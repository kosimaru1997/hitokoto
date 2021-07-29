class Post < ApplicationRecord


  def set_sentiment_with_title
    sentiment = self.get_sentiment
    self.magnitude = sentiment[:magnitude]
    if sentiment[:score] > 50
      title = ["ポンコツbaby", "ハッピー能天気バカ","so funy", "おしゃべりクソ野郎", "無駄話うそ太郎", "元気の押し売り", "言い訳クソメガネ", "ラッキー幸せ人間", "好感度おばけ"]
      self.sentiment = "ポジティブ"
      self.score = sentiment[:score]
    elsif sentiment[:score] > 0
      title = ["おたんこなすび", "おまぬけ勘違いさん","おたんこなすび", "おしゃべりクソ野郎", "無駄話うそ太郎", "あほ", "言い訳クソメガネ", "クレイジー日本代表", "優しき偽善者"]
      self.sentiment = "ポジティブ"
      self.score = sentiment[:score]
    elsif sentiment[:score] <= 0
      title = ["ポンコツbaby", "インテリくそ陰キャ","so sad", "おたんこなすび", "詐欺師", "ろくでなしこちゃん", "屁理屈ガイコツ", "元気出せよ💓", "孤高の天才"]
      self.sentiment = "ネガティブ"
      self.score = sentiment[:score]*-1
    end
    self.personality_title = title[rand(10)-1]
  end

  def set_int_with_personality
    index1 = ["センス", "知性", "努力", "主人公度", "地頭力", "おもしろさ"]
    index2 = ["香ばしさ", "神に愛され度", "なんか良い感じの雰囲気", "足の臭さ", "強者の風格", "人望"]
    self.random_int1 = rand(rand(200))
    self.personality1 = index1[rand(7)-1]
    self.random_int2 = rand(rand(200))
    self.personality2 = index2[rand(7)-1]
  end

  def get_sentiment
    require 'net/http'
    require 'uri'
    require 'json'

    text = self.post

    uri = URI.parse("https://language.googleapis.com/v1beta1/documents:analyzeSentiment?key=#{ENV["GOOGlE_API_KYE"]}")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request.body = ""
    request.body = {
                      document:{
                        type:'PLAIN_TEXT',
                        content: text
                      }
                    }.to_json

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    json = JSON.parse(response.body)
    score =  json['documentSentiment']['score']*100
    magnitude = json['documentSentiment']['magnitude']*100
    sentiment = {score: score.to_i, magnitude: magnitude.to_i}
  end

end
