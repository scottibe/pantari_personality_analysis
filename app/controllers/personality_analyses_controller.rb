class PersonalityAnalysesController < PantariApplicationController 

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
      analysis = PersonalityApiCaller.new(params[:text_analysis]).scores_to_hash
      @analysis = PersonAnalysis.create(analysis)
      @analysis.author = params[:text_author]
      @analysis.user_id = session[:user_id]
      @analysis.save

      redirect to "/personality_analyses/#{@analysis.id}"
    end  
  end   

  post '/twitter_analyses' do 
    if params[:tweeter] == "" || params[:tweeter] == nil
      puts "Please enter the name of the Twitter User"
      redirect to "/personality_analyses/new"
    elsif
      params[:twitter_analysis] == "" && params[:twitter_analysis] == nil
      puts "Please enter a Twitter username"
      redirect to "/personality_analyses/new"
    else
      tweeter = TwitterApiCall.new
      tweet_text = tweeter.user_tweets(params[:twitter_analysis])
      analysis = PersonalityApiCaller.new(tweet_text).scores_to_hash
      @analysis = PersonAnalysis.create(analysis)
      @analysis.author = params[:tweeter]
      @analysis.user_id = session[:user_id]
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
    





  helpers do 

    def logged_in?
      !!session[:user_id]
    end 
    
    def current_user
      User.find(session[:user_id])
    end
  end  

end