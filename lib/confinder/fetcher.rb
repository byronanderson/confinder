require 'sunlight'

Sunlight::Base.api_key = "6a084c8b1f614684bb39086b51ff5599"

module Confinder
  class Fetcher
    def fetch(person)
      congresspeople = Sunlight::Legislator.all_in_zipcode(person["zip"])
      data = person.dup
      data["legislators"] = congresspeople.map do |congressperson|
        congressperson.instance_variables.each_with_object({}) do |v, hash|
          hash[v.to_s.gsub("@", "")] = congressperson.instance_variable_get(v)
        end
      end
      data
    end
  end
end
