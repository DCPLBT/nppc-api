# == Schema Information
#
# Table name: attachments
#
#  id              :bigint           not null, primary key
#  attachable_type :string           not null
#  default         :boolean
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
    :default,
    :file_url
  )

  def file_url
    rails_blob_url(object.file) if object.file.attached?
  end
end
