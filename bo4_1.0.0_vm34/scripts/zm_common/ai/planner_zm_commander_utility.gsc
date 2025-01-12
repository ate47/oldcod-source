#using scripts\core_common\ai\planner_commander;
#using scripts\core_common\ai\planner_squad;
#using scripts\core_common\ai\strategic_command;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\planner;
#using scripts\core_common\ai\systems\planner_blackboard;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace planner_zm_commander_utility;

// Namespace planner_zm_commander_utility/planner_zm_commander_utility
// Params 0, eflags: 0x2
// Checksum 0xe3b09f6a, Offset: 0xf8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"planner_zm_commander_utility", &namespace_4e5b5b02::__init__, undefined, undefined);
}

#namespace namespace_4e5b5b02;

// Namespace namespace_4e5b5b02/planner_zm_commander_utility
// Params 0, eflags: 0x4
// Checksum 0x7195c2, Offset: 0x140
// Size: 0x154
function private __init__() {
    plannercommanderutility::registerutilityapi(#"commanderscoreage", &function_262087c);
    plannercommanderutility::registerdaemonapi(#"daemonzmaltars", &function_2d156392);
    plannercommanderutility::registerdaemonapi(#"daemonzmblockers", &function_42d1e374);
    plannercommanderutility::registerdaemonapi(#"daemonzmchests", &function_b7e57b17);
    plannercommanderutility::registerdaemonapi(#"daemonzmpowerups", &function_3749c73e);
    plannercommanderutility::registerdaemonapi(#"daemonzmswitches", &function_5f3f67a5);
    plannercommanderutility::registerdaemonapi(#"daemonzmwallbuys", &function_3d20faaa);
}

// Namespace namespace_4e5b5b02/planner_zm_commander_utility
// Params 1, eflags: 0x4
// Checksum 0xe1f04030, Offset: 0x2a0
// Size: 0x1ac
function private function_2d156392(commander) {
    altars = [];
    if (isarray(level.var_8b1c4f80)) {
        foreach (altar in level.var_8b1c4f80) {
            if (!isdefined(altar)) {
                continue;
            }
            var_4cabe57d = array();
            var_4cabe57d[#"origin"] = altar.origin;
            var_4cabe57d[#"type"] = altar.script_unitrigger_type;
            if (!isdefined(var_4cabe57d[#"__unsafe__"])) {
                var_4cabe57d[#"__unsafe__"] = array();
            }
            var_4cabe57d[#"__unsafe__"][#"altar"] = altar;
            altars[altars.size] = var_4cabe57d;
        }
    }
    blackboard::setstructblackboardattribute(commander, #"zm_altars", altars);
}

// Namespace namespace_4e5b5b02/planner_zm_commander_utility
// Params 1, eflags: 0x4
// Checksum 0x784f15ac, Offset: 0x458
// Size: 0x2dc
function private function_42d1e374(commander) {
    blockers = [];
    var_506fa6fc = array("zombie_door", "zombie_airlock_buy", "zombie_debris");
    foreach (var_9c858d3d in var_506fa6fc) {
        doorblockers = getentarray(var_9c858d3d, "targetname");
        foreach (doorblocker in doorblockers) {
            var_356b404f = array();
            if (isdefined(doorblocker.purchaser)) {
                continue;
            }
            if (doorblocker._door_open === 1 || doorblocker.has_been_opened === 1) {
                continue;
            }
            if (isdefined(doorblocker.script_noteworthy)) {
                switch (doorblocker.script_noteworthy) {
                case #"electric_door":
                case #"local_electric_door":
                case #"electric_buyable_door":
                    continue;
                }
            }
            var_356b404f[#"cost"] = doorblocker.zombie_cost;
            var_356b404f[#"origin"] = doorblocker.origin;
            if (!isdefined(var_356b404f[#"__unsafe__"])) {
                var_356b404f[#"__unsafe__"] = array();
            }
            var_356b404f[#"__unsafe__"][#"blocker"] = doorblocker;
            blockers[blockers.size] = var_356b404f;
        }
    }
    blackboard::setstructblackboardattribute(commander, #"zm_blockers", blockers);
}

// Namespace namespace_4e5b5b02/planner_zm_commander_utility
// Params 1, eflags: 0x4
// Checksum 0x6803e4a1, Offset: 0x740
// Size: 0x1fc
function private function_b7e57b17(commander) {
    chests = [];
    if (isarray(level.chests)) {
        foreach (chest in level.chests) {
            if (!isdefined(chest)) {
                continue;
            }
            if (isdefined(chest.hidden) && chest.hidden) {
                continue;
            }
            var_e9feafe2 = array();
            var_e9feafe2[#"origin"] = chest.unitrigger_stub.origin;
            var_e9feafe2[#"cost"] = chest.zombie_cost;
            var_e9feafe2[#"type"] = chest.unitrigger_stub.script_unitrigger_type;
            if (!isdefined(var_e9feafe2[#"__unsafe__"])) {
                var_e9feafe2[#"__unsafe__"] = array();
            }
            var_e9feafe2[#"__unsafe__"][#"chest"] = chest;
            chests[chests.size] = var_e9feafe2;
        }
    }
    blackboard::setstructblackboardattribute(commander, #"zm_chests", chests);
}

// Namespace namespace_4e5b5b02/planner_zm_commander_utility
// Params 1, eflags: 0x4
// Checksum 0x7e3366bd, Offset: 0x948
// Size: 0x1ac
function private function_3749c73e(commander) {
    powerups = [];
    if (isarray(level.active_powerups)) {
        foreach (powerup in level.active_powerups) {
            if (!isdefined(powerup)) {
                continue;
            }
            if (powerup.powerup_name == #"nuke") {
                continue;
            }
            var_ca95c9e1 = array();
            var_ca95c9e1[#"type"] = powerup.powerup_name;
            if (!isdefined(var_ca95c9e1[#"__unsafe__"])) {
                var_ca95c9e1[#"__unsafe__"] = array();
            }
            var_ca95c9e1[#"__unsafe__"][#"powerup"] = powerup;
            powerups[powerups.size] = var_ca95c9e1;
        }
    }
    blackboard::setstructblackboardattribute(commander, #"zm_powerups", powerups);
}

// Namespace namespace_4e5b5b02/planner_zm_commander_utility
// Params 1, eflags: 0x4
// Checksum 0xe7da9530, Offset: 0xb00
// Size: 0x1cc
function private function_5f3f67a5(commander) {
    switches = [];
    switchents = getentarray("use_elec_switch", "targetname");
    if (isarray(switchents)) {
        foreach (switchent in switchents) {
            if (!isdefined(switchent)) {
                continue;
            }
            var_2b019963 = array();
            var_2b019963[#"origin"] = switchent.origin;
            var_2b019963[#"cost"] = switchent.zombie_cost;
            if (!isdefined(var_2b019963[#"__unsafe__"])) {
                var_2b019963[#"__unsafe__"] = array();
            }
            var_2b019963[#"__unsafe__"][#"switch"] = switchent;
            switches[switches.size] = var_2b019963;
        }
    }
    blackboard::setstructblackboardattribute(commander, #"zm_switches", switches);
}

// Namespace namespace_4e5b5b02/planner_zm_commander_utility
// Params 1, eflags: 0x4
// Checksum 0xc3d07d1e, Offset: 0xcd8
// Size: 0x2fc
function private function_3d20faaa(commander) {
    wallbuys = [];
    if (isarray(level._spawned_wallbuys)) {
        foreach (wallbuy in level._spawned_wallbuys) {
            if (!isdefined(wallbuy.trigger_stub)) {
                continue;
            }
            if (wallbuy.weapon.type === "melee") {
                continue;
            }
            var_ebd9b3c1 = array();
            var_ebd9b3c1[#"weapon"] = wallbuy.weapon;
            var_ebd9b3c1[#"origin"] = wallbuy.trigger_stub.origin;
            var_ebd9b3c1[#"height"] = wallbuy.trigger_stub.script_height;
            var_ebd9b3c1[#"length"] = wallbuy.trigger_stub.script_length;
            var_ebd9b3c1[#"width"] = wallbuy.trigger_stub.script_width;
            var_ebd9b3c1[#"type"] = wallbuy.trigger_stub.script_unitrigger_type;
            zombieweapon = level.zombie_weapons[wallbuy.weapon];
            var_ebd9b3c1[#"ammo_cost"] = zombieweapon.ammo_cost;
            var_ebd9b3c1[#"cost"] = zombieweapon.cost;
            var_ebd9b3c1[#"upgrade_weapon"] = zombieweapon.upgrade;
            if (!isdefined(var_ebd9b3c1[#"__unsafe__"])) {
                var_ebd9b3c1[#"__unsafe__"] = array();
            }
            var_ebd9b3c1[#"__unsafe__"][#"wallbuy"] = wallbuy;
            wallbuys[wallbuys.size] = var_ebd9b3c1;
        }
    }
    blackboard::setstructblackboardattribute(commander, #"zm_wallbuys", wallbuys);
}

// Namespace namespace_4e5b5b02/planner_zm_commander_utility
// Params 3, eflags: 0x4
// Checksum 0x9c0b6e00, Offset: 0xfe0
// Size: 0x9a
function private function_262087c(commander, squad, constants) {
    assert(isdefined(constants[#"maxage"]), "<dev string:x30>" + "<invalid>" + "<dev string:x67>");
    if (gettime() > squad.createtime + constants[#"maxage"]) {
        return false;
    }
    return true;
}

