require 'minitest/autorun'
require_relative 'vcr_helper'
require_relative '../lib/confinder/fetcher'

class ConfinderFetcherTest < MiniTest::Unit::TestCase
  def fetcher
    @fetcher ||= Confinder::Fetcher.new
  end

  def queue
    @queue ||= MiniTest::Mock.new
  end

  def test_parses_csv
    VCR.use_cassette('sunshine_80227_legislators') do
      mark = { name: "Mark Udall" }
      diana = { name: "Diana DeGette" }
      ed = { name: "Ed Perlmutter" }
      michael = { name: "Michael Bennet" }
      expectation = { id: "1", name: "Byron Anderson", zip: "80227", legislators: [michael, diana, mark, ed] }
      fetcher.fetch(id: "1", name: "Byron Anderson", zip: "80227").must_equal expectation
    end
  end
end
