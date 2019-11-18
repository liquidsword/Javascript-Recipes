class RecipeIngredientSerializer < ActiveModel::Serializer
  attributes :id, :quantity

  belongs_to :ingredient

end
