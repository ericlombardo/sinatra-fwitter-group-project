class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all
      erb :"tweets/index"
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if session[:user_id]
      erb :"tweets/new"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if session[:user_id]
      if !params.values.any?("")
        @tweet = Tweet.new(params)
        @tweet.user_id = session[:user_id]
        @tweet.save
        redirect to "tweets/#{@tweet.id}"
      else
        redirect to '/tweets/new'
      end
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show"
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do 
    redirect to '/login' if !session[:user_id]
    @tweet = Tweet.find(params[:id])
    if session[:user_id] == @tweet.user_id
      erb :"tweets/edit"
    else
      redirect to '/tweets'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if session[:user_id] == @tweet.user_id && !params.values.any?("")
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{params[:id]}"
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id' do
    
    tweet = Tweet.find(params[:id])
    tweet.destroy if tweet.user_id == session[:user_id]
  end

end
