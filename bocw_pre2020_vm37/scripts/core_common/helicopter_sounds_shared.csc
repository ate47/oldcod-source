#using scripts\core_common\audio_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace helicopter_sounds;

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x6
// Checksum 0x5a643b91, Offset: 0x228
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"helicopter_sounds", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x4
// Checksum 0x6a9a45fa, Offset: 0x270
// Size: 0x5cc
function private function_70a657d8() {
    level._entityshutdowncbfunc = &heli_linkto_sound_ents_delete;
    level.helisoundvalues = [];
    init_heli_sound_values("cobra", "turbine", 65, 0.6, 0.8, 65, 1, 1.1);
    init_heli_sound_values("cobra", "top_rotor", 45, 0.7, 1, 45, 0.95, 1.1);
    init_heli_sound_values("cobra", "tail_rotor", 45, 0.5, 1, 45, 0.95, 1.1);
    init_heli_sound_values("hind", "turbine", 65, 0.6, 0.8, 65, 1, 1.1);
    init_heli_sound_values("hind", "top_rotor", 45, 0.7, 1, 45, 0.95, 1.1);
    init_heli_sound_values("hind", "tail_rotor", 45, 0.5, 1, 45, 0.95, 1.1);
    init_heli_sound_values("supply", "turbine", 65, 0.7, 1, 65, 1, 1.1);
    init_heli_sound_values("supply", "top_rotor", 35, 0.95, 1, 100, 1, 1.1);
    init_heli_sound_values("supply", "tail_rotor", 35, 0.95, 1, 45, 1, 1.1);
    init_heli_sound_values("huey", "turbine", 65, 0.7, 0.8, 65, 1, 1.1);
    init_heli_sound_values("huey", "top_rotor", 45, 0.8, 1, 45, 0.95, 1.1);
    init_heli_sound_values("huey", "tail_rotor", 45, 0.6, 1, 45, 0.95, 1);
    init_heli_sound_values("huey", "wind_rt", 45, 0.6, 1, 45, 0.95, 1);
    init_heli_sound_values("huey", "wind_lft", 45, 0.6, 1, 45, 0.95, 1);
    init_heli_sound_values("qrdrone", "turbine_idle", 30, 0.8, 0, 16, 0.9, 1.1);
    init_heli_sound_values("qrdrone", "turbine_moving", 30, 0, 0.9, 20, 0.9, 1.1);
    init_heli_sound_values("qrdrone", "turn", 5, 0, 1, 1, 1, 1);
    init_heli_sound_values("heli_guard", "turbine", 10, 0.9, 1, 30, 0.9, 1.05);
    init_heli_sound_values("heli_guard", "rotor", 10, 0.9, 1, 30, 0.9, 1.1);
    /#
        if (getdvarstring(#"helisounds") == "<dev string:x38>") {
            setdvar(#"helisounds", "<dev string:x38>");
        }
        level thread command_parser();
    #/
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 7, eflags: 0x0
// Checksum 0x6916e1a1, Offset: 0x848
// Size: 0x8a
function vehicle_is_firing_function(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    println("<dev string:x3c>" + bwastimejump);
    if (bwastimejump == 0) {
        self.isfiring = 0;
        return;
    }
    self.isfiring = 1;
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 8, eflags: 0x0
// Checksum 0x25c0bd9b, Offset: 0x8e0
// Size: 0x27c
function init_heli_sound_values(heli_type, part_type, max_speed_vol, min_vol, max_vol, max_speed_pitch, min_pitch, max_pitch) {
    if (!isdefined(level.helisoundvalues[heli_type])) {
        level.helisoundvalues[heli_type] = [];
    }
    if (!isdefined(level.helisoundvalues[heli_type][part_type])) {
        level.helisoundvalues[heli_type][part_type] = spawnstruct();
    }
    level.helisoundvalues[heli_type][part_type].speedvolumemax = max_speed_vol;
    level.helisoundvalues[heli_type][part_type].speedpitchmax = max_speed_pitch;
    level.helisoundvalues[heli_type][part_type].volumemin = min_vol;
    level.helisoundvalues[heli_type][part_type].volumemax = max_vol;
    level.helisoundvalues[heli_type][part_type].pitchmin = min_pitch;
    level.helisoundvalues[heli_type][part_type].pitchmax = max_pitch;
    /#
        if (getdvarint(#"debug_heli", 0) > 0) {
            println("<dev string:x54>" + heli_type);
            println("<dev string:x74>" + part_type);
            println("<dev string:x94>" + max_speed_vol);
            println("<dev string:xb8>" + min_vol);
            println("<dev string:xd6>" + max_vol);
            println("<dev string:xf4>" + max_speed_pitch);
            println("<dev string:x11a>" + min_pitch);
            println("<dev string:x13a>" + max_pitch);
        }
    #/
}

/#

    // Namespace helicopter_sounds/helicopter_sounds_shared
    // Params 0, eflags: 0x0
    // Checksum 0x9e7722d6, Offset: 0xb68
    // Size: 0x538
    function command_parser() {
        while (true) {
            command = getdvarstring(#"helisounds");
            if (command != "<dev string:x38>") {
                success = 1;
                tokens = strtok(command, "<dev string:x15a>");
                if (!isdefined(tokens[0]) || !isdefined(level.helisoundvalues[tokens[0]])) {
                    if (isdefined(tokens[0])) {
                        println("<dev string:x15f>" + tokens[0]);
                    } else {
                        println("<dev string:x192>");
                    }
                    println("<dev string:x1c2>");
                    success = 0;
                } else if (!isdefined(tokens[1])) {
                    if (isdefined(tokens[1])) {
                        println("<dev string:x20f>" + tokens[0] + "<dev string:x242>" + tokens[1]);
                    } else {
                        println("<dev string:x251>" + tokens[0]);
                    }
                    println("<dev string:x1c2>");
                    success = 0;
                } else if (!isdefined(tokens[2])) {
                    println("<dev string:x28c>" + tokens[0] + "<dev string:x2cc>" + tokens[1]);
                    println("<dev string:x1c2>");
                    success = 0;
                } else if (!isdefined(tokens[3])) {
                    println("<dev string:x2d7>" + tokens[0] + "<dev string:x2cc>" + tokens[1]);
                    println("<dev string:x1c2>");
                    success = 0;
                }
                if (success) {
                    heli_type = tokens[0];
                    heli_part = tokens[1];
                    value_name = tokens[2];
                    value = float(tokens[3]);
                    switch (value_name) {
                    case #"volumemin":
                        level.helisoundvalues[heli_type][heli_part].volumemin = value;
                        println("<dev string:x312>" + value);
                        break;
                    case #"volumemax":
                        level.helisoundvalues[heli_type][heli_part].volumemax = value;
                        println("<dev string:x32b>" + value);
                        break;
                    case #"pitchmin":
                        level.helisoundvalues[heli_type][heli_part].pitchmin = value;
                        println("<dev string:x344>" + value);
                        break;
                    case #"pitchmax":
                        level.helisoundvalues[heli_type][heli_part].pitchmax = value;
                        println("<dev string:x35c>" + value);
                        break;
                    case #"speedvolumemax":
                        level.helisoundvalues[heli_type][heli_part].speedvolumemax = value;
                        println("<dev string:x374>" + value);
                        break;
                    case #"speedpitchmax":
                        level.helisoundvalues[heli_type][heli_part].speedpitchmax = value;
                        println("<dev string:x392>" + value);
                        break;
                    default:
                        println("<dev string:x3af>");
                        break;
                    }
                }
                setdvar(#"helisounds", "<dev string:x38>");
            }
            wait 0.1;
        }
    }

#/

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x793bed6e, Offset: 0x10a8
// Size: 0x162
function init_heli_sounds_gunner() {
    setup_heli_sounds("lfe", "engine", "snd_cockpit", #"veh_huey_rotor_lfe");
    setup_heli_sounds("turbine", "engine", "snd_rotor", #"veh_huey_turbine");
    setup_heli_sounds("top_rotor", "engine", "snd_rotor", #"veh_huey_rotor");
    setup_heli_sounds("tail_rotor", "engine", "snd_tail_rotor", #"veh_huey_tail");
    setup_heli_sounds("wind_rt", "engine", "snd_wind_right", #"veh_huey_door_wind");
    setup_heli_sounds("radio", "engine", "snd_cockpit", #"veh_huey_radio");
    self.warning_tag = "snd_cockpit";
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0xf1e69b85, Offset: 0x1218
// Size: 0xf2
function init_heli_sounds_player_controlled() {
    setup_heli_sounds("lfe", "engine", "snd_cockpit", #"veh_cobra_rotor_lfe");
    setup_heli_sounds("turbine", "engine", "snd_rotor", #"veh_cobra_turbine");
    setup_heli_sounds("top_rotor", "engine", "snd_rotor", #"veh_cobra_rotor");
    setup_heli_sounds("tail_rotor", "engine", "snd_tail_rotor", #"veh_cobra_tail");
    self.warning_tag = "snd_cockpit";
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x4e6a3543, Offset: 0x1318
// Size: 0x9e
function init_heli_sounds_supply() {
    setup_heli_sounds("lfe", "engine", undefined, #"veh_supply_rotor_lfe");
    setup_heli_sounds("turbine", "engine", undefined, #"veh_supply_turbine");
    setup_heli_sounds("top_rotor", "engine", undefined, #"veh_supply_rotor");
    self.warning_tag = undefined;
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x1db29e35, Offset: 0x13c0
// Size: 0xce
function init_heli_sounds_ai_attack() {
    setup_heli_sounds("lfe", "engine", undefined, #"veh_hind_rotor_lfe");
    setup_heli_sounds("turbine", "engine", undefined, #"veh_hind_turbine");
    setup_heli_sounds("top_rotor", "engine", undefined, #"veh_hind_rotor");
    setup_heli_sounds("tail_rotor", "engine", undefined, #"veh_hind_tail");
    self.warning_tag = undefined;
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x38c5d7ef, Offset: 0x1498
// Size: 0xb6
function init_heli_sounds_player_drone() {
    setup_heli_sounds("turbine_idle", "engine", "tag_body", #"veh_qrdrone_turbine_idle");
    setup_heli_sounds("turbine_moving", "engine", "tag_body", #"veh_qrdrone_turbine_moving");
    setup_heli_sounds("turn", "engine", "tag_body", #"veh_qrdrone_idle_rotate");
    self.warning_tag = undefined;
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x9db982ae, Offset: 0x1558
// Size: 0x9e
function init_heli_sounds_heli_guard() {
    setup_heli_sounds("lfe", "engine", undefined, #"veh_overwatch_lfe");
    setup_heli_sounds("turbine", "engine", undefined, #"veh_overwatch_turbine");
    setup_heli_sounds("rotor", "engine", undefined, #"veh_overwatch_rotor");
    self.warning_tag = undefined;
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 2, eflags: 0x0
// Checksum 0xea603932, Offset: 0x1600
// Size: 0x5c
function sound_linkto(parent, tag) {
    if (isdefined(tag)) {
        self linkto(parent, tag);
        return;
    }
    self linkto(parent, "tag_body");
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 7, eflags: 0x0
// Checksum 0x2df54268, Offset: 0x1668
// Size: 0x324
function setup_heli_sounds(bone_location, type, tag, run, dmg1, dmg2, dmg3) {
    self.heli[bone_location] = spawnstruct();
    self.heli[bone_location].sound_type = type;
    self.heli[bone_location].run = spawn(0, self.origin, "script_origin");
    self.heli[bone_location].run sound_linkto(self, tag);
    self.heli[bone_location].run.alias = run;
    self thread heli_loop_sound_delete(self.heli[bone_location].run);
    if (isdefined(dmg1)) {
        self.heli[bone_location].idle = spawn(0, self.origin, "script_origin");
        self.heli[bone_location].idle sound_linkto(self, tag);
        self.heli[bone_location].idle.alias = dmg1;
        self thread heli_loop_sound_delete(self.heli[bone_location].dmg1);
    }
    if (isdefined(dmg2)) {
        self.heli[bone_location].idle = spawn(0, self.origin, "script_origin");
        self.heli[bone_location].idle sound_linkto(self, tag);
        self.heli[bone_location].idle.alias = dmg2;
        self thread heli_loop_sound_delete(self.heli[bone_location].dmg2);
    }
    if (isdefined(dmg3)) {
        self.heli[bone_location].idle = spawn(0, self.origin, "script_origin");
        self.heli[bone_location].idle sound_linkto(self, tag);
        self.heli[bone_location].idle.alias = dmg3;
        self thread heli_loop_sound_delete(self.heli[bone_location].dmg3);
    }
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0xba06ff6e, Offset: 0x1998
// Size: 0x27c
function init_terrain_sounds() {
    self.surface_type = [];
    self.surface_type[#"default"] = "dirt";
    self.surface_type[#"metal"] = "dirt";
    self.surface_type[#"concrete"] = "dirt";
    self.surface_type[#"wood"] = "dirt";
    self.surface_type[#"dirt"] = "dirt";
    self.surface_type[#"gravel"] = "dirt";
    self.surface_type[#"grass"] = "dirt";
    self.surface_type[#"mud"] = "dirt";
    self.surface_type[#"snow"] = "dirt";
    self.surface_type[#"asphalt"] = "dirt";
    self.surface_type[#"brick"] = "dirt";
    self.surface_type[#"glass"] = "dirt";
    self.surface_type[#"plaster"] = "dirt";
    self.surface_type[#"sand"] = "dirt";
    self.surface_type[#"rock"] = "dirt";
    self.surface_type[#"water"] = "water";
    self.surface_type[#"foliage"] = "dirt";
    self setup_terrain_sounds("dirt", "veh_chopper_prop_wash_dirt");
    self setup_terrain_sounds("water", "veh_chopper_prop_wash_water");
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 2, eflags: 0x0
// Checksum 0x44f6a9df, Offset: 0x1c20
// Size: 0x7c
function setup_terrain_sounds(surface_type, alias) {
    self.terrain_ent_array[surface_type] = spawn(0, self.origin, "script_origin");
    self.terrain_ent_array[surface_type].alias = alias;
    self thread heli_loop_sound_delete(self.terrain_ent_array[surface_type]);
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 2, eflags: 0x0
// Checksum 0xf761d9e2, Offset: 0x1ca8
// Size: 0x7c
function setup_terrain_brass_sounds(surface_type, alias) {
    self.terrain_brass_ent_array[surface_type] = spawn(0, self.origin, "script_origin");
    self.terrain_brass_ent_array[surface_type].alias = alias;
    self thread heli_loop_sound_delete(self.terrain_brass_ent_array[surface_type]);
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0xe3fb3e66, Offset: 0x1d30
// Size: 0x1e4
function start_helicopter_sounds(*localclientnum) {
    if (isdefined(self.sounddef)) {
        self.heli = [];
        self.terrain = [];
        self.sound_ents = [];
        self.cur_speed = 0;
        self.mph_to_inches_per_sec = 17.6;
        self.speed_of_wind = 20;
        self.idle_run_trans_speed = 5;
        switch (self.sounddef) {
        case #"veh_heli_ai_mp":
            break;
        case #"veh_heli_guard_mp":
            break;
        case #"veh_heli_supplydrop_mp":
            break;
        case #"veh_heli_gunner_mp":
            break;
        case #"veh_heli_player_gunner_mp":
            break;
        case #"veh_drn_qrdrone_mp":
            break;
        default:
            println("<dev string:x40c>" + self.vehicletype + "<dev string:x423>");
            break;
        }
        self init_terrain_sounds();
        self thread terrain_trace();
        /#
            if (getdvarint(#"debug_heli", 0) > 0) {
                iprintlnbold("<dev string:x451>" + self.vehicletype + "<dev string:x466>");
            }
        #/
        return;
    }
    println("<dev string:x476>");
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0xbcf8e077, Offset: 0x1f20
// Size: 0x64
function heli_loop_sound_delete(real_ent) {
    self waittill(#"death");
    real_ent unlink();
    real_ent stopallloopsounds(4);
    real_ent delete();
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 2, eflags: 0x0
// Checksum 0xca4f1f40, Offset: 0x1f90
// Size: 0x28
function heli_linkto_sound_ents_delete(*localclientnum, entity) {
    entity notify(#"death");
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0xb78b3925, Offset: 0x1fc0
// Size: 0xc2
function heli_sound_play(heli_bone) {
    switch (heli_bone.sound_type) {
    case #"engine":
        heli_bone.run playloopsound(heli_bone.run.alias, 2);
        break;
    case #"wind":
        break;
    default:
        println("<dev string:x4b2>" + heli_bone.type + "<dev string:x4d2>");
        break;
    }
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0xae1763f1, Offset: 0x2090
// Size: 0xa4
function play_player_controlled_sounds() {
    self heli_sound_play(self.heli[#"lfe"]);
    self thread heli_idle_run_transition("cobra", "turbine");
    self thread heli_idle_run_transition("cobra", "top_rotor");
    self thread heli_idle_run_transition("cobra", "tail_rotor");
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0xf1def73f, Offset: 0x2140
// Size: 0xa4
function play_attack_ai_sounds() {
    self heli_sound_play(self.heli[#"lfe"]);
    self thread heli_idle_run_transition("hind", "turbine");
    self thread heli_idle_run_transition("hind", "top_rotor");
    self thread heli_idle_run_transition("hind", "tail_rotor");
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0xacbb8ef, Offset: 0x21f0
// Size: 0x7c
function play_supply_sounds() {
    self thread heli_idle_run_transition("supply", "turbine");
    self thread heli_idle_run_transition("supply", "top_rotor");
    self heli_sound_play(self.heli[#"lfe"]);
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x3260c31b, Offset: 0x2278
// Size: 0xf4
function play_gunner_sounds() {
    self heli_sound_play(self.heli[#"lfe"]);
    self heli_sound_play(self.heli[#"radio"]);
    self thread heli_idle_run_transition("huey", "turbine");
    self thread heli_idle_run_transition("huey", "top_rotor");
    self thread heli_idle_run_transition("huey", "tail_rotor");
    self thread heli_idle_run_transition("huey", "wind_rt");
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2378
// Size: 0x4
function play_player_drone_sounds() {
    
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x578d2f51, Offset: 0x2388
// Size: 0x94
function play_heli_guard_sounds() {
    self heli_sound_play(self.heli[#"lfe"]);
    self thread heli_idle_run_transition("heli_guard", "turbine");
    self thread heli_idle_run_transition("heli_guard", "rotor");
    self thread terrain_trace_brass();
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 4, eflags: 0x0
// Checksum 0xa9af23b3, Offset: 0x2428
// Size: 0x426
function heli_idle_run_transition(heli_type, heli_part, wait_time, updown) {
    self endon(#"death");
    heli_bone = self.heli[heli_part];
    run_id = heli_bone.run playloopsound(heli_bone.run.alias, 0.5);
    if (!isdefined(wait_time)) {
        wait_time = 0.5;
    }
    while (isdefined(self)) {
        if (!isdefined(level.helisoundvalues[heli_type]) || !isdefined(level.helisoundvalues[heli_type][heli_part])) {
            println("<dev string:x4f3>");
            return;
        }
        max_speed_vol = level.helisoundvalues[heli_type][heli_part].speedvolumemax;
        min_vol = level.helisoundvalues[heli_type][heli_part].volumemin;
        max_vol = level.helisoundvalues[heli_type][heli_part].volumemax;
        max_speed_pitch = level.helisoundvalues[heli_type][heli_part].speedpitchmax;
        min_pitch = level.helisoundvalues[heli_type][heli_part].pitchmin;
        max_pitch = level.helisoundvalues[heli_type][heli_part].pitchmax;
        plr_vel = self getvelocity();
        self.cur_speed = abs(sqrt(vectordot(plr_vel, plr_vel))) / self.mph_to_inches_per_sec;
        run_volume = audio::scale_speed(self.idle_run_trans_speed, max_speed_vol, min_vol, max_vol, self.cur_speed);
        run_pitch = audio::scale_speed(self.idle_run_trans_speed, max_speed_pitch, min_pitch, max_pitch, self.cur_speed);
        if (isdefined(updown)) {
            if (!isdefined(self.qrdrone_z_difference)) {
                self.qrdrone_z_difference = 0;
            }
            run_volume_vertical = audio::scale_speed(5, 50, 0, 1, abs(self.qrdrone_z_difference));
            run_volume -= run_volume_vertical;
        }
        if (isdefined(run_volume) && isdefined(run_pitch)) {
            heli_bone.run setloopstate(heli_bone.run.alias, run_volume, run_pitch, 1, 0.15);
            /#
                if (getdvarint(#"debug_heli", 0) > 0) {
                    println("<dev string:x525>" + self.cur_speed);
                    println("<dev string:x53e>" + run_pitch);
                    println("<dev string:x525>" + self.cur_speed);
                    println("<dev string:x552>" + run_volume);
                }
            #/
        }
        wait wait_time;
    }
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x5187295a, Offset: 0x2858
// Size: 0x370
function terrain_trace_brass() {
    self endon(#"death");
    self setup_terrain_brass_sounds("dirt", "prj_brass_loop_dirt");
    self setup_terrain_brass_sounds("water", "prj_brass_loop_water");
    self.isfiring = 0;
    trace = undefined;
    trace_ent = self;
    pre_terrain = undefined;
    next_terrain = undefined;
    pre_trace_real_ent = undefined;
    trace_real_ent = undefined;
    pre_origin = (100000, 100000, 100000);
    while (isdefined(self)) {
        wait 1 + randomfloatrange(0, 0.2);
        if (distancesquared(pre_origin, trace_ent.origin) < 144) {
            continue;
        }
        pre_origin = trace_ent.origin;
        trace = tracepoint(trace_ent.origin, trace_ent.origin - (0, 0, 100000));
        trace_surface_type = trace[#"surfacetype"];
        if (!isdefined(trace)) {
            continue;
        }
        pre_terrain = next_terrain;
        next_terrain = trace_surface_type;
        if (!isdefined(pre_terrain) || !isdefined(next_terrain)) {
            continue;
        }
        if (!isdefined(self.surface_type[next_terrain]) || !isdefined(self.surface_type[pre_terrain])) {
            /#
            #/
            continue;
        }
        surf_type = self.surface_type[next_terrain];
        trace_real_ent = self.terrain_brass_ent_array[surf_type];
        pre_surf_type = self.surface_type[pre_terrain];
        pre_trace_real_ent = self.terrain_brass_ent_array[pre_surf_type];
        if (!isdefined(trace[#"position"])) {
            if (isdefined(pre_trace_real_ent)) {
                pre_trace_real_ent stopallloopsounds(0.5);
            }
            continue;
        }
        if (!self.isfiring) {
            pre_trace_real_ent stopallloopsounds(0.5);
        }
        trace_real_ent.origin = trace[#"position"];
        pre_trace_real_ent.origin = trace[#"position"];
        if (isdefined(surf_type) && self.isfiring) {
            if (surf_type == pre_surf_type && pre_trace_real_ent isplayingloopsound()) {
                continue;
            }
            pre_trace_real_ent stopallloopsounds(0.5);
            trace_real_ent playloopsound(trace_real_ent.alias, 0.75);
        }
    }
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0xdc5b61c7, Offset: 0x2bd0
// Size: 0x2e0
function terrain_trace() {
    self endon(#"death");
    trace = undefined;
    trace_ent = self;
    pre_terrain = undefined;
    next_terrain = undefined;
    pre_trace_real_ent = undefined;
    trace_real_ent = undefined;
    pre_origin = (100000, 100000, 100000);
    while (isdefined(self)) {
        wait 1 + randomfloatrange(0, 0.2);
        if (distancesquared(pre_origin, trace_ent.origin) < 144) {
            continue;
        }
        pre_origin = trace_ent.origin;
        trace = tracepoint(trace_ent.origin, trace_ent.origin - (0, 0, 100000));
        trace_surface_type = trace[#"surfacetype"];
        if (!isdefined(trace)) {
            continue;
        }
        pre_terrain = next_terrain;
        next_terrain = trace_surface_type;
        if (!isdefined(pre_terrain) || !isdefined(next_terrain)) {
            continue;
        }
        if (!isdefined(self.surface_type[next_terrain]) || !isdefined(self.surface_type[pre_terrain])) {
            /#
            #/
            continue;
        }
        surf_type = self.surface_type[next_terrain];
        trace_real_ent = self.terrain_ent_array[surf_type];
        pre_surf_type = self.surface_type[pre_terrain];
        pre_trace_real_ent = self.terrain_ent_array[pre_surf_type];
        if (!isdefined(trace[#"position"])) {
            if (isdefined(pre_trace_real_ent)) {
                pre_trace_real_ent stopallloopsounds(0.5);
            }
            continue;
        }
        trace_real_ent.origin = trace[#"position"];
        pre_trace_real_ent.origin = trace[#"position"];
        if (isdefined(surf_type)) {
            if (surf_type == pre_surf_type && pre_trace_real_ent isplayingloopsound()) {
                continue;
            }
            pre_trace_real_ent stopallloopsounds(0.5);
            trace_real_ent playloopsound(trace_real_ent.alias, 0.5);
        }
    }
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0xb580003a, Offset: 0x2eb8
// Size: 0x3d8
function aircraft_dustkick(localclientnum) {
    println("<dev string:x566>");
    self endon(#"death");
    maxheight = 1200;
    minheight = 350;
    if (self.vehicletype == #"qrdrone_mp") {
        maxheight = 120;
        minheight = 1;
    }
    slowestrepeatwait = 0.15;
    fastestrepeatwait = 0.05;
    numframespertrace = 3;
    dotracethisframe = numframespertrace;
    defaultrepeatrate = 1;
    repeatrate = defaultrepeatrate;
    trace = undefined;
    d = undefined;
    trace_ent = self;
    while (isdefined(self)) {
        if (repeatrate <= 0) {
            repeatrate = defaultrepeatrate;
        }
        if (!util::server_wait(localclientnum, repeatrate)) {
            continue;
        }
        if (!isdefined(self)) {
            return;
        }
        dotracethisframe--;
        if (dotracethisframe <= 0) {
            dotracethisframe = numframespertrace;
            trace = bullettrace(trace_ent.origin, trace_ent.origin - (0, 0, 100000), 0, trace_ent, 1);
            d = distance(trace_ent.origin, trace[#"position"]);
            repeatrate = (d - minheight) / (maxheight - minheight) * (slowestrepeatwait - fastestrepeatwait) + fastestrepeatwait;
        }
        if (!isdefined(trace)) {
            continue;
        }
        assert(isdefined(d));
        if (d > maxheight) {
            repeatrate = defaultrepeatrate;
            continue;
        }
        if (isdefined(trace[#"entity"])) {
            repeatrate = defaultrepeatrate;
            continue;
        }
        if (!isdefined(trace[#"position"])) {
            repeatrate = defaultrepeatrate;
            continue;
        }
        if (!isdefined(trace[#"surfacetype"])) {
            trace[#"surfacetype"] = "dirt";
        }
        if (!isdefined(self.treadfxnamearray) || !isdefined(self.treadfxnamearray[trace[#"surfacetype"]])) {
            /#
                if (isdefined(self.vehicletype)) {
                    println("<dev string:x583>" + trace[#"surfacetype"] + "<dev string:x5aa>" + self.vehicletype);
                    return;
                }
                println("<dev string:x583>" + trace[#"surfacetype"] + "<dev string:x5c0>");
            #/
            return;
        }
        if (isdefined(self.treadfxnamearray[trace[#"surfacetype"]])) {
            playfx(localclientnum, self.treadfxnamearray[trace[#"surfacetype"]], trace[#"position"]);
        }
    }
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 3, eflags: 0x0
// Checksum 0xfff12b65, Offset: 0x3298
// Size: 0x80
function play_targeting_sound(play, sound, handle) {
    sound_ent = get_lock_sound_ent();
    if (play) {
        return sound_ent playloopsound(sound);
    }
    if (isdefined(handle)) {
        sound_ent stopallloopsounds(0.1);
        return undefined;
    }
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0x67b41e5e, Offset: 0x3320
// Size: 0x3a
function play_targeted_sound(play) {
    self.lockingsound = play_targeting_sound(play, #"veh_hind_alarm_missile_locking_mp", self.lockingsound);
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0xcae6ef0d, Offset: 0x3368
// Size: 0x3a
function play_locked_sound(play) {
    self.lockedsound = play_targeting_sound(play, #"veh_hind_alarm_missile_locked_mp", self.lockedsound);
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0x979163c6, Offset: 0x33b0
// Size: 0x3a
function play_fired_sound(play) {
    self.firedsound = play_targeting_sound(play, #"veh_hind_alarm_missile_fired", self.firedsound);
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0x30f22946, Offset: 0x33f8
// Size: 0x8c
function play_leaving_battlefield_alarm(play) {
    sound_ent = get_leaving_sound_ent();
    if (play) {
        self.leavingbattlefieldsound = sound_ent playloopsound(#"veh_helicopter_alarm");
        return;
    }
    if (isdefined(self.leavingbattlefieldsound) && self.leavingbattlefieldsound) {
        sound_ent stopallloopsounds(0.1);
    }
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0x7e95415a, Offset: 0x3490
// Size: 0xa8
function get_heli_sound_ent(sound_ent) {
    if (!isdefined(sound_ent)) {
        tag = "tag_origin";
        if (isdefined(self.warning_tag)) {
            tag = self.warning_tag;
        }
        sound_ent = spawn(0, self gettagorigin(tag), "script_origin");
        sound_ent linkto(self, tag);
        self thread heli_sound_ent_delete(sound_ent);
    }
    return sound_ent;
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x4e547c71, Offset: 0x3540
// Size: 0x2a
function get_lock_sound_ent() {
    self.lock_sound_ent = get_heli_sound_ent(self.lock_sound_ent);
    return self.lock_sound_ent;
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x3672d837, Offset: 0x3578
// Size: 0x2a
function get_leaving_sound_ent() {
    self.leaving_sound_ent = get_heli_sound_ent(self.leaving_sound_ent);
    return self.leaving_sound_ent;
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0x944fb57d, Offset: 0x35b0
// Size: 0x54
function heli_sound_ent_delete(real_ent) {
    self waittill(#"death");
    real_ent stopallloopsounds(0.1);
    real_ent delete();
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x2c619df9, Offset: 0x3610
// Size: 0x4f0
function drone_up_down_transition() {
    self endon(#"death");
    volumerate = 1;
    qr_ent_up = spawn(0, self.origin, "script_origin");
    qr_ent_down = spawn(0, self.origin, "script_origin");
    qr_ent_either = spawn(0, self.origin, "script_origin");
    qr_ent_up thread qr_ent_cleanup(self);
    qr_ent_down thread qr_ent_cleanup(self);
    qr_ent_either thread qr_ent_cleanup(self);
    self.qrdrone_z_difference = 0;
    down = qr_ent_down playloopsound(#"veh_qrdrone_move_down");
    qr_ent_down setloopstate(#"veh_qrdrone_move_down", 0, 0);
    up = qr_ent_up playloopsound(#"veh_qrdrone_move_up");
    qr_ent_up setloopstate(#"veh_qrdrone_move_up", 0, 0);
    either = qr_ent_either playloopsound(#"veh_qrdrone_vertical");
    qr_ent_either setloopstate(#"veh_qrdrone_vertical", 0, 0);
    tag = "tag_body";
    qr_ent_up linkto(self, tag);
    qr_ent_down linkto(self, tag);
    qr_ent_either linkto(self, tag);
    self thread drone_button_watch();
    while (true) {
        last_pos = self.origin[2];
        wait 0.1;
        self.qrdrone_z_difference = last_pos - self.origin[2];
        if (self.qrdrone_z_difference < 0) {
            up_difference = self.qrdrone_z_difference * -1;
            run_volume_up = audio::scale_speed(5, 40, 0, 1, up_difference);
            run_pitch_up = audio::scale_speed(5, 40, 0.9, 1.1, up_difference);
            run_volume_either = audio::scale_speed(5, 50, 0, 1, up_difference);
            run_pitch_either = audio::scale_speed(5, 50, 0.9, 1.1, up_difference);
        } else {
            run_volume_up = 0;
            run_pitch_up = 1;
            run_volume_either = audio::scale_speed(5, 50, 0, 1, self.qrdrone_z_difference);
            run_pitch_either = audio::scale_speed(5, 50, 0.95, 0.8, self.qrdrone_z_difference);
        }
        run_volume_down = audio::scale_speed(5, 50, 0, 1, self.qrdrone_z_difference);
        run_pitch_down = audio::scale_speed(5, 50, 1, 0.8, self.qrdrone_z_difference);
        qr_ent_down setloopstate(#"veh_qrdrone_move_down", run_volume_down, run_pitch_down, volumerate);
        qr_ent_up setloopstate(#"veh_qrdrone_move_up", run_volume_up, run_pitch_up, volumerate);
        qr_ent_either setloopstate(#"veh_qrdrone_vertical", run_volume_either, run_pitch_either, volumerate);
    }
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0x4c9a1f89, Offset: 0x3b08
// Size: 0x3c
function qr_ent_cleanup(veh_ent) {
    veh_ent waittill(#"death");
    self delete();
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 2, eflags: 0x0
// Checksum 0x50956720, Offset: 0x3b50
// Size: 0x220
function drone_rotate_angle(*heli_type, *heli_part) {
    self endon(#"death");
    level endon(#"save_restore");
    volumerate = 2.5;
    qr_ent_angle = spawn(0, self.origin, "script_origin");
    qr_ent_angle thread qr_ent_cleanup(self);
    angle = qr_ent_angle playloopsound(#"veh_qrdrone_idle_rotate");
    setsoundvolume(angle, 0);
    tag = "tag_body";
    qr_ent_angle linkto(self, tag);
    while (true) {
        last_angle = abs(self.angles[1]);
        wait 0.1;
        turning_speed = last_angle - abs(self.angles[1]);
        abs_turning_speed = abs(turning_speed);
        jet_stick_vol = audio::scale_speed(0, 5, 0, 0.4, abs_turning_speed);
        jet_stick_pitch = audio::scale_speed(0, 4, 0.9, 1.05, abs_turning_speed);
        qr_ent_angle setloopstate(#"veh_qrdrone_idle_rotate", jet_stick_vol, jet_stick_pitch, volumerate);
    }
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x75eef9fd, Offset: 0x3d78
// Size: 0xe2
function drone_button_watch() {
    self endon(#"death");
    player = getlocalplayers()[0];
    return_to_zero = 1;
    while (true) {
        if (abs(self.qrdrone_z_difference) > 5 && return_to_zero) {
            self playsound(0, #"veh_qrdrone_move_start");
            return_to_zero = 0;
        } else if (abs(self.qrdrone_z_difference) < 5 && !return_to_zero) {
            return_to_zero = 1;
        }
        waitframe(1);
    }
}

