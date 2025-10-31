class UpdateToUseUuid < ActiveRecord::Migration[8.0]
  def up
    change_table :audits, bulk: true do |t|
      t.remove :auditable_id, :user_id
      t.uuid :auditable_id
      t.uuid :user_id
    end
  end
end
