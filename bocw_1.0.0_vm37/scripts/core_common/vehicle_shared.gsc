#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
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
// Params 0, eflags: 0x6
// Checksum 0x54e2dbca, Offset: 0xb98
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"vehicle_shared", &preinit, &postinit, undefined, undefined);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x4
// Checksum 0x3b8d330d, Offset: 0xbf0
// Size: 0xb94
function private preinit() {
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
    clientfield::register("vehicle", "toggle_force_driver_taillights", 1, 1, "int");
    clientfield::register("vehicle", "toggle_ambient_anim_group1", 1, 1, "int");
    clientfield::register("vehicle", "toggle_ambient_anim_group2", 1, 1, "int");
    clientfield::register("vehicle", "toggle_ambient_anim_group3", 1, 1, "int");
    clientfield::register("vehicle", "toggle_control_bone_group1", 1, 1, "int");
    clientfield::register("vehicle", "toggle_control_bone_group2", 1, 1, "int");
    clientfield::register("vehicle", "toggle_control_bone_group3", 1, 1, "int");
    clientfield::register("vehicle", "toggle_control_bone_group4", 1, 1, "int");
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
    clientfield::register("vehicle", "stunned", 1, 1, "int");
    clientfield::register("vehicle", "rocket_damage_rumble", 1, 1, "counter");
    if (!is_true(level.var_7b05c4b5)) {
        clientfield::register_clientuimodel("vehicle.ammoCount", 1, 10, "int", 0);
        clientfield::register_clientuimodel("vehicle.ammoReloading", 1, 1, "int", 0);
        clientfield::register_clientuimodel("vehicle.ammoLow", 1, 1, "int", 0);
        clientfield::register_clientuimodel("vehicle.rocketAmmo", 1, 2, "int", 0);
        clientfield::register_clientuimodel("vehicle.ammo2Count", 1, 10, "int", 0);
        clientfield::register_clientuimodel("vehicle.ammo2Reloading", 1, 1, "int", 0);
        clientfield::register_clientuimodel("vehicle.ammo2Low", 1, 1, "int", 0);
        clientfield::register_clientuimodel("vehicle.collisionWarning", 1, 2, "int", 0);
        clientfield::register_clientuimodel("vehicle.enemyInReticle", 1, 1, "int", 0);
        clientfield::register_clientuimodel("vehicle.missileRepulsed", 1, 1, "int", 0);
        clientfield::register_clientuimodel("vehicle.incomingMissile", 1, 1, "int", 0);
        clientfield::register_clientuimodel("vehicle.missileLock", 1, 2, "int", 0);
        clientfield::register_clientuimodel("vehicle.malfunction", 1, 2, "int", 0);
        clientfield::register_clientuimodel("vehicle.showHoldToExitPrompt", 1, 1, "int", 0);
        clientfield::register_clientuimodel("vehicle.holdToExitProgress", 1, 5, "float", 0);
        clientfield::register_clientuimodel("vehicle.vehicleAttackMode", 1, 3, "int", 0);
        clientfield::register_clientuimodel("vehicle.invalidLanding", 1, 1, "int", 0);
        for (i = 0; i < 3; i++) {
            clientfield::register_clientuimodel("vehicle.bindingCooldown" + i + ".cooldown", 1, 5, "float", 0);
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
    level.var_16e6c35e = &function_16e6c35e;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x4
// Checksum 0xb61476d2, Offset: 0x1790
// Size: 0x164
function private postinit() {
    a_all_spawners = getvehiclespawnerarray();
    setup_spawners(a_all_spawners);
    /#
        if (!is_true(level.var_26be8a4f)) {
            setdvar(#"hash_55a12fa73793eaf1", 0);
            function_cd140ee9(#"hash_55a12fa73793eaf1", &function_40fc185b);
            setdvar(#"hash_6e675a2062aa1f3e", 0);
            function_cd140ee9(#"hash_6e675a2062aa1f3e", &function_ef1192d);
            setdvar(#"hash_4381be5e131dc9aa", 0);
            level thread devgui_vehicle_spawn_think();
            level thread spline_debug();
            level thread function_280e8883();
        }
    #/
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x8e4ca4c6, Offset: 0x1900
// Size: 0x42
function setup_script_gatetrigger(trigger) {
    gates = [];
    if (isdefined(trigger.script_gatetrigger)) {
        return level.vehicle_gatetrigger[trigger.script_gatetrigger];
    }
    return gates;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x69eea48e, Offset: 0x1950
// Size: 0x594
function trigger_process(trigger) {
    if (isdefined(trigger.classname) && (trigger.classname == "trigger_multiple" || trigger.classname == "trigger_radius" || trigger.classname == "trigger_lookat" || trigger.classname == "trigger_box")) {
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
                println("<dev string:x38>", trigger.script_vehiclegroupdelete);
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
                println("<dev string:x8b>", trigger.script_vehiclestartmove);
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
// Checksum 0x16d4bdc0, Offset: 0x1ef0
// Size: 0x180
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
// Checksum 0x93c4cfe5, Offset: 0x2078
// Size: 0x4c
function path_detour_script_origin(detournode) {
    detourpath = path_detour_get_detourpath(detournode);
    if (isdefined(detourpath)) {
        self thread paths(detourpath);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x69817aaf, Offset: 0x20d0
// Size: 0x8e
function crash_detour_check(detourpath) {
    return isdefined(detourpath.script_crashtype) && (isdefined(self.deaddriver) || self.health <= 0 || detourpath.script_crashtype == "forced") && (!isdefined(detourpath.derailed) || isdefined(detourpath.script_crashtype) && detourpath.script_crashtype == "plane");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x3394f61c, Offset: 0x2168
// Size: 0x28
function crash_derailed_check(detourpath) {
    return isdefined(detourpath.derailed) && detourpath.derailed;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xf564b1f2, Offset: 0x2198
// Size: 0x186
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
// Checksum 0xc5e49c22, Offset: 0x2328
// Size: 0x10c
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
// Checksum 0x80b10181, Offset: 0x2440
// Size: 0x42
function _spawn_array(spawners) {
    ai = _remove_non_riders_from_array(spawner::simple_spawn(spawners));
    return ai;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x937419, Offset: 0x2490
// Size: 0x70
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
// Checksum 0x68701079, Offset: 0x2508
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
// Checksum 0x760e8486, Offset: 0x2570
// Size: 0xa2
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
// Checksum 0x170d3270, Offset: 0x2620
// Size: 0x9a
function rider_walk_setup(*vehicle) {
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
// Checksum 0x1dee074c, Offset: 0x26c8
// Size: 0xd0
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
// Checksum 0x391120cc, Offset: 0x27a0
// Size: 0xa6
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
// Checksum 0x3992e499, Offset: 0x2850
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
// Checksum 0x9cc84cea, Offset: 0x28d0
// Size: 0xbfc
function paths(node) {
    assert(isdefined(node) || isdefined(self.attachedpath), "<dev string:xab>");
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
            self notify(#"noteworthy", {#noteworthy:currentpoint.script_noteworthy, #noteworthy_node:currentpoint});
        }
        if (isdefined(currentpoint.script_notify)) {
            self notify(currentpoint.script_notify);
            level notify(currentpoint.script_notify);
        }
        waittillframeend();
        if (!isdefined(self)) {
            return;
        }
        if (is_true(currentpoint.script_delete)) {
            if (isdefined(self.var_761c973) && isdefined(self.var_761c973.riders) && self.var_761c973.riders.size > 0) {
                array::delete_all(self.var_761c973.riders);
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
                if (is_true(self.isphysicsvehicle)) {
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
        if (is_true(self.vehicle_paused)) {
            resume_path();
        }
    }
    self notify(#"reached_dynamic_path_end");
    self.attachedpath = undefined;
    if (isai(self)) {
        self function_af0fc980();
    }
    if (is_true(self.var_cc1f9488)) {
        self function_d4c687c9();
    }
    if (isdefined(self.script_delete)) {
        self delete();
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x3743667a, Offset: 0x34d8
// Size: 0xea
function pause_path() {
    if (!is_true(self.vehicle_paused)) {
        if (is_true(self.isphysicsvehicle)) {
            self setbrake(1);
        }
        if (self.vehicleclass === "helicopter") {
            if (is_true(self.drivepath)) {
                self function_a57c34b7(self.origin, 1);
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
// Checksum 0x58994cc3, Offset: 0x35d0
// Size: 0xde
function resume_path() {
    if (is_true(self.vehicle_paused)) {
        if (is_true(self.isphysicsvehicle)) {
            self setbrake(0);
        }
        if (self.vehicleclass === "helicopter") {
            if (is_true(self.drivepath)) {
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
// Checksum 0xe1f2c616, Offset: 0x36b8
// Size: 0x264
function get_on_path(path_start, str_key = "targetname", distance = 0) {
    if (!isdefined(self)) {
        assert(0, "<dev string:xd3>");
        return;
    }
    if (isstring(path_start)) {
        path_start = getvehiclenode(path_start, str_key);
    }
    if (!isdefined(path_start)) {
        if (isdefined(self.targetname)) {
            assertmsg("<dev string:xff>" + self.targetname);
            return;
        }
        assertmsg("<dev string:x127>");
        return;
    }
    if (isdefined(self.hasstarted)) {
        self.hasstarted = undefined;
    }
    self.attachedpath = path_start;
    if (!is_true(self.drivepath)) {
        self attachpath(path_start);
    } else if (distance != 0) {
        self function_ded6dd2e(path_start, distance);
        self.var_ef0d9bf7 = 1;
    }
    if (self.disconnectpathonstop === 1 && !issentient(self)) {
        self disconnect_paths(self.disconnectpathdetail);
    }
    self function_ea0f8324();
    if (is_true(self.isphysicsvehicle)) {
        self setbrake(1);
    }
    if (isai(self)) {
        self vehicle_ai::set_state("spline");
    }
    self thread paths();
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x522b43a7, Offset: 0x3928
// Size: 0x94
function function_af0fc980() {
    assert(is_true(isai(self)));
    state = self vehicle_ai::get_previous_state();
    if (!isdefined(state)) {
        state = "off";
    }
    self vehicle_ai::set_state(state);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x43d06007, Offset: 0x39c8
// Size: 0x64
function get_off_path() {
    self cancelaimove();
    self function_d4c687c9();
    if (isai(self)) {
        function_af0fc980();
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xb9b6c638, Offset: 0x3a38
// Size: 0x78
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
// Checksum 0x9d61dc84, Offset: 0x3ab8
// Size: 0x5c
function get_on_and_go_path(path_start, distance = 0) {
    self get_on_path(path_start, "targetname", distance);
    self go_path();
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x57681b47, Offset: 0x3b20
// Size: 0x260
function go_path() {
    self endon(#"death", #"stop path");
    if (is_true(self.isphysicsvehicle)) {
        self setbrake(0);
    }
    if (isdefined(self.script_vehiclestartmove)) {
        arrayremovevalue(level.vehicle_startmovegroup[self.script_vehiclestartmove], self);
    }
    if (isdefined(self.hasstarted)) {
        println("<dev string:x14d>");
        return;
    } else {
        self.hasstarted = 1;
    }
    self util::script_delay();
    self notify(#"start_vehiclepath");
    if (is_true(self.var_ef0d9bf7)) {
        self drivepath();
    } else if (is_true(self.drivepath)) {
        self drivepath(self.attachedpath);
    } else {
        self startpath();
    }
    waitframe(1);
    self connect_paths();
    self function_7f62bf84();
    self waittill(#"reached_end_node");
    if (self.disconnectpathonstop === 1 && !issentient(self)) {
        self disconnect_paths(self.disconnectpathdetail);
    }
    self thread function_c7ff51d8(1);
    if (isdefined(self.currentnode) && isdefined(self.currentnode.script_noteworthy) && self.currentnode.script_noteworthy == "deleteme") {
        return;
    }
}

// Namespace vehicle/vehicle_shared
// Params 5, eflags: 0x0
// Checksum 0xa22d4103, Offset: 0x3d88
// Size: 0x1a4
function function_bb9b43a9(path_start, var_1c847d0f, var_dda93e6c, location, var_e4c839a6) {
    var_6d0cd4d7 = (var_1c847d0f[0], var_1c847d0f[1], 0);
    var_92d9eea1 = (0, isdefined(location.yaw) ? location.yaw : location.angles[1], 0);
    delta_angles = var_92d9eea1 - var_dda93e6c;
    var_b38f0c63 = (path_start.origin[0], path_start.origin[1], 0) - var_6d0cd4d7;
    var_1d7df545 = rotatepoint(var_b38f0c63, delta_angles);
    var_9a100b12 = (location.origin[0], location.origin[1], 0) - var_6d0cd4d7;
    height_offset = (0, 0, 0);
    if (isdefined(var_e4c839a6)) {
        height_offset = (0, 0, var_e4c839a6) - (0, 0, var_1c847d0f[2]);
    }
    self pathmove(path_start, path_start.origin - var_b38f0c63 + var_1d7df545 + var_9a100b12 + height_offset, path_start.angles + delta_angles);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xb2bcedaf, Offset: 0x3f38
// Size: 0x30
function path_gate_open(node) {
    node.gateopen = 1;
    node notify(#"gate opened");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x1386a642, Offset: 0x3f70
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
// Checksum 0xaa360092, Offset: 0x4018
// Size: 0xba
function _spawn_group(spawngroup) {
    while (true) {
        level waittill("spawnvehiclegroup" + spawngroup);
        spawned_vehicles = [];
        for (i = 0; i < level.vehicle_spawners[spawngroup].size; i++) {
            spawned_vehicles[spawned_vehicles.size] = _vehicle_spawn(level.vehicle_spawners[spawngroup][i]);
        }
        waittillframeend();
        level notify("vehiclegroup spawned" + spawngroup, {#vehicles:spawned_vehicles});
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xf07c117d, Offset: 0x40e0
// Size: 0x56
function _scripted_spawn(group) {
    thread _scripted_spawn_go(group);
    waitresult = level waittill("vehiclegroup spawned" + group);
    return waitresult.vehicles;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xdff736da, Offset: 0x4140
// Size: 0x22
function _scripted_spawn_go(group) {
    waittillframeend();
    level notify("spawnvehiclegroup" + group);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x9dee04d1, Offset: 0x4170
// Size: 0xc
function set_variables(*vehicle) {
    
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xe234a61b, Offset: 0x4188
// Size: 0x1be
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
// Checksum 0x3c3433d7, Offset: 0x4350
// Size: 0x9d4
function init(vehicle) {
    callback::callback(#"on_vehicle_spawned");
    vehicle useanimtree("generic");
    if (isdefined(vehicle.e_dyn_path)) {
        vehicle.e_dyn_path linkto(vehicle);
    }
    vehicle flag::init("waiting_for_flag");
    if (is_true(vehicle.script_godmode)) {
        vehicle val::set(#"script_godmode", "takedamage", 0);
    }
    vehicle.zerospeed = 1;
    if (!isdefined(vehicle.modeldummyon)) {
        vehicle.modeldummyon = 0;
    }
    if (is_true(vehicle.isphysicsvehicle)) {
        if (is_true(vehicle.script_brake)) {
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
        settings = getscriptbundle(vehicle.scriptbundlesettings);
        if (isdefined(settings) && isdefined(settings.lightgroups_numgroups)) {
            if (settings.lightgroups_numgroups >= 1 && settings.lightgroups_1_always_on === 1 && !is_true(settings.var_1eaaada1)) {
                vehicle toggle_lights_group(1, 1);
            }
            if (settings.lightgroups_numgroups >= 2 && settings.lightgroups_2_always_on === 1 && !is_true(settings.var_97369f73)) {
                vehicle toggle_lights_group(2, 1);
            }
            if (settings.lightgroups_numgroups >= 3 && settings.lightgroups_3_always_on === 1 && !is_true(settings.var_acd5533)) {
                vehicle toggle_lights_group(3, 1);
            }
            if (settings.lightgroups_numgroups >= 4 && settings.lightgroups_4_always_on === 1 && !is_true(settings.var_bcb4ccd1)) {
                vehicle toggle_lights_group(4, 1);
            }
        }
        if (isdefined(settings) && isdefined(settings.var_22b9bee1)) {
            vehicle.var_22b9bee1 = 1;
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
        if (is_true(vehicle.script_disconnectpaths)) {
            vehicle.disconnectpathonstop = undefined;
            self disconnect_paths(0);
        }
        self function_ea0f8324();
    } else if (vehicle.isplayervehicle && !sessionmodeiswarzonegame()) {
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
        if (is_true(vehicle.script_recordent)) {
            recordent(vehicle);
        }
    #/
    /#
        vehicle thread debug_vehicle();
    #/
    if (isdefined(vehicle.script_targetset) && vehicle.script_targetset == 1) {
        offset = (0, 0, 0);
        if (isdefined(vehicle.script_targetoffset)) {
            offset = vehicle.script_targetoffset;
        }
        make_targetable(vehicle, offset);
    }
    if (is_true(vehicle.script_vehicleavoidance)) {
        vehicle setvehicleavoidance(1);
    }
    vehicle enable_turrets();
    if (vehicle.vehicleclass === "artillery") {
        if (isdefined(vehicle.target)) {
            turret_node = getnode(vehicle.target, "targetname");
            if (isdefined(turret_node)) {
                tag_name = turret::_get_gunner_tag_for_turret_index(0);
                v_origin = vehicle gettagorigin(tag_name);
                v_angles = vehicle gettagangles(tag_name);
                function_24ece0fc(turret_node, vehicle, v_origin, v_angles);
                dropnodetofloor(turret_node, 32);
                if (turret_node.type == #"turret") {
                    setturretnode(turret_node, vehicle);
                } else {
                    setenablenode(turret_node, 0);
                    /#
                        var_c452392e = "<dev string:x187>";
                        print3d(turret_node.origin, var_c452392e, (1, 0, 0), 1, 1, 6000);
                    #/
                }
            }
        }
        vehicle turret::_init_turret(0);
    }
    if (isdefined(level.vehiclespawncallbackthread)) {
        level thread [[ level.vehiclespawncallbackthread ]](vehicle);
    }
    heatseekingmissile::initlockfield(vehicle);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x637919c, Offset: 0x4d30
// Size: 0x3c
function make_targetable(vehicle, offset = (0, 0, 0)) {
    target_set(vehicle, offset);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x26b1e151, Offset: 0x4d78
// Size: 0xc8
function function_e2a44ff1(vehicle) {
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
// Checksum 0x90f5e512, Offset: 0x4e48
// Size: 0xc4
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
// Checksum 0xed4d5357, Offset: 0x4f18
// Size: 0x2a
function get_settings() {
    settings = getscriptbundle(self.scriptbundlesettings);
    return settings;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xcb50c5a4, Offset: 0x4f50
// Size: 0xa8
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
// Checksum 0x3aa4bc80, Offset: 0x5000
// Size: 0x23c
function enable_turrets(veh = self) {
    if (is_true(self.script_enable_turret0)) {
        veh turret::enable(0);
    }
    if (is_true(self.script_enable_turret1)) {
        veh turret::enable(1);
    }
    if (is_true(self.script_enable_turret2)) {
        veh turret::enable(2);
    }
    if (is_true(self.script_enable_turret3)) {
        veh turret::enable(3);
    }
    if (is_true(self.script_enable_turret4)) {
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
// Checksum 0x1f8a4b96, Offset: 0x5248
// Size: 0x7c
function _disconnect_paths_when_stopped() {
    if (ispathfinder(self) && !is_true(self.disconnectpathonstop)) {
        return;
    }
    if (isdefined(self.script_disconnectpaths) && !self.script_disconnectpaths) {
        self.disconnectpathonstop = 0;
        return;
    }
    self function_d733412a(1);
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0xd6ebbb64, Offset: 0x52d0
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
    // Checksum 0x650df0e4, Offset: 0x5360
    // Size: 0xfc
    function debug_set_speed(*speed, *rate, msg) {
        self notify(#"new debug_vehiclesetspeed");
        self endon(#"new debug_vehiclesetspeed", #"resuming speed", #"death");
        while (true) {
            while (getdvarstring(#"debug_vehiclesetspeed") != "<dev string:x1ba>") {
                print3d(self.origin + (0, 0, 192), "<dev string:x1c1>" + msg, (1, 1, 1), 1, 3);
                waitframe(1);
            }
            wait 0.5;
        }
    }

#/

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xf1534f91, Offset: 0x5468
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
        self thread debug_resume(msg + "<dev string:x1d7>" + type);
    #/
}

/#

    // Namespace vehicle/vehicle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x9c1e60e7, Offset: 0x55d0
    // Size: 0x12a
    function debug_resume(msg) {
        if (getdvarstring(#"debug_vehicleresume") == "<dev string:x1ba>") {
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
// Checksum 0xa724eab0, Offset: 0x5708
// Size: 0x126
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
                print3d(self.origin + (0, 0, position), "<dev string:x1dd>" + self.resumemsgs[i], (0, 1, 0), 1, 3);
            #/
        }
        waitframe(1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x6c11608f, Offset: 0x5838
// Size: 0x2c
function god_on() {
    self val::set(#"vehicle_god_on", "takedamage", 0);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x901b58e7, Offset: 0x5870
// Size: 0x2c
function god_off() {
    self val::reset(#"vehicle_god_on", "takedamage");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xd3216241, Offset: 0x58a8
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
// Checksum 0x51b4c12d, Offset: 0x5938
// Size: 0x5e
function setup_dynamic_detour(pathnode, get_func) {
    prevnode = [[ get_func ]](pathnode.targetname);
    assert(isdefined(prevnode), "<dev string:x1f1>");
    prevnode.detoured = 0;
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x491365af, Offset: 0x59a0
// Size: 0x4e
function array_2d_add(array, firstelem, newelem) {
    if (!isdefined(array[firstelem])) {
        array[firstelem] = [];
    }
    array[firstelem][array[firstelem].size] = newelem;
    return array;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x968e3164, Offset: 0x59f8
// Size: 0x32
function is_node_script_origin(pathnode) {
    return isdefined(pathnode.classname) && pathnode.classname == "script_origin";
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xc8191d42, Offset: 0x5a38
// Size: 0x31c
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
                println("<dev string:x212>", self.script_vehicledetour);
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
// Checksum 0x79984692, Offset: 0x5d60
// Size: 0xdc
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
// Checksum 0x306f6ccb, Offset: 0x5e48
// Size: 0xd8
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
// Checksum 0x16466bbc, Offset: 0x5f28
// Size: 0x44
function is_node_script_struct(node) {
    if (!isdefined(node.targetname)) {
        return false;
    }
    return isdefined(struct::get(node.targetname, "targetname"));
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x4962ab9f, Offset: 0x5f78
// Size: 0x348
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
// Checksum 0x784d138a, Offset: 0x62c8
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
    if (!self.var_dd74f4a9) {
        return;
    }
    self.health = self.healthdefault;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x6348
// Size: 0x4
function _vehicle_load_assets() {
    
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x8c4d100f, Offset: 0x6358
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
// Checksum 0x59e4fecf, Offset: 0x6388
// Size: 0xce
function play_looped_fx_on_tag(effect, durration, tag) {
    emodel = get_dummy();
    effectorigin = spawn("script_origin", emodel.origin);
    self endon(#"fire_extinguish");
    thread _play_looped_fx_on_tag_origin_update(tag, effectorigin);
    while (true) {
        playfx(effect, effectorigin.origin, effectorigin.upvec);
        wait durration;
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xbfd51204, Offset: 0x6460
// Size: 0x16c
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
// Checksum 0xcb2e380f, Offset: 0x65d8
// Size: 0xbc
function setup_dvars() {
    /#
        if (getdvarstring(#"debug_vehicleresume") == "<dev string:x252>") {
            setdvar(#"debug_vehicleresume", "<dev string:x1ba>");
        }
        if (getdvarstring(#"debug_vehiclesetspeed") == "<dev string:x252>") {
            setdvar(#"debug_vehiclesetspeed", "<dev string:x1ba>");
        }
    #/
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xce840060, Offset: 0x66a0
// Size: 0x2a8
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
// Checksum 0x16937b55, Offset: 0x6950
// Size: 0x68
function attacker_is_on_my_team(attacker) {
    if (isdefined(attacker) && isdefined(attacker.team) && isdefined(self.team) && !util::function_fbce7263(attacker.team, self.team)) {
        return 1;
    }
    return 0;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xa6404b56, Offset: 0x69c0
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
// Checksum 0xacd4cfa5, Offset: 0x6a48
// Size: 0x46
function friendly_fire_shield() {
    if (isdefined(level.vehicle_bulletshield[self.vehicletype]) && !isdefined(self.script_bulletshield)) {
        self.script_bulletshield = level.vehicle_bulletshield[self.vehicletype];
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x31b5f80a, Offset: 0x6a98
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
// Checksum 0x4061fd33, Offset: 0x6cb0
// Size: 0x11a
function get_vehiclenode_any_dynamic(target) {
    path_start = getvehiclenode(target, "targetname");
    if (!isdefined(path_start)) {
        path_start = getent(target, "targetname");
    } else if (self.vehicleclass === "plane") {
        /#
            println("<dev string:x256>" + path_start.targetname);
            println("<dev string:x276>" + self.vehicletype);
        #/
        assertmsg("<dev string:x287>");
    }
    if (!isdefined(path_start)) {
        path_start = struct::get(target, "targetname");
    }
    return path_start;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xfe52e4b0, Offset: 0x6dd8
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
// Checksum 0x67dc7798, Offset: 0x6e60
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
// Checksum 0xcc67b648, Offset: 0x6f70
// Size: 0x64
function set_goal_pos(origin, bstop) {
    if (self.health <= 0) {
        return;
    }
    if (isdefined(self.originheightoffset)) {
        origin += (0, 0, self.originheightoffset);
    }
    self function_a57c34b7(origin, bstop);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xf050bf4, Offset: 0x6fe0
// Size: 0x8a
function liftoff(height = 512) {
    dest = self.origin + (0, 0, height);
    self setneargoalnotifydist(10);
    self set_goal_pos(dest, 1);
    self waittill(#"goal");
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xa5867538, Offset: 0x7078
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
// Params 0, eflags: 0x0
// Checksum 0xd1bb031d, Offset: 0x7150
// Size: 0x38
function function_fa5a19de() {
    while (isdefined(self) && self getspeed() > 1) {
        waitframe(1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x241ed997, Offset: 0x7190
// Size: 0xfc
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
    } else {
        function_fa5a19de();
    }
    if (node is_unload_node()) {
        unload(node.script_unload);
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xfbc42e16, Offset: 0x7298
// Size: 0x22
function is_unload_node() {
    return isdefined(self.script_unload) && self.script_unload != "none";
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xdc2ae203, Offset: 0x72c8
// Size: 0x232
function unload_node_helicopter(*node) {
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
    self function_a57c34b7(goal, 1);
    self waittill(#"goal");
    self notify(#"unload", {#who:self.nextnode.script_unload});
    self waittill(#"unloaded");
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xcb9b815a, Offset: 0x7508
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
        self function_a57c34b7(self.origin + (0, 0, 4), 1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xe3662bcc, Offset: 0x75f8
// Size: 0x1da
function simple_spawn(name_or_spawners, b_supress_assert = 0) {
    a_spawners = [];
    if (isstring(name_or_spawners)) {
        a_spawners = getvehiclespawnerarray(name_or_spawners, "targetname");
        assert(a_spawners.size || b_supress_assert, "<dev string:x2bd>" + name_or_spawners + "<dev string:x2dd>");
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
// Checksum 0x42350764, Offset: 0x77e0
// Size: 0xe0
function simple_spawn_single(name_or_spawner, b_supress_assert = 0) {
    vehicle_array = simple_spawn(name_or_spawner, b_supress_assert);
    if (isentity(name_or_spawner)) {
        name = name_or_spawner.targetname;
    } else {
        name = name_or_spawner;
    }
    assert(b_supress_assert || vehicle_array.size == 1, "<dev string:x2e8>" + name + "<dev string:x315>" + vehicle_array.size + "<dev string:x32a>");
    if (vehicle_array.size > 0) {
        return vehicle_array[0];
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xf303c75a, Offset: 0x78c8
// Size: 0x92
function simple_spawn_single_and_drive(name) {
    vehiclearray = simple_spawn(name);
    assert(vehiclearray.size == 1, "<dev string:x2e8>" + name + "<dev string:x315>" + vehiclearray.size + "<dev string:x32a>");
    vehiclearray[0] thread go_path();
    return vehiclearray[0];
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x989d6237, Offset: 0x7968
// Size: 0x68
function simple_spawn_and_drive(name) {
    vehiclearray = simple_spawn(name);
    for (i = 0; i < vehiclearray.size; i++) {
        vehiclearray[i] thread go_path();
    }
    return vehiclearray;
}

// Namespace vehicle/vehicle_shared
// Params 5, eflags: 0x0
// Checksum 0x6510f21a, Offset: 0x79d8
// Size: 0xaa
function spawn(*modelname, targetname, vehicletype, origin, angles) {
    assert(isdefined(targetname));
    assert(isdefined(vehicletype));
    assert(isdefined(origin));
    assert(isdefined(angles));
    return spawnvehicle(vehicletype, origin, angles, targetname);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xa4018313, Offset: 0x7a90
// Size: 0x1cc
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
// Checksum 0xebc8fd81, Offset: 0x7c68
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
// Checksum 0xe5bc48d6, Offset: 0x7d68
// Size: 0x4c
function toggle_force_driver_taillights(on) {
    bit = 1;
    if (!on) {
        bit = 0;
    }
    self clientfield::set("toggle_force_driver_taillights", bit);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x21d04230, Offset: 0x7dc0
// Size: 0x54
function toggle_lights_group(groupid, on) {
    bit = 1;
    if (!on) {
        bit = 0;
    }
    self clientfield::set("toggle_lights_group" + groupid, bit);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x4be12cd6, Offset: 0x7e20
// Size: 0x184
function control_lights_groups(on) {
    if (!isdefined(self.scriptbundlesettings)) {
        return;
    }
    settings = getscriptbundle(self.scriptbundlesettings);
    if (!isdefined(settings) || !isdefined(settings.lightgroups_numgroups)) {
        return;
    }
    if (settings.lightgroups_numgroups >= 1 && settings.lightgroups_1_always_on !== 1 && !is_true(level.var_f1997f07)) {
        toggle_lights_group(1, on);
    }
    if (settings.lightgroups_numgroups >= 2 && settings.lightgroups_2_always_on !== 1) {
        toggle_lights_group(2, on);
    }
    if (settings.lightgroups_numgroups >= 3 && settings.lightgroups_3_always_on !== 1) {
        toggle_lights_group(3, on);
    }
    if (settings.lightgroups_numgroups >= 4 && settings.lightgroups_4_always_on !== 1) {
        toggle_lights_group(4, on);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x3e7376bf, Offset: 0x7fb0
// Size: 0xc4
function lights_on(team) {
    if (isdefined(team)) {
        if (team == #"allies") {
            self clientfield::set("toggle_lights", 2);
        } else if (team == #"axis") {
            self clientfield::set("toggle_lights", 3);
        }
    } else {
        self clientfield::set("toggle_lights", 0);
    }
    control_lights_groups(1);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xcc12663e, Offset: 0x8080
// Size: 0x3c
function lights_off() {
    self clientfield::set("toggle_lights", 1);
    control_lights_groups(0);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xfdc09a59, Offset: 0x80c8
// Size: 0x54
function toggle_ambient_anim_group(groupid, on) {
    bit = 1;
    if (!on) {
        bit = 0;
    }
    self clientfield::set("toggle_ambient_anim_group" + groupid, bit);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xdb4a4133, Offset: 0x8128
// Size: 0x54
function toggle_control_bone_group(groupid, on) {
    bit = 1;
    if (!on) {
        bit = 0;
    }
    self clientfield::set("toggle_control_bone_group" + groupid, bit);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x6913c2f5, Offset: 0x8188
// Size: 0x64
function do_death_fx() {
    deathfxtype = self.died_by_emp === 1 ? 2 : 1;
    self clientfield::set("deathfx", deathfxtype);
    self stopsounds();
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xee43c188, Offset: 0x81f8
// Size: 0x2c
function toggle_emp_fx(on) {
    self clientfield::set("toggle_emp_fx", on);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x8ade806b, Offset: 0x8230
// Size: 0x2c
function toggle_burn_fx(on) {
    self clientfield::set("toggle_burn_fx", on);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xb2a492a8, Offset: 0x8268
// Size: 0x6c
function do_death_dynents(special_status = 1) {
    assert(special_status >= 0 && special_status <= 3);
    self clientfield::set("spawn_death_dynents", special_status);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xe72cb939, Offset: 0x82e0
// Size: 0xa4
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
// Checksum 0x8fdecbc7, Offset: 0x8390
// Size: 0x2c
function set_alert_fx_level(alert_level) {
    self clientfield::set("alert_level", alert_level);
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x4f874724, Offset: 0x83c8
// Size: 0x35e
function should_update_damage_fx_level(currenthealth, damage, maxhealth) {
    if (!isdefined(self.scriptbundlesettings)) {
        return 0;
    }
    settings = getscriptbundle(self.scriptbundlesettings);
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
// Checksum 0xf9b65780, Offset: 0x8730
// Size: 0x64
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
// Checksum 0xa437f555, Offset: 0x87a0
// Size: 0x2c
function set_damage_fx_level(damage_level) {
    self clientfield::set("damage_level", damage_level);
}

// Namespace vehicle/vehicle_shared
// Params 4, eflags: 0x0
// Checksum 0xb27eb52e, Offset: 0x87d8
// Size: 0x94
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
// Checksum 0xdd381fc0, Offset: 0x8878
// Size: 0x94
function function_ea56e00e(vehicle) {
    target = get_target(vehicle);
    if (!isdefined(target)) {
        vehicle setgoal(vehicle.origin, 0, vehicle.goalradius, vehicle.goalheight);
        return;
    }
    vehicle setgoal(target.origin, 1);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xc916bd74, Offset: 0x8918
// Size: 0xa2
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
// Checksum 0x8ddfaf87, Offset: 0x89c8
// Size: 0x2a
function get_from_spawnstruct(target) {
    return struct::get(target, "targetname");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x38fa9bea, Offset: 0x8a00
// Size: 0x2a
function get_from_entity(target) {
    return getent(target, "targetname");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x8c6c47ec, Offset: 0x8a38
// Size: 0x2a
function get_from_spawnstruct_target(target) {
    return struct::get(target, "target");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x2c605984, Offset: 0x8a70
// Size: 0x2a
function get_from_entity_target(target) {
    return getent(target, "target");
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xb4ab6df4, Offset: 0x8aa8
// Size: 0xc
function is_destructible() {
    return isdefined(self.destructible_type);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x1babb6c5, Offset: 0x8ac0
// Size: 0x2ac
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
                if (util::function_fbce7263(group[i].team, self.team)) {
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
// Checksum 0x81c60f96, Offset: 0x8d78
// Size: 0xac
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
    // Checksum 0xa68d2202, Offset: 0x8e30
    // Size: 0xd6
    function debug_vehicle() {
        self endon(#"death");
        if (getdvarstring(#"debug_vehicle_health") == "<dev string:x252>") {
            setdvar(#"debug_vehicle_health", 0);
        }
        while (true) {
            if (getdvarint(#"debug_vehicle_health", 0) > 0) {
                print3d(self.origin, "<dev string:x345>" + self.health, (1, 1, 1), 1, 3);
            }
            waitframe(1);
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x238320e1, Offset: 0x8f10
    // Size: 0x15a
    function debug_vehicle_paths() {
        self endon(#"death", #"newpath", #"endpath", #"reached_dynamic_path_end");
        for (nextnode = self.currentnode; true; nextnode = self.nextnode) {
            if (getdvarint(#"debug_vehicle_paths", 0) > 0) {
                recordline(self.origin, self.currentnode.origin, (1, 0, 0), "<dev string:x351>", self);
                recordline(self.origin, nextnode.origin, (0, 1, 0), "<dev string:x351>", self);
                recordline(self.currentnode.origin, nextnode.origin, (1, 1, 1), "<dev string:x351>", self);
            }
            waitframe(1);
            if (isdefined(self.nextnode) && self.nextnode != nextnode) {
            }
        }
    }

#/

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xaa58fcc2, Offset: 0x9078
// Size: 0x50
function get_dummy() {
    if (is_true(self.modeldummyon) && !isdefined(self.vehicleassembly)) {
        emodel = self.modeldummy;
    } else {
        emodel = self;
    }
    return emodel;
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x45bbc1c, Offset: 0x90d0
// Size: 0x84
function add_main_callback(vehicletype, main) {
    if (!isdefined(level.vehicle_main_callback)) {
        level.vehicle_main_callback = [];
    }
    /#
        if (isdefined(level.vehicle_main_callback[vehicletype])) {
            println("<dev string:x35b>" + vehicletype + "<dev string:x38b>");
        }
    #/
    level.vehicle_main_callback[vehicletype] = main;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xff7a8525, Offset: 0x9160
// Size: 0x6e
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
// Checksum 0xc0cf07c9, Offset: 0x91d8
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
// Checksum 0xe7bc23c2, Offset: 0x9238
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
// Checksum 0xb57a367, Offset: 0x9298
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
// Checksum 0x4119e037, Offset: 0x92f8
// Size: 0xc4
function function_bbc1d940(on) {
    if (is_true(self.emped) || is_true(self.isjammed)) {
        on = 0;
    }
    if (on) {
        self clientfield::set("toggle_horn_sound", 1);
    } else {
        self clientfield::set("toggle_horn_sound", 0);
    }
    self callback::callback(#"hash_6e388f6a0df7bdac", {#var_d8ceeba3:on});
}

// Namespace vehicle/event_9430cf9f
// Params 1, eflags: 0x40
// Checksum 0x93972e5, Offset: 0x93c8
// Size: 0x10c
function event_handler[event_9430cf9f] function_c8effed1(eventstruct) {
    if (isvehicle(eventstruct.vehicle)) {
        if (!isdefined(eventstruct.vehicle.var_18a9fdc) || self [[ eventstruct.vehicle.var_18a9fdc ]](eventstruct.vehicle)) {
            if (is_true(eventstruct.vehicle.var_304cf9da)) {
                if (eventstruct.vehicle clientfield::get("toggle_horn_sound")) {
                    eventstruct.vehicle function_bbc1d940(0);
                } else {
                    eventstruct.vehicle function_bbc1d940(1);
                }
                return;
            }
            eventstruct.vehicle function_bbc1d940(1);
        }
    }
}

// Namespace vehicle/event_1e1c81ae
// Params 1, eflags: 0x40
// Checksum 0x34b07e06, Offset: 0x94e0
// Size: 0x6c
function event_handler[event_1e1c81ae] function_7e40b597(eventstruct) {
    if (isvehicle(eventstruct.vehicle)) {
        if (!is_true(eventstruct.vehicle.var_304cf9da)) {
            eventstruct.vehicle function_bbc1d940(0);
        }
    }
}

// Namespace vehicle/vehicle_collision
// Params 1, eflags: 0x40
// Checksum 0xe3e42602, Offset: 0x9558
// Size: 0x44
function event_handler[vehicle_collision] function_5b65d9ec(eventstruct) {
    self notify(#"vehicle_collision", eventstruct);
    callback::callback(#"veh_collision", eventstruct);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xda48cb9a, Offset: 0x95a8
// Size: 0x22c
function function_fa4236af(params) {
    self endon(#"death", #"exit_vehicle");
    driver = self getseatoccupant(0);
    if (!isplayer(driver)) {
        self toggle_sounds(1);
        return;
    }
    driver endon(#"death", #"disconnect");
    if (isdefined(self.var_42cfec27) && self.var_42cfec27 != "") {
        var_b0c85051 = soundgetplaybacktime(self.var_42cfec27) * 0.001;
        var_b0c85051 -= 0.5;
        if (var_b0c85051 > 0) {
            var_b0c85051 = math::clamp(var_b0c85051, 0.25, 1.5);
            self takeplayercontrol();
            self playsound(self.var_42cfec27);
            wait var_b0c85051;
            if (!is_true(params.var_30a04b16)) {
                self returnplayercontrol();
            }
        }
    }
    self toggle_sounds(1);
    if (isdefined(params.var_32a85fa1)) {
        self takeplayercontrol();
        wait params.var_32a85fa1;
        if (!is_true(params.var_30a04b16)) {
            self returnplayercontrol();
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x3eb396f, Offset: 0x97e0
// Size: 0x44
function function_7f0bbde3() {
    if (isdefined(self.var_ae271c0b) && self.var_ae271c0b != "") {
        self playsound(self.var_ae271c0b);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xf4810b14, Offset: 0x9830
// Size: 0x6a
function is_corpse(veh) {
    if (isdefined(veh)) {
        if (is_true(veh.isacorpse)) {
            return true;
        } else if (isdefined(veh.classname) && veh.classname == "script_vehicle_corpse") {
            return true;
        }
    }
    return false;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x8bf11b7f, Offset: 0x98a8
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
// Checksum 0xb0dcde40, Offset: 0x9918
// Size: 0x5c
function add_spawn_function(veh_targetname, spawn_func, param1, param2, param3, param4) {
    add_spawn_function_group(veh_targetname, "targetname", spawn_func, param1, param2, param3, param4);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xffa2a8fb, Offset: 0x9980
// Size: 0x23a
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
// Checksum 0xeab7fec4, Offset: 0x9bc8
// Size: 0x5c
function add_spawn_function_by_type(veh_type, spawn_func, param1, param2, param3, param4) {
    add_spawn_function_group(veh_type, "vehicletype", spawn_func, param1, param2, param3, param4);
}

// Namespace vehicle/vehicle_shared
// Params 6, eflags: 0x0
// Checksum 0x415dc178, Offset: 0x9c30
// Size: 0x172
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
// Checksum 0x8a753716, Offset: 0x9db0
// Size: 0x16c
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
// Checksum 0xeceb1d70, Offset: 0x9f28
// Size: 0x64
function disconnect_paths(detail_level = 2, move_allowed = 1) {
    self disconnectpaths(detail_level, move_allowed);
    self enableobstacle(0);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x29fa5fc8, Offset: 0x9f98
// Size: 0x34
function connect_paths() {
    self connectpaths();
    self enableobstacle(1);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x399b1dbf, Offset: 0x9fd8
// Size: 0x1c8
function function_2798ed66() {
    if (!isalive(self)) {
        return;
    }
    if (!isdefined(self.var_77b06e7a) && isdefined(self.script_vehiclecovernode)) {
        self.var_77b06e7a = [];
        var_2d292ec2 = getnodearray(self.script_vehiclecovernode, "script_vehiclecovernode");
        foreach (node in var_2d292ec2) {
            assert(isdefined(node.var_f3da2b27), "<dev string:x3b8>" + node.origin + "<dev string:x3d7>");
            array::add(self.var_77b06e7a, node, 0);
            tag_origin = self gettagorigin(node.var_f3da2b27);
            tag_angles = self gettagangles(node.var_f3da2b27);
            function_24ece0fc(node, self, tag_origin, tag_angles);
            setenablenode(node, 0);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xe1fe6c2f, Offset: 0xa1a8
// Size: 0x2b4
function function_ea0f8324() {
    self function_2798ed66();
    if (!isdefined(self.var_77b06e7a) || isdefined(self.var_affda994) && self.var_affda994) {
        return;
    }
    foreach (node in self.var_77b06e7a) {
        if (isdefined(node.var_6964df75) && node.var_6964df75) {
            continue;
        }
        setenablenode(node, 1);
        if (!function_253efe78(node, 33, 16)) {
            setenablenode(node, 0);
            /#
                if (getdvarint(#"hash_1acfe6b9af5f939b", 0)) {
                    print3d(node.origin, "<dev string:x3fa>", (1, 1, 1), 1, 0.5, 200, 1);
                }
            #/
            continue;
        }
        dropnodetofloor(node, 32);
        if (!isnodeenabled(node)) {
            /#
                if (getdvarint(#"hash_1acfe6b9af5f939b", 0)) {
                    print3d(node.origin, "<dev string:x412>", (1, 1, 1), 1, 0.5, 200, 1);
                }
            #/
            continue;
        }
        function_76a8df57(node);
        if (!isnodeenabled(node)) {
            /#
                if (getdvarint(#"hash_1acfe6b9af5f939b", 0)) {
                    print3d(node.origin, "<dev string:x432>", (1, 1, 1), 1, 0.5, 200, 1);
                }
            #/
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xf278703b, Offset: 0xa468
// Size: 0x4c
function function_c7ff51d8(wait_time) {
    self endon(#"hash_3efac6330670094d", #"death");
    wait wait_time;
    self function_ea0f8324();
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xf0ced970, Offset: 0xa4c0
// Size: 0xb0
function function_7f62bf84() {
    self notify(#"hash_3efac6330670094d");
    if (!isdefined(self.var_77b06e7a)) {
        return;
    }
    foreach (node in self.var_77b06e7a) {
        setenablenode(node, 0);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x757981be, Offset: 0xa578
// Size: 0x2e
function function_776053b8(allow) {
    if (allow) {
        self.var_affda994 = 0;
        return;
    }
    self.var_affda994 = 1;
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x396ddad7, Offset: 0xa5b0
// Size: 0x36
function function_5f30fcdb(node, allow) {
    if (allow) {
        node.var_6964df75 = undefined;
        return;
    }
    node.var_6964df75 = 1;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xd0f5fbb4, Offset: 0xa5f0
// Size: 0x32
function function_f597b732(enable) {
    if (enable) {
        self.var_e57269bc = 1;
        return;
    }
    self.var_e57269bc = 0;
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x9f5e67b0, Offset: 0xa630
// Size: 0xe
function init_target_group() {
    self.target_group = [];
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x1608d073, Offset: 0xa648
// Size: 0x9c
function add_to_target_group(target_ent) {
    assert(isdefined(self.target_group), "<dev string:x450>");
    if (!isdefined(self.target_group)) {
        self.target_group = [];
    } else if (!isarray(self.target_group)) {
        self.target_group = array(self.target_group);
    }
    self.target_group[self.target_group.size] = target_ent;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xf273e58, Offset: 0xa6f0
// Size: 0x4c
function remove_from_target_group(target_ent) {
    assert(isdefined(self.target_group), "<dev string:x450>");
    arrayremovevalue(self.target_group, target_ent);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x4b7eb0aa, Offset: 0xa748
// Size: 0xf6
function monitor_missiles_locked_on_to_me(player, wait_time = 0.1) {
    monitored_entity = self;
    monitored_entity endon(#"death");
    assert(isdefined(monitored_entity.target_group), "<dev string:x450>");
    player endon(#"stop_monitor_missile_locked_on_to_me", #"disconnect", #"joined_team");
    while (true) {
        closest_attacker = player get_closest_attacker_with_missile_locked_on_to_me(monitored_entity);
        player setvehiclelockedonbyent(closest_attacker);
        wait wait_time;
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x86a08cfe, Offset: 0xa848
// Size: 0x45e
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
        controlled = is_true(veh.controlled);
        if (!is_true(veh.isstunned)) {
            if (weapon.dostun && mod == "MOD_GRENADE_SPLASH") {
                veh.isstunned = 1;
                veh.noshoot = 1;
                veh notify(#"fire_stop");
                veh cancelaimove();
                if (issentient(veh)) {
                    veh clearentitytarget();
                }
                veh function_d4c687c9();
                veh vehclearlookat();
                veh disablegunnerfiring(0, 1);
                angles = veh function_bc2f1cb8(0);
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
// Checksum 0xe8b5c3d6, Offset: 0xacb0
// Size: 0x16
function stop_monitor_missiles_locked_on_to_me() {
    self notify(#"stop_monitor_missile_locked_on_to_me");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xa0c74904, Offset: 0xacd0
// Size: 0x256
function get_closest_attacker_with_missile_locked_on_to_me(monitored_entity) {
    assert(isdefined(monitored_entity.target_group), "<dev string:x450>");
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
// Checksum 0xbdb7d1ec, Offset: 0xaf30
// Size: 0x40
function set_vehicle_drivable_time_starting_now(duration_ms) {
    end_time_ms = gettime() + duration_ms;
    set_vehicle_drivable_time(duration_ms, end_time_ms);
    return end_time_ms;
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xeef06a26, Offset: 0xaf78
// Size: 0x44
function set_vehicle_drivable_time(duration_ms, end_time_ms) {
    self setvehicledrivableduration(duration_ms);
    self setvehicledrivableendtime(end_time_ms);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x83df4a2d, Offset: 0xafc8
// Size: 0x16
function stop_monitor_damage_as_occupant() {
    self notify(#"stop_monitor_damage_as_occupant");
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xc827fe8c, Offset: 0xafe8
// Size: 0x84
function kill_vehicle(attackingplayer, weapon = level.weaponnone) {
    damageorigin = self.origin + (0, 0, 1);
    self finishvehicleradiusdamage(attackingplayer, attackingplayer, 32000, 32000, 10, 0, "MOD_EXPLOSIVE", weapon, damageorigin, 400, -1, (0, 0, 1), 0);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xf48c33f5, Offset: 0xb078
// Size: 0x2c
function function_eb183ffe(attackingplayer, weapon) {
    kill_vehicle(attackingplayer, weapon);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x7c2bf4de, Offset: 0xb0b0
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
// Checksum 0x82b2ed2d, Offset: 0xb140
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
// Checksum 0xcd871644, Offset: 0xb1a0
// Size: 0x76
function enable_laser(b_enable, *n_index) {
    if (n_index) {
        self laseron();
        self thread laser_death_watcher();
        return;
    }
    self laseroff();
    self notify(#"laser_death_thread_stop");
}

/#

    // Namespace vehicle/vehicle_shared
    // Params 0, eflags: 0x4
    // Checksum 0x3b967c92, Offset: 0xb220
    // Size: 0x296
    function private function_3624d1c8() {
        self endon(#"hash_71971051d63a4545", #"death");
        while (isdefined(self)) {
            vehicle = self getvehicleoccupied();
            if (isdefined(vehicle)) {
                var_d4862d39 = undefined;
                vehiclename = function_9e72a96(vehicle.vehicletype);
                debug2dtext((0, 50, 0), vehiclename);
                var_6a8c15bb = undefined;
                if (self attackbuttonpressed()) {
                    if (!isdefined(self.var_e54ab55e)) {
                        var_6a8c15bb = 1;
                    }
                    self.var_e54ab55e = 1;
                } else {
                    self.var_e54ab55e = undefined;
                }
                if (isdefined(var_6a8c15bb)) {
                    if (issubstr(vehiclename, "<dev string:x473>")) {
                        var_d4862d39 = getsubstr(vehiclename, 0, vehiclename.size - 2);
                    } else {
                        var_d4862d39 = vehiclename + "<dev string:x473>";
                    }
                    if (isdefined(var_d4862d39)) {
                        var_31caf8f0 = function_951b4205();
                        foundvehicle = undefined;
                        foreach (asset in var_31caf8f0) {
                            if (asset.name == hash(var_d4862d39)) {
                                foundvehicle = 1;
                            }
                        }
                        if (is_true(foundvehicle)) {
                            vehicle setvehicletype(var_d4862d39);
                        } else {
                            println("<dev string:x479>" + var_d4862d39 + "<dev string:x48e>");
                        }
                    }
                }
            }
            waitframe(1);
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 1, eflags: 0x4
    // Checksum 0xab809b76, Offset: 0xb4c0
    // Size: 0x90
    function private function_ef1192d(params) {
        waitframe(1);
        if (is_true(params.value)) {
            player = level.players[0];
            player thread function_3624d1c8();
            return;
        }
        player = level.players[0];
        player notify(#"hash_71971051d63a4545");
    }

    // Namespace vehicle/vehicle_shared
    // Params 1, eflags: 0x4
    // Checksum 0xead4257d, Offset: 0xb558
    // Size: 0xc0
    function private function_40fc185b(*params) {
        waitframe(1);
        vehicles = getvehiclearray();
        if (isdefined(vehicles)) {
            foreach (vehicle in vehicles) {
                vehicle delete();
            }
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe9ea7abf, Offset: 0xb620
    // Size: 0x1e4
    function function_1f05ebe8(vehicleassets) {
        foreach (asset in vehicleassets) {
            if (asset.var_57f5cdd8 != #"") {
                foreach (var_58388e8c in vehicleassets) {
                    if (var_58388e8c.name == asset.var_57f5cdd8) {
                        var_58388e8c.variant = 1;
                    }
                }
                continue;
            }
            if (asset.var_5a25c2fb != #"") {
                foreach (var_3913f550 in vehicleassets) {
                    if (var_3913f550.name == asset.var_5a25c2fb) {
                        var_3913f550.variant = 1;
                    }
                }
            }
        }
        return vehicleassets;
    }

    // Namespace vehicle/vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5825b4c7, Offset: 0xb810
    // Size: 0x41a
    function devgui_vehicle_spawn_think() {
        level endon(#"game_ended");
        function_5ac4dc99("<dev string:x49a>", "<dev string:x252>");
        if (is_true(game.var_76affb26)) {
            return;
        }
        level flag::wait_till("<dev string:x4ae>");
        assert(!isdefined(level.vehicle_spawner), "<dev string:x4c5>");
        level.vehicle_spawner = spawnstruct();
        var_31caf8f0 = function_951b4205();
        var_31caf8f0 = function_1f05ebe8(var_31caf8f0);
        level.var_194c1a03 = [];
        var_b668ad34 = [];
        var_1883f5da = [];
        var_1cdd56e5 = [];
        foreach (vehicle in var_31caf8f0) {
            if (!ispc() && is_true(vehicle.variant)) {
                continue;
            }
            level.var_194c1a03[vehicle.name] = vehicle.model;
            switch (vehicle.type) {
            case 0:
            case 1:
            case 2:
                arrayinsert(var_b668ad34, vehicle.name, 0);
                break;
            case 3:
            case 6:
                arrayinsert(var_1883f5da, vehicle.name, 0);
                break;
            case 4:
                arrayinsert(var_1cdd56e5, vehicle.name, 0);
                break;
            case 5:
            default:
                arrayinsert(var_b668ad34, vehicle.name, 0);
                break;
            }
        }
        var_d3634e5d = "<dev string:x4fb>";
        menu_index = 1;
        level thread function_f4c8a8ec(var_d3634e5d, "<dev string:x52d>", 0, var_b668ad34, "<dev string:x534>", menu_index);
        menu_index++;
        level thread function_f4c8a8ec(var_d3634e5d, "<dev string:x52d>", 0, var_1883f5da, "<dev string:x53c>", menu_index);
        menu_index++;
        level thread function_f4c8a8ec(var_d3634e5d, "<dev string:x52d>", 0, var_1cdd56e5, "<dev string:x543>", menu_index);
        menu_index++;
        game.var_76affb26 = 1;
        function_cd140ee9("<dev string:x49a>", &function_d53cf714);
        waitframe(1);
    }

    // Namespace vehicle/vehicle_shared
    // Params 6, eflags: 0x4
    // Checksum 0x217a1d84, Offset: 0xbc38
    // Size: 0xec
    function private function_f4c8a8ec(root, *pname, index, a_vehicles, vehicle_type, *mindex) {
        level endon(#"game_ended");
        if (isdedicated()) {
            return;
        }
        devgui_root = index + mindex + "<dev string:x54a>";
        if (isdefined(vehicle_type)) {
            for (i = 0; i < vehicle_type.size; i++) {
                name = function_9e72a96(vehicle_type[i]);
                function_9db84b1b(devgui_root, a_vehicles, name, i + 1, name);
            }
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 5, eflags: 0x4
    // Checksum 0x1b089407, Offset: 0xbd30
    // Size: 0x8c
    function private function_9db84b1b(root, *pid, veh_name, *cmdindex, *displayname) {
        util::waittill_can_add_debug_command();
        adddebugcommand(cmdindex + displayname + "<dev string:x54f>" + "<dev string:x49a>" + "<dev string:x55a>" + displayname + "<dev string:x55f>");
    }

    // Namespace vehicle/vehicle_shared
    // Params 1, eflags: 0x4
    // Checksum 0x7aaf53b3, Offset: 0xbdc8
    // Size: 0x1dc
    function private function_d53cf714(params) {
        waitframe(1);
        if (isdefined(level.vehicle_spawner.dynamic_spawn_hud)) {
            level.vehicle_spawner.dynamic_spawn_hud destroy();
        }
        if (isdefined(level.vehicle_spawner.dynamic_spawn_dummy_model)) {
            level.vehicle_spawner.dynamic_spawn_dummy_model delete();
        }
        if (isdefined(params) && isdefined(params.value)) {
            if (params.value != "<dev string:x252>") {
                player = getplayers()[0];
                level.vehicle_spawner.dynamic_spawn_hud = newdebughudelem(player);
                level.vehicle_spawner.dynamic_spawn_hud.alignx = "<dev string:x566>";
                level.vehicle_spawner.dynamic_spawn_hud.x = 20;
                level.vehicle_spawner.dynamic_spawn_hud.y = 395;
                level.vehicle_spawner.dynamic_spawn_hud.fontscale = 1;
                level.vehicle_spawner.dynamic_spawn_dummy_model = spawn("<dev string:x56e>", (0, 0, 0));
                level.vehicle_spawner thread function_8b412f99(params.value);
                return;
            }
            level.vehicle_spawner notify(#"hash_4e305005b552fa4e");
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 1, eflags: 0x4
    // Checksum 0x5434e6d8, Offset: 0xbfb0
    // Size: 0x288
    function private function_8b412f99(vehicle_name) {
        self notify(#"hash_4e305005b552fa4e");
        self endon(#"hash_4e305005b552fa4e");
        while (true) {
            player = getplayers()[0];
            origin = player.origin + anglestoforward(player getplayerangles()) * 270;
            origin += (0, 0, 40);
            if (player usebuttonpressed()) {
                self.dynamic_spawn_dummy_model hide();
                vehicle = spawnvehicle(vehicle_name, origin, player.angles, "<dev string:x57e>");
                vehicle makevehicleusable();
                while (player usebuttonpressed()) {
                    waitframe(1);
                }
            } else if (player buttonpressed("<dev string:x595>")) {
                setdvar(#"hash_7c03d763c6345d2b", "<dev string:x252>");
                self.dynamic_spawn_dummy_model delete();
                return;
            }
            self.dynamic_spawn_hud settext("<dev string:x5a1>" + vehicle_name + "<dev string:x5c3>");
            self.dynamic_spawn_dummy_model setmodel(level.var_194c1a03[hash(vehicle_name)]);
            self.dynamic_spawn_dummy_model show();
            self.dynamic_spawn_dummy_model notsolid();
            self.dynamic_spawn_dummy_model.origin = origin;
            self.dynamic_spawn_dummy_model.angles = player.angles;
            waitframe(1);
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x6ca9bbd8, Offset: 0xc240
    // Size: 0x6e
    function spline_debug() {
        level thread _spline_debug();
        while (true) {
            level flag::set_val("<dev string:x5e2>", getdvarint(#"g_vehicledrawsplines", 0));
            waitframe(1);
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0xaba70a64, Offset: 0xc2b8
    // Size: 0xc2
    function _spline_debug() {
        while (true) {
            level flag::wait_till("<dev string:x5e2>");
            foreach (nd in getallvehiclenodes()) {
                nd show_node_debug_info();
            }
            waitframe(1);
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf215479e, Offset: 0xc388
    // Size: 0xbc
    function show_node_debug_info() {
        self.n_debug_display_count = 0;
        if (is_unload_node()) {
            print_debug_info("<dev string:x5fb>" + self.script_unload + "<dev string:x608>");
        }
        if (isdefined(self.script_notify)) {
            print_debug_info("<dev string:x60d>" + self.script_notify + "<dev string:x608>");
        }
        if (is_true(self.script_delete)) {
            print_debug_info("<dev string:x61a>");
        }
    }

    // Namespace vehicle/vehicle_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc0c13907, Offset: 0xc450
    // Size: 0x5c
    function print_debug_info(str_info) {
        self.n_debug_display_count++;
        print3d(self.origin - (0, 0, self.n_debug_display_count * 20), str_info, (0, 0, 1), 1, 1);
    }

    // Namespace vehicle/vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe9872aa8, Offset: 0xc4b8
    // Size: 0x5c
    function function_280e8883() {
        util::init_dvar("<dev string:x624>", 0, &function_cccd25de);
        util::waittill_can_add_debug_command();
        adddebugcommand("<dev string:x648>");
    }

    // Namespace vehicle/vehicle_shared
    // Params 1, eflags: 0x0
    // Checksum 0xea867532, Offset: 0xc520
    // Size: 0x11c
    function function_cccd25de(params) {
        if (params.value) {
            foreach (player in getplayers()) {
                if (player isinvehicle()) {
                    vehicle = player getvehicleoccupied();
                    vehicle dodamage(vehicle.maxhealth, vehicle.origin);
                }
            }
            setdvar(#"hash_7ffc63ff2f197a50", 0);
        }
    }

#/

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x4
// Checksum 0xcedc536a, Offset: 0xc648
// Size: 0x114
function private function_bbd487c2() {
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
// Checksum 0x40569fbe, Offset: 0xc768
// Size: 0x4a4
function function_93844822(e_player, b_skip_scene, b_enter = 1) {
    var_40a72df6 = "";
    if (!b_enter) {
        s_info = self function_831cd622(e_player);
    }
    if (!b_skip_scene) {
        if (b_enter) {
            debug_scene = getdvarstring(#"hash_56b164d8150f9e8d", "");
            if (debug_scene != "") {
                str_scene = debug_scene;
            } else if (isdefined(self.script_vh_entrance)) {
                str_scene = self.script_vh_entrance;
            } else if (isdefined(self.settings) && isdefined(self.settings.var_fbbdbf11)) {
                str_scene = self.settings.var_fbbdbf11;
                if (!isdefined(e_player.companion)) {
                    var_3966de80 = str_scene;
                    var_3966de80 += "_solo";
                    scene = getscriptbundle(var_3966de80);
                    if (isdefined(scene)) {
                        str_scene = var_3966de80;
                    }
                }
                var_9d0b2a04 = vectordot(anglestoright(self.angles), vectornormalize(self.origin - e_player.origin));
                if (var_9d0b2a04 > 0) {
                    var_664b49b8 = "left";
                } else {
                    var_664b49b8 = "right";
                }
                str_shot = var_664b49b8 + var_40a72df6;
            }
        } else {
            debug_scene = getdvarstring(#"hash_56b164d8150f9e8d", "");
            if (debug_scene != "") {
                str_scene = debug_scene;
            } else if (isdefined(self.var_a5fbf4c5)) {
                str_scene = self.var_a5fbf4c5;
            } else if (isdefined(self.settings) && isdefined(self.settings.var_ffbed7fd)) {
                str_scene = self.settings.var_ffbed7fd;
                if (!isdefined(e_player.companion)) {
                    var_3966de80 = str_scene;
                    var_3966de80 += "_solo";
                    scene = getscriptbundle(var_3966de80);
                    if (isdefined(scene)) {
                        str_scene = var_3966de80;
                    }
                }
                var_664b49b8 = s_info.var_664b49b8;
                str_shot = var_664b49b8 + var_40a72df6;
            }
        }
        if (isdefined(str_scene) && str_scene != "") {
            self notify(#"hash_376d57a458a131df");
            a_ents = array(e_player);
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
            e_player flag::wait_till_clear("scene");
            self notify(#"vehicle_scene_done");
        }
        if (!b_enter) {
            if (isdefined(s_info.v_teleport_pos)) {
                e_player setorigin(s_info.v_teleport_pos);
            }
            if (isdefined(s_info.v_teleport_angles)) {
                e_player setplayerangles(s_info.v_teleport_angles);
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x4
// Checksum 0x324ac2bb, Offset: 0xcc18
// Size: 0x35e
function private function_831cd622(e_player) {
    s_info = {};
    v_movement = e_player getnormalizedmovement();
    if (self.archetype === #"fav") {
        var_d526c0e4 = self.origin + anglestoright(self.angles) * 115;
        var_c1af71a1 = self.origin + anglestoright(self.angles) * -125;
        var_b44997b4 = self.origin + anglestoforward(self.angles) * -110;
        if (v_movement[1] < 0 && ispointonnavmesh(var_c1af71a1) && bullettracepassed(self.origin + (0, 0, 75), var_c1af71a1 + (0, 0, 5), 1, self)) {
            s_info.var_664b49b8 = "left";
        } else if (ispointonnavmesh(var_d526c0e4) && bullettracepassed(self.origin + (0, 0, 75), var_d526c0e4 + (0, 0, 5), 1, self)) {
            s_info.var_664b49b8 = "right";
        } else {
            s_info.var_664b49b8 = "left";
            s_info.v_teleport_pos = getclosestpointonnavmesh(self.origin, 256, 16);
        }
    } else if (self.archetype === #"quad") {
        var_d526c0e4 = self.origin + anglestoright(self.angles) * 85;
        var_c1af71a1 = self.origin + anglestoright(self.angles) * -85;
        if (v_movement[1] < 0 && ispointonnavmesh(var_c1af71a1)) {
            s_info.var_664b49b8 = "left";
            s_info.v_teleport_pos = getclosestpointonnavmesh(var_c1af71a1, 256, 16);
        } else {
            s_info.var_664b49b8 = "right";
            s_info.v_teleport_pos = getclosestpointonnavmesh(var_d526c0e4, 256, 16);
        }
        s_info.v_teleport_angles = (0, self.angles[1], 0);
    } else if (v_movement[1] < 0) {
        s_info.var_664b49b8 = "left";
    } else {
        s_info.var_664b49b8 = "right";
    }
    return s_info;
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x4050e252, Offset: 0xcf80
// Size: 0x1b2
function function_19bd94a1(var_3051fdcd, b_one_shot = 0) {
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
        vh.script_vh_entrance = var_3051fdcd;
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
// Checksum 0x9a58a6d0, Offset: 0xd140
// Size: 0x1b2
function function_1e82f829(var_35304872, b_one_shot = 0) {
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
        vh.var_a5fbf4c5 = var_35304872;
    }
    if (b_one_shot) {
        array::wait_any(a_vehicles, "vehicle_scene_done");
        foreach (vh in a_vehicles) {
            if (isdefined(vh)) {
                vh.var_a5fbf4c5 = undefined;
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x602ab076, Offset: 0xd300
// Size: 0x90
function function_feea068b(var_8730ee3e, vehicle) {
    if (is_true(var_8730ee3e.var_77cc0e86)) {
        if (vehicle.angles[2] < -20) {
            return "left";
        } else if (vehicle.angles[2] > 20) {
            return "right";
        } else {
            return "straight";
        }
        return;
    }
    return "straight";
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x4689d2e, Offset: 0xd398
// Size: 0xec
function function_700512f1(vehicle) {
    vehicleup = anglestoup(vehicle.angles);
    var_2dd1b16a = vehicle.origin + vehicleup * 20;
    angles = (0, vehicle.angles[1], 0);
    rightvecdot = vectordot(anglestoright(angles), vectornormalize(self.origin - var_2dd1b16a));
    if (rightvecdot > 0) {
        return "right";
    }
    return "left";
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x9d88dd5a, Offset: 0xd490
// Size: 0x146
function function_1895ca2(var_8730ee3e, var_ef8d5042, var_de5ed888) {
    if (is_true(var_8730ee3e.var_99851f11) && self isplayerswimming()) {
        if (var_ef8d5042 == "right") {
            animation = var_8730ee3e.var_e6086420;
        } else {
            animation = var_8730ee3e.var_33e416f;
        }
    } else if (var_de5ed888 == "straight") {
        if (var_ef8d5042 == "right") {
            animation = var_8730ee3e.var_9b47c071;
        } else {
            animation = var_8730ee3e.var_9323d5c1;
        }
    } else if (var_de5ed888 == "right") {
        if (var_ef8d5042 == "right") {
            animation = var_8730ee3e.var_189ada3;
        } else {
            animation = var_8730ee3e.var_905b93a1;
        }
    } else if (var_ef8d5042 == "right") {
        animation = var_8730ee3e.var_8846d82e;
    } else {
        animation = var_8730ee3e.var_be5486b5;
    }
    return animation;
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xe1860ed4, Offset: 0xd5e0
// Size: 0x72
function function_cc8f8c87(var_8730ee3e, var_de5ed888) {
    if (var_de5ed888 == "straight") {
        animation = var_8730ee3e.vehicleenteranim;
    } else if (var_de5ed888 == "right") {
        animation = var_8730ee3e.var_7761a828;
    } else {
        animation = var_8730ee3e.var_5bd999a1;
    }
    return animation;
}

// Namespace vehicle/enter_vehicle
// Params 1, eflags: 0x40
// Checksum 0xdd5c32f, Offset: 0xd660
// Size: 0x444
function event_handler[enter_vehicle] codecallback_vehicleenter(eventstruct) {
    if (is_true(self.var_5a44792f)) {
        self.var_5a44792f = undefined;
        return;
    }
    if (isvehicle(eventstruct.vehicle)) {
        if (!isdefined(eventstruct.seat_index)) {
            return;
        }
        var_fd110a27 = eventstruct.vehicle function_a3f90231(eventstruct.seat_index);
        if (!isdefined(var_fd110a27)) {
            return;
        }
        var_8730ee3e = getscriptbundle(var_fd110a27);
        if (isdefined(var_8730ee3e)) {
            if (is_true(var_8730ee3e.zmenhancedstatejukeinit)) {
                if (!isdefined(eventstruct.vehicle.t_sarah_foy_objective__indicator_)) {
                    eventstruct.vehicle.t_sarah_foy_objective__indicator_ = [];
                }
                if (is_true(eventstruct.vehicle.t_sarah_foy_objective__indicator_[eventstruct.seat_index])) {
                    return;
                }
                eventstruct.vehicle.t_sarah_foy_objective__indicator_[eventstruct.seat_index] = 1;
            }
            var_ef8d5042 = function_700512f1(eventstruct.vehicle);
            var_de5ed888 = function_feea068b(var_8730ee3e, eventstruct.vehicle);
            animation = self function_1895ca2(var_8730ee3e, var_ef8d5042, var_de5ed888);
            if (isdefined(animation) && self hasdobj()) {
                self animscripted("vehicle_enter_anim_player", eventstruct.vehicle function_5051cc0c(eventstruct.seat_index), eventstruct.vehicle function_90d45d34(eventstruct.seat_index), animation, "server script", undefined, 1, undefined, undefined, undefined, 1);
            }
            vehicleanim = function_cc8f8c87(var_8730ee3e, var_de5ed888);
            if (isdefined(vehicleanim)) {
                if (var_de5ed888 == "straight") {
                    eventstruct.vehicle setanimknobrestart(vehicleanim, 1, 0, 1);
                    return;
                }
                angles = (eventstruct.vehicle.angles[0], eventstruct.vehicle.angles[1], 0);
                startorigin = eventstruct.vehicle.origin + (0, 0, 10);
                endorigin = eventstruct.vehicle.origin - (0, 0, 60);
                trace = groundtrace(startorigin, endorigin, 0, eventstruct.vehicle);
                if (trace[#"fraction"] == 1) {
                    var_4e1ed731 = eventstruct.vehicle.origin;
                } else {
                    var_4e1ed731 = trace[#"position"];
                }
                eventstruct.vehicle animscripted("vehicle_enter_anim_vehicle", var_4e1ed731, angles, vehicleanim, "normal", undefined, 1, undefined, undefined, undefined, 1);
            }
        }
    }
}

// Namespace vehicle/change_seat
// Params 1, eflags: 0x40
// Checksum 0x3e3255cf, Offset: 0xdab0
// Size: 0x2bc
function event_handler[change_seat] function_124469f4(eventstruct) {
    if (isvehicle(eventstruct.vehicle)) {
        if (!isdefined(eventstruct.seat_index)) {
            return;
        }
        var_fd110a27 = eventstruct.vehicle function_a3f90231(eventstruct.seat_index);
        if (!isdefined(var_fd110a27)) {
            return;
        }
        var_8730ee3e = getscriptbundle(var_fd110a27);
        if (isdefined(var_8730ee3e)) {
            if (!is_true(var_8730ee3e.var_8d496bb1)) {
                return;
            }
            if (is_true(var_8730ee3e.zmenhancedstatejukeinit)) {
                if (!isdefined(eventstruct.vehicle.t_sarah_foy_objective__indicator_)) {
                    eventstruct.vehicle.t_sarah_foy_objective__indicator_ = [];
                }
                if (is_true(eventstruct.vehicle.t_sarah_foy_objective__indicator_[eventstruct.seat_index])) {
                    return;
                }
                eventstruct.vehicle.t_sarah_foy_objective__indicator_[eventstruct.seat_index] = 1;
            }
            rightvecdot = vectordot(anglestoright(eventstruct.vehicle.angles), vectornormalize(self.origin - eventstruct.vehicle.origin));
            if (rightvecdot > 0) {
                animation = var_8730ee3e.var_9b47c071;
            } else {
                animation = var_8730ee3e.var_9323d5c1;
            }
            if (isdefined(animation)) {
                self animscripted("vehicle_enter_anim", eventstruct.vehicle function_5051cc0c(eventstruct.seat_index), eventstruct.vehicle function_90d45d34(eventstruct.seat_index), animation, "server script", undefined, 1, undefined, undefined, undefined, 1);
            }
            vehicleanim = var_8730ee3e.vehicleenteranim;
            if (isdefined(vehicleanim)) {
                eventstruct.vehicle setanimknobrestart(vehicleanim, 1, 0, 1);
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0xc337078b, Offset: 0xdd78
// Size: 0xc8
function function_fa8ced6e(v_origin, v_angles, str_vehicle = undefined) {
    if (self isinvehicle()) {
        return self getvehicleoccupied();
    }
    assert(isdefined(str_vehicle), "<dev string:x6b1>");
    var_80730518 = spawnvehicle(str_vehicle, v_origin, v_angles, "player_spawned_vehicle");
    var_80730518 usevehicle(self, 0);
    return var_80730518;
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0xd6257fe8, Offset: 0xde48
// Size: 0x84
function function_715433be(vehicle, bot, n_seat) {
    if (isbot(bot) && n_seat == 0) {
        if (vehicle vehicle_ai::has_state("off")) {
            vehicle vehicle_ai::set_state("off");
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x309895ca, Offset: 0xded8
// Size: 0xf0
function function_a29610b6(x, k) {
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
// Checksum 0xa3cc8065, Offset: 0xdfd0
// Size: 0x2fe
function update_flare_ability(player, var_55716d54, active_time = 5, cooldown_time = 10, flare_tag = undefined) {
    var_a86d6798 = "update_flare_ability";
    self notify(var_a86d6798);
    self endon(#"death", var_a86d6798);
    var_bca5c6c1 = active_time;
    flarecooldown = cooldown_time;
    if (!self flag::exists("flares_available")) {
        self flag::init("flares_available", 1);
    } else {
        self flag::set("flares_available");
    }
    player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_55716d54 + ".cooldown", 1);
    while (isdefined(player.vh_vehicle) && player function_e01d381a()) {
        waitframe(1);
    }
    self.var_40d7d1f2 = 0;
    while (isdefined(player) && (isdefined(player.vh_vehicle) || self.var_40d7d1f2)) {
        assert(!is_true(self.var_40d7d1f2));
        if (player function_e01d381a()) {
            self flag::clear("flares_available");
            self.var_40d7d1f2 = 1;
            player playsoundtoplayer(#"hash_35af2f72517d10ab", player);
            self fire_flares(player, flare_tag, active_time);
            player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_55716d54 + ".cooldown", 0);
            wait var_bca5c6c1;
            self.var_40d7d1f2 = 0;
            level thread function_1bb979ca(flarecooldown, player, var_55716d54);
            player playsoundtoplayer(#"hash_62742dd7b6e513e", player);
            self flag::set("flares_available");
        }
        waitframe(1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x4eb9578, Offset: 0xe2d8
// Size: 0x140
function function_8aab5d53(player, var_55716d54) {
    self endon(#"death");
    player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_55716d54 + ".cooldown", 0);
    while (isdefined(player) && isdefined(player.vh_vehicle)) {
        var_42775dfe = 0;
        if (self function_b835102b()) {
            var_42775dfe = player function_dd63190a();
        } else {
            var_759ec838 = player getvehicleboosttime();
            boosttimeleft = player getvehicleboosttimeleft();
            if (var_759ec838 > 0) {
                var_42775dfe = boosttimeleft / var_759ec838;
            }
        }
        player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_55716d54 + ".cooldown", var_42775dfe);
        wait 0.05;
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x4
// Checksum 0xc6c01559, Offset: 0xe420
// Size: 0x168
function private function_1eab63e3(flare_lifetime = undefined) {
    if (!isdefined(flare_lifetime)) {
        flare_lifetime = 3;
    }
    lifetimes = [];
    for (var_b2814b11 = 0; var_b2814b11 < 4; var_b2814b11++) {
        if (!isdefined(lifetimes)) {
            lifetimes = [];
        } else if (!isarray(lifetimes)) {
            lifetimes = array(lifetimes);
        }
        lifetimes[lifetimes.size] = flare_lifetime - var_b2814b11 * 0.3;
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
// Checksum 0x290a2438, Offset: 0xe590
// Size: 0x26c
function fire_flares(*player, flare_tag = undefined, flare_lifetime = undefined) {
    var_f9a2afb9 = function_1eab63e3(flare_lifetime);
    for (var_558d81a6 = 0; var_558d81a6 < 4; var_558d81a6++) {
        model = "tag_origin";
        if (!isdefined(flare_tag)) {
            self.var_70eddc3b = !is_true(self.var_70eddc3b);
            start_tag = self.var_70eddc3b ? "tag_fx_flare_left" : "tag_fx_flare_right";
            start_origin = self gettagorigin(start_tag);
        } else {
            start_origin = self gettagorigin(flare_tag);
        }
        if (!isdefined(start_origin)) {
            start_origin = self gettagorigin("tag_origin") + (0, 0, 128);
        }
        if (isdefined(flare_tag)) {
            var_ac3aef54 = self gettagangles(flare_tag);
        }
        if (!isdefined(var_ac3aef54)) {
            var_ac3aef54 = self.angles;
        }
        flare = util::spawn_model(model, start_origin, var_ac3aef54);
        flare clientfield::set("play_flare_fx", 1);
        flare_lifetime = max(var_f9a2afb9[var_558d81a6] - var_558d81a6 * 0.15, 0.5);
        flare thread move_flare(self, (0, 0, -200), 0.5, 0.25, flare_lifetime, flare_tag);
        flare thread function_9ff1a886(self);
        wait 0.15;
    }
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0xc4f30c59, Offset: 0xe808
// Size: 0x17a
function function_e863c9af(owner, var_8fbb46cd, var_abfdfad5) {
    ownerforward = anglestoforward(owner.angles);
    if (!var_abfdfad5) {
        var_538c5a93 = vectornormalize((ownerforward[0], ownerforward[1], 0));
        velocity = var_538c5a93 * 1000;
        var_43fa4fb6 = vectornormalize((var_8fbb46cd[0], var_8fbb46cd[1], 0));
        velocity += function_7786cb5e(var_43fa4fb6, owner getvelocity()) * 1.2;
    } else {
        ownerforward = vectornormalize(ownerforward);
        velocity = ownerforward * 1000;
        var_8fbb46cd = vectornormalize(var_8fbb46cd);
        velocity += owner getvelocity() * 1.2;
    }
    velocity += (0, 0, 1) * 275;
    return velocity;
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xc71eaf98, Offset: 0xe990
// Size: 0x74
function function_7786cb5e(var_95d2171d, vector) {
    vector2d = (vector[0], vector[1], 0);
    dot = vectordot(var_95d2171d, vector2d);
    if (dot < 0) {
        vector2d -= var_95d2171d * dot;
    }
    return vector2d;
}

// Namespace vehicle/vehicle_shared
// Params 6, eflags: 0x0
// Checksum 0xeab327f8, Offset: 0xea10
// Size: 0x36c
function move_flare(owner, gravity, var_2434a7ac, var_2d0d8b66, max_time, flare_tag = undefined) {
    self endon(#"death");
    start_time = gettime();
    var_6de53efa = start_time + var_2434a7ac * 1000;
    end_time = start_time + max_time * 1000;
    if (isdefined(flare_tag)) {
        var_4626a28f = owner gettagangles(flare_tag);
        var_abfdfad5 = 1;
    } else {
        var_4626a28f = owner.angles;
        var_abfdfad5 = 0;
    }
    velocity = function_e863c9af(owner, anglestoforward(var_4626a28f), var_abfdfad5);
    var_c1ad7c79 = vectornormalize(velocity);
    while (gettime() < end_time) {
        if (gettime() > var_6de53efa) {
            newvelocity = velocity * (1 - (gettime() - var_6de53efa) / 1000 / (max_time - var_2434a7ac));
        } else {
            velocity = self getvelocity();
            var_c18f874c = vectornormalize(velocity);
            var_40a3c87d = function_e863c9af(owner, var_c18f874c, var_abfdfad5);
            velocity = lerpvector(velocity, var_40a3c87d, 0.5);
            newvelocity = velocity;
        }
        newvelocity += gravity * (gettime() - start_time) / 1000;
        movetopos = self.origin + newvelocity * var_2d0d8b66;
        traceresult = bullettrace(self.origin, movetopos, 0, owner, 0, 0, self);
        if (traceresult[#"fraction"] < 1) {
            if (traceresult[#"fraction"] > 0) {
                movetopos = traceresult[#"position"] + traceresult[#"normal"] * 0.1;
                var_2d0d8b66 *= traceresult[#"fraction"];
                self moveto(movetopos, var_2d0d8b66);
                self waittill(#"movedone");
            }
            break;
        }
        self moveto(movetopos, var_2d0d8b66);
        wait var_2d0d8b66;
    }
    if (gettime() < end_time) {
        wait (end_time - gettime()) / 1000;
    }
    self delete();
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xe2d03543, Offset: 0xed88
// Size: 0xd4
function function_b5f1f39(missile) {
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
// Checksum 0x8e8a5b23, Offset: 0xee68
// Size: 0x180
function function_d6c00549(owner, var_cc6abdaa) {
    if (isdefined(var_cc6abdaa) && isdefined(var_cc6abdaa.weapon)) {
        if (var_cc6abdaa.weapon.guidedmissiletype === "HeatSeeking" && var_cc6abdaa missile_gettarget() === owner) {
            self thread function_b5f1f39(var_cc6abdaa);
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
                self thread function_b5f1f39(missile);
                return true;
            }
        }
    }
    return false;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x164da998, Offset: 0xeff0
// Size: 0xbe
function function_9ff1a886(owner) {
    self endon(#"death");
    owner endon(#"death");
    self.var_8dfaef6b = 0;
    while (!self.var_8dfaef6b) {
        self.var_8dfaef6b = self function_d6c00549(owner);
        waitresult = owner waittill(#"stinger_fired_at_me");
        self.var_8dfaef6b = self function_d6c00549(owner, waitresult.projectile);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x4b348a3, Offset: 0xf0b8
// Size: 0x24
function function_ae93aef2(usephysics) {
    clientfield::set("vehUseMaterialPhysics", usephysics);
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x88ca11da, Offset: 0xf0e8
// Size: 0xcc
function function_1bb979ca(n_cooldown_time, e_player, var_a18a512) {
    e_player endon(#"death");
    var_e41dced6 = 0;
    var_d969828b = n_cooldown_time / 0.05;
    while (var_e41dced6 <= var_d969828b) {
        var_50d0d640 = mapfloat(0, var_d969828b, 0, 1, var_e41dced6);
        e_player clientfield::set_player_uimodel("vehicle.bindingCooldown" + var_a18a512 + ".cooldown", var_50d0d640);
        var_e41dced6++;
        wait 0.05;
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xfec432b5, Offset: 0xf1c0
// Size: 0x180
function function_78cfd053() {
    self endon(#"death");
    var_c56865cf = self.healthdefault;
    var_c96543ab = self.var_7812fce8;
    var_70fdf0cb = self.healthpoolsize;
    var_8ac0fa8 = [];
    for (n = 0; n < var_c96543ab; n++) {
        if (n == 0) {
            var_8ac0fa8[n] = var_c56865cf;
            continue;
        }
        var_8ac0fa8[n] = var_c56865cf - var_70fdf0cb * n;
    }
    var_8ac0fa8[var_8ac0fa8.size] = 0;
    while (true) {
        self waittill(#"damage");
        foreach (keys, n_health_threshold in var_8ac0fa8) {
            if (self.health > n_health_threshold) {
                break;
            }
        }
        self thread function_f2fa0421(var_8ac0fa8[keys - 1]);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xba3c90d1, Offset: 0xf348
// Size: 0x10c
function function_f2fa0421(n_health) {
    self notify(#"hash_7d33424c72addcf1");
    self endon(#"death", #"hash_7d33424c72addcf1");
    if (isdefined(level.playerhealth_regularregendelay)) {
        wait float(level.playerhealth_regularregendelay) / 1000;
    } else {
        wait 3;
    }
    var_ab73d707 = int(self.healthdefault * 0.0083);
    while (self.health < n_health) {
        self.health += var_ab73d707;
        if (self.health >= n_health) {
            self.health = n_health;
        }
        wait 0.1;
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x34e3743f, Offset: 0xf460
// Size: 0x28c
function function_ff77beb1(otherplayer = undefined) {
    if (!isdefined(self)) {
        return;
    }
    player = self;
    if (isdefined(player.var_19bc935c)) {
        player swap_character(player.var_19bc935c);
        player weapons::force_stowed_weapon_update();
        player.var_19bc935c = undefined;
        if (isdefined(otherplayer) && isdefined(otherplayer.var_19bc935c)) {
            otherplayer swap_character(otherplayer.var_19bc935c);
            otherplayer weapons::force_stowed_weapon_update();
            otherplayer.var_19bc935c = undefined;
        }
        return;
    }
    if (isdefined(otherplayer)) {
        var_9db4bbbe = spawnstruct();
        var_9db4bbbe.tag_stowed_back_weapon = player.tag_stowed_back;
        var_9db4bbbe.var_b6233805 = player.tag_stowed_hip;
        var_9db4bbbe.stowed_weapon = player getstowedweapon();
        var_9db4bbbe.bodytype = player getcharacterbodytype();
        var_9db4bbbe.outfit = player getcharacteroutfit();
        var_d8d89950 = spawnstruct();
        var_d8d89950.tag_stowed_back_weapon = otherplayer.tag_stowed_back;
        var_d8d89950.var_b6233805 = otherplayer.tag_stowed_hip;
        var_d8d89950.stowed_weapon = otherplayer getstowedweapon();
        var_d8d89950.bodytype = otherplayer getcharacterbodytype();
        var_d8d89950.outfit = otherplayer getcharacteroutfit();
        if (!isdefined(player.var_19bc935c)) {
            player.var_19bc935c = var_9db4bbbe;
        }
        if (!isdefined(otherplayer.var_19bc935c)) {
            otherplayer.var_19bc935c = var_d8d89950;
        }
        otherplayer swap_character(var_9db4bbbe);
        otherplayer function_269b4eca(var_9db4bbbe);
        player swap_character(var_d8d89950);
        player function_269b4eca(var_d8d89950);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x55f5766, Offset: 0xf6f8
// Size: 0x5c
function swap_character(var_19bc935c) {
    player = self;
    player setcharacterbodytype(var_19bc935c.bodytype);
    player setcharacteroutfit(var_19bc935c.outfit);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x4af898ac, Offset: 0xf760
// Size: 0xfc
function function_269b4eca(var_19bc935c) {
    player = self;
    player weapons::detach_all_weapons();
    player.tag_stowed_back = var_19bc935c.tag_stowed_back_weapon;
    if (isdefined(player.tag_stowed_back)) {
        player attach(player.tag_stowed_back, "tag_stowed_back", 1);
    } else if (level.weaponnone != var_19bc935c.stowed_weapon) {
        player setstowedweapon(var_19bc935c.stowed_weapon);
    }
    player.tag_stowed_hip = var_19bc935c.tag_stowed_back_weapon;
    if (isdefined(player.tag_stowed_hip)) {
        player attach(player.tag_stowed_hip.worldmodel, "tag_stowed_hip_rear", 1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x9006661b, Offset: 0xf868
// Size: 0x48
function function_16e6c35e(vehicle, player, seatindex) {
    if (isdefined(level.var_2513e40c)) {
        return [[ level.var_2513e40c ]](vehicle, player, seatindex);
    }
    return 1;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x78bbd930, Offset: 0xf8b8
// Size: 0x1a
function function_bc2025e(player) {
    player.var_5a44792f = 1;
}

