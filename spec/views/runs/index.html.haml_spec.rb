require 'rails_helper'

RSpec.describe "runs/index", type: :view do
  before(:each) do
    assign(:runs, [
      Run.create!(
        :duration => 2,
        :distance => 3,
        :avg_speed => 4.5,
        :user => nil
      ),
      Run.create!(
        :duration => 2,
        :distance => 3,
        :avg_speed => 4.5,
        :user => nil
      )
    ])
  end

  it "renders a list of runs" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
