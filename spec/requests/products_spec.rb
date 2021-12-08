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

RSpec.describe '/products', type: :request do
  let(:user) { create(:admin) }
  let(:product_type) { create(:product_type, user: user) }
  before(:each) do
    sign_in(user)
  end
  # This should return the minimal set of attributes required to create a valid
  # Product. As you add validations to Product, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { name: Faker::Book.name, description: Faker::Restaurant.review, user: user, product_type: product_type }
  end

  let(:invalid_attributes) do
    { name: nil }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Product.create! valid_attributes
      get api_v1_products_url, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      product = Product.create! valid_attributes
      get api_v1_product_url(product), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Product' do
        expect do
          post api_v1_product_type_products_url(product_type),
               params: { product: valid_attributes }, as: :json
        end.to change(Product, :count).by(1)
      end

      it 'renders a JSON response with the new product' do
        post api_v1_product_type_products_url(product_type),
             params: { product: valid_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Product' do
        expect do
          post api_v1_product_type_products_url(product_type),
               params: { product: invalid_attributes }, as: :json
        end.to change(Product, :count).by(0)
      end

      it 'renders a JSON response with errors for the new product' do
        post api_v1_product_type_products_url(product_type),
             params: { product: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { name: 'Hello product' }
      end

      it 'updates the requested product' do
        product = Product.create! valid_attributes
        patch api_v1_product_url(product),
              params: { product: new_attributes }, as: :json
        product.reload
        expect(status).to eq(200)
        expect(json.dig(:data, :attributes, :name)).to eq(new_attributes[:name])
      end

      it 'renders a JSON response with the product' do
        product = Product.create! valid_attributes
        patch api_v1_product_url(product),
              params: { product: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the product' do
        product = Product.create! valid_attributes
        patch api_v1_product_url(product),
              params: { product: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested product' do
      product = Product.create! valid_attributes
      expect do
        delete api_v1_product_url(product), as: :json
      end.to change(Product, :count).by(-1)
    end
  end
end
