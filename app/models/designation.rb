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
#  agency_id   :bigint
#  user_id     :bigint           not null
#
# Indexes
#
#  index_designations_on_agency_id  (agency_id)
#  index_designations_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (agency_id => agencies.id)
#  fk_rails_...  (user_id => users.id)
#
class Designation < ApplicationRecord
  include Scopes::Designation
  include Relations::Designation
  include Validations::Designation
end
