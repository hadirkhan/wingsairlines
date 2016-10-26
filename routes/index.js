var express = require('express');
var path = require('path');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Wings-Welcome!' });
  //res.sendFile('home.html', {root: path.join(__dirname, '..', 'views')});
});

router.get('/search', function(req, res, next){
  res.sendFile('search.html', {root: path.join(__dirname, '..', 'views')});
});

router.get('/payments', function(req, res, next){
  res.sendFile('payments.html', {root: path.join(__dirname, '..', 'views')});
});

router.get('/confirmation', function(req, res, next){
  res.sendFile('confirmation.html', {root: path.join(__dirname, '..', 'views')});
});

router.get('/about', function(req, res, next){
  res.render('about', {title: 'About Us'});
});

module.exports = router;
