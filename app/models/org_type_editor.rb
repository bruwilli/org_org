# == Schema Information
#
# Table name: org_type_editors
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrgTypeEditor < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, 
                  :password, :password_confirmation
  has_secure_password

  before_save { self.email.downcase! }

  
  validates :first_name, presence: true, length: { maximum: 64 }
  validates :last_name, presence: true, length: { maximum: 64 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  validates_confirmation_of :password
  validates :password_confirmation, presence: true
end
