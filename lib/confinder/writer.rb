require 'csv'
require 'ostruct'

module Confinder
  class Writer
    def file
      @file ||= File.new("congresspeople.csv", "w")
    end

    def write(message)
      message = Message.new(message)
      names = message.legislators.map(&:name).join(",")
      string = "#{message.id},#{message.name},\"#{names}\""
      file.puts string
    end

    def flush
      file.flush
    end

    def close
      file.close
    end

    def file_path
      file.path
    end

    class Message
      attr_reader :hash
      def initialize(hash)
        @hash = hash
      end

      def id
        hash.fetch("id")
      end

      def name
        hash.fetch("name")
      end

      def legislators
        hash.fetch("legislators").map { |legislator| Legislator.new(legislator) }
      end
    end

    Legislator = OpenStruct
  end
end
