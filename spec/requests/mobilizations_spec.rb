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

RSpec.describe '/mobilizations', type: :request do
  let!(:user) { create(:user, role_ids: [2]) }
  let!(:unit) { create(:unit, user: user) }

  let(:region) { create(:region, user: user) }
  let(:region1) { create(:region, user: user) }
  let(:district) { create(:district, region: region, user: user) }
  let(:district1) { create(:district, region: region1, user: user) }
  let(:extension) { create(:extension, district: district, user: user) }
  let(:extension1) { create(:extension, district: district1, user: user) }
  let(:company) { create(:company, user: user) }

  let(:user1) do
    create(:user, role_ids: [8], profile_attributes: { region: region, district: district, extension: extension })
  end
  let(:ea) do
    create(:user, role_ids: [4], profile_attributes: { region: region, district: district, extension: extension })
  end
  let(:ea1) do
    create(:user, role_ids: [4], profile_attributes: { region: region1, district: district1, extension: extension1 })
  end
  let!(:company_user) do
    create(:user, role_ids: [6], profile_attributes: {
             region: region1, district: district1, extension: extension1, company: company
           })
  end

  let!(:product_type) { create(:product_type, user: user) }
  let!(:product) { create(:product, product_type: product_type, user: user, unit: unit) }
  let!(:stock) { create(:stock, product_type: product_type, product: product, user: user, unit: unit) }

  let!(:cart) { create(:cart, cartable: user, session_id: 2, cart_user_ids: [user.id], category: :mobilization) }
  let!(:line_item) do
    create(:line_item, product_type: product_type, product: product, unit: unit, stock: stock, itemable: cart)
  end

  before(:each) do
    sign_in(user)
  end

  # This should return the minimal set of attributes required to create a valid
  # Mobilization. As you add validations to Mobilization, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { region_id: region.id, district_id: district.id, extension_id: extension.id, user_id: user.id,
      category: 'ea', line_items: [line_item] }
  end

  let(:invalid_attributes) do
    { category: nil }
  end

  describe 'GET /index' do
    let!(:stock1) { create(:stock, product: product, product_type: product_type, unit: unit, user: user) }
    let!(:mobilization1) do
      create(
        :mobilization, user_id: user.id, mobilizer_ids: [user.id], mobilized_to_ids: [ea.id],
                       region: user.region, district: user.district, extension: user.extension, category: 'ea',
                       line_items_attributes: [
                         { product_type: product_type, product: product, stock: stock1, quantity: 10, unit_id: unit.id }
                       ]
      )
    end
    let!(:mobilization2) do
      create(
        :mobilization, user_id: user.id, mobilizer_ids: [user.id], mobilized_to_ids: [ea.id],
                       region: user.region, district: user.district, extension: user.extension, category: 'ea',
                       line_items_attributes: [
                         { product_type: product_type, product: product, stock: stock1, quantity: 10, unit_id: unit.id }
                       ]
      )
    end
    let!(:mobilization3) do
      create(
        :mobilization, user_id: user.id, mobilizer_ids: [user.id], mobilized_to_ids: [ea.id],
                       region: user.region, district: user.district, extension: user.extension, category: 'ea',
                       line_items_attributes: [
                         { product_type: product_type, product: product, stock: stock1, quantity: 10, unit_id: unit.id }
                       ]
      )
    end
    let!(:mobilization4) do
      create(
        :mobilization, user_id: user.id, mobilizer_ids: [user.id], mobilized_to_ids: [ea1.id],
                       region: user1.region, district: user1.district, extension: user1.extension,
                       category: 'ea',
                       line_items_attributes: [
                         { product_type: product_type, product: product, stock: stock1, quantity: 10, unit_id: unit.id }
                       ]
      )
    end

    it 'renders a successful response' do
      get api_v1_mobilizations_url(category: :mobilization), as: :json
      expect(response).to be_successful
    end

    it 'filter by distributor' do
      get api_v1_mobilizations_url(category: :mobilization, distributed: true), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(4)
    end

    it 'filter by product type' do
      get api_v1_mobilizations_url(category: :mobilization, product_type_id: product_type.id), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(4)
    end

    it 'filter by product' do
      get api_v1_mobilizations_url(category: :mobilization, product_id: product.id), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(4)
    end

    it 'filter by region' do
      get api_v1_mobilizations_url(category: :mobilization, region_id: user1.profile.region_id), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(1)
    end

    it 'filter by district' do
      get api_v1_mobilizations_url(category: :mobilization, district_id: user1.profile.district_id), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(1)
    end

    it 'filter by extension' do
      get api_v1_mobilizations_url(category: :mobilization, extension_id: user1.profile.extension_id), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(1)
    end

    it 'filter by year' do
      mobilization4.update_columns(created_at: Date.new(2000))
      get api_v1_mobilizations_url(category: :mobilization, year: '2000'), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(1)
    end

    it 'filter by received' do
      sign_out
      sign_in(ea)
      get api_v1_mobilizations_url(category: :mobilization, received: true), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(3)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      mobilization = Mobilization.create! valid_attributes
      get api_v1_mobilization_url(mobilization, category: :mobilization), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Mobilization' do
        expect do
          post api_v1_mobilizations_url(category: :mobilization),
               params: { mobilization: valid_attributes }, as: :json
        end.to change(Mobilization, :count).by(1)
      end

      it 'renders a JSON response with the new mobilization' do
        valid_attributes[:category] = 'ea'
        post api_v1_mobilizations_url(category: :mobilization),
             params: { mobilization: valid_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end

      it 'distribute to company' do
        valid_attributes[:company_id] = company.id
        valid_attributes[:category] = 'mhv'
        post api_v1_mobilizations_url(category: :mobilization),
             params: { mobilization: valid_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))

        sign_out
        sign_in(company_user)
        get api_v1_mobilizations_url(category: :mobilization, received: true), as: :json
        expect(status).to eq(200)
        expect(json[:data].size).to eq(1)

        put api_v1_mobilization_url(Mobilization.first, category: :mobilization),
            params: { mobilization: { state: :received } }, as: :json
        expect(status).to eq(200)
        expect(company_user.stocks.size).to eq(1)
      end

      it 'validate stock' do
        valid_attributes[:category] = 'ea'
        cart.line_items.first.update(quantity: 1001)
        post api_v1_mobilizations_url(category: :mobilization),
             params: { mobilization: valid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'validate approved by' do
        sign_out
        sign_in(ea)
        valid_attributes[:state] = :approved
        valid_attributes[:approved_by_id] = ea.id
        post api_v1_mobilizations_url(category: :mobilization),
             params: { mobilization: valid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Mobilization' do
        expect do
          post api_v1_mobilizations_url(category: :mobilization),
               params: { mobilization: invalid_attributes }, as: :json
        end.to change(Mobilization, :count).by(0)
      end

      it 'renders a JSON response with errors for the new mobilization' do
        post api_v1_mobilizations_url(category: :mobilization),
             params: { mobilization: invalid_attributes }, as: :json
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
        mobilization = Mobilization.create! valid_attributes
        patch api_v1_mobilization_url(mobilization, category: :mobilization),
              params: { mobilization: new_attributes }, as: :json
        mobilization.reload
        expect(response).to have_http_status(:ok)
      end

      it 'updates the requested mobilization' do
        mobilization = Mobilization.create! valid_attributes
        patch api_v1_mobilization_url(mobilization, category: :mobilization),
              params: { mobilization: new_attributes }, as: :json
        mobilization.reload
        expect(response).to have_http_status(:ok)
      end

      it 'renders a JSON response with the mobilization' do
        mobilization = Mobilization.create! valid_attributes
        patch api_v1_mobilization_url(mobilization, category: :mobilization),
              params: { mobilization: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the mobilization' do
        mobilization = Mobilization.create! valid_attributes
        patch api_v1_mobilization_url(mobilization, category: :mobilization),
              params: { mobilization: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested mobilization' do
      mobilization = Mobilization.create! valid_attributes
      expect do
        delete api_v1_mobilization_url(mobilization, category: :mobilization), as: :json
      end.to change(Mobilization, :count).by(-1)
    end
  end
end
