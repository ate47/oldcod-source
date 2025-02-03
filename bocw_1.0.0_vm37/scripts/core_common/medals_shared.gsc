#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace medals;

// Namespace medals/medals_shared
// Params 0, eflags: 0x6
// Checksum 0x42a468d0, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"medals", &preinit, undefined, undefined, undefined);
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x4
// Checksum 0x744a487e, Offset: 0xb8
// Size: 0x24
function private preinit() {
    callback::on_start_gametype(&init);
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x0
// Checksum 0xb31f780e, Offset: 0xe8
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
// Params 0, eflags: 0x0
// Checksum 0x7182fdb6, Offset: 0x158
// Size: 0xe
function on_player_connect() {
    self.lastkilledby = undefined;
}

// Namespace medals/medals_shared
// Params 2, eflags: 0x0
// Checksum 0xc8059382, Offset: 0x170
// Size: 0x2e
function setlastkilledby(attacker, inflictor) {
    self.lastkilledby = attacker;
    self.var_e78602fc = inflictor;
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x0
// Checksum 0x9779e3b2, Offset: 0x1a8
// Size: 0x10
function offenseglobalcount() {
    level.globalteammedals++;
}

// Namespace medals/medals_shared
// Params 0, eflags: 0x0
// Checksum 0xa39119fb, Offset: 0x1c0
// Size: 0x10
function defenseglobalcount() {
    level.globalteammedals++;
}

// Namespace medals/player_medal
// Params 1, eflags: 0x40
// Checksum 0xa3caa6d3, Offset: 0x1d8
// Size: 0x6c
function event_handler[player_medal] codecallback_medal(eventstruct) {
    self luinotifyevent(#"medal_received", 1, eventstruct.medal_index);
    self function_8ba40d2f(#"medal_received", 1, eventstruct.medal_index);
}

