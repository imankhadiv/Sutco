require 'spec_helper'

describe "Adding Comments" do
  let!(:board) { FactoryGirl.create(:board) }
  let!(:conversation) { FactoryGirl.create(:conversation) }

  specify "I can add comments to a conversation and have notifications sent out" do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    user2 = User.create :email =>"testuser2@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanapproveduser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>TRUE
    user2.roles << role
    login_as(user, :scope => :user)

    board.conversations << conversation
    user.conversations << conversation
    visit board_path(board.id)
    page.should have_link "Conversation 1"
    click_on 'Conversation 1'
    page.should have_content "Conversation 1"
    comment = Comment.create :body =>"Latest Comment", :conversation_id =>conversation.id, :user_id =>user.id
    comment.notify_users
    comment.send_mail
    visit board_conversation_path(board.id, conversation.id)
    page.should have_content "Latest Comment"
    logout(:user)

    login_as(user2, :scope => :user)
    visit root_path
    page.should have_content "MESSAGE BOARD"
    page.should have_css('.badge')
    badge = all('.badge').first
    within(badge) do
      page.should have_content "1"
    end
  end

  specify "I can view notifications of comments that were added" do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    user2 = User.create :email =>"testuser2@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanapproveduser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>TRUE
    user2.roles << role
    login_as(user, :scope => :user)

    board.conversations << conversation
    user.conversations << conversation
    visit board_path(board.id)
    page.should have_link "Conversation 1"
    click_on 'Conversation 1'
    page.should have_content "Conversation 1"
    comment = Comment.create :body =>"Latest Comment", :conversation_id =>conversation.id, :user_id =>user.id
    comment.notify_users
    comment.send_mail
    visit board_conversation_path(board.id, conversation.id)
    page.should have_content "Latest Comment"
    logout(:user)

    login_as(user2, :scope => :user)
    visit root_path
    page.should have_content "MESSAGE BOARD"
    page.should have_css('.badge')
    badge = all('.badge').first
    within(badge) do
      page.should have_content "1"
    end
    click_on 'Conversation 1'
    page.should have_content "Conversation 1"
    visit root_path
    page.should_not have_css('.badge')
  end



end

