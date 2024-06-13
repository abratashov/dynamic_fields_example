class Tenant < ApplicationRecord
  include DynamicStructsDefinition

  has_many :dynamic_structs, as: :fields_structable, dependent: :destroy
  has_many :users
end
