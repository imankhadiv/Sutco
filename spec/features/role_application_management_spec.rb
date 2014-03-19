require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Role application tests" do

  before(:each) do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
  end

  describe "Apply for role" do 
    let!(:show_with_show_roles_show_dates) { FactoryGirl.create(:show_with_show_roles_show_dates) }
  	specify "I can create application" do
      visit show_path(show_with_show_roles_show_dates.id)
      click_on "Apply for roles"
      page.should have_content "Why did you apply for the role?"
      fill_in "role_application[content]", with: "I am interested in the role."
      click_on "Submit"
      page.should have_content "Role application was successfully created."
      page.should have_content "I am interested in the role."
      page.should have_content "Pending"
  	end
  end
end

  describe "View role application on record page" do
	let!(:show_with_show_roles_show_dates) { FactoryGirl.create(:show_with_show_roles_show_dates) }
	specify "I can view my application on record page" do
  	 role = Role.create :name =>"Member"
      user = User.create :email =>"testuser2@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanapproveduser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>TRUE
      user.roles << role
      login_as(user, :scope => :user) 
      show_role = ShowRole.create :show_id => show_with_show_roles_show_dates.id, :position => "something", :required_number => "1"
      role_application = RoleApplication.create :user_id => user.id, :show_role_id => show_role.id, :content => "Some content", :status => "Pending"
      visit calendars_path
      click_on "Profile"
      page.should have_content "List of Show Role Records"
      page.should have_content show_with_show_roles_show_dates.name
      click_on "View"
      page.should have_content "Your application for"
  	end 
end 