# frozen_string_literal: true

require './lib/dynamic_fields'

RSpec.describe DynamicFields do
  let(:tenant) { create(:tenant) }
  let(:user) { create(:user, tenant:) }

  let(:struct) do
    {
      'name': 'string',
      'phone': 'integer',
      'gender': { single_field: %w[male female no_info] },
      'languages': { multiple_fields: %w[uk ru en] }
    }
  end

  context 'when valid with symbols' do
    subject(:fields) { described_class.new(struct, data) }

    let(:data) do
      {
        name: 'Jack',
        phone: 123_456_789,
        gender: 'male',
        languages: %w[uk en]
      }
    end

    it { expect(fields).to be_valid }
  end

  context 'when valid with strings' do
    subject(:fields) { described_class.new(struct, data) }

    let(:data) do
      {
        'name': 'Jack',
        'phone': 123_456_789,
        'gender': 'male',
        'languages': %w[uk en]
      }
    end

    it { expect(fields).to be_valid }
  end

  context 'when invalid struct' do
    it {
      fields = described_class.new(struct, { name1: 'Jack' })
      expect(fields).not_to be_valid
      expect(fields.errors).to eq({ name1: ["Invalid field: 'name1'"] })
    }

    it {
      fields = described_class.new(struct, { name: 0 })
      expect(fields).not_to be_valid
      expect(fields.errors).to eq({ name: ["Should have correct type: 'string'"] })
    }

    it {
      fields = described_class.new(struct, { phone: '123456789' })
      expect(fields).not_to be_valid
      expect(fields.errors).to eq({ phone: ["Should have correct type: 'integer'"] })
    }

    it {
      fields = described_class.new(struct, { gender: 'unknown' })
      expect(fields).not_to be_valid
      expect(fields.errors).to eq({
                                    gender: ["Should have correct type: '{:single_field=>[\"male\", \"female\", \"no_info\"]}'"]
                                  })
    }

    it {
      fields = described_class.new(struct, { languages: 'es' })
      expect(fields).not_to be_valid
      expect(fields.errors).to eq({
                                    languages: ["Should have correct type: '{:multiple_fields=>[\"uk\", \"ru\", \"en\"]}'"]
                                  })
    }

    it {
      fields = described_class.new(struct, { languages: ['es'] })
      expect(fields).not_to be_valid
      expect(fields.errors).to eq({
                                    languages: ["Should have correct type: '{:multiple_fields=>[\"uk\", \"ru\", \"en\"]}'"]
                                  })
    }
  end
end
