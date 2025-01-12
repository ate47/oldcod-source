#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damage;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\targetting_delay;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\flak_drone;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\heatseekingmissile;

#namespace helicopter;

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x85e6a2f3, Offset: 0x670
// Size: 0x5ac
function init_shared(bundle_name) {
    if (!isdefined(level.helicopter_shared)) {
        level.helicopter_shared = {};
        airsupport::init_shared();
        flak_drone::init_shared();
        path_start = getentarray("heli_start", "targetname");
        loop_start = getentarray("heli_loop_start", "targetname");
        /#
            debug_refresh = 1;
        #/
        thread heli_update_global_dvars(debug_refresh);
        level.chaff_offset[#"attack"] = (-130, 0, -140);
        level.choppercomlinkfriendly = #"veh_t7_drone_hunter";
        level.choppercomlinkenemy = #"hash_7948c5263c738621";
        level.chopperregular = #"hash_7948c5263c738621";
        precachehelicopter(level.chopperregular);
        clientfield::register("vehicle", "heli_comlink_bootup_anim", 1, 1, "int");
        clientfield::register("vehicle", "heli_warn_targeted", 1, 1, "int");
        clientfield::register("vehicle", "heli_warn_locked", 1, 1, "int");
        clientfield::register("vehicle", "heli_warn_fired", 1, 1, "int");
        clientfield::register("vehicle", "active_camo", 1, 3, "int");
        level.heli_paths = [];
        level.heli_loop_paths = [];
        level.heli_startnodes = [];
        level.heli_leavenodes = [];
        level.heli_crash_paths = [];
        level.last_start_node_index = 0;
        level.chopper_fx[#"explode"][#"death"] = "killstreaks/fx_heli_exp_lg";
        level.chopper_fx[#"explode"][#"guard"] = "killstreaks/fx_heli_exp_md";
        level.chopper_fx[#"explode"][#"gunner"] = "killstreaks/fx_vtol_exp";
        level.chopper_fx[#"explode"][#"large"] = "killstreaks/fx_heli_exp_sm";
        level.chopper_fx[#"damage"][#"light_smoke"] = "destruct/fx8_atk_chppr_smk_trail";
        level.chopper_fx[#"damage"][#"heavy_smoke"] = "destruct/fx8_atk_chppr_exp_trail";
        level.chopper_fx[#"smoke"][#"trail"] = "destruct/fx8_atk_chppr_exp_trail";
        level.chopper_fx[#"fire"][#"trail"][#"large"] = "killstreaks/fx_heli_smk_trail_engine";
        level._effect[#"heli_comlink_light"][#"friendly"] = #"hash_33eb8912b6c63ecd";
        level._effect[#"heli_comlink_light"][#"enemy"] = #"hash_33eb8912b6c63ecd";
        bundle = struct::get_script_bundle("killstreak", bundle_name);
        killstreaks::register_bundle(bundle, &usekillstreakhelicopter);
        killstreaks::set_team_kill_penalty_scale("helicopter_comlink", 0);
        level.killstreakbundle[#"helicopter_comlink"] = bundle;
        level.killstreaks[#"helicopter_comlink"].threatonkill = 1;
        if (!path_start.size && !loop_start.size) {
            return;
        }
        heli_path_graph();
    }
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x5f3350b6, Offset: 0xc28
// Size: 0x172
function precachehelicopter(model) {
    level.vehicle_deathmodel[model] = model;
    level.heli_sound[#"hit"] = #"evt_helicopter_hit";
    level.heli_sound[#"hitsecondary"] = #"evt_helicopter_hit";
    level.heli_sound[#"damaged"] = #"null";
    level.heli_sound[#"spinloop"] = #"evt_helicopter_spin_loop";
    level.heli_sound[#"spinstart"] = #"evt_helicopter_spin_start";
    level.heli_sound[#"crash"] = #"evt_helicopter_midair_exp";
    level.heli_sound[#"missilefire"] = #"wpn_hellfire_fire_npc";
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0xdcc80f5, Offset: 0xda8
// Size: 0x24
function function_75f79c69() {
    self beginlocationcomlinkselection("map_mortar_selector");
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x441444be, Offset: 0xdd8
// Size: 0x2d0
function usekillstreakhelicopter(hardpointtype) {
    if (self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0) {
        return false;
    }
    if (!isdefined(level.heli_paths) || !level.heli_paths.size) {
        /#
            iprintlnbold("<dev string:x30>");
        #/
        return false;
    }
    if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
        level.helilocation = self.origin;
    }
    destination = 0;
    missilesenabled = 0;
    if (hardpointtype == "helicopter_x2") {
        missilesenabled = 1;
    }
    assert(level.heli_paths.size > 0, "<dev string:x5a>");
    random_path = randomint(level.heli_paths[destination].size);
    startnode = level.heli_paths[destination][random_path];
    protectlocation = undefined;
    armored = 0;
    if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
        protectlocation = (level.helilocation[0], level.helilocation[1], int(airsupport::getminimumflyheight()));
        armored = 0;
        startnode = getvalidprotectlocationstart(random_path, protectlocation, destination);
    }
    killstreak_id = self killstreakrules::killstreakstart(hardpointtype, self.team);
    if (killstreak_id == -1) {
        return false;
    }
    if (isdefined(level.var_63b9b5b1)) {
        self [[ level.var_63b9b5b1 ]](hardpointtype);
    }
    self killstreaks::play_killstreak_start_dialog(hardpointtype, self.team, killstreak_id);
    self thread announcehelicopterinbound(hardpointtype);
    thread heli_think(self, startnode, self.team, missilesenabled, protectlocation, hardpointtype, armored, killstreak_id);
    return true;
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0xb10d025c, Offset: 0x10b0
// Size: 0x54
function announcehelicopterinbound(hardpointtype) {
    team = self.team;
    self stats::function_4f10b697(killstreaks::get_killstreak_weapon(hardpointtype), #"used", 1);
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0xa32fb9c8, Offset: 0x1110
// Size: 0x714
function heli_path_graph() {
    path_start = getentarray("heli_start", "targetname");
    path_dest = getentarray("heli_dest", "targetname");
    loop_start = getentarray("heli_loop_start", "targetname");
    gunner_loop_start = getentarray("heli_gunner_loop_start", "targetname");
    leave_nodes = getentarray("heli_leave", "targetname");
    crash_start = getentarray("heli_crash_start", "targetname");
    assert(isdefined(path_start) && isdefined(path_dest), "<dev string:x87>");
    for (i = 0; i < path_dest.size; i++) {
        startnode_array = [];
        isprimarydest = 0;
        destnode_pointer = path_dest[i];
        destnode = getent(destnode_pointer.target, "targetname");
        for (j = 0; j < path_start.size; j++) {
            todest = 0;
            for (currentnode = path_start[j]; isdefined(currentnode.target); currentnode = nextnode) {
                nextnode = getent(currentnode.target, "targetname");
                if (nextnode.origin == destnode.origin) {
                    todest = 1;
                    break;
                }
                /#
                    airsupport::debug_print3d_simple("<dev string:xa7>", currentnode, (0, 0, -10));
                    if (isdefined(nextnode.target)) {
                        airsupport::debug_line(nextnode.origin, getent(nextnode.target, "<dev string:xa9>").origin, (0.25, 0.5, 0.25), 5);
                    }
                    if (isdefined(currentnode.script_delay)) {
                        airsupport::debug_print3d_simple("<dev string:xb4>" + currentnode.script_delay, currentnode, (0, 0, 10));
                    }
                #/
            }
            if (todest) {
                startnode_array[startnode_array.size] = getent(path_start[j].target, "targetname");
                if (isdefined(path_start[j].script_noteworthy) && path_start[j].script_noteworthy == "primary") {
                    isprimarydest = 1;
                }
            }
        }
        assert(isdefined(startnode_array) && startnode_array.size > 0, "<dev string:xbb>");
        if (isprimarydest) {
            level.heli_primary_path = startnode_array;
            continue;
        }
        level.heli_paths[level.heli_paths.size] = startnode_array;
    }
    for (i = 0; i < loop_start.size; i++) {
        startnode = getent(loop_start[i].target, "targetname");
        level.heli_loop_paths[level.heli_loop_paths.size] = startnode;
    }
    assert(isdefined(level.heli_loop_paths[0]), "<dev string:xd5>");
    for (i = 0; i < gunner_loop_start.size; i++) {
        startnode = getent(gunner_loop_start[i].target, "targetname");
        startnode.isgunnerpath = 1;
        level.heli_loop_paths[level.heli_loop_paths.size] = startnode;
    }
    for (i = 0; i < path_start.size; i++) {
        if (isdefined(path_start[i].script_noteworthy) && path_start[i].script_noteworthy == "primary") {
            continue;
        }
        level.heli_startnodes[level.heli_startnodes.size] = path_start[i];
    }
    assert(isdefined(level.heli_startnodes[0]), "<dev string:xfb>");
    for (i = 0; i < leave_nodes.size; i++) {
        level.heli_leavenodes[level.heli_leavenodes.size] = leave_nodes[i];
    }
    assert(isdefined(level.heli_leavenodes[0]), "<dev string:x122>");
    for (i = 0; i < crash_start.size; i++) {
        crash_start_node = getent(crash_start[i].target, "targetname");
        level.heli_crash_paths[level.heli_crash_paths.size] = crash_start_node;
    }
    assert(isdefined(level.heli_crash_paths[0]), "<dev string:x149>");
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x81ecf456, Offset: 0x1830
// Size: 0x80c
function heli_update_global_dvars(debug_refresh) {
    do {
        level.heli_loopmax = getdvar(#"scr_heli_loopmax", 2);
        level.heli_missile_rof = getdvar(#"scr_heli_missile_rof", 2);
        level.heli_armor = getdvar(#"scr_heli_armor", 500);
        level.heli_maxhealth = getdvar(#"scr_heli_maxhealth", 2000);
        level.heli_amored_maxhealth = getdvar(#"scr_heli_armored_maxhealth", 1500);
        level.heli_missile_max = getdvar(#"scr_heli_missile_max", 20);
        level.heli_dest_wait = getdvar(#"scr_heli_dest_wait", 8);
        level.heli_debug = getdvar(#"scr_heli_debug", 0);
        level.heli_debug_crash = getdvar(#"scr_heli_debug_crash", 0);
        level.heli_targeting_delay = getdvar(#"scr_heli_targeting_delay", 0.1);
        level.heli_turretreloadtime = getdvar(#"scr_heli_turretreloadtime", 0.5);
        level.heli_turretclipsize = getdvar(#"scr_heli_turretclipsize", 60);
        level.heli_visual_range = isdefined(level.heli_visual_range_override) ? level.heli_visual_range_override : getdvar(#"scr_heli_visual_range", 3500);
        level.heli_missile_range = getdvar(#"scr_heli_missile_range", 100000);
        level.heli_health_degrade = getdvar(#"scr_heli_health_degrade", 0);
        level.heli_turret_target_cone = getdvar(#"scr_heli_turret_target_cone", 0.6);
        level.heli_target_spawnprotection = getdvar(#"scr_heli_target_spawnprotection", 5);
        level.heli_missile_regen_time = getdvar(#"scr_heli_missile_regen_time", 10);
        level.heli_turret_spinup_delay = getdvar(#"scr_heli_turret_spinup_delay", 0.1);
        level.heli_target_recognition = getdvar(#"scr_heli_target_recognition", 0.2);
        level.heli_missile_friendlycare = getdvar(#"scr_heli_missile_friendlycare", 512);
        level.heli_missile_target_cone = getdvar(#"scr_heli_missile_target_cone", 0.6);
        level.heli_valid_target_cone = getdvar(#"scr_heli_missile_valid_target_cone", 0.7);
        level.heli_armor_bulletdamage = getdvar(#"scr_heli_armor_bulletdamage", 0.5);
        level.heli_attract_strength = getdvar(#"scr_heli_attract_strength", 1000);
        level.heli_attract_range = getdvar(#"scr_heli_attract_range", 20000);
        level.helicopterturretmaxangle = getdvar(#"scr_helicopterturretmaxangle", 50);
        level.var_6fb48cdb = isdefined(getgametypesetting(#"hash_5f76e2d55ad861ed")) && getgametypesetting(#"hash_5f76e2d55ad861ed");
        if (level.var_6fb48cdb) {
            level.heli_protect_time = getdvarint(#"scr_heli_protect_time", 60);
            level.heli_protect_pos_time = getdvarint(#"scr_heli_protect_pos_time", 8);
            level.var_567463c6 = getdvarint(#"hash_26f6fa23a134bc05", 6);
            level.var_3b7f3818 = getdvarint(#"hash_27120423a14b94bb", 8);
            level.heli_protect_radius = getdvarint(#"scr_heli_protect_radius", 1500);
            level.var_7d184855 = getdvarint(#"hash_5681be4514516b7a", 1400);
            level.var_67f9a0bb = getdvarint(#"hash_569da8451469c0d0", 1600);
            level.var_6cbdf51d = getdvarint(#"hash_7e0189d9c55ba919", 350);
        } else {
            level.heli_protect_time = getdvar(#"scr_heli_protect_time", 60);
            level.heli_protect_pos_time = getdvar(#"scr_heli_protect_pos_time", 8);
            level.heli_protect_radius = getdvar(#"scr_heli_protect_radius", 2000);
        }
        level.heli_missile_reload_time = getdvar(#"scr_heli_missile_reload_time", 5);
        level.heli_warning_distance = getdvar(#"scr_heli_warning_distance", 500);
        wait 1;
    } while (isdefined(debug_refresh));
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0x5e2f3709, Offset: 0x2048
// Size: 0xe4
function set_goal_pos(goalpos, stop) {
    if (!isdefined(self)) {
        return;
    }
    self.heligoalpos = goalpos;
    if (level.var_6fb48cdb) {
        if (issentient(self) && ispathfinder(self)) {
            self setgoal(goalpos, stop);
            self function_3c8dce03(goalpos, stop, 1);
        } else {
            self function_3c8dce03(goalpos, stop, 0);
        }
        return;
    }
    self setgoal(goalpos, stop);
}

// Namespace helicopter/helicopter_shared
// Params 8, eflags: 0x0
// Checksum 0xaa6cd23e, Offset: 0x2138
// Size: 0x248
function spawn_helicopter(owner, origin, angles, vehicledef, targetname, target_offset, hardpointtype, killstreak_id) {
    chopper = spawnvehicle(vehicledef, origin, angles);
    chopper setowner(owner);
    chopper.owner = owner;
    chopper clientfield::set("enemyvehicle", 1);
    chopper.attackers = [];
    chopper.attackerdata = [];
    chopper.attackerdamage = [];
    chopper.flareattackerdamage = [];
    chopper.destroyfunc = &destroyhelicopter;
    chopper.hardpointtype = hardpointtype;
    chopper.killstreak_id = killstreak_id;
    chopper.pilotistalking = 0;
    chopper setdrawinfrared(1);
    chopper.allowcontinuedlockonafterinvis = 1;
    chopper.soundmod = "heli";
    chopper.team = owner.team;
    chopper setteam(owner.team);
    if (!isdefined(target_offset)) {
        target_offset = (0, 0, 0);
    }
    chopper.target_offset = target_offset;
    target_set(chopper, target_offset);
    if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
        chopper killstreaks::function_1c47e9c9(hardpointtype);
        chopper.overridevehicledamage = &function_fb780485;
    }
    chopper setrotorspeed(1);
    return chopper;
}

// Namespace helicopter/helicopter_shared
// Params 15, eflags: 0x0
// Checksum 0x55b3a9bb, Offset: 0x2388
// Size: 0xfa
function function_fb780485(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    helicopter = self;
    if (smeansofdeath == "MOD_TRIGGER_HURT") {
        return 0;
    }
    idamage = self killstreaks::ondamageperweapon("helicopter_comlink", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.lowhealth, undefined, 0, undefined, 1, 1);
    return idamage;
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0xeb2f12f4, Offset: 0x2490
// Size: 0x84
function onflakdronedestroyed() {
    chopper = self;
    if (!isdefined(chopper)) {
        return;
    }
    chopper.numflares = 0;
    chopper killstreaks::play_pilot_dialog_on_owner("weaponDestroyed", "helicopter_comlink", chopper.killstreak_id);
    chopper thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", "death");
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x8c039f97, Offset: 0x2520
// Size: 0x50
function explodeoncontact(hardpointtype) {
    self endon(#"death");
    wait 10;
    for (;;) {
        self waittill(#"touch");
        self thread heli_explode();
    }
}

// Namespace helicopter/helicopter_shared
// Params 4, eflags: 0x0
// Checksum 0xba66c020, Offset: 0x2578
// Size: 0x19a
function getvalidprotectlocationstart(random_path, protectlocation, destination, var_981b9b57 = 0) {
    startnode = level.heli_paths[destination][random_path];
    path_index = (random_path + 1) % level.heli_paths[destination].size;
    if (var_981b9b57) {
        innofly = airsupport::crossesnoflyzone(protectlocation + (0, 0, 1), protectlocation);
        if (isdefined(innofly)) {
            protectlocation = (protectlocation[0], protectlocation[1], level.noflyzones[innofly].origin[2] + level.noflyzones[innofly].height);
        }
        noflyzone = airsupport::crossesnoflyzone(startnode.origin, protectlocation);
        while (isdefined(noflyzone) && path_index != random_path) {
            startnode = level.heli_paths[destination][path_index];
            if (isdefined(noflyzone)) {
                path_index = (path_index + 1) % level.heli_paths[destination].size;
            }
        }
    }
    return level.heli_paths[destination][path_index];
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0xd4406f2f, Offset: 0x2720
// Size: 0x21c
function getvalidrandomleavenode(start, var_981b9b57 = 1) {
    if (self === level.vtol) {
        foreach (node in level.heli_leavenodes) {
            if (isdefined(node.script_noteworthy) && node.script_noteworthy == "primary") {
                return node;
            }
        }
    }
    random_leave_node = randomint(level.heli_leavenodes.size);
    leavenode = level.heli_leavenodes[random_leave_node];
    path_index = (random_leave_node + 1) % level.heli_leavenodes.size;
    if (var_981b9b57) {
        noflyzone = airsupport::crossesnoflyzone(leavenode.origin, start);
        isprimary = leavenode.script_noteworthy === "primary";
        while ((isdefined(noflyzone) || isprimary) && path_index != random_leave_node) {
            leavenode = level.heli_leavenodes[path_index];
            noflyzone = airsupport::crossesnoflyzone(leavenode.origin, start);
            isprimary = leavenode.script_noteworthy === "primary";
            path_index = (path_index + 1) % level.heli_leavenodes.size;
        }
    }
    return level.heli_leavenodes[path_index];
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0x418d90da, Offset: 0x2948
// Size: 0x164
function getvalidrandomstartnode(dest, var_981b9b57 = 1) {
    if (!isdefined(level.heli_startnodes) || !level.heli_startnodes.size) {
        return undefined;
    }
    path_index = randomint(level.heli_startnodes.size);
    best_index = path_index;
    if (var_981b9b57) {
        count = 0;
        for (i = 0; i < level.heli_startnodes.size; i++) {
            startnode = level.heli_startnodes[path_index];
            noflyzone = airsupport::crossesnoflyzone(startnode.origin, dest);
            if (!isdefined(noflyzone)) {
                best_index = path_index;
                if (path_index != level.last_start_node_index) {
                    break;
                }
            }
            path_index = (path_index + 1) % level.heli_startnodes.size;
        }
    }
    level.last_start_node_index = best_index;
    return level.heli_startnodes[best_index];
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x6029f471, Offset: 0x2ab8
// Size: 0x114
function getvalidrandomcrashnode(start) {
    random_leave_node = randomint(level.heli_crash_paths.size);
    leavenode = level.heli_crash_paths[random_leave_node];
    path_index = (random_leave_node + 1) % level.heli_crash_paths.size;
    noflyzone = airsupport::crossesnoflyzone(leavenode.origin, start);
    while (isdefined(noflyzone) && path_index != random_leave_node) {
        leavenode = level.heli_crash_paths[path_index];
        noflyzone = airsupport::crossesnoflyzone(leavenode.origin, start);
        path_index = (path_index + 1) % level.heli_crash_paths.size;
    }
    return level.heli_crash_paths[path_index];
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0x3171d6d2, Offset: 0x2bd8
// Size: 0x3c
function configureteampost(owner, ishacked) {
    chopper = self;
    owner thread watchforearlyleave(chopper);
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x430b2a9e, Offset: 0x2c20
// Size: 0xb6
function hackedcallbackpost(hacker) {
    heli = self;
    if (isdefined(heli.flak_drone)) {
        heli.flak_drone flak_drone::configureteam(heli, 1);
    }
    heli.endtime = gettime() + int(killstreak_bundles::get_hack_timeout() * 1000);
    heli.killstreakendtime = int(heli.endtime);
}

// Namespace helicopter/helicopter_shared
// Params 8, eflags: 0x0
// Checksum 0x35fdd9a4, Offset: 0x2ce0
// Size: 0x6cc
function heli_think(owner, startnode, heli_team, missilesenabled, protectlocation, hardpointtype, armored, killstreak_id) {
    heliorigin = startnode.origin;
    heliangles = startnode.angles;
    if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
        choppermodelfriendly = level.choppercomlinkfriendly;
        choppermodelenemy = level.choppercomlinkenemy;
    } else {
        choppermodelfriendly = level.chopperregular;
        choppermodelenemy = level.chopperregular;
    }
    chopper = spawn_helicopter(owner, heliorigin, heliangles, "veh_t8_helicopter_gunship_mp", choppermodelfriendly, (0, 0, 100), hardpointtype, killstreak_id);
    chopper.harpointtype = hardpointtype;
    chopper killstreaks::configure_team(hardpointtype, killstreak_id, owner, "helicopter", undefined, &configureteampost);
    level.vehicle_death_thread[chopper.vehicletype] = level.var_891a0eff;
    if (isdefined(chopper.flak_drone)) {
        chopper.flak_drone flak_drone::configureteam(chopper, 0);
    }
    if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
        chopper killstreak_hacking::enable_hacking("helicopter_comlink", undefined, &hackedcallbackpost);
    }
    chopper thread watchforemp();
    if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
        chopper.defaultweapon = getweapon(#"cobra_20mm_comlink");
    } else {
        chopper.defaultweapon = getweapon(#"cobra_20mm");
    }
    chopper.requireddeathcount = owner.deathcount;
    chopper.chaff_offset = level.chaff_offset[#"attack"];
    minigun_snd_ent = spawn("script_origin", chopper gettagorigin("tag_flash"));
    minigun_snd_ent linkto(chopper, "tag_flash", (0, 0, 0), (0, 0, 0));
    chopper.minigun_snd_ent = minigun_snd_ent;
    minigun_snd_ent thread autostopsound();
    chopper thread heli_existance();
    level.chopper = chopper;
    chopper.reached_dest = 0;
    if (hardpointtype != "helicopter_comlink" && hardpointtype != "inventory_helicopter_comlink") {
        if (armored) {
            chopper.maxhealth = level.heli_amored_maxhealth;
        } else {
            chopper.maxhealth = level.heli_maxhealth;
        }
    }
    if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
        chopper.numflares = 1;
    } else if (hardpointtype == "helicopter_guard") {
        chopper.numflares = 1;
    } else {
        chopper.numflares = 2;
    }
    chopper.flareoffset = (0, 0, -256);
    chopper.waittime = level.heli_dest_wait;
    chopper.loopcount = 0;
    chopper.evasive = 0;
    chopper.health_bulletdamageble = level.heli_armor;
    chopper.health_evasive = level.heli_armor;
    chopper.targeting_delay = level.heli_targeting_delay;
    chopper.primarytarget = undefined;
    chopper.secondarytarget = undefined;
    chopper.attacker = undefined;
    chopper.missile_ammo = level.heli_missile_max;
    chopper.currentstate = "ok";
    chopper.lastrocketfiretime = -1;
    if (isdefined(protectlocation)) {
        chopper thread heli_protect(startnode, protectlocation, hardpointtype, heli_team);
        chopper clientfield::set("heli_comlink_bootup_anim", 1);
    } else {
        chopper thread heli_fly(startnode, 2, hardpointtype);
    }
    if (hardpointtype != "helicopter_comlink") {
        chopper thread heli_damage_monitor(hardpointtype);
    }
    chopper thread wait_for_killed();
    chopper thread heli_health(hardpointtype);
    chopper thread attack_targets(missilesenabled, hardpointtype);
    chopper thread heli_targeting(missilesenabled, hardpointtype);
    chopper thread heli_missile_regen();
    chopper thread targetting_delay::function_3362444f(level.killstreakbundle[#"helicopter_comlink"].var_50d8ae50);
    chopper thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", "death");
    chopper thread create_flare_ent((0, 0, -150));
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x9e60dcc6, Offset: 0x33b8
// Size: 0x44
function autostopsound() {
    self endon(#"death");
    level waittill(#"game_ended");
    self stoploopsound();
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x633a8272, Offset: 0x3408
// Size: 0x3c
function heli_existance() {
    self endon(#"death");
    self waittill(#"leaving");
    self influencers::remove_influencers();
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x5420ed3c, Offset: 0x3450
// Size: 0x94
function create_flare_ent(offset) {
    self.flare_ent = spawn("script_model", self gettagorigin("tag_origin"));
    self.flare_ent setmodel(#"tag_origin");
    self.flare_ent linkto(self, "tag_origin", offset);
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x671bbbac, Offset: 0x34f0
// Size: 0x130
function heli_missile_regen() {
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    for (;;) {
        /#
            airsupport::debug_print3d("<dev string:x170>" + self.missile_ammo, (0.5, 0.5, 1), self, (0, 0, -100), 0);
        #/
        if (self.missile_ammo >= level.heli_missile_max) {
            self waittill(#"missile fired");
        } else if (self.currentstate == "heavy smoke") {
            wait level.heli_missile_regen_time / 4;
        } else if (self.currentstate == "light smoke") {
            wait level.heli_missile_regen_time / 2;
        } else {
            wait level.heli_missile_regen_time;
        }
        if (self.missile_ammo < level.heli_missile_max) {
            self.missile_ammo++;
        }
    }
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0xb2016f22, Offset: 0x3628
// Size: 0x5a0
function heli_targeting(missilesenabled, hardpointtype) {
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    for (;;) {
        targets = [];
        targetsmissile = [];
        players = level.players;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (self cantargetplayer_turret(player, hardpointtype)) {
                if (isdefined(player)) {
                    targets[targets.size] = player;
                }
            }
            if (missilesenabled && self cantargetplayer_missile(player, hardpointtype)) {
                if (isdefined(player)) {
                    targetsmissile[targetsmissile.size] = player;
                }
                continue;
            }
        }
        tanks = getentarray("talon", "targetname");
        foreach (tank in tanks) {
            if (self cantargettank_turret(tank)) {
                targets[targets.size] = tank;
            }
        }
        actors = getactorarray();
        foreach (actor in actors) {
            if (isdefined(actor) && isactor(actor) && isalive(actor)) {
                if (self cantargetactor_turret(actor, hardpointtype)) {
                    targets[targets.size] = actor;
                }
            }
        }
        if (targets.size == 0 && targetsmissile.size == 0) {
            self.primarytarget = undefined;
            self.secondarytarget = undefined;
            /#
                debug_print_target();
            #/
            wait self.targeting_delay;
            continue;
        }
        if (targets.size == 1) {
            if (isdefined(targets[0].type) && (targets[0].type == "dog" || targets[0].type == "tank_drone")) {
                killstreaks::update_dog_threat(targets[0]);
            } else if (isactor(targets[0])) {
                killstreaks::update_actor_threat(targets[0]);
            } else {
                killstreaks::update_player_threat(targets[0]);
            }
            self.primarytarget = targets[0];
            self notify(#"primary acquired");
            self.secondarytarget = undefined;
            /#
                debug_print_target();
            #/
        } else if (targets.size > 1) {
            assignprimarytargets(targets);
        }
        if (targetsmissile.size == 1) {
            if (!isdefined(targetsmissile[0].type) || targetsmissile[0].type != "dog" || targets[0].type == "tank_drone") {
                self killstreaks::update_missile_player_threat(targetsmissile[0]);
            } else if (targetsmissile[0].type == "dog") {
                self killstreaks::update_missile_dog_threat(targetsmissile[0]);
            }
            self.secondarytarget = targetsmissile[0];
            self notify(#"secondary acquired");
            /#
                debug_print_target();
            #/
        } else if (targetsmissile.size > 1) {
            assignsecondarytargets(targetsmissile);
        }
        wait self.targeting_delay;
        /#
            debug_print_target();
        #/
    }
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0x3348e66, Offset: 0x3bd0
// Size: 0x2b4
function cantargetplayer_turret(player, hardpointtype) {
    if (!isalive(player) || player.sessionstate != "playing") {
        return false;
    }
    if (player.ignoreme === 1) {
        return false;
    }
    if (player == self.owner) {
        self check_owner(hardpointtype);
        return false;
    }
    if (player airsupport::cantargetplayerwithspecialty() == 0) {
        return false;
    }
    if (distance(player.origin, self.origin) > level.heli_visual_range) {
        return false;
    }
    if (!isdefined(player.team)) {
        return false;
    }
    if (level.teambased && player.team == self.team) {
        return false;
    }
    if (player.team == #"spectator") {
        return false;
    }
    if (isdefined(player.spawntime) && float(gettime() - player.spawntime) / 1000 <= level.heli_target_spawnprotection) {
        return false;
    }
    heli_centroid = self.origin + (0, 0, -160);
    heli_forward_norm = anglestoforward(self.angles);
    heli_turret_point = heli_centroid + 144 * heli_forward_norm;
    visible_amount = player sightconetrace(heli_turret_point, self);
    if (visible_amount < level.heli_target_recognition) {
        return false;
    }
    var_56b0611 = self targetting_delay::function_3b2437d9(player);
    targetting_delay::function_4ba58de4(player, int((isdefined(self.targeting_delay) ? self.targeting_delay : 0.25) * 1000));
    if (!var_56b0611) {
        return false;
    }
    return true;
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0x2ad12a34, Offset: 0x3e90
// Size: 0x176
function cantargetactor_turret(actor, hardpointtype) {
    helicopter = self;
    cantarget = 1;
    if (!isalive(actor)) {
        return actor;
    }
    if (!isdefined(actor.team)) {
        return 0;
    }
    if (level.teambased && actor.team == helicopter.team) {
        return 0;
    }
    if (distancesquared(actor.origin, helicopter.origin) > level.heli_visual_range * level.heli_visual_range) {
        return 0;
    }
    heli_centroid = helicopter.origin + (0, 0, -160);
    heli_forward_norm = anglestoforward(helicopter.angles);
    heli_turret_point = heli_centroid + 144 * heli_forward_norm;
    visible_amount = actor sightconetrace(heli_turret_point, helicopter);
    if (visible_amount < level.heli_target_recognition) {
        return 0;
    }
    return cantarget;
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0xe44b73c1, Offset: 0x4010
// Size: 0xd4
function getverticaltan(startorigin, endorigin) {
    vector = endorigin - startorigin;
    opposite = startorigin[2] - endorigin[2];
    if (opposite < 0) {
        opposite *= 1;
    }
    adjacent = distance2d(startorigin, endorigin);
    if (adjacent < 0) {
        adjacent *= 1;
    }
    if (adjacent < 0.01) {
        adjacent = 0.01;
    }
    tangent = opposite / adjacent;
    return tangent;
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0xd671e32a, Offset: 0x40f0
// Size: 0x2ca
function cantargetplayer_missile(player, hardpointtype) {
    cantarget = 1;
    if (!isalive(player) || player.sessionstate != "playing") {
        return 0;
    }
    if (player.ignoreme === 1) {
        return 0;
    }
    if (player == self.owner) {
        self check_owner(hardpointtype);
        return 0;
    }
    if (player airsupport::cantargetplayerwithspecialty() == 0) {
        return 0;
    }
    if (distance(player.origin, self.origin) > level.heli_missile_range) {
        return 0;
    }
    if (!isdefined(player.team)) {
        return 0;
    }
    if (level.teambased && player.team == self.team) {
        return 0;
    }
    if (player.team == #"spectator") {
        return 0;
    }
    if (isdefined(player.spawntime) && float(gettime() - player.spawntime) / 1000 <= level.heli_target_spawnprotection) {
        return 0;
    }
    if (self target_cone_check(player, level.heli_missile_target_cone) == 0) {
        return 0;
    }
    if (self targetting_delay::function_3b2437d9(player) == 0) {
        return 0;
    }
    heli_centroid = self.origin + (0, 0, -160);
    heli_forward_norm = anglestoforward(self.angles);
    heli_turret_point = heli_centroid + 144 * heli_forward_norm;
    if (!isdefined(player.lasthit)) {
        player.lasthit = 0;
    }
    player.lasthit = self heliturretsighttrace(heli_turret_point, player, player.lasthit);
    if (player.lasthit != 0) {
        return 0;
    }
    return cantarget;
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x427eccaa, Offset: 0x43c8
// Size: 0x1a2
function cantargetdog_turret(dog) {
    cantarget = 1;
    if (!isdefined(dog)) {
        return 0;
    }
    if (distance(dog.origin, self.origin) > level.heli_visual_range) {
        return 0;
    }
    if (!isdefined(dog.team)) {
        return 0;
    }
    if (level.teambased && dog.team == self.team) {
        return 0;
    }
    if (isdefined(dog.script_owner) && self.owner == dog.script_owner) {
        return 0;
    }
    heli_centroid = self.origin + (0, 0, -160);
    heli_forward_norm = anglestoforward(self.angles);
    heli_turret_point = heli_centroid + 144 * heli_forward_norm;
    if (!isdefined(dog.lasthit)) {
        dog.lasthit = 0;
    }
    dog.lasthit = self heliturretdogtrace(heli_turret_point, dog, dog.lasthit);
    if (dog.lasthit != 0) {
        return 0;
    }
    return cantarget;
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x69db4629, Offset: 0x4578
// Size: 0x1a2
function cantargetdog_missile(dog) {
    cantarget = 1;
    if (!isdefined(dog)) {
        return 0;
    }
    if (distance(dog.origin, self.origin) > level.heli_missile_range) {
        return 0;
    }
    if (!isdefined(dog.team)) {
        return 0;
    }
    if (level.teambased && dog.team == self.team) {
        return 0;
    }
    if (isdefined(dog.script_owner) && self.owner == dog.script_owner) {
        return 0;
    }
    heli_centroid = self.origin + (0, 0, -160);
    heli_forward_norm = anglestoforward(self.angles);
    heli_turret_point = heli_centroid + 144 * heli_forward_norm;
    if (!isdefined(dog.lasthit)) {
        dog.lasthit = 0;
    }
    dog.lasthit = self heliturretdogtrace(heli_turret_point, dog, dog.lasthit);
    if (dog.lasthit != 0) {
        return 0;
    }
    return cantarget;
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0xc4bcb1d, Offset: 0x4728
// Size: 0xd2
function cantargettank_turret(tank) {
    cantarget = 1;
    if (!isdefined(tank)) {
        return 0;
    }
    if (distance(tank.origin, self.origin) > level.heli_visual_range) {
        return 0;
    }
    if (!isdefined(tank.team)) {
        return 0;
    }
    if (level.teambased && tank.team == self.team) {
        return 0;
    }
    if (isdefined(tank.owner) && self.owner == tank.owner) {
        return 0;
    }
    return cantarget;
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0xc5ecea01, Offset: 0x4808
// Size: 0x246
function assignprimarytargets(targets) {
    for (idx = 0; idx < targets.size; idx++) {
        if (isdefined(targets[idx].type) && targets[idx].type == "dog") {
            killstreaks::update_dog_threat(targets[idx]);
            continue;
        }
        if (isactor(targets[idx])) {
            killstreaks::update_actor_threat(targets[idx]);
            continue;
        }
        if (isplayer(targets[idx])) {
            killstreaks::update_player_threat(targets[idx]);
            continue;
        }
        killstreaks::update_non_player_threat(targets[idx]);
    }
    assert(targets.size >= 2, "<dev string:x17f>");
    highest = 0;
    second_highest = 0;
    primarytarget = undefined;
    for (idx = 0; idx < targets.size; idx++) {
        assert(isdefined(targets[idx].threatlevel), "<dev string:x1b2>");
        if (targets[idx].threatlevel >= highest) {
            highest = targets[idx].threatlevel;
            primarytarget = targets[idx];
        }
    }
    assert(isdefined(primarytarget), "<dev string:x1db>");
    self.primarytarget = primarytarget;
    self notify(#"primary acquired");
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x35679e48, Offset: 0x4a58
// Size: 0x216
function assignsecondarytargets(targets) {
    for (idx = 0; idx < targets.size; idx++) {
        if (!isdefined(targets[idx].type) || targets[idx].type != "dog") {
            self killstreaks::update_missile_player_threat(targets[idx]);
            continue;
        }
        if (targets[idx].type == "dog" || targets[0].type == "tank_drone") {
            killstreaks::update_missile_dog_threat(targets[idx]);
        }
    }
    assert(targets.size >= 2, "<dev string:x17f>");
    highest = 0;
    second_highest = 0;
    primarytarget = undefined;
    secondarytarget = undefined;
    for (idx = 0; idx < targets.size; idx++) {
        assert(isdefined(targets[idx].missilethreatlevel), "<dev string:x1b2>");
        if (targets[idx].missilethreatlevel >= highest) {
            highest = targets[idx].missilethreatlevel;
            secondarytarget = targets[idx];
        }
    }
    assert(isdefined(secondarytarget), "<dev string:x20b>");
    self.secondarytarget = secondarytarget;
    self notify(#"secondary acquired");
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0xdfbbfbcd, Offset: 0x4c78
// Size: 0x8c
function heli_reset() {
    self cleartargetyaw();
    self cleargoalyaw();
    self setyawspeed(75, 45, 45);
    self setmaxpitchroll(30, 30);
    self setneargoalnotifydist(256);
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x72b7a3ca, Offset: 0x4d10
// Size: 0x7e
function heli_wait(waittime) {
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"evasive");
    self thread heli_hover();
    wait waittime;
    heli_reset();
    self notify(#"stop hover");
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0xb41f0e18, Offset: 0x4d98
// Size: 0x9c
function heli_hover() {
    self endon(#"death");
    self endon(#"stop hover");
    self endon(#"evasive");
    self endon(#"leaving");
    self endon(#"crashing");
    randint = randomint(360);
    self setgoalyaw(self.angles[1] + randint);
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x11e83263, Offset: 0x4e40
// Size: 0x108
function wait_for_killed() {
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    self.bda = 0;
    while (true) {
        waitresult = self waittill(#"killed");
        victim = waitresult.victim;
        if (!isdefined(self.owner) || !isdefined(victim)) {
            continue;
        }
        if (self.owner == victim) {
            continue;
        }
        if (level.teambased && self.owner.team == victim.team) {
            continue;
        }
        self thread wait_for_bda_timeout();
    }
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x90984da0, Offset: 0x4f50
// Size: 0x3c
function wait_for_bda_timeout() {
    self endon(#"killed");
    wait 2.5;
    if (!isdefined(self)) {
        return;
    }
    self play_bda_dialog();
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0xc4bc3a9f, Offset: 0x4f98
// Size: 0xe2
function play_bda_dialog() {
    if (self.bda == 1) {
        bdadialog = "kill1";
    } else if (self.bda == 2) {
        bdadialog = "kill2";
    } else if (self.bda == 3) {
        bdadialog = "kill3";
    } else if (self.bda > 3) {
        bdadialog = "killMultiple";
    }
    self killstreaks::play_pilot_dialog_on_owner(bdadialog, self.killstreaktype, self.killstreak_id);
    self notify(#"bda_dialog", {#dialog_key:bdadialog});
    self.bda = 0;
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0xf92edc24, Offset: 0x5088
// Size: 0x7e
function heli_hacked_health_update(hacker) {
    helicopter = self;
    hackeddamagetaken = helicopter.maxhealth - helicopter.hackedhealth;
    assert(hackeddamagetaken > 0);
    if (hackeddamagetaken > helicopter.damagetaken) {
        helicopter.damagetaken = hackeddamagetaken;
    }
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x60be4903, Offset: 0x5110
// Size: 0x97a
function heli_damage_monitor(hardpointtype) {
    helicopter = self;
    self endon(#"death");
    self endon(#"crashing");
    self.damagetaken = 0;
    last_hit_vo = 0;
    hit_vo_spacing = 6000;
    helicopter.hackedhealthupdatecallback = &heli_hacked_health_update;
    helicopter.hackedhealth = killstreak_bundles::get_hacked_health(hardpointtype);
    if (!isdefined(self.attackerdata)) {
        self.attackers = [];
        self.attackerdata = [];
        self.attackerdamage = [];
        self.flareattackerdamage = [];
    }
    for (;;) {
        waitresult = self waittill(#"damage");
        attacker = waitresult.attacker;
        weapon = waitresult.weapon;
        damage = waitresult.amount;
        type = waitresult.mod;
        flags = waitresult.flags;
        chargelevel = waitresult.chargelevel;
        if (!isdefined(attacker) || !isplayer(attacker)) {
            continue;
        }
        heli_friendlyfire = damage::friendlyfirecheck(self.owner, attacker);
        if (!heli_friendlyfire) {
            continue;
        }
        if (!level.hardcoremode) {
            if (isdefined(self.owner) && attacker == self.owner) {
                continue;
            }
            if (level.teambased) {
                isvalidattacker = isdefined(attacker.team) && attacker.team != self.team;
            } else {
                isvalidattacker = 1;
            }
            if (!isvalidattacker) {
                continue;
            }
        }
        weapon_damage = killstreak_bundles::get_weapon_damage(hardpointtype, self.maxhealth, attacker, weapon, type, damage, flags, chargelevel);
        if (!isdefined(weapon_damage)) {
            weapon_damage = killstreaks::get_old_damage(attacker, weapon, type, damage, 1, level.var_711845ca);
        }
        self.damagetaken += weapon_damage;
        playercontrolled = 0;
        if (self.damagetaken > self.maxhealth && !isdefined(self.xpgiven)) {
            self.xpgiven = 1;
            switch (hardpointtype) {
            case #"helicopter_comlink":
            case #"inventory_helicopter_comlink":
                event = "attack_chopper_shutdown";
                if (self.leaving !== 1) {
                    self killstreaks::play_destroyed_dialog_on_owner(self.killstreaktype, self.killstreak_id);
                }
                break;
            case #"supply_drop":
            case #"supply_drop_combat_robot":
                if (isdefined(helicopter.killstreakweaponname)) {
                    switch (helicopter.killstreakweaponname) {
                    case #"tank_robot":
                    case #"ai_tank_drop_marker":
                    case #"inventory_ai_tank_marker":
                    case #"inventory_tank_robot":
                    case #"ai_tank_marker":
                        event = "destroyed_helicopter_agr_drop";
                        break;
                    case #"combat_robot_marker":
                    case #"inventory_combat_robot_marker":
                    case #"combat_robot_drop":
                    case #"inventory_combat_robot_drop":
                        event = "destroyed_helicopter_giunit_drop";
                        break;
                    default:
                        event = "care_package_shutdown";
                        break;
                    }
                } else {
                    event = "care_package_shutdown";
                }
                break;
            }
            if (isdefined(level.var_8ca610ad)) {
                self [[ level.var_8ca610ad ]](attacker, weapon, type, weapon_damage, event, playercontrolled, hardpointtype);
            }
            weaponstatname = #"destroyed";
            switch (weapon.name) {
            case #"tow_turret":
            case #"tow_turret_drop":
            case #"auto_tow":
                weaponstatname = #"kills";
                break;
            }
            attacker stats::function_4f10b697(weapon, weaponstatname, 1);
            notifystring = undefined;
            killstreakreference = undefined;
            switch (hardpointtype) {
            case #"helicopter_player_firstperson":
                killstreakreference = "killstreak_helicopter_player_firstperson";
                break;
            case #"helicopter_x2":
            case #"helicopter_comlink":
            case #"helicopter":
            case #"inventory_helicopter_comlink":
                notifystring = #"hash_286f843fea185e5";
                killstreakreference = "killstreak_helicopter_comlink";
                break;
            case #"supply_drop":
                notifystring = #"hash_3267fdfd0c2b7fdc";
                killstreakreference = "killstreak_supply_drop";
                break;
            case #"helicopter_guard":
                killstreakreference = "killstreak_helicopter_guard";
                break;
            }
            if (isdefined(killstreakreference)) {
                level.globalkillstreaksdestroyed++;
                attacker stats::function_4f10b697(getweapon(hardpointtype), #"destroyed", 1);
            }
            if (hardpointtype == "helicopter_player_gunner") {
                self.owner sendkillstreakdamageevent(600);
            }
            if (isdefined(notifystring)) {
                luinotifyevent(#"player_callout", 2, notifystring, attacker.entnum);
            }
            if (isdefined(self.attackers)) {
                for (j = 0; j < self.attackers.size; j++) {
                    player = self.attackers[j];
                    if (!isdefined(player)) {
                        continue;
                    }
                    if (player == attacker) {
                        continue;
                    }
                    flare_done = self.flareattackerdamage[player.clientid];
                    if (isdefined(flare_done) && flare_done == 1) {
                        scoreevents::processscoreevent(#"aircraft_flare_assist", player, undefined, undefined);
                        continue;
                    }
                    damage_done = self.attackerdamage[player.clientid];
                    player thread processcopterassist(self, damage_done);
                }
                self.attackers = [];
            }
            attacker notify(#"destroyed_helicopter");
            if (target_istarget(self)) {
                target_remove(self);
            }
        } else if (isdefined(self.owner) && isplayer(self.owner)) {
            if (last_hit_vo + hit_vo_spacing < gettime()) {
                if (type == "MOD_PROJECTILE" || randomintrange(0, 3) == 0) {
                    last_hit_vo = gettime();
                }
            }
        }
        if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
        }
    }
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0xc09f0dad, Offset: 0x5a98
// Size: 0x7c
function init_active_camo() {
    heli = self;
    heli.active_camo_damage = 0;
    heli.active_camo_disabled = 0;
    heli.camo_state = 0;
    heli_set_active_camo_state(1);
    if (isdefined(heli.flak_drone)) {
        heli.flak_drone flak_drone::setcamostate(1);
    }
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0xa25a665, Offset: 0x5b20
// Size: 0x24c
function heli_set_active_camo_state(state) {
    heli = self;
    if (!isdefined(heli.active_camo_supported)) {
        return;
    }
    if (state == 0) {
        heli clientfield::set("toggle_lights", 1);
        if (heli.camo_state == 1) {
            heli playsound(#"veh_hind_cloak_off");
        }
        heli.camo_state = 0;
        heli.camo_state_switch_time = gettime();
    } else if (state == 1) {
        if (heli.active_camo_disabled) {
            return;
        }
        heli clientfield::set("toggle_lights", 0);
        if (heli.camo_state == 0) {
            heli playsound(#"veh_hind_cloak_on");
        }
        heli.camo_state = 1;
        heli.camo_state_switch_time = gettime();
        if (isdefined(heli.owner)) {
            if (isdefined(heli.play_camo_dialog) && heli.play_camo_dialog) {
                heli killstreaks::play_pilot_dialog_on_owner("activateCounter", "helicopter_comlink", self.killstreak_id);
                heli.play_camo_dialog = 0;
            } else if (!isdefined(heli.play_camo_dialog)) {
                heli.play_camo_dialog = 1;
            }
        }
    } else if (state == 2) {
        heli clientfield::set("toggle_lights", 1);
    }
    if (isdefined(heli.flak_drone)) {
        heli.flak_drone flak_drone::setcamostate(state);
    }
    heli clientfield::set("active_camo", state);
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0xa84a6150, Offset: 0x5d78
// Size: 0xd4
function heli_active_camo_damage_update(damage) {
    self endon(#"death");
    self endon(#"crashing");
    heli = self;
    heli.active_camo_damage += damage;
    if (heli.active_camo_damage > 100) {
        heli.active_camo_disabled = 1;
        heli thread heli_active_camo_damage_disable();
        return;
    }
    heli heli_set_active_camo_state(2);
    wait 1;
    heli heli_set_active_camo_state(1);
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x5b89fb04, Offset: 0x5e58
// Size: 0xac
function heli_active_camo_damage_disable() {
    self endon(#"death");
    self endon(#"crashing");
    heli = self;
    heli notify(#"heli_active_camo_damage_disable");
    heli endon(#"heli_active_camo_damage_disable");
    heli heli_set_active_camo_state(0);
    wait 10;
    heli.active_camo_damage = 0;
    heli.active_camo_disabled = 0;
    heli heli_set_active_camo_state(1);
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0xeaa7dd0e, Offset: 0x5f10
// Size: 0x392
function heli_health(hardpointtype, playernotify) {
    self endon(#"death");
    self endon(#"crashing");
    self.currentstate = "ok";
    self.laststate = "ok";
    damagestate = 3;
    for (;;) {
        self waittill(#"damage");
        waitframe(1);
        if (!isdefined(self.damagetaken)) {
            waitframe(1);
            continue;
        }
        if (!(isdefined(self.var_73bced7f) && self.var_73bced7f) && self.damagetaken >= self.maxhealth * 0.5) {
            self killstreaks::play_pilot_dialog_on_owner("damaged", "helicopter_comlink", self.killstreak_id);
            self.var_73bced7f = 1;
        }
        if (self.damagetaken > self.maxhealth) {
            damagestate = 0;
            self heli_set_active_camo_state(0);
            self thread heli_crash(hardpointtype, self.owner, playernotify);
            continue;
        }
        if (self.damagetaken >= self.maxhealth * 0.66 && damagestate >= 2) {
            if (isdefined(self.vehicletype) && self.vehicletype == #"heli_player_gunner_mp") {
                playfxontag(level.chopper_fx[#"damage"][#"heavy_smoke"], self, "tag_origin");
            } else {
                playfxontag(level.chopper_fx[#"damage"][#"heavy_smoke"], self, "tag_engine_left");
            }
            damagestate = 1;
            self.currentstate = "heavy smoke";
            self.evasive = 1;
            self notify(#"damage state");
            continue;
        }
        if (self.damagetaken >= self.maxhealth * 0.33 && damagestate == 3) {
            if (isdefined(self.vehicletype) && self.vehicletype == #"heli_player_gunner_mp") {
                playfxontag(level.chopper_fx[#"damage"][#"light_smoke"], self, "tag_origin");
            } else {
                playfxontag(level.chopper_fx[#"damage"][#"light_smoke"], self, "tag_main_rotor");
            }
            damagestate = 2;
            self.currentstate = "light smoke";
            self notify(#"damage state");
        }
    }
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0xe26cfd7f, Offset: 0x62b0
// Size: 0x94
function heli_evasive(hardpointtype) {
    self notify(#"evasive");
    self.evasive = 1;
    loop_startnode = level.heli_loop_paths[0];
    startwait = 2;
    if (isdefined(self.donotstop) && self.donotstop) {
        startwait = 0;
    }
    self thread heli_fly(loop_startnode, startwait, hardpointtype);
}

// Namespace helicopter/helicopter_shared
// Params 3, eflags: 0x0
// Checksum 0x7d86fb7b, Offset: 0x6350
// Size: 0x5e
function notify_player(player, playernotify, delay) {
    if (!isdefined(player)) {
        return;
    }
    if (!isdefined(playernotify)) {
        return;
    }
    player endon(#"disconnect");
    player endon(playernotify);
    wait delay;
    player notify(playernotify);
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x168e4d0d, Offset: 0x63b8
// Size: 0x3e
function play_going_down_vo(delay) {
    self.owner endon(#"disconnect");
    self endon(#"death");
    wait delay;
}

// Namespace helicopter/helicopter_shared
// Params 3, eflags: 0x0
// Checksum 0xb9c1209b, Offset: 0x6400
// Size: 0x4e4
function heli_crash(hardpointtype, player, playernotify) {
    self endon(#"death");
    self notify(#"crashing");
    self influencers::remove_influencers();
    self stoploopsound(0);
    if (isdefined(self.minigun_snd_ent)) {
        self.minigun_snd_ent stoploopsound();
    }
    if (isdefined(self.alarm_snd_ent)) {
        self.alarm_snd_ent stoploopsound();
    }
    crashtypes = [];
    crashtypes[0] = "crashOnPath";
    crashtypes[1] = "spinOut";
    crashtype = crashtypes[randomint(2)];
    if (isdefined(self.crashtype)) {
        crashtype = self.crashtype;
    }
    /#
        if (level.heli_debug_crash) {
            switch (level.heli_debug_crash) {
            case 1:
                crashtype = "<dev string:x240>";
                break;
            case 2:
                crashtype = "<dev string:x248>";
                break;
            case 3:
                crashtype = "<dev string:x254>";
                break;
            default:
                break;
            }
        }
    #/
    switch (crashtype) {
    case #"explode":
        thread notify_player(player, playernotify, 0);
        self thread heli_explode();
        break;
    case #"crashonpath":
        if (isdefined(player)) {
            self thread play_going_down_vo(0.5);
        }
        thread notify_player(player, playernotify, 4);
        self clear_client_flags();
        self thread crashonnearestcrashpath(hardpointtype);
        break;
    case #"spinout":
        if (isdefined(player)) {
            self thread play_going_down_vo(0.5);
        }
        thread notify_player(player, playernotify, 4);
        self clear_client_flags();
        heli_reset();
        heli_speed = 30 + randomint(50);
        heli_accel = 10 + randomint(25);
        leavenode = getvalidrandomcrashnode(self.origin);
        self setspeed(heli_speed, heli_accel);
        self set_goal_pos(leavenode.origin, 0);
        rateofspin = 45 + randomint(90);
        thread heli_secondary_explosions();
        self thread heli_spin(rateofspin);
        self waittilltimeout(randomintrange(4, 6), #"near_goal");
        if (isdefined(player) && isdefined(playernotify)) {
            player notify(playernotify);
        }
        self thread heli_explode();
        break;
    }
    self thread explodeoncontact(hardpointtype);
    time = randomintrange(4, 6);
    self thread waitthenexplode(time);
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x312e6ddb, Offset: 0x68f0
// Size: 0x34
function damagedrotorfx() {
    self endon(#"death");
    self setrotorspeed(0.6);
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x2741df73, Offset: 0x6930
// Size: 0x3c
function waitthenexplode(time) {
    self endon(#"death");
    wait time;
    self thread heli_explode();
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x18de7351, Offset: 0x6978
// Size: 0x1fc
function crashonnearestcrashpath(hardpointtype) {
    crashpathdistance = -1;
    crashpath = level.heli_crash_paths[0];
    for (i = 0; i < level.heli_crash_paths.size; i++) {
        currentdistance = distance(self.origin, level.heli_crash_paths[i].origin);
        if (crashpathdistance == -1 || crashpathdistance > currentdistance) {
            crashpathdistance = currentdistance;
            crashpath = level.heli_crash_paths[i];
        }
    }
    heli_speed = 30 + randomint(50);
    heli_accel = 10 + randomint(25);
    self setspeed(heli_speed, heli_accel);
    thread heli_secondary_explosions();
    self thread heli_fly(crashpath, 0, hardpointtype);
    rateofspin = 45 + randomint(90);
    self thread heli_spin(rateofspin);
    self endon(#"death");
    self waittill(#"path start");
    self waittilltimeout(5, #"destination reached");
    self thread heli_explode();
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0xf2882132, Offset: 0x6b80
// Size: 0x9e
function checkhelicoptertag(tagname) {
    if (isdefined(self.model)) {
        if (self.model == "veh_t8_drone_hunter_mp_light") {
            switch (tagname) {
            case #"tag_engine_left":
                return "tag_fx_exhaust2";
            case #"tag_engine_right":
                return "tag_fx_exhaust1";
            case #"tail_rotor_jnt":
                return "tag_fx_tail";
            default:
                break;
            }
        }
    }
    return tagname;
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x2e78faf5, Offset: 0x6c28
// Size: 0x28c
function heli_secondary_explosions() {
    self endon(#"death");
    playfxontag(level.chopper_fx[#"explode"][#"large"], self, self checkhelicoptertag("tag_engine_left"));
    self playsound(level.heli_sound[#"hit"]);
    if (isdefined(self.vehicletype) && self.vehicletype == #"heli_player_gunner_mp") {
        self thread trail_fx(level.chopper_fx[#"smoke"][#"trail"], self checkhelicoptertag("tag_engine_right"), "stop tail smoke");
    } else {
        self thread trail_fx(level.chopper_fx[#"smoke"][#"trail"], self checkhelicoptertag("tail_rotor_jnt"), "stop tail smoke");
    }
    self thread trail_fx(level.chopper_fx[#"fire"][#"trail"][#"large"], self checkhelicoptertag("tag_engine_left"), "stop body fire");
    wait 3;
    if (!isdefined(self)) {
        return;
    }
    playfxontag(level.chopper_fx[#"explode"][#"large"], self, self checkhelicoptertag("tag_engine_left"));
    self playsound(level.heli_sound[#"hitsecondary"]);
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0xd9044255, Offset: 0x6ec0
// Size: 0x9e
function heli_spin(speed) {
    self endon(#"death");
    self thread spinsoundshortly();
    self setyawspeed(speed, speed / 3, speed / 3);
    while (isdefined(self)) {
        self settargetyaw(self.angles[1] + speed * 0.9);
        wait 1;
    }
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x68aaa4d5, Offset: 0x6f68
// Size: 0x94
function spinsoundshortly() {
    self endon(#"death");
    wait 0.25;
    self stoploopsound();
    waitframe(1);
    self playloopsound(level.heli_sound[#"spinloop"]);
    waitframe(1);
    self playsound(level.heli_sound[#"spinstart"]);
}

// Namespace helicopter/helicopter_shared
// Params 3, eflags: 0x0
// Checksum 0xba6bf0bf, Offset: 0x7008
// Size: 0x1c
function trail_fx(trail_fx, trail_tag, stop_notify) {
    
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x84935254, Offset: 0x7030
// Size: 0x1a4
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
    killstreakrules::killstreakstop(self.hardpointtype, team, self.killstreak_id);
    if (isdefined(var_6e546e05) && var_6e546e05) {
        self function_236dcb7b();
    }
    self delete();
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x64ae46bd, Offset: 0x71e0
// Size: 0x174
function function_236dcb7b() {
    forward = self.origin + (0, 0, 100) - self.origin;
    if (isdefined(self.helitype) && self.helitype == "littlebird") {
        playfx(level.chopper_fx[#"explode"][#"guard"], self.origin, forward);
    } else if (isdefined(self.vehicletype) && self.vehicletype == #"heli_player_gunner_mp") {
        playfx(level.chopper_fx[#"explode"][#"gunner"], self.origin, forward);
    } else {
        playfx(level.chopper_fx[#"explode"][#"death"], self.origin, forward);
    }
    self playsound(level.heli_sound[#"crash"]);
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0xdb03febd, Offset: 0x7360
// Size: 0x64
function heli_explode() {
    self endon(#"death");
    self function_236dcb7b();
    wait 0.1;
    assert(isdefined(self.destroyfunc));
    self [[ self.destroyfunc ]]();
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0xd648a7ff, Offset: 0x73d0
// Size: 0x64
function clear_client_flags() {
    self clientfield::set("heli_warn_fired", 0);
    self clientfield::set("heli_warn_targeted", 0);
    self clientfield::set("heli_warn_locked", 0);
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0xdd43eeb2, Offset: 0x7440
// Size: 0xdc
function function_6d273cc0(goalpos, stop) {
    if (!isdefined(self)) {
        return;
    }
    self.heligoalpos = goalpos;
    if (issentient(self) && ispathfinder(self) && ispointinnavvolume(self.origin, "navvolume_big")) {
        self setgoal(goalpos, stop);
        self function_3c8dce03(goalpos, stop, 1);
        return;
    }
    self function_3c8dce03(goalpos, stop, 0);
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x4
// Checksum 0x97c742b8, Offset: 0x7528
// Size: 0x186
function private function_768b2544(var_b321594) {
    self endon(#"death");
    radius = distance(self.origin, var_b321594);
    var_40c02d23 = getclosestpointonnavvolume(var_b321594, "navvolume_big", radius);
    if (isdefined(var_40c02d23)) {
        self function_6d273cc0(var_40c02d23, 0);
        while (true) {
            /#
                recordsphere(var_40c02d23, 8, (0, 0, 1), "<dev string:x25c>");
            #/
            var_6f7637e2 = ispointinnavvolume(self.origin, "navvolume_big");
            if (!var_6f7637e2) {
                if (issentient(self)) {
                    self function_32aff240();
                }
                self notify(#"hash_2bf34763927dd61b");
                break;
            }
            waitframe(1);
        }
        return;
    }
    if (issentient(self)) {
        self function_32aff240();
    }
    self notify(#"hash_2bf34763927dd61b");
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x6fd14e69, Offset: 0x76b8
// Size: 0x2ec
function function_32f7b457(var_59a31b8c) {
    self notify(#"destintation reached");
    self notify(#"leaving");
    hardpointtype = self.hardpointtype;
    self.leaving = 1;
    if (!(isdefined(self.destroyscoreeventgiven) && self.destroyscoreeventgiven)) {
        self killstreaks::play_pilot_dialog_on_owner("timeout", hardpointtype);
        self killstreaks::play_taacom_dialog_response_on_owner("timeoutConfirmed", hardpointtype);
    }
    leavenode = getvalidrandomleavenode(self.origin);
    var_b321594 = leavenode.origin;
    if (isdefined(var_59a31b8c)) {
        var_b321594 = var_59a31b8c;
    }
    heli_reset();
    self vehclearlookat();
    exitangles = vectortoangles(var_b321594 - self.origin);
    self setgoalyaw(exitangles[1]);
    wait 1.5;
    if (!isdefined(self)) {
        return;
    }
    /#
        self util::debug_slow_heli_speed();
    #/
    self set_goal_pos(self.origin + (var_b321594 - self.origin) / 2 + (0, 0, 1000), 0);
    self waittill(#"near_goal", #"death");
    if (isdefined(self)) {
        self set_goal_pos(var_b321594, 1);
        self waittill(#"goal", #"death");
        if (isdefined(self)) {
            self stoploopsound(1);
            self util::death_notify_wrapper();
            if (isdefined(self.alarm_snd_ent)) {
                self.alarm_snd_ent stoploopsound();
                self.alarm_snd_ent delete();
                self.alarm_snd_ent = undefined;
            }
            assert(isdefined(self.destroyfunc));
            self [[ self.destroyfunc ]]();
        }
    }
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x465e2209, Offset: 0x79b0
// Size: 0xcc
function function_f597be8(var_b321594) {
    self endon(#"death");
    self endon(#"near_goal");
    while (true) {
        distsq = distancesquared(self.origin, var_b321594);
        if (distsq <= 10000) {
            self notify(#"fallback_goal");
            break;
        }
        if (!ispointinnavvolume(self.origin, "navvolume_big")) {
            self notify(#"fallback_goal");
            break;
        }
        waitframe(1);
    }
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0xfec0ea78, Offset: 0x7a88
// Size: 0x36c
function heli_leave(var_59a31b8c = undefined, var_21f3986f = 0) {
    if (!level.var_6fb48cdb || var_21f3986f) {
        self thread function_32f7b457(var_59a31b8c);
        return;
    }
    self notify(#"destintation reached");
    self notify(#"leaving");
    hardpointtype = self.hardpointtype;
    self.leaving = 1;
    if (!(isdefined(self.destroyscoreeventgiven) && self.destroyscoreeventgiven)) {
        self killstreaks::play_pilot_dialog_on_owner("timeout", hardpointtype);
        self killstreaks::play_taacom_dialog_response_on_owner("timeoutConfirmed", hardpointtype);
    }
    leavenode = getvalidrandomleavenode(self.origin);
    var_b321594 = leavenode.origin;
    if (isdefined(var_59a31b8c)) {
        var_b321594 = var_59a31b8c;
    }
    heli_reset();
    self thread function_f597be8(var_b321594);
    self vehclearlookat();
    exitangles = vectortoangles(var_b321594 - self.origin);
    self setgoalyaw(exitangles[1]);
    if (!ispointinnavvolume(var_b321594, "navvolume_big")) {
        self thread function_768b2544(var_b321594);
        self waittill(#"fallback_goal", #"hash_2bf34763927dd61b", #"death");
    }
    /#
        self util::debug_slow_heli_speed();
    #/
    if (!isdefined(self)) {
        return;
    }
    self function_6d273cc0(var_b321594, 1);
    self waittill(#"fallback_goal", #"near_goal", #"death");
    if (isdefined(self)) {
        self stoploopsound(1);
        self util::death_notify_wrapper();
        if (isdefined(self.alarm_snd_ent)) {
            self.alarm_snd_ent stoploopsound();
            self.alarm_snd_ent delete();
            self.alarm_snd_ent = undefined;
        }
        assert(isdefined(self.destroyfunc));
        self [[ self.destroyfunc ]]();
    }
}

// Namespace helicopter/helicopter_shared
// Params 3, eflags: 0x0
// Checksum 0xf7212541, Offset: 0x7e00
// Size: 0x514
function heli_fly(currentnode, startwait, hardpointtype) {
    self endon(#"death");
    self endon(#"leaving");
    self notify(#"flying");
    self endon(#"flying");
    self endon(#"abandoned");
    self.reached_dest = 0;
    heli_reset();
    pos = self.origin;
    wait startwait;
    while (isdefined(currentnode.target)) {
        nextnode = getent(currentnode.target, "targetname");
        assert(isdefined(nextnode), "<dev string:x263>");
        pos = nextnode.origin + (0, 0, 30);
        if (isdefined(currentnode.script_airspeed) && isdefined(currentnode.script_accel)) {
            heli_speed = currentnode.script_airspeed;
            heli_accel = currentnode.script_accel;
        } else {
            heli_speed = 30 + randomint(20);
            heli_accel = 10 + randomint(5);
        }
        if (isdefined(self.pathspeedscale)) {
            heli_speed *= self.pathspeedscale;
            heli_accel *= self.pathspeedscale;
        }
        if (!isdefined(nextnode.target)) {
            stop = 1;
        } else {
            stop = 0;
        }
        /#
            airsupport::debug_line(currentnode.origin, nextnode.origin, (1, 0.5, 0.5), 200);
        #/
        if (self.currentstate == "heavy smoke" || self.currentstate == "light smoke") {
            self setspeed(heli_speed, heli_accel);
            self set_goal_pos(pos, stop);
            self waittill(#"near_goal");
            self notify(#"path start");
        } else {
            if (isdefined(nextnode.script_delay) && !isdefined(self.donotstop)) {
                stop = 1;
            }
            self setspeed(heli_speed, heli_accel);
            self set_goal_pos(pos, stop);
            if (!isdefined(nextnode.script_delay) || isdefined(self.donotstop)) {
                self waittill(#"near_goal");
                self notify(#"path start");
            } else {
                self setgoalyaw(nextnode.angles[1]);
                self waittill(#"goal");
                heli_wait(nextnode.script_delay);
            }
        }
        for (index = 0; index < level.heli_loop_paths.size; index++) {
            if (level.heli_loop_paths[index].origin == nextnode.origin) {
                self.loopcount++;
            }
        }
        if (self.loopcount >= level.heli_loopmax) {
            self thread heli_leave();
            return;
        }
        currentnode = nextnode;
    }
    self setgoalyaw(currentnode.angles[1]);
    self.reached_dest = 1;
    self notify(#"destination reached");
    if (isdefined(self.waittime) && self.waittime > 0) {
        heli_wait(self.waittime);
    }
    if (isdefined(self)) {
        self thread heli_evasive(hardpointtype);
    }
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x747aae79, Offset: 0x8320
// Size: 0xac
function set_heli_speed_normal() {
    self setmaxpitchroll(30, 30);
    heli_speed = 30 + randomint(20);
    heli_accel = 10 + randomint(5);
    self setspeed(heli_speed, heli_accel);
    self setyawspeed(75, 45, 45);
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x1ad6cd4f, Offset: 0x83d8
// Size: 0xac
function set_heli_speed_evasive() {
    self setmaxpitchroll(30, 90);
    heli_speed = 50 + randomint(20);
    heli_accel = 30 + randomint(5);
    self setspeed(heli_speed, heli_accel);
    self setyawspeed(100, 75, 75);
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x28a2919b, Offset: 0x8490
// Size: 0x5c
function set_heli_speed_hover() {
    self setmaxpitchroll(0, 90);
    self setspeed(20, 10);
    self setyawspeed(55, 25, 25);
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x6de98298, Offset: 0x84f8
// Size: 0x64
function is_targeted() {
    if (isdefined(self.locking_on) && self.locking_on) {
        return true;
    }
    if (isdefined(self.locked_on) && self.locked_on) {
        return true;
    }
    if (isdefined(self.locking_on_hacking) && self.locking_on_hacking) {
        return true;
    }
    return false;
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0xb1c6f164, Offset: 0x8568
// Size: 0x144
function heli_mobilespawn(protectdest) {
    self endon(#"death");
    self notify(#"flying");
    self endon(#"flying");
    self endon(#"abandoned");
    /#
        iprintlnbold("<dev string:x296>" + protectdest[0] + "<dev string:x2a8>" + protectdest[1] + "<dev string:x2a8>" + protectdest[2] + "<dev string:x2aa>");
    #/
    heli_reset();
    self sethoverparams(50, 100, 50);
    wait 2;
    set_heli_speed_normal();
    self set_goal_pos(protectdest, 1);
    self waittill(#"near_goal");
    set_heli_speed_hover();
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x3e632f6d, Offset: 0x86b8
// Size: 0x13c
function function_b973a2e3() {
    self endon(#"death");
    self endon(#"abandoned");
    while (true) {
        var_6f7637e2 = ispointinnavvolume(self.origin, "navvolume_big");
        if (var_6f7637e2) {
            heli_reset();
            if (!ispathfinder(self)) {
                self makepathfinder();
            }
            if (!issentient(self)) {
                self makesentient();
            }
            self.ignoreme = 1;
            if (isdefined(self.heligoalpos)) {
                self set_goal_pos(self.heligoalpos, 1);
            }
            self notify(#"hash_340ab3c2b94ff86a");
            break;
        }
        wait 2;
    }
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x75a5d13c, Offset: 0x8800
// Size: 0x22e
function function_91fa8e0d() {
    self endon(#"death", #"abandoned");
    while (true) {
        if (isdefined(self.protectdest)) {
            /#
                recordsphere(self.protectdest, 8, (0, 0, 1), "<dev string:x25c>");
            #/
        }
        if (isdefined(self.var_f1a9f7c5)) {
            /#
                recordline(self.protectdest, self.var_f1a9f7c5, (0, 1, 0), "<dev string:x25c>");
                recordsphere(self.var_f1a9f7c5, 8, (0, 1, 0), "<dev string:x25c>");
            #/
        }
        if (isdefined(self.goalpos)) {
            /#
                recordsphere(self.goalpos, 8, (0, 1, 1), "<dev string:x25c>");
                recordline(self.origin, self.goalpos, (0, 1, 1), "<dev string:x25c>");
            #/
        }
        if (isdefined(self.var_29ef9ebf) && isdefined(self.var_b0b3cf42)) {
            /#
                recordsphere(self.var_b0b3cf42, 8, (0, 1, 0), "<dev string:x25c>");
                recordline(self.var_29ef9ebf, self.var_b0b3cf42, (0, 1, 0), "<dev string:x25c>");
                record3dtext("<dev string:x2ad>" + distance(self.var_29ef9ebf, self.var_b0b3cf42), self.var_b0b3cf42 + (0, 0, 20), (0, 1, 0), "<dev string:x25c>");
            #/
        }
        waitframe(1);
    }
}

// Namespace helicopter/helicopter_shared
// Params 3, eflags: 0x0
// Checksum 0xb14d0b, Offset: 0x8a38
// Size: 0x416
function heli_get_protect_spot(protectdest, overrideradius, heli_team) {
    assert(isdefined(level.heli_protect_radius));
    if (!isdefined(overrideradius)) {
        overrideradius = level.heli_protect_radius;
    }
    min_radius = int(overrideradius * 0.4);
    max_radius = overrideradius;
    groundpos = getclosestpointonnavmesh(protectdest, 10000);
    assert(isdefined(level.var_7d184855) && isdefined(level.var_67f9a0bb));
    assert(isdefined(level.var_67f9a0bb >= level.var_7d184855));
    heightmin = level.var_7d184855;
    heightmax = level.var_67f9a0bb;
    if (heli_team == #"axis") {
        assert(isdefined(level.var_6cbdf51d));
        heightmin += level.var_6cbdf51d;
        heightmax += level.var_6cbdf51d;
    }
    hoverheight = heightmin + (heightmax - heightmin) / 2;
    radius = 10000;
    if (isdefined(groundpos)) {
        var_6f77f9b8 = undefined;
        if (isdefined(self.primarytarget)) {
            var_6f77f9b8 = getclosestpointonnavmesh(self.primarytarget.origin, 10000);
        }
        if (isdefined(var_6f77f9b8)) {
            groundpos = var_6f77f9b8;
        }
        protectdest = (groundpos[0], groundpos[1], groundpos[2] + hoverheight);
        protectdest = getclosestpointonnavvolume(protectdest, "navvolume_big", radius);
        self.var_29ef9ebf = groundpos;
        self.var_b0b3cf42 = protectdest;
        halfheight = (heightmax - heightmin) / 2;
        queryresult = positionquery_source_navigation(protectdest, min_radius, max_radius, halfheight, 50, self);
        if (isdefined(queryresult.data) && queryresult.data.size) {
            validpoints = [];
            var_4ca2e438 = randomintrange(heightmin, heightmax);
            foreach (point in queryresult.data) {
                distsq = distancesquared(self.origin, point.origin);
                if (distsq >= var_4ca2e438 * var_4ca2e438) {
                    array::add(validpoints, point);
                }
            }
            if (validpoints.size) {
                return array::random(validpoints);
            }
        }
    }
    return undefined;
}

// Namespace helicopter/helicopter_shared
// Params 4, eflags: 0x0
// Checksum 0x77bab5cd, Offset: 0x8e58
// Size: 0x574
function function_4ca43607(startnode, protectdest, hardpointtype, heli_team) {
    self endon(#"death");
    self notify(#"flying");
    self endon(#"flying");
    self endon(#"abandoned");
    self.reached_dest = 0;
    heli_reset();
    wait 2;
    currentdest = protectdest;
    nodeheight = protectdest[2];
    nextnode = startnode;
    heightoffset = 0;
    if (heli_team == #"axis") {
        heightoffset = 400;
    }
    protectdest = (protectdest[0], protectdest[1], nodeheight);
    noflyzoneheight = airsupport::getnoflyzoneheight(protectdest);
    protectdest = (protectdest[0], protectdest[1], noflyzoneheight + heightoffset);
    currentdest = protectdest;
    starttime = gettime();
    self.endtime = starttime + int(level.heli_protect_time * 1000);
    self.halftime = starttime + int(level.heli_protect_time * 0.5 * 1000);
    self.killstreakendtime = int(self.endtime);
    /#
        self util::debug_slow_heli_speed();
    #/
    self set_goal_pos(self.origin + (currentdest - self.origin) / 3 + (0, 0, 1000), 0);
    self waittill(#"near_goal");
    self killstreaks::play_pilot_dialog_on_owner("arrive", hardpointtype, self.killstreak_id);
    self thread updatetargetyaw();
    mapenter = 1;
    var_13608e5f = 1;
    while (gettime() < self.endtime) {
        if (!(isdefined(self.var_b79daf6c) && self.var_b79daf6c) && gettime() >= self.halftime) {
            self killstreaks::play_pilot_dialog_on_owner("timecheck", hardpointtype);
            self.var_b79daf6c = 1;
        }
        self set_goal_pos(currentdest, 1);
        self thread updatespeedonlock();
        self waittill(#"near_goal");
        hostmigration::waittillhostmigrationdone();
        self notify(#"path start");
        if (self is_targeted()) {
            if (isdefined(var_13608e5f) && var_13608e5f) {
                var_13608e5f = 0;
            } else {
                wait 5;
            }
        } else {
            waittillframeend();
            time = level.heli_protect_pos_time;
            if (self.evasive == 1) {
                time = 2;
            }
            if (isdefined(var_13608e5f) && var_13608e5f) {
                waitresult = self waittilltimeout(time, #"locking on", #"locking on hacking", #"damage state");
                if (waitresult._notify != "timeout") {
                    var_13608e5f = 0;
                }
            } else {
                wait time;
            }
        }
        prevdest = currentdest;
        currentdest = function_de09f7d1(protectdest, nodeheight);
        noflyzoneheight = airsupport::getnoflyzoneheight(currentdest);
        currentdest = (currentdest[0], currentdest[1], noflyzoneheight + heightoffset);
        noflyzones = airsupport::crossesnoflyzones(prevdest, currentdest);
        if (isdefined(noflyzones) && noflyzones.size > 0) {
            currentdest = prevdest;
        }
    }
    self heli_set_active_camo_state(1);
    self thread heli_leave();
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0xf0943d06, Offset: 0x93d8
// Size: 0x10e
function heli_random_point_in_radius(protectdest, nodeheight) {
    min_distance = int(level.heli_protect_radius * 0.2);
    direction = randomintrange(0, 360);
    distance = randomintrange(min_distance, level.heli_protect_radius);
    x = cos(direction);
    y = sin(direction);
    x *= distance;
    y *= distance;
    return (protectdest[0] + x, protectdest[1] + y, nodeheight);
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0xd966467e, Offset: 0x94f0
// Size: 0xf6
function function_de09f7d1(protectdest, nodeheight) {
    protect_spot = heli_random_point_in_radius(protectdest, nodeheight);
    tries = 10;
    for (noflyzone = airsupport::crossesnoflyzone(protectdest, protect_spot); tries != 0 && isdefined(noflyzone); noflyzone = airsupport::crossesnoflyzone(protectdest, protect_spot)) {
        protect_spot = heli_random_point_in_radius(protectdest, nodeheight);
        tries--;
    }
    noflyzoneheight = airsupport::getnoflyzoneheightcrossed(protectdest, protect_spot, nodeheight);
    return (protect_spot[0], protect_spot[1], noflyzoneheight);
}

// Namespace helicopter/helicopter_shared
// Params 4, eflags: 0x0
// Checksum 0x7dfe7f1d, Offset: 0x95f0
// Size: 0x5ac
function heli_protect(startnode, protectdest, hardpointtype, heli_team) {
    if (!(isdefined(level.var_6fb48cdb) && level.var_6fb48cdb)) {
        self thread function_4ca43607(startnode, protectdest, hardpointtype, heli_team);
        return;
    }
    self endon(#"death", #"abandoned");
    self notify(#"flying");
    self endon(#"flying");
    heli_reset();
    self.reached_dest = 0;
    self.goalradius = 30;
    starttime = gettime();
    self.halftime = starttime + int(level.heli_protect_time * 0.5 * 1000);
    self.killstreakendtime = starttime + int(level.heli_protect_time * 1000);
    self.endtime = starttime + int(level.heli_protect_time * 1000);
    self thread function_b973a2e3();
    self thread function_91fa8e0d();
    self.protectdest = protectdest;
    self.var_f1a9f7c5 = protectdest;
    radius = 10000;
    if (isdefined(self.owner)) {
        radius = distance(protectdest, self.origin);
    }
    var_40c02d23 = getclosestpointonnavvolume(protectdest, "navvolume_big", radius);
    if (isdefined(var_40c02d23)) {
        protectdest = var_40c02d23;
        self.var_f1a9f7c5 = protectdest;
        var_c987c8fc = heli_get_protect_spot(protectdest, 300, heli_team);
        if (isdefined(var_c987c8fc)) {
            self function_6d273cc0(var_c987c8fc.origin, 1);
            protectdest = var_c987c8fc.origin;
            self.var_f1a9f7c5 = var_c987c8fc.origin;
        } else {
            self function_6d273cc0(protectdest, 1);
        }
    }
    /#
        self util::debug_slow_heli_speed();
    #/
    self thread updatetargetyaw();
    self thread updatespeedonlock();
    self function_6d273cc0(protectdest, 1);
    self waittill(#"near_goal");
    var_fc62536f = level.heli_protect_pos_time;
    var_13608e5f = 1;
    while (gettime() < self.killstreakendtime) {
        if (!(isdefined(self.var_b79daf6c) && self.var_b79daf6c) && gettime() >= self.halftime) {
            self killstreaks::play_pilot_dialog_on_owner("timecheck", hardpointtype);
            self.var_b79daf6c = 1;
        }
        var_fc62536f = randomintrange(level.var_567463c6, level.var_3b7f3818);
        if (self is_targeted()) {
            if (isdefined(var_13608e5f) && var_13608e5f) {
                var_13608e5f = 0;
            } else {
                wait var_fc62536f;
            }
        } else {
            waittillframeend();
            if (isdefined(var_13608e5f) && var_13608e5f) {
                waitresult = self waittilltimeout(var_fc62536f, #"locking on", #"locking on hacking", #"damage state");
                if (waitresult._notify != "timeout") {
                    var_13608e5f = 0;
                }
            } else {
                wait var_fc62536f;
            }
        }
        if (!isdefined(self)) {
            return;
        }
        newdest = heli_get_protect_spot(protectdest, undefined, heli_team);
        if (isdefined(newdest)) {
            self function_6d273cc0(newdest.origin, 1);
            self waittill(#"near_goal");
        } else {
            wait var_fc62536f;
        }
        hostmigration::waittillhostmigrationdone();
        self notify(#"path start");
    }
    self heli_set_active_camo_state(1);
    self thread heli_leave();
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x9b005658, Offset: 0x9ba8
// Size: 0x7e
function updatespeedonlock() {
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    while (true) {
        self waittill(#"locking on", #"locking on hacking");
        self updatespeed();
        wait 1;
    }
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x94ec882f, Offset: 0x9c30
// Size: 0x64
function updatespeed() {
    if (self is_targeted() || isdefined(self.evasive) && self.evasive) {
        set_heli_speed_evasive();
        return;
    }
    set_heli_speed_normal();
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x894dfb13, Offset: 0x9ca0
// Size: 0xfe
function updatetargetyaw() {
    self notify(#"endtargetyawupdate");
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    self endon(#"endtargetyawupdate");
    for (;;) {
        if (isdefined(self.primarytarget)) {
            yaw = math::get_2d_yaw(self.origin, self.primarytarget.origin);
            self settargetyaw(yaw);
        } else if (isdefined(self.var_f1a9f7c5)) {
            yaw = math::get_2d_yaw(self.origin, self.var_f1a9f7c5);
            self settargetyaw(yaw);
        }
        wait 1;
    }
}

// Namespace helicopter/helicopter_shared
// Params 3, eflags: 0x0
// Checksum 0x1ca46b2a, Offset: 0x9da8
// Size: 0x228
function fire_missile(smissiletype, ishots = 1, etarget) {
    assert(self.health > 0);
    weapon = undefined;
    weaponshoottime = undefined;
    tags = [];
    switch (smissiletype) {
    case #"ffar":
        weapon = getweapon(#"hind_ffar");
        tags[0] = "tag_store_r_2";
        break;
    default:
        assertmsg("<dev string:x2b3>");
        break;
    }
    assert(isdefined(weapon));
    assert(tags.size > 0);
    weaponshoottime = weapon.firetime;
    assert(isdefined(weaponshoottime));
    self setvehweapon(weapon);
    nextmissiletag = -1;
    for (i = 0; i < ishots; i++) {
        nextmissiletag++;
        if (nextmissiletag >= tags.size) {
            nextmissiletag = 0;
        }
        emissile = self fireweapon(0, etarget);
        emissile.killcament = self;
        self.lastrocketfiretime = gettime();
        if (i < ishots - 1) {
            wait weaponshoottime;
        }
    }
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0xf28a8554, Offset: 0x9fd8
// Size: 0x7c
function check_owner(hardpointtype) {
    if (!isdefined(self.owner) || !isdefined(self.owner.team) || self.owner.team != self.team) {
        self notify(#"abandoned");
        self thread heli_leave();
    }
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0xa93c9fbf, Offset: 0xa060
// Size: 0x4c
function attack_targets(missilesenabled, hardpointtype) {
    self thread attack_primary(hardpointtype);
    if (missilesenabled) {
        self thread attack_secondary(hardpointtype);
    }
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0xd404d114, Offset: 0xa0b8
// Size: 0x1b0
function attack_secondary(hardpointtype) {
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    for (;;) {
        if (isdefined(self.secondarytarget)) {
            self.secondarytarget.antithreat = undefined;
            self.missiletarget = self.secondarytarget;
            antithreat = 0;
            while (isdefined(self.missiletarget) && isalive(self.missiletarget)) {
                if (self target_cone_check(self.missiletarget, level.heli_missile_target_cone)) {
                    self thread missile_support(self.missiletarget, level.heli_missile_rof, 1, undefined);
                } else {
                    break;
                }
                antithreat += 100;
                self.missiletarget.antithreat = antithreat;
                wait level.heli_missile_rof;
                if (!isdefined(self.secondarytarget) || isdefined(self.secondarytarget) && self.missiletarget != self.secondarytarget) {
                    break;
                }
            }
            if (isdefined(self.missiletarget)) {
                self.missiletarget.antithreat = undefined;
            }
        }
        self waittill(#"secondary acquired");
        self check_owner(hardpointtype);
    }
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0xae1c0e87, Offset: 0xa270
// Size: 0x102
function turret_target_check(turrettarget, attackangle) {
    targetyaw = math::get_2d_yaw(self.origin, turrettarget.origin);
    chopperyaw = self.angles[1];
    if (targetyaw < 0) {
        targetyaw *= -1;
    }
    targetyaw = int(targetyaw) % 360;
    if (chopperyaw < 0) {
        chopperyaw *= -1;
    }
    chopperyaw = int(chopperyaw) % 360;
    if (chopperyaw > targetyaw) {
        difference = chopperyaw - targetyaw;
    } else {
        difference = targetyaw - chopperyaw;
    }
    return difference <= attackangle;
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0x97079f16, Offset: 0xa380
// Size: 0xf4
function target_cone_check(target, conecosine) {
    heli2target_normal = vectornormalize(target.origin - self.origin);
    heli2forward = anglestoforward(self.angles);
    heli2forward_normal = vectornormalize(heli2forward);
    heli_dot_target = vectordot(heli2target_normal, heli2forward_normal);
    if (heli_dot_target >= conecosine) {
        /#
            airsupport::debug_print3d_simple("<dev string:x2e0>" + heli_dot_target, self, (0, 0, -40), 40);
        #/
        return true;
    }
    return false;
}

// Namespace helicopter/helicopter_shared
// Params 4, eflags: 0x0
// Checksum 0x32c369eb, Offset: 0xa480
// Size: 0x2f6
function missile_support(target_player, rof, instantfire, endon_notify) {
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    if (isdefined(endon_notify)) {
        self endon(endon_notify);
    }
    self.turret_giveup = 0;
    if (!instantfire) {
        wait rof;
        self.turret_giveup = 1;
        self notify(#"give up");
    }
    if (isdefined(target_player)) {
        if (level.teambased) {
            for (i = 0; i < level.players.size; i++) {
                player = level.players[i];
                if (isdefined(player.team) && player.team == self.team && distance(player.origin, target_player.origin) <= level.heli_missile_friendlycare) {
                    /#
                        airsupport::debug_print3d_simple("<dev string:x2ed>", self, (0, 0, -80), 40);
                    #/
                    self notify(#"missile ready");
                    return;
                }
            }
        } else {
            player = self.owner;
            if (isdefined(player) && isdefined(player.team) && player.team == self.team && distance(player.origin, target_player.origin) <= level.heli_missile_friendlycare) {
                /#
                    airsupport::debug_print3d_simple("<dev string:x2ed>", self, (0, 0, -80), 40);
                #/
                self notify(#"missile ready");
                return;
            }
        }
    }
    if (self.missile_ammo > 0 && isdefined(target_player)) {
        self fire_missile("ffar", 1, target_player);
        self.missile_ammo--;
        self notify(#"missile fired");
    } else {
        return;
    }
    if (instantfire) {
        wait rof;
        self notify(#"missile ready");
    }
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x1a4216b7, Offset: 0xa780
// Size: 0x468
function attack_primary(hardpointtype) {
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    level endon(#"game_ended");
    self turretsetontargettolerance(0, 5);
    for (;;) {
        if (isdefined(self.primarytarget)) {
            self.primarytarget.antithreat = undefined;
            self.turrettarget = self.primarytarget;
            antithreat = 0;
            last_pos = undefined;
            while (isdefined(self.turrettarget) && isalive(self.turrettarget)) {
                if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
                    self vehlookat(self.turrettarget);
                }
                if (!isdefined(self.turrettarget) || !isalive(self.turrettarget)) {
                    break;
                }
                self turret::set_target(self.turrettarget, undefined, 0);
                self setvehweapon(self.defaultweapon);
                while (!self.turretontarget) {
                    waitframe(1);
                }
                self notify(#"turret_on_target");
                self heli_set_active_camo_state(0);
                wait level.heli_turret_spinup_delay;
                weaponshoottime = self.defaultweapon.firetime;
                self setvehweapon(self.defaultweapon);
                for (i = 0; i < level.heli_turretclipsize; i++) {
                    if (isdefined(self.turrettarget) && isdefined(self.primarytarget)) {
                        if (self.primarytarget != self.turrettarget) {
                            self turret::set_target(self.primarytarget, undefined, 0);
                            while (!self.turretontarget) {
                                waitframe(1);
                            }
                        }
                    }
                    if (gettime() != self.lastrocketfiretime) {
                        if (isdefined(self.primarytarget)) {
                            self turret::set_target(self.primarytarget, undefined, 0);
                            s_turret = self turret::_get_turret_data(0);
                            minigun = self fireweapon(0, self.primarytarget, s_turret.v_offset);
                        } else {
                            minigun = self fireweapon();
                        }
                    }
                    waitframe(1);
                }
                self notify(#"turret reloading");
                wait level.heli_turretreloadtime;
                self heli_set_active_camo_state(1);
                if (isdefined(self.turrettarget) && isalive(self.turrettarget)) {
                    antithreat += 100;
                    self.turrettarget.antithreat = antithreat;
                }
                if (!isdefined(self.primarytarget) || isdefined(self.turrettarget) && isdefined(self.primarytarget) && self.primarytarget != self.turrettarget) {
                    break;
                }
            }
            if (isdefined(self.turrettarget)) {
                self.turrettarget.antithreat = undefined;
            }
        }
        self waittill(#"primary acquired");
        self check_owner(hardpointtype);
    }
}

/#

    // Namespace helicopter/helicopter_shared
    // Params 0, eflags: 0x0
    // Checksum 0x508d3cdf, Offset: 0xabf0
    // Size: 0x25c
    function debug_print_target() {
        if (isdefined(level.heli_debug) && level.heli_debug == 1) {
            if (isdefined(self.primarytarget) && isdefined(self.primarytarget.threatlevel)) {
                if (isdefined(self.primarytarget.type) && self.primarytarget.type == "<dev string:x314>") {
                    name = "<dev string:x314>";
                } else {
                    name = self.primarytarget.name;
                }
                primary_msg = "<dev string:x318>" + name + "<dev string:x322>" + self.primarytarget.threatlevel;
            } else {
                primary_msg = "<dev string:x318>";
            }
            if (isdefined(self.secondarytarget) && isdefined(self.secondarytarget.threatlevel)) {
                if (isdefined(self.secondarytarget.type) && self.secondarytarget.type == "<dev string:x314>") {
                    name = "<dev string:x314>";
                } else {
                    name = self.secondarytarget.name;
                }
                secondary_msg = "<dev string:x326>" + name + "<dev string:x322>" + self.secondarytarget.threatlevel;
            } else {
                secondary_msg = "<dev string:x326>";
            }
            frames = int(self.targeting_delay * 20) + 1;
            thread airsupport::draw_text(primary_msg, (1, 0.6, 0.6), self, (0, 0, 40), frames);
            thread airsupport::draw_text(secondary_msg, (1, 0.6, 0.6), self, (0, 0, 0), frames);
        }
    }

#/

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x15e6514a, Offset: 0xae58
// Size: 0x4e
function waittill_confirm_location() {
    self endon(#"emp_jammed");
    self endon(#"emp_grenaded");
    waitresult = self waittill(#"confirm_location");
    return waitresult.position;
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0xb0abeee2, Offset: 0xaeb0
// Size: 0xba
function selecthelicopterlocation(hardpointtype) {
    self airsupport::function_277a9e(&function_75f79c69);
    location = self airsupport::waitforlocationselection();
    if (!isdefined(location)) {
        return 0;
    }
    if (self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0) {
        return 0;
    }
    level.helilocation = location.origin;
    return airsupport::function_4293d951(location.origin);
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0x7af7120, Offset: 0xaf78
// Size: 0x124
function processcopterassist(destroyedcopter, damagedone) {
    self endon(#"disconnect");
    destroyedcopter endon(#"disconnect");
    waitframe(1);
    if (!isdefined(level.teams[self.team])) {
        return;
    }
    if (self.team == destroyedcopter.team) {
        return;
    }
    assist_level = "aircraft_destruction_assist";
    assist_level_value = int(ceil(damagedone.damage / destroyedcopter.maxhealth * 4));
    if (assist_level_value > 0) {
        if (assist_level_value > 3) {
            assist_level_value = 3;
        }
        assist_level = assist_level + "_" + assist_level_value * 25;
    }
    scoreevents::processscoreevent(assist_level, self, undefined, undefined);
}

// Namespace helicopter/helicopter_shared
// Params 4, eflags: 0x0
// Checksum 0x134d610c, Offset: 0xb0a8
// Size: 0xf4
function playpilotdialog(dialog, time, voice, shouldwait) {
    self endon(#"death");
    level endon(#"remote_end");
    if (isdefined(time)) {
        wait time;
    }
    if (!isdefined(self.pilotvoicenumber)) {
        self.pilotvoicenumber = 0;
    }
    if (isdefined(voice)) {
        voicenumber = voice;
    } else {
        voicenumber = self.pilotvoicenumber;
    }
    soundalias = level.teamprefix[self.team] + voicenumber + "_" + dialog;
    if (isdefined(self.owner)) {
        self.owner playpilottalking(shouldwait, soundalias);
    }
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0x23013b11, Offset: 0xb1a8
// Size: 0xde
function playpilottalking(shouldwait, soundalias) {
    self endon(#"disconnect");
    self endon(#"joined_team");
    self endon(#"joined_spectators");
    for (trycounter = 0; isdefined(self.pilottalking) && self.pilottalking && trycounter < 10; trycounter++) {
        if (isdefined(shouldwait) && !shouldwait) {
            return;
        }
        wait 1;
    }
    self.pilottalking = 1;
    self playlocalsound(soundalias);
    wait 3;
    self.pilottalking = 0;
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0xe60c05f6, Offset: 0xb290
// Size: 0xc6
function watchforearlyleave(chopper) {
    chopper notify(#"watchforearlyleave_helicopter");
    chopper endon(#"watchforearlyleave_helicopter");
    chopper endon(#"death");
    self endon(#"heli_timeup");
    self waittill(#"disconnect", #"joined_team", #"joined_spectator");
    if (isdefined(chopper)) {
        chopper thread heli_leave();
    }
    if (isdefined(self)) {
        self notify(#"heli_timeup");
    }
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0xe9715cd1, Offset: 0xb360
// Size: 0xc4
function watchforemp() {
    heli = self;
    heli endon(#"death", #"heli_timeup");
    heli.owner endon(#"disconnect", #"joined_team", #"joined_spectator", #"changed_specialist");
    heli.owner waittill(#"emp_jammed");
    heli thread heli_explode();
}

