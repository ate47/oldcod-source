#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace namespace_1e7514ce;

// Namespace namespace_1e7514ce/namespace_1e7514ce
// Params 0, eflags: 0x2
// Checksum 0xfa68e572, Offset: 0x230
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_clone_render", &__init__, undefined, undefined);
}

// Namespace namespace_1e7514ce/namespace_1e7514ce
// Params 0, eflags: 0x0
// Checksum 0x1f3e8381, Offset: 0x270
// Size: 0xd4
function __init__() {
    duplicate_render::set_dr_filter_framebuffer("clone_ally", 90, "clone_ally_on", "clone_damage", 0, "mc/ability_clone_ally", 0);
    duplicate_render::set_dr_filter_framebuffer("clone_enemy", 90, "clone_enemy_on", "clone_damage", 0, "mc/ability_clone_enemy", 0);
    duplicate_render::set_dr_filter_framebuffer("clone_damage_ally", 90, "clone_ally_on,clone_damage", undefined, 0, "mc/ability_clone_ally_damage", 0);
    duplicate_render::set_dr_filter_framebuffer("clone_damage_enemy", 90, "clone_enemy_on,clone_damage", undefined, 0, "mc/ability_clone_enemy_damage", 0);
}

// Namespace namespace_1e7514ce/namespace_1e7514ce
// Params 1, eflags: 0x0
// Checksum 0x68b91a42, Offset: 0x350
// Size: 0xa0
function function_9bad5680(localclientnum) {
    self endon(#"death");
    self endon(#"hash_b8916aca");
    var_c4612ef7 = 0;
    while (var_c4612ef7 < 1) {
        if (isdefined(self)) {
            self mapshaderconstant(localclientnum, 0, "scriptVector3", 1, var_c4612ef7, 0, 0.04);
        }
        var_c4612ef7 += 0.04;
        waitframe(1);
    }
}

