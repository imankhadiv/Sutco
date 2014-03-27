require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "FOH tests" do
  before(:each) do
    role = FactoryGirl.create(:role)
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    Position.create :name =>"Manager"
    Position.create :name =>"Box Officer"
    Position.create :name =>"Refreshment Officer"
    Position.create :name =>"Usher 1"
    Position.create :name =>"Usher 2"
    Position.create :name =>"Usher 3"
    Position.create :name =>"Usher 4"
  end

  describe "View list of available FOH" do
    let!(:show_with_show_dates) { FactoryGirl.create(:show_with_show_dates) }
    specify "Given a show exists with several show dates, I can view a list of these dates and Apply for front of house" do
      visit fohs_path
      page.should have_content "Show 1"
      click_on "Apply"
      page.should have_content "You are applying for a front of house position"
    end
  end

  describe "Apply for front of house" do
    let!(:show_with_show_dates) { FactoryGirl.create(:show_with_show_dates) }
    specify "Given a show exists with several show dates, I can Apply for front of house for one of them" do
      visit show_path(show_with_show_dates.id)
      click_on "Apply for front of house"
      page.should have_content "You are applying for a front of house position"
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
      visit show_path(show_with_show_dates.id)

      click_on "Apply for front of house"
      page.should have_content "You are applying for a front of house position"
      page.should have_content "Manager"

      page.choose("Manager")
      fill_in "Phone number", with: "07405149580"
      click_button "Apply"
      page.should have_content "You have successfully applied for the position"

      visit show_path(show_with_show_dates.id)
      click_on "Apply for front of house"
      page.should_not have_content "Manager"
    end

    specify "Do not allow user to apply for multiple positions within the same day" do
      visit show_path(show_with_show_dates.id)
      click_on "Apply for front of house"
      page.should have_content "You are applying for a front of house position"
      page.should have_content "Manager"

      page.choose("Manager")
      fill_in "Phone number", with: "07405149580"
      click_button "Apply"
      page.should have_content "You have successfully applied for the position"

      visit show_path(show_with_show_dates.id)
      click_on "Apply for front of house"
      page.choose("Refreshment Officer")
      fill_in "Phone number", with: "07405149580"
      click_button "Apply"
      page.should have_content "You can only apply for one position for a particular show date"
    end

    specify "when all the positions are taken, do not display the link for Apply for front of house on the show page" do
      pending
      Position.delete_all
      Position.create :name =>"Manager"
      visit show_path(show_with_show_dates.id)
      click_on "Apply for front of house"
      page.should have_content "You are applying for a front of house position"
      page.should have_content "Manager"

      page.choose("Manager")
      fill_in "Phone number", with: "07405149580"
      click_button "Apply"
      page.should have_content "You have successfully applied for the position"

      visit show_path(show_with_show_dates.id)
      click_on "Apply for front of house"
      page.should have_content "You are applying for a front of house position"
      page.should have_content "Manager"

      page.choose("Manager")
      fill_in "Phone number", with: "07405149580"
      click_button "Apply"
      page.should have_content "You have successfully applied for the position"

      visit show_path(show_with_show_dates.id)
      click_on "Apply for front of house"
      page.should have_content "You are applying for a front of house position"
      page.should have_content "Manager"

      page.choose("Manager")
      fill_in "Phone number", with: "07405149580"
      click_button "Apply"
      page.should have_content "You have successfully applied for the position"

      visit show_path(show_with_show_dates.id)
      click_on "Apply for front of house"
      page.should have_content "You are applying for a front of house position"
      page.should have_content "Manager"

      page.choose("Manager")
      fill_in "Phone number", with: "07405149580"
      click_button "Apply"
      page.should have_content "You have successfully applied for the position"

      visit show_path(show_with_show_dates.id)
      click_on "Apply for front of house"
      page.should have_content "You are applying for a front of house position"
      page.should have_content "Manager"

      page.choose("Manager")
      fill_in "Phone number", with: "07405149580"
      click_button "Apply"
      page.should have_content "You have successfully applied for the position"

      visit show_path(show_with_show_dates.id)
      page.should_not have_content "Apply for front of house"
    end
  end
end