#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;

#namespace shrapnel;

// Namespace shrapnel/shrapnel
// Params 0, eflags: 0x6
// Checksum 0x885695e4, Offset: 0xe0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"shrapnel", undefined, &__postload_init__, undefined, undefined);
}

// Namespace shrapnel/shrapnel
// Params 0, eflags: 0x0
// Checksum 0x9a17c687, Offset: 0x128
// Size: 0xb4
function __postload_init__() {
    if (!getdvarint(#"shrapnel_enabled", 0)) {
        return;
    }
    if (!level.new_health_model) {
        return;
    }
    level.var_67f97f4 = [];
    level.var_67f97f4[1] = "generic_explosion_overlay_01";
    level.var_67f97f4[2] = "generic_explosion_overlay_02";
    level.var_67f97f4[3] = "generic_explosion_overlay_03";
    level.var_67f97f4[4] = "generic_explosion_overlay_03";
    callback::on_localplayer_spawned(&localplayer_spawned);
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0xa4bc69be, Offset: 0x1e8
// Size: 0x74
function private localplayer_spawned(localclientnum) {
    if (!self function_21c0fa55()) {
        return;
    }
    level thread wait_game_ended(localclientnum);
    self thread function_989d336d(localclientnum);
    self thread function_8f0cb320(localclientnum);
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0xca4b51d0, Offset: 0x268
// Size: 0x54
function private function_8f0cb320(localclientnum) {
    self waittill(#"death");
    self function_816d735d(localclientnum);
    self end_splatter(localclientnum);
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0x8c241564, Offset: 0x2c8
// Size: 0x36
function private enable_shrapnel(*localclientnum) {
    self.shrapnel_enabled = 1;
    if (!isdefined(self.var_f08b8b9)) {
        self.var_f08b8b9 = "generic_explosion_overlay_01";
    }
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0x6855b7a3, Offset: 0x308
// Size: 0x1e
function private function_816d735d(*localclientnum) {
    if (isdefined(self)) {
        self.shrapnel_enabled = 0;
    }
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0x6dd5f546, Offset: 0x330
// Size: 0x2b6
function private function_989d336d(localclientnum) {
    self endon(#"disconnect");
    self endon(#"death");
    assert(level.new_health_model == 1);
    basehealth = 100;
    playerhealth = renderhealthoverlayhealth(localclientnum, basehealth);
    var_8e5bb835 = playerhealth;
    while (true) {
        if (!isdefined(self.shrapnel_enabled)) {
            self.shrapnel_enabled = 0;
        }
        var_df99eba3 = 0;
        if (renderhealthoverlay(localclientnum)) {
            priorplayerhealth = playerhealth;
            playerhealth = renderhealthoverlayhealth(localclientnum, basehealth);
            var_89524e53 = function_e31d7cf9(playerhealth, priorplayerhealth, basehealth);
            var_d081e441 = function_bf9b3d6(playerhealth, basehealth);
            if (playerhealth > var_8e5bb835 || playerhealth <= var_d081e441) {
                var_8e5bb835 = playerhealth;
            }
            var_387f8be9 = self function_a6fe4166();
            var_ba6de045 = self.var_d9167e48 === 1;
            if (var_ba6de045) {
                var_1e429b84 = var_8e5bb835 - playerhealth >= 1 / basehealth - 0.0001;
                if (var_1e429b84 && playerhealth > var_d081e441) {
                    self thread splatter(localclientnum);
                    var_8e5bb835 = playerhealth;
                    self.var_d9167e48 = 0;
                }
            }
            shouldenabledoverlay = 0;
            if (var_387f8be9 > 0 && playerhealth <= var_89524e53) {
                var_df99eba3 = 1;
            }
            self function_4e9cfc19(localclientnum, playerhealth, priorplayerhealth, basehealth);
        }
        if (var_df99eba3) {
            if (!self.shrapnel_enabled) {
                self enable_shrapnel(localclientnum);
            }
        } else if (self.shrapnel_enabled) {
            self function_816d735d(localclientnum);
        }
        waitframe(1);
    }
}

// Namespace shrapnel/shrapnel
// Params 0, eflags: 0x4
// Checksum 0xcdc10d51, Offset: 0x5f0
// Size: 0x6
function private function_a6fe4166() {
    return false;
}

// Namespace shrapnel/shrapnel
// Params 3, eflags: 0x0
// Checksum 0x300206d6, Offset: 0x600
// Size: 0xa8
function function_e31d7cf9(playerhealth, priorplayerhealth, basehealth) {
    healing = playerhealth > priorplayerhealth;
    if (healing || self.var_fe44fc0f === 1) {
        self.var_fe44fc0f = playerhealth >= priorplayerhealth;
        return (getdvarint(#"hash_5a4cebcd3aef8f0", 90) / basehealth);
    }
    return getdvarint(#"hash_213e599222859525", 90) / basehealth;
}

// Namespace shrapnel/shrapnel
// Params 2, eflags: 0x0
// Checksum 0x2720edec, Offset: 0x6b0
// Size: 0x40
function function_bf9b3d6(*playerhealth, basehealth) {
    return getdvarint(#"hash_213e599222859525", 90) / basehealth;
}

// Namespace shrapnel/shrapnel
// Params 4, eflags: 0x4
// Checksum 0x229e9184, Offset: 0x6f8
// Size: 0x166
function private function_4e9cfc19(*localclientnum, playerhealth, priorplayerhealth, basehealth = 100) {
    if (!isdefined(self.var_996ceac2)) {
        self.var_996ceac2 = 0;
    }
    var_89524e53 = self function_e31d7cf9(playerhealth, priorplayerhealth, basehealth);
    stage2_threshold = getdvarint(#"hash_213e56922285900c", 69) / basehealth;
    stage3_threshold = getdvarint(#"hash_213e5792228591bf", 29) / basehealth;
    stage4_threshold = getdvarint(#"hash_213e549222858ca6", 1) / basehealth;
    var_5142946f = self.var_996ceac2;
    var_387f8be9 = self function_a6fe4166();
    if (var_387f8be9 != var_5142946f) {
    }
    self.var_996ceac2 = var_387f8be9;
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0x482576e1, Offset: 0x868
// Size: 0x35c
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
        waitframe(1);
    }
    end_splatter(localclientnum);
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0x67d280de, Offset: 0xbd0
// Size: 0xc
function private start_splatter(*localclientnum) {
    
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0x7d4a5136, Offset: 0xbe8
// Size: 0xc
function private end_splatter(*localclientnum) {
    
}

// Namespace shrapnel/shrapnel
// Params 1, eflags: 0x4
// Checksum 0x2aed7d22, Offset: 0xc00
// Size: 0x7c
function private wait_game_ended(localclientnum) {
    if (!isdefined(level.var_b6a1586d)) {
        level.var_b6a1586d = [];
    }
    if (level.var_b6a1586d[localclientnum] === 1) {
        return;
    }
    level.var_b6a1586d[localclientnum] = 1;
    level waittill(#"game_ended");
    level.var_b6a1586d[localclientnum] = 0;
}
