require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Social tests" do

		describe "Creating socials" do
		  specify "I can create an social" do
		    visit new_social_path
		    fill_in "Title", with: "Social 1"
		    fill_in "Location", with: "RG-12"
		    fill_in "Description", with: "Some description"
		    select '2013', :from => 'Date'
		    click_button "Create Social"
		    page.should have_content "Social was successfully created"
		    page.should have_content "Social 1"
		
		
		  end
		
		  specify "I cannot create a social with blank fields" do
		  	pending "input validation to be added"
		    visit new_social_path
		    click_button "Create Social"
		    page.should have_content "can't be blank"
		  end
		end
		
		describe "Updating socials" do
		
		  let!(:social) { FactoryGirl.create(:social) }
		
		  specify "Given an social exists I can update it" do
		    visit socials_path
		    click_link "Edit"
		    fill_in "Title", with: "Social 2"
		    fill_in "Description", with: "Some Description"
		    click_button "Update Social"
		
		    page.should have_content "Social 2"
		    page.should have_content "Social was successfully updated"
		  end
		end
		
		### No option for it ! 
		
		
		 describe "Deleting socials" do
		
		   let!(:social) { FactoryGirl.create(:social) }
		
		   specify "Given a social exists I can delete it" do
		
		     visit socials_path
		     click_link "Destroy"
		     page.should_not have_content social.title
		     page.should have_content "Social was successfully destroyed"
		   end
		 end


end
