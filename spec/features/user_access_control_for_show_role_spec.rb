require 'spec_helper'


describe "Access control for different roles for show roles" do
let!(:show_with_show_roles_show_dates) { FactoryGirl.create(:show_with_show_roles_show_dates) }
#creating
  specify "As a member, I cannot remove show roles" do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_roles_show_dates.id)
    page.should_not have_content "Remove Role"
  end

  specify "As a production team member, I can remove show roles" do
    role = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
     visit show_path(show_with_show_roles_show_dates.id)
      click_on "Remove Role"
      page.should have_content "Show 1"
      page.should have_content "Show role was successfully destroyed"
      page.should_not have_content "Lighting operator"
  end

  specify "As a production team member, I can add show roles" do
    role = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_roles_show_dates.id)
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
      page.should have_content "Apply for role"
  end

  specify "As a committee member, I cannot remove show roles" do
    role = Role.create :name =>"Committee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_roles_show_dates.id)
    page.should_not have_content "Remove Role"
  end

  specify "As a drama studio manager, I cannot remove show roles" do
    role = Role.create :name =>"DramaStudioManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_roles_show_dates.id)
    page.should_not have_content "Remove Role"
  end

  specify "As a senior committee, I cannot remove show roles" do
    role = Role.create :name =>"SeniorCommittee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_roles_show_dates.id)
    page.should_not have_content "Remove Role"
  end

  specify "As a tech manager, I cannot remove show roles" do
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_roles_show_dates.id)
    page.should_not have_content "Remove Role"
  end

end