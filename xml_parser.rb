require 'httparty'
require 'nokogiri'

class XmlParser
  def self.parse_from_url url
    res = HTTParty.get(url)
    
    Nokogiri::XML(res.body)
  end
end
