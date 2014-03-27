require 'spec_helper'

describe "Signing up and signing in" do
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
   page.should have_content "Your Sign up was successful but approval is required from an administrator. When you are approved, you will be able to sign in. Thank you!"

  end

 specify "Do not allow user to sign up without filling all the fields" do
   visit new_user_registration_path
   fill_in "Email", with: "testuser@sheffield.ac.uk"
   fill_in "Password", with: user.password
   fill_in "Password confirmation", with: user.password
   click_button "Sign Up"
   page.should_not have_content "Sign up successful"
  end

 specify "I can not visit the site before approval" do
   user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'myfirstname',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>FALSE
   visit new_user_session_path
   fill_in 'user_email', with: user1.email
   fill_in 'user_password', with: user1.password
   click_button "Sign in"
   page.should have_content "Your account has not been approved by your administrator yet."
   page.should_not have_content "HOME"
   page.should_not have_content "EVENT CALENDAR"
   page.should_not have_content "SHOWS"
   page.should_not have_content "EVENTS"
 end

 specify "I can visit the site after approval" do

  user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'myfirstname',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>TRUE
  visit new_user_session_path
  fill_in 'user_email', with: user1.email
  fill_in 'user_password', with: user1.password
  click_button "Sign in"
  page.should_not have_content "Your account has not been approved by your administrator yet."
  page.should have_content "HOME"
  page.should have_content "EVENT CALENDAR"
  page.should have_content "SHOWS"
  page.should have_content "EVENTS"
 end
end

