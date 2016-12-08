const express = require('express');
const router = express.Router();
const path = require('path');
const JourneyTypeEnum = require('../utilities/JourneyTypeEnum');


var searchModule = require('../models/SearchFlightsModel');
var homepageModule = require('../models/HomePageModel');

router.get('/', function(req, res, next) {
    homepageModule.getAirportsList(handleResults);
    function handleResults(err, data){
        if(err){
            throw err;
        }else if (data){
            res.render('index', { title: 'Wings-Welcome!' , data: data});
        }
    }
});

router.post('/search', function(req, res, next) {

    if(req.body.tripType || req.session){

        var params = req.body || req.session.userSearchParams;

        req.session.userSearchParams = params;

        searchModule.searchFlights(params.tripType, params.departureAirportCode, params.destinationAirportCode, params.departDate, params.returnDate,
            function (err, data) {
                if(err){
                    console.error('Error in searching flight records!');
                } else {

                    homepageModule.getAirportsList(function (err, airportsList) {
                        if(err){
                            throw err;
                        } else if (airportsList){
                            if(params.tripType == JourneyTypeEnum.ONE_WAY){
                                params.isOneway = true;
                                res.render('searchoneway', { title: 'Flight Search' ,
                                    airportsList: airportsList,
                                    searchParams: params,
                                    results: data
                                });
                            } else {
                                params.isRoundtrip = true;
                                res.render('search', { title: 'Flight Search',
                                    airportsList: airportsList,
                                    searchParams: params,
                                    results: data
                                });
                            }
                        }
                    });
                }
            });
    } else {
        console.info('Redirected user to index page from direct search');
        res.redirect('/');
    }
});

router.post('/payments', function(req, res, next) {

    if(req.session.userSearchParams){
        var userSearchParams = req.session.userSearchParams;
        var selectedToFlightInfo, selectedReturnFlightInfo;
        if(req.body){
            selectedToFlightInfo = {
                flightNo: req.body.flightNo,
                flightDepartureTime: req.body.flightDepartureTime,
                flightArrivalTime: req.body.flightArrivalTime,
                flightDuration: req.body.flightDuration,
                totalFare: '299',//req.body.totalFare,
                departureCityName: req.body.departureCityName,
                departureCityShortCode: req.body.departureCityShortCode,
                arrivalCityName: req.body.arrivalCityName,
                arrivalCityShortCode: req.body.arrivalCityShortCode,
                formattedDateOfTravel: req.body.formattedDateOfTravel
            };
            if(userSearchParams.tripType == JourneyTypeEnum.RETURN){
                selectedReturnFlightInfo = {
                    flightNo: req.body.rFlightNo,
                    flightDepartureTime: req.body.rFlightDepartureTime,
                    flightArrivalTime: req.body.rFlightArrivalTime,
                    flightDuration: req.body.rFlightDuration,
                    totalFare: '200', //req.body.rTotalFare,
                    departureCityName: req.body.rDepartureCityName,
                    departureCityShortCode: req.body.rDepartureCityShortCode,
                    arrivalCityName: req.body.rArrivalCityName,
                    arrivalCityShortCode: req.body.rArrivalCityShortCode,
                    formattedDateOfTravel: req.body.rFormattedDateOfTravel
                }
            }
        }

        var templateData = {
            title: 'Payments',
            userSearchParams: userSearchParams,
            toFlightInfo: selectedToFlightInfo
        };

        templateData.returnFlightInfo = selectedReturnFlightInfo ? selectedReturnFlightInfo : undefined;

        res.render('payments', templateData);

    } else {
        console.info('Redirected user to index page from direct payments');
        res.redirect('/');
    }
});

router.get('/confirmation', function(req, res, next){
    /////////////////////////////////////////
// Initialize Email Generation
/////////////////////////////////////////

var Mailgun = require('mailgun-js');

//API KEY from Mailgun’s Control Panel
var api_key = process.env.MAILGUN_API_KEY;

//Domain from the Mailgun Control Panel
var domain = process.env.MAILGUN_DOMAIN;

//WingsAirlines Email Address
var email_from = 'no_reply@wingsairlines.com';

//Sending email address
var email_to = 'garg78@pnw.edu'; //Customer email address i.e. req.params.email 

var path = require("path");

//Retrieve ticket for attachment
var fp = path.join(__dirname, '../utilities/tickets/ticket.pdf');

/////////////////////////////////////////
// Send Email with Attachment
/////////////////////////////////////////

var mailgun = new Mailgun({apiKey: api_key, domain: domain});

var data = {
  from: email_from,
  to: email_to,
  subject: 'WingsAirlines - Your ticket :)',
  html: 'Please download your ticket before arriving at the airport.  <br><br>  Your pnr is xyz. Save this pnr number! <br><br>  Thank you for flying WingsAirlines! <br>', 
  // attachment: fp
};

mailgun.messages().send(data, function (error, body) {
  console.log(body);
});

/////////////////////////////////////////
    res.render('confirmation', { title: 'Confirmation' });
});

router.get('/about', function(req, res, next){
    res.render('about', {title: 'About Us'});
});

router.get('/pnr', function(req, res, next){
    res.render('pnr', {title: 'See Bookings'});
});

router.get('/destinations', function(req, res, next){
    res.render('destinations', {title: 'Destinations'});
});


router.get('/print', function(req, res, next){
    res.render('print', {title: 'Print'});
});

module.exports = router;
