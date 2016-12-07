const dbutil = require('../utilities/DatabaseConnectionUtility.js');

function getAirportsList(callback) {
    var results = {};
    const conn = dbutil.getConnection();
    var allPromises;

    conn.query("SELECT city_id, city_name FROM cities", function(err, cities, fields) {
        if(!err) {
            allPromises = cities.map(function(city, index) {
                return new Promise(function(resolve, reject){
                    conn.query("SELECT * FROM airport WHERE city_id=?", [city.city_id], function(err, airport, fields) {
                        if(err){
                            reject(err, 'Error occurred in getting airport data for city: ' + city.city_name);
                        } else if(!err){
                            results[airport[0].airport_code] = city.city_name +" - "+ airport[0].airport_name + ' Airport';
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
                    callback(err, null);
                });
        } else {
            console.error('search flights query failed!');
            throw err;
        }

    });
}

module.exports = {
    getAirportsList: getAirportsList
}