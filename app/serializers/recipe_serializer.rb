class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :instructions
  belongs_to :culinary_artist_id
  has_many :ingredients
end
