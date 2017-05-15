var RunsIndexTable = React.createClass({
  propTypes: {
    runs: React.PropTypes.array
  },

  render: function() {
    var _this = this;
    var runItems = this.props.runs.map(function(run){
      return <RunsIndexTableRow key={"run_id_"+run.id} run={run} />;
    });

    return (
      <div className="table-responsive">
        <table className="table table-striped table-bordered table-hover">
          <thead>
            <tr>
              <th>Date</th>
              <th>Duration (Mins)</th>
              <th>Distance (M)</th>
              <th>Avg Speed (Km/H)</th>
              <th>User</th>
              <th></th>
              <th></th>
              <th></th>
            </tr>
          </thead>
          <tbody>              
            {runItems}
          </tbody>
        </table>
      </div>
    );
  }
});
