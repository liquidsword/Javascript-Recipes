class IngredientsController < ApplicationController

  def new
    if params[:recipe_ingredient_id]
      #@recipe = Recipe.find_by(params[:recipe_id])
      #@recipe_ingredient = @recipe.recipe_ingredients.build
      #@recipe_ingredient.save
      #@ingredient = @recipe_ingredient.build_ingredient
      #@ingredient.save
    #else
      @ingredient = Ingredient.new
      @ingredient.save
    end
  end

  def index
    @ingredients = Ingredient.all
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def create
    @ingredient = Ingredient.new(params[:id])
    if @ingredient.save
      redirect_to @ingredient
    else
      render :new
    end
  end

  def edit
    @ingredient = Ingredient.find_by(params[:id])
  end

  def update
    @ingredient = Ingredient.find_by(params[:id])
  end

  def destroy
    @ingredient = Ingredient.find_by(params[:id])
    @ingredient.destroy
    @ingredients = Ingredient.all
    redirect_to ingredients_path
  end
  
end
