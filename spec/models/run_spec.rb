describe Run, type: :model do
  before(:each) { 
  	user = create :user
  	run_attrs = {
	  	date: "2017-05-13",
	    duration: 10,
	    distance: 500,
	    user: user}
  	@run = Run.create! run_attrs
  }

  subject { @run }

  it { should respond_to(:duration_minutes) }

  it "calculates average speed accurately" do
    expect(@run.calculate_avg_speed).to match 3
  end
end