describe "User approval" do
 specify "As a TechManager, I can view the list of users that is under approval, as well as the list of users that has been approved" do
  role = Role.create :name =>"TechManager"
  user = FactoryGirl.create(:user)
  user.roles << role
  user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanewuser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>FALSE
  user2 = User.create :email =>"testuser2@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanapproveduser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>TRUE
  visit new_user_session_path
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_button "Sign in"
  click_on "Users"
      page.should have_content "List of users awaiting approval"
      page.should have_content "Imanewuser"
      page.should have_content "List of currently approved users"
      page.should have_content "Imanapproveduser"
 end

 specify "As a SeniorCommittee, I can view the list of users that is under approval, as well as the list of users that has been approved" do
  role = Role.create :name =>"SeniorCommittee"
  user = FactoryGirl.create(:user)
  user.roles << role
  user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanewuser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>FALSE
  user2 = User.create :email =>"testuser2@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanapproveduser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>TRUE
  visit new_user_session_path
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_button "Sign in"
  click_on "Users"
  page.should have_content "List of users awaiting approval"
  page.should have_content "Imanewuser"
  page.should have_content "List of currently approved users"
  page.should have_content "Imanapproveduser"
 end


 specify "As a TechManager, I can aprove users and assign roles to them as Member" do
  role = Role.create :name =>"TechManager"
  Role.create :name =>"Member"
  user = FactoryGirl.create(:user)
  user.roles << role
  user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanewuser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>FALSE
  visit new_user_session_path
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_button "Sign in"
  click_on "Users"
  page.should have_content "List of users awaiting approval"
  page.should have_content "Imanewuser"
  page.should have_link "Approve User"
  click_link "Approve User"
  page.should have_content "Edit Approval status and roles for Imanewuser"
  page.should have_content "Approved"
  page.check("user[approved]")
  page.check("Member")
  click_button "Update User"
  page.should_not have_link "Approve User"
  page.should have_content "List of currently approved users"
  page.should have_content "Imanewuser"
 end

 specify "As a SeniorCommittee, I can aprove users and assign roles to them as Member" do
  role = Role.create :name =>"SeniorCommittee"
  Role.create :name =>"Member"
  user = FactoryGirl.create(:user)
  user.roles << role
  user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanewuser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>FALSE
  visit new_user_session_path
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_button "Sign in"
  click_on "Users"
  page.should have_content "List of users awaiting approval"
  page.should have_content "Imanewuser"
  page.should have_link "Approve User"
  click_link "Approve User"
  page.should have_content "Edit Approval status and roles for Imanewuser"
  page.check("user[approved]")
  page.check("Member")
  click_button "Update User"
  page.should_not have_link "Approve User"
  page.should have_content "List of currently approved users"
  page.should have_content "Imanewuser"
 end

 specify "As a TechManager, I can approve users and assign roles to them as ProductionTeam" do
  role = Role.create :name =>"TechManager"
  Role.create :name =>"ProductionTeam"
  user = FactoryGirl.create(:user)
  user.roles << role
  user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanewuser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>FALSE
  visit new_user_session_path
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_button "Sign in"
  click_on "Users"
  page.should have_content "List of users awaiting approval"
  page.should have_content "Imanewuser"
  page.should have_link "Approve User"
  click_link "Approve User"
  page.should have_content "Edit Approval status and roles for Imanewuser"
  page.should have_content "Approved"
  page.check("user[approved]")
  page.check("ProductionTeam")
  click_button "Update User"
  page.should_not have_link "Approve User"
  page.should have_content "List of currently approved users"
  page.should have_content "Imanewuser"
 end

 specify "As a SeniorCommittee, I can approve users and assign roles to them as ProductionTeam" do
  role = Role.create :name =>"SeniorCommittee"
  Role.create :name =>"ProductionTeam"
  user = FactoryGirl.create(:user)
  user.roles << role
  user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanewuser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>FALSE
  visit new_user_session_path
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_button "Sign in"
  click_on "Users"
  page.should have_content "List of users awaiting approval"
  page.should have_content "Imanewuser"
  page.should have_link "Approve User"
  click_link "Approve User"
  page.should have_content "Edit Approval status and roles for Imanewuser"
  page.check("user[approved]")
  page.check("ProductionTeam")
  click_button "Update User"
  page.should_not have_link "Approve User"
  page.should have_content "List of currently approved users"
  page.should have_content "Imanewuser"
 end


 specify "As a TechManager, I can approve users and assign roles to them as Committee" do
  role = Role.create :name =>"TechManager"
  Role.create :name =>"Committee"
  user = FactoryGirl.create(:user)
  user.roles << role
  user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanewuser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>FALSE
  visit new_user_session_path
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_button "Sign in"
  click_on "Users"
  page.should have_content "List of users awaiting approval"
  page.should have_content "Imanewuser"
  page.should have_link "Approve User"
  click_link "Approve User"
  page.should have_content "Edit Approval status and roles for Imanewuser"
  page.should have_content "Approved"
  page.check("user[approved]")
  page.check("Committee")
  click_button "Update User"
  page.should_not have_link "Approve User"
  page.should have_content "List of currently approved users"
  page.should have_content "Imanewuser"
 end

 specify "As a SeniorCommittee, I can approve users and assign roles to them as Committee" do
  role = Role.create :name =>"SeniorCommittee"
  Role.create :name =>"Committee"
  user = FactoryGirl.create(:user)
  user.roles << role
  user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanewuser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>FALSE
  visit new_user_session_path
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_button "Sign in"
  click_on "Users"
  page.should have_content "List of users awaiting approval"
  page.should have_content "Imanewuser"
  page.should have_link "Approve User"
  click_link "Approve User"
  page.should have_content "Edit Approval status and roles for Imanewuser"
  page.check("user[approved]")
  page.check("Committee")
  click_button "Update User"
  page.should_not have_link "Approve User"
  page.should have_content "List of currently approved users"
  page.should have_content "Imanewuser"
 end

 specify "As a TechManager, I can approve users and assign roles to them as DramaStudioManager" do
  role = Role.create :name =>"TechManager"
  Role.create :name =>"DramaStudioManager"
  user = FactoryGirl.create(:user)
  user.roles << role
  user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanewuser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>FALSE
  visit new_user_session_path
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_button "Sign in"
  click_on "Users"
  page.should have_content "List of users awaiting approval"
  page.should have_content "Imanewuser"
  page.should have_link "Approve User"
  click_link "Approve User"
  page.should have_content "Edit Approval status and roles for Imanewuser"
  page.should have_content "Approved"
  page.check("user[approved]")
  page.check("DramaStudioManager")
  click_button "Update User"
  page.should_not have_link "Approve User"
  page.should have_content "List of currently approved users"
  page.should have_content "Imanewuser"
 end

 specify "As a SeniorCommittee, I can approve users and assign roles to them as DramaStudioManager" do
  role = Role.create :name =>"SeniorCommittee"
  Role.create :name =>"DramaStudioManager"
  user = FactoryGirl.create(:user)
  user.roles << role
  user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanewuser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>FALSE
  visit new_user_session_path
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_button "Sign in"
  click_on "Users"
  page.should have_content "List of users awaiting approval"
  page.should have_content "Imanewuser"
  page.should have_link "Approve User"
  click_link "Approve User"
  page.should have_content "Edit Approval status and roles for Imanewuser"
  page.check("user[approved]")
  page.check("DramaStudioManager")
  click_button "Update User"
  page.should_not have_link "Approve User"
  page.should have_content "List of currently approved users"
  page.should have_content "Imanewuser"
 end

 specify "As a TechManager, I can approve users and assign roles to them as SeniorCommittee" do
  role = Role.create :name =>"TechManager"
  Role.create :name =>"SeniorCommittee"
  user = FactoryGirl.create(:user)
  user.roles << role
  user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanewuser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>FALSE
  visit new_user_session_path
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_button "Sign in"
  click_on "Users"
  page.should have_content "List of users awaiting approval"
  page.should have_content "Imanewuser"
  page.should have_link "Approve User"
  click_link "Approve User"
  page.should have_content "Edit Approval status and roles for Imanewuser"
  page.should have_content "Approved"
  page.check("user[approved]")
  page.check("SeniorCommittee")
  click_button "Update User"
  page.should_not have_link "Approve User"
  page.should have_content "List of currently approved users"
  page.should have_content "Imanewuser"
 end

 specify "As a SeniorCommittee, I can approve users and assign roles to them as SeniorCommittee" do
  role = Role.create :name =>"SeniorCommittee"
  Role.create :name =>"SeniorCommittee"
  user = FactoryGirl.create(:user)
  user.roles << role
  user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanewuser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>FALSE
  visit new_user_session_path
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_button "Sign in"
  click_on "Users"
  page.should have_content "List of users awaiting approval"
  page.should have_content "Imanewuser"
  page.should have_link "Approve User"
  click_link "Approve User"
  page.should have_content "Edit Approval status and roles for Imanewuser"
  page.check("user[approved]")
  page.check("SeniorCommittee")
  click_button "Update User"
  page.should_not have_link "Approve User"
  page.should have_content "List of currently approved users"
  page.should have_content "Imanewuser"
 end

 specify "As a TechManager, I can approve users and assign roles to them as SeniorCommittee" do
  role = Role.create :name =>"TechManager"
  Role.create :name =>"SeniorCommittee"
  user = FactoryGirl.create(:user)
  user.roles << role
  user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanewuser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>FALSE
  visit new_user_session_path
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_button "Sign in"
  click_on "Users"
  page.should have_content "List of users awaiting approval"
  page.should have_content "Imanewuser"
  page.should have_link "Approve User"
  click_link "Approve User"
  page.should have_content "Edit Approval status and roles for Imanewuser"
  page.should have_content "Approved"
  page.check("user[approved]")
  page.check("SeniorCommittee")
  click_button "Update User"
  page.should_not have_link "Approve User"
  page.should have_content "List of currently approved users"
  page.should have_content "Imanewuser"
 end

 specify "As a SeniorCommittee, I can approve users and assign roles to them as SeniorCommittee" do
  role = Role.create :name =>"SeniorCommittee"
  Role.create :name =>"SeniorCommittee"
  user = FactoryGirl.create(:user)
  user.roles << role
  user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanewuser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>FALSE
  visit new_user_session_path
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_button "Sign in"
  click_on "Users"
  page.should have_content "List of users awaiting approval"
  page.should have_content "Imanewuser"
  page.should have_link "Approve User"
  click_link "Approve User"
  page.should have_content "Edit Approval status and roles for Imanewuser"
  page.check("user[approved]")
  page.check("SeniorCommittee")
  click_button "Update User"
  page.should_not have_link "Approve User"
  page.should have_content "List of currently approved users"
  page.should have_content "Imanewuser"
 end


