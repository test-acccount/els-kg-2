class RemoveSingletonGuardFromPricings < ActiveRecord::Migration[5.2]
  def up
    remove_column :pricings, :singleton_guard, :integer
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
