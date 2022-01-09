# frozen_string_literal: true

module ResourceFinder
  def parent
    return unless nested_route?

    klass, param = parent_class
    klass.find(params[param.to_sym])
  end

  def current_role
    @current_role ||= Role.find_by(id: params[:current_role_id])
  end

  def current_role_name
    @current_role_name ||= (
      current_role.nil? ? current_user.roles.first.name : current_role&.name
    )&.delete(' ')&.underscore
  end

  def next_role_name
    case current_role_name
    when 'user'
      'ea'
    when 'ea'
      'dao'
    else
      'nppc'
    end
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

  def nested_route?
    request.url.split('v1/')[1].split('/').size >= 3
  end
end
