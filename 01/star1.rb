data = File.readlines(ARGV[0])

fuel = data.map! { |n| (n.to_i / 3) - 2  }.inject(:+)
puts "Star 1 #{fuel}"

def calc_total_fuel n
  sum       = n
  remaining = n

  loop do
    t = (remaining / 3) - 2

    break if t < 1

    sum += t
    remaining = t
  end

  sum
end

total_fuel = data.map! { |n| calc_total_fuel(n) }.inject(:+)

puts "Star 2 #{total_fuel}"


