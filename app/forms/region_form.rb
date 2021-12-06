# frozen_string_literal: true

class RegionForm < BaseForm
  def show
    region
  end

  def create
    region.save
  end

  def update
    region.update(params)
  end

  def destroy
    region.destroy
  end

  private

  def region
    @region ||= id ? Region.find(id) : current_user.regions.build(params)
  end
end
