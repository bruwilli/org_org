class CreateOrgTemplates < ActiveRecord::Migration
  def change
    create_table :org_templates do |t|
      t.string :name
      t.integer :editor_id

      t.timestamps
    end
    add_index :org_templates, [:editor_id, :created_at]
  end
end
