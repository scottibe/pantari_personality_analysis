require '/Users/scottbewick/Development/code/watson_api_for_ruby/lib/personality_analysis'
require '/Users/scottbewick/Development/code/watson_api_for_ruby/lib/tone_analysis'

User.destroy_all
PersonAnalysis.destroy_all
TheToneAnalysis.destroy_all

bewick = PersonalityApiCaller.new(File.open("/Users/scottbewick/Development/code/mytext.rtf", "r"))
PersonAnalysis.create(bewick.scores_to_hash)
                
tweeter = TwitterApiCall.new
tweet_text = tweeter.user_tweets('thomasbews')
thomas = PersonalityApiCaller.new(tweet_text).scores_to_hash
PersonAnalysis.create(thomas)

tweeter = TwitterApiCall.new
tweet_text = tweeter.user_tweets('realdonaldtrump')
trump = PersonalityApiCaller.new(tweet_text).scores_to_hash
PersonAnalysis.create(trump)

tweeter = TwitterApiCall.new
tweet_text = tweeter.user_tweets('sarahksilverman')
silver = ToneApiCaller.new(tweet_text).scores_to_hash
TheToneAnalysis.create(silver)
   
bewster = ToneApiCaller.new(File.open("/Users/scottbewick/Development/code/mytext.rtf", "r"))
TheToneAnalysis.create(bewster.scores_to_hash)                

@abby = User.create(:username => 'abbyibe', :email => 'abby@abby.com', :password => 'abby')

@scott = User.create(:username => 'scottibe', :email => 'scott@scott.com', :password => 'scott')

@killtrump = User.create(:username => 'killtrump', :email => 'kill@trump.com', :password => 'kill')