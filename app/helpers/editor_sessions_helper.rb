module EditorSessionsHelper
  def sign_in_as_editor(editor)
    cookies.permanent[:editor_remember_token] = editor.remember_token
    self.current_editor = editor
  end
  
  def signed_in_as_editor?
    !current_editor.nil?
  end

  def current_editor=(editor)
    @current_editor = editor
  end

  def current_editor
    @current_editor ||= Editor.find_by_remember_token(cookies[:editor_remember_token])
  end

  def current_editor?(editor)
    editor == current_editor
  end

  def sign_out_as_editor
    self.current_editor = nil
    cookies.delete(:editor_remember_token)
  end

  def editor_redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def editor_store_location
    session[:return_to] = request.url
  end
end
