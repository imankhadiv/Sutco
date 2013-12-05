# # == Schema Information
# #
# # Table name: trainings
# #
# #


 FactoryGirl.define do
   factory :training do
     title "Training 1"
     category "Lighting Operator"
     description "Some Description"
     date Time.now
   end
 end
