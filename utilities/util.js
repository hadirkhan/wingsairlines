/*
* converts the 24-hour time to 12 hour time
* */
function formatTime(hours, mins) {
    var h = (hours % 12) || 12;
    h = (h < 10)?("0"+h):h;
    mins = mins < 10 ? '0'+mins : mins;
    var ampm = hours < 12 ? " AM" : " PM";
    return h + ":" + mins + " " + ampm;
}

function replaceShortDayName(dateString) {
    var shortDayName = dateString.substr(0, 3);
    var fullDayName;
    switch (shortDayName){
        case 'Sun':
            fullDayName = 'Sunday';
            break;
        case 'Mon':
            fullDayName = 'Monday';
            break;
        case 'Tue':
            fullDayName = 'Tuesday';
            break;
        case 'Wed':
            fullDayName = 'Wednesday';
            break;
        case 'Thu':
            fullDayName = 'Thursday';
            break;
        case 'Fri':
            fullDayName = 'Friday';
            break;
        case 'Sat':
            fullDayName = 'Saturday';
            break;
        default:
            break;
    }
    return dateString.replace(shortDayName, fullDayName);
}

function getFormattedLegDuration(departureTimestamp, arrivalTimestamp) {
    var departure = new Date(departureTimestamp);
    var arrival = new Date(arrivalTimestamp);
    var diff = (arrival - departure)/ 1000 / 60 ;
    console.log((diff/60).toString().split(".")[0]+"h"+diff%60+"m");
    var hours = Math.abs(arrival.getHours() - departure.getHours());
    hours = hours < 10 ? '0'+hours : hours;
    var mins = Math.abs(arrival.getMinutes() - departure.getMinutes());
    mins = mins < 10 ? '0'+mins : mins;
    return  (diff/60).toString().split(".")[0]+"h "+diff%60+"m";
}


module.exports = {
    formatTime: formatTime,
    replaceShortDayName: replaceShortDayName,
    getFormattedLegDuration: getFormattedLegDuration
}