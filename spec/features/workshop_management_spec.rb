require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Workshop tests" do
 before(:each) do
 role = FactoryGirl.create(:role)
	    user = FactoryGirl.create(:user)
user.roles << role
			login_as(user, :scope => :user)
end
		describe "Creating workshops" do
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
		  	#pending "input validation to be added"
		    visit new_workshop_path
		    click_button "Create Workshop"
		    page.should have_content "can't be blank"
		  end
		end
		
		describe "Updating workshops" do
		
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
		end
		
		### No option for it ! 
		
		
		 describe "Deleting workshops" do
		
		   let!(:workshop) { FactoryGirl.create(:workshop) }
		
		   specify "Given a workshop exists I can delete it" do
		
		     visit workshops_path
		     click_link "Delete"
		     page.should_not have_content workshop.title
		     page.should have_content "Workshop was successfully destroyed"
		   end
		 end


end
