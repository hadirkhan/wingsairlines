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

    if(req.body.tripType){

        var airportsData;


        var params = req.body;

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

router.get('/payments', function(req, res, next) {
    if(req.session){
        res.render('payments', { title: 'Payments' });
    } else {
        console.info('Redirected user to index page from direct payments');
        res.redirect('/');
    }
});

router.get('/confirmation', function(req, res, next){
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

module.exports = router;
