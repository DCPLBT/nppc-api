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

RSpec.describe '/line_items', type: :request do
  let(:user) { create(:admin) }
  let(:unit) { create(:unit, user: user) }
  let(:product_type) { create(:product_type, user: user) }
  let(:product) { create(:product, user: user, product_type: product_type, unit: unit) }
  let(:indent) { create(:indent, user: user) }
  before(:each) do
    sign_in(user)
  end
  # This should return the minimal set of attributes required to create a valid
  # line_item. As you add validations to line_item, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { product_type_id: product_type.id, product_id: product.id, quantity: 10, unit_id: unit.id, itemable: indent }
  end

  let(:invalid_attributes) do
    { quantity: nil }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      LineItem.create! valid_attributes
      get api_v1_indent_line_items_url(indent), as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      line_item = LineItem.create! valid_attributes
      get api_v1_line_item_url(line_item), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new line_item' do
        expect do
          post api_v1_indent_line_items_url(indent),
               params: { line_item: valid_attributes }, as: :json
        end.to change(LineItem, :count).by(1)
      end

      it 'renders a JSON response with the new line_item' do
        post api_v1_indent_line_items_url(indent),
             params: { line_item: valid_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new line_item' do
        expect do
          post api_v1_indent_line_items_url(indent),
               params: { line_item: invalid_attributes }, as: :json
        end.to change(LineItem, :count).by(0)
      end

      it 'renders a JSON response with errors for the new line_item' do
        post api_v1_indent_line_items_url(indent),
             params: { line_item: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { quantity: 100 }
      end

      it 'updates the requested line_item' do
        line_item = LineItem.create! valid_attributes
        patch api_v1_line_item_url(line_item),
              params: { line_item: new_attributes }, as: :json
        line_item.reload
        expect(status).to eq(200)
        expect(json.dig(:data, :attributes, :quantity)).to eq(new_attributes[:quantity])
      end

      it 'renders a JSON response with the line_item' do
        line_item = LineItem.create! valid_attributes
        patch api_v1_line_item_url(line_item),
              params: { line_item: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the line_item' do
        line_item = LineItem.create! valid_attributes
        patch api_v1_line_item_url(line_item),
              params: { line_item: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested line_item' do
      line_item = LineItem.create! valid_attributes
      expect do
        delete api_v1_line_item_url(line_item), as: :json
      end.to change(LineItem, :count).by(-1)
    end
  end
end
