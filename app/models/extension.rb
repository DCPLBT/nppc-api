# frozen_string_literal: true

# == Schema Information
#
# Table name: extensions
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  district_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_extensions_on_district_id  (district_id)
#  index_extensions_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (district_id => districts.id)
#  fk_rails_...  (user_id => users.id)
#
class Extension < ApplicationRecord
  include Scopes::Extension
  include Relations::Extension
  include Validations::Extension
end
