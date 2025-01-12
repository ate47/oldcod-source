#using scripts\core_common\callbacks_shared;

#namespace bb;

// Namespace bb/bb_shared
// Params 0, eflags: 0x0
// Checksum 0x8a63cef4, Offset: 0x70
// Size: 0x64
function init_shared() {
    callback::on_start_gametype(&init);
    callback::on_joined_team(&player_joined_team);
    callback::on_spawned(&on_player_spawned);
}

// Namespace bb/bb_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xe0
// Size: 0x4
function init() {
    
}

// Namespace bb/bb_shared
// Params 0, eflags: 0x0
// Checksum 0xdce47111, Offset: 0xf0
// Size: 0x86
function on_player_spawned() {
    self._bbdata = [];
    self._bbdata[#"score"] = 0;
    self._bbdata[#"momentum"] = 0;
    self._bbdata[#"spawntime"] = gettime();
    self._bbdata[#"shots"] = 0;
    self._bbdata[#"hits"] = 0;
}

// Namespace bb/bb_shared
// Params 3, eflags: 0x0
// Checksum 0x6cbb7635, Offset: 0x180
// Size: 0x1fe
function commit_weapon_data(spawnid, currentweapon, time0) {
    if (isbot(self)) {
        return;
    }
    assert(isdefined(self._bbdata));
    if (!isdefined(self._bbdata)) {
        return;
    }
    time1 = gettime();
    blackboxeventname = #"mpweapons";
    eventname = #"hash_41cc1afc10e99541";
    if (sessionmodeiscampaigngame()) {
        blackboxeventname = #"cpweapons";
        eventname = #"hash_474292d3118817ab";
    } else if (sessionmodeiszombiesgame()) {
        blackboxeventname = #"zmweapons";
        eventname = #"hash_67140d84a7660909";
    }
    event_data = {#spawnid:spawnid, #name:currentweapon.name, #duration:time1 - time0, #shots:self._bbdata[#"shots"], #hits:self._bbdata[#"hits"]};
    function_b1f6086c(eventname, blackboxeventname, event_data);
    self._bbdata[#"shots"] = 0;
    self._bbdata[#"hits"] = 0;
}

// Namespace bb/bb_shared
// Params 2, eflags: 0x0
// Checksum 0x515b9281, Offset: 0x388
// Size: 0x72
function add_to_stat(statname, delta) {
    if (isbot(self)) {
        return;
    }
    if (isdefined(self._bbdata) && isdefined(self._bbdata[statname])) {
        self._bbdata[statname] = self._bbdata[statname] + delta;
    }
}

// Namespace bb/bb_shared
// Params 1, eflags: 0x0
// Checksum 0x1118cfeb, Offset: 0x408
// Size: 0x44
function function_deb9127a(reason) {
    function_b1f6086c(#"hash_28b295eb3b8e189", {#reason:reason});
}

// Namespace bb/bb_shared
// Params 3, eflags: 0x0
// Checksum 0x952645dd, Offset: 0x458
// Size: 0x74
function function_e8ba589f(name, clientnum, xuid) {
    function_b1f6086c(#"hash_3e5070f3289e386c", {#name:name, #clientnum:clientnum, #xuid:xuid});
}

// Namespace bb/bb_shared
// Params 3, eflags: 0x0
// Checksum 0x6df5c1b6, Offset: 0x4d8
// Size: 0x74
function function_a8a8fbfc(name, clientnum, xuid) {
    function_b1f6086c(#"hash_557aae9aaddeac22", {#name:name, #clientnum:clientnum, #xuid:xuid});
}

// Namespace bb/bb_shared
// Params 1, eflags: 0x0
// Checksum 0xd9bf7c2e, Offset: 0x558
// Size: 0x3a
function player_joined_team(params) {
    if (!isdefined(self.team) || isdefined(self.startingteam)) {
        return;
    }
    self.startingteam = self.team;
}

