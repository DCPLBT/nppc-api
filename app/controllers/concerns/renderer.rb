module Renderer
  def create_form(form, model)
    if form.create
      render data(form.send(model), form.try(:serializer))
    else
      invalid_resource(form.send(model))
    end
  end

  def update_form(form, model)
    if form.update
      render data(form.send(model), form.try(:serializer))
    else
      invalid_resource(form.send(model))
    end
  end

  def destroy_form(form, model)
    if form.destroy
      render data(form.send(model), form.try(:serializer))
    else
      invalid_resource(form.send(model))
    end
  end

  def show_form(form, model)
    if form.show
      render data(form.send(model), form.try(:serializer))
    else
      invalid_resource(form.send(model))
    end
  end

  def data(object, serializer)
    {
      json: object,
      status: :ok,
      serializer: serializer
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

  def method_missing(method_sym, *args, &block)
    if method_sym.to_s =~ /^(create|update|destroy|show)_(.*)_form$/
      send("#{Regexp.last_match(1)}_form", *args, Regexp.last_match(2))
    else
      super
    end
  end

  def respond_to_missing?(method, *)
    super
  end
end
