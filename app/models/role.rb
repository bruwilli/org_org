class Role < ActiveRecord::Base
  attr_accessible :description, :name, :org_type_id

  belongs_to :org_type
  
  validates :name, :length => { :maximum => 64 }  
end
