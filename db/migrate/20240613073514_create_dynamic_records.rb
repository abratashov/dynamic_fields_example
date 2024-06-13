class CreateDynamicRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :dynamic_records, id: :uuid do |t|
      t.references :dynamic_struct, null: false, foreign_key: true, type: :uuid
      t.jsonb :data, default: {}, null: false
      t.references :fields_recordable, polymorphic: true, type: :uuid

      t.timestamps
    end
  end
end
