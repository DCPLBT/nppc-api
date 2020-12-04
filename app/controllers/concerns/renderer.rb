module Renderer
  def compute_form(action, model, form, serializer = {})
    if form.send(action)
      render data(form.send(model), form, serializer)
    else
      invalid_resource(form.send(model))
    end
  end

  def data(object, form, serializer)
    options = {
      include: form.include,
      params: { current_user: current_user }
    }
    {
      json: single_serializer(object, serializer.try(:serializer)).new(object, options).serialized_json,
      status: :ok
    }
  end

  def file_download(file_path, file_name, file_type)
    send_file(
      file_path,
      type: file_type,
      disposition: 'attachment',
      file_name: file_name,
      x_sendfile: true
    )
  end

  def file_preview(data, file_name, file_type)
    send_data(
      data,
      type: file_type,
      disposition: 'attachment',
      file_name: file_name,
      x_sendfile: true
    )
  end

  def method_missing(method_sym, *args, &block)
    if method_sym.to_s =~ /^(^[^_]+(?=_))_(.*)_form$/i
      compute_form(Regexp.last_match(1), Regexp.last_match(2), *args)
    else
      super
    end
  end

  def respond_to_missing?(method, *)
    super
  end

  def single_serializer(obj, serializer)
    serializer.present? ? serializer : "#{obj.class}Serializer".constantize
  end
end
