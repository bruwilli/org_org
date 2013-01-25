require 'spec_helper'

describe "Editor pages" do

  subject { page }

  describe "index" do
    let(:admin) { FactoryGirl.create(:admin) }

    before(:each) do
      editor_sign_in admin
      visit editors_path
    end

    it { should have_title 'All editors' }
    it { should have_heading 'All editors' }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:editor) } }
      after(:all)  { Editor.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each editor" do
        Editor.paginate(page: 1).each do |editor|
          page.should have_selector('li', text: "#{editor.first_name} #{editor.last_name}")
        end
      end
    end
    
    describe "delete links" do
      before do
        30.times { FactoryGirl.create(:editor) }
      end
      
      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          editor_sign_in admin
          visit editors_path
        end

        it { should_not have_link('delete', href: editor_path(Editor.first)) }
        it "should be able to delete another editor" do
          expect { click_link('delete') }.to change(Editor, :count).by(-1)
        end
        it { should_not have_link('delete', href: editor_path(admin)) }
      end
    end
  end
  
  describe "editor signup page" do
    before { visit editor_signup_path }

    it { should have_heading('Become an Org-Organizer Editor') }
    it { should have_title('Become an Editor') }
  end

  describe "editor settings page" do
    let(:editor) { FactoryGirl.create(:editor) }
    let!(:m1) { FactoryGirl.create(:org_template, editor: editor, name: "Foo") }
    let!(:m2) { FactoryGirl.create(:org_template, editor: editor, name: "Bar") }

    # Code to make a user variable
    before { visit editor_path(editor) }

    it { should have_heading(editor.first_name) }
    it { should have_heading(editor.last_name) }
    it { should have_title(editor.first_name) }

    describe "org_templates" do
      it { should have_content(m1.name) }
      it { should have_content(m2.name) }
      it { should have_content(editor.org_templates.count) }
    end
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
                
        describe "when trying to visit new editor page" do
          before { visit editor_signup_path }
          
          specify { current_path.should == root_path }
        end
        
      end
    end
  end
  
  describe "edit" do
    let(:editor) { FactoryGirl.create(:editor) }
    before do
      editor_sign_in editor
      visit edit_editor_path(editor) 
    end

    describe "page" do
      it { should have_heading("Update your profile") }
      it { should have_title("Editor profile") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_first_name)  { "New First Name" }
      let(:new_last_name)  { "New Last Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "First name",       with: new_first_name
        fill_in "Last name",        with: new_last_name
        fill_in "Email",            with: new_email
        fill_in "Confirm email",    with: new_email
        fill_in "Password",         with: editor.password
        fill_in "Confirm password", with: editor.password
        click_button "Save changes"
      end

      it { should have_title new_first_name }
      it { should have_success_message }
      it { should have_link('Editor sign out', href: editor_signout_path) }
      specify { editor.reload.first_name.should  == new_first_name }
      specify { editor.reload.last_name.should  == new_last_name }
      specify { editor.reload.email.should == new_email }
    end
  end
end