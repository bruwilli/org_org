class AddPasswordDigestToOrgTypeEditors < ActiveRecord::Migration
  def change
    add_column :org_type_editors, :password_digest, :string
  end
end
