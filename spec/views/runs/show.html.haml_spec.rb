describe "runs/show", type: :view do
  
  let(:user) { create(:user) }

  before(:each) do
    @run = assign(:run, Run.create!(
      :date => "2017-05-13",
      :duration => 10,
      :distance => 100,
      :user => user
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/10/)
    expect(rendered).to match(/100/)
    expect(rendered).to match(user.name)
  end
end
