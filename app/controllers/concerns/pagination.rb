module Pagination
  def paginate(resource)
    {
      previous: resource.prev,
      current: resource.page,
      next_page: resource.next,
      last_page: resource.last,
      total: resource.count
    }
  end

  def render_paginated_collection(resource, serializer = nil, root = nil)
    config, collection = paginated_collection(resource)
    render paginated_data(collection, config, serializer, root)
  end

  def paginated_collection(resource)
    pagy(
      resource,
      page: params.fetch(:page, 1),
      items: params.fetch(:per_page, 10)
    )
  end

  def paginated_data(collection, config, serializer, root)
    {
      json: collection,
      status: :ok,
      each_serializer: serializer,
      root: root,
      meta: paginate(config)
    }
  end
end
