class Tenant < ApplicationRecord
  has_many :dynamic_structs, as: :fields_structable, dependent: :destroy
end
