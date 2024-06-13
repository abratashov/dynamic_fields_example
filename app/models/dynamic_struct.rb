class DynamicStruct < ApplicationRecord
  has_many :dynamic_records, dependent: :destroy
end
