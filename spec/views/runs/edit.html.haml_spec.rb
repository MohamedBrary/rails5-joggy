require 'rails_helper'

RSpec.describe "runs/edit", type: :view do
  before(:each) do
    @run = assign(:run, Run.create!(
      :duration => 1,
      :distance => 1,
      :avg_speed => 1.5,
      :user => nil
    ))
  end

  it "renders the edit run form" do
    render

    assert_select "form[action=?][method=?]", run_path(@run), "post" do

      assert_select "input[name=?]", "run[duration]"

      assert_select "input[name=?]", "run[distance]"

      assert_select "input[name=?]", "run[avg_speed]"

      assert_select "input[name=?]", "run[user_id]"
    end
  end
end
