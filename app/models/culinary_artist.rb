class CulinaryArtist < ApplicationRecord

  validates :culinary_artist_name, presence: true
  has_secure_password
  has_many :recipes
  has_many :ingredients, through: :recipes

  def self.find_or_create_by_omniauth(auth_hash)
    self.where(:email => auth_hash["info"]["email"]).first_or_create do |culinary_artist|
      culinary_artist.password = SecureRandom.hex
    end
  end
end
