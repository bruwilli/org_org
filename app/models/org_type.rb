class OrgType < ActiveRecord::Base
  attr_accessible :description, :name
  validates :name, :length => { :maximum => 64 }
  has_many :roles
end
