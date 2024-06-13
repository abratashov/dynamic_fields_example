# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Users::Update do
  subject(:service) { described_class.call(user:, params:) }

  let(:tenant) do
    create(:tenant, :with_struct_user_info, id: 'f989eaef-17f7-411f-8f00-212347bbe4c1',
                                            name: 'Douglass Murphy')
  end
  let(:user) { create(:user, id: '74ea0ce1-7cfe-451a-b953-df4cc750f037', tenant:) }

  before { user }

  describe 'with valid params' do
    let(:params) do
      {
        user_info: {
          data: {
            name: 'Jack',
            phone: 123_456_789,
            gender: 'male',
            languages: %w[uk en]
          }
        }
      }
    end

    context 'with data filling' do
      it 'fills user data' do
        expect { service }.to change { DynamicRecord.count }.by(1)
        expect(j2h(UserSerializer.new(service.user.reload).to_json)).to eq(
          {
            'id' => '74ea0ce1-7cfe-451a-b953-df4cc750f037',
            'user_info' =>
            { 'data' =>
              {
                'name' => 'Jack',
                'phone' => 123_456_789,
                'gender' => 'male',
                'languages' => %w[uk en]
              } },
            'tenant' => {
              'id' => 'f989eaef-17f7-411f-8f00-212347bbe4c1', 'name' => 'Douglass Murphy'
            }
          }
        )
      end
    end

    context 'with data updating' do
      let(:updated_params) do
        {
          user_info: {
            data: {
              name: 'Jane', phone: 1_000_000, gender: 'female', languages: ['en']
            }
          }
        }
      end

      before { service }

      it 'updates user data' do
        described_class.call(user:, params: updated_params)
        expect(j2h(UserSerializer.new(service.user.reload).to_json)).to eq(
          {
            'id' => '74ea0ce1-7cfe-451a-b953-df4cc750f037',
            'user_info' =>
            { 'data' =>
              {
                'name' => 'Jane',
                'phone' => 1_000_000,
                'gender' => 'female',
                'languages' => ['en']
              } },
            'tenant' => {
              'id' => 'f989eaef-17f7-411f-8f00-212347bbe4c1', 'name' => 'Douglass Murphy'
            }
          }
        )
      end
    end

    context 'with data merging' do
      let(:merging_params) do
        {
          user_info: {
            merge: true,
            data: {
              phone: 777_555_333, languages: %w[uk en ru]
            }
          }
        }
      end

      before { service }

      it 'updates user data' do
        described_class.call(user:, params: merging_params)
        expect(j2h(UserSerializer.new(service.user.reload).to_json)).to eq(
          {
            'id' => '74ea0ce1-7cfe-451a-b953-df4cc750f037',
            'user_info' =>
            { 'data' =>
              {
                'name' => 'Jack',
                'phone' => 777_555_333,
                'gender' => 'male',
                'languages' => %w[uk en ru]
              } },
            'tenant' => {
              'id' => 'f989eaef-17f7-411f-8f00-212347bbe4c1', 'name' => 'Douglass Murphy'
            }
          }
        )
      end
    end

    describe 'with invalid params' do
      let(:user) { nil }

      it 'returns an error' do
        expect(service.failure?).to be_truthy
        expect(service.error).to match('user is missing')
      end
    end
  end
end
