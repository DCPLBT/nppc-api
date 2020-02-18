# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Role < ApplicationRecord
  include Booleans::Role
  include Relations::Role
  include Validations::Role
  include ::Callbacks::Role
end
