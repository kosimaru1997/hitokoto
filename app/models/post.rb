class Post < ApplicationRecord

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
