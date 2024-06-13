class User < ApplicationRecord
  belongs_to :tenant
  has_many :dynamic_records, as: :fields_recordable, dependent: :destroy
end
