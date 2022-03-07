# frozen_string_literal: true

class IndentForm < BaseForm
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
      from_id: from_id,
      to_id: to_id
    )
  end

  def update_accepted_indent
    indent.update_columns(
      accepted_by_id: current_user.id,
      accepted_on: Time.current
    )
  end
end
