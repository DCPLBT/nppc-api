# frozen_string_literal: true

module Delegates
  module Agency
    extend ActiveSupport::Concern

    included do
      delegate(:name, to: :user, prefix: true)
    end
  end
end
