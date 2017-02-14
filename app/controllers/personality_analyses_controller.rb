class PersonalityAnalysesController < PantariApplicationController 

  get '/personality_analyses/new' do 
    if logged_in?
      erb :'personality_analyses/new'
    else
      redirect to '/login' 
    end
  end

  post '/personality_analyses' do 
    if params[:author] == "" || params[:author] == nil
      redirect to "/personality_analyses/new"
    elsif
      params[:text_input] == "" || params[:text_input] == nil 
      return "Error write error message"  
  end      

  get 'personality_analyses/:id'
    
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