require 'spec_helper'

 describe "Signing up" do
   let!(:user) { FactoryGirl.create(:user) }
   specify "I can sign up" do
     visit new_user_registration_path
     fill_in "Email", with: "testuser@sheffield.ac.uk"
     fill_in "Password", with: user.password
     fill_in "Password confirmation", with: user.password
     fill_in "Firstname", with: user.firstname
     fill_in "Lastname", with: user.lastname
     fill_in "Course", with: user.course
     fill_in "Ucard", with: user.ucard
     select 'Level1'

     click_button "Sign Up"
     page.should have_content "Sign up successful"
     page.should have_content "Your Sign up was successful but approval is required from an administrator. When you are approved, you will be able to sign in. Thank you! Sign In ©2014 Genesys Solutions"

    end

   specify "I can not Sing in before approval" do
     visit new_user_session_path
     fill_in "Email", with: user.email
     fill_in "Password", with: user.password
     user.approved = false
     user.save
     click_button "Sign in"
     page.should have_content "Your account has not been approved by your administrator yet."

   end

   specify "I can sing in after approval" do
     visit new_user_session_path
     fill_in "Email", with: user.email
     fill_in "Password", with: user.password
     click_button "Sign in"
     page.should have_content "Signed in successfully."

   end
 end
