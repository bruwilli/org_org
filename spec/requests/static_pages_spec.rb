require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the h1 'Org Org'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => 'Org-Org')
    end

    it "should have the base title" do
      visit '/static_pages/home'
      page.should have_selector('title',
                        :text => "Org-Org: Organize Your Organization")
    end

    it "should not have a custom page title" do
      visit '/static_pages/home'
      page.should_not have_selector('title', :text => '| Home')
    end
  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_content('Help')
    end

    it "should have the right title" do
      visit '/static_pages/help'
      page.should have_selector('title',
                        :text => "Org-Org: Organize Your Organization | Help")
    end
  end

  describe "About page" do

    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      page.should have_content('About Us')
    end

    it "should have the right title" do
      visit '/static_pages/about'
      page.should have_selector('title',
                        :text => "Org-Org: Organize Your Organization | About Us")
    end
  end
  
end