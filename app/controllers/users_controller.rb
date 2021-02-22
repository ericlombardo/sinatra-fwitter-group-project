class UsersController < ApplicationController

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:user_id]
      redirect to '/tweets/index'
    else
      erb :signup
    end
  end

  post '/signup' do
    if !params.values.any? {|v| v.empty?}
      @user = User.create(params) # create user
      session[:user_id] = @user.id  
      redirect './tweets'
    else
     redirect '/signup'
    end
  end

  get '/login'do
    if session[:user_id]
      redirect to "/tweets"
    else
      erb :login  
    end
  end

  post '/login' do  # sends in user, redirect to index page of tweets, page has "Welcome,"
    @user = User.find_by(username: params[:username])  #=> instance or nil
    if @user && @user.authenticate(params[:password])  #=> instance or false
      session[:user_id] = @user.id
      redirect to "/tweets"
    end
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect to "/login"
    else
      redirect to "/login"
    end
  end 

  get '/users/:slug' do
    @user = find_by_slug(param[:slug])
    erb :"tweets/show"
  end
end
