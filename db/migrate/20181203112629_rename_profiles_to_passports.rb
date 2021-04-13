class RenameProfilesToPassports < ActiveRecord::Migration[5.2]
  def up
    rename_table :profiles, :passports

    # Reindex passports because index name changed
    execute <<-SQL.squish
      REINDEX TABLE passports;
    SQL

    # Update active_storage pointing to passport & has_many_attached :photos
    execute <<-SQL.squish
      UPDATE active_storage_attachments
      SET name = 'photos', record_type = 'Passport'
      WHERE record_type = 'Profile';
    SQL

    # Update active_storage indexes
    execute <<-SQL.squish
      REINDEX TABLE active_storage_attachments;
    SQL
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
