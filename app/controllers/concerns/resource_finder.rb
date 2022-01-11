# frozen_string_literal: true

module ResourceFinder
  def parent
    return unless nested_route?

    klass, param = parent_class
    return if klass.nil?

    klass.find(params[param.to_sym])
  end

  def current_role
    @current_role ||= Role.find_by(id: params[:current_role_id]) || current_user.roles.first
  end

  def current_role_name
    @current_role_name ||= current_role.name.delete(' ').underscore
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

  def forwarded_to_ids
    region_id, district_id, extension_id = extract_ids(next_role_name)
    @forwarded_to_ids ||= User.similar_users(
      next_role_name, region_id, district_id, extension_id
    ).pluck(:id)
  end

  def requester_ids
    region_id, district_id, extension_id = extract_ids(current_role_name)
    @requester_ids ||= User.similar_users(
      current_role_name, region_id, district_id, extension_id
    ).pluck(:id)
  end

  def extract_ids(role_name)
    case role_name
    when 'ea', 'user'
      [current_user.region_id, current_user.district_id, current_user.extension_id]
    when 'dao'
      [current_user.region_id, current_user.district_id]
    when 'adrc'
      [current_user.region_id]
    else
      []
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
