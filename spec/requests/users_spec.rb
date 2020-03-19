require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user) }
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:admin) { create(:admin) }

  context 'As a admin' do
    let!(:token) { user_token(admin) }

    it 'should see the list of users' do
      get api_v1_users_path, params: {}, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:users).count).to eq(4)
    end

    it 'should activate & deactivate user' do
      put api_v1_user_path(user), params: { user: { active: false } }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:user, :active)).to eq(false)
    end
  end

  context 'As a normal user' do
    let!(:token) { user_token(user) }

    it 'should not be able to see the list of user' do
      get api_v1_users_path, params: {}, headers: header_params(token: token)
      expect(status).to eq(403)
      expect(json.dig(:errors)).to eq([I18n.t('pundit')])
    end

    it 'should not permit to activate or deactivate user' do
      put api_v1_user_path(user), params: { user: { active: false } }, headers: header_params(token: token)
      expect(status).to eq(403)
      expect(json.dig(:errors)).to eq([I18n.t('pundit')])
    end

    it 'should not allow to see other user details' do
      get api_v1_user_path(user), params: {}, headers: header_params(token: token)
      expect(status).to eq(403)
      expect(json.dig(:errors)).to eq([I18n.t('pundit')])
    end

    it 'should not allowed to delete other user' do
      delete api_v1_user_path(user), params: {}, headers: header_params(token: token)
      expect(status).to eq(403)
      expect(json.dig(:errors)).to eq([I18n.t('pundit')])
    end
  end
end
