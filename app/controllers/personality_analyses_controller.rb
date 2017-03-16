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
      erb :'/personality_analyses/error'
    elsif
      params[:text_analysis] == "" || params[:text_analysis] == nil
      erb :'/personality_analyses/error'
    else
      begin
        analysis = PersonalityApiCaller.new(params[:text_analysis]).scores_to_hash
      rescue ArgumentError 
      end  
      @analysis = PersonAnalysis.new(analysis)
      @analysis.author = params[:text_author]
      @analysis.person_text = params[:text_analysis].encode!("UTF-8", invalid: :replace, undef: :replace).force_encoding("utf-8")
      @analysis.user_id = session[:user_id]
      @analysis.save
      redirect to "/personality_analyses/#{@analysis.id}" 
    end  
  end   

  post '/twitter_analyses' do 
    if params[:tweeter] == "" || params[:tweeter] == nil
      erb :'/personality_analyses/error'
    elsif
      params[:twitter_analysis] == "" || params[:twitter_analysis] == nil
      erb :'/personality_analyses/error'
    else
      tweeter = TwitterApiCall.new
      #begin
        get_analysis = PersonalityApiCaller.new(tweeter.user_tweets(params[:twitter_analysis])).scores_to_hash
      #rescue NoMethodError
      #end
      @analysis = PersonAnalysis.new(get_analysis)
      @analysis.tweeter_text = tweeter.user_tweets(params[:twitter_analysis]).split(": ")      
      @analysis.author = params[:tweeter]
      @analysis.tweeter_username = params[:twitter_analysis]
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
  
end
