class DynamicStruct < ApplicationRecord
  has_many :dynamic_records, dependent: :destroy

  validates :name, presence: true,
                   length: {minimum: 1, maximum: 80},
                   uniqueness: { scope: [:fields_structable_type, :fields_structable_id] }
end
