require './config/environment'
require 'bcrypt'
require 'excon'
require '../watson_api_for_ruby/lib/personality_analysis'
require '../watson_api_for_ruby/lib/tone_analysis'
require 'rack-flash'
class PantariApplicationController < Sinatra::Base
  use Rack::Flash
  # before do 
  #   content_type :txt
  # end

  # not_found do 
  #   "There's nothing there where you are trying to be"
  # end  

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'shhhit_its_a_secret'
    set :show_exceptions, :after_handler
  end

  get "/" do
    erb :index
  end

  get '/analyses' do
    if logged_in?
      @user ||= User.find_by_id(session[:user_id])
      @user_analyses ||= @user.person_analyses 
      @user_tones ||= @user.the_tone_analyses                 
      erb :home 
    else
      redirect to '/login'   
    end  
  end

  get '/learn' do 
    erb :learn
  end  

   helpers do 

    def logged_in?
      !!session[:user_id]
    end 
    
    def current_user
      User.find(session[:user_id])
    end
  end  

end