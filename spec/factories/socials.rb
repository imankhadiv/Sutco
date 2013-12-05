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
     date Time.now
   end
 end
