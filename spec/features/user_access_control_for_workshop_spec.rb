require 'spec_helper'

describe "Access control for different roles for workshop model" do
  describe "Creating workshops: " do
    specify "As a member, I can't add workshop" do
      role = Role.create :name =>"Member"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should_not have_content "Create New Workshop"
      visit new_workshop_path
      page.should have_content "You are not authorized to access this page"
    end

    specify "As a production team member, I can't add workshops" do
      role = Role.create :name =>"ProductionTeam"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should_not have_content "Create New Workshop"
      visit new_workshop_path
      page.should have_content "You are not authorized to access this page"
    end

    specify "As a committee member, I can't add workshops" do
      role = Role.create :name =>"Committee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should_not have_content "Create New Workshop"
      visit new_workshop_path
      page.should have_content "You are not authorized to access this page"
    end

    specify "As a drama studio manager, I can't add workshops" do
      role = Role.create :name =>"DramaStudioManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should_not have_content "Create New Workshop"
      visit new_workshop_path
      page.should have_content "You are not authorized to access this page"
    end

    specify "As a senior committee, I can add workshops" do
      role = Role.create :name =>"SeniorCommittee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should have_content "Create New Workshop"
      visit new_workshop_path
      page.should_not have_content "You are not authorized to access this page"
    end

    specify "As a tech manager, I can add workshops" do
      role = Role.create :name =>"TechManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should have_content "Create New Workshop"
      visit new_workshop_path
      page.should_not have_content "You are not authorized to access this page"
    end
  end

  describe "Editing workshops: " do
    let!(:workshop) { FactoryGirl.create(:workshop) }
