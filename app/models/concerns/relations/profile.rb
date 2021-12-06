# frozen_string_literal: true

module Relations
  module Profile
    extend ActiveSupport::Concern

    included do
      belongs_to :region
      belongs_to :district
      belongs_to :extension
      belongs_to :user, inverse_of: :profile

      has_one :photo, as: :imageable, dependent: :destroy

      accepts_nested_attributes_for(
        :photo,
        update_only: true
      )
    end
  end
end
