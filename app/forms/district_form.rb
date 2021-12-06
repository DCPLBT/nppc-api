# frozen_string_literal: true

class DistrictForm < BaseForm
  attr_accessor :district_id

  def show
    district
  end

  def create
    district.save
  end

  def update
    district.update(params)
  end

  def destroy
    district.destroy
  end

  private

  def district
    @district ||= if district_id
                    District.find(district_id)
                  else
                    parent.districts.build(params.merge(user_id: current_user.id))
                  end
  end
end
