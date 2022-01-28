# frozen_string_literal: true

module Relations
  module Notification
    extend ActiveSupport::Concern

    included do
      has_rich_text :text

      has_many :recipients, dependent: :destroy
      has_many :users, through: :recipients
    end
  end
end
