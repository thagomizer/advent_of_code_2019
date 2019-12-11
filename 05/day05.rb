data = File.read(ARGV[0]).split(",").map { |n| n.to_i }

class Computer
  attr_accessor :input, :output

  PARAM_COUNT = {1 => 4, 2 => 4, # Add, Multiply
                 3 => 2, 4 => 2, # Get, Set
                 5 => 3, 6 => 3, # Jump if true, jump if false
                 7 => 4, 8 => 4, # LT, EQ
                 99 => 0 }

  def run mem
    ip = 0

    loop do
      update_ip = true
      opcode = mem[ip] % 100
      modes = [(mem[ip] / 100) % 10,
               (mem[ip] / 1_000) % 10,
               (mem[ip] / 10_000) % 10]

      _, a, b, c = mem[ip, 4]
      a = mem[a] if a && modes[0] == 0
      b = mem[b] if b && modes[1] == 0

      case opcode
      when 1
        mem[c] = a + b
      when 2
        mem[c] = a * b
      when 3
        mem[mem[ip + 1]] = get_input
      when 4
        put_output a
      when 5
        if a != 0
          ip = b
          next
        end
      when 6
        if a == 0
          ip = b
          next
        end
      when 7
        mem[c] = a < b ? 1 : 0
      when 8
        mem[c] = a == b ? 1 : 0
      when 99
        return mem[0]
      end

      ip += PARAM_COUNT[opcode]
    end
  end

  def get_input
    puts "Getting input from i_vars: #{@input}"
    @input
  end

  def put_output output
    @output = output
  end
end

c = Computer.new

c.input = 1
c.run(data.dup)
puts "Star 1 #{c.output}"

c.input = 5
c.run(data.dup)
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
