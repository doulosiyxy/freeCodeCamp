const express = require('express')
const app = express()
const cors = require('cors')
require('dotenv').config()
const mongoose = require('mongoose')
const mongo = require('mongodb')
const bodyParser = require('body-parser')

app.use(cors())
app.use(express.static('public'))
app.use(bodyParser.urlencoded({ extended: false }));

mongoose.connect(process.env.URL_URI, { useNewUrlParser: true, useUnifiedTopology: true });

let connection = mongoose.connection;
connection.on('error', console.error.bind(console, 'connection error:'));
connection.once('open', () => {
  console.log('MongoDB connected');
});

let userSchema = new mongoose.Schema({
  username: String,
  log: [{
    description: String,
    duration: Number,
    date: String
  }]
});

let User = mongoose.model('User', userSchema)

app.get('/', (req, res) => {
  res.sendFile(__dirname + '/views/index.html')
});

app.post('/api/users', (req, res) => {
  const username = req.body.username;
  User.findOne({username: username})
  .then((data) => {
        if(data) {
          res.json({
            username: data.username,
            _id: data._id
          })
        } else {
          let user = new User({
            username: username
          });

          user.save().then((data) => {
            res.json({
              username: data.username,
              _id: data._id
            });
          })
          .catch((err) => {
            console.log(err);
          })
        }
  })
  .catch((err) => {
    console.log(err);
  })
});

app.post('/api/users/:_id/exercises', (req, res) => {
  const uid = req.params._id;
  const description = req.body.description;
  const duration = req.body.duration;
  let dateInput = req.body.date;
  let date = dateInput ? new Date(dateInput) : new Date();
  date = date.toDateString()

  const dataObj = {
    description: description,
    duration: duration,
    date: date
  }

  User.findById(uid)
  .then((data) => {
      data.log.push(dataObj);
      data.save().then((updatedData) => {
        res.json({
          username: updatedData.username,
          description: updatedData.log[updatedData.log.length - 1].description,
          duration: updatedData.log[updatedData.log.length - 1].duration,
          date: updatedData.log[updatedData.log.length - 1].date,
          _id: updatedData._id
        })
      }).catch((err) => {
        console.log(err)
      });
  })
})

app.get('/api/users/:_id/logs', (req, res) => {
  const uid = req.params._id;
  User.findById(uid)
    .then((data) => {

      let log = data.log

      if(req.query.limit) {
        log = data.log.slice(0, req.query.limit);
      }

      if(req.query.from || req.query.to) {
        let from = new Date(0);
        let to = new Date();

        if(req.query.from) {
          from = new Date(req.query.from);
        }
        if(req.query.to) {
          to = new Date(req.query.to);
        }

        from = from.getTime();
        to = to.getTime();

        log = data.log.filter(excercise => {
          let excerciseUnix = new Date(excercise.date).getTime();
          return excerciseUnix >= from && excerciseUnix <= to;
        });
      }

      res.json({
        username: data.username,
        count: log.length,
        _id: data._id,
        log: log
      })
    })
    .catch((err) => {
      console.log(err);
    });
});

app.get('/api/users', (req, res) => {
  User.find({})
    .then((data) => {
      let userInfo = data.map((account) => {
        return {
          _id: account._id,
          username: account.username
        }
      })
      res.json(
        userInfo
      )
    })
    .catch((err) => {
      console.log(err)
    });
});

const listener = app.listen(process.env.PORT || 3000, () => {
  console.log('Your app is listening on port ' + listener.address().port)
})
