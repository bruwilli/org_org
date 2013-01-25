require 'spec_helper'

describe OrgTemplate do
  let(:editor) { FactoryGirl.create(:editor) }

  before do
    @org_template = editor.org_templates.build(name: "Toastmasters")
  end

  subject { @org_template }

  it { should respond_to(:name) }
  it { should respond_to(:editor_id) }
  it { should respond_to(:editor) }
  its(:editor) { should == editor }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to editor_id" do
      expect do
        OrgTemplate.new(editor_id: editor.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when editor_id is not present" do
    before { @org_template.editor_id = nil }
    it { should_not be_valid }
  end

  describe "when editor_id is not present" do
    before { @org_template.editor_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @org_template.name = " " }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @org_template.name = "a" * 65 }
    it { should_not be_valid }
  end
  
end
