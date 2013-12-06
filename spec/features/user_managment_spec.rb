require 'spec_helper'

 describe "Signing up" do
   let!(:user) { FactoryGirl.create(:user) }
   specify "I can sign up" do
     visit new_user_registration_path
     fill_in "Email", with: "user1@sheffield.ac.uk"
     fill_in "Password", with: user.password
     fill_in "Password confirmation", with: user.password
     fill_in "Firstname", with: user.firstname
     fill_in "Course", with: user.course
     fill_in "Ucard", with: user.ucard




     click_button "Sign Up"
     response.should not_approved
    # page.should have_content "You have signed up successfully but your account has not been approved by your administrator yet"
   end
 end
