class Member < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :org_id
end
