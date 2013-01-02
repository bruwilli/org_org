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
      before { editor_sign_in(editor) }

      it { should have_title(editor.first_name) }
      it { should have_link('Profile', href: editor_path(editor)) }
      it { should have_link('Settings', href: edit_editor_path(editor)) }      
      it { should have_link('Editor sign out', href: editor_signout_path) }
      it { should_not have_link('Editor sign in', href: editor_signin_path) }

      describe "followed by signout" do
        before { click_link "Editor sign out" }
        it { should have_link('Editor sign in') }
      end
    end
  end  
  describe "authorization" do

    describe "for non-signed-in editors" do
      let(:editor) { FactoryGirl.create(:editor) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_editor_path(editor)
          fill_in "Email",    with: editor.email
          fill_in "Password", with: editor.password
          click_button "Sign in"
        end

        describe "after signing in" do
          it "should render the desired protected page" do
            page.should have_title('Editor profile')
          end
        end
      end
      
      describe "in the Editors controller" do

        describe "visiting the edit page" do
          before { visit edit_editor_path(editor) }
          it { should have_title 'Editor sign in' }
        end

        describe "submitting to the update action" do
          before { put editor_path(editor) }
          specify { response.should redirect_to(editor_signin_path) }
        end
      end
    end

    describe "as wrong editor" do
      let(:editor) { FactoryGirl.create(:editor) }
      let(:wrong_editor) { FactoryGirl.create(:editor, 
                                              email: "wrong@example.com",
                                              email_confirmation: "wrong@example.com") }
      before { editor_sign_in editor }
      describe "visiting Editors#edit page" do
        before { visit edit_editor_path(wrong_editor) }
        it { should_not have_title(full_title('Editor profile')) }
      end

      describe "submitting a PUT request to the Editors#update action" do
        before { put editor_path(wrong_editor) }
        specify { response.should redirect_to(root_path) }
      end
    end

  end
end