var WebSocket = require('ws');

var port = process.env.PORT || 8091;

var server = new WebSocket.Server(
  {
    port: port,
    //host: 'localhost',
  }
)

let msg = "Server: Welcome!";

server.on('connection', function connection(client) {
  client.send(msg);
  console.log('someone is connected');
  client.on('message', function incoming(message) {
    msg = message;
    for (var cl of server.clients) {
      cl.send(message);
    }
    console.log("Received the following message:\n" + message);
  });

  client.on('close', function () {
    console.log('we have lose a client');
  });
});