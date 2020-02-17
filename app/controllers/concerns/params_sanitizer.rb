module ParamsSanitizer
  def user_attributes
    [
      :id,
      :email,
      :phone,
      :username,
      :current_password,
      role_ids: [],
      profile_attributes: [
        :id,
        :first_name,
        :last_name,
        :gender,
        :salutation,
        photo_attributes: [
          :image
        ]
      ]
    ]
  end
end
