#namespace perplayer;

// Namespace perplayer/perplayer
// Params 3, eflags: 0x0
// Checksum 0x4f307350, Offset: 0x60
// Size: 0x94
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
// Checksum 0x81f951ba, Offset: 0x100
// Size: 0x104
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
// Checksum 0xcd617938, Offset: 0x210
// Size: 0x10c
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
// Checksum 0xee0d47f7, Offset: 0x328
// Size: 0x168
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
// Checksum 0xd9df5cd4, Offset: 0x498
// Size: 0xb4
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
// Checksum 0xf5a44a6c, Offset: 0x558
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
// Checksum 0x5ed3590b, Offset: 0x5b8
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
// Checksum 0xb7909c44, Offset: 0x618
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
// Checksum 0xa415893c, Offset: 0x670
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
// Checksum 0xa211bed3, Offset: 0x6d0
// Size: 0x90
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
// Checksum 0xe2f27006, Offset: 0x768
// Size: 0xa8
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

