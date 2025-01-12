#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\core_common\weapons_shared;
#using scripts\weapons\heatseekingmissile;

#namespace vehicle;

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x2
// Checksum 0xc07c159c, Offset: 0x920
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"vehicle_shared", &__init__, &__main__, undefined);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xcfc5d893, Offset: 0x970
// Size: 0xa96
function __init__() {
    clientfield::register("vehicle", "toggle_lockon", 1, 1, "int");
    clientfield::register("vehicle", "toggle_sounds", 1, 1, "int");
    clientfield::register("vehicle", "use_engine_damage_sounds", 1, 2, "int");
    clientfield::register("vehicle", "toggle_treadfx", 1, 1, "int");
    clientfield::register("vehicle", "toggle_exhaustfx", 1, 1, "int");
    clientfield::register("vehicle", "toggle_lights", 1, 2, "int");
    clientfield::register("vehicle", "toggle_lights_group1", 1, 1, "int");
    clientfield::register("vehicle", "toggle_lights_group2", 1, 1, "int");
    clientfield::register("vehicle", "toggle_lights_group3", 1, 1, "int");
    clientfield::register("vehicle", "toggle_lights_group4", 1, 1, "int");
    clientfield::register("vehicle", "toggle_ambient_anim_group1", 1, 1, "int");
    clientfield::register("vehicle", "toggle_ambient_anim_group2", 1, 1, "int");
    clientfield::register("vehicle", "toggle_ambient_anim_group3", 1, 1, "int");
    clientfield::register("vehicle", "toggle_emp_fx", 1, 1, "int");
    clientfield::register("vehicle", "toggle_burn_fx", 1, 1, "int");
    clientfield::register("vehicle", "deathfx", 1, 2, "int");
    clientfield::register("vehicle", "stopallfx", 1, 1, "int");
    clientfield::register("vehicle", "flickerlights", 1, 2, "int");
    clientfield::register("vehicle", "alert_level", 1, 2, "int");
    clientfield::register("vehicle", "set_lighting_ent", 1, 1, "int");
    clientfield::register("vehicle", "stun", 1, 1, "int");
    clientfield::register("vehicle", "use_lighting_ent", 1, 1, "int");
    clientfield::register("vehicle", "damage_level", 1, 3, "int");
    clientfield::register("vehicle", "spawn_death_dynents", 1, 2, "int");
    clientfield::register("vehicle", "spawn_gib_dynents", 1, 1, "int");
    clientfield::register("vehicle", "toggle_horn_sound", 1, 1, "int");
    clientfield::register("vehicle", "update_malfunction", 1, 2, "int");
    if (!sessionmodeiszombiesgame() && !(isdefined(level.var_56889215) && level.var_56889215)) {
        clientfield::register("clientuimodel", "vehicle.ammoCount", 1, 10, "int");
        clientfield::register("clientuimodel", "vehicle.ammoReloading", 1, 1, "int");
        clientfield::register("clientuimodel", "vehicle.ammoLow", 1, 1, "int");
        clientfield::register("clientuimodel", "vehicle.rocketAmmo", 1, 2, "int");
        clientfield::register("clientuimodel", "vehicle.ammo2Count", 1, 10, "int");
        clientfield::register("clientuimodel", "vehicle.ammo2Reloading", 1, 1, "int");
        clientfield::register("clientuimodel", "vehicle.ammo2Low", 1, 1, "int");
        clientfield::register("clientuimodel", "vehicle.collisionWarning", 1, 2, "int");
        clientfield::register("clientuimodel", "vehicle.enemyInReticle", 1, 1, "int");
        clientfield::register("clientuimodel", "vehicle.missileRepulsed", 1, 1, "int");
        clientfield::register("clientuimodel", "vehicle.incomingMissile", 1, 1, "int");
        clientfield::register("clientuimodel", "vehicle.malfunction", 1, 2, "int");
        clientfield::register("clientuimodel", "vehicle.showHoldToExitPrompt", 1, 1, "int");
        clientfield::register("clientuimodel", "vehicle.holdToExitProgress", 1, 5, "float");
        clientfield::register("clientuimodel", "vehicle.vehicleAttackMode", 1, 3, "int");
        for (i = 0; i < 3; i++) {
            clientfield::register("clientuimodel", "vehicle.bindingCooldown" + i + ".cooldown", 1, 5, "float");
        }
    }
    clientfield::register("toplayer", "toggle_dnidamagefx", 1, 1, "int");
    clientfield::register("toplayer", "toggle_flir_postfx", 1, 2, "int");
    clientfield::register("toplayer", "static_postfx", 1, 1, "int");
    clientfield::register("vehicle", "vehUseMaterialPhysics", 1, 1, "int");
    clientfield::register("scriptmover", "play_flare_fx", 1, 1, "int");
    clientfield::register("scriptmover", "play_flare_hit_fx", 1, 1, "int");
    if (isdefined(level.bypassvehiclescripts)) {
        return;
    }
    level.heli_default_decel = 10;
    setup_dvars();
    setup_level_vars();
    setup_triggers();
    setup_nodes();
    level array::thread_all_ents(level.vehicle_processtriggers, &trigger_process);
    level.vehicle_processtriggers = undefined;
    level.vehicle_enemy_tanks = [];
    level.vehicle_enemy_tanks[#"vehicle_ger_tracked_king_tiger"] = 1;
    level thread _watch_for_hijacked_vehicles();
    level.var_36033be4 = &function_36033be4;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x2d53d5ee, Offset: 0x1410
// Size: 0x64
function __main__() {
    a_all_spawners = getvehiclespawnerarray();
    setup_spawners(a_all_spawners);
    /#
        level thread vehicle_spawner_tool();
        level thread spline_debug();
    #/
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x1630554b, Offset: 0x1480
// Size: 0x46
function setup_script_gatetrigger(trigger) {
    gates = [];
    if (isdefined(trigger.script_gatetrigger)) {
        return level.vehicle_gatetrigger[trigger.script_gatetrigger];
    }
    return gates;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x1af4c89d, Offset: 0x14d0
// Size: 0x63c
function trigger_process(trigger) {
    if (isdefined(trigger.classname) && (trigger.classname == "trigger_multiple" || trigger.classname == "trigger_radius" || trigger.classname == "trigger_lookat" || trigger.classname == "trigger_box" || trigger.classname == "trigger_multiple_new" || trigger.classname == "trigger_radius_new" || trigger.classname == "trigger_lookat_new" || trigger.classname == "trigger_box_new")) {
        btriggeronce = 1;
    } else {
        btriggeronce = 0;
    }
    if (isdefined(trigger.script_noteworthy) && trigger.script_noteworthy == "trigger_multiple") {
        btriggeronce = 0;
    }
    trigger.processed_trigger = undefined;
    gates = setup_script_gatetrigger(trigger);
    script_vehicledetour = isdefined(trigger.script_vehicledetour) && (is_node_script_origin(trigger) || is_node_script_struct(trigger));
    detoured = isdefined(trigger.detoured) && !(is_node_script_origin(trigger) || is_node_script_struct(trigger));
    gotrigger = 1;
    while (gotrigger) {
        trigger trigger::wait_till();
        other = trigger.who;
        if (isdefined(trigger.enabled) && !trigger.enabled) {
            trigger waittill(#"enable");
        }
        if (isdefined(trigger.script_flag_set)) {
            if (isdefined(other) && isdefined(other.vehicle_flags)) {
                other.vehicle_flags[trigger.script_flag_set] = 1;
            }
            if (isdefined(other)) {
                other notify(#"vehicle_flag_arrived", {#is_set:trigger.script_flag_set});
            }
            level flag::set(trigger.script_flag_set);
        }
        if (isdefined(trigger.script_flag_clear)) {
            if (isdefined(other) && isdefined(other.vehicle_flags)) {
                other.vehicle_flags[trigger.script_flag_clear] = 0;
            }
            level flag::clear(trigger.script_flag_clear);
        }
        if (isdefined(other) && script_vehicledetour) {
            other thread path_detour_script_origin(trigger);
        } else if (detoured && isdefined(other)) {
            other thread path_detour(trigger);
        }
        trigger util::script_delay();
        if (btriggeronce) {
            gotrigger = 0;
        }
        if (isdefined(trigger.script_vehiclegroupdelete)) {
            if (!isdefined(level.vehicle_deletegroup[trigger.script_vehiclegroupdelete])) {
                println("<dev string:x30>", trigger.script_vehiclegroupdelete);
                level.vehicle_deletegroup[trigger.script_vehiclegroupdelete] = [];
            }
            array::delete_all(level.vehicle_deletegroup[trigger.script_vehiclegroupdelete]);
        }
        if (isdefined(trigger.script_vehiclespawngroup)) {
            level notify("spawnvehiclegroup" + trigger.script_vehiclespawngroup);
            level waittill("vehiclegroup spawned" + trigger.script_vehiclespawngroup);
        }
        if (gates.size > 0 && btriggeronce) {
            level array::thread_all_ents(gates, &path_gate_open);
        }
        if (isdefined(trigger) && isdefined(trigger.script_vehiclestartmove)) {
            if (!isdefined(level.vehicle_startmovegroup[trigger.script_vehiclestartmove])) {
                println("<dev string:x80>", trigger.script_vehiclestartmove);
                return;
            }
            foreach (vehicle in arraycopy(level.vehicle_startmovegroup[trigger.script_vehiclestartmove])) {
                if (isdefined(vehicle)) {
                    vehicle thread go_path();
                }
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xdf498e87, Offset: 0x1b18
// Size: 0x186
function path_detour_get_detourpath(a_nd_detour) {
    if (!isdefined(a_nd_detour)) {
        a_nd_detour = [];
    } else if (!isarray(a_nd_detour)) {
        a_nd_detour = array(a_nd_detour);
    }
    a_nd_detour_real = [];
    foreach (nd in a_nd_detour) {
        if (isdefined(nd.script_vehicledetour)) {
            if (!isdefined(a_nd_detour_real)) {
                a_nd_detour_real = [];
            } else if (!isarray(a_nd_detour_real)) {
                a_nd_detour_real = array(a_nd_detour_real);
            }
            a_nd_detour_real[a_nd_detour_real.size] = nd;
        }
    }
    a_nd_detour_real = array::randomize(a_nd_detour_real);
    for (i = 0; i < a_nd_detour_real.size; i++) {
        if (!islastnode(a_nd_detour_real[i])) {
            return a_nd_detour_real[i];
        }
    }
    return undefined;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x72712970, Offset: 0x1ca8
// Size: 0x4c
function path_detour_script_origin(detournode) {
    detourpath = path_detour_get_detourpath(detournode);
    if (isdefined(detourpath)) {
        self thread paths(detourpath);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xc7243009, Offset: 0x1d00
// Size: 0x92
function crash_detour_check(detourpath) {
    return isdefined(detourpath.script_crashtype) && (isdefined(self.deaddriver) || self.health <= 0 || detourpath.script_crashtype == "forced") && (!isdefined(detourpath.derailed) || isdefined(detourpath.script_crashtype) && detourpath.script_crashtype == "plane");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x8a844039, Offset: 0x1da0
// Size: 0x28
function crash_derailed_check(detourpath) {
    return isdefined(detourpath.derailed) && detourpath.derailed;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x446183e4, Offset: 0x1dd0
// Size: 0x19a
function path_detour(node) {
    a_nd_detour = getvehiclenodearray(node.target2, "targetname");
    detourpath = path_detour_get_detourpath(a_nd_detour);
    if (!isdefined(detourpath)) {
        return;
    }
    if (node.detoured && !isdefined(detourpath.script_vehicledetourgroup)) {
        return;
    }
    if (crash_detour_check(detourpath)) {
        if (isdefined(self.script_crashtypeoverride) && self.script_crashtypeoverride === "ground_vehicle_on_spline") {
            self.nd_crash_path = detourpath;
            self thread vehicle_death::ground_vehicle_crash();
            return;
        }
        self notify(#"crashpath", detourpath);
        detourpath.derailed = 1;
        self notify(#"newpath");
        self setswitchnode(node, detourpath);
        return;
    }
    if (crash_derailed_check(detourpath)) {
        return;
    }
    if (isdefined(detourpath.script_vehicledetourgroup)) {
        if (!isdefined(self.script_vehicledetourgroup)) {
            return;
        }
        if (detourpath.script_vehicledetourgroup != self.script_vehicledetourgroup) {
            return;
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xe4b820f1, Offset: 0x1f78
// Size: 0x10e
function levelstuff(vehicle) {
    if (isdefined(vehicle.script_linkname)) {
        level.vehicle_link = array_2d_add(level.vehicle_link, vehicle.script_linkname, vehicle);
    }
    if (isdefined(vehicle.script_vehiclespawngroup)) {
        level.vehicle_spawngroup = array_2d_add(level.vehicle_spawngroup, vehicle.script_vehiclespawngroup, vehicle);
    }
    if (isdefined(vehicle.script_vehiclestartmove)) {
        level.vehicle_startmovegroup = array_2d_add(level.vehicle_startmovegroup, vehicle.script_vehiclestartmove, vehicle);
    }
    if (isdefined(vehicle.script_vehiclegroupdelete)) {
        level.vehicle_deletegroup = array_2d_add(level.vehicle_deletegroup, vehicle.script_vehiclegroupdelete, vehicle);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x9844353a, Offset: 0x2090
// Size: 0x42
function _spawn_array(spawners) {
    ai = _remove_non_riders_from_array(spawner::simple_spawn(spawners));
    return ai;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x27d07699, Offset: 0x20e0
// Size: 0x80
function _remove_non_riders_from_array(ai) {
    living_ai = [];
    for (i = 0; i < ai.size; i++) {
        if (!ai_should_be_added(ai[i])) {
            continue;
        }
        living_ai[living_ai.size] = ai[i];
    }
    return living_ai;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xe84dd71a, Offset: 0x2168
// Size: 0x60
function ai_should_be_added(ai) {
    if (isalive(ai)) {
        return true;
    }
    if (!isdefined(ai)) {
        return false;
    }
    if (!isdefined(ai.classname)) {
        return false;
    }
    return ai.classname == "script_model";
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xef4c6a66, Offset: 0x21d0
// Size: 0xba
function sort_by_startingpos(guysarray) {
    firstarray = [];
    secondarray = [];
    for (i = 0; i < guysarray.size; i++) {
        if (isdefined(guysarray[i].script_startingposition)) {
            firstarray[firstarray.size] = guysarray[i];
            continue;
        }
        secondarray[secondarray.size] = guysarray[i];
    }
    return arraycombine(firstarray, secondarray, 1, 0);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x2459a84e, Offset: 0x2298
// Size: 0x9a
function rider_walk_setup(vehicle) {
    if (!isdefined(self.script_vehiclewalk)) {
        return;
    }
    if (isdefined(self.script_followmode)) {
        self.followmode = self.script_followmode;
    } else {
        self.followmode = "cover nodes";
    }
    if (!isdefined(self.target)) {
        return;
    }
    node = getnode(self.target, "targetname");
    if (isdefined(node)) {
        self.nodeaftervehiclewalk = node;
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xaf41ec1e, Offset: 0x2340
// Size: 0xc8
function setup_groundnode_detour(node) {
    a_nd_realdetour = getvehiclenodearray(node.targetname, "target2");
    if (!a_nd_realdetour.size) {
        return;
    }
    foreach (nd_detour in a_nd_realdetour) {
        nd_detour.detoured = 0;
        add_proccess_trigger(nd_detour);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x7bfecd25, Offset: 0x2410
// Size: 0xb2
function add_proccess_trigger(trigger) {
    if (isdefined(trigger.processed_trigger)) {
        return;
    }
    if (!isdefined(level.vehicle_processtriggers)) {
        level.vehicle_processtriggers = [];
    } else if (!isarray(level.vehicle_processtriggers)) {
        level.vehicle_processtriggers = array(level.vehicle_processtriggers);
    }
    level.vehicle_processtriggers[level.vehicle_processtriggers.size] = trigger;
    trigger.processed_trigger = 1;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x681552dd, Offset: 0x24d0
// Size: 0x74
function islastnode(node) {
    if (!isdefined(node.target)) {
        return true;
    }
    if (!isdefined(getvehiclenode(node.target, "targetname")) && !isdefined(get_vehiclenode_any_dynamic(node.target))) {
        return true;
    }
    return false;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xfa149090, Offset: 0x2550
// Size: 0xbec
function paths(node) {
    assert(isdefined(node) || isdefined(self.attachedpath), "<dev string:x9d>");
    self notify(#"endpath");
    self endon(#"endpath");
    self notify(#"newpath");
    self endon(#"death", #"newpath");
    if (isdefined(node)) {
        self.attachedpath = node;
    }
    pathstart = self.attachedpath;
    self.currentnode = self.attachedpath;
    if (!isdefined(pathstart)) {
        return;
    }
    /#
        self thread debug_vehicle_paths();
    #/
    currentpoint = pathstart;
    while (isdefined(currentpoint)) {
        waitresult = self waittill(#"reached_node");
        currentpoint = waitresult.node;
        currentpoint enable_turrets(self);
        if (!isdefined(self)) {
            return;
        }
        self.currentnode = currentpoint;
        self.nextnode = isdefined(currentpoint.target) ? getvehiclenode(currentpoint.target, "targetname") : undefined;
        if (isdefined(currentpoint.gateopen) && !currentpoint.gateopen) {
            self thread path_gate_wait_till_open(currentpoint);
        }
        currentpoint notify(#"trigger", {#activator:self});
        if (isdefined(currentpoint.script_dropbombs) && currentpoint.script_dropbombs > 0) {
            amount = currentpoint.script_dropbombs;
            delay = 0;
            delaytrace = 0;
            if (isdefined(currentpoint.script_dropbombs_delay) && currentpoint.script_dropbombs_delay > 0) {
                delay = currentpoint.script_dropbombs_delay;
            }
            if (isdefined(currentpoint.script_dropbombs_delaytrace) && currentpoint.script_dropbombs_delaytrace > 0) {
                delaytrace = currentpoint.script_dropbombs_delaytrace;
            }
            self notify(#"drop_bombs", {#amount:amount, #delay:delay, #delay_trace:delaytrace});
        }
        if (isdefined(currentpoint.script_noteworthy)) {
            self notify(currentpoint.script_noteworthy);
            self notify(#"noteworthy", {#noteworthy:currentpoint.script_noteworthy});
        }
        if (isdefined(currentpoint.script_notify)) {
            self notify(currentpoint.script_notify);
            level notify(currentpoint.script_notify);
        }
        waittillframeend();
        if (!isdefined(self)) {
            return;
        }
        if (isdefined(currentpoint.script_delete) && currentpoint.script_delete) {
            if (isdefined(self.riders) && self.riders.size > 0) {
                array::delete_all(self.riders);
            }
            self delete();
            return;
        }
        if (isdefined(currentpoint.script_sound)) {
            self playsound(currentpoint.script_sound);
        }
        if (isdefined(currentpoint.script_noteworthy)) {
            if (currentpoint.script_noteworthy == "godon") {
                self god_on();
            } else if (currentpoint.script_noteworthy == "godoff") {
                self god_off();
            } else if (currentpoint.script_noteworthy == "drivepath") {
                self drivepath();
            } else if (currentpoint.script_noteworthy == "lockpath") {
                self startpath();
            } else if (currentpoint.script_noteworthy == "brake") {
                if (self.isphysicsvehicle) {
                    self setbrake(1);
                }
                self setspeed(0, 60, 60);
            } else if (currentpoint.script_noteworthy == "resumespeed") {
                accel = 30;
                if (isdefined(currentpoint.script_float)) {
                    accel = currentpoint.script_float;
                }
                self resumespeed(accel);
            }
        }
        if (isdefined(currentpoint.script_crashtypeoverride)) {
            self.script_crashtypeoverride = currentpoint.script_crashtypeoverride;
        }
        if (isdefined(currentpoint.script_badplace)) {
            self.script_badplace = currentpoint.script_badplace;
        }
        if (isdefined(currentpoint.script_team)) {
            self.team = currentpoint.script_team;
        }
        if (isdefined(currentpoint.script_turningdir)) {
            self notify(#"turning", {#direction:currentpoint.script_turningdir});
        }
        if (isdefined(currentpoint.script_deathroll)) {
            if (currentpoint.script_deathroll == 0) {
                self thread vehicle_death::deathrolloff();
            } else {
                self thread vehicle_death::deathrollon();
            }
        }
        if (isdefined(currentpoint.script_exploder)) {
            exploder::exploder(currentpoint.script_exploder);
        }
        if (isdefined(currentpoint.script_flag_set)) {
            if (isdefined(self.vehicle_flags)) {
                self.vehicle_flags[currentpoint.script_flag_set] = 1;
            }
            self notify(#"vehicle_flag_arrived", {#is_set:currentpoint.script_flag_set});
            level flag::set(currentpoint.script_flag_set);
        }
        if (isdefined(currentpoint.script_flag_clear)) {
            if (isdefined(self.vehicle_flags)) {
                self.vehicle_flags[currentpoint.script_flag_clear] = 0;
            }
            level flag::clear(currentpoint.script_flag_clear);
        }
        if (self.vehicleclass === "helicopter" && isdefined(self.drivepath) && self.drivepath == 1) {
            if (isdefined(self.nextnode) && self.nextnode is_unload_node()) {
                unload_node_helicopter(undefined);
                self.attachedpath = self.nextnode;
                self drivepath(self.attachedpath);
            }
        } else if (currentpoint is_unload_node()) {
            unload_node(currentpoint);
        }
        if (isdefined(currentpoint.script_wait)) {
            pause_path();
            currentpoint util::script_wait();
        }
        if (isdefined(currentpoint.script_waittill)) {
            pause_path();
            util::waittill_any_ents(self, currentpoint.script_waittill, level, currentpoint.script_waittill);
        }
        if (isdefined(currentpoint.script_flag_wait)) {
            if (!isdefined(self.vehicle_flags)) {
                self.vehicle_flags = [];
            }
            self.vehicle_flags[currentpoint.script_flag_wait] = 1;
            self notify(#"vehicle_flag_arrived", {#is_set:currentpoint.script_flag_wait});
            self flag::set("waiting_for_flag");
            if (!level flag::get(currentpoint.script_flag_wait)) {
                pause_path();
                level flag::wait_till(currentpoint.script_flag_wait);
            }
            self flag::clear("waiting_for_flag");
        }
        if (isdefined(self.set_lookat_point)) {
            self.set_lookat_point = undefined;
            self vehclearlookat();
        }
        if (isdefined(currentpoint.script_lights_on)) {
            if (currentpoint.script_lights_on) {
                self lights_on();
            } else {
                self lights_off();
            }
        }
        if (isdefined(currentpoint.script_stopnode)) {
            self set_goal_pos(currentpoint.origin, 1);
        }
        if (isdefined(self.switchnode)) {
            if (currentpoint == self.switchnode) {
                self.switchnode = undefined;
            }
        } else if (!isdefined(currentpoint.target)) {
            break;
        }
        if (isdefined(self.vehicle_paused) && self.vehicle_paused) {
            resume_path();
        }
    }
    self notify(#"reached_dynamic_path_end");
    self.attachedpath = undefined;
    if (isai(self)) {
        self function_3d2d74fd();
    }
    if (isdefined(self.var_5fbe1cdd) && self.var_5fbe1cdd) {
        self function_9f59031e();
    }
    if (isdefined(self.script_delete)) {
        self delete();
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xb321c0a3, Offset: 0x3148
// Size: 0xda
function pause_path() {
    if (!(isdefined(self.vehicle_paused) && self.vehicle_paused)) {
        if (self.isphysicsvehicle) {
            self setbrake(1);
        }
        if (self.vehicleclass === "helicopter") {
            if (isdefined(self.drivepath) && self.drivepath) {
                self function_3c8dce03(self.origin, 1);
            } else {
                self setspeed(0, 100, 100);
            }
        } else {
            self setspeed(0, 35, 35);
        }
        self.vehicle_paused = 1;
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x1ac68674, Offset: 0x3230
// Size: 0xc6
function resume_path() {
    if (isdefined(self.vehicle_paused) && self.vehicle_paused) {
        if (self.isphysicsvehicle) {
            self setbrake(0);
        }
        if (self.vehicleclass === "helicopter") {
            if (isdefined(self.drivepath) && self.drivepath) {
                self drivepath(self.currentnode);
            }
            self resumespeed(100);
        } else {
            self resumespeed(35);
        }
        self.vehicle_paused = undefined;
    }
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x63067970, Offset: 0x3300
// Size: 0x22c
function get_on_path(path_start, str_key = "targetname", distance = 0) {
    if (isstring(path_start)) {
        path_start = getvehiclenode(path_start, str_key);
    }
    if (!isdefined(path_start)) {
        if (isdefined(self.targetname)) {
            assertmsg("<dev string:xc2>" + self.targetname);
        } else {
            assertmsg("<dev string:xc2>" + self.targetname);
        }
    }
    if (isdefined(self.hasstarted)) {
        self.hasstarted = undefined;
    }
    self.attachedpath = path_start;
    if (!(isdefined(self.drivepath) && self.drivepath)) {
        self attachpath(path_start);
    } else if (distance != 0) {
        self function_513ceae7(path_start, distance);
        self.var_faac4ec9 = 1;
    }
    if (self.disconnectpathonstop === 1 && !issentient(self)) {
        self disconnect_paths(self.disconnectpathdetail);
    }
    if (isdefined(self.isphysicsvehicle) && self.isphysicsvehicle) {
        self setbrake(1);
    }
    if (isai(self)) {
        self vehicle_ai::set_state("spline");
    }
    self thread paths();
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x8f3c99ee, Offset: 0x3538
// Size: 0x94
function function_3d2d74fd() {
    assert(isdefined(isai(self)) && isai(self));
    state = self vehicle_ai::get_previous_state();
    if (!isdefined(state)) {
        state = "off";
    }
    self vehicle_ai::set_state(state);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xbd5c7c4c, Offset: 0x35d8
// Size: 0x64
function get_off_path() {
    self cancelaimove();
    self function_9f59031e();
    if (isai(self)) {
        function_3d2d74fd();
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x63c4a193, Offset: 0x3648
// Size: 0x82
function create_from_spawngroup_and_go_path(spawngroup) {
    vehiclearray = _scripted_spawn(spawngroup);
    for (i = 0; i < vehiclearray.size; i++) {
        if (isdefined(vehiclearray[i])) {
            vehiclearray[i] thread go_path();
        }
    }
    return vehiclearray;
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x17bad371, Offset: 0x36d8
// Size: 0x5c
function get_on_and_go_path(path_start, distance = 0) {
    self get_on_path(path_start, "targetname", distance);
    self go_path();
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x8feb1103, Offset: 0x3740
// Size: 0x218
function go_path() {
    self endon(#"death", #"stop path");
    if (self.isphysicsvehicle) {
        self setbrake(0);
    }
    if (isdefined(self.script_vehiclestartmove)) {
        arrayremovevalue(level.vehicle_startmovegroup[self.script_vehiclestartmove], self);
    }
    if (isdefined(self.hasstarted)) {
        println("<dev string:xe7>");
        return;
    } else {
        self.hasstarted = 1;
    }
    self util::script_delay();
    self notify(#"start_vehiclepath");
    if (isdefined(self.var_faac4ec9) && self.var_faac4ec9) {
        self drivepath();
    } else if (isdefined(self.drivepath) && self.drivepath) {
        self drivepath(self.attachedpath);
    } else {
        self startpath();
    }
    waitframe(1);
    self connect_paths();
    self waittill(#"reached_end_node");
    if (self.disconnectpathonstop === 1 && !issentient(self)) {
        self disconnect_paths(self.disconnectpathdetail);
    }
    if (isdefined(self.currentnode) && isdefined(self.currentnode.script_noteworthy) && self.currentnode.script_noteworthy == "deleteme") {
        return;
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xb1dc647d, Offset: 0x3960
// Size: 0x30
function path_gate_open(node) {
    node.gateopen = 1;
    node notify(#"gate opened");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x4596b642, Offset: 0x3998
// Size: 0x9c
function path_gate_wait_till_open(pathspot) {
    self endon(#"death");
    self.waitingforgate = 1;
    self set_speed(0, 15, "path gate closed");
    pathspot waittill(#"gate opened");
    self.waitingforgate = 0;
    if (self.health > 0) {
        script_resume_speed("gate opened", level.vehicle_resumespeed);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x4fd9e025, Offset: 0x3a40
// Size: 0xca
function _spawn_group(spawngroup) {
    while (true) {
        level waittill("spawnvehiclegroup" + spawngroup);
        spawned_vehicles = [];
        for (i = 0; i < level.vehicle_spawners[spawngroup].size; i++) {
            spawned_vehicles[spawned_vehicles.size] = _vehicle_spawn(level.vehicle_spawners[spawngroup][i]);
        }
        level notify("vehiclegroup spawned" + spawngroup, {#vehicles:spawned_vehicles});
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xfdb8dba4, Offset: 0x3b18
// Size: 0x4e
function _scripted_spawn(group) {
    thread _scripted_spawn_go(group);
    waitresult = level waittill("vehiclegroup spawned" + group);
    return waitresult.vehicles;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xf8dd68fd, Offset: 0x3b70
// Size: 0x22
function _scripted_spawn_go(group) {
    waittillframeend();
    level notify("spawnvehiclegroup" + group);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x7d7bf35a, Offset: 0x3ba0
// Size: 0xc
function set_variables(vehicle) {
    
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x22928608, Offset: 0x3bb8
// Size: 0x1e2
function _vehicle_spawn(vspawner) {
    if (!isdefined(vspawner) || !vspawner.count) {
        return;
    }
    spawner::global_spawn_throttle();
    if (!isdefined(vspawner) || !vspawner.count) {
        return;
    }
    vehicle = vspawner spawnfromspawner(isdefined(vspawner.targetname) ? vspawner.targetname : undefined, 1);
    if (!isdefined(vehicle)) {
        return;
    }
    if (isdefined(vspawner.script_team)) {
        vehicle setteam(vspawner.script_team);
    }
    if (isdefined(vehicle.lockheliheight)) {
        vehicle setheliheightlock(vehicle.lockheliheight);
    }
    if (isdefined(vehicle.targetname)) {
        level notify("new_vehicle_spawned" + vehicle.targetname, {#vehicle:vehicle});
    }
    if (isdefined(vehicle.script_noteworthy)) {
        level notify("new_vehicle_spawned" + vehicle.script_noteworthy, {#vehicle:vehicle});
    }
    if (isdefined(vehicle.script_animname)) {
        vehicle.animname = vehicle.script_animname;
    }
    if (isdefined(vehicle.script_animscripted)) {
        vehicle.supportsanimscripted = vehicle.script_animscripted;
    }
    return vehicle;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x43ef0fb2, Offset: 0x3da8
// Size: 0x7a4
function init(vehicle) {
    callback::callback(#"on_vehicle_spawned");
    vehicle useanimtree("generic");
    if (isdefined(vehicle.e_dyn_path)) {
        vehicle.e_dyn_path linkto(vehicle);
    }
    vehicle flag::init("waiting_for_flag");
    if (isdefined(vehicle.script_godmode) && vehicle.script_godmode) {
        vehicle val::set(#"script_godmode", "takedamage", 0);
    }
    vehicle.zerospeed = 1;
    if (!isdefined(vehicle.modeldummyon)) {
        vehicle.modeldummyon = 0;
    }
    if (isdefined(vehicle.isphysicsvehicle) && vehicle.isphysicsvehicle) {
        if (isdefined(vehicle.script_brake) && vehicle.script_brake) {
            vehicle setbrake(1);
        }
    }
    type = vehicle.vehicletype;
    vehicle _vehicle_life();
    vehicle thread maingun_fx();
    vehicle.getoutrig = [];
    if (isdefined(level.vehicle_attachedmodels) && isdefined(level.vehicle_attachedmodels[type])) {
        rigs = level.vehicle_attachedmodels[type];
        strings = getarraykeys(rigs);
        for (i = 0; i < strings.size; i++) {
            vehicle.getoutrig[strings[i]] = undefined;
            vehicle.getoutriganimating[strings[i]] = 0;
        }
    }
    if (isdefined(self.script_badplace)) {
        vehicle thread _vehicle_bad_place();
    }
    if (isdefined(vehicle.scriptbundlesettings)) {
        settings = struct::get_script_bundle("vehiclecustomsettings", vehicle.scriptbundlesettings);
        if (isdefined(settings) && isdefined(settings.lightgroups_numgroups)) {
            if (settings.lightgroups_numgroups >= 1 && settings.lightgroups_1_always_on === 1) {
                vehicle toggle_lights_group(1, 1);
            }
            if (settings.lightgroups_numgroups >= 2 && settings.lightgroups_2_always_on === 1) {
                vehicle toggle_lights_group(2, 1);
            }
            if (settings.lightgroups_numgroups >= 3 && settings.lightgroups_3_always_on === 1) {
                vehicle toggle_lights_group(3, 1);
            }
            if (settings.lightgroups_numgroups >= 4 && settings.lightgroups_4_always_on === 1) {
                vehicle toggle_lights_group(4, 1);
            }
        }
    }
    if (!vehicle is_cheap()) {
        vehicle friendly_fire_shield();
    }
    if (isdefined(vehicle.script_physicsjolt) && vehicle.script_physicsjolt) {
    }
    levelstuff(vehicle);
    vehicle.disconnectpathdetail = 0;
    if (vehicle.vehicleclass === "artillery") {
        vehicle.disconnectpathonstop = undefined;
        self disconnect_paths(0);
    } else if (vehicle.isplayervehicle) {
        vehicle.disconnectpathonstop = 1;
        vehicle.disconnectpathdetail = 2;
    } else {
        vehicle.disconnectpathonstop = self.script_disconnectpaths;
    }
    if (isdefined(self.script_disconnectpath_detail)) {
        vehicle.disconnectpathdetail = self.script_disconnectpath_detail;
    }
    if (!vehicle is_cheap() && !(vehicle.vehicleclass === "plane") && !(vehicle.vehicleclass === "artillery")) {
        vehicle thread _disconnect_paths_when_stopped();
    }
    if (!isdefined(vehicle.script_nonmovingvehicle)) {
        path_start = get_target(vehicle);
        if (isdefined(path_start) && isvehiclenode(path_start)) {
            vehicle thread get_on_path(path_start);
        }
    }
    if (isdefined(vehicle.script_vehicleattackgroup)) {
        vehicle thread attack_group_think();
    }
    /#
        if (isdefined(vehicle.script_recordent) && vehicle.script_recordent) {
            recordent(vehicle);
        }
    #/
    /#
        vehicle thread debug_vehicle();
    #/
    if (!vehicle vehicle_ai::function_9e6e6f62()) {
        vehicle thread vehicle_death::main();
    }
    if (isdefined(vehicle.script_targetset) && vehicle.script_targetset == 1) {
        offset = (0, 0, 0);
        if (isdefined(vehicle.script_targetoffset)) {
            offset = vehicle.script_targetoffset;
        }
        make_targetable(vehicle, offset);
    }
    if (isdefined(vehicle.script_vehicleavoidance) && vehicle.script_vehicleavoidance) {
        vehicle setvehicleavoidance(1);
    }
    vehicle enable_turrets();
    if (isdefined(level.vehiclespawncallbackthread)) {
        level thread [[ level.vehiclespawncallbackthread ]](vehicle);
    }
    heatseekingmissile::initlockfield(vehicle);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x4e5195c6, Offset: 0x4558
// Size: 0x3c
function make_targetable(vehicle, offset = (0, 0, 0)) {
    target_set(vehicle, offset);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xc98bbb17, Offset: 0x45a0
// Size: 0xb8
function function_fc750064(vehicle) {
    subtargets = target_getpotentialsubtargets(vehicle);
    if (subtargets.size > 1) {
        foreach (subtarget in subtargets) {
            if (subtarget) {
                thread subtarget_watch(vehicle, subtarget);
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x70694c55, Offset: 0x4660
// Size: 0xbc
function subtarget_watch(vehicle, subtarget) {
    vehicle endon(#"death");
    target_set(vehicle, (0, 0, 0), subtarget);
    while (true) {
        waitresult = vehicle waittill(#"subtarget_broken");
        if (waitresult.subtarget === subtarget) {
            break;
        }
    }
    if (target_istarget(vehicle, subtarget)) {
        target_remove(vehicle, subtarget);
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x8384beca, Offset: 0x4728
// Size: 0x2a
function get_settings() {
    settings = getscriptbundle(self.scriptbundlesettings);
    return settings;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x65ea9189, Offset: 0x4760
// Size: 0x98
function detach_getoutrigs() {
    if (!isdefined(self.getoutrig)) {
        return;
    }
    if (!self.getoutrig.size) {
        return;
    }
    foreach (v in self.getoutrig) {
        v unlink();
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x2e40ea9, Offset: 0x4800
// Size: 0x21c
function enable_turrets(veh = self) {
    if (isdefined(self.script_enable_turret0) && self.script_enable_turret0) {
        veh turret::enable(0);
    }
    if (isdefined(self.script_enable_turret1) && self.script_enable_turret1) {
        veh turret::enable(1);
    }
    if (isdefined(self.script_enable_turret2) && self.script_enable_turret2) {
        veh turret::enable(2);
    }
    if (isdefined(self.script_enable_turret3) && self.script_enable_turret3) {
        veh turret::enable(3);
    }
    if (isdefined(self.script_enable_turret4) && self.script_enable_turret4) {
        veh turret::enable(4);
    }
    if (isdefined(self.script_enable_turret0) && !self.script_enable_turret0) {
        veh turret::disable(0);
    }
    if (isdefined(self.script_enable_turret1) && !self.script_enable_turret1) {
        veh turret::disable(1);
    }
    if (isdefined(self.script_enable_turret2) && !self.script_enable_turret2) {
        veh turret::disable(2);
    }
    if (isdefined(self.script_enable_turret3) && !self.script_enable_turret3) {
        veh turret::disable(3);
    }
    if (isdefined(self.script_enable_turret4) && !self.script_enable_turret4) {
        veh turret::disable(4);
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xcdb936c5, Offset: 0x4a28
// Size: 0x34
function function_c130bd7b() {
    self notify(#"hash_328ac97cd09c325b");
    self.disconnectpathonstop = 0;
    self thread _disconnect_paths_when_stopped();
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xaad5767e, Offset: 0x4a68
// Size: 0x178
function _disconnect_paths_when_stopped() {
    if (ispathfinder(self) && !(isdefined(self.disconnectpathonstop) && self.disconnectpathonstop)) {
        return;
    }
    if (isdefined(self.script_disconnectpaths) && !self.script_disconnectpaths) {
        self.disconnectpathonstop = 0;
        return;
    }
    self endon(#"death", #"hash_328ac97cd09c325b");
    wait 1;
    threshold = 3;
    while (isdefined(self)) {
        if (lengthsquared(self.velocity) < threshold * threshold) {
            if (self.disconnectpathonstop === 1) {
                self disconnect_paths(self.disconnectpathdetail);
                self notify(#"hash_10dac1ee2d2d2746");
            }
            while (lengthsquared(self.velocity) < threshold * threshold) {
                waitframe(1);
            }
        }
        self connect_paths();
        while (lengthsquared(self.velocity) >= threshold * threshold) {
            waitframe(1);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x31da65cc, Offset: 0x4be8
// Size: 0x84
function set_speed(speed, rate, msg) {
    if (self getspeedmph() == 0 && speed == 0) {
        return;
    }
    /#
        self thread debug_set_speed(speed, rate, msg);
    #/
    self setspeed(speed, rate);
}

/#

    // Namespace vehicle/vehicle_shared
    // Params 3, eflags: 0x0
    // Checksum 0x51cf0059, Offset: 0x4c78
    // Size: 0xfc
    function debug_set_speed(speed, rate, msg) {
        self notify(#"new debug_vehiclesetspeed");
        self endon(#"new debug_vehiclesetspeed", #"resuming speed", #"death");
        while (true) {
            while (getdvarstring(#"debug_vehiclesetspeed") != "<dev string:x11e>") {
                print3d(self.origin + (0, 0, 192), "<dev string:x122>" + msg, (1, 1, 1), 1, 3);
                waitframe(1);
            }
            wait 0.5;
        }
    }

#/

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x4fe6bfa8, Offset: 0x4d80
// Size: 0x15c
function script_resume_speed(msg, rate) {
    fsetspeed = 0;
    type = "resumespeed";
    if (!isdefined(self.resumemsgs)) {
        self.resumemsgs = [];
    }
    if (isdefined(self.waitingforgate) && self.waitingforgate) {
        return;
    }
    if (isdefined(self.attacking) && self.attacking) {
        fsetspeed = self.attackspeed;
        type = "setspeed";
    }
    self.zerospeed = 0;
    if (fsetspeed == 0) {
        self.zerospeed = 1;
    }
    if (type == "resumespeed") {
        self resumespeed(rate);
    } else if (type == "setspeed") {
        self set_speed(fsetspeed, 15, "resume setspeed from attack");
    }
    self notify(#"resuming speed");
    /#
        self thread debug_resume(msg + "<dev string:x135>" + type);
    #/
}

/#

    // Namespace vehicle/vehicle_shared
    // Params 1, eflags: 0x0
    // Checksum 0xcaa03e6a, Offset: 0x4ee8
    // Size: 0x132
    function debug_resume(msg) {
        if (getdvarstring(#"debug_vehicleresume") == "<dev string:x11e>") {
            return;
        }
        self endon(#"death");
        number = self.resumemsgs.size;
        self.resumemsgs[number] = msg;
        self thread print_resume_speed(gettime() + int(3 * 1000));
        wait 3;
        newarray = [];
        for (i = 0; i < self.resumemsgs.size; i++) {
            if (i != number) {
                newarray[newarray.size] = self.resumemsgs[i];
            }
        }
        self.resumemsgs = newarray;
    }

#/

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x49491e8e, Offset: 0x5028
// Size: 0x128
function print_resume_speed(timer) {
    self notify(#"newresumespeedmsag");
    self endon(#"newresumespeedmsag", #"death");
    while (gettime() < timer && isdefined(self.resumemsgs)) {
        if (self.resumemsgs.size > 6) {
            start = self.resumemsgs.size - 5;
        } else {
            start = 0;
        }
        for (i = start; i < self.resumemsgs.size; i++) {
            position = i * 32;
            /#
                print3d(self.origin + (0, 0, position), "<dev string:x138>" + self.resumemsgs[i], (0, 1, 0), 1, 3);
            #/
        }
        waitframe(1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x2c885df3, Offset: 0x5158
// Size: 0x2c
function god_on() {
    self val::set(#"vehicle_god_on", "takedamage", 0);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x74b734e8, Offset: 0x5190
// Size: 0x2c
function god_off() {
    self val::reset(#"vehicle_god_on", "takedamage");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x3221f28d, Offset: 0x51c8
// Size: 0x84
function get_normal_anim_time(animation) {
    animtime = self getanimtime(animation);
    animlength = getanimlength(animation);
    if (animtime == 0) {
        return 0;
    }
    return self getanimtime(animation) / getanimlength(animation);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xa9a617b6, Offset: 0x5258
// Size: 0x62
function setup_dynamic_detour(pathnode, get_func) {
    prevnode = [[ get_func ]](pathnode.targetname);
    assert(isdefined(prevnode), "<dev string:x149>");
    prevnode.detoured = 0;
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x880a2181, Offset: 0x52c8
// Size: 0x5c
function array_2d_add(array, firstelem, newelem) {
    if (!isdefined(array[firstelem])) {
        array[firstelem] = [];
    }
    array[firstelem][array[firstelem].size] = newelem;
    return array;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x847aee68, Offset: 0x5330
// Size: 0x32
function is_node_script_origin(pathnode) {
    return isdefined(pathnode.classname) && pathnode.classname == "script_origin";
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x68baa5af, Offset: 0x5370
// Size: 0x32c
function node_trigger_process() {
    processtrigger = 0;
    if (isdefined(self.spawnflags) && (self.spawnflags & 1) == 1) {
        if (isdefined(self.script_crashtype)) {
            level.vehicle_crashpaths[level.vehicle_crashpaths.size] = self;
        }
        level.vehicle_startnodes[level.vehicle_startnodes.size] = self;
    }
    if (isdefined(self.script_vehicledetour) && isdefined(self.targetname)) {
        get_func = undefined;
        if (isdefined(get_from_entity(self.targetname))) {
            get_func = &get_from_entity_target;
        }
        if (isdefined(get_from_spawnstruct(self.targetname))) {
            get_func = &get_from_spawnstruct_target;
        }
        if (isdefined(get_func)) {
            setup_dynamic_detour(self, get_func);
            processtrigger = 1;
        } else {
            setup_groundnode_detour(self);
        }
        level.vehicle_detourpaths = array_2d_add(level.vehicle_detourpaths, self.script_vehicledetour, self);
        /#
            if (level.vehicle_detourpaths[self.script_vehicledetour].size > 2) {
                println("<dev string:x167>", self.script_vehicledetour);
            }
        #/
    }
    if (isdefined(self.script_gatetrigger)) {
        level.vehicle_gatetrigger = array_2d_add(level.vehicle_gatetrigger, self.script_gatetrigger, self);
        self.gateopen = 0;
    }
    if (isdefined(self.script_flag_set)) {
        if (!isdefined(level.flag) || !isdefined(level.flag[self.script_flag_set])) {
            level flag::init(self.script_flag_set);
        }
    }
    if (isdefined(self.script_flag_clear)) {
        if (!level flag::exists(self.script_flag_clear)) {
            level flag::init(self.script_flag_clear);
        }
    }
    if (isdefined(self.script_flag_wait)) {
        if (!level flag::exists(self.script_flag_wait)) {
            level flag::init(self.script_flag_wait);
        }
    }
    if (isdefined(self.script_vehiclespawngroup) || isdefined(self.script_vehiclestartmove) || isdefined(self.script_gatetrigger) || isdefined(self.script_vehiclegroupdelete)) {
        processtrigger = 1;
    }
    if (processtrigger) {
        add_proccess_trigger(self);
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x35f326b6, Offset: 0x56a8
// Size: 0xe4
function setup_triggers() {
    level.vehicle_processtriggers = [];
    triggers = [];
    triggers = arraycombine(getallvehiclenodes(), getentarray("script_origin", "classname"), 1, 0);
    triggers = arraycombine(triggers, level.struct, 1, 0);
    triggers = arraycombine(triggers, trigger::get_all(), 1, 0);
    array::thread_all(triggers, &node_trigger_process);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x99c67250, Offset: 0x5798
// Size: 0xc8
function setup_nodes() {
    a_nodes = getallvehiclenodes();
    foreach (node in a_nodes) {
        if (isdefined(node.script_flag_set)) {
            if (!level flag::exists(node.script_flag_set)) {
                level flag::init(node.script_flag_set);
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x4b719cf, Offset: 0x5868
// Size: 0x44
function is_node_script_struct(node) {
    if (!isdefined(node.targetname)) {
        return false;
    }
    return isdefined(struct::get(node.targetname, "targetname"));
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xff61cc5b, Offset: 0x58b8
// Size: 0x368
function setup_spawners(a_veh_spawners) {
    spawnvehicles = [];
    groups = [];
    foreach (spawner in a_veh_spawners) {
        if (isdefined(spawner.script_vehiclespawngroup)) {
            if (!isdefined(spawnvehicles[spawner.script_vehiclespawngroup])) {
                spawnvehicles[spawner.script_vehiclespawngroup] = [];
            } else if (!isarray(spawnvehicles[spawner.script_vehiclespawngroup])) {
                spawnvehicles[spawner.script_vehiclespawngroup] = array(spawnvehicles[spawner.script_vehiclespawngroup]);
            }
            spawnvehicles[spawner.script_vehiclespawngroup][spawnvehicles[spawner.script_vehiclespawngroup].size] = spawner;
            addgroup[0] = spawner.script_vehiclespawngroup;
            groups = arraycombine(groups, addgroup, 0, 0);
        }
    }
    waittillframeend();
    foreach (spawngroup in groups) {
        a_veh_spawners = spawnvehicles[spawngroup];
        level.vehicle_spawners[spawngroup] = [];
        foreach (sp in a_veh_spawners) {
            if (sp.count < 1) {
                sp.count = 1;
            }
            set_variables(sp);
            if (!isdefined(level.vehicle_spawners[spawngroup])) {
                level.vehicle_spawners[spawngroup] = [];
            } else if (!isarray(level.vehicle_spawners[spawngroup])) {
                level.vehicle_spawners[spawngroup] = array(level.vehicle_spawners[spawngroup]);
            }
            level.vehicle_spawners[spawngroup][level.vehicle_spawners[spawngroup].size] = sp;
        }
        level thread _spawn_group(spawngroup);
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x7903c807, Offset: 0x5c28
// Size: 0x76
function _vehicle_life() {
    if (isdefined(self.destructibledef)) {
        self.health = 99999;
        return;
    }
    type = self.vehicletype;
    if (isdefined(self.script_startinghealth)) {
        self.health = self.script_startinghealth;
        return;
    }
    if (!self.var_3e9c2d0b) {
        return;
    }
    self.health = self.healthdefault;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x5ca8
// Size: 0x4
function _vehicle_load_assets() {
    
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xac74e33b, Offset: 0x5cb8
// Size: 0x26
function is_cheap() {
    if (!isdefined(self.script_cheap)) {
        return false;
    }
    if (!self.script_cheap) {
        return false;
    }
    return true;
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x3fe59105, Offset: 0x5ce8
// Size: 0xce
function play_looped_fx_on_tag(effect, durration, tag) {
    emodel = get_dummy();
    effectorigin = sys::spawn("script_origin", emodel.origin);
    self endon(#"fire_extinguish");
    thread _play_looped_fx_on_tag_origin_update(tag, effectorigin);
    while (true) {
        playfx(effect, effectorigin.origin, effectorigin.upvec);
        wait durration;
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x12c2b515, Offset: 0x5dc0
// Size: 0x198
function _play_looped_fx_on_tag_origin_update(tag, effectorigin) {
    effectorigin.angles = self gettagangles(tag);
    effectorigin.origin = self gettagorigin(tag);
    effectorigin.forwardvec = anglestoforward(effectorigin.angles);
    effectorigin.upvec = anglestoup(effectorigin.angles);
    while (isdefined(self) && self.classname == "script_vehicle" && self getspeedmph() > 0) {
        emodel = get_dummy();
        effectorigin.angles = emodel gettagangles(tag);
        effectorigin.origin = emodel gettagorigin(tag);
        effectorigin.forwardvec = anglestoforward(effectorigin.angles);
        effectorigin.upvec = anglestoup(effectorigin.angles);
        waitframe(1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x59a0fed8, Offset: 0x5f60
// Size: 0xbc
function setup_dvars() {
    /#
        if (getdvarstring(#"debug_vehicleresume") == "<dev string:x1a4>") {
            setdvar(#"debug_vehicleresume", "<dev string:x11e>");
        }
        if (getdvarstring(#"debug_vehiclesetspeed") == "<dev string:x1a4>") {
            setdvar(#"debug_vehiclesetspeed", "<dev string:x11e>");
        }
    #/
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xf25514a7, Offset: 0x6028
// Size: 0x2e6
function setup_level_vars() {
    level.vehicle_resumespeed = 5;
    level.vehicle_deletegroup = [];
    level.vehicle_spawngroup = [];
    level.vehicle_startmovegroup = [];
    level.vehicle_deathswitch = [];
    level.vehicle_gatetrigger = [];
    level.vehicle_crashpaths = [];
    level.vehicle_link = [];
    level.vehicle_detourpaths = [];
    level.vehicle_startnodes = [];
    level.vehicle_spawners = [];
    level.a_str_vehicle_spawn_custom_keys = [];
    level.vehicle_walkercount = [];
    level.helicopter_crash_locations = getentarray("helicopter_crash_location", "targetname");
    level.playervehicle = sys::spawn("script_origin", (0, 0, 0));
    level.playervehiclenone = level.playervehicle;
    if (!isdefined(level.vehicle_death_thread)) {
        level.vehicle_death_thread = [];
    }
    if (!isdefined(level.vehicle_driveidle)) {
        level.vehicle_driveidle = [];
    }
    if (!isdefined(level.vehicle_driveidle_r)) {
        level.vehicle_driveidle_r = [];
    }
    if (!isdefined(level.attack_origin_condition_threadd)) {
        level.attack_origin_condition_threadd = [];
    }
    if (!isdefined(level.vehiclefireanim)) {
        level.vehiclefireanim = [];
    }
    if (!isdefined(level.vehiclefireanim_settle)) {
        level.vehiclefireanim_settle = [];
    }
    if (!isdefined(level.vehicle_hasname)) {
        level.vehicle_hasname = [];
    }
    if (!isdefined(level.vehicle_turret_requiresrider)) {
        level.vehicle_turret_requiresrider = [];
    }
    if (!isdefined(level.vehicle_isstationary)) {
        level.vehicle_isstationary = [];
    }
    if (!isdefined(level.vehicle_compassicon)) {
        level.vehicle_compassicon = [];
    }
    if (!isdefined(level.vehicle_unloadgroups)) {
        level.vehicle_unloadgroups = [];
    }
    if (!isdefined(level.vehicle_unloadwhenattacked)) {
        level.vehicle_unloadwhenattacked = [];
    }
    if (!isdefined(level.vehicle_deckdust)) {
        level.vehicle_deckdust = [];
    }
    if (!isdefined(level.vehicle_types)) {
        level.vehicle_types = [];
    }
    if (!isdefined(level.vehicle_compass_types)) {
        level.vehicle_compass_types = [];
    }
    if (!isdefined(level.vehicle_bulletshield)) {
        level.vehicle_bulletshield = [];
    }
    if (!isdefined(level.vehicle_death_badplace)) {
        level.vehicle_death_badplace = [];
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xf2129bcb, Offset: 0x6318
// Size: 0x60
function attacker_is_on_my_team(attacker) {
    if (isdefined(attacker) && isdefined(attacker.team) && isdefined(self.team) && attacker.team == self.team) {
        return 1;
    }
    return 0;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x1ed219ed, Offset: 0x6380
// Size: 0x80
function bullet_shielded(type) {
    if (!isdefined(self.script_bulletshield)) {
        return 0;
    }
    type = tolower(type);
    if (!isdefined(type) || !issubstr(type, "bullet")) {
        return 0;
    }
    if (self.script_bulletshield) {
        return 1;
    }
    return 0;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x65946399, Offset: 0x6408
// Size: 0x46
function friendly_fire_shield() {
    if (isdefined(level.vehicle_bulletshield[self.vehicletype]) && !isdefined(self.script_bulletshield)) {
        self.script_bulletshield = level.vehicle_bulletshield[self.vehicletype];
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x678827c7, Offset: 0x6458
// Size: 0x20e
function _vehicle_bad_place() {
    self endon(#"kill_badplace_forever", #"death", #"delete");
    if (isdefined(level.custombadplacethread)) {
        self thread [[ level.custombadplacethread ]]();
        return;
    }
    hasturret = isdefined(self.turretweapon) && self.turretweapon != level.weaponnone;
    while (true) {
        if (!self.script_badplace) {
            while (!self.script_badplace) {
                wait 0.5;
            }
        }
        speed = self getspeedmph();
        if (speed <= 0) {
            wait 0.5;
            continue;
        }
        if (speed < 5) {
            bp_radius = 200;
        } else if (speed > 5 && speed < 8) {
            bp_radius = 350;
        } else {
            bp_radius = 500;
        }
        if (isdefined(self.badplacemodifier)) {
            bp_radius *= self.badplacemodifier;
        }
        v_turret_angles = self gettagangles("tag_turret");
        if (hasturret && isdefined(v_turret_angles)) {
            bp_direction = anglestoforward(v_turret_angles);
        } else {
            bp_direction = anglestoforward(self.angles);
        }
        wait 0.5 + 0.05;
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x265f1db3, Offset: 0x6670
// Size: 0x11a
function get_vehiclenode_any_dynamic(target) {
    path_start = getvehiclenode(target, "targetname");
    if (!isdefined(path_start)) {
        path_start = getent(target, "targetname");
    } else if (self.vehicleclass === "plane") {
        /#
            println("<dev string:x1a5>" + path_start.targetname);
            println("<dev string:x1c2>" + self.vehicletype);
        #/
        assertmsg("<dev string:x1d0>");
    }
    if (!isdefined(path_start)) {
        path_start = struct::get(target, "targetname");
    }
    return path_start;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x22d2fd2c, Offset: 0x6798
// Size: 0x7c
function resume_path_vehicle() {
    if (isdefined(self.currentnode.target)) {
        node = get_vehiclenode_any_dynamic(self.currentnode.target);
    }
    if (isdefined(node)) {
        self resumespeed(35);
        paths(node);
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xf9ab6cb0, Offset: 0x6820
// Size: 0x102
function land() {
    self setneargoalnotifydist(2);
    self sethoverparams(0, 0, 10);
    self cleargoalyaw();
    self settargetyaw((0, self.angles[1], 0)[1]);
    self set_goal_pos(groundtrace(self.origin + (0, 0, 8), self.origin + (0, 0, -100000), 0, self)[#"position"], 1);
    self waittill(#"goal");
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x58eb1fb6, Offset: 0x6930
// Size: 0x64
function set_goal_pos(origin, bstop) {
    if (self.health <= 0) {
        return;
    }
    if (isdefined(self.originheightoffset)) {
        origin += (0, 0, self.originheightoffset);
    }
    self function_3c8dce03(origin, bstop);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x4f8aa2fc, Offset: 0x69a0
// Size: 0x8a
function liftoff(height = 512) {
    dest = self.origin + (0, 0, height);
    self setneargoalnotifydist(10);
    self set_goal_pos(dest, 1);
    self waittill(#"goal");
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xd259874d, Offset: 0x6a38
// Size: 0xca
function wait_till_stable() {
    timer = gettime() + 400;
    while (isdefined(self)) {
        if (self.angles[0] > 12 || self.angles[0] < -1 * 12) {
            timer = gettime() + 400;
        }
        if (self.angles[2] > 12 || self.angles[2] < -1 * 12) {
            timer = gettime() + 400;
        }
        if (gettime() > timer) {
            break;
        }
        waitframe(1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x760dc711, Offset: 0x6b10
// Size: 0xe4
function unload_node(node) {
    if (isdefined(self.custom_unload_function)) {
        [[ self.custom_unload_function ]]();
        return;
    }
    pause_path();
    if (self.vehicleclass === "plane") {
        wait_till_stable();
    } else if (self.vehicleclass === "helicopter") {
        self sethoverparams(0, 0, 10);
        wait_till_stable();
    }
    if (node is_unload_node()) {
        unload(node.script_unload);
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x2ec83a39, Offset: 0x6c00
// Size: 0x22
function is_unload_node() {
    return isdefined(self.script_unload) && self.script_unload != "none";
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x57a0604a, Offset: 0x6c30
// Size: 0x23a
function unload_node_helicopter(node) {
    if (isdefined(self.custom_unload_function)) {
        self thread [[ self.custom_unload_function ]]();
    }
    self sethoverparams(0, 0, 10);
    goal = self.nextnode.origin;
    start = self.nextnode.origin;
    end = start - (0, 0, 10000);
    trace = bullettrace(start, end, 0, undefined);
    if (trace[#"fraction"] <= 1) {
        goal = (trace[#"position"][0], trace[#"position"][1], trace[#"position"][2] + self.fastropeoffset);
    }
    drop_offset_tag = "tag_fastrope_ri";
    if (isdefined(self.drop_offset_tag)) {
        drop_offset_tag = self.drop_offset_tag;
    }
    drop_offset = self gettagorigin("tag_origin") - self gettagorigin(drop_offset_tag);
    goal += (drop_offset[0], drop_offset[1], 0);
    self function_3c8dce03(goal, 1);
    self waittill(#"goal");
    self notify(#"unload", {#who:self.nextnode.script_unload});
    self waittill(#"unloaded");
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x99ae7e5a, Offset: 0x6e78
// Size: 0xe4
function detach_path() {
    self.attachedpath = undefined;
    self notify(#"newpath");
    if (isvehicle(self)) {
        speed = self getgoalspeedmph();
        if (speed == 0) {
            self setspeed(0.01);
        }
        self setgoalyaw((0, self.angles[1], 0)[1]);
        self function_3c8dce03(self.origin + (0, 0, 4), 1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x3c28c994, Offset: 0x6f68
// Size: 0x1d0
function simple_spawn(name_or_spawners, b_supress_assert = 0) {
    a_spawners = [];
    if (isstring(name_or_spawners)) {
        a_spawners = getvehiclespawnerarray(name_or_spawners, "targetname");
        assert(a_spawners.size || b_supress_assert, "<dev string:x203>" + name_or_spawners + "<dev string:x220>");
    } else {
        if (!isdefined(name_or_spawners)) {
            name_or_spawners = [];
        } else if (!isarray(name_or_spawners)) {
            name_or_spawners = array(name_or_spawners);
        }
        a_spawners = name_or_spawners;
    }
    a_vehicles = [];
    foreach (sp in a_spawners) {
        vh = _vehicle_spawn(sp);
        if (!isdefined(a_vehicles)) {
            a_vehicles = [];
        } else if (!isarray(a_vehicles)) {
            a_vehicles = array(a_vehicles);
        }
        a_vehicles[a_vehicles.size] = vh;
    }
    return a_vehicles;
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x53581999, Offset: 0x7140
// Size: 0xaa
function simple_spawn_single(name, b_supress_assert = 0) {
    vehicle_array = simple_spawn(name, b_supress_assert);
    assert(b_supress_assert || vehicle_array.size == 1, "<dev string:x228>" + name + "<dev string:x252>" + vehicle_array.size + "<dev string:x264>");
    if (vehicle_array.size > 0) {
        return vehicle_array[0];
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xc81ccbe8, Offset: 0x71f8
// Size: 0x94
function simple_spawn_single_and_drive(name) {
    vehiclearray = simple_spawn(name);
    assert(vehiclearray.size == 1, "<dev string:x228>" + name + "<dev string:x252>" + vehiclearray.size + "<dev string:x264>");
    vehiclearray[0] thread go_path();
    return vehiclearray[0];
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xd987cf2a, Offset: 0x7298
// Size: 0x72
function simple_spawn_and_drive(name) {
    vehiclearray = simple_spawn(name);
    for (i = 0; i < vehiclearray.size; i++) {
        vehiclearray[i] thread go_path();
    }
    return vehiclearray;
}

// Namespace vehicle/vehicle_shared
// Params 6, eflags: 0x0
// Checksum 0xfd8d31b9, Offset: 0x7318
// Size: 0xba
function spawn(modelname, targetname, vehicletype, origin, angles, destructibledef) {
    assert(isdefined(targetname));
    assert(isdefined(vehicletype));
    assert(isdefined(origin));
    assert(isdefined(angles));
    return spawnvehicle(vehicletype, origin, angles, targetname, destructibledef);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xfb0826ca, Offset: 0x73e0
// Size: 0x1d4
function impact_fx(fxname, surfacetypes) {
    if (isdefined(fxname)) {
        body = self gettagorigin("tag_body");
        if (!isdefined(body)) {
            body = self.origin + (0, 0, 10);
        }
        trace = bullettrace(body, body - (0, 0, 2 * self.radius), 0, self);
        if (trace[#"fraction"] < 1 && !isdefined(trace[#"entity"]) && (!isdefined(surfacetypes) || array::contains(surfacetypes, trace[#"surfacetype"]))) {
            pos = 0.5 * (self.origin + trace[#"position"]);
            up = 0.5 * (trace[#"normal"] + anglestoup(self.angles));
            forward = anglestoforward(self.angles);
            playfx(fxname, pos, up, forward);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x840d9269, Offset: 0x75c0
// Size: 0xf8
function maingun_fx() {
    if (!isdefined(level.vehicle_deckdust[self.model])) {
        return;
    }
    self endon(#"death");
    while (true) {
        self waittill(#"weapon_fired");
        playfxontag(level.vehicle_deckdust[self.model], self, "tag_engine_exhaust");
        barrel_origin = self gettagorigin("tag_flash");
        ground = physicstrace(barrel_origin, barrel_origin + (0, 0, -128));
        physicsexplosionsphere(ground, 192, 100, 1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x82d40458, Offset: 0x76c0
// Size: 0xac
function lights_on(team) {
    if (isdefined(team)) {
        if (team == #"allies") {
            self clientfield::set("toggle_lights", 2);
        } else if (team == #"axis") {
            self clientfield::set("toggle_lights", 3);
        }
        return;
    }
    self clientfield::set("toggle_lights", 0);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x2ee52382, Offset: 0x7778
// Size: 0x24
function lights_off() {
    self clientfield::set("toggle_lights", 1);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x20b83959, Offset: 0x77a8
// Size: 0x54
function toggle_lights_group(groupid, on) {
    bit = 1;
    if (!on) {
        bit = 0;
    }
    self clientfield::set("toggle_lights_group" + groupid, bit);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xddfa5c27, Offset: 0x7808
// Size: 0x54
function toggle_ambient_anim_group(groupid, on) {
    bit = 1;
    if (!on) {
        bit = 0;
    }
    self clientfield::set("toggle_ambient_anim_group" + groupid, bit);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x9aa13670, Offset: 0x7868
// Size: 0x64
function do_death_fx() {
    deathfxtype = self.died_by_emp === 1 ? 2 : 1;
    self clientfield::set("deathfx", deathfxtype);
    self stopsounds();
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x5f21832a, Offset: 0x78d8
// Size: 0x2c
function toggle_emp_fx(on) {
    self clientfield::set("toggle_emp_fx", on);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xaa71ef49, Offset: 0x7910
// Size: 0x2c
function toggle_burn_fx(on) {
    self clientfield::set("toggle_burn_fx", on);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x7b345259, Offset: 0x7948
// Size: 0x6c
function do_death_dynents(special_status = 1) {
    assert(special_status >= 0 && special_status <= 3);
    self clientfield::set("spawn_death_dynents", special_status);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xfb1aa787, Offset: 0x79c0
// Size: 0xae
function do_gib_dynents() {
    self clientfield::set("spawn_gib_dynents", 1);
    numdynents = 2;
    for (i = 0; i < numdynents; i++) {
        hidetag = self.settings.("servo_gib_tag" + i);
        if (isdefined(hidetag)) {
            self hidepart(hidetag, "", 1);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x71448c17, Offset: 0x7a78
// Size: 0x2c
function set_alert_fx_level(alert_level) {
    self clientfield::set("alert_level", alert_level);
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0xb698ec0f, Offset: 0x7ab0
// Size: 0x37a
function should_update_damage_fx_level(currenthealth, damage, maxhealth) {
    settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    if (!isdefined(settings)) {
        return 0;
    }
    currentratio = math::clamp(float(currenthealth) / float(maxhealth), 0, 1);
    afterdamageratio = math::clamp(float(currenthealth - damage) / float(maxhealth), 0, 1);
    currentlevel = undefined;
    afterdamagelevel = undefined;
    switch (isdefined(settings.damagestate_numstates) ? settings.damagestate_numstates : 0) {
    case 6:
        if (settings.damagestate_lv6_ratio >= afterdamageratio) {
            afterdamagelevel = 6;
            currentlevel = 6;
            if (settings.damagestate_lv6_ratio < currentratio) {
                currentlevel = 5;
            }
            break;
        }
    case 5:
        if (settings.damagestate_lv5_ratio >= afterdamageratio) {
            afterdamagelevel = 5;
            currentlevel = 5;
            if (settings.damagestate_lv5_ratio < currentratio) {
                currentlevel = 4;
            }
            break;
        }
    case 4:
        if (settings.damagestate_lv4_ratio >= afterdamageratio) {
            afterdamagelevel = 4;
            currentlevel = 4;
            if (settings.damagestate_lv4_ratio < currentratio) {
                currentlevel = 3;
            }
            break;
        }
    case 3:
        if (settings.damagestate_lv3_ratio >= afterdamageratio) {
            afterdamagelevel = 3;
            currentlevel = 3;
            if (settings.damagestate_lv3_ratio < currentratio) {
                currentlevel = 2;
            }
            break;
        }
    case 2:
        if (settings.damagestate_lv2_ratio >= afterdamageratio) {
            afterdamagelevel = 2;
            currentlevel = 2;
            if (settings.damagestate_lv2_ratio < currentratio) {
                currentlevel = 1;
            }
            break;
        }
    case 1:
        if (settings.damagestate_lv1_ratio >= afterdamageratio) {
            afterdamagelevel = 1;
            currentlevel = 1;
            if (settings.damagestate_lv1_ratio < currentratio) {
                currentlevel = 0;
            }
            break;
        }
    default:
        break;
    }
    if (!isdefined(currentlevel) || !isdefined(afterdamagelevel)) {
        return 0;
    }
    if (currentlevel != afterdamagelevel) {
        return afterdamagelevel;
    }
    return 0;
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0xcaf711e7, Offset: 0x7e38
// Size: 0x6c
function update_damage_fx_level(currenthealth, damage, maxhealth) {
    newdamagelevel = should_update_damage_fx_level(currenthealth, damage, maxhealth);
    if (newdamagelevel > 0) {
        self set_damage_fx_level(newdamagelevel);
        return true;
    }
    return false;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xaac25ee9, Offset: 0x7eb0
// Size: 0x2c
function set_damage_fx_level(damage_level) {
    self clientfield::set("damage_level", damage_level);
}

// Namespace vehicle/vehicle_shared
// Params 4, eflags: 0x0
// Checksum 0xb7309c2b, Offset: 0x7ee8
// Size: 0xb2
function build_drive(forward, reverse, normalspeed = 10, rate) {
    level.vehicle_driveidle[self.model] = forward;
    if (isdefined(reverse)) {
        level.vehicle_driveidle_r[self.model] = reverse;
    }
    level.vehicle_driveidle_normal_speed[self.model] = normalspeed;
    if (isdefined(rate)) {
        level.vehicle_driveidle_animrate[self.model] = rate;
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x84746a1e, Offset: 0x7fa8
// Size: 0x94
function function_cd841da4(vehicle) {
    target = get_target(vehicle);
    if (!isdefined(target)) {
        vehicle setgoal(vehicle.origin, 0, vehicle.goalradius, vehicle.goalheight);
        return;
    }
    vehicle setgoal(target.origin, 1);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x3d61e197, Offset: 0x8048
// Size: 0xaa
function get_target(vehicle) {
    target = undefined;
    if (isdefined(vehicle.target)) {
        target = getvehiclenode(vehicle.target, "targetname");
        if (!isdefined(target)) {
            target = get_from_entity(vehicle.target);
            if (!isdefined(target)) {
                target = get_from_spawnstruct(vehicle.target);
            }
        }
    }
    return target;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xaed28e4b, Offset: 0x8100
// Size: 0x2a
function get_from_spawnstruct(target) {
    return struct::get(target, "targetname");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x323780d9, Offset: 0x8138
// Size: 0x2a
function get_from_entity(target) {
    return getent(target, "targetname");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x7affb71b, Offset: 0x8170
// Size: 0x2a
function get_from_spawnstruct_target(target) {
    return struct::get(target, "target");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x7beee14d, Offset: 0x81a8
// Size: 0x2a
function get_from_entity_target(target) {
    return getent(target, "target");
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xe613875c, Offset: 0x81e0
// Size: 0xc
function is_destructible() {
    return isdefined(self.destructible_type);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xd4dec4e6, Offset: 0x81f8
// Size: 0x2c4
function attack_group_think() {
    self endon(#"death", #"switch group", #"killed all targets");
    if (isdefined(self.script_vehicleattackgroupwait)) {
        wait self.script_vehicleattackgroupwait;
    }
    for (;;) {
        group = getentarray("script_vehicle", "classname");
        valid_targets = [];
        for (i = 0; i < group.size; i++) {
            if (!isdefined(group[i].script_vehiclespawngroup)) {
                continue;
            }
            if (group[i].script_vehiclespawngroup == self.script_vehicleattackgroup) {
                if (group[i].team != self.team) {
                    if (!isdefined(valid_targets)) {
                        valid_targets = [];
                    } else if (!isarray(valid_targets)) {
                        valid_targets = array(valid_targets);
                    }
                    valid_targets[valid_targets.size] = group[i];
                }
            }
        }
        if (valid_targets.size == 0) {
            wait 0.5;
            continue;
        }
        for (;;) {
            current_target = undefined;
            if (valid_targets.size != 0) {
                current_target = self get_nearest_target(valid_targets);
            } else {
                self notify(#"killed all targets");
            }
            if (current_target.health <= 0) {
                arrayremovevalue(valid_targets, current_target);
                continue;
            }
            self turretsettarget(0, current_target, (0, 0, 50));
            if (isdefined(self.fire_delay_min) && isdefined(self.fire_delay_max)) {
                if (self.fire_delay_max < self.fire_delay_min) {
                    self.fire_delay_max = self.fire_delay_min;
                }
                wait randomintrange(self.fire_delay_min, self.fire_delay_max);
            } else {
                wait randomintrange(4, 6);
            }
            self fireweapon();
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xd215ca9c, Offset: 0x84c8
// Size: 0xbe
function get_nearest_target(valid_targets) {
    nearest_distsq = 99999999;
    nearest = undefined;
    for (i = 0; i < valid_targets.size; i++) {
        if (!isdefined(valid_targets[i])) {
            continue;
        }
        current_distsq = distancesquared(self.origin, valid_targets[i].origin);
        if (current_distsq < nearest_distsq) {
            nearest_distsq = current_distsq;
            nearest = valid_targets[i];
        }
    }
    return nearest;
}

/#

    // Namespace vehicle/vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2a0a1b11, Offset: 0x8590
    // Size: 0xd6
    function debug_vehicle() {
        self endon(#"death");
        if (getdvarstring(#"debug_vehicle_health") == "<dev string:x1a4>") {
            setdvar(#"debug_vehicle_health", 0);
        }
        while (true) {
            if (getdvarint(#"debug_vehicle_health", 0) > 0) {
                print3d(self.origin, "<dev string:x27c>" + self.health, (1, 1, 1), 1, 3);
            }
            waitframe(1);
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3e8da828, Offset: 0x8670
    // Size: 0x15a
    function debug_vehicle_paths() {
        self endon(#"death", #"newpath", #"endpath", #"reached_dynamic_path_end");
        for (nextnode = self.currentnode; true; nextnode = self.nextnode) {
            if (getdvarint(#"debug_vehicle_paths", 0) > 0) {
                recordline(self.origin, self.currentnode.origin, (1, 0, 0), "<dev string:x285>", self);
                recordline(self.origin, nextnode.origin, (0, 1, 0), "<dev string:x285>", self);
                recordline(self.currentnode.origin, nextnode.origin, (1, 1, 1), "<dev string:x285>", self);
            }
            waitframe(1);
            if (isdefined(self.nextnode) && self.nextnode != nextnode) {
            }
        }
    }

#/

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xe7b570d9, Offset: 0x87d8
// Size: 0x3c
function get_dummy() {
    if (isdefined(self.modeldummyon) && self.modeldummyon) {
        emodel = self.modeldummy;
    } else {
        emodel = self;
    }
    return emodel;
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xcc33a4bc, Offset: 0x8820
// Size: 0x8a
function add_main_callback(vehicletype, main) {
    if (!isdefined(level.vehicle_main_callback)) {
        level.vehicle_main_callback = [];
    }
    /#
        if (isdefined(level.vehicle_main_callback[vehicletype])) {
            println("<dev string:x28c>" + vehicletype + "<dev string:x2b9>");
        }
    #/
    level.vehicle_main_callback[vehicletype] = main;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xa330e149, Offset: 0x88b8
// Size: 0x72
function vehicle_get_occupant_team() {
    occupants = self getvehoccupants();
    if (occupants.size != 0) {
        occupant = occupants[0];
        if (isplayer(occupant)) {
            return occupant.team;
        }
    }
    return self.team;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x6c50722e, Offset: 0x8938
// Size: 0x54
function toggle_exhaust_fx(on) {
    if (!on) {
        self clientfield::set("toggle_exhaustfx", 1);
        return;
    }
    self clientfield::set("toggle_exhaustfx", 0);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x794e79ed, Offset: 0x8998
// Size: 0x54
function toggle_tread_fx(on) {
    if (on) {
        self clientfield::set("toggle_treadfx", 1);
        return;
    }
    self clientfield::set("toggle_treadfx", 0);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x53ad6390, Offset: 0x89f8
// Size: 0x54
function toggle_sounds(on) {
    if (!on) {
        self clientfield::set("toggle_sounds", 1);
        return;
    }
    self clientfield::set("toggle_sounds", 0);
}

// Namespace vehicle/event_f6f3291
// Params 1, eflags: 0x40
// Checksum 0xa18e793b, Offset: 0x8a58
// Size: 0x4c
function event_handler[event_f6f3291] function_cb41d074(eventstruct) {
    if (isvehicle(eventstruct.vehicle)) {
        eventstruct.vehicle clientfield::set("toggle_horn_sound", 1);
    }
}

// Namespace vehicle/event_7cc4dc14
// Params 1, eflags: 0x40
// Checksum 0x3152b0ee, Offset: 0x8ab0
// Size: 0x4c
function event_handler[event_7cc4dc14] function_d589926d(eventstruct) {
    if (isvehicle(eventstruct.vehicle)) {
        eventstruct.vehicle clientfield::set("toggle_horn_sound", 0);
    }
}

// Namespace vehicle/vehicle_collision
// Params 1, eflags: 0x40
// Checksum 0x2ba27b40, Offset: 0x8b08
// Size: 0x2c
function event_handler[vehicle_collision] function_39b5c9ab(eventstruct) {
    callback::callback(#"veh_collision", eventstruct);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xb8dcf39, Offset: 0x8b40
// Size: 0x23c
function function_2ef1a84e(params) {
    self endon(#"death");
    self endon(#"exit_vehicle");
    driver = self getseatoccupant(0);
    if (!isplayer(driver)) {
        self toggle_sounds(1);
        return;
    }
    driver endon(#"death");
    driver endon(#"disconnect");
    if (isdefined(self.var_28a090d) && self.var_28a090d != "") {
        var_1c58de0b = soundgetplaybacktime(self.var_28a090d) * 0.001;
        var_1c58de0b -= 0.5;
        if (var_1c58de0b > 0) {
            var_1c58de0b = math::clamp(var_1c58de0b, 0.25, 1.5);
            self takeplayercontrol();
            self playsound(self.var_28a090d);
            wait var_1c58de0b;
            if (!(isdefined(params.var_338ab99d) && params.var_338ab99d)) {
                self returnplayercontrol();
            }
        }
    }
    self toggle_sounds(1);
    if (isdefined(params.var_251fcf3a)) {
        self takeplayercontrol();
        wait params.var_251fcf3a;
        if (!(isdefined(params.var_338ab99d) && params.var_338ab99d)) {
            self returnplayercontrol();
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x3a4c5d31, Offset: 0x8d88
// Size: 0x44
function function_d4ecc8() {
    if (isdefined(self.var_4f06fb8) && self.var_4f06fb8 != "") {
        self playsound(self.var_4f06fb8);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x191a90d7, Offset: 0x8dd8
// Size: 0x72
function is_corpse(veh) {
    if (isdefined(veh)) {
        if (isdefined(veh.isacorpse) && veh.isacorpse) {
            return true;
        } else if (isdefined(veh.classname) && veh.classname == "script_vehicle_corpse") {
            return true;
        }
    }
    return false;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x79ebe6d7, Offset: 0x8e58
// Size: 0x64
function is_on(vehicle) {
    if (!isdefined(self.viewlockedentity)) {
        return false;
    } else if (self.viewlockedentity == vehicle) {
        return true;
    }
    if (!isdefined(self.groundentity)) {
        return false;
    } else if (self.groundentity == vehicle) {
        return true;
    }
    return false;
}

// Namespace vehicle/vehicle_shared
// Params 6, eflags: 0x0
// Checksum 0xbc73d9c5, Offset: 0x8ec8
// Size: 0x64
function add_spawn_function(veh_targetname, spawn_func, param1, param2, param3, param4) {
    add_spawn_function_group(veh_targetname, "targetname", spawn_func, param1, param2, param3, param4);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xc0d56ea8, Offset: 0x8f38
// Size: 0x25c
function add_spawn_function_group(str_value, str_key, spawn_func, param1, param2, param3, param4) {
    func = [];
    func[#"function"] = spawn_func;
    func[#"param1"] = param1;
    func[#"param2"] = param2;
    func[#"param3"] = param3;
    func[#"param4"] = param4;
    if (!isdefined(level.a_str_vehicle_spawn_custom_keys)) {
        level.a_str_vehicle_spawn_custom_keys = [];
    }
    if (!isdefined(level.("a_str_vehicle_spawn_key_" + str_key))) {
        level.("a_str_vehicle_spawn_key_" + str_key) = [];
    }
    a_key_spawn_funcs = level.("a_str_vehicle_spawn_key_" + str_key);
    if (!isdefined(level.a_str_vehicle_spawn_custom_keys)) {
        level.a_str_vehicle_spawn_custom_keys = [];
    } else if (!isarray(level.a_str_vehicle_spawn_custom_keys)) {
        level.a_str_vehicle_spawn_custom_keys = array(level.a_str_vehicle_spawn_custom_keys);
    }
    if (!isinarray(level.a_str_vehicle_spawn_custom_keys, str_key)) {
        level.a_str_vehicle_spawn_custom_keys[level.a_str_vehicle_spawn_custom_keys.size] = str_key;
    }
    if (!isdefined(a_key_spawn_funcs[str_value])) {
        a_key_spawn_funcs[str_value] = [];
    } else if (!isarray(a_key_spawn_funcs[str_value])) {
        a_key_spawn_funcs[str_value] = array(a_key_spawn_funcs[str_value]);
    }
    a_key_spawn_funcs[str_value][a_key_spawn_funcs[str_value].size] = func;
}

// Namespace vehicle/vehicle_shared
// Params 6, eflags: 0x0
// Checksum 0xe4d2ec1a, Offset: 0x91a0
// Size: 0x64
function add_spawn_function_by_type(veh_type, spawn_func, param1, param2, param3, param4) {
    add_spawn_function_group(veh_type, "vehicletype", spawn_func, param1, param2, param3, param4);
}

// Namespace vehicle/vehicle_shared
// Params 6, eflags: 0x0
// Checksum 0x2694ea53, Offset: 0x9210
// Size: 0x180
function add_hijack_function(veh_targetname, spawn_func, param1, param2, param3, param4) {
    func = [];
    func[#"function"] = spawn_func;
    func[#"param1"] = param1;
    func[#"param2"] = param2;
    func[#"param3"] = param3;
    func[#"param4"] = param4;
    if (!isdefined(level.a_vehicle_hijack_targetnames)) {
        level.a_vehicle_hijack_targetnames = [];
    }
    if (!isdefined(level.a_vehicle_hijack_targetnames[veh_targetname])) {
        level.a_vehicle_hijack_targetnames[veh_targetname] = [];
    } else if (!isarray(level.a_vehicle_hijack_targetnames[veh_targetname])) {
        level.a_vehicle_hijack_targetnames[veh_targetname] = array(level.a_vehicle_hijack_targetnames[veh_targetname]);
    }
    level.a_vehicle_hijack_targetnames[veh_targetname][level.a_vehicle_hijack_targetnames[veh_targetname].size] = func;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x4
// Checksum 0xfa92e10d, Offset: 0x9398
// Size: 0x15c
function private _watch_for_hijacked_vehicles() {
    while (true) {
        waitresult = level waittill(#"clonedentity");
        str_targetname = waitresult.clone.targetname;
        waittillframeend();
        if (isdefined(str_targetname) && isdefined(level.a_vehicle_hijack_targetnames) && isdefined(level.a_vehicle_hijack_targetnames[str_targetname])) {
            foreach (func in level.a_vehicle_hijack_targetnames[str_targetname]) {
                util::single_thread(waitresult.clone, func[#"function"], func[#"param1"], func[#"param2"], func[#"param3"], func[#"param4"]);
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x23d3054, Offset: 0x9500
// Size: 0x64
function disconnect_paths(detail_level = 2, move_allowed = 1) {
    self disconnectpaths(detail_level, move_allowed);
    self enableobstacle(0);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x6bd2bc89, Offset: 0x9570
// Size: 0x34
function connect_paths() {
    self connectpaths();
    self enableobstacle(1);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xdff8fd58, Offset: 0x95b0
// Size: 0xe
function init_target_group() {
    self.target_group = [];
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x7484a525, Offset: 0x95c8
// Size: 0x9e
function add_to_target_group(target_ent) {
    assert(isdefined(self.target_group), "<dev string:x2e3>");
    if (!isdefined(self.target_group)) {
        self.target_group = [];
    } else if (!isarray(self.target_group)) {
        self.target_group = array(self.target_group);
    }
    self.target_group[self.target_group.size] = target_ent;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x6d9a2ab6, Offset: 0x9670
// Size: 0x4c
function remove_from_target_group(target_ent) {
    assert(isdefined(self.target_group), "<dev string:x2e3>");
    arrayremovevalue(self.target_group, target_ent);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x8d544792, Offset: 0x96c8
// Size: 0xf6
function monitor_missiles_locked_on_to_me(player, wait_time = 0.1) {
    monitored_entity = self;
    monitored_entity endon(#"death");
    assert(isdefined(monitored_entity.target_group), "<dev string:x2e3>");
    player endon(#"stop_monitor_missile_locked_on_to_me", #"disconnect", #"joined_team");
    while (true) {
        closest_attacker = player get_closest_attacker_with_missile_locked_on_to_me(monitored_entity);
        player setvehiclelockedonbyent(closest_attacker);
        wait wait_time;
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x68a26951, Offset: 0x97c8
// Size: 0x46a
function watch_freeze_on_flash(duration) {
    veh = self;
    if (veh flag::exists("watch_freeze_on_flash")) {
        return;
    }
    veh flag::init("watch_freeze_on_flash", 1);
    if (isdefined(veh.owner)) {
        veh.owner clientfield::set_to_player("static_postfx", 0);
    }
    veh clientfield::set("stun", 0);
    while (true) {
        waitresult = veh waittill(#"damage", #"death");
        if (waitresult._notify == "death") {
            return;
        }
        weapon = waitresult.weapon;
        mod = waitresult.mod;
        owner = veh.owner;
        controlled = isdefined(veh.controlled) && veh.controlled;
        if (!(isdefined(veh.isstunned) && veh.isstunned)) {
            if (weapon.dostun && mod == "MOD_GRENADE_SPLASH") {
                veh.isstunned = 1;
                veh.noshoot = 1;
                veh notify(#"fire_stop");
                veh cancelaimove();
                veh clearentitytarget();
                veh function_9f59031e();
                veh vehclearlookat();
                veh disablegunnerfiring(0, 1);
                angles = veh function_2b49f581(0);
                veh turretsettargetangles(0, angles + (50, 0, 0));
                if (controlled && isdefined(owner)) {
                    owner val::set(#"veh", "freezecontrols", 1);
                    owner clientfield::set_to_player("static_postfx", 1);
                }
                veh clientfield::set("stun", 1);
                waitresult = veh waittilltimeout(duration, #"death");
                if (controlled && isdefined(owner)) {
                    owner clientfield::set_to_player("static_postfx", 0);
                    owner val::reset(#"veh", "freezecontrols");
                }
                if (!isdefined(veh)) {
                    return;
                }
                veh clientfield::set("stun", 0);
                isalive = isalive(veh);
                if (isalive) {
                    veh turretcleartarget(0);
                    veh disablegunnerfiring(0, 0);
                    veh.noshoot = undefined;
                    veh.isstunned = undefined;
                }
                if (waitresult._notify == "death") {
                    return;
                }
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xf0102e33, Offset: 0x9c40
// Size: 0x16
function stop_monitor_missiles_locked_on_to_me() {
    self notify(#"stop_monitor_missile_locked_on_to_me");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xb7886a9c, Offset: 0x9c60
// Size: 0x268
function get_closest_attacker_with_missile_locked_on_to_me(monitored_entity) {
    assert(isdefined(monitored_entity.target_group), "<dev string:x2e3>");
    player = self;
    closest_attacker = undefined;
    closest_attacker_dot = -999;
    view_origin = player getplayercamerapos();
    view_forward = anglestoforward(player getplayerangles());
    remaining_locked_on_flags = 0;
    foreach (target_ent in monitored_entity.target_group) {
        if (isdefined(target_ent) && isdefined(target_ent.locked_on)) {
            remaining_locked_on_flags |= target_ent.locked_on;
        }
    }
    for (i = 0; remaining_locked_on_flags && i < level.players.size; i++) {
        attacker = level.players[i];
        if (isdefined(attacker)) {
            client_flag = 1 << attacker getentitynumber();
            if (client_flag & remaining_locked_on_flags) {
                to_attacker = vectornormalize(attacker.origin - view_origin);
                attacker_dot = vectordot(view_forward, to_attacker);
                if (attacker_dot > closest_attacker_dot) {
                    closest_attacker = attacker;
                    closest_attacker_dot = attacker_dot;
                }
                remaining_locked_on_flags &= ~client_flag;
            }
        }
    }
    return closest_attacker;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x36da1bc3, Offset: 0x9ed0
// Size: 0x40
function set_vehicle_drivable_time_starting_now(duration_ms) {
    end_time_ms = gettime() + duration_ms;
    set_vehicle_drivable_time(duration_ms, end_time_ms);
    return end_time_ms;
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xe1e4f6a0, Offset: 0x9f18
// Size: 0x44
function set_vehicle_drivable_time(duration_ms, end_time_ms) {
    self setvehicledrivableduration(duration_ms);
    self setvehicledrivableendtime(end_time_ms);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x14e51c1e, Offset: 0x9f68
// Size: 0x64
function update_damage_as_occupant(damage_taken, max_health) {
    damage_taken_normalized = math::clamp(damage_taken / max_health, 0, 1);
    self setvehicledamagemeter(damage_taken_normalized);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xead60ee5, Offset: 0x9fd8
// Size: 0x16
function stop_monitor_damage_as_occupant() {
    self notify(#"stop_monitor_damage_as_occupant");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x4aa256e3, Offset: 0x9ff8
// Size: 0x100
function monitor_damage_as_occupant(player) {
    player notify(#"stop_monitor_damage_as_occupant");
    player endon(#"stop_monitor_damage_as_occupant", #"disconnect");
    self endon(#"death");
    if (!isdefined(self.maxhealth)) {
        self.maxhealth = self.healthdefault;
    }
    wait 0.1;
    player update_damage_as_occupant(self.maxhealth - self.health, self.maxhealth);
    while (true) {
        self waittill(#"damage");
        waittillframeend();
        player update_damage_as_occupant(self.maxhealth - self.health, self.maxhealth);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xfeb3f392, Offset: 0xa100
// Size: 0x74
function kill_vehicle(attacker) {
    damageorigin = self.origin + (0, 0, 1);
    self finishvehicleradiusdamage(attacker, attacker, 32000, 32000, 10, 0, "MOD_EXPLOSIVE", level.weaponnone, damageorigin, 400, -1, (0, 0, 1), 0);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xc901e5c1, Offset: 0xa180
// Size: 0x84
function player_is_driver() {
    if (!isalive(self)) {
        return false;
    }
    vehicle = self getvehicleoccupied();
    if (isdefined(vehicle)) {
        seat = vehicle getoccupantseat(self);
        if (isdefined(seat) && seat == 0) {
            return true;
        }
    }
    return false;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x6d9a766b, Offset: 0xa210
// Size: 0x54
function laser_death_watcher() {
    self notify(#"laser_death_thread_stop");
    self endon(#"laser_death_thread_stop");
    self waittill(#"death");
    if (isdefined(self)) {
        self laseroff();
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x78db28a8, Offset: 0xa270
// Size: 0x76
function enable_laser(b_enable, n_index) {
    if (b_enable) {
        self laseron();
        self thread laser_death_watcher();
        return;
    }
    self laseroff();
    self notify(#"laser_death_thread_stop");
}

/#

    // Namespace vehicle/vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0xce93b623, Offset: 0xa2f0
    // Size: 0x7ae
    function vehicle_spawner_tool() {
        allvehicles = getentarray("<dev string:x303>", "<dev string:x312>");
        vehicletypes = [];
        foreach (veh in allvehicles) {
            vehicletypes[veh.vehicletype] = veh.model;
        }
        if (isassetloaded("<dev string:x31c>", "<dev string:x324>")) {
            veh = spawnvehicle("<dev string:x324>", (0, 0, 10000), (0, 0, 0), "<dev string:x334>");
            vehicletypes[veh.vehicletype] = veh.model;
            veh delete();
        }
        if (isassetloaded("<dev string:x31c>", "<dev string:x348>")) {
            veh = spawnvehicle("<dev string:x348>", (0, 0, 10000), (0, 0, 0), "<dev string:x334>");
            vehicletypes[veh.vehicletype] = veh.model;
            veh delete();
        }
        if (isassetloaded("<dev string:x31c>", "<dev string:x34c>")) {
            veh = spawnvehicle("<dev string:x34c>", (0, 0, 10000), (0, 0, 0), "<dev string:x334>");
            vehicletypes[veh.vehicletype] = veh.model;
            veh delete();
        }
        if (isassetloaded("<dev string:x31c>", "<dev string:x359>")) {
            veh = spawnvehicle("<dev string:x359>", (0, 0, 10000), (0, 0, 0), "<dev string:x334>");
            vehicletypes[veh.vehicletype] = veh.model;
            veh delete();
        }
        if (isassetloaded("<dev string:x31c>", "<dev string:x366>")) {
            veh = spawnvehicle("<dev string:x366>", (0, 0, 10000), (0, 0, 0), "<dev string:x334>");
            vehicletypes[veh.vehicletype] = veh.model;
            veh delete();
        }
        types = getarraykeys(vehicletypes);
        if (types.size == 0) {
            return;
        }
        type_index = 0;
        while (true) {
            if (getdvarint(#"debug_vehicle_spawn", 0) > 0) {
                player = getplayers()[0];
                dynamic_spawn_hud = newdebughudelem(player);
                dynamic_spawn_hud.alignx = "<dev string:x376>";
                dynamic_spawn_hud.x = 20;
                dynamic_spawn_hud.y = 395;
                dynamic_spawn_hud.fontscale = 1;
                dynamic_spawn_dummy_model = sys::spawn("<dev string:x37b>", (0, 0, 0));
                while (getdvarint(#"debug_vehicle_spawn", 0) > 0) {
                    origin = player.origin + anglestoforward(player getplayerangles()) * 270;
                    origin += (0, 0, 40);
                    if (player usebuttonpressed()) {
                        dynamic_spawn_dummy_model hide();
                        vehicle = spawnvehicle(function_15979fa9(types[type_index]), origin, player.angles, "<dev string:x334>");
                        vehicle makevehicleusable();
                        if (getdvarint(#"debug_vehicle_spawn", 0) == 1) {
                            setdvar(#"debug_vehicle_spawn", 0);
                            continue;
                        }
                        wait 0.3;
                    }
                    if (player buttonpressed("<dev string:x388>")) {
                        dynamic_spawn_dummy_model hide();
                        type_index++;
                        if (type_index >= types.size) {
                            type_index = 0;
                        }
                        wait 0.3;
                    }
                    if (player buttonpressed("<dev string:x393>")) {
                        dynamic_spawn_dummy_model hide();
                        type_index--;
                        if (type_index < 0) {
                            type_index = types.size - 1;
                        }
                        wait 0.3;
                    }
                    type = types[type_index];
                    dynamic_spawn_hud settext("<dev string:x39d>" + function_15979fa9(type));
                    dynamic_spawn_dummy_model setmodel(vehicletypes[type]);
                    dynamic_spawn_dummy_model show();
                    dynamic_spawn_dummy_model notsolid();
                    dynamic_spawn_dummy_model.origin = origin;
                    dynamic_spawn_dummy_model.angles = player.angles;
                    waitframe(1);
                }
                dynamic_spawn_hud destroy();
                dynamic_spawn_dummy_model delete();
            }
            wait 2;
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x71b6b773, Offset: 0xaaa8
    // Size: 0x8e
    function spline_debug() {
        level flag::init("<dev string:x3b7>");
        level thread _spline_debug();
        while (true) {
            level flag::set_val("<dev string:x3b7>", getdvarint(#"g_vehicledrawsplines", 0));
            waitframe(1);
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1a18ea50, Offset: 0xab40
    // Size: 0xb2
    function _spline_debug() {
        while (true) {
            level flag::wait_till("<dev string:x3b7>");
            foreach (nd in getallvehiclenodes()) {
                nd show_node_debug_info();
            }
            waitframe(1);
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc9896e62, Offset: 0xac00
    // Size: 0xbc
    function show_node_debug_info() {
        self.n_debug_display_count = 0;
        if (is_unload_node()) {
            print_debug_info("<dev string:x3cd>" + self.script_unload + "<dev string:x3d7>");
        }
        if (isdefined(self.script_notify)) {
            print_debug_info("<dev string:x3d9>" + self.script_notify + "<dev string:x3d7>");
        }
        if (isdefined(self.script_delete) && self.script_delete) {
            print_debug_info("<dev string:x3e3>");
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe2a46e5e, Offset: 0xacc8
    // Size: 0x5c
    function print_debug_info(str_info) {
        self.n_debug_display_count++;
        print3d(self.origin - (0, 0, self.n_debug_display_count * 20), str_info, (0, 0, 1), 1, 1);
    }

#/

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x9bcfbbf4, Offset: 0xad30
// Size: 0xfa
function function_2b040030(vh_target, n_seat) {
    if (isbot(self) && isdefined(vh_target.var_6259e41c) && vh_target.var_6259e41c) {
        return false;
    }
    if (isdefined(vh_target) && isalive(self) && !self laststand::player_is_in_laststand() && isdefined(vh_target function_504b3ba8(n_seat)) && vh_target function_504b3ba8(n_seat) && !vh_target isvehicleseatoccupied(n_seat)) {
        return true;
    }
    return false;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x4
// Checksum 0x482fd112, Offset: 0xae38
// Size: 0x114
function private function_d6ede604() {
    e_player = self.owner;
    if (!isdefined(e_player)) {
        self thread util::auto_delete();
        return;
    }
    self endon(#"death", #"enter_vehicle");
    e_player endon(#"disconnect");
    level endon(#"game_ended");
    for (b_do_delete = 0; !b_do_delete; b_do_delete = 1) {
        wait 5;
        dist = distance2d(self.origin, e_player.origin);
        if (isalive(e_player) && dist > 3000) {
        }
    }
    self thread util::auto_delete();
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x23a62386, Offset: 0xaf58
// Size: 0x5ec
function function_9b0d5c3d(e_player, b_skip_scene, b_enter = 1) {
    var_3f1c2b5a = "";
    if (!b_enter) {
        s_info = self function_4955848(e_player);
    }
    if (!b_skip_scene) {
        if (b_enter) {
            debug_scene = getdvarstring(#"hash_56b164d8150f9e8d", "");
            if (debug_scene != "") {
                str_scene = debug_scene;
            } else if (isdefined(self.script_vh_entrance)) {
                str_scene = self.script_vh_entrance;
            } else if (isdefined(self.settings) && isdefined(self.settings.var_87f96ecd)) {
                str_scene = self.settings.var_87f96ecd;
                if (!isdefined(e_player.companion)) {
                    var_98442c5 = str_scene;
                    var_98442c5 += "_solo";
                    scene = getscriptbundle(var_98442c5);
                    if (isdefined(scene)) {
                        str_scene = var_98442c5;
                    }
                }
                var_c6584028 = vectordot(anglestoright(self.angles), vectornormalize(self.origin - e_player.origin));
                if (var_c6584028 > 0) {
                    var_37c45ea8 = "left";
                } else {
                    var_37c45ea8 = "right";
                }
                str_shot = var_37c45ea8 + var_3f1c2b5a;
            }
        } else {
            debug_scene = getdvarstring(#"hash_56b164d8150f9e8d", "");
            if (debug_scene != "") {
                str_scene = debug_scene;
            } else if (isdefined(self.var_5d4007c)) {
                str_scene = self.var_5d4007c;
            } else if (isdefined(self.settings) && isdefined(self.settings.var_6e6ab31f)) {
                str_scene = self.settings.var_6e6ab31f;
                if (!isdefined(e_player.companion)) {
                    var_98442c5 = str_scene;
                    var_98442c5 += "_solo";
                    scene = getscriptbundle(var_98442c5);
                    if (isdefined(scene)) {
                        str_scene = var_98442c5;
                    }
                }
                var_37c45ea8 = s_info.var_37c45ea8;
                str_shot = var_37c45ea8 + var_3f1c2b5a;
            }
        }
        if (isdefined(str_scene) && str_scene != "") {
            if (isdefined(e_player.companion) && e_player.companion isplayinganimscripted()) {
                e_player.companion stopanimscripted();
                util::wait_network_frame();
            }
            self notify(#"hash_376d57a458a131df");
            a_ents = array(e_player);
            if (isalive(e_player.companion) && scene::function_a1d3b978(str_scene) > 0) {
                if (!isdefined(a_ents)) {
                    a_ents = [];
                } else if (!isarray(a_ents)) {
                    a_ents = array(a_ents);
                }
                a_ents[a_ents.size] = e_player.companion;
            }
            if (scene::get_vehicle_count(str_scene) > 0) {
                if (!isdefined(a_ents)) {
                    a_ents = [];
                } else if (!isarray(a_ents)) {
                    a_ents = array(a_ents);
                }
                a_ents[a_ents.size] = self;
            }
            if (isdefined(str_shot)) {
                self thread scene::play(str_scene, str_shot, a_ents);
            } else {
                self thread scene::play(str_scene, a_ents);
            }
            e_player flagsys::wait_till_clear("scene");
            self notify(#"vehicle_scene_done");
        }
        if (!b_enter) {
            if (isdefined(s_info.v_teleport_pos)) {
                e_player setorigin(s_info.v_teleport_pos);
            }
            if (isdefined(s_info.v_teleport_angles)) {
                e_player setplayerangles(s_info.v_teleport_angles);
            }
            if (isdefined(s_info.var_47c59547)) {
                e_player.companion setorigin(s_info.var_47c59547);
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x4
// Checksum 0x48572f65, Offset: 0xb550
// Size: 0x41e
function private function_4955848(e_player) {
    s_info = {};
    v_movement = e_player getnormalizedmovement();
    if (self.archetype === "fav") {
        var_4619dba9 = self.origin + anglestoright(self.angles) * 115;
        var_b39b00c8 = self.origin + anglestoright(self.angles) * -125;
        var_a95154da = self.origin + anglestoforward(self.angles) * -110;
        if (v_movement[1] < 0 && ispointonnavmesh(var_b39b00c8) && bullettracepassed(self.origin + (0, 0, 75), var_b39b00c8 + (0, 0, 5), 1, self)) {
            s_info.var_37c45ea8 = "left";
        } else if (ispointonnavmesh(var_4619dba9) && bullettracepassed(self.origin + (0, 0, 75), var_4619dba9 + (0, 0, 5), 1, self)) {
            s_info.var_37c45ea8 = "right";
        } else {
            s_info.var_37c45ea8 = "left";
            s_info.v_teleport_pos = getclosestpointonnavmesh(self.origin, 256, 16);
        }
        if (!ispointonnavmesh(var_a95154da) || !bullettracepassed(self.origin + (0, 0, 75), var_a95154da + (0, 0, 75), 1, self)) {
            s_info.var_47c59547 = getclosestpointonnavmesh(self.origin, 256, 16);
        }
    } else if (self.archetype === "quad") {
        var_4619dba9 = self.origin + anglestoright(self.angles) * 85;
        var_b39b00c8 = self.origin + anglestoright(self.angles) * -85;
        if (v_movement[1] < 0 && ispointonnavmesh(var_b39b00c8)) {
            s_info.var_37c45ea8 = "left";
            s_info.v_teleport_pos = getclosestpointonnavmesh(var_b39b00c8, 256, 16);
        } else {
            s_info.var_37c45ea8 = "right";
            s_info.v_teleport_pos = getclosestpointonnavmesh(var_4619dba9, 256, 16);
        }
        s_info.v_teleport_angles = (0, self.angles[1], 0);
    } else if (v_movement[1] < 0) {
        s_info.var_37c45ea8 = "left";
    } else {
        s_info.var_37c45ea8 = "right";
    }
    return s_info;
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x1d1e31f8, Offset: 0xb978
// Size: 0x196
function function_d98130c1(var_e2a69154, b_one_shot = 0) {
    level endon(#"game_ended");
    a_vehicles = self;
    if (!isarray(a_vehicles)) {
        if (!isdefined(a_vehicles)) {
            a_vehicles = [];
        } else if (!isarray(a_vehicles)) {
            a_vehicles = array(a_vehicles);
        }
    }
    foreach (vh in a_vehicles) {
        vh.script_vh_entrance = var_e2a69154;
    }
    if (b_one_shot) {
        array::wait_till(a_vehicles, "vehicle_scene_done");
        foreach (vh in a_vehicles) {
            if (isdefined(vh)) {
                vh.script_vh_entrance = undefined;
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x155e9594, Offset: 0xbb18
// Size: 0x196
function function_5809569f(var_d31c2cca, b_one_shot = 0) {
    level endon(#"game_ended");
    a_vehicles = self;
    if (!isarray(a_vehicles)) {
        if (!isdefined(a_vehicles)) {
            a_vehicles = [];
        } else if (!isarray(a_vehicles)) {
            a_vehicles = array(a_vehicles);
        }
    }
    foreach (vh in a_vehicles) {
        vh.var_5d4007c = var_d31c2cca;
    }
    if (b_one_shot) {
        array::wait_any(a_vehicles, "vehicle_scene_done");
        foreach (vh in a_vehicles) {
            if (isdefined(vh)) {
                vh.var_5d4007c = undefined;
            }
        }
    }
}

// Namespace vehicle/enter_vehicle
// Params 1, eflags: 0x40
// Checksum 0x5ba77a59, Offset: 0xbcb8
// Size: 0x1d4
function event_handler[enter_vehicle] function_2e195381(eventstruct) {
    if (isvehicle(eventstruct.vehicle)) {
        if (!isdefined(eventstruct.seat_index)) {
            return;
        }
        var_e17486ad = eventstruct.vehicle function_45829573(eventstruct.seat_index);
        if (!isdefined(var_e17486ad)) {
            return;
        }
        var_616fbe7c = getscriptbundle(var_e17486ad);
        if (isdefined(var_616fbe7c)) {
            rightvecdot = vectordot(anglestoright(eventstruct.vehicle.angles), vectornormalize(self.origin - eventstruct.vehicle.origin));
            if (rightvecdot > 0) {
                animation = var_616fbe7c.var_9b266d62;
            } else {
                animation = var_616fbe7c.var_31672def;
            }
            if (isdefined(animation)) {
                self animscripted("vehicle_enter_anim", eventstruct.vehicle function_228687a2(eventstruct.seat_index), eventstruct.vehicle function_d813fea4(eventstruct.seat_index), animation, "normal", undefined, 1, undefined, undefined, undefined, 1);
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0xc0b2aa1a, Offset: 0xbe98
// Size: 0xd0
function function_e1608b0e(v_origin, v_angles, str_vehicle = undefined) {
    if (self isinvehicle()) {
        return self getvehicleoccupied();
    }
    assert(isdefined(str_vehicle), "<dev string:x3ea>");
    var_9f7fd4a1 = spawnvehicle(str_vehicle, v_origin, v_angles, "player_spawned_vehicle");
    var_9f7fd4a1 usevehicle(self, 0);
    return var_9f7fd4a1;
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0xcdd61542, Offset: 0xbf70
// Size: 0x84
function function_9fc7b8af(vehicle, bot, n_seat) {
    if (isbot(bot) && n_seat == 0) {
        if (vehicle vehicle_ai::has_state("off")) {
            vehicle vehicle_ai::set_state("off");
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xda174197, Offset: 0xc000
// Size: 0xf4
function function_8c662be3(x, k) {
    if (x < -1) {
        x = -1;
    } else if (x > 1) {
        x = 1;
    }
    if (k < -1) {
        k = -1;
    } else if (k > 1) {
        k = 1;
    }
    numerator = x - x * k;
    denominator = k - abs(x) * 2 * k + 1;
    result = numerator / denominator;
    return result;
}

// Namespace vehicle/vehicle_shared
// Params 5, eflags: 0x0
// Checksum 0xb80d673, Offset: 0xc100
// Size: 0x306
function update_flare_ability(player, var_de164e3f, active_time = 5, cooldown_time = 10, flare_tag = undefined) {
    var_1cb45442 = "update_flare_ability";
    self notify(var_1cb45442);
    self endon(#"death", var_1cb45442);
    var_7adf5558 = active_time;
    flarecooldown = cooldown_time;
    if (!self flag::exists("flares_available")) {
        self flag::init("flares_available", 1);
    } else {
        self flag::set("flares_available");
    }
    player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_de164e3f + ".cooldown", 1);
    while (isdefined(player.vh_vehicle) && player function_49ce508f()) {
        waitframe(1);
    }
    self.var_e5e57665 = 0;
    while (isdefined(player) && (isdefined(player.vh_vehicle) || self.var_e5e57665)) {
        assert(!(isdefined(self.var_e5e57665) && self.var_e5e57665));
        if (player function_49ce508f()) {
            self flag::clear("flares_available");
            self.var_e5e57665 = 1;
            player playsoundtoplayer(#"hash_35af2f72517d10ab", player);
            self fire_flares(player, flare_tag, active_time);
            player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_de164e3f + ".cooldown", 0);
            wait var_7adf5558;
            self.var_e5e57665 = 0;
            level thread function_8b8653fd(flarecooldown, player, var_de164e3f);
            player playsoundtoplayer(#"hash_62742dd7b6e513e", player);
            self flag::set("flares_available");
        }
        waitframe(1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x39dc0bfc, Offset: 0xc410
// Size: 0x140
function function_f3072dd5(player, var_de164e3f) {
    self endon(#"death");
    player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_de164e3f + ".cooldown", 0);
    while (isdefined(player) && isdefined(player.vh_vehicle)) {
        var_d36056f9 = 0;
        if (player function_bbaf1d59()) {
            var_d36056f9 = player function_97d775fa();
        } else {
            var_e8f400f9 = player getvehicleboosttime();
            boosttimeleft = player getvehicleboosttimeleft();
            if (var_e8f400f9 > 0) {
                var_d36056f9 = boosttimeleft / var_e8f400f9;
            }
        }
        player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_de164e3f + ".cooldown", var_d36056f9);
        wait 0.05;
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x4
// Checksum 0xd20300c9, Offset: 0xc558
// Size: 0x16a
function private function_7e8a6c70(flare_lifetime = undefined) {
    if (!isdefined(flare_lifetime)) {
        flare_lifetime = 3;
    }
    lifetimes = [];
    for (var_cd066e60 = 0; var_cd066e60 < 4; var_cd066e60++) {
        if (!isdefined(lifetimes)) {
            lifetimes = [];
        } else if (!isarray(lifetimes)) {
            lifetimes = array(lifetimes);
        }
        lifetimes[lifetimes.size] = flare_lifetime - var_cd066e60 * 0.3;
    }
    lifetimes = array::randomize(lifetimes);
    foreach (key, value in lifetimes) {
        if (value == flare_lifetime) {
            lifetimes[key] = lifetimes[key] + key * 0.15;
        }
    }
    return lifetimes;
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0xc01e8bc1, Offset: 0xc6d0
// Size: 0x266
function fire_flares(player, flare_tag = undefined, flare_lifetime = undefined) {
    var_45e25036 = function_7e8a6c70(flare_lifetime);
    for (var_a81616a9 = 0; var_a81616a9 < 4; var_a81616a9++) {
        model = "tag_origin";
        if (!isdefined(flare_tag)) {
            self.var_ad961c2a = !(isdefined(self.var_ad961c2a) && self.var_ad961c2a);
            start_tag = self.var_ad961c2a ? "tag_fx_flare_left" : "tag_fx_flare_right";
            start_origin = self gettagorigin(start_tag);
        } else {
            start_origin = self gettagorigin(flare_tag);
        }
        if (!isdefined(start_origin)) {
            start_origin = self gettagorigin("tag_origin") + (0, 0, 128);
        }
        if (isdefined(flare_tag)) {
            var_b3a717ae = self gettagangles(flare_tag);
        }
        if (!isdefined(var_b3a717ae)) {
            var_b3a717ae = self.angles;
        }
        flare = util::spawn_model(model, start_origin, var_b3a717ae);
        flare clientfield::set("play_flare_fx", 1);
        flare_lifetime = max(var_45e25036[var_a81616a9] - var_a81616a9 * 0.15, 0.5);
        flare thread move_flare(self, (0, 0, -200), 0.5, 0.25, flare_lifetime, flare_tag);
        flare thread function_b2c0f62f(self);
        wait 0.15;
    }
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x11b7c3ff, Offset: 0xc940
// Size: 0x17a
function function_8dbc031a(owner, var_2be9fd26, var_2ee95acc) {
    ownerforward = anglestoforward(owner.angles);
    if (!var_2ee95acc) {
        var_d7beaff3 = vectornormalize((ownerforward[0], ownerforward[1], 0));
        velocity = var_d7beaff3 * 1000;
        var_4a54f914 = vectornormalize((var_2be9fd26[0], var_2be9fd26[1], 0));
        velocity += function_5d00ee4e(var_4a54f914, owner getvelocity()) * 1.2;
    } else {
        ownerforward = vectornormalize(ownerforward);
        velocity = ownerforward * 1000;
        var_2be9fd26 = vectornormalize(var_2be9fd26);
        velocity += owner getvelocity() * 1.2;
    }
    velocity += (0, 0, 1) * 275;
    return velocity;
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x6337a474, Offset: 0xcac8
// Size: 0x78
function function_5d00ee4e(var_ff729ff7, vector) {
    vector2d = (vector[0], vector[1], 0);
    dot = vectordot(var_ff729ff7, vector2d);
    if (dot < 0) {
        vector2d -= var_ff729ff7 * dot;
    }
    return vector2d;
}

// Namespace vehicle/vehicle_shared
// Params 6, eflags: 0x0
// Checksum 0xcdfb08ff, Offset: 0xcb48
// Size: 0x39c
function move_flare(owner, gravity, var_33a8a87a, var_b6d1408a, max_time, flare_tag = undefined) {
    self endon(#"death");
    start_time = gettime();
    var_26606bf5 = start_time + var_33a8a87a * 1000;
    end_time = start_time + max_time * 1000;
    if (isdefined(flare_tag)) {
        var_91e36ef3 = owner gettagangles(flare_tag);
        var_2ee95acc = 1;
    } else {
        var_91e36ef3 = owner.angles;
        var_2ee95acc = 0;
    }
    velocity = function_8dbc031a(owner, anglestoforward(var_91e36ef3), var_2ee95acc);
    var_dda8f2d1 = vectornormalize(velocity);
    while (gettime() < end_time) {
        if (gettime() > var_26606bf5) {
            newvelocity = velocity * (1 - (gettime() - var_26606bf5) / 1000 / (max_time - var_33a8a87a));
        } else {
            velocity = self getvelocity();
            var_28d61b7a = vectornormalize(velocity);
            var_75bd1a13 = function_8dbc031a(owner, var_28d61b7a, var_2ee95acc);
            velocity = lerpvector(velocity, var_75bd1a13, 0.5);
            newvelocity = velocity;
        }
        newvelocity += gravity * (gettime() - start_time) / 1000;
        movetopos = self.origin + newvelocity * var_b6d1408a;
        traceresult = bullettrace(self.origin, movetopos, 0, owner, 0, 0, self);
        if (traceresult[#"fraction"] < 1) {
            if (traceresult[#"fraction"] > 0) {
                movetopos = traceresult[#"position"] + traceresult[#"normal"] * 0.1;
                var_b6d1408a *= traceresult[#"fraction"];
                self moveto(movetopos, var_b6d1408a);
                self waittill(#"movedone");
            }
            break;
        }
        self moveto(movetopos, var_b6d1408a);
        wait var_b6d1408a;
    }
    if (gettime() < end_time) {
        wait (end_time - gettime()) / 1000;
    }
    self delete();
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xa764b63c, Offset: 0xcef0
// Size: 0xdc
function function_4d3fee07(missile) {
    self endon(#"death");
    self thread heatseekingmissile::missiletarget_proximitydetonate(missile, missile.owner, missile.weapon, "death");
    missile waittill(#"death");
    self clientfield::set("play_flare_fx", 0);
    self clientfield::set("play_flare_hit_fx", 1);
    util::wait_network_frame();
    self delete();
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xcc065d70, Offset: 0xcfd8
// Size: 0x178
function function_12a1b44(owner, var_8318a238) {
    if (isdefined(var_8318a238) && isdefined(var_8318a238.weapon)) {
        if (var_8318a238.weapon.guidedmissiletype === "HeatSeeking" && var_8318a238 missile_gettarget() === owner) {
            self thread function_4d3fee07(var_8318a238);
            return true;
        }
    } else {
        foreach (missile in level.missileentities) {
            if (!isdefined(missile) || !isdefined(missile.weapon)) {
                continue;
            }
            if (missile.weapon.guidedmissiletype !== "HeatSeeking") {
                continue;
            }
            if (missile missile_gettarget() === owner) {
                self thread function_4d3fee07(missile);
                return true;
            }
        }
    }
    return false;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xe2448312, Offset: 0xd158
// Size: 0xbe
function function_b2c0f62f(owner) {
    self endon(#"death");
    owner endon(#"death");
    self.var_d167e352 = 0;
    while (!self.var_d167e352) {
        self.var_d167e352 = self function_12a1b44(owner);
        waitresult = owner waittill(#"stinger_fired_at_me");
        self.var_d167e352 = self function_12a1b44(owner, waitresult.projectile);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x2d756fa7, Offset: 0xd220
// Size: 0x24
function function_b360e44c(usephysics) {
    clientfield::set("vehUseMaterialPhysics", usephysics);
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x75d3cfc9, Offset: 0xd250
// Size: 0xd0
function function_8b8653fd(n_cooldown_time, e_player, var_54d6aaee) {
    e_player endon(#"death");
    var_c1c93aba = 0;
    var_5fc57243 = n_cooldown_time / 0.05;
    while (var_c1c93aba <= var_5fc57243) {
        var_550efc89 = mapfloat(0, var_5fc57243, 0, 1, var_c1c93aba);
        e_player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_54d6aaee + ".cooldown", var_550efc89);
        var_c1c93aba++;
        wait 0.05;
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x6b2fe6ad, Offset: 0xd328
// Size: 0x180
function function_273e7ad1() {
    self endon(#"death");
    var_2faf3498 = self.healthdefault;
    var_444a18cb = self.var_33142c4c;
    var_281f4063 = self.healthpoolsize;
    var_79dde57 = [];
    for (n = 0; n < var_444a18cb; n++) {
        if (n == 0) {
            var_79dde57[n] = var_2faf3498;
            continue;
        }
        var_79dde57[n] = var_2faf3498 - var_281f4063 * n;
    }
    var_79dde57[var_79dde57.size] = 0;
    while (true) {
        self waittill(#"damage");
        foreach (keys, n_health_threshold in var_79dde57) {
            if (self.health > n_health_threshold) {
                break;
            }
        }
        self thread function_b5599ea1(var_79dde57[keys - 1]);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xc3f8f710, Offset: 0xd4b0
// Size: 0x1cc
function function_b5599ea1(n_health) {
    self notify(#"hash_7d33424c72addcf1");
    self endon(#"death", #"hash_7d33424c72addcf1");
    if (isdefined(level.playerhealth_regularregendelay)) {
        wait float(level.playerhealth_regularregendelay) / 1000;
    } else {
        wait 3;
    }
    var_b8806bf3 = int(self.healthdefault * 0.0083);
    while (self.health < n_health) {
        self.health += var_b8806bf3;
        if (self.health >= n_health) {
            self.health = n_health;
        }
        a_occupants = self getvehoccupants();
        foreach (e_occupant in a_occupants) {
            if (isplayer(e_occupant)) {
                e_occupant update_damage_as_occupant(self.maxhealth - self.health, self.maxhealth);
            }
        }
        wait 0.1;
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x30d4fa7c, Offset: 0xd688
// Size: 0x2ec
function function_5c8cd2e9(otherplayer = undefined) {
    if (!isdefined(self)) {
        return;
    }
    player = self;
    if (isdefined(player.var_761b668f)) {
        player swap_character(player.var_761b668f);
        player weapons::force_stowed_weapon_update();
        player.var_761b668f = undefined;
        if (isdefined(otherplayer) && isdefined(otherplayer.var_761b668f)) {
            otherplayer swap_character(otherplayer.var_761b668f);
            otherplayer weapons::force_stowed_weapon_update();
            otherplayer.var_761b668f = undefined;
        }
        return;
    }
    if (isdefined(otherplayer)) {
        var_56002783 = spawnstruct();
        var_56002783.tag_stowed_back_weapon = player.tag_stowed_back;
        var_56002783.var_38e09773 = player.tag_stowed_hip;
        var_56002783.stowed_weapon = player getstowedweapon();
        var_56002783.bodytype = player getcharacterbodytype();
        var_56002783.outfit = player getcharacteroutfit();
        var_d282ab1f = spawnstruct();
        var_d282ab1f.tag_stowed_back_weapon = otherplayer.tag_stowed_back;
        var_d282ab1f.var_38e09773 = otherplayer.tag_stowed_hip;
        var_d282ab1f.stowed_weapon = otherplayer getstowedweapon();
        var_d282ab1f.bodytype = otherplayer getcharacterbodytype();
        var_d282ab1f.outfit = otherplayer getcharacteroutfit();
        if (!isdefined(player.var_761b668f)) {
            player.var_761b668f = var_56002783;
        }
        if (!isdefined(otherplayer.var_761b668f)) {
            otherplayer.var_761b668f = var_d282ab1f;
        }
        otherplayer swap_character(var_56002783);
        otherplayer function_196def1e(var_56002783);
        player swap_character(var_d282ab1f);
        player function_196def1e(var_d282ab1f);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xd4750ce8, Offset: 0xd980
// Size: 0x5c
function swap_character(var_761b668f) {
    player = self;
    player setcharacterbodytype(var_761b668f.bodytype);
    player setcharacteroutfit(var_761b668f.outfit);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xa60a5919, Offset: 0xd9e8
// Size: 0x124
function function_196def1e(var_761b668f) {
    player = self;
    player weapons::detach_all_weapons();
    player.tag_stowed_back = var_761b668f.tag_stowed_back_weapon;
    if (isdefined(player.tag_stowed_back)) {
        player attach(player.tag_stowed_back, "tag_stowed_back", 1);
    } else if (level.weaponnone != var_761b668f.stowed_weapon) {
        player setstowedweapon(var_761b668f.stowed_weapon);
    }
    player.tag_stowed_hip = var_761b668f.tag_stowed_back_weapon;
    if (isdefined(player.tag_stowed_hip)) {
        player attach(player.tag_stowed_hip.worldmodel, "tag_stowed_hip_rear", 1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xe3514185, Offset: 0xdb18
// Size: 0x40
function function_36033be4(vehicle, player) {
    if (isdefined(level.var_f684ab66)) {
        return [[ level.var_f684ab66 ]](vehicle, player);
    }
    return 1;
}

