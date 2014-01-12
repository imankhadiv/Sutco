require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Calendar tests" do
 before(:each) do
 role = FactoryGirl.create(:role)
	    user = FactoryGirl.create(:user)
user.roles << role
			login_as(user, :scope => :user)
end

	describe "View events in calendar" do			
		describe "View trainings in calendar" do		
		  let!(:training) { FactoryGirl.create(:training) }		
		  specify "Given a training exists I can view it in calendar" do
		    visit calendars_path		    
		    page.should have_content "Training 1"
				click_link "Training 1"
		    page.should have_content "Training 1"
		    page.should have_content "Lighting Operator"
		  end
		end
		
		describe "View workshops in calendar" do		
		  let!(:workshop) { FactoryGirl.create(:workshop) }		
		  specify "Given a workshop exists I can view it in calendar" do
		    visit calendars_path
		    
		    page.should have_content "Workshop 1"
				click_link "Workshop 1"
		    page.should have_content "Workshop 1"
		    page.should have_content "Some Description"
		  end
		end
		
		describe "View shows in calendar" do		
		  let!(:show) { FactoryGirl.create(:show) }		
		  specify "Given a show exists I can view it in calendar" do
		  	pending "shows to be added in calendar"
		    visit calendars_path
		    
		    page.should have_content "Show 1"
				click_link "Show 1"
		    page.should have_content "Show 1"
		    page.should have_content "Some Description"
		  end
		end			
		
		describe "View socials in calendar" do		
		  let!(:social) { FactoryGirl.create(:social) }		
		  specify "Given a social event exists I can view it in calendar" do
		    visit calendars_path		    
		    page.should have_content "Social 1"
				click_link "Social 1"
		    page.should have_content "Social 1"
		    page.should have_content "RG-12"
		  end
		end		
	end
	
	describe "Create events in calendar" do	
		describe "Create a show in calendar" do	
			 specify "I can create a show in calendar view" do
visit calendars_path
				  click_link "Create New Show"
				  fill_in "Name", with: "Show 1"
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
		end
		
		describe "Create a training session in calendar" do	
			 specify "I can create a training session in calendar view" do
			 	visit calendars_path
				  click_link "Create New Training Session"
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
		end
		
		describe "Create a workshop in calendar" do	
			 specify "I can create a workshop in calendar view" do
			 	visit calendars_path
				  click_link "Create New Workshop"
			    fill_in "Title", with: "Workshop 1"
			    fill_in "Description", with: "Some description"
		    fill_in "Date", with: "10/12/2014"
		    fill_in "Time", with: "11:45 AM"
		    fill_in "Duration", with: "120"
			    click_button "Create Workshop"
			    page.should have_content "Workshop was successfully created"
			    page.should have_content "Workshop 1"
			  end
		end		
		
		describe "Create a social event in calendar" do	
			 specify "I can create a social event in calendar view" do
			 	visit calendars_path
				  click_link "Create New Social Event"
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
		end
  end	
end
