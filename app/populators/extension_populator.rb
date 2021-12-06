# frozen_string_literal: true

class ExtensionPopulator < BasePopulator
  def run
    extensions
      .public_send(:search, q)
  end

  private

  def extensions
    @extensions ||= parent ? parent.extensions : Extension
  end
end