end

describe "Profile" do
  specify "As a TechManager, I can view my profile page"  do
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit calendars_path
    click_on "Users"
    click_on "View My Profile"
    page.should have_content "Profile"
    page.should have_content user.email
    page.should have_content user.firstname
    page.should have_content user.lastname
    page.should have_content user.ucard
    page.should have_content user.course
    page.should have_content user.level
  end
  specify "As a Member, I can view my profile page"  do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit calendars_path
    click_on "Profile"
    page.should have_content "Profile"
    page.should have_content user.email
    page.should have_content user.firstname
    page.should have_content user.lastname
    page.should have_content user.ucard
    page.should have_content user.course
    page.should have_content user.level
  end
  specify "As a Member, I can view my profile report"  do
    pending
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit calendars_path
    click_on "Profile"
    click_on "Report"
    page.should have_content "User Profile"
    page.should have_content user.firstname
    page.should have_content user.lastname
    page.should have_content user.course
    page.should have_content user.level
    click_on "Download"
    response_headers["Content-Type"].should == "application/pdf"
  end
  specify "As a TechManager, I can view the profile report"  do
    pending
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit calendars_path
    click_on "Users"
    click_on "View My Profile"
    click_on "Generate Report"
    page.should have_content "User Profile"
    page.should have_content user.firstname
    page.should have_content user.lastname
    page.should have_content user.course
    page.should have_content user.level
    click_on "Download Report"
    response_headers["Content-Type"].should == "application/pdf"
  end
  specify "As a TechManager, I can update my profile page"  do
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit calendars_path
    click_on "Users"
    click_on "View My Profile"
    click_on "Update My Profile"
    fill_in "Password", with: "987654321"
    fill_in "Password confirmation", with: "987654321"
    fill_in "Current password", with: user.password
    fill_in "Firstname", with: "Newname"
    fill_in "Lastname", with: "Newname"
    fill_in "Course", with: "Newcourse"
    fill_in "Ucard", with: "4321"
    select 'Level2'
    click_on "Update"
    page.should have_content "You updated your account successfully."
    page.should have_content "Profile"
    page.should have_content "Newname"
    page.should have_content "Newcourse"
    page.should have_content "4321"
    page.should have_content 'Level2'
  end
  specify "As a Member, I can update my profile page"  do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit calendars_path
    click_on "Profile"
    click_on "Update My Profile"
    fill_in "Password", with: "987654321"
    fill_in "Password confirmation", with: "987654321"
    fill_in "Current password", with: user.password
    fill_in "Firstname", with: "Newname"
    fill_in "Lastname", with: "Newname"
    fill_in "Course", with: "Newcourse"
    fill_in "Ucard", with: "4321"
    select 'Level2'
    click_on "Update"
    page.should have_content "You updated your account successfully."
    page.should have_content "Profile"
    page.should have_content "Newname"
    page.should have_content "Newcourse"
    page.should have_content "4321"
    page.should have_content 'Level2'
  end
end
