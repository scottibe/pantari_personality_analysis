require_relative 'personality_api_caller'
require_relative 'twitter/twitter_api'

class PersonalityAnalysis

  attr_accessor :word_count, :agreeableness, :conscientiousness, :extraversion, 
                :emotional_range, :openness, :challenge, :closeness, :curiosity,
                :excitement, :harmony, :ideal, :liberty, :love, :practicality,
                :self_expression, :stability, :structure, :conservation, :openness_to_change, 
                :hedonism, :self_enhancement, :self_transcendence

  def initialize(analysis)
    analysis.each do |k, v|
      self.send("#{k}=", v)
    end 
  end

  def self.create_analysis(input)
    analysis = PersonalityApiCaller.new(input).scores_to_hash
    final_analysis = PersonalityAnalysis.new(analysis)
  end

  def self.create_twitter_analysis(twitter_handle)
    tweeter = TwitterApiCall.new
    tweet_text = tweeter.user_tweets(twitter_handle)
    analysis = PersonalityApiCaller.new(tweet_text).scores_to_hash
    final_analysis = PersonalityAnalysis.new(analysis) 
  end

end
