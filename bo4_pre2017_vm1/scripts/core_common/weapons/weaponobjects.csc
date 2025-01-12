#using scripts/core_common/array_shared;
#using scripts/core_common/audio_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/filter_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace weaponobjects;

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xc77faead, Offset: 0x398
// Size: 0x234
function init_shared() {
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    clientfield::register("toplayer", "proximity_alarm", 1, 2, "int", &proximity_alarm_changed, 0, 1);
    clientfield::register("missile", "retrievable", 1, 1, "int", &retrievable_changed, 0, 1);
    clientfield::register("scriptmover", "retrievable", 1, 1, "int", &retrievable_changed, 0, 0);
    clientfield::register("missile", "enemyequip", 1, 2, "int", &enemyequip_changed, 0, 1);
    clientfield::register("scriptmover", "enemyequip", 1, 2, "int", &enemyequip_changed, 0, 0);
    clientfield::register("missile", "teamequip", 1, 1, "int", &teamequip_changed, 0, 1);
    level._effect["powerLight"] = "weapon/fx_equip_light_os";
    if (!isdefined(level.retrievable)) {
        level.retrievable = [];
    }
    if (!isdefined(level.enemyequip)) {
        level.enemyequip = [];
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x97536a07, Offset: 0x5d8
// Size: 0x5c
function on_localplayer_spawned(local_client_num) {
    if (self != getlocalplayer(local_client_num)) {
        return;
    }
    self thread watch_perks_changed(local_client_num);
    self thread function_94c5a728(local_client_num);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x50f89025, Offset: 0x640
// Size: 0x148
function function_94c5a728(local_client_num) {
    self notify(#"hash_94c5a728");
    self endon(#"hash_94c5a728");
    self endon(#"death");
    self endon(#"disconnect");
    while (isdefined(self)) {
        waitresult = self waittill("notetrack");
        if (waitresult.notetrack == "activate_datapad") {
            uimodel = createuimodel(getuimodelforcontroller(local_client_num), "hudItems.killstreakActivated");
            setuimodelvalue(uimodel, 1);
        }
        if (waitresult.notetrack == "deactivate_datapad") {
            uimodel = createuimodel(getuimodelforcontroller(local_client_num), "hudItems.killstreakActivated");
            setuimodelvalue(uimodel, 0);
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 7, eflags: 0x0
// Checksum 0xf42802cb, Offset: 0x790
// Size: 0x5c
function proximity_alarm_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    update_sound(local_client_num, bnewent, newval, oldval);
}

// Namespace weaponobjects/weaponobjects
// Params 4, eflags: 0x0
// Checksum 0x54786c25, Offset: 0x7f8
// Size: 0x15c
function update_sound(local_client_num, bnewent, newval, oldval) {
    if (newval == 2) {
        if (!isdefined(self._proximity_alarm_snd_ent)) {
            self._proximity_alarm_snd_ent = spawn(local_client_num, self.origin, "script_origin");
            self thread sndproxalert_entcleanup(local_client_num, self._proximity_alarm_snd_ent);
        }
        playsound(local_client_num, "uin_c4_proximity_alarm_start", (0, 0, 0));
        self._proximity_alarm_snd_ent playloopsound("uin_c4_proximity_alarm_loop", 0.1);
        return;
    }
    if (newval == 1) {
        return;
    }
    if (newval == 0 && isdefined(oldval) && oldval != newval) {
        playsound(local_client_num, "uin_c4_proximity_alarm_stop", (0, 0, 0));
        if (isdefined(self._proximity_alarm_snd_ent)) {
            self._proximity_alarm_snd_ent stopallloopsounds(0.5);
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 7, eflags: 0x0
// Checksum 0x50a909c5, Offset: 0x960
// Size: 0x5c
function teamequip_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self updateteamequipment(local_client_num, newval);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xe895c6f4, Offset: 0x9c8
// Size: 0x2c
function updateteamequipment(local_client_num, newval) {
    self checkteamequipment(local_client_num);
}

// Namespace weaponobjects/weaponobjects
// Params 7, eflags: 0x0
// Checksum 0x746da792, Offset: 0xa00
// Size: 0x84
function retrievable_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self util::add_remove_list(level.retrievable, newval);
    self updateretrievable(local_client_num, newval);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x62c1561f, Offset: 0xa90
// Size: 0x94
function updateretrievable(local_client_num, newval) {
    if (isdefined(self.owner) && self.owner == getlocalplayer(local_client_num)) {
        self duplicate_render::set_item_retrievable(local_client_num, newval);
        return;
    }
    if (isdefined(self.currentdrfilter)) {
        self duplicate_render::set_item_retrievable(local_client_num, 0);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 7, eflags: 0x0
// Checksum 0x163b68e8, Offset: 0xb30
// Size: 0x8c
function enemyequip_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    newval = newval != 0;
    self util::add_remove_list(level.enemyequip, newval);
    self updateenemyequipment(local_client_num, newval);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x1bac7038, Offset: 0xbc8
// Size: 0x19c
function updateenemyequipment(local_client_num, newval) {
    watcher = getlocalplayer(local_client_num);
    friend = self util::friend_not_foe(local_client_num, 1);
    if (watcher hasperk(local_client_num, "specialty_showenemyequipment") || !friend && isdefined(watcher) && self.var_dbad997e === 1) {
        self duplicate_render::set_item_friendly_equipment(local_client_num, 0);
        self duplicate_render::set_item_enemy_equipment(local_client_num, newval);
        return;
    }
    if (watcher duplicate_render::show_friendly_outlines(local_client_num) || friend && isdefined(watcher) && self.var_519dd23d === 1) {
        self duplicate_render::set_item_enemy_equipment(local_client_num, 0);
        self duplicate_render::set_item_friendly_equipment(local_client_num, newval);
        return;
    }
    self duplicate_render::set_item_enemy_equipment(local_client_num, 0);
    self duplicate_render::set_item_friendly_equipment(local_client_num, 0);
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xa217b3e5, Offset: 0xd70
// Size: 0xc
function function_be7bb045(local_client_num) {
    
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x88f54593, Offset: 0xd88
// Size: 0xfe
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
        self waittill("perks_changed");
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x31661d4d, Offset: 0xe90
// Size: 0x162
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
    watcher = getlocalplayer(localclientnum);
    if (!isdefined(self.equipmentoldwatcherteam)) {
        self.equipmentoldwatcherteam = watcher.team;
    }
    if (self.equipmentoldteam != self.team || self.equipmentoldownerteam != self.owner.team || self.equipmentoldwatcherteam != watcher.team) {
        self.equipmentoldteam = self.team;
        self.equipmentoldownerteam = self.owner.team;
        self.equipmentoldwatcherteam = watcher.team;
        self notify(#"team_changed");
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xe011567d, Offset: 0x1000
// Size: 0xd4
function equipmentteamobject(localclientnum) {
    if (isdefined(level.disable_equipment_team_object) && level.disable_equipment_team_object) {
        return;
    }
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    waitframe(1);
    fx_handle = self thread playflarefx(localclientnum);
    self thread equipmentwatchteamfx(localclientnum, fx_handle);
    self thread equipmentwatchplayerteamchanged(localclientnum, fx_handle);
    self thread function_be7bb045();
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x18c8ca3c, Offset: 0x10e0
// Size: 0x134
function playflarefx(localclientnum) {
    self endon(#"death");
    level endon(#"player_switch");
    if (!isdefined(self.equipmenttagfx)) {
        self.equipmenttagfx = "tag_origin";
    }
    if (!isdefined(self.equipmentfriendfx)) {
        self.equipmenttagfx = level._effect["powerLightGreen"];
    }
    if (!isdefined(self.equipmentenemyfx)) {
        self.equipmenttagfx = level._effect["powerLight"];
    }
    if (self util::friend_not_foe(localclientnum, 1)) {
        fx_handle = playfxontag(localclientnum, self.equipmentfriendfx, self, self.equipmenttagfx);
    } else {
        fx_handle = playfxontag(localclientnum, self.equipmentenemyfx, self, self.equipmenttagfx);
    }
    return fx_handle;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x1514cae3, Offset: 0x1220
// Size: 0xa4
function equipmentwatchteamfx(localclientnum, fxhandle) {
    msg = self waittill("death", "team_changed", "player_switch");
    if (isdefined(fxhandle)) {
        stopfx(localclientnum, fxhandle);
    }
    waittillframeend();
    if (msg._notify != "death" && isdefined(self)) {
        self thread equipmentteamobject(localclientnum);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x62e5cd72, Offset: 0x12d0
// Size: 0xce
function equipmentwatchplayerteamchanged(localclientnum, fxhandle) {
    self endon(#"death");
    self notify(#"team_changed_watcher");
    self endon(#"team_changed_watcher");
    watcherplayer = getlocalplayer(localclientnum);
    while (true) {
        waitresult = level waittill("team_changed");
        player = getlocalplayer(waitresult.localclientnum);
        if (watcherplayer == player) {
            self notify(#"team_changed");
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x24ec1363, Offset: 0x13a8
// Size: 0x84
function sndproxalert_entcleanup(localclientnum, ent) {
    level waittill("sndDEDe", "demo_jump", "player_switch", "killcam_begin", "killcam_end");
    if (isdefined(ent)) {
        ent stopallloopsounds(0.5);
        ent delete();
    }
}

