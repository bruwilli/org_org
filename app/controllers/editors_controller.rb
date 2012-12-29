class EditorsController < ApplicationController
  def show
    @editor = Editor.find(params[:id])
  end

  def new
    @editor = Editor.new
  end

  def create
    @editor = Editor.new(params[:editor])
    if @editor.save
      sign_in_as_editor @editor
      flash[:success] = "Welcome to the Org-Organizer Editor Community!"
      redirect_to @editor
    else
      render 'new'
    end
  end
  
end
