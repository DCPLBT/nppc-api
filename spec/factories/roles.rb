# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :role do
    name { 'Admin' }
    trait :admin do
      name { 'Admin' }
    end
    trait :user do
      name { 'User' }
    end
  end
end
