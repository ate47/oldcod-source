#using script_52d2de9b438adc78;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\entityheadicons_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\ai_tank_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\emp_shared;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\mp\killstreak_weapons;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\weapons\hacker_tool;
#using scripts\weapons\heatseekingmissile;
#using scripts\weapons\smokegrenade;
#using scripts\weapons\tacticalinsertion;
#using scripts\weapons\weaponobjects;
#using scripts\weapons\weapons;

#namespace supplydrop;

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x2
// Checksum 0x1637aeb3, Offset: 0x670
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"supplydrop", &__init__, undefined, #"killstreaks");
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0x2a9f5da4, Offset: 0x6c0
// Size: 0x53c
function __init__() {
    level.cratemodelfriendly = #"p8_care_package_01_a";
    level.cratemodelenemy = #"p8_care_package_02_a";
    level.cratemodeltank = #"wpn_t7_drop_box";
    level.cratemodelboobytrapped = #"p8_care_package_03_a";
    level.vtoldrophelicoptervehicleinfo = "vehicle_t8_mil_helicopter_transport_mp";
    ir_strobe::init_shared();
    level.crateownerusetime = 500;
    level.cratenonownerusetime = int(getgametypesetting(#"cratecapturetime") * 1000);
    level.supplydropdisarmcrate = #"hash_20071ab3686e8d58";
    clientfield::register("vehicle", "supplydrop_care_package_state", 1, 1, "int");
    clientfield::register("vehicle", "supplydrop_ai_tank_state", 1, 1, "int");
    clientfield::register("scriptmover", "supplydrop_thrusters_state", 1, 1, "int");
    clientfield::register("scriptmover", "aitank_thrusters_state", 1, 1, "int");
    level._supply_drop_smoke_fx = "_t7/killstreaks/fx_supply_drop_smoke";
    level._supply_drop_explosion_fx = "explosions/fx_exp_grenade_default";
    killstreaks::register_killstreak("killstreak_supply_drop", &usekillstreaksupplydrop);
    killstreaks::allow_assists("supply_drop", 1);
    killstreak_bundles::register_killstreak_bundle("supply_drop_ai_tank");
    killstreak_bundles::register_killstreak_bundle("supply_drop_combat_robot");
    level.cratetypes = [];
    level.categorytypeweight = [];
    ir_strobe::function_aede4f7c(#"supplydrop_marker", &function_5795ee49);
    function_980195fb("uav", 140, 95);
    function_980195fb("recon_car", 140, 75);
    function_980195fb("counteruav", 115, 85);
    function_980195fb("remote_missile", 115, 100);
    function_980195fb("planemortar", 95, 80);
    function_980195fb("ultimate_turret", 105, 100);
    function_980195fb("helicopter_comlink", 55, 45);
    function_980195fb("straferun", 35, 35);
    function_980195fb("swat_team", 35, 35);
    function_980195fb("ac130", 25, 10);
    function_980195fb("tank_robot", 45, 40);
    function_b61dce70("inventory_tank_robot", "killstreak", "tank_robot", 75, #"hash_6f13430dac318d3b", undefined, undefined, &ai_tank::crateland);
    function_b61dce70("tank_robot", "killstreak", "tank_robot", 75, #"hash_6f13430dac318d3b", undefined, undefined, &ai_tank::crateland);
    level.cratecategoryweights = [];
    level.cratecategorytypeweights = [];
    foreach (categorykey, category in level.cratetypes) {
        finalizecratecategory(categorykey);
    }
    /#
        level thread supply_drop_dev_gui();
    #/
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0xc0b2e774, Offset: 0xc08
// Size: 0x124
function finalizecratecategory(category) {
    level.cratecategoryweights[category] = 0;
    cratetypekeys = getarraykeys(level.cratetypes[category]);
    for (cratetype = 0; cratetype < cratetypekeys.size; cratetype++) {
        typekey = cratetypekeys[cratetype];
        level.cratetypes[category][typekey].previousweight = level.cratecategoryweights[category];
        level.cratecategoryweights[category] = level.cratecategoryweights[category] + level.cratetypes[category][typekey].weight;
        level.cratetypes[category][typekey].weight = level.cratecategoryweights[category];
    }
}

// Namespace supplydrop/supplydrop
// Params 3, eflags: 0x0
// Checksum 0xc187440f, Offset: 0xd38
// Size: 0x26a
function setcategorytypeweight(category, type, weight) {
    if (!isdefined(level.categorytypeweight[category])) {
        level.categorytypeweight[category] = [];
    }
    level.categorytypeweight[category][type] = spawnstruct();
    level.categorytypeweight[category][type].weight = weight;
    count = 0;
    totalweight = 0;
    startindex = undefined;
    finalindex = undefined;
    cratenamekeys = getarraykeys(level.cratetypes[category]);
    for (cratename = 0; cratename < cratenamekeys.size; cratename++) {
        namekey = cratenamekeys[cratename];
        if (level.cratetypes[category][namekey].type == type) {
            count++;
            totalweight += level.cratetypes[category][namekey].weight;
            if (!isdefined(startindex)) {
                startindex = cratename;
            }
            if (isdefined(finalindex) && finalindex + 1 != cratename) {
                /#
                    util::error("<dev string:x30>");
                #/
                callback::abort_level();
                return;
            }
            finalindex = cratename;
        }
    }
    level.categorytypeweight[category][type].totalcrateweight = totalweight;
    level.categorytypeweight[category][type].cratecount = count;
    level.categorytypeweight[category][type].startindex = startindex;
    level.categorytypeweight[category][type].finalindex = finalindex;
}

// Namespace supplydrop/supplydrop
// Params 5, eflags: 0x0
// Checksum 0x24e9d1b, Offset: 0xfb0
// Size: 0xec
function function_980195fb(name, weight, var_5aaf6d56, hint, hint_gambler) {
    function_b61dce70("supplydrop", "killstreak", name, weight, hint, hint_gambler, &givecratekillstreak);
    function_b61dce70("inventory_supplydrop", "killstreak", name, weight, hint, hint_gambler, &givecratekillstreak);
    function_b61dce70("gambler", "killstreak", name, var_5aaf6d56, hint, hint_gambler, &givecratekillstreak);
}

// Namespace supplydrop/supplydrop
// Params 8, eflags: 0x0
// Checksum 0x9b03d936, Offset: 0x10a8
// Size: 0x1aa
function function_b61dce70(category, type, name, weight, hint, hint_gambler, givefunction, landfunctionoverride) {
    if (!isdefined(level.cratetypes[category])) {
        level.cratetypes[category] = [];
    }
    if (isitemrestricted(name)) {
        return;
    }
    if (isdefined(level.killstreaks[name])) {
        bundle = level.killstreakbundle[name];
        hint = bundle.var_aeedfc31;
        hint_gambler = bundle.var_3d3d7227;
    }
    cratetype = spawnstruct();
    cratetype.type = type;
    cratetype.name = name;
    cratetype.weight = weight;
    cratetype.hint = hint;
    cratetype.hint_gambler = hint_gambler;
    cratetype.givefunction = givefunction;
    if (isdefined(landfunctionoverride)) {
        cratetype.landfunctionoverride = landfunctionoverride;
    }
    level.cratetypes[category][name] = cratetype;
    game.strings[name + "_hint"] = hint;
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0x78ec8e8, Offset: 0x1260
// Size: 0x3c2
function getrandomcratetype(category, gambler_crate_name) {
    if (!isdefined(level.cratetypes) || !isdefined(level.cratetypes[category])) {
        return;
    }
    assert(isdefined(level.cratetypes));
    assert(isdefined(level.cratetypes[category]));
    assert(isdefined(level.cratecategoryweights[category]));
    typekey = undefined;
    cratetypestart = 0;
    randomweightend = randomintrange(1, level.cratecategoryweights[category] + 1);
    find_another = 0;
    cratenamekeys = getarraykeys(level.cratetypes[category]);
    if (isdefined(level.categorytypeweight[category])) {
        randomweightend = randomint(level.cratecategorytypeweights[category]) + 1;
        cratetypekeys = getarraykeys(level.categorytypeweight[category]);
        for (cratetype = 0; cratetype < cratetypekeys.size; cratetype++) {
            typekey = cratetypekeys[cratetype];
            if (level.categorytypeweight[category][typekey].weight < randomweightend) {
                continue;
            }
            cratetypestart = level.categorytypeweight[category][typekey].startindex;
            randomweightend = randomint(level.categorytypeweight[category][typekey].totalcrateweight) + 1;
            randomweightend += level.cratetypes[category][cratenamekeys[cratetypestart]].previousweight;
            break;
        }
    }
    for (cratetype = cratetypestart; cratetype < cratenamekeys.size; cratetype++) {
        typekey = cratenamekeys[cratetype];
        if (level.cratetypes[category][typekey].weight < randomweightend) {
            continue;
        }
        if (isdefined(gambler_crate_name) && level.cratetypes[category][typekey].name == gambler_crate_name) {
            find_another = 1;
        }
        if (find_another) {
            if (cratetype < cratenamekeys.size - 1) {
                cratetype++;
            } else if (cratetype > 0) {
                cratetype--;
            }
            typekey = cratenamekeys[cratetype];
        }
        break;
    }
    /#
        if (isdefined(level.dev_gui_supply_drop) && level.dev_gui_supply_drop != "<dev string:x5a>" && level.dev_gui_supply_drop != "<dev string:x61>") {
            typekey = level.dev_gui_supply_drop;
        }
    #/
    return level.cratetypes[category][typekey];
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0xcce10028, Offset: 0x1630
// Size: 0xba
function givecrateitem(crate) {
    if (!isalive(self) || !isdefined(crate.cratetype)) {
        return;
    }
    assert(isdefined(crate.cratetype.givefunction), "<dev string:x62>" + crate.cratetype.name);
    return [[ crate.cratetype.givefunction ]]("inventory_" + crate.cratetype.name);
}

// Namespace supplydrop/supplydrop
// Params 3, eflags: 0x0
// Checksum 0x5126f957, Offset: 0x16f8
// Size: 0x76
function givecratekillstreakwaiter(event, removecrate, extraendon) {
    self endon(#"give_crate_killstreak_done");
    if (isdefined(extraendon)) {
        self endon(extraendon);
    }
    self waittill(event);
    self notify(#"give_crate_killstreak_done", {#is_remove:removecrate});
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0xbd509a91, Offset: 0x1778
// Size: 0x24
function givecratekillstreak(killstreak) {
    self killstreaks::give(killstreak);
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0xbe5844d0, Offset: 0x17a8
// Size: 0x1f2
function givespecializedcrateweapon(weapon) {
    switch (weapon.name) {
    case #"minigun":
        level thread popups::displayteammessagetoall(#"hash_3b566d06e5a482e1", self);
        level weapons::add_limited_weapon(weapon, self, 3);
        break;
    case #"m32":
        level thread popups::displayteammessagetoall(#"hash_25ae9096a4ce050c", self);
        level weapons::add_limited_weapon(weapon, self, 3);
        break;
    case #"m202_flash":
        level thread popups::displayteammessagetoall(#"hash_63592826ae4e477a", self);
        level weapons::add_limited_weapon(weapon, self, 3);
        break;
    case #"m220_tow":
        level thread popups::displayteammessagetoall(#"hash_51751eb890739762", self);
        level weapons::add_limited_weapon(weapon, self, 3);
        break;
    case #"mp40_blinged":
        level thread popups::displayteammessagetoall(#"killstreak_mp40_inbound", self);
        level weapons::add_limited_weapon(weapon, self, 3);
        break;
    default:
        break;
    }
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0xfa46be11, Offset: 0x19a8
// Size: 0x1d8
function givecrateweapon(weapon_name) {
    weapon = getweapon(weapon_name);
    if (weapon == level.weaponnone) {
        return;
    }
    currentweapon = self getcurrentweapon();
    if (currentweapon == weapon || self hasweapon(weapon)) {
        self givemaxammo(weapon);
        return 1;
    }
    if (currentweapon.issupplydropweapon || isdefined(level.grenade_array[currentweapon]) || isdefined(level.inventory_array[currentweapon])) {
        self takeweapon(self.lastdroppableweapon);
        self giveweapon(weapon);
        self switchtoweapon(weapon);
        return 1;
    }
    self stats::function_4f10b697(weapon, #"used", 1);
    givespecializedcrateweapon(weapon);
    self giveweapon(weapon);
    self switchtoweapon(weapon);
    self waittill(#"weapon_change");
    self killstreak_weapons::usekillstreakweaponfromcrate(weapon);
    return 1;
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0x9da27f26, Offset: 0x1b88
// Size: 0x234
function usesupplydropmarker(package_contents_id, context) {
    player = self;
    self endon(#"disconnect");
    self endon(#"spawned_player");
    supplydropweapon = level.weaponnone;
    currentweapon = self getcurrentweapon();
    prevweapon = currentweapon;
    if (currentweapon.issupplydropweapon) {
        supplydropweapon = currentweapon;
    }
    if (supplydropweapon.isgrenadeweapon) {
        trigger_event = "grenade_fire";
    } else {
        trigger_event = "weapon_fired";
    }
    trigger_event = "none";
    self thread supplydropwatcher(package_contents_id, trigger_event, supplydropweapon, context);
    self.supplygrenadedeathdrop = 0;
    while (true) {
        player allowmelee(0);
        notifystring = self waittill(#"weapon_change", trigger_event, #"disconnect", #"spawned_player");
        player allowmelee(1);
        if (trigger_event != "none") {
            if (notifystring._notify != trigger_event) {
                cleanup(context, player);
                return false;
            }
        }
        if (isdefined(player.markerposition)) {
            break;
        }
    }
    self notify(#"trigger_weapon_shutdown");
    if (supplydropweapon == level.weaponnone) {
        cleanup(context, player);
        return false;
    }
    return true;
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x906d28e8, Offset: 0x1dc8
// Size: 0x4c
function issupplydropgrenadeallowed(killstreak) {
    if (!self killstreakrules::iskillstreakallowed(killstreak, self.team)) {
        self killstreaks::switch_to_last_non_killstreak_weapon();
        return false;
    }
    return true;
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0xa6eb54cd, Offset: 0x1e20
// Size: 0x2a
function adddroplocation(killstreak_id, location) {
    level.droplocations[killstreak_id] = location;
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x13c426b6, Offset: 0x1e58
// Size: 0x1c
function deldroplocation(killstreak_id) {
    level.droplocations[killstreak_id] = undefined;
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0x7f166cea, Offset: 0x1e80
// Size: 0x236
function function_cff5746f(location, context) {
    foreach (droplocation in level.droplocations) {
        if (distance2dsquared(droplocation, location) < 3600) {
            return false;
        }
    }
    if (context.perform_physics_trace === 1) {
        mask = 1;
        if (isdefined(context.tracemask)) {
            mask = context.tracemask;
        }
        radius = context.radius;
        trace = physicstrace(location + (0, 0, 5000), location + (0, 0, 10), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);
        if (trace[#"fraction"] < 1) {
            if (!(isdefined(level.var_25b256f9) && level.var_25b256f9)) {
                return false;
            }
        }
    }
    result = function_cfee2a04(location + (0, 0, 100), 170);
    if (!isdefined(result)) {
        return false;
    }
    if (context.check_same_floor === 1 && abs(location[2] - self.origin[2]) > 96) {
        return false;
    }
    return true;
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0xe5b7cdb5, Offset: 0x20c0
// Size: 0x4a0
function islocationgood(location, context) {
    if (getdvarint(#"hash_458cd0a10d30cedb", 1)) {
        return function_cff5746f(location, context);
    }
    foreach (droplocation in level.droplocations) {
        if (distance2dsquared(droplocation, location) < 3600) {
            return 0;
        }
    }
    if (context.perform_physics_trace === 1) {
        mask = 1;
        if (isdefined(context.tracemask)) {
            mask = context.tracemask;
        }
        radius = context.radius;
        trace = physicstrace(location + (0, 0, 5000), location + (0, 0, 10), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);
        if (trace[#"fraction"] < 1) {
            /#
                if (getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
                    sphere(location, radius, (1, 0, 0), 1, 1, 10, 1);
                }
            #/
            return 0;
        } else {
            /#
                if (getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
                    sphere(location, radius, (0, 0, 1), 1, 1, 10, 1);
                }
            #/
        }
    }
    closestpoint = getclosestpointonnavmesh(location, max(context.max_dist_from_location, 24), context.dist_from_boundary);
    isvalidpoint = isdefined(closestpoint);
    if (isvalidpoint && context.check_same_floor === 1 && abs(location[2] - closestpoint[2]) > 96) {
        isvalidpoint = 0;
    }
    if (isvalidpoint && distance2dsquared(location, closestpoint) > context.max_dist_from_location * context.max_dist_from_location) {
        isvalidpoint = 0;
    }
    /#
        if (getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
            if (!isvalidpoint) {
                otherclosestpoint = getclosestpointonnavmesh(location, getdvarfloat(#"scr_supply_drop_valid_location_radius_debug", 96), context.dist_from_boundary);
                if (isdefined(otherclosestpoint)) {
                    sphere(otherclosestpoint, context.max_dist_from_location, (1, 0, 0), 0.8, 0, 20, 1);
                }
            } else {
                sphere(closestpoint, context.max_dist_from_location, (0, 1, 0), 0.8, 0, 20, 1);
                util::drawcylinder(closestpoint, context.radius, 8000, 0.0166667, undefined, (0, 0.9, 0), 0.7);
            }
        }
    #/
    return isvalidpoint;
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x5d2f7745, Offset: 0x2568
// Size: 0x152
function usekillstreaksupplydrop(killstreak) {
    player = self;
    if (!player issupplydropgrenadeallowed(killstreak)) {
        return 0;
    }
    context = spawnstruct();
    context.radius = level.killstreakcorebundle.ksairdropaitankradius;
    context.dist_from_boundary = 50;
    context.max_dist_from_location = 16;
    context.perform_physics_trace = 1;
    context.islocationgood = &islocationgood;
    context.killstreakref = killstreak;
    context.validlocationsound = level.killstreakcorebundle.ksvalidcarepackagelocationsound;
    context.tracemask = 1 | 4;
    context.droptag = "tag_cargo_attach";
    context.var_b9e1781a = 1;
    context.killstreaktype = #"supplydrop_marker";
    return self ir_strobe::function_7707d9be(undefined, context);
}

// Namespace supplydrop/supplydrop
// Params 3, eflags: 0x0
// Checksum 0xb852232f, Offset: 0x26c8
// Size: 0x8c
function spawn_supplydrop(owner, context, origin) {
    location = spawnstruct();
    location.origin = origin;
    owner clientfield::set_player_uimodel("hudItems.tankState", 1);
    owner airsupport::function_4293d951(location, &supplydropwatcher);
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x30ce8088, Offset: 0x2760
// Size: 0x1e0
function use_killstreak_death_machine(killstreak) {
    if (!self killstreakrules::iskillstreakallowed(killstreak, self.team)) {
        return false;
    }
    weapon = getweapon(#"minigun");
    currentweapon = self getcurrentweapon();
    if (currentweapon.issupplydropweapon || isdefined(level.grenade_array[currentweapon]) || isdefined(level.inventory_array[currentweapon])) {
        self takeweapon(self.lastdroppableweapon);
        self giveweapon(weapon);
        self switchtoweapon(weapon);
        self setblockweaponpickup(weapon, 1);
        return true;
    }
    level thread popups::displayteammessagetoall(#"hash_3b566d06e5a482e1", self);
    level weapons::add_limited_weapon(weapon, self, 3);
    self takeweapon(currentweapon);
    self giveweapon(weapon);
    self switchtoweapon(weapon);
    self setblockweaponpickup(weapon, 1);
    return true;
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x626df0a9, Offset: 0x2948
// Size: 0x1e0
function use_killstreak_grim_reaper(killstreak) {
    if (!self killstreakrules::iskillstreakallowed(killstreak, self.team)) {
        return false;
    }
    weapon = getweapon(#"m202_flash");
    currentweapon = self getcurrentweapon();
    if (currentweapon.issupplydropweapon || isdefined(level.grenade_array[currentweapon]) || isdefined(level.inventory_array[currentweapon])) {
        self takeweapon(self.lastdroppableweapon);
        self giveweapon(weapon);
        self switchtoweapon(weapon);
        self setblockweaponpickup(weapon, 1);
        return true;
    }
    level thread popups::displayteammessagetoall(#"hash_63592826ae4e477a", self);
    level weapons::add_limited_weapon(weapon, self, 3);
    self takeweapon(currentweapon);
    self giveweapon(weapon);
    self switchtoweapon(weapon);
    self setblockweaponpickup(weapon, 1);
    return true;
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0xe2c415b4, Offset: 0x2b30
// Size: 0xde
function cleanupwatcherondeath(team, killstreak_id) {
    player = self;
    self endon(#"disconnect", #"supplydropwatcher", #"trigger_weapon_shutdown", #"spawned_player", #"weapon_change");
    self waittill(#"death", #"joined_team", #"joined_spectators");
    killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
    self notify(#"cleanup_marker");
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0x65f3ded5, Offset: 0x2c18
// Size: 0xdc
function cleanup(context, player) {
    if (isdefined(context) && isdefined(context.marker)) {
        context.marker delete();
        context.marker = undefined;
        if (isdefined(context.markerfxhandle)) {
            context.markerfxhandle delete();
            context.markerfxhandle = undefined;
        }
        if (isdefined(player)) {
            player clientfield::set_to_player("marker_state", 0);
        }
    }
    if (isdefined(context.killstreak_id)) {
        deldroplocation(context.killstreak_id);
    }
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0xd4358e46, Offset: 0x2d00
// Size: 0x33e
function markerupdatethread(context) {
    player = self;
    player endon(#"supplydropwatcher", #"spawned_player", #"disconnect", #"weapon_change", #"death");
    markermodel = spawn("script_model", (0, 0, 0));
    context.marker = markermodel;
    player thread markercleanupthread(context);
    while (true) {
        if (player flagsys::get(#"marking_done")) {
            break;
        }
        minrange = level.killstreakcorebundle.ksminairdroptargetrange;
        maxrange = level.killstreakcorebundle.ksmaxairdroptargetrange;
        forwardvector = vectorscale(anglestoforward(player getplayerangles()), maxrange);
        mask = 1;
        if (isdefined(context.tracemask)) {
            mask = context.tracemask;
        }
        radius = 2;
        results = physicstrace(player geteye(), player geteye() + forwardvector, (radius * -1, radius * -1, 0), (radius, radius, 0), player, mask);
        markermodel.origin = results[#"position"];
        tooclose = distancesquared(markermodel.origin, player.origin) < minrange * minrange;
        if (results[#"normal"][2] > 0.7 && !tooclose && isdefined(context.islocationgood) && [[ context.islocationgood ]](markermodel.origin, context)) {
            player.markerposition = markermodel.origin;
            player clientfield::set_to_player("marker_state", 1);
        } else {
            player.markerposition = undefined;
            player clientfield::set_to_player("marker_state", 2);
        }
        waitframe(1);
    }
}

// Namespace supplydrop/supplydrop
// Params 3, eflags: 0x0
// Checksum 0xa5445e4, Offset: 0x3048
// Size: 0x15c
function function_5795ee49(owner, context, location) {
    team = self.team;
    killstreak_id = self killstreakrules::killstreakstart("supply_drop", team, 0, 1);
    if (killstreak_id == -1) {
        return 0;
    }
    bundle = struct::get_script_bundle("killstreak", "killstreak_supply_drop");
    killstreak = killstreaks::get_killstreak_for_weapon(bundle.ksweapon);
    context.selectedlocation = location;
    context.killstreak_id = killstreak_id;
    self thread helidelivercrate(context.selectedlocation, bundle.ksweapon, self, team, killstreak_id, killstreak_id, context);
    self addweaponstat(bundle.ksweapon, #"used", 1);
}

// Namespace supplydrop/supplydrop
// Params 3, eflags: 0x0
// Checksum 0x8a512301, Offset: 0x31b0
// Size: 0x88
function function_82a0a42d(killstreak_id, context, team) {
    result = self usesupplydropmarker(killstreak_id, context);
    self notify(#"supply_drop_marker_done");
    if (!(isdefined(result) && result)) {
        return false;
    }
    self killstreaks::play_killstreak_start_dialog("supply_drop", team, killstreak_id);
    return true;
}

// Namespace supplydrop/supplydrop
// Params 4, eflags: 0x0
// Checksum 0x1560657c, Offset: 0x3240
// Size: 0x494
function supplydropwatcher(package_contents_id, trigger_event, supplydropweapon, context) {
    player = self;
    self notify(#"supplydropwatcher");
    self endon(#"supplydropwatcher", #"spawned_player", #"disconnect", #"weapon_change");
    team = self.team;
    if (isdefined(context.killstreak_id)) {
        killstreak_id = context.killstreak_id;
    } else {
        killstreak_id = killstreakrules::killstreakstart("supply_drop", team, 0, 0);
        if (killstreak_id == -1) {
            return;
        }
        context.killstreak_id = killstreak_id;
    }
    player flagsys::clear(#"marking_done");
    self thread checkforemp();
    if (trigger_event != "none") {
        if (!supplydropweapon.isgrenadeweapon) {
            self thread markerupdatethread(context);
        }
        self thread checkweaponchange(team, killstreak_id);
    }
    self thread cleanupwatcherondeath(team, killstreak_id);
    while (true) {
        if (trigger_event == "none") {
            weapon = supplydropweapon;
            weapon_instance = weapon;
        } else {
            waitresult = self waittill(trigger_event);
            weapon = waitresult.weapon;
            weapon_instance = waitresult.projectile;
        }
        issupplydropweapon = 1;
        if (trigger_event == "grenade_fire") {
            issupplydropweapon = weapon.issupplydropweapon;
        }
        if (isdefined(self) && issupplydropweapon) {
            if (isdefined(context)) {
                if (!isdefined(player.markerposition) || !(isdefined(context.islocationgood) && [[ context.islocationgood ]](player.markerposition, context))) {
                    if (isdefined(level.killstreakcorebundle.ksinvalidlocationsound)) {
                        player playsoundtoplayer(level.killstreakcorebundle.ksinvalidlocationsound, player);
                    }
                    if (isdefined(level.killstreakcorebundle.ksinvalidlocationstring)) {
                        player iprintlnbold(level.killstreakcorebundle.ksinvalidlocationstring);
                    }
                    continue;
                }
                if (isdefined(context.validlocationsound)) {
                    player playsoundtoplayer(context.validlocationsound, player);
                }
                self thread helidelivercrate(context.selectedlocation, weapon, self, team, killstreak_id, package_contents_id, context);
            } else {
                self thread dosupplydrop(weapon_instance, weapon, self, killstreak_id, package_contents_id);
                weapon_instance thread do_supply_drop_detonation(weapon, self);
                weapon_instance thread supplydropgrenadetimeout(team, killstreak_id, weapon);
            }
            self killstreaks::switch_to_last_non_killstreak_weapon();
        } else {
            killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
            self notify(#"cleanup_marker");
        }
        break;
    }
    player flagsys::set(#"marking_done");
    player clientfield::set_to_player("marker_state", 0);
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0xe04d6736, Offset: 0x36e0
// Size: 0x8c
function checkforemp() {
    self endon(#"supplydropwatcher");
    self endon(#"spawned_player");
    self endon(#"disconnect");
    self endon(#"weapon_change");
    self endon(#"death");
    self endon(#"trigger_weapon_shutdown");
    self waittill(#"emp_jammed");
    self killstreaks::switch_to_last_non_killstreak_weapon();
}

// Namespace supplydrop/supplydrop
// Params 3, eflags: 0x0
// Checksum 0x1b3492a2, Offset: 0x3778
// Size: 0x1e4
function supplydropgrenadetimeout(team, killstreak_id, weapon) {
    self endon(#"death");
    self endon(#"stationary");
    grenade_lifetime = 10;
    wait grenade_lifetime;
    if (!isdefined(self)) {
        return;
    }
    self notify(#"grenade_timeout");
    killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
    if (weapon.name == #"tank_robot") {
        killstreakrules::killstreakstop("tank_robot", team, killstreak_id);
        self notify(#"cleanup_marker");
    } else if (weapon.name == #"inventory_tank_robot") {
        killstreakrules::killstreakstop("inventory_tank_robot", team, killstreak_id);
        self notify(#"cleanup_marker");
    } else if (weapon.name == #"combat_robot_drop") {
        killstreakrules::killstreakstop("combat_robot_drop", team, killstreak_id);
        self notify(#"cleanup_marker");
    } else if (weapon.name == #"inventory_combat_robot_drop") {
        killstreakrules::killstreakstop("inventory_combat_robot_drop", team, killstreak_id);
        self notify(#"cleanup_marker");
    }
    self delete();
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0x6ce55164, Offset: 0x3968
// Size: 0xae
function checkweaponchange(team, killstreak_id) {
    self endon(#"supplydropwatcher", #"spawned_player", #"disconnect", #"trigger_weapon_shutdown", #"death");
    self waittill(#"weapon_change");
    killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
    self notify(#"cleanup_marker");
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0x6952397b, Offset: 0x3a20
// Size: 0xd6
function geticonforcrate() {
    if (isdefined(self.cratetype.objective)) {
        return self.cratetype.objective;
    }
    if (self.cratetype.type == "killstreak") {
        assert(isdefined(self.cratetype.name));
        crateweapon = killstreaks::get_killstreak_weapon(self.cratetype.name);
        if (isdefined(crateweapon)) {
            self.cratetype.objective = getcrateheadobjective(crateweapon);
            return self.cratetype.objective;
        }
    }
    return undefined;
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x93f3224, Offset: 0x3b00
// Size: 0x5e4
function crateactivate(hacker) {
    self makeusable();
    self setcursorhint("HINT_NOICON");
    if (!isdefined(self.cratetype)) {
        return;
    }
    self sethintstring(self.cratetype.hint);
    if (isdefined(self.cratetype.hint_gambler)) {
        self sethintstringforperk(#"specialty_showenemyequipment", self.cratetype.hint_gambler);
    }
    crateobjid = gameobjects::get_next_obj_id();
    objective_add(crateobjid, "invisible", self.origin);
    objective_setstate(crateobjid, "active");
    self.friendlyobjid = crateobjid;
    self.enemyobjid = [];
    icon = self geticonforcrate();
    if (isdefined(hacker)) {
    }
    if (level.teambased) {
        objective_setteam(crateobjid, self.team);
        foreach (team, _ in level.teams) {
            if (self.team == team) {
                continue;
            }
            crateobjid = gameobjects::get_next_obj_id();
            objective_add(crateobjid, "invisible", self.origin);
            objective_setteam(crateobjid, team);
            objective_setstate(crateobjid, "active");
            self.enemyobjid[self.enemyobjid.size] = crateobjid;
        }
    } else {
        if (!self.visibletoall) {
            objective_setinvisibletoall(crateobjid);
            enemycrateobjid = gameobjects::get_next_obj_id();
            objective_add(enemycrateobjid, "invisible", self.origin);
            objective_setstate(enemycrateobjid, "active");
            if (isplayer(self.owner)) {
                objective_setinvisibletoplayer(enemycrateobjid, self.owner);
            }
            self.enemyobjid[self.enemyobjid.size] = enemycrateobjid;
        }
        if (isplayer(self.owner)) {
            objective_setvisibletoplayer(crateobjid, self.owner);
        }
        if (isdefined(self.hacker)) {
            objective_setinvisibletoplayer(crateobjid, self.hacker);
            crateobjid = gameobjects::get_next_obj_id();
            objective_add(crateobjid, "invisible", self.origin);
            objective_setstate(crateobjid, "active");
            objective_setinvisibletoall(crateobjid);
            objective_setvisibletoplayer(crateobjid, self.hacker);
            self.hackerobjid = crateobjid;
        }
    }
    if (!self.visibletoall && isdefined(icon)) {
        self entityheadicons::setentityheadicon(self.team, self, icon);
        if (self.entityheadobjectives.size > 0) {
            objectiveid = self.entityheadobjectives[self.entityheadobjectives.size - 1];
            if (isdefined(objectiveid)) {
                objective_setinvisibletoall(objectiveid);
                if (isdefined(self.owner)) {
                    objective_setvisibletoplayer(objectiveid, self.owner);
                }
            }
        }
    }
    if (isdefined(self.owner) && isplayer(self.owner) && isbot(self.owner)) {
        self.owner notify(#"bot_crate_landed", {#crate:self});
    }
    if (isdefined(self.owner)) {
        self.owner notify(#"crate_landed", {#crate:self});
        setricochetprotectionendtime("supply_drop", self.killstreak_id, self.owner);
    }
}

// Namespace supplydrop/supplydrop
// Params 3, eflags: 0x0
// Checksum 0x622be107, Offset: 0x40f0
// Size: 0xbc
function setricochetprotectionendtime(killstreak, killstreak_id, owner) {
    ksbundle = level.killstreakbundle[killstreak];
    if (isdefined(ksbundle) && isdefined(ksbundle.ksricochetpostlandduration) && ksbundle.ksricochetpostlandduration > 0) {
        endtime = gettime() + int(ksbundle.ksricochetpostlandduration * 1000);
        killstreaks::set_ricochet_protection_endtime(killstreak_id, owner, endtime);
    }
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0xe944dfef, Offset: 0x41b8
// Size: 0x156
function cratedeactivate() {
    self makeunusable();
    if (isdefined(self.friendlyobjid)) {
        objective_delete(self.friendlyobjid);
        gameobjects::release_obj_id(self.friendlyobjid);
        self.friendlyobjid = undefined;
    }
    if (isdefined(self.enemyobjid)) {
        foreach (objid in self.enemyobjid) {
            objective_delete(objid);
            gameobjects::release_obj_id(objid);
        }
        self.enemyobjid = [];
    }
    if (isdefined(self.hackerobjid)) {
        objective_delete(self.hackerobjid);
        gameobjects::release_obj_id(self.hackerobjid);
        self.hackerobjid = undefined;
    }
}

// Namespace supplydrop/supplydrop
// Params 3, eflags: 0x0
// Checksum 0x669014e, Offset: 0x4318
// Size: 0xb0
function dropalltoground(origin, radius, stickyobjectradius) {
    physicsexplosionsphere(origin, radius, radius, 0);
    waitframe(1);
    weapons::drop_all_to_ground(origin, radius);
    dropcratestoground(origin, radius);
    level notify(#"drop_objects_to_ground", {#position:origin, #radius:stickyobjectradius});
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0xd141b29a, Offset: 0x43d0
// Size: 0x2c
function dropeverythingtouchingcrate(origin) {
    dropalltoground(origin, 70, 70);
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0x8c52baf8, Offset: 0x4408
// Size: 0x4c
function dropalltogroundaftercratedelete(crate, crate_origin) {
    crate waittill(#"death");
    wait 0.1;
    crate dropeverythingtouchingcrate(crate_origin);
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0x4d9b1962, Offset: 0x4460
// Size: 0xbe
function dropcratestoground(origin, radius) {
    crate_ents = getentarray("care_package", "script_noteworthy");
    radius_sq = radius * radius;
    for (i = 0; i < crate_ents.size; i++) {
        if (distancesquared(origin, crate_ents[i].origin) < radius_sq) {
            crate_ents[i] thread dropcratetoground();
        }
    }
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0xa4a31d3, Offset: 0x4528
// Size: 0xb6
function dropcratetoground() {
    self endon(#"death");
    if (isdefined(self.droppingtoground)) {
        return;
    }
    self.droppingtoground = 1;
    dropeverythingtouchingcrate(self.origin);
    self cratedeactivate();
    self thread cratedroptogroundkill();
    self crateredophysics();
    self crateactivate();
    self.droppingtoground = undefined;
}

// Namespace supplydrop/supplydrop
// Params 8, eflags: 0x0
// Checksum 0x6e7a635b, Offset: 0x45e8
// Size: 0x3f6
function cratespawn(killstreak, killstreakid, owner, team, drop_origin, drop_angle, _crate, context) {
    if (isdefined(_crate)) {
        crate = _crate;
    } else {
        crate = spawn("script_model", drop_origin, 1);
    }
    crate killstreaks::configure_team(killstreak, killstreakid, owner);
    crate.angles = drop_angle;
    crate.visibletoall = 0;
    crate.script_noteworthy = "care_package";
    if (!isdefined(context) || !isdefined(context.vehicle)) {
        crate clientfield::set("enemyequip", 1);
    }
    if (!isdefined(_crate)) {
        if (killstreak == "tank_robot" || killstreak == "inventory_tank_robot") {
            crate setmodel(level.cratemodeltank);
            crate setenemymodel(level.cratemodeltank);
        } else {
            crate setmodel(level.cratemodelfriendly);
            crate setenemymodel(level.cratemodelenemy);
        }
    }
    if (isdefined(context) && !(isdefined(context.dontdisconnectpaths) && context.dontdisconnectpaths)) {
        crate disconnectpaths();
    }
    switch (killstreak) {
    case #"turret_drop":
        crate.cratetype = level.cratetypes[killstreak][#"autoturret"];
        break;
    case #"tow_turret_drop":
        crate.cratetype = level.cratetypes[killstreak][#"auto_tow"];
        break;
    case #"m220_tow_drop":
        crate.cratetype = level.cratetypes[killstreak][#"m220_tow"];
        break;
    case #"tank_robot":
    case #"inventory_tank_robot":
        crate.cratetype = level.cratetypes[killstreak][#"tank_robot"];
        break;
    case #"inventory_minigun_drop":
    case #"minigun_drop":
        crate.cratetype = level.cratetypes[killstreak][#"minigun"];
        break;
    case #"m32_drop":
    case #"inventory_m32_drop":
        crate.cratetype = level.cratetypes[killstreak][#"m32"];
        break;
    default:
        crate.cratetype = getrandomcratetype("supplydrop");
        break;
    }
    return crate;
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x65b1c241, Offset: 0x49e8
// Size: 0x1e4
function cratedelete(drop_all_to_ground) {
    if (!isdefined(self)) {
        return;
    }
    killstreaks::remove_ricochet_protection(self.killstreak_id, self.originalowner);
    if (!isdefined(drop_all_to_ground)) {
        drop_all_to_ground = 1;
    }
    if (isdefined(self.friendlyobjid)) {
        objective_delete(self.friendlyobjid);
        gameobjects::release_obj_id(self.friendlyobjid);
        self.friendlyobjid = undefined;
    }
    if (isdefined(self.enemyobjid)) {
        foreach (objid in self.enemyobjid) {
            objective_delete(objid);
            gameobjects::release_obj_id(objid);
        }
        self.enemyobjid = undefined;
    }
    if (isdefined(self.hackerobjid)) {
        objective_delete(self.hackerobjid);
        gameobjects::release_obj_id(self.hackerobjid);
        self.hackerobjid = undefined;
    }
    if (drop_all_to_ground) {
        level thread dropalltogroundaftercratedelete(self, self.origin);
    }
    if (isdefined(self.killcament)) {
        self.killcament thread util::deleteaftertime(5);
    }
    self delete();
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0x6f9f2a4, Offset: 0x4bd8
// Size: 0x5e
function stationarycrateoverride() {
    self endon(#"death");
    self endon(#"stationary");
    wait 4;
    self.angles = self.angles;
    self.origin = self.origin;
    self notify(#"stationary");
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0xe838dcd1, Offset: 0x4c40
// Size: 0x44
function timeoutcratewaiter() {
    self endon(#"death");
    self endon(#"stationary");
    wait 20;
    self cratedelete(1);
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0xc5bb547f, Offset: 0x4c90
// Size: 0x16a
function cratephysics() {
    forcepointvariance = 200;
    vertvelocitymin = -100;
    vertvelocitymax = 100;
    forcepointx = randomfloatrange(0 - forcepointvariance, forcepointvariance);
    forcepointy = randomfloatrange(0 - forcepointvariance, forcepointvariance);
    forcepoint = (forcepointx, forcepointy, 0);
    forcepoint += self.origin;
    initialvelocityz = randomfloatrange(vertvelocitymin, vertvelocitymax);
    initialvelocity = (0, 0, initialvelocityz);
    self physicslaunch(forcepoint, initialvelocity);
    self thread timeoutcratewaiter();
    self thread update_crate_velocity();
    self thread play_impact_sound();
    self waittill(#"stationary");
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0xc7f05dc9, Offset: 0x4e08
// Size: 0x6e
function function_c12ad267(v_target_location) {
    endtime = gettime() + 7000;
    while (endtime > gettime()) {
        if (self.origin[2] - 20 < v_target_location[2]) {
            break;
        }
        waitframe(1);
    }
    self notify(#"stationary");
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0x35436bb3, Offset: 0x4e80
// Size: 0x204
function cratecontrolleddrop(killstreak, v_target_location) {
    crate = self;
    supplydrop = 1;
    if (killstreak == "tank_robot") {
        supplydrop = 0;
    }
    if (supplydrop) {
        params = level.killstreakbundle[#"supply_drop"];
    } else {
        params = level.killstreakbundle[#"tank_robot"];
    }
    var_b427cf85 = 0;
    if (!isdefined(params.kstotaldroptime)) {
        params.kstotaldroptime = 4;
    }
    var_8faf76d8 = 1;
    acceltime = params.kstotaldroptime * var_8faf76d8;
    deceltime = params.kstotaldroptime - acceltime;
    target = (v_target_location[0], v_target_location[1], v_target_location[2] + var_b427cf85);
    hostmigration::waittillhostmigrationdone();
    crate moveto(target, params.kstotaldroptime, acceltime, deceltime);
    crate thread watchforcratekill(v_target_location[2] + (isdefined(params.ksstartcratekillheightfromground) ? params.ksstartcratekillheightfromground : 200));
    crate waittill(#"movedone");
    hostmigration::waittillhostmigrationdone();
    crate cratephysics();
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0x88000402, Offset: 0x5090
// Size: 0x8c
function play_impact_sound() {
    self endon(#"stationary");
    self endon(#"death");
    wait 0.5;
    while (abs(self.velocity[2]) > 5) {
        wait 0.1;
    }
    self playsound(#"phy_impact_supply");
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0xba90ccd3, Offset: 0x5128
// Size: 0x84
function update_crate_velocity() {
    self endon(#"death");
    self endon(#"stationary");
    self.velocity = (0, 0, 0);
    self.old_origin = self.origin;
    while (isdefined(self)) {
        self.velocity = self.origin - self.old_origin;
        self.old_origin = self.origin;
        waitframe(1);
    }
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0xa9dad8b5, Offset: 0x51b8
// Size: 0x8a
function crateredophysics() {
    forcepoint = self.origin;
    initialvelocity = (0, 0, 0);
    self physicslaunch(forcepoint, initialvelocity);
    self thread timeoutcratewaiter();
    self thread stationarycrateoverride();
    self waittill(#"stationary");
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0x635110fa, Offset: 0x5250
// Size: 0x1ac
function do_supply_drop_detonation(weapon, owner) {
    self notify(#"supplydropwatcher");
    self endon(#"supplydropwatcher");
    self endon(#"spawned_player");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"grenade_timeout");
    self util::waittillnotmoving();
    self.angles = (0, self.angles[1], 90);
    fuse_time = float(weapon.fusetime) / 1000;
    wait fuse_time;
    if (!isdefined(owner) || !owner emp::enemyempactive()) {
        thread smokegrenade::playsmokesound(self.origin, 6, level.sound_smoke_start, level.sound_smoke_stop, level.sound_smoke_loop);
        playfxontag(level._supply_drop_smoke_fx, self, "tag_fx");
        proj_explosion_sound = weapon.projexplosionsound;
        sound::play_in_space(proj_explosion_sound, self.origin);
    }
    wait 3;
    self delete();
}

// Namespace supplydrop/supplydrop
// Params 6, eflags: 0x0
// Checksum 0xd5d0387d, Offset: 0x5408
// Size: 0x10c
function dosupplydrop(weapon_instance, weapon, owner, killstreak_id, package_contents_id, context) {
    weapon endon(#"explode", #"grenade_timeout");
    self endon(#"disconnect");
    team = owner.team;
    weapon_instance thread watchexplode(weapon, owner, killstreak_id, package_contents_id);
    weapon_instance util::waittillnotmoving();
    weapon_instance notify(#"stoppedmoving");
    self thread helidelivercrate(weapon_instance.origin, weapon, owner, team, killstreak_id, package_contents_id, context);
}

// Namespace supplydrop/supplydrop
// Params 4, eflags: 0x0
// Checksum 0x4211da2f, Offset: 0x5520
// Size: 0x9c
function watchexplode(weapon, owner, killstreak_id, package_contents_id) {
    self endon(#"stoppedmoving");
    team = owner.team;
    waitresult = self waittill(#"explode");
    owner thread helidelivercrate(waitresult.position, weapon, owner, team, killstreak_id, package_contents_id);
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0x398ca043, Offset: 0x55c8
// Size: 0x44
function cratetimeoutthreader() {
    crate = self;
    cratetimeout(90);
    crate thread deleteonownerleave();
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x8881be7a, Offset: 0x5618
// Size: 0x6c
function cratetimeout(time) {
    crate = self;
    self thread killstreaks::waitfortimeout("inventory_supply_drop", int(90 * 1000), &cratedelete, "death");
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0x7b3c2f5d, Offset: 0x5690
// Size: 0x84
function deleteonownerleave() {
    crate = self;
    crate endon(#"death");
    crate.owner waittill(#"joined_team", #"joined_spectators", #"disconnect");
    crate cratedelete(1);
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x3af0557e, Offset: 0x5720
// Size: 0x3c
function waitanddelete(time) {
    self endon(#"death");
    wait time;
    self delete();
}

// Namespace supplydrop/supplydrop
// Params 11, eflags: 0x0
// Checksum 0x951b6372, Offset: 0x5768
// Size: 0x5ec
function dropcrate(origin, angle, killstreak, owner, team, killcament, killstreak_id, package_contents_id, crate_, context, var_18a1b881) {
    angles = (angle[0] * 0.5, angle[1] * 0.5, angle[2] * 0.5);
    if (isdefined(crate_)) {
        origin = crate_.origin;
        angles = crate_.angles;
        crate_ thread waitanddelete(0.1);
    }
    if (isdefined(context.vehicledrop) && context.vehicledrop) {
        context.vehicle = spawnvehicle(#"archetype_mini_quadtank_mp", origin, angles, "talon", undefined, 1, self);
    }
    crate = cratespawn(killstreak, killstreak_id, owner, team, origin, angles);
    killcament unlink();
    killcament linkto(crate);
    crate.killcament = killcament;
    crate.killstreak_id = killstreak_id;
    crate.package_contents_id = package_contents_id;
    killcament thread util::deleteaftertime(15);
    killcament thread unlinkonrotation(crate);
    crate endon(#"death");
    if (!(isdefined(context.vehicledrop) && context.vehicledrop)) {
        crate cratetimeoutthreader();
    }
    trace = groundtrace(crate.origin + (0, 0, -100), crate.origin + (0, 0, -10000), 0, crate, 0);
    v_target_location = trace[#"position"];
    /#
        if (getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
            util::drawcylinder(v_target_location, context.radius, 8000, 99999999, "<dev string:x80>", (0, 0, 0.9), 0.8);
        }
    #/
    if (isdefined(context.vehicle)) {
        crate function_c12ad267(v_target_location);
    } else if (!getdvarint(#"hash_763d6ee8f054423f", 0) && isdefined(v_target_location)) {
        crate cratecontrolleddrop(killstreak, (v_target_location[0], v_target_location[1], v_target_location[2] + 10));
    } else if (isdefined(var_18a1b881)) {
        crate cratecontrolleddrop(killstreak, (var_18a1b881[0], var_18a1b881[1], var_18a1b881[2] + 10));
    } else if (isdefined(owner.markerposition)) {
        crate cratecontrolleddrop(killstreak, (owner.markerposition[0], owner.markerposition[1], owner.markerposition[2] + 10));
    } else {
        crate cratecontrolleddrop(killstreak, v_target_location);
    }
    crate thread hacker_tool::registerwithhackertool(level.carepackagehackertoolradius, level.carepackagehackertooltimems);
    cleanup(context, owner);
    if (isdefined(crate.cratetype) && isdefined(crate.cratetype.landfunctionoverride)) {
        [[ crate.cratetype.landfunctionoverride ]](crate, killstreak, owner, team, context);
        return;
    }
    crate crateactivate();
    crate thread crateusethink();
    crate thread crateusethinkowner();
    if (isdefined(crate.cratetype) && isdefined(crate.cratetype.hint_gambler)) {
        crate thread crategamblerthink();
    }
    default_land_function(crate, killstreak, owner, team);
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0xda609447, Offset: 0x5d60
// Size: 0x17c
function unlinkonrotation(crate) {
    self endon(#"delete");
    crate endon(#"death");
    crate endon(#"stationary");
    waitbeforerotationcheck = getdvarfloat(#"scr_supplydrop_killcam_rot_wait", 0.5);
    wait waitbeforerotationcheck;
    mincos = getdvarfloat(#"scr_supplydrop_killcam_max_rot", 0.999);
    cosine = 1;
    currentdirection = vectornormalize(anglestoforward(crate.angles));
    while (cosine > mincos) {
        olddirection = currentdirection;
        waitframe(1);
        currentdirection = vectornormalize(anglestoforward(crate.angles));
        cosine = vectordot(olddirection, currentdirection);
    }
    self unlink();
}

// Namespace supplydrop/supplydrop
// Params 4, eflags: 0x0
// Checksum 0xc335d4d9, Offset: 0x5ee8
// Size: 0x1f2
function default_land_function(crate, category, owner, team) {
    while (true) {
        waitresult = crate waittill(#"captured");
        player = waitresult.player;
        remote_hack = waitresult.is_remote_hack;
        player challenges::capturedcrate(owner);
        deletecrate = player givecrateitem(crate);
        if (isdefined(deletecrate) && !deletecrate) {
            continue;
        }
        playerhasengineerperk = player hasperk(#"specialty_showenemyequipment");
        if ((playerhasengineerperk || remote_hack == 1) && owner != player && (level.teambased && team != player.team || !level.teambased)) {
            spawn_explosive_crate(crate.origin, crate.angles, category, owner, team, player, playerhasengineerperk);
            crate makeunusable();
            util::wait_network_frame();
            crate cratedelete(0);
            return;
        }
        crate cratedelete(1);
        return;
    }
}

// Namespace supplydrop/supplydrop
// Params 7, eflags: 0x0
// Checksum 0xd97fe7ff, Offset: 0x60e8
// Size: 0x1ca
function spawn_explosive_crate(origin, angle, killstreak, owner, team, hacker, playerhasengineerperk) {
    crate = cratespawn(killstreak, undefined, owner, team, origin, angle);
    crate setowner(owner);
    crate setteam(team);
    if (level.teambased) {
        crate setenemymodel(level.cratemodelboobytrapped);
        crate makeusable(team);
    } else {
        crate setenemymodel(level.cratemodelenemy);
    }
    crate.hacker = hacker;
    crate.visibletoall = 0;
    crate crateactivate(hacker);
    crate sethintstringforperk("specialty_showenemyequipment", level.supplydropdisarmcrate);
    crate thread crateusethink();
    crate thread crateusethinkowner();
    crate thread watch_explosive_crate();
    crate cratetimeoutthreader();
    crate.playerhasengineerperk = playerhasengineerperk;
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0x9590aeed, Offset: 0x62c0
// Size: 0x2a4
function watch_explosive_crate() {
    killcament = spawn("script_model", self.origin + (0, 0, 60));
    self.killcament = killcament;
    waitresult = self waittill(#"captured", #"death");
    remote_hack = waitresult.is_remote_hack;
    player = waitresult.player;
    if (isdefined(self)) {
        if (!player hasperk(#"specialty_showenemyequipment") && !remote_hack) {
            self thread entityheadicons::setentityheadicon(player.team, player, "headicon_dead");
            self loop_sound("wpn_semtex_alert", 0.15);
            if (!isdefined(self.hacker)) {
                self.hacker = self;
            }
            self radiusdamage(self.origin, 256, 500, 300, self.hacker, "MOD_EXPLOSIVE", getweapon(#"supplydrop"));
            playfx(level._supply_drop_explosion_fx, self.origin);
            playsoundatposition(#"wpn_grenade_explode", self.origin);
        } else {
            playsoundatposition(#"mpl_turret_alert", self.origin);
            scoreevents::processscoreevent(#"disarm_hacked_care_package", player, undefined, undefined);
            player challenges::disarmedhackedcarepackage();
        }
    }
    wait 0.1;
    if (isdefined(self)) {
        self cratedelete();
    }
    killcament thread util::deleteaftertime(5);
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0x5944a739, Offset: 0x6570
// Size: 0x7a
function loop_sound(alias, interval) {
    self endon(#"death");
    while (true) {
        playsoundatposition(alias, self.origin);
        wait interval;
        interval /= 1.2;
        if (interval < 0.08) {
            break;
        }
    }
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0xc0055bbc, Offset: 0x65f8
// Size: 0x15c
function watchforcratekill(start_kill_watch_z_threshold) {
    crate = self;
    crate endon(#"death");
    crate endon(#"stationary");
    while (crate.origin[2] > start_kill_watch_z_threshold) {
        waitframe(1);
    }
    stationarythreshold = 2;
    killthreshold = 0;
    maxframestillstationary = 20;
    numframesstationary = 0;
    while (true) {
        vel = 0;
        if (isdefined(self.velocity)) {
            vel = abs(self.velocity[2]);
        }
        if (vel > killthreshold) {
            crate is_touching_crate();
            crate is_clone_touching_crate();
        }
        if (vel < stationarythreshold) {
            numframesstationary++;
        } else {
            numframesstationary = 0;
        }
        if (numframesstationary >= maxframestillstationary) {
            break;
        }
        waitframe(1);
    }
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0x5028b319, Offset: 0x6760
// Size: 0x110
function cratekill() {
    self endon(#"death");
    stationarythreshold = 2;
    killthreshold = 15;
    maxframestillstationary = 20;
    numframesstationary = 0;
    while (true) {
        vel = 0;
        if (isdefined(self.velocity)) {
            vel = abs(self.velocity[2]);
        }
        if (vel > killthreshold) {
            self is_touching_crate();
            self is_clone_touching_crate();
        }
        if (vel < stationarythreshold) {
            numframesstationary++;
        } else {
            numframesstationary = 0;
        }
        if (numframesstationary >= maxframestillstationary) {
            break;
        }
        wait 0.01;
    }
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0xb78e4863, Offset: 0x6878
// Size: 0x41c
function cratedroptogroundkill() {
    self endon(#"death");
    self endon(#"stationary");
    for (;;) {
        players = getplayers();
        dotrace = 0;
        for (i = 0; i < players.size; i++) {
            if (players[i].sessionstate != "playing") {
                continue;
            }
            if (players[i].team == #"spectator") {
                continue;
            }
            self is_equipment_touching_crate(players[i]);
            if (!isalive(players[i])) {
                continue;
            }
            flattenedselforigin = (self.origin[0], self.origin[1], 0);
            flattenedplayerorigin = (players[i].origin[0], players[i].origin[1], 0);
            if (distancesquared(flattenedselforigin, flattenedplayerorigin) > 4096) {
                continue;
            }
            dotrace = 1;
            break;
        }
        if (dotrace) {
            start = self.origin;
            cratedroptogroundtrace(start);
            start = self getpointinbounds(1, 0, 0);
            cratedroptogroundtrace(start);
            start = self getpointinbounds(-1, 0, 0);
            cratedroptogroundtrace(start);
            start = self getpointinbounds(0, -1, 0);
            cratedroptogroundtrace(start);
            start = self getpointinbounds(0, 1, 0);
            cratedroptogroundtrace(start);
            start = self getpointinbounds(1, 1, 0);
            cratedroptogroundtrace(start);
            start = self getpointinbounds(-1, 1, 0);
            cratedroptogroundtrace(start);
            start = self getpointinbounds(1, -1, 0);
            cratedroptogroundtrace(start);
            start = self getpointinbounds(-1, -1, 0);
            cratedroptogroundtrace(start);
            wait 0.2;
            continue;
        }
        wait 0.5;
    }
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0xe597ddd0, Offset: 0x6ca0
// Size: 0x224
function cratedroptogroundtrace(start) {
    end = start + (0, 0, -8000);
    trace = bullettrace(start, end, 1, self, 0, 1);
    if (isdefined(trace[#"entity"]) && isplayer(trace[#"entity"]) && isalive(trace[#"entity"])) {
        player = trace[#"entity"];
        if (player.sessionstate != "playing") {
            return;
        }
        if (player.team == #"spectator") {
            return;
        }
        if (distancesquared(start, trace[#"position"]) < 144 || self istouching(player)) {
            player dodamage(player.health + 1, player.origin, self.owner, self, "none", "MOD_HIT_BY_OBJECT", 0, getweapon(#"supplydrop"));
            player playsound(#"mpl_supply_crush");
            player playsound(#"phy_impact_supply");
        }
    }
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0x9b9360f4, Offset: 0x6ed0
// Size: 0x3c4
function is_touching_crate() {
    if (!isdefined(self)) {
        return;
    }
    crate = self;
    extraboundary = (10, 10, 10);
    players = getplayers();
    crate_bottom_point = self.origin;
    foreach (player in level.players) {
        if (isdefined(player) && isalive(player)) {
            stance = player getstance();
            stance_z_offset = stance == "crouch" ? 18 : stance == "stand" ? 40 : 6;
            player_test_point = player.origin + (0, 0, stance_z_offset);
            var_6d42a956 = distance2dsquared(player_test_point, self.origin);
            zvel = self.velocity[2];
            if (var_6d42a956 < 2500 && player_test_point[2] > crate_bottom_point[2]) {
                attacker = isdefined(self.owner) ? self.owner : self;
                player dodamage(player.health + 1, player.origin, attacker, self, "none", "MOD_HIT_BY_OBJECT", 0, getweapon(#"supplydrop"));
                player playsound(#"mpl_supply_crush");
                player playsound(#"phy_impact_supply");
            }
        }
        self is_equipment_touching_crate(player);
    }
    vehicles = getentarray("script_vehicle", "classname");
    foreach (vehicle in vehicles) {
        if (isvehicle(vehicle)) {
            if (isdefined(vehicle.archetype) && vehicle.archetype == "wasp") {
                if (crate istouching(vehicle, (2, 2, 2))) {
                    vehicle notify(#"sentinel_shutdown");
                }
            }
        }
    }
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0x44b92c44, Offset: 0x72a0
// Size: 0x1ee
function is_clone_touching_crate() {
    if (!isdefined(self)) {
        return;
    }
    extraboundary = (10, 10, 10);
    actors = getactorarray();
    for (i = 0; i < actors.size; i++) {
        if (isdefined(actors[i]) && isdefined(actors[i].isaiclone) && isalive(actors[i]) && actors[i].origin[2] < self.origin[2] && self istouching(actors[i], extraboundary)) {
            attacker = isdefined(self.owner) ? self.owner : self;
            actors[i] dodamage(actors[i].health + 1, actors[i].origin, attacker, self, "none", "MOD_HIT_BY_OBJECT", 0, getweapon(#"supplydrop"));
            actors[i] playsound(#"mpl_supply_crush");
            actors[i] playsound(#"phy_impact_supply");
        }
    }
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x4f0a7a6b, Offset: 0x7498
// Size: 0x1bc
function is_equipment_touching_crate(player) {
    extraboundary = (10, 10, 10);
    if (isdefined(player) && isdefined(player.weaponobjectwatcherarray)) {
        for (watcher = 0; watcher < player.weaponobjectwatcherarray.size; watcher++) {
            objectwatcher = player.weaponobjectwatcherarray[watcher];
            objectarray = objectwatcher.objectarray;
            if (isdefined(objectarray)) {
                for (weaponobject = 0; weaponobject < objectarray.size; weaponobject++) {
                    if (isdefined(objectarray[weaponobject]) && self istouching(objectarray[weaponobject], extraboundary)) {
                        if (isdefined(objectwatcher.ondetonatecallback)) {
                            objectwatcher thread weaponobjects::waitanddetonate(objectarray[weaponobject], 0);
                            continue;
                        }
                        weaponobjects::removeweaponobject(objectwatcher, objectarray[weaponobject]);
                    }
                }
            }
        }
    }
    extraboundary = (15, 15, 15);
    if (isdefined(player) && isdefined(player.tacticalinsertion) && self istouching(player.tacticalinsertion, extraboundary)) {
        player.tacticalinsertion thread tacticalinsertion::fizzle();
    }
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0x9a334e38, Offset: 0x7660
// Size: 0x88
function spawnuseent() {
    useent = spawn("script_origin", self.origin);
    useent.curprogress = 0;
    useent.inuse = 0;
    useent.userate = 0;
    useent.usetime = 0;
    useent.owner = self;
    useent thread useentownerdeathwaiter(self);
    return useent;
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x735bf427, Offset: 0x76f0
// Size: 0x4c
function useentownerdeathwaiter(owner) {
    self endon(#"death");
    owner waittill(#"death");
    self delete();
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0x72002089, Offset: 0x7748
// Size: 0x1aa
function crateusethink() {
    while (isdefined(self)) {
        waitresult = self waittill(#"trigger", #"death");
        player = waitresult.activator;
        if (!isalive(player)) {
            continue;
        }
        if (!player isonground()) {
            continue;
        }
        if (isdefined(self.owner) && self.owner == player) {
            continue;
        }
        useent = self spawnuseent();
        result = 0;
        if (isdefined(self.hacker)) {
            useent.hacker = self.hacker;
        }
        self.useent = useent;
        result = useent useholdthink(player, level.cratenonownerusetime);
        if (isdefined(useent)) {
            useent delete();
        } else {
            break;
        }
        if (result) {
            scoreevents::givecratecapturemedal(self, player);
            self notify(#"captured", {#player:player, #is_remote_hack:0});
        }
    }
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0x926e806f, Offset: 0x7900
// Size: 0x122
function crateusethinkowner() {
    while (isdefined(self)) {
        waitresult = self waittill(#"trigger", #"death");
        if (waitresult._notify == "death") {
            return;
        }
        player = waitresult.activator;
        if (!isalive(player)) {
            continue;
        }
        if (!isdefined(self.owner)) {
            continue;
        }
        if (self.owner != player) {
            continue;
        }
        result = self useholdthink(player, level.crateownerusetime);
        if (result) {
            self notify(#"captured", {#player:player, #is_remote_hack:0});
        }
    }
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0x51735273, Offset: 0x7a30
// Size: 0x190
function useholdthink(player, usetime) {
    player notify(#"use_hold");
    player val::set(#"supplydrop", "freezecontrols");
    player val::set(#"supplydrop", "disable_weapons");
    self.curprogress = 0;
    self.inuse = 1;
    self.userate = 0;
    self.usetime = usetime;
    player thread personalusebar(self);
    result = useholdthinkloop(player);
    if (isdefined(player)) {
        player notify(#"done_using");
    }
    if (isalive(player)) {
        player val::reset(#"supplydrop", "freezecontrols");
        player val::reset(#"supplydrop", "disable_weapons");
    }
    if (isdefined(self)) {
        self.inuse = 0;
    }
    if (isdefined(result) && result) {
        return true;
    }
    return false;
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0xc6b46a63, Offset: 0x7bc8
// Size: 0xde
function continueholdthinkloop(player) {
    if (!isdefined(self)) {
        return false;
    }
    if (self.curprogress >= self.usetime) {
        return false;
    }
    if (!isalive(player)) {
        return false;
    }
    if (player.throwinggrenade) {
        return false;
    }
    if (!player usebuttonpressed()) {
        return false;
    }
    if (player meleebuttonpressed()) {
        return false;
    }
    if (player isinvehicle()) {
        return false;
    }
    if (player isweaponviewonlylinked()) {
        return false;
    }
    if (player isremotecontrolling()) {
        return false;
    }
    return true;
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0xc4e33da3, Offset: 0x7cb0
// Size: 0x112
function useholdthinkloop(player) {
    level endon(#"game_ended");
    self endon(#"disabled");
    self.owner endon(#"crate_use_interrupt");
    timedout = 0;
    while (self continueholdthinkloop(player)) {
        timedout += 0.05;
        self.curprogress += level.var_b5db3a4 * self.userate;
        self.userate = 1;
        if (self.curprogress >= self.usetime) {
            self.inuse = 0;
            waitframe(1);
            return isalive(player);
        }
        waitframe(1);
        hostmigration::waittillhostmigrationdone();
    }
    return 0;
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0x1fe1e899, Offset: 0x7dd0
// Size: 0x186
function crategamblerthink() {
    self endon(#"death");
    for (;;) {
        waitresult = self waittill(#"trigger_use_doubletap");
        player = waitresult.player;
        if (!player hasperk(#"specialty_showenemyequipment")) {
            continue;
        }
        if (isdefined(self.useent) && self.useent.inuse) {
            if (isdefined(self.owner) && self.owner != player) {
                continue;
            }
        }
        player playlocalsound(#"uin_gamble_perk");
        self.cratetype = getrandomcratetype("gambler", self.cratetype.name);
        self cratereactivate();
        self sethintstringforperk("specialty_showenemyequipment", self.cratetype.hint);
        self notify(#"crate_use_interrupt");
        level notify(#"use_interrupt", {#target:self});
        return;
    }
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0xcb2b5fab, Offset: 0x7f60
// Size: 0x6c
function cratereactivate() {
    self sethintstring(self.cratetype.hint);
    icon = self geticonforcrate();
    self thread entityheadicons::setentityheadicon(self.team, self, icon);
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x9b734552, Offset: 0x7fd8
// Size: 0x3f4
function personalusebar(object) {
    self endon(#"disconnect");
    capturecratestate = 0;
    if (self hasperk(#"specialty_showenemyequipment") && object.owner != self && !isdefined(object.hacker) && (level.teambased && object.owner.team != self.team || !level.teambased)) {
        capturecratestate = 2;
        self playlocalsound(#"evt_hacker_hacking");
    } else if (self hasperk(#"specialty_showenemyequipment") && isdefined(object.hacker) && (object.owner == self || level.teambased && object.owner.team == self.team)) {
        capturecratestate = 3;
        self playlocalsound(#"evt_hacker_hacking");
    } else {
        capturecratestate = 1;
        self.is_capturing_own_supply_drop = object.owner === self && (!isdefined(object.originalowner) || object.originalowner == self);
    }
    lastrate = -1;
    while (isalive(self) && isdefined(object) && object.inuse && !level.gameended) {
        if (lastrate != object.userate) {
            if (object.curprogress > object.usetime) {
                object.curprogress = object.usetime;
            }
            if (!object.userate) {
                self clientfield::set_player_uimodel("hudItems.captureCrateTotalTime", 0);
                self clientfield::set_player_uimodel("hudItems.captureCrateState", 0);
            } else {
                barfrac = object.curprogress / object.usetime;
                rateofchange = object.userate / object.usetime;
                capturecratetotaltime = 0;
                if (rateofchange > 0) {
                    capturecratetotaltime = (1 - barfrac) / rateofchange;
                }
                self clientfield::set_player_uimodel("hudItems.captureCrateTotalTime", int(capturecratetotaltime));
                self clientfield::set_player_uimodel("hudItems.captureCrateState", capturecratestate);
            }
        }
        lastrate = object.userate;
        waitframe(1);
    }
    self.is_capturing_own_supply_drop = 0;
    self clientfield::set_player_uimodel("hudItems.captureCrateTotalTime", 0);
    self clientfield::set_player_uimodel("hudItems.captureCrateState", 0);
}

// Namespace supplydrop/supplydrop
// Params 8, eflags: 0x0
// Checksum 0x97f5cee7, Offset: 0x83d8
// Size: 0x3d8
function spawn_helicopter(owner, team, origin, angles, vehicledef, targetname, killstreak_id, context) {
    chopper = spawnvehicle(vehicledef, origin, angles, targetname);
    chopper setowner(owner);
    if (!isdefined(chopper)) {
        if (isplayer(owner)) {
            killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
            self notify(#"cleanup_marker");
        }
        return undefined;
    }
    chopper.destroyfunc = &destroyhelicopter;
    chopper.script_nocorpse = 1;
    chopper killstreaks::configure_team("supply_drop", killstreak_id, owner);
    chopper.maxhealth = level.heli_maxhealth;
    chopper.rocketdamageoneshot = chopper.maxhealth + 1;
    chopper.damagetaken = 0;
    hardpointtypefordamage = "supply_drop";
    if (context.killstreakref === "inventory_tank_robot" || context.killstreakref === "tank_robot") {
        hardpointtypefordamage = "supply_drop_ai_tank";
    } else if (context.killstreakref === "inventory_combat_robot" || context.killstreakref === "combat_robot") {
        hardpointtypefordamage = "supply_drop_combat_robot";
    }
    chopper thread helicopter::heli_damage_monitor(hardpointtypefordamage);
    chopper thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", "death");
    chopper.spawntime = gettime();
    chopper clientfield::set("enemyvehicle", 1);
    /#
        chopper util::debug_slow_heli_speed();
    #/
    maxpitch = getdvarint(#"scr_supplydropmaxpitch", 25);
    maxroll = getdvarint(#"scr_supplydropmaxroll", 45);
    chopper setmaxpitchroll(0, maxroll);
    chopper setdrawinfrared(1);
    chopper setneargoalnotifydist(40);
    target_set(chopper, (0, 0, -25));
    if (isplayer(owner)) {
        chopper thread refcountdecchopper(team, killstreak_id);
    }
    chopper thread helidestroyed();
    chopper setrotorspeed(1);
    return chopper;
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x1ae54f95, Offset: 0x87b8
// Size: 0x1b4
function destroyhelicopter(var_6e546e05) {
    team = self.originalteam;
    if (target_istarget(self)) {
        target_remove(self);
    }
    self influencers::remove_influencers();
    if (isdefined(self.interior_model)) {
        self.interior_model delete();
        self.interior_model = undefined;
    }
    if (isdefined(self.minigun_snd_ent)) {
        self.minigun_snd_ent stoploopsound();
        self.minigun_snd_ent delete();
        self.minigun_snd_ent = undefined;
    }
    if (isdefined(self.alarm_snd_ent)) {
        self.alarm_snd_ent delete();
        self.alarm_snd_ent = undefined;
    }
    if (isdefined(self.flare_ent)) {
        self.flare_ent delete();
        self.flare_ent = undefined;
    }
    self notify(#"hash_525537be2de4c159", {#position:self.origin, #direction:self.angles, #owner:self.owner});
    lbexplode();
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x5442e966, Offset: 0x8978
// Size: 0x1a
function getdropheight(origin) {
    return airsupport::getminimumflyheight();
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0x91009ac1, Offset: 0x89a0
// Size: 0x1e
function getdropdirection() {
    return (0, randomint(360), 0);
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0x44846cec, Offset: 0x89c8
// Size: 0x60
function getnextdropdirection(drop_direction, degrees) {
    drop_direction = (0, drop_direction[1] + degrees, 0);
    if (drop_direction[1] >= 360) {
        drop_direction = (0, drop_direction[1] - 360, 0);
    }
    return drop_direction;
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0xbcd3e4a0, Offset: 0x8a30
// Size: 0x1fe
function gethelistart(drop_origin, drop_direction) {
    dist = -1 * getdvarint(#"scr_supplydropincomingdistance", 15000);
    pathrandomness = 100;
    direction = drop_direction + (0, randomintrange(-2, 3), 0);
    start_origin = drop_origin + anglestoforward(direction) * dist;
    start_origin += ((randomfloat(2) - 1) * pathrandomness, (randomfloat(2) - 1) * pathrandomness, 0);
    /#
        if (getdvarint(#"scr_noflyzones_debug", 0)) {
            if (level.noflyzones.size) {
                index = randomintrange(0, level.noflyzones.size);
                delta = drop_origin - level.noflyzones[index].origin;
                delta = (delta[0] + randomint(10), delta[1] + randomint(10), 0);
                delta = vectornormalize(delta);
                start_origin = drop_origin + delta * dist;
            }
        }
    #/
    return start_origin;
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0xb67de86b, Offset: 0x8c38
// Size: 0x162
function getheliend(drop_origin, drop_direction) {
    pathrandomness = 150;
    dist = -1 * getdvarint(#"scr_supplydropoutgoingdistance", 15000);
    if (randomintrange(0, 2) == 0) {
        turn = randomintrange(60, 121);
    } else {
        turn = -1 * randomintrange(60, 121);
    }
    direction = drop_direction + (0, turn, 0);
    end_origin = drop_origin + anglestoforward(direction) * dist;
    end_origin += ((randomfloat(2) - 1) * pathrandomness, (randomfloat(2) - 1) * pathrandomness, 0);
    return end_origin;
}

// Namespace supplydrop/supplydrop
// Params 3, eflags: 0x0
// Checksum 0x306813cd, Offset: 0x8da8
// Size: 0x78
function addoffsetontopoint(point, direction, offset) {
    angles = vectortoangles((direction[0], direction[1], 0));
    offset_world = rotatepoint(offset, angles);
    return point + offset_world;
}

// Namespace supplydrop/supplydrop
// Params 3, eflags: 0x0
// Checksum 0x90c38e45, Offset: 0x8e28
// Size: 0x62
function supplydrophelistartpath_v2_setup(goal, goal_offset, var_981b9b57) {
    goalpath = spawnstruct();
    goalpath.start = helicopter::getvalidrandomstartnode(goal, var_981b9b57).origin;
    return goalpath;
}

// Namespace supplydrop/supplydrop
// Params 3, eflags: 0x0
// Checksum 0xed71de04, Offset: 0x8e98
// Size: 0x72
function supplydrophelistartpath_v2_part2_local(goal, goalpath, goal_local_offset) {
    direction = goal - goalpath.start;
    goalpath.path = [];
    goalpath.path[0] = addoffsetontopoint(goal, direction, goal_local_offset);
}

// Namespace supplydrop/supplydrop
// Params 3, eflags: 0x0
// Checksum 0xf9e7e9d5, Offset: 0x8f18
// Size: 0x46
function supplydrophelistartpath_v2_part2(goal, goalpath, goal_world_offset) {
    goalpath.path = [];
    goalpath.path[0] = goal + goal_world_offset;
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0x1028ee45, Offset: 0x8f68
// Size: 0x306
function supplydrophelistartpath(goal, goal_offset) {
    total_tries = 12;
    tries = 0;
    goalpath = spawnstruct();
    drop_direction = getdropdirection();
    while (tries < total_tries) {
        goalpath.start = gethelistart(goal, drop_direction);
        goalpath.path = airsupport::gethelipath(goalpath.start, goal);
        startnoflyzones = airsupport::insidenoflyzones(goalpath.start, 0);
        if (isdefined(goalpath.path) && startnoflyzones.size == 0) {
            if (goalpath.path.size > 1) {
                direction = goalpath.path[goalpath.path.size - 1] - goalpath.path[goalpath.path.size - 2];
            } else {
                direction = goalpath.path[goalpath.path.size - 1] - goalpath.start;
            }
            goalpath.path[goalpath.path.size - 1] = addoffsetontopoint(goalpath.path[goalpath.path.size - 1], direction, goal_offset);
            /#
                sphere(goalpath.path[goalpath.path.size - 1], 10, (0, 0, 1), 1, 1, 10, 1000);
            #/
            return goalpath;
        }
        drop_direction = getnextdropdirection(drop_direction, 30);
        tries++;
    }
    drop_direction = getdropdirection();
    goalpath.start = gethelistart(goal, drop_direction);
    direction = goal - goalpath.start;
    goalpath.path = [];
    goalpath.path[0] = addoffsetontopoint(goal, direction, goal_offset);
    return goalpath;
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0xffdb1bc7, Offset: 0x9278
// Size: 0x8a
function supplydropheliendpath_v2(start, var_981b9b57) {
    goalpath = spawnstruct();
    goalpath.start = start;
    goal = helicopter::getvalidrandomleavenode(start, var_981b9b57).origin;
    goalpath.path = [];
    goalpath.path[0] = goal;
    return goalpath;
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0x35986d32, Offset: 0x9310
// Size: 0x1be
function supplydropheliendpath(origin, drop_direction) {
    total_tries = 5;
    tries = 0;
    goalpath = spawnstruct();
    while (tries < total_tries) {
        goal = getheliend(origin, drop_direction);
        goalpath.path = airsupport::gethelipath(origin, goal);
        if (isdefined(goalpath.path)) {
            return goalpath;
        }
        tries++;
    }
    leave_nodes = getentarray("heli_leave", "targetname");
    foreach (node in leave_nodes) {
        goalpath.path = airsupport::gethelipath(origin, node.origin);
        if (isdefined(goalpath.path)) {
            return goalpath;
        }
    }
    goalpath.path = [];
    goalpath.path[0] = getheliend(origin, drop_direction);
    return goalpath;
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0xd6998981, Offset: 0x94d8
// Size: 0x352
function inccratekillstreakusagestat(weapon, killstreak_id) {
    if (weapon == level.weaponnone) {
        return;
    }
    switch (weapon.name) {
    case #"turret_drop":
        self killstreaks::play_killstreak_start_dialog("turret_drop", self.pers[#"team"], killstreak_id);
        break;
    case #"tow_turret_drop":
        self killstreaks::play_killstreak_start_dialog("tow_turret_drop", self.pers[#"team"], killstreak_id);
        break;
    case #"supplydrop_marker":
    case #"inventory_supplydrop_marker":
        self killstreaks::play_killstreak_start_dialog("supply_drop", self.pers[#"team"], killstreak_id);
        level thread popups::displaykillstreakteammessagetoall("supply_drop", self);
        self challenges::calledincarepackage();
        self stats::function_4f10b697(getweapon(#"supplydrop"), #"used", 1);
        break;
    case #"tank_robot":
    case #"inventory_tank_robot":
        self killstreaks::play_killstreak_start_dialog("tank_robot", self.pers[#"team"], killstreak_id);
        level thread popups::displaykillstreakteammessagetoall("tank_robot", self);
        self stats::function_4f10b697(getweapon(#"tank_robot"), #"used", 1);
        break;
    case #"inventory_minigun_drop":
    case #"minigun_drop":
        self killstreaks::play_killstreak_start_dialog("minigun", self.pers[#"team"], killstreak_id);
        break;
    case #"m32_drop":
    case #"inventory_m32_drop":
        self killstreaks::play_killstreak_start_dialog("m32", self.pers[#"team"], killstreak_id);
        break;
    case #"combat_robot_drop":
        level thread popups::displaykillstreakteammessagetoall("combat_robot", self);
        break;
    }
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x6646a284, Offset: 0x9838
// Size: 0x8c
function markercleanupthread(context) {
    player = self;
    player waittill(#"death", #"disconnect", #"joined_team", #"joined_spectators", #"cleanup_marker");
    cleanup(context, player);
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x98c2bd7d, Offset: 0x98d0
// Size: 0x9a
function getchopperdroppoint(context) {
    chopper = self;
    return isdefined(context.droptag) ? chopper gettagorigin(context.droptag) + rotatepoint(isdefined(context.droptagoffset) ? context.droptagoffset : (0, 0, 0), chopper.angles) : chopper.origin;
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x4
// Checksum 0x8e06db10, Offset: 0x9978
// Size: 0xae
function private function_c544ed11(drop_origin, context) {
    if (ispointonnavmesh(drop_origin, context.dist_from_boundary)) {
        /#
            recordsphere(drop_origin + (0, 0, 10), 2, (0, 1, 0), "<dev string:xaf>");
        #/
        return true;
    }
    /#
        recordsphere(drop_origin + (0, 0, 10), 2, (1, 0, 0), "<dev string:xaf>");
    #/
    return false;
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x4
// Checksum 0xabdd0bea, Offset: 0x9a30
// Size: 0x96
function private function_3733773(tacpoint, context) {
    if (tacpoint.ceilingheight >= 4000) {
        /#
            recordsphere(tacpoint.origin, 2, (0, 1, 0), "<dev string:xaf>");
        #/
        return true;
    }
    /#
        recordsphere(tacpoint.origin, 2, (1, 0, 0), "<dev string:xaf>");
    #/
    return false;
}

// Namespace supplydrop/supplydrop
// Params 3, eflags: 0x4
// Checksum 0x5821a10c, Offset: 0x9ad0
// Size: 0x11c
function private function_da52d234(drop_origin, context, drop_height) {
    if (isdefined(level.var_6fb48cdb) && level.var_6fb48cdb) {
        heli_drop_goal = (drop_origin[0], drop_origin[1], drop_origin[2] + drop_height);
        var_6f7637e2 = ispointinnavvolume(heli_drop_goal, "navvolume_big");
        if (var_6f7637e2) {
            /#
                recordsphere(drop_origin + (0, 0, 20), 2, (0, 1, 0), "<dev string:xaf>");
            #/
            return true;
        }
        /#
            recordsphere(drop_origin + (0, 0, 20), 2, (1, 0, 0), "<dev string:xaf>");
        #/
        return false;
    }
    return true;
}

// Namespace supplydrop/supplydrop
// Params 3, eflags: 0x4
// Checksum 0x1d213595, Offset: 0x9bf8
// Size: 0x168
function private function_8ae2ceee(drop_origin, context, drop_height) {
    mask = 1;
    radius = 30;
    heli_drop_goal = (drop_origin[0], drop_origin[1], drop_origin[2] + drop_height);
    trace = physicstrace(heli_drop_goal, drop_origin + (0, 0, 10), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);
    if (trace[#"fraction"] < 1) {
        /#
            recordsphere(drop_origin + (0, 0, 20), 2, (1, 0, 0), "<dev string:xaf>");
        #/
        return false;
    }
    /#
        recordsphere(drop_origin + (0, 0, 20), 2, (0, 1, 0), "<dev string:xaf>");
    #/
    return true;
}

// Namespace supplydrop/supplydrop
// Params 3, eflags: 0x4
// Checksum 0x6d7c3140, Offset: 0x9d68
// Size: 0x130
function private function_78327378(tacpoints, context, drop_height) {
    assert(isdefined(tacpoints) && tacpoints.size);
    filteredpoints = [];
    foreach (tacpoint in tacpoints) {
        if (function_3733773(tacpoint, context) && function_c544ed11(tacpoint.origin, context) && function_da52d234(tacpoint.origin, context, drop_height)) {
            filteredpoints[filteredpoints.size] = tacpoint.origin;
        }
    }
    return filteredpoints;
}

// Namespace supplydrop/supplydrop
// Params 3, eflags: 0x0
// Checksum 0x481b7c93, Offset: 0x9ea0
// Size: 0xf2
function function_3da41164(origins, context, drop_height) {
    assert(isdefined(origins) && origins.size);
    filteredpoints = [];
    foreach (origin in origins) {
        if (function_8ae2ceee(origin, context, drop_height)) {
            filteredpoints[filteredpoints.size] = origin;
            break;
        }
        waitframe(1);
    }
    return filteredpoints;
}

// Namespace supplydrop/supplydrop
// Params 3, eflags: 0x0
// Checksum 0xee959f35, Offset: 0x9fa0
// Size: 0x246
function function_45eea428(drop_origin, drop_height, context) {
    if (getdvarint(#"hash_458cd0a10d30cedb", 1)) {
        if (function_c544ed11(drop_origin, context) && function_da52d234(drop_origin, context, drop_height)) {
            if (function_8ae2ceee(drop_origin, context, drop_height)) {
                return drop_origin;
            }
        }
        cylinder = ai::t_cylinder(drop_origin, 500, 30);
        tacpoints = tacticalquery("supply_drop_deploy", drop_origin, cylinder);
        if (isdefined(tacpoints) && tacpoints.size) {
            tacpoints = function_78327378(tacpoints, context, drop_height);
            waitframe(1);
            if (tacpoints.size) {
                tacpoints = arraysortclosest(tacpoints, drop_origin);
                filteredpoints = function_3da41164(tacpoints, context, drop_height);
                if (isdefined(filteredpoints[0])) {
                    /#
                        recordsphere(filteredpoints[0] + (0, 0, 70), 4, (1, 0.5, 0), "<dev string:xaf>");
                    #/
                    return filteredpoints[0];
                } else {
                    var_2a9ea29a = arraygetclosest(drop_origin, tacpoints);
                    /#
                        recordsphere(var_2a9ea29a + (0, 0, 70), 4, (0, 1, 1), "<dev string:xaf>");
                    #/
                    return var_2a9ea29a;
                }
            }
        }
    }
    return drop_origin;
}

// Namespace supplydrop/supplydrop
// Params 4, eflags: 0x0
// Checksum 0x79118699, Offset: 0xa1f0
// Size: 0x156
function function_9413ce6e(chopper, heli_drop_goal, drop_height, original_drop_origin) {
    chopper endon(#"death", #"drop_goal");
    if (getdvarint(#"hash_458cd0a10d30cedb", 1)) {
        drop_origin = (heli_drop_goal[0], heli_drop_goal[1], heli_drop_goal[2] - drop_height);
        while (true) {
            /#
                recordsphere(original_drop_origin, 4, (1, 0, 0), "<dev string:xaf>");
                recordsphere(drop_origin, 4, (1, 0.5, 0), "<dev string:xaf>");
                recordsphere(heli_drop_goal, 4, (0, 0, 1), "<dev string:xaf>");
                recordline(drop_origin, heli_drop_goal, (0, 0, 1), "<dev string:xaf>");
            #/
            waitframe(1);
        }
    }
}

// Namespace supplydrop/supplydrop
// Params 7, eflags: 0x0
// Checksum 0xf354bfc4, Offset: 0xa350
// Size: 0x13b4
function helidelivercrate(origin, weapon, owner, team, killstreak_id, package_contents_id, context) {
    if (owner emp::enemyempactive() && !owner hasperk(#"specialty_immuneemp")) {
        killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
        self notify(#"cleanup_marker");
        return;
    }
    /#
        if (getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
            level notify(#"stop_heli_drop_valid_location_marked_cylinder");
            level notify(#"stop_heli_drop_valid_location_arrived_at_goal_cylinder");
            level notify(#"stop_heli_drop_valid_location_dropped_cylinder");
            util::drawcylinder(origin, context.radius, 8000, 99999999, "<dev string:xb6>", (0.4, 0, 0.4), 0.8);
        }
    #/
    origin = self.markerposition;
    if (isdefined(context.marker)) {
        origin = context.marker.origin;
    }
    if (!isdefined(context.var_b9e1781a) || !context.var_b9e1781a) {
        context.markerfxhandle = spawnfx(level.killstreakcorebundle.fxmarkedlocation, origin + (0, 0, 5), (0, 0, 1), (1, 0, 0));
        context.markerfxhandle.team = owner.team;
        triggerfx(context.markerfxhandle);
    }
    killstreakbundle = isdefined(context.killstreaktype) ? level.killstreakbundle[context.killstreaktype] : undefined;
    ricochetdistance = isdefined(killstreakbundle) ? killstreakbundle.ksricochetdistance : undefined;
    killstreaks::add_ricochet_protection(killstreak_id, owner, origin, ricochetdistance);
    if (isdefined(context.marker)) {
        context.marker.team = owner.team;
        context.marker entityheadicons::destroyentityheadicons();
        context.marker entityheadicons::setentityheadicon(owner.pers[#"team"], owner, context.objective);
    }
    if (isdefined(weapon)) {
        inccratekillstreakusagestat(weapon, killstreak_id);
    }
    rear_hatch_offset_local = getdvarint(#"scr_supplydropoffset", 0);
    drop_origin = origin;
    if (getdvarint(#"hash_458cd0a10d30cedb", 1)) {
        drop_height = 1600;
    } else {
        drop_height = getdropheight(drop_origin);
    }
    drop_height += level.zoffsetcounter * 350;
    level.zoffsetcounter++;
    if (level.zoffsetcounter >= 5) {
        level.zoffsetcounter = 0;
    }
    original_drop_origin = drop_origin;
    if (!getdvarint(#"hash_7ccc40e85206e0a5", 1)) {
        drop_origin = function_45eea428(drop_origin, drop_height, context);
    } else if (!function_da52d234(drop_origin, context, drop_height)) {
        killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
        self notify(#"cleanup_marker");
        return;
    }
    adddroplocation(killstreak_id, drop_origin);
    if (getdvarint(#"hash_458cd0a10d30cedb", 1)) {
        if (!isvec(drop_origin)) {
            drop_origin = original_drop_origin;
        }
        heli_drop_goal = (drop_origin[0], drop_origin[1], drop_origin[2] + drop_height);
    } else {
        heli_drop_goal = (drop_origin[0], drop_origin[1], drop_height);
    }
    goalpath = undefined;
    if (level.var_6fb48cdb) {
        if (isdefined(context.dropoffset)) {
            goalpath = supplydrophelistartpath_v2_setup(heli_drop_goal, context.dropoffset, 0);
            supplydrophelistartpath_v2_part2_local(heli_drop_goal, goalpath, context.dropoffset);
        } else {
            goalpath = supplydrophelistartpath_v2_setup(heli_drop_goal, (rear_hatch_offset_local, 0, 0), 0);
            goal_path_setup_needs_finishing = 1;
        }
    } else if (isdefined(context.dropoffset)) {
        goalpath = supplydrophelistartpath_v2_setup(heli_drop_goal, context.dropoffset, 1);
        supplydrophelistartpath_v2_part2_local(heli_drop_goal, goalpath, context.dropoffset);
    } else {
        goalpath = supplydrophelistartpath_v2_setup(heli_drop_goal, (rear_hatch_offset_local, 0, 0), 1);
        goal_path_setup_needs_finishing = 1;
    }
    spawn_angles = vectortoangles((heli_drop_goal[0], heli_drop_goal[1], 0) - (goalpath.start[0], goalpath.start[1], 0));
    if (isdefined(context.vehiclename)) {
        helicoptervehicleinfo = context.vehiclename;
    } else {
        helicoptervehicleinfo = level.vtoldrophelicoptervehicleinfo;
    }
    chopper = spawn_helicopter(owner, team, goalpath.start, spawn_angles, helicoptervehicleinfo, "", killstreak_id, context);
    chopper thread function_9413ce6e(chopper, heli_drop_goal, drop_height, original_drop_origin);
    if (level.var_6fb48cdb) {
        chopper makesentient();
        chopper makepathfinder();
        chopper.ignoreme = 1;
        chopper.ignoreall = 1;
        chopper setneargoalnotifydist(40);
        chopper.goalradius = 40;
        if (goal_path_setup_needs_finishing === 1) {
            goal_world_offset = chopper.origin - chopper getchopperdroppoint(context);
            supplydrophelistartpath_v2_part2(heli_drop_goal, goalpath, goal_world_offset);
            goal_path_setup_needs_finishing = 0;
        }
    } else if (goal_path_setup_needs_finishing === 1) {
        goal_world_offset = chopper.origin - chopper getchopperdroppoint(context);
        supplydrophelistartpath_v2_part2(heli_drop_goal, goalpath, goal_world_offset);
        goal_path_setup_needs_finishing = 0;
    }
    waitforonlyonedroplocation = 0;
    while (level.droplocations.size > 1 && waitforonlyonedroplocation) {
        arrayremovevalue(level.droplocations, undefined);
        wait_for_drop = 0;
        foreach (id, droplocation in level.droplocations) {
            if (id < killstreak_id) {
                wait_for_drop = 1;
                break;
            }
        }
        if (wait_for_drop) {
            wait 0.5;
            continue;
        }
        break;
    }
    chopper.killstreakweaponname = weapon.name;
    if (isdefined(context) && isdefined(context.hasflares)) {
        chopper.numflares = 3;
        chopper.flareoffset = (0, 0, 0);
        chopper thread helicopter::create_flare_ent((0, 0, -50));
    } else {
        chopper.numflares = 0;
    }
    killcament = spawn("script_model", chopper.origin + (0, 0, 800));
    killcament.angles = (100, chopper.angles[1], chopper.angles[2]);
    killcament.starttime = gettime();
    killcament linkto(chopper);
    if (!isdefined(chopper)) {
        return;
    }
    if (isdefined(context) && isdefined(context.prolog)) {
        chopper [[ context.prolog ]](context);
    } else if (getdvarint(#"hash_458cd0a10d30cedb", 1)) {
        chopper thread helidropcrate(level.killstreakweapons[weapon], owner, rear_hatch_offset_local, killcament, killstreak_id, package_contents_id, context, drop_origin);
    } else {
        chopper thread helidropcrate(level.killstreakweapons[weapon], owner, rear_hatch_offset_local, killcament, killstreak_id, package_contents_id, context);
    }
    chopper endon(#"death");
    if (level.var_6fb48cdb) {
        chopper thread airsupport::function_9eab754a(goalpath.path, "drop_goal", 1);
    } else {
        chopper thread airsupport::followpath(goalpath.path, "drop_goal", 1);
    }
    chopper thread speedregulator(heli_drop_goal);
    target_set(chopper, (0, 0, 50));
    chopper waittill(#"drop_goal");
    chopper thread function_d361ecb9(15);
    if (isdefined(owner)) {
        owner notify(#"payload_delivered");
    }
    if (isdefined(context) && isdefined(context.epilog)) {
        chopper [[ context.epilog ]](context);
    }
    /#
        println("<dev string:xe4>" + gettime() - chopper.spawntime);
        if (getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
            if (isdefined(context.dropoffset)) {
                chopper_drop_point = chopper.origin - rotatepoint(context.dropoffset, chopper.angles);
            } else {
                chopper_drop_point = chopper getchopperdroppoint(context);
            }
            trace = groundtrace(chopper_drop_point + (0, 0, -100), chopper_drop_point + (0, 0, -10000), 0, undefined, 0);
            debug_drop_location = trace[#"position"];
            util::drawcylinder(debug_drop_location, context.radius, 8000, 99999999, "<dev string:xfc>", (1, 0.6, 0), 0.9);
            iprintln("<dev string:x133>" + distance2d(chopper_drop_point, heli_drop_goal));
        }
    #/
    on_target = 0;
    last_distance_from_goal_squared = 1e+07 * 1e+07;
    continue_waiting = 1;
    for (remaining_tries = 30; continue_waiting && remaining_tries > 0; remaining_tries--) {
        if (isdefined(context.dropoffset)) {
            chopper_drop_point = chopper.origin - rotatepoint(context.dropoffset, chopper.angles);
        } else {
            chopper_drop_point = chopper getchopperdroppoint(context);
        }
        current_distance_from_goal_squared = distance2dsquared(chopper_drop_point, heli_drop_goal);
        continue_waiting = current_distance_from_goal_squared < last_distance_from_goal_squared && current_distance_from_goal_squared > 3.7 * 3.7;
        last_distance_from_goal_squared = current_distance_from_goal_squared;
        /#
            if (getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
                sphere(chopper_drop_point, 8, (1, 0, 0), 0.9, 0, 20, 1);
            }
        #/
        if (continue_waiting) {
            /#
                if (getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
                    iprintln("<dev string:x152>" + distance2d(chopper_drop_point, heli_drop_goal));
                }
            #/
            waitframe(1);
        }
    }
    /#
        if (getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
            iprintln("<dev string:x164>" + distance2d(chopper_drop_point, heli_drop_goal));
        }
    #/
    chopper notify(#"drop_crate", {#position:chopper.origin, #direction:chopper.angles, #owner:chopper.owner});
    chopper.droptime = gettime();
    chopper playsound(#"veh_supply_drop");
    wait 0.7;
    if (isdefined(level.killstreakweapons[weapon])) {
        chopper killstreaks::play_pilot_dialog_on_owner("waveStartFinal", level.killstreakweapons[weapon], chopper.killstreak_id);
    }
    /#
        chopper util::debug_slow_heli_speed();
    #/
    if (level.var_6fb48cdb) {
        if (!issentient(chopper)) {
            chopper makesentient();
        }
        if (!ispathfinder(chopper)) {
            chopper makepathfinder();
        }
        chopper.ignoreme = 1;
        chopper.ignoreall = 1;
        goalpath = supplydropheliendpath_v2(chopper.origin, 0);
        chopper airsupport::function_9eab754a(goalpath.path, undefined, 1, 1);
    } else {
        goalpath = supplydropheliendpath_v2(chopper.origin, 1);
        chopper airsupport::followpath(goalpath.path, undefined, 0);
    }
    println("<dev string:x183>" + gettime() - chopper.droptime);
    chopper notify(#"leaving");
    chopper delete();
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x461f7b45, Offset: 0xb710
// Size: 0x4c
function function_d361ecb9(delay) {
    wait delay;
    if (!isdefined(self)) {
        return;
    }
    if (target_istarget(self)) {
        target_remove(self);
    }
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x6f57c468, Offset: 0xb768
// Size: 0xcc
function speedregulator(goal) {
    self endon(#"drop_goal");
    self endon(#"death");
    /#
        self util::debug_slow_heli_speed();
    #/
    maxpitch = getdvarint(#"scr_supplydropmaxpitch", 25);
    maxroll = getdvarint(#"scr_supplydropmaxroll", 35);
    self setmaxpitchroll(maxpitch, maxroll);
}

// Namespace supplydrop/supplydrop
// Params 8, eflags: 0x0
// Checksum 0x9c9667d4, Offset: 0xb840
// Size: 0x55c
function helidropcrate(killstreak, originalowner, offset, killcament, killstreak_id, package_contents_id, context, var_18a1b881) {
    helicopter = self;
    originalowner endon(#"disconnect");
    crate = cratespawn(killstreak, killstreak_id, originalowner, self.team, self.origin, self.angles, undefined, context);
    if (killstreak == "inventory_supply_drop" || killstreak == "supply_drop") {
        crate linkto(helicopter, isdefined(context.droptag) ? context.droptag : "tag_origin", isdefined(context.droptagoffset) ? context.droptagoffset : (0, 0, 0));
        helicopter clientfield::set("supplydrop_care_package_state", 1);
    } else if (killstreak == "inventory_tank_robot" || killstreak == "tank_robot" || killstreak == "ai_tank_marker") {
        crate linkto(helicopter, isdefined(context.droptag) ? context.droptag : "tag_origin", isdefined(context.droptagoffset) ? context.droptagoffset : (0, 0, 0));
        helicopter clientfield::set("supplydrop_ai_tank_state", 1);
    }
    team = self.team;
    waitresult = helicopter waittill(#"drop_crate", #"hash_525537be2de4c159");
    chopperowner = waitresult.owner;
    origin = waitresult.position;
    angles = waitresult.direction;
    if (waitresult._notify == #"hash_525537be2de4c159") {
        crate cratedelete(0);
        return;
    }
    if (isdefined(chopperowner)) {
        owner = chopperowner;
        if (owner != originalowner) {
            crate killstreaks::configure_team(killstreak, owner);
            killstreaks::remove_ricochet_protection(killstreak_id, owner);
        }
    } else {
        owner = originalowner;
    }
    if (isdefined(self)) {
        team = self.team;
        if (killstreak == "inventory_supply_drop" || killstreak == "supply_drop") {
            helicopter clientfield::set("supplydrop_care_package_state", 0);
        } else if (killstreak == "inventory_tank_robot" || killstreak == "tank_robot") {
            helicopter clientfield::set("supplydrop_ai_tank_state", 0);
        }
        enemy = helicopter.owner battlechatter::get_closest_player_enemy(helicopter.origin, 1);
        enemyradius = battlechatter::mpdialog_value("supplyDropRadius", 0);
        if (isdefined(enemy) && distance2dsquared(origin, enemy.origin) < enemyradius * enemyradius) {
            enemy thread battlechatter::play_killstreak_threat(killstreak);
        }
    }
    if (team == owner.team) {
        rear_hatch_offset_height = getdvarint(#"scr_supplydropoffsetheight", 200);
        rear_hatch_offset_world = rotatepoint((offset, 0, 0), angles);
        drop_origin = origin - (0, 0, rear_hatch_offset_height) - rear_hatch_offset_world;
        thread dropcrate(drop_origin, angles, killstreak, owner, team, killcament, killstreak_id, package_contents_id, crate, context, var_18a1b881);
    }
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0xcd1e4d5f, Offset: 0xbda8
// Size: 0x144
function helidestroyed() {
    self endon(#"leaving");
    self endon(#"helicopter_gone");
    self endon(#"death");
    while (true) {
        if (self.damagetaken > self.maxhealth) {
            break;
        }
        waitframe(1);
    }
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.owner)) {
        self.owner notify(#"payload_fail");
    }
    self setspeed(25, 5);
    wait randomfloatrange(0.5, 1.5);
    self notify(#"hash_525537be2de4c159", {#position:self.origin, #direction:self.angles, #owner:self.owner});
    lbexplode();
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x0
// Checksum 0x9b9fb264, Offset: 0xbef8
// Size: 0xfc
function lbexplode() {
    forward = self.origin + (0, 0, 1) - self.origin;
    playfx(level.chopper_fx[#"explode"][#"death"], self.origin, forward);
    self playsound(level.heli_sound[#"crash"]);
    self notify(#"explode");
    if (isdefined(self.delete_after_destruction_wait_time)) {
        self hide();
        self waitanddelete(self.delete_after_destruction_wait_time);
        return;
    }
    self delete();
}

// Namespace supplydrop/supplydrop
// Params 1, eflags: 0x0
// Checksum 0x47a38b3e, Offset: 0xc000
// Size: 0x11e
function lbspin(speed) {
    self endon(#"explode");
    playfxontag(level.chopper_fx[#"explode"][#"large"], self, "tail_rotor_jnt");
    playfxontag(level.chopper_fx[#"fire"][#"trail"][#"large"], self, "tail_rotor_jnt");
    self setyawspeed(speed, speed, speed);
    while (isdefined(self)) {
        self settargetyaw(self.angles[1] + speed * 0.9);
        wait 1;
    }
}

// Namespace supplydrop/supplydrop
// Params 2, eflags: 0x0
// Checksum 0xf54da17e, Offset: 0xc128
// Size: 0x5e
function refcountdecchopper(team, killstreak_id) {
    self waittill(#"death");
    killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
    self notify(#"cleanup_marker");
}

/#

    // Namespace supplydrop/supplydrop
    // Params 0, eflags: 0x0
    // Checksum 0xab7de939, Offset: 0xc190
    // Size: 0x82
    function supply_drop_dev_gui() {
        setdvar(#"scr_supply_drop_gui", "<dev string:x61>");
        while (true) {
            wait 0.5;
            devgui_string = getdvarstring(#"scr_supply_drop_gui");
            level.dev_gui_supply_drop = devgui_string;
        }
    }

#/
