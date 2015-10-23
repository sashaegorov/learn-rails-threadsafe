require 'net/http'

uri = URI('http://localhost:9090')

50.times {
  5.times.map {
    Thread.new { Net::HTTP.get_response(uri) }
  }.each(&:join)
}
