require 'spec_helper'

describe "profiles/new" do
  before(:each) do
    assign(:profile, stub_model(Profile,
      :name => "MyString",
      :course => "MyString",
      :ucard => 1,
      :email => "MyString"
    ).as_new_record)
  end

  it "renders new profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", profiles_path, "post" do
      assert_select "input#profile_name[name=?]", "profile[name]"
      assert_select "input#profile_course[name=?]", "profile[course]"
      assert_select "input#profile_ucard[name=?]", "profile[ucard]"
      assert_select "input#profile_email[name=?]", "profile[email]"
    end
  end
end
