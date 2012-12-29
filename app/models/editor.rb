# == Schema Information
#
# Table name: editors
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

class Editor < ActiveRecord::Base
  attr_accessible :first_name, :last_name, 
                  :email, :email_confirmation,
                  :password, :password_confirmation
  attr_accessor :email_confirmation
  has_secure_password

  before_save { self.email.downcase! }
  before_save :create_remember_token

  
  validates :first_name, presence: true, length: { maximum: 64 }
  validates :last_name, presence: true, length: { maximum: 64 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email_confirmation, presence: true
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false },
                    confirmation_no_case: true  
  validates :password_confirmation, presence: true
  validates :password, presence: true,
                       length: { minimum: 8 },
                       confirmation: true

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
