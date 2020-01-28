class UserSerializer < ApplicationSerializer
  attributes(
    :id,
    :email,
    :username,
    :phone
  )
end
