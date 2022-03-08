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

RSpec.describe '/carts', type: :request do
  let!(:user) { create(:user, role_ids: [2]) }
  let!(:unit) { create(:unit, user: user) }
  let!(:product_type) { create(:product_type, user: user) }
  let!(:product) { create(:product, product_type: product_type, user: user, unit: unit) }
  let!(:stock) { create(:stock, product_type: product_type, product: product, user: user, unit: unit) }
  let!(:cart) { create(:cart, cartable: user, session_id: 2, category: :distribution) }
  let!(:line_items) do
    create(
      :line_item,
      product_type: product_type, product: product, unit: unit, stock: stock, itemable: cart, quantity: 10
    )
  end
  before(:each) do
    sign_in(user)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_v1_carts_url(category: :distribution), as: :json
      expect(response).to be_successful
    end

    it 'merge similar product' do
      data = {
        line_item: {
          product_type_id: product_type.id, product_id: product.id, stock_id: stock.id, unit_id: unit.id, quantity: 10
        }
      }
      post api_v1_cart_line_items_url(cart), params: data, as: :json
      expect(status).to eq(200)
      expect(json.dig(:data, :attributes, :quantity)).to eq(20)
      post api_v1_cart_line_items_url(cart), params: data, as: :json
      expect(status).to eq(200)
      expect(json.dig(:data, :attributes, :quantity)).to eq(30)
      data[:line_item][:quantity] = stock.quantity + 10
      post api_v1_cart_line_items_url(cart), params: data, as: :json
      expect(status).to eq(422)
      expect(
        json[:errors]
      ).to match_array(["#{product.name} has insufficient stock. Available stock is #{stock.quantity}."])
    end
  end
end
