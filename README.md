## Using the balena API & SDK to set device tags from within apps.

This is a simple project which runs one container based on the [balena simple-server-node repository][simple-server-node] that demonstrates how to set device tags from within your application.

This project serves up `"Hello World!"` on port `:80` of your balena device and additionally:
* sets the `stats.laststart` tag with the current timestamp when the application starts.
  * This is done using CURL in the application's `start.sh`.
* sets the `stats.lastrequest` tag with the current timestamp whenever the node server responds to an HTTP request.
  * This is done using the javascript [balena-SDK][balena-sdk] in the application's `server.js`.

### Setup

Check out the instructions in the [balena simple-server-node repository][simple-server-node] to get started.

### Authentication

The scripts use the [`BALENA_API_KEY` environment variable][container-environment], which is injected to the environment of all balena applications, to authenticate all requests.

[simple-server-node]:https://github.com/balena-io-projects/simple-server-node
[balena-sdk]:https://github.com/balena-io/balena-sdk/
[container-environment]:https://docs.balena.io/runtime/runtime/#the-container-environment
