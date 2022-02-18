# frozen_string_literal: true

module Relations
  module UserGroup
    extend ActiveSupport::Concern

    included do
      belongs_to :user, inverse_of: :user_groups
      belongs_to :group, inverse_of: :user_groups
    end
  end
end
