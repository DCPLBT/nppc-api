# frozen_string_literal: true

class ExtensionPopulator < BasePopulator
  def run
    extensions
      .public_send(:search, q)
      .yield_self { |extensions| filter_by_disabled(extensions) }
  end

  private

  def extensions
    @extensions ||= parent ? parent.extensions : Extension
  end
end
