# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  org_type_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Role < ActiveRecord::Base
  attr_accessible :description, :name, :org_type_id

  belongs_to :org_type
  
  validates :name, :length => { :maximum => 64 }  
end
