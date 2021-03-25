# frozen_string_literal: true

# == Schema Information
#
# Table name: attachments
#
#  id              :bigint           not null, primary key
#  attachable_type :string           not null
#  default         :boolean          default(FALSE)
#  type            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  attachable_id   :bigint           not null
#
# Indexes
#
#  index_attachments_on_attachable_type_and_attachable_id  (attachable_type,attachable_id)
#

class AttachmentSerializer < ApplicationSerializer
  attributes(
    :id,
    :filename,
    :byte_size,
    :default
  )

  attribute :file_url do |object|
    Rails.application.routes.url_helpers.rails_blob_url(object.file) if object.file.attached?
  end
end
