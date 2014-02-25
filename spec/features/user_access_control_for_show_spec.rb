require 'spec_helper'


describe "Access control for different roles for show model" do
#creating
  specify "As a member, I can't add shows" do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should_not have_content "Create New Show"
    visit new_show_path
    page.should have_content "You are not authorized to access this page"
  end

  specify "As a production team member, I can add shows" do
    role = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should have_content "Create New Show"
    visit new_show_path
    page.should_not have_content "You are not authorized to access this page"
  end

  specify "As a committee member, I can't add shows" do
    role = Role.create :name =>"Committee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should_not have_content "Create New Show"
    visit new_show_path
    page.should have_content "You are not authorized to access this page"
  end

  specify "As a drama studio manager, I can't add shows" do
    role = Role.create :name =>"DramaStudioManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should_not have_content "Create New Show"
    visit new_show_path
    page.should have_content "You are not authorized to access this page"
  end

  specify "As a senior committee, I can't add shows" do
    role = Role.create :name =>"SeniorCommittee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should_not have_content "Create New Show"
    visit new_show_path
    page.should have_content "You are not authorized to access this page"
  end

  specify "As a tech manager, I can't add shows" do
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should_not have_content "Create New Show"
    visit new_show_path
    page.should have_content "You are not authorized to access this page"
  end

  let!(:show_with_show_dates) { FactoryGirl.create(:show_with_show_dates) }
#Editing
  specify "As a member, I can't edit shows" do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should_not have_link "Edit"
    click_on "Show 1"
    page.should_not have_link "Edit"
    visit edit_show_path(show_with_show_dates.id)
    page.should have_content "You are not authorized to access this page"
  end

  specify "As a production team member, I can edit shows" do
    role = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should have_link "Edit"
    click_on "Show 1"
    page.should have_link "Edit"
    visit edit_show_path(show_with_show_dates.id)
    page.should_not have_content "You are not authorized to access this page"
  end

  specify "As a committee member, I can't edit shows" do
    role = Role.create :name =>"Committee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should_not have_link "Edit"
    click_on "Show 1"
    page.should_not have_link "Edit"
    visit edit_show_path(show_with_show_dates.id)
    page.should have_content "You are not authorized to access this page"
  end

  specify "As a drama studio manager, I can't edit shows" do
    role = Role.create :name =>"DramaStudioManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should_not have_link "Edit"
    click_on "Show 1"
    page.should_not have_link "Edit"
    visit edit_show_path(show_with_show_dates.id)
    page.should have_content "You are not authorized to access this page"
  end

  specify "As a senior committee, I can't edit shows" do
    role = Role.create :name =>"SeniorCommittee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should_not have_link "Edit"
    click_on "Show 1"
    page.should_not have_link "Edit"
    visit edit_show_path(show_with_show_dates.id)
    page.should have_content "You are not authorized to access this page"
  end

  specify "As a tech manager, I can't edit shows" do
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should_not have_link "Edit"
    click_on "Show 1"
    page.should_not have_link "Edit"
    visit edit_show_path(show_with_show_dates.id)
    page.should have_content "You are not authorized to access this page"
  end

#Deleting
  specify "As a member, I can't delete shows" do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should_not have_link "Delete"
    click_on "Show 1"
    page.should_not have_link "Delete"
  end

  specify "As a production team member, I can delete shows" do
    role = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should have_link "Delete"
    click_on "Show 1"
    page.should have_link "Delete"
  end

  specify "As a committee member, I can't delete shows" do
    role = Role.create :name =>"Committee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should_not have_link "Delete"
    click_on "Show 1"
    page.should_not have_link "Delete"
  end

  specify "As a drama studio manager, I can't delete shows" do
    role = Role.create :name =>"DramaStudioManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should_not have_link "Delete"
    click_on "Show 1"
    page.should_not have_link "Delete"
  end

  specify "As a senior committee, I can't delete shows" do
    role = Role.create :name =>"SeniorCommittee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should_not have_link "Delete"
    click_on "Show 1"
    page.should_not have_link "Delete"
  end

  specify "As a tech manager, I can't delete shows" do
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should_not have_link "Delete"
    click_on "Show 1"
    page.should_not have_link "Delete"
  end

end