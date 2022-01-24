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

RSpec.describe '/stocks', type: :request do
  let(:user) { create(:admin) }
  let(:product_type) { create(:product_type, user: user) }
  let(:product_type1) { create(:product_type, user: user) }
  let(:unit) { create(:unit, user: user) }
  let(:product) { create(:product, user: user, product_type: product_type, unit: unit) }
  let(:product1) { create(:product, user: user, product_type: product_type, unit: unit) }
  let(:product2) { create(:product, user: user, product_type: product_type1, unit: unit) }
  let(:product3) { create(:product, user: user, product_type: product_type1, unit: unit) }
  before(:each) do
    sign_in(user)
  end
  # This should return the minimal set of attributes required to create a valid
  # Stock. As you add validations to Stock, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      product_type_id: product_type.id,
      product_id: product.id,
      quantity: 10,
      unit_price: 200,
      expiry_date: Time.now + 2.months,
      procured_on: Time.now,
      remark: Faker::Restaurant.review,
      user: user,
      unit_id: unit.id
    }
  end

  let(:invalid_attributes) do
    { quantity: nil }
  end

  describe 'GET /index' do
    let!(:setting) { create(:setting, category: :obsolete, user: user, meta: { period: 3 }) }
    let!(:stock) do
      create(:stock, product_type: product_type1, product: product2, unit: unit, user: user, user_ids: [user.id])
    end
    let!(:stock1) do
      create(:stock, product_type: product_type, product: product1, unit: unit, user: user, user_ids: [user.id])
    end
    let!(:stock2) do
      create(:stock, product_type: product_type, product: product, unit: unit, user: user, user_ids: [user.id])
    end
    let!(:stock3) do
      create(:stock, product_type: product_type, product: product, unit: unit, user: user, user_ids: [user.id])
    end

    it 'renders a successful response' do
      Stock.create! valid_attributes
      get api_v1_stocks_url, as: :json
      expect(response).to be_successful
    end

    it 'filter by product' do
      get api_v1_stocks_url(product_id: product.id), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(2)
    end

    it 'filter by product type' do
      get api_v1_stocks_url(product_type_id: product_type.id), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(3)
    end

    it 'search stock' do
      get api_v1_stocks_url(q: product_type1.name), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(1)
    end

    it 'Get obsolete stocks' do
      stock.update(obsolete_date: Time.current - (setting.meta['period'] + 2).days)
      get api_v1_stocks_url(obsolete: true), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(1)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      stock = Stock.create! valid_attributes
      get api_v1_stock_url(stock), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Stock' do
        expect do
          post api_v1_stocks_url,
               params: { stock: valid_attributes }, as: :json
        end.to change(Stock, :count).by(1)
      end

      it 'renders a JSON response with the new stock' do
        post api_v1_stocks_url,
             params: { stock: valid_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Stock' do
        expect do
          post api_v1_stocks_url,
               params: { stock: invalid_attributes }, as: :json
        end.to change(Stock, :count).by(0)
      end

      it 'renders a JSON response with errors for the new stock' do
        post api_v1_stocks_url,
             params: { stock: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { quantity: 10 }
      end

      it 'updates the requested stock' do
        stock = Stock.create! valid_attributes
        patch api_v1_stock_url(stock),
              params: { stock: new_attributes }, as: :json
        stock.reload
        expect(status).to eq(200)
      end

      it 'renders a JSON response with the stock' do
        stock = Stock.create! valid_attributes
        patch api_v1_stock_url(stock),
              params: { stock: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the stock' do
        stock = Stock.create! valid_attributes
        patch api_v1_stock_url(stock),
              params: { stock: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested stock' do
      stock = Stock.create! valid_attributes
      expect do
        delete api_v1_stock_url(stock), as: :json
      end.to change(Stock, :count).by(-1)
    end
  end
end
