# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dealerships requests', type: :request do
  let(:general_user) { create(:user, role: :general) }
  let(:admin_user) { create(:user, role: :admin) }
  let(:name_validation_message) { 'Name can&#39;t be blank' }

  describe 'GET /admin/dealerships' do
    let!(:dealerships) { create_list(:dealership, 3) }

    before do
      login_as(user)
      get admin_dealerships_path
    end

    context 'when user is admin' do
      let(:user) { admin_user }

      it 'successful respond and show dealerships', :aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(*dealerships.pluck(:name))
      end
    end

    context 'when user is general' do
      let(:user) { general_user }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end

  describe 'POST /admin/dealerships' do
    subject(:do_request) { post admin_dealerships_path, params: params }

    let(:params) do
      {
        dealership: {
          name: name
        }
      }
    end

    before { login_as(admin_user) }

    context 'when params are ok' do
      let(:name) { 'Lorem' }

      it 'creates a new dealership', :aggregate_failures do
        expect { do_request }.to change(Dealership, :count).by(1)
        expect(response).to redirect_to(admin_dealerships_path)
      end
    end

    context 'when missing dealership´s name' do
      let(:name) { '' }

      it 'display error message' do
        expect { do_request }.not_to change(Dealership, :count)
        expect(response.body).to include(name_validation_message)
      end
    end
  end

  describe 'PUT /admin/dealerships/:id' do
    subject(:do_request) do
      put admin_dealership_path(dealership_id), params: params
      dealership.reload
    end

    let!(:dealership) { create(:dealership, name: 'Lorem') }
    let(:name) { 'Ipsum' }
    let(:params) do
      {
        dealership: {
          name: name
        }
      }
    end

    before { login_as(admin_user) }

    context 'when dealership was not found' do
      let(:dealership_id) { dealership.id + 1 }

      it { expect { do_request }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'when dealership exists but name is blank' do
      let(:dealership_id) { dealership.id }
      let(:name) { '' }

      it 'do not update dealership', :aggregate_failures do
        expect { do_request }.not_to change(dealership, :name)
        expect(response.body).to include(name_validation_message)
      end
    end

    context 'when name is present and dealership exists' do
      let(:dealership_id) { dealership.id }

      it 'updates dealership name' do
        expect { do_request }.to change(dealership, :name).from('Lorem').to('Ipsum')
        expect(response).to redirect_to(admin_dealerships_path)
      end
    end
  end

  describe 'DELETE /admin/dealerships/:id' do
  end
end
