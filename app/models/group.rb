# frozen_string_literal: true

# == Schema Information
#
# Table name: groups
#
#  id           :bigint           not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :bigint
#  district_id  :bigint
#  extension_id :bigint
#  region_id    :bigint
#  role_id      :bigint           not null
#  village_id   :bigint
#
# Indexes
#
#  index_groups_on_company_id    (company_id)
#  index_groups_on_district_id   (district_id)
#  index_groups_on_extension_id  (extension_id)
#  index_groups_on_region_id     (region_id)
#  index_groups_on_role_id       (role_id)
#  index_groups_on_village_id    (village_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (district_id => districts.id)
#  fk_rails_...  (extension_id => extensions.id)
#  fk_rails_...  (region_id => regions.id)
#  fk_rails_...  (role_id => roles.id)
#  fk_rails_...  (village_id => villages.id)
#
class Group < ApplicationRecord
  include Scopes::Group
  include Delegates::Group
  include Relations::Group
  include Validations::Group
end
