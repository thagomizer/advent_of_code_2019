require 'pp'
DEBUG = false

class Computer
  attr_accessor :input, :output, :mem

  PARAM_COUNT = {1 => 4, 2 => 4, # Add, Multiply
                 3 => 2, 4 => 2, # Get, Set
                 5 => 3, 6 => 3, # Jump if true, jump if false
                 7 => 4, 8 => 4, # LT, EQ
                 99 => 0 }

  def initialize mem
    @input = []
    @mem = mem
    @ip = 0
    @halted = false
  end

  def reset mem
    @input = []
    @mem = mem
    @ip = 0
    @halted = false
  end

  def run
    loop do
      opcode = @mem[@ip] % 100
      modes = [(@mem[@ip] / 100) % 10,
               (@mem[@ip] / 1_000) % 10,
               (@mem[@ip] / 10_000) % 10]

      if DEBUG
        pp "Instruction: #{@mem[@ip]}"
        pp "Opcode: #{opcode}"
        pp "Modes: #{modes}"
      end

      _, a, b, c = @mem[@ip, 4]
      a = @mem[a] if a && modes[0] == 0
      b = @mem[b] if b && modes[1] == 0

      case opcode
      when 1
        @mem[c] = a + b
      when 2
        @mem[c] = a * b
      when 3
        x = get_input
        @mem[@mem[@ip + 1]] = x
      when 4
        put_output a
        @ip += PARAM_COUNT[opcode]
        return a
      when 5
        if a != 0
          @ip = b
          next
        end
      when 6
        if a == 0
          @ip = b
          next
        end
      when 7
        @mem[c] = a < b ? 1 : 0
      when 8
        @mem[c] = a == b ? 1 : 0
      when 99
        puts "HALTING" if DEBUG
        @halted = true
        return
      end

      @ip += PARAM_COUNT[opcode]
    end
  end

  def debug
    pp "DEBUGGING OUTPUT: Current input #{@input} IP #{@ip}"
  end

  def halted?
    @halted
  end

  def set_inputs is
    @inputs = is
  end

  def get_input
    @input.shift
  end

  def put_output output
    @output = output
  end
end
