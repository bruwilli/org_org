require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "editor signin page" do
    before { visit editor_signin_path }

    it { should have_heading('Editor sign in') }
    it { should have_title('Editor sign in') }
  end
  
  describe "editor signin" do
    before { visit editor_signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Editor sign in') }
      it { should have_error_message('Invalid') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_any_error_message }
      end
    end

    describe "with valid information" do
      let(:editor) { FactoryGirl.create(:editor) }
      before { valid_editor_signin(editor) }

      it { should have_title(editor.first_name) }
      it { should have_link('Profile', href: editor_path(editor)) }
      it { should have_link('Editor sign out', href: editor_signout_path) }
      it { should_not have_link('Editor sign in', href: editor_signin_path) }

      describe "followed by signout" do
        before { click_link "Editor sign out" }
        it { should have_link('Editor sign in') }
      end
    end
  end  
end