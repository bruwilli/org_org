class AddIndexToOrgTypeEditorsEmail < ActiveRecord::Migration
  def change
    add_index :org_type_editors, :email, unique: true
  end
end
