var RunsIndexTableRow = React.createClass({
  propTypes: {
    run: React.PropTypes.object
  },

  render: function() {
    return (
      <tr>
        <td>
          {this.props.run.date}
        </td>
        <td>
          {this.props.run.duration}
        </td>
        <td>
          {this.props.run.distance}
        </td>
        <td>
          {this.props.run.avgSpeed}
        </td>
        <td>
          {this.props.run.user}
        </td>
        <td>
          <a href={"/runs/"+this.props.run.id}>
            Show
          </a>
        </td>
        <td>
          <a href={"/runs/"+this.props.run.id+"/edit"}>
            Edit
          </a>
        </td>
        <td>
          <a data-confirm="Are you sure?" data-method="delete" href={"/runs/"+this.props.run.id} rel="nofollow">
            Destroy
          </a>
        </td>
      </tr>
    );
  }
});
