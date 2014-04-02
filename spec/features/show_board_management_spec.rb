require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Show Message Board" do



  specify "Without an approved role in a show, I can not view it's message board" do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    show = FactoryGirl.create(:show_with_show_roles)
    login_as(user, :scope => :user)
    visit boards_path
    page.should_not have_link "Show 1"
  end

  specify "Without an approved role in a show, I get an error message when trying to view it's message board" do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    show = FactoryGirl.create(:show_with_show_roles)
    login_as(user, :scope => :user)
    visit board_path(Board.first.id)
    page.should have_content "You can't view this board"
  end


  specify "with an approved role in a show, i can view it's message board" do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    show = FactoryGirl.create(:show_with_show_roles)
    login_as(user, :scope => :user)
    RoleApplication.create :user_id => user.id, :show_role_id => show.show_roles.first.id, :content => "Some content", status: "Approved"
    visit boards_path
    page.should have_content "Show 1"
    click_link "Show 1"
    page.should have_content "Show 1"
  end

  let!(:conversation) { FactoryGirl.create(:conversation) }

  specify "I can add comments to a conversation and have notifications sent out" do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    user2 = User.create :email =>"testuser2@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanapproveduser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>TRUE
    user2.roles << role
    login_as(user, :scope => :user)
    show = FactoryGirl.create(:show_with_show_roles)
    show_role = ShowRole.create :show_id => show.id, :position => "something", :required_number => "1"
    show.show_roles << show_role
    RoleApplication.create :user_id => user.id, :show_role_id => show.show_roles.first.id, :content => "Some content", status: "Approved"
    RoleApplication.create :user_id => user2.id, :show_role_id => show.show_roles.last.id, :content => "Some content", status: "Approved"
    Board.first.conversations << conversation
    user.conversations << conversation
    visit boards_path
    page.should have_content "Show 1"
    click_link "Show 1"
    page.should have_link "Conversation 1"
    click_on 'Conversation 1'
    page.should have_content "Conversation 1"
    comment = Comment.create :body =>"Latest Comment", :conversation_id =>conversation.id, :user_id =>user.id
    comment.notify_users
    comment.send_mail
    visit board_conversation_path(Board.first.id, conversation.id)
    page.should have_content "Latest Comment"
  end

  specify "I can get notifications sent to me as a production team member" do
    role = Role.create :name =>"Member"
    role2 = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    user2 = User.create :email =>"testuser2@sheffield.ac.uk", :password =>"123456789",   :password_confirmation =>"123456789",   :firstname =>'Imanapproveduser',  :lastname =>'mylastname',  :ucard =>'1234', :course =>'mycourse',  :level =>"Level1",  :approved =>TRUE
    user2.roles << role2
    login_as(user, :scope => :user)
    show = FactoryGirl.create(:show_with_show_roles)
    show_role = ShowRole.create :show_id => show.id, :position => "something", :required_number => "1"
    show.show_roles << show_role
    RoleApplication.create :user_id => user.id, :show_role_id => show.show_roles.first.id, :content => "Some content", status: "Approved"
    Board.first.conversations << conversation
    user.conversations << conversation
    visit boards_path
    page.should have_content "Show 1"
    click_link "Show 1"
    page.should have_link "Conversation 1"
    click_on 'Conversation 1'
    page.should have_content "Conversation 1"
    comment = Comment.create :body =>"Latest Comment", :conversation_id =>conversation.id, :user_id =>user.id
    comment.notify_users
    comment.send_mail
    visit board_conversation_path(Board.first.id, conversation.id)
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



end

