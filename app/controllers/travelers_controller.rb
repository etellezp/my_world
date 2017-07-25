class TravelersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'travelers/create_traveler'
    else
      redirect to '/recommendations'
    end
  end

  # view
    # -> USer click on "signup"
    # -> Sends "POST" reuqest with HTTP URL of "/signup" to the server
    # -> The server than parses the request through its middle ware (Rack)
    # -> It passes the request to the sinatra code
    # -> Sinatra route matches

  post '/signup' do
      @traveler = Traveler.new(username: params[:username], email: params[:email], password: params[:password])
      if @traveler.save
        session[:traveler_id] = @traveler.id
        redirect to '/recommendations'
      else
        erb :'travelers/create_traveler'
      end
  end

  get '/login' do
    if !logged_in?
      erb :'travelers/login'
    else
      redirect to '/recommendations'
    end
  end

  post '/login' do
    traveler = Traveler.find_by(username: params[:username])
    if traveler && traveler.authenticate(params[:password])
      session[:traveler_id] = traveler.id
      redirect to '/recommendations'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
