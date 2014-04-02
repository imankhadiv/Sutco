require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Add/Edit/Delete trainings" do
  before(:each) do
    role = FactoryGirl.create(:role)
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
  end

  specify "I can create a training" do
    visit new_training_path
    fill_in "Title", with: "Training 1"
    fill_in "Category", with: "Lighting Operator"
    fill_in "Description", with: "Some description"
    fill_in "Date", with: "10/12/2014"
    fill_in "Time", with: "11:45 AM"
    fill_in "Duration", with: "120"
    click_button "Create Training"
    page.should have_content "Training was successfully created"
    page.should have_content "Training 1"
  end

  specify "I cannot create a training with blank fields" do
    #pending "input validation to be added"
    visit new_training_path
    click_button "Create Training"
    page.should have_content "can't be blank"
  end

  let!(:training) { FactoryGirl.create(:training) }

  specify "Given a training exists I can update it" do

    visit training_path(training.id)
    click_link "Edit"
    fill_in "Title", with: "Training 2"
    fill_in "Description", with: "Some Description"
    click_button "Update Training"

    page.should have_content "Training 2"
    page.should have_content "Training was successfully updated"
  end
  specify "I cannot update a training with blank fields" do
    visit training_path(training.id)
    click_link "Edit"
    fill_in "Title", with: ""
    fill_in "Description", with: ""
    click_button "Update Training"
    page.should have_content "can't be blank"
  end
  specify "Given a training exists I can delete it" do
    visit training_path(training.id)
    click_link "Delete"
    page.should_not have_content training.title
    page.should have_content "Training was successfully destroyed"
  end
end

describe "Record attendance" do
let!(:training) { FactoryGirl.create(:training)}
before(:each) do
   role = FactoryGirl.create(:role)
   user = FactoryGirl.create(:user)
   user.roles << role
   login_as(user, :scope => :user)
end

specify "As a Techmanager I can view a list of registered users" do
   user = User.create :email =>"testuser2@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanapproveduser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>TRUE
   training_record = TrainingRecord.create :user_id => user.id, :training_id => training.id

   visit training_path(training.id)
   page.should have_content "View registered users"

   click_on 'View registered users'
   page.should have_content "#{user.firstname}"
   page.should have_content "#{user.lastname}"
   page.should have_content "#{user.email}"
   page.should_not have_content 'attended'
end

specify "As a Techmanager I can record attendance" do
   user = User.create :email =>"testuser2@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanapproveduser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>TRUE
   raining_record = TrainingRecord.create :user_id => user.id, :training_id => training.id

   visit training_path(training.id)
   page.should have_content "View registered users"
   click_on 'View registered users'
   page.check("unattended_ids[]")
   click_on 'Submit'
   page.should have_content "The attendance was successfully updated"
   visit training_path(training.id)
   click_on 'View registered users'
   page.should have_content 'attended'

end
end

describe "Apply for a training sessions" do

let!(:training) { FactoryGirl.create(:training)}
before(:each) do
   role1 = Role.create :name => 'Member'
   user = FactoryGirl.create(:user)
   user.roles << role1
   login_as(user, :scope => :user)
end

specify "As a member, I can Apply for a training session " do
       visit training_path(training.id)
       page.should have_link "Attend Training"

       click_link 'Attend Training'
       page.should have_content "You have successfully registered for #{training.title}"
end

specify "As a member I can not see the apply button If I have already applied for the training" do
   visit training_path(training.id)
   page.should have_link "Attend Training"
   click_link 'Attend Training'
   page.should have_content "You have successfully registered for #{training.title}"
   visit training_path(training.id)
   page.should have_content "You have registered for #{training.title}"
   page.should_not have_link "Attend Training"
end
end

