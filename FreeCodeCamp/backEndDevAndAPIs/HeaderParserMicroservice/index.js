// init project
require('dotenv').config();
var express = require('express');
var app = express();
// enable fcc to test
var cors = require('cors');
app.use(cors({ optionsSuccessStatus: 200 }));
//grant access to public assets
app.use(express.static('public'));

app.get('/', function(req, res) {
  res.sendFile(__dirname + '/views/index.html');
});

app.get('/api/whoami', function (req, res) {
  res.json({
    ipaddress: req.headers['x-forwarded-for'],
    language: req.headers['accept-language'],
    software: req.headers['user-agent']
  });
});

// listen for requests :)
var listener = app.listen(process.env.PORT || 3000, function() {
  console.log('Your app is listening on port ' + listener.address().port);
});
