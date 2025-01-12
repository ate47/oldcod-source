#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/exploder_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/trigger_shared;
#using scripts/core_common/turret_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;
#using scripts/core_common/vehicle_death_shared;
#using scripts/core_common/vehicleriders_shared;
#using scripts/core_common/vehicles/auto_turret;

#namespace vehicle;

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x2
// Checksum 0x25846c86, Offset: 0x930
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("vehicle_shared", &__init__, &__main__, undefined);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xbc2a42f1, Offset: 0x978
// Size: 0xad4
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
    clientfield::register("vehicle", "alert_level", 1, 2, "int");
    clientfield::register("vehicle", "set_lighting_ent", 1, 1, "int");
    clientfield::register("vehicle", "use_lighting_ent", 1, 1, "int");
    clientfield::register("vehicle", "damage_level", 1, 3, "int");
    clientfield::register("vehicle", "spawn_death_dynents", 1, 2, "int");
    clientfield::register("vehicle", "spawn_gib_dynents", 1, 1, "int");
    clientfield::register("clientuimodel", "vehicle.ammo", 1, 8, "int");
    clientfield::register("clientuimodel", "vehicle.ammo2", 1, 3, "int");
    clientfield::register("clientuimodel", "vehicle.collisionWarning", 1, 2, "int");
    clientfield::register("clientuimodel", "vehicle.enemyInReticle", 1, 1, "int");
    clientfield::register("clientuimodel", "vehicle.missileRepulsed", 1, 1, "int");
    clientfield::register("helicopter", "toggle_lockon", 1, 1, "int");
    clientfield::register("helicopter", "toggle_sounds", 1, 1, "int");
    clientfield::register("helicopter", "use_engine_damage_sounds", 1, 2, "int");
    clientfield::register("helicopter", "toggle_treadfx", 1, 1, "int");
    clientfield::register("helicopter", "toggle_exhaustfx", 1, 1, "int");
    clientfield::register("helicopter", "toggle_lights", 1, 2, "int");
    clientfield::register("helicopter", "toggle_lights_group1", 1, 1, "int");
    clientfield::register("helicopter", "toggle_lights_group2", 1, 1, "int");
    clientfield::register("helicopter", "toggle_lights_group3", 1, 1, "int");
    clientfield::register("helicopter", "toggle_lights_group4", 1, 1, "int");
    clientfield::register("helicopter", "toggle_ambient_anim_group1", 1, 1, "int");
    clientfield::register("helicopter", "toggle_ambient_anim_group2", 1, 1, "int");
    clientfield::register("helicopter", "toggle_ambient_anim_group3", 1, 1, "int");
    clientfield::register("helicopter", "toggle_emp_fx", 1, 1, "int");
    clientfield::register("helicopter", "toggle_burn_fx", 1, 1, "int");
    clientfield::register("helicopter", "deathfx", 1, 1, "int");
    clientfield::register("helicopter", "alert_level", 1, 2, "int");
    clientfield::register("helicopter", "set_lighting_ent", 1, 1, "int");
    clientfield::register("helicopter", "use_lighting_ent", 1, 1, "int");
    clientfield::register("helicopter", "damage_level", 1, 3, "int");
    clientfield::register("helicopter", "spawn_death_dynents", 1, 2, "int");
    clientfield::register("helicopter", "spawn_gib_dynents", 1, 1, "int");
    clientfield::register("plane", "toggle_treadfx", 1, 1, "int");
    clientfield::register("toplayer", "toggle_dnidamagefx", 1, 1, "int");
    clientfield::register("toplayer", "toggle_flir_postfx", 1, 2, "int");
    clientfield::register("toplayer", "static_postfx", 1, 1, "int");
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
    level.vehicle_enemy_tanks["vehicle_ger_tracked_king_tiger"] = 1;
    level thread _watch_for_hijacked_vehicles();
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xb6e8bdcc, Offset: 0x1458
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
// Checksum 0xe6db84e, Offset: 0x14c8
// Size: 0x52
function setup_script_gatetrigger(trigger) {
    gates = [];
    if (isdefined(trigger.script_gatetrigger)) {
        return level.vehicle_gatetrigger[trigger.script_gatetrigger];
    }
    return gates;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xb43b3f55, Offset: 0x1528
// Size: 0x63e
function trigger_process(trigger) {
    if (trigger.classname == "trigger_multiple" || trigger.classname == "trigger_radius" || trigger.classname == "trigger_lookat" || isdefined(trigger.classname) && trigger.classname == "trigger_box") {
        btriggeronce = 1;
    } else {
        btriggeronce = 0;
    }
    if (isdefined(trigger.script_noteworthy) && trigger.script_noteworthy == "trigger_multiple") {
        btriggeronce = 0;
    }
    trigger.processed_trigger = undefined;
    gates = setup_script_gatetrigger(trigger);
    script_vehicledetour = is_node_script_origin(trigger) || isdefined(trigger.script_vehicledetour) && is_node_script_struct(trigger);
    detoured = isdefined(trigger.detoured) && !(is_node_script_origin(trigger) || is_node_script_struct(trigger));
    gotrigger = 1;
    while (gotrigger) {
        trigger trigger::wait_till();
        other = trigger.who;
        if (isdefined(trigger.enabled) && !trigger.enabled) {
            trigger waittill("enable");
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
                /#
                    println("<dev string:x28>", trigger.script_vehiclegroupdelete);
                #/
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
                /#
                    println("<dev string:x78>", trigger.script_vehiclestartmove);
                #/
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
// Checksum 0xda61c21a, Offset: 0x1b70
// Size: 0x1b6
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
// Checksum 0xd71f6f5c, Offset: 0x1d30
// Size: 0x54
function path_detour_script_origin(detournode) {
    detourpath = path_detour_get_detourpath(detournode);
    if (isdefined(detourpath)) {
        self thread paths(detourpath);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xac1c157f, Offset: 0x1d90
// Size: 0x9c
function crash_detour_check(detourpath) {
    return isdefined(detourpath.script_crashtype) && (!isdefined(detourpath.derailed) || (isdefined(self.deaddriver) || self.health <= 0 || isdefined(detourpath.script_crashtype) && detourpath.script_crashtype == "forced") && detourpath.script_crashtype == "plane");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x81090506, Offset: 0x1e38
// Size: 0x2e
function crash_derailed_check(detourpath) {
    return isdefined(detourpath.derailed) && detourpath.derailed;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xd85cbdc3, Offset: 0x1e70
// Size: 0x1b2
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
// Checksum 0x99892206, Offset: 0x2030
// Size: 0x148
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
// Checksum 0xde47feb6, Offset: 0x2180
// Size: 0x44
function _spawn_array(spawners) {
    ai = _remove_non_riders_from_array(spawner::simple_spawn(spawners));
    return ai;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x22a99242, Offset: 0x21d0
// Size: 0x88
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
// Checksum 0x257c42a3, Offset: 0x2260
// Size: 0x68
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
// Checksum 0xe9c141ee, Offset: 0x22d0
// Size: 0xc2
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
// Checksum 0xaf8b2e20, Offset: 0x23a0
// Size: 0xa8
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
// Checksum 0x13e4da7, Offset: 0x2450
// Size: 0xe2
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
// Checksum 0xeaba2299, Offset: 0x2540
// Size: 0xc0
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
// Checksum 0xb01f3043, Offset: 0x2608
// Size: 0x82
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
// Checksum 0xac61a9ce, Offset: 0x2698
// Size: 0xc24
function paths(node) {
    self endon(#"death");
    /#
        assert(isdefined(node) || isdefined(self.attachedpath), "<dev string:x95>");
    #/
    self notify(#"newpath");
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
    self endon(#"newpath");
    currentpoint = pathstart;
    while (isdefined(currentpoint)) {
        waitresult = self waittill("reached_node");
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
            self.delete_on_death = 1;
            self notify(#"death");
            if (!isalive(self)) {
                self delete();
            }
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
        resume_path();
    }
    self notify(#"reached_dynamic_path_end");
    if (isdefined(self.script_delete)) {
        self delete();
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xab142efd, Offset: 0x32c8
// Size: 0xec
function pause_path() {
    if (!(isdefined(self.vehicle_paused) && self.vehicle_paused)) {
        if (self.isphysicsvehicle) {
            self setbrake(1);
        }
        if (self.vehicleclass === "helicopter") {
            if (isdefined(self.drivepath) && self.drivepath) {
                self setvehgoalpos(self.origin, 1);
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
// Checksum 0xa736a070, Offset: 0x33c0
// Size: 0xde
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
// Params 2, eflags: 0x0
// Checksum 0x39d88db, Offset: 0x34a8
// Size: 0x1d4
function get_on_path(path_start, str_key) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (isstring(path_start)) {
        path_start = getvehiclenode(path_start, str_key);
    }
    if (!isdefined(path_start)) {
        if (isdefined(self.targetname)) {
            /#
                assertmsg("<dev string:xba>" + self.targetname);
            #/
        } else {
            /#
                assertmsg("<dev string:xba>" + self.targetname);
            #/
        }
    }
    if (isdefined(self.hasstarted)) {
        self.hasstarted = undefined;
    }
    self.attachedpath = path_start;
    if (!(isdefined(self.drivepath) && self.drivepath)) {
        self attachpath(path_start);
    }
    if (self.disconnectpathonstop === 1 && !issentient(self)) {
        self disconnect_paths(self.disconnectpathdetail);
    }
    if (isdefined(self.isphysicsvehicle) && self.isphysicsvehicle) {
        self setbrake(1);
    }
    self thread paths();
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xb92c0b4e, Offset: 0x3688
// Size: 0x34
function get_off_path() {
    self cancelaimove();
    self clearvehgoalpos();
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x9ea89f5a, Offset: 0x36c8
// Size: 0x8a
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
// Params 1, eflags: 0x0
// Checksum 0xbd14a6d, Offset: 0x3760
// Size: 0x3c
function get_on_and_go_path(path_start) {
    self get_on_path(path_start);
    self go_path();
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x941bdff, Offset: 0x37a8
// Size: 0x1f6
function go_path() {
    self endon(#"death");
    self endon(#"hash_117fe2f2");
    if (self.isphysicsvehicle) {
        self setbrake(0);
    }
    if (isdefined(self.script_vehiclestartmove)) {
        arrayremovevalue(level.vehicle_startmovegroup[self.script_vehiclestartmove], self);
    }
    if (isdefined(self.hasstarted)) {
        /#
            println("<dev string:xdf>");
        #/
        return;
    } else {
        self.hasstarted = 1;
    }
    self util::script_delay();
    self notify(#"start_vehiclepath");
    if (isdefined(self.drivepath) && self.drivepath) {
        self drivepath(self.attachedpath);
    } else {
        self startpath();
    }
    waitframe(1);
    self connect_paths();
    self waittill("reached_end_node");
    if (self.disconnectpathonstop === 1 && !issentient(self)) {
        self disconnect_paths(self.disconnectpathdetail);
    }
    if (isdefined(self.currentnode) && isdefined(self.currentnode.script_noteworthy) && self.currentnode.script_noteworthy == "deleteme") {
        return;
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xd307b7c2, Offset: 0x39a8
// Size: 0x30
function path_gate_open(node) {
    node.gateopen = 1;
    node notify(#"hash_91ff5153");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xd44f96c3, Offset: 0x39e0
// Size: 0x9c
function path_gate_wait_till_open(pathspot) {
    self endon(#"death");
    self.waitingforgate = 1;
    self set_speed(0, 15, "path gate closed");
    pathspot waittill("gate opened");
    self.waitingforgate = 0;
    if (self.health > 0) {
        script_resume_speed("gate opened", level.vehicle_resumespeed);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xc9d70e0e, Offset: 0x3a88
// Size: 0xd2
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
// Checksum 0x89d5c2cf, Offset: 0x3b68
// Size: 0x52
function _scripted_spawn(group) {
    thread _scripted_spawn_go(group);
    waitresult = level waittill("vehiclegroup spawned" + group);
    return waitresult.vehicles;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x3baf304a, Offset: 0x3bc8
// Size: 0x22
function _scripted_spawn_go(group) {
    waittillframeend();
    level notify("spawnvehiclegroup" + group);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xc6db30ba, Offset: 0x3bf8
// Size: 0x6c
function set_variables(vehicle) {
    if (isdefined(vehicle.script_deathflag)) {
        if (!level flag::exists(vehicle.script_deathflag)) {
            level flag::init(vehicle.script_deathflag);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x73bf475a, Offset: 0x3c70
// Size: 0x228
function _vehicle_spawn(vspawner) {
    if (!isdefined(vspawner) || !vspawner.count) {
        return;
    }
    str_targetname = undefined;
    if (isdefined(vspawner.targetname)) {
        str_targetname = vspawner.targetname + "_vh";
    }
    spawner::global_spawn_throttle();
    if (!isdefined(vspawner) || !vspawner.count) {
        return;
    }
    vehicle = vspawner spawnfromspawner(str_targetname, 1);
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
// Checksum 0x47898ee8, Offset: 0x3ea0
// Size: 0x880
function init(vehicle) {
    callback::callback(#"hash_bae82b92");
    vehicle useanimtree(#generic);
    if (isdefined(vehicle.e_dyn_path)) {
        vehicle.e_dyn_path linkto(vehicle);
    }
    vehicle flag::init("waiting_for_flag");
    if (isdefined(vehicle.script_godmode) && vehicle.script_godmode) {
        vehicle val::set("script_godmode", "takedamage", 0);
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
    if (vehicle.vehicleclass === "artillery") {
        vehicle.disconnectpathonstop = undefined;
        self disconnect_paths(0);
    } else {
        vehicle.disconnectpathonstop = self.script_disconnectpaths;
    }
    vehicle.disconnectpathdetail = self.script_disconnectpath_detail;
    if (!isdefined(vehicle.disconnectpathdetail)) {
        vehicle.disconnectpathdetail = 0;
    }
    if (!vehicle is_cheap() && !(vehicle.vehicleclass === "plane") && !(vehicle.vehicleclass === "artillery")) {
        vehicle thread _disconnect_paths_when_stopped();
    }
    if (!isdefined(vehicle.script_nonmovingvehicle)) {
        if (isdefined(vehicle.target)) {
            path_start = getvehiclenode(vehicle.target, "targetname");
            if (!isdefined(path_start)) {
                path_start = getent(vehicle.target, "targetname");
                if (!isdefined(path_start)) {
                    path_start = struct::get(vehicle.target, "targetname");
                }
            }
        }
        if (isdefined(path_start) && vehicle.vehicletype != "inc_base_jump_spotlight") {
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
    vehicle thread vehicle_death::main();
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
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x644c0f09, Offset: 0x4728
// Size: 0x10c
function make_targetable(vehicle, offset) {
    if (!isdefined(offset)) {
        offset = (0, 0, 0);
    }
    subtargets = target_getpotentialsubtargets(vehicle);
    if (subtargets.size > 1) {
        foreach (subtarget in subtargets) {
            if (subtarget) {
                thread subtarget_watch(vehicle, subtarget);
            }
        }
        return;
    }
    target_set(vehicle, offset);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xc776016f, Offset: 0x4840
// Size: 0x84
function subtarget_watch(vehicle, subtarget) {
    target_set(vehicle, (0, 0, 0), subtarget);
    function_671b2686(vehicle, subtarget);
    if (target_istarget(vehicle, subtarget)) {
        target_remove(vehicle, subtarget);
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x710274f0, Offset: 0x48d0
// Size: 0x66
function function_671b2686(vehicle, subtarget) {
    vehicle endon(#"death");
    while (true) {
        waitresult = vehicle waittill("subtarget_broken");
        if (waitresult.subtarget === subtarget) {
            return;
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x7a9aac8b, Offset: 0x4940
// Size: 0x2c
function get_settings() {
    settings = getscriptbundle(self.scriptbundlesettings);
    return settings;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x3f6d054f, Offset: 0x4978
// Size: 0xa6
function detach_getoutrigs() {
    if (!isdefined(self.getoutrig)) {
        return;
    }
    if (!self.getoutrig.size) {
        return;
    }
    keys = getarraykeys(self.getoutrig);
    for (i = 0; i < keys.size; i++) {
        self.getoutrig[keys[i]] unlink();
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x505327da, Offset: 0x4a28
// Size: 0x24c
function enable_turrets(veh) {
    if (!isdefined(veh)) {
        veh = self;
    }
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
// Checksum 0xd3fe63bc, Offset: 0x4c80
// Size: 0x34
function function_c130bd7b() {
    self notify(#"kill_disconnect_paths_forever");
    self.disconnectpathonstop = 0;
    self thread _disconnect_paths_when_stopped();
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xb0a38d8e, Offset: 0x4cc0
// Size: 0x178
function _disconnect_paths_when_stopped() {
    if (ispathfinder(self)) {
        self.disconnectpathonstop = 0;
        return;
    }
    if (isdefined(self.script_disconnectpaths) && !self.script_disconnectpaths) {
        self.disconnectpathonstop = 0;
        return;
    }
    self endon(#"death");
    self endon(#"kill_disconnect_paths_forever");
    wait 1;
    threshold = 3;
    while (isdefined(self)) {
        if (lengthsquared(self.velocity) < threshold * threshold) {
            if (self.disconnectpathonstop === 1) {
                self disconnect_paths(self.disconnectpathdetail);
                self notify(#"hash_fbf26c3c");
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
// Checksum 0x11eedd28, Offset: 0x4e40
// Size: 0x8c
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
    // Checksum 0x627dcc58, Offset: 0x4ed8
    // Size: 0xdc
    function debug_set_speed(speed, rate, msg) {
        self notify(#"hash_3790d3c8");
        self endon(#"hash_3790d3c8");
        self endon(#"hash_eeaec2a0");
        self endon(#"death");
        while (true) {
            while (getdvarstring("<dev string:x116>") != "<dev string:x12c>") {
                print3d(self.origin + (0, 0, 192), "<dev string:x130>" + msg, (1, 1, 1), 1, 3);
                waitframe(1);
            }
            wait 0.5;
        }
    }

#/

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xfcec359c, Offset: 0x4fc0
// Size: 0x17c
function script_resume_speed(msg, rate) {
    self endon(#"death");
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
    self notify(#"hash_eeaec2a0");
    /#
        self thread debug_resume(msg + "<dev string:x143>" + type);
    #/
}

/#

    // Namespace vehicle/vehicle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x76a5bff3, Offset: 0x5148
    // Size: 0x124
    function debug_resume(msg) {
        if (getdvarstring("<dev string:x146>") == "<dev string:x12c>") {
            return;
        }
        self endon(#"death");
        number = self.resumemsgs.size;
        self.resumemsgs[number] = msg;
        self thread print_resume_speed(gettime() + 3 * 1000);
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
// Checksum 0x4da08c00, Offset: 0x5278
// Size: 0x130
function print_resume_speed(timer) {
    self notify(#"newresumespeedmsag");
    self endon(#"newresumespeedmsag");
    self endon(#"death");
    while (gettime() < timer && isdefined(self.resumemsgs)) {
        if (self.resumemsgs.size > 6) {
            start = self.resumemsgs.size - 5;
        } else {
            start = 0;
        }
        for (i = start; i < self.resumemsgs.size; i++) {
            position = i * 32;
            /#
                print3d(self.origin + (0, 0, position), "<dev string:x15a>" + self.resumemsgs[i], (0, 1, 0), 1, 3);
            #/
        }
        waitframe(1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xa384e524, Offset: 0x53b0
// Size: 0x2c
function god_on() {
    self val::set("vehicle_god_on", "takedamage", 0);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x38cf23bf, Offset: 0x53e8
// Size: 0x2c
function god_off() {
    self val::reset("vehicle_god_on", "takedamage");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x4c35754, Offset: 0x5420
// Size: 0x94
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
// Checksum 0xc27c7c0, Offset: 0x54c0
// Size: 0x6c
function setup_dynamic_detour(pathnode, get_func) {
    prevnode = [[ get_func ]](pathnode.targetname);
    /#
        assert(isdefined(prevnode), "<dev string:x16b>");
    #/
    prevnode.detoured = 0;
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0xefab2e59, Offset: 0x5538
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
// Checksum 0x8556a735, Offset: 0x55a0
// Size: 0x38
function is_node_script_origin(pathnode) {
    return isdefined(pathnode.classname) && pathnode.classname == "script_origin";
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xf493263a, Offset: 0x55e0
// Size: 0x38c
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
                println("<dev string:x189>", self.script_vehicledetour);
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
// Checksum 0xb3143214, Offset: 0x5978
// Size: 0xec
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
// Checksum 0x4a53d0f0, Offset: 0x5a70
// Size: 0xea
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
// Checksum 0x7a7816ec, Offset: 0x5b68
// Size: 0x4c
function is_node_script_struct(node) {
    if (!isdefined(node.targetname)) {
        return false;
    }
    return isdefined(struct::get(node.targetname, "targetname"));
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xf6764d7, Offset: 0x5bc0
// Size: 0x3ca
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
// Checksum 0xeb642c95, Offset: 0x5f98
// Size: 0x94
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
    if (self.healthdefault == -1) {
        return;
    }
    self.health = self.healthdefault;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x6038
// Size: 0x4
function _vehicle_load_assets() {
    
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x1d6fd84c, Offset: 0x6048
// Size: 0x2e
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
// Checksum 0x624b110c, Offset: 0x6080
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
// Checksum 0x3792ed58, Offset: 0x6158
// Size: 0x1b2
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
// Checksum 0x91b59136, Offset: 0x6318
// Size: 0x9c
function setup_dvars() {
    /#
        if (getdvarstring("<dev string:x146>") == "<dev string:x1c6>") {
            setdvar("<dev string:x146>", "<dev string:x12c>");
        }
        if (getdvarstring("<dev string:x116>") == "<dev string:x1c6>") {
            setdvar("<dev string:x116>", "<dev string:x12c>");
        }
    #/
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x30b9f2d0, Offset: 0x63c0
// Size: 0x360
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
// Checksum 0xa9a0efcb, Offset: 0x6728
// Size: 0x62
function attacker_is_on_my_team(attacker) {
    if (isdefined(attacker) && isdefined(attacker.team) && isdefined(self.team) && attacker.team == self.team) {
        return 1;
    }
    return 0;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x8b619686, Offset: 0x6798
// Size: 0xae
function function_a827243f(attacker) {
    if (isdefined(self.team) && self.team == "allies" && isdefined(attacker) && isdefined(level.player) && attacker == level.player) {
        return 1;
    }
    if (isai(attacker) && attacker.team == self.team) {
        return 1;
    }
    return 0;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xb30a6321, Offset: 0x6850
// Size: 0x88
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
// Checksum 0x596e0ab8, Offset: 0x68e0
// Size: 0x64
function friendly_fire_shield() {
    self.var_6724d788 = 1;
    if (isdefined(level.vehicle_bulletshield[self.vehicletype]) && !isdefined(self.script_bulletshield)) {
        self.script_bulletshield = level.vehicle_bulletshield[self.vehicletype];
    }
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0xa7487428, Offset: 0x6950
// Size: 0xce
function function_f08ebf85(attacker, amount, type) {
    if (!isdefined(self.var_6724d788) || !self.var_6724d788) {
        return false;
    }
    if (!isdefined(attacker) && self.team != "neutral" || attacker_is_on_my_team(attacker) || function_a827243f(attacker) || is_destructible() || bullet_shielded(type)) {
        return true;
    }
    return false;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xf7add5cd, Offset: 0x6a28
// Size: 0x21e
function _vehicle_bad_place() {
    self endon(#"kill_badplace_forever");
    self endon(#"death");
    self endon(#"delete");
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
// Checksum 0x3e8b4322, Offset: 0x6c50
// Size: 0x124
function get_vehiclenode_any_dynamic(target) {
    path_start = getvehiclenode(target, "targetname");
    if (!isdefined(path_start)) {
        path_start = getent(target, "targetname");
    } else if (self.vehicleclass === "plane") {
        /#
            println("<dev string:x1c7>" + path_start.targetname);
            println("<dev string:x1e4>" + self.vehicletype);
        #/
        /#
            assertmsg("<dev string:x1f2>");
        #/
    }
    if (!isdefined(path_start)) {
        path_start = struct::get(target, "targetname");
    }
    return path_start;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x6929b2ae, Offset: 0x6d80
// Size: 0x84
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
// Checksum 0x7cf4b205, Offset: 0x6e10
// Size: 0xea
function land() {
    self setneargoalnotifydist(2);
    self sethoverparams(0, 0, 10);
    self cleargoalyaw();
    self settargetyaw((0, self.angles[1], 0)[1]);
    self set_goal_pos(groundtrace(self.origin, self.origin + (0, 0, -100000), 0, self)["position"], 1);
    self waittill("goal");
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x72c68d51, Offset: 0x6f08
// Size: 0x74
function set_goal_pos(origin, bstop) {
    if (self.health <= 0) {
        return;
    }
    if (isdefined(self.originheightoffset)) {
        origin += (0, 0, self.originheightoffset);
    }
    self setvehgoalpos(origin, bstop);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xe23b2d15, Offset: 0x6f88
// Size: 0x8a
function liftoff(height) {
    if (!isdefined(height)) {
        height = 512;
    }
    dest = self.origin + (0, 0, height);
    self setneargoalnotifydist(10);
    self set_goal_pos(dest, 1);
    self waittill("goal");
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x4ac142f9, Offset: 0x7020
// Size: 0xd4
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
// Checksum 0x376a24c2, Offset: 0x7100
// Size: 0xec
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
// Checksum 0xb534980, Offset: 0x71f8
// Size: 0x28
function is_unload_node() {
    return isdefined(self.script_unload) && self.script_unload != "none";
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x4572352b, Offset: 0x7228
// Size: 0x23a
function unload_node_helicopter(node) {
    if (isdefined(self.custom_unload_function)) {
        self thread [[ self.custom_unload_function ]]();
    }
    self sethoverparams(0, 0, 10);
    goal = self.nextnode.origin;
    start = self.nextnode.origin;
    end = start - (0, 0, 10000);
    trace = bullettrace(start, end, 0, undefined, 1);
    if (trace["fraction"] <= 1) {
        goal = (trace["position"][0], trace["position"][1], trace["position"][2] + self.fastropeoffset);
    }
    drop_offset_tag = "tag_fastrope_ri";
    if (isdefined(self.drop_offset_tag)) {
        drop_offset_tag = self.drop_offset_tag;
    }
    drop_offset = self gettagorigin("tag_origin") - self gettagorigin(drop_offset_tag);
    goal += (drop_offset[0], drop_offset[1], 0);
    self setvehgoalpos(goal, 1);
    self waittill("goal");
    self notify(#"unload", {#who:self.nextnode.script_unload});
    self waittill("unloaded");
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x26f7bf67, Offset: 0x7470
// Size: 0xc4
function detach_path() {
    self.attachedpath = undefined;
    self notify(#"newpath");
    speed = self getgoalspeedmph();
    if (speed == 0) {
        self setspeed(0.01);
    }
    self setgoalyaw((0, self.angles[1], 0)[1]);
    self setvehgoalpos(self.origin + (0, 0, 4), 1);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x40a9dd9c, Offset: 0x7540
// Size: 0x14c
function simple_spawn(name, b_supress_assert) {
    if (!isdefined(b_supress_assert)) {
        b_supress_assert = 0;
    }
    a_spawners = getvehiclespawnerarray(name, "targetname");
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
// Checksum 0x7f1df240, Offset: 0x7698
// Size: 0xbc
function simple_spawn_single(name, b_supress_assert) {
    if (!isdefined(b_supress_assert)) {
        b_supress_assert = 0;
    }
    vehicle_array = simple_spawn(name, b_supress_assert);
    /#
        assert(b_supress_assert || vehicle_array.size == 1, "<dev string:x225>" + name + "<dev string:x24f>" + vehicle_array.size + "<dev string:x261>");
    #/
    if (vehicle_array.size > 0) {
        return vehicle_array[0];
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x669399ee, Offset: 0x7760
// Size: 0x9c
function simple_spawn_single_and_drive(name) {
    vehiclearray = simple_spawn(name);
    /#
        assert(vehiclearray.size == 1, "<dev string:x225>" + name + "<dev string:x24f>" + vehiclearray.size + "<dev string:x261>");
    #/
    vehiclearray[0] thread go_path();
    return vehiclearray[0];
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x7b8c89d6, Offset: 0x7808
// Size: 0x7a
function simple_spawn_and_drive(name) {
    vehiclearray = simple_spawn(name);
    for (i = 0; i < vehiclearray.size; i++) {
        vehiclearray[i] thread go_path();
    }
    return vehiclearray;
}

// Namespace vehicle/vehicle_shared
// Params 6, eflags: 0x0
// Checksum 0x48855c61, Offset: 0x7890
// Size: 0xda
function spawn(modelname, targetname, vehicletype, origin, angles, destructibledef) {
    /#
        assert(isdefined(targetname));
    #/
    /#
        assert(isdefined(vehicletype));
    #/
    /#
        assert(isdefined(origin));
    #/
    /#
        assert(isdefined(angles));
    #/
    return spawnvehicle(vehicletype, origin, angles, targetname, destructibledef);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xb062e9ba, Offset: 0x7978
// Size: 0x1c4
function impact_fx(fxname, surfacetypes) {
    if (isdefined(fxname)) {
        body = self gettagorigin("tag_body");
        if (!isdefined(body)) {
            body = self.origin + (0, 0, 10);
        }
        trace = bullettrace(body, body - (0, 0, 2 * self.radius), 0, self);
        if (!isdefined(surfacetypes) || trace["fraction"] < 1 && !isdefined(trace["entity"]) && array::contains(surfacetypes, trace["surfacetype"])) {
            pos = 0.5 * (self.origin + trace["position"]);
            up = 0.5 * (trace["normal"] + anglestoup(self.angles));
            forward = anglestoforward(self.angles);
            playfx(fxname, pos, up, forward);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xeeea3c98, Offset: 0x7b48
// Size: 0x108
function maingun_fx() {
    if (!isdefined(level.vehicle_deckdust[self.model])) {
        return;
    }
    self endon(#"death");
    while (true) {
        self waittill("weapon_fired");
        playfxontag(level.vehicle_deckdust[self.model], self, "tag_engine_exhaust");
        barrel_origin = self gettagorigin("tag_flash");
        ground = physicstrace(barrel_origin, barrel_origin + (0, 0, -128));
        physicsexplosionsphere(ground, 192, 100, 1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xfcb6387, Offset: 0x7c58
// Size: 0xa4
function lights_on(team) {
    if (isdefined(team)) {
        if (team == "allies") {
            self clientfield::set("toggle_lights", 2);
        } else if (team == "axis") {
            self clientfield::set("toggle_lights", 3);
        }
        return;
    }
    self clientfield::set("toggle_lights", 0);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xe056e4e1, Offset: 0x7d08
// Size: 0x24
function lights_off() {
    self clientfield::set("toggle_lights", 1);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x1fbb8756, Offset: 0x7d38
// Size: 0x5c
function toggle_lights_group(groupid, on) {
    bit = 1;
    if (!on) {
        bit = 0;
    }
    self clientfield::set("toggle_lights_group" + groupid, bit);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x9bff99b9, Offset: 0x7da0
// Size: 0x5c
function toggle_ambient_anim_group(groupid, on) {
    bit = 1;
    if (!on) {
        bit = 0;
    }
    self clientfield::set("toggle_ambient_anim_group" + groupid, bit);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x59bb65a9, Offset: 0x7e08
// Size: 0x6c
function do_death_fx() {
    deathfxtype = self.died_by_emp === 1 ? 2 : 1;
    self clientfield::set("deathfx", deathfxtype);
    self stopsounds();
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x4dd5879a, Offset: 0x7e80
// Size: 0x2c
function toggle_emp_fx(on) {
    self clientfield::set("toggle_emp_fx", on);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x60290952, Offset: 0x7eb8
// Size: 0x2c
function toggle_burn_fx(on) {
    self clientfield::set("toggle_burn_fx", on);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xfcd282c0, Offset: 0x7ef0
// Size: 0x6c
function do_death_dynents(special_status) {
    if (!isdefined(special_status)) {
        special_status = 1;
    }
    /#
        assert(special_status >= 0 && special_status <= 3);
    #/
    self clientfield::set("spawn_death_dynents", special_status);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xd8db7d45, Offset: 0x7f68
// Size: 0xb6
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
// Checksum 0x61fd9086, Offset: 0x8028
// Size: 0x2c
function set_alert_fx_level(alert_level) {
    self clientfield::set("alert_level", alert_level);
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0xa1d92440, Offset: 0x8060
// Size: 0x3ac
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
// Checksum 0x86e6a356, Offset: 0x8418
// Size: 0x74
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
// Checksum 0xa1dd3500, Offset: 0x8498
// Size: 0x2c
function set_damage_fx_level(damage_level) {
    self clientfield::set("damage_level", damage_level);
}

// Namespace vehicle/vehicle_shared
// Params 4, eflags: 0x0
// Checksum 0xd43408f9, Offset: 0x84d0
// Size: 0xc2
function build_drive(forward, reverse, normalspeed, rate) {
    if (!isdefined(normalspeed)) {
        normalspeed = 10;
    }
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
// Checksum 0x6a91f5a2, Offset: 0x85a0
// Size: 0x2a
function get_from_spawnstruct(target) {
    return struct::get(target, "targetname");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x3cb7f77f, Offset: 0x85d8
// Size: 0x2a
function get_from_entity(target) {
    return getent(target, "targetname");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xa3b6ddbc, Offset: 0x8610
// Size: 0x2a
function get_from_spawnstruct_target(target) {
    return struct::get(target, "target");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x9f71580d, Offset: 0x8648
// Size: 0x2a
function get_from_entity_target(target) {
    return getent(target, "target");
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xabd0f242, Offset: 0x8680
// Size: 0x10
function is_destructible() {
    return isdefined(self.destructible_type);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x1d4ee94f, Offset: 0x8698
// Size: 0x2e4
function attack_group_think() {
    self endon(#"death");
    self endon(#"hash_11675b4c");
    self endon(#"hash_9696a8ad");
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
                self notify(#"hash_9696a8ad");
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
// Checksum 0x35f9c771, Offset: 0x8988
// Size: 0xd6
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
    // Checksum 0x9d919652, Offset: 0x8a68
    // Size: 0xc6
    function debug_vehicle() {
        self endon(#"death");
        if (getdvarstring("<dev string:x279>") == "<dev string:x1c6>") {
            setdvar("<dev string:x279>", "<dev string:x28e>");
        }
        while (true) {
            if (getdvarint("<dev string:x279>") > 0) {
                print3d(self.origin, "<dev string:x290>" + self.health, (1, 1, 1), 1, 3);
            }
            waitframe(1);
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x49a7dd6e, Offset: 0x8b38
    // Size: 0x148
    function debug_vehicle_paths() {
        self endon(#"death");
        self endon(#"newpath");
        self endon(#"reached_dynamic_path_end");
        for (nextnode = self.currentnode; true; nextnode = self.nextnode) {
            if (getdvarint("<dev string:x299>") > 0) {
                recordline(self.origin, self.currentnode.origin, (1, 0, 0), "<dev string:x2ad>", self);
                recordline(self.origin, nextnode.origin, (0, 1, 0), "<dev string:x2ad>", self);
                recordline(self.currentnode.origin, nextnode.origin, (1, 1, 1), "<dev string:x2ad>", self);
            }
            waitframe(1);
            if (isdefined(self.nextnode) && self.nextnode != nextnode) {
            }
        }
    }

#/

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xf12e1cb2, Offset: 0x8c88
// Size: 0x48
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
// Checksum 0xddb9fd8d, Offset: 0x8cd8
// Size: 0x8a
function add_main_callback(vehicletype, main) {
    if (!isdefined(level.vehicle_main_callback)) {
        level.vehicle_main_callback = [];
    }
    /#
        if (isdefined(level.vehicle_main_callback[vehicletype])) {
            println("<dev string:x2b4>" + vehicletype + "<dev string:x2e1>");
        }
    #/
    level.vehicle_main_callback[vehicletype] = main;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xceb0bf64, Offset: 0x8d70
// Size: 0x7e
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
// Checksum 0x47090b52, Offset: 0x8df8
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
// Checksum 0x9d7bc949, Offset: 0x8e58
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
// Checksum 0xac52746b, Offset: 0x8eb8
// Size: 0x54
function toggle_sounds(on) {
    if (!on) {
        self clientfield::set("toggle_sounds", 1);
        return;
    }
    self clientfield::set("toggle_sounds", 0);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x465b77a8, Offset: 0x8f18
// Size: 0x7c
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
// Checksum 0x14c0220d, Offset: 0x8fa0
// Size: 0x70
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
// Checksum 0x9b42c5d8, Offset: 0x9018
// Size: 0x64
function add_spawn_function(veh_targetname, spawn_func, param1, param2, param3, param4) {
    add_spawn_function_group(veh_targetname, "targetname", spawn_func, param1, param2, param3, param4);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xdc334914, Offset: 0x9088
// Size: 0x264
function add_spawn_function_group(str_value, str_key, spawn_func, param1, param2, param3, param4) {
    func = [];
    func["function"] = spawn_func;
    func["param1"] = param1;
    func["param2"] = param2;
    func["param3"] = param3;
    func["param4"] = param4;
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
// Checksum 0x1ccab51, Offset: 0x92f8
// Size: 0x64
function add_spawn_function_by_type(veh_type, spawn_func, param1, param2, param3, param4) {
    add_spawn_function_group(veh_type, "vehicletype", spawn_func, param1, param2, param3, param4);
}

// Namespace vehicle/vehicle_shared
// Params 6, eflags: 0x0
// Checksum 0x4185c327, Offset: 0x9368
// Size: 0x184
function add_hijack_function(veh_targetname, spawn_func, param1, param2, param3, param4) {
    func = [];
    func["function"] = spawn_func;
    func["param1"] = param1;
    func["param2"] = param2;
    func["param3"] = param3;
    func["param4"] = param4;
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
// Checksum 0xf1cf5ffb, Offset: 0x94f8
// Size: 0x1ae
function private _watch_for_hijacked_vehicles() {
    while (true) {
        waitresult = level waittill("ClonedEntity");
        str_targetname = waitresult.clone.targetname;
        if (isdefined(str_targetname) && strendswith(str_targetname, "_ai")) {
            str_targetname = getsubstr(str_targetname, 0, str_targetname.size - 3);
        }
        waittillframeend();
        if (isdefined(str_targetname) && isdefined(level.a_vehicle_hijack_targetnames) && isdefined(level.a_vehicle_hijack_targetnames[str_targetname])) {
            foreach (func in level.a_vehicle_hijack_targetnames[str_targetname]) {
                util::single_thread(waitresult.clone, func["function"], func["param1"], func["param2"], func["param3"], func["param4"]);
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x20d38c62, Offset: 0x96b0
// Size: 0x74
function disconnect_paths(detail_level, move_allowed) {
    if (!isdefined(detail_level)) {
        detail_level = 2;
    }
    if (!isdefined(move_allowed)) {
        move_allowed = 1;
    }
    self disconnectpaths(detail_level, move_allowed);
    self enableobstacle(0);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x9f75bfe6, Offset: 0x9730
// Size: 0x34
function connect_paths() {
    self connectpaths();
    self enableobstacle(1);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x1b1f5121, Offset: 0x9770
// Size: 0x10
function init_target_group() {
    self.target_group = [];
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xdcc431ef, Offset: 0x9788
// Size: 0xb2
function add_to_target_group(target_ent) {
    /#
        assert(isdefined(self.target_group), "<dev string:x30b>");
    #/
    if (!isdefined(self.target_group)) {
        self.target_group = [];
    } else if (!isarray(self.target_group)) {
        self.target_group = array(self.target_group);
    }
    self.target_group[self.target_group.size] = target_ent;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x6524bff7, Offset: 0x9848
// Size: 0x54
function remove_from_target_group(target_ent) {
    /#
        assert(isdefined(self.target_group), "<dev string:x30b>");
    #/
    arrayremovevalue(self.target_group, target_ent);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x9f2e9680, Offset: 0x98a8
// Size: 0xf6
function monitor_missiles_locked_on_to_me(player, wait_time) {
    if (!isdefined(wait_time)) {
        wait_time = 0.1;
    }
    monitored_entity = self;
    monitored_entity endon(#"death");
    /#
        assert(isdefined(monitored_entity.target_group), "<dev string:x30b>");
    #/
    player endon(#"stop_monitor_missile_locked_on_to_me");
    player endon(#"disconnect");
    player endon(#"joined_team");
    while (true) {
        closest_attacker = player get_closest_attacker_with_missile_locked_on_to_me(monitored_entity);
        player setvehiclelockedonbyent(closest_attacker);
        wait wait_time;
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x681971f5, Offset: 0x99a8
// Size: 0x12
function stop_monitor_missiles_locked_on_to_me() {
    self notify(#"stop_monitor_missile_locked_on_to_me");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xbf9fb469, Offset: 0x99c8
// Size: 0x2b2
function get_closest_attacker_with_missile_locked_on_to_me(monitored_entity) {
    /#
        assert(isdefined(monitored_entity.target_group), "<dev string:x30b>");
    #/
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
// Checksum 0x392ac274, Offset: 0x9c88
// Size: 0x40
function set_vehicle_drivable_time_starting_now(duration_ms) {
    end_time_ms = gettime() + duration_ms;
    set_vehicle_drivable_time(duration_ms, end_time_ms);
    return end_time_ms;
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xc5e69f1a, Offset: 0x9cd0
// Size: 0x44
function set_vehicle_drivable_time(duration_ms, end_time_ms) {
    self setvehicledrivableduration(duration_ms);
    self setvehicledrivableendtime(end_time_ms);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xab1bc89a, Offset: 0x9d20
// Size: 0x6c
function update_damage_as_occupant(damage_taken, max_health) {
    damage_taken_normalized = math::clamp(damage_taken / max_health, 0, 1);
    self setvehicledamagemeter(damage_taken_normalized);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x7f3efb80, Offset: 0x9d98
// Size: 0x12
function stop_monitor_damage_as_occupant() {
    self notify(#"stop_monitor_damage_as_occupant");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xbcb864ae, Offset: 0x9db8
// Size: 0xf0
function monitor_damage_as_occupant(player) {
    player endon(#"disconnect");
    player notify(#"stop_monitor_damage_as_occupant");
    player endon(#"stop_monitor_damage_as_occupant");
    self endon(#"death");
    if (!isdefined(self.maxhealth)) {
        self.maxhealth = self.healthdefault;
    }
    wait 0.1;
    player update_damage_as_occupant(self.maxhealth - self.health, self.maxhealth);
    while (true) {
        self waittill("damage");
        waittillframeend();
        player update_damage_as_occupant(self.maxhealth - self.health, self.maxhealth);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xf73c535c, Offset: 0x9eb0
// Size: 0x7c
function kill_vehicle(attacker) {
    damageorigin = self.origin + (0, 0, 1);
    self finishvehicleradiusdamage(attacker, attacker, 32000, 32000, 10, 0, "MOD_EXPLOSIVE", level.weaponnone, damageorigin, 400, -1, (0, 0, 1), 0);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x4dbe2532, Offset: 0x9f38
// Size: 0x8e
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
// Checksum 0xb9296c1b, Offset: 0x9fd0
// Size: 0x4c
function laser_death_watcher() {
    self notify(#"laser_death_thread_stop");
    self endon(#"laser_death_thread_stop");
    self waittill("death");
    if (isdefined(self)) {
        self laseroff();
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xbaee2499, Offset: 0xa028
// Size: 0x72
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
    // Checksum 0xe621d141, Offset: 0xa0a8
    // Size: 0x7f6
    function vehicle_spawner_tool() {
        allvehicles = getentarray("<dev string:x32b>", "<dev string:x33a>");
        vehicletypes = [];
        foreach (veh in allvehicles) {
            vehicletypes[veh.vehicletype] = veh.model;
        }
        if (isassetloaded("<dev string:x344>", "<dev string:x34c>")) {
            veh = spawnvehicle("<dev string:x34c>", (0, 0, 10000), (0, 0, 0), "<dev string:x35c>");
            vehicletypes[veh.vehicletype] = veh.model;
            veh delete();
        }
        if (isassetloaded("<dev string:x344>", "<dev string:x370>")) {
            veh = spawnvehicle("<dev string:x370>", (0, 0, 10000), (0, 0, 0), "<dev string:x35c>");
            vehicletypes[veh.vehicletype] = veh.model;
            veh delete();
        }
        if (isassetloaded("<dev string:x344>", "<dev string:x374>")) {
            veh = spawnvehicle("<dev string:x374>", (0, 0, 10000), (0, 0, 0), "<dev string:x35c>");
            vehicletypes[veh.vehicletype] = veh.model;
            veh delete();
        }
        if (isassetloaded("<dev string:x344>", "<dev string:x381>")) {
            veh = spawnvehicle("<dev string:x381>", (0, 0, 10000), (0, 0, 0), "<dev string:x35c>");
            vehicletypes[veh.vehicletype] = veh.model;
            veh delete();
        }
        if (isassetloaded("<dev string:x344>", "<dev string:x38e>")) {
            veh = spawnvehicle("<dev string:x38e>", (0, 0, 10000), (0, 0, 0), "<dev string:x35c>");
            vehicletypes[veh.vehicletype] = veh.model;
            veh delete();
        }
        types = getarraykeys(vehicletypes);
        if (types.size == 0) {
            return;
        }
        type_index = 0;
        while (true) {
            if (getdvarint("<dev string:x39e>") > 0) {
                player = getplayers()[0];
                dynamic_spawn_hud = newclienthudelem(player);
                dynamic_spawn_hud.alignx = "<dev string:x3b2>";
                dynamic_spawn_hud.x = 20;
                dynamic_spawn_hud.y = 395;
                dynamic_spawn_hud.fontscale = 2;
                dynamic_spawn_dummy_model = sys::spawn("<dev string:x3b7>", (0, 0, 0));
                while (getdvarint("<dev string:x39e>") > 0) {
                    origin = player.origin + anglestoforward(player getplayerangles()) * 270;
                    origin += (0, 0, 40);
                    if (player usebuttonpressed()) {
                        dynamic_spawn_dummy_model hide();
                        vehicle = spawnvehicle(types[type_index], origin, player.angles, "<dev string:x35c>");
                        vehicle makevehicleusable();
                        if (getdvarint("<dev string:x39e>") == 1) {
                            setdvar("<dev string:x39e>", "<dev string:x28e>");
                            continue;
                        }
                        wait 0.3;
                    }
                    if (player buttonpressed("<dev string:x3c4>")) {
                        dynamic_spawn_dummy_model hide();
                        type_index++;
                        if (type_index >= types.size) {
                            type_index = 0;
                        }
                        wait 0.3;
                    }
                    if (player buttonpressed("<dev string:x3cf>")) {
                        dynamic_spawn_dummy_model hide();
                        type_index--;
                        if (type_index < 0) {
                            type_index = types.size - 1;
                        }
                        wait 0.3;
                    }
                    type = types[type_index];
                    dynamic_spawn_hud settext("<dev string:x3d9>" + type);
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
    // Checksum 0x82f3c621, Offset: 0xa8a8
    // Size: 0x7e
    function spline_debug() {
        level flag::init("<dev string:x3f3>");
        level thread _spline_debug();
        while (true) {
            level flag::set_val("<dev string:x3f3>", getdvarint("<dev string:x409>"));
            waitframe(1);
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5ab346a2, Offset: 0xa930
    // Size: 0xc4
    function _spline_debug() {
        while (true) {
            level flag::wait_till("<dev string:x3f3>");
            foreach (nd in getallvehiclenodes()) {
                nd show_node_debug_info();
            }
            waitframe(1);
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x8249b524, Offset: 0xaa00
    // Size: 0xcc
    function show_node_debug_info() {
        self.n_debug_display_count = 0;
        if (is_unload_node()) {
            print_debug_info("<dev string:x41e>" + self.script_unload + "<dev string:x428>");
        }
        if (isdefined(self.script_notify)) {
            print_debug_info("<dev string:x42a>" + self.script_notify + "<dev string:x428>");
        }
        if (isdefined(self.script_delete) && self.script_delete) {
            print_debug_info("<dev string:x434>");
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x72a45f4b, Offset: 0xaad8
    // Size: 0x5c
    function print_debug_info(str_info) {
        self.n_debug_display_count++;
        print3d(self.origin - (0, 0, self.n_debug_display_count * 20), str_info, (0, 0, 1), 1, 1);
    }

#/
