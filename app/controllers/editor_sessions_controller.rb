class EditorSessionsController < ApplicationController
  def new
  end

  def create
    editor = Editor.find_by_email(params[:editor_session][:email].downcase)
    if editor && editor.authenticate(params[:editor_session][:password])
      # Sign the editor in and redirect to the editor's show page.
      sign_in_as_editor editor
      redirect_to editor
    else
      # Create an error message and re-render the signin form.
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    sign_out_as_editor
    redirect_to root_url
  end
end
