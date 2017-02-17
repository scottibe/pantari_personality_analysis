require '/Users/scottbewick/Development/code/watson_api_for_ruby/lib/tone_analysis' 

class TheToneAnalysis < ActiveRecord::Base
  include Slugifiable::InstanceMethods 
  extend Slugifiable::ClassMethods  
  
  belongs_to :user

end  