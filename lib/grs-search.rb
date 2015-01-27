require 'rest-client'
require 'uri'
require 'json'
require 'grs-search/response'
require 'pp'

class GRSSearch
  RIPE_API_URI = URI.parse('http://rest.db.ripe.net/search.json')
  GRS_SOURCES = %w(ripe-grs arin-grs apnic-grs lacnic-grs afrinic-grs radb-grs)

  class << self
    attr_accessor :proxy_url
  end

  def self.lookup(ip)
    url = RIPE_API_URI.merge("?query-string=#{ip}&" +  GRS_SOURCES.map { |s| 'source=' + s }.join('&'))

    if self.proxy_url
      _rest_client_proxy = RestClient.proxy
      RestClient.proxy = self.proxy_url
    end

    puts url
    response = nil

    begin
      res = RestClient.get(url.to_s)
      data = JSON.parse(res)
      response = Response.new(data)
    rescue Exception => e
      STDERR.puts e.to_s
      STDERR.puts e.backtrace.join("\n")
    end
      
    if self.proxy_url
      RestClient.proxy = _rest_client_proxy
    end
    
    response
  end
end
