class UsersController < PantariApplicationController
#shotgun --server=thin --port=9494 config.ru
  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    @user.person_alayses
    erb :'users/show'
  end  

  get '/signup' do
    session.clear
    if logged_in?
      redirect '/analyses'
    else
      erb :'users/create_user'
    end   
  end  

  post '/signup' do 
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else   
    @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    @user.save
    session[:user_id] = @user.id 
    redirect to '/analyses'
    end 
  end   

  get '/login' do 
    if logged_in?
      redirect to '/analyses'
    else
      erb :'users/login'
    end    
  end  

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      redirect to '/analyses'
    else
      redirect to '/login' 
    end 
  end      

  get '/logout' do 
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
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
