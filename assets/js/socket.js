/*jshint esversion: 6 */
import { Socket, Presence } from "phoenix";
// Socket
let player = document.getElementById("current_player").innerText;
let token = $("meta[name=channel_token]").attr("content");
let socket = new Socket("/socket", {
    params: {
        token: token,
        player: player
    },
    logger: (kind, msg, data) => {
        console.log(`${kind}: ${msg}`, data);
    }
});

socket.connect();

// Presence
let presences = {};




function renderOnlineUsers(presences) {
    let response = "";

    Presence.list(presences, (id, { metas: [first, ...rest] }) => {
        let count = rest.length + 1;
        response += `
        <br><strong>${first.username}</strong> (count: ${count})


        `;
    });

    document.querySelector("#UserList").innerHTML = response;
}

// Channel
let channel = socket.channel("lobby:lobby", {});

channel.on("presence_state", state => {
    presences = Presence.syncState(presences, state);
    renderOnlineUsers(presences);
});

channel.on("presence_diff", diff => {
    presences = Presence.syncDiff(presences, diff);
    renderOnlineUsers(presences);
});

//
//
//
let chatInput = document.querySelector("#chatInput");
let messagesContainer = document.querySelector("#MessageList");
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
    messageItem.innerText = `[${payload.player}]  ${payload.body}`;
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

//
lobby.on("game_invite", function(response) {
    console.log("You were invited to join a game by", response.username);
});
window.invitePlayer = function(username) {
    lobby.push("game_invite", { username: username });
};

export default socket;
