#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace gadget_clone_render;

// Namespace gadget_clone_render/gadget_clone_render
// Params 0, eflags: 0x2
// Checksum 0xfa68e572, Offset: 0x230
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_clone_render", &__init__, undefined, undefined);
}

// Namespace gadget_clone_render/gadget_clone_render
// Params 0, eflags: 0x0
// Checksum 0x1f3e8381, Offset: 0x270
// Size: 0xd4
function __init__() {
    duplicate_render::set_dr_filter_framebuffer("clone_ally", 90, "clone_ally_on", "clone_damage", 0, "mc/ability_clone_ally", 0);
    duplicate_render::set_dr_filter_framebuffer("clone_enemy", 90, "clone_enemy_on", "clone_damage", 0, "mc/ability_clone_enemy", 0);
    duplicate_render::set_dr_filter_framebuffer("clone_damage_ally", 90, "clone_ally_on,clone_damage", undefined, 0, "mc/ability_clone_ally_damage", 0);
    duplicate_render::set_dr_filter_framebuffer("clone_damage_enemy", 90, "clone_enemy_on,clone_damage", undefined, 0, "mc/ability_clone_enemy_damage", 0);
}

// Namespace gadget_clone_render/gadget_clone_render
// Params 1, eflags: 0x0
// Checksum 0x68b91a42, Offset: 0x350
// Size: 0xa0
function transition_shader(localclientnum) {
    self endon(#"death");
    self endon(#"clone_shader_off");
    rampinshader = 0;
    while (rampinshader < 1) {
        if (isdefined(self)) {
            self mapshaderconstant(localclientnum, 0, "scriptVector3", 1, rampinshader, 0, 0.04);
        }
        rampinshader += 0.04;
        waitframe(1);
    }
}

