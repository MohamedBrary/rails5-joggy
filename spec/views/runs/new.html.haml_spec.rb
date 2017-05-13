require 'rails_helper'

RSpec.describe "runs/new", type: :view do
  before(:each) do
    assign(:run, Run.new(
      :duration => 1,
      :distance => 1,
      :avg_speed => 1.5,
      :user => nil
    ))
  end

  it "renders new run form" do
    render

    assert_select "form[action=?][method=?]", runs_path, "post" do

      assert_select "input[name=?]", "run[duration]"

      assert_select "input[name=?]", "run[distance]"

      assert_select "input[name=?]", "run[avg_speed]"

      assert_select "input[name=?]", "run[user_id]"
    end
  end
end
