#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_audio;

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x2
// Checksum 0xede5613a, Offset: 0x250
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_audio", &__init__, undefined, undefined);
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x2e08b253, Offset: 0x298
// Size: 0x1ec
function __init__() {
    clientfield::register("allplayers", "charindex", 1, 3, "int", &charindex_cb, 0, 1);
    clientfield::register("toplayer", "isspeaking", 1, 1, "int", &isspeaking_cb, 0, 1);
    if (!isdefined(level.exert_sounds)) {
        level.exert_sounds = [];
    }
    level.exert_sounds[0][#"playerbreathinsound"] = "vox_exert_generic_inhale";
    level.exert_sounds[0][#"playerbreathoutsound"] = "vox_exert_generic_exhale";
    level.exert_sounds[0][#"playerbreathgaspsound"] = "vox_exert_generic_exhale";
    level.exert_sounds[0][#"falldamage"] = "vox_exert_generic_pain";
    level.exert_sounds[0][#"mantlesoundplayer"] = "vox_exert_generic_mantle";
    level.exert_sounds[0][#"meleeswipesoundplayer"] = "vox_exert_generic_knifeswipe";
    level.exert_sounds[0][#"dtplandsoundplayer"] = "vox_exert_generic_pain";
    callback::on_spawned(&on_player_spawned);
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x3c1618ed, Offset: 0x490
// Size: 0xc
function on_player_spawned(localclientnum) {
    
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x9ec50811, Offset: 0x4a8
// Size: 0x46
function delay_set_exert_id(newval) {
    self endon(#"death");
    self endon(#"sndendexertoverride");
    wait 0.5;
    self.player_exert_id = newval;
}

// Namespace zm_audio/zm_audio
// Params 7, eflags: 0x0
// Checksum 0x68b70b92, Offset: 0x4f8
// Size: 0xa4
function charindex_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!bnewent) {
        self.player_exert_id = newval;
        self._first_frame_exert_id_recieved = 1;
        self notify(#"sndendexertoverride");
        return;
    }
    if (!isdefined(self._first_frame_exert_id_recieved)) {
        self._first_frame_exert_id_recieved = 1;
        self thread delay_set_exert_id(newval);
    }
}

// Namespace zm_audio/zm_audio
// Params 7, eflags: 0x0
// Checksum 0xd1369642, Offset: 0x5a8
// Size: 0x62
function isspeaking_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!bnewent) {
        self.isspeaking = newval;
        return;
    }
    self.isspeaking = 0;
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0xeb79fa95, Offset: 0x618
// Size: 0x9c
function zmbmuslooper() {
    ent = spawn(0, (0, 0, 0), "script_origin");
    playsound(0, #"mus_zmb_gamemode_start", (0, 0, 0));
    wait 10;
    ent playloopsound(#"mus_zmb_gamemode_loop", 0.05);
    ent thread waitfor_music_stop();
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x7544e5ce, Offset: 0x6c0
// Size: 0x7c
function waitfor_music_stop() {
    level waittill(#"stpm");
    self stopallloopsounds(0.1);
    playsound(0, #"mus_zmb_gamemode_end", (0, 0, 0));
    wait 1;
    self delete();
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0x5f94f8d9, Offset: 0x748
// Size: 0x34
function playerfalldamagesound(client_num, firstperson) {
    self playerexert(client_num, "falldamage");
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x6d42718b, Offset: 0x788
// Size: 0x76
function clientvoicesetup() {
    callback::on_localclient_connect(&audio_player_connect);
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        thread audio_player_connect(i);
    }
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x0
// Checksum 0x9eb74866, Offset: 0x808
// Size: 0xcc
function audio_player_connect(localclientnum) {
    thread sndvonotifyplain(localclientnum, "playerbreathinsound");
    thread sndvonotifyplain(localclientnum, "playerbreathoutsound");
    thread sndvonotifyplain(localclientnum, "playerbreathgaspsound");
    thread sndvonotifyplain(localclientnum, "mantlesoundplayer");
    thread sndvonotifyplain(localclientnum, "meleeswipesoundplayer");
    thread sndvonotifydtp(localclientnum, "dtplandsoundplayer");
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0x46bcde29, Offset: 0x8e0
// Size: 0x1a4
function playerexert(localclientnum, exert) {
    if (isdefined(self.isspeaking) && self.isspeaking == 1) {
        return;
    }
    if (isdefined(self.beast_mode) && self.beast_mode) {
        return;
    }
    id = level.exert_sounds[0][exert];
    if (isarray(level.exert_sounds[0][exert])) {
        id = array::random(level.exert_sounds[0][exert]);
    }
    if (isdefined(self.player_exert_id) && isarray(level.exert_sounds) && isarray(level.exert_sounds[self.player_exert_id])) {
        if (isarray(level.exert_sounds[self.player_exert_id][exert])) {
            id = array::random(level.exert_sounds[self.player_exert_id][exert]);
        } else {
            id = level.exert_sounds[self.player_exert_id][exert];
        }
    }
    if (isdefined(id)) {
        self playsound(localclientnum, id);
    }
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0x61a8d3a2, Offset: 0xa90
// Size: 0xe8
function sndvonotifydtp(localclientnum, notifystring) {
    level notify("kill_sndVoNotifyDTP" + localclientnum + notifystring);
    level endon("kill_sndVoNotifyDTP" + localclientnum + notifystring);
    player = function_f97e7787(localclientnum);
    while (!isdefined(player)) {
        player = function_f97e7787(localclientnum);
        waitframe(1);
    }
    player endon(#"disconnect");
    player endon(#"death");
    for (;;) {
        player waittill(notifystring);
        player playerexert(localclientnum, notifystring);
    }
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0xabbe08f6, Offset: 0xb80
// Size: 0x218
function sndmeleeswipe(localclientnum, notifystring) {
    player = undefined;
    while (!isdefined(player)) {
        player = function_f97e7787(localclientnum);
        waitframe(1);
    }
    player endon(#"disconnect");
    player endon(#"death");
    for (;;) {
        player waittill(notifystring);
        currentweapon = getcurrentweapon(localclientnum);
        if (isdefined(level.sndnomeleeonclient) && level.sndnomeleeonclient) {
            return;
        }
        if (isdefined(player.is_player_zombie) && player.is_player_zombie) {
            playsound(0, #"zmb_melee_whoosh_zmb_plr", player.origin);
            continue;
        }
        if (currentweapon.name == "bowie_knife") {
            playsound(0, #"zmb_bowie_swing_plr", player.origin);
            continue;
        }
        if (currentweapon.name == "spoon_zm_alcatraz") {
            playsound(0, #"zmb_spoon_swing_plr", player.origin);
            continue;
        }
        if (currentweapon.name == "spork_zm_alcatraz") {
            playsound(0, #"zmb_spork_swing_plr", player.origin);
            continue;
        }
        playsound(0, #"zmb_melee_whoosh_plr", player.origin);
    }
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0x250b8d10, Offset: 0xda0
// Size: 0x100
function sndvonotifyplain(localclientnum, notifystring) {
    level notify("kill_sndVoNotifyPlain" + localclientnum + notifystring);
    level endon("kill_sndVoNotifyPlain" + localclientnum + notifystring);
    player = undefined;
    while (!isdefined(player)) {
        player = function_f97e7787(localclientnum);
        waitframe(1);
    }
    player endon(#"disconnect");
    player endon(#"death");
    for (;;) {
        player waittill(notifystring);
        if (isdefined(player.is_player_zombie) && player.is_player_zombie) {
            continue;
        }
        player playerexert(localclientnum, notifystring);
    }
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x1941b89b, Offset: 0xea8
// Size: 0x74
function end_gameover_snapshot() {
    level waittill(#"demo_jump", #"demo_player_switch", #"snd_clear_script_duck");
    wait 1;
    audio::snd_set_snapshot("default");
    level thread gameover_snapshot();
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x9d552aee, Offset: 0xf28
// Size: 0x4c
function gameover_snapshot() {
    level waittill(#"zesn");
    audio::snd_set_snapshot("zmb_game_over");
    level thread end_gameover_snapshot();
}

// Namespace zm_audio/zm_audio
// Params 7, eflags: 0x0
// Checksum 0x6ec19ba0, Offset: 0xf80
// Size: 0x10e
function sndzmblaststand(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playsound(localclientnum, #"hash_5e980fdf2497d9a1", (0, 0, 0));
        self.var_d3e6ead1 = self playloopsound(#"hash_7b41cf42e1b9847b");
        self.inlaststand = 1;
        return;
    }
    if (isdefined(self.inlaststand) && self.inlaststand) {
        playsound(localclientnum, #"hash_1526662237d7780f", (0, 0, 0));
        self stoploopsound(self.var_d3e6ead1);
        self.inlaststand = 0;
    }
}

