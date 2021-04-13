class CreatePricings < ActiveRecord::Migration[5.2]
  def change
    create_table :pricings do |t|
      t.jsonb :data, null: false, default: {}
      t.integer :singleton_guard, null: false, default: 0

      t.timestamps
    end
    add_index :pricings, :singleton_guard, unique: true
  end
end
