var dbutil = require('../utilities/DatabaseConnectionUtility.js');

function searchFlights(callback) {
  let results = {};
  const conn = dbutil.getConnection();
  let allPromises;

  conn.query("select city_id, city_name from cities", function(err, cities, fields) {
    if(!err) {
      allPromises = cities.map(function(city, index) {
      	return new Promise(function(resolve, reject){
      		conn.query("select * from airport where city_id=?", [city.city_id], function(err, airport, fields) {
      			if(err){
      				reject(err, 'Error occurred in getting airport data for city: ' + city.city_name);
      			} else if(!err){
      				results[airport[0].airport_code] = city.city_name +" - "+ airport[0].airport_name;
      				resolve();		
      			}
      		});
      	});
      });

      Promise.all(allPromises)
      .then(function(){
      	callback(null, results);
      })
      .catch(function(err, custom_err_msg) {
      	console.error(custom_err_msg);
      	results(err, null);
      });
    } else {
      console.log('search flights query failed!');
      throw err;
    }
  
  });
}

module.exports = {
  searchFlights: searchFlights
}