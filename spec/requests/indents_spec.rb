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
  let(:admin) { create(:admin) }
  let(:region) { create(:region, user: admin) }
  let(:region1) { create(:region, user: admin) }
  let(:district) { create(:district, region: region, user: admin) }
  let(:district1) { create(:district, region: region1, user: admin) }
  let(:extension) { create(:extension, district: district, user: admin) }
  let(:extension1) { create(:extension, district: district1, user: admin) }
  let(:user) do
    create(:user, role_ids: [8], profile_attributes: { region: region, district: district, extension: extension })
  end
  let(:user1) do
    create(:user, role_ids: [8], profile_attributes: { region: region1, district: district1, extension: extension1 })
  end
  let(:unit) { create(:unit, user: user) }
  let(:product_type) { create(:product_type, user: user) }
  let(:product) { create(:product, user: user, product_type: product_type, unit: unit) }
  let(:ea) do
    create(:user, role_ids: [4], profile_attributes: { region: region, district: district, extension: extension })
  end
  let(:ea1) do
    create(:user, role_ids: [4], profile_attributes: { region: region1, district: district1, extension: extension1 })
  end
  before(:each) do
    sign_in(user)
  end
  # This should return the minimal set of attributes required to create a valid
  # Indent. As you add validations to Indent, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { draft: false, line_items_attributes: [
      { product_type_id: product_type.id, product_id: product.id, quantity: 120, unit_id: unit.id }
    ] }
  end

  let(:invalid_attributes) do
    { draft: nil }
  end

  describe 'GET /index' do
    let!(:indent1) do
      create(
        :indent, draft: true, requester_ids: [user.id], forwarded_to_ids: [ea.id],
                 region: user.region, district: user.district, extension: user.extension,
                 line_items_attributes: [
                   { product_type: product_type, product: product, quantity: 10, unit_id: unit.id }
                 ]
      )
    end
    let!(:indent2) do
      create(
        :indent, draft: false, requester_ids: [user.id], forwarded_to_ids: [ea.id],
                 region: user.region, district: user.district, extension: user.extension,
                 line_items_attributes: [
                   { product_type: product_type, product: product, quantity: 10, unit_id: unit.id }
                 ]
      )
    end
    let!(:indent3) do
      create(
        :indent, draft: false, requester_ids: [user.id], forwarded_to_ids: [ea.id],
                 region: user.region, district: user.district, extension: user.extension,
                 line_items_attributes: [
                   { product_type: product_type, product: product, quantity: 10, unit_id: unit.id }
                 ]
      )
    end
    let!(:indent4) do
      create(
        :indent, draft: false, requester_ids: [user1.id], forwarded_to_ids: [ea1.id],
                 region: user1.region, district: user1.district, extension: user1.extension,
                 line_items_attributes: [
                   { product_type: product_type, product: product, quantity: 10, unit_id: unit.id }
                 ]
      )
    end

    it 'renders a successful response' do
      get api_v1_indents_url, as: :json
      expect(response).to be_successful
    end

    it 'filter by draft' do
      get api_v1_indents_url(draft: true), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(1)
    end

    it 'filter by requested' do
      get api_v1_indents_url(requested: true), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(3)
    end

    it 'filter by product type' do
      get api_v1_indents_url(product_type_id: product_type.id), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(4)
    end

    it 'filter by product' do
      get api_v1_indents_url(product_id: product.id), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(4)
    end

    it 'filter by region' do
      get api_v1_indents_url(region_id: user.profile.region_id), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(3)
    end

    it 'filter by district' do
      get api_v1_indents_url(district_id: user1.profile.district_id), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(1)
    end

    it 'filter by extension' do
      get api_v1_indents_url(extension_id: user1.profile.extension_id), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(1)
    end

    it 'filter by year' do
      indent4.update_columns(created_at: Date.new(2000))
      get api_v1_indents_url(year: '2000'), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(1)
    end

    it 'filter by received' do
      sign_out
      sign_in(ea)
      get api_v1_indents_url(received: true), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(3)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      indent = Indent.create! valid_attributes
      get api_v1_indent_url(indent), as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /forward' do
    it 'renders a successful response' do
      indent = Indent.create! valid_attributes
      get forward_api_v1_indent_url(indent), as: :json
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
        { draft: false }
      end

      it 'updates the requested indent' do
        indent = Indent.create! valid_attributes
        patch api_v1_indent_url(indent),
              params: { indent: new_attributes }, as: :json
        indent.reload
        expect(json.dig(:data, :attributes, :draft)).to eq(new_attributes[:draft])
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
