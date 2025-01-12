#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\system_shared;

#namespace archetype_stoker;

// Namespace archetype_stoker/archetype_stoker
// Params 0, eflags: 0x2
// Checksum 0x41a863df, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"stoker", &__init__, undefined, undefined);
}

// Namespace archetype_stoker/archetype_stoker
// Params 0, eflags: 0x0
// Checksum 0x491574eb, Offset: 0xf0
// Size: 0x54
function __init__() {
    footsteps::registeraitypefootstepcb("stoker", &function_ee209e18);
    ai::add_archetype_spawn_function("stoker", &function_1d7b286f);
}

// Namespace archetype_stoker/archetype_stoker
// Params 5, eflags: 0x0
// Checksum 0x909b7113, Offset: 0x150
// Size: 0x1bc
function function_ee209e18(localclientnum, pos, surface, notetrack, bone) {
    e_player = function_f97e7787(localclientnum);
    n_dist = distancesquared(pos, e_player.origin);
    var_21665d39 = 1000000;
    if (var_21665d39 > 0) {
        n_scale = (var_21665d39 - n_dist) / var_21665d39;
    } else {
        return;
    }
    if (n_scale > 1 || n_scale < 0) {
        return;
    }
    n_scale *= 0.25;
    if (n_scale <= 0.01) {
        return;
    }
    earthquake(localclientnum, n_scale, 0.1, pos, n_dist);
    if (n_scale <= 0.25 && n_scale > 0.2) {
        function_d2913e3e(localclientnum, "anim_med");
        return;
    }
    if (n_scale <= 0.2 && n_scale > 0.1) {
        function_d2913e3e(localclientnum, "damage_light");
        return;
    }
    function_d2913e3e(localclientnum, "damage_light");
}

// Namespace archetype_stoker/archetype_stoker
// Params 1, eflags: 0x4
// Checksum 0xe9d32c38, Offset: 0x318
// Size: 0x2c
function private function_1d7b286f(localclientnum) {
    fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
}

