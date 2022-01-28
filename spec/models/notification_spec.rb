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
require 'rails_helper'

RSpec.describe Notification, type: :model do
  context 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :text }
    it { should validate_presence_of :recipients }
  end
end
