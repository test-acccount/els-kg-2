class CreateDocumentDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :document_details do |t|
      t.jsonb :invoice_contacts, null: false, default: {}
      t.jsonb :customs_forms_contacts, null: false, default: {}
      t.integer :singleton_guard, null: false, default: 0

      t.timestamps
    end
    add_index :document_details, :singleton_guard, unique: true
  end
end
