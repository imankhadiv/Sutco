require 'spec_helper'

describe "applicants/new" do
  before(:each) do
    assign(:applicant, stub_model(Applicant,
      :status => "MyString",
      :access_level => "MyString"
    ).as_new_record)
  end

  it "renders new applicant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", applicants_path, "post" do
      assert_select "input#applicant_status[name=?]", "applicant[status]"
      assert_select "input#applicant_access_level[name=?]", "applicant[access_level]"
    end
  end
end
