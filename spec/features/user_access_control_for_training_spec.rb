require 'spec_helper'

describe "Access control for different roles for training model" do
  describe "Creating trainings: " do
    specify "As a member, I can't add training" do
      role = Role.create :name =>"Member"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should_not have_content "Create New Training"
      visit new_training_path
      page.should have_content "You are not authorized to access this page"
    end

    specify "As a production team member, I can't add trainings" do
      role = Role.create :name =>"ProductionTeam"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should_not have_content "Create New Training"
      visit new_training_path
      page.should have_content "You are not authorized to access this page"
    end

    specify "As a committee member, I can't add trainings" do
      role = Role.create :name =>"Committee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should_not have_content "Create New Training"
      visit new_training_path
      page.should have_content "You are not authorized to access this page"
    end

    specify "As a drama studio manager, I can't add trainings" do
      role = Role.create :name =>"DramaStudioManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should_not have_content "Create New Training"
      visit new_training_path
      page.should have_content "You are not authorized to access this page"
    end

    specify "As a senior committee, I can add trainings" do
      role = Role.create :name =>"SeniorCommittee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should have_content "Create New Training"
      visit new_training_path
      page.should_not have_content "You are not authorized to access this page"
    end

    specify "As a tech manager, I can add trainings" do
      role = Role.create :name =>"TechManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should have_content "Create New Training"
      visit new_training_path
      page.should_not have_content "You are not authorized to access this page"
    end
  end

  describe "Editing trainings: " do
    let!(:training) { FactoryGirl.create(:training) }
