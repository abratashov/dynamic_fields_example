# frozen_string_literal: true

class AddIndexToNameField < ActiveRecord::Migration[7.1]
  def change
    add_index :dynamic_structs, %i[name fields_structable_type fields_structable_id], unique: true
  end
end
