#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace weapon_cache;

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x6
// Checksum 0x4e587a15, Offset: 0x190
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"weapon_cache", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x5 linked
// Checksum 0xeb6ecd6f, Offset: 0x1d8
// Size: 0x164
function private function_70a657d8() {
    if (!is_true(getgametypesetting(#"hash_6143c4e1e18f08fd"))) {
        return;
    }
    clientfield::register("scriptmover", "register_weapon_cache", 1, 1, "int", &register_weapon_cache, 0, 0);
    clientfield::register("toplayer", "weapon_cache_ammo_cooldown", 1, 1, "int", &function_ce75a340, 0, 1);
    clientfield::register("toplayer", "weapon_cache_cac_cooldown", 1, 1, "int", &weapon_cache_cac_cooldown, 0, 1);
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    callback::on_localclient_connect(&_on_localclient_connect);
    level.var_745f6ccb = [];
    level.var_2e44d000 = [];
}

// Namespace weapon_cache/weapon_cache
// Params 1, eflags: 0x5 linked
// Checksum 0xbe34e78f, Offset: 0x348
// Size: 0x7c
function private _on_localclient_connect(localclientnum) {
    level.var_745f6ccb[localclientnum] = 0;
    level.var_2e44d000[localclientnum] = 0;
    setuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"hash_6f4b11a0bee9b73d"), "weaponCachePromptState"), 3);
}

// Namespace weapon_cache/weapon_cache
// Params 1, eflags: 0x5 linked
// Checksum 0x9cd2ddb, Offset: 0x3d0
// Size: 0x54
function private on_localplayer_spawned(localclientnum) {
    if (self function_da43934d()) {
        self thread function_e18d0975(localclientnum);
        self thread function_d43c0a0(localclientnum);
    }
}

// Namespace weapon_cache/weapon_cache
// Params 7, eflags: 0x5 linked
// Checksum 0x6c9f8636, Offset: 0x430
// Size: 0x8c
function private register_weapon_cache(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(level.var_b5f67dff)) {
        level.var_b5f67dff = [];
    }
    arrayremovevalue(level.var_b5f67dff, undefined, 0);
    level.var_b5f67dff[level.var_b5f67dff.size] = self;
}

