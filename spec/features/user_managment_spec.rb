require 'spec_helper'

 describe "Signing up" do
   let!(:user) { FactoryGirl.create(:user) }
   specify "I can sign up" do
     visit new_user_registration_path
     fill_in "Email", with: "testuser@sheffield.ac.uk"
     fill_in "Password", with: user.password
     fill_in "Password confirmation", with: user.password
     fill_in "Firstname", with: user.firstname
     fill_in "Lastname", with: user.lastname
     fill_in "Course", with: user.course
     fill_in "Ucard", with: user.ucard
     select 'Level1'

     click_button "Sign Up"
     page.should have_content "Sign up successful"
     page.should have_content "Your Sign up was successful but approval is required from an administrator. When you are approved, you will be able to sign in. Thank you! Sign In ©2014 Genesys Solutions"

    end

   specify "I can not Sign in before approval" do
     visit new_user_session_path
     fill_in "Email", with: user.email
     fill_in "Password", with: user.password
     user.approved = false
     user.save
     click_button "Sign in"
     page.should have_content "Your account has not been approved by your administrator yet."

   end

   specify "I can sign in after approval" do
     visit new_user_session_path
     fill_in "Email", with: user.email
     fill_in "Password", with: user.password
     click_button "Sign in"
     page.should have_content "Signed in successfully."

   end
 end

describe "Access control for different roles" do

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

  specify "As a production team member, I can't add shows" do
    role = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should_not have_content "Create New Show"
    visit new_show_path
    page.should have_content "You are not authorized to access this page"
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

  specify "As a senior committee, I can add shows" do
    role = Role.create :name =>"SeniorCommittee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should have_content "Create New Show"
    visit new_show_path
    page.should_not have_content "You are not authorized to access this page"
  end

  specify "As a tech manager, I can add shows" do
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should have_content "Create New Show"
    visit new_show_path
    page.should_not have_content "You are not authorized to access this page"
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

 specify "As a production team member, I can't edit shows" do
    role = Role.create :name =>"ProductionTeam"
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

 specify "As a senior committee, I can edit shows" do
    role = Role.create :name =>"SeniorCommittee"
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

 specify "As a tech manager, I can edit shows" do
    role = Role.create :name =>"TechManager"
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

 specify "As a production team member, I can't delete shows" do
    role = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should_not have_link "Delete"
    click_on "Show 1"
    page.should_not have_link "Delete"
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

 specify "As a senior committee, I can delete shows" do
    role = Role.create :name =>"SeniorCommittee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should have_link "Delete"
    click_on "Show 1"
    page.should have_link "Delete"
  end

 specify "As a tech manager, I can delete shows" do
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit shows_path
    page.should have_link "Delete"
    click_on "Show 1"
    page.should have_link "Delete"
  end

end

