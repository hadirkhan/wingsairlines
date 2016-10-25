var express = require('express');
var path = require('path');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Wings-Welcome!' });
  //res.sendFile('home.html', {root: path.join(__dirname, '..', 'views')});
});

module.exports = router;
