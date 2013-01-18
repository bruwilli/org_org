require 'spec_helper'

describe EditorsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end
  
  describe "create when signed in" do
    before :each do
      editor_sign_in FactoryGirl.create(:editor)
    end
    
    it "does not change editor count" do
      expect {post :create, 
                   editor: FactoryGirl.attributes_for(:editor)
             }.to_not change(Editor, :count) 
    end
    
    it "redirects to root URL" do
     post :create, editor: FactoryGirl.attributes_for(:editor) 
     response.should redirect_to root_path
    end
  end
end
