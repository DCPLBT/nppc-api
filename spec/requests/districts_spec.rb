# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/districts', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # District. As you add validations to District, be sure to
  # adjust the attributes here as well.
  let(:user) { create(:admin) }
  before(:each) do
    sign_in(user)
  end
  let(:region) { create(:region, user: user) }

  let(:valid_attributes) do
    { name: Faker::Name.name, description: Faker::Restaurant.review, user_id: user.id }
  end

  let(:invalid_attributes) do
    { name: nil, description: 'Hello' }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      District.create! valid_attributes
      get api_v1_region_districts_url(region), as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      district = District.create! valid_attributes
      get api_v1_district_url(district), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new District' do
        expect do
          post api_v1_region_districts_url(region),
               params: { district: valid_attributes }, as: :json
        end.to change(District, :count).by(1)
      end

      it 'renders a JSON response with the new district' do
        post api_v1_region_districts_url(region),
             params: { district: valid_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new District' do
        expect do
          post api_v1_region_districts_url(region),
               params: { district: invalid_attributes }, as: :json
        end.to change(District, :count).by(0)
      end

      it 'renders a JSON response with errors for the new district' do
        post api_v1_region_districts_url(region),
             params: { district: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { name: 'Thimphu', description: 'Thimphu district' }
      end

      it 'updates the requested district' do
        district = District.create! valid_attributes
        patch api_v1_district_url(district),
              params: { district: new_attributes }, as: :json
        district.reload
        expect(status).to eq(200)
      end

      it 'renders a JSON response with the district' do
        district = District.create! valid_attributes
        patch api_v1_district_url(district),
              params: { district: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the district' do
        district = District.create! valid_attributes
        patch api_v1_district_url(district),
              params: { district: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested district' do
      district = District.create! valid_attributes
      expect do
        delete api_v1_district_url(district), as: :json
      end.to change(District, :count).by(-1)
    end
  end
end
