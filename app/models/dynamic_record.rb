class DynamicRecord < ApplicationRecord
  belongs_to :dynamic_struct

  # We can pass 'merge' key for data merging
  def update_data(changes, merge: false)
    data_current = DynamicFields.new(dynamic_struct.struct, data)
    data_changes = DynamicFields.new(dynamic_struct.struct, changes)

    errors.add(:data, data_changes.errors) and return unless data_changes.valid?

    merge ? update!(data: data.merge(data_changes.data)): update!(data: data_changes.data)
  end
end
