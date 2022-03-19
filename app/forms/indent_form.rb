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

  def update
    indent.update(params).tap do |result|
      result && indent.accepted? && update_accepted_indent
      result && determine_boolean(submitted) && create_requester_forwarded_to
    end
  end

  def forward
    create_requester_forwarded_to
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

  def update_accepted_indent
    indent.update_columns(
      accepted_by_id: current_user.id,
      accepted_on: Time.current
    )
  end
end
