describe "runs/index", type: :view do
  let(:user) { create(:user) }

  before(:each) do
    assign(:runs, [
      Run.create!(
        :date => "2017-05-13",
        :duration => 20,
        :distance => 3,
        :user => user
      ),
      Run.create!(
        :date => "2017-05-13",
        :duration => 20,
        :distance => 3,
        :user => user
      )
    ])
  end

  it "renders a list of runs" do
    render
    
    assert_select "tr>td", :text => "2017-05-13", :count => 2
    assert_select "tr>td", :text => "20.0", :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => user.name, :count => 2
  end
end
