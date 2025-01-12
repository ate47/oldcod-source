#using scripts\core_common\ai\archetype_brutus;
#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm;

#namespace zm_ai_brutus;

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 0, eflags: 0x2
// Checksum 0xbf63c128, Offset: 0x1e8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_ai_brutus", &__init__, undefined, undefined);
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 0, eflags: 0x0
// Checksum 0xa8ca2889, Offset: 0x230
// Size: 0x12c
function __init__() {
    clientfield::register("actor", "brutus_shock_attack", 1, 1, "counter", &brutus_shock_attack_fx, 0, 0);
    clientfield::register("actor", "brutus_spawn_clientfield", 1, 1, "int", &function_633be23b, 0, 0);
    clientfield::register("toplayer", "brutus_shock_attack_player", 1, 1, "counter", &brutus_shock_attack_player, 0, 0);
    footsteps::registeraitypefootstepcb("brutus", &function_8f9c7d5);
    ai::add_archetype_spawn_function("brutus", &function_9a61481c);
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 1, eflags: 0x0
// Checksum 0x6f0f1e1e, Offset: 0x368
// Size: 0x64
function function_9a61481c(localclientnum) {
    self._eyeglow_fx_override = "zm_ai/fx8_zombie_eye_glow_red";
    self._eyeglow_tag_override = "tag_eye";
    self zm::createzombieeyes(localclientnum);
    self callback::on_shutdown(&on_entity_shutdown);
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 1, eflags: 0x0
// Checksum 0xf6493f4c, Offset: 0x3d8
// Size: 0x2c
function on_entity_shutdown(localclientnum) {
    if (isdefined(self)) {
        self zm::deletezombieeyes(localclientnum);
    }
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 7, eflags: 0x0
// Checksum 0xf2634712, Offset: 0x410
// Size: 0x10c
function function_633be23b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        self.lightfx = util::playfxontag(localclientnum, "light/fx8_light_spot_brutus_flicker", self, "j_spineupper");
        playfx(localclientnum, "maps/zm_escape/fx8_alcatraz_brut_spawn", self.origin);
        return;
    }
    if (isdefined(self.lightfx)) {
        stopfx(localclientnum, self.lightfx);
    }
    playfx(localclientnum, "maps/zm_escape/fx8_alcatraz_brut_spawn", self.origin);
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 7, eflags: 0x0
// Checksum 0x82d6678c, Offset: 0x528
// Size: 0xdc
function brutus_shock_attack_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    playfx(localclientnum, "maps/zm_escape/fx8_alcatraz_brut_shock", self.origin, anglestoup(self.angles));
    earthquake(localclientnum, 1, 1, self.origin, self ai::function_a0dbf10a().var_3d56fc04);
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 7, eflags: 0x0
// Checksum 0x24426942, Offset: 0x610
// Size: 0x5c
function brutus_shock_attack_player(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    function_d2913e3e(localclientnum, "damage_heavy");
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 5, eflags: 0x0
// Checksum 0xacdf2a10, Offset: 0x678
// Size: 0x12e
function function_8f9c7d5(localclientnum, pos, surface, notetrack, bone) {
    a_players = getlocalplayers();
    for (i = 0; i < a_players.size; i++) {
        if (abs(self.origin[2] - a_players[i].origin[2]) < 128) {
            var_8dc0721d = a_players[i] getlocalclientnumber();
            if (isdefined(var_8dc0721d)) {
                earthquake(var_8dc0721d, 0.5, 0.1, self.origin, 1500);
                playrumbleonposition(var_8dc0721d, "brutus_footsteps", self.origin);
            }
        }
    }
}

