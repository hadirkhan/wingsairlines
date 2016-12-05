var PDFDocument, doc;
var fs = require('fs');

PDFDocument = require('pdfkit');

doc = new PDFDocument;

doc.pipe(fs.createWriteStream('./tickets/ticket.pdf'));

doc.image('./images/logo.jpg', 25, 25, {width: 33});

// Set a title and pass the X and Y coordinates
doc.fontSize(20).text('WingsAirlines', 75, 35);

doc.moveDown();
doc.moveDown();

doc.fontSize(16).text('Ticket Number: 123456789ORD', 25, 100);
doc.fontSize(16).text('First Name: James', 25, 125);
doc.fontSize(16).text('Last Name: Smith', 25, 150);
doc.end();