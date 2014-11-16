require 'rss'
require 'open-uri'
require 'nokogiri'
require 'kconv'
require 'pp'
require 'date'

module FetchSite

  def minkei(url)
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

  def asahi_digital

    event = Api::V1::Event.new(
      title: "鎌倉高校前駅",
      desc: "神奈川県鎌倉市の江ノ島電鉄「鎌倉高校前」駅のそばにある踏切が、台湾からの観光客の人気スポットになっている。アニメ「ＳＬＡＭ　ＤＵＮＫ（スラムダンク）」の舞台のモデルになった場所というのが理由のようだ。江ノ電は昨年、台湾の観光鉄道「平渓線」と１日乗車券を相互利用できる協定を結んだ。今年９月末までに、平渓線の乗車券で江ノ電に乗ったのは６５６１件。逆に江ノ電から平渓線へは３６８件。",
      url: "http://www.asahi.com/articles/ASGCF3TJXGCFULOB00F.html?ref=medialab",
      image_url: "http://www.asahicom.jp/articles/images/AS20141114004509_commL.jpg",
      start_time: DateTime.parse("2014-11-16 07:57:37")
    )
    event.save!

    event = Api::V1::Event.new(
        title: "銀座ミキモト",
        desc: "東京・銀座の冬を彩る巨大なクリスマスツリーが１５日、宝飾品店「ミキモト」本店前にお目見えした。１９７６年から展示が始まったツリーは、ビルの建て替えのため今年で見納め。高さ約１０メートル、樹齢３０～４０年のもみの木は、北海道から根付きのまま運ばれ、約６５００個のＬＥＤで装飾された。点灯は１２月２５日までの午前１１時～午後１０時。毎正時には、音楽と光の演出も行われる。",
        url: "http://www.asahi.com/articles/ASGCH62CFGCHUQIP02H.html?ref=medialab",
        image_url: "http://www.asahicom.jp/articles/images/AS20141115002565_commL.jpg",
        start_time: DateTime.parse("2014-11-15 20:34:23")
    )
    event.save!

    event = Api::V1::Event.new(
        title: "マスターズ甲子園２０１４",
        desc: "元高校球児がかつての仲間とともに青春時代の夢を追う「マスターズ甲子園２０１４」が１５日、兵庫県西宮市の阪神甲子園球場で開幕し、地方大会を勝ち抜いた１６チームが開会式に臨んだ。１６日まで２日間、８試合が予定され、元球児が家族らと参加できる甲子園キャッチボールも行われる。マスターズ甲子園は元高校球児が出身校別に同窓会チームを結成し、甲子園を目指す大会。０４年に始まり、１１回目を迎えた。",
        url: "http://www.asahi.com/articles/ASGCF4CV0GCFUTIL01T.html?ref=medialab",
        image_url: "http://www.asahicom.jp/articles/images/AS20141115000939_commL.jpg",
        start_time: DateTime.parse("2014-11-15 20:34:23")
    )
    event.save!
  end

  def grunavi
    access_key= "d3be53e51af80127f684c72083b53766"
    end_point = "http://api.gnavi.co.jp/ver1/RestSearchAPI/".freeze
    range = 3 # 1000m
    lat = "35.6101177"
    lon = "139.7831018"
    category_l = "RSFST18000"
    url = "#{end_point}?keyid=#{access_key}&pref=PREF13&range=#{range}&latitude=#{lat}&longitude=#{lon}&category_l=#{category_l}"
    puts url
    doc = REXML::Document.new(open(URI.escape(url)))

    res =[]
    doc.elements.each("response/rest") do |e|
      shop = {}
      #shop["shop_id"] = e.elements['id'].text
      shop["title"] = e.elements['name'].text
      shop["desc"] = e.elements['address'].text
      shop["url"] = e.elements['url'].text
      image_url = e.elements['image_url/shop_image1'].text
      shop["image_url"] = image_url.text if image_url
      shop["location"] = "#{e.elements['latitude'].text},#{e.elements['longitude'].text}"
      event = Api::V1::Event.new(shop)
      event.save
    end
    return res
  end
end