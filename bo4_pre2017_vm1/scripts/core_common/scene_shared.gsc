#using scripts/core_common/ai_shared;
#using scripts/core_common/animation_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/laststand_shared;
#using scripts/core_common/lui_shared;
#using scripts/core_common/player_shared;
#using scripts/core_common/scene_debug_shared;
#using scripts/core_common/scene_objects_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/trigger_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;

#namespace scene;

// Namespace scene/scene_shared
// Params 0, eflags: 0x2
// Checksum 0xfe3929c9, Offset: 0x740
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("scene", &__init__, &__main__, undefined);
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xc28ec51, Offset: 0x788
// Size: 0x3ac
function __init__() {
    level.scenedefs = getscriptbundlenames("scene");
    level.active_scenes = [];
    level.inactive_scenes = [];
    level.var_7e438819 = 0;
    level.active_scenes = [];
    level.sceneskippedcount = 0;
    streamerrequest("clear");
    foreach (s_scenedef in getscriptbundles("scene")) {
        var_cbf643a3 = s_scenedef.name + "_scene_done";
        level flag::init(var_cbf643a3);
        if (s_scenedef.vmtype === "client") {
            continue;
        }
        if (s_scenedef.vmtype === "both" && !s_scenedef is_igc()) {
            n_clientbits = getminbitcountfornum(3);
            /#
                n_clientbits = getminbitcountfornum(6);
            #/
            clientfield::register("world", s_scenedef.name, 1, n_clientbits, "int");
        }
    }
    clientfield::register("toplayer", "postfx_igc", 1, 2, "counter");
    clientfield::register("world", "in_igc", 1, 12, "int");
    clientfield::register("toplayer", "player_scene_skip_completed", 1, 2, "counter");
    clientfield::register("allplayers", "player_scene_animation_skip", 1, 2, "counter");
    clientfield::register("actor", "player_scene_animation_skip", 1, 2, "counter");
    clientfield::register("vehicle", "player_scene_animation_skip", 1, 2, "counter");
    clientfield::register("scriptmover", "player_scene_animation_skip", 1, 2, "counter");
    callback::on_connect(&on_player_connect);
    callback::on_disconnect(&on_player_disconnect);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x15c693c4, Offset: 0xb40
// Size: 0x958
function fixup_scenedef(s_scenedef) {
    function_2801ec94(s_scenedef);
    if (!isdefined(s_scenedef.vmtype)) {
        return s_scenedef;
    }
    if (!isdefined(s_scenedef.ready_to_use)) {
        s_scenedef.ready_to_use = 1;
    } else {
        return s_scenedef;
    }
    a_invalid_object_indexes = [];
    foreach (i, s_object in s_scenedef.objects) {
        if (!isdefined(s_object.name) && !isdefined(s_object.model) && !(s_object.type === "player")) {
            if (!isdefined(a_invalid_object_indexes)) {
                a_invalid_object_indexes = [];
            } else if (!isarray(a_invalid_object_indexes)) {
                a_invalid_object_indexes = array(a_invalid_object_indexes);
            }
            a_invalid_object_indexes[a_invalid_object_indexes.size] = i;
        }
    }
    for (i = a_invalid_object_indexes.size - 1; i >= 0; i--) {
        arrayremoveindex(s_scenedef.objects, a_invalid_object_indexes[i]);
    }
    s_scenedef.editaction = undefined;
    s_scenedef.newobject = undefined;
    if (isstring(s_scenedef.femalebundle)) {
        s_female_bundle = struct::get_script_bundle("scene", s_scenedef.femalebundle);
        s_female_bundle.malebundle = s_scenedef.name;
        s_scenedef.s_female_bundle = s_female_bundle;
        s_female_bundle.s_male_bundle = s_scenedef;
    }
    if (!isdefined(level.scene_sequence_names)) {
        level.scene_sequence_names = [];
    }
    if (!isdefined(level.scene_streamer_ignore)) {
        level.scene_streamer_ignore = [];
    }
    if (!isdefined(level.scene_sequence_names[s_scenedef.name])) {
        for (s_next_bundle = s_scenedef; isdefined(s_next_bundle); s_next_bundle = undefined) {
            level.scene_sequence_names[s_next_bundle.name] = s_scenedef.name;
            if (isdefined(s_next_bundle.nextscenebundle)) {
                s_next_bundle = getscriptbundle(s_next_bundle.nextscenebundle);
                continue;
            }
        }
    } else {
        level.scene_streamer_ignore[s_scenedef.name] = 1;
    }
    if (isstring(s_scenedef.nextscenebundle)) {
        s_next_bundle = s_scenedef;
        while (isdefined(s_next_bundle)) {
            if (isdefined(s_next_bundle.nextscenebundle)) {
                s_next_bundle = getscriptbundle(s_next_bundle.nextscenebundle);
            } else {
                s_next_bundle = undefined;
            }
            if (isdefined(s_next_bundle)) {
                s_scenedef.str_final_bundle = s_next_bundle.name;
            }
        }
        foreach (i, s_object in s_scenedef.objects) {
            if (s_object.type === "player") {
                s_object.disabletransitionout = 1;
            }
        }
        s_next_bundle = struct::get_script_bundle("scene", s_scenedef.nextscenebundle);
        s_scenedef.next_bundle = s_next_bundle;
        s_next_bundle.dontsync = 1;
        s_next_bundle.dontthrottle = 1;
        foreach (i, s_object in s_next_bundle.objects) {
            if (s_object.type === "player") {
                s_object.disabletransitionin = 1;
            }
            s_object.iscutscene = 1;
        }
        if (isdefined(s_next_bundle.femalebundle)) {
            s_next_female_bundle = struct::get_script_bundle("scene", s_next_bundle.femalebundle);
            if (isdefined(s_next_female_bundle)) {
                s_next_female_bundle.dontsync = 1;
                s_next_female_bundle.dontthrottle = 1;
                foreach (i, s_object in s_next_female_bundle.objects) {
                    if (s_object.type === "player") {
                        s_object.disabletransitionin = 1;
                    }
                    s_object.iscutscene = 1;
                }
            }
        }
    }
    foreach (i, s_object in s_scenedef.objects) {
        if (s_object.type === "player") {
            if (!isdefined(s_object.cameratween)) {
                s_object.cameratween = 0;
            }
            s_object.newplayermethod = 1;
            if (isdefined(s_object.sharedigc) && s_object.sharedigc) {
                s_object.type = "sharedplayer";
            }
        }
        if (s_object.type != "player" && s_object.type != "sharedplayer") {
            s_object.cameraswitcher = undefined;
        }
        s_object.player = undefined;
        if (s_object.type === "player model") {
            s_object.type = "fakeplayer";
            continue;
        }
        if (s_object.type === "prop") {
            s_object.type = "model";
        }
    }
    if (isstring(s_scenedef.cameraswitcher) || isstring(s_scenedef.extracamswitcher1) || isstring(s_scenedef.extracamswitcher2) || isstring(s_scenedef.extracamswitcher3) || isstring(s_scenedef.extracamswitcher4)) {
        s_scenedef.igc = 1;
    }
    convert_to_new_format(s_scenedef);
    return s_scenedef;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xd1b662e, Offset: 0x14a0
// Size: 0x5ac
function convert_to_new_format(s_scenedef) {
    foreach (s_object in s_scenedef.objects) {
        s_object.old_scene_version = 1;
        b_has_init = 0;
        b_has_main = 0;
        b_has_camera = 0;
        if (isdefined(s_object.firstframe) && s_object.firstframe) {
            b_has_init = 1;
            s_object.var_7ee3f9e6 = "first frame";
            s_object.var_5da675e8 = s_object.mainanim;
        } else {
            if (isdefined(s_object.initanim)) {
                b_has_init = 1;
                s_object.var_fd81fe77 = s_object.initanim;
            }
            if (isdefined(s_object.initanimloop)) {
                b_has_init = 1;
                s_object.var_5da675e8 = s_object.initanimloop;
            }
            if (isdefined(s_object.spawnoninit) && s_object.spawnoninit) {
                b_has_init = 1;
            }
        }
        if (isdefined(s_object.cameraswitcher)) {
            b_has_main = 1;
            b_has_camera = 1;
            s_scenedef.igc = 1;
            if (b_has_init) {
                s_object.var_b91db8f4 = s_object.cameraswitcher;
            } else {
                s_object.var_40641403 = s_object.cameraswitcher;
            }
        }
        if (!isdefined(s_object.mainblend)) {
            s_object.mainblend = 0.02;
        }
        b_has_main = 1;
        if (b_has_init) {
            if (b_has_camera) {
                s_object.var_91cc8c22 = s_object.mainblend;
            } else {
                s_object.var_94e94969 = s_object.mainblend;
            }
        } else if (b_has_camera) {
            s_object.var_2ddfeb33 = s_object.mainblend;
        } else {
            s_object.var_ba5bc738 = s_object.mainblend;
        }
        if (isdefined(s_object.mainanim)) {
            b_has_main = 1;
            if (b_has_init) {
                if (b_has_camera) {
                    s_object.var_e6c41fdc = s_object.mainanim;
                } else {
                    s_object.var_cb13ef55 = s_object.mainanim;
                }
            } else if (b_has_camera) {
                s_object.var_a2505fa1 = s_object.mainanim;
            } else {
                s_object.var_5da675e8 = s_object.mainanim;
            }
        }
        if (isdefined(s_object.endblend)) {
            b_has_main = 1;
            if (b_has_init) {
                s_object.var_aeca7a4f = s_object.endblend;
            } else {
                s_object.var_30d53f56 = s_object.endblend;
            }
        }
        if (isdefined(s_object.endanim)) {
            b_has_main = 1;
            if (b_has_init) {
                s_object.var_e7b90cb7 = s_object.endanim;
            } else {
                s_object.var_b84d79f2 = s_object.endanim;
            }
        }
        if (isdefined(s_object.endanimloop)) {
            b_has_main = 1;
            if (b_has_init) {
                s_object.var_8a3a5dde = s_object.endanimloop;
            } else {
                s_object.var_6a64875b = s_object.endanimloop;
            }
        }
        if (b_has_init) {
            s_object.var_6e5564b4 = "init";
        }
        if (b_has_main) {
            if (b_has_init) {
                s_object.var_8e693051 = "play";
            } else {
                s_object.var_6e5564b4 = "play";
            }
        }
        s_object.initanim = undefined;
        s_object.initanimloop = undefined;
        s_object.mainblend = undefined;
        s_object.mainanim = undefined;
        s_object.endblend = undefined;
        s_object.endanim = undefined;
        s_object.endanimloop = undefined;
        s_object.firstframe = undefined;
    }
    s_scenedef.old_scene_version = 1;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x381311b5, Offset: 0x1a58
// Size: 0x150
function get_all_shot_names(str_scenedef) {
    a_shots = [];
    foreach (s_object in get_scenedef(str_scenedef).objects) {
        if (!(isdefined(s_object.disabled) && s_object.disabled)) {
            for (n_shot = 1; n_shot <= 64; n_shot++) {
                str_shot_name = s_object.("shot" + n_shot + "_name");
                if (isdefined(str_shot_name)) {
                    array::add(a_shots, str_shot_name, 0);
                    continue;
                }
                break;
            }
        }
    }
    return a_shots;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x8966d6e5, Offset: 0x1bb0
// Size: 0x41a
function function_2801ec94(s_scenedef) {
    foreach (obj in s_scenedef.objects) {
        if (isdefined(obj.var_b54636dd) && (isdefined(obj.var_9392362e) && (isdefined(obj.var_ac93a3e9) && (isdefined(obj.var_eb02ef7e) && obj.var_eb02ef7e || obj.var_ac93a3e9) || obj.var_9392362e) || obj.var_b54636dd)) {
            if (!isdefined(s_scenedef.var_51bc3a4)) {
                s_scenedef.var_51bc3a4 = [];
            }
            if (!isdefined(s_scenedef.var_c8269f35)) {
                s_scenedef.var_c8269f35 = [];
            }
            str_team = util::get_team_mapping(obj.team);
            if (str_team !== "allies" && str_team !== "axis") {
                continue;
            }
            if (!isdefined(s_scenedef.var_51bc3a4[str_team])) {
                s_scenedef.var_51bc3a4[str_team] = [];
            }
            if (!isdefined(s_scenedef.var_c8269f35[str_team])) {
                s_scenedef.var_c8269f35[str_team] = [];
            }
            if (isdefined(obj.var_eb02ef7e) && obj.var_eb02ef7e && isdefined(obj.mainanim) && !isdefined(s_scenedef.var_51bc3a4[str_team]["primary"])) {
                s_scenedef.var_51bc3a4[str_team]["primary"] = obj.mainanim;
            }
            if (isdefined(obj.var_9392362e) && obj.var_9392362e && isdefined(obj.mainanim) && !isdefined(s_scenedef.var_51bc3a4[str_team]["secondary"])) {
                s_scenedef.var_51bc3a4[str_team]["secondary"] = obj.mainanim;
            }
            if (isdefined(obj.var_ac93a3e9) && obj.var_ac93a3e9 && isdefined(obj.mainanim) && !isdefined(s_scenedef.var_c8269f35[str_team]["primary"])) {
                s_scenedef.var_c8269f35[str_team]["primary"] = obj.mainanim;
            }
            if (isdefined(obj.var_b54636dd) && obj.var_b54636dd && isdefined(obj.mainanim) && !isdefined(s_scenedef.var_c8269f35[str_team]["secondary"])) {
                s_scenedef.var_c8269f35[str_team]["secondary"] = obj.mainanim;
            }
        }
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xa96181, Offset: 0x1fd8
// Size: 0x47c
function __main__() {
    a_instances = arraycombine(struct::get_array("scriptbundle_scene", "classname"), struct::get_array("scriptbundle_fxanim", "classname"), 0, 0);
    function_bf34d1f2();
    foreach (s_instance in a_instances) {
        s_instance function_17054157();
        if (isdefined(s_instance.linkto)) {
            s_instance thread _scene_link();
        }
        if (isdefined(s_instance.script_flag_set)) {
            level flag::init(s_instance.script_flag_set);
        }
        if (isdefined(s_instance.scriptgroup_initscenes)) {
            foreach (trig in getentarray(s_instance.scriptgroup_initscenes, "scriptgroup_initscenes")) {
                s_instance thread _trigger_init(trig);
            }
        }
        if (isdefined(s_instance.scriptgroup_playscenes)) {
            foreach (trig in getentarray(s_instance.scriptgroup_playscenes, "scriptgroup_playscenes")) {
                s_instance thread _trigger_play(trig);
            }
        }
        if (isdefined(s_instance.scriptgroup_stopscenes)) {
            foreach (trig in getentarray(s_instance.scriptgroup_stopscenes, "scriptgroup_stopscenes")) {
                s_instance thread _trigger_stop(trig);
            }
        }
        /#
            if (!isdefined(level.scene_roots)) {
                level.scene_roots = [];
            } else if (!isarray(level.scene_roots)) {
                level.scene_roots = array(level.scene_roots);
            }
            if (!isinarray(level.scene_roots, s_instance)) {
                level.scene_roots[level.scene_roots.size] = s_instance;
            }
        #/
    }
    level thread on_load_wait();
    level thread run_instances();
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x65a097c3, Offset: 0x2460
// Size: 0x25a
function function_bf34d1f2() {
    a_triggers = trigger::get_all();
    foreach (trig in a_triggers) {
        if (isdefined(trig.targetname)) {
            str_trig_name = "(targetname: " + trig.targetname + ")";
        } else {
            str_trig_name = "(entity number " + trig getentitynumber() + ")";
        }
        if (isdefined(trig.scriptgroup_initscenes)) {
            a_instances = struct::get_array(trig.scriptgroup_initscenes, "scriptgroup_initscenes");
            /#
                assert(a_instances.size, "<dev string:x28>" + str_trig_name + "<dev string:x31>");
            #/
        }
        if (isdefined(trig.scriptgroup_playscenes)) {
            a_instances = struct::get_array(trig.scriptgroup_playscenes, "scriptgroup_playscenes");
            /#
                assert(a_instances.size, "<dev string:x28>" + str_trig_name + "<dev string:x7d>");
            #/
        }
        if (isdefined(trig.scriptgroup_stopscenes)) {
            a_instances = struct::get_array(trig.scriptgroup_stopscenes, "scriptgroup_stopscenes");
            /#
                assert(a_instances.size, "<dev string:x28>" + str_trig_name + "<dev string:xc9>");
            #/
        }
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x4cc9cbf9, Offset: 0x26c8
// Size: 0x138
function function_17054157() {
    if (isdefined(self.script_igc_teleport_location)) {
        foreach (str_team in level.teams) {
            self.var_8adb8fdb[str_team] = util::query_ents(associativearray("variantname", "igc_teleport_players_" + str_team, "script_igc_teleport_location", self.script_igc_teleport_location));
            self.var_37a40366[str_team] = util::query_ents(associativearray("variantname", "igc_teleport_companions_" + str_team, "script_igc_teleport_location", self.script_igc_teleport_location));
        }
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xb68a9fcd, Offset: 0x2808
// Size: 0x1a4
function function_2ac52389() {
    if (!isdefined(self.var_8adb8fdb) && !isdefined(self.var_37a40366)) {
        return;
    }
    foreach (str_team in level.teams) {
        foreach (s_loc in self.var_8adb8fdb[str_team]) {
            s_loc.b_taken = 0;
        }
        foreach (s_loc in self.var_37a40366[str_team]) {
            s_loc.b_taken = 0;
        }
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x56cb4f28, Offset: 0x29b8
// Size: 0xbc
function _scene_link() {
    self.e_scene_link = util::spawn_model("tag_origin", self.origin, self.angles);
    e_linkto = getent(self.linkto, "linkname");
    self.e_scene_link linkto(e_linkto);
    util::waittill_any_ents_two(self, "death", e_linkto, "death");
    self.e_scene_link delete();
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xe82c58c3, Offset: 0x2a80
// Size: 0x44
function on_load_wait() {
    util::wait_network_frame();
    util::wait_network_frame();
    level flagsys::set("scene_on_load_wait");
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xa3e371cc, Offset: 0x2ad0
// Size: 0x16a
function run_instances() {
    foreach (s_instance in struct::get_script_bundle_instances("scene")) {
        if (getscriptbundle(s_instance.scriptbundlename).vmtype === "client") {
            s_instance struct::delete();
            continue;
        }
        if (isdefined(s_instance.spawnflags) && (s_instance.spawnflags & 2) == 2) {
            s_instance thread play();
            continue;
        }
        if (isdefined(s_instance.spawnflags) && (s_instance.spawnflags & 1) == 1) {
            s_instance thread init();
        }
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xb0834b08, Offset: 0x2c48
// Size: 0xb4
function _trigger_init(trig) {
    trig endon(#"death");
    trig trigger::wait_till();
    a_ents = [];
    if (get_player_count(self.scriptbundlename) > 0) {
        if (isplayer(trig.who)) {
            a_ents[0] = trig.who;
        }
    }
    self thread init(a_ents);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xe31c8fd6, Offset: 0x2d08
// Size: 0xfe
function _trigger_play(trig) {
    trig endon(#"death");
    do {
        trig trigger::wait_till();
        a_ents = [];
        if (get_player_count(self.scriptbundlename) > 0) {
            if (isplayer(trig.who)) {
                a_ents[0] = trig.who;
            }
        }
        self thread play(a_ents);
    } while (isdefined(getscriptbundle(self.scriptbundlename).looping) && getscriptbundle(self.scriptbundlename).looping);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x7849281c, Offset: 0x2e10
// Size: 0x4c
function _trigger_stop(trig) {
    trig endon(#"death");
    trig trigger::wait_till();
    self thread stop();
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x20 variadic
// Checksum 0xa8c88fb, Offset: 0x2e68
// Size: 0x14c
function add_scene_func(str_scenedef, func, str_state, ...) {
    if (!isdefined(str_state)) {
        str_state = "play";
    }
    /#
        /#
            assert(isdefined(getscriptbundle(str_scenedef)), "<dev string:x115>" + str_scenedef + "<dev string:x140>");
        #/
    #/
    if (!isdefined(level.scene_funcs)) {
        level.scene_funcs = [];
    }
    if (!isdefined(level.scene_funcs[str_scenedef])) {
        level.scene_funcs[str_scenedef] = [];
    }
    if (!isdefined(level.scene_funcs[str_scenedef][str_state])) {
        level.scene_funcs[str_scenedef][str_state] = [];
    }
    array::add(level.scene_funcs[str_scenedef][str_state], array(func, vararg), 0);
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0xbd7483c5, Offset: 0x2fc0
// Size: 0x16e
function remove_scene_func(str_scenedef, func, str_state) {
    if (!isdefined(str_state)) {
        str_state = "play";
    }
    /#
        /#
            assert(isdefined(getscriptbundle(str_scenedef)), "<dev string:x156>" + str_scenedef + "<dev string:x140>");
        #/
    #/
    if (!isdefined(level.scene_funcs)) {
        level.scene_funcs = [];
    }
    if (isdefined(level.scene_funcs[str_scenedef]) && isdefined(level.scene_funcs[str_scenedef][str_state])) {
        for (i = level.scene_funcs[str_scenedef][str_state].size - 1; i >= 0; i--) {
            if (level.scene_funcs[str_scenedef][str_state][i][0] == func) {
                arrayremoveindex(level.scene_funcs[str_scenedef][str_state], i);
            }
        }
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x63db7e9d, Offset: 0x3138
// Size: 0x8a
function get_scenedef(str_scenedef) {
    s_scriptbundle = getscriptbundle(str_scenedef);
    /#
        assert(isdefined(s_scriptbundle) && s_scriptbundle.name !== "<dev string:x184>", str_scenedef + "<dev string:x198>");
    #/
    return fixup_scenedef(s_scriptbundle);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x58a9d90f, Offset: 0x31d0
// Size: 0x15c
function get_scenedefs(str_type) {
    if (!isdefined(str_type)) {
        str_type = "scene";
    }
    a_scenedefs = [];
    foreach (s_scenedef in getscriptbundles("scene")) {
        if (s_scenedef.scenetype === str_type && s_scenedef.vmtype !== "client") {
            s_scenedef = fixup_scenedef(s_scenedef);
            if (!isdefined(a_scenedefs)) {
                a_scenedefs = [];
            } else if (!isarray(a_scenedefs)) {
                a_scenedefs = array(a_scenedefs);
            }
            a_scenedefs[a_scenedefs.size] = s_scenedef;
        }
    }
    return a_scenedefs;
}

// Namespace scene/scene_shared
// Params 5, eflags: 0x0
// Checksum 0x9a051ef2, Offset: 0x3338
// Size: 0x1a8
function spawn(arg1, arg2, arg3, arg4, b_test_run) {
    str_scenedef = arg1;
    /#
        assert(isdefined(str_scenedef), "<dev string:x1b6>");
    #/
    if (isvec(arg2)) {
        v_origin = arg2;
        v_angles = arg3;
        a_ents = arg4;
    } else {
        a_ents = arg2;
        v_origin = arg3;
        v_angles = arg4;
    }
    s_instance = spawnstruct();
    s_instance.origin = isdefined(v_origin) ? v_origin : (0, 0, 0);
    s_instance.angles = isdefined(v_angles) ? v_angles : (0, 0, 0);
    s_instance.classname = "scriptbundle_scene";
    s_instance.scriptbundlename = str_scenedef;
    s_instance struct::init();
    s_instance init(str_scenedef, a_ents, undefined, b_test_run);
    return s_instance;
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x0
// Checksum 0x1df4fd6b, Offset: 0x34e8
// Size: 0x54
function init(arg1, arg2, arg3, b_test_run) {
    self thread play(arg1, arg2, arg3, b_test_run, "init");
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0x16b3c775, Offset: 0x3548
// Size: 0x200
function _init_instance(str_scenedef, a_ents, b_test_run) {
    if (!isdefined(b_test_run)) {
        b_test_run = 0;
    }
    level flagsys::wait_till("scene_on_load_wait");
    if (!isdefined(str_scenedef)) {
        str_scenedef = self.scriptbundlename;
    }
    /#
        if (array().size && !isinarray(array(), str_scenedef)) {
            return;
        }
    #/
    s_bundle = get_scenedef(str_scenedef);
    /#
        /#
            assert(isdefined(str_scenedef), "<dev string:x1e1>" + (isdefined(self.origin) ? self.origin : "<dev string:x1ec>") + "<dev string:x1f2>");
        #/
        /#
            assert(isdefined(s_bundle), "<dev string:x1e1>" + (isdefined(self.origin) ? self.origin : "<dev string:x1ec>") + "<dev string:x20e>" + str_scenedef + "<dev string:x140>");
        #/
    #/
    o_scene = get_active_scene(str_scenedef);
    if (!isdefined(o_scene)) {
        [[ new cscene ]]->__constructor();
        o_scene = <error pop>;
        [[ o_scene ]]->init(s_bundle.name, s_bundle, self, a_ents, b_test_run);
    }
    return o_scene;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x8ef74087, Offset: 0x3750
// Size: 0x27c
function _load_female_scene(s_bundle, a_ents) {
    b_has_player = 0;
    foreach (s_object in s_bundle.objects) {
        if (!isdefined(s_object)) {
            continue;
        }
        if (s_object.type === "player") {
            b_has_player = 1;
            break;
        }
    }
    if (b_has_player) {
        e_player = undefined;
        if (isplayer(a_ents)) {
            e_player = a_ents;
        } else if (isarray(a_ents)) {
            foreach (ent in a_ents) {
                if (isplayer(ent)) {
                    e_player = ent;
                    break;
                }
            }
        }
        if (!isdefined(e_player) && isdefined(level.activeplayers)) {
            e_player = level.activeplayers[0];
        }
        if (isplayer(e_player) && e_player util::is_female()) {
            if (isdefined(s_bundle.femalebundle)) {
                s_female_bundle = struct::get_script_bundle("scene", s_bundle.femalebundle);
                if (isdefined(s_female_bundle)) {
                    return s_female_bundle;
                }
            }
        }
    }
    return s_bundle;
}

// Namespace scene/scene_shared
// Params 5, eflags: 0x0
// Checksum 0x71020c36, Offset: 0x39d8
// Size: 0x44c
function play(arg1, arg2, arg3, b_test_run, str_mode) {
    if (!isdefined(b_test_run)) {
        b_test_run = 0;
    }
    if (!isdefined(str_mode)) {
        str_mode = "";
    }
    /#
        if (getdvarint("<dev string:x228>") > 0) {
            if (isdefined(arg1) && isstring(arg1)) {
                printtoprightln("<dev string:x234>" + arg1);
            } else {
                printtoprightln("<dev string:x243>");
            }
        }
    #/
    s_tracker = spawnstruct();
    s_tracker.n_scene_count = 0;
    if (self == level) {
        a_instances = [];
        if (isstring(arg1)) {
            if (issubstr(arg1, ",")) {
                a_toks = strtok(arg1, ",");
                str_value = a_toks[0];
                str_key = a_toks[1];
                if (isstring(arg2)) {
                    str_shot = arg2;
                    a_ents = arg3;
                } else {
                    a_ents = arg2;
                }
            } else if (isinarray(level.scenedefs, arg1)) {
                str_scenedef = arg1;
            } else {
                str_value = arg1;
                str_key = "targetname";
            }
            if (isstring(arg2)) {
                if (isinarray(array("targetname", "script_noteworthy"), arg2)) {
                    str_key = arg2;
                } else {
                    str_shot = arg2;
                }
                a_ents = arg3;
            } else {
                a_ents = arg2;
            }
            a_instances = _get_scene_instances(str_value, str_key, str_scenedef);
            if (a_instances.size) {
                s_tracker.n_scene_count = a_instances.size;
                foreach (s_instance in a_instances) {
                    if (isdefined(s_instance)) {
                        s_instance thread _play_instance(s_tracker, str_scenedef, a_ents, b_test_run, str_shot, str_mode);
                    }
                }
            } else {
                _play_on_self(s_tracker, arg1, arg2, arg3, b_test_run, str_mode);
            }
        }
    } else {
        _play_on_self(s_tracker, arg1, arg2, arg3, b_test_run, str_mode);
    }
    if (s_tracker.n_scene_count > 0) {
        s_tracker waittill("scenes_done");
    }
}

// Namespace scene/scene_shared
// Params 6, eflags: 0x0
// Checksum 0xaa36ab19, Offset: 0x3e30
// Size: 0x174
function _play_on_self(s_tracker, arg1, arg2, arg3, b_test_run, str_mode) {
    if (!isdefined(b_test_run)) {
        b_test_run = 0;
    }
    if (!isdefined(str_mode)) {
        str_mode = "";
    }
    if (str_mode === "init") {
        str_shot = str_mode;
        str_mode = "";
    }
    if (isstring(arg1)) {
        if (isinarray(level.scenedefs, arg1)) {
            str_scenedef = arg1;
            if (isstring(arg2)) {
                str_shot = arg2;
                a_ents = arg3;
            } else {
                a_ents = arg2;
            }
        } else {
            str_shot = arg1;
            a_ents = arg2;
        }
    }
    s_tracker.n_scene_count = 1;
    self thread _play_instance(s_tracker, str_scenedef, a_ents, b_test_run, str_shot, str_mode);
}

// Namespace scene/scene_shared
// Params 6, eflags: 0x0
// Checksum 0xc996aaa5, Offset: 0x3fb0
// Size: 0x53c
function _play_instance(s_tracker, str_scenedef, a_ents, b_test_run, str_shot, str_mode) {
    if (!isdefined(b_test_run)) {
        b_test_run = 0;
    }
    if (!isdefined(str_shot)) {
        str_shot = "play";
    }
    if (str_mode === "init") {
        str_shot = str_mode;
        str_mode = "";
    }
    if (!isdefined(str_scenedef)) {
        str_scenedef = self.scriptbundlename;
    }
    /#
        if (array().size && !isinarray(array(), str_scenedef)) {
            return;
        }
    #/
    if (level flag::get(str_scenedef + "_scene_done")) {
        level flag::clear(str_scenedef + "_scene_done");
        var_5f4ce8b9 = getscriptbundle(str_scenedef);
        while (isdefined(var_5f4ce8b9.nextscenebundle)) {
            var_5f4ce8b9 = getscriptbundle(var_5f4ce8b9.nextscenebundle);
            level flag::clear(var_5f4ce8b9.name + "_scene_done");
        }
    }
    b_play = 1;
    if (self.scriptbundlename === str_scenedef) {
        if (!(isdefined(self.script_play_multiple) && self.script_play_multiple)) {
            if (!isdefined(self.scene_played)) {
                self.scene_played = [];
            }
            if (isdefined(self.scene_played[str_shot]) && self.scene_played[str_shot] && !b_test_run) {
                waittillframeend();
                while (is_playing(str_scenedef, str_shot)) {
                    waitframe(1);
                }
                b_play = 0;
            }
        }
        self.scene_played[str_shot] = 1;
    }
    if (b_play) {
        function_2ac52389();
        o_scene = _init_instance(str_scenedef, a_ents, b_test_run);
        if (isdefined(o_scene)) {
            if ((!isdefined(str_mode) || str_mode == "") && [[ o_scene ]]->function_58e414c3()) {
                skip_scene(o_scene._s.name, 0, 0, 1);
            }
            thread [[ o_scene ]]->play(str_shot, a_ents, b_test_run, str_mode);
        }
        o_scene waittill(str_shot);
        if (isdefined(self)) {
            if (isdefined(getscriptbundle(self.scriptbundlename).looping) && isdefined(self.scriptbundlename) && getscriptbundle(self.scriptbundlename).looping) {
                self.scene_played[str_shot] = 0;
            }
            if (isdefined(self.script_flag_set)) {
                level flag::set(self.script_flag_set);
            }
        }
    }
    s_bundle = getscriptbundle(str_scenedef);
    if (isdefined(s_bundle.str_final_bundle)) {
        var_3be733aa = s_bundle.name;
        level waittill(s_bundle.str_final_bundle + "_done");
        if (str_shot == "play") {
            level flag::set(var_3be733aa + "_scene_done");
        }
    }
    s_tracker.n_scene_count--;
    if (s_tracker.n_scene_count == 0) {
        if (str_shot == "play") {
            level flag::set(str_scenedef + "_scene_done");
        }
        s_tracker notify(#"scenes_done");
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xf3833c9, Offset: 0x44f8
// Size: 0x204
function delete_scene_spawned_ents(arg1) {
    if (self == level) {
        a_instances = [];
        if (isstring(arg1)) {
            if (issubstr(arg1, ",")) {
                a_toks = strtok(arg1, ",");
                str_value = a_toks[0];
                str_key = a_toks[1];
            } else if (isinarray(level.scenedefs, arg1)) {
                str_scenedef = arg1;
            } else {
                str_value = arg1;
                str_key = "targetname";
            }
            a_instances = _get_scene_instances(str_value, str_key, str_scenedef, 1);
            if (a_instances.size) {
                foreach (instance in a_instances) {
                    instance _delete_scene_spawned_ents(str_scenedef);
                }
            }
        }
        return;
    }
    if (isstring(arg1)) {
        str_scenedef = arg1;
    }
    instance _delete_scene_spawned_ents(str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x779d55a3, Offset: 0x4708
// Size: 0x252
function _delete_scene_spawned_ents(str_scene) {
    if (isdefined(self.scene_ents)) {
        if (isdefined(str_scene)) {
            foreach (ent in self.scene_ents) {
                if (!isarray(ent) && isdefined(ent) && isdefined(ent.scene_spawned)) {
                    ent delete();
                }
            }
            /#
                update_debug_state(str_scene, "<dev string:x24f>");
            #/
            return;
        }
        a_scenes = getarraykeys(self.scene_ents);
        foreach (str_scene in a_scenes) {
            foreach (ent in self.scene_ents) {
                if (isdefined(ent.scene_spawned)) {
                    ent delete();
                }
            }
            /#
                update_debug_state(str_scene, "<dev string:x24f>");
            #/
        }
    }
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0xd9698e77, Offset: 0x4968
// Size: 0x9e
function update_debug_state(str_scene, str_state) {
    if (!strendswith(self.last_scene_state_instance[str_scene], str_state)) {
        level.last_scene_state[str_scene] = level.last_scene_state[str_scene] + "," + str_state;
        self.last_scene_state_instance[str_scene] = self.last_scene_state_instance[str_scene] + "," + str_state;
    }
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x0
// Checksum 0xb05b5bc4, Offset: 0x4a10
// Size: 0x1ac
function _get_scene_instances(str_value, str_key, str_scenedef, b_include_inactive) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (!isdefined(b_include_inactive)) {
        b_include_inactive = 0;
    }
    a_instances = [];
    if (isdefined(str_value)) {
        a_instances = struct::get_array(str_value, str_key);
        /#
            /#
                assert(a_instances.size, "<dev string:x257>" + str_key + "<dev string:x275>" + str_value + "<dev string:x279>");
            #/
        #/
    }
    if (isdefined(str_scenedef)) {
        a_instances_by_scenedef = struct::get_array(str_scenedef, "scriptbundlename");
        a_instances = arraycombine(a_instances_by_scenedef, a_instances, 0, 0);
        a_active_instances = get_active_scenes(str_scenedef);
        a_instances = arraycombine(a_active_instances, a_instances, 0, 0);
        if (b_include_inactive) {
            a_inactive_instances = get_inactive_scenes(str_scenedef);
            a_instances = arraycombine(a_inactive_instances, a_instances, 0, 0);
        }
    }
    return a_instances;
}

// Namespace scene/scene_shared
// Params 5, eflags: 0x0
// Checksum 0xe96448da, Offset: 0x4bc8
// Size: 0xb4
function skipto_end(arg1, arg2, arg3, n_time, b_include_players) {
    if (!isdefined(b_include_players)) {
        b_include_players = 1;
    }
    str_mode = "skipto";
    if (!b_include_players) {
        str_mode += "_noplayers";
    }
    if (isdefined(n_time)) {
        str_mode += ":" + n_time;
    }
    play(arg1, arg2, arg3, 0, str_mode);
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x0
// Checksum 0x415c1f44, Offset: 0x4c88
// Size: 0x84
function skipto_end_noai(arg1, arg2, arg3, n_time) {
    str_mode = "skipto_noai_noplayers";
    if (isdefined(n_time)) {
        str_mode += ":" + n_time;
    }
    play(arg1, arg2, arg3, 0, str_mode);
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0xdb95fe57, Offset: 0x4d18
// Size: 0x274
function stop(arg1, arg2, arg3) {
    if (self == level) {
        if (isstring(arg1)) {
            if (isstring(arg2)) {
                str_value = arg1;
                str_key = arg2;
                b_clear = arg3;
            } else {
                str_value = arg1;
                b_clear = arg2;
            }
            if (isdefined(str_key)) {
                a_instances = struct::get_array(str_value, str_key);
                /#
                    /#
                        assert(a_instances.size, "<dev string:x257>" + str_key + "<dev string:x275>" + str_value + "<dev string:x279>");
                    #/
                #/
                str_value = undefined;
            } else {
                a_instances = struct::get_array(str_value, "targetname");
                if (!a_instances.size) {
                    a_instances = get_active_scenes(str_value);
                } else {
                    str_value = undefined;
                }
            }
            foreach (s_instance in arraycopy(a_instances)) {
                if (isdefined(s_instance)) {
                    s_instance _stop_instance(b_clear, str_value);
                }
            }
        }
        return;
    }
    if (isstring(arg1)) {
        _stop_instance(arg2, arg1);
        return;
    }
    _stop_instance(arg1);
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0xbda535a2, Offset: 0x4f98
// Size: 0xfe
function _stop_instance(b_clear, str_scenedef) {
    if (!isdefined(b_clear)) {
        b_clear = 0;
    }
    if (isdefined(self.scenes)) {
        foreach (o_scene in arraycopy(self.scenes)) {
            str_scene_name = o_scene._str_name;
            if (!isdefined(str_scenedef) || str_scene_name == str_scenedef) {
                thread [[ o_scene ]]->stop(b_clear);
            }
        }
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xc393bc5d, Offset: 0x50a0
// Size: 0x3a
function has_init_state(str_scenedef) {
    return isinarray(get_all_shot_names(str_scenedef), "init");
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x45c97cf9, Offset: 0x50e8
// Size: 0x2a
function get_prop_count(str_scenedef) {
    return _get_type_count("prop", str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xb97feb8d, Offset: 0x5120
// Size: 0x2a
function get_vehicle_count(str_scenedef) {
    return _get_type_count("vehicle", str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xacb47bed, Offset: 0x5158
// Size: 0x2a
function get_actor_count(str_scenedef) {
    return _get_type_count("actor", str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x326c2085, Offset: 0x5190
// Size: 0x2a
function get_player_count(str_scenedef) {
    return _get_type_count("player", str_scenedef);
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x8ec7e386, Offset: 0x51c8
// Size: 0x140
function _get_type_count(str_type, str_scenedef) {
    s_scenedef = isdefined(str_scenedef) ? getscriptbundle(str_scenedef) : getscriptbundle(self.scriptbundlename);
    n_count = 0;
    foreach (s_obj in s_scenedef.objects) {
        if (isdefined(s_obj.type)) {
            if (tolower(s_obj.type) == tolower(str_type)) {
                n_count++;
            }
        }
    }
    return n_count;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xc7c6b9ff, Offset: 0x5310
// Size: 0x4e
function is_active(str_scenedef) {
    if (self == level) {
        return (get_active_scenes(str_scenedef).size > 0);
    }
    return isdefined(get_active_scene(str_scenedef));
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0xe5e6314, Offset: 0x5368
// Size: 0x88
function is_playing(str_scenedef, str_shot) {
    if (!isdefined(str_shot)) {
        str_shot = "play";
    }
    if (!isdefined(str_scenedef)) {
        str_scenedef = self.scriptbundlename;
    }
    o_scene = get_active_scene(str_scenedef);
    if (isdefined(o_scene)) {
        return (o_scene._str_shot === str_shot);
    }
    return false;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x4eaf4218, Offset: 0x53f8
// Size: 0x9e
function is_ready(str_scenedef) {
    if (self == level) {
        return level flagsys::get(str_scenedef + "_ready");
    } else {
        if (!isdefined(str_scenedef)) {
            str_scenedef = self.scriptbundlename;
        }
        o_scene = get_active_scene(str_scenedef);
        if (isdefined(o_scene)) {
            return o_scene flagsys::get("ready");
        }
    }
    return 0;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x3b29af2, Offset: 0x54a0
// Size: 0xfc
function get_active_scenes(str_scenedef) {
    if (isdefined(str_scenedef)) {
        return (isdefined(level.active_scenes[str_scenedef]) ? level.active_scenes[str_scenedef] : []);
    }
    a_scenes = [];
    foreach (str_scenedef, _ in level.active_scenes) {
        a_scenes = arraycombine(a_scenes, level.active_scenes[str_scenedef], 0, 0);
    }
    return a_scenes;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x5c857b43, Offset: 0x55a8
// Size: 0x11c
function get_inactive_scenes(str_scenedef) {
    if (!isdefined(level.inactive_scenes)) {
        level.inactive_scenes = [];
    }
    if (isdefined(str_scenedef)) {
        return (isdefined(level.inactive_scenes[str_scenedef]) ? level.inactive_scenes[str_scenedef] : []);
    }
    a_scenes = [];
    foreach (str_scenedef, _ in level.inactive_scenes) {
        a_scenes = arraycombine(a_scenes, level.inactive_scenes[str_scenedef], 0, 0);
    }
    return a_scenes;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x3e943e2c, Offset: 0x56d0
// Size: 0xb4
function get_active_scene(str_scenedef) {
    if (isdefined(str_scenedef) && isdefined(self.scenes)) {
        foreach (o_scene in self.scenes) {
            if (o_scene._str_name == str_scenedef) {
                return o_scene;
            }
        }
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xfcde75c3, Offset: 0x5790
// Size: 0xc
function delete_scene_data(str_scenename) {
    
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xf3a70407, Offset: 0x57a8
// Size: 0x9a
function is_igc() {
    return isstring(self.cameraswitcher) || isstring(self.extracamswitcher1) || isstring(self.extracamswitcher2) || isstring(self.extracamswitcher3) || isstring(self.extracamswitcher4);
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x16d96f2b, Offset: 0x5850
// Size: 0x112
function scene_disable_player_stuff(s_scenedef, s_objectdef) {
    /#
        if (getdvarint("<dev string:x228>") > 0) {
            printtoprightln("<dev string:x27c>");
        }
    #/
    self notify(#"scene_disable_player_stuff");
    self notify(#"kill_hint_text");
    self disableoffhandweapons();
    if (isdefined(s_objectdef)) {
        if (!(isdefined(s_objectdef.showhud) && s_objectdef.showhud)) {
            level notify(#"disable_cybercom", {#player:self});
            self val::set("scene", "show_hud", 0);
            util::wait_network_frame();
            self notify(#"delete_weapon_objects");
        }
    }
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0x36ad9cbb, Offset: 0x5970
// Size: 0x13c
function scene_enable_player_stuff(s_scenedef, s_objectdef, e_scene_root) {
    /#
        if (getdvarint("<dev string:x228>") > 0) {
            printtoprightln("<dev string:x29e>");
        }
    #/
    self endon(#"scene_disable_player_stuff");
    self endon(#"disconnect");
    waitframe(0);
    if (isdefined(s_scenedef) && !isdefined(s_scenedef.nextscenebundle)) {
        self function_a198015a(e_scene_root);
    }
    waitframe(10);
    self enableoffhandweapons();
    if (isdefined(s_objectdef)) {
        if (!(isdefined(s_objectdef.showhud) && s_objectdef.showhud)) {
            level notify(#"enable_cybercom", {#player:self});
            self notify(#"scene_enable_cybercom");
            self val::reset("scene", "show_hud");
        }
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xd24d4c3, Offset: 0x5ab8
// Size: 0xcc
function function_a198015a(e_scene_root) {
    self endon(#"disconnect");
    if (isdefined(e_scene_root)) {
        if (self util::function_4f5dd9d2()) {
            waitframe(0);
        }
        if (self util::function_4f5dd9d2() && isdefined(e_scene_root.var_37a40366)) {
            function_baec50e1(e_scene_root.var_37a40366[self.team]);
            return;
        }
        if (isdefined(e_scene_root.var_8adb8fdb)) {
            function_baec50e1(e_scene_root.var_8adb8fdb[self.team]);
        }
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x4
// Checksum 0xeb15c7b0, Offset: 0x5b90
// Size: 0x184
function private function_baec50e1(&a_locations) {
    if (self util::function_4f5dd9d2()) {
        a_locations = arraysortclosest(a_locations, self.owner.origin);
    }
    foreach (s_loc in a_locations) {
        if (!(isdefined(s_loc.b_taken) && s_loc.b_taken)) {
            self thread lui::screen_flash(0, 0.3, 0.3);
            s_loc.b_taken = 1;
            self setorigin(s_loc.origin);
            self util::delay_network_frames(2, "disconnect", &setplayerangles, s_loc.angles);
            return;
        }
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x110df530, Offset: 0x5d20
// Size: 0x152
function updateigcviewtime(b_in_igc) {
    if (b_in_igc && !isdefined(level.igcstarttime)) {
        level.igcstarttime = gettime();
        return;
    }
    if (!b_in_igc && isdefined(level.igcstarttime)) {
        igcviewtimesec = gettime() - level.igcstarttime;
        level.igcstarttime = undefined;
        foreach (player in level.players) {
            if (!isdefined(player.totaligcviewtime)) {
                player.totaligcviewtime = 0;
            }
            player.totaligcviewtime += int(igcviewtimesec / 1000);
        }
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xbbe7d7cb, Offset: 0x5e80
// Size: 0xd0
function set_igc_active(b_in_igc) {
    n_ent_num = self getentitynumber();
    n_players_in_igc_field = level clientfield::get("in_igc");
    if (b_in_igc) {
        n_players_in_igc_field |= 1 << n_ent_num;
    } else {
        n_players_in_igc_field &= ~(1 << n_ent_num);
    }
    updateigcviewtime(b_in_igc);
    level clientfield::set("in_igc", n_players_in_igc_field);
    /#
    #/
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x22064c1d, Offset: 0x5f58
// Size: 0x60
function is_igc_active() {
    n_players_in_igc = level clientfield::get("in_igc");
    n_entnum = self getentitynumber();
    return n_players_in_igc & 1 << n_entnum;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x21b41f69, Offset: 0x5fc0
// Size: 0xd4
function get_scene_shot(str_scene) {
    foreach (o_scene in self.scenes) {
        if (o_scene._str_name === str_scene) {
            return o_scene._str_shot;
        }
    }
    /#
        assert("<dev string:x2bf>" + str_scene + "<dev string:x2c7>");
    #/
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xd5adf3a4, Offset: 0x60a0
// Size: 0x5c
function is_capture_mode() {
    str_mode = getdvarstring("scene_menu_mode", "default");
    if (issubstr(str_mode, "capture")) {
        return 1;
    }
    return 0;
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xc9ef880, Offset: 0x6108
// Size: 0x1e
function should_spectate_on_join() {
    return isdefined(level.scene_should_spectate_on_hot_join) && level.scene_should_spectate_on_hot_join;
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x44f70a7e, Offset: 0x6130
// Size: 0x2c
function wait_until_spectate_on_join_completes() {
    while (isdefined(level.scene_should_spectate_on_hot_join) && level.scene_should_spectate_on_hot_join) {
        waitframe(1);
    }
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x0
// Checksum 0x2d5ccc6e, Offset: 0x6168
// Size: 0x5aa
function skip_scene(scene_name, var_55a89816, b_player_scene, var_53e46d30) {
    if (!isdefined(scene_name)) {
        if (isdefined(level.var_e0ec1056)) {
            scene_name = level.var_e0ec1056;
        }
        if (!isdefined(scene_name)) {
            if (isdefined(level.players) && isdefined(level.players[0].current_scene)) {
                scene_name = level.players[0].current_scene;
            }
            if (!isdefined(scene_name)) {
                foreach (player in level.players) {
                    if (isdefined(player.current_scene)) {
                        scene_name = player.current_scene;
                        break;
                    }
                }
            }
        }
    }
    /#
        if (getdvarint("<dev string:x2ec>") > 0) {
            if (isdefined(scene_name)) {
                printtoprightln("<dev string:x2fd>" + scene_name + "<dev string:x31c>" + gettime(), (1, 0.5, 0));
            } else {
                printtoprightln("<dev string:x320>" + gettime(), (1, 0.5, 0));
            }
        }
    #/
    if (!(isdefined(var_55a89816) && var_55a89816)) {
        if (!isdefined(b_player_scene)) {
            foreach (player in level.players) {
                if (isdefined(player.current_scene) && player.current_scene == scene_name) {
                    b_player_scene = 1;
                    break;
                }
            }
        }
        if (isdefined(b_player_scene) && b_player_scene) {
            a_instances = get_active_scenes(scene_name);
            var_cb82c545 = 0;
            foreach (s_instance in arraycopy(a_instances)) {
                if (isdefined(s_instance)) {
                    var_7aef94aa = s_instance _skip_scene(scene_name, 0, 1, 0);
                    if (var_7aef94aa == 2) {
                        break;
                    }
                    if (var_7aef94aa == 1) {
                        var_cb82c545 = 1;
                        break;
                    }
                }
            }
            if (isdefined(var_cb82c545) && var_cb82c545) {
                a_instances = get_active_scenes();
                foreach (s_instance in arraycopy(a_instances)) {
                    if (isdefined(s_instance)) {
                        s_instance _skip_scene(scene_name, 0, 0, 1);
                    }
                }
                return;
            }
            level.var_a1d36213 = undefined;
            level.var_e0ec1056 = undefined;
            return;
        }
    }
    a_instances = struct::get_array(scene_name, "targetname");
    if (!a_instances.size) {
        a_instances = get_active_scenes(scene_name);
    }
    foreach (s_instance in arraycopy(a_instances)) {
        if (isdefined(s_instance)) {
            s_instance _skip_scene(scene_name, var_55a89816, b_player_scene, var_53e46d30);
        }
    }
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x0
// Checksum 0xdb35ac42, Offset: 0x6720
// Size: 0x3ee
function _skip_scene(var_7265d040, var_55a89816, b_player_scene, var_53e46d30) {
    var_7aef94aa = 0;
    if (isdefined(self.scenes)) {
        foreach (o_scene in arraycopy(self.scenes)) {
            if (isdefined(o_scene.skipping_scene) && o_scene.skipping_scene) {
                continue;
            }
            if (!(isdefined(var_55a89816) && var_55a89816)) {
                if (isdefined(b_player_scene) && b_player_scene && !(isdefined(var_53e46d30) && var_53e46d30)) {
                    if (o_scene._s.name === var_7265d040) {
                        if (isdefined(o_scene._s.disablesceneskipping) && o_scene._s.disablesceneskipping) {
                            return 2;
                        } else {
                            var_7aef94aa = 1;
                        }
                    } else if (!isdefined(var_7265d040)) {
                        if ([[ o_scene ]]->is_scene_shared()) {
                            if (isdefined(o_scene._s.disablesceneskipping) && o_scene._s.disablesceneskipping) {
                                return 2;
                            } else {
                                var_7aef94aa = 1;
                            }
                        } else {
                            continue;
                        }
                    } else {
                        continue;
                    }
                }
                var_c36badf6 = array::contains(level.var_109c74a6, o_scene._str_name);
                if (isdefined(o_scene._s.disablesceneskipping) && (!var_c36badf6 || isdefined(var_53e46d30) && var_53e46d30 && o_scene._s.disablesceneskipping)) {
                    continue;
                }
                if (var_c36badf6 && (!isdefined(var_7265d040) || o_scene._str_name == var_7265d040 || !(isdefined(o_scene._s.disablesceneskipping) && o_scene._s.disablesceneskipping))) {
                    if (isdefined(b_player_scene) && (!isdefined(var_7265d040) || o_scene._str_name == var_7265d040) && b_player_scene && !(isdefined(var_53e46d30) && var_53e46d30) && !var_c36badf6) {
                        var_7aef94aa = 1;
                        o_scene.b_player_scene = 1;
                        level.var_cd66d9d1 = o_scene._str_name;
                    }
                    o_scene.skipping_scene = 1;
                    thread [[ o_scene ]]->skip_scene(var_55a89816);
                }
                continue;
            }
            o_scene.b_player_scene = b_player_scene;
            o_scene.skipping_scene = 1;
            thread [[ o_scene ]]->skip_scene(var_55a89816);
        }
    }
    return var_7aef94aa;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x724d6d20, Offset: 0x6b18
// Size: 0x4c
function function_9e5b8cdb(var_68612a53) {
    if (!isdefined(level.var_109c74a6)) {
        level.var_109c74a6 = [];
    }
    array::add(level.var_109c74a6, var_68612a53);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x14904d8c, Offset: 0x6b70
// Size: 0x3c
function function_bac0d34c(var_68612a53) {
    if (isdefined(level.var_109c74a6)) {
        arrayremovevalue(level.var_109c74a6, var_68612a53);
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x7890ae9a, Offset: 0x6bb8
// Size: 0x1e
function function_f69c7a83() {
    while (isdefined(level.var_cd66d9d1)) {
        waitframe(1);
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x46a31410, Offset: 0x6be0
// Size: 0x10
function function_b1f75ee9() {
    return isdefined(level.var_cd66d9d1);
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x669e8263, Offset: 0x6bf8
// Size: 0x80
function function_557b98ac() {
    self endon(#"disconnect");
    while (true) {
        level waittill("scene_sequence_started");
        self thread function_b5cb230();
        self thread function_b76e09b();
        self thread function_e79b5797();
        level waittill("scene_sequence_ended");
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x9101a8c9, Offset: 0x6c80
// Size: 0xf8
function clear_scene_skipping_ui() {
    level endon(#"hash_1c353a4f");
    if (isdefined(self.scene_skip_timer)) {
        self.scene_skip_timer = undefined;
    }
    if (isdefined(self.scene_skip_start_time)) {
        self.scene_skip_start_time = undefined;
    }
    foreach (player in level.players) {
        if (isdefined(player.skip_scene_menu_handle)) {
            player closeluimenu(player.skip_scene_menu_handle);
            player.skip_scene_menu_handle = undefined;
        }
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xdf0946f0, Offset: 0x6d80
// Size: 0x3c
function function_b76e09b() {
    self endon(#"disconnect");
    self endon(#"scene_being_skipped");
    level waittill("scene_sequence_ended");
    clear_scene_skipping_ui();
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x5d52f590, Offset: 0x6dc8
// Size: 0x4c
function function_e79b5797() {
    self endon(#"disconnect");
    level endon(#"hash_14c06c0c");
    self waittill("scene_being_skipped");
    level.sceneskippedcount++;
    clear_scene_skipping_ui();
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xb8791354, Offset: 0x6e20
// Size: 0x5d4
function function_b5cb230() {
    self endon(#"disconnect");
    level endon(#"hash_14c06c0c");
    b_skip_scene = 0;
    clear_scene_skipping_ui();
    waitframe(1);
    foreach (player in level.players) {
        if (isdefined(player.skip_scene_menu_handle)) {
            player closeluimenu(player.skip_scene_menu_handle);
            waitframe(1);
        }
        player.skip_scene_menu_handle = player openluimenu("CPSkipSceneMenu");
        player setluimenudata(player.skip_scene_menu_handle, "showSkipButton", 0);
        player setluimenudata(player.skip_scene_menu_handle, "hostIsSkipping", 0);
        player setluimenudata(player.skip_scene_menu_handle, "sceneSkipEndTime", 0);
    }
    while (true) {
        if (self any_button_pressed() && !(isdefined(level.chyron_text_active) && level.chyron_text_active)) {
            if (!isdefined(self.scene_skip_timer)) {
                self setluimenudata(self.skip_scene_menu_handle, "showSkipButton", 1);
            }
            self.scene_skip_timer = gettime();
        } else if (isdefined(self.scene_skip_timer)) {
            if (gettime() - self.scene_skip_timer > 3000) {
                self setluimenudata(self.skip_scene_menu_handle, "showSkipButton", 2);
                self.scene_skip_timer = undefined;
            }
        }
        if (self primarybuttonpressedlocal() && !(isdefined(level.chyron_text_active) && level.chyron_text_active)) {
            if (!isdefined(self.scene_skip_start_time)) {
                foreach (player in level.players) {
                    if (player ishost()) {
                        player setluimenudata(player.skip_scene_menu_handle, "sceneSkipEndTime", gettime() + 2500);
                        continue;
                    }
                    if (isdefined(player.skip_scene_menu_handle)) {
                        player setluimenudata(player.skip_scene_menu_handle, "hostIsSkipping", 1);
                    }
                }
                self.scene_skip_start_time = gettime();
            } else if (gettime() - self.scene_skip_start_time > 2500) {
                b_skip_scene = 1;
                break;
            }
        } else if (isdefined(self.scene_skip_start_time)) {
            foreach (player in level.players) {
                if (player ishost()) {
                    player setluimenudata(player.skip_scene_menu_handle, "sceneSkipEndTime", 0);
                    continue;
                }
                if (isdefined(player.skip_scene_menu_handle)) {
                    player setluimenudata(player.skip_scene_menu_handle, "hostIsSkipping", 2);
                }
            }
            self.scene_skip_start_time = undefined;
        }
        if (isdefined(level.chyron_text_active) && level.chyron_text_active) {
            while (isdefined(level.chyron_text_active) && level.chyron_text_active) {
                waitframe(1);
            }
            wait 3;
        }
        waitframe(1);
    }
    if (b_skip_scene) {
        self playsound("uin_igc_skip");
        self notify(#"scene_being_skipped");
        level notify(#"hash_cdfdddaf");
        skip_scene(level.var_e0ec1056, 0, 1);
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x2549004b, Offset: 0x7400
// Size: 0x1a6
function any_button_pressed() {
    if (self actionslotonebuttonpressed()) {
        return true;
    } else if (self actionslottwobuttonpressed()) {
        return true;
    } else if (self actionslotthreebuttonpressed()) {
        return true;
    } else if (self actionslotfourbuttonpressed()) {
        return true;
    } else if (self jumpbuttonpressed()) {
        return true;
    } else if (self stancebuttonpressed()) {
        return true;
    } else if (self weaponswitchbuttonpressed()) {
        return true;
    } else if (self reloadbuttonpressed()) {
        return true;
    } else if (self fragbuttonpressed()) {
        return true;
    } else if (self throwbuttonpressed()) {
        return true;
    } else if (self attackbuttonpressed()) {
        return true;
    } else if (self secondaryoffhandbuttonpressed()) {
        return true;
    } else if (self meleebuttonpressed()) {
        return true;
    }
    return false;
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x642326c7, Offset: 0x75b0
// Size: 0x1e
function on_player_connect() {
    if (self ishost()) {
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x7e0a11c5, Offset: 0x75d8
// Size: 0x1c
function on_player_disconnect() {
    self set_igc_active(0);
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0xa4d3ff6d, Offset: 0x7600
// Size: 0xe4
function add_scene_ordered_notetrack(group_name, str_note) {
    if (!isdefined(level.scene_ordered_notetracks)) {
        level.scene_ordered_notetracks = [];
    }
    group_obj = level.scene_ordered_notetracks[group_name];
    if (!isdefined(group_obj)) {
        group_obj = spawnstruct();
        group_obj.count = 0;
        group_obj.current_count = 0;
        level.scene_ordered_notetracks[group_name] = group_obj;
    }
    group_obj.count++;
    self thread _wait_for_ordered_notify(group_obj.count - 1, group_obj, group_name, str_note);
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x0
// Checksum 0x817eb116, Offset: 0x76f0
// Size: 0x254
function _wait_for_ordered_notify(id, group_obj, group_name, str_note) {
    self waittill(str_note);
    if (group_obj.current_count == id) {
        group_obj.current_count++;
        self notify("scene_" + str_note);
        waitframe(1);
        if (group_obj.current_count == group_obj.count) {
            group_obj.pending_notifies = undefined;
            level.scene_ordered_notetracks[group_name] = undefined;
        } else if (isdefined(group_obj.pending_notifies) && group_obj.current_count + group_obj.pending_notifies.size == group_obj.count) {
            self thread _fire_ordered_notitifes(group_obj, group_name);
        }
        return;
    }
    if (!isdefined(group_obj.pending_notifies)) {
        group_obj.pending_notifies = [];
    }
    notetrack = spawnstruct();
    notetrack.id = id;
    notetrack.str_note = str_note;
    for (i = 0; i < group_obj.pending_notifies.size && group_obj.pending_notifies[i].id < id; i++) {
    }
    arrayinsert(group_obj.pending_notifies, notetrack, i);
    if (group_obj.current_count + group_obj.pending_notifies.size == group_obj.count) {
        self thread _fire_ordered_notitifes(group_obj, group_name);
    }
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0xd7120dec, Offset: 0x7950
// Size: 0xb4
function _fire_ordered_notitifes(group_obj, group_name) {
    if (isdefined(group_obj.pending_notifies)) {
        while (group_obj.pending_notifies.size > 0) {
            self notify("scene_" + group_obj.pending_notifies[0].str_note);
            arrayremoveindex(group_obj.pending_notifies, 0);
            waitframe(1);
        }
    }
    group_obj.pending_notifies = undefined;
    level.scene_ordered_notetracks[group_name] = undefined;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x4e758494, Offset: 0x7a10
// Size: 0x4c
function add_wait_for_streamer_hint_scene(str_scene_name) {
    if (!isdefined(level.wait_for_streamer_hint_scenes)) {
        level.wait_for_streamer_hint_scenes = [];
    }
    array::add(level.wait_for_streamer_hint_scenes, str_scene_name);
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0xd1b3a757, Offset: 0x7a68
// Size: 0x24c
function get_existing_ent(str_name, b_spawner_only, b_nodes_and_structs) {
    if (!isdefined(b_spawner_only)) {
        b_spawner_only = 0;
    }
    if (!isdefined(b_nodes_and_structs)) {
        b_nodes_and_structs = 0;
    }
    e = undefined;
    if (b_spawner_only) {
        e_array = getspawnerarray(str_name, "script_animname");
        if (e_array.size == 0) {
            e_array = getspawnerarray(str_name, "targetname");
        }
        /#
            assert(e_array.size <= 1, "<dev string:x34d>");
        #/
        foreach (ent in e_array) {
            if (!isdefined(ent.isdying)) {
                e = ent;
                break;
            }
        }
    } else {
        e = function_72ab741e(str_name);
        if (!is_valid_ent(e)) {
            e = get_existing_ent_by_targetname(str_name);
            if (!is_valid_ent(e) && b_nodes_and_structs) {
                e = getnode(str_name, "targetname");
                if (!is_valid_ent(e)) {
                    e = struct::get(str_name, "targetname");
                }
            }
        }
    }
    if (is_valid_ent(e)) {
        return e;
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xac9b36d6, Offset: 0x7cc0
// Size: 0xe4
function function_72ab741e(str_name) {
    e = _get_existing_ent(str_name, "animname", 1);
    if (!is_valid_ent(e)) {
        e = _get_existing_ent(str_name, "animname");
        if (!is_valid_ent(e)) {
            e = _get_existing_ent(str_name, "script_animname", 1);
            if (!is_valid_ent(e)) {
                e = _get_existing_ent(str_name, "script_animname");
            }
        }
    }
    return e;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x7936c3fe, Offset: 0x7db0
// Size: 0x104
function get_existing_ent_by_targetname(str_name) {
    e = _get_existing_ent(str_name + "_ai", "targetname", 1);
    if (!is_valid_ent(e)) {
        e = _get_existing_ent(str_name + "_vh", "targetname", 1);
        if (!is_valid_ent(e)) {
            e = _get_existing_ent(str_name, "targetname", 1);
            if (!is_valid_ent(e)) {
                e = _get_existing_ent(str_name, "targetname");
            }
        }
    }
    return e;
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0xf90cb855, Offset: 0x7ec0
// Size: 0xbc
function _get_existing_ent(val, key, b_ignore_spawners) {
    if (!isdefined(b_ignore_spawners)) {
        b_ignore_spawners = 0;
    }
    /#
        a_ents = getentarray(val, key, b_ignore_spawners);
        /#
            assert(a_ents.size <= 1, "<dev string:x366>");
        #/
    #/
    e = getent(val, key, b_ignore_spawners);
    return e;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xe9845d66, Offset: 0x7f88
// Size: 0x60
function is_valid_ent(ent) {
    return !isdefined(ent.isdying) && !ent ai::is_dead_sentient() || isdefined(ent) && self._s.ignorealivecheck === 1;
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xe14bdb50, Offset: 0x7ff0
// Size: 0x1d4
function synced_delete() {
    self endon(#"death");
    self.isdying = 1;
    if (isdefined(self.targetname)) {
        self.targetname += "_sync_deleting";
    }
    if (isdefined(self.animname)) {
        self.animname += "_sync_deleting";
    }
    if (isdefined(self.script_animname)) {
        self.script_animname += "_sync_deleting";
    }
    if (!isplayer(self)) {
        sethideonclientwhenscriptedanimcompleted(self);
        self stopanimscripted();
    } else {
        waitframe(1);
        self ghost();
    }
    self notsolid();
    if (isalive(self)) {
        if (issentient(self)) {
            self val::set("synced_delete", "ignoreall", 1);
        }
        if (isactor(self)) {
            self pathmode("dont move");
        }
    }
    wait 1;
    self delete();
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x7214f78, Offset: 0x81d0
// Size: 0x1c4
function error_on_screen(str_msg) {
    if (str_msg != "") {
        if (!isdefined(level.scene_error_hud)) {
            level.scene_error_hud = level.players[0] openluimenu("HudElementText");
            level.players[0] setluimenudata(level.scene_error_hud, "alignment", 2);
            level.players[0] setluimenudata(level.scene_error_hud, "x", 0);
            level.players[0] setluimenudata(level.scene_error_hud, "y", 10);
            level.players[0] setluimenudata(level.scene_error_hud, "width", 1280);
            level.players[0] lui::set_color(level.scene_error_hud, (1, 0, 0));
        }
        level.players[0] setluimenudata(level.scene_error_hud, "text", str_msg);
        self thread _destroy_error_on_screen();
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x265eee5c, Offset: 0x83a0
// Size: 0x6e
function _destroy_error_on_screen() {
    level notify(#"_destroy_error_on_screen");
    level endon(#"_destroy_error_on_screen");
    self waittilltimeout(5, "stopped");
    level.players[0] closeluimenu(level.scene_error_hud);
    level.scene_error_hud = undefined;
}

/#

    // Namespace scene/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0x846c52b2, Offset: 0x8418
    // Size: 0x1cc
    function warning_on_screen(str_msg) {
        if (str_msg != "<dev string:x38c>") {
            if (!isdefined(level.scene_warning_hud)) {
                level.scene_warning_hud = level.players[0] openluimenu("<dev string:x38d>");
                level.players[0] setluimenudata(level.scene_warning_hud, "<dev string:x39c>", 2);
                level.players[0] setluimenudata(level.scene_warning_hud, "<dev string:x3a6>", 0);
                level.players[0] setluimenudata(level.scene_warning_hud, "<dev string:x3a8>", 1060);
                level.players[0] setluimenudata(level.scene_warning_hud, "<dev string:x3aa>", 1280);
                level.players[0] lui::set_color(level.scene_warning_hud, (1, 1, 0));
            }
            level.players[0] setluimenudata(level.scene_warning_hud, "<dev string:x3b0>", str_msg);
            level thread _destroy_warning_on_screen();
        }
    }

#/

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xb311dab9, Offset: 0x85f0
// Size: 0x5e
function _destroy_warning_on_screen() {
    level notify(#"_destroy_warning_on_screen");
    level endon(#"_destroy_warning_on_screen");
    wait 10;
    level.players[0] closeluimenu(level.scene_warning_hud);
    level.scene_warning_hud = undefined;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x5e5b482e, Offset: 0x8658
// Size: 0xd4
function wait_server_time(n_time, n_start_time) {
    if (!isdefined(n_start_time)) {
        n_start_time = 0;
    }
    n_len = n_time - n_time * n_start_time;
    n_len /= 0.05;
    n_len_int = int(n_len);
    if (n_len_int != n_len) {
        n_len = floor(n_len);
    }
    n_server_length = n_len * 0.05;
    waitframe(int(n_len));
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x8cce951e, Offset: 0x8738
// Size: 0xd8
function check_team(str_team1, str_team2) {
    if (!isdefined(str_team1)) {
        str_team1 = "any";
    }
    if (!isdefined(str_team2)) {
        str_team2 = "any";
    }
    str_team1 = tolower(str_team1);
    str_team2 = tolower(str_team2);
    str_team1 = util::get_team_mapping(str_team1);
    str_team2 = util::get_team_mapping(str_team2);
    if (str_team1 == "any" || str_team2 == "any") {
        return true;
    }
    return str_team1 == str_team2;
}

