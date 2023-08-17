require 'rails_helper'

RSpec.describe "courses/show", type: :view do
  before(:each) do
    @course = assign(:course, Course.create!(
      name: "Name",
      school_id: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end
