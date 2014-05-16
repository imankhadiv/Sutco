require 'spec_helper'



describe "Access control for different roles for FOH model" do
  before(:each) do
    Position.create :name =>"Manager"
    Position.create :name =>"Box Officer"
    Position.create :name =>"Refreshment Officer"
    Position.create :name =>"Usher 1"
    Position.create :name =>"Usher 2"
    Position.create :name =>"Usher 3"
    Position.create :name =>"Usher 4"
  end
  let!(:show_with_show_dates) { FactoryGirl.create(:show_with_show_dates) }
  specify "As a member, I can apply for FOH" do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_dates.id)
    click_on "Apply for front of house"
    page.should have_content "You are applying for a front of house position"
    page.should have_content "Manager"
    page.should have_content "Box Officer"
    page.should have_content "Refreshment Officer"
    page.should have_content "Usher 1"
    page.should have_content "Usher 2"
    page.should have_content "Usher 3"
    page.should have_content "Usher 4"
    page.choose("Manager")
    fill_in "Phone number", with: "07405149580"
    click_button "Apply"
    page.should have_content "You have successfully applied for the position"
  end

  specify "As a production team member, I can apply for a front of house position" do
    role = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_dates.id)
    click_on "Apply for front of house"
    page.should have_content "You are applying for a front of house position"
    page.should have_content "Manager"
    page.should have_content "Box Officer"
    page.should have_content "Refreshment Officer"
    page.should have_content "Usher 1"
    page.should have_content "Usher 2"
    page.should have_content "Usher 3"
    page.should have_content "Usher 4"
    page.choose("Manager")
    fill_in "Phone number", with: "07405149580"
    click_button "Apply"
    page.should have_content "You have successfully applied for the position"
  end

  specify "As a production team member, I can View filled front of house positions for a show" do
    role = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_dates.id)
    click_on "Apply for front of house"
    page.should have_content "You are applying for a front of house position"
    page.should have_content "Manager"
    page.should have_content "Box Officer"
    page.should have_content "Refreshment Officer"
    page.should have_content "Usher 1"
    page.should have_content "Usher 2"
    page.should have_content "Usher 3"
    page.should have_content "Usher 4"
    page.choose("Manager")
    fill_in "Phone number", with: "07405149580"
    click_button "Apply"
    page.should have_content "You have successfully applied for the position"
    visit show_path(show_with_show_dates.id)
    click_on "View filled positions"
    page.should have_content "Filled front of house positions for"
  end

  specify "As a committee member, I can You are applying for a front of house position" do
    role = Role.create :name =>"Committee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_dates.id)
    click_on "Apply for front of house"
    page.should have_content "You are applying for a front of house position"
    page.should have_content "Manager"
    page.should have_content "Box Officer"
    page.should have_content "Refreshment Officer"
    page.should have_content "Usher 1"
    page.should have_content "Usher 2"
    page.should have_content "Usher 3"
    page.should have_content "Usher 4"
    page.choose("Manager")
    fill_in "Phone number", with: "07405149580"
    click_button "Apply"
    page.should have_content "You have successfully applied for the position"
  end

  specify "As a drama studio manager, I can You are applying for a front of house position" do
    role = Role.create :name =>"DramaStudioManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_dates.id)
    click_on "Apply for front of house"
    page.should have_content "You are applying for a front of house position"
    page.should have_content "Manager"
    page.should have_content "Box Officer"
    page.should have_content "Refreshment Officer"
    page.should have_content "Usher 1"
    page.should have_content "Usher 2"
    page.should have_content "Usher 3"
    page.should have_content "Usher 4"
    page.choose("Manager")
    fill_in "Phone number", with: "07405149580"
    click_button "Apply"
    page.should have_content "You have successfully applied for the position"
  end

  specify "As a senior committee, I can You are applying for a front of house position" do
    role = Role.create :name =>"SeniorCommittee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_dates.id)
    click_on "Apply for front of house"
    page.should have_content "You are applying for a front of house position"
    page.should have_content "Manager"
    page.should have_content "Box Officer"
    page.should have_content "Refreshment Officer"
    page.should have_content "Usher 1"
    page.should have_content "Usher 2"
    page.should have_content "Usher 3"
    page.should have_content "Usher 4"
    page.choose("Manager")
    fill_in "Phone number", with: "07405149580"
    click_button "Apply"
    page.should have_content "You have successfully applied for the position"
  end

  specify "As a tech manager, I can You are applying for a front of house position" do
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_dates.id)
    click_on "Apply for front of house"
    page.should have_content "You are applying for a front of house position"
    page.should have_content "Manager"
    page.should have_content "Box Officer"
    page.should have_content "Refreshment Officer"
    page.should have_content "Usher 1"
    page.should have_content "Usher 2"
    page.should have_content "Usher 3"
    page.should have_content "Usher 4"
    page.choose("Manager")
    fill_in "Phone number", with: "07405149580"
    click_button "Apply"
    page.should have_content "You have successfully applied for the position"
  end

end

