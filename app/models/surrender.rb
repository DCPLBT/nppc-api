# frozen_string_literal: true

# == Schema Information
#
# Table name: surrenders
#
#  id             :bigint           not null, primary key
#  reference_no   :string
#  state          :integer
#  surrender_type :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  district_id    :bigint
#  extension_id   :bigint
#  region_id      :bigint
#  user_id        :bigint           not null
#
# Indexes
#
#  index_surrenders_on_district_id   (district_id)
#  index_surrenders_on_extension_id  (extension_id)
#  index_surrenders_on_region_id     (region_id)
#  index_surrenders_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (district_id => districts.id)
#  fk_rails_...  (extension_id => extensions.id)
#  fk_rails_...  (region_id => regions.id)
#  fk_rails_...  (user_id => users.id)
#
class Surrender < ApplicationRecord
  include Enums::Surrender
  include Scopes::Surrender
  include Helpers::Surrender
  include Delegates::Surrender
  include Relations::Surrender
  include Validations::Surrender
  include ::Callbacks::Surrender
end
