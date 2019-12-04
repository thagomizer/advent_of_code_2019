data = File.read(ARGV[0]).split(",").map { |n| n.to_i }

def run mem
  ip = 0

  loop do
    opcode = mem[ip]

    case opcode
    when 1
      _, a, b, c = mem[ip, 4]

      mem[c] = mem[a] + mem[b]

      ip += 4
    when 2
      _, a, b, c = mem[ip, 4]

      mem[c] = mem[a] * mem[b]

      ip += 4
    when 99
      break
    end
  end

  mem[0]
end

## Restore state
mem = data.dup
mem[1] = 12
mem[2] = 2

puts "Star 1 #{run(mem)}"


(0..99).each do |noun|
  (0..99).each do |verb|
    mem = data.dup
    mem[1] = noun
    mem[2] = verb

    result = run(mem)

    if result == 19690720
      puts "Star 2 #{100 * noun + verb}"
      exit
    end
  end
end
