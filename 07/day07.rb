require 'pp'
require_relative 'intcode.rb'

class Amplifier
  attr_accessor :setting, :output, :computer

  def initialize mem
    @mem = mem
    @computer = Computer.new mem
  end

  def reset mem
    @computer.reset mem
  end

  def output
    @computer.output
  end

  def halted?
    @computer.halted?
  end

  def add_input i
    @computer.input << i
  end

  def run
    @computer.run
  end
end

data = File.read(ARGV[0]).split(",").map { |n| n.to_i }

amps = Array.new(5) { Amplifier.new(data.dup) }

max = 0

[0, 1, 2, 3, 4].permutation.each do |p|
  amps.each_with_index do |a, i|
    a.reset data.dup
    a.add_input p[i]
  end

  input = 0

  amps.each_with_index do |a, i|
    a.add_input input

    input = a.run
  end

  max = amps[4].output if amps[4].output > max
end

puts "Star 1 #{max}"


####

amps = Array.new(5) { Amplifier.new data.dup }

max = 0

[9, 8, 7, 6, 5].permutation.each do |p|
  amps.each_with_index do |a, i|
    a.reset data.dup
    a.add_input p[i]
  end

  current_amp = 0
  input = 0

  loop do
    a = amps[current_amp]
    a.add_input input

    input = a.run

    if amps[4].halted?
      max = amps[4].output if amps[4].output > max
      break
    end

    current_amp = (current_amp + 1) % 5
  end

  max = amps[4].output if amps[4].output > max
end

puts "Star 2 #{max}"
