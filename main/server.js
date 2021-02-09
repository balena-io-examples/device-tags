const express = require('express');
const app = express();
const { getSdk } = require('balena-sdk');
let sdk;

// reply to request with "Hello World!"
app.get('/', function (req, res) {
  if (sdk) {
    // set the 'stats.lastrequest' tag but w/o blocking the response
    sdk.models.device.tags
      .set(process.env.BALENA_DEVICE_UUID, 'stats.last_request', Date.now())
      .catch(function(e) {
        console.error('Error while setting stats.last_request tag', e);
      });
  }
  res.send('Hello World from device tags example!');
});

//start a server on port 80 and log its start to our console
const server = app.listen(80, async function () {
  sdk = getSdk({
    // only required if the device is not running on balena-cloud.com
    apiUrl: process.env.BALENA_API_URL
  });

  try {
    await sdk.auth.logout();
    await sdk.auth.loginWithToken(process.env.BALENA_API_KEY);
    await sdk.models.device.tags.set(process.env.BALENA_DEVICE_UUID, 'stats.lastserverstart', Date.now());
  } catch (err) {
    console.error('Error while setting stats.lastserverstart tag', err);
  }

  const port = server.address().port;
  console.log('Example app listening on port ', port);
});
