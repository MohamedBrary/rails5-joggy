var RunsMain = React.createClass({
  propTypes: {
    runs: React.PropTypes.array,
    currentUser: React.PropTypes.object,
    canChangeOwner: React.PropTypes.bool,
    users: React.PropTypes.array,
    filterFrom: React.PropTypes.node,
    filterTo: React.PropTypes.node,
    currentWeekStats: React.PropTypes.object,
    prevWeekStats: React.PropTypes.object,
    totalStats: React.PropTypes.object
  },

  render: function() {
    return (
      <div>
        <div className="row">
          <div id="runs_form_container" className="col-md-4">
            <RunsForm authenticityToken={this.props.authenticityToken} currentUser={this.props.currentUser} canChangeOwner={this.props.canChangeOwner} users={this.props.users} />
          </div>
          <div id="runs_stats_container" className="col-md-8">
            <RunsStats currentWeekStats={this.props.currentWeekStats} prevWeekStats={this.props.prevWeekStats} totalStats={this.props.totalStats} />
          </div>
        </div>
        <div className="row">
          <div id="runs_index_container" className="col-md-12">
            <RunsIndex runs={this.props.runs} filterFrom={this.props.filterFrom} filterTo={this.props.filterTo}  descHead={this.props.descHead}  descFilter={this.props.descFilter}/>
          </div>
        </div>
      </div>
    );
  }
});
