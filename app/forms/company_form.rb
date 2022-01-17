# frozen_string_literal: true

class CompanyForm < BaseForm
  def show
    company
  end

  def create
    company.save
  end

  def update
    company.update(params)
  end

  def destroy
    company.destroy
  end

  private

  def company
    @company ||= id ? Company.find(id) : Company.new(params.merge(user_id: current_user.id))
  end
end
