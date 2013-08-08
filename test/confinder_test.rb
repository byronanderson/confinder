require 'minitest/autorun'
require 'minitest/pride'
require 'confinder'
Sunlight::Base.api_key = "6a084c8b1f614684bb39086b51ff5599"

class ConfinderTest < MiniTest::Unit::TestCase
  def test_confinder
    kick_off_writer
    kick_off_fetcher
    kick_off_parser(fixture)
    sleep 5
    expectation = <<-DOC
1,Byron Anderson,"Michael Bennet,Diana DeGette,Mark Udall,Ed Perlmutter"
DOC
    assert File.read("congresspeople.csv") =~ /Byron/
  end

  def kick_off_fetcher
    system "ruby lib/fetcher.rb &"
  end

  def kick_off_writer
    system "ruby lib/writer.rb &"
  end

  def kick_off_parser(file)
    system "ruby lib/parser.rb #{file.path} &"
  end

  def fixture
    File.new("test/fixtures/one_person.csv", "r")
  end

  def queue
    @queue ||= Redis::Queue.new('waiting', 'processing', redis: redis)
  end

  def redis
    @redis ||= Redis.new
  end
end
