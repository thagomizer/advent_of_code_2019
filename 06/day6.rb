input = File.readlines(ARGV[0]).map { |l| l.strip.split(")") }

orbits = Hash.new { |h, k| h[k] = [] }

input.each do |planet, moon|
  orbits[planet] << moon
end

paths = Hash.new { |h, k| h[k] = [] }
to_follow = ["COM"]

while !to_follow.empty?
  current = to_follow.shift
  moons = orbits[current]
  current_path = paths[current]

  moons.each do |moon|
    paths[moon] = [current] + current_path
    to_follow << moon
  end
end

puts "Star 1 #{paths.values.map{ |p| p.length }.inject(:+)}"

## Number of orbital transfers
## Find the first node both you and santa have in common
##  Add the distance from me to the common node and Santa to the common node

common_node = (paths["YOU"] & paths["SAN"])[0]

orbital_transfers = paths["YOU"].find_index(common_node) + paths["SAN"].find_index(common_node)

puts "Star 2 #{orbital_transfers}"
