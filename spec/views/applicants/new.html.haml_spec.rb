require 'spec_helper'

describe "applicants/new" do
  before(:each) do
    assign(:applicant, stub_model(Applicant,
      :status => "active",
      :access_level => "Senior Commite Member"
    ).as_new_record)
  end

  it "renders new applicant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", applicants_path, "post" do
      assert_select "select#applicant_status[name=?]", "applicant[status]"
      assert_select "select#applicant_access_level[name=?]", "applicant[access_level]"
    end
  end
end
