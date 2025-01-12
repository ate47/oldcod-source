#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\duplicaterender_mgr;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\util_shared;

#namespace weaponobjects;

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x4d7fbdc4, Offset: 0x140
// Size: 0x3e4
function init_shared(friendly_rob, var_dd6484b3) {
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    clientfield::register("toplayer", "proximity_alarm", 1, 3, "int", &proximity_alarm_changed, 0, 1);
    clientfield::register("missile", "retrievable", 1, 1, "int", &retrievable_changed, 0, 1);
    clientfield::register("scriptmover", "retrievable", 1, 1, "int", &retrievable_changed, 0, 0);
    clientfield::register("missile", "enemyequip", 1, 2, "int", &enemyequip_changed, 0, 1);
    clientfield::register("scriptmover", "enemyequip", 1, 2, "int", &enemyequip_changed, 0, 0);
    clientfield::register("missile", "teamequip", 1, 1, "int", &teamequip_changed, 0, 1);
    clientfield::register("clientuimodel", "hudItems.proximityAlarm", 1, 3, "int", undefined, 0, 0);
    clientfield::register("missile", "friendlyequip", 1, 1, "int", &friendly_outline, 0, 1);
    clientfield::register("scriptmover", "friendlyequip", 1, 1, "int", &friendly_outline, 0, 0);
    level._effect[#"powerlight"] = #"weapon/fx8_equip_light_os";
    if (getgametypesetting(#"hash_48670d9509071424")) {
        level.var_f68f1bc3 = friendly_rob;
    }
    level.var_81e75046 = var_dd6484b3;
    if (!isdefined(level.retrievable)) {
        level.retrievable = [];
    }
    if (!isdefined(level.enemyequip)) {
        level.enemyequip = [];
    }
    if (isdefined(level.var_f68f1bc3)) {
        renderoverridebundle::function_9f4eff5e(#"hash_66ac79c57723c169", level.var_f68f1bc3, &function_31712ef2);
    }
    if (isdefined(level.var_81e75046)) {
        renderoverridebundle::function_9f4eff5e(#"hash_691f7dc47ae8aa08", level.var_81e75046, &function_b76547cd);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x19b3db4f, Offset: 0x530
// Size: 0x3c
function on_localplayer_spawned(local_client_num) {
    if (!self function_60dbc438()) {
        return;
    }
    self thread watch_perks_changed(local_client_num);
}

// Namespace weaponobjects/weaponobjects
// Params 7, eflags: 0x0
// Checksum 0xf170b626, Offset: 0x578
// Size: 0x5c
function proximity_alarm_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    update_sound(local_client_num, bnewent, newval, oldval);
}

// Namespace weaponobjects/weaponobjects
// Params 4, eflags: 0x0
// Checksum 0xa54681f2, Offset: 0x5e0
// Size: 0xf4
function update_sound(local_client_num, bnewent, newval, oldval) {
    if (newval == 2) {
        if (!isdefined(self._proximity_alarm_snd_ent)) {
            self._proximity_alarm_snd_ent = spawn(local_client_num, self.origin, "script_origin");
            self thread sndproxalert_entcleanup(local_client_num, self._proximity_alarm_snd_ent);
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
// Params 7, eflags: 0x0
// Checksum 0x803f8185, Offset: 0x6e0
// Size: 0x54
function teamequip_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self updateteamequipment(local_client_num, newval);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x818250e6, Offset: 0x740
// Size: 0x2c
function updateteamequipment(local_client_num, newval) {
    self checkteamequipment(local_client_num);
}

// Namespace weaponobjects/weaponobjects
// Params 7, eflags: 0x0
// Checksum 0xddfee166, Offset: 0x778
// Size: 0x74
function retrievable_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self util::add_remove_list(level.retrievable, newval);
    self updateretrievable(local_client_num, newval);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xd35e7ec4, Offset: 0x7f8
// Size: 0x74
function updateretrievable(local_client_num, newval) {
    if (self function_e81e3832()) {
        self duplicate_render::set_item_retrievable(local_client_num, newval);
        return;
    }
    if (isdefined(self.currentdrfilter)) {
        self duplicate_render::set_item_retrievable(local_client_num, 0);
    }
}

// Namespace weaponobjects/weaponobjects
// Params 7, eflags: 0x0
// Checksum 0x5d6305b6, Offset: 0x878
// Size: 0x84
function enemyequip_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    newval = newval != 0;
    self util::add_remove_list(level.enemyequip, newval);
    self updateenemyequipment(local_client_num, newval);
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xc1a30ae, Offset: 0x908
// Size: 0x62
function function_31712ef2(local_client_num, bundle) {
    if (!self function_31d3dfec()) {
        return false;
    }
    if (isdefined(level.vision_pulse[local_client_num]) && level.vision_pulse[local_client_num]) {
        return false;
    }
    return true;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x6a83f053, Offset: 0x978
// Size: 0xce
function function_b76547cd(local_client_num, bundle) {
    if (self function_31d3dfec()) {
        return false;
    }
    if (self.var_dbad997e === 1) {
        return true;
    }
    if (sessionmodeiswarzonegame()) {
        if (function_24e25118(local_client_num, #"specialty_showenemyequipment") && isdefined(self.var_ee4739a0) && self.var_ee4739a0) {
            return true;
        }
    } else if (function_24e25118(local_client_num, #"specialty_showenemyequipment")) {
        return true;
    }
    return false;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x78025e37, Offset: 0xa50
// Size: 0xa4
function updateenemyequipment(local_client_num, newval) {
    if (isdefined(level.var_f68f1bc3)) {
        self renderoverridebundle::function_15e70783(local_client_num, #"friendly", #"hash_66ac79c57723c169");
    }
    if (isdefined(level.var_81e75046)) {
        self renderoverridebundle::function_15e70783(local_client_num, #"enemy", #"hash_691f7dc47ae8aa08");
    }
}

// Namespace weaponobjects/weaponobjects
// Params 7, eflags: 0x0
// Checksum 0x36b333a, Offset: 0xb00
// Size: 0x3c
function friendly_outline(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x279e4f1a, Offset: 0xb48
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
// Params 1, eflags: 0x0
// Checksum 0x42e8761, Offset: 0xc60
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
    var_71fb4650 = function_e4542aa3(localclientnum);
    if (!isdefined(self.equipmentoldwatcherteam)) {
        self.equipmentoldwatcherteam = var_71fb4650;
    }
    if (self.equipmentoldteam != self.team || self.equipmentoldownerteam != self.owner.team || self.equipmentoldwatcherteam != var_71fb4650) {
        self.equipmentoldteam = self.team;
        self.equipmentoldownerteam = self.owner.team;
        self.equipmentoldwatcherteam = var_71fb4650;
        self notify(#"team_changed");
    }
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x25ee7781, Offset: 0xd88
// Size: 0xb4
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
}

// Namespace weaponobjects/weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xf9a05d47, Offset: 0xe48
// Size: 0x122
function playflarefx(localclientnum) {
    self endon(#"death");
    level endon(#"player_switch");
    if (!isdefined(self.equipmenttagfx)) {
        self.equipmenttagfx = "tag_origin";
    }
    if (!isdefined(self.equipmentfriendfx)) {
        self.equipmenttagfx = level._effect[#"powerlightgreen"];
    }
    if (!isdefined(self.equipmentenemyfx)) {
        self.equipmenttagfx = level._effect[#"powerlight"];
    }
    if (self function_55a8b32b()) {
        fx_handle = util::playfxontag(localclientnum, self.equipmentfriendfx, self, self.equipmenttagfx);
    } else {
        fx_handle = util::playfxontag(localclientnum, self.equipmentenemyfx, self, self.equipmenttagfx);
    }
    return fx_handle;
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xbde2ab66, Offset: 0xf78
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
// Params 2, eflags: 0x0
// Checksum 0x52fc9fa9, Offset: 0x1038
// Size: 0xe2
function equipmentwatchplayerteamchanged(localclientnum, fxhandle) {
    self endon(#"death");
    self notify(#"team_changed_watcher");
    self endon(#"team_changed_watcher");
    watcherplayer = function_f97e7787(localclientnum);
    while (true) {
        waitresult = level waittill(#"team_changed");
        player = function_f97e7787(waitresult.localclientnum);
        if (watcherplayer == player) {
            self notify(#"team_changed");
        }
    }
}

// Namespace weaponobjects/weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x2056ac9, Offset: 0x1128
// Size: 0xac
function sndproxalert_entcleanup(localclientnum, ent) {
    level waittill(#"snddede", #"demo_jump", #"player_switch", #"killcam_begin", #"killcam_end");
    if (isdefined(ent)) {
        ent stopallloopsounds(0.5);
        ent delete();
    }
}

