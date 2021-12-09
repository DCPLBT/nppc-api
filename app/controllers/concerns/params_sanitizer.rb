# frozen_string_literal: true

module ParamsSanitizer
  def user_attributes # rubocop:disable Metrics/MethodLength
    [
      :id,
      :email,
      :phone,
      :username,
      :active,
      :cid,
      { role_ids: [] },
      { profile_attributes: [
        :firstname,
        :lastname,
        :gender,
        :region_id,
        :district_id,
        :extension_id,
        :employee_type,
        :employee_id,
        :designation,
        :agency,
        { photo_attributes: [:image] }
      ] }
    ]
  end
end
