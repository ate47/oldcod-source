#using scripts/core_common/ai/systems/fx_character;
#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/ai_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace archetype_robot;

// Namespace archetype_robot/archetype_robot
// Params 0, eflags: 0x2
// Checksum 0xa9bd0e6a, Offset: 0x2e0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("robot", &__init__, undefined, undefined);
}

// Namespace archetype_robot/archetype_robot
// Params 0, eflags: 0x2
// Checksum 0x7a3eeb52, Offset: 0x320
// Size: 0x42
function autoexec precache() {
    level._effect["fx_ability_elec_surge_short_robot"] = "electric/fx_ability_elec_surge_short_robot";
    level._effect["fx_exp_robot_stage3_evb"] = "explosions/fx_exp_robot_stage3_evb";
}

// Namespace archetype_robot/archetype_robot
// Params 0, eflags: 0x0
// Checksum 0xcd3f3589, Offset: 0x370
// Size: 0x164
function __init__() {
    if (ai::shouldregisterclientfieldforarchetype("robot")) {
        clientfield::register("actor", "robot_mind_control", 1, 2, "int", &robotclientutils::robotmindcontrolhandler, 0, 1);
        clientfield::register("actor", "robot_mind_control_explosion", 1, 1, "int", &robotclientutils::robotmindcontrolexplosionhandler, 0, 0);
        clientfield::register("actor", "robot_lights", 1, 3, "int", &robotclientutils::robotlightshandler, 0, 0);
        clientfield::register("actor", "robot_EMP", 1, 1, "int", &robotclientutils::robotemphandler, 0, 0);
    }
    ai::add_archetype_spawn_function("robot", &robotclientutils::robotsoldierspawnsetup);
}

#namespace robotclientutils;

// Namespace robotclientutils/archetype_robot
// Params 1, eflags: 0x4
// Checksum 0x829260ab, Offset: 0x4e0
// Size: 0x1c
function private robotsoldierspawnsetup(localclientnum) {
    entity = self;
}

// Namespace robotclientutils/archetype_robot
// Params 4, eflags: 0x4
// Checksum 0xf8aa9fe, Offset: 0x508
// Size: 0x346
function private robotlighting(localclientnum, entity, flicker, mindcontrolstate) {
    switch (mindcontrolstate) {
    case 0:
        entity tmodeclearflag(0);
        if (flicker) {
            fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef3);
        } else {
            fxclientutils::playfxbundle(localclientnum, entity, entity.fxdef);
        }
        break;
    case 1:
        entity tmodeclearflag(0);
        fxclientutils::stopallfxbundles(localclientnum, entity);
        if (flicker) {
            fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef4);
        } else {
            fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef1);
        }
        if (!gibclientutils::isgibbed(localclientnum, entity, 8)) {
            entity playsound(localclientnum, "fly_bot_ctrl_lvl_01_start", entity.origin);
        }
        break;
    case 2:
        entity tmodesetflag(0);
        fxclientutils::stopallfxbundles(localclientnum, entity);
        if (flicker) {
            fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef4);
        } else {
            fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef1);
        }
        if (!gibclientutils::isgibbed(localclientnum, entity, 8)) {
            entity playsound(localclientnum, "fly_bot_ctrl_lvl_02_start", entity.origin);
        }
        break;
    case 3:
        entity tmodesetflag(0);
        fxclientutils::stopallfxbundles(localclientnum, entity);
        if (flicker) {
            fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef5);
        } else {
            fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef2);
        }
        entity playsound(localclientnum, "fly_bot_ctrl_lvl_03_start", entity.origin);
        break;
    }
}

// Namespace robotclientutils/archetype_robot
// Params 7, eflags: 0x4
// Checksum 0x505893f9, Offset: 0x858
// Size: 0x164
function private robotlightshandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (isdefined(entity.archetype) && (!isdefined(entity) || !entity isai() || entity.archetype != "robot")) {
        return;
    }
    fxclientutils::stopallfxbundles(localclientnum, entity);
    flicker = newvalue == 1;
    if (newvalue == 0 || newvalue == 3 || flicker) {
        robotlighting(localclientnum, entity, flicker, clientfield::get("robot_mind_control"));
        return;
    }
    if (newvalue == 4) {
        fxclientutils::playfxbundle(localclientnum, entity, entity.deathfxdef);
    }
}

// Namespace robotclientutils/archetype_robot
// Params 7, eflags: 0x4
// Checksum 0x9ede94bf, Offset: 0x9c8
// Size: 0x142
function private robotemphandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (isdefined(entity.archetype) && (!isdefined(entity) || !entity isai() || entity.archetype != "robot")) {
        return;
    }
    if (isdefined(entity.empfx)) {
        stopfx(localclientnum, entity.empfx);
    }
    switch (newvalue) {
    case 0:
        break;
    case 1:
        entity.empfx = playfxontag(localclientnum, level._effect["fx_ability_elec_surge_short_robot"], entity, "j_spine4");
        break;
    }
}

// Namespace robotclientutils/archetype_robot
// Params 7, eflags: 0x4
// Checksum 0xe0214311, Offset: 0xb18
// Size: 0x114
function private robotmindcontrolhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (isdefined(entity.archetype) && (!isdefined(entity) || !entity isai() || entity.archetype != "robot")) {
        return;
    }
    lights = clientfield::get("robot_lights");
    flicker = lights == 1;
    if (lights == 0 || flicker) {
        robotlighting(localclientnum, entity, flicker, newvalue);
    }
}

// Namespace robotclientutils/archetype_robot
// Params 7, eflags: 0x0
// Checksum 0x3f121fb5, Offset: 0xc38
// Size: 0x102
function robotmindcontrolexplosionhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (isdefined(entity.archetype) && (!isdefined(entity) || !entity isai() || entity.archetype != "robot")) {
        return;
    }
    switch (newvalue) {
    case 1:
        entity.explosionfx = playfxontag(localclientnum, level._effect["fx_exp_robot_stage3_evb"], entity, "j_spineupper");
        break;
    }
}
