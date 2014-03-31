require 'spec_helper'

describe "Access control for different roles for message board" do
  describe "Creating Conversation: " do
    specify "As a member, I can add conversation to general message board" do
      role = Role.create :name =>"Member"
      user = FactoryGirl.create(:user)
      board = FactoryGirl.create(:board)
      user.roles << role
      login_as(user, :scope => :user)
      visit board_path(board.id)
      page.should have_content "Add Conversation"
      visit new_board_conversation_path(board.id)
      page.should have_content "New conversation"
    end

  end
  describe "Deleting Conversation: " do
    specify "As a member, I can not remove conversation from general message board" do
      role = Role.create :name =>"Member"
      user = FactoryGirl.create(:user)
      board = FactoryGirl.create(:board)
      user.roles << role
      login_as(user, :scope => :user)
      visit board_path(board.id)
      page.should have_content "Add Conversation"
      page.should_not have_content "Remove conversation"
    end

    specify "As As a production team member, I can not remove conversations" do
      role = Role.create :name =>"ProductionTeam"
      user = FactoryGirl.create(:user)
      board = FactoryGirl.create(:board)
      user.roles << role
      login_as(user, :scope => :user)
      visit board_path(board.id)
      page.should have_content "Add Conversation"
      page.should_not have_content "Remove conversation"
    end

    specify "As As a TechManager, I can not remove conversations" do
      role = Role.create :name =>"TechManager"
      user = FactoryGirl.create(:user)
      board = FactoryGirl.create(:board)
      user.roles << role
      login_as(user, :scope => :user)
      visit board_path(board.id)
      page.should have_content "Add Conversation"
      page.should_not have_content "Remove conversation"
    end
    specify "As As a DramaStudioManager, I can not remove conversations" do
      role = Role.create :name =>"DramaStudioManager"
      user = FactoryGirl.create(:user)
      board = FactoryGirl.create(:board)
      user.roles << role
      login_as(user, :scope => :user)
      visit board_path(board.id)
      page.should have_content "Add Conversation"
      page.should_not have_content "Remove conversation"
    end
    specify "As As a SeniorCommittee  member, I can remove conversations" do
      pending
      role = Role.create :name =>"SeniorCommittee"
      user = FactoryGirl.create(:user)
      board = FactoryGirl.create(:board)
      user.roles << role
      login_as(user, :scope => :user)
      user.roles << role

      visit board_path(board.id)
      page.should have_content "Add Conversation"
      puts user.roles.last
      page.should have_content "Remove conversation"
    end

  end

end
