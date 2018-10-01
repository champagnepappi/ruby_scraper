require 'HTTParty'
require 'Nokogiri'

class Scraper
  attr_accessor :parse_page
  def initialize
    doc = HTTParty.get("http://store.nike.com/us/en_us/pw/mens-nikeid-lifestyle-shoes/1k9Z7puZoneZoi3?ipp=69")
    @parse_page ||= Nokogiri::HTML(doc)
  end

  def get_names
    item_container.css(".product-name").css("p").children.map {|name| name.text}.compact
  end

  def get_prices
    item_container.css(".product-price").css("span.local").children.map {|price| price.text}.compact
  end

  private
  def item_container
    parse_page.css(".grid-item-info")
  end

  scraper = Scraper.new
  prices = scraper.get_prices
  names = scraper.get_names
end