#Editing
    specify "As a member, I can't Edit trainings" do
      role = Role.create :name =>"Member"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should_not have_link "Edit"
      visit training_path(training.id)
      page.should_not have_link "Edit"
      visit edit_training_path(training.id)
      page.should have_content "You are not authorized to access this page"
    end

    specify "As a production team member, I can't Edit trainings" do
      role = Role.create :name =>"ProductionTeam"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should_not have_link "Edit"
      visit training_path(training.id)
      page.should_not have_link "Edit"
      visit edit_training_path(training.id)
      page.should have_content "You are not authorized to access this page"
    end

    specify "As a committee member, I can't Edit trainings" do
      role = Role.create :name =>"Committee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should_not have_link "Edit"
      visit training_path(training.id)
      page.should_not have_link "Edit"
      visit edit_training_path(training.id)
      page.should have_content "You are not authorized to access this page"
    end

    specify "As a drama studio manager, I can't Edit trainings" do
      role = Role.create :name =>"DramaStudioManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should_not have_link "Edit"
      visit training_path(training.id)
      page.should_not have_link "Edit"
      visit edit_training_path(training.id)
      page.should have_content "You are not authorized to access this page"
    end

    specify "As a senior committee, I can Edit trainings" do
      role = Role.create :name =>"SeniorCommittee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should have_content "Edit"
      visit training_path(training.id)
      page.should have_link "Edit"
      visit edit_training_path(training.id)
      page.should_not have_content "You are not authorized to access this page"
    end

    specify "As a tech manager, I can Edit trainings" do
      role = Role.create :name =>"TechManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should have_link "Edit"
      visit training_path(training.id)
      page.should have_link "Edit"
      visit edit_training_path(training.id)
      page.should_not have_content "You are not authorized to access this page"
    end
  end
  describe "Deleting trainings: " do
    let!(:training) { FactoryGirl.create(:training) }
    #Deleting
    specify "As a member, I can't Delete trainings" do
      role = Role.create :name =>"Member"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should_not have_link "Delete"
      visit training_path(training.id)
      page.should_not have_link "Delete"
    end

    specify "As a production team member, I can't Delete trainings" do
      role = Role.create :name =>"ProductionTeam"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should_not have_link "Delete"
      visit training_path(training.id)
      page.should_not have_link "Delete"
    end

    specify "As a committee member, I can't Delete trainings" do
      role = Role.create :name =>"Committee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should_not have_link "Delete"
      visit training_path(training.id)
      page.should_not have_link "Delete"
    end

    specify "As a drama studio manager, I can't Delete trainings" do
      role = Role.create :name =>"DramaStudioManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should_not have_link "Delete"
      visit training_path(training.id)
      page.should_not have_link "Delete"
    end

    specify "As a senior committee, I can Delete trainings" do
      role = Role.create :name =>"SeniorCommittee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should have_link "Delete"
      visit training_path(training.id)
      page.should have_link "Delete"
    end

    specify "As a tech manager, I can Delete trainings" do
      role = Role.create :name =>"TechManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      page.should have_link "Delete"
      visit training_path(training.id)
      page.should have_link "Delete"
    end
  end

  describe "Applying for traings:" do
    let!(:training) { FactoryGirl.create(:training) }
    specify "As a member, I can Apply for a training session" do
      role = Role.create :name =>"Member"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit training_path(training.id)
      page.should have_link "Attend Training"
      click_link 'Attend Training'
      page.should have_content "You have successfully registered for #{training.title}"
    end

    specify "As a production team member, I can Apply for a training session" do
      role = Role.create :name =>"ProductionTeam"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit training_path(training.id)
      page.should have_link "Attend Training"
      click_link 'Attend Training'
      page.should have_content "You have successfully registered for #{training.title}"
    end

    specify "As a committee member, I can Apply for a training session" do
      role = Role.create :name =>"Committee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit training_path(training.id)
      page.should have_link "Attend Training"
      click_link 'Attend Training'
      page.should have_content "You have successfully registered for #{training.title}"
    end

    specify "As a drama studio manager, I can Apply for a training session" do
      role = Role.create :name =>"DramaStudioManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit training_path(training.id)
      page.should have_link "Attend Training"
      click_link 'Attend Training'
      page.should have_content "You have successfully registered for #{training.title}"
    end

    specify "As a senior committee, I can Apply for a training session" do
      role = Role.create :name =>"SeniorCommittee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit training_path(training.id)
      page.should have_link "Attend Training"
      click_link 'Attend Training'
      page.should have_content "You have successfully registered for #{training.title}"
    end

    specify "As a tech manager, I can Apply for a training session" do
      role = Role.create :name =>"TechManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit training_path(training.id)
      page.should have_link "Attend Training"
      click_link 'Attend Training'
      page.should have_content "You have successfully registered for #{training.title}"
    end
  end

  describe "Recording training attendance: " do
    let!(:training) { FactoryGirl.create(:training)}
    before(:each) do
      user = User.create :email =>"testuser2@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanapproveduser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>TRUE
      training_record = TrainingRecord.create :user_id => user.id, :training_id => training.id
    end

    specify "As a member, I can't record attendance for a training" do
      role = Role.create :name =>"Member"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      visit training_path(training.id)
      page.should_not have_content "View registered users"
    end

    specify "As a production team member, I can't record attendance for a training" do
      role = Role.create :name =>"ProductionTeam"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      visit training_path(training.id)
      page.should_not have_content "View registered users"
    end

    specify "As a committee member, I can't record attendance for a training" do
      role = Role.create :name =>"Committee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      visit training_path(training.id)
      page.should_not have_content "View registered users"
    end

    specify "As a drama studio manager, I can't record attendance for a training" do
      role = Role.create :name =>"DramaStudioManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      visit training_path(training.id)
      page.should_not have_content "View registered users"
    end

    specify "As a senior committee, I can't record attendance for a training" do
      role = Role.create :name =>"SeniorCommittee"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      visit training_path(training.id)
      page.should_not have_content "View registered users"
    end

    specify "As a tech manager, I can record attendance for a training" do
      role = Role.create :name =>"TechManager"
      user = FactoryGirl.create(:user)
      user.roles << role
      login_as(user, :scope => :user)
      visit trainings_path
      visit training_path(training.id)
      page.should have_content "View registered users"
      click_on 'View registered users'
      page.check("unattended_ids[]")
      click_on 'Submit'
      page.should have_content "The attendance was successfully updated"
      visit trainings_path
      visit training_path(training.id)
      click_on 'View registered users'
      page.should have_content 'attended'
    end
  end
end