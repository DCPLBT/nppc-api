# frozen_string_literal: true

# == Schema Information
#
# Table name: mobilizations
#
#  id             :bigint           not null, primary key
#  category       :integer
#  reference_no   :string
#  state          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  approved_by_id :bigint
#  company_id     :bigint
#  district_id    :bigint
#  extension_id   :bigint
#  region_id      :bigint
#  user_id        :bigint           not null
#
# Indexes
#
#  index_mobilizations_on_approved_by_id  (approved_by_id)
#  index_mobilizations_on_company_id      (company_id)
#  index_mobilizations_on_district_id     (district_id)
#  index_mobilizations_on_extension_id    (extension_id)
#  index_mobilizations_on_region_id       (region_id)
#  index_mobilizations_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (district_id => districts.id)
#  fk_rails_...  (extension_id => extensions.id)
#  fk_rails_...  (region_id => regions.id)
#  fk_rails_...  (user_id => users.id)
#
class Mobilization < ApplicationRecord
  include Enums::Mobilization
  include Scopes::Mobilization
  include Helpers::Mobilization
  include Booleans::Mobilization
  include Delegates::Mobilization
  include Relations::Mobilization
  include Validations::Mobilization
  include ::Callbacks::Mobilization
end
