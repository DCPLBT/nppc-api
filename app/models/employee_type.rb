# frozen_string_literal: true

# == Schema Information
#
# Table name: employee_types
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_employee_types_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class EmployeeType < ApplicationRecord
  include Scopes::EmployeeType
  include Relations::EmployeeType
  include Validations::EmployeeType
end