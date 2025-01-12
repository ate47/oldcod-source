#namespace perplayer;

// Namespace perplayer/perplayer
// Params 3, eflags: 0x0
// Checksum 0x149ee402, Offset: 0x68
// Size: 0xa6
function init(id, playerbegincallback, playerendcallback) {
    handler = spawnstruct();
    handler.id = id;
    handler.playerbegincallback = playerbegincallback;
    handler.playerendcallback = playerendcallback;
    handler.enabled = 0;
    handler.players = [];
    thread onplayerconnect(handler);
    level.handlerglobalflagval = 0;
    return handler;
}

// Namespace perplayer/perplayer
// Params 1, eflags: 0x0
// Checksum 0xf7954ba0, Offset: 0x118
// Size: 0x12e
function enable(handler) {
    if (handler.enabled) {
        return;
    }
    handler.enabled = 1;
    level.handlerglobalflagval++;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i].handlerflagval = level.handlerglobalflagval;
    }
    players = handler.players;
    for (i = 0; i < players.size; i++) {
        if (players[i].handlerflagval != level.handlerglobalflagval) {
            continue;
        }
        if (players[i].handlers[handler.id].ready) {
            players[i] handleplayer(handler);
        }
    }
}

// Namespace perplayer/perplayer
// Params 1, eflags: 0x0
// Checksum 0xeb28e87c, Offset: 0x250
// Size: 0x12e
function disable(handler) {
    if (!handler.enabled) {
        return;
    }
    handler.enabled = 0;
    level.handlerglobalflagval++;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i].handlerflagval = level.handlerglobalflagval;
    }
    players = handler.players;
    for (i = 0; i < players.size; i++) {
        if (players[i].handlerflagval != level.handlerglobalflagval) {
            continue;
        }
        if (players[i].handlers[handler.id].ready) {
            players[i] unhandleplayer(handler, 0, 0);
        }
    }
}

// Namespace perplayer/perplayer
// Params 1, eflags: 0x0
// Checksum 0x27781500, Offset: 0x388
// Size: 0x188
function onplayerconnect(handler) {
    for (;;) {
        waitresult = level waittill(#"connecting");
        player = waitresult.player;
        if (!isdefined(player.handlers)) {
            player.handlers = [];
        }
        player.handlers[handler.id] = spawnstruct();
        player.handlers[handler.id].ready = 0;
        player.handlers[handler.id].handled = 0;
        player.handlerflagval = -1;
        handler.players[handler.players.size] = player;
        player thread onplayerdisconnect(handler);
        player thread onplayerspawned(handler);
        player thread onjoinedteam(handler);
        player thread onjoinedspectators(handler);
        player thread onplayerkilled(handler);
    }
}

// Namespace perplayer/perplayer
// Params 1, eflags: 0x0
// Checksum 0x6bc21422, Offset: 0x518
// Size: 0xc4
function onplayerdisconnect(handler) {
    self waittill(#"disconnect");
    newplayers = [];
    for (i = 0; i < handler.players.size; i++) {
        if (handler.players[i] != self) {
            newplayers[newplayers.size] = handler.players[i];
        }
    }
    handler.players = newplayers;
    self thread unhandleplayer(handler, 1, 1);
}

// Namespace perplayer/perplayer
// Params 1, eflags: 0x0
// Checksum 0x1e45e754, Offset: 0x5e8
// Size: 0x58
function onjoinedteam(handler) {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"joined_team");
        self thread unhandleplayer(handler, 1, 0);
    }
}

// Namespace perplayer/perplayer
// Params 1, eflags: 0x0
// Checksum 0xb6351e32, Offset: 0x648
// Size: 0x58
function onjoinedspectators(handler) {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"joined_spectators");
        self thread unhandleplayer(handler, 1, 0);
    }
}

// Namespace perplayer/perplayer
// Params 1, eflags: 0x0
// Checksum 0x930a88c0, Offset: 0x6a8
// Size: 0x50
function onplayerspawned(handler) {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"spawned_player");
        self thread handleplayer(handler);
    }
}

// Namespace perplayer/perplayer
// Params 1, eflags: 0x0
// Checksum 0x20eb1bcb, Offset: 0x700
// Size: 0x58
function onplayerkilled(handler) {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"killed_player");
        self thread unhandleplayer(handler, 1, 0);
    }
}

// Namespace perplayer/perplayer
// Params 1, eflags: 0x0
// Checksum 0xe830e13a, Offset: 0x760
// Size: 0x98
function handleplayer(handler) {
    self.handlers[handler.id].ready = 1;
    if (!handler.enabled) {
        return;
    }
    if (self.handlers[handler.id].handled) {
        return;
    }
    self.handlers[handler.id].handled = 1;
    self thread [[ handler.playerbegincallback ]]();
}

// Namespace perplayer/perplayer
// Params 3, eflags: 0x0
// Checksum 0x8202ddc2, Offset: 0x800
// Size: 0xb4
function unhandleplayer(handler, unsetready, disconnected) {
    if (!disconnected && unsetready) {
        self.handlers[handler.id].ready = 0;
    }
    if (!self.handlers[handler.id].handled) {
        return;
    }
    if (!disconnected) {
        self.handlers[handler.id].handled = 0;
    }
    self thread [[ handler.playerendcallback ]](disconnected);
}

