class AddIndexToEditorsEmail < ActiveRecord::Migration
  def change
    add_index :editors, :email, unique: true
  end
end
