require_relative 'intcode'

data = File.read(ARGV[0]).split(",").map { |n| n.to_i }

c = Computer.new data.dup
c.mem[1] = 12
c.mem[2] = 2
c.run

puts "Star 1 #{c.mem[0]}"

(0..99).each do |noun|
  (0..99).each do |verb|
    c.reset data.dup
    c.mem[1] = noun
    c.mem[2] = verb

    c.run

    if c.mem[0] == 19690720
      puts "Star 2 #{100 * noun + verb}"
      exit
    end
  end
end
