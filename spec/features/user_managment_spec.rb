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
     page.should_not have_content "Home"
     page.should_not have_content "Event Calendar"
     page.should_not have_content "Shows"
     page.should_not have_content "Workshops"
     page.should_not have_content "Trainings"
   end

   specify "I can visit the site after approval" do

    user1 = User.create :email =>"testuser1@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'myfirstname',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>TRUE
    visit new_user_session_path
    fill_in 'user_email', with: user1.email
    fill_in 'user_password', with: user1.password
    click_button "Sign in"
    page.should_not have_content "Your account has not been approved by your administrator yet."
    page.should have_content "Home"
    page.should have_content "Event Calendar"
    page.should have_content "Shows"
    page.should have_content "Workshops"
    page.should have_content "Trainings"
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

