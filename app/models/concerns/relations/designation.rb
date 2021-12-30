# frozen_string_literal: true

module Relations
  module Designation
    extend ActiveSupport::Concern

    included do
      belongs_to :user
    end
  end
end
