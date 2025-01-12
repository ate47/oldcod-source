#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\util_shared;

#namespace archetype_elephant;

// Namespace archetype_elephant/archetype_elephant
// Params 0, eflags: 0x2
// Checksum 0xebfddea1, Offset: 0x218
// Size: 0x204
function autoexec init() {
    ai::add_archetype_spawn_function("elephant", &function_ee4da73e);
    clientfield::register("actor", "towers_boss_melee_effect", 1, 1, "counter", &function_65e7b95c, 0, 0);
    clientfield::register("actor", "tower_boss_death_fx", 1, 1, "counter", &function_490ae06a, 0, 0);
    clientfield::register("scriptmover", "towers_boss_head_proj_fx_cf", 1, 1, "int", &function_897c8e13, 0, 0);
    clientfield::register("scriptmover", "towers_boss_head_proj_explosion_fx_cf", 1, 1, "int", &function_1a9d47a0, 0, 0);
    clientfield::register("actor", "towers_boss_eye_fx_cf", 1, 1, "int", &function_597cfd7f, 0, 0);
    footsteps::registeraitypefootstepcb("elephant", &function_374c03d4);
    clientfield::register("actor", "sndTowersBossArmor", 1, 1, "int", &sndtowersbossarmor, 0, 0);
}

// Namespace archetype_elephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0x719a9a65, Offset: 0x428
// Size: 0xc
function private function_ee4da73e(localclientnum) {
    
}

// Namespace archetype_elephant/archetype_elephant
// Params 7, eflags: 0x0
// Checksum 0xa7e5945c, Offset: 0x440
// Size: 0xa4
function function_597cfd7f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.eyefx = util::playfxontag(localclientnum, "maps/zm_towers/fx8_boss_eye_glow", self, "tag_eye");
        return;
    }
    if (isdefined(self.eyefx)) {
        stopfx(localclientnum, self.eyefx);
    }
}

// Namespace archetype_elephant/archetype_elephant
// Params 7, eflags: 0x0
// Checksum 0x953cfbb4, Offset: 0x4f0
// Size: 0xa4
function function_897c8e13(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.fx = util::playfxontag(localclientnum, "maps/zm_towers/fx8_boss_attack_eye_trail", self, "tag_origin");
        return;
    }
    if (isdefined(self.fx)) {
        stopfx(localclientnum, self.fx);
    }
}

// Namespace archetype_elephant/archetype_elephant
// Params 7, eflags: 0x0
// Checksum 0x57790ee, Offset: 0x5a0
// Size: 0xa4
function function_1a9d47a0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.fx = util::playfxontag(localclientnum, "maps/zm_towers/fx8_boss_attack_eye_trail_split", self, "tag_origin");
        return;
    }
    if (isdefined(self.fx)) {
        stopfx(localclientnum, self.fx);
    }
}

// Namespace archetype_elephant/archetype_elephant
// Params 7, eflags: 0x0
// Checksum 0xfad7ae7, Offset: 0x650
// Size: 0x18c
function function_65e7b95c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    e_player = function_f97e7787(localclientnum);
    n_dist = distancesquared(self gettagorigin("j_nose4"), e_player.origin);
    var_cad97542 = 1400 * 1400;
    n_scale = (var_cad97542 - n_dist) / var_cad97542;
    if (n_scale > 0.01) {
        earthquake(localclientnum, n_scale, 1, self.origin, n_dist);
        if (n_scale <= 0.25 && n_scale > 0.2) {
            function_d2913e3e(localclientnum, "tank_fire");
        } else {
            function_d2913e3e(localclientnum, "damage_heavy");
        }
        physicsexplosionsphere(localclientnum, self.origin, 400, 100, 2);
    }
}

// Namespace archetype_elephant/archetype_elephant
// Params 7, eflags: 0x0
// Checksum 0x71482dd1, Offset: 0x7e8
// Size: 0xd4
function function_490ae06a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    e_player = function_f97e7787(localclientnum);
    earthquake(localclientnum, 0.6, 1, self.origin, 4000);
    function_d2913e3e(localclientnum, "tank_fire");
    physicsexplosionsphere(localclientnum, self.origin, 2000, 100, 4);
}

// Namespace archetype_elephant/archetype_elephant
// Params 5, eflags: 0x0
// Checksum 0x4138e08, Offset: 0x8c8
// Size: 0x134
function function_374c03d4(localclientnum, pos, surface, notetrack, bone) {
    e_player = function_f97e7787(localclientnum);
    n_dist = distancesquared(pos, e_player.origin);
    var_cad97542 = 1200 * 1200;
    if (n_dist < var_cad97542) {
        earthquake(localclientnum, 0.1, 0.5, self.origin, n_dist);
        function_d2913e3e(localclientnum, "damage_light");
        if (isdefined(bone)) {
            origin = self gettagorigin(bone);
            physicsexplosionsphere(localclientnum, origin, 200, 20, 100);
        }
    }
}

// Namespace archetype_elephant/archetype_elephant
// Params 7, eflags: 0x0
// Checksum 0x2ef4ce1a, Offset: 0xa08
// Size: 0x94
function sndtowersbossarmor(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejum) {
    if (newval == 1) {
        setsoundcontext("supernicedude", "armor");
        return;
    }
    setsoundcontext("supernicedude", "");
}

