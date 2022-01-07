# frozen_string_literal: true

class IndentForm < BaseForm
  def show
    indent
  end

  def create
    indent.save.tap do |result|
      result && create_requester_forwarded_to
    end
  end

  def update
    indent.update(params)
  end

  def destroy
    indent.destroy
  end

  private

  def indent
    @indent ||= id ? Indent.find(id) : build_indent
  end

  def build_indent
    params.merge!(
      region: current_user.region,
      district: current_user.district,
      extension: current_user.extension
    )
    Indent.new(params)
  end

  def create_requester_forwarded_to # rubocop:disable Metrics/AbcSize
    indent.update(
      forwarded_to_ids: User.similar_users(
        next_role_name, current_user.region_id, current_user.district_id, current_user.extension_id
      ).pluck(:id),
      requester_ids: User.similar_users(
        current_role_name, current_user.region_id, current_user.district_id, current_user.extension_id
      ).pluck(:id)
    )
  end
end
