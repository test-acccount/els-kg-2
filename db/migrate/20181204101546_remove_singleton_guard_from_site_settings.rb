class RemoveSingletonGuardFromSiteSettings < ActiveRecord::Migration[5.2]
  def up
    remove_column :site_settings, :singleton_guard, :integer
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
