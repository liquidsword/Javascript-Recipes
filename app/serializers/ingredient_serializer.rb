class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :recipe
  has_many :recipe_ingredients
end