// Namespace weapon_cache/weapon_cache
// Params 7, eflags: 0x5 linked
// Checksum 0x43d0d851, Offset: 0x4c8
// Size: 0x298
function private function_ce75a340(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(self)) {
        return;
    }
    self util::waittill_dobj(fieldname);
    if (!isdefined(self) || !self isplayer() || !self function_da43934d() || !isdefined(level.var_b5f67dff) || !isalive(self)) {
        return;
    }
    foreach (weapon_cache in level.var_b5f67dff) {
        level.var_2e44d000[fieldname] = bwastimejump;
        function_f3b7c879(fieldname);
        if (bwastimejump == 1) {
            if (!isdefined(weapon_cache.var_1563bf09)) {
                weapon_cache.var_1563bf09 = util::getnextobjid(fieldname);
                objective_add(fieldname, weapon_cache.var_1563bf09, "active", #"hash_60b265ded94ea645", weapon_cache.origin, self.team, self);
            } else {
                objective_setstate(fieldname, weapon_cache.var_1563bf09, "active");
            }
            weapon_cache thread function_366dfc57(fieldname, weapon_cache.var_1563bf09, 60);
            continue;
        }
        if (isdefined(weapon_cache.var_1563bf09)) {
            weapon_cache notify(#"hash_21d2c3e2020a95a3");
            objective_setprogress(fieldname, weapon_cache.var_1563bf09, 1);
            objective_setstate(fieldname, weapon_cache.var_1563bf09, "invisible");
        }
    }
}

// Namespace weapon_cache/weapon_cache
// Params 3, eflags: 0x1 linked
// Checksum 0xa3008076, Offset: 0x768
// Size: 0xfc
function function_366dfc57(localclientnum, obj_id, cooldowntime) {
    self endon(#"hash_21d2c3e2020a95a3");
    level endon(#"disconnect", #"game_ended");
    endtime = cooldowntime - 4;
    for (progress = 0; progress < endtime; progress += 0.15) {
        percent = min(1, progress / endtime);
        objective_setprogress(localclientnum, obj_id, percent);
        wait 0.15;
    }
    if (!isdefined(self)) {
        objective_delete(localclientnum, obj_id);
    }
}

// Namespace weapon_cache/weapon_cache
// Params 7, eflags: 0x5 linked
// Checksum 0x22f38ca1, Offset: 0x870
// Size: 0x298
function private weapon_cache_cac_cooldown(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(self)) {
        return;
    }
    self util::waittill_dobj(fieldname);
    if (!isdefined(self) || !self isplayer() || !self function_da43934d() || !isdefined(level.var_b5f67dff) || !isalive(self)) {
        return;
    }
    foreach (weapon_cache in level.var_b5f67dff) {
        level.var_745f6ccb[fieldname] = bwastimejump;
        function_f3b7c879(fieldname);
        if (bwastimejump == 1) {
            if (!isdefined(weapon_cache.var_decd4745)) {
                weapon_cache.var_decd4745 = util::getnextobjid(fieldname);
                objective_add(fieldname, weapon_cache.var_decd4745, "active", #"hash_53b2e93d1661a0a4", weapon_cache.origin, self.team, self);
            } else {
                objective_setstate(fieldname, weapon_cache.var_decd4745, "active");
            }
            weapon_cache thread function_366dfc57(fieldname, weapon_cache.var_decd4745, 120);
            continue;
        }
        if (isdefined(weapon_cache.var_decd4745)) {
            weapon_cache notify(#"hash_21d2c3e2020a95a3");
            objective_setprogress(fieldname, weapon_cache.var_decd4745, 1);
            objective_setstate(fieldname, weapon_cache.var_decd4745, "invisible");
        }
    }
}

// Namespace weapon_cache/weapon_cache
// Params 1, eflags: 0x1 linked
// Checksum 0xd0224ea1, Offset: 0xb10
// Size: 0x118
function function_e18d0975(localclientnum) {
    self endon(#"shutdown", #"death");
    self notify("7096b817d60a87d5");
    self endon("7096b817d60a87d5");
    var_bd0cdac3 = "weapon_cache_cac_request";
    var_b784f644 = var_bd0cdac3 + localclientnum;
    while (true) {
        util::waittill_any_ents(self, var_bd0cdac3, level, var_b784f644);
        if (self.weapon.statname === #"ultimate_turret") {
            continue;
        }
        weapon_cache = function_2cf636b5(localclientnum);
        if (!isdefined(weapon_cache)) {
            continue;
        }
        if (level.var_745f6ccb[localclientnum] == 0) {
            function_cfade99b(localclientnum);
        }
    }
}

// Namespace weapon_cache/weapon_cache
// Params 1, eflags: 0x1 linked
// Checksum 0xf6e9616a, Offset: 0xc30
// Size: 0xf0
function function_d43c0a0(localclientnum) {
    self endon(#"shutdown", #"death");
    self notify("12ab75b4eda6c1b5");
    self endon("12ab75b4eda6c1b5");
    var_bd0cdac3 = "weapon_cache_resupply_request";
    var_b784f644 = var_bd0cdac3 + localclientnum;
    while (true) {
        util::waittill_any_ents(self, var_bd0cdac3, level, var_b784f644);
        weapon_cache = function_2cf636b5(localclientnum);
        if (!isdefined(weapon_cache)) {
            continue;
        }
        if (level.var_2e44d000[localclientnum] == 0) {
            function_f08e1146(localclientnum);
        }
    }
}

// Namespace weapon_cache/weapon_cache
// Params 1, eflags: 0x5 linked
// Checksum 0xeca32e12, Offset: 0xd28
// Size: 0x134
function private function_2cf636b5(localclientnum) {
    if (!isdefined(level.var_b5f67dff)) {
        return undefined;
    }
    playerorigin = getlocalclienteyepos(localclientnum);
    foreach (weapon_cache in level.var_b5f67dff) {
        if (!isdefined(weapon_cache)) {
            continue;
        }
        if (distance2dsquared(playerorigin, weapon_cache.origin) > function_a3f6cdac(96) || abs(playerorigin[2] - weapon_cache.origin[2]) > 96) {
            continue;
        }
        return weapon_cache;
    }
}

// Namespace weapon_cache/weapon_cache
// Params 1, eflags: 0x5 linked
// Checksum 0xf921b6ef, Offset: 0xe68
// Size: 0x11c
function private function_f3b7c879(localclientnum) {
    huditemsmodel = function_1df4c3b0(localclientnum, #"hash_6f4b11a0bee9b73d");
    var_56436909 = getuimodel(huditemsmodel, "weaponCachePromptState");
    if (level.var_2e44d000[localclientnum] && level.var_745f6ccb[localclientnum]) {
        setuimodelvalue(var_56436909, 0);
        return;
    }
    if (level.var_2e44d000[localclientnum]) {
        setuimodelvalue(var_56436909, 2);
        return;
    }
    if (level.var_745f6ccb[localclientnum]) {
        setuimodelvalue(var_56436909, 1);
        return;
    }
    setuimodelvalue(var_56436909, 3);
}

