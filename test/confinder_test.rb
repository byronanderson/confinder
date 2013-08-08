require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class ConfinderTest < MiniTest::Unit::TestCase
  def setup
    kick_off_writer
    kick_off_fetcher
  end

  def teardown
    kill("writer")
    kill("fetcher")
    `rm congresspeople.csv`
  end

  def kill(process_name)
    process_listing = `ps ax | grep bin/#{process_name} | grep -v grep`
    pid = process_listing.split.first
    `kill #{pid}` unless pid.nil?
  end

  def kick_off_fetcher
    system "bin/fetcher &"
  end

  def kick_off_writer
    system "bin/writer &"
  end

  def test_confinder
    parse(fixture)
    sleep 5
    expectation = <<-DOC
1,Byron Anderson,"Michael Bennet,Diana DeGette,Mark Udall,Ed Perlmutter"
DOC
    assert File.read("congresspeople.csv") =~ /Byron/
  end

  def parse(file)
    system "bin/parser #{file.path} &"
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
