const express = require('express');
const app = express();
const { getSdk } = require('balena-sdk');
let sdk;

// reply to request with "Hello World!"
app.get('/', function (req, res) {
  if (sdk) {
    // set the 'device_tags_node.lastrequest' tag but w/o blocking the response
    sdk.models.device.tags
      .set(process.env.BALENA_DEVICE_UUID, 'device_tags_node.last_request', new Date().toISOString())
      .catch(function(e) {
        console.error('Error while setting device_tags_node.last_request tag', e);
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
    await sdk.models.device.tags.set(process.env.BALENA_DEVICE_UUID, 'device_tags_node.last_server_start', new Date().toISOString());
  } catch (err) {
    console.error('Error while setting device_tags_node.last_server_start tag', err);
  }

  const port = server.address().port;
  console.log('Example app listening on port ', port);
});
