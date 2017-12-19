/*jshint esversion: 6 */

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import { Socket } from "phoenix";

var token = $('meta[name=channel_token]').attr('content');
var socket = new Socket('/socket', {params: {token: token}});
socket.connect();

var lobby = socket.channel('lobby:lobby');
lobby.on('lobby_update', function(response) {
  console.log(JSON.stringify(response.players));
});
lobby.join().receive('ok', function() {
  console.log('Connected to lobby!');
});

lobby.on('game_invite', function(response) {
  console.log('You were invited to join a game by', response.username);
});

window.invitePlayer = function(username) {
  lobby.push('game_invite', {username: username});
};



// format timestamp
let formatTimestamp = timestamp => {
    let date = new Date(timestamp);
    return date.toLocaleTimeString();
};

let channel = socket.channel("lobby:lobby", {});
let chatInput = document.querySelector("#chat-input");
let messagesContainer = document.querySelector("#messages");

// listen for "enter" key press
chatInput.addEventListener("keypress", event => {
    if (event.keyCode === 13) {
        channel.push("new_msg", { body: chatInput.value });
        chatInput.value = "";
    }
});

// listen for messages and append to the messagesContainer
channel.on("new_msg", payload => {
    let messageItem = document.createElement("li");
    messageItem.innerText = `[${Date()}] ${payload.body}`;
    messagesContainer.appendChild(messageItem);
});

channel
    .join()
    .receive("ok", resp => {
        console.log("Joined successfully", resp);
    })
    .receive("error", resp => {
        console.log("Unable to join", resp);
    });

export default socket;

// WORKING WITH PHOENIX PRESENCE MODULE //
// channel.on("presence_state", state => {
//     presences = Presence.syncState(presences, state);
//     renderOnlinePlayers(presences);
// });
//
// channel.on("presence_diff", diff => {
//     presences = Presence.syncDiff(presences, diff);
//     renderOnlinePlayers(presences);
// });
// WORKING WITH PHOENIX PRESENCE MODULE //
