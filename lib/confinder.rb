require 'stringio'
require 'sunlight'
require 'pry'
require 'csv'
require 'redis'
require 'redis-queue'

Sunlight::Base.api_key = "6a084c8b1f614684bb39086b51ff5599"

class Confinder
  def self.run(input_file, queue)
    new(input_file, queue).run
  end

  attr_reader :input_file, :queue
  def initialize(input_file, queue)
    @input_file = input_file
    @queue = queue
  end

  def run
    Parser.parse(input_file, queue)
  end
end
