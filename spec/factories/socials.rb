# # == Schema Information
# #
# # Table name: socials
# #
# #


 FactoryGirl.define do
   factory :social do
     title "Social 1"
     location "RG-12"
     description "Some Description"
     date Date.tomorrow
     time Time.now
     duration 60
   end
 end
