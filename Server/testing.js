const app = require('express')()
const http = require('http').createServer(app)
const socketio = require('socket.io')(http)

app.get('/', (req, res) => {
    res.send("Node Server is running. Yay!!")
})

//Socket Logic

console.log('server running on port 3000')
socketio.on("connection", (userSocket) => {
    userSocket.broadcast.emit("receive_message", 'test')
    console.log('someone connected! '+ userSocket.id);
    userSocket.on("send_message", (data) => {
        userSocket.broadcast.emit("receive_message", 'test')
        console.log(data);
    });

    userSocket.on('disconnect', () => {
        console.log('user disconnected');
      });
})



http.listen(3000)