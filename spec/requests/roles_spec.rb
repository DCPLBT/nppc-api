# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Roles', type: :request do
  let!(:user) { create(:admin) }

  before(:each) do
    user_token(user)
  end

  describe 'GET /roles' do
    it 'Get list of roles' do
      get api_v1_roles_path
      expect(response).to have_http_status(200)
      expect(json[:data].size).to eq(3)
      expect(json[:data].pluck(:attributes).pluck(:name)).to eq(Role.pluck(:name))
    end
  end

  describe 'GET /roles/:id' do
    it 'Fetch role details' do
      get api_v1_role_path(Role.first)
      expect(response).to have_http_status(200)
      expect(json.dig(:data, :id)&.to_i).to eq(Role.first.id)
      expect(json.dig(:data, :attributes, :name)).to eq(Role.first.name)
    end
  end

  describe 'DELETE /roles/:id' do
    let!(:role) { create(:role, name: 'Cook') }

    it 'Delete role' do
      delete api_v1_role_path(role)
      expect(response).to have_http_status(200)
    end

    it 'Should not delete reserved role like admin' do
      delete api_v1_role_path(Role.first)
      expect(response).to have_http_status(422)
      expect(
        json.dig(:errors, 0)
      ).to eq("Name #{I18n.t('activerecord.errors.models.role.name_is_reserved', name: Role.first.name)}")
    end
  end

  describe 'POST /roles' do
    let!(:data) do
      {
        role: {
          name: Faker::Name.first_name
        }
      }
    end

    it 'Create roles' do
      post api_v1_roles_path, params: data
      expect(response).to have_http_status(200)
      expect(json.dig(:data, :attributes, :name)).to eq(data[:role][:name])
    end

    it 'Role name should be unique' do
      data[:role][:name] = 'Admin'
      post api_v1_roles_path, params: data
      expect(response).to have_http_status(422)
      expect(json.dig(:errors, 0)).to eq("Name #{I18n.t('errors.messages.taken')}")
    end
  end

  describe 'PUT /roles/:id' do
    let!(:role) { create(:role, name: Faker::Name.first_name) }
    let!(:data) do
      {
        role: {
          name: Faker::Name.first_name
        }
      }
    end

    it 'Update books' do
      put api_v1_role_path(role), params: data
      expect(response).to have_http_status(200)
      expect(json.dig(:data, :attributes, :name)).to eq(data[:role][:name])
      expect(json.dig(:data, :id).to_i).to eq(role.id)
    end

    it 'Do not allow system reserved role' do
      role = Role.find(1)
      put api_v1_role_path(role), params: data
      expect(response).to have_http_status(422)
      expect(
        json.dig(:errors, 0)
      ).to eq("Name #{I18n.t('activerecord.errors.models.role.name_is_reserved', name: role.name)}")
    end
  end
end
