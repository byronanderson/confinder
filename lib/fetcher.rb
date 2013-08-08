require 'sunlight'
require 'pry'
require 'csv'
require 'json'
require 'redis'
require 'redis-queue'

Sunlight::Base.api_key = "6a084c8b1f614684bb39086b51ff5599"

def fetch_queue
  @queue ||= Redis::Queue.new('waiting', 'processing', redis: redis)
end

def redis
  @redis ||= Redis.new
end

def each_person
  while message = queue.pop
    message = JSON.parse(message)
    yield message
    queue.commit
  end
end

each_person do |person|
  congresspeople = Sunlight::Legislator.all_in_zipcode(person["zip"])
  names = congresspeople.map do |peep|
    "#{peep.firstname} #{peep.lastname}"
  end
end
