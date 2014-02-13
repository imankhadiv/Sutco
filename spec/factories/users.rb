# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string(255)      default(""), not null
#  encrypted_password :string(255)      default(""), not null
#  created_at         :datetime
#  updated_at         :datetime
#

FactoryGirl.define do
  #Defines a default role for user
  factory :role do
    name "TechManager"
  end

  #Defines a default user for use in the tests
  factory :user do
    email "user@sheffield.ac.uk"
    password "123456789"
    password_confirmation "123456789"
    firstname 'myfirstname'
    lastname 'mylastname'
    ucard '1234'
    course 'mycourse'
    level "Level1"
    approved TRUE
  end

end