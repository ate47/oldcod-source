#using script_5520b91a8aa516ab;
#using script_7bee869df82e0445;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreak_detect;

#namespace remotemissile;

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x0
// Checksum 0x5af811e5, Offset: 0x2c0
// Size: 0x2dc
function init_shared() {
    if (!(isdefined(level.var_2d85b616) && level.var_2d85b616) && !isdefined(level.var_684c26d5)) {
        level.var_684c26d5 = {};
        killstreak_detect::init_shared();
        remote_missile_targets::register("remote_missile_targets");
        remote_missile_target_lockon::register("remote_missile_target_lockon0");
        remote_missile_target_lockon::register("remote_missile_target_lockon1");
        remote_missile_target_lockon::register("remote_missile_target_lockon2");
        remote_missile_target_lockon::register("remote_missile_target_lockon3");
        remote_missile_target_lockon::register("remote_missile_target_lockon4");
        remote_missile_target_lockon::register("remote_missile_target_lockon5");
        clientfield::register("missile", "remote_missile_bomblet_fired", 1, 1, "int", &bomblets_deployed, 0, 0);
        clientfield::register("missile", "remote_missile_fired", 1, 2, "int", &missile_fired, 0, 0);
        clientfield::register("missile", "remote_missile_phase2", 1, 1, "int", undefined, 0, 0);
        clientfield::register("toplayer", "remote_missile_screenfx", 1, 1, "int", &function_6e5888b, 0, 1);
        clientfield::register("clientuimodel", "hudItems.remoteMissilePhase2", 1, 1, "int", undefined, 0, 0);
        clientfield::register("scriptmover", "hellstorm_camera", 1, 1, "int", &function_a1350b59, 0, 0);
        clientfield::register("scriptmover", "hellstorm_deploy", 1, 1, "int", &hellstorm_deploy, 0, 0);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x0
// Checksum 0x2265c752, Offset: 0x5a8
// Size: 0xc0
function hellstorm_deploy(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (newval) {
        self useanimtree("generic");
        self setanim(#"hash_4b6a7686ae8c1f16", 1);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x0
// Checksum 0x28b7872a, Offset: 0x670
// Size: 0x54
function function_a1350b59(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread function_35d55867(localclientnum);
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0x93a112f4, Offset: 0x6d0
// Size: 0xce
function function_35d55867(localclientnum) {
    self notify(#"hash_3f127346d8e9769f");
    self endon(#"hash_3f127346d8e9769f", #"death");
    player = function_f97e7787(localclientnum);
    self util::waittill_dobj(localclientnum);
    while (isdefined(player) && isdefined(self)) {
        player camerasetposition(self.origin);
        player camerasetlookat(self.angles);
        waitframe(1);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x0
// Checksum 0x875574b4, Offset: 0x7a8
// Size: 0x2bc
function missile_fired(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        player = function_f97e7787(localclientnum);
        owner = self getowner(localclientnum);
        clientobjid = util::getnextobjid(localclientnum);
        objective_onentity(localclientnum, clientobjid, self, 1, 0, 1);
        self.hellfireobjid = clientobjid;
        self thread destruction_watcher(localclientnum, clientobjid);
        objective_setstate(localclientnum, clientobjid, "active");
        if (player hasperk(localclientnum, #"specialty_showscorestreakicons")) {
            objective_seticon(localclientnum, clientobjid, "remotemissile_targetF");
            objective_seticonsize(localclientnum, clientobjid, 50);
        }
        self thread hud_update(localclientnum);
        if (player === owner) {
            player.clouds_fx = util::playfxontag(localclientnum, #"hash_50b25e352ba908d0", self, "tag_origin");
        }
    } else if (newval == 2) {
        if (isdefined(self.hellfireobjid)) {
            self notify(#"hellfire_detonated");
            objective_delete(localclientnum, self.hellfireobjid);
            util::releaseobjid(localclientnum, self.hellfireobjid);
        }
    } else {
        self notify(#"cleanup_objectives");
    }
    ammo_ui_data_model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.rocketAmmo");
    if (isdefined(ammo_ui_data_model)) {
        setuimodelvalue(ammo_ui_data_model, 2);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x0
// Checksum 0x2d19884f, Offset: 0xa70
// Size: 0x1dc
function bomblets_deployed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (bnewent && oldval == newval) {
        return;
    }
    if (newval == 1) {
        player = function_f97e7787(localclientnum);
        owner = self getowner(localclientnum);
        clientobjid = util::getnextobjid(localclientnum);
        objective_onentity(localclientnum, clientobjid, self, 1, 0, 1);
        self thread destruction_watcher(localclientnum, clientobjid);
        objective_setstate(localclientnum, clientobjid, "active");
        if (player hasperk(localclientnum, #"specialty_showscorestreakicons")) {
            objective_seticon(localclientnum, clientobjid, "remotemissile_target");
        }
    } else {
        self notify(#"cleanup_objectives");
    }
    ammo_ui_data_model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.rocketAmmo");
    if (isdefined(ammo_ui_data_model)) {
        setuimodelvalue(ammo_ui_data_model, 0);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 2, eflags: 0x0
// Checksum 0xf5f9bc61, Offset: 0xc58
// Size: 0x7c
function destruction_watcher(localclientnum, clientobjid) {
    self waittill(#"death", #"cleanup_objectives");
    wait 0.1;
    if (isdefined(clientobjid)) {
        objective_delete(localclientnum, clientobjid);
        util::releaseobjid(localclientnum, clientobjid);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0xbccf7dd1, Offset: 0xce0
// Size: 0x296
function hud_update(localclientnum) {
    self endon(#"death");
    self notify(#"remote_missile_singeton");
    self endon(#"remote_missile_singeton");
    missile = self;
    altitude_ui_data_model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.altitude");
    speed_ui_data_model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.speed");
    var_6a0940b = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.remainingTime");
    if (!isdefined(altitude_ui_data_model) || !isdefined(speed_ui_data_model) || !isdefined(var_6a0940b)) {
        return;
    }
    birthtime = gettime();
    lifetime = (isdefined(missile.weapon.lifetime) ? missile.weapon.lifetime : 20) * 1000;
    prev_z = missile.origin[2];
    fps = 20;
    delay = 1 / fps;
    while (true) {
        cur_z = missile.origin[2];
        setuimodelvalue(altitude_ui_data_model, cur_z);
        dist = (prev_z - cur_z) * fps;
        val = dist / 17.6;
        setuimodelvalue(speed_ui_data_model, val);
        prev_z = cur_z;
        remainingtime = 1 - (gettime() - birthtime) / lifetime;
        setuimodelvalue(var_6a0940b, remainingtime);
        wait delay;
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x0
// Checksum 0x6f9e42f5, Offset: 0xf80
// Size: 0x154
function function_6e5888b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = function_f97e7787(localclientnum);
    postfxbundle = #"hash_778f4a554a5cfc33";
    if (newval) {
        if (!self postfx::function_7348f3a5(postfxbundle) && (!function_1fe374eb(localclientnum) || function_e27699cf(localclientnum) === function_609b5d7a(localclientnum))) {
            player codeplaypostfxbundle(postfxbundle);
        }
        return;
    }
    if (isdefined(player.clouds_fx)) {
        killfx(localclientnum, player.clouds_fx);
    }
    if (self postfx::function_7348f3a5(postfxbundle)) {
        player codestoppostfxbundle(postfxbundle);
    }
}

