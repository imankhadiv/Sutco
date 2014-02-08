require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "FOH tests" do
  before(:each) do
    role = FactoryGirl.create(:role)
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
  end
  describe "Apply for FOH" do

    #let!(:show) { FactoryGirl.create(:show) }
    let!(:show_with_show_dates) { FactoryGirl.create(:show_with_show_dates) }

    #let!(:position) { FactoryGirl.create(:position) }

    specify "Given a show exists with several show dates, I can apply for FOH for one of them" do
      Position.create :name =>"Manager"
      Position.create :name =>"Box Officer"
      Position.create :name =>"Refreshment Officer"
      Position.create :name =>"Usher 1"
      Position.create :name =>"Usher 2"
      Position.create :name =>"Usher 3"
      Position.create :name =>"Usher 4"
      visit show_path(show_with_show_dates.id)

      click_on "Apply for foh"
      page.should have_content "Apply for a front of house position"
      page.should have_content "Manager"
      page.should have_content "Box Officer"
      page.should have_content "Refreshment Officer"
      page.should have_content "Usher 1"
      page.should have_content "Usher 2"
      page.should have_content "Usher 3"
      page.should have_content "Usher 4"
      page.choose("Manager")
      fill_in "Phone number", with: "07405149580"
      click_button "Apply"
      page.should have_content "You have successfully applied for the position"

    end

    specify "Once a position is taken, it should be removed from the application web page" do
      Position.create :name =>"Manager"
      Position.create :name =>"Box Officer"
      Position.create :name =>"Refreshment Officer"
      Position.create :name =>"Usher 1"
      Position.create :name =>"Usher 2"
      Position.create :name =>"Usher 3"
      Position.create :name =>"Usher 4"
      visit show_path(show_with_show_dates.id)

      click_on "Apply for foh"
      page.should have_content "Apply for a front of house position"
      page.should have_content "Manager"

      page.choose("Manager")
      fill_in "Phone number", with: "07405149580"
      click_button "Apply"
      page.should have_content "You have successfully applied for the position"

      visit show_path(show_with_show_dates.id)
      click_on "Apply for foh"
      page.should_not have_content "Manager"
    end

    specify "Do not allow user to apply for multiple positions within the same day" do
      Position.create :name =>"Manager"
      Position.create :name =>"Box Officer"
      Position.create :name =>"Refreshment Officer"
      Position.create :name =>"Usher 1"
      Position.create :name =>"Usher 2"
      Position.create :name =>"Usher 3"
      Position.create :name =>"Usher 4"
      visit show_path(show_with_show_dates.id)

      click_on "Apply for foh"
      page.should have_content "Apply for a front of house position"
      page.should have_content "Manager"

      page.choose("Manager")
      fill_in "Phone number", with: "07405149580"
      click_button "Apply"
      page.should have_content "You have successfully applied for the position"

      visit show_path(show_with_show_dates.id)
      click_on "Apply for foh"
      page.choose("Refreshment Officer")
      fill_in "Phone number", with: "07405149580"
      click_button "Apply"
      page.should have_content "You can only apply for one position for a particular show date"
    end
  end

  ### No option for it !


  describe "Cancel application" do

    let!(:show) { FactoryGirl.create(:show) }

    specify "Given an application has been submitted, I can Cancel it" do

      pending "cancel function and interface to be implemented"
    end
  end


end