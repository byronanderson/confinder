require 'csv'
require 'redis'
require 'json'
require 'redis-queue'

module Confinder
  class Parser
    def self.parse(file, queue)
      new(file, queue).parse
    end

    attr_reader :file, :queue

    def initialize(file, queue)
      @file = file
      @queue = queue
    end

    def parse
      CSV.foreach(file, headers: true) do |line|
        name = line.values_at("first_Name", "last_Name").join(" ")
        data = {
          id: line[" "],
          zip: line["Zipcode"],
          name: name
        }
        queue.push data
      end
    end
  end
end
