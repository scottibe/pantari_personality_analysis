require 'twitter'
require 'json'
require "dotenv"

class TwitterApiCall
  Dotenv.load

  @@client = Twitter::REST::Client.new do |config|
    config.consumer_key = "WAuxO3AkhEuk50e6xeWupygxv"
    config.consumer_secret = "g2FPkHx8Of6VNP839B0vsctr1QuYmD8fuQTUMOQbkbZltCiPYf"
    config.access_token = "19828996-dsc6Noz9j4MpfsVYntIDWSC40zOhLqBhhSyijynWV"
    config.access_token_secret = "9PcrwCVq6qTDRWOfnFN1NSIBbTxNrnJ1GDvOI35iMVq54"
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
              