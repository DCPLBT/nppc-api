# frozen_string_literal: true

# == Schema Information
#
# Table name: indents
#
#  id             :bigint           not null, primary key
#  accepted_on    :datetime
#  draft          :boolean
#  indent_type    :integer
#  reference_no   :string
#  state          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  accepted_by_id :bigint
#  company_id     :bigint
#  district_id    :bigint
#  extension_id   :bigint
#  from_id        :bigint
#  region_id      :bigint
#  to_id          :bigint
#  user_id        :bigint           not null
#
# Indexes
#
#  index_indents_on_accepted_by_id  (accepted_by_id)
#  index_indents_on_company_id      (company_id)
#  index_indents_on_district_id     (district_id)
#  index_indents_on_extension_id    (extension_id)
#  index_indents_on_region_id       (region_id)
#  index_indents_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (district_id => districts.id)
#  fk_rails_...  (extension_id => extensions.id)
#  fk_rails_...  (region_id => regions.id)
#  fk_rails_...  (user_id => users.id)
#
class Indent < ApplicationRecord
  include Enums::Indent
  include Scopes::Indent
  include Helpers::Indent
  include Delegates::Indent
  include Relations::Indent
  include Validations::Indent
  include ::Callbacks::Indent
end
