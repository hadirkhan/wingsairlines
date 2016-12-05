var express = require('express');

var Mailgun = require('mailgun-js');

//Init express
var app = express();

//API KEY from Mailgun’s Control Panel
var api_key = process.env.MAILGUN_API_KEY;

//Domain from the Mailgun Control Panel
var domain = process.env.MAILGUN_DOMAIN;

//WingsAirlines Email Address
var email_from = 'no_reply@wingsairlines.com';

//Sending email address
var email_to = 'CUSTOMER@EMAIL.COM'; //Customer email address 

var path = require("path");

//Retrieve ticket for attachment
var fp = path.join(__dirname, './tickets/ticket.pdf');

//////////////////////////////////
// Send Email with Attachment
//////////////////////////////////

var mailgun = new Mailgun({apiKey: api_key, domain: domain});

var data = {
  from: email_from,
  to: email_to,
  subject: 'WingsAirlines - Your ticket :)',
  html: 'Please download your ticket before arriving at the airport.  <br><br>  Thank you for flying WingsAirlines! <br>', 
  attachment: fp
};

mailgun.messages().send(data, function (error, body) {
  console.log(body);
});