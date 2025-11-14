class AddMissingIndexesToAudits < ActiveRecord::Migration[8.0]
  def change
    add_index :audits, [:auditable_type, :auditable_id], name: "auditable_index"
    add_index :audits, [:user_type, :user_id], name: "user_index"
    add_index :audits, :user_id unless index_exists?(:audits, :user_id)
  end
end
