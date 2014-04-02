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
    let!(:board) { FactoryGirl.create(:board) }

    specify "I can view the general message board" do
      visit board_path(board.id)
      page.should have_content 'General Message Board'
    end

    specify "I can add a conversation" do
      visit board_path(board.id)
      page.should have_link "Add Conversation"
      click_on 'Add Conversation'
      page.should have_content "New conversation"
      fill_in "Title", with: "Title"
      fill_in "Initial Comment", with: 'Initial Comment'
      click_button "Create Conversation"


      page.should have_content "Conversation was successfully created."

    end

    specify "I cannot create conversation with blank fields" do

      visit new_board_conversation_path(board.id)
      click_button "Create Conversation"
      page.should have_content "can't be blank"
    end

  end


end

