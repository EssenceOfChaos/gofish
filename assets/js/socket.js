/*jshint esversion: 6 */

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import { Socket } from "phoenix";

var token = $("meta[name=channel_token]").attr("content");
var socket = new Socket("/socket", {
    params: {
        token: token
    }
});
console.log("READING TOKEN: ");
console.log(token);

socket.connect();

function renderOnlineUsers(presences) {
    let response = "";

    Presence.list(presences, (id, { metas: [first, ...rest] }) => {
        let count = rest.length + 1;
        response += `<br>${id} (count: ${count})</br>`;
    });

    document.querySelector("#UserList").innerHTML = response;
}

let presences = {};

let channel = socket.channel("lobby:lobby", {});

channel.on("presence_state", state => {
    presences = Presence.syncState(presences, state);
    renderOnlineUsers(presences);
});

channel.on("presence_diff", diff => {
    presences = Presence.syncDiff(presences, diff);
    renderOnlineUsers(presences);
});

// format timestamp
let formatTimestamp = timestamp => {
    let date = new Date(timestamp);
    return date.toLocaleTimeString();
};

//  ## ## ## ## ## ##  //
// phoenix guide example

let chatInput = document.querySelector("#chat-input");
let messagesContainer = document.querySelector("#messages");
// listen for "enter" key press
chatInput.addEventListener("keypress", event => {
    if (event.keyCode === 13) {
        channel.push("new_msg", {
            body: chatInput.value
        });
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

channel.on("presence_state", state => {
    presences = Presence.syncState(presences, state);
    renderOnlinePlayers(presences);
});

channel.on("presence_diff", diff => {
    presences = Presence.syncDiff(presences, diff);
    renderOnlinePlayers(presences);
});

export default socket;