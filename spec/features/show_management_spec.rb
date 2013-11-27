require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Show tests" do

		describe "Creating shows" do
		  specify "I can create an show with a name and barcode" do
		    visit new_show_path
		    fill_in "Name", with: "Show 1"
		    fill_in "Image", with: ""
		    fill_in "Director", with: "Some Director"
		    fill_in "Stage manager", with: "Some Stage manager"
		    fill_in "Producer", with: "Some Producer"
		    fill_in "Synopsis", with: "Some Description"
		    click_button "Create Show"
		    page.should have_content "Show was successfully created"
		    page.should have_content "Show 1"
		    page.should have_content "Some Director"
		    page.should have_content "Some Stage manager"
		    page.should have_content "Some Producer"
		    page.should have_content "Some Description"
		
		
		  end
		
		  specify "I cannot create an show with blank fields" do
		  	pending
		    visit new_show_path
		    click_button "Create Show"
		    page.should have_content "can't be blank"
		  end
		end
		
		describe "Updating shows" do
		
		  let!(:show) { FactoryGirl.create(:show) }
		
		  specify "Given an show exists I can update it" do
		    visit shows_path
		    click_link "Edit"
		    fill_in "Name", with: "Show 2"
		    fill_in "Image", with: ""
		    fill_in "Director", with: "Some Director"
		    fill_in "Stage manager", with: "Some Stage manager"
		    fill_in "Producer", with: "Some Producer"
		    fill_in "Synopsis", with: "Some Description"
		    click_button "Update Show"
		
		    page.should have_content "Show 2"
		    page.should have_content "Show was successfully updated"
		  end
		end
		
		### No option for it ! 
		
		
		 describe "Deleting shows" do
		
		   let!(:show) { FactoryGirl.create(:show) }
		
		   specify "Given an show exists I can delete it" do
		
		     visit shows_path
		     click_link "Destroy"
		     page.should_not have_content show.name
		     page.should have_content "Show was successfully destroyed"
		   end
		 end


end
