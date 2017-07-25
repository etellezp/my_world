class RecommendationsController < ApplicationController

  get '/recommendations' do
    if logged_in?
      @recommendations = Recommendation.all
      erb :'recommendations/recommendations'
    else
      flash[:notice] = 'Please log in first.'
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
    @recommendation = current_traveler.recommendations.build(params)
    if @recommendation.save
      redirect to "/recommendations/#{@recommendation.id}"
    else
      erb :'recommendations/create_recommendation'
    end
  end

  get '/recommendations/:id' do
    if logged_in?
      if @recommendation = Recommendation.find_by(id: params[:id])
        erb :'recommendations/show_recommendation'
      else
        redirect '/recommendations' # or some 404 page
      end
    else
      redirect to '/login'
    end
  end

  get '/recommendations/:id/edit' do
    if logged_in?
      if @recommendation = current_traveler.recommendations.find_by(id: params[:id])
        erb :'recommendations/edit_recommendation'
      else
        flash[:notice] = "You can only edit your recommendations"
        redirect to '/recommendations'
      end
    else
      redirect to '/login'
    end
  end

  patch '/recommendations/:id' do
    @recommendation = current_traveler.recommendations.find_by(id: params[:id])
    if @recommendation
      if @recommendation.update(params)
        redirect to "/recommendations/#{@recommendation.id}"
      else
        erb :'recommendations/edit_recommendation'
      end
    else
      flash[:notice] = "You can only edit your recommendations"
      redirect to '/recommendations'
    end
  end

  delete '/recommendations/:id/delete' do
    if logged_in?
      if recommendation = current_traveler.recommendations.find_by(params[:id]) &&
        recommendation.delete
          redirect to '/recommendations'
      else
        flash[:notice] = "You can only delete your recommendations"
        redirect to '/recommendations'
      end
    end
  end
  
end
