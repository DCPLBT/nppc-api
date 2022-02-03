# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:agency) { create(:agency, user: create(:admin)) }
  let!(:designation) { create(:designation, user: create(:admin)) }
  let!(:employee_type) { create(:employee_type, user: create(:admin)) }
  let!(:user) do
    create(:user, profile_attributes: {
             agency: agency, employee_type: employee_type, designation: designation,
             photo_attributes: { image: image }
           })
  end
  let(:region) { create(:region, user: user) }
  let(:district) { create(:district, region: region, user: user) }
  let(:extension) { create(:extension, district: district, user: user) }
  let(:company) { create(:company, user: user) }

  let!(:user1) { create(:user, profile_attributes: { region: region }) }
  let!(:user2) { create(:user, profile_attributes: { region: region, district: district }) }
  let!(:user3) { create(:user, profile_attributes: { region: region, district: district, extension: extension }) }
  let!(:admin) { create(:admin) }

  context 'As a admin' do
    before(:each) do
      sign_in(admin)
    end

    it 'should see the list of users' do
      sign_out
      post user_session_url, params: { user: { login: 'dummy@dummy.com', password: 'dummy' } }
      expect(status).to eq(401)
    end

    it 'should see the list of users' do
      get api_v1_users_path
      expect(status).to eq(200)
      expect(json[:data].size).to eq(8)
    end

    it 'check others user' do
      get api_v1_user_path(user)
      expect(status).to eq(200)
      expect(json.dig(:data, :id).to_i).to eq(user.id)
    end

    it 'check his/her profile' do
      get profile_api_v1_users_path
      expect(status).to eq(200)
      expect(json.dig(:data, :id).to_i).to eq(admin.id)
    end

    it 'admin should be able to delete the user' do
      delete api_v1_user_path(user3)
      expect(status).to eq(200)
    end

    it 'filter user by roles' do
      get api_v1_users_path, params: { roles: [2] }
      expect(status).to eq(200)
    end

    it 'filter user by status' do
      get api_v1_users_path, params: { status: true }
      expect(status).to eq(200)
    end

    it 'should activate & deactivate user' do
      put api_v1_user_path(user), params: { user: { active: false } }
      expect(status).to eq(200)
      expect(json.dig(:data, :attributes, :active)).to eq(false)
    end

    it 'filter user by region' do
      get api_v1_users_path, params: { region_id: region.id }
      expect(status).to eq(200)
      expect(json[:data].size).to eq(3)
    end

    it 'filter user by district' do
      get api_v1_users_path, params: { district_id: district.id }
      expect(status).to eq(200)
      expect(json[:data].size).to eq(2)
    end

    it 'filter user by extension' do
      get api_v1_users_path, params: { extension_id: extension.id }
      expect(status).to eq(200)
      expect(json[:data].size).to eq(1)
    end
  end

  context 'As a normal user' do
    before(:each) do
      sign_in(user)
    end

    # it 'should not be able to see the list of user' do
    #   get api_v1_users_path, params: {}
    #   expect(status).to eq(403)
    #   expect(json[:errors]).to eq([I18n.t('pundit')])
    # end

    it 'should not permit to activate or deactivate user' do
      put api_v1_user_path(user1), params: { user: { active: false } }
      expect(status).to eq(403)
      expect(json[:errors]).to eq([I18n.t('pundit')])
    end

    it 'should not allow to see other user details' do
      get api_v1_user_path(user), params: {}
      expect(status).to eq(403)
      expect(json[:errors]).to eq([I18n.t('pundit')])
    end

    it 'should not allowed to delete other user' do
      delete api_v1_user_path(user), params: {}
      expect(status).to eq(403)
      expect(json[:errors]).to eq([I18n.t('pundit')])
    end
  end

  context 'Anonymous user' do
    it 'Unable to login' do
      admin.assign_attributes(email: Faker::Internet.email)
      sign_in(admin)
      expect(json[:error]).to eq(I18n.t('devise.failure.invalid', authentication_keys: 'Login'))
    end
  end
end
