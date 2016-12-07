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
    dateString = dateString.replace(shortDayName, fullDayName);
    return dateString.split(' ').slice(0, 4).join(' ');
}

function getFormattedLegDuration(departureTimestamp, arrivalTimestamp) {
    var departure = new Date(departureTimestamp);
    var arrival = new Date(arrivalTimestamp);
    var diff = (arrival - departure)/ 1000 / 60 ;

    /*
    var hours = Math.abs(arrival.getHours() - departure.getHours());
    hours = hours < 10 ? '0'+hours : hours;
    var mins = Math.abs(arrival.getMinutes() - departure.getMinutes());
    mins = mins < 10 ? '0'+mins : mins;
    */

    var tempArr = (diff/60).toString().split(".");
    var hours = tempArr[0], mins = diff%60;
    var hoursStr = hours == 0 ? '' : (hours < 10 ? '0'+hours : hours) + 'h';
    var minsStr = mins == 0 ? '' : (mins < 10 ? '0'+mins : mins) + 'm';

    return hoursStr + minsStr;
}


module.exports = {
    formatTime: formatTime,
    replaceShortDayName: replaceShortDayName,
    getFormattedLegDuration: getFormattedLegDuration
}