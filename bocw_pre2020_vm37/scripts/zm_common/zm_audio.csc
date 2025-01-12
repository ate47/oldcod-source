#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_audio;

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x6
// Checksum 0xec08c73b, Offset: 0x280
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_audio", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x5 linked
// Checksum 0x227f5412, Offset: 0x2c8
// Size: 0x1e4
function private function_70a657d8() {
    clientfield::register("allplayers", "charindex", 1, 4, "int", &charindex_cb, 0, 1);
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
// Params 1, eflags: 0x1 linked
// Checksum 0x19133613, Offset: 0x4b8
// Size: 0xc
function on_player_spawned(*localclientnum) {
    
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x6a85be2f, Offset: 0x4d0
// Size: 0x46
function delay_set_exert_id(newval) {
    self endon(#"death");
    self endon(#"sndendexertoverride");
    wait 0.5;
    self.player_exert_id = newval;
}

// Namespace zm_audio/zm_audio
// Params 7, eflags: 0x1 linked
// Checksum 0xed716f57, Offset: 0x520
// Size: 0xa4
function charindex_cb(*localclientnum, *oldval, newval, bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!bwastimejump) {
        self.player_exert_id = fieldname;
        self.var_164a7bad = 1;
        self notify(#"sndendexertoverride");
        return;
    }
    if (!isdefined(self.var_164a7bad)) {
        self.var_164a7bad = 1;
        self thread delay_set_exert_id(fieldname);
    }
}

// Namespace zm_audio/zm_audio
// Params 7, eflags: 0x1 linked
// Checksum 0xcd3df1e4, Offset: 0x5d0
// Size: 0x62
function isspeaking_cb(*localclientnum, *oldval, newval, bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!bwastimejump) {
        self.isspeaking = fieldname;
        return;
    }
    self.isspeaking = 0;
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x0
// Checksum 0x942ae2d0, Offset: 0x640
// Size: 0x9c
function zmbmuslooper() {
    ent = spawn(0, (0, 0, 0), "script_origin");
    playsound(0, #"mus_zmb_gamemode_start", (0, 0, 0));
    wait 10;
    ent playloopsound(#"mus_zmb_gamemode_loop", 0.05);
    ent thread waitfor_music_stop();
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xb56910ab, Offset: 0x6e8
// Size: 0x7c
function waitfor_music_stop() {
    level waittill(#"stpm");
    self stopallloopsounds(0.1);
    playsound(0, #"mus_zmb_gamemode_end", (0, 0, 0));
    wait 1;
    self delete();
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0x1a977c27, Offset: 0x770
// Size: 0x34
function playerfalldamagesound(client_num, *firstperson) {
    self playerexert(firstperson, "falldamage");
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xec1239e, Offset: 0x7b0
// Size: 0x3c
function clientvoicesetup() {
    localclientnum = self getlocalclientnumber();
    self thread audio_player_connect(localclientnum);
}

// Namespace zm_audio/zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0xaa85b75e, Offset: 0x7f8
// Size: 0x8c
function audio_player_connect(localclientnum) {
    var_3d2dc382 = array("playerbreathinsound", "playerbreathoutsound", "playerbreathgaspsound", "mantlesoundplayer", "meleeswipesoundplayer");
    self thread sndvonotifyplain(localclientnum, var_3d2dc382);
    self thread sndvonotifydtp(localclientnum, "dtplandsoundplayer");
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0x4cfa0019, Offset: 0x890
// Size: 0xa8
function sndvonotifyplain(localclientnum, var_3d2dc382) {
    self notify("68e9879d130dec7b");
    self endon("68e9879d130dec7b");
    self endon(#"death");
    while (true) {
        s_result = self waittill(var_3d2dc382);
        if (is_true(self.is_player_zombie)) {
            continue;
        }
        self playerexert(localclientnum, s_result._notify);
    }
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0x607687f2, Offset: 0x940
// Size: 0x1cc
function playerexert(localclientnum, exert) {
    if (isdefined(self.isspeaking) && self.isspeaking == 1) {
        return;
    }
    if (is_true(self.beast_mode)) {
        return;
    }
    if (exert === "meleeswipesoundplayer") {
        if (function_42e50d5()) {
            return;
        }
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
// Params 0, eflags: 0x1 linked
// Checksum 0x18ae21e0, Offset: 0xb18
// Size: 0x64
function function_42e50d5() {
    if (isdefined(self.weapon)) {
        switch (self.weapon.name) {
        case #"hero_scepter_lv3":
        case #"hero_scepter_lv2":
        case #"hero_scepter_lv1":
            return true;
        }
    }
    return false;
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0x9eded34d, Offset: 0xb88
// Size: 0x70
function sndvonotifydtp(localclientnum, notifystring) {
    self notify("50ec137dd0562c2");
    self endon("50ec137dd0562c2");
    self endon(#"death");
    while (true) {
        self waittill(notifystring);
        self playerexert(localclientnum, notifystring);
    }
}

// Namespace zm_audio/zm_audio
// Params 2, eflags: 0x0
// Checksum 0x9840b5e8, Offset: 0xc00
// Size: 0x1d0
function sndmeleeswipe(localclientnum, notifystring) {
    self endon(#"death");
    for (;;) {
        self waittill(notifystring);
        currentweapon = getcurrentweapon(localclientnum);
        if (is_true(level.sndnomeleeonclient)) {
            return;
        }
        if (is_true(self.is_player_zombie)) {
            playsound(0, #"zmb_melee_whoosh_zmb_plr", self.origin);
            continue;
        }
        if (currentweapon.statname === #"bowie_knife") {
            playsound(0, #"zmb_bowie_swing_plr", self.origin);
            continue;
        }
        if (currentweapon.name == "spoon_zm_alcatraz") {
            playsound(0, #"zmb_spoon_swing_plr", self.origin);
            continue;
        }
        if (currentweapon.name == "spork_zm_alcatraz") {
            playsound(0, #"zmb_spork_swing_plr", self.origin);
            continue;
        }
        playsound(0, #"zmb_melee_whoosh_plr", self.origin);
    }
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x8a424235, Offset: 0xdd8
// Size: 0x74
function end_gameover_snapshot() {
    level waittill(#"demo_jump", #"demo_player_switch", #"snd_clear_script_duck");
    wait 1;
    audio::snd_set_snapshot("default");
    level thread gameover_snapshot();
}

// Namespace zm_audio/zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x8b63db30, Offset: 0xe58
// Size: 0x4c
function gameover_snapshot() {
    level waittill(#"zesn");
    audio::snd_set_snapshot("zmb_game_over");
    level thread end_gameover_snapshot();
}

// Namespace zm_audio/zm_audio
// Params 7, eflags: 0x0
// Checksum 0xde11aaa6, Offset: 0xeb0
// Size: 0x10e
function sndzmblaststand(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        playsound(fieldname, #"hash_5e980fdf2497d9a1", (0, 0, 0));
        self.var_63de16a = self playloopsound(#"hash_7b41cf42e1b9847b");
        self.inlaststand = 1;
        return;
    }
    if (is_true(self.inlaststand)) {
        playsound(fieldname, #"hash_1526662237d7780f", (0, 0, 0));
        self stoploopsound(self.var_63de16a);
        self.inlaststand = 0;
    }
}
