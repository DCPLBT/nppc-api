# frozen_string_literal: true

class IndentForm < BaseForm
  def show
    indent
  end

  def create
    indent.save
  end

  def update
    indent.update(params)
  end

  def destroy
    indent.destroy
  end

  private

  def indent
    @indent ||= id ? Indent.find(id) : Indent.new(params.merge(requester: current_user))
  end
end
