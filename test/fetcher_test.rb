gem 'minitest'
require 'minitest/autorun'
require_relative 'vcr_helper'
require_relative '../lib/confinder/fetcher'

class ConfinderFetcherTest < MiniTest::Unit::TestCase
  def fetcher
    @fetcher ||= Confinder::Fetcher.new
  end

  def test_parses_csv
    VCR.use_cassette('sunshine_80227_legislators') do
      val = fetcher.fetch("id" => "1", "name" => "Byron Anderson", "zip" => "80227")
      assert_equal val["id"], "1"
      assert_equal val["name"], "Byron Anderson"
      assert_equal val["zip"], "80227"
      legislators = val["legislators"]
      michael = legislators.first
      assert_equal michael["firstname"], "Michael"
      assert_equal michael["lastname"], "Bennet"
    end
  end
end
