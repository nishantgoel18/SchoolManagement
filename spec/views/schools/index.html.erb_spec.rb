require 'rails_helper'

RSpec.describe "schools/index", type: :view do
  before(:each) do
    assign(:schools, [
      School.create!(
        name: "Name",
        address: "MyText",
        about: "MyText"
      ),
      School.create!(
        name: "Name",
        address: "MyText",
        about: "MyText"
      )
    ])
  end

  it "renders a list of schools" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
