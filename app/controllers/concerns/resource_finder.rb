# frozen_string_literal: true

module ResourceFinder # rubocop:disable Metrics/ModuleLength
  def parent
    return unless nested_route?

    klass, param = parent_class
    return if klass.nil?

    klass.find(params[param.to_sym])
  end

  def current_role
    @current_role ||= Role.find_by(id: params[:current_role_id]) || current_user.roles.first
  end

  def current_group
    @current_group ||= Group.find_by(group_attributes(current_role)) || current_user.groups.first
  end

  def current_role_name
    @current_role_name ||= current_role.name.delete(' ').underscore
  end

  def next_role
    role_name = case current_role_name
                when 'user'
                  'EA'
                when 'ea'
                  'DAO'
                else
                  'NPPC'
                end
    Role.find_by(name: role_name)
  end

  def to_role(role)
    role_name = case role
                when 'self', 'individual'
                  'User'
                when 'admin'
                  'Admin'
                else
                  role&.upcase
                end
    Role.find_by(name: role_name)
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

  def from_id
    attr = { region_id: current_user.region_id, district_id: current_user.district_id,
             extension_id: current_user.extension_id, village_id: current_user.village_id,
             company_id: current_user.company_id, individual_id: current_user.id }
    @from_id ||= Group.find_by(group_attributes(current_role, attr))&.id
  end

  # rubocop:disable Metrics/MethodLength,Metrics/CyclomaticComplexity,Metrics/AbcSize
  def group_attributes(
    role, attrs = {
      region_id: nil, district_id: nil, extension_id: nil, village_id: nil, company_id: nil, individual_id: nil
    }
  )
    attr = { role_id: role&.id }
    case role&.name
    when 'ADRC'
      attr.merge!(
        { region_id: attrs[:region_id] }
      )
    when 'MHV'
      attr.merge!(
        { company_id: attrs[:company_id] }
      )
    when 'DAO'
      attr.merge!(
        { region_id: attrs[:region_id], district_id: attrs[:district_id] }
      )
    when 'EA'
      attr.merge!(
        { region_id: attrs[:region_id], district_id: attrs[:district_id], extension_id: attrs[:extension_id] }
      )
    when 'ASSR'
      attr.merge!(
        {
          individual_id: attrs[:individual_id], region_id: attrs[:region_id], district_id: attrs[:district_id],
          extension_id: attrs[:extension_id]
        }
      )
    when 'User'
      attr.merge!(
        { individual_id: attrs[:individual_id] }
      )
    else
      attr
    end
  end

  # rubocop:enable Metrics/MethodLength,Metrics/CyclomaticComplexity,Metrics/AbcSize

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
