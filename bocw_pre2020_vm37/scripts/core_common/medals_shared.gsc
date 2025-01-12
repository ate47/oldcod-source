#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace medals;

// Namespace medals/medals_shared
// Params 0, eflags: 0x6
// Checksum 0x8b9c821e, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"medals", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x1d4171c5, Offset: 0xb8
// Size: 0x24
function private function_70a657d8() {
    callback::on_start_gametype(&init);
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x30e2f10f, Offset: 0xe8
// Size: 0x64
function init() {
    level.medalinfo = [];
    level.medalcallbacks = [];
    level.numkills = 0;
    level.prevlastkilltime = 0;
    level.lastkilltime = 0;
    callback::on_connect(&on_player_connect);
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xda5c77e5, Offset: 0x158
// Size: 0xe
function on_player_connect() {
    self.lastkilledby = undefined;
}

// Namespace medals/medals_shared
// Params 2, eflags: 0x0
// Checksum 0x963da465, Offset: 0x170
// Size: 0x2e
function setlastkilledby(attacker, inflictor) {
    self.lastkilledby = attacker;
    self.var_e78602fc = inflictor;
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x0
// Checksum 0x914606ad, Offset: 0x1a8
// Size: 0x10
function offenseglobalcount() {
    level.globalteammedals++;
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x0
// Checksum 0x440bb21f, Offset: 0x1c0
// Size: 0x10
function defenseglobalcount() {
    level.globalteammedals++;
}

// Namespace medals/player_medal
// Params 1, eflags: 0x40
// Checksum 0xa857f4ef, Offset: 0x1d8
// Size: 0x6c
function event_handler[player_medal] codecallback_medal(eventstruct) {
    self luinotifyevent(#"medal_received", 1, eventstruct.medal_index);
    self function_8ba40d2f(#"medal_received", 1, eventstruct.medal_index);
}

