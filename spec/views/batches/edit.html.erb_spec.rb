require 'rails_helper'

RSpec.describe "batches/edit", type: :view do
  before(:each) do
    @batch = assign(:batch, Batch.create!(
      school_id: 1,
      name: "MyString"
    ))
  end

  it "renders the edit batch form" do
    render

    assert_select "form[action=?][method=?]", batch_path(@batch), "post" do

      assert_select "input[name=?]", "batch[school_id]"

      assert_select "input[name=?]", "batch[name]"
    end
  end
end
