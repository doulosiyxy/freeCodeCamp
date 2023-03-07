// init project
require('dotenv').config();

const express = require('express');
const mongo = require('mongodb');
const mongoose = require('mongoose');
const app = express();
const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: false }));
const shortId = require('shortid');
const dns = require('dns');
const parser = require('url');

// enable fcc to test
var cors = require('cors');
app.use(cors({ optionsSuccessStatus: 200 }));

//grant access to public assets
app.use(express.static('public'));
app.get('/', function(req, res) {
  res.sendFile(__dirname + '/views/index.html');
});

//connect to database
mongoose.connect(process.env.URL_URI, { useNewUrlParser: true, useUnifiedTopology: true });

//check connection

let connection = mongoose.connection;
connection.on('error', console.error.bind(console, 'connection error:'));
connection.once('open', () => {
  console.log('MongoDB connected');
});

/* Create URL Model */
let urlSchema = new mongoose.Schema({
  original_url: String,
  short_url: String
})

const URL = mongoose.model('URL', urlSchema);

app.post('/api/shorturl', (req, res) => {
  var url = req.body.url
  var urlCode = shortId.generate();

  const isUrl = dns.lookup(parser.parse(url).hostname, (err, address) => {
    if (!address) {
      res.json({
        error: 'invalid url'
      });
    } else {
      URL.findOne({ original_url: url }, (err, data) => {
        if (err) return console.log(err);
        if (data) {
          res.json({
            original_url: data.original_url,
            short_url: data.short_url
          });

        } else {

          var newDoc = new URL({
            original_url: url,
            short_url: urlCode
          });

          newDoc.save((err, data) => {
            if (err) return console.log(err);
            res.json({
              original_url: data.original_url,
              short_url: data.short_url
            })
          });//save
        }//else
      });// findone
    } //else
  }); //dns
});

//get
app.get("/api/shorturl/:short_url", (req, res) => {
  let input = req.params.short_url;

  URL.findOne({ short_url: input }, (err, data) => {
    if (err) return console.log(err);
    if (!data) {
      res.json({
        error: 'invalid url'
      });
    } else {
      res.redirect(data.original_url);
    }
  });
});

var listener = app.listen(process.env.PORT || 3000, function() {
  console.log('Your app is listening on port ' + listener.address().port);
});
