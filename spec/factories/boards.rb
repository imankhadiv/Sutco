FactoryGirl.define do
  factory :board do
    title "General Message Board"
    public true
  end

  factory :conversation do
    title "Conversation 1"
    body "Initial Comment"
  end
end
