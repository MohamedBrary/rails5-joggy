describe "runs/edit", type: :view do

  let(:user) { create(:user) }

  before(:each) do
    @run = assign(:run, Run.create!(
      :date => "2017-05-13",
      :duration => 10,
      :distance => 100,
      :avg_speed => 1.5,
      :user => user
    ))
  end

  it "renders the edit run form" do
    render
    assert_select "form[action=?][method=?]", run_path(@run), "post" do

      assert_select "input[name=?]", "run[duration]"

      assert_select "input[name=?]", "run[distance]"
      
    end
  end
end
