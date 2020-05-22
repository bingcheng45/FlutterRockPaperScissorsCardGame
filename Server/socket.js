var app = require('express')();
var http = require('http').createServer(app);
var io = require('socket.io')(http);

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
});

// usernames which are currently connected to the chat
var usernames = {};

// rooms which are currently available in chat
var rooms = ['lobby','room1','room2','room3'];

io.on('connection', (socket) => {

    // when the client emits 'adduser', this listens and executes
	socket.on('adduser', function(username){
        // echo to client they've connected
        io.emit('test', 'you have connected to lobby');
        console.log(username);
		// store the username in the socket session for this client
		socket.username = username;
		// store the room name in the socket session for this client
		socket.room = 'lobby';
		// add the client's username to the global list
		usernames[username] = username;
		// send client to lobby
        socket.join('lobby');
        
        

		// echo to client they've connected
		socket.emit('updatechat', 'SERVER', 'you have connected to lobby');
		// echo to lobby that a person has connected to their room
		socket.broadcast.to('lobby').emit('updatechat', 'SERVER', username + ' has connected to this room');
		socket.emit('updaterooms', rooms, 'lobby');
	});

    //Leave the room if the user closes the socket
    socket.on('disconnect', () => {
        socket.leave('room1');
        console.log('a user disconnected');
    });

    socket.on('editservermsg', (data) => {

    });


    console.log('a user connected ');
    //io.emit('receive_message', 'test');
    // socket.on("send_message", (data) => {
    //     io.emit("receive_message", 'test');
    //     socket.join('room1');
    //     console.log(data);
    // });

});


http.listen(3000, () => {
    console.log('listening on *:3000');
});