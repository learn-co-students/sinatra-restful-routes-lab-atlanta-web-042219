class ApplicationController < Sinatra::Base
  # set :method_override, true
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/recipes'
  end

  get '/recipes' do
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect to "recipes/#{@recipe.id}"
  end

  get "/recipes/:id/edit" do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    params.delete("_method")
    @recipe.update(params)
    redirect to "/recipes/#{@recipe.id}"

  end

  delete '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.destroy
    # Recipe.destroy(params[:id])
    redirect to '/recipes'
  end

end
