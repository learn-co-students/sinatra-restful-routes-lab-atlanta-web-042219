class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #__________ home __________

  get '/' do
  	redirect '/recipes'
  end

  get '/recipes' do
  	erb :index
  end

  #__________ create / new __________

  get '/recipes/new' do
    erb :new_recipe
  end

  post '/recipes' do
    redirect "/recipes/#{Recipe.create(params).id}"
  end

  # get

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show_recipe
  end

  # edit / update / patch

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit_recipe
  end

  patch '/recipes/:id' do
  	params.delete('_method')
  	puts params
  	Recipe.update(params[:id], params)
  	redirect "recipes/#{params[:id]}"
  end

  # delete

  delete '/recipes/:id' do
  	Recipe.destroy(params[:id])
  	redirect '/recipes'
  end
#
end
