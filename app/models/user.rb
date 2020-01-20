class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise(
    :lockable,
    :trackable,
    :invitable,
    :confirmable,
    :timeoutable,
    :recoverable,
    :validatable,
    :registerable,
    :rememberable,
    :jwt_authenticatable,
    :database_authenticatable,
    jwt_revocation_strategy: self
  )
end