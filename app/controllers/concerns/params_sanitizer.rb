# frozen_string_literal: true

module ParamsSanitizer
  def user_attributes # rubocop:disable Metrics/MethodLength
    [
      :id,
      :email,
      :phone,
      :username,
      :active,
      :password,
      :cid,
      { role_ids: [] },
      { profile_attributes: [
        :firstname,
        :lastname,
        :gender,
        :region_id,
        :district_id,
        :extension_id,
        :company_id,
        :employee_type_id,
        :employee_id,
        :designation_id,
        :agency_id,
        { photo_attributes: [:image] }
      ] }
    ]
  end
end
