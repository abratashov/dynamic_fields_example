class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.references :tenant, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
