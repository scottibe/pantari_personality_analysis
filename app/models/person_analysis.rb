require '/Users/scottbewick/Development/code/watson_api_for_ruby/lib/personality_analysis'

class PersonAnalysis < ActiveRecord::Base
  include Slugifiable::InstanceMethods 
  extend Slugifiable::ClassMethods  

  belongs_to :user

end  