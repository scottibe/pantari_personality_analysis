class ToneAnalysesController < PantariApplicationController
  use Rack::Flash

  get '/tone_analyses/new' do
    if logged_in?
      erb :'tone_analyses/new_tone'
    else
      redirect to
    end
  end

  post '/text_tone_analyses' do 
    if params[:text_author] == "" || params[:text_author] == nil
      erb :'/tone_analyses/error'
    elsif
      params[:text_analysis] == "" && params[:text_analysis] == nil
      erb :'/tone_analyses/error'
    else  
      tone_analysis = ToneApiCaller.new(params[:text_analysis]).scores_to_hash
      @analysis = TheToneAnalysis.create(tone_analysis)
      @analysis.tone_text = params[:text_analysis].encode!("UTF-8", invalid: :replace, undef: :replace).force_encoding("utf-8") 
      @analysis.author = params[:text_author]
      @analysis.user_id = session[:user_id]
      flash[:message] = "Analysis Complete!"
      @analysis.save

      redirect to "/tone_analyses/#{@analysis.id}" 
    end  
  end   

  post '/twitter_tone_analyses' do 
    if params[:tweeter] == "" || params[:tweeter] == nil
      erb :'/tone_analyses/error'
    elsif
      params[:twitter_analysis] == "" && params[:twitter_analysis] == nil
      erb :'/tone_analyses/error'
    else       
      tweeter = TwitterApiCall.new
      tweeties = tweeter.user_tweets(params[:twitter_analysis])
      get_analysis = ToneApiCaller.new(tweeties).scores_to_hash
      @analysis = TheToneAnalysis.create(get_analysis)
      @analysis.tweet_text = tweeter.user_tweets(params[:twitter_analysis])
      @analysis.author = params[:tweeter]
      @analysis.tweeter_username = params[:twitter_analysis]
      @analysis.user_id = session[:user_id]
      @analysis.save

      redirect to "/tone_analyses/#{@analysis.id}"    
    end  
  end 

  get '/tone_analyses/:id' do
    if logged_in?
      @analysis = TheToneAnalysis.find_by_id(params[:id])
      @user = User.find_by_id(params[:id])
      erb :'/tone_analyses/show_tone'
    else
      redirect to 'login'
    end    
  end
    
  get '/tone_analyses/:id/edit' do 
    if logged_in?
      @analysis = TheToneAnalysis.find_by_id(params[:id])
      @analysis.save
      if self.current_user.id == @analysis.user_id
        erb :'tone_analyses/edit_tone'
      else
        redirect to '/analyses'
      end
    else
      redirect to '/login'
    end       
  end  

  patch '/tone_analyses/:id' do 
    if params[:text_author] == "" || params[:text_author] == nil
      redirect to "/tone_analyses/#{params[:id]}/edit"
    else  
      @analysis = TheToneAnalysis.find_by_id(params[:id])
      tone_analysis = ToneApiCaller.new(params[:text_analysis]).scores_to_hash      
      @analysis.update(tone_analysis)
      @analysis.update(author: params[:text_author], tone_text: params[:text_analysis].encode!("UTF-8", invalid: :replace, undef: :replace).force_encoding("utf-8")) 
      @author = params[:text_author]
      redirect to "/tone_analyses/#{@analysis.id}"
    end   
  end  

  patch '/twitter_tone_analyses/:id' do 
    if params[:tweeter] == "" || params[:tweeter] == nil
      redirect to "/tone_analyses/#{params[:id]}/edit"
    else 
      @analysis = TheToneAnalysis.find_by_id(params[:id])
      @analysis.author = params[:tweeter]       
      @analysis.save
      redirect to "/tone_analyses/#{@analysis.id}"
    end   
  end

  delete '/tone_analyses/:id/delete' do 
    if logged_in?
      @analysis = TheToneAnalysis.find_by_id(params[:id])
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

