require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Workshop tests" do

		describe "Creating workshops" do
		  specify "I can create a workshop" do
		    visit new_workshop_path
		    fill_in "Title", with: "Workshop 1"
		    fill_in "Description", with: "Some description"
		    #select_date(Date.tomorrow, from:"Date", datepicker: :bootstrap)
		    click_button "Create Workshop"
		    page.should have_content "Workshop was successfully created"
		    page.should have_content "Workshop 1"
		
		
		  end
		
		  specify "I cannot create a workshop with blank fields" do
		  	pending "input validation to be added"
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
		     click_link "Destroy"
		     page.should_not have_content workshop.title
		     page.should have_content "Workshop was successfully destroyed"
		   end
		 end


end
