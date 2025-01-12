#namespace globallogic;

// Namespace globallogic/globallogic_shared
// Params 0, eflags: 0x0
// Checksum 0x77c7b74b, Offset: 0x98
// Size: 0x6e
function resetoutcomeforallplayers() {
    players = level.players;
    for (index = 0; index < players.size; index++) {
        player = players[index];
        player notify(#"reset_outcome");
    }
}

// Namespace globallogic/globallogic_shared
// Params 1, eflags: 0x0
// Checksum 0x74b67807, Offset: 0x110
// Size: 0x68
function function_db16a372(winner) {
    if (!isdefined(winner)) {
        return "tie";
    }
    if (isentity(winner)) {
        return (isdefined(winner.team) ? winner.team : "none");
    }
    return winner;
}

