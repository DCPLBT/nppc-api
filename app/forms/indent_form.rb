# frozen_string_literal: true

class IndentForm < BaseForm
  attr_accessor :submitted

  def show
    indent
  end

  def create
    indent.indent_type = next_role_name
    indent.save.tap do |result|
      result && create_requester_forwarded_to
    end
  end

  def update # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity,Metrics/AbcSize
    indent.update(params).tap do |result|
      result && indent.accepted? && update_accepted_info
      result && indent.received? && update_received_info
      result && indent.forwarded? && update_forwarded_info
      result && indent.forwarded? && create_requester_forwarded_to
      result && !indent.draft? && determine_boolean(submitted) && create_requester_forwarded_to
    end
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
      user: current_user
    )
    Indent.new(params)
  end

  def create_requester_forwarded_to
    indent.update(
      requester_ids: (indent.requester_ids << from_id).uniq,
      forwarded_to_ids: (indent.forwarded_to_ids << to_id).uniq
    )
  end

  def update_accepted_info
    indent.update_columns(
      accepted_by_id: current_user.id,
      accepted_on: Time.current
    )
  end

  def update_forwarded_info
    indent.update_columns(
      forwarded_by_id: current_user.id,
      forwarded_on: Time.current
    )
  end

  def update_received_info
    indent.update_columns(
      received_by_id: current_user.id,
      received_on: Time.current
    )
  end
end
