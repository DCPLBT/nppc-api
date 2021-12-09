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

RSpec.describe '/product_types', type: :request do
  let(:user) { create(:admin) }
  before(:each) do
    sign_in(user)
  end
  # This should return the minimal set of attributes required to create a valid
  # ProductType. As you add validations to ProductType, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { name: Faker::Name.name, description: Faker::Restaurant.review, user: user }
  end

  let(:invalid_attributes) do
    { name: nil }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      ProductType.create! valid_attributes
      get api_v1_product_types_url, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      product_type = ProductType.create! valid_attributes
      get api_v1_product_type_url(product_type), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new ProductType' do
        expect do
          post api_v1_product_types_url,
               params: { product_type: valid_attributes }, as: :json
        end.to change(ProductType, :count).by(1)
      end

      it 'renders a JSON response with the new product_type' do
        post api_v1_product_types_url,
             params: { product_type: valid_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new ProductType' do
        expect do
          post api_v1_product_types_url,
               params: { product_type: invalid_attributes }, as: :json
        end.to change(ProductType, :count).by(0)
      end

      it 'renders a JSON response with errors for the new product_type' do
        post api_v1_product_types_url,
             params: { product_type: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { name: 'Hello product type' }
      end

      it 'updates the requested product_type' do
        product_type = ProductType.create! valid_attributes
        patch api_v1_product_type_url(product_type),
              params: { product_type: new_attributes }, as: :json
        product_type.reload
        expect(status).to eq(200)
        expect(json.dig(:data, :attributes, :name)).to eq(new_attributes[:name])
      end

      it 'renders a JSON response with the product_type' do
        product_type = ProductType.create! valid_attributes
        patch api_v1_product_type_url(product_type),
              params: { product_type: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the product_type' do
        product_type = ProductType.create! valid_attributes
        patch api_v1_product_type_url(product_type),
              params: { product_type: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested product_type' do
      product_type = ProductType.create! valid_attributes
      expect do
        delete api_v1_product_type_url(product_type), as: :json
      end.to change(ProductType, :count).by(-1)
    end
  end
end