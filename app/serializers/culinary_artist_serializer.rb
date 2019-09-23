class CulinaryArtistSerializer < ActiveModel::Serializer
  attributes :id, :culinary_artist_name
  has_many :recipes
end
