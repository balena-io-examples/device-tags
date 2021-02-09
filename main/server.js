const express = require('express');
const app = express();
const { getSdk } = require('balena-sdk');
let sdk;

// reply to request with "Hello World!"
app.get('/', function (req, res) {
  if (sdk) {
    // set the 'stats.lastrequest' tag but w/o blocking the response
    sdk.models.device.tags
      .set(process.env.BALENA_DEVICE_UUID, 'stats.lastrequest', Date.now())
      .catch(function(e) {
        console.error('Error while setting stats.lastrequest tag', e);
      });
  }
  res.send('Hello World from device tags example!');
});

//start a server on port 80 and log its start to our console
const server = app.listen(80, function () {
  sdk = getSdk({
    // only required if the device is not running on balena-cloud.com
    apiUrl: process.env.BALENA_API_URL
  });
  sdk.auth.logout();
  sdk.auth.loginWithToken(process.env.BALENA_API_KEY);

  sdk.models.device.tags.set(process.env.BALENA_DEVICE_UUID, 'stats.lastserverstart', Date.now());

  const port = server.address().port;
  console.log('Example app listening on port ', port);

});
