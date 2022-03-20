# frozen_string_literal: true

# == Schema Information
#
# Table name: indents
#
#  id              :bigint           not null, primary key
#  accepted_on     :datetime
#  draft           :boolean
#  forwarded_on    :datetime
#  indent_type     :integer
#  received_on     :datetime
#  reference_no    :string
#  state           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  accepted_by_id  :bigint
#  company_id      :bigint
#  district_id     :bigint
#  extension_id    :bigint
#  forwarded_by_id :bigint
#  from_id         :bigint
#  received_by_id  :bigint
#  region_id       :bigint
#  to_id           :bigint
#  user_id         :bigint           not null
#
# Indexes
#
#  index_indents_on_accepted_by_id   (accepted_by_id)
#  index_indents_on_company_id       (company_id)
#  index_indents_on_district_id      (district_id)
#  index_indents_on_extension_id     (extension_id)
#  index_indents_on_forwarded_by_id  (forwarded_by_id)
#  index_indents_on_received_by_id   (received_by_id)
#  index_indents_on_region_id        (region_id)
#  index_indents_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (district_id => districts.id)
#  fk_rails_...  (extension_id => extensions.id)
#  fk_rails_...  (region_id => regions.id)
#  fk_rails_...  (user_id => users.id)
#
class IndentSerializer < ApplicationSerializer
  attributes(
    :user_id,
    :user_name,
    :draft,
    :state,
    :user_name,
    :user_cid,
    :user_region_name,
    :user_district_name,
    :user_extension_name,
    :user_village_name,
    :user_company_name,
    :reference_no,
    :created_at,
    :region_name,
    :district_name,
    :extension_name,
    :company_name,
    :accepted_by_id,
    :accepted_by_name,
    :accepted_on,
    :indent_type,
    :total_product,
    :total_quantity,
    :requester_ids,
    :forwarded_to_ids,
    :forwarded_by_name,
    :forwarded_on,
    :received_by_name,
    :received_on
  )

  attribute :remark do |object|
    object.remark&.to_plain_text
  end
end
