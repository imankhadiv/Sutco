require 'spec_helper'


describe "Access control for different roles for role application model" do
#creating
  let!(:show_with_show_roles_show_dates) { FactoryGirl.create(:show_with_show_roles_show_dates) }
  specify "As a member, I can apply for a role" do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_roles_show_dates.id)
    click_on "Apply for roles"
    page.should have_content "Why did you apply for the role?"
    fill_in "role_application[content]", with: "I am interested in the role."
    click_on "Submit"
    page.should have_content "Role application was successfully created."
  end

  specify "As a production team member, I can apply for a role" do
    role = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_roles_show_dates.id)
    click_on "Apply for roles"
    page.should have_content "Why did you apply for the role?"
    fill_in "role_application[content]", with: "I am interested in the role."
    click_on "Submit"
    page.should have_content "Role application was successfully created."
  end

  specify "As a committee member, I can apply for a role" do
    role = Role.create :name =>"Committee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_roles_show_dates.id)
    click_on "Apply for roles"
    page.should have_content "Why did you apply for the role?"
    fill_in "role_application[content]", with: "I am interested in the role."
    click_on "Submit"
    page.should have_content "Role application was successfully created."
  end

  specify "As a drama studio manager, I can apply for a role" do
    role = Role.create :name =>"DramaStudioManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_roles_show_dates.id)
    click_on "Apply for roles"
    page.should have_content "Why did you apply for the role?"
    fill_in "role_application[content]", with: "I am interested in the role."
    click_on "Submit"
    page.should have_content "Role application was successfully created."
  end

  specify "As a senior committee, I can apply for a role" do
    role = Role.create :name =>"SeniorCommittee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_roles_show_dates.id)
    click_on "Apply for roles"
    page.should have_content "Why did you apply for the role?"
    fill_in "role_application[content]", with: "I am interested in the role."
    click_on "Submit"
    page.should have_content "Role application was successfully created."
  end

  specify "As a tech manager, I can apply for a role" do
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit show_path(show_with_show_roles_show_dates.id)
    click_on "Apply for roles"
    page.should have_content "Why did you apply for the role?"
    fill_in "role_application[content]", with: "I am interested in the role."
    click_on "Submit"
    page.should have_content "Role application was successfully created."
  end

  specify "As a member, I cannot process applications" do
    role = Role.create :name =>"Member"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit role_applications_path
    page.should have_content "You are not authorized to access this page."
    page.should_not have_content "To be processed"
  end

  specify "As a production team member, I cannot process applications" do
    role = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit role_applications_path
    page.should have_content "You are not authorized to access this page."
    page.should_not have_content "To be processed"
  end

  specify "As a committee member, I cannot process applications" do
    role = Role.create :name =>"Committee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit role_applications_path
    page.should have_content "You are not authorized to access this page."
    page.should_not have_content "To be processed"
  end

   specify "As a drama studio manager, I cannot process applications" do
    role = Role.create :name =>"DramaStudioManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit role_applications_path
    page.should have_content "You are not authorized to access this page."
    page.should_not have_content "To be processed"
  end

    specify "As a senior committee, I cannot process applications" do
    role = Role.create :name =>"SeniorCommittee"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    visit role_applications_path
    page.should have_content "You are not authorized to access this page."
    page.should_not have_content "To be processed"
  end

  # let!(:show_role) { FactoryGirl.create(:show_role) }
  specify "As a tech manager, I can process applications" do
    role = Role.create :name =>"TechManager"
    user = FactoryGirl.create(:user)
    user.roles << role
    login_as(user, :scope => :user)
    show_role = ShowRole.create :show_id => show_with_show_roles_show_dates.id, :position => "something", :required_number => "1"
    role_application = RoleApplication.create :user_id => user.id, :show_role_id => show_role.id, :content => "Some content", :status => "Pending"
    visit role_applications_path
    click_on "Process Application"
    page.should have_content "Processing application for"
    select "Approved", :from => "role_application[status]"
    click_on "Update Application Status"
    page.should have_content "Role application was successfully"
  end
end