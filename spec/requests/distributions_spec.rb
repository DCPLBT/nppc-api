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

RSpec.describe '/distributions', type: :request do
  let!(:user) { create(:user, role_ids: [2]) }
  let!(:unit) { create(:unit, user: user) }

  let(:region) { create(:region, user: user) }
  let(:region1) { create(:region, user: user) }
  let(:district) { create(:district, region: region, user: user) }
  let(:district1) { create(:district, region: region1, user: user) }
  let(:extension) { create(:extension, district: district, user: user) }
  let(:extension1) { create(:extension, district: district1, user: user) }
  let(:village) { create(:village, extension: extension, user: user) }
  let(:village1) { create(:village, extension: extension1, user: user) }
  let(:company) { create(:company, user: user) }

  let(:user1) do
    create(:user, role_ids: [8], profile_attributes: {
             region: region, district: district, extension: extension, village: village
           })
  end
  let(:user2) do
    create(:user, role_ids: [8], profile_attributes: {
             region: region1, district: district1, extension: extension1, village: village1
           })
  end
  let(:ea) do
    create(:user, role_ids: [4], profile_attributes: { region: region, district: district, extension: extension })
  end
  let(:ea1) do
    create(:user, role_ids: [4], profile_attributes: { region: region1, district: district1, extension: extension1 })
  end
  let!(:company_user) do
    create(:user, role_ids: [6], profile_attributes: {
             company: company
           })
  end

  let!(:product_type) { create(:product_type, user: user) }
  let!(:product) { create(:product, product_type: product_type, user: user, unit: unit) }
  let!(:stock) do
    create(:stock, product_type: product_type, product: product, user: user, unit: unit, group: user.groups.first)
  end

  let!(:cart) { create(:cart, cartable: user, session_id: 2, category: :distribution) }
  let!(:line_item) do
    create(:line_item, product_type: product_type, product: product, unit: unit, stock: stock, itemable: cart)
  end

  before(:each) do
    sign_in(user)
  end

  # This should return the minimal set of attributes required to create a valid
  # Distribution. As you add validations to Distribution, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { region_id: region.id, district_id: district.id, extension_id: extension.id, user_id: user.id,
      distributed_type: 'ea', from_id: user.groups.first.id, to_id: ea.groups.first.id, line_items: [line_item] }
  end

  let(:invalid_attributes) do
    { distributed_type: nil }
  end

  describe 'GET /index' do
    let!(:stock1) do
      create(:stock, product: product, product_type: product_type, unit: unit, user: user, group: user.groups.first)
    end
    let!(:distribution1) do
      create(
        :distribution,
        user_id: user.id, from_id: user.groups.first.id, to_id: ea.groups.first.id,
        region: user1.region, district: user1.district, extension: user1.extension, distributed_type: 'ea',
        line_items_attributes: [
          { product_type: product_type, product: product, stock: stock1, quantity: 10, unit_id: unit.id }
        ]
      )
    end
    let!(:distribution2) do
      create(
        :distribution,
        draft: false, user_id: user.id, from_id: user.groups.first.id, to_id: ea.groups.first.id,
        region: user1.region, district: user1.district, extension: user1.extension, distributed_type: 'ea',
        line_items_attributes: [
          { product_type: product_type, product: product, stock: stock1, quantity: 10, unit_id: unit.id }
        ]
      )
    end
    let!(:distribution3) do
      create(
        :distribution,
        draft: false, user_id: user.id, from_id: user.groups.first.id, to_id: ea.groups.first.id,
        region: user1.region, district: user1.district, extension: user1.extension, distributed_type: 'ea',
        line_items_attributes: [
          { product_type: product_type, product: product, stock: stock1, quantity: 10, unit_id: unit.id }
        ]
      )
    end
    let!(:distribution4) do
      create(
        :distribution,
        draft: false, user_id: user.id, from_id: user.groups.first.id, to_id: ea1.groups.first.id,
        region: user2.region, district: user2.district, extension: user2.extension,
        distributed_type: 'ea',
        line_items_attributes: [
          { product_type: product_type, product: product, stock: stock1, quantity: 10, unit_id: unit.id }
        ]
      )
    end

    it 'renders a successful response' do
      get api_v1_distributions_url(category: :distribution), as: :json
      expect(response).to be_successful
    end

    it 'filter by tab - Individual' do
      get api_v1_distributions_url(category: :distribution, tab: 'individual'), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(0)
    end

    it 'filter by tab - Others' do
      get api_v1_distributions_url(category: :distribution, tab: 'others'), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(4)
    end

    it 'filter by distributor' do
      get api_v1_distributions_url(category: :distribution, distributed: true), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(4)
    end

    it 'filter by product type' do
      get api_v1_distributions_url(category: :distribution, product_type_id: product_type.id), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(4)
    end

    it 'filter by product' do
      get api_v1_distributions_url(category: :distribution, product_id: product.id), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(4)
    end

    it 'filter by region' do
      get api_v1_distributions_url(category: :distribution, region_id: user1.profile.region_id), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(3)
    end

    it 'filter by district' do
      get api_v1_distributions_url(category: :distribution, district_id: user1.profile.district_id), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(3)
    end

    it 'filter by extension' do
      get api_v1_distributions_url(category: :distribution, extension_id: user1.profile.extension_id), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(3)
    end

    it 'filter by year' do
      distribution4.update_columns(created_at: Date.new(2000))
      get api_v1_distributions_url(category: :distribution, year: '2000'), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(1)
    end

    it 'filter by received' do
      sign_out
      sign_in(ea)
      get api_v1_distributions_url(category: :distribution, received: true), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(3)
    end

    it 'filter by date range' do
      distribution4.update_columns(created_at: '2022-02-01')
      get api_v1_distributions_url(category: :distribution, from_date: '2022-02-01', to_date: '2022-02-01'), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(1)
    end

    it 'filter by distribution type' do
      distribution4.update_columns(distributed_type: 'individual')
      get api_v1_distributions_url(category: :distribution, distributed_type: 'individual'), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(1)
    end

    it 'Download excel' do
      get excel_download_api_v1_distributions_url, as: :json
      expect(response).to be_successful
    end

    it 'Download pdf' do
      get pdf_download_api_v1_distributions_url, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      distribution = Distribution.create! valid_attributes
      get api_v1_distribution_url(distribution, category: :distribution), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Distribution' do
        expect do
          post api_v1_distributions_url(category: :distribution),
               params: { distribution: valid_attributes }, as: :json
        end.to change(Distribution, :count).by(1)
      end

      it 'renders a JSON response with the new distribution' do
        valid_attributes[:distributed_type] = 'individual'
        post api_v1_distributions_url(category: :distribution),
             params: { distribution: valid_attributes.merge!(
               consumer_cid: user1.cid, village_id: user1.village_id
             ) }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end

      it 'distribute to company' do
        valid_attributes[:company_id] = company.id
        valid_attributes[:distributed_type] = 'mhv'
        post api_v1_distributions_url(category: :distribution),
             params: { distribution: valid_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end

      it 'validate stock' do
        valid_attributes[:distributed_type] = 'individual'
        cart.line_items.first.update_columns(quantity: 1001)
        post api_v1_distributions_url(category: :distribution),
             params: { distribution: valid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Distribution' do
        expect do
          post api_v1_distributions_url(category: :distribution),
               params: { distribution: invalid_attributes }, as: :json
        end.to change(Distribution, :count).by(0)
      end

      it 'renders a JSON response with errors for the new distribution' do
        post api_v1_distributions_url(category: :distribution),
             params: { distribution: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { state: :received, received_remark: 'Hello I have received the item' }
      end

      it 'upload receipt' do
        valid_attributes[:attachment_attributes] = { file: image }
        distribution = Distribution.create! valid_attributes
        patch api_v1_distribution_url(distribution, category: :distribution),
              params: { distribution: new_attributes }, as: :json
        distribution.reload
        expect(response).to have_http_status(:ok)
      end

      it 'updates the requested distribution' do
        distribution = Distribution.create! valid_attributes
        patch api_v1_distribution_url(distribution, category: :distribution),
              params: { distribution: new_attributes }, as: :json
        distribution.reload
        expect(response).to have_http_status(:ok)
      end

      it 'renders a JSON response with the distribution' do
        distribution = Distribution.create! valid_attributes
        patch api_v1_distribution_url(distribution, category: :distribution),
              params: { distribution: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the distribution' do
        distribution = Distribution.create! valid_attributes
        patch api_v1_distribution_url(distribution, category: :distribution),
              params: { distribution: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested distribution' do
      distribution = Distribution.create! valid_attributes
      expect do
        delete api_v1_distribution_url(distribution, category: :distribution), as: :json
      end.to change(Distribution, :count).by(-1)
    end
  end
end
