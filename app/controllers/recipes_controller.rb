class RecipesController < ApplicationController

  def index
    if params[:culinary_artist_id]
      @recipes = CulinaryArtist.find(params[:culinary_artist_id]).recipes
      @culinary_artist_id = params[:culinary_artist_id]
      respond_to do |f|
        f.html
        f.json {render json: @recipes} #recipes.json isn't working
        end
    else
      @recipes = Recipe.all
      respond_to do |f|
        f.html
        f.json {render json: @recipes}
        end
    end
  end

  def alpha
    #@recipes.order(title: 'desc') #tell which view to render, move to model, call the scope method here
    @recipes = Recipe.alphabetize
    render 'index'
  end

  def show
    @recipe = Recipe.find(params[:id]) #have to make sure this code stays or it can't find title method
    respond_to do |f|
      f.html { render :show}
      f.json {render json: @recipe }
  end

  def new
    if params[:culinary_artist_id] && !CulinaryArtist.exists?(params[:culinary_artist_id])
      redirect_to culinary_artists_path, alert: "CulinaryArtist not found!"
    else
      @recipe = Recipe.new(culinary_artist_id: params[:culinary_artist_id])
      #3.times { @recipe.recipe_ingredients.build} #this seems to work
    end
  end

  def create

    @recipe = Recipe.create(recipe_params)
    #@recipe.recipe_ingredients.build  #added 12/3/18
    @recipe.culinary_artist_id = @culinary_artist_id
    if @recipe.valid?
       #redirect_to recipe_path(@recipe)
      render json: @recipe #(added 8-26-19)
    else
      3.times { @recipe.recipe_ingredients.build } #added 10-2-18
      #render 'new'
      render json: @recipe, status: 201
    end
  end

  def edit
    if params[:culinary_artist_id]
      culinary_artist = CulinaryArtist.find_by(id: params[:culinary_artist_id])
      if culinary_artist.nil?
        redirect_to culinary_artists_path, alert: "CulinaryArtist not found."
      else
        @recipe = culinary_artist.recipes.find_by(id: params[:id])
        redirect_to culinary_artist_recipes_path(culinary_artist), alert: "Couldn't find that recipe!" if @recipe.nil?
      end
    else
    @recipe = Recipe.find(params[:id])
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    redirect_to @recipe
  end

  def destroy
    @recipe = Recipe.find_by(params[:id])
    @recipe.destroy
  end

  private
    def recipe_params
        params.require(:recipe).permit(:culinary_artist_id, :title, :instructions, recipe_ingredients_attributes: [:quantity, :ingredient_name, :_destroy])

    end
end
