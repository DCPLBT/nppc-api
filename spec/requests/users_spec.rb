# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:admin) { create(:admin) }
  let!(:employee_type) { create(:employee_type, user: admin, role: Role.last) }
  let!(:agency) { create(:agency, user: admin, employee_type: employee_type) }
  let!(:designation) { create(:designation, user: admin, agency: agency) }
  let!(:region) { create(:region, user: admin) }
  let!(:district) { create(:district, region: region, user: admin) }
  let!(:extension) { create(:extension, district: district, user: admin) }
  let!(:village) { create(:village, extension: extension, user: admin) }
  let!(:company) { create(:company, user: admin) }

  let!(:user) do
    create(:user, profile_attributes: {
             name: Faker::Name.name, agency: agency, employee_type: employee_type, designation: designation,
             region: region, district: district, extension: extension, village: village,
             photo_attributes: { image: image }
           })
  end
  let!(:user1) { create(:user, role_ids: [5], profile_attributes: { name: Faker::Name.name, region: region }) }
  let!(:user2) do
    create(:user, role_ids: [3], profile_attributes: { name: Faker::Name.name, region: region, district: district })
  end
  let!(:user3) do
    create(
      :user, role_ids: [4],
             profile_attributes: {
               name: Faker::Name.name, region: region, district: district, extension: extension
             }
    )
  end

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
      expect(json[:data].size).to eq(5)
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
      expect(json[:data].size).to eq(4)
    end

    it 'filter user by district' do
      get api_v1_users_path, params: { district_id: district.id }
      expect(status).to eq(200)
      expect(json[:data].size).to eq(3)
    end

    it 'filter user by extension' do
      get api_v1_users_path, params: { extension_id: extension.id }
      expect(status).to eq(200)
      expect(json[:data].size).to eq(2)
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
