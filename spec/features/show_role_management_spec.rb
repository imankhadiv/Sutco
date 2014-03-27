require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Show role tests" do

  before(:each) do
    role = Role.create :name =>"DramaStudioManager"
    role1 = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    user.roles << role1
    login_as(user, :scope => :user)
  end


  describe "Add/Delete roles to a show" do

    let!(:show_with_show_roles) { FactoryGirl.create(:show_with_show_roles) }
    specify "Given a show exists I can add a show role to it" do
      visit show_path(show_with_show_roles.id)
      click_on "Edit"
      page.should have_content "Editing show"
      fill_in "Name", with: "Show 2"
      fill_in "Director", with: "Some Director"
      fill_in "Stage manager", with: "Some Stage manager"
      fill_in "Producer", with: "Some Producer"
      fill_in "Synopsis", with: "Some Description"
      click_on "Add Role"
      last_nested_fields = all('.fields').last
      within(last_nested_fields) do
        select "Lighting Designer", :from => "show[show_roles_attributes][0][position]"
        fill_in "show[show_roles_attributes][0][required_number]", with: "2"
      end
      click_button "Update Show"
      page.should have_content "Show 2"
      page.should have_content "Show was successfully update"
      page.should have_content "Lighting Designer"
    end

    let!(:show_with_show_roles) { FactoryGirl.create(:show_with_show_roles) }
    specify "Given a show exists I can remove a show role from it" do
      visit show_path(show_with_show_roles.id)
      click_on "Remove Role"
      page.should have_content "Show 1"
      page.should have_content "Show role was successfully destroyed"
      page.should_not have_content "Lighting operator"

    end

    specify "I cannot add an empty show role" do
    visit show_path(show_with_show_roles.id)
      click_on "Edit"
      page.should have_content "Editing show"
      click_on "Add Role"
      last_nested_fields = all('.fields').last
      within(last_nested_fields) do
        select "other", :from => "show[show_roles_attributes][0][position]"
        fill_in "show[show_roles_attributes][0][required_number]", with: ""
      end
      click_button "Update Show"
      page.should have_content "required number is not a number"
    end
  end

end
