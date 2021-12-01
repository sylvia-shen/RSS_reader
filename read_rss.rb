require './xml_parser'

class Item
  MAX_DESC_LENGTH = 100
  def initialize title, link, description
    @title = title
    @link = link
    @description = description
  end

  def formatted_str
    desc = truncate_description(@description)
    
    "[#{@title}]\n#{desc}\n#{@link}"
  end

  private

  def truncate_description description
    if description.length < MAX_DESC_LENGTH
      description 
    else
      "#{description[0...MAX_DESC_LENGTH]}..."
    end  
  end
end

url = ARGV[0]
xml = XmlParser.parse_from_url(url)
items = xml.search('item').map do |item|
  Item.new(
    item.at('title').text,
    item.at('link').text,
    item.at('description').text
  )
end

item_contents = items.first(5).map(&:formatted_str)
puts item_contents.join("\n\n===\n\n")
