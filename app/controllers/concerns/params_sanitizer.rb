module ParamsSanitizer
  def user_attributes
    [
      :id,
      :email,
      :phone,
      :username,
      :current_password,
      :active,
      { role_ids: [] }
    ]
  end
end
