class OrgTemplate < ActiveRecord::Base
  attr_accessible :name
  belongs_to :editor

  validates :editor_id, presence: true

  default_scope order: 'org_templates.created_at DESC'
end
