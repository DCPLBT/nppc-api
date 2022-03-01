# frozen_string_literal: true

module Relations
  module Designation
    extend ActiveSupport::Concern

    included do
      belongs_to :user
      belongs_to :agency, inverse_of: :designations
    end
  end
end
