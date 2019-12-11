require_relative 'intcode.rb'

data = File.read(ARGV[0]).split(",").map { |n| n.to_i }

c = Computer.new data.dup

c.input << 1
c.run
puts "Star 1 #{c.output}"

c.reset data.dup
c.input << 5
c.run
puts "Star 2 #{c.output}"



# puts "Input 1"
# c.input = 1
# c.run(data.dup)
# puts "result: #{c.output}"

# puts "Input 8"
# c.input = 8
# c.run(data.dup)
# puts "result: #{c.output}"

# puts "Input 10"
# c.input = 10
# c.run(data.dup)
# puts "result: #{c.output}"
