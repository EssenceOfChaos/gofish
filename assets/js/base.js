/*jshint esversion: 6 */
// BASE JS
// just some basic javascript added to the project

// navbar - indicate active page
document.addEventListener("DOMContentLoaded", function() {
    if (window.location.pathname == "/players") {
        let players = document.getElementById("players");
        players.className += " active";
    } else if (window.location.pathname == "/rules") {
        let rules = document.getElementById("rules");
        rules.className += " active";
    } else if (window.location.pathname == "/info") {
        let info = document.getElementById("info");
        info.className += " active";
    }

    console.log("baseJS is now loaded.");
    console.log("URI path is " + window.location.pathname);
});