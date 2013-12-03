require 'spec_helper'

describe "profiles/edit" , :type => :view do

  before(:each) do
    @profile = assign(:profile, stub_model(Profile,
      :name => "MyString",
      :course => "MyString",
      :ucard => 1,
      :email => "MyString"
    ))
  end

  it "renders the edit profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", profile_path(@profile), "post" do
      assert_select "input#profile_name[name=?]", "profile[name]"
      assert_select "input#profile_course[name=?]", "profile[course]"
      assert_select "input#profile_ucard[name=?]", "profile[ucard]"
      assert_select "input#profile_email[name=?]", "profile[email]"
    end
  end
end
