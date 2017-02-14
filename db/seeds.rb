require '/Users/scottbewick/Development/code/watson_api_for_ruby/lib/personality_analysis'
require '/Users/scottbewick/Development/code/watson_api_for_ruby/lib/tone_analysis'

# User.destroy_all
# PersonAnalysis.destroy_all
# TheToneAnalysis.destroy_all

@ball = PersonalityApiCaller.new(File.open("/Users/scottbewick/Development/code/mytext.rtf", "r"))
@analysis = PersonAnalysis.create(@ball.scores_to_hash)
@analysis.author = "Benny Dick"

# @user = User.create(:username => 'abbyibe', :email => 'abby@abby.com', :password => 'abby')
# @analysis.user_id = @user.id


tweeter = TwitterApiCall.new
tweet_text = tweeter.user_tweets('thomasbews')
thomas = PersonalityApiCaller.new(tweet_text).scores_to_hash
PersonAnalysis.create(thomas)

tweeter = TwitterApiCall.new
tweet_text = tweeter.user_tweets('realdonaldtrump')
trump = PersonalityApiCaller.new(tweet_text).scores_to_hash
PersonAnalysis.create(trump)

# tweeter = TwitterApiCall.new
# tweet_text = tweeter.user_tweets('sarahksilverman')
# silver = ToneApiCaller.new(tweet_text).scores_to_hash
# TheToneAnalysis.create(silver)
   
# bewster = ToneApiCaller.new(File.open("/Users/scottbewick/Development/code/mytext.rtf", "r"))
# TheToneAnalysis.create(bewster.scores_to_hash)                


# @scott = User.create(:username => 'scottibe', :email => 'scott@scott.com', :password => 'scott')

# @killtrump = User.create(:username => 'killtrump', :email => 'kill@trump.com', :password => 'kill')





