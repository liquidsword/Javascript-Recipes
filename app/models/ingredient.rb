class Ingredient < ApplicationRecord

  validates :name, presence: true
  belongs_to :recipe

  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  accepts_nested_attributes_for :recipes, allow_destroy: true
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true

end
