#using script_13da4e6b98ca81a1;
#using script_4daa124bc391e7ed;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\smokegrenade;

#namespace player;

// Namespace player/player
// Params 0, eflags: 0x6
// Checksum 0x8a1275e4, Offset: 0xf0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_mp", &preinit, undefined, undefined, "renderoverridebundle");
}

// Namespace player/player
// Params 0, eflags: 0x4
// Checksum 0xdacfbcf6, Offset: 0x140
// Size: 0x19c
function private preinit() {
    callback::on_spawned(&on_player_spawned);
    callback::on_player_corpse(&on_player_corpse);
    callback::function_930e5d42(&function_930e5d42);
    callback::on_weapon_change(&function_585458);
    callback::on_localclient_connect(&codcaster::function_57a6b7b0);
    level.var_15ab9bbd = 1;
    renderoverridebundle::function_f72f089c(#"hash_27554b8df2b9e92b", sessionmodeiscampaigngame() ? #"hash_1cbf6d26721c59a7" : #"hash_1c90592671f4c6e9", &function_6803f977, undefined, undefined, 1);
    renderoverridebundle::function_f72f089c(#"hash_5982cfcbc143bf28", #"rob_codcaster_keyline", &function_9216f2c3);
    renderoverridebundle::function_f72f089c(#"hash_7a2c1fbc9f2b9754", #"hash_58a6f58aee1cda35", &function_9216f2c3);
}

// Namespace player/player
// Params 2, eflags: 0x0
// Checksum 0xbd7da3de, Offset: 0x2e8
// Size: 0x7c
function function_a25e8ff(localclientnum, var_27121fbd) {
    if (!var_27121fbd && codcaster::function_b8fe9b52(localclientnum)) {
        codcaster::function_12acfa84();
        return;
    }
    if (!self function_21c0fa55()) {
        self function_bcc9c79c(localclientnum);
    }
}

// Namespace player/player
// Params 1, eflags: 0x0
// Checksum 0xc584f58a, Offset: 0x370
// Size: 0xd4
function on_player_spawned(localclientnum) {
    if (codcaster::function_b8fe9b52(localclientnum)) {
        if (self postfx::function_556665f2("pstfx_radiation_dot")) {
            self postfx::exitpostfxbundle("pstfx_radiation_dot");
        }
        if (self postfx::function_556665f2("pstfx_burn_loop")) {
            self postfx::exitpostfxbundle("pstfx_burn_loop");
        }
    }
    function_a25e8ff(localclientnum, 0);
    self namespace_9bcd7d72::function_bdda909b();
}

// Namespace player/player
// Params 1, eflags: 0x4
// Checksum 0xbf981cbd, Offset: 0x450
// Size: 0xd8
function private function_5d6c2a78(localclientnum) {
    foreach (player in getplayers(localclientnum)) {
        if (!player function_21c0fa55() && player.team == self.team) {
            player function_bcc9c79c(localclientnum);
        }
    }
}

// Namespace player/player
// Params 1, eflags: 0x0
// Checksum 0xafdb0bf1, Offset: 0x530
// Size: 0x4c
function function_930e5d42(localclientnum) {
    if (self function_da43934d()) {
        level notify(#"hash_21eba590bb904092");
        self function_5d6c2a78(localclientnum);
    }
}

// Namespace player/player
// Params 2, eflags: 0x0
// Checksum 0xd3bac78d, Offset: 0x588
// Size: 0xec
function on_player_corpse(localclientnum, *params) {
    self endon(#"death");
    self util::waittill_dobj(params);
    self function_a25e8ff(params, 1);
    self renderoverridebundle::stop_bundle(#"friendly", sessionmodeiscampaigngame() ? #"hash_1cbf6d26721c59a7" : #"hash_1c90592671f4c6e9", 0);
    if (codcaster::function_b8fe9b52(params)) {
        self stoprenderoverridebundle(#"rob_codcaster_keyline");
    }
}

// Namespace player/player
// Params 1, eflags: 0x0
// Checksum 0xc25766f6, Offset: 0x680
// Size: 0x94
function function_585458(params) {
    if (self == level) {
        local_client_num = params.localclientnum;
        var_a6426655 = function_5778f82(local_client_num, #"hash_410c46b5ff702c96");
        if (var_a6426655) {
            localplayer = function_5c10bd79(local_client_num);
            localplayer smokegrenade::function_4fc900e1(local_client_num);
        }
    }
}

// Namespace player/player
// Params 1, eflags: 0x0
// Checksum 0x4140d00a, Offset: 0x720
// Size: 0x44
function function_bcc9c79c(local_client_num) {
    self renderoverridebundle::function_c8d97b8e(local_client_num, #"friendly", #"hash_27554b8df2b9e92b");
}

// Namespace player/player
// Params 2, eflags: 0x0
// Checksum 0x4da130ab, Offset: 0x770
// Size: 0x56
function function_9216f2c3(local_client_num, *bundle) {
    if (level.gameended) {
        return false;
    }
    if (!codcaster::function_b8fe9b52(bundle)) {
        return false;
    }
    if (!level.gamestarted) {
        return false;
    }
    return true;
}

// Namespace player/player
// Params 2, eflags: 0x0
// Checksum 0x9eb56de5, Offset: 0x7d0
// Size: 0x10a
function function_6803f977(local_client_num, bundle) {
    if (!function_2f9b4fe8(local_client_num, #"specialty_friendliesthroughwalls")) {
        return 0;
    }
    if (level.gameended) {
        return 0;
    }
    if (self function_da43934d()) {
        return 0;
    }
    if (isigcactive(local_client_num)) {
        return 0;
    }
    player = function_5c10bd79(local_client_num);
    if (self == player) {
        return 0;
    }
    if (function_1cbf351b(local_client_num) && !player function_ca024039()) {
        return 0;
    }
    if (player.var_33b61b6f === 1) {
        return 0;
    }
    return renderoverridebundle::function_6803f977(local_client_num, bundle);
}

