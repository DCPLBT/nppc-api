# frozen_string_literal: true

class UserForm < BaseForm
  def show
    user
  end

  def update
    user.update(params)
  end

  def destroy
    user.destroy
  end

  private

  def user
    @user ||= User.includes(
      :roles
    ).find(id)
  end
end
