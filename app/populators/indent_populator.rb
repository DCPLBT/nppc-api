# frozen_string_literal: true

class IndentPopulator < BasePopulator
  attr_accessor :draft, :requested, :received

  def run
    indents
      .public_send(:search, q)
      .yield_self { |indents| filter_by_draft(indents) }
      .yield_self { |indents| filter_by_requested(indents) }
      .yield_self { |indents| filter_by_received(indents) }
  end

  private

  def indents
    @indents ||= Indent.includes(:requester, :forwarded_to)
  end

  def filter_by_draft(indents)
    return indents unless draft.present?

    indents.where(draft: determine_boolean(draft))
  end

  def filter_by_requested(indents)
    return indents unless requested.present? || determine_boolean(requested)

    indents.where(requester_id: current_user.id)
  end

  def filter_by_received(indents)
    return indents unless received.present? || determine_boolean(received)

    indents.where(forwarded_to_id: current_user.id)
  end
end
