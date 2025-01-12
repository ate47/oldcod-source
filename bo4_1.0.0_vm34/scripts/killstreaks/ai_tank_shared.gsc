#using script_46fade957db10c16;
#using script_52d2de9b438adc78;
#using scripts\abilities\ability_player;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\blackboard_vehicle;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\lui_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\targetting_delay;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\emp_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\remote_weapons;
#using scripts\weapons\heatseekingmissile;

#namespace ai_tank;

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0xb9bb1d9, Offset: 0x6c0
// Size: 0x3fc
function init_shared(bundlename) {
    if (!isdefined(level.var_e5eeac3a)) {
        level.var_e5eeac3a = {};
        ir_strobe::init_shared();
        remote_weapons::init_shared();
        airsupport::init_shared();
        if (!isdefined(bundlename)) {
            bundlename = "killstreak_tank_robot";
        }
        level.var_78159f7c = [];
        if (!(isdefined(level.var_db13f6c8) && level.var_db13f6c8)) {
            for (ti = 0; ti < 5; ti++) {
                level.var_78159f7c[ti] = multi_stage_target_lockon::register("multi_stage_target_lockon" + ti);
            }
        }
        bundle = struct::get_script_bundle("killstreak", bundlename);
        level.var_e5eeac3a.aitankkillstreakbundle = bundle;
        killstreaks::register_bundle(bundle, &usekillstreakaitankdrop);
        killstreaks::register_remote_override_weapon("tank_robot", "killstreak_ai_tank");
        killstreaks::function_71b27c39("tank_robot", getweapon(#"tank_robot_launcher_turret"));
        ir_strobe::function_aede4f7c(#"ai_tank_marker", &spawn_tank_robot);
        level.killstreaks[#"tank_robot"].threatonkill = 1;
        if (ispc()) {
            remote_weapons::registerremoteweapon("killstreak_ai_tank", #"hash_3abd55f34c1661ac", &starttankremotecontrol, &endtankremotecontrol, 1);
        } else {
            remote_weapons::registerremoteweapon("killstreak_ai_tank", #"hash_747fc4429380f380", &starttankremotecontrol, &endtankremotecontrol, 1);
        }
        level.var_f9f0faef = bundle.ksweapon;
        level.ai_tank_damage_fx = "killstreaks/fx_agr_damage_state";
        level.ai_tank_explode_fx = "killstreaks/fx8_agr_explosion";
        level.ai_tank_crate_explode_fx = "killstreaks/fx_agr_drop_box";
        if (!isdefined(bundle.ksmainturretrecoilforcezoffset)) {
            bundle.ksmainturretrecoilforcezoffset = 0;
        }
        if (!isdefined(bundle.ksweaponreloadtime)) {
            bundle.ksweaponreloadtime = 0.5;
        }
        visionset_mgr::register_info("visionset", "agr_visionset", 1, 80, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
        callback::on_spawned(&on_player_spawned);
        function_87bdae1c();
        thread register();
        level.var_602292e5 = new throttle();
        [[ level.var_602292e5 ]]->initialize(1, 0.5);
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0x210e2ddc, Offset: 0xac8
// Size: 0x12c
function on_player_spawned() {
    if (isdefined(level.var_f9f0faef) && !self hasweapon(level.var_f9f0faef)) {
        self clientfield::set_player_uimodel("hudItems.tankState", 0);
    }
    foreach (player in level.players) {
        if (!isdefined(player)) {
            continue;
        }
        if (self.team == player.team) {
            continue;
        }
        if (isdefined(player.ai_tank_drone)) {
            player.ai_tank_drone respectnottargetedbyaitankperk(self);
        }
    }
    cleanup_targeting(self);
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0xc81aaf35, Offset: 0xc00
// Size: 0x27e
function function_87bdae1c() {
    level.var_474a12f2 = struct::get_array("datapad_loc", "targetname");
    foreach (point in level.var_474a12f2) {
        point.objectiveid = gameobjects::get_next_obj_id();
        objective_add(point.objectiveid, "invisible", point.origin, #"datapad_location");
        objective_setinvisibletoall(point.objectiveid);
    }
    var_e97cb7cb = struct::get_array("datapad_patrol_loc", "targetname");
    foreach (point in var_e97cb7cb) {
        point.objectiveid = gameobjects::get_next_obj_id();
        objective_add(point.objectiveid, "invisible", point.origin, #"hash_60fb0be7a198b305");
        objective_setinvisibletoall(point.objectiveid);
        if (!isdefined(level.var_474a12f2)) {
            level.var_474a12f2 = [];
        } else if (!isarray(level.var_474a12f2)) {
            level.var_474a12f2 = array(level.var_474a12f2);
        }
        level.var_474a12f2[level.var_474a12f2.size] = point;
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0x1a19e9db, Offset: 0xe88
// Size: 0xf4
function register() {
    clientfield::register("vehicle", "ai_tank_death", 1, 1, "int");
    clientfield::register("vehicle", "ai_tank_immobile", 1, 1, "int");
    clientfield::register("vehicle", "ai_tank_change_control", 1, 1, "int");
    clientfield::register("toplayer", "ai_tank_update_hud", 1, 1, "counter");
    clientfield::register("clientuimodel", "hudItems.tankState", 1, 3, "int");
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0xc129decb, Offset: 0xf88
// Size: 0x3c
function function_6ba537a7(waittime) {
    self endon(#"disconnect");
    wait waittime;
    lui::screen_fade_in(0);
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0xfe101cb5, Offset: 0xfd0
// Size: 0xf4
function watchforentervehicle() {
    self endon(#"emp_jammed");
    self endon(#"emp_grenaded");
    self endon(#"disconnect");
    self endon(#"confirm_location");
    self endon(#"cancel_location");
    self waittill(#"enter_vehicle");
    if (self remote_weapons::allowremotestart(1) && isdefined(self.ai_tank_drone)) {
        thread function_6ba537a7(3);
        lui::screen_fade_out(0.1);
        self thread remote_weapons::useremoteweapon(self.ai_tank_drone, "killstreak_ai_tank", 1, 1, 1);
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0xd61caae, Offset: 0x10d0
// Size: 0x64
function function_7e779137() {
    self clientfield::set_player_uimodel("locSel.snapTo", 1);
    self function_ed6ca1c5("map_directional_selector");
    self.selectinglocation = 1;
    self thread airsupport::endselectionthink();
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0x85651f6c, Offset: 0x1140
// Size: 0x3c
function function_14c86435() {
    self function_7e779137();
    self clientfield::set_player_uimodel("locSel.commandMode", 0);
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0xbb2f90c0, Offset: 0x1188
// Size: 0x3c
function function_a1909dd9() {
    self function_7e779137();
    self clientfield::set_player_uimodel("locSel.commandMode", 1);
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0x3fed48fc, Offset: 0x11d0
// Size: 0x28
function islocselincommandmode() {
    return self clientfield::get_player_uimodel("locSel.commandMode") == 1;
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x95f267c4, Offset: 0x1200
// Size: 0x1ca
function usekillstreakaitankdrop(killstreaktype) {
    team = self.team;
    waterdepth = self depthofplayerinwater();
    if (!self isonground() || self util::isusingremote() || waterdepth > 2) {
        self iprintlnbold(#"hash_ec04d7a9114ba0e");
        return 0;
    }
    context = spawnstruct();
    context.radius = level.killstreakcorebundle.ksairdropsupplydropradius;
    context.dist_from_boundary = 50;
    context.max_dist_from_location = 4;
    context.perform_physics_trace = 1;
    context.islocationgood = &islocationgood;
    context.objective = #"hash_1b5a86007f598bbc";
    context.validlocationsound = level.killstreakcorebundle.ksvalidcarepackagelocationsound;
    context.tracemask = 1 | 4;
    context.droptag = "tag_cargo_attach";
    context.killstreaktype = #"ai_tank_marker";
    context.dontdisconnectpaths = 1;
    return self ir_strobe::function_7707d9be(undefined, context);
}

// Namespace ai_tank/ai_tank_shared
// Params 3, eflags: 0x0
// Checksum 0xc7fb33a8, Offset: 0x13d8
// Size: 0x8c
function spawn_tank_robot(owner, context, origin) {
    location = spawnstruct();
    location.origin = origin;
    owner clientfield::set_player_uimodel("hudItems.tankState", 1);
    owner airsupport::function_4293d951(location, &function_369477a8);
}

// Namespace ai_tank/ai_tank_shared
// Params 2, eflags: 0x0
// Checksum 0x41f10d29, Offset: 0x1470
// Size: 0x266
function function_cff5746f(location, context) {
    if (!self killstreakrules::iskillstreakallowed("tank_robot", self.team)) {
        return false;
    }
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

// Namespace ai_tank/ai_tank_shared
// Params 2, eflags: 0x0
// Checksum 0xb5487fd2, Offset: 0x16e0
// Size: 0x430
function islocationgood(location, context) {
    if (getdvarint(#"hash_458cd0a10d30cedb", 1)) {
        return function_cff5746f(location, context);
    }
    if (!self killstreakrules::iskillstreakallowed("tank_robot", self.team)) {
        return 0;
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
            if (!(isdefined(level.var_25b256f9) && level.var_25b256f9)) {
                return 0;
            }
        }
    }
    isvalidpoint = 1;
    if (ispointonnavmesh(location, context.dist_from_boundary)) {
        closestpoint = getclosestpointonnavmesh(location, max(context.max_dist_from_location, 24), context.dist_from_boundary);
        isvalidpoint = isdefined(closestpoint);
        if (isvalidpoint && context.check_same_floor === 1 && abs(location[2] - closestpoint[2]) > 96) {
            isvalidpoint = 0;
        }
    } else {
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

// Namespace ai_tank/ai_tank_shared
// Params 2, eflags: 0x0
// Checksum 0x8c86a7a2, Offset: 0x1b18
// Size: 0x9c
function function_8dcc4b08(team, killstreak_id) {
    self endon(#"payload_delivered", #"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist");
    self waittill(#"payload_fail");
    self killstreakrules::killstreakstop("tank_robot", team, killstreak_id);
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0x27a1750c, Offset: 0x1bc0
// Size: 0xdc
function function_9612a5dd() {
    self endon(#"death", #"changed_specialist", #"disconnect", #"joined_team", #"joined_spectators");
    killstreakweapon = killstreaks::get_killstreak_weapon("tank_robot");
    while (true) {
        quantity = killstreaks::get_killstreak_quantity(killstreakweapon);
        if (quantity === 0) {
            break;
        }
        waitframe(1);
    }
    killstreaks::change_killstreak_quantity(killstreakweapon, 1);
}

// Namespace ai_tank/ai_tank_shared
// Params 2, eflags: 0x0
// Checksum 0x7ba4d635, Offset: 0x1ca8
// Size: 0x2f8
function function_369477a8(location, killstreak_id) {
    team = self.team;
    killstreak_id = self killstreakrules::killstreakstart("tank_robot", team, 0, 1);
    if (killstreak_id == -1) {
        return false;
    }
    bundle = level.var_e5eeac3a.aitankkillstreakbundle;
    killstreak = killstreaks::get_killstreak_for_weapon(bundle.ksweapon);
    context = spawnstruct();
    if (!isdefined(context)) {
        killstreak_stop_and_assert(killstreak, team, killstreak_id, "Failed to spawn struct for ai tank.");
        return false;
    }
    self ability_player::function_184edba5(bundle.ksweapon);
    context.radius = level.killstreakcorebundle.ksairdropaitankradius;
    context.dist_from_boundary = 50;
    context.max_dist_from_location = 4;
    context.perform_physics_trace = 1;
    context.selectedlocation = location;
    context.islocationgood = &is_location_good;
    context.objective = #"airdrop_aitank";
    context.killstreakref = killstreak;
    context.validlocationsound = level.killstreakcorebundle.ksvalidaitanklocationsound;
    context.vehiclename = #"vehicle_t8_mil_helicopter_transport_mp";
    context.tracemask = 1 | 4;
    context.droptag = "tag_cargo_attach";
    context.var_b9e1781a = 1;
    context.dontdisconnectpaths = 1;
    if (!isdefined(level.var_7cda9384)) {
        return false;
    }
    result = [[ level.var_7cda9384 ]](killstreak_id, context, team);
    if (!(isdefined(result) && result)) {
        killstreakrules::killstreakstop("tank_robot", team, killstreak_id);
        return false;
    }
    self thread function_10801db1(team, killstreak_id);
    self stats::function_4f10b697(bundle.ksweapon, #"used", 1);
    return true;
}

// Namespace ai_tank/ai_tank_shared
// Params 2, eflags: 0x0
// Checksum 0x42d6e693, Offset: 0x1fa8
// Size: 0xbc
function function_10801db1(team, killstreak_id) {
    self notify("5f1d229765269ba8");
    self endon("5f1d229765269ba8");
    player = self;
    player endon(#"tank_robot");
    player waittill(#"changed_specialist", #"disconnect", #"joined_team", #"joined_spectators");
    killstreakrules::killstreakstop("tank_robot", team, killstreak_id);
}

// Namespace ai_tank/ai_tank_shared
// Params 2, eflags: 0x0
// Checksum 0x3f054f7f, Offset: 0x2070
// Size: 0xcc
function function_67e8f6af(location, context) {
    if (!ispointonnavmesh(location)) {
        /#
            recordsphere(location + (0, 0, 10), 2, (1, 0, 0), "<dev string:x30>");
        #/
        return false;
    }
    var_c51e5334 = 5;
    depth = getwaterheight(location) - self.origin[2];
    inwater = depth > var_c51e5334;
    if (inwater) {
        return false;
    }
    return true;
}

// Namespace ai_tank/ai_tank_shared
// Params 5, eflags: 0x0
// Checksum 0xa8856d5c, Offset: 0x2148
// Size: 0x254
function crateland(crate, category, owner, team, context) {
    owner notify(#"tank_robot");
    context.perform_physics_trace = 0;
    context.dist_from_boundary = 50;
    context.max_dist_from_location = 96;
    if (!crate function_67e8f6af(crate.origin, context) || !isdefined(owner) || team != owner.team || owner emp::enemyempactive() && !owner hasperk(#"specialty_immuneemp")) {
        killstreakrules::killstreakstop(category, team, crate.package_contents_id);
        wait 10;
        if (isdefined(crate)) {
            crate delete();
        }
        return;
    }
    origin = crate.origin;
    cratebottom = bullettrace(origin, origin + (0, 0, -50), 0, crate);
    if (isdefined(cratebottom)) {
        origin = cratebottom[#"position"] + (0, 0, 1);
    }
    playfx(level.ai_tank_crate_explode_fx, origin, (1, 0, 0), (0, 0, 1));
    playsoundatposition(#"veh_talon_crate_exp", crate.origin);
    level thread ai_tank_killstreak_start(owner, origin, crate.package_contents_id, category, undefined, context);
    if (!isdefined(context.vehicle)) {
        crate delete();
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 2, eflags: 0x0
// Checksum 0x8e68ff44, Offset: 0x23a8
// Size: 0x18
function is_location_good(location, context) {
    return true;
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x66d0ac75, Offset: 0x23c8
// Size: 0x134
function hackedcallbackpre(hacker) {
    drone = self;
    drone clientfield::set("enemyvehicle", 2);
    drone.owner stop_remote();
    drone.owner clientfield::set_to_player("static_postfx", 0);
    if (drone.controlled === 1) {
        visionset_mgr::deactivate("visionset", "agr_visionset", drone.owner);
    }
    drone.owner remote_weapons::removeandassignnewremotecontroltrigger(drone.usetrigger);
    drone remote_weapons::endremotecontrolweaponuse(1);
    drone.owner unlink();
    drone clientfield::set("vehicletransition", 0);
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x7566b724, Offset: 0x2508
// Size: 0x76
function hackedcallbackpost(hacker) {
    drone = self;
    hacker remote_weapons::useremoteweapon(drone, "killstreak_ai_tank", 0);
    drone notify(#"watchremotecontroldeactivate_remoteweapons");
    drone.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now(drone);
}

// Namespace ai_tank/ai_tank_shared
// Params 2, eflags: 0x0
// Checksum 0x622a1a12, Offset: 0x2588
// Size: 0x34
function configureteampost(owner, ishacked) {
    drone = self;
    drone thread tank_watch_owner_events();
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x37147e8b, Offset: 0x25c8
// Size: 0x49c
function function_a15a0a3f(drone) {
    drone useanimtree("generic");
    vehicle::make_targetable(drone);
    blackboard::createblackboardforentity(drone);
    drone blackboard::registervehicleblackboardattributes();
    drone.health = drone.healthdefault;
    drone vehicle::friendly_fire_shield();
    drone enableaimassist();
    drone setneargoalnotifydist(40);
    drone setplayercollision(0);
    drone setavoidancemask("avoid none");
    drone.fovcosine = 0;
    drone.fovcosinebusy = 0.574;
    assert(isdefined(drone.scriptbundlesettings));
    drone.settings = struct::get_script_bundle("vehiclecustomsettings", drone.scriptbundlesettings);
    drone.goalheight = 512;
    drone setgoal(drone.origin, 0, drone.goalradius, drone.goalheight);
    drone.delete_on_death = 1;
    drone.no_free_on_death = 1;
    drone.overridevehicledamage = &drone_callback_damage;
    drone thread vehicle_ai::nudge_collision();
    drone.cobra = 0;
    drone asmrequestsubstate(#"locomotion@movement");
    drone.variant = "light_weight";
    drone.var_59227300 = 1;
    drone.var_7fa2f852 = 1;
    drone.var_3ef9bfb3 = 0;
    drone util::cooldown("cobra_up", 10);
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](drone);
    }
    drone.var_304c2e6e = 1;
    drone vehicle_ai::init_state_machine_for_role("default");
    drone vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
    if (drone.vehicletype == #"archetype_mini_quadtank_ct") {
        drone vehicle_ai::get_state_callbacks("combat").update_func = &function_a2d545b1;
    } else {
        drone vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    }
    drone vehicle_ai::get_state_callbacks("driving").update_func = &state_driving_update;
    drone vehicle_ai::get_state_callbacks("driving").exit_func = &function_fc0e288f;
    drone vehicle_ai::get_state_callbacks("emped").update_func = &state_emped_update;
    drone vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    drone vehicle_ai::startinitialstate("combat");
    drone thread targetting_delay::function_3362444f(level.killstreakbundle[#"tank_robot"].var_50d8ae50);
}

// Namespace ai_tank/ai_tank_shared
// Params 15, eflags: 0x0
// Checksum 0xe153cb6d, Offset: 0x2a70
// Size: 0xd2
function drone_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    idamage = vehicle_ai::shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    return idamage;
}

// Namespace ai_tank/ai_tank_shared
// Params 6, eflags: 0x0
// Checksum 0x25f5eafc, Offset: 0x2b50
// Size: 0x6b8
function ai_tank_killstreak_start(owner, origin, killstreak_id, category, tankarchetype, context) {
    team = owner.team;
    waittillframeend();
    if (level.gameended) {
        return;
    }
    if (!isdefined(tankarchetype)) {
        tankarchetype = #"archetype_mini_quadtank_mp";
    }
    if (isdefined(context) && isdefined(context.vehicle)) {
        drone = context.vehicle;
    } else {
        drone = spawnvehicle(tankarchetype, origin + (0, 0, 20), (0, 0, 0), "talon", undefined, 1, owner);
    }
    drone killstreak_bundles::spawned(level.killstreakbundle[#"tank_robot"]);
    if (!isdefined(drone)) {
        killstreak_stop_and_assert(category, team, killstreak_id, "Failed to spawn ai tank vehicle.");
        return;
    }
    function_a15a0a3f(drone);
    owner clientfield::set_player_uimodel("hudItems.tankState", 2);
    drone.settings = struct::get_script_bundle("vehiclecustomsettings", drone.scriptbundlesettings);
    drone.isstunned = 0;
    drone.var_2f438c71 = 0;
    aiutility::addaioverridedamagecallback(drone, &function_7dca865a);
    drone.customdamagemonitor = 1;
    drone.avoid_shooting_owner = 1;
    drone.avoid_shooting_owner_ref_tag = "tag_flash_gunner1";
    drone killstreaks::configure_team("tank_robot", killstreak_id, owner, "small_vehicle", undefined, &configureteampost);
    drone killstreak_hacking::enable_hacking("tank_robot", &hackedcallbackpre, &hackedcallbackpost);
    drone killstreaks::setup_health("tank_robot", 5000, 0);
    drone.original_vehicle_type = drone.vehicletype;
    drone clientfield::set("enemyvehicle", 1);
    drone setvehicleavoidance(1);
    owner clientfield::set_player_uimodel("vehicle.ammoCount", 4);
    drone.killstreak_id = killstreak_id;
    drone.type = "tank_drone";
    drone.dontdisconnectpaths = 1;
    drone.soundmod = "drone_land";
    drone.ignore_vehicle_underneath_splash_scalar = 1;
    drone.treat_owner_damage_as_friendly_fire = 1;
    drone.ignore_team_kills = 1;
    drone.var_7fa2f852 = 1;
    drone.offhand_special = 1;
    drone.var_fe11b7ad = 1;
    drone.goalradius = 250;
    if (isdefined(level.var_a2209510)) {
        drone [[ level.var_a2209510 ]]();
    }
    drone.controlled = 0;
    drone makevehicleunusable();
    drone.numberrockets = 4;
    drone.warningshots = 3;
    drone setdrawinfrared(1);
    target_set(drone, (0, 0, 20));
    drone vehicle::init_target_group();
    drone vehicle::add_to_target_group(drone);
    drone setneargoalnotifydist(35);
    drone setup_gameplay_think(category);
    drone.killstreak_end_time = gettime() + 90000;
    params = level.killstreakbundle[#"tank_robot"];
    immediate_use = isdefined(params.ksuseimmediately) ? params.ksuseimmediately : 0;
    waitframe(1);
    owner remote_weapons::useremoteweapon(drone, "killstreak_ai_tank", immediate_use);
    owner.var_eb3b93ad = #"tank_robot";
    owner thread function_d5192787(drone);
    drone thread kill_monitor();
    drone thread deleteonkillbrush(drone.owner);
    drone thread tank_rocket_watch_ai();
    drone callback::function_1dea870d(#"on_end_game", &on_end_game);
    drone playloopsound(#"hash_aa65b39680b8d1b");
    owner.ai_tank_drone = drone;
    foreach (player in level.players) {
        drone respectnottargetedbyaitankperk(player);
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x76fe2c9b, Offset: 0x3210
// Size: 0x70
function function_d5192787(weapon) {
    weapon endon(#"remote_weapon_end", #"death");
    while (self.var_eb3b93ad == #"tank_robot") {
        waitframe(1);
    }
    weapon notify(#"remote_weapon_end");
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x6d885992, Offset: 0x3288
// Size: 0x7b4
function function_b72ff26a(player) {
    self notify(#"hash_3eddb5faa34443ee");
    self endon(#"hash_3eddb5faa34443ee");
    tank = self;
    self endon(#"death");
    fovcosine = cos(15);
    player.var_c2a2dd80 = [];
    player.var_577f2157 = [];
    for (ti = 0; ti < 5; ti++) {
        player.var_c2a2dd80[ti] = spawnstruct();
        player.var_c2a2dd80[ti].state = 0;
        uifield = level.var_78159f7c[ti];
        if (!uifield multi_stage_target_lockon::is_open(player)) {
            uifield multi_stage_target_lockon::open(player, 1);
        }
        uifield multi_stage_target_lockon::set_entnum(player, player.clientid);
        uifield multi_stage_target_lockon::set_targetstate(player, 0);
    }
    enemies = getplayers(util::getotherteam(player.team));
    ti = 0;
    foreach (enemy in enemies) {
        if (isplayer(enemy)) {
            entnum = enemy getentitynumber();
            player.var_577f2157[entnum] = ti;
            ti++;
            if (ti >= 5) {
                break;
            }
        }
    }
    while (true) {
        origin = player getplayercamerapos();
        angles = player getplayerangles();
        var_f7700441 = anglestoforward(angles);
        fwd = vectorscale(var_f7700441, 2000);
        locking = player adsbuttonpressed();
        nlocks = 0;
        enemies = getplayers(util::getotherteam(player.team));
        foreach (target in enemies) {
            if (!isplayer(target)) {
                continue;
            }
            if (target hasperk(#"specialty_nokillstreakreticle")) {
                continue;
            }
            var_fa0cbe4c = target getentitynumber();
            ti = player.var_577f2157[var_fa0cbe4c];
            if (!isdefined(ti)) {
                continue;
            }
            uifield = level.var_78159f7c[ti];
            target_info = player.var_c2a2dd80[ti];
            if (target.ignoreme === 1 || !isalive(target)) {
                target_info.state = 0;
            } else if (!bullettracepassed(origin, target.origin + (0, 0, 60), 0, player)) {
                target_info.state = 0;
            } else if (target_info.state != 4) {
                if (locking) {
                    good = util::within_fov(origin, angles, target.origin, fovcosine);
                    if (isdefined(good) && good && nlocks < self.numberrockets) {
                        if (target_info.state != 3) {
                            if (target_info.state == 2) {
                                if (target_info.var_58a8472c < gettime()) {
                                    target_info.state = 3;
                                    self playsoundtoplayer(#"hash_683ed977cfc2bf2b", player);
                                }
                            } else {
                                target_info.state = 2;
                                target_info.var_58a8472c = gettime() + 500;
                                self playsoundtoplayer(#"hash_5386a095fd840c2e", player);
                            }
                        }
                        nlocks++;
                    } else {
                        target_info.state = 1;
                    }
                } else {
                    target_info.state = 1;
                }
            }
            uifield multi_stage_target_lockon::set_entnum(player, var_fa0cbe4c);
            uifield multi_stage_target_lockon::set_targetstate(player, target_info.state);
        }
        foreach (target in enemies) {
            var_fa0cbe4c = target getentitynumber();
            ti = player.var_577f2157[var_fa0cbe4c];
            if (isdefined(ti)) {
                if (!isdefined(target) || !isalive(target)) {
                    level.var_78159f7c[ti] multi_stage_target_lockon::set_entnum(player, var_fa0cbe4c);
                    level.var_78159f7c[ti] multi_stage_target_lockon::set_targetstate(player, 0);
                    player.var_c2a2dd80[ti].state = 0;
                }
            }
        }
        waitframe(1);
        waitframe(1);
        waitframe(1);
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 15, eflags: 0x4
// Checksum 0x79d73f22, Offset: 0x3a48
// Size: 0xb4
function private function_7dca865a(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(einflictor) && einflictor == self) {
        return 0;
    }
    if (isdefined(eattacker) && eattacker == self) {
        return 0;
    }
    return idamage;
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0xeab7e6f0, Offset: 0x3b08
// Size: 0xac
function state_death_update(params) {
    self endon(#"death");
    death_type = vehicle_ai::get_death_type(params);
    if (!isdefined(death_type)) {
        params.death_type = "gibbed";
        death_type = params.death_type;
    }
    if (death_type === "suicide_crash") {
        self death_suicide_crash(params);
    }
    self vehicle_ai::defaultstate_death_update(params);
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x4f8a21cc, Offset: 0x3bc0
// Size: 0x1ca
function death_suicide_crash(params) {
    self endon(#"death");
    goaldir = anglestoforward(self.angles);
    goaldist = randomfloatrange(300, 400);
    goalpos = self.origin + goaldir * goaldist;
    self setmaxspeedscale(880 / self getmaxspeed(1));
    self setmaxaccelerationscale(50 / self getdefaultacceleration());
    self setspeed(self.settings.defaultmovespeed);
    self function_3c8dce03(goalpos, 0);
    self waittilltimeout(3.5, #"near_goal", #"veh_collision");
    self setmaxspeedscale(0.1);
    self setspeed(0.1);
    self vehicle_ai::clearallmovement();
    self vehicle_ai::clearalllookingandtargeting();
    self.death_type = "gibbed";
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0xb5327074, Offset: 0x3d98
// Size: 0xfc
function state_emped_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    angles = self gettagangles("tag_turret");
    self turretsettargetangles(0, (45, angles[1] - self.angles[1], 0));
    angles = self gettagangles("tag_gunner_turret1");
    self turretsettargetangles(1, (45, angles[1] - self.angles[1], 0));
    self vehicle_ai::defaultstate_emped_update(params);
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0xc841ae73, Offset: 0x3ea0
// Size: 0xf0
function state_driving_update(params) {
    self endon(#"change_state", #"death");
    if (isdefined(self.var_7fa2f852) && self.var_7fa2f852) {
        return;
    }
    driver = self getseatoccupant(0);
    if (isplayer(driver)) {
        while (true) {
            driver endon(#"disconnect");
            driver util::waittill_vehicle_move_up_button_pressed();
            if (self.cobra === 0) {
                self cobra_raise();
                continue;
            }
            self cobra_retract();
        }
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0xc37ca33, Offset: 0x3f98
// Size: 0xea
function function_fc0e288f(params) {
    if (isalive(self) && isvehicle(self)) {
        self enableaimassist();
        self.turretrotscale = 1;
        vehicle_ai::clearalllookingandtargeting();
        vehicle_ai::clearallmovement();
        if (!ispointonnavmesh(self.origin, self)) {
            newpos = getclosestpointonnavmesh(self.origin, self.radius * 3, self.radius * 2);
            if (isdefined(newpos)) {
                self.origin = newpos;
            }
        }
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0xd0a51e9a, Offset: 0x4090
// Size: 0xe4
function cobra_raise() {
    if (isdefined(self.var_7fa2f852) && self.var_7fa2f852) {
        return;
    }
    self.cobra = 1;
    if (isdefined(self.settings.cobra_fx_1) && isdefined(self.settings.cobra_tag_1)) {
        playfxontag(self.settings.cobra_fx_1, self, self.settings.cobra_tag_1);
    }
    self asmrequestsubstate(#"hash_3e3fc20d5fcbf6e0");
    self vehicle_ai::waittill_asm_complete(#"hash_3e3fc20d5fcbf6e0", 4);
    self laseron();
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0xe325eaf4, Offset: 0x4180
// Size: 0x8c
function cobra_retract() {
    if (isdefined(self.var_7fa2f852) && self.var_7fa2f852) {
        return;
    }
    self.cobra = 0;
    self laseroff();
    self notify(#"disable_lens_flare");
    self asmrequestsubstate(#"locomotion@movement");
    self vehicle_ai::waittill_asm_complete("locomotion@movement", 4);
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x4
// Checksum 0xc9922947, Offset: 0x4218
// Size: 0xb4
function private state_combat_enter(params) {
    if (ispointonnavmesh(self.origin) && ispointonnavmesh(self.origin, 50)) {
        newpos = getclosestpointonnavmesh(self.origin, 100, self.radius);
        if (isdefined(newpos)) {
            self.origin = newpos;
        }
    }
    self thread function_698775b4();
    self thread turretfireupdate();
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0xc6420afd, Offset: 0x42d8
// Size: 0x28c
function function_698775b4() {
    self endon(#"death");
    self endon(#"change_state");
    wait 1;
    for (;;) {
        if (isdefined(self.isstunned) && self.isstunned) {
            self.favoriteenemy = undefined;
            waitframe(1);
            continue;
        }
        targets = [];
        targetsmissile = [];
        players = level.players;
        foreach (player in players) {
            if (self cantargetplayer(player)) {
                targets[targets.size] = player;
            }
        }
        tanks = getentarray("talon", "targetname");
        foreach (tank in tanks) {
            if (self cantargettank(tank)) {
                targets[targets.size] = tank;
            }
        }
        actors = getactorarray();
        foreach (actor in actors) {
            if (self cantargetactor(actor)) {
                targets[targets.size] = actor;
            }
        }
        self.favoriteenemy = function_e5fd6904(targets);
        waitframe(1);
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0xfd0ed80, Offset: 0x4570
// Size: 0x24c
function function_e5fd6904(targets) {
    entnum = self getentitynumber();
    for (idx = 0; idx < targets.size; idx++) {
        if (!isdefined(targets[idx].var_921735fc)) {
            targets[idx].var_921735fc = [];
        }
        targets[idx].var_921735fc[entnum] = 0;
        if (isdefined(targets[idx].type) && targets[idx].type == "dog") {
            update_dog_threat(targets[idx]);
            continue;
        }
        if (isactor(targets[idx])) {
            update_actor_threat(targets[idx]);
            continue;
        }
        if (isplayer(targets[idx])) {
            update_player_threat(targets[idx]);
            continue;
        }
        update_non_player_threat(targets[idx]);
    }
    var_299906d6 = undefined;
    highest = -1;
    for (idx = 0; idx < targets.size; idx++) {
        assert(isdefined(targets[idx].var_921735fc[entnum]), "<dev string:x37>");
        if (targets[idx].var_921735fc[entnum] >= highest) {
            highest = targets[idx].var_921735fc[entnum];
            var_299906d6 = targets[idx];
        }
    }
    return var_299906d6;
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x4
// Checksum 0xdc23c6ca, Offset: 0x47c8
// Size: 0x2e2
function private update_player_threat(player) {
    entnum = self getentitynumber();
    player.var_921735fc[entnum] = 0;
    dist = distance(player.origin, self.origin);
    player.var_921735fc[entnum] = player.var_921735fc[entnum] - dist;
    if (isdefined(self.attacker) && player == self.attacker) {
        player.var_921735fc[entnum] = player.var_921735fc[entnum] + 100;
    }
    if (isdefined(player.carryobject)) {
        player.var_921735fc[entnum] = player.var_921735fc[entnum] + 200;
    }
    if (isdefined(player.score)) {
        player.var_921735fc[entnum] = player.var_921735fc[entnum] + player.score * 2;
    }
    if (player weapons::has_launcher()) {
        if (player weapons::has_lockon(self)) {
            player.var_921735fc[entnum] = player.var_921735fc[entnum] + 1000;
        } else {
            player.var_921735fc[entnum] = player.var_921735fc[entnum] + 500;
        }
    }
    if (player weapons::has_heavy_weapon()) {
        player.var_921735fc[entnum] = player.var_921735fc[entnum] + 300;
    }
    if (player weapons::has_lmg()) {
        player.var_921735fc[entnum] = player.var_921735fc[entnum] + 200;
    }
    if (isdefined(player.antithreat)) {
        player.var_921735fc[entnum] = player.var_921735fc[entnum] - player.antithreat;
    }
    if (player.var_921735fc[entnum] <= 0) {
        player.var_921735fc[entnum] = 1;
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x4
// Checksum 0x7cec84a2, Offset: 0x4ab8
// Size: 0xca
function private update_non_player_threat(non_player) {
    entnum = self getentitynumber();
    non_player.var_921735fc[entnum] = 0;
    dist = distance(non_player.origin, self.origin);
    non_player.var_921735fc[entnum] = non_player.var_921735fc[entnum] - dist;
    if (non_player.var_921735fc[entnum] <= 0) {
        non_player.var_921735fc[entnum] = 1;
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x4
// Checksum 0xfb808ad, Offset: 0x4b90
// Size: 0x21a
function private update_actor_threat(actor) {
    entnum = self getentitynumber();
    actor.var_921735fc[entnum] = 0;
    dist = distance(actor.origin, self.origin);
    actor.var_921735fc[entnum] = actor.var_921735fc[entnum] - dist;
    if (isdefined(actor.owner)) {
        if (isdefined(self.attacker) && actor.owner == self.attacker) {
            actor.var_921735fc[entnum] = actor.var_921735fc[entnum] + 100;
        }
        if (isdefined(actor.owner.carryobject)) {
            actor.var_921735fc[entnum] = actor.var_921735fc[entnum] + 200;
        }
        if (isdefined(actor.owner.score)) {
            actor.var_921735fc[entnum] = actor.var_921735fc[entnum] + actor.owner.score * 4;
        }
        if (isdefined(actor.owner.antithreat)) {
            actor.var_921735fc[entnum] = actor.var_921735fc[entnum] - actor.owner.antithreat;
        }
    }
    if (actor.var_921735fc[entnum] <= 0) {
        actor.var_921735fc[entnum] = 1;
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x4
// Checksum 0xbc5ee670, Offset: 0x4db8
// Size: 0x9a
function private update_dog_threat(dog) {
    entnum = self getentitynumber();
    dog.var_921735fc[entnum] = 0;
    dist = distance(dog.origin, self.origin);
    dog.var_921735fc[entnum] = dog.var_921735fc[entnum] - dist;
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x50227ee7, Offset: 0x4e60
// Size: 0x11a
function cantargetplayer(player) {
    if (!isdefined(player)) {
        return false;
    }
    if (!isalive(player) || player.sessionstate != "playing") {
        return false;
    }
    if (player.ignoreme === 1) {
        return false;
    }
    if (isdefined(self.owner) && player == self.owner) {
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
    if (self targetting_delay::function_3b2437d9(player) == 0) {
        return false;
    }
    return true;
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0xf06fa148, Offset: 0x4f88
// Size: 0x8e
function cantargettank(tank) {
    if (!isdefined(tank)) {
        return false;
    }
    if (!isdefined(tank.team)) {
        return false;
    }
    if (level.teambased && tank.team == self.team) {
        return false;
    }
    if (isdefined(tank.owner) && self.owner == tank.owner) {
        return false;
    }
    return true;
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x5d07e6d1, Offset: 0x5020
// Size: 0x92
function cantargetactor(actor) {
    if (!isdefined(actor)) {
        return false;
    }
    if (!isactor(actor)) {
        return false;
    }
    if (!isalive(actor)) {
        return false;
    }
    if (!isdefined(actor.team)) {
        return false;
    }
    if (level.teambased && actor.team == self.team) {
        return false;
    }
    return true;
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0x975853ae, Offset: 0x50c0
// Size: 0x338
function turretfireupdate() {
    self endon(#"death", #"change_state");
    if (!isdefined(self) || !isalive(self) || iscorpse(self)) {
        return;
    }
    weapon = self seatgetweapon(0);
    if (weapon.name == "none") {
        return;
    }
    self turretsetontargettolerance(0, 7);
    while (true) {
        if (self.avoid_shooting_owner === 1 && isdefined(self.owner)) {
            if (self vehicle_ai::owner_in_line_of_fire()) {
                wait 0.1;
                continue;
            }
        }
        if (isalive(self) && !(isdefined(self.isstunned) && self.isstunned) && isdefined(self.enemy)) {
            muzzlepos = self gettagorigin("tag_flash");
            enemyeyepos = self.enemy geteye();
            var_d85247d2 = sighttracepassed(muzzlepos, enemyeyepos, 0, self, self.enemy);
            if (var_d85247d2) {
                self turretsettarget(0, self.enemy);
                self vehlookat(self.enemy);
                waitframe(1);
                if (!self.turretontarget) {
                    wait 0.1;
                }
                if (self.turretontarget && isdefined(self.enemy)) {
                    self vehicle_ai::fire_for_time(randomfloatrange(self.settings.burstfiredurationmin, self.settings.burstfiredurationmax), 0, self.enemy);
                }
                if (isdefined(self.enemy) && isai(self.enemy)) {
                    wait randomfloatrange(self.settings.burstfireaidelaymin, self.settings.burstfireaidelaymax);
                } else {
                    wait randomfloatrange(self.settings.burstfiredelaymin, self.settings.burstfiredelaymax);
                }
            }
            wait 1;
            continue;
        }
        wait 1;
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0xd42c5d3c, Offset: 0x5400
// Size: 0x6c8
function function_a2d545b1(params) {
    self endon(#"change_state", #"death");
    self setspeed(self.settings.defaultmovespeed);
    self setacceleration(isdefined(self.settings.default_move_acceleration) ? self.settings.default_move_acceleration : 10);
    heatseekingmissile::initlockfield(self);
    for (;;) {
        assert(isdefined(self.ai));
        if (!isdefined(self.ai.var_8f317f8f)) {
            self.ai.var_8f317f8f = gettime();
        }
        var_f53aa0c5 = 0;
        goalinfo = self function_e9a79b0e();
        newpos = undefined;
        forcedgoal = isdefined(goalinfo.goalforced) && goalinfo.goalforced;
        isatgoal = isdefined(goalinfo.isatgoal) && goalinfo.isatgoal || self isapproachinggoal() && isdefined(self.overridegoalpos);
        itsbeenawhile = isdefined(goalinfo.isatgoal) && goalinfo.isatgoal && gettime() > self.ai.var_8f317f8f;
        var_4b393583 = 0;
        var_351beb54 = forcedgoal && isdefined(self.overridegoalpos) && distancesquared(self.overridegoalpos, goalinfo.goalpos) < self.radius * self.radius;
        if (isdefined(self.enemy) && !self haspath()) {
            var_4b393583 = !self seerecently(self.enemy, randomintrange(3, 5));
            if (issentient(self.enemy) || function_a5354464(self.enemy)) {
                var_4b393583 = var_4b393583 && !self attackedrecently(self.enemy, randomintrange(5, 7));
            }
        }
        var_f53aa0c5 = !isatgoal || var_4b393583 || itsbeenawhile;
        var_f53aa0c5 = var_f53aa0c5 && !var_351beb54;
        if (var_f53aa0c5) {
            if (forcedgoal) {
                newpos = getclosestpointonnavmesh(goalinfo.goalpos, self.radius * 2, self.radius);
            } else {
                goalarray = [];
                if (isdefined(self.enemy)) {
                    goalarray = tacticalquery("ai_tank_combat", goalinfo.goalpos, self, self.enemy);
                } else {
                    var_db1ad975 = ai::t_cylinder(self.origin, 200, 100);
                    goalarray = tacticalquery("ai_tank_wander", goalinfo.goalpos, self, var_db1ad975);
                }
                var_aa3ad758 = [];
                if (isdefined(goalarray) && goalarray.size) {
                    foreach (goal in goalarray) {
                        if (!self isingoal(goal.origin)) {
                            continue;
                        }
                        if (isdefined(self.overridegoalpos) && distancesquared(self.overridegoalpos, goal.origin) < 100 * 100) {
                            continue;
                        }
                        var_aa3ad758[var_aa3ad758.size] = goal;
                    }
                    if (var_aa3ad758.size) {
                        goal = array::random(var_aa3ad758);
                        goalpos = goal.origin;
                    }
                }
            }
            if (!isdefined(goalpos)) {
                goalpos = getclosestpointonnavmesh(goalinfo.goalpos, self.radius * 2, 100);
            }
            self.ai.var_8f317f8f = gettime() + randomintrange(3500, 5000);
        }
        if (isdefined(goalpos)) {
            self function_3c8dce03(goalpos, 1, 1);
            self.current_pathto_pos = goalpos;
        }
        if (self haspath()) {
            self asmrequestsubstate(#"locomotion@movement");
            result = self waittill(#"near_goal", #"stunned");
        } else {
            self asmrequestsubstate(#"hash_236f963ae1728eb3");
        }
        wait randomintrange(2, 5);
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0x9d7463cf, Offset: 0x5ad0
// Size: 0x94
function function_63f82ae() {
    enemies = util::function_8260dc36(self.team);
    alltargets = arraycombine(enemies, getactorarray(), 1, 0);
    alltargets = arraysort(enemies, self.origin, 1);
    if (alltargets.size) {
        return alltargets[0];
    }
    return undefined;
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0xaad0a398, Offset: 0x5b70
// Size: 0x896
function state_combat_update(params) {
    self endon(#"change_state");
    self endon(#"death");
    if (!isdefined(self) || !isalive(self) || iscorpse(self)) {
        return;
    }
    self setspeed(self.settings.defaultmovespeed);
    self setacceleration(isdefined(self.settings.default_move_acceleration) ? self.settings.default_move_acceleration : 10);
    heatseekingmissile::initlockfield(self);
    for (;;) {
        if (isdefined(self.isstunned) && self.isstunned || isdefined(self.var_2f438c71) && self.var_2f438c71) {
            waitframe(1);
            continue;
        }
        newpos = undefined;
        cansee = 0;
        if (isdefined(self.enemy)) {
            muzzlepos = self gettagorigin("tag_flash");
            enemyeyepos = self.enemy geteye();
            cansee = sighttracepassed(muzzlepos, enemyeyepos, 0, self, self.enemy);
        }
        if (isdefined(self.enemy) && cansee) {
            var_db1ad975 = ai::t_cylinder(self.origin, 100, 200);
            tacpoints = tacticalquery("tank_robot_tacquery_combat", self.enemy.origin, self, var_db1ad975);
            if (isdefined(tacpoints) && tacpoints.size > 0) {
                newpos = getclosestpointonnavmesh(tacpoints[0].origin, self.goalradius, self getpathfindingradius());
            }
        } else {
            enemy = self function_63f82ae();
            if (isdefined(enemy)) {
                searchradius = 800;
                var_7530e2bb = 100;
                origin = getclosestpointonnavmesh(self.origin, var_7530e2bb);
                forwarddir = vectornormalize(enemy.origin - self.origin);
                pos = self.origin + vectorscale(forwarddir, 300);
                if (tracepassedonnavmesh(self.origin, pos)) {
                    forwardpos = getclosestpointonnavmesh(self.origin, 3000);
                }
                if (!isdefined(forwardpos) && isdefined(self.var_2b6352be)) {
                    forwarddir = vectornormalize(self.origin - self.var_2b6352be);
                    forwarddir = self.origin + vectorscale(forwarddir, randomintrange(300, 500));
                    forwardpos = getclosestpointonnavmesh(self.origin, 3000);
                }
                if (!isdefined(forwardpos)) {
                    forwardpos = enemy.origin;
                }
                if (isdefined(origin)) {
                    cylinder = ai::t_cylinder(origin, searchradius, 500);
                    var_db1ad975 = ai::t_cylinder(self.origin, 100, 200);
                    tacpoints = tacticalquery("tank_robot_tacquery_seek", origin, cylinder, self, var_db1ad975, forwardpos);
                    if (isdefined(tacpoints) && tacpoints.size > 0) {
                        newpos = getclosestpointonnavmesh(tacpoints[0].origin, self.goalradius, self getpathfindingradius());
                    }
                }
            } else {
                searchradius = 1200;
                origin = getclosestpointonnavmesh(self.origin, self getpathfindingradius());
                if (isdefined(origin)) {
                    cylinder = ai::t_cylinder(origin, searchradius, 200);
                    var_db1ad975 = ai::t_cylinder(self.origin, 100, 200);
                    tacpoints = tacticalquery("tank_robot_tacquery_wander", origin, cylinder, self, var_db1ad975);
                    if (isdefined(tacpoints) && tacpoints.size > 0) {
                        tacpoints = array::randomize(tacpoints);
                        newpos = getclosestpointonnavmesh(tacpoints[0].origin, self.goalradius, self getpathfindingradius());
                    }
                }
            }
        }
        foundpath = 0;
        if (isdefined(newpos)) {
            self.var_2b6352be = newpos;
            if (!ispointonnavmesh(self.origin, self)) {
                getbackpoint = getclosestpointonnavmesh(self.origin, 500, self getpathfindingradius() * 1.1);
                if (isdefined(getbackpoint)) {
                    self.origin = getbackpoint;
                }
            }
            path = generatenavmeshpath(self.origin, newpos, self);
            if (isdefined(path) && path.status === "succeeded") {
                foundpath = 1;
            }
            if (foundpath) {
                /#
                    recordsphere(newpos, 3, (0, 1, 0), "<dev string:x30>");
                #/
                self function_3c8dce03(newpos, 0, 1);
                self setbrake(0);
                self asmrequestsubstate(#"locomotion@movement");
                result = self waittilltimeout(randomintrange(4, 5), #"near_goal", #"stunned");
            } else {
                /#
                    recordsphere(newpos, 3, (1, 0, 0), "<dev string:x30>");
                #/
            }
        }
        if (!foundpath) {
            self function_9f59031e();
            self setbrake(1);
            vehicle_ai::clearallmovement(1);
            self asmrequestsubstate(#"hash_236f963ae1728eb3");
            waitframe(1);
        }
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0xeed6b997, Offset: 0x6410
// Size: 0xa4
function setup_gameplay_think(category) {
    drone = self;
    drone thread tank_abort_think();
    drone thread tank_team_kill();
    drone thread tank_too_far_from_nav_mesh_abort_think();
    drone thread tank_death_think(category);
    drone thread tank_damage_think();
    drone thread watchwater();
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0x292b5b3f, Offset: 0x64c0
// Size: 0x46
function tank_team_kill() {
    self endon(#"death");
    self.owner waittill(#"teamkillkicked");
    self notify(#"death");
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0xb635d3ec, Offset: 0x6510
// Size: 0x136
function kill_monitor() {
    self endon(#"death");
    last_kill_vo = 0;
    kill_vo_spacing = 4000;
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
        if (!self.controlled && last_kill_vo + kill_vo_spacing < gettime()) {
            self killstreaks::play_pilot_dialog_on_owner("kill", "tank_robot", self.killstreak_id);
            last_kill_vo = gettime();
        }
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0xd20d89ba, Offset: 0x6650
// Size: 0x54
function tank_abort_think() {
    tank = self;
    tank thread killstreaks::waitfortimeout("tank_robot", 90000, &tank_timeout_callback, "death", "emp_jammed");
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x987def92, Offset: 0x66b0
// Size: 0x10c
function cleanup_targeting(player) {
    self notify(#"hash_3eddb5faa34443ee");
    if (isdefined(player)) {
        for (ti = 0; ti < 5; ti++) {
            if (isdefined(level.var_78159f7c[ti])) {
                uifield = level.var_78159f7c[ti];
                uifield multi_stage_target_lockon::set_targetstate(player, 0);
                if (uifield multi_stage_target_lockon::is_open(player)) {
                    uifield multi_stage_target_lockon::close(player);
                }
            }
            if (isdefined(player.var_c2a2dd80) && isdefined(player.var_c2a2dd80[ti])) {
                player.var_c2a2dd80[ti].state = 0;
            }
        }
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0xbffc7836, Offset: 0x67c8
// Size: 0x13e
function tank_timeout_callback() {
    self killstreaks::play_pilot_dialog_on_owner("timeout", "tank_robot");
    self.timed_out = 1;
    self vehicle_death::death_fx();
    player = self.owner;
    if (isdefined(player) && isalive(player)) {
        player.ai_tank_drone = undefined;
        player stop_remote();
        if (isdefined(self.controlled) && self.controlled) {
            visionset_mgr::deactivate("visionset", "agr_visionset", player);
        } else {
            player killstreaks::switch_to_last_non_killstreak_weapon();
        }
        player clientfield::set_player_uimodel("hudItems.tankState", 0);
    }
    cleanup_targeting(player);
    wait 0.25;
    self notify(#"death");
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0xdbc2d677, Offset: 0x6910
// Size: 0x17e
function tank_watch_owner_events() {
    self notify(#"tank_watch_owner_events_singleton");
    self endon(#"tank_watch_owner_events_singleton");
    self endon(#"death");
    res = self.owner waittill(#"joined_team", #"disconnect", #"joined_spectators");
    self makevehicleusable();
    if (isdefined(self.owner) && isdefined(self.controlled) && self.controlled) {
        visionset_mgr::deactivate("visionset", "agr_visionset", self.owner);
        self.owner stop_remote();
    }
    self.controlled = 0;
    if (isdefined(self.owner)) {
        self.owner unlink();
        self clientfield::set("vehicletransition", 0);
    }
    self makevehicleunusable();
    self.abandoned = 1;
    self notify(#"death");
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x6e1e676d, Offset: 0x6a98
// Size: 0x28
function on_end_game(drone) {
    if (isdefined(drone)) {
        drone notify(#"death");
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0x8601663a, Offset: 0x6ac8
// Size: 0x5c
function stop_remote() {
    if (!isdefined(self)) {
        return;
    }
    self killstreaks::clear_using_remote();
    self remote_weapons::destroyremotehud();
    self util::clientnotify("nofutz");
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x6646bf7d, Offset: 0x6b30
// Size: 0x7e
function tank_hacked_health_update(hacker) {
    tank = self;
    hackeddamagetaken = tank.defaultmaxhealth - tank.hackedhealth;
    assert(hackeddamagetaken > 0);
    if (hackeddamagetaken > tank.damagetaken) {
        tank.damagetaken = hackeddamagetaken;
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0xaaa4f756, Offset: 0x6bb8
// Size: 0x550
function tank_damage_think() {
    self endon(#"death");
    assert(isdefined(self.maxhealth));
    self.defaultmaxhealth = self.maxhealth;
    maxhealth = self.maxhealth;
    self.maxhealth = 999999;
    self.health = self.maxhealth;
    self.isstunned = 0;
    self.var_2f438c71 = 0;
    self.var_333bdd23 = 0;
    self.hackedhealthupdatecallback = &tank_hacked_health_update;
    self.hackedhealth = killstreak_bundles::get_hacked_health("tank_robot");
    low_health = 0;
    self.damagetaken = 0;
    for (;;) {
        waitresult = self waittill(#"damage");
        damage = waitresult.amount;
        attacker = waitresult.attacker;
        weapon = waitresult.weapon;
        mod = waitresult.mod;
        chargelevel = waitresult.charge_level;
        position = waitresult.position;
        flags = waitresult.flags;
        self.maxhealth = 999999;
        self.health = self.maxhealth;
        /#
            self.damage_debug = damage + "<dev string:x60>" + weapon.name + "<dev string:x63>";
        #/
        if (weapon.isemp && mod == "MOD_GRENADE_SPLASH") {
            emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage("tank_robot", maxhealth);
            if (!isdefined(emp_damage_to_apply)) {
                emp_damage_to_apply = maxhealth / 2;
            }
            self.damagetaken += emp_damage_to_apply;
            damage = 0;
            if (!self.isstunned && emp_damage_to_apply > 0) {
                self.isstunned = 1;
                challenges::stunnedtankwithempgrenade(attacker);
                self thread tank_stun(1.5);
            }
        }
        if (!self.isstunned) {
            if (weapon.dostun && (mod == "MOD_GRENADE_SPLASH" || mod == "MOD_GAS")) {
                self.isstunned = 1;
                self thread tank_stun(3);
            }
        }
        weapon_damage = killstreak_bundles::get_weapon_damage("tank_robot", maxhealth, attacker, weapon, mod, damage, flags, chargelevel);
        if (!isdefined(weapon_damage)) {
            weapon_damage = killstreaks::get_old_damage(attacker, weapon, mod, damage, 1);
        }
        self.damagetaken += weapon_damage;
        if (self.controlled && isdefined(self.owner)) {
            self.owner sendkillstreakdamageevent(int(weapon_damage));
            self.owner vehicle::update_damage_as_occupant(self.damagetaken, maxhealth);
        }
        if (self.damagetaken >= maxhealth) {
            if (isdefined(self.owner)) {
                self.owner.dofutz = 1;
            }
            self.health = 0;
            self notify(#"death", {#attacker:attacker, #mod:mod, #weapon:weapon});
            return;
        }
        self function_6ae1a0cb(weapon_damage);
        if (!low_health && self.damagetaken > maxhealth / 1.8) {
            self killstreaks::play_pilot_dialog_on_owner("damaged", "tank_robot", self.killstreak_id);
            self thread tank_low_health_fx();
            low_health = 1;
        }
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0xe04a6fc5, Offset: 0x7110
// Size: 0xfc
function tank_low_health_fx() {
    self endon(#"death");
    self.damage_fx = spawn("script_model", self gettagorigin("tag_origin") + (0, 0, -14));
    if (!isdefined(self.damage_fx)) {
        return;
    }
    self.damage_fx setmodel(#"tag_origin");
    self.damage_fx linkto(self, "tag_turret", (0, 0, -14), (0, 0, 0));
    wait 0.1;
    playfxontag(level.ai_tank_damage_fx, self.damage_fx, "tag_origin");
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x694c5117, Offset: 0x7218
// Size: 0xf8
function deleteonkillbrush(player) {
    player endon(#"disconnect");
    self endon(#"death");
    killbrushes = getentarray("trigger_hurt_new", "classname");
    while (true) {
        for (i = 0; i < killbrushes.size; i++) {
            if (self istouching(killbrushes[i])) {
                if (isdefined(self)) {
                    self notify(#"death", {#attacker:self.owner});
                }
                return;
            }
        }
        wait 0.1;
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x7a75146f, Offset: 0x7318
// Size: 0x5c
function function_6ae1a0cb(weapon_damage) {
    if (!self.var_2f438c71) {
        self.var_333bdd23 += weapon_damage;
        if (self.var_333bdd23 >= 750) {
            self.var_333bdd23 = 0;
            self thread tank_immobile();
        }
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0x64ec9226, Offset: 0x7380
// Size: 0x1e4
function tank_immobile() {
    self notify(#"immobile");
    self.var_2f438c71 = 1;
    self cancelaimove();
    self function_9f59031e();
    controlled = self.controlled;
    owner = self.owner;
    if (controlled && isdefined(owner)) {
        owner val::set(#"tank_immobile", "freezecontrols_allowlook", 1);
    }
    self clientfield::set("ai_tank_immobile", 1);
    if (controlled && isdefined(owner)) {
        owner clientfield::set_to_player("static_postfx", 1);
    }
    self waittilltimeout(1.5, #"death");
    isalive = isalive(self);
    if (isalive) {
        self clientfield::set("ai_tank_immobile", 0);
        self.var_2f438c71 = 0;
    }
    if (controlled && isdefined(owner)) {
        if (!isalive || !self.isstunned) {
            owner clientfield::set_to_player("static_postfx", 0);
        }
        owner val::reset(#"tank_immobile", "freezecontrols_allowlook");
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x571370b5, Offset: 0x7570
// Size: 0x294
function tank_stun(duration) {
    self notify(#"stunned");
    self notify(#"fire_stop");
    self cancelaimove();
    self function_9f59031e();
    forward = anglestoforward(self.angles);
    forward = self.origin + forward * 128;
    forward -= (0, 0, 64);
    self turretsettarget(0, forward);
    self disablegunnerfiring(0, 1);
    self laseroff();
    controlled = self.controlled;
    owner = self.owner;
    if (controlled) {
        owner val::set(#"tank_stun", "freezecontrols", 1);
        owner sendkillstreakdamageevent(400);
    }
    self clientfield::set("stun", 1);
    if (controlled) {
        owner clientfield::set_to_player("static_postfx", 1);
    }
    self waittilltimeout(duration, #"death");
    isalive = isalive(self);
    if (isalive) {
        self clientfield::set("stun", 0);
        self disablegunnerfiring(0, 0);
        self.isstunned = 0;
    }
    if (controlled) {
        if (!isalive || !self.var_2f438c71) {
            owner clientfield::set_to_player("static_postfx", 0);
        }
        owner val::reset(#"tank_stun", "freezecontrols");
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0xd84389be, Offset: 0x7810
// Size: 0x20c
function emp_crazy_death() {
    self clientfield::set("stun", 1);
    self notify(#"death");
    time = 0;
    randomangle = randomint(360);
    while (time < 1.45) {
        self turretsettarget(0, self.origin + anglestoforward((randomintrange(305, 315), int(randomangle + time * 180), 0)) * 100);
        if (time > 0.2) {
            self fireweapon(0);
            if (randomint(100) > 85) {
                rocket = self fireweapon(0);
                if (isdefined(rocket)) {
                    rocket.from_ai = 1;
                }
            }
        }
        time += 0.05;
        waitframe(1);
    }
    self clientfield::set("ai_tank_death", 1);
    playfx(level.ai_tank_explode_fx, self.origin, (0, 0, 1));
    playsoundatposition(#"wpn_remote_missile_explode_close", self.origin);
    waitframe(1);
    self hide();
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0x2cd921d2, Offset: 0x7a28
// Size: 0x48
function function_65542f60() {
    self endon(#"death");
    origin = self.origin;
    while (isdefined(self)) {
        self.origin = origin;
        waitframe(1);
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0xf5658bae, Offset: 0x7a78
// Size: 0x5a4
function tank_death_think(hardpointname) {
    team = self.team;
    killstreak_id = self.killstreak_id;
    waitresult = self waittill(#"death");
    attacker = waitresult.attacker;
    weapon = waitresult.weapon;
    if (!isdefined(self)) {
        killstreak_stop_and_assert(hardpointname, team, killstreak_id, "Failed to handle death. A.");
        return;
    }
    self.dead = 1;
    self laseroff();
    self function_9f59031e();
    not_abandoned = !isdefined(self.abandoned) || !self.abandoned;
    if (isdefined(self.controlled) && self.controlled && isdefined(self.owner)) {
        self.owner sendkillstreakdamageevent(600);
        self.owner remote_weapons::destroyremotehud();
    }
    self clientfield::set("ai_tank_death", 1);
    self.isstunned = 0;
    settings = self.settings;
    if (isdefined(settings) && (self.timed_out === 1 || self.abandoned === 1)) {
        fx_origin = self gettagorigin(isdefined(settings.timed_out_death_tag_1) ? settings.timed_out_death_tag_1 : "tag_origin");
        playfx(isdefined(settings.timed_out_death_fx_1) ? settings.timed_out_death_fx_1 : level.ai_tank_explode_fx, isdefined(fx_origin) ? fx_origin : self.origin, (0, 0, 1), (1, 0, 0));
        playsoundatposition(isdefined(settings.timed_out_death_sound_1) ? settings.timed_out_death_sound_1 : "wpn_remote_missile_explode_close", self.origin);
    } else {
        playfx(level.ai_tank_explode_fx, self.origin, (0, 0, 1), (1, 0, 0));
        playsoundatposition(#"wpn_remote_missile_explode_close", self.origin);
    }
    if (isdefined(self.owner)) {
        self.owner clientfield::set_player_uimodel("hudItems.tankState", 0);
    }
    if (not_abandoned) {
        util::wait_network_frame();
        if (!isdefined(self)) {
            killstreak_stop_and_assert(hardpointname, team, killstreak_id, "Failed to handle death. B.");
            return;
        }
    }
    if (self.controlled) {
        self ghost();
        self thread function_65542f60();
    } else {
        self hide();
    }
    if (isdefined(self.damage_fx)) {
        self.damage_fx delete();
    }
    var_757a988f = 0;
    if (isdefined(level.aitank_explode)) {
        var_757a988f = [[ level.aitank_explode ]](attacker, weapon);
    }
    var_ef31a667 = 0;
    if (isdefined(var_757a988f) && var_757a988f && isdefined(self.owner)) {
        var_ef31a667 = 3;
    }
    if (isdefined(self.owner)) {
        self.owner ability_player::function_281eba9f(level.var_f9f0faef, var_ef31a667);
    }
    if (not_abandoned) {
        self waittilltimeout(2, #"remote_weapon_end", #"death");
        if (!isdefined(self)) {
            killstreak_stop_and_assert(hardpointname, team, killstreak_id, "Failed to handle death. C.");
            return;
        }
    }
    killstreakrules::killstreakstop(hardpointname, team, self.killstreak_id);
    if (isdefined(self.owner) && isalive(self.owner)) {
        self.owner killstreaks::switch_to_last_non_killstreak_weapon();
    }
    if (isdefined(self.aim_entity)) {
        self.aim_entity delete();
    }
    wait 1;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 4, eflags: 0x0
// Checksum 0xcf327a88, Offset: 0x8028
// Size: 0x44
function killstreak_stop_and_assert(hardpoint_name, team, killstreak_id, assert_msg) {
    killstreakrules::killstreakstop(hardpoint_name, team, killstreak_id);
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0xe8d8c8d6, Offset: 0x8078
// Size: 0x8a
function tank_too_far_from_nav_mesh_abort_think() {
    self endon(#"death");
    not_on_nav_mesh_count = 0;
    for (;;) {
        wait 1;
        not_on_nav_mesh_count = isdefined(getclosestpointonnavmesh(self.origin, 480)) ? 0 : not_on_nav_mesh_count + 1;
        if (not_on_nav_mesh_count >= 4) {
            self notify(#"death");
        }
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0xcf0dd0bf, Offset: 0x8110
// Size: 0x74
function respectnottargetedbyaitankperk(player) {
    if (!isplayer(player)) {
        return;
    }
    aitank = self;
    aitank setignoreent(player, player hasperk(#"specialty_nottargetedbyaitank"));
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0xbe7a9c9d, Offset: 0x8190
// Size: 0x2b0
function starttankremotecontrol(drone) {
    drone makevehicleusable();
    drone function_9f59031e();
    drone turretcleartarget(0);
    drone laseroff();
    drone.treat_owner_damage_as_friendly_fire = 0;
    drone.ignore_team_kills = 0;
    if (isdefined(drone.playerdrivenversion)) {
        drone setvehicletype(drone.playerdrivenversion);
    }
    drone usevehicle(self, 0);
    drone clientfield::set("vehicletransition", 1);
    drone thread function_b72ff26a(self);
    drone vehicle_ai::set_state("driving");
    drone makevehicleunusable();
    drone setbrake(0);
    if (drone.numberrockets != 0) {
        drone thread tank_rocket_watch(self);
    }
    drone thread vehicle::monitor_missiles_locked_on_to_me(self);
    self vehicle::set_vehicle_drivable_time(90000, drone.killstreak_end_time);
    self vehicle::update_damage_as_occupant(isdefined(drone.damagetaken) ? drone.damagetaken : 0, isdefined(drone.defaultmaxhealth) ? drone.defaultmaxhealth : 100);
    drone update_client_ammo(drone.numberrockets, 1);
    self clientfield::set_player_uimodel("hudItems.tankState", 3);
    visionset_mgr::activate("visionset", "agr_visionset", self, 1, 90000, 1);
    if (isdefined(level.var_fc8e6013)) {
        self [[ level.var_fc8e6013 ]](drone);
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 2, eflags: 0x0
// Checksum 0x404bffe0, Offset: 0x8448
// Size: 0x328
function endtankremotecontrol(drone, exitrequestedbyowner) {
    not_dead = !(isdefined(drone.dead) && drone.dead);
    if (isdefined(drone.owner)) {
        drone.owner remote_weapons::destroyremotehud();
    }
    drone.treat_owner_damage_as_friendly_fire = 1;
    drone.ignore_team_kills = 1;
    if (drone.classname == "script_vehicle") {
        drone makevehicleunusable();
    }
    if (isdefined(drone.original_vehicle_type) && not_dead) {
        drone.vehicletype = drone.original_vehicle_type;
    }
    if (isdefined(drone.owner)) {
        drone.owner vehicle::stop_monitor_missiles_locked_on_to_me();
    }
    if (exitrequestedbyowner && not_dead) {
        if (isdefined(drone.settings.ai_enabled) && drone.settings.ai_enabled) {
            drone vehicle_ai::set_state("combat");
        } else {
            drone vehicle_ai::set_state("off");
        }
        if (isdefined(drone.owner)) {
            drone.owner clientfield::set_player_uimodel("hudItems.tankState", 2);
        }
    }
    if (drone.cobra === 1 && not_dead) {
        drone thread cobra_retract();
    }
    if (isdefined(drone.owner) && drone.controlled === 1) {
        visionset_mgr::deactivate("visionset", "agr_visionset", drone.owner);
    }
    drone clientfield::set("vehicletransition", 0);
    params = level.killstreakbundle[#"tank_robot"];
    shutdown_on_exit = isdefined(params.ksshutdownonexit) ? params.ksshutdownonexit : 0;
    if (shutdown_on_exit) {
        drone tank_timeout_callback();
    } else {
        drone cleanup_targeting(drone.owner);
    }
    if (isdefined(level.var_f2db9aa9)) {
        self [[ level.var_f2db9aa9 ]](drone);
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0xe2c7aeb6, Offset: 0x8778
// Size: 0xe4
function perform_recoil_missile_turret(player) {
    bundle = level.killstreakbundle[#"tank_robot"];
    earthquake(0.4, 0.5, self.origin, 200);
    self perform_recoil("tag_barrel", isdefined(self.controlled) && self.controlled ? bundle.ksmainturretrecoilforcecontrolled : bundle.ksmainturretrecoilforce, bundle.ksmainturretrecoilforcezoffset);
    if (self.controlled && isdefined(player)) {
        player playrumbleonentity("sniper_fire");
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 3, eflags: 0x0
// Checksum 0x733fe293, Offset: 0x8868
// Size: 0x94
function perform_recoil(recoil_tag, force_scale_factor, force_z_offset) {
    angles = self gettagangles(recoil_tag);
    dir = anglestoforward(angles);
    self launchvehicle(dir * force_scale_factor, self.origin + (0, 0, force_z_offset), 0);
}

// Namespace ai_tank/ai_tank_shared
// Params 2, eflags: 0x0
// Checksum 0x55a44a59, Offset: 0x8908
// Size: 0x54
function update_client_ammo(ammo_count, driver_only_update = 0) {
    if (isdefined(self.owner)) {
        self.owner clientfield::set_player_uimodel("vehicle.ammoCount", ammo_count);
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 2, eflags: 0x0
// Checksum 0x1b3a3fe0, Offset: 0x8968
// Size: 0x8a
function watch_target(owner, target_index) {
    self endon(#"death");
    wait 3;
    if (isalive(self)) {
        level.var_78159f7c[target_index] multi_stage_target_lockon::set_targetstate(owner, 0);
        owner.var_c2a2dd80[target_index].state = 0;
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 2, eflags: 0x0
// Checksum 0x1a1efa7a, Offset: 0x8a00
// Size: 0x2cc
function shoot_targets(projectile, max_missiles) {
    var_a8942db6 = 0;
    weapon = getweapon("tank_robot_launcher_turret");
    origin = projectile.origin;
    owner = projectile.owner;
    enemies = getplayers(util::getotherteam(owner.team));
    foreach (target in enemies) {
        if (isdefined(target) && isplayer(target)) {
            var_fa0cbe4c = target getentitynumber();
            ti = owner.var_577f2157[var_fa0cbe4c];
            if (!isdefined(ti)) {
                continue;
            }
            target_info = owner.var_c2a2dd80[ti];
            if (target_info.state == 3) {
                dir = target.origin + (0, 0, 40) - origin;
                dir = vectornormalize(dir);
                rocket = magicbullet(weapon, origin, origin + dir * 1000, owner);
                rocket missile_settarget(target);
                level.var_78159f7c[ti] multi_stage_target_lockon::set_targetstate(owner, 4);
                target_info.state = 4;
                target thread watch_target(owner, ti);
                var_a8942db6++;
                if (var_a8942db6 >= max_missiles) {
                    break;
                }
            }
        }
    }
    if (var_a8942db6 > 0) {
        projectile delete();
    } else {
        var_a8942db6 = 1;
    }
    return var_a8942db6;
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0xe220f456, Offset: 0x8cd8
// Size: 0x188
function tank_rocket_watch(player) {
    self endon(#"death");
    player endon(#"stopped_using_remote");
    if (self.numberrockets <= 0) {
        self reload_rockets(player);
    }
    if (!self.isstunned) {
        self disabledriverfiring(0);
    }
    while (true) {
        waitresult = player waittill(#"missile_fire");
        var_a8942db6 = 1;
        if (isdefined(waitresult.projectile)) {
            waitresult.projectile.ignore_team_kills = self.ignore_team_kills;
            var_a8942db6 = player shoot_targets(waitresult.projectile, self.numberrockets);
        }
        self.numberrockets -= var_a8942db6;
        self update_client_ammo(self.numberrockets);
        self perform_recoil_missile_turret(player);
        if (self.numberrockets <= 0) {
            self reload_rockets(player);
        }
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0xbfc5c432, Offset: 0x8e68
// Size: 0x7e
function tank_rocket_watch_ai() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"missile_fire");
        if (isdefined(waitresult.projectile)) {
            waitresult.projectile.ignore_team_kills = self.ignore_team_kills;
            waitresult.projectile.killcament = self;
        }
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 1, eflags: 0x0
// Checksum 0x8bac5b9b, Offset: 0x8ef0
// Size: 0x134
function reload_rockets(player) {
    bundle = level.killstreakbundle[#"tank_robot"];
    self disabledriverfiring(1);
    weapon_wait_duration_ms = int(bundle.ksweaponreloadtime * 1000);
    player setvehicleweaponwaitduration(weapon_wait_duration_ms);
    player setvehicleweaponwaitendtime(gettime() + weapon_wait_duration_ms);
    self playsoundtoplayer(#"hash_67ccc430f6e101f3", player);
    wait bundle.ksweaponreloadtime;
    self.numberrockets = 4;
    self update_client_ammo(self.numberrockets);
    wait 0.4;
    if (!self.isstunned) {
        self disabledriverfiring(0);
    }
}

// Namespace ai_tank/ai_tank_shared
// Params 0, eflags: 0x0
// Checksum 0xfb911fc7, Offset: 0x9030
// Size: 0x11e
function watchwater() {
    self endon(#"death");
    var_c51e5334 = 25;
    var_c45b87e8 = 12.5;
    inwater = 0;
    while (!inwater) {
        wait 0.3;
        depth = getwaterheight(self.origin) - self.origin[2];
        inwater = depth > var_c51e5334;
        if (isdefined(self.owner) && self.controlled) {
            self.owner clientfield::set_to_player("static_postfx", depth < var_c45b87e8 ? 0 : 1);
        }
    }
    if (isdefined(self.owner)) {
        self.owner.dofutz = 1;
    }
    self notify(#"death");
}

// Namespace ai_tank/ai_tank_shared
// Params 2, eflags: 0x4
// Checksum 0x5bfd80fd, Offset: 0x9158
// Size: 0x5e
function private function_8ce9322a(tank_robot, timetoadd) {
    player = self;
    tank_robot.var_bb0a4eae[player.clientid] = gettime() + int(timetoadd * 1000);
}

