class UserSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :email,
    :username,
    :phone
  )
end
