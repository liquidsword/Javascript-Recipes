class RecipeIngredient < ApplicationRecord

  belongs_to :recipe, optional: true
  belongs_to :ingredient, optional: true

  validates :quantity, presence: true

  accepts_nested_attributes_for :ingredient, allow_destroy: true
  accepts_nested_attributes_for :recipe, allow_destroy: true

  def ingredient_name=(ingredient_name) #setter
    self.ingredient = Ingredient.find_or_create_by(name: ingredient_name)
  end

  def ingredient_name #getter
    ingredient.name if ingredient
  end

end
