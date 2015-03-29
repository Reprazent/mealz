class MealSerializer < ActiveModel::Serializer
  attributes :id
  has_one :payed_by
end
