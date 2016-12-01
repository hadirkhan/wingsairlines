var dbutil = require('../utilities/DatabaseConnectionUtility.js');

function searchFlights(flightType, fromDest, toDest, departureDate, returnDate, numOfPassengers){

  var conn = dbutil.getConnection();
  conn.query("SELECT table_name FROM information_schema.tables where table_schema='heroku_972f993ecef99cc'", function(err, rows, fields){
    if(!err) {
      console.log('search flights results: ', rows);
    } else {
      console.log('search flights query failed!');
      throw err;
    }
  });
}

module.exports = {
  searchFlights: searchFlights
}