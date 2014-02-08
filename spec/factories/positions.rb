# # == Schema Information
# #
# # Table name: positions
# #
# #


FactoryGirl.define do
  factory :position do |p|
    p.sequence(:name) {|n| "Usher #{n}"}
  end

  factory :position2 do
    name "Box Officer"
  end

  factory :position3 do
    name "Refreshment Officer"
  end

  factory :position4 do
    name "Usher 1"
  end

  factory :position5 do
    name "Usher 2"
  end

  factory :position6 do
    name "Usher 3"
  end

  factory :position7 do
    name "Usher 4"
  end

end

