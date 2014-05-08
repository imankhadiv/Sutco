require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Add/Edit/Delete workshops" do
  before(:each) do
    role = FactoryGirl.create(:role)
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
  end

  specify "I can create a workshop" do
    visit new_workshop_path
    fill_in "Title", with: "Workshop 1"
    fill_in "Description", with: "Some description"
    fill_in "Date", with: "10/12/2014"
    fill_in "Time", with: "11:45 AM"
    fill_in "Duration", with: "120"
    click_button "Create Workshop"
    page.should have_content "Workshop was successfully created"
    page.should have_content "Workshop 1"
  end

  specify "I cannot create a workshop with blank fields" do
    visit new_workshop_path
    click_button "Create Workshop"
    page.should have_content "can't be blank"
  end

  let!(:workshop) { FactoryGirl.create(:workshop) }

  specify "Given a workshop exists I can update it" do

    visit workshops_path
    click_link "Edit"
    fill_in "Title", with: "Workshop 2"
    fill_in "Description", with: "Some Description"
    click_button "Update Workshop"

    page.should have_content "Workshop 2"
    page.should have_content "Workshop was successfully updated"
  end
  specify "I cannot update a workshop with blank fields" do
    visit workshops_path
    click_link "Edit"
    fill_in "Title", with: ""
    fill_in "Description", with: ""
    click_button "Update Workshop"
    page.should have_content "can't be blank"
  end

  specify "Given a workshop exists I can delete it" do
    visit workshops_path
    click_link "Delete"
    page.should_not have_content workshop.title
    page.should have_content "Workshop was successfully destroyed"
  end
end

describe "Record attendance" do
  let!(:workshop) { FactoryGirl.create(:workshop)}
  before(:each) do
    role = FactoryGirl.create(:role)
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
  end

  specify "As a Techmanager I can view a list of registered users" do
    user = User.create :email =>"testuser2@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanapproveduser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>TRUE
    workshop_record = WorkshopRecord.create :user_id => user.id, :workshop_id => workshop.id

    visit workshop_path(workshop.id)
    page.should have_content "View registered users"

    click_on 'View registered users'
    page.should have_content "#{user.firstname}"
    page.should have_content "#{user.lastname}"
    page.should have_content "#{user.email}"
    page.should_not have_content 'attended'
  end

  specify "As a Techmanager I can record attendance" do
    user = User.create :email =>"testuser2@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanapproveduser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>TRUE
    raining_record = WorkshopRecord.create :user_id => user.id, :workshop_id => workshop.id

    visit workshop_path(workshop.id)
    page.should have_content "View registered users"
    click_on 'View registered users'
    page.check("unattended_ids[]")
    click_on 'Submit'
    page.should have_content "Attendance was successfully updated"
    visit workshop_path(workshop.id)
    click_on 'View registered users'
    page.should have_content 'attended'

  end
end

describe "Apply for a workshop sessions" do

  let!(:workshop) { FactoryGirl.create(:workshop)}
  before(:each) do
    role1 = Role.create :name => 'Member'
    user = FactoryGirl.create(:user)
    user.roles << role1
    login_as(user, :scope => :user)
  end

  specify "As a member, I can Apply for a workshop session " do
    visit workshop_path(workshop.id)
    page.should have_link "Attend Workshop"

    click_link 'Attend Workshop'
    page.should have_content "You have successfully registered for #{workshop.title}"
  end

  specify "As a member I can not see the apply button If I have already applied for the workshop" do
    visit workshop_path(workshop.id)
    page.should have_link "Attend Workshop"
    click_link 'Attend Workshop'
    page.should have_content "You have successfully registered for #{workshop.title}"
    visit workshop_path(workshop.id)
    page.should have_content "You have registered for #{workshop.title}"
    page.should_not have_link "Attend Workshop"
  end
end

