require 'minitest/autorun'
require_relative '../lib/confinder/parser'

class ConfinderParserTest < MiniTest::Unit::TestCase
  def parser
    @parser ||= Confinder::Parser.new(input_file, queue)
  end

  def queue
    @queue ||= MiniTest::Mock.new
  end

  def input_file
    File.new("test/fixtures/one_person.csv", "r")
  end

  def test_parses_csv
    data = {
      id: "1",
      zip: "80227",
      name: "Byron Anderson",
    }
    queue.expect(:push, nil, [data])
    parser.parse
    queue.verify
  end
end
