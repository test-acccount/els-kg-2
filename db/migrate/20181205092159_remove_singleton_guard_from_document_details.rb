class RemoveSingletonGuardFromDocumentDetails < ActiveRecord::Migration[5.2]
  def up
    remove_column :document_details, :singleton_guard, :integer
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
