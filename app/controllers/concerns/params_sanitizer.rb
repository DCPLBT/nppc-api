# frozen_string_literal: true

module ParamsSanitizer
  def user_attributes # rubocop:disable Metrics/MethodLength
    [
      :id,
      :email,
      :phone,
      :username,
      :current_password,
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
        { photo_attributes: [:image] }
      ] }
    ]
  end
end
