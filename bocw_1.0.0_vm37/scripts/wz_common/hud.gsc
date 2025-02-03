#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#using scripts\wz_common\util;

#namespace hud;

// Namespace hud/hud
// Params 0, eflags: 0x0
// Checksum 0xc1044a72, Offset: 0x3d8
// Size: 0x3f4
function function_9b9cecdf() {
    clientfield::function_5b7d846d("hudItems.warzone.reinsertionPassengerCount", 1, 7, "int");
    clientfield::register_clientuimodel("hudItems.alivePlayerCount", 1, 7, "int", 0);
    clientfield::register_clientuimodel("hudItems.alivePlayerCountEnemy", 1, 7, "int", 0);
    clientfield::register_clientuimodel("hudItems.aliveTeammateCount", 1, 7, "int", 1);
    clientfield::register_clientuimodel("hudItems.spectatorsCount", 1, 7, "int", 1);
    clientfield::register_clientuimodel("hudItems.playerKills", 1, 7, "int", 0);
    clientfield::register_clientuimodel("hudItems.playerCleanUps", 1, 7, "int", 0);
    clientfield::register_clientuimodel("presence.modeparam", 1, 7, "int", 1);
    clientfield::register_clientuimodel("hudItems.hasBackpack", 1, 1, "int", 0);
    clientfield::register_clientuimodel("hudItems.armorType", 1, 2, "int", 0);
    clientfield::register_clientuimodel("hudItems.streamerLoadFraction", 1, 5, "float", 1);
    clientfield::register_clientuimodel("hudItems.wzLoadFinished", 1, 1, "int", 1);
    clientfield::register_clientuimodel("hudItems.showReinsertionPassengerCount", 1, 1, "int", 0);
    clientfield::register_clientuimodel("hudItems.playerLivesRemaining", 15000, 3, "int");
    clientfield::register_clientuimodel("hudItems.playerCanRedeploy", 15000, 1, "int");
    clientfield::register("toplayer", "realtime_multiplay", 1, 1, "int");
    clientfield::function_5b7d846d("hudItems.warzone.collapse", 11000, 21, "int");
    clientfield::function_5b7d846d("hudItems.warzone.waveRespawnTimer", 15000, 21, "int");
    clientfield::function_5b7d846d("hudItems.warzone.collapseIndex", 1, 3, "int");
    clientfield::function_5b7d846d("hudItems.warzone.collapseCount", 1, 3, "int");
    clientfield::function_5b7d846d("hudItems.warzone.reinsertionIndex", 1, 3, "int");
    clientfield::register_clientuimodel("hudItems.skydiveAltimeterVisible", 1, 1, "int");
    clientfield::function_5b7d846d("hudItems.skydiveAltimeterHeight", 1, 16, "int");
    clientfield::function_5b7d846d("hudItems.skydiveAltimeterSeaHeight", 1, 16, "int");
}

// Namespace hud/hud
// Params 0, eflags: 0x0
// Checksum 0x4e982854, Offset: 0x7d8
// Size: 0xec
function function_2f66bc37() {
    assert(isplayer(self));
    actionslot3 = getdvarint(#"hash_449fa75f87a4b5b4", 0) < 0 ? "flourish_callouts" : "ping_callouts";
    self setactionslot(3, actionslot3);
    actionslot4 = getdvarint(#"hash_23270ec9008cb656", 0) < 0 ? "scorestreak_wheel" : "sprays_boasts";
    self setactionslot(4, actionslot4);
}

// Namespace hud/hud
// Params 1, eflags: 0x0
// Checksum 0x937ad854, Offset: 0x8d0
// Size: 0x8c
function function_cb4b48d5(var_80427091 = 1) {
    assert(isplayer(self));
    if (var_80427091) {
        self setactionslot(3, "");
    }
    self setactionslot(4, "");
}

// Namespace hud/hud
// Params 0, eflags: 0x0
// Checksum 0xc17e7965, Offset: 0x968
// Size: 0x14
function function_22df4165() {
    level.var_22df4165 = 1;
}

// Namespace hud/hud
// Params 0, eflags: 0x0
// Checksum 0xe411c6b3, Offset: 0x988
// Size: 0x48
function function_5db32126() {
    while (true) {
        waitframe(1);
        if (is_true(level.var_22df4165)) {
            function_e91890a7();
        }
    }
}

// Namespace hud/hud
// Params 0, eflags: 0x0
// Checksum 0x4180bb9d, Offset: 0x9d8
// Size: 0x222
function function_e91890a7() {
    if (!is_true(level.var_22df4165)) {
        return;
    }
    util::waittillslowprocessallowed();
    player_counts = util::function_de15dc32();
    players = getplayers();
    foreach (player in players) {
        aliveplayercount = player_counts.alive;
        player clientfield::set_player_uimodel("presence.modeparam", aliveplayercount);
        player clientfield::set_player_uimodel("hudItems.alivePlayerCount", aliveplayercount);
        aliveteammates = 0;
        teammembers = getplayers(player.team);
        foreach (member in teammembers) {
            if (isalive(member) && member != player) {
                aliveteammates++;
            }
        }
        player clientfield::set_player_uimodel("hudItems.aliveTeammateCount", aliveteammates);
    }
    level.var_22df4165 = undefined;
}

// Namespace hud/enter_vehicle
// Params 1, eflags: 0x40
// Checksum 0x21af55f6, Offset: 0xc08
// Size: 0x3c
function event_handler[enter_vehicle] codecallback_entervehicle(*eventstruct) {
    if (isplayer(self)) {
        self function_cb4b48d5(0);
    }
}

// Namespace hud/exit_vehicle
// Params 1, eflags: 0x40
// Checksum 0xcfd44012, Offset: 0xc50
// Size: 0x3c
function event_handler[exit_vehicle] codecallback_exitvehicle(*eventstruct) {
    if (isplayer(self)) {
        self function_2f66bc37();
    }
}

// Namespace hud/freefall
// Params 1, eflags: 0x40
// Checksum 0xc87bf2be, Offset: 0xc98
// Size: 0x5c
function event_handler[freefall] function_5019e563(eventstruct) {
    if (eventstruct.freefall) {
        self function_cb4b48d5(0);
        return;
    }
    if (!eventstruct.var_695a7111) {
        self function_2f66bc37();
    }
}

// Namespace hud/parachute
// Params 1, eflags: 0x40
// Checksum 0x209e7edd, Offset: 0xd00
// Size: 0x4c
function event_handler[parachute] function_87b05fa3(eventstruct) {
    if (eventstruct.parachute) {
        self function_cb4b48d5(0);
        return;
    }
    self function_2f66bc37();
}

