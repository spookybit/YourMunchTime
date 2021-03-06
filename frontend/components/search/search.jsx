import React from 'react';
import { Link, withRouter } from 'react-router-dom';

class SearchBar extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      restaurantName: "",
      location_id: 0
    };
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  update(field) {
    return e => this.setState({
      [field]: e.currentTarget.value
    });
  }

  handleSubmit(e) {
    e.preventDefault;
    const search = {
      restaurant: {
        location_id: this.state.location_id,
        name: this.state.restaurantName
      }
    };
    if (this.state.restaurantName !== "" || this.state.location_id !== 0) {
      this.props.makeSearch(search);
      this.props.history.push(`/search/${this.state.restaurantName}`);
    }
  }


  render () {
    return (
      <form className="searchForm" onSubmit={this.handleSubmit}>
        <div className="searchFormHeading">
          Make restaurant reservations the easy way
        </div>
        <div className="searchBar">
          <input type="text"
            placeholder="Restaurant name"
            value={this.state.restaurantName}
            onChange={this.update('restaurantName')}
            />
          <select defaultValue="City" className="searchCityDrop" onChange={this.update('location_id')}>
            <option disabled>City</option>
            <option value="1">Tokyo</option>
            <option value="2">San Francisco</option>
            <option value="3">Los Angeles</option>
            <option value="4">New York</option>
            <option value="5">Seattle</option>
            <option value="6">Austin</option>
          </select>
          <input className="formClick" type="submit" value="Submit" />

        </div>
      </form>
    );
  }
}

export default withRouter(SearchBar);
