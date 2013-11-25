require 'spec_helper'

describe "applicants/show" do
  before(:each) do
    @applicant = assign(:applicant, stub_model(Applicant,
      :status => "Status",
      :access_level => "Access Level"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Status/)
    rendered.should match(/Access Level/)
  end
end
