require 'rubygame'
class PersonalityAnalysesController < PantariApplicationController 
  use Rack::Flash

  get '/personality_analyses/new' do 
    if logged_in?
      erb :'personality_analyses/new_personality'
    else
      redirect to '/login' 
    end
  end

  post '/text_analyses' do 
    if params[:text_author] == "" || params[:text_author] == nil
      puts "Please enter the author of the text"
      redirect to "/personality_analyses/new"
    elsif
      params[:text_analysis] == "" && params[:text_analysis] == nil
      puts "Please enter text or a Twitter username"
      redirect to "/personality_analyses/new"
    else
      begin
        analysis = PersonalityApiCaller.new(params[:text_analysis]).scores_to_hash
      rescue ArgumentError 
      end  
      @analysis = PersonAnalysis.create(analysis)
      @analysis.author = params[:text_author]
      @analysis.person_text = params[:text_analysis].encode!("UTF-8", invalid: :replace, undef: :replace).force_encoding("utf-8")
      @analysis.user_id = session[:user_id]
      @analysis.save
      redirect to "/personality_analyses/#{@analysis.id}"
    end  
  end   

  post '/twitter_analyses' do 
    if params[:tweeter] == "" || params[:tweeter] == nil
      puts "Please enter a valid username"
      redirect to "/personality_analyses/new"
    elsif
      params[:twitter_analysis] == "" && params[:twitter_analysis] == nil
      puts "Please enter a valid username"
      redirect to "/personality_analyses/new"
    else
      tweeter = TwitterApiCall.new
      begin
        get_analysis = PersonalityApiCaller.new(tweeter.user_tweets(params[:twitter_analysis])).scores_to_hash
      rescue ArgumentError
      end
      @analysis = PersonAnalysis.create(get_analysis)
      if params[:twitter_analysis].length < 200
        flash[:error] = "If there are no scores in the analysis, your text wasnt long enough or Didn't make no sense."
      else
      end  
      @analysis.tweeter_text = tweeter.user_tweets(params[:twitter_analysis]).split(": ")      
      @analysis.author = params[:tweeter]
      @analysis.tweeter_username = params[:twitter_analysis]
      @analysis.user_id = session[:user_id]
      flash[:message] = "Hey hey, look at that, it worked!"
      @analysis.save

      redirect to "/personality_analyses/#{@analysis.id}"
    end  
  end 



  get '/personality_analyses/:id' do
    if logged_in?
      @analysis = PersonAnalysis.find_by_id(params[:id])
      @user = User.find_by_id(params[:id])
      erb :'/personality_analyses/show_personality'
    else
      redirect to 'login'
    end    
  end
    
  get '/personality_analyses/:id/edit' do 
    if logged_in?
      @analysis = PersonAnalysis.find_by_id(params[:id])
      if self.current_user.id == @analysis.user_id
        erb :'personality_analyses/edit_personality'
      else
        redirect to '/analyses'
      end
    else
      redirect to '/login'
    end       
  end  

  patch '/personality_analyses/:id' do 
    if params[:text_author] == "" || params[:text_author] == nil
      redirect to "/personality_analyses/#{params[:id]}/edit"
    else  
      @analysis = PersonAnalysis.find_by_id(params[:id])
      @analysis.author = params[:text_author] 
      @analysis.person_text = params[:text_analysis]
      @analysis.save
      redirect to "/personality_analyses/#{@analysis.id}"
    end   
  end  

  patch '/twitter_personality_analyses/:id' do 
    if params[:tweeter] == "" || params[:tweeter] == nil
      redirect to "/personality_analyses/#{params[:id]}/edit"
    else  
      @analysis = PersonAnalysis.find_by_id(params[:id])
      @analysis.author = params[:tweeter]  
      @analysis.tweeter_text = params[:twitter_analysis]                
      @analysis.save
      redirect to "/personality_analyses/#{@analysis.id}"
    end   
  end

  delete '/personality_analyses/:id/delete' do 
    if logged_in?
      @analysis = PersonAnalysis.find_by_id(params[:id])
      if current_user.id == @analysis.user_id
        @analysis.destroy
        redirect to '/analyses'
      else
        redirect to '/analyses'
      end
    else
      redirect to 'login'
    end
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