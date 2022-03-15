# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reports', type: :request do
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

  let!(:cart) { create(:cart, cartable: user, session_id: 2, cart_user_ids: [user.id], category: :distribution) }
  let!(:line_item) do
    create(:line_item, product_type: product_type, product: product, unit: unit, stock: stock, itemable: cart)
  end

  before(:each) do
    sign_in(user)
  end

  describe 'GET /index' do
    let!(:stock1) { create(:stock, product: product, product_type: product_type, unit: unit, user: user) }
    let!(:distribution1) do
      create(
        :distribution, user_id: user.id, distributor_ids: [user.id], distributed_to_ids: [ea.id],
                       region: user.region, district: user.district, extension: user.extension, distributed_type: 'ea',
                       line_items_attributes: [
                         { product_type: product_type, product: product, stock: stock1, quantity: 10, unit_id: unit.id }
                       ]
      )
    end
    let!(:distribution2) do
      create(
        :distribution, draft: false, user_id: user.id, distributor_ids: [user.id], distributed_to_ids: [ea.id],
                       region: user.region, district: user.district, extension: user.extension, distributed_type: 'ea',
                       line_items_attributes: [
                         { product_type: product_type, product: product, stock: stock1, quantity: 10, unit_id: unit.id }
                       ]
      )
    end
    let!(:distribution3) do
      create(
        :distribution, draft: false, user_id: user.id, distributor_ids: [user.id], distributed_to_ids: [ea.id],
                       region: user.region, district: user.district, extension: user.extension, distributed_type: 'ea',
                       line_items_attributes: [
                         { product_type: product_type, product: product, stock: stock1, quantity: 10, unit_id: unit.id }
                       ]
      )
    end
    let!(:distribution4) do
      create(
        :distribution, draft: false, user_id: user.id, distributor_ids: [user.id], distributed_to_ids: [ea1.id],
                       region: user1.region, district: user1.district, extension: user1.extension,
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

    it 'filter by date range' do
      distribution4.update_columns(created_at: '2022-02-01')
      get api_v1_distributions_url(category: :distribution, from_date: '2022-02-01', to_date: '2022-02-01'), as: :json
      expect(response).to be_successful
      expect(json[:data].size).to eq(1)
    end
  end
end
