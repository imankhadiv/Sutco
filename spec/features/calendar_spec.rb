require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Calendar tests" do
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
	
end
