# frozen_string_literal: true

module Delegates
  module Unit
    extend ActiveSupport::Concern

    included do
      delegate(:name, to: :user, prefix: true)
    end
  end
end
