/*jshint esversion: 6 */
import { Socket, Presence } from "phoenix";

var player = document.getElementById("current_player").innerText;
var token = $("meta[name=channel_token]").attr("content");
var socket = new Socket("/socket", {
    params: {
        token: token
    },
    logger: (kind, msg, data) => {
        console.log(`${kind}: ${msg}`, data);
    }
});

console.log("READING TOKEN: ");
console.log(token);

socket.connect();

let presences = {};

function renderOnlineUsers(presences) {
    let response = "";

    Presence.list(presences, (id, { metas: [first, ...rest] }) => {
        let count = rest.length + 1;
        response += `<br>${first.username} (count: ${count})</br>`;
    });

    document.querySelector("#UserList").innerHTML = response;
    // document.querySelector("main[role=main]").innerHTML = response;
}

let channel = socket.channel("lobby:lobby", {});

channel.on("presence_state", state => {
    presences = Presence.syncState(presences, state);
    renderOnlineUsers(presences);
});

channel.on("presence_diff", diff => {
    presences = Presence.syncDiff(presences, diff);
    renderOnlineUsers(presences);
});

let chatInput = document.querySelector("#chatInput");
let messagesContainer = document.querySelector("#messages");
// // listen for "enter" key press
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
    let messageItem = document.createElement("p");
    messageItem.innerText = `[${Date()}] ${payload.body}`;
    messagesContainer.appendChild(messageItem);
});

channel
    .join()
    .receive("ok", resp => {
        console.log("Joined Lobby successfully", resp);
    })
    .receive("error", resp => {
        console.log("Unable to join", resp);
    });

export default socket;