class Event < ActiveRecord::Base
  extend FetchSite

  def self.minkei2db

    url = "http://rss.rssad.jp/rss/minkei/tokyobay.xml"
    res = minkei(url)
    res.each do |r|
      event = Event.new(r)
      event.save!
    end

  end
end
