#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm;

#namespace zm_ai_tiger;

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 0, eflags: 0x2
// Checksum 0x50a9158d, Offset: 0x1b8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_ai_tiger", &__init__, undefined, undefined);
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 0, eflags: 0x0
// Checksum 0x6197ac1d, Offset: 0x200
// Size: 0x84
function __init__() {
    clientfield::register("toplayer", "" + #"hash_14c746e550d9f3ca", 1, 2, "counter", &function_4b208991, 0, 0);
    ai::add_archetype_spawn_function("tiger", &function_b30362ef);
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 1, eflags: 0x0
// Checksum 0x2d5ac56e, Offset: 0x290
// Size: 0xac
function function_b30362ef(localclientnum) {
    self._eyeglow_fx_override = "zm_ai/fx8_zombie_tiger_eye_glow_red";
    self._eyeglow_tag_override = "tag_eye";
    self zm::createzombieeyes(localclientnum);
    self.var_cb2e3984 = "rob_zm_towers_tiger_eye_red";
    self playrenderoverridebundle(self.var_cb2e3984, "j_head");
    self.var_e015d462 = &function_ea070850;
    self callback::on_shutdown(&on_entity_shutdown);
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 7, eflags: 0x0
// Checksum 0xb7cf18e1, Offset: 0x348
// Size: 0x9c
function function_4b208991(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (abs(newval - oldval) == 1) {
        self postfx::playpostfxbundle("pstfx_tiger_slash");
        return;
    }
    self postfx::playpostfxbundle("pstfx_tiger_slash_r_to_l");
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 2, eflags: 0x0
// Checksum 0x18eb3b22, Offset: 0x3f0
// Size: 0x114
function function_ea070850(localclientnum, turned) {
    self stoprenderoverridebundle(self.var_cb2e3984, "j_head");
    self.var_cb2e3984 = turned == 1 ? "rob_zm_towers_tiger_eye_green" : "rob_zm_towers_tiger_eye_red";
    self playrenderoverridebundle(self.var_cb2e3984, "j_head");
    if (turned) {
        self zm::deletezombieeyes(localclientnum);
        self._eyeglow_fx_override = "zm_ai/fx8_zombie_tiger_eye_glow_green";
        self zm::createzombieeyes(localclientnum);
        return;
    }
    self zm::deletezombieeyes(localclientnum);
    self._eyeglow_fx_override = "zm_ai/fx8_zombie_tiger_eye_glow_red";
    self zm::createzombieeyes(localclientnum);
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 1, eflags: 0x0
// Checksum 0x90b23689, Offset: 0x510
// Size: 0x104
function on_entity_shutdown(localclientnum) {
    if (isdefined(self)) {
        self zm::deletezombieeyes(localclientnum);
        self stoprenderoverridebundle(self.var_cb2e3984, "j_head");
        origin = self gettagorigin("j_spine2");
        angles = self gettagangles("j_spine2");
        if (!isdefined(origin)) {
            origin = self.origin;
        }
        if (!isdefined(angles)) {
            angles = self.angles;
        }
        playfx(localclientnum, "zm_ai/fx8_dog_death_exp", origin, anglestoforward(angles));
    }
}

