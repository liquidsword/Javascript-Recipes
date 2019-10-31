class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :instructions, :recipe_ingredients
  belongs_to :culinary_artist_id
  has_many :ingredients
end
