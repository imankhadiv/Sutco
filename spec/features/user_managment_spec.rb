require 'spec_helper'

 describe "Signing up" do
   let!(:user) { FactoryGirl.create(:user) }
   specify "I can sign up" do
     visit new_user_registration_path
     fill_in "Email", with: "i@sheffield.ac.uk"
     fill_in "Password", with: user.password
     fill_in "Password confirmation", with: user.password
     fill_in "Firstname", with: user.firstname
     fill_in "Lastname", with: user.lastname
     fill_in "Course", with: user.course
     fill_in "Ucard", with: user.ucard
     select 'Level1'

     click_button "Sign Up"
    #page.should have_content "You have signed up successfully but your account has not been approved by your administrator yet"

   end
 end
