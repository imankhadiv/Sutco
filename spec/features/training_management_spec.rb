require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Training tests" do
 before(:each) do
 role = FactoryGirl.create(:role)
	    user = FactoryGirl.create(:user)
user.roles << role
			login_as(user, :scope => :user)
end
		describe "Creating trainings" do
		  specify "I can create a training" do
		    visit new_training_path
		    fill_in "Title", with: "Training 1"
		    fill_in "Category", with: "Lighting Operator"
		    fill_in "Description", with: "Some description"
		    fill_in "Date", with: "10/12/2013"
		    fill_in "Time", with: "11:45 AM"
		    click_button "Create Training"
		    page.should have_content "Training was successfully created"
		    page.should have_content "Training 1"
		
		
		  end
		
		  specify "I cannot create a training with blank fields" do
		  	pending "input validation to be added"
		    visit new_training_path
		    click_button "Create Training"
		    page.should have_content "can't be blank"
		  end
		end
		
		describe "Updating trainings" do
		
		  let!(:training) { FactoryGirl.create(:training) }
		
		  specify "Given a training exists I can update it" do
		    visit trainings_path
		    click_link "Edit"
		    fill_in "Title", with: "Training 2"
		    fill_in "Description", with: "Some Description"
		    click_button "Update Training"
		
		    page.should have_content "Training 2"
		    page.should have_content "Training was successfully updated"
		  end
		end
		
		### No option for it ! 
		
		
		 describe "Deleting trainings" do
		
		   let!(:training) { FactoryGirl.create(:training) }
		
		   specify "Given a training exists I can delete it" do
		
		     visit trainings_path
		     click_link "Destroy"
		     page.should_not have_content training.title
		     page.should have_content "Training was successfully destroyed"
		   end
		 end


end
