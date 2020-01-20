module ResourceFinder
  def parent
    klass, param = parent_class
    klass&.find(params[param.to_sym])
  end

  private

  def parent_class
    params.each_key do |name|
      if name.match?(/(.+)_id$/)
        model = name.match(%r{([^\/.]*)_id$})
        return model[1].classify.constantize, name
      end
    end
    nil
  end
end
