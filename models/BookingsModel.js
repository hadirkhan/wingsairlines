const util = require('../utilities/util')
const dbutil = require('../utilities/DatabaseConnectionUtility');

function cancelFlights(pnr,callback)
{
    var results {};
    var allPromises;
    const conn = dbutil.getConnection();

    return new Promise(function (resolve, reject) {
        const cancelQuery = "UPDATE reservation SET reservation_status = 'Cancelled' where passenger_pnr = ?;";

        dbutil.getConnection().query(cancelQuery, [pnr], function(err, rows, fields){
            if(!err) {
                resolve(rows);
                allPromises = reservations.map(function(passenger_pnr, index) {
                  return new Promise(function(resolve, reject){
                    conn.query("Delete from ticket where ticket_no = ?", [reservation.ticket_no], function(err, airport, fields) {
                        if(err){
                            reject(err, 'Error occurred in canceling ticket for pnr' + reservation.passenger_pnr);
                        } else if(!err){
                            results[reservation_status] = 'Cancelled';
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
            }
            else {
                console.error('Error in BookingsModel.cancelFlights');
                reject(err);
            }
        });
    });
}

module.exports = {
    cancelFlights: cancelFlights
}