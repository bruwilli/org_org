# == Schema Information
#
# Table name: org_types
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class OrgType < ActiveRecord::Base
  attr_accessible :description, :name
  validates :name, :length => { :maximum => 64 }
  has_many :roles
end
