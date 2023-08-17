require 'rails_helper'

RSpec.describe "courses/index", type: :view do
  before(:each) do
    assign(:courses, [
      Course.create!(
        name: "Name",
        school_id: 2
      ),
      Course.create!(
        name: "Name",
        school_id: 2
      )
    ])
  end

  it "renders a list of courses" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
  end
end
