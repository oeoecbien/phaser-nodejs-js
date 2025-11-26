# WebSocket Practical Guide

Ce projet contient des exemples pratiques pour utiliser les WebSockets dans des applications temps réel.

## Objectifs
- Comprendre comment créer un serveur WebSocket.
- Apprendre à intégrer un client WebSocket.
- Explorer des cas d'utilisation concrets comme un chat en temps réel ou un tableau de notifications.

---

## Installation

### Prérequis
- [Node.js](https://nodejs.org/)
- Navigateur supportant les WebSockets

### Étapes

1. Clonez ce dépôt :
   ```bash
   git clone <URL_DU_DEPOT>
   cd <NOM_DU_DEPOT>
   ```

2. Installez les dépendances :
   ```bash
   npm install express ws
   ```

3. Lancez le serveur :
   ```bash
   node server.js
   ```

4. Ouvrez le fichier `client.html` dans votre navigateur pour tester.

---

## Structure du Projet

```
.
├── server.js      # Serveur WebSocket (Node.js)
├── client.html    # Client WebSocket (HTML/JS)
├── public         # Dossier pour les fichiers statiques
│   └── index.html # Interface utilisateur (Chat en temps réel)
└── README.md      # Documentation
```

---

## Exemples Pratiques

### 1. Serveur WebSocket de Base

Le fichier `server.js` contient un exemple de serveur WebSocket simple :

```javascript
const WebSocket = require('ws');
const express = require('express');
const http = require('http');

const app = express();
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

// Middleware pour servir les fichiers statiques
app.use(express.static('public'));

wss.on('connection', (ws) => {
    console.log('Client connecté.');

    ws.on('message', (message) => {
        console.log(`Message reçu : ${message}`);

        // Diffuser le message à tous les clients
        wss.clients.forEach(client => {
            if (client.readyState === WebSocket.OPEN) {
                client.send(message);
            }
        });
    });

    ws.send('Bienvenue sur le serveur WebSocket!');
});

server.listen(8080, () => {
    console.log('Serveur WebSocket en écoute sur http://localhost:8080');
});
```

### 2. Client WebSocket (Interface utilisateur)

Créez un fichier `index.html` dans le dossier `public` pour illustrer un chat en temps réel :

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat en Temps Réel</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background-color: #f5f5f5;
        }
        #messages {
            width: 80%;
            height: 60%;
            border: 1px solid #ddd;
            overflow-y: auto;
            margin-bottom: 10px;
            padding: 10px;
            background-color: #fff;
        }
        #inputArea {
            display: flex;
            width: 80%;
        }
        #messageInput {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
        }
        button {
            padding: 10px;
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>Chat en Temps Réel</h1>
    <div id="messages"></div>
    <div id="inputArea">
        <input id="messageInput" type="text" placeholder="Entrez votre message">
        <button onclick="sendMessage()">Envoyer</button>
    </div>

    <script>
        const socket = new WebSocket('ws://localhost:8080');

        const messagesDiv = document.getElementById('messages');

        socket.onmessage = (event) => {
            const p = document.createElement('p');
            p.textContent = event.data;
            messagesDiv.appendChild(p);
            messagesDiv.scrollTop = messagesDiv.scrollHeight;
        };

        function sendMessage() {
            const input = document.getElementById('messageInput');
            const message = input.value;
            if (message.trim() !== '') {
                socket.send(message);
                input.value = '';
            }
        }
    </script>
</body>
</html>
```

---

## Tester le Projet
1. Lancez le serveur avec `node server.js`.
2. Accédez à `http://localhost:8080` dans votre navigateur.
3. Ouvrez plusieurs onglets ou navigateurs pour tester le chat en temps réel.

---

## Ressources
- [MDN WebSockets](https://developer.mozilla.org/fr/docs/Web/API/WebSockets_API)
- [ws Library](https://github.com/websockets/ws)
