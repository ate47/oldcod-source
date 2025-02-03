#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\spawn;

#namespace wave_spawn;

// Namespace wave_spawn/wave_spawn
// Params 0, eflags: 0x6
// Checksum 0x4fa3bce9, Offset: 0xf8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"wave_spawn", &__init__, undefined, undefined, undefined);
}

// Namespace wave_spawn/wave_spawn
// Params 0, eflags: 0x0
// Checksum 0xac0286a6, Offset: 0x140
// Size: 0x19c
function __init__() {
    level.wave_spawn = isdefined(getgametypesetting(#"wzenablewaverespawn")) ? getgametypesetting(#"wzenablewaverespawn") : 0;
    if (level.wave_spawn) {
        level.takelivesondeath = 1;
        level.var_a5f54d9f = 1;
        level callback::add_callback(#"hash_e702d557e24bb6", &function_a7ed6d54);
        level callback::add_callback(#"hash_3be1213f454fa90e", &function_301b775b);
        level callback::add_callback(#"hash_7fc21de2eaebdb3b", &function_832ecb3d);
        level callback::add_callback(#"hash_405e46788e83af41", &function_1540761c);
        level callback::add_callback(#"hash_7912e21750e4010d", &function_a27362d0);
        level callback::on_player_killed(&function_14a68e0b);
    }
}

// Namespace wave_spawn/wave_spawn
// Params 0, eflags: 0x0
// Checksum 0x47e0dac7, Offset: 0x2e8
// Size: 0x84
function function_301b775b() {
    if (clientfield::can_set("hudItems.warzone.waveRespawnTimer")) {
        time = int(gettime() + int(level.waverespawndelay * 1000));
        level clientfield::set_world_uimodel("hudItems.warzone.waveRespawnTimer", time);
    }
}

// Namespace wave_spawn/wave_spawn
// Params 1, eflags: 0x4
// Checksum 0x32a8d150, Offset: 0x378
// Size: 0xd8
function private function_a27362d0(*params) {
    if (level.deathcircleindex >= level.deathcircles.size - 2) {
        foreach (player in getplayers()) {
            player clientfield::set_player_uimodel("hudItems.playerCanRedeploy", 0);
            player thread function_ca1398a7();
        }
    }
}

// Namespace wave_spawn/wave_spawn
// Params 0, eflags: 0x0
// Checksum 0x925e7e0a, Offset: 0x458
// Size: 0x108
function function_ca1398a7() {
    if (!isplayer(self)) {
        return;
    }
    self endon(#"disconnect");
    if (!isdefined(self.pers) || !isdefined(self.pers[#"lives"])) {
        return;
    }
    weapon = getweapon(#"bare_hands");
    count = 0;
    lives = self.pers[#"lives"] - 1;
    while (count < lives && isdefined(self)) {
        count++;
        scoreevents::processscoreevent(#"redeploy_bonus", self, undefined, weapon);
    }
}

// Namespace wave_spawn/wave_spawn
// Params 1, eflags: 0x0
// Checksum 0xabb27796, Offset: 0x568
// Size: 0x90
function function_1540761c(*params) {
    if (!level.deathcircle.enabled || level.deathcircles.size <= 0) {
        return;
    }
    time = death_circle::function_49443399();
    level.var_75db41a7 = gettime() + int((time - level.waverespawndelay) * 1000);
}

// Namespace wave_spawn/wave_spawn
// Params 1, eflags: 0x0
// Checksum 0x1ca58619, Offset: 0x600
// Size: 0xa0
function function_832ecb3d(*params) {
    foreach (player in getplayers()) {
        player clientfield::set_player_uimodel("hudItems.playerCanRedeploy", 0);
    }
}

// Namespace wave_spawn/wave_spawn
// Params 1, eflags: 0x0
// Checksum 0x7da2d874, Offset: 0x6a8
// Size: 0x8c
function function_a7ed6d54(params) {
    player = params.player;
    if (isdefined(player) && isdefined(player.pers) && isdefined(player.pers[#"lives"])) {
        player spawn::function_1390f875(player.pers[#"lives"]);
    }
}

// Namespace wave_spawn/wave_spawn
// Params 1, eflags: 0x4
// Checksum 0x9cadccbe, Offset: 0x740
// Size: 0x124
function private function_14a68e0b(*death_params) {
    if (is_true(level.var_1766510)) {
        return;
    }
    level.var_1766510 = 1;
    wavedelay = level.waverespawndelay;
    if (wavedelay) {
        foreach (team, _ in level.teams) {
            level.wavedelay[team] = wavedelay;
            level.lastwave[team] = 0;
        }
        level thread [[ level.wavespawntimer ]]();
        level clientfield::set_world_uimodel("hudItems.warzone.collapseCount", level.deathcircles.size - 1);
    }
}

