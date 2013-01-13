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

require 'spec_helper'

describe Editor do
  before do
    @editor = Editor.new(first_name: "Example", 
                                       last_name: "User", 
                                       email: "user@example.com",
                                       email_confirmation: "user@example.com",
                                       password: "foobar12", 
                                       password_confirmation: "foobar12")
  end

  subject { @editor }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:email_confirmation) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }  
  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @editor.save!
      @editor.toggle!(:admin)
    end

    it { should be_admin }
  end
  
  describe "when first_name is not present" do
    before { @editor.first_name = " " }
    it { should_not be_valid }
  end

  describe "when last_name is not present" do
    before { @editor.last_name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @editor.email = " " }
    it { should_not be_valid }
  end

  describe "when email confirmation is not present" do
    before { @editor.email_confirmation = " " }
    it { should_not be_valid }
  end

   describe "when first_name is too long" do
    before { @editor.first_name = "a" * 65 }
    it { should_not be_valid }
  end

   describe "when last_name is too long" do
    before { @editor.last_name = "a" * 65 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @editor.email = invalid_address
        @editor.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @editor.email = @editor.email_confirmation = valid_address
        @editor.should be_valid
      end      
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @editor.dup
      user_with_same_email.email = @editor.email_confirmation = @editor.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when email doesn't match confirmation" do
    before { @editor.email_confirmation = "mismatch@mismatch.com" }
    it { should_not be_valid }
  end

  describe "when email matches confirmation except case" do
    before do
      @editor.email_confirmation.downcase!
      @editor.email_confirmation.upcase!
    end
    it { should be_valid }
  end

  describe "when email doesn't match confirmation" do
    before { @editor.email_confirmation = "mismatch@mismatch.com" }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @editor.password = @editor.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @editor.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "@editor password confirmation is nil" do
    before { @editor.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @editor.save }
    let(:found_editor) { Editor.find_by_email(@editor.email) }

    describe "with valid password" do
      it { should == found_editor.authenticate(@editor.password) }
    end

    describe "with invalid password" do
      let(:editor_for_invalid_password) { found_editor.authenticate("invalid12") }

      it { should_not == editor_for_invalid_password }
      specify { editor_for_invalid_password.should be_false }
    end
  end  
  
  describe "with a password that's too short" do
    before { @editor.password = @editor.password_confirmation = "a" * 7 }
    it { should be_invalid }
  end  

  describe "editor remember token" do
    before { @editor.save }
    its(:remember_token) { should_not be_blank }
  end
end
