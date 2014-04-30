require 'spec_helper'


describe "Home page provides the entries to the services I have access" do

   specify "As a member, I can view my home page" do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit welcome_path
    page.should have_content "View Calendar"
    page.should_not have_content "Manage Shows"
    page.should_not have_content "Manage Training Sessions"
    page.should_not have_content "Manage Workshops"
    page.should_not have_content "Manage Social Events"
    page.should_not have_content "Manage Users"
    page.should_not have_content "Process User Applications"
    page.should_not have_content "You have unapproved users"
    page.should_not have_content "You have unprocessed role applications"
    page.should_not have_content "View Role Applications"
  end
 
 specify "As a production team member, I can view my home page" do
    role = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit welcome_path
    page.should have_content "View Calendar"
    page.should have_content "Manage Shows"
    page.should_not have_content "Manage Training Sessions"
    page.should_not have_content "Manage Workshops"
    page.should have_content "Manage Social Events"
    page.should_not have_content "Manage Users"
    page.should_not have_content "Process User Applications"
    page.should_not have_content "You have unapproved users"
    page.should_not have_content "You have unprocessed role applications"
    page.should_not have_content "View Role Applications"
  end
  

  specify "As a committee member, I can view my home page" do
    role = Role.create :name =>"Committee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit welcome_path
    page.should have_content "View Calendar"
    page.should_not have_content "Manage Shows"
    page.should_not have_content "Manage Training Sessions"
    page.should_not have_content "Manage Workshops"
    page.should have_content "Manage Social Events"
    page.should_not have_content "Manage Users"
    page.should_not have_content "Process User Applications"
    page.should_not have_content "You have unapproved users"
    page.should_not have_content "You have unprocessed role applications"
    page.should_not have_content "View Role Applications"
  end

  specify "As a drama studio manager, I can view my home page" do
    role = Role.create :name =>"DramaStudioManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit welcome_path
    page.should have_content "View Calendar"
    page.should_not have_content "Manage Shows"
    page.should_not have_content "Manage Training Sessions"
    page.should_not have_content "Manage Workshops"
    page.should_not have_content "Manage Social Events"
    page.should_not have_content "Manage Users"
    page.should_not have_content "Process User Applications"
    page.should_not have_content "You have unapproved users"
    page.should_not have_content "You have unprocessed role applications"
    page.should_not have_content "View Role Applications"
  end

  specify "As a senior committee, I can view my home page, no user application" do
    role = Role.create :name =>"SeniorCommittee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit welcome_path
    page.should have_content "View Calendar"
    page.should_not have_content "Manage Shows"
    page.should have_content "Manage Training Sessions"
    page.should have_content "Manage Workshops"
    page.should have_content "Manage Social Events"
    page.should have_content "Manage Users"
    page.should_not have_content "Process User Applications"
    page.should_not have_content "You have unapproved users"
    page.should_not have_content "You have unprocessed role applications"
    page.should_not have_content "View Role Applications"
  end
  
    specify "As a senior committee, I can view my home page, has pending user application" do
    role = Role.create :name =>"SeniorCommittee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'myfirstname',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>FALSE
    visit welcome_path
    page.should have_content "View Calendar"
    page.should_not have_content "Manage Shows"
    page.should have_content "Manage Training Sessions"
    page.should have_content "Manage Workshops"
    page.should have_content "Manage Social Events"
    page.should have_content "You have unapproved users"
    page.should_not have_content "You have unprocessed role applications"
    page.should_not have_content "View Role Applications"
  end

	specify "As a tech manager, I can view my home page, has no application" do
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit welcome_path
    page.should have_content "View Calendar"
    page.should_not have_content "Manage Shows"
    page.should have_content "Manage Training Sessions"
    page.should have_content "Manage Workshops"
    page.should_not have_content "Manage Social Events"
    page.should have_content "Manage Users"
    page.should_not have_content "Process User Applications"
    page.should_not have_content "You have unapproved users"
    page.should_not have_content "You have unprocessed role applications"
    page.should have_content "View Role Applications"
  end
  
	let!(:show_with_show_roles_show_dates) { FactoryGirl.create(:show_with_show_roles_show_dates) }
  specify "As a tech manager, I can view my home page, has pending role application" do
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_roles_path
    click_on "Apply for role"
    page.should have_content "Why are you applying for this role?"
    fill_in "role_application[content]", with: "I am interested in the role."
    click_on "Submit"
    visit welcome_path
    page.should have_content "View Calendar"
    page.should_not have_content "Manage Shows"
    page.should have_content "Manage Training Sessions"
    page.should have_content "Manage Workshops"
    page.should_not have_content "Manage Social Events"
    page.should have_content "Manage Users"
    page.should_not have_content "You have unapproved users"
    page.should have_content "You have unprocessed role applications"
    page.should_not have_content "View Role Applications"
  end
  
  specify "As a tech manager, I can view my home page, has pending user application" do
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'myfirstname',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>FALSE
    visit welcome_path
    page.should have_content "View Calendar"
    page.should_not have_content "Manage Shows"
    page.should have_content "Manage Training Sessions"
    page.should have_content "Manage Workshops"
    page.should_not have_content "Manage Social Events"
    page.should have_content "You have unapproved users"
    page.should_not have_content "You have unprocessed role applications"
    page.should have_content "View Role Applications"
  end
  
end