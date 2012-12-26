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

require 'spec_helper'

describe OrgTypeEditor do
  before do
    @orgTypeEditor = OrgTypeEditor.new(first_name: "Example", 
                                       last_name: "User", 
                                       email: "user@example.com",
                                       password: "foobar12", 
                                       password_confirmation: "foobar12")
  end

  subject { @orgTypeEditor }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate)}

  it { should be_valid }
  
  describe "when first_name is not present" do
    before { @orgTypeEditor.first_name = " " }
    it { should_not be_valid }
  end

  describe "when last_name is not present" do
    before { @orgTypeEditor.last_name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @orgTypeEditor.email = " " }
    it { should_not be_valid }
  end

   describe "when first_name is too long" do
    before { @orgTypeEditor.first_name = "a" * 65 }
    it { should_not be_valid }
  end

   describe "when last_name is too long" do
    before { @orgTypeEditor.last_name = "a" * 65 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @orgTypeEditor.email = invalid_address
        @orgTypeEditor.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @orgTypeEditor.email = valid_address
        @orgTypeEditor.should be_valid
      end      
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @orgTypeEditor.dup
      user_with_same_email.email = @orgTypeEditor.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @orgTypeEditor.password = @orgTypeEditor.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @orgTypeEditor.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "@orgTypeEditor password confirmation is nil" do
    before { @orgTypeEditor.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @orgTypeEditor.save }
    let(:found_org_type_editor) { OrgTypeEditor.find_by_email(@orgTypeEditor.email) }

    describe "with valid password" do
      it { should == found_org_type_editor.authenticate(@orgTypeEditor.password) }
    end

    describe "with invalid password" do
      let(:org_type_editor_for_invalid_password) { found_org_type_editor.authenticate("invalid12") }

      it { should_not == org_type_editor_for_invalid_password }
      specify { org_type_editor_for_invalid_password.should be_false }
    end
  end  
  
  describe "with a password that's too short" do
    before { @orgTypeEditor.password = @orgTypeEditor.password_confirmation = "a" * 7 }
    it { should be_invalid }
  end  
end
