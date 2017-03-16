require 'twitter'
require 'json'
require "dotenv"

class TwitterApiCall
  Dotenv.load

  @@client = Twitter::REST::Client.new do |config|
    config.consumer_key = 
    config.consumer_secret = 
    config.access_token = 
    config.access_token_secret = 
  end

  def user_tweets(twitter_handle)
    tweets = []
    begin
    twit = @@client.user_timeline(twitter_handle, options = {:count => 200})
    twit.each do |tweet|
      tweets << tweet.text 
    end  
    rescue Twitter::Error
    end 
    tweets.clear unless tweets.first != "Trumpnocare" 
    tweets.join(" ") 
  end 
end    
              