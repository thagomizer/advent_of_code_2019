require 'pp'

data = File.readlines(ARGV[0])

wire1 = data[0].strip.split(",")
wire2 = data[1].strip.split(",")

def map_wire wire, path
  wire.each do |token|
    dir = token.slice(/[RLUD]/)
    mag = token.slice(/\d+/).to_i

    case dir
    when "D"
      mag.times do
        tail = path[-1]
        path << [tail[0],tail[1] - 1]
      end
    when "R"
      mag.times do
        tail = path[-1]
        path << [tail[0] + 1,tail[1]]
      end
    when "L"
      mag.times do
        tail = path[-1]
        path << [tail[0] - 1,tail[1]]
      end
    when "U"
      mag.times do
        tail = path[-1]
        path << [tail[0],tail[1] + 1]
      end
    end
  end
  path
end

path1 = map_wire(wire1, [[0,0]])
path2 = map_wire(wire2, [[0,0]])

path1.shift
path2.shift

intersections = path1 & path2

distances = intersections.map { |x, y| x.abs + y.abs }

puts "Star 1 #{distances.min}"

delays = intersections.map { |n| path1.find_index(n) + path2.find_index(n) }

puts "Star 2 #{delays.min + 2}"
