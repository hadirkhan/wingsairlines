const util = require('../utilities/util')
const dbutil = require('../utilities/DatabaseConnectionUtility');
const JourneyTypeEnum = require('../utilities/JourneyTypeEnum');

function getFlights(departingAirportCode, arrivalAirportCode, dateOfTravel) {

    return new Promise(function (resolve, reject) {
        /*
        const searchQuery = "SELECT fl.flight_no, fl.scheduled_departure_time, fl.scheduled_arrival_time, fl.leg_duration, f.fare, fl.leg_no " +
            "FROM fare f JOIN route r ON r.route_id = f.route_id " +
            "JOIN flight_leg fl ON f.route_id = fl.route_id " +
            "JOIN leg_instance l ON fl.flight_no = l.flight_no " +
            "WHERE r.departure_airport_code = ? AND r.arrival_airport_code = ? " +
            "AND l.date_of_travel = ? AND l.leg_no = fl.leg_no;";
        */
        const searchQuery = "SELECT fl.flight_no, fl.scheduled_departure_time, fl.scheduled_arrival_time, fl.leg_duration, " +
            "fr.fare, l.date_of_travel , fl.route_id , l.leg_no FROM flight_leg AS fl LEFT JOIN flight AS f ON (fl.flight_no = f.flight_no) " +
            "JOIN leg_instance l ON fl.flight_no = l.flight_no LEFT JOIN route AS r ON (fl.route_id = r.route_id) " +
            "LEFT JOIN fare AS fr ON (fl.route_id = fr.route_id AND fl.flight_no = fr.special_code) " +
            "WHERE r.departure_airport_code = ? AND r.arrival_airport_code = ? AND l.date_of_travel = ? AND l.leg_no = fl.leg_no;";

        dbutil.getConnection().query(searchQuery, [departingAirportCode, arrivalAirportCode, dateOfTravel], function(err, rows, fields){
            if(!err) {
                resolve(rows);
            } else {
                console.error('Error in SearchFlightsModel.getFlights');
                reject(err);
            }
        });
    });
}

function getCitiesInformation(airportCode) {
    return new Promise(function(resolve, reject){
        dbutil.getConnection().query("SELECT c.city_name, c.city_short_code " +
            "FROM cities c JOIN airport a ON c.city_id = a.city_id " +
            "WHERE a.airport_code = ?", [airportCode], function (err, rows, fields) {
            if(err){
                console.error('Error in fetching departing city name in SearchFlightsModel.searchFlights');
                reject(err);
            }else if (rows.length > 0){
                resolve(rows);
            }
        });
    });
}

function searchFlights(flightType, fromAirport, destinationAirport, departureDate, returnDate, callback){

    var results = {};

    results['departureDate'] = new Date(departureDate).toUTCString();
    results['formattedDepartureDate'] = util.replaceShortDayName(results.departureDate);

    var departingCityName = getCitiesInformation(fromAirport);
    var arrivingCityName = getCitiesInformation(destinationAirport);

    var oneWay, returnTrip;

    if(flightType == JourneyTypeEnum.ONE_WAY){

        oneWay = getFlights(fromAirport, destinationAirport, departureDate);

    } else if(flightType == JourneyTypeEnum.RETURN){

        oneWay = getFlights(fromAirport, destinationAirport, departureDate);
        returnTrip = getFlights(destinationAirport, fromAirport, returnDate);

        results['returnDate'] = new Date(returnDate).toUTCString();
        results['formattedReturnDate'] = util.replaceShortDayName(results.returnDate);
    }

    Promise.all([oneWay, returnTrip, departingCityName, arrivingCityName])
        .then(function (response) {

            Object.assign(results, {
                oneWayFlights: response[0],
                departingCityName: response[2],
                arrivingCityName: response[3]
            });

            results.oneWayFlights.map(function (item, index) {
                var departHours = new Date(item.scheduled_departure_time).getHours();
                var departMins = new Date(item.scheduled_departure_time).getMinutes();

                var arrivalHours = new Date(item.scheduled_arrival_time).getHours();
                var arrivalMins = new Date(item.scheduled_arrival_time).getMinutes();

                item['formattedDepartTime'] = util.formatTime(departHours, departMins);
                item['formattedArrivalTime'] = util.formatTime(arrivalHours, arrivalMins);
                item['formattedLegDuration'] = util.getFormattedLegDuration(item.scheduled_departure_time, item.scheduled_arrival_time);
            });

            if(flightType == JourneyTypeEnum.RETURN){

                results['returnFlights'] = response[1];

                results.returnFlights.map(function (item, index) {
                    var departHours = new Date(item.scheduled_departure_time).getHours();
                    var departMins = new Date(item.scheduled_departure_time).getMinutes();

                    var arrivalHours = new Date(item.scheduled_arrival_time).getHours();
                    var arrivalMins = new Date(item.scheduled_arrival_time).getMinutes();

                    item['formattedDepartTime'] = util.formatTime(departHours, departMins);
                    item['formattedArrivalTime'] = util.formatTime(arrivalHours, arrivalMins);

                    item['formattedLegDuration'] = util.getFormattedLegDuration(item.scheduled_departure_time, item.scheduled_arrival_time);
                });
            }

            callback(null, results);
        })
        .catch(function (err) {
            console.error('err: ', err);
            callback(err, null);
        });
}

module.exports = {
    searchFlights: searchFlights
}