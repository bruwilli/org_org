require 'spec_helper'
require 'support/utilities'

describe "Static pages" do
  subject { page }
  describe "Home page" do
  before { visit root_path }
    it { should have_heading('Org-Org') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
  end

  describe "Help page" do
  before { visit help_path } 
    it { should have_content 'Help' }
    it { should have_title(full_title('Help')) }
  end

  describe "About page" do
  before { visit about_path } 
    it { should have_content 'About Us' }
    it { should have_title(full_title('About Us')) }
  end

  describe "Contact page" do
  before { visit contacts_path } 
    it { should have_heading('Contact') }
    it { should have_title(full_title('Contact')) }
  end
end