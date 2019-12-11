require 'pp'
require_relative 'intcode.rb'

class Amplifier
  attr_accessor :setting, :input_signal, :output, :computer

  def initialize
    @computer = Computer.new
  end

  def output
    @computer.output
  end

  def run mem
    @computer.input = [self.setting, self.input_signal]

    @computer.run mem

    self.output
  end
end

data = File.read(ARGV[0]).split(",").map { |n| n.to_i }

amps = Array.new(5) { Amplifier.new }

amps[0].next_computer = amps[1].computer
amps[1].next_computer = amps[2].computer
amps[2].next_computer = amps[3].computer
amps[3].next_computer = amps[4].computer
amps[4].next_computer = amps[0].computer
