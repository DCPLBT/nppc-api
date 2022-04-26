# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  title      :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class NotificationSerializer < ApplicationSerializer
  attributes :title, :url, :created_at

  attribute :text do |object|
    object.text&.to_plain_text
  end

  attribute :read do |obj, params|
    obj.recipients.select { |x| x.user_id == params[:current_user].id }.first&.read
  end

  attribute :read_at do |obj, params|
    obj.recipients.select { |x| x.user_id == params[:current_user].id }.first&.read_at
  end
end
