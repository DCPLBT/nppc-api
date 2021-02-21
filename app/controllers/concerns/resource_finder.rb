# frozen_string_literal: true

module ResourceFinder
  def parent
    klass, param = parent_class
    klass&.find(params[param.to_sym])
  end

  private

  def parent_class
    result = nil
    params.each_key do |name|
      if name.match?(/(.+)_id$/)
        model = name.match(%r{([^/.]*)_id$})
        result = model[1].classify.constantize, name
      end
    end
    result
  end
end
