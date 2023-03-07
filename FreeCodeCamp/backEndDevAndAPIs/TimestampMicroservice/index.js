var express = require('express');
var app = express();

//this is just for freecodecamp purposes
var cors = require('cors');
app.use(cors({ optionsSuccessStatus: 200 }));

//add this to make the css files in public accessible.
app.use(express.static(__dirname + '/public'));

//this serves html file to client
app.get("/", (req, res) => {
  res.sendFile(__dirname + "/views/index.html");
});

//api for empty input
app.get("/api", (req, res) => {
  res.json({
      unix: new Date().getTime(),
      utc: new Date().toUTCString()
    });
});

//date api
app.get("/api/:date", (req, res) => {
  var dateReq = req.params.date;
  var newDate;
  var dateObject;

  //if unix
  if (/^\d+$/.test(dateReq)) {
    newDate = new Date(parseInt(dateReq));
    dateObject = getDate(newDate);
  } else {
    newDate = new Date(dateReq);
    //if invalid
    if (newDate == "Invalid Date") {
      dateObject = {
        error: "Invalid Date"
      }
    } else {
      //if date string
      dateObject = getDate(newDate);
    }
  }
  res.json(dateObject);
});

const getDate = (date) => {
  return {
    unix: date.getTime(),
    utc: date.toUTCString()
  }
}

// this assigns listening to a port, putting the app into a running state.
var listener = app.listen(process.env.PORT, () => {
  console.log('Your app is listening on port ' + listener.address().port);
});
