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
      fill_in "Body", with: 'Body'
      click_button "Create Conversation"


      page.should have_content "Conversation was successfully created."

    end

    specify "I cannot create conversation with blank fields" do

      visit new_board_conversation_path(board.id)
      click_button "Create Conversation"
      page.should have_content "can't be blank"
    end

  end

  describe "Show Message Board" do

    let!(:show_with_show_roles) { FactoryGirl.create(:show_with_show_roles) }
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)

    specify "As an unapproved role in a show, I can not view it's message board" do
      show_role = ShowRole.create :show_id => show_with_show_roles.id, :position => "something", :required_number => "1"

      visit boards_path
      page.should have_content "Show 1"
      click_link "Show"
      page.should have_content "You can't view this board"
    end


    specify "As an approved role in a show, i can view it's message board" do
      pending
      show = Show.create director: 'Some Director', producer: 'Some Producer', name: 'Show 1'
      puts show.producer
      show_role = ShowRole.create :show_id => show.id, :position => "something", :required_number => "1"
      role_application = RoleApplication.create :user_id => user.id, :show_role_id => show_role.id, :content => "Some content", status: "Approved"
      visit boards_path
      page.should have_content "Show 1"
      click_link "Show"
      page.should have_content "Add Conversation"

    end


  end

end

