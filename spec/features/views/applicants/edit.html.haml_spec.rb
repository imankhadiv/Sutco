require 'spec_helper'

describe "applicants/edit"  , :type => :view do

  before(:each) do
    @applicant = assign(:applicant, stub_model(Applicant,
      :status => "active",
      :access_level => "Senior Commite Member"
    ))
  end

  it "renders the edit applicant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", applicant_path(@applicant), "post" do
      assert_select "select#applicant_status[name=?]", "applicant[status]"
      assert_select "select#applicant_access_level[name=?]", "applicant[access_level]"

    end
  end
end
