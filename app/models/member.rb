# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  org_id     :integer
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Member < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :org_id
end
