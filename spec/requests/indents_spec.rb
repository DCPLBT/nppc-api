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

RSpec.describe '/indents', type: :request do
  let(:user) { create(:user, role_ids: [8]) }
  let(:product_type) { create(:product_type, user: user) }
  let(:product) { create(:product, user: user, product_type: product_type) }
  let(:ea) { create(:user, role_ids: [4]) }
  before(:each) do
    sign_in(user)
  end
  # This should return the minimal set of attributes required to create a valid
  # Indent. As you add validations to Indent, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { product_type_id: product_type.id, product_id: product.id, requester: user, quantity: 120 }
  end

  let(:invalid_attributes) do
    { quantity: nil }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      create(:indent, product_type: product_type, product: product, requester: user, quantity: 10, draft: true)
      create(:indent, product_type: product_type, product: product, requester: user, quantity: 10)
      create(:indent, product_type: product_type, product: product, requester: user, quantity: 10, forwarded_to_id: ea)

      get api_v1_indents_url, as: :json
      expect(response).to be_successful
    end

    it 'filter by draft' do
      create(:indent, product_type: product_type, product: product, requester: user, quantity: 10, draft: true)
      create(:indent, product_type: product_type, product: product, requester: user, quantity: 10)
      create(:indent, product_type: product_type, product: product, requester: user, quantity: 10, forwarded_to_id: ea)

      get api_v1_indents_url(draft: true), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(1)
    end

    it 'filter by requested' do
      create(:indent, product_type: product_type, product: product, requester: user, quantity: 10, draft: true)
      create(:indent, product_type: product_type, product: product, requester: user, quantity: 10)
      create(:indent, product_type: product_type, product: product, requester: user, quantity: 10, forwarded_to_id: ea)

      get api_v1_indents_url(requested: true), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(3)
    end

    it 'filter by received' do
      create(:indent, product_type: product_type, product: product, requester: user, quantity: 10, draft: true)
      create(:indent, product_type: product_type, product: product, requester: user, quantity: 10)
      create(:indent, product_type: product_type, product: product, requester: user, quantity: 10,
                      forwarded_to_id: ea.id)
      sign_out
      sign_in(ea)
      get api_v1_indents_url(received: true), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(1)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      indent = Indent.create! valid_attributes
      get api_v1_indent_url(indent), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Indent' do
        expect do
          post api_v1_indents_url,
               params: { indent: valid_attributes }, as: :json
        end.to change(Indent, :count).by(1)
      end

      it 'renders a JSON response with the new indent' do
        post api_v1_indents_url,
             params: { indent: valid_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Indent' do
        expect do
          post api_v1_indents_url,
               params: { indent: invalid_attributes }, as: :json
        end.to change(Indent, :count).by(0)
      end

      it 'renders a JSON response with errors for the new indent' do
        post api_v1_indents_url,
             params: { indent: invalid_attributes }, as: :json
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

      it 'updates the requested indent' do
        indent = Indent.create! valid_attributes
        patch api_v1_indent_url(indent),
              params: { indent: new_attributes }, as: :json
        indent.reload
        expect(json.dig(:data, :attributes, :quantity)).to eq(new_attributes[:quantity])
      end

      it 'renders a JSON response with the indent' do
        indent = Indent.create! valid_attributes
        patch api_v1_indent_url(indent),
              params: { indent: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the indent' do
        indent = Indent.create! valid_attributes
        patch api_v1_indent_url(indent),
              params: { indent: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested indent' do
      indent = Indent.create! valid_attributes
      expect do
        delete api_v1_indent_url(indent), as: :json
      end.to change(Indent, :count).by(-1)
    end
  end
end