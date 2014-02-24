require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Social tests" do
 before(:each) do
   role = Role.create :name =>"ProductionTeam"
	 user = FactoryGirl.create(:user)
  user.roles << role
	login_as(user, :scope => :user)
end

		describe "Creating socials" do
		  specify "I can create an social" do
		    visit new_social_path
		    fill_in "Title", with: "Social 1"
		    fill_in "Location", with: "RG-12"
		    fill_in "Description", with: "Some description"
		    fill_in "Date", with: "10/12/2014"
		    fill_in "Time", with: "11:45 AM"
		    fill_in "Duration", with: "120"
		    click_button "Create Social"
		    page.should have_content "Social was successfully created"
		    page.should have_content "Social 1"
		
		
		  end
		
		  specify "I cannot create a social with blank fields" do
		  	#pending "input validation to be added"
		    visit new_social_path
		    click_button "Create Social"
		    page.should have_content "can't be blank"
		  end
		end
		
		describe "Updating socials" do
		
		  let!(:social) { FactoryGirl.create(:social) }
		
		  specify "Given a social exists I can update it" do
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
