class RecipesController < ApplicationController

  def index
    @recipes = Recipe.includes(:ingredients).all
    render json: @recipes
  end

  def alpha
    @recipes = Recipe.alphabetize
    render 'index'
  end

  def show
    @recipe = Recipe.find(params[:id]) #have to make sure this code stays or it can't find title method
    respond_to do |f|
      f.html
      f.json {render json: @recipe }
    end
  end

  def new
    if params[:culinary_artist_id] && !CulinaryArtist.exists?(params[:culinary_artist_id])
      redirect_to culinary_artists_path, alert: "CulinaryArtist not found!"
    else
      @recipe = Recipe.new(culinary_artist_id: params[:culinary_artist_id])
    end
  end

  def create
    @recipe = Recipe.create(recipe_params)
    @recipe.culinary_artist_id = @culinary_artist_id
    if @recipe.valid?
       # redirect_to recipe_path(@recipe)
       render json: @recipe #(added 8-26-19)
    else
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
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    @recipes = Recipe.all
    redirect_to recipes_path
  end

  private
    def recipe_params
        params.require(:recipe).permit(:culinary_artist_id, :title, :instructions, recipe_ingredients_attributes: [:quantity, :ingredient_name, :_destroy])

    end
end
