#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace medals;

// Namespace medals/medals_shared
// Params 0, eflags: 0x2
// Checksum 0x2dcd4df0, Offset: 0x108
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("medals", &__init__, undefined, undefined);
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x0
// Checksum 0xc77ff403, Offset: 0x148
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x0
// Checksum 0x9c35b824, Offset: 0x178
// Size: 0x54
function init() {
    level.medalinfo = [];
    level.medalcallbacks = [];
    level.numkills = 0;
    callback::on_connect(&on_player_connect);
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x0
// Checksum 0x9c537bd9, Offset: 0x1d8
// Size: 0xe
function on_player_connect() {
    self.lastkilledby = undefined;
}

// Namespace medals/medals_shared
// Params 1, eflags: 0x0
// Checksum 0x14abacf1, Offset: 0x1f0
// Size: 0x1c
function setlastkilledby(attacker) {
    self.lastkilledby = attacker;
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x0
// Checksum 0xdbcc6f94, Offset: 0x218
// Size: 0x10
function offenseglobalcount() {
    level.globalteammedals++;
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x0
// Checksum 0x362c910c, Offset: 0x230
// Size: 0x10
function defenseglobalcount() {
    level.globalteammedals++;
}

// Namespace medals/player_medal
// Params 1, eflags: 0x40
// Checksum 0x5f8d1917, Offset: 0x248
// Size: 0x6c
function event_handler[player_medal] codecallback_medal(eventstruct) {
    self luinotifyevent(%medal_received, 1, eventstruct.medal_index);
    self luinotifyeventtospectators(%medal_received, 1, eventstruct.medal_index);
}

