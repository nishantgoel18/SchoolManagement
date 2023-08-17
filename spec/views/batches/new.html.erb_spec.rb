require 'rails_helper'

RSpec.describe "batches/new", type: :view do
  before(:each) do
    assign(:batch, Batch.new(
      school_id: 1,
      name: "MyString"
    ))
  end

  it "renders new batch form" do
    render

    assert_select "form[action=?][method=?]", batches_path, "post" do

      assert_select "input[name=?]", "batch[school_id]"

      assert_select "input[name=?]", "batch[name]"
    end
  end
end
