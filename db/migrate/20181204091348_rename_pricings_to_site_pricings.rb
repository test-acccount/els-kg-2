class RenamePricingsToSitePricings < ActiveRecord::Migration[5.2]
  def change
    rename_table :pricings, :site_pricings
  end
end
