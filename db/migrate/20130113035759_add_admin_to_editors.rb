class AddAdminToEditors < ActiveRecord::Migration
  def change
    add_column :editors, :admin, :boolean, default: false
  end
end
