# frozen_string_literal: true

module Delegates
  module Group
    extend ActiveSupport::Concern

    included do
      delegate(:name, to: :role, prefix: true)
    end
  end
end
