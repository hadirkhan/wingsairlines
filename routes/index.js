var express = require('express');
var router = express.Router();
var path = require('path');

var searchModule = require('../models/SearchFlightsModel.js');

var paymentsModule = require('../models/PaymentsModel.js');

router.get('/', function(req, res, next) {
  res.render('index', { title: 'Wings-Welcome!' });
});

router.get('/search', function(req, res, next) {
  searchModule.searchFlights();
  res.render('search', { title: 'Flight Search' });
});

router.get('/searchoneway', function(req, res, next) {
  res.render('searchoneway', { title: 'Search!' });
});

router.get('/payments', function(req, res, next) {
  // paymentsModule.paymentdetails();
  res.render('payments', { title: 'Payments' });
});

router.get('/confirmation', function(req, res, next){
  res.render('confirmation', { title: 'Confirmation' });
});

router.get('/pnr', function(req, res, next){
  res.render('pnr', { title: 'Check PNR' });
});
router.get('/about', function(req, res, next){
  res.render('about', {title: 'About Us'});
});

module.exports = router;