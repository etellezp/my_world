class RecommendationsController < ApplicationController
  get '/recommendations' do
    if logged_in?
      @recommendations = Recommendation.all
      erb :'recommendations/recommendations'
    else
      redirect to '/login'
    end
  end

  get '/recommendations/new' do
    if logged_in?
      erb :'recommendations/create_recommendation'
    else
      redirect to '/login'
    end
  end

  post '/recommendations' do
    if params[:location] == "" || params[:content] == "" || params[:rating] == ""
      redirect to '/recommendations/new'
    else
      @recommendation = current_traveler.recommendations.create(params)
      redirect to "/recommendations/#{@recommendation.id}"
    end
  end

  get '/recommendations/:id' do
    if logged_in?
      @recommendation = Recommendation.find_by_id(params[:id])
      erb :'recommendations/show_recommendation'
    else
      redirect to '/login'
    end
  end

  get '/recommendations/:id/edit' do
    if logged_in?
      @recommendation = current_traveler.recommendations.find_by(id: params[:id])
      if @recommendation
        erb :'recommendations/edit_recommendation'
      else
        redirect to '/recommendations'
      end
    end
  end

  patch '/recommendations/:id' do
    if params[:location] == "" || params[:content] == "" || params[:rating] == ""
      redirect to "/recommendations/#{params[:id]}/edit"
    else
      @recommendation = Recommendation.find_by_id(params[:id])
      @recommendation.location = params[:location]
      @recommendation.content = params[:content]
      @recommendation.rating = params[:rating]
      @recommendation.save
      redirect to "/recommendations/#{@recommendation.id}"
    end
  end

  delete '/recommendations/:id/delete' do
    if logged_in?
      recommendation = current_traveler.recommendations.find_by(params[:id])
      if recommendation
        recommendation.delete
        redirect to '/recommendations'
      else
        redirect to '/recommendations'
      end
    end
  end

end
