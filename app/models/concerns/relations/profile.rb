# frozen_string_literal: true

module Relations
  module Profile
    extend ActiveSupport::Concern

    included do
      belongs_to :region, optional: true
      belongs_to :district, optional: true
      belongs_to :extension, optional: true
      belongs_to :company, optional: true
      belongs_to :user, inverse_of: :profile
      belongs_to :agency, optional: true
      belongs_to :designation, optional: true
      belongs_to :employee_type, optional: true

      has_one :photo, as: :imageable, dependent: :destroy

      accepts_nested_attributes_for(
        :photo,
        update_only: true
      )
    end
  end
end
