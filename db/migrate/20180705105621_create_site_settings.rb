class CreateSiteSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :site_settings do |t|
      t.jsonb :data, null: false, default: {}
      t.integer :singleton_guard, null: false, default: 0

      t.timestamps
    end
    add_index :site_settings, :singleton_guard, unique: true
  end
end
