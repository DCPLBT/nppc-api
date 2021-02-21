# frozen_string_literal: true

module Assigner
  def assign_attributes(attributes = {})
    Hash(attributes).each do |key, value|
      writer_method = "#{key}="
      send(writer_method, value) if respond_to?(writer_method)

      assign_attributes(value) if value.is_a?(Hash) || value.is_a?(ActionController::Parameters)
    end
  end
end
