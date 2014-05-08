require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Show role tests" do

  before(:each) do
    role = Role.create :name =>"DramaStudioManager"
    role1 = Role.create :name =>"ProductionTeam"
    user = FactoryGirl.create(:user)
    user.roles << role
    user.roles << role1
    login_as(user, :scope => :user)
  end

  describe "Add/Delete roles to a show" do
  let!(:show_with_show_roles) { FactoryGirl.create(:show_with_show_roles) }
    specify "Given a show exists I can remove a show role from it" do
      visit show_path(show_with_show_roles.id)
      click_on "Remove Role"
      page.should have_content "Show 1"
      page.should have_content "Show role was successfully destroyed"
      page.should_not have_content "Lighting operator"
    end
  end

end
