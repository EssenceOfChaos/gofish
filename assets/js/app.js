/*jshint esversion: 6 */
// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".
import { base } from "./base";
// import socket from "./socket";

// PHX PRESENCE //
import { Socket, Presence } from "phoenix";

let socket = new Socket("/socket", {
    params: {}
});

function renderOnlineUsers(presences) {
    let response = "";

    Presence.list(presences, (id, { metas: [first, ...rest] }) => {
        let count = rest.length + 1;
        response += `<br>${id} (count: ${count})</br>`;
    });

    document.querySelector("#UserList").innerHTML = response;
}
socket.connect();

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

channel.join();