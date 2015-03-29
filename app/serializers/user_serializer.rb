class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :balance
end
