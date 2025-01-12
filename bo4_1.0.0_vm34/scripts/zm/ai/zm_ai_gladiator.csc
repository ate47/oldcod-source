#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm;

#namespace zm_ai_gladiator;

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 0, eflags: 0x2
// Checksum 0x12e64151, Offset: 0x1d0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_ai_gladiator", &__init__, undefined, undefined);
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 0, eflags: 0x0
// Checksum 0xada2ffbc, Offset: 0x218
// Size: 0x17c
function __init__() {
    level._effect[#"fx8_destroyer_axe_trail"] = "zm_ai/fx8_destroyer_axe_trail";
    level._effect[#"fx8_destroyer_arm_spurt"] = "zm_ai/fx8_destroyer_arm_spurt";
    footsteps::registeraitypefootstepcb("gladiator", &function_898561c5);
    ai::add_archetype_spawn_function("gladiator", &function_3ac849d4);
    clientfield::register("toplayer", "gladiator_melee_effect", 1, 1, "counter", &function_92ecd51a, 0, 0);
    clientfield::register("actor", "gladiator_arm_effect", 1, 2, "int", &function_355706b0, 0, 0);
    clientfield::register("scriptmover", "gladiator_axe_effect", 1, 1, "int", &function_dfa007ea, 0, 0);
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 5, eflags: 0x4
// Checksum 0x80298b90, Offset: 0x3a0
// Size: 0x1bc
function private function_898561c5(localclientnum, pos, surface, notetrack, bone) {
    e_player = function_f97e7787(localclientnum);
    n_dist = distancesquared(pos, e_player.origin);
    var_b4860eb2 = 1000000;
    if (var_b4860eb2 > 0) {
        n_scale = (var_b4860eb2 - n_dist) / var_b4860eb2;
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

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0xc99c4035, Offset: 0x568
// Size: 0x84
function private function_3ac849d4(localclientnum) {
    self._eyeglow_tag_override = "tag_eye";
    self zm::createzombieeyes(localclientnum);
    self.var_cb2e3984 = "rob_zm_eyes_red";
    self playrenderoverridebundle(self.var_cb2e3984, "j_head");
    self callback::on_shutdown(&function_6b7fb63a);
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x7ca0adc0, Offset: 0x5f8
// Size: 0x54
function private function_6b7fb63a(localclientnum) {
    if (isdefined(self)) {
        self zm::deletezombieeyes(localclientnum);
        self stoprenderoverridebundle(self.var_cb2e3984, "j_head");
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 7, eflags: 0x4
// Checksum 0x28decf8f, Offset: 0x658
// Size: 0x8c
function private function_92ecd51a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    earthquake(localclientnum, 0.3, 1.2, self.origin, 64);
    function_d2913e3e(localclientnum, "damage_light");
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 7, eflags: 0x4
// Checksum 0xca6f407c, Offset: 0x6f0
// Size: 0xcc
function private function_355706b0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        util::playfxontag(localclientnum, level._effect[#"fx8_destroyer_arm_spurt"], self, "j_shouldertwist_le");
        return;
    }
    if (newval == 2) {
        util::playfxontag(localclientnum, level._effect[#"fx8_destroyer_arm_spurt"], self, "tag_shoulder_ri_fx");
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 7, eflags: 0x4
// Checksum 0xecb07f21, Offset: 0x7c8
// Size: 0xb4
function private function_dfa007ea(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_d6fcdf7f = util::playfxontag(localclientnum, level._effect[#"fx8_destroyer_axe_trail"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_d6fcdf7f)) {
        stopfx(localclientnum, self.var_d6fcdf7f);
    }
}

