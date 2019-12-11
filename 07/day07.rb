require 'pp'
require_relative 'intcode.rb'

class Amplifier
  attr_accessor :setting, :input_signal, :output

  def initialize mem
    @computer = Computer.new mem
  end

  def output
    @computer.output
  end

  def run
    @computer.input = [self.setting, self.input_signal]

    @computer.run 

    self.output
  end
end

data = File.read(ARGV[0]).split(",").map { |n| n.to_i }

amps = Array.new(5) { Amplifier.new data.dup }

max = 0

[0, 1, 2, 3, 4].permutation.each do |p|
  input = 0
  amps.each_with_index do |a, i|
    a.input_signal = input
    a.setting = p[i]

    input = a.run
  end

  max = amps[4].output if amps[4].output > max
end

puts "Star 1 #{max}"
