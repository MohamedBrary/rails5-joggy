var RunsForm = React.createClass({
  propTypes: {
    run: React.PropTypes.object,
    currentUser: React.PropTypes.object,
    canChangeOwner: React.PropTypes.bool,
    users: React.PropTypes.array
  },

  render: function() {
    if(this.props.canChangeOwner){
      var _this = this;
      var userItems = this.props.users.map(function(user){
        return (
          <option value={user[1]}>
            {user[0]}
          </option>
        )
      });      
    }

    return (
      <div>
        <div className="page-header">            
          <h2>
            Create Run
          </h2>        
        </div>
        <form acceptCharset="UTF-8" action="/runs/" className="form-horizontal" id="new_run" method="post" role="form">
          <input name="authenticity_token" type="hidden" value={this.props.authenticityToken}/>
          <input name="utf8" type="hidden" value="✓"/>
          <div className="form-group">
            <label className="col-sm-2 control-label" htmlFor="run_date">
              Date
            </label>
            <div className="col-sm-8">
              <input className="form-control" id="run_date" name="run[date]" placeholder="in 2017-05-14 format" type="date"/>
            </div>
          </div>
          <div className="form-group">
            <label className="col-sm-2 control-label" htmlFor="run_duration">
              Duration
            </label>
            <div className="col-sm-8">
              <input className="form-control" id="run_duration" name="run[duration]" placeholder="in minutes" type="number"/>
            </div>
          </div>
          <div className="form-group">
            <label className="col-sm-2 control-label" htmlFor="run_distance">
              Distance
            </label>
            <div className="col-sm-8">
              <input className="form-control" id="run_distance" name="run[distance]" placeholder="in meters" type="number"/>
            </div>
          </div>
          { this.props.canChangeOwner && 
            <div className="form-group">
              <label className="col-sm-2 control-label" htmlFor="run_user_id">
                User
              </label>
              <div className="col-sm-8">
                <select className="form-control" id="run_user_id" name="run[user_id]">
                  {userItems}
                </select>
              </div>
            </div>
          }
          <div className="form-group">
            <div className="col-sm-offset-2 col-sm-6">
              <input className="btn btn-primary" data-disable-with="Create Run" name="commit" type="submit" value="Create Run"/>
            </div>
          </div>
        </form>
      </div>
    );
  }
});
