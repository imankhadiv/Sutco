# # == Schema Information
# #
# # Table name: workshops
# #
# #


 FactoryGirl.define do
   factory :workshop do
     title "Workshop 1"
     description "Some Description"
     date Time.now
   end
 end
