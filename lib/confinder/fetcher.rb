require 'sunlight'
require 'pry'

Sunlight::Base.api_key = "6a084c8b1f614684bb39086b51ff5599"

module Confinder
  class Fetcher
    def fetch(person)
      congresspeople = Sunlight::Legislator.all_in_zipcode(person["zip"])
      data = person.dup
      data["legislators"] = congresspeople.map { |legislator|
        { name: "#{legislator.firstname} #{legislator.lastname}" }
      }
      return data
    end
  end
end
