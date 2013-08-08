require 'minitest/autorun'
require_relative '../lib/confinder/writer'

class ConfinderWriterTest < MiniTest::Unit::TestCase
  def test_writing
    message = {
      "id" => 1,
      "name" => "Byron Anderson",
      "legislators" => [
        {
          "name" => "Mark Udall"
        },
        {
          "name" => "Diana DeGette"
        }
      ],
    }
    writer = Confinder::Writer.new
    writer.message_received(message)
    writer.flush
    file_contents = File.read(writer.file_path)
    file_contents.must_include '1,Byron Anderson,"Mark Udall,Diana DeGette"'
  end
end
