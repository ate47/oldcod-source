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
// Params 0, eflags: 0x0
// Checksum 0x3a881375, Offset: 0x2c0
// Size: 0x3e4
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
        clientfield::register("toplayer", "remote_missile_piloting", 1, 1, "int", &remote_missile_piloting, 0, 1);
        clientfield::register_clientuimodel("hudItems.remoteMissilePhase2", #"hud_items", #"remotemissilephase2", 1, 1, "int", undefined, 0, 0);
        clientfield::register("scriptmover", "hellstorm_camera", 1, 1, "int", &function_6d66e75a, 0, 0);
        clientfield::register("scriptmover", "hellstorm_deploy", 1, 1, "int", &hellstorm_deploy, 0, 0);
        clientfield::register("scriptmover", "remote_missile_child_rocket_fx", 1, 1, "int", &remote_missile_child_rocket_fx, 0, 0);
        callback::function_a880899e(&function_a880899e);
        bundlename = "killstreak_remote_missile";
        if (sessionmodeiswarzonegame()) {
            bundlename += "_wz";
        }
        level.var_bb1f7e1e = getscriptbundle(bundlename);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0x7463cc40, Offset: 0x6b0
// Size: 0x4c
function function_a880899e(eventparams) {
    localclientnum = eventparams.localclientnum;
    if (isdefined(self)) {
        function_d260edc9(localclientnum, eventparams.enabled);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x0
// Checksum 0x5e7d7cae, Offset: 0x708
// Size: 0x64
function function_fd0c759c(localclientnum, *oldval, newval, *bnewent, *binitialsnap, fieldname, *bwastimejump) {
    if (isdefined(level.var_e656f88a)) {
        [[ level.var_e656f88a ]](binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x0
// Checksum 0x7786d63, Offset: 0x778
// Size: 0x64
function function_1de73512(localclientnum, *oldval, newval, *bnewent, *binitialsnap, fieldname, *bwastimejump) {
    if (isdefined(level.var_70a07f6f)) {
        [[ level.var_70a07f6f ]](binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x0
// Checksum 0xd71f1dfe, Offset: 0x7e8
// Size: 0x196
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
            if (isdefined(level.var_bb1f7e1e.var_1050ff32)) {
                self.cloudfx = util::playfxontag(fieldname, #"hash_75b6b7edc8c8900", self, "tag_origin");
            }
        } else {
            self hide();
        }
        return;
    }
    if (isdefined(self.cloudfx)) {
        stopfx(fieldname, self.cloudfx);
        self.cloudfx = undefined;
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x0
// Checksum 0x12686599, Offset: 0x988
// Size: 0x54
function function_6d66e75a(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self thread function_90b75549(bwastimejump);
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0xef940c2e, Offset: 0x9e8
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
// Params 7, eflags: 0x0
// Checksum 0x816091b5, Offset: 0xad0
// Size: 0x84
function function_3e76ad59(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self function_d309e55a("tag_brake_control_animate", 1);
        return;
    }
    self function_d309e55a("tag_brake_control_animate", 0);
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x0
// Checksum 0x1595d147, Offset: 0xb60
// Size: 0x2d4
function missile_fired(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self function_d309e55a("tag_fin_control_animate", 1);
        self function_1f0c7136(2);
        localplayer = function_5c10bd79(fieldname);
        owner = self getowner(fieldname);
        if (localplayer hasperk(fieldname, #"specialty_showscorestreakicons") || self.team == localplayer.team) {
            self.iconent = spawn(fieldname, self.origin, "script_model", localplayer getentitynumber(), self.team);
            self.iconent setcompassicon(level.var_bb1f7e1e.var_cb98fbf7);
            var_b13727dd = getgametypesetting("compassAnchorScorestreakIcons");
            self.iconent function_dce2238(var_b13727dd);
            self.iconent setmodel(#"tag_origin");
            self.iconent linkto(self);
            self.iconent function_5e00861(level.var_bb1f7e1e.var_792e8590);
            self thread function_20fff7ed(level.var_bb1f7e1e.var_792e8590, level.var_bb1f7e1e.var_f99969f1, gettime(), level.var_bb1f7e1e.var_6b2f302f * 1000);
        }
        self thread hud_update(fieldname);
        self thread function_298565db();
        return;
    }
    if (bwastimejump == 2) {
        self.iconent delete();
        return;
    }
    self function_fd73ab50();
}

// Namespace remotemissile/remotemissile_shared
// Params 0, eflags: 0x4
// Checksum 0x6e561ee1, Offset: 0xe40
// Size: 0x3c
function private function_298565db() {
    self waittill(#"death", #"disconnect");
    self function_fd73ab50();
}

// Namespace remotemissile/remotemissile_shared
// Params 4, eflags: 0x0
// Checksum 0x48337a4f, Offset: 0xe88
// Size: 0xd4
function function_20fff7ed(startscale, endscale, starttime, duration) {
    self endon(#"death");
    while (gettime() < starttime + duration) {
        currtime = gettime();
        ratio = (currtime - starttime) / duration;
        scale = lerpfloat(startscale, endscale, ratio);
        self.iconent function_5e00861(scale);
        wait 0.1;
    }
    self.iconent function_5e00861(endscale);
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x0
// Checksum 0xae6f461b, Offset: 0xf68
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
            self.iconent = spawn(bnewent, self.origin, "script_model", localplayer getentitynumber(), self.team);
            self.iconent setcompassicon(level.var_bb1f7e1e.var_cb98fbf7);
            var_b13727dd = getgametypesetting("compassAnchorScorestreakIcons");
            self.iconent function_dce2238(var_b13727dd);
            self.iconent function_5e00861(level.var_bb1f7e1e.var_c3e4af00);
            self.iconent linkto(self);
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
// Params 0, eflags: 0x0
// Checksum 0x4b025f61, Offset: 0x11c8
// Size: 0x2c
function function_fd73ab50() {
    if (isdefined(self.iconent)) {
        self.iconent delete();
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 1, eflags: 0x0
// Checksum 0xae362be8, Offset: 0x1200
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
// Params 2, eflags: 0x0
// Checksum 0x1f064f2f, Offset: 0x14b8
// Size: 0x164
function function_d260edc9(localclientnum, enabled) {
    player = function_5c10bd79(localclientnum);
    postfxbundle = level.var_bb1f7e1e.var_19f55f0;
    if (!isdefined(postfxbundle)) {
        return;
    }
    if (enabled && !function_148ccc79(localclientnum, postfxbundle) && (!function_1cbf351b(localclientnum) || function_93e0f729(localclientnum) === function_27673a7(localclientnum)) && !codcaster::function_45a5c04c(localclientnum)) {
        if (isdefined(self.weapon) && self.weapon.statname == #"remote_missile") {
            function_a837926b(localclientnum, postfxbundle);
        }
        return;
    }
    if (function_148ccc79(localclientnum, postfxbundle)) {
        codestoppostfxbundlelocal(localclientnum, postfxbundle);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x0
// Checksum 0xf15e99b0, Offset: 0x1628
// Size: 0x1cc
function remote_missile_piloting(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    player = function_5c10bd79(fieldname);
    postfxbundle = level.var_bb1f7e1e.var_19f55f0;
    rumble = level.var_bb1f7e1e.var_f0728ef;
    if (!isdefined(self)) {
        return;
    }
    if (bwastimejump) {
        if (isdefined(postfxbundle) && !function_148ccc79(fieldname, postfxbundle)) {
            if ((!function_1cbf351b(fieldname) || function_93e0f729(fieldname) === function_27673a7(fieldname)) && !codcaster::function_45a5c04c(fieldname)) {
                function_a837926b(fieldname, postfxbundle);
            }
        }
        if (isdefined(rumble)) {
            self playrumblelooponentity(fieldname, rumble);
        }
        return;
    }
    if (isdefined(postfxbundle) && function_148ccc79(fieldname, postfxbundle)) {
        codestoppostfxbundlelocal(fieldname, postfxbundle);
    }
    if (isdefined(rumble)) {
        self stoprumble(fieldname, rumble);
    }
}

// Namespace remotemissile/remotemissile_shared
// Params 7, eflags: 0x0
// Checksum 0xe1e405a0, Offset: 0x1800
// Size: 0x74
function remote_missile_child_rocket_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        util::playfxontag(fieldname, level.var_bb1f7e1e.var_96312ae9, self, "tag_fx");
    }
}

