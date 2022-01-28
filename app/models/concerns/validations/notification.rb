# frozen_string_literal: true

module Validations
  module Notification
    extend ActiveSupport::Concern

    included do
      validates_presence_of :title, :text, :recipients
    end
  end
end
