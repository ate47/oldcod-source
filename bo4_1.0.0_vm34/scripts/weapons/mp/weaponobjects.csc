#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace weaponobjects;

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x2
// Checksum 0x8aabc9ff, Offset: 0x118
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"weaponobjects", &__init__, undefined, undefined);
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x31606422, Offset: 0x160
// Size: 0x84
function __init__() {
    init_shared(sessionmodeiscampaigngame() ? #"rob_sonar_set_friendlyequip_cp" : #"rob_sonar_set_friendlyequip_mp", #"rob_sonar_set_enemyequip");
    level setupscriptmovercompassicons();
    level setupmissilecompassicons();
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x3d35b3b5, Offset: 0x1f0
// Size: 0x112
function setupscriptmovercompassicons() {
    if (!isdefined(level.scriptmovercompassicons)) {
        level.scriptmovercompassicons = [];
    }
    level.scriptmovercompassicons[#"wpn_t7_turret_emp_core"] = "compass_empcore_white";
    level.scriptmovercompassicons[#"t6_wpn_turret_ads_world"] = "compass_guardian_white";
    level.scriptmovercompassicons[#"veh_t7_drone_uav_enemy_vista"] = "compass_uav";
    level.scriptmovercompassicons[#"veh_t7_mil_vtol_fighter_mp"] = "compass_lightningstrike";
    level.scriptmovercompassicons[#"veh_t7_drone_rolling_thunder"] = "compass_lodestar";
    level.scriptmovercompassicons[#"veh_t7_drone_srv_blimp"] = "t7_hud_minimap_hatr";
}

// Namespace weaponobjects/weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xe7c02dcf, Offset: 0x310
// Size: 0x7a
function setupmissilecompassicons() {
    if (!isdefined(level.missilecompassicons)) {
        level.missilecompassicons = [];
    }
    if (isdefined(getweapon(#"drone_strike"))) {
        level.missilecompassicons[getweapon(#"drone_strike")] = "compass_lodestar";
    }
}

