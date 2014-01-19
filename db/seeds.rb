# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1= User.create :email =>"user1@sheffield.ac.uk",
:password =>"123456789",
:password_confirmation =>"123456789",
:firstname =>'myfirstname',
:lastname =>'mylastname',
:ucard =>'1234',
:course =>'mycourse',
:level =>"Level1",
:approved =>TRUE

role1 = Role.create :name=>"TechManager"

user1.roles << role1

Position.create :name =>"Manager"
Position.create :name =>"Box Officer"
Position.create :name =>"Refreshment Officer"
Position.create :name =>"Usher 1"
Position.create :name =>"Usher 2"
Position.create :name =>"Usher 3"
Position.create :name =>"Usher 4"


