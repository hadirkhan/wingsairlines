const express = require('express');
const router = express.Router();
const path = require('path');
const JourneyTypeEnum = require('../utilities/JourneyTypeEnum');
const randomstring = require("randomstring");


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
                totalFare: req.body.totalFare,
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
                    totalFare: req.body.rTotalFare,
                    departureCityName: req.body.rDepartureCityName,
                    departureCityShortCode: req.body.rDepartureCityShortCode,
                    arrivalCityName: req.body.rArrivalCityName,
                    arrivalCityShortCode: req.body.rArrivalCityShortCode,
                    formattedDateOfTravel: req.body.rFormattedDateOfTravel
                };

                req.session.returnFlightInfo = selectedReturnFlightInfo;
            }
            req.session.toFlightInfo = selectedToFlightInfo;
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

router.post('/confirmation', function(req, res, next){
    if(req.session.toFlightInfo){
        if(req.body){
            if(req.body.personCardDetails.cardholderName && req.body.personCardDetails.cardType && req.body.personCardDetails.cardNumber){
                console.log('req.body.personCardDetails', req.body.personCardDetails);
                var cardNumbers =  ['1234567890', '9876543210'];
                var cardType = ['Visa', 'MasterCard'];
                console.log((cardNumbers.includes(req.body.personCardDetails.cardNumber)) && (cardType.includes(req.body.personCardDetails.cardType)));
                if((cardNumbers.includes(req.body.personCardDetails.cardNumber)) && (cardType.includes(req.body.personCardDetails.cardType))){
                    req.session.userPNR = randomstring.generate(6).toUpperCase();
                    req.session.userReservationNumber = randomstring.generate(10).toUpperCase();
                    res.send('success');
                }
            }else{
                res.send('error');
            }
        }
    }else {
        console.info('Redirected user to index page from direct confirmation');
        res.redirect('/');
    }
});

router.get('/showConfirmation', function(req, res, next){
    if(req.session){
        var returnFlightInfo = req.session.returnFlightInfo;
        var toFlightInfo = req.session.toFlightInfo;
        res.render('confirmation', {title: 'About Us', returnFlightInfo: returnFlightInfo, toFlightInfo: toFlightInfo});

    }
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

module.exports = router;
