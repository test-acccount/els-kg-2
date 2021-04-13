class CreateIncomingPackages < ActiveRecord::Migration[5.2]
  def change
    create_table :incoming_packages do |t|
      t.string :tracking
      t.integer :carrier, default: 0

      t.timestamps
    end
    add_index :incoming_packages, :tracking, unique: true
  end
end
