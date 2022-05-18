# frozen_string_literal: true

class IndentMailer < ApplicationMailer
  def notify_indent_submission(indent)
    @indent = indent
    mail(to: indent.forwarded_tos.flat_map(&:users).pluck(:email))
  end
end
