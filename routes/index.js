var express = require('express');
var path = require('path');
var router = express.Router();

router.get('/', function(req, res, next) {
  res.render('index', { title: 'Wings-Welcome!' });
});

router.get('/search', function(req, res, next) {
<<<<<<< HEAD
  res.render('search', { title: 'Flight Search' });
});

=======
  res.render('search', { title: 'Search!' });
});

router.get('/searchoneway', function(req, res, next) {
  res.render('searchoneway', { title: 'Search!' });
});

>>>>>>> 9668f22f528fda5282460d46c73011382dbc5326
router.get('/payments', function(req, res, next) {
  res.render('payments', { title: 'Payments' });
});

router.get('/confirmation', function(req, res, next){
  res.render('confirmation', { title: 'Confirmation' });
});

router.get('/about', function(req, res, next){
  res.render('about', {title: 'About Us'});
});

module.exports = router;
