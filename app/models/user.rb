# frozen_string_literal: true

class User < ApplicationRecord
  include DynamicRecordsDefinition

  belongs_to :tenant
  alias dynamic_struct_owner tenant

  has_many :dynamic_records, as: :fields_recordable, dependent: :destroy
end
