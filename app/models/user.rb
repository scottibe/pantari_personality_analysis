class User < ActiveRecord::Base

  has_many :person_analyses
  has_many :the_tone_analyses

  has_secure_password


end