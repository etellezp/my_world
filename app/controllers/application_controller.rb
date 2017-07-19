require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_world_secret"
    use Rack::Flash
  end

  get "/" do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_traveler
    end

    def current_traveler
      @current_traveler ||= Traveler.find_by(id: session[:traveler_id]) if session[:traveler_id]
    end
  end

end
