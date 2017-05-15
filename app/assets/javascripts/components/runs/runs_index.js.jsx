var RunsIndex = React.createClass({
  propTypes: {
    runs: React.PropTypes.array,
    filterFrom: React.PropTypes.node,
    filterTo: React.PropTypes.node,
    descHead: React.PropTypes.string,
    descFilter: React.PropTypes.string
  },

  render: function() {
    return (
      <div className="container">
        <div className="page-header">            
          <h2>
            {this.props.descHead}
          </h2>
          <p className="lead help-block">
            <em>{this.props.descFilter}</em>
          </p>
        </div>
        <RunsIndexFilter filterFrom={this.props.filterFrom} filterTo={this.props.filterTo}  descHead={this.props.descHead}  descFilter={this.props.descFilter}/>
        <RunsIndexTable runs={this.props.runs}/>
      </div>          
    );
  }
});
