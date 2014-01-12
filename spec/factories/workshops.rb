# # == Schema Information
# #
# # Table name: workshops
# #
# #


 FactoryGirl.define do
   factory :workshop do
     title "Workshop 1"
     description "Some Description"
     date Date.tomorrow
     time Time.now
     duration 60
   end
 end
