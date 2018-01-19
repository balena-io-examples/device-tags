## Using the resin.io API & SDK to set device tags from within apps.

This is a simple project based on the [resin.io simple-server-node repository][simple-server-node] that demonstrates how to set device tags from within your application.

This project serves up `"Hello World!"` on port `:80` of your resin.io device and additionally:
* sets the `stats.laststart` tag with the current timestamp when the application starts.
  * This is done using CURL in the application's `start.sh`.
* sets the `stats.lastrequest` tag with the current timestamp whenever the node server responds to an HTTP request.
  * This is done using the javascript [resin-SDK][resin-sdk] in the application's `server.js`.

### Setup

Check out the instructions in the [resin.io simple-server-node repository][simple-server-node] to get started.

### Authentication

The scripts will check whether the [`USER_API_KEY` environment variable][environment-variables] is defined and use it to authenticate all requests. In case that this isn't provided, then they will fallback using the [`RESIN_API_KEY` environment variable][container-environment] which is injected to the environment of all resin.io applications.

You can find more information on how to generate user API Keys [here][resin-user-api-keys].


[simple-server-node]:https://github.com/resin-io-projects/simple-server-node
[resin-sdk]:https://github.com/resin-io/resin-sdk/
[resin-user-api-keys]:https://forums.resin.io/t/auth-token-without-expiration-to-use-api/302/25?u=thgreasi
[container-environment]:https://docs.resin.io/runtime/runtime/#the-container-environment
[environment-variables]:https://docs.resin.io/management/env-vars/#environment-variables
