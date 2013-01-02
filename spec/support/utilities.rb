include ApplicationHelper

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :have_title do |text|
  match do |page|
    page.should have_selector('title', text: text)
  end
end

RSpec::Matchers.define :have_any_error_message do
  match do |page|
    page.should have_selector('div.alert.alert-error')
  end
end

RSpec::Matchers.define :have_heading do |text|
  match do |page|
    page.should have_selector('h1', text: text)
  end
end

def editor_sign_in(editor)
  visit editor_signin_path
  fill_in "Email",    with: editor.email
  fill_in "Password", with: editor.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:editor_remember_token] = editor.remember_token
end
