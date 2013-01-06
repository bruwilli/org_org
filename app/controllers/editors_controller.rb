class EditorsController < ApplicationController
  before_filter :signed_in_editor, only: [:index, :edit, :update]
  before_filter :correct_editor,   only: [:edit, :update]

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

  def index
    @editors = Editor.all
  end
  
  def edit
    @editor.email_confirmation = @editor.email
  end
  
  def update
    if @editor.update_attributes(params[:editor])
      flash[:success] = "Profile updated"
      sign_in_as_editor @editor
      redirect_to @editor
    else
      render 'edit'
    end
  end
  
  private

    def signed_in_editor
      unless signed_in_as_editor?
        editor_store_location
        redirect_to editor_signin_url, notice: "Please sign in."
      end
    end

    def correct_editor
      @editor = Editor.find(params[:id])
      redirect_to(root_path) unless current_editor?(@editor)
    end
end
