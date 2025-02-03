#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace weapon_cache;

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x6
// Checksum 0x876090db, Offset: 0x160
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"weapon_cache", &preinit, undefined, undefined, undefined);
}

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x4
// Checksum 0x36a31c21, Offset: 0x1a8
// Size: 0x17c
function private preinit() {
    if (!is_true(getgametypesetting(#"hash_6143c4e1e18f08fd"))) {
        return;
    }
    clientfield::register("scriptmover", "register_weapon_cache", 1, 1, "int", &register_weapon_cache, 0, 0);
    clientfield::register("toplayer", "weapon_cache_ammo_cooldown", 1, 1, "int", &function_ce75a340, 0, 0);
    clientfield::register("toplayer", "weapon_cache_cac_cooldown", 1, 1, "int", &weapon_cache_cac_cooldown, 0, 0);
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    callback::on_localclient_connect(&_on_localclient_connect);
    level.var_745f6ccb = [];
    level.var_2e44d000 = [];
    level.var_a979e61b = &function_a979e61b;
}

// Namespace weapon_cache/weapon_cache
// Params 1, eflags: 0x4
// Checksum 0x49189279, Offset: 0x330
// Size: 0x7c
function private _on_localclient_connect(localclientnum) {
    level.var_745f6ccb[localclientnum] = 0;
    level.var_2e44d000[localclientnum] = 0;
    setuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"hud_items"), "weaponCachePromptState"), 3);
}

// Namespace weapon_cache/weapon_cache
// Params 1, eflags: 0x4
// Checksum 0xfe1fb2c6, Offset: 0x3b8
// Size: 0x3c
function private on_localplayer_spawned(localclientnum) {
    if (self function_da43934d()) {
        self thread function_d43c0a0(localclientnum);
    }
}

// Namespace weapon_cache/weapon_cache
// Params 7, eflags: 0x4
// Checksum 0x576a075e, Offset: 0x400
// Size: 0x8c
function private register_weapon_cache(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(level.var_b5f67dff)) {
        level.var_b5f67dff = [];
    }
    arrayremovevalue(level.var_b5f67dff, undefined, 0);
    level.var_b5f67dff[level.var_b5f67dff.size] = self;
}

// Namespace weapon_cache/weapon_cache
// Params 7, eflags: 0x4
// Checksum 0x307c39fc, Offset: 0x498
// Size: 0x278
function private function_ce75a340(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(self)) {
        return;
    }
    self util::waittill_dobj(fieldname);
    if (!isdefined(self) || !self isplayer() || !self function_da43934d() || !isdefined(level.var_b5f67dff)) {
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
            weapon_cache thread updateprogress(fieldname, weapon_cache.var_1563bf09, 60);
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
// Params 3, eflags: 0x0
// Checksum 0x396a4b03, Offset: 0x718
// Size: 0xfc
function updateprogress(localclientnum, obj_id, cooldowntime) {
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
// Params 7, eflags: 0x4
// Checksum 0x941383c0, Offset: 0x820
// Size: 0x278
function private weapon_cache_cac_cooldown(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(self)) {
        return;
    }
    self util::waittill_dobj(fieldname);
    if (!isdefined(self) || !self isplayer() || !self function_da43934d() || !isdefined(level.var_b5f67dff)) {
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
            weapon_cache thread updateprogress(fieldname, weapon_cache.var_decd4745, 120);
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
// Params 1, eflags: 0x4
// Checksum 0xa5178b14, Offset: 0xaa0
// Size: 0xac
function private function_a979e61b(localclientnum) {
    if (!isalive(self)) {
        return;
    }
    if (self.weapon.statname === #"ultimate_turret") {
        return 0;
    }
    weapon_cache = function_2cf636b5(localclientnum);
    if (!isdefined(weapon_cache)) {
        return 0;
    }
    if (level.var_745f6ccb[localclientnum] == 0) {
        function_cfade99b(localclientnum);
        return 1;
    }
    return 0;
}

// Namespace weapon_cache/weapon_cache
// Params 1, eflags: 0x0
// Checksum 0x6ba2f6ad, Offset: 0xb58
// Size: 0xf0
function function_d43c0a0(localclientnum) {
    self endon(#"shutdown", #"death");
    self notify("3cdb770c9d280ef0");
    self endon("3cdb770c9d280ef0");
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
// Params 1, eflags: 0x4
// Checksum 0xfdb4bd20, Offset: 0xc50
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
        if (distance2dsquared(playerorigin, weapon_cache.origin) > sqr(96) || abs(playerorigin[2] - weapon_cache.origin[2]) > 96) {
            continue;
        }
        return weapon_cache;
    }
}

// Namespace weapon_cache/weapon_cache
// Params 1, eflags: 0x4
// Checksum 0x43e0da10, Offset: 0xd90
// Size: 0x11c
function private function_f3b7c879(localclientnum) {
    huditemsmodel = function_1df4c3b0(localclientnum, #"hud_items");
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

