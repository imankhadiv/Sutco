require 'spec_helper'

describe "applicants/index" , :type => :view do

  before(:each) do
    assign(:applicants, [
      stub_model(Applicant,
        :status => "Status",
        :access_level => "Access Level"
      ),
      stub_model(Applicant,
        :status => "Status",
        :access_level => "Access Level"
      )
    ])
  end

  it "renders a list of applicants" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Access Level".to_s, :count => 2
  end
end
