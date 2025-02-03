#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace audio;

// Namespace audio/audio_shared
// Params 0, eflags: 0x6
// Checksum 0x8d308258, Offset: 0x2a0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"audio", &preinit, undefined, undefined, undefined);
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x4
// Checksum 0xb61ee199, Offset: 0x2e8
// Size: 0xb4
function private preinit() {
    util::registerclientsys("duckCmd");
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&sndresetsoundsettings);
    callback::on_player_killed(&on_player_killed);
    callback::on_vehicle_spawned(&vehiclespawncontext);
    level thread register_clientfields();
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x4d603ffd, Offset: 0x3a8
// Size: 0x2d4
function register_clientfields() {
    clientfield::register("world", "sndMatchSnapshot", 1, 2, "int");
    clientfield::register("scriptmover", "sndRattle", 1, 1, "counter");
    clientfield::register("allplayers", "sndRattle", 1, 1, "counter");
    clientfield::register("toplayer", "sndMelee", 1, 1, "int");
    clientfield::register("vehicle", "sndSwitchVehicleContext", 1, 3, "int");
    clientfield::register("toplayer", "sndCCHacking", 1, 2, "int");
    clientfield::register("toplayer", "sndTacRig", 1, 1, "int");
    clientfield::register("toplayer", "sndLevelStartSnapOff", 1, 1, "int");
    clientfield::register("world", "sndIGCsnapshot", 1, 4, "int");
    clientfield::register("world", "sndChyronLoop", 1, 1, "int");
    clientfield::register("world", "sndZMBFadeIn", 1, 1, "int");
    clientfield::register("world", "sndDeactivateSquadSpawnMusic", 1, 1, "int");
    clientfield::register("toplayer", "sndVehicleDamageAlarm", 1, 1, "counter");
    clientfield::register("toplayer", "sndCriticalHealth", 1, 1, "int");
    clientfield::register("toplayer", "sndLastStand", 1, 1, "int");
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x0
// Checksum 0x46c379b9, Offset: 0x688
// Size: 0x5c
function function_dcd27601(state, player) {
    if (isdefined(player)) {
        util::setclientsysstate("duckCmd", state, player);
        return;
    }
    util::setclientsysstate("duckCmd", state);
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x82a9db7c, Offset: 0x6f0
// Size: 0x9c
function sndchyronwatcher() {
    level waittill(#"chyron_menu_open");
    if (isdefined(level.var_3bc9e7f0) == 0) {
        level clientfield::set("sndChyronLoop", 1);
    }
    level waittill(#"chyron_menu_closed");
    if (isdefined(level.var_3bc9e7f0) == 0) {
        level clientfield::set("sndChyronLoop", 0);
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xac7dcfd9, Offset: 0x798
// Size: 0xa4
function sndresetsoundsettings() {
    self clientfield::set_to_player("sndMelee", 0);
    self util::clientnotify("sndDEDe");
    if (!self flag::exists("playing_stinger_fired_at_me")) {
        self flag::init("playing_stinger_fired_at_me", 0);
        return;
    }
    self flag::clear("playing_stinger_fired_at_me");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xd8fcc2ab, Offset: 0x848
// Size: 0x64
function on_player_connect() {
    self callback::function_d8abfc3d(#"missile_lock", &on_missile_lock);
    self callback::function_d8abfc3d(#"hash_1a32e0fdeb70a76b", &function_c25f7d1);
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xbe0e65c8, Offset: 0x8b8
// Size: 0x74
function on_player_killed(*params) {
    if (sessionmodeiscampaigngame()) {
        if (self util::function_a1d6293()) {
            return;
        }
        music::setmusicstate("death");
        self playsound("uin_player_death");
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xd89b4b05, Offset: 0x938
// Size: 0x54
function vehiclespawncontext() {
    if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
        self clientfield::set("sndSwitchVehicleContext", 1);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x9a66837b, Offset: 0x998
// Size: 0x84
function sndupdatevehiclecontext(added) {
    if (!isdefined(self.sndoccupants)) {
        self.sndoccupants = 0;
    }
    if (added) {
        self.sndoccupants++;
    } else {
        self.sndoccupants--;
        if (self.sndoccupants < 0) {
            self.sndoccupants = 0;
        }
    }
    self clientfield::set("sndSwitchVehicleContext", self.sndoccupants + 1);
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x0
// Checksum 0x73b7218a, Offset: 0xa28
// Size: 0xba
function playtargetmissilesound(alias, looping) {
    self notify(#"stop_target_missile_sound");
    self endon(#"stop_target_missile_sound", #"disconnect", #"death");
    if (isdefined(alias)) {
        time = soundgetplaybacktime(alias) * 0.001;
        if (time > 0) {
            do {
                self playlocalsound(alias);
                wait time;
            } while (looping);
        }
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xf00bb865, Offset: 0xaf0
// Size: 0xce
function on_missile_lock(params) {
    assert(isplayer(self));
    if (!flag::get("playing_stinger_fired_at_me")) {
        self thread playtargetmissilesound(params.weapon.lockontargetlockedsound, params.weapon.lockontargetlockedsoundloops);
        self waittill(#"stinger_fired_at_me", #"missile_unlocked", #"death");
        self notify(#"stop_target_missile_sound");
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xe9d99108, Offset: 0xbc8
// Size: 0x10c
function function_c25f7d1(params) {
    assert(isplayer(self));
    self endon(#"death", #"disconnect");
    self flag::set("playing_stinger_fired_at_me");
    self thread playtargetmissilesound(params.weapon.lockontargetfiredonsound, params.weapon.lockontargetfiredonsoundloops);
    params.projectile waittill(#"projectile_impact_explode", #"death");
    self notify(#"stop_target_missile_sound");
    self flag::clear("playing_stinger_fired_at_me");
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x0
// Checksum 0xdd2d8155, Offset: 0xce0
// Size: 0x14
function unlockfrontendmusic(*unlockname, *allplayers) {
    
}

// Namespace audio/audio_shared
// Params 3, eflags: 0x0
// Checksum 0x4d525491, Offset: 0xd00
// Size: 0xf4
function function_30d4f8c4(attacker, smeansofdeath, weapon) {
    str_alias = #"hash_4296e7b3cbb7f3de";
    var_90937e56 = function_bd53fa92(attacker, smeansofdeath, weapon);
    if (isdefined(var_90937e56)) {
        if (var_90937e56 === #"explosive") {
            str_alias = #"hash_c43c0f6a63f7e0";
        }
        if (var_90937e56 === #"gas") {
            str_alias = #"hash_291958f59b6be82";
        }
    }
    if (weapon.name === #"hatchet") {
        str_alias = #"hash_55bb02aa30e19da8";
    }
    self playsoundtoplayer(str_alias, self);
}

// Namespace audio/audio_shared
// Params 3, eflags: 0x0
// Checksum 0x2ed09990, Offset: 0xe00
// Size: 0xd0
function function_bd53fa92(*attacker, mod, weapon) {
    if (isdefined(mod)) {
        if (mod === "MOD_EXPLOSIVE" || mod === "MOD_GRENADE" || mod === "MOD_GRENADE_SPLASH") {
            return #"explosive";
        }
        if (mod === "MOD_GAS") {
            return #"gas";
        }
        if (mod === "MOD_SUICIDE") {
            return;
        }
    }
    if (isdefined(weapon)) {
        if (weapon.name === "tear_gas") {
            return #"gas";
        }
    }
    return undefined;
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x95769a44, Offset: 0xed8
// Size: 0x4c
function function_641cec60(weapon) {
    if (!isdefined(weapon)) {
        return;
    }
    var_80de6af = 0;
    if (weapon.name == #"knife_loadout") {
        var_80de6af = 1;
    }
    return var_80de6af;
}

