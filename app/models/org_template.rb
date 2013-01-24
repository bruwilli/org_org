class OrgTemplate < ActiveRecord::Base
  attr_accessible :name
  belongs_to :editor

  validates :name, presence: true, length: { maximum: 64 }
  validates :editor_id, presence: true

  default_scope order: 'org_templates.created_at DESC'
end
