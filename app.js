var mongo = require('mongodb');
var express = require('express');
const util = require('util');

var app = express();

var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017";

app.get('/', function(req, res) {
    MongoClient.connect(url, function(err, client) {
      if (err) return res.send(err);
      db = client.db("visits")
      db.collection("users").findOne({user: 1234}, function(err, result) {
        if (err) return res.send(err);
          count = result.count;
          console.log(result)
          db.collection("users").updateOne({user: 1234}, { $inc: { "count": 1 } }, function(err, res) {
            if (err) return res.send(err);
            console.log(res)
            client.close();
          });
          return res.send(util.format("Hello from %s. This website is visited by %s times", process.env.HOSTNAME, count.toString()));
      });
    });
})

MongoClient.connect(url, function(err, client) {
  if (err) return console.log(err);
        
  var myobj = { user: 1234, count: 0 };
  db = client.db("visits")
  db.collection("users").insertOne(myobj, function(err, res) {
    if (err) return console.log(err);
    console.log("1 document inserted");
    client.close();
  });
});


app.listen(5000, util.format("%s.localhost", process.env.INSTANCE));