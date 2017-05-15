var RunsStats = React.createClass({
  propTypes: {
    currentWeekStats: React.PropTypes.object,
    prevWeekStats: React.PropTypes.object,
    totalStats: React.PropTypes.object
  },

  render: function() {
    return (
      <div>
        <div className="page-header">            
          <h2>
            Statistics
          </h2>        
        </div>
        <div className="col-md-4">
          <h3>Current Week Stats</h3>
          <p>
            <b>Runs Count:</b>
            <span>{this.props.currentWeekStats.runsCount}</span>
          </p>
          <p>
            <b>Avg. Speed (Km/H):</b>
            <span>{this.props.currentWeekStats.avgSpeed}</span>
          </p>
          <p>
            <b>Total Distance (M):</b>
            <span>{this.props.currentWeekStats.totalDistance}</span>
          </p>
          <p>
            <b>Total Duration (Mins):</b>
            <span>{this.props.currentWeekStats.totalDuration}</span>
          </p>
        </div>
        <div className="col-md-4">
          <h3>Last Week Stats</h3>
          <p>
            <b>Runs Count:</b>
            <span>{this.props.prevWeekStats.runsCount}</span>
          </p>
          <p>
            <b>Avg. Speed (Km/H):</b>
            <span>{this.props.prevWeekStats.avgSpeed}</span>
          </p>
          <p>
            <b>Total Distance (M):</b>
            <span>{this.props.prevWeekStats.totalDistance}</span>
          </p>
          <p>
            <b>Total Duration (Mins):</b>
            <span>{this.props.prevWeekStats.totalDuration}</span>
          </p>
        </div>
        <div className="col-md-4">
          <h3>Total Stats</h3>
          <p>
            <b>Runs Count:</b>
            <span>{this.props.totalStats.runsCount}</span>
          </p>
          <p>
            <b>Avg. Speed (Km/H):</b>
            <span>{this.props.totalStats.avgSpeed}</span>
          </p>
          <p>
            <b>Total Distance (M):</b>
            <span>{this.props.totalStats.totalDistance}</span>
          </p>
          <p>
            <b>Total Duration (Mins):</b>
            <span>{this.props.totalStats.totalDuration}</span>
          </p>
        </div>
      </div>
    );
  }
});
