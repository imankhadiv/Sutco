require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Show tests" do

  before(:each) do
    role = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
  end

  describe "Creating shows" do
    specify "I can create a show" do
      visit new_show_path
      fill_in "Name", with: "Show 1"
      fill_in "Director", with: "Some Director"
      fill_in "Stage manager", with: "Some Stage manager"
      fill_in "Producer", with: "Some Producer"
      fill_in "Synopsis", with: "Some Description"
      click_on "Add Date"
      last_nested_fields = all('.fields').first
      within(last_nested_fields) do
        select "2015", :from => "show[show_dates_attributes][0][date(1i)]"
      end
      click_button "Create Show"
      page.should have_content "Show was successfully created"
      page.should have_content "Show 1"
      page.should have_content "Some Director"
      page.should have_content "Some Stage manager"
      page.should have_content "Some Producer"
      page.should have_content "Some Description"
    end

    specify "I cannot create a show with blank fields" do
      #pending "input validation to be added"
      visit new_show_path
      click_button "Create Show"
      page.should have_content "can't be blank"
    end
  end

  describe "Updating shows" do

    let!(:show_with_show_dates) { FactoryGirl.create(:show_with_show_dates) }
    specify "Given a show exists I can update it, remove a show date" do
      visit show_path(show_with_show_dates.id)
      click_on "Edit"
      page.should have_content "Editing show"
      fill_in "Name", with: "Show 2"
      fill_in "Director", with: "Some Director"
      fill_in "Stage manager", with: "Some Stage manager"
      fill_in "Producer", with: "Some Producer"
      fill_in "Synopsis", with: "Some Description"
      click_on "remove"
      last_nested_fields = all('.fields').first
      within(last_nested_fields) do
        select "2015", :from => "show[show_dates_attributes][0][date(1i)]"
      end
      click_button "Update Show"
      page.should have_content "Show 2"
      page.should have_content "Show was successfully updated"
    end
    specify "Given a show exists I can update it, add a show date" do
      visit show_path(show_with_show_dates.id)
      click_on "Edit"
      page.should have_content "Editing show"
      fill_in "Name", with: "Show 2"
      fill_in "Director", with: "Some Director"
      fill_in "Stage manager", with: "Some Stage manager"
      fill_in "Producer", with: "Some Producer"
      fill_in "Synopsis", with: "Some Description"
      click_on "Add Date"
      last_nested_fields = all('.fields').first
      within(last_nested_fields) do
        select "2015", :from => "show[show_dates_attributes][0][date(1i)]"
      end
      click_button "Update Show"
      page.should have_content "Show 2"
      page.should have_content "Show was successfully updated"
    end
    specify "I cannot update a show with blank fields" do
      visit show_path(show_with_show_dates.id)
      click_on "Edit"
      page.should have_content "Editing show"
      fill_in "Name", with: ""
      click_button "Update Show"
      page.should have_content "can't be blank"
    end
  end

 describe "Deleting shows" do
   let!(:show_with_show_dates) { FactoryGirl.create(:show_with_show_dates) }
   specify "Given a show exists I can delete it" do
     visit show_path(show_with_show_dates.id)
     click_on "Delete"
     #page.driver.browser.switch_to.alert.accept
     page.should_not have_content show_with_show_dates.name
     page.should have_content "Show was successfully destroyed"
   end
 end

end
