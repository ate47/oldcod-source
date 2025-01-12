#using script_13da4e6b98ca81a1;
#using script_5520b91a8aa516ab;
#using script_7bee869df82e0445;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreak_detect;

#namespace remotemissile;

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x4ca5eb24, Offset: 0x298
// Size: 0x39c
function init_shared() {
    if (!is_true(level.var_e3049e92) && !isdefined(level.var_2a02828c)) {
        level.var_2a02828c = {};
        killstreak_detect::init_shared();
        remote_missile_targets::register();
        for (ti = 0; ti < 6; ti++) {
            level.remote_missile_targets[ti] = spawnstruct();
            remote_missile_target_lockon::register("remote_missile_target_lockon" + ti, &function_1de73512, &function_fd0c759c);
        }
        clientfield::register("missile", "remote_missile_brakes", 1, 1, "int", &function_3e76ad59, 0, 0);
        clientfield::register("missile", "remote_missile_bomblet_fired", 1, 1, "int", &bomblets_deployed, 0, 0);
        clientfield::register("missile", "remote_missile_fired", 1, 2, "int", &missile_fired, 0, 0);
        clientfield::register("missile", "remote_missile_phase2", 1, 1, "int", undefined, 0, 0);
        clientfield::register("toplayer", "remote_missile_screenfx", 1, 1, "int", &function_c65b18ed, 0, 1);
        clientfield::register_clientuimodel("hudItems.remoteMissilePhase2", #"hash_6f4b11a0bee9b73d", #"remotemissilephase2", 1, 1, "int", undefined, 0, 0);
        clientfield::register("scriptmover", "hellstorm_camera", 1, 1, "int", &function_6d66e75a, 0, 0);
        clientfield::register("scriptmover", "hellstorm_deploy", 1, 1, "int", &hellstorm_deploy, 0, 0);
        callback::function_a880899e(&function_a880899e);
        bundlename = "killstreak_remote_missile";
        if (sessionmodeiswarzonegame()) {
            bundlename += "_wz";
        }
        level.var_bb1f7e1e = getscriptbundle(bundlename);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xb2194fbc, Offset: 0x640
// Size: 0x4c
function function_a880899e(eventparams) {
    localclientnum = eventparams.localclientnum;
    if (isdefined(self)) {
        function_d260edc9(localclientnum, eventparams.enabled);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xfe62d12a, Offset: 0x698
// Size: 0x64
function function_fd0c759c(localclientnum, *oldval, newval, *bnewent, *binitialsnap, fieldname, *bwastimejump) {
    if (isdefined(level.var_e656f88a)) {
        [[ level.var_e656f88a ]](binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x9b2f2193, Offset: 0x708
// Size: 0x64
function function_1de73512(localclientnum, *oldval, newval, *bnewent, *binitialsnap, fieldname, *bwastimejump) {
    if (isdefined(level.var_70a07f6f)) {
        [[ level.var_70a07f6f ]](binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xe24bd74f, Offset: 0x778
// Size: 0x118
function hellstorm_deploy(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self util::waittill_dobj(fieldname);
    if (bwastimejump) {
        player = function_5c10bd79(fieldname);
        if (isdefined(player) && isdefined(self) && self.owner === player) {
            self useanimtree("generic");
            self setanim(#"hash_21fa3a72d877f87a", 1);
        } else {
            self hide();
        }
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x48964808, Offset: 0x898
// Size: 0x54
function function_6d66e75a(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self thread function_90b75549(bwastimejump);
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x94fc71b, Offset: 0x8f8
// Size: 0xde
function function_90b75549(localclientnum) {
    self notify(#"hash_3f127346d8e9769f");
    self endon(#"hash_3f127346d8e9769f", #"death");
    player = function_5c10bd79(localclientnum);
    self util::waittill_dobj(localclientnum);
    while (isdefined(player) && isdefined(self) && self.owner === player) {
        player camerasetposition(self.origin);
        player camerasetlookat(self.angles);
        waitframe(1);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xeb01bd16, Offset: 0x9e0
// Size: 0x84
function function_3e76ad59(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self function_d309e55a("tag_brake_control_animate", 1);
        return;
    }
    self function_d309e55a("tag_brake_control_animate", 0);
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x5d8b18ca, Offset: 0xa70
// Size: 0x314
function missile_fired(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self function_d309e55a("tag_fin_control_animate", 1);
        self function_1f0c7136(2);
        localplayer = function_5c10bd79(fieldname);
        owner = self getowner(fieldname);
        if (localplayer hasperk(fieldname, #"specialty_showscorestreakicons") || self.team == localplayer.team) {
            self.var_7ec0e2d1 = spawn(fieldname, self.origin, "script_model", localplayer getentitynumber(), self.team);
            self.var_7ec0e2d1 setcompassicon(level.var_bb1f7e1e.var_cb98fbf7);
            var_b13727dd = getgametypesetting("compassAnchorScorestreakIcons");
            self.var_7ec0e2d1 function_dce2238(var_b13727dd);
            self.var_7ec0e2d1 setmodel(#"tag_origin");
            self.var_7ec0e2d1 linkto(self);
            self.var_7ec0e2d1 function_5e00861(level.var_bb1f7e1e.var_792e8590);
            self thread function_20fff7ed(level.var_bb1f7e1e.var_792e8590, level.var_bb1f7e1e.var_f99969f1, gettime(), level.var_bb1f7e1e.var_6b2f302f * 1000);
        }
        self thread hud_update(fieldname);
        self thread function_298565db();
        if (localplayer === owner) {
            localplayer.clouds_fx = util::playfxontag(fieldname, level.var_bb1f7e1e.var_1050ff32, self, "tag_origin");
        }
        return;
    }
    if (bwastimejump == 2) {
        self.var_7ec0e2d1 delete();
        return;
    }
    self function_fd73ab50();
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x5 linked
// Checksum 0xf547d93c, Offset: 0xd90
// Size: 0x3c
function private function_298565db() {
    self waittill(#"death", #"disconnect");
    self function_fd73ab50();
}

// Namespace remotemissile/remotemissile_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x1f3c2764, Offset: 0xdd8
// Size: 0xd4
function function_20fff7ed(startscale, endscale, starttime, duration) {
    self endon(#"death");
    while (gettime() < starttime + duration) {
        currtime = gettime();
        ratio = (currtime - starttime) / duration;
        scale = lerpfloat(startscale, endscale, ratio);
        self.var_7ec0e2d1 function_5e00861(scale);
        wait 0.1;
    }
    self.var_7ec0e2d1 function_5e00861(endscale);
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x256bacbe, Offset: 0xeb8
// Size: 0x254
function bomblets_deployed(localclientnum, oldval, newval, bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump && binitialsnap == fieldname) {
        return;
    }
    if (fieldname == 1) {
        localplayer = function_5c10bd79(bnewent);
        owner = self getowner(bnewent);
        if (localplayer hasperk(bnewent, #"specialty_showscorestreakicons") || self.team == localplayer.team) {
            self function_fd73ab50();
            self.var_7ec0e2d1 = spawn(bnewent, self.origin, "script_model", localplayer getentitynumber(), self.team);
            self.var_7ec0e2d1 setcompassicon(level.var_bb1f7e1e.var_cb98fbf7);
            var_b13727dd = getgametypesetting("compassAnchorScorestreakIcons");
            self.var_7ec0e2d1 function_dce2238(var_b13727dd);
            self.var_7ec0e2d1 function_5e00861(level.var_bb1f7e1e.var_c3e4af00);
            self.var_7ec0e2d1 linkto(self);
        }
    } else {
        self function_fd73ab50();
    }
    ammo_ui_data_model = getuimodel(function_1df4c3b0(bnewent, #"vehicle_info"), "rocketAmmo");
    if (isdefined(ammo_ui_data_model)) {
        setuimodelvalue(ammo_ui_data_model, 0);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xd87017c6, Offset: 0x1118
// Size: 0x2c
function function_fd73ab50() {
    if (isdefined(self.var_7ec0e2d1)) {
        self.var_7ec0e2d1 delete();
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xe6ae2758, Offset: 0x1150
// Size: 0x2ae
function hud_update(localclientnum) {
    self endon(#"death");
    self notify(#"remote_missile_singeton");
    self endon(#"remote_missile_singeton");
    missile = self;
    altitude_ui_data_model = getuimodel(function_1df4c3b0(localclientnum, #"vehicle_info"), "altitude");
    speed_ui_data_model = getuimodel(function_1df4c3b0(localclientnum, #"vehicle_info"), "speed");
    var_2c36f843 = getuimodel(function_1df4c3b0(localclientnum, #"vehicle_info"), "remainingTime");
    if (!isdefined(altitude_ui_data_model) || !isdefined(speed_ui_data_model) || !isdefined(var_2c36f843)) {
        return;
    }
    birthtime = gettime();
    lifetime = (isdefined(missile.weapon.lifetime) ? missile.weapon.lifetime : 20) * 1000;
    prev_z = missile.origin[2];
    fps = 20;
    delay = 1 / fps;
    while (isdefined(lifetime) && lifetime > 0) {
        cur_z = missile.origin[2];
        setuimodelvalue(altitude_ui_data_model, cur_z);
        dist = (prev_z - cur_z) * fps;
        val = dist / 17.6;
        setuimodelvalue(speed_ui_data_model, val);
        prev_z = cur_z;
        remainingtime = 1 - (gettime() - birthtime) / lifetime;
        setuimodelvalue(var_2c36f843, remainingtime);
        wait delay;
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xa9af7eff, Offset: 0x1408
// Size: 0x17c
function function_d260edc9(localclientnum, enabled) {
    player = function_5c10bd79(localclientnum);
    postfxbundle = #"hash_778f4a554a5cfc33";
    if (enabled && !function_148ccc79(localclientnum, postfxbundle) && (!function_1cbf351b(localclientnum) || function_93e0f729(localclientnum) === function_27673a7(localclientnum)) && !codcaster::function_45a5c04c(localclientnum)) {
        if (isdefined(self.weapon) && self.weapon.statname == #"remote_missile") {
            function_a837926b(localclientnum, postfxbundle);
        }
        return;
    }
    if (isdefined(player.clouds_fx)) {
        killfx(localclientnum, player.clouds_fx);
    }
    if (function_148ccc79(localclientnum, postfxbundle)) {
        codestoppostfxbundlelocal(localclientnum, postfxbundle);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xee481bdc, Offset: 0x1590
// Size: 0x184
function function_c65b18ed(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    player = function_5c10bd79(fieldname);
    postfxbundle = #"hash_778f4a554a5cfc33";
    if (!isdefined(self)) {
        return;
    }
    if (bwastimejump) {
        if (!function_148ccc79(fieldname, postfxbundle) && (!function_1cbf351b(fieldname) || function_93e0f729(fieldname) === function_27673a7(fieldname)) && !codcaster::function_45a5c04c(fieldname)) {
            function_a837926b(fieldname, postfxbundle);
        }
        return;
    }
    if (isdefined(player.clouds_fx)) {
        killfx(fieldname, player.clouds_fx);
    }
    if (function_148ccc79(fieldname, postfxbundle)) {
        codestoppostfxbundlelocal(fieldname, postfxbundle);
    }
}

