# frozen_string_literal: true

module Relations
  module User
    extend ActiveSupport::Concern

    included do
      has_many :regions, inverse_of: :user, dependent: :destroy

      has_one :profile, inverse_of: :user, dependent: :destroy
      has_one :photo, through: :profile

      has_many :settings, inverse_of: :user, dependent: :destroy
      has_many :forwardable_forwarded_tos, foreign_key: :forwarded_to_id
      has_many :requestable_requesters, foreign_key: :requester_id
      has_many :forwarded_indents, through: :forwardable_forwarded_tos, source: :forwardable, source_type: 'Indent'
      has_many :requested_indents, through: :requestable_requesters, source: :requestable, source_type: 'Indent'

      has_and_belongs_to_many :roles, inverse_of: :users

      accepts_nested_attributes_for(
        :profile,
        update_only: true
      )
    end
  end
end
