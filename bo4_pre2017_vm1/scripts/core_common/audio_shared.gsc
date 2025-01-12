#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/music_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;

#namespace audio;

// Namespace audio/audio_shared
// Params 0, eflags: 0x2
// Checksum 0xade537a5, Offset: 0x318
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("audio", &__init__, undefined, undefined);
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xfd835e4e, Offset: 0x358
// Size: 0xec
function __init__() {
    callback::on_spawned(&sndresetsoundsettings);
    callback::on_spawned(&function_fe1c918a);
    callback::on_spawned(&function_dbe63d5d);
    callback::on_player_killed(&on_player_killed);
    callback::on_vehicle_spawned(&vehiclespawncontext);
    level thread register_clientfields();
    level thread sndchyronwatcher();
    level thread function_9c83d0d4();
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xb3436bf0, Offset: 0x450
// Size: 0x214
function register_clientfields() {
    clientfield::register("world", "sndMatchSnapshot", 1, 2, "int");
    clientfield::register("world", "sndFoleyContext", 1, 1, "int");
    clientfield::register("scriptmover", "sndRattle", 1, 1, "int");
    clientfield::register("toplayer", "sndMelee", 1, 1, "int");
    clientfield::register("vehicle", "sndSwitchVehicleContext", 1, 3, "int");
    clientfield::register("toplayer", "sndCCHacking", 1, 2, "int");
    clientfield::register("toplayer", "sndTacRig", 1, 1, "int");
    clientfield::register("toplayer", "sndLevelStartSnapOff", 1, 1, "int");
    clientfield::register("world", "sndIGCsnapshot", 1, 4, "int");
    clientfield::register("world", "sndChyronLoop", 1, 1, "int");
    clientfield::register("world", "sndZMBFadeIn", 1, 1, "int");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xf5a7453, Offset: 0x670
// Size: 0x64
function sndchyronwatcher() {
    level waittill("chyron_menu_open");
    level clientfield::set("sndChyronLoop", 1);
    level waittill("chyron_menu_closed");
    level clientfield::set("sndChyronLoop", 0);
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x2207119b, Offset: 0x6e0
// Size: 0x38
function function_9c83d0d4() {
    while (true) {
        level waittill("scene_skip_sequence_started");
        music::setmusicstate("death");
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xa2f7a212, Offset: 0x720
// Size: 0x44
function sndresetsoundsettings() {
    self clientfield::set_to_player("sndMelee", 0);
    self util::clientnotify("sndDEDe");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x420c23dd, Offset: 0x770
// Size: 0x3c
function on_player_killed() {
    if (!(isdefined(self.killcam) && self.killcam)) {
        self util::clientnotify("sndDED");
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xa49f59b4, Offset: 0x7b8
// Size: 0x34
function vehiclespawncontext() {
    if (sessionmodeismultiplayergame()) {
        self clientfield::set("sndSwitchVehicleContext", 1);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xc522c329, Offset: 0x7f8
// Size: 0x94
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
// Checksum 0x6f552765, Offset: 0x898
// Size: 0xb2
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
// Params 0, eflags: 0x0
// Checksum 0x59e5ceca, Offset: 0x958
// Size: 0x122
function function_fe1c918a() {
    self endon(#"death");
    self endon(#"disconnect");
    if (!self flag::exists("playing_stinger_fired_at_me")) {
        self flag::init("playing_stinger_fired_at_me", 0);
    } else {
        self flag::clear("playing_stinger_fired_at_me");
    }
    while (true) {
        waitresult = self waittill("missile_lock");
        if (!flag::get("playing_stinger_fired_at_me")) {
            self thread playtargetmissilesound(waitresult.weapon.lockontargetlockedsound, waitresult.weapon.lockontargetlockedsoundloops);
            self waittill("stinger_fired_at_me", "missile_unlocked", "death");
            self notify(#"stop_target_missile_sound");
        }
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x1d487c28, Offset: 0xa88
// Size: 0xe8
function function_dbe63d5d() {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill("stinger_fired_at_me");
        waittillframeend();
        self flag::set("playing_stinger_fired_at_me");
        self thread playtargetmissilesound(waitresult.weapon.lockontargetfiredonsound, waitresult.weapon.lockontargetfiredonsoundloops);
        waitresult.projectile waittill("projectile_impact_explode", "death");
        self notify(#"stop_target_missile_sound");
        self flag::clear("playing_stinger_fired_at_me");
    }
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x0
// Checksum 0x682d3e75, Offset: 0xb78
// Size: 0x28
function unlockfrontendmusic(unlockname, allplayers) {
    if (!isdefined(allplayers)) {
        allplayers = 1;
    }
}

