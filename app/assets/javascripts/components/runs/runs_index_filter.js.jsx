var RunsIndexFilter = React.createClass({
  propTypes: {
    filterFrom: React.PropTypes.node,
    filterTo: React.PropTypes.node,
    descHead: React.PropTypes.string,
    descFilter: React.PropTypes.string
  },

  render: function() {
    return (
      <div>
        <form acceptCharset="UTF-8" action="" className="form-horizontal" method="get" role="form" style={{marginLeft: 20 + 'px'}}>
          <input name="utf8" type="hidden" value="✓"/>
          <div className="form-group form-control-inline">
            <input className="form-control form-control-inline" name="from" placeholder="Filter runs from this date" defaultValue={this.props.filterFrom}/>
            <input className="form-control form-control-inline" name="to" placeholder="Filter runs to this date" defaultValue={this.props.filterTo}/>
          </div>

          <input className="btn btn-primary form-control-inline" data-disable-with="Filter" name="commit" style={{marginLeft: 20 + 'px'}} type="submit" value="Filter"/>
        </form>
      </div>
    );
  }
});
