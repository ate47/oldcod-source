#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace medals;

// Namespace medals/medals_shared
// Params 0, eflags: 0x2
// Checksum 0x24c22463, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"medals", &__init__, undefined, undefined);
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x0
// Checksum 0xbfaedbb, Offset: 0xc0
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x0
// Checksum 0x2408a6ac, Offset: 0xf0
// Size: 0x4c
function init() {
    level.medalinfo = [];
    level.medalcallbacks = [];
    level.numkills = 0;
    callback::on_connect(&on_player_connect);
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x0
// Checksum 0x18e32857, Offset: 0x148
// Size: 0xe
function on_player_connect() {
    self.lastkilledby = undefined;
}

// Namespace medals/medals_shared
// Params 2, eflags: 0x0
// Checksum 0x5bcbc5b8, Offset: 0x160
// Size: 0x2e
function setlastkilledby(attacker, inflictor) {
    self.lastkilledby = attacker;
    self.var_eb95f255 = inflictor;
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x0
// Checksum 0x1908dd12, Offset: 0x198
// Size: 0x10
function offenseglobalcount() {
    level.globalteammedals++;
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x0
// Checksum 0xb1898bdd, Offset: 0x1b0
// Size: 0x10
function defenseglobalcount() {
    level.globalteammedals++;
}

// Namespace medals/player_medal
// Params 1, eflags: 0x40
// Checksum 0xd0638f57, Offset: 0x1c8
// Size: 0x6c
function event_handler[player_medal] codecallback_medal(eventstruct) {
    self luinotifyevent(#"medal_received", 1, eventstruct.medal_index);
    self luinotifyeventtospectators(#"medal_received", 1, eventstruct.medal_index);
}

