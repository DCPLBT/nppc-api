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
      region: current_user.region,
      district: current_user.district,
      extension: current_user.extension,
      company: current_user.company,
      user: current_user
    )
    Indent.new(params)
  end

  def create_requester_forwarded_to
    indent.update(
      forwarded_to_ids: destination_ids,
      requester_ids: source_ids
    )
  end
end
