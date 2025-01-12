#using scripts\core_common\audio_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace helicopter_sounds;

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x2
// Checksum 0x8647edb1, Offset: 0x238
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"helicopter_sounds", &__init__, undefined, undefined);
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x663a6055, Offset: 0x280
// Size: 0x5cc
function __init__() {
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
        if (getdvarstring(#"helisounds") == "<dev string:x30>") {
            setdvar(#"helisounds", "<dev string:x30>");
        }
        level thread command_parser();
    #/
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 7, eflags: 0x0
// Checksum 0x676c2c14, Offset: 0x858
// Size: 0x8a
function vehicle_is_firing_function(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    println("<dev string:x31>" + newval);
    if (newval == 0) {
        self.isfiring = 0;
        return;
    }
    self.isfiring = 1;
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 8, eflags: 0x0
// Checksum 0xa3b2d58d, Offset: 0x8f0
// Size: 0x2a4
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
            println("<dev string:x46>" + heli_type);
            println("<dev string:x63>" + part_type);
            println("<dev string:x80>" + max_speed_vol);
            println("<dev string:xa1>" + min_vol);
            println("<dev string:xbc>" + max_vol);
            println("<dev string:xd7>" + max_speed_pitch);
            println("<dev string:xfa>" + min_pitch);
            println("<dev string:x117>" + max_pitch);
        }
    #/
}

/#

    // Namespace helicopter_sounds/helicopter_sounds_shared
    // Params 0, eflags: 0x0
    // Checksum 0x8407ee29, Offset: 0xba0
    // Size: 0x580
    function command_parser() {
        while (true) {
            command = getdvarstring(#"helisounds");
            if (command != "<dev string:x30>") {
                success = 1;
                tokens = strtok(command, "<dev string:x134>");
                if (!isdefined(tokens[0]) || !isdefined(level.helisoundvalues[tokens[0]])) {
                    if (isdefined(tokens[0])) {
                        println("<dev string:x136>" + tokens[0]);
                    } else {
                        println("<dev string:x166>");
                    }
                    println("<dev string:x193>");
                    success = 0;
                } else if (!isdefined(tokens[1])) {
                    if (isdefined(tokens[1])) {
                        println("<dev string:x1dd>" + tokens[0] + "<dev string:x20d>" + tokens[1]);
                    } else {
                        println("<dev string:x219>" + tokens[0]);
                    }
                    println("<dev string:x193>");
                    success = 0;
                } else if (!isdefined(tokens[2])) {
                    println("<dev string:x251>" + tokens[0] + "<dev string:x28e>" + tokens[1]);
                    println("<dev string:x193>");
                    success = 0;
                } else if (!isdefined(tokens[3])) {
                    println("<dev string:x296>" + tokens[0] + "<dev string:x28e>" + tokens[1]);
                    println("<dev string:x193>");
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
                        println("<dev string:x2ce>" + value);
                        break;
                    case #"volumemax":
                        level.helisoundvalues[heli_type][heli_part].volumemax = value;
                        println("<dev string:x2e4>" + value);
                        break;
                    case #"pitchmin":
                        level.helisoundvalues[heli_type][heli_part].pitchmin = value;
                        println("<dev string:x2fa>" + value);
                        break;
                    case #"pitchmax":
                        level.helisoundvalues[heli_type][heli_part].pitchmax = value;
                        println("<dev string:x30f>" + value);
                        break;
                    case #"speedvolumemax":
                        level.helisoundvalues[heli_type][heli_part].speedvolumemax = value;
                        println("<dev string:x324>" + value);
                        break;
                    case #"speedpitchmax":
                        level.helisoundvalues[heli_type][heli_part].speedpitchmax = value;
                        println("<dev string:x33f>" + value);
                        break;
                    default:
                        println("<dev string:x359>");
                        break;
                    }
                }
                setdvar(#"helisounds", "<dev string:x30>");
            }
            wait 0.1;
        }
    }

#/

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x7d7dabc6, Offset: 0x1128
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
// Checksum 0xa3e5117, Offset: 0x1298
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
// Checksum 0xf06554ce, Offset: 0x1398
// Size: 0x9e
function init_heli_sounds_supply() {
    setup_heli_sounds("lfe", "engine", undefined, #"veh_supply_rotor_lfe");
    setup_heli_sounds("turbine", "engine", undefined, #"veh_supply_turbine");
    setup_heli_sounds("top_rotor", "engine", undefined, #"veh_supply_rotor");
    self.warning_tag = undefined;
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0xefa3904, Offset: 0x1440
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
// Checksum 0x654dd82b, Offset: 0x1518
// Size: 0xb6
function init_heli_sounds_player_drone() {
    setup_heli_sounds("turbine_idle", "engine", "tag_body", #"veh_qrdrone_turbine_idle");
    setup_heli_sounds("turbine_moving", "engine", "tag_body", #"veh_qrdrone_turbine_moving");
    setup_heli_sounds("turn", "engine", "tag_body", #"veh_qrdrone_idle_rotate");
    self.warning_tag = undefined;
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0xf72a3408, Offset: 0x15d8
// Size: 0x9e
function init_heli_sounds_heli_guard() {
    setup_heli_sounds("lfe", "engine", undefined, #"veh_overwatch_lfe");
    setup_heli_sounds("turbine", "engine", undefined, #"veh_overwatch_turbine");
    setup_heli_sounds("rotor", "engine", undefined, #"veh_overwatch_rotor");
    self.warning_tag = undefined;
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 2, eflags: 0x0
// Checksum 0x45ad226f, Offset: 0x1680
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
// Checksum 0x7994fb2e, Offset: 0x16e8
// Size: 0x34c
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
// Checksum 0x5220fd64, Offset: 0x1a40
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
// Checksum 0xe964e692, Offset: 0x1cc8
// Size: 0x84
function setup_terrain_sounds(surface_type, alias) {
    self.terrain_ent_array[surface_type] = spawn(0, self.origin, "script_origin");
    self.terrain_ent_array[surface_type].alias = alias;
    self thread heli_loop_sound_delete(self.terrain_ent_array[surface_type]);
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 2, eflags: 0x0
// Checksum 0x1affd6c1, Offset: 0x1d58
// Size: 0x84
function setup_terrain_brass_sounds(surface_type, alias) {
    self.terrain_brass_ent_array[surface_type] = spawn(0, self.origin, "script_origin");
    self.terrain_brass_ent_array[surface_type].alias = alias;
    self thread heli_loop_sound_delete(self.terrain_brass_ent_array[surface_type]);
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0x63debc81, Offset: 0x1de8
// Size: 0x1e4
function start_helicopter_sounds(localclientnum) {
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
            println("<dev string:x3b3>" + self.vehicletype + "<dev string:x3c7>");
            break;
        }
        self init_terrain_sounds();
        self thread terrain_trace();
        /#
            if (getdvarint(#"debug_heli", 0) > 0) {
                iprintlnbold("<dev string:x3f2>" + self.vehicletype + "<dev string:x404>");
            }
        #/
        return;
    }
    println("<dev string:x411>");
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0xea8e857d, Offset: 0x1fd8
// Size: 0x64
function heli_loop_sound_delete(real_ent) {
    self waittill(#"death");
    real_ent unlink();
    real_ent stopallloopsounds(4);
    real_ent delete();
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 2, eflags: 0x0
// Checksum 0xefe24408, Offset: 0x2048
// Size: 0x28
function heli_linkto_sound_ents_delete(localclientnum, entity) {
    entity notify(#"death");
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0xa1602cdf, Offset: 0x2078
// Size: 0xd2
function heli_sound_play(heli_bone) {
    switch (heli_bone.sound_type) {
    case #"engine":
        heli_bone.run playloopsound(heli_bone.run.alias, 2);
        break;
    case #"wind":
        break;
    default:
        println("<dev string:x44a>" + heli_bone.type + "<dev string:x467>");
        break;
    }
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x6d49af82, Offset: 0x2158
// Size: 0xa4
function play_player_controlled_sounds() {
    self heli_sound_play(self.heli[#"lfe"]);
    self thread heli_idle_run_transition("cobra", "turbine");
    self thread heli_idle_run_transition("cobra", "top_rotor");
    self thread heli_idle_run_transition("cobra", "tail_rotor");
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x11461178, Offset: 0x2208
// Size: 0xa4
function play_attack_ai_sounds() {
    self heli_sound_play(self.heli[#"lfe"]);
    self thread heli_idle_run_transition("hind", "turbine");
    self thread heli_idle_run_transition("hind", "top_rotor");
    self thread heli_idle_run_transition("hind", "tail_rotor");
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x7e77edd4, Offset: 0x22b8
// Size: 0x7c
function play_supply_sounds() {
    self thread heli_idle_run_transition("supply", "turbine");
    self thread heli_idle_run_transition("supply", "top_rotor");
    self heli_sound_play(self.heli[#"lfe"]);
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x90ba4ca7, Offset: 0x2340
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
// Checksum 0x80f724d1, Offset: 0x2440
// Size: 0x4
function play_player_drone_sounds() {
    
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x5737c620, Offset: 0x2450
// Size: 0x94
function play_heli_guard_sounds() {
    self heli_sound_play(self.heli[#"lfe"]);
    self thread heli_idle_run_transition("heli_guard", "turbine");
    self thread heli_idle_run_transition("heli_guard", "rotor");
    self thread terrain_trace_brass();
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 4, eflags: 0x0
// Checksum 0xda75382d, Offset: 0x24f0
// Size: 0x466
function heli_idle_run_transition(heli_type, heli_part, wait_time, updown) {
    self endon(#"death");
    heli_bone = self.heli[heli_part];
    run_id = heli_bone.run playloopsound(heli_bone.run.alias, 0.5);
    if (!isdefined(wait_time)) {
        wait_time = 0.5;
    }
    while (isdefined(self)) {
        if (!isdefined(level.helisoundvalues[heli_type]) || !isdefined(level.helisoundvalues[heli_type][heli_part])) {
            println("<dev string:x485>");
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
                    println("<dev string:x4b4>" + self.cur_speed);
                    println("<dev string:x4ca>" + run_pitch);
                    println("<dev string:x4b4>" + self.cur_speed);
                    println("<dev string:x4db>" + run_volume);
                }
            #/
        }
        wait wait_time;
    }
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0x7f8887d9, Offset: 0x2960
// Size: 0x388
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
// Checksum 0xfb4ce47d, Offset: 0x2cf0
// Size: 0x2f8
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
// Checksum 0x6290ad4c, Offset: 0x2ff0
// Size: 0x418
function aircraft_dustkick(localclientnum) {
    println("<dev string:x4ec>");
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
                    println("<dev string:x506>" + trace[#"surfacetype"] + "<dev string:x52a>" + self.vehicletype);
                    return;
                }
                println("<dev string:x506>" + trace[#"surfacetype"] + "<dev string:x53d>");
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
// Checksum 0xb9f6d51c, Offset: 0x3410
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
// Checksum 0xfe0c6dbd, Offset: 0x3498
// Size: 0x3a
function play_targeted_sound(play) {
    self.lockingsound = play_targeting_sound(play, "veh_hind_alarm_missile_locking_mp", self.lockingsound);
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0x1f872d37, Offset: 0x34e0
// Size: 0x3a
function play_locked_sound(play) {
    self.lockedsound = play_targeting_sound(play, "veh_hind_alarm_missile_locked_mp", self.lockedsound);
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0x48d7c31e, Offset: 0x3528
// Size: 0x3a
function play_fired_sound(play) {
    self.firedsound = play_targeting_sound(play, "veh_hind_alarm_missile_fired", self.firedsound);
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0x8ffdf993, Offset: 0x3570
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
// Checksum 0xfcd918db, Offset: 0x3608
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
// Checksum 0xa11d0eb, Offset: 0x36b8
// Size: 0x2a
function get_lock_sound_ent() {
    self.lock_sound_ent = get_heli_sound_ent(self.lock_sound_ent);
    return self.lock_sound_ent;
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0xd23f850b, Offset: 0x36f0
// Size: 0x2a
function get_leaving_sound_ent() {
    self.leaving_sound_ent = get_heli_sound_ent(self.leaving_sound_ent);
    return self.leaving_sound_ent;
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 1, eflags: 0x0
// Checksum 0xd61eb51c, Offset: 0x3728
// Size: 0x54
function heli_sound_ent_delete(real_ent) {
    self waittill(#"death");
    real_ent stopallloopsounds(0.1);
    real_ent delete();
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 0, eflags: 0x0
// Checksum 0xa8d03e50, Offset: 0x3788
// Size: 0x4f8
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
// Checksum 0x9bd41722, Offset: 0x3c88
// Size: 0x3c
function qr_ent_cleanup(veh_ent) {
    veh_ent waittill(#"death");
    self delete();
}

// Namespace helicopter_sounds/helicopter_sounds_shared
// Params 2, eflags: 0x0
// Checksum 0xd46a1b76, Offset: 0x3cd0
// Size: 0x228
function drone_rotate_angle(heli_type, heli_part) {
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
// Checksum 0x2109e1b0, Offset: 0x3f00
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

