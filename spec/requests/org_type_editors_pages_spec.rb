require 'spec_helper'

describe "OrgTypeEditor pages" do

  subject { page }

  describe "org profile editor signup page" do
    before { visit new_org_profile_editor_path }

    it { should have_selector('h1',    text: 'Become an Org Profile Editor') }
    it { should have_selector('title', text: 'Become an Org Profile Editor') }
  end

  describe "org profile editor settings page" do
    let(:org_type_editor) { FactoryGirl.create(:org_type_editor) }

    # Code to make a user variable
    before { visit org_type_editor_path(org_type_editor) }

    it { should have_selector('h1',    text: org_type_editor.first_name) }
    it { should have_selector('h1',    text: org_type_editor.last_name) }
    it { should have_selector('title', text: org_type_editor.first_name) }
  end

  describe "signup" do

    before { visit new_org_profile_editor_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create an org type editor" do
        expect { click_button submit }.not_to change(OrgTypeEditor, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "First name",         with: "Example"
        fill_in "Last name",          with: "User"
        fill_in "Email",              with: "user@example.com"
        fill_in "Confirm email",      with: "user@example.com"
        fill_in "Password",           with: "foobar12"
        fill_in "Confirm password",   with: "foobar12"
      end

      it "should create an org type editor" do
        expect { click_button submit }.to change(OrgTypeEditor, :count).by(1)
      end
    end
  end
  
end