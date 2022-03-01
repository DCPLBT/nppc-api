# frozen_string_literal: true

# == Schema Information
#
# Table name: designations
#
#  id          :bigint           not null, primary key
#  description :text
#  disabled    :boolean          default(FALSE)
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_designations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Designation < ApplicationRecord
  include Scopes::Designation
  include Relations::Designation
  include Validations::Designation
end
