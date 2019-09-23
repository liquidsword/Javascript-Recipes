class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :instructions
  belongs_to :culinary_artist_name
  has_many :ingredients
end
