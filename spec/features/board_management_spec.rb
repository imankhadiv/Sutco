require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Messageboard tests" do

  before(:each) do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
  end

  describe "General messageboard" do
    specify "I can view the general message board" do
      pending
      visit new_show_path
      end

    specify "I can add a conversation" do
      pending
    end

  end

  describe "Show Message board" do
    specify "As an approved role in a show, i can view it's message board" do
      pending
  end

  end

end
