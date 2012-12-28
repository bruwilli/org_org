class OrgTypeEditorsController < ApplicationController
  def show
    @org_type_editor = OrgTypeEditor.find(params[:id])
  end

  def new
    @org_type_editor = OrgTypeEditor.new
  end

  def create
    @org_type_editor = OrgTypeEditor.new(params[:org_type_editor])
    if @org_type_editor.save
      flash[:success] = "Welcome to the Org-Organizer Profile Editor Community!"
      redirect_to @org_type_editor
    else
      render 'new'
    end
  end
  
end
