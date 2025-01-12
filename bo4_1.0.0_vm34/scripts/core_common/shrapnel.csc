#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\filter_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;

#namespace shrapnel;

// Namespace shrapnel/shrapnel
// Params 0, eflags: 0x2
// Checksum 0xdbdd30f9, Offset: 0x118
// Size: 0x34
function autoexec __init__system__() {
    system::register(#"shrapnel", undefined, &__postload_init__, undefined);
}

// Namespace shrapnel/shrapnel
// Params 0, eflags: 0x0
// Checksum 0xc0429cab, Offset: 0x158
// Size: 0xd4
function __postload_init__() {
    if (!getdvarint(#"shrapnel_enabled", 0)) {
        return;
    }
    if (!level.new_health_model) {
        return;
    }
    level.var_c4e2df29 = [];
    level.var_c4e2df29[1] = "generic_explosion_overlay_01";
    level.var_c4e2df29[2] = "generic_explosion_overlay_02";
    level.var_c4e2df29[3] = "generic_explosion_overlay_03";
    level.var_c4e2df29[4] = "generic_explosion_overlay_03";
    callback::on_localplayer_spawned(&localplayer_spawned);
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0x6efc27c7, Offset: 0x238
// Size: 0xd4
function private localplayer_spawned(localclientnum) {
    if (!self function_60dbc438()) {
        return;
    }
    level thread wait_game_ended(localclientnum);
    self thread function_511e88ba(localclientnum);
    self thread function_f16c16b(localclientnum);
    new_health_model_ui_model = createuimodel(getuimodelforcontroller(localclientnum), "usingNewHealthModel");
    if (isdefined(new_health_model_ui_model)) {
        setuimodelvalue(new_health_model_ui_model, level.new_health_model);
    }
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0x7845b8e5, Offset: 0x318
// Size: 0x54
function private function_f16c16b(localclientnum) {
    self waittill(#"death");
    self function_155e6eb9(localclientnum);
    self end_splatter(localclientnum);
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0x7ca6ae18, Offset: 0x378
// Size: 0xb4
function private enable_shrapnel(localclientnum) {
    self.shrapnel_enabled = 1;
    if (!isdefined(self.var_ae60a539)) {
        self.var_ae60a539 = "generic_explosion_overlay_01";
    }
    setfilterpassmaterial(localclientnum, 6, 1, get_mat_id(localclientnum, self.var_ae60a539));
    filter::function_d8c6dc18(localclientnum, 6, 1, 1);
    setfilterpassenabled(localclientnum, 6, 1, 1);
}

// Namespace shrapnel/shrapnel
// Params 2, eflags: 0x4
// Checksum 0xb153f1df, Offset: 0x438
// Size: 0x72
function private get_mat_id(localclientnum, filter_name) {
    mat_id = filter::mapped_material_id(filter_name);
    if (!isdefined(mat_id)) {
        filter::map_material_helper_by_localclientnum(localclientnum, filter_name);
        mat_id = filter::mapped_material_id(filter_name);
    }
    return mat_id;
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0xa4194863, Offset: 0x4b8
// Size: 0x3c
function private function_155e6eb9(localclientnum) {
    if (isdefined(self)) {
        self.shrapnel_enabled = 0;
    }
    setfilterpassenabled(localclientnum, 6, 1, 0);
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0x484a4bfc, Offset: 0x500
// Size: 0x2d6
function private function_511e88ba(localclientnum) {
    self endon(#"disconnect");
    self endon(#"death");
    assert(level.new_health_model == 1);
    basehealth = 100;
    playerhealth = renderhealthoverlayhealth(localclientnum, basehealth);
    var_1fea5000 = playerhealth;
    while (true) {
        if (!isdefined(self.shrapnel_enabled)) {
            self.shrapnel_enabled = 0;
        }
        var_2675357e = 0;
        if (renderhealthoverlay(localclientnum)) {
            priorplayerhealth = playerhealth;
            playerhealth = renderhealthoverlayhealth(localclientnum, basehealth);
            var_6388eb5a = function_998d6f91(playerhealth, priorplayerhealth, basehealth);
            var_b74eb71c = function_ff53c4d(playerhealth, basehealth);
            if (playerhealth > var_1fea5000 || playerhealth <= var_b74eb71c) {
                var_1fea5000 = playerhealth;
            }
            var_ac282025 = self function_ada61d2();
            var_8c31b0a4 = self.var_2744e907 === 1;
            if (var_8c31b0a4) {
                var_3c6c3e9f = var_1fea5000 - playerhealth >= 1 / basehealth - 0.0001;
                if (var_3c6c3e9f && playerhealth > var_b74eb71c) {
                    self thread splatter(localclientnum);
                    var_1fea5000 = playerhealth;
                    self.var_2744e907 = 0;
                }
            }
            shouldenabledoverlay = 0;
            if (var_ac282025 > 0 && playerhealth <= var_6388eb5a) {
                var_2675357e = 1;
            }
            self function_245ddbb6(localclientnum, playerhealth, priorplayerhealth, basehealth);
        }
        if (var_2675357e) {
            if (!self.shrapnel_enabled) {
                self enable_shrapnel(localclientnum);
            }
        } else if (self.shrapnel_enabled) {
            self function_155e6eb9(localclientnum);
        }
        waitframe(1);
    }
}

// Namespace shrapnel/shrapnel
// Params 0, eflags: 0x4
// Checksum 0x2977fc92, Offset: 0x7e0
// Size: 0x6
function private function_ada61d2() {
    return false;
}

// Namespace shrapnel/shrapnel
// Params 3, eflags: 0x0
// Checksum 0xea74f66d, Offset: 0x7f0
// Size: 0xb0
function function_998d6f91(playerhealth, priorplayerhealth, basehealth) {
    healing = playerhealth > priorplayerhealth;
    if (healing || self.var_c421d4ad === 1) {
        self.var_c421d4ad = playerhealth >= priorplayerhealth;
        return (getdvarint(#"hash_5a4cebcd3aef8f0", 90) / basehealth);
    }
    return getdvarint(#"hash_213e599222859525", 90) / basehealth;
}

// Namespace shrapnel/shrapnel
// Params 2, eflags: 0x0
// Checksum 0x1b44d14d, Offset: 0x8a8
// Size: 0x40
function function_ff53c4d(playerhealth, basehealth) {
    return getdvarint(#"hash_213e599222859525", 90) / basehealth;
}

// Namespace shrapnel/shrapnel
// Params 4, eflags: 0x4
// Checksum 0x14228a5c, Offset: 0x8f0
// Size: 0x1ea
function private function_245ddbb6(localclientnum, playerhealth, priorplayerhealth, basehealth = 100) {
    if (!isdefined(self.var_8a37f90)) {
        self.var_8a37f90 = 0;
    }
    var_6388eb5a = self function_998d6f91(playerhealth, priorplayerhealth, basehealth);
    stage2_threshold = getdvarint(#"hash_213e56922285900c", 69) / basehealth;
    stage3_threshold = getdvarint(#"hash_213e5792228591bf", 29) / basehealth;
    stage4_threshold = getdvarint(#"hash_213e549222858ca6", 1) / basehealth;
    var_197fe96 = self.var_8a37f90;
    var_ac282025 = self function_ada61d2();
    if (var_ac282025 != var_197fe96) {
        if (var_ac282025 > 0) {
            self.var_ae60a539 = level.var_c4e2df29[var_ac282025];
            filter::map_material_helper_by_localclientnum(localclientnum, self.var_ae60a539);
            if (self.shrapnel_enabled) {
                setfilterpassmaterial(localclientnum, 6, 1, filter::mapped_material_id(self.var_ae60a539));
            }
        }
    }
    self.var_8a37f90 = var_ac282025;
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0x77358a62, Offset: 0xae8
// Size: 0x394
function private splatter(localclientnum) {
    self notify(#"hash_343f00346af5b101");
    self endon(#"hash_343f00346af5b101");
    splatter_opacity = getdvarfloat(#"hash_95576df1970dd46", 1);
    start_splatter(localclientnum);
    initial_delay = math::clamp(getdvarint(#"hash_41140ec15abcde62", 100), 10, 3000);
    wait float(initial_delay) / 1000;
    if (!isdefined(self)) {
        end_splatter(localclientnum);
        return;
    }
    lasttime = self getclienttime();
    while (splatter_opacity > 0.9 && isdefined(self)) {
        now = self getclienttime();
        elapsedtime = now - lasttime;
        if (elapsedtime > 0) {
            fadeduration = math::clamp(getdvarint(#"hash_34e60a4256fbc184", 5000), 10, 88000);
            splatter_opacity -= elapsedtime / fadeduration;
            splatter_opacity = math::clamp(splatter_opacity, 0, 1);
            lasttime = now;
        }
        filter::function_d8c6dc18(localclientnum, 6, 0, splatter_opacity);
        waitframe(1);
    }
    wait getdvarfloat(#"hash_624718787e051400", 1.5);
    if (!isdefined(self)) {
        end_splatter(localclientnum);
        return;
    }
    lasttime = self getclienttime();
    while (splatter_opacity > 0 && isdefined(self)) {
        now = self getclienttime();
        elapsedtime = now - lasttime;
        if (elapsedtime > 0) {
            fadeduration = math::clamp(getdvarint(#"hash_34e60d4256fbc69d", 500), 10, 88000);
            splatter_opacity -= elapsedtime / fadeduration;
            splatter_opacity = math::clamp(splatter_opacity, 0, 1);
            lasttime = now;
        }
        filter::function_d8c6dc18(localclientnum, 6, 0, splatter_opacity);
        waitframe(1);
    }
    end_splatter(localclientnum);
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0x13dac62d, Offset: 0xe88
// Size: 0xbc
function private start_splatter(localclientnum) {
    filter::map_material_helper_by_localclientnum(localclientnum, "generic_explosion_overlay_00");
    setfilterpassmaterial(localclientnum, 6, 0, filter::mapped_material_id("generic_explosion_overlay_00"));
    filter::function_d8c6dc18(localclientnum, 6, 0, getdvarfloat(#"hash_95576df1970dd46", 1));
    setfilterpassenabled(localclientnum, 6, 0, 1);
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0xbee54a6d, Offset: 0xf50
// Size: 0x2c
function private end_splatter(localclientnum) {
    setfilterpassenabled(localclientnum, 6, 0, 0);
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0xc8fc6555, Offset: 0xf88
// Size: 0x8a
function private wait_game_ended(localclientnum) {
    if (!isdefined(level.var_abb7210a)) {
        level.var_abb7210a = [];
    }
    if (level.var_abb7210a[localclientnum] === 1) {
        return;
    }
    level.var_abb7210a[localclientnum] = 1;
    level waittill(#"game_ended");
    level.var_abb7210a[localclientnum] = 0;
}

