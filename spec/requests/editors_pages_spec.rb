require 'spec_helper'

describe "Editor pages" do

  subject { page }

  describe "editor signup page" do
    before { visit editor_signup_path }

    it { should have_heading('Become an Org-Organizer Editor') }
    it { should have_title('Become an Editor') }
  end

  describe "editor settings page" do
    let(:editor) { FactoryGirl.create(:editor) }

    # Code to make a user variable
    before { visit editor_path(editor) }

    it { should have_heading(editor.first_name) }
    it { should have_heading(editor.last_name) }
    it { should have_title(editor.first_name) }
  end

  describe "signup" do

    before { visit editor_signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create an editor" do
        expect { click_button submit }.not_to change(Editor, :count)
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

      it "should create an editor" do
        expect { click_button submit }.to change(Editor, :count).by(1)
      end
      
      describe "after saving the editor" do
        before { click_button submit }
        let(:editor) { Editor.find_by_email('user@example.com') }

        it { should have_title(editor.first_name) }
        it { should have_success_message('Welcome') }
        it { should have_link('Editor sign out') }      
      end
    end
  end
  
end