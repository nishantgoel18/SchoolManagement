require 'rails_helper'

RSpec.describe "batches/index", type: :view do
  before(:each) do
    assign(:batches, [
      Batch.create!(
        school_id: 2,
        name: "Name"
      ),
      Batch.create!(
        school_id: 2,
        name: "Name"
      )
    ])
  end

  it "renders a list of batches" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
