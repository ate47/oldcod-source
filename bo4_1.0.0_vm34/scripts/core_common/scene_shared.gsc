#using script_439e9618e516580f;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\oob;
#using scripts\core_common\scene_debug_shared;
#using scripts\core_common\scene_objects_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace scene;

// Namespace scene/scene_shared
// Params 0, eflags: 0x2
// Checksum 0xb5d0bb2b, Offset: 0x518
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"scene", &__init__, &__main__, undefined);
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x64398486, Offset: 0x568
// Size: 0x42c
function __init__() {
    if (!isdefined(level.scene_sequence_names)) {
        level.scene_sequence_names = [];
    }
    if (!isdefined(level.scene_streamer_ignore)) {
        level.scene_streamer_ignore = [];
    }
    level.scenedefs = getscriptbundlenames("scene");
    level.active_scenes = [];
    level.inactive_scenes = [];
    level.active_scenes = [];
    level.sceneskippedcount = 0;
    lui::add_luimenu("cp_skip_scene_menu", &cp_skip_scene_menu::register, "cp_skip_scene_menu");
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
    clientfield::register("toplayer", "postfx_cateye", 1, 1, "int");
    clientfield::register("toplayer", "player_scene_skip_completed", 1, 2, "counter");
    clientfield::register("toplayer", "player_pbg_bank_scene_system", 1, getminbitcountfornum(3), "int");
    clientfield::register("allplayers", "player_scene_animation_skip", 1, 2, "counter");
    clientfield::register("actor", "player_scene_animation_skip", 1, 2, "counter");
    clientfield::register("vehicle", "player_scene_animation_skip", 1, 2, "counter");
    clientfield::register("scriptmover", "player_scene_animation_skip", 1, 2, "counter");
    callback::on_disconnect(&on_player_disconnect);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xe4d89c55, Offset: 0x9a0
// Size: 0x3e8
function function_a5a6992f(var_4e8029c3) {
    if (isarray(var_4e8029c3.var_2830ea4f) && var_4e8029c3.var_2830ea4f.size) {
        var_3e7f53ab = [];
        if (!isdefined(level.heroes)) {
            level.heroes = [];
        }
        foreach (specialist in level.heroes) {
            str_name = specialist.animname;
            if (!isdefined(var_3e7f53ab)) {
                var_3e7f53ab = [];
            } else if (!isarray(var_3e7f53ab)) {
                var_3e7f53ab = array(var_3e7f53ab);
            }
            var_3e7f53ab[var_3e7f53ab.size] = str_name;
        }
        var_de63d86e = [];
        foreach (var_9841b450 in var_4e8029c3.var_2830ea4f) {
            str_scenedef = var_9841b450.var_9c76dcc6;
            if (!isdefined(str_scenedef)) {
                continue;
            }
            var_c56c2a97 = getscriptbundle(str_scenedef);
            var_cc146976 = [];
            foreach (var_90a08110 in var_c56c2a97.objects) {
                if (isdefined(var_90a08110.specialistname)) {
                    if (!isdefined(var_cc146976)) {
                        var_cc146976 = [];
                    } else if (!isarray(var_cc146976)) {
                        var_cc146976 = array(var_cc146976);
                    }
                    if (!isinarray(var_cc146976, var_90a08110.specialistname)) {
                        var_cc146976[var_cc146976.size] = var_90a08110.specialistname;
                    }
                }
            }
            if (isarray(var_cc146976)) {
                foreach (str_name in var_3e7f53ab) {
                    if (isinarray(var_cc146976, str_name)) {
                        if (!isdefined(var_de63d86e)) {
                            var_de63d86e = [];
                        } else if (!isarray(var_de63d86e)) {
                            var_de63d86e = array(var_de63d86e);
                        }
                        if (!isinarray(var_de63d86e, var_c56c2a97)) {
                            var_de63d86e[var_de63d86e.size] = var_c56c2a97;
                        }
                    }
                }
            }
        }
        return var_de63d86e;
    }
    return undefined;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x64f726bc, Offset: 0xd90
// Size: 0xae
function function_510b0598(var_2109d5f8, var_c56c2a97) {
    foreach (var_9770a74c in var_c56c2a97.objects) {
        if (isdefined(var_9770a74c.specialistname) && var_9770a74c.specialistname != var_2109d5f8) {
            return var_9770a74c.specialistname;
        }
    }
    return undefined;
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xca9c8a3, Offset: 0xe48
// Size: 0x1dc
function function_ea9f6e24() {
    if (function_9181f70f(self.name)) {
        self.igc = 1;
        return;
    }
    foreach (s_object in self.objects) {
        if (!(isdefined(s_object.disabled) && s_object.disabled) && !(isdefined(s_object.showhud) && s_object.showhud)) {
            if (isdefined(s_object.shots)) {
                foreach (s_shot in s_object.shots) {
                    if (isdefined(s_shot.entry)) {
                        foreach (s_entry in s_shot.entry) {
                            if (isdefined(s_entry.cameraswitcher)) {
                                self.igc = 1;
                                return;
                            }
                        }
                    }
                }
            }
        }
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x9207dc46, Offset: 0x1030
// Size: 0x7d0
function fixup_scenedef(s_scenedef) {
    if (isdefined(s_scenedef.objects[0]) && isdefined(s_scenedef.objects[0].shots)) {
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
    if (isstring(s_scenedef.femalebundle) || ishash(s_scenedef.femalebundle)) {
        s_female_bundle = struct::get_script_bundle("scene", s_scenedef.femalebundle);
        s_female_bundle.malebundle = s_scenedef.name;
        s_scenedef.s_female_bundle = s_female_bundle;
        s_female_bundle.s_male_bundle = s_scenedef;
    }
    if (isdefined(level.scene_sequence_names) && !isdefined(level.scene_sequence_names[s_scenedef.name])) {
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
    if (isstring(s_scenedef.nextscenebundle) || ishash(s_scenedef.nextscenebundle)) {
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
        }
    }
    if (isstring(s_scenedef.cameraswitcher) || ishash(s_scenedef.cameraswitcher)) {
        s_scenedef.igc = 1;
    }
    convert_to_new_format(s_scenedef);
    return s_scenedef;
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x0
// Checksum 0x1f88b3a1, Offset: 0x1808
// Size: 0x1e4
function function_61cee5af(var_f0142d04, var_615a96f0, str_field, var_893cb0ac) {
    var_f0142d04--;
    var_615a96f0--;
    if (!isdefined(self.shots)) {
        self.shots = [];
    }
    if (!isdefined(self.shots[0])) {
        self.shots[0] = spawnstruct();
    }
    if (!isdefined(self.shots[0].entry)) {
        self.shots[0].entry = [];
    }
    if (!isdefined(self.shots[0].entry[0])) {
        self.shots[0].entry[0] = spawnstruct();
    }
    if (!isdefined(self.shots[var_f0142d04])) {
        self.shots[var_f0142d04] = spawnstruct();
        self.shots[var_f0142d04].entry = [];
        self.shots[var_f0142d04].entry[0] = spawnstruct();
    }
    if (!isdefined(self.shots[var_f0142d04].entry[var_615a96f0])) {
        self.shots[var_f0142d04].entry[var_615a96f0] = spawnstruct();
    }
    self.shots[var_f0142d04].entry[var_615a96f0].(str_field) = var_893cb0ac;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x104404d6, Offset: 0x19f8
// Size: 0x4a
function function_5abaf630(n_shot, str_shot_name) {
    n_shot--;
    if (isdefined(self.shots[n_shot])) {
        self.shots[n_shot].name = str_shot_name;
    }
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0xb7b04a98, Offset: 0x1a50
// Size: 0xf0
function function_1c62ac51(var_27c3bf38, str_field, var_893cb0ac) {
    if (isstruct(var_27c3bf38)) {
        var_27c3bf38.(str_field) = var_893cb0ac;
        return;
    }
    var_27c3bf38--;
    if (!isdefined(self.shots)) {
        self.shots = [];
    }
    if (!isdefined(self.shots[0])) {
        self.shots[0] = spawnstruct();
    }
    if (!isdefined(self.shots[var_27c3bf38])) {
        self.shots[var_27c3bf38] = spawnstruct();
    }
    self.shots[var_27c3bf38].(str_field) = var_893cb0ac;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xe20886dc, Offset: 0x1b48
// Size: 0x802
function convert_to_new_format(s_scenedef) {
    foreach (s_object in s_scenedef.objects) {
        s_object.old_scene_version = 1;
        b_has_init = 0;
        b_has_main = 0;
        b_has_camera = 0;
        if (isdefined(s_object.firstframe) && s_object.firstframe) {
            b_has_init = 1;
            s_object function_61cee5af(1, 1, "anim", s_object.mainanim);
        } else {
            if (isdefined(s_object.initanim)) {
                b_has_init = 1;
                s_object function_61cee5af(1, 1, "anim", s_object.initanim);
            }
            if (isdefined(s_object.initanimloop)) {
                b_has_init = 1;
                s_object function_61cee5af(1, 2, "anim", s_object.initanimloop);
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
                s_object function_61cee5af(2, 1, "cameraswitcher", s_object.cameraswitcher);
            } else {
                s_object function_61cee5af(1, 1, "cameraswitcher", s_object.cameraswitcher);
            }
        }
        if (!isdefined(s_object.mainblend)) {
            s_object.mainblend = 0.02;
        }
        b_has_main = 1;
        if (b_has_init) {
            if (b_has_camera) {
                s_object function_61cee5af(2, 2, "blend", s_object.mainblend);
            } else {
                s_object function_61cee5af(2, 1, "blend", s_object.mainblend);
            }
        } else if (b_has_camera) {
            s_object function_61cee5af(1, 2, "blend", s_object.mainblend);
        } else {
            s_object function_61cee5af(1, 1, "blend", s_object.mainblend);
        }
        if (isdefined(s_object.mainanim)) {
            b_has_main = 1;
            if (b_has_init) {
                if (b_has_camera) {
                    s_object function_61cee5af(2, 3, "anim", s_object.mainanim);
                } else {
                    s_object function_61cee5af(2, 2, "anim", s_object.mainanim);
                }
            } else if (b_has_camera) {
                s_object function_61cee5af(1, 3, "anim", s_object.mainanim);
            } else {
                s_object function_61cee5af(1, 2, "anim", s_object.mainanim);
            }
        }
        if (isdefined(s_object.endblend)) {
            b_has_main = 1;
            if (b_has_init) {
                s_object function_61cee5af(2, 3, "blend", s_object.endblend);
            } else {
                s_object function_61cee5af(1, 3, "blend", s_object.endblend);
            }
        }
        if (isdefined(s_object.endanim)) {
            b_has_main = 1;
            if (b_has_init) {
                s_object function_61cee5af(2, 4, "anim", s_object.endanim);
            } else {
                s_object function_61cee5af(1, 4, "anim", s_object.endanim);
            }
        }
        if (isdefined(s_object.endanimloop)) {
            b_has_main = 1;
            if (b_has_init) {
                s_object function_61cee5af(2, 5, "anim", s_object.endanimloop);
            } else {
                s_object function_61cee5af(1, 5, "anim", s_object.endanimloop);
            }
        }
        if (b_has_init) {
            s_object function_5abaf630(1, "init");
            var_be2bdbd0 = s_object.shots[0];
            if (isdefined(s_object.initdelaymin)) {
                s_object function_1c62ac51(var_be2bdbd0, "SpacerMin", s_object.initdelaymin);
            }
            if (isdefined(s_object.initdelaymax)) {
                s_object function_1c62ac51(var_be2bdbd0, "SpacerMax", s_object.initdelaymax);
            }
        }
        if (b_has_main) {
            if (b_has_init) {
                s_object function_5abaf630(2, "play");
                var_efcdd7f8 = s_object.shots[1];
            } else {
                s_object function_5abaf630(1, "play");
                var_efcdd7f8 = s_object.shots[0];
            }
            if (isdefined(s_object.maindelaymin)) {
                s_object function_1c62ac51(var_efcdd7f8, "SpacerMin", s_object.maindelaymin);
            }
            if (isdefined(s_object.maindelaymax)) {
                s_object function_1c62ac51(var_efcdd7f8, "SpacerMax", s_object.maindelaymax);
            }
        }
        s_object.initanim = undefined;
        s_object.initanimloop = undefined;
        s_object.mainblend = undefined;
        s_object.mainanim = undefined;
        s_object.endblend = undefined;
        s_object.endanim = undefined;
        s_object.endanimloop = undefined;
        s_object.initdelaymin = undefined;
        s_object.initdelaymax = undefined;
        s_object.maindelaymin = undefined;
        s_object.maindelaymax = undefined;
    }
    s_scenedef.old_scene_version = 1;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x2af43537, Offset: 0x2358
// Size: 0x230
function get_all_shot_names(str_scenedef, var_eb7f8dae = 0) {
    s_scenedef = get_scenedef(str_scenedef);
    if (isdefined(s_scenedef.a_str_shot_names)) {
        a_shots = s_scenedef.a_str_shot_names;
        if (var_eb7f8dae) {
            arrayremovevalue(a_shots, "init");
        }
        return a_shots;
    }
    a_shots = [];
    foreach (s_object in s_scenedef.objects) {
        if (!(isdefined(s_object.disabled) && s_object.disabled)) {
            foreach (s_shot in s_object.shots) {
                if (!isdefined(a_shots)) {
                    a_shots = [];
                } else if (!isarray(a_shots)) {
                    a_shots = array(a_shots);
                }
                if (!isinarray(a_shots, s_shot.name)) {
                    a_shots[a_shots.size] = s_shot.name;
                }
            }
        }
    }
    s_scenedef.a_str_shot_names = a_shots;
    if (var_eb7f8dae) {
        arrayremovevalue(a_shots, "init");
    }
    return a_shots;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x2df25559, Offset: 0x2590
// Size: 0x98
function function_f80af16d(str_scenedef) {
    s_scenedef = get_scenedef(str_scenedef);
    if (isdefined(s_scenedef.str_final_bundle)) {
        return s_scenedef.str_final_bundle;
    }
    if (isdefined(s_scenedef.var_88029ab6)) {
        return s_scenedef.var_88029ab6;
    }
    a_shots = get_all_shot_names(str_scenedef);
    return a_shots[a_shots.size - 1];
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x944e56b5, Offset: 0x2630
// Size: 0x86
function function_f589f84a(str_scenedef, str_shot) {
    a_shots = get_all_shot_names(str_scenedef);
    if (str_shot == "init") {
        return false;
    }
    arrayremovevalue(a_shots, "init");
    if (a_shots[0] === str_shot) {
        return true;
    }
    return false;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0xcecac7b1, Offset: 0x26c0
// Size: 0xb6
function function_1c059f9b(str_scenedef, str_shot) {
    var_88029ab6 = function_f80af16d(str_scenedef);
    s_scenedef = get_scenedef(str_scenedef);
    if (str_shot !== "init" && (str_shot === var_88029ab6 || isdefined(s_scenedef.old_scene_version) && s_scenedef.old_scene_version && str_shot === "play")) {
        return true;
    }
    return false;
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xfd7f47a7, Offset: 0x2780
// Size: 0x494
function __main__() {
    a_instances = arraycombine(struct::get_array("scriptbundle_scene", "classname"), struct::get_array("scriptbundle_fxanim", "classname"), 0, 0);
    function_bf34d1f2();
    foreach (s_instance in a_instances) {
        s_scenedef = getscriptbundle(s_instance.scriptbundlename);
        assert(isdefined(s_scenedef), "<dev string:x30>" + function_15979fa9(s_instance.scriptbundlename) + "<dev string:x3e>");
        if (s_scenedef.vmtype === "client") {
            continue;
        }
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
        s_instance function_8468771c();
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
// Checksum 0xa1ee3209, Offset: 0x2c20
// Size: 0xb8
function function_bff20b0b() {
    if (isdefined(self.script_scene_nodes)) {
        self.var_64774efa = getnodearray(self.script_scene_nodes, "script_scene_nodes");
        foreach (node in self.var_64774efa) {
            setenablenode(node, 1);
        }
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x420a1cc9, Offset: 0x2ce0
// Size: 0xb8
function function_8468771c() {
    if (isdefined(self.script_scene_nodes)) {
        self.var_64774efa = getnodearray(self.script_scene_nodes, "script_scene_nodes");
        foreach (node in self.var_64774efa) {
            setenablenode(node, 0);
        }
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xf54168c3, Offset: 0x2da0
// Size: 0x21e
function function_fefec137(var_ce243c8f) {
    if (self.classname === "scriptbundle_scene" && isdefined(self.script_scene_entities) && !isdefined(self get_active_scene(self.scriptbundlename))) {
        if (!isdefined(var_ce243c8f)) {
            var_ce243c8f = [];
        } else if (!isarray(var_ce243c8f)) {
            var_ce243c8f = array(var_ce243c8f);
        }
        var_db1d458b = [];
        if (!isdefined(self.scene_ents)) {
            var_db1d458b = getentarray(self.script_scene_entities, "script_scene_entities");
            var_db1d458b = array::remove_undefined(var_db1d458b);
            foreach (ent in arraycopy(var_db1d458b)) {
                if (isspawner(ent) && ent.count === 0 || isactor(ent) || isvehicle(ent)) {
                    ent.script_scene_entities = undefined;
                    arrayremovevalue(var_db1d458b, ent, 1);
                }
            }
        }
        a_ents = arraycombine(var_ce243c8f, var_db1d458b, 0, 0);
    } else {
        a_ents = var_ce243c8f;
    }
    return a_ents;
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xed261167, Offset: 0x2fc8
// Size: 0x250
function function_bf34d1f2() {
    /#
        a_triggers = trigger::get_all();
        foreach (trig in a_triggers) {
            if (isdefined(trig.targetname)) {
                str_trig_name = "<dev string:x9e>" + trig.targetname + "<dev string:xac>";
            } else {
                str_trig_name = "<dev string:xae>" + trig getentitynumber() + "<dev string:xac>";
            }
            if (isdefined(trig.scriptgroup_initscenes)) {
                a_instances = struct::get_array(trig.scriptgroup_initscenes, "<dev string:xbe>");
                assert(a_instances.size, "<dev string:xd5>" + str_trig_name + "<dev string:xde>" + trig.scriptgroup_initscenes);
            }
            if (isdefined(trig.scriptgroup_playscenes)) {
                a_instances = struct::get_array(trig.scriptgroup_playscenes, "<dev string:x12b>");
                assert(a_instances.size, "<dev string:xd5>" + str_trig_name + "<dev string:x142>" + trig.scriptgroup_playscenes);
            }
            if (isdefined(trig.scriptgroup_stopscenes)) {
                a_instances = struct::get_array(trig.scriptgroup_stopscenes, "<dev string:x18f>");
                assert(a_instances.size, "<dev string:xd5>" + str_trig_name + "<dev string:x1a6>" + trig.scriptgroup_stopscenes);
            }
        }
    #/
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xd5fb48ae, Offset: 0x3220
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
// Checksum 0x194345a1, Offset: 0x32e8
// Size: 0x44
function on_load_wait() {
    util::wait_network_frame();
    util::wait_network_frame();
    level flagsys::set(#"scene_on_load_wait");
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x3bb0fece, Offset: 0x3338
// Size: 0x148
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
// Checksum 0xbd24c704, Offset: 0x3488
// Size: 0xac
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
// Checksum 0xa8448744, Offset: 0x3540
// Size: 0xf8
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
// Checksum 0x690072d1, Offset: 0x3640
// Size: 0x4c
function _trigger_stop(trig) {
    trig endon(#"death");
    trig trigger::wait_till();
    self thread stop();
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x20 variadic
// Checksum 0xe2ba7fbd, Offset: 0x3698
// Size: 0x1d4
function add_scene_func(str_scenedef, func, var_f2be2307 = "play", ...) {
    assert(isdefined(getscriptbundle(str_scenedef)), "<dev string:x1f3>" + str_scenedef + "<dev string:x21e>");
    if (!isdefined(level.scene_funcs)) {
        level.scene_funcs = [];
    }
    if (!isdefined(level.scene_funcs[str_scenedef])) {
        level.scene_funcs[str_scenedef] = [];
    }
    var_f2be2307 = tolower(var_f2be2307);
    str_shot = function_3017192a(str_scenedef, var_f2be2307);
    if (!isdefined(level.scene_funcs[str_scenedef][str_shot])) {
        level.scene_funcs[str_scenedef][str_shot] = [];
    }
    if (var_f2be2307 === "play" && str_shot !== "play") {
        array::add(level.scene_funcs[str_scenedef][str_shot], array(func, vararg, 1), 0);
        return;
    }
    array::add(level.scene_funcs[str_scenedef][str_shot], array(func, vararg), 0);
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x20 variadic
// Checksum 0xaca840d4, Offset: 0x3878
// Size: 0x1d4
function function_e62681ef(str_scenedef, func, var_f2be2307 = "play", ...) {
    assert(isdefined(getscriptbundle(str_scenedef)), "<dev string:x1f3>" + str_scenedef + "<dev string:x21e>");
    if (!isdefined(level.var_26c1b074)) {
        level.var_26c1b074 = [];
    }
    if (!isdefined(level.var_26c1b074[str_scenedef])) {
        level.var_26c1b074[str_scenedef] = [];
    }
    var_f2be2307 = tolower(var_f2be2307);
    str_shot = function_3017192a(str_scenedef, var_f2be2307);
    if (!isdefined(level.var_26c1b074[str_scenedef][str_shot])) {
        level.var_26c1b074[str_scenedef][str_shot] = [];
    }
    if (var_f2be2307 === "play" && str_shot !== "play") {
        array::add(level.var_26c1b074[str_scenedef][str_shot], array(func, vararg, 1), 0);
        return;
    }
    array::add(level.var_26c1b074[str_scenedef][str_shot], array(func, vararg), 0);
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0xf2fce619, Offset: 0x3a58
// Size: 0x25e
function remove_scene_func(str_scenedef, func, var_f2be2307 = "play") {
    assert(isdefined(getscriptbundle(str_scenedef)), "<dev string:x234>" + str_scenedef + "<dev string:x21e>");
    if (!isdefined(level.scene_funcs)) {
        level.scene_funcs = [];
    }
    if (!isdefined(level.var_26c1b074)) {
        level.var_26c1b074 = [];
    }
    var_f2be2307 = tolower(var_f2be2307);
    str_shot = function_3017192a(str_scenedef, var_f2be2307);
    if (isdefined(level.scene_funcs[str_scenedef]) && isdefined(level.scene_funcs[str_scenedef][str_shot])) {
        for (i = level.scene_funcs[str_scenedef][str_shot].size - 1; i >= 0; i--) {
            if (level.scene_funcs[str_scenedef][str_shot][i][0] == func) {
                arrayremoveindex(level.scene_funcs[str_scenedef][str_shot], i);
            }
        }
    }
    if (isdefined(level.var_26c1b074[str_scenedef]) && isdefined(level.var_26c1b074[str_scenedef][str_shot])) {
        for (i = level.var_26c1b074[str_scenedef][str_shot].size - 1; i >= 0; i--) {
            if (level.var_26c1b074[str_scenedef][str_shot][i][0] == func) {
                arrayremoveindex(level.var_26c1b074[str_scenedef][str_shot], i);
            }
        }
    }
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x4
// Checksum 0x22428d4f, Offset: 0x3cc0
// Size: 0x92
function private function_3017192a(str_scenedef, str_state) {
    str_shot = str_state;
    if (str_state == "init") {
        str_shot = function_d0a1d87d(str_scenedef, "init");
    } else if (str_state == "play") {
        str_shot = function_d0a1d87d(str_scenedef, "play");
    }
    return str_shot;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x4dbb769c, Offset: 0x3d60
// Size: 0xa2
function get_scenedef(str_scenedef) {
    s_scriptbundle = getscriptbundle(str_scenedef);
    assert(isdefined(s_scriptbundle) && isdefined(s_scriptbundle.objects), "<dev string:x30>" + function_15979fa9(str_scenedef) + "<dev string:x262>");
    s_scriptbundle = fixup_scenedef(s_scriptbundle);
    return s_scriptbundle;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xf93e3533, Offset: 0x3e10
// Size: 0x138
function get_scenedefs(str_type = "scene") {
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
// Checksum 0x24c35a04, Offset: 0x3f50
// Size: 0x178
function spawn(arg1, arg2, arg3, arg4, b_test_run) {
    str_scenedef = arg1;
    assert(isdefined(str_scenedef), "<dev string:x2ce>");
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
// Checksum 0x7bdf55a1, Offset: 0x40d0
// Size: 0x54
function init(arg1, arg2, arg3, b_test_run) {
    self thread play(arg1, arg2, arg3, b_test_run, "init");
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0x2cf9697d, Offset: 0x4130
// Size: 0x102
function function_4fc601a9(str_scenedef, var_d2f25133, var_73cf2cfd) {
    if (self == level) {
        array::run_all(level.players, &forcestreambundle, str_scenedef, var_d2f25133, var_73cf2cfd);
    } else {
        self forcestreambundle(str_scenedef, var_d2f25133, var_73cf2cfd);
    }
    if (!isdefined(self.var_3d868d0f)) {
        self.var_3d868d0f = [];
    } else if (!isarray(self.var_3d868d0f)) {
        self.var_3d868d0f = array(self.var_3d868d0f);
    }
    if (!isinarray(self.var_3d868d0f, str_scenedef)) {
        self.var_3d868d0f[self.var_3d868d0f.size] = str_scenedef;
    }
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0xfb9a7e75, Offset: 0x4240
// Size: 0x9c
function function_a87de75b(str_scenedef, var_d2f25133, var_73cf2cfd) {
    if (!isdefined(self.var_3d868d0f)) {
        self.var_3d868d0f = [];
    }
    if (self == level) {
        array::run_all(level.players, &function_5094c112, str_scenedef);
    } else {
        self function_5094c112(str_scenedef);
    }
    arrayremovevalue(self.var_3d868d0f, str_scenedef);
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x420cf7a0, Offset: 0x42e8
// Size: 0x98
function function_78c7f92e() {
    if (!isdefined(self.var_3d868d0f)) {
        self.var_3d868d0f = [];
    }
    foreach (str_scenedef in self.var_3d868d0f) {
        level function_a87de75b(str_scenedef);
    }
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x0
// Checksum 0xdc4906b5, Offset: 0x4388
// Size: 0x384
function init_streamer(str_scenedef, str_team, var_fd8edd85 = 0, b_invulnerable = 1) {
    s_scenedef = get_scenedef(str_scenedef);
    str_team = util::get_team_mapping(str_team);
    level flag::wait_till("all_players_spawned");
    if (str_team == #"allies" && isdefined(s_scenedef.var_eb92591f)) {
        a_players = util::get_players(#"allies");
        array::thread_all(a_players, &function_2954e777, s_scenedef.var_eb92591f);
    } else if (str_team == #"axis" && isdefined(s_scenedef.var_798ae9e4)) {
        a_players = util::get_players(#"axis");
        array::thread_all(a_players, &function_2954e777, s_scenedef.var_798ae9e4);
    } else {
        return;
    }
    if (level flag::exists("draft_complete")) {
        level flag::wait_till("draft_complete");
    }
    /#
        iprintln("<dev string:x2f9>" + str_scenedef);
    #/
    if (var_fd8edd85) {
        array::thread_all(a_players, &val::set, "init_streamer", "freezecontrols", 1);
        array::thread_all(a_players, &lui::screen_fade_out, 0, undefined, "init_streamer");
    }
    if (b_invulnerable) {
        array::thread_all(a_players, &val::set, "init_streamer", "takedamage", 0);
    }
    array::wait_till(a_players, "init_streamer_done", 10);
    if (var_fd8edd85) {
        array::thread_all(a_players, &val::reset, "init_streamer", "freezecontrols");
        array::thread_all(a_players, &util::delay, 0.2, "disconnect", &lui::screen_fade_in, 1, undefined, "init_streamer");
    }
    if (b_invulnerable) {
        array::thread_all(a_players, &val::reset, "init_streamer", "takedamage");
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x4
// Checksum 0xdfe09d0c, Offset: 0x4718
// Size: 0x10e
function private function_2954e777(var_da9d25ea) {
    self endon(#"disconnect");
    self flagsys::set(#"player_streamer_loading");
    if (level flag::exists("draft_complete")) {
        level flag::wait_till("draft_complete");
    }
    self.var_9eddf64e = self playerstreamerrequest("set", var_da9d25ea);
    self.var_1375be5 = var_da9d25ea;
    self util::streamer_wait(self.var_9eddf64e, undefined, 10);
    self flagsys::clear(#"player_streamer_loading");
    self notify(#"init_streamer_done");
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0x7d9e4c10, Offset: 0x4830
// Size: 0x200
function _init_instance(str_scenedef, a_ents, b_test_run = 0) {
    level flagsys::wait_till("scene_on_load_wait");
    if (!isdefined(str_scenedef)) {
        str_scenedef = self.scriptbundlename;
    }
    /#
        if (array().size && !isinarray(array(), str_scenedef)) {
            return;
        }
    #/
    s_bundle = get_scenedef(isdefined(self.var_df1e88e4) ? self.var_df1e88e4 : str_scenedef);
    /#
        assert(isdefined(str_scenedef), "<dev string:x31d>" + (isdefined(self.origin) ? self.origin : "<dev string:x328>") + "<dev string:x32e>");
        assert(isdefined(s_bundle), "<dev string:x31d>" + (isdefined(self.origin) ? self.origin : "<dev string:x328>") + "<dev string:x34a>" + str_scenedef + "<dev string:x21e>");
    #/
    if (!(isdefined(self.script_ignore_active_scene_check) && self.script_ignore_active_scene_check)) {
        o_scene = get_active_scene(str_scenedef);
    }
    if (!isdefined(o_scene)) {
        o_scene = new cscene();
        [[ o_scene ]]->init(str_scenedef, s_bundle, self, a_ents, b_test_run);
    }
    return o_scene;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x5588bee2, Offset: 0x4a38
// Size: 0x238
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
// Params 2, eflags: 0x0
// Checksum 0x585d46, Offset: 0x4c78
// Size: 0x112
function function_d0a1d87d(str_scenedef, str_mode) {
    a_shots = get_all_shot_names(str_scenedef);
    if (a_shots.size == 0) {
        return "play";
    } else if (str_mode !== "init") {
        if (a_shots[0] !== "init") {
            str_shot = a_shots[0];
        } else if (a_shots.size > 1) {
            str_shot = a_shots[1];
        }
    } else if (str_mode === "init") {
        if (isinarray(a_shots, "init")) {
            str_shot = "init";
        } else {
            str_shot = a_shots[0];
        }
    }
    if (!isdefined(str_shot)) {
        str_shot = "play";
    }
    return str_shot;
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x0
// Checksum 0xf0afdbcc, Offset: 0x4d98
// Size: 0x7cc
function play(arg1, arg2, arg3, b_test_run = 0, str_mode = "", n_time, var_7a09eca) {
    /#
        if (getdvarint(#"debug_scene", 0) > 0) {
            if (isdefined(arg1) && (isstring(arg1) || ishash(arg1))) {
                printtoprightln("<dev string:x364>" + function_15979fa9(arg1));
            } else {
                printtoprightln("<dev string:x373>");
            }
        }
    #/
    s_tracker = spawnstruct();
    s_tracker.n_scene_count = 0;
    if (self == level) {
        a_instances = [];
        if (isstring(arg1) || ishash(arg1)) {
            if (isstring(arg1) && issubstr(arg1, ",")) {
                a_toks = strtok(arg1, ",");
                str_value = a_toks[0];
                str_key = a_toks[1];
                if (isstring(arg2)) {
                    str_shot = tolower(arg2);
                    a_ents = arg3;
                } else {
                    a_ents = arg2;
                }
            } else if (isinarray(level.scenedefs, hash(arg1))) {
                str_scenedef = arg1;
                var_f8dd026a = 1;
            } else {
                str_value = arg1;
                str_key = "targetname";
            }
            if (isstring(arg2)) {
                if (isinarray(array("targetname", "script_noteworthy"), arg2)) {
                    str_key = arg2;
                } else {
                    str_shot = tolower(arg2);
                    var_4070d5c7 = 1;
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
                        if (str_mode !== "init" && s_instance function_b057b8c1()) {
                            s_instance.var_b0bfb223 = 1;
                            s_instance function_4748fd6a(isdefined(s_instance.script_notify) ? s_instance.script_notify : s_instance.script_wait, isdefined(s_instance.script_waittill) ? s_instance.script_waittill : s_instance.script_timer, var_7a09eca);
                            return;
                        }
                        if (!(isdefined(var_f8dd026a) && var_f8dd026a)) {
                            str_scenedef = s_instance.scriptbundlename;
                        }
                        if (!(isdefined(var_4070d5c7) && var_4070d5c7)) {
                            str_shot = function_d0a1d87d(str_scenedef, str_mode);
                        } else {
                            /#
                                if (str_mode === "<dev string:x37f>") {
                                    iprintlnbold("<dev string:x384>");
                                    println("<dev string:x384>");
                                }
                            #/
                            if (str_mode === "loop") {
                                str_mode = "single_loop";
                            } else if (str_mode !== "init" && !issubstr(str_mode, "play_from_time") && !strstartswith(str_mode, "capture")) {
                                str_mode = "single";
                            }
                        }
                        var_cf60af1d = s_instance function_fefec137(a_ents);
                        s_instance thread _play_instance(s_tracker, str_scenedef, var_cf60af1d, b_test_run, str_shot, str_mode, n_time);
                    }
                }
            } else if (str_mode !== "init" && self function_b057b8c1()) {
                self.var_b0bfb223 = 1;
                self function_4748fd6a(isdefined(self.script_notify) ? self.script_notify : self.script_wait, isdefined(self.script_waittill) ? self.script_waittill : self.script_timer, var_7a09eca);
                return;
            } else {
                _play_on_self(s_tracker, arg1, arg2, arg3, b_test_run, str_mode, n_time);
            }
        }
    } else if (str_mode !== "init" && self function_b057b8c1()) {
        self.var_b0bfb223 = 1;
        self function_4748fd6a(isdefined(self.script_notify) ? self.script_notify : self.script_wait, isdefined(self.script_waittill) ? self.script_waittill : self.script_timer, var_7a09eca);
        return;
    } else {
        _play_on_self(s_tracker, arg1, arg2, arg3, b_test_run, str_mode, n_time);
    }
    if (s_tracker.n_scene_count > 0) {
        s_tracker waittill(#"scenes_done", #"death");
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x6194aafc, Offset: 0x5570
// Size: 0x98
function function_b057b8c1() {
    if (self.classname === "scriptbundle_scene" && isdefined(self.scriptbundlename)) {
        if (!(isdefined(self.var_b0bfb223) && self.var_b0bfb223) && function_68180861(self.scriptbundlename, "breach_init") && function_68180861(self.scriptbundlename, "breach_play")) {
            return true;
        }
    }
    return false;
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x0
// Checksum 0xa5652e79, Offset: 0x5610
// Size: 0x4c
function function_d5d61543(arg1, arg2, arg3, var_7a09eca) {
    self play(arg1, arg2, arg3, undefined, undefined, undefined, var_7a09eca);
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0x4b85d3ea, Offset: 0x5668
// Size: 0x26e
function function_4748fd6a(var_5bf6129d = 0, var_87b41109 = 4, var_7a09eca = array()) {
    self thread play("breach_init");
    if (isstring(var_5bf6129d) || ishash(var_5bf6129d)) {
        level waittill(var_5bf6129d);
    } else {
        wait var_5bf6129d;
    }
    a_ai = [];
    foreach (ent in self.scene_ents) {
        if (isai(ent) && !ent util::is_on_side(#"allies")) {
            array::add(a_ai, ent, 0);
        }
    }
    a_ai = arraycombine(a_ai, var_7a09eca, 0, 0);
    self thread function_4f205b8(a_ai);
    self thread breach_slow_time(var_87b41109);
    self play("breach_play");
    self waittill(#"breach_done");
    if (function_68180861(self.scriptbundlename, "breach_end")) {
        self play("breach_end");
    }
    if (isdefined(self.script_play_multiple) && self.script_play_multiple) {
        self.var_b0bfb223 = undefined;
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x29216d39, Offset: 0x58e0
// Size: 0x1fe
function breach_slow_time(var_87b41109) {
    setslowmotion(1, 0.3, 0.3);
    foreach (e_player in util::get_players()) {
        e_player setmovespeedscale(0.3);
    }
    wait 0.3;
    if (isstring(var_87b41109) || ishash(var_87b41109)) {
        util::waittill_any_ents(self, "breach_cleared", level, var_87b41109);
    } else {
        var_de7c1bd4 = var_87b41109 * 0.3;
        self waittilltimeout(var_de7c1bd4, #"breach_cleared");
    }
    setslowmotion(0.3, 1, 0.3);
    foreach (e_player in util::get_players()) {
        e_player setmovespeedscale(1);
    }
    self notify(#"breach_done");
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x9f97448a, Offset: 0x5ae8
// Size: 0x76
function function_4f205b8(a_ai) {
    self endon(#"breach_done");
    a_ai = array::remove_dead(a_ai);
    if (a_ai.size > 0) {
        ai::waittill_dead(a_ai);
    } else {
        wait 0.5;
    }
    self notify(#"breach_cleared");
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x0
// Checksum 0xaccdf56f, Offset: 0x5b68
// Size: 0x3d0
function play_pair(var_e023672c, var_522ad667, var_fd8edd85 = 0, var_789a266a = 0) {
    if (var_fd8edd85) {
        var_1e1f7dd2 = getscriptbundle(var_e023672c);
        if (var_1e1f7dd2.team === "wun") {
            function_e62681ef(var_e023672c, &function_fe24afe4, "done", #"allies");
        } else if (var_1e1f7dd2.team === "fpa") {
            function_e62681ef(var_e023672c, &function_fe24afe4, "done", #"axis");
        }
        var_f81d0369 = getscriptbundle(var_522ad667);
        if (var_f81d0369.team === "wun") {
            function_e62681ef(var_522ad667, &function_fe24afe4, "done", #"allies");
        } else if (var_f81d0369.team === "fpa") {
            function_e62681ef(var_522ad667, &function_fe24afe4, "done", #"axis");
        }
        var_1e1f7dd2 = undefined;
        var_f81d0369 = undefined;
        if (var_789a266a) {
            level.var_6e1075a2 = 0;
        }
    }
    self thread play(var_e023672c);
    self thread play(var_522ad667);
    a_flags = array(var_e023672c + "_scene_done", var_522ad667 + "_scene_done");
    level flag::wait_till_all(a_flags);
    if (var_fd8edd85) {
        util::wait_network_frame();
        remove_scene_func(var_e023672c, &function_fe24afe4, "done");
        remove_scene_func(var_522ad667, &function_fe24afe4, "done");
        a_players = util::get_players();
        foreach (player in a_players) {
            player val::set(#"hash_588e644c65309ea3", "freezecontrols", 1);
            if (!var_789a266a) {
                player util::delay(0.1, "disconnect", &lui::screen_fade_in, 1, undefined, "scene_system");
            }
        }
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xe3345de9, Offset: 0x5f40
// Size: 0xd8
function function_fe24afe4(str_team) {
    a_players = util::get_players(str_team);
    foreach (player in a_players) {
        player val::set(#"hash_588e644c65309ea3", "freezecontrols", 1);
        player thread lui::screen_fade_out(0, undefined, "scene_system");
    }
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x0
// Checksum 0x8ef9d5bd, Offset: 0x6020
// Size: 0x2bc
function _play_on_self(s_tracker, arg1, arg2, arg3, b_test_run = 0, str_mode = "", n_time) {
    if (isstring(arg1) || ishash(arg1)) {
        if (isinarray(level.scenedefs, hash(arg1))) {
            str_scenedef = arg1;
            if (isstring(arg2)) {
                str_shot = tolower(arg2);
                a_ents = arg3;
            } else {
                a_ents = arg2;
            }
        } else {
            str_shot = tolower(arg1);
            a_ents = arg2;
        }
    } else if (isarray(arg1) || isentity(arg1)) {
        str_scenedef = self.scriptbundlename;
        a_ents = arg1;
    } else {
        str_scenedef = self.scriptbundlename;
    }
    s_tracker.n_scene_count = 1;
    if (!isdefined(str_shot) && isdefined(str_scenedef)) {
        str_shot = function_d0a1d87d(str_scenedef, str_mode);
    } else if (isdefined(str_shot)) {
        /#
            if (str_mode === "<dev string:x37f>") {
                iprintlnbold("<dev string:x384>");
                println("<dev string:x384>");
            }
        #/
        if (str_mode !== "init" && !issubstr(str_mode, "play_from_time")) {
            str_mode = "single";
        }
    }
    var_cf60af1d = self function_fefec137(a_ents);
    self thread _play_instance(s_tracker, str_scenedef, var_cf60af1d, b_test_run, str_shot, str_mode, n_time);
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x0
// Checksum 0xb8dfdba9, Offset: 0x62e8
// Size: 0x74e
function _play_instance(s_tracker, str_scenedef = self.scriptbundlename, a_ents, b_test_run = 0, str_shot = "play", str_mode, n_time) {
    if (isdefined(n_time) && issubstr(str_mode, "play_from_time")) {
        var_e8b45933 = function_9ed8d5d0(str_scenedef, str_mode, n_time);
        str_shot = var_e8b45933.var_be0369b9;
        var_bed42e22 = var_e8b45933.var_aacb0e72;
        str_mode += ":" + var_bed42e22;
    }
    if (str_mode === "init") {
        str_shot = function_d0a1d87d(str_scenedef, str_mode);
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
    if (str_mode !== "init" && isdefined(self.script_delay) && self.script_delay > 0) {
        wait self.script_delay;
    }
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
                println("<dev string:x3bd>" + str_scenedef + "<dev string:x3c5>");
            }
        }
        if (str_mode == "init") {
            self.scene_played[str_shot] = 0;
        } else {
            self.scene_played[str_shot] = 1;
        }
    }
    if (b_play) {
        if (isdefined(self.script_teleport_location)) {
            self teleport::function_8db85ae7();
        }
        o_scene = _init_instance(str_scenedef, a_ents, b_test_run);
        /#
            function_6435e76d(o_scene);
        #/
        if (isdefined(o_scene)) {
            thread [[ o_scene ]]->play(str_shot, a_ents, b_test_run, str_mode);
        }
        o_scene waittill(str_shot, #"hash_27297a73bc597607");
        if (isdefined(self)) {
            if (isdefined(self.scriptbundlename) && isdefined(getscriptbundle(self.scriptbundlename).looping) && getscriptbundle(self.scriptbundlename).looping) {
                self.scene_played[str_shot] = 0;
            }
        }
    }
    var_3c23c6de = function_f80af16d(str_scenedef);
    if (isdefined(var_3c23c6de) && str_shot != "init" && str_mode != "single" && str_mode != "init") {
        var_1a9afd59 = getscriptbundle(str_scenedef);
        var_582e1a2c = getscriptbundle(var_3c23c6de);
        if (isdefined(var_582e1a2c) && var_582e1a2c.type === "scene" && var_582e1a2c !== var_1a9afd59) {
            var_3be733aa = var_1a9afd59.name;
            level waittill(var_1a9afd59.str_final_bundle + "_done");
            if (str_shot == "play") {
                level flag::set(var_3be733aa + "_scene_done");
            }
        } else if (!function_1c059f9b(str_scenedef, str_shot)) {
            if (isdefined(o_scene) && !(isdefined(o_scene.scene_stopping) && o_scene.scene_stopping)) {
                o_scene waittill(#"scene_done", #"scene_stop", #"scene_skip_completed");
            }
        }
    }
    s_tracker.n_scene_count--;
    if (s_tracker.n_scene_count == 0) {
        level flag::set(str_scenedef + "_scene_done");
        if (isdefined(self) && isdefined(self.script_flag_set) && str_mode !== "init") {
            level flag::set(self.script_flag_set);
        }
        /#
            function_6435e76d(o_scene);
        #/
        s_tracker notify(#"scenes_done");
        if (isdefined(self)) {
            self notify(#"scenes_done");
        }
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x4d5ea2a4, Offset: 0x6a40
// Size: 0x23c
function delete_scene_spawned_ents(arg1) {
    if (self == level) {
        a_instances = [];
        if (isstring(arg1) || ishash(arg1)) {
            if (isstring(arg1) && issubstr(arg1, ",")) {
                a_toks = strtok(arg1, ",");
                str_value = a_toks[0];
                str_key = a_toks[1];
            } else if (isinarray(level.scenedefs, hash(arg1))) {
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
    if (isstring(arg1) || ishash(arg1)) {
        str_scenedef = arg1;
    }
    self _delete_scene_spawned_ents(str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x79772e9a, Offset: 0x6c88
// Size: 0xd4
function _delete_scene_spawned_ents(str_scene) {
    if (isdefined(self.scene_ents)) {
        foreach (ent in self.scene_ents) {
            if (isdefined(ent) && isdefined(ent.scene_spawned)) {
                ent delete();
            }
        }
        /#
            if (isdefined(str_scene)) {
                update_debug_state(str_scene, "<dev string:x435>");
            }
        #/
    }
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0xb134735a, Offset: 0x6d68
// Size: 0x92
function update_debug_state(str_scene, str_state) {
    if (!strendswith(self.last_scene_state_instance[str_scene], str_state)) {
        level.last_scene_state[str_scene] = level.last_scene_state[str_scene] + "," + str_state;
        self.last_scene_state_instance[str_scene] = self.last_scene_state_instance[str_scene] + "," + str_state;
    }
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x0
// Checksum 0x30fdd0a5, Offset: 0x6e08
// Size: 0x19a
function _get_scene_instances(str_value, str_key = "targetname", str_scenedef, b_include_inactive = 0) {
    a_instances = [];
    if (isdefined(str_value)) {
        a_instances = struct::get_array(str_value, str_key);
        assert(a_instances.size, "<dev string:x43d>" + str_key + "<dev string:x45b>" + str_value + "<dev string:x45f>");
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
// Checksum 0x59a6337a, Offset: 0x6fb0
// Size: 0x7c
function skipto_end(arg1, arg2, arg3, n_time, b_include_players = 1) {
    n_time = isdefined(n_time) ? n_time : 1;
    play_from_time(arg1, arg2, arg3, n_time, 1, b_include_players);
}

// Namespace scene/scene_shared
// Params 7, eflags: 0x0
// Checksum 0x707ae966, Offset: 0x7038
// Size: 0xec
function play_from_time(arg1, arg2, arg3, n_time, var_bd541d75 = 1, b_include_players = 1, var_70b00f39 = 1) {
    if (var_bd541d75) {
        str_mode = "play_from_time_normalized";
    } else {
        str_mode = "play_from_time_elapsed";
    }
    if (!b_include_players) {
        str_mode += "_noplayers";
    }
    if (!var_70b00f39) {
        str_mode += "_noai";
    }
    play(arg1, arg2, arg3, 0, str_mode, n_time);
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0x5ba42d57, Offset: 0x7130
// Size: 0xb2
function function_9ed8d5d0(str_scenedef, str_mode, n_time) {
    if (issubstr(str_mode, "play_from_time_normalized")) {
        var_e45dcfd1 = float(n_time) * function_a2174d35(str_scenedef);
    } else {
        var_e45dcfd1 = float(n_time);
    }
    var_e8b45933 = function_a2faed48(str_scenedef, var_e45dcfd1);
    return var_e8b45933;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x9ef74fb1, Offset: 0x71f0
// Size: 0x1fa
function function_6e7a6390(obj, str_shot) {
    var_38bfdf38 = 0;
    n_anim_length = 0;
    if (isdefined(obj.shots)) {
        foreach (s_shot in obj.shots) {
            if (s_shot.name === tolower(str_shot) && isdefined(s_shot.entry)) {
                foreach (s_entry in s_shot.entry) {
                    if (isdefined(s_entry.cameraswitcher)) {
                        var_38bfdf38 += float(getcamanimtime(s_entry.cameraswitcher)) / 1000;
                        continue;
                    }
                    if (isdefined(s_entry.("anim"))) {
                        n_anim_length += getanimlength(s_entry.("anim"));
                    }
                }
                break;
            }
        }
    }
    n_length = max(var_38bfdf38, n_anim_length);
    return n_length;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x3b966088, Offset: 0x73f8
// Size: 0x24a
function function_a2faed48(str_scenedef, n_elapsed_time) {
    s_scenedef = get_scenedef(str_scenedef);
    a_shots = get_all_shot_names(str_scenedef, 1);
    var_7006741a = 0;
    var_e8b45933 = spawnstruct();
    foreach (str_shot in a_shots) {
        var_6c51ddca = 0;
        foreach (obj in s_scenedef.objects) {
            var_aa251452 = function_6e7a6390(obj, str_shot);
            if (var_aa251452 > var_6c51ddca) {
                var_6c51ddca = var_aa251452;
            }
        }
        var_1d7b679d = var_7006741a;
        var_9fcbfb18 = var_1d7b679d + var_6c51ddca;
        if (n_elapsed_time >= var_1d7b679d && n_elapsed_time < var_9fcbfb18) {
            var_e8b45933.var_be0369b9 = str_shot;
            var_e8b45933.var_aacb0e72 = (n_elapsed_time - var_1d7b679d) / var_6c51ddca;
            return var_e8b45933;
        }
        var_7006741a += var_6c51ddca;
    }
    var_e8b45933.var_be0369b9 = a_shots[a_shots.size - 1];
    var_e8b45933.var_aacb0e72 = 0.99;
    return var_e8b45933;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x1b523ad9, Offset: 0x7650
// Size: 0x122
function function_3dd10dad(var_a6cf02a8, str_shot) {
    if (isstring(var_a6cf02a8) || ishash(var_a6cf02a8)) {
        s_scenedef = get_scenedef(var_a6cf02a8);
    } else {
        s_scenedef = var_a6cf02a8;
    }
    var_25d67477 = 0;
    foreach (obj in s_scenedef.objects) {
        var_aa251452 = function_6e7a6390(obj, str_shot);
        if (var_aa251452 > var_25d67477) {
            var_25d67477 = var_aa251452;
        }
    }
    return var_25d67477;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xda665fcc, Offset: 0x7780
// Size: 0xe8
function function_a2174d35(str_scenedef) {
    s_scenedef = get_scenedef(str_scenedef);
    a_shots = get_all_shot_names(str_scenedef, 1);
    var_425e77f3 = 0;
    foreach (str_shot in a_shots) {
        var_425e77f3 += function_3dd10dad(s_scenedef, str_shot);
    }
    return var_425e77f3;
}

// Namespace scene/scene_shared
// Params 4, eflags: 0x0
// Checksum 0x347a71ec, Offset: 0x7870
// Size: 0x64
function skipto_end_noai(arg1, arg2, arg3, n_time) {
    n_time = isdefined(n_time) ? n_time : 1;
    play_from_time(arg1, arg2, arg3, n_time, 1, 0, 0);
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0x564f8555, Offset: 0x78e0
// Size: 0x274
function stop(arg1, arg2, arg3) {
    if (self == level) {
        if (isstring(arg1) || ishash(arg1)) {
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
                assert(a_instances.size, "<dev string:x43d>" + str_key + "<dev string:x45b>" + str_value + "<dev string:x45f>");
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
    if (isstring(arg1) || ishash(arg1)) {
        _stop_instance(arg2, arg1);
        return;
    }
    _stop_instance(arg1);
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x716279a3, Offset: 0x7b60
// Size: 0xe8
function _stop_instance(b_clear = 0, str_scenedef) {
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
// Checksum 0x8863577, Offset: 0x7c50
// Size: 0x3a
function has_init_state(str_scenedef) {
    return isinarray(get_all_shot_names(str_scenedef), "init");
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x34b894b6, Offset: 0x7c98
// Size: 0x3a
function function_68180861(str_scenedef, str_shotname) {
    return isinarray(get_all_shot_names(str_scenedef), str_shotname);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x4855de8e, Offset: 0x7ce0
// Size: 0x22
function get_prop_count(str_scenedef) {
    return _get_type_count("prop", str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xf8ef4326, Offset: 0x7d10
// Size: 0x22
function get_vehicle_count(str_scenedef) {
    return _get_type_count("vehicle", str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xf017ec0e, Offset: 0x7d40
// Size: 0x22
function get_actor_count(str_scenedef) {
    return _get_type_count("actor", str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xdb2ec7b0, Offset: 0x7d70
// Size: 0x22
function function_9181f70f(str_scenedef) {
    return _get_type_count("sharedplayer", str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xf08e56ee, Offset: 0x7da0
// Size: 0x22
function get_player_count(str_scenedef) {
    return _get_type_count("player", str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xbb494ae6, Offset: 0x7dd0
// Size: 0x22
function function_a1d3b978(str_scenedef) {
    return _get_type_count("companion", str_scenedef);
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xd2b084c9, Offset: 0x7e00
// Size: 0x22
function function_e91cd35b(str_scenedef) {
    return _get_type_count(undefined, str_scenedef);
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x69effe63, Offset: 0x7e30
// Size: 0x126
function _get_type_count(str_type, str_scenedef) {
    s_scenedef = isdefined(str_scenedef) ? getscriptbundle(str_scenedef) : getscriptbundle(self.scriptbundlename);
    if (!isdefined(str_type)) {
        return s_scenedef.objects.size;
    }
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
// Checksum 0xe2cd125c, Offset: 0x7f60
// Size: 0x126
function function_e6ca377e(var_a5b96b53) {
    if (!isdefined(self._scene_object) || !isdefined(self.var_afdf4f45)) {
        return true;
    }
    foreach (s_shot in self._scene_object._s.shots) {
        if (isdefined(self.var_afdf4f45[s_shot.name]) && self.var_afdf4f45[s_shot.name]) {
            continue;
        }
        if (self._scene_object csceneobject::function_eaf45a5c(s_shot) && !self._scene_object csceneobject::function_e6ca377e(s_shot, var_a5b96b53)) {
            return false;
        }
    }
    return true;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xddbf3024, Offset: 0x8090
// Size: 0x4e
function is_active(str_scenedef) {
    if (self == level) {
        return (get_active_scenes(str_scenedef).size > 0);
    }
    return isdefined(get_active_scene(str_scenedef));
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0xb19d34e4, Offset: 0x80e8
// Size: 0x74
function is_playing(str_scenedef = self.scriptbundlename, str_shot = "play") {
    o_scene = get_active_scene(str_scenedef);
    if (isdefined(o_scene)) {
        return (o_scene._str_shot === str_shot);
    }
    return false;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x7d1294cd, Offset: 0x8168
// Size: 0x96
function is_ready(str_scenedef) {
    if (self == level) {
        return level flagsys::get(str_scenedef + "_ready");
    } else {
        if (!isdefined(str_scenedef)) {
            str_scenedef = self.scriptbundlename;
        }
        o_scene = get_active_scene(str_scenedef);
        if (isdefined(o_scene)) {
            return o_scene flagsys::get(#"ready");
        }
    }
    return 0;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x80181c57, Offset: 0x8208
// Size: 0xe0
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
// Checksum 0x335f3e4a, Offset: 0x82f0
// Size: 0xf8
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
// Checksum 0x257fd629, Offset: 0x83f0
// Size: 0x9e
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
// Checksum 0xc9fcac19, Offset: 0x8498
// Size: 0xc
function delete_scene_data(str_scenename) {
    
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x3d17fc46, Offset: 0x84b0
// Size: 0x54
function is_igc() {
    return isdefined(self.igc) && self.igc || isstring(self.cameraswitcher) || ishash(self.cameraswitcher);
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0xddb99d14, Offset: 0x8510
// Size: 0x17e
function scene_disable_player_stuff(s_scenedef, s_objectdef) {
    /#
        if (getdvarint(#"debug_scene", 0) > 0) {
            printtoprightln("<dev string:x462>");
        }
    #/
    self notify(#"scene_disable_player_stuff");
    self notify(#"kill_hint_text");
    self disableoffhandweapons();
    self disableoffhandspecial();
    self val::set(#"player_insertion", "disable_oob", 1);
    if (isdefined(s_objectdef)) {
        if (!(isdefined(s_objectdef.showhud) && s_objectdef.showhud)) {
            level notify(#"disable_cybercom", {#player:self});
            self val::set(#"scene", "show_hud", 0);
            util::wait_network_frame();
            self notify(#"delete_weapon_objects");
        }
    }
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0xb5a69dd0, Offset: 0x8698
// Size: 0x1ac
function scene_enable_player_stuff(s_scenedef, s_objectdef, e_scene_root) {
    /#
        if (getdvarint(#"debug_scene", 0) > 0) {
            printtoprightln("<dev string:x484>");
        }
    #/
    self endon(#"scene_disable_player_stuff", #"disconnect");
    waitframe(0);
    if (isdefined(s_scenedef) && !isdefined(s_scenedef.nextscenebundle)) {
        self function_c9911bf1(e_scene_root, s_scenedef);
    }
    waitframe(10);
    self enableoffhandweapons();
    self enableoffhandspecial();
    self val::set(#"player_insertion", "disable_oob", 0);
    if (isdefined(s_objectdef)) {
        if (!(isdefined(s_objectdef.showhud) && s_objectdef.showhud)) {
            level notify(#"enable_cybercom", {#player:self});
            self notify(#"scene_enable_cybercom");
            self val::reset(#"scene", "show_hud");
        }
    }
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x8091e7a6, Offset: 0x8850
// Size: 0x5c
function function_c9911bf1(e_scene_root, s_scenedef) {
    self endon(#"disconnect");
    if (isdefined(e_scene_root) && isdefined(e_scene_root.script_teleport_location)) {
        e_scene_root teleport::player(self);
    }
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x8ff258d9, Offset: 0x88b8
// Size: 0x64
function function_a0128166(e_scene_root, s_scenedef) {
    waitframe(0);
    if (isdefined(s_scenedef) && !isdefined(s_scenedef.nextscenebundle)) {
        if (isdefined(e_scene_root) && isdefined(e_scene_root.script_teleport_location)) {
            e_scene_root teleport::hero(self);
        }
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x1e3f0f17, Offset: 0x8928
// Size: 0x142
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
            player.totaligcviewtime += int(float(igcviewtimesec) / 1000);
        }
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xaff5b643, Offset: 0x8a78
// Size: 0xc8
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
// Checksum 0x9890edec, Offset: 0x8b48
// Size: 0x5e
function is_igc_active() {
    n_players_in_igc = level clientfield::get("in_igc");
    n_entnum = self getentitynumber();
    return n_players_in_igc & 1 << n_entnum;
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xe1f31547, Offset: 0x8bb0
// Size: 0x18
function function_c5c8dac2() {
    return isdefined(self.var_41d547be) && self.var_41d547be;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x9177174c, Offset: 0x8bd0
// Size: 0xbc
function get_scene_shot(str_scene) {
    foreach (o_scene in self.scenes) {
        if (o_scene._str_name === str_scene) {
            return o_scene._str_shot;
        }
    }
    assert("<dev string:x4a5>" + str_scene + "<dev string:x4ad>");
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x5abe7091, Offset: 0x8c98
// Size: 0x80
function is_capture_mode(str_mode = getdvarstring(#"scene_menu_mode", "default")) {
    if (issubstr(str_mode, "capture") || function_a81ac58a(1)) {
        return true;
    }
    return false;
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xeb80ae7e, Offset: 0x8d20
// Size: 0x20
function should_spectate_on_join() {
    return isdefined(level.scene_should_spectate_on_hot_join) && level.scene_should_spectate_on_hot_join;
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x2d327e3d, Offset: 0x8d48
// Size: 0x2e
function wait_until_spectate_on_join_completes() {
    while (isdefined(level.scene_should_spectate_on_hot_join) && level.scene_should_spectate_on_hot_join) {
        waitframe(1);
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xa6c08c40, Offset: 0x8d80
// Size: 0xa8
function function_a81ac58a(var_e0f8fc60 = 0) {
    if (var_e0f8fc60) {
        if (getdvarint(#"hash_6a54249f0cc48945", 0)) {
            return true;
        }
    } else if (getdvarint(#"hash_1ac735c6e28a2f7a", 0) || getdvarint(#"hash_6a54249f0cc48945", 0)) {
        return true;
    }
    return false;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x3a513a1c, Offset: 0x8e30
// Size: 0x98
function function_e1e106d2(str_scenedef) {
    if (function_a81ac58a()) {
        return false;
    }
    if (getdvarint(#"hash_862358d532e674c", 0) === 1) {
        var_1a9afd59 = getscriptbundle(str_scenedef);
        if (isdefined(var_1a9afd59.var_248e7d34) && var_1a9afd59.var_248e7d34) {
            return true;
        }
    }
    return false;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xe4b79d99, Offset: 0x8ed0
// Size: 0x80
function function_3926939d(str_scenedef) {
    if (getdvarint(#"hash_862358d532e674c", 0) === 2) {
        var_1a9afd59 = getscriptbundle(str_scenedef);
        if (isdefined(var_1a9afd59.var_248e7d34) && var_1a9afd59.var_248e7d34) {
            return true;
        }
    }
    return false;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x665b4ed8, Offset: 0x8f58
// Size: 0x7d0
function function_9987a727(o_scene) {
    if ((getdvarint(#"hash_12bb279f3cc30d88", 0) == 0 || isdefined(o_scene._s.disablesceneskipping) && o_scene._s.disablesceneskipping) && !function_e1e106d2(o_scene._str_name)) {
        return;
    }
    self notify(#"hash_f7c1e0e8fb935d5");
    self endoncallback(&function_8e7bce56, #"hash_f7c1e0e8fb935d5", #"disconnect");
    o_scene endoncallback(&function_8e7bce56, #"scene_done", #"scene_stop", #"scene_skip_completed", #"hash_63783193d9ac5bfc");
    level endoncallback(&function_8e7bce56, #"hash_7a8cd7f6a20dde3e");
    b_skip_scene = 0;
    self clear_scene_skipping_ui();
    waitframe(1);
    if (function_e1e106d2(o_scene._str_name)) {
        var_2729b0e7 = 1;
        var_83002661 = 0;
    } else {
        var_2729b0e7 = 0;
        var_83002661 = 2500;
    }
    self.skip_scene_menu_handle = lui::get_luimenu("cp_skip_scene_menu");
    self.skip_scene_menu_handle cp_skip_scene_menu::open(self);
    self.skip_scene_menu_handle cp_skip_scene_menu::set_showskipbutton(self, 0);
    self.skip_scene_menu_handle cp_skip_scene_menu::set_hostisskipping(self, 0);
    self.skip_scene_menu_handle cp_skip_scene_menu::set_votedtoskip(self, 0);
    self.skip_scene_menu_handle cp_skip_scene_menu::set_sceneskipendtime(self, 0);
    while (true) {
        if (isdefined(self.var_e4aa494f) && self.var_e4aa494f && isdefined(self.skip_scene_menu_handle)) {
            self.skip_scene_menu_handle cp_skip_scene_menu::set_votedtoskip(self, 1);
            self.skip_scene_menu_handle cp_skip_scene_menu::set_showskipbutton(self, 2);
            self.scene_skip_timer = undefined;
        } else if (self any_button_pressed() && function_f4d1734()) {
            if (!isdefined(self.scene_skip_timer) && isdefined(self.skip_scene_menu_handle)) {
                self.skip_scene_menu_handle cp_skip_scene_menu::set_showskipbutton(self, 1);
            }
            self.scene_skip_timer = gettime();
        } else if (isdefined(self.scene_skip_timer) && isdefined(self.skip_scene_menu_handle)) {
            if (gettime() - self.scene_skip_timer > var_83002661) {
                self.skip_scene_menu_handle cp_skip_scene_menu::set_showskipbutton(self, 2);
                self.scene_skip_timer = undefined;
            }
        }
        var_eb2bbd46 = ispc() ? self attackbuttonpressed() : self jumpbuttonpressed();
        if (var_2729b0e7) {
            var_eb2bbd46 = 1;
        }
        if (var_eb2bbd46 && function_f4d1734()) {
            if (!isdefined(self.scene_skip_start_time) && isdefined(self.skip_scene_menu_handle)) {
                self.skip_scene_menu_handle cp_skip_scene_menu::set_sceneskipendtime(self, gettime() + var_83002661);
                self.scene_skip_start_time = gettime();
            } else if (isdefined(self.scene_skip_start_time) && gettime() - self.scene_skip_start_time > var_83002661) {
                if (self ishost()) {
                    b_skip_scene = 1;
                    break;
                } else {
                    self.var_e4aa494f = 1;
                    var_ffa470b = 0;
                    foreach (player in level.players) {
                        if (isdefined(player.var_e4aa494f) && player.var_e4aa494f) {
                            var_ffa470b++;
                        }
                    }
                    if (var_ffa470b > 1) {
                        b_skip_scene = 1;
                        break;
                    }
                }
            }
        } else if (isdefined(self.scene_skip_start_time) && isdefined(self.skip_scene_menu_handle)) {
            self.skip_scene_menu_handle cp_skip_scene_menu::set_sceneskipendtime(self, 0);
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
        self clear_scene_skipping_ui();
        self playsound(#"uin_igc_skip");
        self notify(#"scene_being_skipped");
        music::setmusicstatebyteam("death", self.team);
        start_scene_skip(o_scene);
        foreach (player in level.players) {
            if (isdefined(player._scene_object) && isdefined(player._scene_object._o_scene) && player._scene_object._o_scene != o_scene) {
                var_5addbfb1 = player._scene_object._o_scene;
                if (var_5addbfb1._s is_igc()) {
                    start_scene_skip(var_5addbfb1);
                    break;
                }
            }
        }
        level notify(#"hash_7a8cd7f6a20dde3e");
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xdc713401, Offset: 0x9730
// Size: 0x3c
function start_scene_skip(o_scene) {
    o_scene.skipping_scene = 1;
    o_scene.b_player_scene = 1;
    thread [[ o_scene ]]->skip_scene(0);
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x7b1adcdb, Offset: 0x9778
// Size: 0x94
function function_f4d1734() {
    if (isdefined(level.chyron_text_active) && level.chyron_text_active) {
        return false;
    }
    if (isdefined(level.var_a9466ed4) && level.var_a9466ed4 && level flag::exists("switchmap_preload_finished") && !level flag::get("switchmap_preload_finished")) {
        return false;
    }
    return true;
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xe4ea3697, Offset: 0x9818
// Size: 0x6e
function clear_scene_skipping_ui() {
    if (isdefined(self.scene_skip_timer)) {
        self.scene_skip_timer = undefined;
    }
    if (isdefined(self.scene_skip_start_time)) {
        self.scene_skip_start_time = undefined;
    }
    if (isdefined(self.skip_scene_menu_handle)) {
        self.skip_scene_menu_handle cp_skip_scene_menu::close(self);
        self.skip_scene_menu_handle = undefined;
    }
    self.var_e4aa494f = undefined;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0xbfd4c739, Offset: 0x9890
// Size: 0x8c
function function_8e7bce56(str_notify) {
    if (isclass(self) || self == level) {
        array::thread_all(level.players, &clear_scene_skipping_ui);
        return;
    }
    if (isplayer(self)) {
        self clear_scene_skipping_ui();
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x65a83e33, Offset: 0x9928
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
// Checksum 0xdc4c65c4, Offset: 0x9ad8
// Size: 0x3c
function on_player_disconnect() {
    if (isdefined(level.gameended) && !level.gameended) {
        self set_igc_active(0);
    }
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0x181ce597, Offset: 0x9b20
// Size: 0xd4
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
// Checksum 0xe5fe7057, Offset: 0x9c00
// Size: 0x224
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
// Checksum 0x1483a0b1, Offset: 0x9e30
// Size: 0x9c
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
// Checksum 0x2d449f30, Offset: 0x9ed8
// Size: 0x44
function add_wait_for_streamer_hint_scene(str_scene_name) {
    if (!isdefined(level.wait_for_streamer_hint_scenes)) {
        level.wait_for_streamer_hint_scenes = [];
    }
    array::add(level.wait_for_streamer_hint_scenes, str_scene_name);
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0xd2d65b2f, Offset: 0x9f28
// Size: 0x214
function get_existing_ent(str_name, b_spawner_only = 0, b_nodes_and_structs = 0) {
    e = undefined;
    if (b_spawner_only) {
        e_array = getspawnerarray(str_name, "script_animname");
        if (e_array.size == 0) {
            e_array = getspawnerarray(str_name, "targetname");
        }
        assert(e_array.size <= 1, "<dev string:x4d2>");
        foreach (ent in e_array) {
            if (!isdefined(ent.isdying)) {
                e = ent;
                break;
            }
        }
    } else if (!is_valid_ent(e)) {
        e = get_existing_ent_by_targetname(str_name);
        if (!is_valid_ent(e) && b_nodes_and_structs) {
            e = getnode(str_name, "targetname");
            if (!is_valid_ent(e)) {
                e = struct::get(str_name, "targetname");
            }
        }
    }
    if (is_valid_ent(e)) {
        return e;
    }
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x303b8132, Offset: 0xa148
// Size: 0xe2
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
// Checksum 0x996df45b, Offset: 0xa238
// Size: 0x72
function get_existing_ent_by_targetname(str_name) {
    e = _get_existing_ent(str_name, "targetname", 1);
    if (!is_valid_ent(e)) {
        e = _get_existing_ent(str_name, "targetname");
    }
    return e;
}

// Namespace scene/scene_shared
// Params 3, eflags: 0x0
// Checksum 0xbecd90f5, Offset: 0xa2b8
// Size: 0xaa
function _get_existing_ent(val, key, b_ignore_spawners = 0) {
    /#
        a_ents = getentarray(val, key, b_ignore_spawners);
        assert(a_ents.size <= 1, "<dev string:x4eb>");
    #/
    e = getent(val, key, b_ignore_spawners);
    return e;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x8ae839f4, Offset: 0xa370
// Size: 0x5c
function is_valid_ent(ent) {
    return isdefined(ent) && (!isdefined(ent.isdying) && !ent ai::is_dead_sentient() || self._s.ignorealivecheck === 1);
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x3b096055, Offset: 0xa3d8
// Size: 0x19c
function synced_delete() {
    self endon(#"death");
    self.isdying = 1;
    if (!isplayer(self)) {
        sethideonclientwhenscriptedanimcompleted(self);
        self animation::stop(0);
        waitframe(1);
        self val::set(#"synced_delete", "hide");
    } else {
        waitframe(1);
        self val::set(#"synced_delete", "hide", 2);
    }
    self notsolid();
    if (isalive(self)) {
        if (issentient(self)) {
            self val::set(#"synced_delete", "ignoreall", 1);
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
// Checksum 0xe3c34d13, Offset: 0xa580
// Size: 0x1d4
function error_on_screen(str_msg) {
    if (str_msg != "") {
        if (!isdefined(level.scene_error_hud)) {
            level.scene_error_hud = level.players[0] openluimenu("HudElementText");
            level.players[0] setluimenudata(level.scene_error_hud, #"alignment", 2);
            level.players[0] setluimenudata(level.scene_error_hud, #"x", 0);
            level.players[0] setluimenudata(level.scene_error_hud, #"y", 10);
            level.players[0] setluimenudata(level.scene_error_hud, #"width", 1280);
            level.players[0] lui::set_color(level.scene_error_hud, (1, 0, 0));
        }
        level.players[0] setluimenudata(level.scene_error_hud, #"text", str_msg);
        self thread _destroy_error_on_screen();
    }
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xd69843f3, Offset: 0xa760
// Size: 0x7e
function _destroy_error_on_screen() {
    level notify(#"_destroy_error_on_screen");
    level endon(#"_destroy_error_on_screen");
    self waittilltimeout(5, #"stopped");
    level.players[0] closeluimenu(level.scene_error_hud);
    level.scene_error_hud = undefined;
}

/#

    // Namespace scene/scene_shared
    // Params 1, eflags: 0x0
    // Checksum 0x2ff19b5a, Offset: 0xa7e8
    // Size: 0x1f4
    function warning_on_screen(str_msg) {
        str_msg = function_15979fa9(str_msg);
        if (str_msg != "<dev string:x511>") {
            if (!isdefined(level.scene_warning_hud)) {
                level.scene_warning_hud = level.players[0] openluimenu("<dev string:x512>");
                level.players[0] setluimenudata(level.scene_warning_hud, #"alignment", 2);
                level.players[0] setluimenudata(level.scene_warning_hud, #"x", 0);
                level.players[0] setluimenudata(level.scene_warning_hud, #"y", 1060);
                level.players[0] setluimenudata(level.scene_warning_hud, #"width", 1280);
                level.players[0] lui::set_color(level.scene_warning_hud, (1, 1, 0));
            }
            level.players[0] setluimenudata(level.scene_warning_hud, #"text", str_msg);
            level thread _destroy_warning_on_screen();
        }
    }

#/

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x568bc2a1, Offset: 0xa9e8
// Size: 0x66
function _destroy_warning_on_screen() {
    level notify(#"_destroy_warning_on_screen");
    level endon(#"_destroy_warning_on_screen");
    wait 10;
    level.players[0] closeluimenu(level.scene_warning_hud);
    level.scene_warning_hud = undefined;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0xf4ab908a, Offset: 0xaa58
// Size: 0xcc
function wait_server_time(n_time, n_start_time = 0) {
    n_len = n_time - n_time * n_start_time;
    n_len /= float(function_f9f48566()) / 1000;
    n_len_int = int(n_len);
    if (n_len_int != n_len) {
        n_len = floor(n_len);
    }
    waitframe(int(n_len));
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0xa8995456, Offset: 0xab30
// Size: 0xba
function check_team(str_team1 = #"any", str_team2 = #"any") {
    str_team1 = util::get_team_mapping(str_team1);
    str_team2 = util::get_team_mapping(str_team2);
    if (str_team1 == #"any" || str_team2 == #"any") {
        return true;
    }
    return str_team1 == str_team2;
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x5cb59bd0, Offset: 0xabf8
// Size: 0x18
function function_3807842() {
    if (isdefined(self._scene_object)) {
        return true;
    }
    return false;
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x28fab4d3, Offset: 0xac18
// Size: 0x24
function function_b128228e() {
    self flagsys::clear(#"hash_2d4a7625f4fde7eb");
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x1ce12ffc, Offset: 0xac48
// Size: 0x24
function function_d871063b() {
    self flagsys::set(#"hash_2d4a7625f4fde7eb");
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x4fc069cc, Offset: 0xac78
// Size: 0x2e
function function_18b2f103() {
    if (self flagsys::get(#"hash_2d4a7625f4fde7eb")) {
        return false;
    }
    return true;
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x77736b9a, Offset: 0xacb0
// Size: 0x24
function function_e86ba3e9() {
    self flagsys::set(#"hash_960b6b7a9f62393");
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0xe2254c7e, Offset: 0xace0
// Size: 0x24
function function_31efec94() {
    self flagsys::clear(#"hash_960b6b7a9f62393");
}

// Namespace scene/scene_shared
// Params 0, eflags: 0x0
// Checksum 0x5a4b73e4, Offset: 0xad10
// Size: 0x2e
function function_4f904976() {
    if (self flagsys::get(#"hash_960b6b7a9f62393")) {
        return true;
    }
    return false;
}

// Namespace scene/scene_shared
// Params 2, eflags: 0x0
// Checksum 0xeef8af45, Offset: 0xad48
// Size: 0x3e
function function_ebf62300(var_707fa5a8, var_3ec0668b) {
    if (!isdefined(self.var_d0df381)) {
        self.var_d0df381 = [];
    }
    self.var_d0df381[var_707fa5a8] = var_3ec0668b;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x9f28ad53, Offset: 0xad90
// Size: 0x72
function function_385b264b(var_3847bc0f) {
    if (!isdefined(self.var_3847bc0f)) {
        self.var_3847bc0f = [];
    }
    if (!isdefined(var_3847bc0f)) {
        var_3847bc0f = [];
    } else if (!isarray(var_3847bc0f)) {
        var_3847bc0f = array(var_3847bc0f);
    }
    self.var_3847bc0f = var_3847bc0f;
}

// Namespace scene/scene_shared
// Params 1, eflags: 0x0
// Checksum 0x1d1547bd, Offset: 0xae10
// Size: 0x5c
function function_eaeb78d3(b_enable) {
    if (b_enable) {
        self flagsys::set(#"hash_6ce14241f77af1e7");
        return;
    }
    self flagsys::clear(#"hash_6ce14241f77af1e7");
}

