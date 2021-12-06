# frozen_string_literal: true

class ExtensionForm < BaseForm
  attr_accessor :extension_id

  def show
    extension
  end

  def create
    extension.save
  end

  def update
    extension.update(params)
  end

  def destroy
    extension.destroy
  end

  private

  def extension
    @extension ||= if extension_id
                     Extension.find(extension_id)
                   else
                     parent.extensions.build(params.merge(user_id: current_user.id))
                   end
  end
end
