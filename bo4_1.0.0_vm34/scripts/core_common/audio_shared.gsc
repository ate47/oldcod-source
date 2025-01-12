#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace audio;

// Namespace audio/audio_shared
// Params 0, eflags: 0x2
// Checksum 0x7eb08b2f, Offset: 0x1d0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"audio", &__init__, undefined, undefined);
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x2ffcd02a, Offset: 0x218
// Size: 0xb4
function __init__() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&sndresetsoundsettings);
    callback::on_player_killed(&on_player_killed);
    callback::on_vehicle_spawned(&vehiclespawncontext);
    level thread register_clientfields();
    level thread sndchyronwatcher();
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xfb3705b7, Offset: 0x2d8
// Size: 0x2d4
function register_clientfields() {
    clientfield::register("world", "sndMatchSnapshot", 1, 2, "int");
    clientfield::register("world", "sndFoleyContext", 1, 1, "int");
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
    clientfield::register("toplayer", "sndVehicleDamageAlarm", 1, 1, "counter");
    clientfield::register("toplayer", "sndCriticalHealth", 1, 1, "int");
    clientfield::register("toplayer", "sndLastStand", 1, 1, "int");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xe23ec96, Offset: 0x5b8
// Size: 0x9c
function sndchyronwatcher() {
    level waittill(#"chyron_menu_open");
    if (isdefined(level.var_a258c212) == 0) {
        level clientfield::set("sndChyronLoop", 1);
    }
    level waittill(#"chyron_menu_closed");
    if (isdefined(level.var_a258c212) == 0) {
        level clientfield::set("sndChyronLoop", 0);
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x20baa5e3, Offset: 0x660
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
// Checksum 0x78b68d88, Offset: 0x710
// Size: 0x64
function on_player_connect() {
    self callback::function_1dea870d(#"missile_lock", &on_missile_lock);
    self callback::function_1dea870d(#"hash_1a32e0fdeb70a76b", &function_527107f);
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x349c0392, Offset: 0x780
// Size: 0x3c
function on_player_killed() {
    if (!(isdefined(self.killcam) && self.killcam)) {
        self util::clientnotify("sndDED");
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x8edbd36e, Offset: 0x7c8
// Size: 0x54
function vehiclespawncontext() {
    if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
        self clientfield::set("sndSwitchVehicleContext", 1);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xf05755c3, Offset: 0x828
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
// Checksum 0x15dee2c0, Offset: 0x8b8
// Size: 0xba
function playtargetmissilesound(alias, looping) {
    self notify(#"stop_target_missile_sound");
    self endon(#"stop_target_missile_sound");
    self endon(#"disconnect");
    self endon(#"death");
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
// Checksum 0x3e4170e1, Offset: 0x980
// Size: 0xd6
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
// Checksum 0xa19ae6ed, Offset: 0xa60
// Size: 0x10c
function function_527107f(params) {
    assert(isplayer(self));
    self endon(#"death");
    self endon(#"disconnect");
    self flag::set("playing_stinger_fired_at_me");
    self thread playtargetmissilesound(params.weapon.lockontargetfiredonsound, params.weapon.lockontargetfiredonsoundloops);
    params.projectile waittill(#"projectile_impact_explode", #"death");
    self notify(#"stop_target_missile_sound");
    self flag::clear("playing_stinger_fired_at_me");
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x0
// Checksum 0xdfff03ec, Offset: 0xb78
// Size: 0x24
function unlockfrontendmusic(unlockname, allplayers = 1) {
    
}

// Namespace audio/audio_shared
// Params 3, eflags: 0x0
// Checksum 0x4c5b642e, Offset: 0xba8
// Size: 0x40c
function function_11607c82(attacker, smeansofdeath, weapon) {
    if (!isdefined(weapon)) {
        return;
    }
    str_alias = #"hash_6d746e7e1822ad79";
    switch (weapon.rootweapon.name) {
    case #"hero_annihilator":
        str_alias = #"hash_5e5050d7f9042fac";
        break;
    case #"eq_gravityslam":
        str_alias = #"hash_191ff361b2a52032";
        break;
    case #"molotov_fire":
        str_alias = #"hash_40a5f428bba291a8";
        break;
    case #"gadget_radiation_field":
        str_alias = #"hash_16cc324cc4a290fc";
        break;
    case #"sniper_powersemi_t8":
    case #"sniper_powerbolt_t8":
    case #"sniper_quickscope_t8":
    case #"sniper_fastrechamber_t8":
        str_alias = #"hash_9b40eefa77d6446";
        break;
    case #"tr_midburst_t8":
    case #"ar_damage_t8":
    case #"ar_accurate_t8":
    case #"smg_capacity_t8":
    case #"pistol_burst_t8":
    case #"ar_fastfire_t8":
    case #"lmg_heavy_t8":
    case #"ar_stealth_t8":
    case #"tr_longburst_t8":
    case #"smg_standard_t8":
    case #"lmg_spray_t8":
    case #"smg_accurate_t8":
    case #"ar_modular_t8":
    case #"smg_fastfire_t8":
    case #"lmg_standard_t8":
    case #"smg_handling_t8":
        str_alias = #"hash_669a22b65807ee3b";
        break;
    case #"pistol_standard_t8":
    case #"pistol_revolver_t8":
    case #"tr_powersemi_t8":
        str_alias = #"hash_2b81ab20b5e3d199";
        break;
    case #"shotgun_pump_t8":
    case #"shotgun_semiauto_t8":
        str_alias = #"hash_10ba93a0930567c5";
        break;
    case #"eq_sticky_grenade":
        str_alias = #"hash_5330d1fc9ae03536";
        break;
    case #"eq_cluster_semtex_grenade":
        str_alias = #"hash_58d3e2978f41dc59";
        break;
    }
    switch (smeansofdeath) {
    case #"mod_trigger_hurt":
        str_alias = #"hash_3f3f94dcb425d73b";
        break;
    case #"mod_melee_weapon_butt":
    case #"mod_melee_assassinate":
    case #"mod_melee":
        str_alias = #"hash_3fa09e466fc19e30";
        break;
    case #"mod_meta":
    case #"mod_suicide":
        str_alias = undefined;
        break;
    }
    if (isdefined(str_alias)) {
        self playsoundtoplayer(str_alias, self);
    }
}

