require 'spec_helper'


describe "Access control for different roles for social model" do
#creating
  specify "As a member, I can't add socials" do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should_not have_content "Create New Social"
    visit new_social_path
    page.should have_content "You are not authorized to access this page"
  end

  specify "As a production team member, I can add socials" do
    role = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should have_content "Create New Social"
    visit new_social_path
    page.should_not have_content "You are not authorized to access this page"
  end

  specify "As a committee member, I can add socials" do
    role = Role.create :name =>"Committee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should have_content "Create New Social"
    visit new_social_path
    page.should_not have_content "You are not authorized to access this page"
  end

  specify "As a drama studio manager, I can't add socials" do
    role = Role.create :name =>"DramaStudioManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should_not have_content "Create New Social"
    visit new_social_path
    page.should have_content "You are not authorized to access this page"
  end

  specify "As a senior committee, I can add socials" do
    role = Role.create :name =>"SeniorCommittee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should have_content "Create New Social"
    visit new_social_path
    page.should_not have_content "You are not authorized to access this page"
  end

  specify "As a tech manager, I can't add socials" do
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should_not have_content "Create New Social"
    visit new_social_path
    page.should have_content "You are not authorized to access this page"
  end

  let!(:social) { FactoryGirl.create(:social) }
#Editing
  specify "As a member, I can't edit socials" do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should_not have_link "Edit"
         click_on "Social 1"
    page.should_not have_link "Edit"
    visit edit_social_path(social.id)
    page.should have_content "You are not authorized to access this page"
  end

  specify "As a production team member, I can edit socials" do
    role = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should have_link "Edit"
         click_on "Social 1"
    page.should have_link "Edit"
    visit edit_social_path(social.id)
    page.should_not have_content "You are not authorized to access this page"
  end

  specify "As a committee member, I can edit socials" do
    role = Role.create :name =>"Committee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should have_link "Edit"
         click_on "Social 1"
    page.should have_link "Edit"
    visit edit_social_path(social.id)
    page.should_not have_content "You are not authorized to access this page"
  end

  specify "As a drama studio manager, I can't edit socials" do
    role = Role.create :name =>"DramaStudioManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should_not have_link "Edit"
         click_on "Social 1"
    page.should_not have_link "Edit"
    visit edit_social_path(social.id)
    page.should have_content "You are not authorized to access this page"
  end

  specify "As a senior committee, I can edit socials" do
    role = Role.create :name =>"SeniorCommittee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should have_link "Edit"
         click_on "Social 1"
    page.should have_link "Edit"
    visit edit_social_path(social.id)
    page.should_not have_content "You are not authorized to access this page"
  end

  specify "As a tech manager, I can't edit socials" do
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should_not have_link "Edit"
         click_on "Social 1"
    page.should_not have_link "Edit"
    visit edit_social_path(social.id)
    page.should have_content "You are not authorized to access this page"
  end

#Deleting
  specify "As a member, I can't delete socials" do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should_not have_link "Delete"
  end

  specify "As a production team member, I can delete socials" do
    role = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should have_link "Delete"
  end

  specify "As a committee member, I can delete socials" do
    role = Role.create :name =>"Committee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should have_link "Delete"
  end

  specify "As a drama studio manager, I can't delete socials" do
    role = Role.create :name =>"DramaStudioManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should_not have_link "Delete"
  end

  specify "As a senior committee, I can delete socials" do
    role = Role.create :name =>"SeniorCommittee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should have_link "Delete"
  end

  specify "As a tech manager, I can't delete socials" do
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit socials_path
    page.should_not have_link "Delete"
  end

end