# frozen_string_literal: true

class VillageForm < BaseForm
  attr_accessor :village_id

  def show
    village
  end

  def create
    village.save
  end

  def update
    village.update(params)
  end

  def destroy
    village.destroy
  end

  private

  def village
    @village ||= if village_id
                   Village.find(village_id)
                 else
                   parent.villages.build(params.merge(user_id: current_user.id))
                 end
  end
end
