const express = require('express');
const http = require('http');
const { Server } = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = new Server(server);

app.use(express.static('public'));

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/public/index.html');
});

let users = {};

io.on('connection', (socket) => {
    // Gérer l'arrivée d'un nouvel utilisateur
    socket.on('user joined', (username) => {
        users[socket.id] = username;
        io.emit('user joined', username);  // Notifier tout le monde
    });

    // Gérer l'envoi de messages
    socket.on('chat message', (data) => {
        socket.broadcast.emit('chat message', data);  // Envoyer à tout le monde sauf à l'émetteur
    });

    // Gérer la déconnexion
    socket.on('disconnect', () => {
        const username = users[socket.id];
        if (username) {
            io.emit('user left', username);  // Notifier tout le monde
            delete users[socket.id];  // Supprimer l'utilisateur
        }
    });
});


server.listen(3000, () => {
    console.log('listening on *:3000');
});