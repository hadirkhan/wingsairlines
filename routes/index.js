const express = require('express');
const router = express.Router();
const path = require('path');
const JourneyTypeEnum = require('../utilities/JourneyTypeEnum');


var searchModule = require('../models/SearchFlightsModel');
var homepageModule = require('../models/HomePageModel');

router.get('/', function(req, res, next) {
  homepageModule.searchFlights(handleResults);
  function handleResults(err, data){
  	if(err){
  		throw err;
  	}else if (data){
  		res.render('index', { title: 'Wings-Welcome!' , data: data});
  	}
  }
});

router.post('/search', function(req, res, next) {
    var params = req.body;
    searchModule.searchFlights(params.tripType, params.departureAirportCode, params.destinationAirportCode, params.departDate, params.returnDate,
        function (err, data) {
        if(err){
            console.error('Error in searching flight records!');
        }else{
            if(params.tripType == JourneyTypeEnum.ONE_WAY){
                res.render('searchoneway', { title: 'Flight Search' , results: data});
            } else {
                res.render('search', { title: 'Flight Search' , results: data});
            }
        }
    });
});

router.post('/searchoneway', function(req, res, next) {
    res.render('searchoneway', { title: 'Search!' });
});

router.get('/payments', function(req, res, next) {
    res.render('payments', { title: 'Payments' });
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
