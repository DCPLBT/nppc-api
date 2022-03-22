# frozen_string_literal: true

module Pagination
  require 'pagy/extras/array'

  def paginate(resource, extras = {})
    extras ||= {}
    {
      previous: resource.prev,
      current: resource.page,
      next_page: resource.next,
      last_page: resource.last,
      total: resource.count
    }.merge(extras)
  end

  def render_paginated_collection(resource, options = {})
    config, collection = paginated_collection(resource)
    render paginated_data(collection, config, options)
  end

  def paginated_collection(resource)
    if resource.is_a?(Array)
      pagy_array(resource, page: params.fetch(:page, 1), items: params.fetch(:per_page, 10))
    else
      pagy(resource, page: params.fetch(:page, 1), items: params.fetch(:per_page, 10))
    end
  end

  def paginated_data(collection, config, options)
    params = options[:params] || {}
    options[:meta] = paginate(config, options[:meta])
    options[:params] = params.merge!(current_user: current_user)
    {
      json: collection_serializer(collection, options[:serializer]).new(collection, options).serializable_hash.to_json,
      status: :ok
    }
  end

  def collection_serializer(obj, serializer)
    serializer.present? ? serializer : "#{obj.class.to_s.deconstantize}Serializer".constantize
  end
end
