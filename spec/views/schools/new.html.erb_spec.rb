require 'rails_helper'

RSpec.describe "schools/new", type: :view do
  before(:each) do
    assign(:school, School.new(
      name: "MyString",
      address: "MyText",
      about: "MyText"
    ))
  end

  it "renders new school form" do
    render

    assert_select "form[action=?][method=?]", schools_path, "post" do

      assert_select "input[name=?]", "school[name]"

      assert_select "textarea[name=?]", "school[address]"

      assert_select "textarea[name=?]", "school[about]"
    end
  end
end
