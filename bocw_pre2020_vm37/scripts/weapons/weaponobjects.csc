#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\util_shared;

#namespace weaponobjects;

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x1 linked
// Checksum 0xdddd04ed, Offset: 0x150
// Size: 0x44c
function init_shared(friendly_rob, var_4885f19e) {
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    clientfield::register("toplayer", "proximity_alarm", 1, 3, "int", &proximity_alarm_changed, 0, 1);
    clientfield::register("missile", "retrievable", 1, 1, "int", &retrievable_changed, 0, 1);
    clientfield::register("scriptmover", "retrievable", 1, 1, "int", &retrievable_changed, 0, 0);
    clientfield::register("missile", "enemyequip", 1, 2, "int", &enemyequip_changed, 0, 1);
    clientfield::register("scriptmover", "enemyequip", 1, 2, "int", &enemyequip_changed, 0, 0);
    clientfield::register("missile", "teamequip", 1, 1, "int", &teamequip_changed, 0, 1);
    clientfield::register_clientuimodel("hudItems.proximityAlarm", #"hash_6f4b11a0bee9b73d", #"proximityalarm", 1, 3, "int", undefined, 0, 0);
    clientfield::register("missile", "friendlyequip", 1, 1, "int", &friendly_outline, 0, 1);
    clientfield::register("scriptmover", "friendlyequip", 1, 1, "int", &friendly_outline, 0, 0);
    level._effect[#"powerlight"] = #"weapon/fx8_equip_light_os";
    if (getgametypesetting(#"hash_48670d9509071424") && false) {
        level.var_58253868 = friendly_rob;
    }
    if (isdefined(var_4885f19e)) {
        function_6aae3df3(var_4885f19e);
    }
    level.var_420d7d7e = var_4885f19e;
    level.var_4de4699b = #"rob_sonar_set_enemy";
    if (!isdefined(level.retrievable)) {
        level.retrievable = [];
    }
    if (!isdefined(level.enemyequip)) {
        level.enemyequip = [];
    }
    if (isdefined(level.var_58253868)) {
        renderoverridebundle::function_f72f089c(#"hash_66ac79c57723c169", level.var_58253868, &function_6a5648dc, undefined, undefined, 1);
    }
    if (isdefined(level.var_420d7d7e)) {
        renderoverridebundle::function_f72f089c(#"hash_691f7dc47ae8aa08", level.var_420d7d7e, &function_232f3acf, undefined, level.var_4de4699b, 1);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x1 linked
// Checksum 0x17268ed2, Offset: 0x5a8
// Size: 0x3c
function on_localplayer_spawned(local_client_num) {
    if (!self function_21c0fa55()) {
        return;
    }
    self thread watch_perks_changed(local_client_num);
}

// Namespace weaponobjects/weaponobjects
// Params 7, eflags: 0x1 linked
// Checksum 0x1682052a, Offset: 0x5f0
// Size: 0x5c
function proximity_alarm_changed(local_client_num, oldval, newval, bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    update_sound(bnewent, bwastimejump, fieldname, binitialsnap);
}

// Namespace weaponobjects/weaponobjects
// Params 4, eflags: 0x1 linked
// Checksum 0xd88ec873, Offset: 0x658
// Size: 0xf4
function update_sound(local_client_num, *bnewent, newval, oldval) {
    if (newval == 2) {
        if (!isdefined(self._proximity_alarm_snd_ent)) {
            self._proximity_alarm_snd_ent = spawn(bnewent, self.origin, "script_origin");
            self thread sndproxalert_entcleanup(bnewent, self._proximity_alarm_snd_ent);
        }
        return;
    }
    if (newval == 1) {
        return;
    }
    if (newval == 0 && isdefined(oldval) && oldval != newval) {
        if (isdefined(self._proximity_alarm_snd_ent)) {
            self._proximity_alarm_snd_ent stopallloopsounds(0.5);
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 7, eflags: 0x1 linked
// Checksum 0xd4f3c46d, Offset: 0x758
// Size: 0x54
function teamequip_changed(local_client_num, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self updateteamequipment(fieldname, bwastimejump);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x1 linked
// Checksum 0xda4bbc04, Offset: 0x7b8
// Size: 0x2c
function updateteamequipment(local_client_num, *newval) {
    self checkteamequipment(newval);
}

// Namespace weaponobjects/weaponobjects
// Params 7, eflags: 0x1 linked
// Checksum 0xeae29545, Offset: 0x7f0
// Size: 0x74
function retrievable_changed(local_client_num, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self util::add_remove_list(level.retrievable, bwastimejump);
    self updateretrievable(fieldname, bwastimejump);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x1 linked
// Checksum 0xa7478b05, Offset: 0x870
// Size: 0x32
function updateretrievable(*local_client_num, *newval) {
    if (self function_b9b8fbc7()) {
    }
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x1 linked
// Checksum 0x1030ca91, Offset: 0x8b0
// Size: 0x72
function function_f89c4b81() {
    if (isdefined(self.weapon) && self.weapon.statname == #"ac130") {
        return false;
    }
    if (isdefined(self.weapon) && self.weapon.statname == #"tr_flechette_t8") {
        return false;
    }
    return true;
}

// Namespace weaponobjects/weaponobjects
// Params 7, eflags: 0x1 linked
// Checksum 0xcc48484f, Offset: 0x930
// Size: 0x94
function enemyequip_changed(local_client_num, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    bwastimejump = bwastimejump != 0;
    if (self function_f89c4b81()) {
        self util::add_remove_list(level.enemyequip, bwastimejump);
        self updateenemyequipment(fieldname, bwastimejump);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x1 linked
// Checksum 0x1fd7f5a7, Offset: 0x9d0
// Size: 0xb8
function function_6a5648dc(local_client_num, *bundle) {
    if (!self function_ca024039() || self.team === #"none") {
        return false;
    }
    if (is_true(level.vision_pulse[bundle])) {
        return false;
    }
    player = function_5c10bd79(bundle);
    if (self == player) {
        return false;
    }
    if (player.var_33b61b6f === 1) {
        return false;
    }
    return true;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x1 linked
// Checksum 0xa7375d47, Offset: 0xa90
// Size: 0x15c
function function_232f3acf(local_client_num, bundle) {
    if (self function_ca024039() && self.team !== #"none") {
        return false;
    }
    if (self.var_6abc296 === 1) {
        return true;
    }
    type = self.type;
    if ((type == "missile" || type == "scriptmover") && self clientfield::get("enemyequip") === 0) {
        return false;
    }
    if (sessionmodeiswarzonegame()) {
        if (function_5778f82(local_client_num, #"specialty_showenemyequipment") && is_true(self.var_f19b4afd)) {
            return true;
        }
    } else {
        if (function_5778f82(local_client_num, #"specialty_showenemyequipment")) {
            return true;
        }
        bundle.var_1a5b7293 = 1;
    }
    return false;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x1 linked
// Checksum 0xfa5645c6, Offset: 0xbf8
// Size: 0xa4
function updateenemyequipment(local_client_num, *newval) {
    if (isdefined(level.var_58253868)) {
        self renderoverridebundle::function_c8d97b8e(newval, #"friendly", #"hash_66ac79c57723c169");
    }
    if (isdefined(level.var_420d7d7e)) {
        self renderoverridebundle::function_c8d97b8e(newval, #"enemy", #"hash_691f7dc47ae8aa08");
    }
}

// Namespace weaponobjects/weaponobjects
// Params 7, eflags: 0x1 linked
// Checksum 0x53c09b52, Offset: 0xca8
// Size: 0x3c
function friendly_outline(*local_client_num, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x1 linked
// Checksum 0x6d2570d7, Offset: 0xcf0
// Size: 0x10e
function watch_perks_changed(local_client_num) {
    self notify(#"watch_perks_changed");
    self endon(#"watch_perks_changed");
    self endon(#"death");
    self endon(#"disconnect");
    while (isdefined(self)) {
        waitframe(1);
        util::clean_deleted(level.retrievable);
        util::clean_deleted(level.enemyequip);
        array::thread_all(level.retrievable, &updateretrievable, local_client_num, 1);
        array::thread_all(level.enemyequip, &updateenemyequipment, local_client_num, 1);
        self waittill(#"perks_changed");
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x1 linked
// Checksum 0x172a43b5, Offset: 0xe08
// Size: 0x11e
function checkteamequipment(localclientnum) {
    if (!isdefined(self.owner)) {
        return;
    }
    if (!isdefined(self.equipmentoldteam)) {
        self.equipmentoldteam = self.team;
    }
    if (!isdefined(self.equipmentoldownerteam)) {
        self.equipmentoldownerteam = self.owner.team;
    }
    var_fd9de919 = function_73f4b33(localclientnum);
    if (!isdefined(self.equipmentoldwatcherteam)) {
        self.equipmentoldwatcherteam = var_fd9de919;
    }
    if (self.equipmentoldteam != self.team || self.equipmentoldownerteam != self.owner.team || self.equipmentoldwatcherteam != var_fd9de919) {
        self.equipmentoldteam = self.team;
        self.equipmentoldownerteam = self.owner.team;
        self.equipmentoldwatcherteam = var_fd9de919;
        self notify(#"team_changed");
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x1 linked
// Checksum 0x6f8a9d6b, Offset: 0xf30
// Size: 0xac
function equipmentteamobject(localclientnum) {
    if (is_true(level.disable_equipment_team_object)) {
        return;
    }
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    waitframe(1);
    fx_handle = self playflarefx(localclientnum);
    self thread equipmentwatchteamfx(localclientnum, fx_handle);
    self thread equipmentwatchplayerteamchanged(localclientnum, fx_handle);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x1 linked
// Checksum 0x8ef1ca53, Offset: 0xfe8
// Size: 0x122
function playflarefx(localclientnum) {
    self endon(#"death");
    level endon(#"player_switch");
    if (!isdefined(self.var_7701a848)) {
        self.var_7701a848 = "tag_origin";
    }
    if (!isdefined(self.equipmentfriendfx)) {
        self.equipmentfriendfx = level._effect[#"powerlightgreen"];
    }
    if (!isdefined(self.equipmentenemyfx)) {
        self.equipmentenemyfx = level._effect[#"powerlight"];
    }
    if (self function_ca024039()) {
        fx_handle = util::playfxontag(localclientnum, self.equipmentfriendfx, self, self.var_7701a848);
    } else {
        fx_handle = util::playfxontag(localclientnum, self.equipmentenemyfx, self, self.var_7701a848);
    }
    return fx_handle;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x1 linked
// Checksum 0xba30faca, Offset: 0x1118
// Size: 0xb4
function equipmentwatchteamfx(localclientnum, fxhandle) {
    msg = self waittill(#"death", #"team_changed", #"player_switch");
    if (isdefined(fxhandle)) {
        stopfx(localclientnum, fxhandle);
    }
    waittillframeend();
    if (msg._notify != "death" && isdefined(self)) {
        self thread equipmentteamobject(localclientnum);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x1 linked
// Checksum 0xfb82db43, Offset: 0x11d8
// Size: 0xea
function equipmentwatchplayerteamchanged(localclientnum, *fxhandle) {
    self endon(#"death");
    self notify(#"team_changed_watcher");
    self endon(#"team_changed_watcher");
    watcherplayer = function_5c10bd79(fxhandle);
    while (true) {
        waitresult = level waittill(#"team_changed");
        player = function_5c10bd79(waitresult.localclientnum);
        if (watcherplayer == player) {
            self notify(#"team_changed");
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x1 linked
// Checksum 0x14ef48d0, Offset: 0x12d0
// Size: 0xac
function sndproxalert_entcleanup(*localclientnum, ent) {
    level waittill(#"snddede", #"demo_jump", #"player_switch", #"killcam_begin", #"killcam_end");
    if (isdefined(ent)) {
        ent stopallloopsounds(0.5);
        ent delete();
    }
}

