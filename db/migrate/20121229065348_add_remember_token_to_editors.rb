class AddRememberTokenToEditors < ActiveRecord::Migration
  def change
    add_column :editors, :remember_token, :string
    add_index  :editors, :remember_token
  end
end
