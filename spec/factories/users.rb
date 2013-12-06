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
  factory :user do
    email "user1@sheffield.ac.uk"
    password "123456789"
    password_confirmation "123456789"
    firstname 'myfirstname'
    lastname 'mylastname'
    ucard '1234'
    course 'mycourse'
    level "Level1"

  end
end