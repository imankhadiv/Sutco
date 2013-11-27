require 'spec_helper'

describe "applicants/show" , :type => :view do

  before(:each) do
    @applicant = assign(:applicant, stub_model(Applicant,
      :status => "Status",
      :level => "Level"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Status/)
    rendered.should match(/Level/)
  end
end
