class CreatePackageItems < ActiveRecord::Migration[5.2]
  def change
    create_table :package_items do |t|
      t.string :description
      t.decimal :price, precision: 8, scale: 2
      t.integer :qty, limit: 2, default: 1
      t.references :package, foreign_key: true

      t.timestamps
    end
  end
end
