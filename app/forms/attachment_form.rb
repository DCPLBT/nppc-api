# frozen_string_literal: true

class AttachmentForm < BaseForm
  def create
    attachment.save
  end

  def update
    attachment.update(params)
  end

  def destroy
    attachment.destroy
  end

  private

  def attachment
    @attachment ||= id ? attachment.find(id) : determine_singularity
  end

  def determine_singularity
    parent.respond_to?(:attachment) ? parent.build_attachment(params) : parent.attachments.build(params)
  end
end