#Editing
    specify "As a member, I can't edit workshops" do
      pending "Interface to be modified"
      role = Role.create :name =>"Member"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should_not have_link "Edit"
      click_on "View"
      page.should_not have_link "Edit"
      visit edit_workshop_path(workshop.id)
      page.should have_content "You are not authorized to access this page"
    end

    specify "As a production team member, I can't edit workshops" do
      pending "Interface to be modified"
      role = Role.create :name =>"ProductionTeam"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should_not have_link "Edit"
      click_on "View"
      page.should_not have_link "Edit"
      visit edit_workshop_path(workshop.id)
      page.should have_content "You are not authorized to access this page"
    end

    specify "As a committee member, I can't edit workshops" do
      pending "Interface to be modified"
      role = Role.create :name =>"Committee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should_not have_link "Edit"
      click_on "View"
      page.should_not have_link "Edit"
      visit edit_workshop_path(workshop.id)
      page.should have_content "You are not authorized to access this page"
    end

    specify "As a drama studio manager, I can't edit workshops" do
      pending "Interface to be modified"
      role = Role.create :name =>"DramaStudioManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should_not have_link "Edit"
      click_on "View"
      page.should_not have_link "Edit"
      visit edit_workshop_path(workshop.id)
      page.should have_content "You are not authorized to access this page"
    end

    specify "As a senior committee, I can edit workshops" do
      pending "Interface to be modified"
      role = Role.create :name =>"SeniorCommittee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should have_link "Edit"
      click_on "View"
      page.should have_link "Edit"
      visit edit_workshop_path(workshop.id)
      page.should_not have_content "You are not authorized to access this page"
    end

    specify "As a tech manager, I can edit workshops" do
      pending "Interface to be modified"
      role = Role.create :name =>"TechManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should have_link "Edit"
      click_on "View"
      page.should have_link "Edit"
      visit edit_workshop_path(workshop.id)
      page.should_not have_content "You are not authorized to access this page"
    end
  end
  describe "Deleting workshops: " do
    let!(:workshop) { FactoryGirl.create(:workshop) }
    #Deleting
    specify "As a member, I can't delete workshops" do
      pending "Interface to be modified"
      role = Role.create :name =>"Member"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should_not have_link "Delete"
      click_on "View"
      page.should_not have_link "Delete"
    end

    specify "As a production team member, I can't delete workshops" do
      pending "Interface to be modified"
      role = Role.create :name =>"ProductionTeam"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should_not have_link "Delete"
      click_on "View"
      page.should_not have_link "Delete"
    end

    specify "As a committee member, I can't delete workshops" do
      pending "Interface to be modified"
      role = Role.create :name =>"Committee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should_not have_link "Delete"
      click_on "View"
      page.should_not have_link "Delete"
    end

    specify "As a drama studio manager, I can't delete workshops" do
      pending "Interface to be modified"
      role = Role.create :name =>"DramaStudioManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should_not have_link "Delete"
      click_on "View"
      page.should_not have_link "Delete"
    end

    specify "As a senior committee, I can delete workshops" do
      pending "Interface to be modified"
      role = Role.create :name =>"SeniorCommittee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should have_link "Delete"
      click_on "View"
      page.should have_link "Delete"
    end

    specify "As a tech manager, I can delete workshops" do
      pending "Interface to be modified"
      role = Role.create :name =>"TechManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      page.should have_link "Delete"
      click_on "View"
      page.should have_link "Delete"
    end
  end

  describe "Applying for traings:" do

    let!(:workshop) { FactoryGirl.create(:workshop) }

    specify "As a member, I can Apply for a workshop session" do
      role = Role.create :name =>"Member"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshop_path(workshop.id)
      page.should have_link "Attend Workshop"
      click_link 'Attend Workshop'
      page.should have_content "You have successfully registered for #{workshop.title}"
    end

    specify "As a production team member, I can Apply for a workshop session" do
      role = Role.create :name =>"ProductionTeam"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshop_path(workshop.id)
      page.should have_link "Attend Workshop"
      click_link 'Attend Workshop'
      page.should have_content "You have successfully registered for #{workshop.title}"
    end

    specify "As a committee member, I can Apply for a workshop session" do
      role = Role.create :name =>"Committee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshop_path(workshop.id)
      page.should have_link "Attend Workshop"
      click_link 'Attend Workshop'
      page.should have_content "You have successfully registered for #{workshop.title}"
    end

    specify "As a drama studio manager, I can Apply for a workshop session" do
      role = Role.create :name =>"DramaStudioManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshop_path(workshop.id)
      page.should have_link "Attend Workshop"
      click_link 'Attend Workshop'
      page.should have_content "You have successfully registered for #{workshop.title}"
    end

    specify "As a senior committee, I can Apply for a workshop session" do
      role = Role.create :name =>"SeniorCommittee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshop_path(workshop.id)
      page.should have_link "Attend Workshop"
      click_link 'Attend Workshop'
      page.should have_content "You have successfully registered for #{workshop.title}"
    end

    specify "As a tech manager, I can Apply for a workshop session" do
      role = Role.create :name =>"TechManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshop_path(workshop.id)
      page.should have_link "Attend Workshop"
      click_link 'Attend Workshop'
      page.should have_content "You have successfully registered for #{workshop.title}"
    end
  end
  describe "Recording workshop attendance: " do
    let!(:workshop) { FactoryGirl.create(:workshop)}
    before(:each) do
      user = User.create :email =>"testuser2@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanapproveduser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>TRUE
      workshop_record = WorkshopRecord.create :user_id => user.id, :workshop_id => workshop.id
    end

    specify "As a member, I can't record attendance for a workshop" do
      role = Role.create :name =>"Member"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      click_on "View"
      page.should_not have_content "View registered users"
    end

    specify "As a production team member, I can't record attendance for a workshop" do
      role = Role.create :name =>"ProductionTeam"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      click_on "View"
      page.should_not have_content "View registered users"
    end

    specify "As a committee member, I can't record attendance for a workshop" do
      role = Role.create :name =>"Committee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      click_on "View"
      page.should_not have_content "View registered users"
    end

    specify "As a drama studio manager, I can't record attendance for a workshop" do
      role = Role.create :name =>"DramaStudioManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      click_on "View"
      page.should_not have_content "View registered users"
    end

    specify "As a senior committee, I can't record attendance for a workshop" do
      pending "SeniorCommittee recording attendance, to be confirmed and updated"
      role = Role.create :name =>"SeniorCommittee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      click_on "View"
      page.should_not have_content "View registered users"
    end

    specify "As a tech manager, I can record attendance for a workshop" do
      role = Role.create :name =>"TechManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit workshops_path
      click_on "View"
      page.should have_content "View registered users"
      click_on 'View registered users'
      page.check("unattended_ids[]")
      click_on 'Submit'
      page.should have_content "Attendance was successfully updated"
      visit workshops_path
      click_on "View"
      click_on 'View registered users'
      page.should have_content 'attended'
    end
  end
end