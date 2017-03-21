class UsersController < PantariApplicationController
  use Rack::Flash
  get '/signup' do
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
    session[:user_id] = @user.id 
    @user.save
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
      session[:user_id] = @user.id
      @user.save
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
