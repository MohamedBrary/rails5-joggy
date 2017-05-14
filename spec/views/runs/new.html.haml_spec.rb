require 'rails_helper'

RSpec.describe "runs/new", type: :view do
  
  let(:user) { create(:user) }

  before(:each) do
    @run = assign(:run, Run.new(
      :date => "2017-05-13",
      :duration => 10,
      :distance => 100,
      :avg_speed => 1.5,
      :user => user
    ))
  end

  it "renders new run form" do
    render

    assert_select "form[action=?][method=?]", runs_path, "post" do

      assert_select "input[name=?]", "run[duration]"

      assert_select "input[name=?]", "run[distance]"

    end
  end
end
