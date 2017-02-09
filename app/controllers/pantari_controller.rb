require './config/environment'
require 'bcrypt'
require 'excon'
require '/Users/scottbewick/Development/code/watson_api_for_ruby/lib/personality_analysis'
require '/Users/scottbewick/Development/code/watson_api_for_ruby/lib/tone_analysis'

class PantariController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'shhhit_its_a_secret'
  end

  get "/" do
    erb :index
  end

end

