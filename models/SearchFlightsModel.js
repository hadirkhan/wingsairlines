var dbutil = require('../utilities/DatabaseConnectionUtility.js');

function searchFlights(flightType, fromDest, toDest, departureDate, returnDate, numOfPassengers){

  var conn = dbutil.getConnection();
  conn.query('SELECT * FROM INFORMATION_SCHEMA.TABLES', function(err, rows, fields){
    if(!err) {
      console.log('search flights results: ', rows);
    } else {
      console.log('search flights query failed!');
    }
  });
}

module.exports = {
  searchFlights: searchFlights
}