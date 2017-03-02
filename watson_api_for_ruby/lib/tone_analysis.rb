require_relative 'tone_api_caller'
require_relative 'twitter/twitter_api'
class ToneAnalysis

  attr_accessor :anger, :disgust, :fear, :joy, :sadness, :analytical, :confident, :tentative, :openness, :conscientiousness, :extraversion, :agreeableness, :emotional_range

  def initialize(analysis)
    analysis.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  def self.create_text_analysis(input)
    analysis = ToneApiCaller.new(input).scores_to_hash
    final_analysis = ToneAnalysis.new(analysis)
  end

  def self.create_twitter_analysis(twitter_handle)
    tweeter = TwitterApiCall.new
    tweet_text = tweeter.user_tweets(twitter_handle)
    analysis = ToneApiCaller.new(tweet_text).scores_to_hash
    final_analysis = ToneAnalysis.new(analysis) 
  end

end