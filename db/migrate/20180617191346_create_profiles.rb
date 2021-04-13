class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :address_line
      t.string :address_zipcode
      t.string :address_city
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
