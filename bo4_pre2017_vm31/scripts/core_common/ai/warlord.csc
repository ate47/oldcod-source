#using scripts/core_common/ai_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/system_shared;

#namespace warlord;

// Namespace warlord/warlord
// Params 0, eflags: 0x2
// Checksum 0x69482f01, Offset: 0x3e0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("warlord", &__init__, undefined, undefined);
}

// Namespace warlord/warlord
// Params 0, eflags: 0x2
// Checksum 0x7d8d056c, Offset: 0x420
// Size: 0x102
function autoexec precache() {
    level._effect["fx_elec_warlord_damage_1"] = "electric/fx_elec_warlord_damage_1";
    level._effect["fx_elec_warlord_damage_2"] = "electric/fx_elec_warlord_damage_2";
    level._effect["fx_elec_warlord_lower_damage_1"] = "electric/fx_elec_warlord_lower_damage_1";
    level._effect["fx_elec_warlord_lower_damage_2"] = "electric/fx_elec_warlord_lower_damage_2";
    level._effect["fx_exp_warlord_death"] = "explosions/fx_exp_warlord_death";
    level._effect["fx_exhaust_jetpack_warlord_juke"] = "vehicle/fx_exhaust_jetpack_warlord_juke";
    level._effect["fx_light_eye_glow_warlord"] = "light/fx_light_eye_glow_warlord";
    level._effect["fx_light_body_glow_warlord"] = "light/fx_light_body_glow_warlord";
}

// Namespace warlord/warlord
// Params 0, eflags: 0x0
// Checksum 0xce98a93f, Offset: 0x530
// Size: 0x13c
function __init__() {
    if (ai::shouldregisterclientfieldforarchetype("warlord")) {
        clientfield::register("actor", "warlord_type", 1, 2, "int", &namespace_e95b29c8::function_6765fb9c, 0, 0);
        clientfield::register("actor", "warlord_damage_state", 1, 2, "int", &namespace_e95b29c8::function_695d7dee, 0, 0);
        clientfield::register("actor", "warlord_thruster_direction", 1, 3, "int", &namespace_e95b29c8::function_a4d15a01, 0, 0);
        clientfield::register("actor", "warlord_lights_state", 1, 1, "int", &namespace_e95b29c8::function_5620f99, 0, 0);
    }
}

#namespace namespace_e95b29c8;

// Namespace namespace_e95b29c8/warlord
// Params 7, eflags: 0x0
// Checksum 0xd9d70c8f, Offset: 0x678
// Size: 0x24e
function function_695d7dee(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (isdefined(entity.var_4154355f)) {
        stopfx(localclientnum, entity.var_4154355f);
        entity.var_4154355f = undefined;
    }
    if (isdefined(entity.var_c57c11b8)) {
        stopfx(localclientnum, entity.var_c57c11b8);
        entity.var_c57c11b8 = undefined;
    }
    switch (newvalue) {
    case 0:
        break;
    case 2:
        entity.var_c57c11b8 = playfxontag(localclientnum, level._effect["fx_elec_warlord_damage_2"], entity, "j_spine4");
        playfxontag(localclientnum, level._effect["fx_elec_warlord_lower_damage_2"], entity, "j_mainroot");
    case 1:
        entity.var_4154355f = playfxontag(localclientnum, level._effect["fx_elec_warlord_damage_1"], entity, "j_spine4");
        playfxontag(localclientnum, level._effect["fx_elec_warlord_lower_damage_1"], entity, "j_mainroot");
        break;
    case 3:
        playfxontag(localclientnum, level._effect["fx_exp_warlord_death"], entity, "j_spine4");
        break;
    }
}

// Namespace namespace_e95b29c8/warlord
// Params 7, eflags: 0x0
// Checksum 0xd51066b1, Offset: 0x8d0
// Size: 0x60
function function_6765fb9c(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    entity.warlordtype = newvalue;
}

// Namespace namespace_e95b29c8/warlord
// Params 7, eflags: 0x0
// Checksum 0x6da92180, Offset: 0x938
// Size: 0x25c
function function_a4d15a01(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (isdefined(entity.var_a8d008e0)) {
        assert(isarray(entity.var_a8d008e0));
        for (index = 0; index < entity.var_a8d008e0.size; index++) {
            stopfx(localclientnum, entity.var_a8d008e0[index]);
        }
    }
    entity.var_a8d008e0 = [];
    tags = [];
    switch (newvalue) {
    case 0:
        break;
    case 1:
        tags = array("tag_jets_left_front", "tag_jets_right_front");
        break;
    case 2:
        tags = array("tag_jets_left_back", "tag_jets_right_back");
        break;
    case 3:
        tags = array("tag_jets_left_side");
        break;
    case 4:
        tags = array("tag_jets_right_side");
        break;
    }
    for (index = 0; index < tags.size; index++) {
        entity.var_a8d008e0[entity.var_a8d008e0.size] = playfxontag(localclientnum, level._effect["fx_exhaust_jetpack_warlord_juke"], entity, tags[index]);
    }
}

// Namespace namespace_e95b29c8/warlord
// Params 7, eflags: 0x0
// Checksum 0xdb2c07bc, Offset: 0xba0
// Size: 0xcc
function function_5620f99(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (newvalue == 1) {
        playfxontag(localclientnum, level._effect["fx_light_eye_glow_warlord"], entity, "tag_eye");
        playfxontag(localclientnum, level._effect["fx_light_body_glow_warlord"], entity, "j_spine4");
    }
}
