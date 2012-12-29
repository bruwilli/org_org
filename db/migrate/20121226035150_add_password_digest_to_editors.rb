class AddPasswordDigestToEditors < ActiveRecord::Migration
  def change
    add_column :editors, :password_digest, :string
  end
end
