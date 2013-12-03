require 'spec_helper'

describe "profiles/show" , :type => :view do

  before(:each) do
    @profile = assign(:profile, stub_model(Profile,
      :name => "Name",
      :course => "Course",
      :ucard => 1,
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Course/)
    rendered.should match(/1/)
    rendered.should match(/Email/)
  end
end
