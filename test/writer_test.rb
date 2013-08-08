gem 'minitest'
require 'minitest/autorun'
require_relative '../lib/confinder/writer'

class ConfinderWriterTest < MiniTest::Unit::TestCase
  def test_writing
    message = {
      "id" => 1,
      "name" => "Byron Anderson",
      "legislators" => [
        {
          "firstname" => "Mark",
          "lastname" => "Udall"
        },
        {
          "firstname" => "Diana",
          "lastname" => "DeGette",
        }
      ],
    }
    writer = Confinder::Writer.new
    writer.write(message)
    writer.flush
    file_contents = File.read(writer.file_path)
    assert_includes file_contents, '1,Byron Anderson,"Mark Udall,Diana DeGette"'
  end
end
