require 'rss'
require 'open-uri'
require 'nokogiri'
require 'kconv'
require 'pp'

module FetchSite

  def fetch_minkei(url)
    r = RSS::Parser.parse(url)
    res = []

    r.items.each{|item|
      next if item.title.start_with? 'PR:'
      event ={}
      event["title"] =item.title
      event["url"] =item.link

      charset = nil
      html = open(item.link,"r:binary") do |s|
        charset = s.charset
        s.read
      end
      charset="UTF-8"
      doc = Nokogiri::HTML.parse(html, nil, charset)

      desc = doc.xpath('//meta[@name="description"]')[0]["content"]
      event["desc"] =desc
      location = $1 if doc.xpath('//img[contains(@src,"staticmap")]')[0].get_attribute('src')=~/&markers=([0-9,\.]*)/
      event["location"] =location

      image_url = doc.xpath('//img[@id="hPhoto"]')[0]["src"]
      event["image_url"] =image_url
      res << event
    }
    return res
  end
end