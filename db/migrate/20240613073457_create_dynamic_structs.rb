# frozen_string_literal: true

class CreateDynamicStructs < ActiveRecord::Migration[7.1]
  def change
    create_table :dynamic_structs, id: :uuid do |t|
      t.string :name, null: false
      t.jsonb :struct, default: {}, null: false
      t.references :fields_structable, polymorphic: true, type: :uuid

      t.timestamps
    end
  end
end
