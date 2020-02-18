class RoleForm < BaseForm
  def create
    authorize(role, :create?)
    role.save
  end

  def update
    authorize(role, :update?)
    role.update(params)
  end

  def destroy
    authorize(role, :destroy?)
    role.destroy
  end

  def show
    role
  end

  private

  def role
    @role ||= id ? Role.find(id) : Role.new(params)
  end
end
