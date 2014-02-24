require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

  describe "Calendar tests" do
    before(:each) do
      role = FactoryGirl.create(:role)
      role2 = Role.create :name =>"ProductionTeam"
      user = FactoryGirl.create(:user)
      user.roles << role
      user.roles << role2
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
      let!(:show_with_show_dates) { FactoryGirl.create(:show_with_show_dates) }
      specify "Given a show exists I can view it in calendar" do
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
				 
			    page.should have_content "New show"
			  end
		end
		
		describe "Create a training session in calendar" do	
			 specify "I can create a training session in calendar view" do
			 	visit calendars_path
				  click_link "Create New Training Session"
				page.should have_content "New training"
			  end
		end
		
		describe "Create a workshop in calendar" do	
			 specify "I can create a workshop in calendar view" do
			 	visit calendars_path
				  click_link "Create New Workshop"
				page.should have_content "New workshop"
			  end
		end		
		
		describe "Create a social event in calendar" do	
			 specify "I can create a social event in calendar view" do
			 	visit calendars_path
				  click_link "Create New Social Event"
					page.should have_content "New social"
			  end
		end
  end	
end
