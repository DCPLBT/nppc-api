# frozen_string_literal: true

module Relations
  module User
    extend ActiveSupport::Concern

    included do
      has_one :profile, inverse_of: :user, dependent: :destroy
      has_one :photo, through: :profile

      has_many :carts, as: :cartable, dependent: :destroy
      has_many :regions, inverse_of: :user, dependent: :destroy
      has_many :settings, inverse_of: :user, dependent: :destroy
      has_many :recipients, inverse_of: :user
      has_many :notifications, through: :recipients
      has_many :user_groups, inverse_of: :user, dependent: :destroy
      has_many :groups, through: :user_groups

      has_and_belongs_to_many :roles, inverse_of: :users

      accepts_nested_attributes_for(
        :profile,
        update_only: true
      )
    end
  end
end
