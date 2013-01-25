class EditorsController < ApplicationController
  before_filter :signed_in_editor, only: [:index, :edit, :update, :destroy]
  before_filter :not_signed_in_editor, only: [:new]
  before_filter :correct_editor,   only: [:edit, :update]
  before_filter :admin_editor,     only: [:index, :destroy]
  before_filter :should_not_be_signed_in_as_editor, only: [:create]

  def show
    @editor = Editor.find(params[:id])
    @org_templates = @editor.org_templates.paginate(page: params[:page])
  end

  def new
    @editor = Editor.new
  end

  def destroy
    Editor.find(params[:id]).destroy
    flash[:success] = "Editor destroyed."
    redirect_to editors_url
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
    @editors = Editor.paginate(page:params[:page])
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
    
    def not_signed_in_editor
      if signed_in_as_editor?
        redirect_to(root_path) unless current_editor?(@editor)
      end
    end

    def correct_editor
      @editor = Editor.find(params[:id])
      redirect_to(root_path) unless current_editor?(@editor)
    end
    
    def admin_editor
      redirect_to(editor_path(current_editor.id), notice: "Not available to non-admin editors") unless current_editor.admin?
    end

    def should_not_be_signed_in_as_editor
      redirect_to(root_path) if signed_in_as_editor?
    end
end
