#using scripts\core_common\ai\archetype_tiger;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_towers_util;
#using scripts\zm_common\util\ai_gladiator_util;
#using scripts\zm_common\util\ai_tiger_util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_utility;

#namespace zm_towers_pap_quest;

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 0, eflags: 0x0
// Checksum 0xc4c7fe7c, Offset: 0x960
// Size: 0x2fc
function init() {
    level._effect[#"fx_challenge_head_blood_burst"] = "maps/zm_towers/fx8_challenge_head_blood_burst";
    level._effect[#"fx_challenge_head_blood_drips"] = "maps/zm_towers/fx8_challenge_head_blood_drips";
    function_3b37217a();
    scene::add_scene_func("p8_fxanim_zm_towers_pap_sarcophagus_spikes_bundle", &function_db558966, "init");
    level thread scene::init("p8_fxanim_zm_towers_pap_door_blue_bundle");
    level thread scene::init("p8_fxanim_zm_towers_pap_door_red_bundle");
    level thread scene::init("p8_fxanim_zm_towers_pap_sarcophagus_bundle");
    n_pap_enabled = zm_custom::function_5638f689(#"zmpapenabled");
    switch (n_pap_enabled) {
    case 2:
        level thread function_ebcf7e0f();
        break;
    case 0:
        level flag::set(#"pap_disabled");
        mdl_sentinel_artifact = getent("mdl_pap_quest_sentinel_artifact", "targetname");
        mdl_sentinel_artifact hide();
        mdl_sentinel_artifact notsolid();
        function_ebc9afcc();
        return;
    }
    level thread function_279df1e2();
    a_mdl_pap_room_debris_clip = getentarray("mdl_pap_room_debris_clip", "targetname");
    foreach (mdl_pap_room_debris_clip in a_mdl_pap_room_debris_clip) {
        mdl_pap_room_debris_clip disconnectpaths();
    }
    var_a178d2fe = getent("sarcophagus_destroyed", "targetname");
    var_a178d2fe hide();
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x7364e81b, Offset: 0xc68
// Size: 0x144
function function_ebcf7e0f() {
    level flag::wait_till("all_players_spawned");
    level flag::set(#"hash_3d833ecc64915d8d");
    level flag::set(#"hash_d38ff215be3a4fc");
    level flag::set(#"hash_4142472dec557d03");
    level flag::set(#"hash_45b6b1ee5d5038b4");
    level flag::set(#"hash_1eda3c39867cbe53");
    level flag::set(#"hash_1b7828aafd3f83f4");
    level flag::set(#"hash_15b79db61753c205");
    level flag::set(#"hash_34c1fdccaa5279bc");
    level flag::set(#"hash_2cf71ce4a3d1c081");
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x6cb9dfce, Offset: 0xdb8
// Size: 0x2e4
function function_3b37217a() {
    level flag::init(#"pap_disabled");
    level flag::init(#"hash_2a7d461c7eff8179");
    level flag::init(#"hash_798d51388d6e10f4");
    level flag::init(#"hash_18134dc5b9b39a96");
    level flag::init(#"hash_582eea77824b014d");
    level flag::init(#"hash_5cc500f9282cd290");
    level flag::init(#"hash_20c64c155f7a0065");
    level flag::init(#"hash_589679a12150767a");
    level flag::init(#"hash_4abb12b14a38d2e9");
    level flag::init(#"hash_15f5946d4968f144");
    level flag::init(#"hash_355567a6fa6d44d1");
    level flag::init(#"hash_76692d6669cb0500");
    level flag::init(#"hash_3d833ecc64915d8d");
    level flag::init(#"hash_d38ff215be3a4fc");
    level flag::init(#"hash_4142472dec557d03");
    level flag::init(#"hash_45b6b1ee5d5038b4");
    level flag::init(#"hash_1eda3c39867cbe53");
    level flag::init(#"hash_1b7828aafd3f83f4");
    level flag::init(#"hash_15b79db61753c205");
    level flag::init(#"hash_34c1fdccaa5279bc");
    level flag::init(#"hash_2cf71ce4a3d1c081");
    level flag::init("zm_towers_pap_quest_sentinel_artifact_exploded");
    level flag::init("zm_towers_pap_quest_completed");
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x129c80c8, Offset: 0x10a8
// Size: 0x44
function function_279df1e2() {
    level endon(#"end_game");
    pap_quest_init(0);
    function_6dc839a1(0);
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 1, eflags: 0x0
// Checksum 0xecb545f0, Offset: 0x10f8
// Size: 0xac
function function_ed66fefd(is_powered) {
    level flag::wait_till("all_players_spawned");
    self zm_pack_a_punch::set_state_hidden();
    level flag::wait_till("zm_towers_pap_quest_completed");
    if (!level flag::get(#"pap_disabled")) {
        self zm_pack_a_punch::function_e95839cd(1, "arriving", "arrive_anim_done");
    }
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 1, eflags: 0x0
// Checksum 0x7586a6df, Offset: 0x11b0
// Size: 0x36c
function pap_quest_init(var_758116d) {
    var_99d9163f = getentarray("pap_quest_encounter_triggers", "script_noteworthy");
    array::run_all(var_99d9163f, &sethintstring, #"hash_2a4860e40142bac5");
    var_3e2e2cbb = array(#"marauder", #"destroyer", #"both", #"tigers");
    a_str_towers = array(#"danu", #"ra", #"odin", #"zeus");
    var_3e2e2cbb = array::randomize(var_3e2e2cbb);
    level.var_b8c9a640 = 0;
    foreach (i, str_tower in a_str_towers) {
        level thread function_57046ecd(str_tower, var_3e2e2cbb[i]);
    }
    level.var_97929e50 = 0;
    level.var_56ff5460 = 0;
    level.var_2a993a38 = 0;
    level thread function_601f7915();
    a_mdl_heads = getentarray("mdl_pap_quest_head", "targetname");
    foreach (mdl_head in a_mdl_heads) {
        mdl_head flag::init(#"hash_26125a3306681e2");
        mdl_head hide();
    }
    level thread function_c2fd1876();
    if (!var_758116d) {
        level flag::wait_till_all(array(#"hash_3d833ecc64915d8d", #"hash_d38ff215be3a4fc", #"hash_4142472dec557d03", #"hash_45b6b1ee5d5038b4"));
    }
    level flag::set(#"hash_76692d6669cb0500");
    function_71e9679b(0, 0);
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 1, eflags: 0x0
// Checksum 0x1b8fbf26, Offset: 0x1528
// Size: 0xd8
function function_db558966(a_ents) {
    var_27312137 = a_ents[#"prop 1"];
    a_mdl_heads = getentarray("mdl_pap_quest_head", "targetname");
    foreach (mdl_head in a_mdl_heads) {
        mdl_head linkto(var_27312137, mdl_head.var_5cd49314);
    }
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 2, eflags: 0x0
// Checksum 0xe1f1e5d3, Offset: 0x1608
// Size: 0x1d0
function function_71e9679b(var_758116d, ended_early) {
    if (var_758116d || ended_early) {
        level flag::set(#"hash_18134dc5b9b39a96");
        level flag::set(#"hash_582eea77824b014d");
        level flag::set(#"hash_5cc500f9282cd290");
        level flag::set(#"hash_20c64c155f7a0065");
        level flag::set(#"hash_589679a12150767a");
        level flag::set(#"hash_4abb12b14a38d2e9");
        level flag::set(#"hash_15f5946d4968f144");
        level flag::set(#"hash_355567a6fa6d44d1");
        level flag::set(#"hash_3d833ecc64915d8d");
        level flag::set(#"hash_d38ff215be3a4fc");
        level flag::set(#"hash_4142472dec557d03");
        level flag::set(#"hash_45b6b1ee5d5038b4");
        return;
    }
    level thread function_ebc9afcc();
    level notify(#"hash_9ffcf4efbfb9b65");
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 2, eflags: 0x0
// Checksum 0xe0c813d2, Offset: 0x17e0
// Size: 0x106c
function function_57046ecd(str_tower, str_encounter) {
    level endon(#"pap_quest_completed");
    switch (str_tower) {
    case #"danu":
        str_trigger = "t_pap_quest_danu_encounter";
        var_996b224d = #"hash_18134dc5b9b39a96";
        var_6cbdf539 = #"hash_589679a12150767a";
        level.var_1961da8a = str_encounter;
        var_154dbb46 = struct::get_array("s_pap_encounter_scenes_danu_destroyer");
        var_6ba6dfe0 = struct::get_array("s_pap_encounter_scenes_danu_marauder");
        var_95f0570c = struct::get_array("s_pap_encounter_scenes_danu_tiger");
        s_spawn = struct::get("s_pap_encounter_spawn_danu");
        break;
    case #"ra":
        str_trigger = "t_pap_quest_ra_encounter";
        var_996b224d = #"hash_582eea77824b014d";
        var_6cbdf539 = #"hash_4abb12b14a38d2e9";
        level.var_4e8f3f53 = str_encounter;
        var_154dbb46 = struct::get_array("s_pap_encounter_scenes_ra_destroyer");
        var_6ba6dfe0 = struct::get_array("s_pap_encounter_scenes_ra_marauder");
        var_95f0570c = struct::get_array("s_pap_encounter_scenes_ra_tiger");
        s_spawn = struct::get("s_pap_encounter_spawn_ra");
        break;
    case #"odin":
        str_trigger = "t_pap_quest_odin_encounter";
        var_996b224d = #"hash_5cc500f9282cd290";
        var_6cbdf539 = #"hash_15f5946d4968f144";
        level.var_491f6684 = str_encounter;
        var_154dbb46 = struct::get_array("s_pap_encounter_scenes_odin_destroyer");
        var_6ba6dfe0 = struct::get_array("s_pap_encounter_scenes_odin_marauder");
        var_95f0570c = struct::get_array("s_pap_encounter_scenes_odin_tiger");
        s_spawn = struct::get("s_pap_encounter_spawn_odin");
        break;
    case #"zeus":
        str_trigger = "t_pap_quest_zeus_encounter";
        var_996b224d = #"hash_20c64c155f7a0065";
        var_6cbdf539 = #"hash_355567a6fa6d44d1";
        level.var_82ec401b = str_encounter;
        var_154dbb46 = struct::get_array("s_pap_encounter_scenes_zeus_destroyer");
        var_6ba6dfe0 = struct::get_array("s_pap_encounter_scenes_zeus_marauder");
        var_95f0570c = struct::get_array("s_pap_encounter_scenes_zeus_tiger");
        s_spawn = struct::get("s_pap_encounter_spawn_zeus");
        break;
    }
    var_154dbb46 = array::randomize(var_154dbb46);
    var_6ba6dfe0 = array::randomize(var_6ba6dfe0);
    var_95f0570c = array::randomize(var_95f0570c);
    t_trigger = getent(str_trigger, "targetname");
    var_3a4c73b2 = getent(t_trigger.target, "targetname");
    var_3a4c73b2.var_28cad583 = getent(var_3a4c73b2.target, "targetname");
    var_3a4c73b2.var_46d94f = getent(var_3a4c73b2.var_28cad583.target, "targetname");
    var_3a4c73b2.var_28cad583 hide();
    var_3a4c73b2 thread scene::init("p8_fxanim_zm_towers_challenge_gong_bundle", var_3a4c73b2);
    b_triggered = 0;
    while (!b_triggered) {
        waitresult = t_trigger waittill(#"trigger");
        if (!level flag::get(#"hash_798d51388d6e10f4")) {
            b_triggered = 1;
            break;
        }
    }
    level flag::set(#"hash_2a7d461c7eff8179");
    level flag::set(var_996b224d);
    level flag::set(#"hash_798d51388d6e10f4");
    switch (str_tower) {
    case #"danu":
        str_encounter = level.var_1961da8a;
        str_exploder = "fxexp_gong_danu";
        var_74900bd6 = #"hash_18134dc5b9b39a96";
        break;
    case #"ra":
        str_encounter = level.var_4e8f3f53;
        str_exploder = "fxexp_gong_ra";
        var_74900bd6 = #"hash_582eea77824b014d";
        break;
    case #"odin":
        str_encounter = level.var_491f6684;
        str_exploder = "fxexp_gong_odin";
        var_74900bd6 = #"hash_5cc500f9282cd290";
        break;
    case #"zeus":
        str_encounter = level.var_82ec401b;
        str_exploder = "fxexp_gong_zeus";
        var_74900bd6 = #"hash_20c64c155f7a0065";
        break;
    }
    exploder::exploder(str_exploder);
    level thread zm_audio::sndannouncerplayvox(var_74900bd6);
    switch (str_encounter) {
    case #"marauder":
        if (!level.var_b8c9a640) {
            var_bb458617 = array(#"marauder");
        } else {
            var_bb458617 = [];
            for (i = 0; i < var_6ba6dfe0.size; i++) {
                if (!isdefined(var_bb458617)) {
                    var_bb458617 = [];
                } else if (!isarray(var_bb458617)) {
                    var_bb458617 = array(var_bb458617);
                }
                var_bb458617[var_bb458617.size] = #"marauder";
            }
        }
        break;
    case #"destroyer":
        if (!level.var_b8c9a640) {
            var_bb458617 = array(#"destroyer");
        } else {
            var_bb458617 = [];
            for (i = 0; i < var_154dbb46.size; i++) {
                if (!isdefined(var_bb458617)) {
                    var_bb458617 = [];
                } else if (!isarray(var_bb458617)) {
                    var_bb458617 = array(var_bb458617);
                }
                var_bb458617[var_bb458617.size] = #"destroyer";
            }
        }
        break;
    case #"both":
        var_bb458617 = array(#"marauder", #"destroyer");
        break;
    case #"tigers":
        if (!level.var_b8c9a640) {
            var_bb458617 = array(#"tiger", #"tiger", #"tiger", #"tiger");
        } else {
            var_bb458617 = [];
            for (i = 0; i < var_95f0570c.size; i++) {
                if (!isdefined(var_bb458617)) {
                    var_bb458617 = [];
                } else if (!isarray(var_bb458617)) {
                    var_bb458617 = array(var_bb458617);
                }
                var_bb458617[var_bb458617.size] = #"tiger";
            }
        }
        break;
    }
    var_3a4c73b2 thread scene::play("p8_fxanim_zm_towers_challenge_gong_bundle", var_3a4c73b2);
    var_3a4c73b2.var_28cad583 show();
    wait 0.1;
    var_3a4c73b2.var_46d94f hide();
    function_ebc9afcc();
    level.var_741769f8 = var_bb458617.size;
    level.var_31fc46ed = 0;
    var_202559b7 = arraycopy(var_154dbb46);
    var_fbf842ff = arraycopy(var_6ba6dfe0);
    var_d430061d = arraycopy(var_95f0570c);
    foreach (i, str_enemy in var_bb458617) {
        switch (str_enemy) {
        case #"destroyer":
            if (str_encounter != #"both") {
                if (var_202559b7.size == 0) {
                    var_202559b7 = array::randomize(var_154dbb46);
                }
                s_scene = var_202559b7[0];
                arrayremoveindex(var_202559b7, 0);
            } else {
                switch (str_tower) {
                case #"danu":
                    s_scene = struct::get("danu_destroyer", "script_pap_encounter_scene_both");
                    break;
                case #"ra":
                    s_scene = struct::get("ra_destroyer", "script_pap_encounter_scene_both");
                    break;
                case #"odin":
                    s_scene = struct::get("odin_destroyer", "script_pap_encounter_scene_both");
                    break;
                case #"zeus":
                    s_scene = struct::get("zeus_destroyer", "script_pap_encounter_scene_both");
                    break;
                }
            }
            break;
        case #"marauder":
            if (str_encounter != #"both") {
                if (var_fbf842ff.size == 0) {
                    var_fbf842ff = array::randomize(var_6ba6dfe0);
                }
                s_scene = var_fbf842ff[0];
                arrayremoveindex(var_fbf842ff, 0);
            } else {
                switch (str_tower) {
                case #"danu":
                    s_scene = struct::get("danu_marauder", "script_pap_encounter_scene_both");
                    break;
                case #"ra":
                    s_scene = struct::get("ra_marauder", "script_pap_encounter_scene_both");
                    break;
                case #"odin":
                    s_scene = struct::get("odin_marauder", "script_pap_encounter_scene_both");
                    break;
                case #"zeus":
                    s_scene = struct::get("zeus_marauder", "script_pap_encounter_scene_both");
                    break;
                }
            }
            break;
        case #"tiger":
            if (var_d430061d.size == 0) {
                var_d430061d = array::randomize(var_95f0570c);
            }
            s_scene = var_d430061d[0];
            arrayremoveindex(var_d430061d, 0);
            break;
        }
        function_c81eab9d(str_enemy, s_spawn, s_scene);
        if (level.var_b8c9a640 || str_encounter == #"tigers" && i < var_bb458617.size) {
            wait 1;
        }
    }
    s_waitresult = level waittill(#"hash_2ea1048758a3ff14");
    v_origin = s_waitresult.v_origin;
    var_ab131f92 = s_waitresult.var_ab131f92;
    str_archetype = s_waitresult.str_archetype;
    var_7bf29b5e = s_waitresult.var_7bf29b5e;
    if (str_encounter == #"both") {
        if (var_7bf29b5e == "gladiator_destroyer") {
            level.var_db39bcda = #"destroyer";
        } else {
            level.var_db39bcda = #"marauder";
        }
    }
    level thread drop_head(v_origin, str_tower, var_ab131f92);
    level flag::set(var_6cbdf539);
    level flag::clear(#"hash_798d51388d6e10f4");
    function_3242b8a();
    switch (str_tower) {
    case #"danu":
        var_74900bd6 = #"hash_589679a12150767a";
        break;
    case #"ra":
        var_74900bd6 = #"hash_4abb12b14a38d2e9";
        break;
    case #"odin":
        var_74900bd6 = #"hash_15f5946d4968f144";
        break;
    case #"zeus":
        var_74900bd6 = #"hash_355567a6fa6d44d1";
        break;
    }
    level thread zm_audio::sndannouncerplayvox(var_74900bd6);
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 3, eflags: 0x0
// Checksum 0xc6f36980, Offset: 0x2858
// Size: 0x16a
function function_c81eab9d(str_enemy, s_spawn, s_scene) {
    ai_enemy = undefined;
    while (!isdefined(ai_enemy)) {
        switch (str_enemy) {
        case #"marauder":
            ai_enemy = zombie_gladiator_util::function_30d02c01(1, s_spawn);
            break;
        case #"destroyer":
            ai_enemy = zombie_gladiator_util::function_33373b4f(1, s_spawn);
            break;
        case #"tiger":
            ai_enemy = zombie_tiger_util::spawn_single(1, s_spawn);
            break;
        }
        if (isdefined(ai_enemy)) {
            ai_enemy flag::init(#"hash_368f8dee8aca386c");
            ai_enemy thread function_bbedb85a();
            ai_enemy thread function_337548a9(s_scene);
            if (ai_enemy.archetype == "tiger") {
                ai_enemy ai::set_behavior_attribute("sprint", 1);
            }
            return;
        }
    }
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 1, eflags: 0x0
// Checksum 0xf6eed8ac, Offset: 0x29d0
// Size: 0x11c
function function_337548a9(s_scene) {
    self endon(#"death");
    self.var_2e8cef76 = 1;
    self.no_powerups = 1;
    self.ignore_round_spawn_failsafe = 1;
    self.b_ignore_cleanup = 1;
    self.ignore_enemy_count = 1;
    self.ignore_nuke = 1;
    self.var_da4cbdc4 = 1;
    s_scene scene::play(self);
    self.var_da4cbdc4 = undefined;
    if (self.archetype == "gladiator") {
        self.completed_emerging_into_playable_area = 1;
        self notify(#"completed_emerging_into_playable_area");
    } else if (self.archetype == "tiger") {
        self tigerbehavior::function_643dbbb0();
    }
    self flag::set(#"hash_368f8dee8aca386c");
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 0, eflags: 0x0
// Checksum 0xa4a95445, Offset: 0x2af8
// Size: 0x140
function function_bbedb85a() {
    str_archetype = self.archetype;
    var_7bf29b5e = self.var_ea94c12a;
    self waittill(#"death");
    v_origin = self.origin;
    var_ab131f92 = self flag::get(#"hash_368f8dee8aca386c");
    if (var_ab131f92) {
        var_ab131f92 = zm_utility::check_point_in_playable_area(v_origin);
    }
    level.var_31fc46ed++;
    if (level.var_31fc46ed >= level.var_741769f8) {
        self thread zm_towers_util::function_ebdff9e5(100, 75, 75);
        level notify(#"hash_2ea1048758a3ff14", {#v_origin:v_origin, #var_ab131f92:var_ab131f92, #str_archetype:str_archetype, #var_7bf29b5e:var_7bf29b5e});
    }
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x1295376f, Offset: 0x2c40
// Size: 0xa8
function function_ebc9afcc() {
    var_99d9163f = getentarray("pap_quest_encounter_triggers", "script_noteworthy");
    foreach (var_a4b7095c in var_99d9163f) {
        var_a4b7095c triggerenable(0);
    }
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x4797e519, Offset: 0x2cf0
// Size: 0xd8
function function_3242b8a() {
    var_99d9163f = getentarray("pap_quest_encounter_triggers", "script_noteworthy");
    foreach (var_a4b7095c in var_99d9163f) {
        if (!level flag::get(hash(var_a4b7095c.var_49074aca))) {
            var_a4b7095c triggerenable(1);
        }
    }
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 3, eflags: 0x0
// Checksum 0x862c9ab3, Offset: 0x2dd0
// Size: 0x2d4
function drop_head(v_origin, str_tower, var_988bbfc2) {
    v_position = v_origin + (0, 0, 40);
    str_head = #"c_t8_zmb_dlc0_zombie_corpse_head_2";
    str_encounter = get_encounter(str_tower);
    if (str_encounter == #"both") {
        if (!isdefined(level.var_db39bcda)) {
            level.var_db39bcda = #"destroyer";
        }
        str_encounter = level.var_db39bcda;
    }
    switch (str_encounter) {
    case #"destroyer":
        str_head = #"hash_7c166ef26a8ce946";
        break;
    case #"marauder":
        str_head = #"c_t8_zmb_dlc0_zombie_marauder_decapitated_head1";
        break;
    case #"tigers":
        str_head = #"hash_7046550bbfeaf740";
        break;
    }
    var_5806171 = util::spawn_model(str_head, v_position, (270, 0, 0));
    var_5806171 clientfield::set("zombie_head_pickup_glow", 1);
    if (!var_988bbfc2) {
        switch (str_tower) {
        case #"danu":
            str_backup = "s_danu_encounter_back_up_head_spawn";
            break;
        case #"ra":
            str_backup = "s_ra_encounter_back_up_head_spawn";
            break;
        case #"odin":
            str_backup = "s_odin_encounter_back_up_head_spawn";
            break;
        case #"zeus":
            str_backup = "s_zeus_encounter_back_up_head_spawn";
            break;
        }
        s_point = struct::get(str_backup);
        var_e2ea1b3f = s_point.origin + (0, 0, 40);
        var_5806171 moveto(var_e2ea1b3f, 2);
    }
    var_5806171 thread zm_towers_util::function_9f66d3bc();
    var_5806171 thread function_4974191b(str_tower);
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 1, eflags: 0x0
// Checksum 0xfe7736c, Offset: 0x30b0
// Size: 0x440
function function_4974191b(str_tower) {
    var_a74a8a2e = 0;
    while (!var_a74a8a2e) {
        a_e_players = level.players;
        foreach (e_player in a_e_players) {
            if (distancesquared(e_player.origin, self.origin) < 4096) {
                var_a74a8a2e = 1;
                break;
            }
        }
        wait 0.1;
    }
    switch (str_tower) {
    case #"danu":
        str_flag = #"hash_3d833ecc64915d8d";
        str_clientfield = #"hash_6723503c3bb785e2";
        break;
    case #"ra":
        str_flag = #"hash_d38ff215be3a4fc";
        str_clientfield = #"hash_1210f36a23333b2f";
        break;
    case #"odin":
        str_flag = #"hash_4142472dec557d03";
        str_clientfield = #"hash_aa23a6c8df723cc";
        break;
    case #"zeus":
        str_flag = #"hash_45b6b1ee5d5038b4";
        str_clientfield = #"hash_93244ef9fadd30f";
        break;
    }
    level zm_ui_inventory::function_31a39683(str_clientfield, 1);
    level flag::set(str_flag);
    level.var_97929e50++;
    level thread function_a9787b48();
    n_scalar = zombie_utility::get_zombie_var_team(#"zombie_point_scalar", #"allies");
    foreach (e_player in level.players) {
        e_player zm_score::add_to_player_score(500 * n_scalar);
    }
    playsoundatposition(#"hash_f35db774de79d2", self.origin);
    self clientfield::set("zombie_head_pickup_glow", 0);
    self delete();
    /#
        var_10ff18a9 = 0;
        if (level flag::get(#"hash_3d833ecc64915d8d")) {
            var_10ff18a9++;
        }
        if (level flag::get(#"hash_d38ff215be3a4fc")) {
            var_10ff18a9++;
        }
        if (level flag::get(#"hash_4142472dec557d03")) {
            var_10ff18a9++;
        }
        if (level flag::get(#"hash_45b6b1ee5d5038b4")) {
            var_10ff18a9++;
        }
        str_message = var_10ff18a9 + "<dev string:x30>";
        iprintlnbold(str_message);
    #/
    level notify(#"collected_head");
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 1, eflags: 0x0
// Checksum 0xaefb6105, Offset: 0x34f8
// Size: 0x8c
function function_6dc839a1(var_758116d) {
    if (!var_758116d) {
        level flag::wait_till(#"hash_2cf71ce4a3d1c081");
        level flag::wait_till("zm_towers_pap_quest_sentinel_artifact_exploded");
    }
    level flag::set("zm_towers_pap_quest_completed");
    function_d31b93ba(0, 0);
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 2, eflags: 0x0
// Checksum 0xac0b61a8, Offset: 0x3590
// Size: 0x500
function function_d31b93ba(var_758116d, ended_early) {
    if (var_758116d || ended_early) {
        level flag::set(#"hash_2cf71ce4a3d1c081");
        level flag::set("zm_towers_pap_quest_sentinel_artifact_exploded");
        level flag::set("zm_towers_pap_quest_completed");
        a_mdl_heads = getentarray("mdl_pap_quest_head", "targetname");
        foreach (mdl_head in a_mdl_heads) {
            mdl_head show();
        }
        mdl_sentinel_artifact = getent("mdl_pap_quest_sentinel_artifact", "targetname");
        mdl_sentinel_artifact hide();
        mdl_sentinel_artifact notsolid();
        return;
    }
    /#
        iprintlnbold("<dev string:x51>");
    #/
    if (zm_utility::is_standard()) {
        level waittill(#"hash_7ca261f468171655");
    } else {
        level flag::set("power_on");
    }
    level thread zm_audio::sndannouncerplayvox(#"pap_quest_completed");
    a_mdl_heads = getentarray("mdl_pap_quest_head", "targetname");
    array::thread_all(a_mdl_heads, &function_d47819ae);
    level thread scene::play("p8_fxanim_zm_towers_pap_sarcophagus_spikes_bundle");
    level thread scene::play("p8_fxanim_zm_towers_pap_sarcophagus_blood_01_bundle", "Shot 2");
    level thread scene::play("p8_fxanim_zm_towers_pap_sarcophagus_blood_02_bundle", "Shot 2");
    level thread scene::play("p8_fxanim_zm_towers_pap_sarcophagus_blood_03_bundle", "Shot 2");
    level scene::play("p8_fxanim_zm_towers_pap_sarcophagus_blood_04_bundle", "Shot 2");
    level thread scene::play("p8_fxanim_zm_towers_pap_sarcophagus_bundle");
    level thread scene::play("p8_fxanim_zm_towers_pap_door_blue_bundle");
    level thread scene::play("p8_fxanim_zm_towers_pap_door_red_bundle");
    exploder::exploder("fx8_exp_pap_slam_smk");
    var_a178d2fe = getent("sarcophagus_destroyed", "targetname");
    var_a178d2fe show();
    var_475bc3bf = getent("sarcophagus_solid", "targetname");
    var_475bc3bf delete();
    a_mdl_pap_room_debris_clip = getentarray("mdl_pap_room_debris_clip", "targetname");
    foreach (mdl_pap_room_debris_clip in a_mdl_pap_room_debris_clip) {
        mdl_pap_room_debris_clip connectpaths();
        mdl_pap_room_debris_clip delete();
    }
    level flag::set("connect_pap_room_to_danu_ra_tunnel");
    level flag::set("connect_pap_room_to_odin_zeus_tunnel");
    level notify(#"pap_quest_completed");
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x5f7dd01e, Offset: 0x3a98
// Size: 0xa4
function function_d47819ae() {
    level endon(#"end_game");
    str_notify = self.var_ac3730c2;
    level waittill(str_notify);
    self thread fx::play("fx_challenge_head_blood_burst", self getcentroid(), undefined, undefined, 1, undefined, 1, 0);
    self notify(#"hash_691806c47ba12fac");
    self hide();
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 0, eflags: 0x0
// Checksum 0xe8e28a07, Offset: 0x3b48
// Size: 0x4c
function function_601f7915() {
    t_trigger = getent("t_pap_quest_place_head", "targetname");
    t_trigger sethintstring(#"hash_6b4f36812ac1e729");
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x8235a805, Offset: 0x3ba0
// Size: 0x10c
function function_a9787b48() {
    self notify("2ffef791504f0c11");
    self endon("2ffef791504f0c11");
    level endon(#"pap_quest_completed");
    t_trigger = getent("t_pap_quest_place_head", "targetname");
    t_trigger sethintstring(#"hash_50fc385a94b3d3f");
    while (true) {
        s_notify = t_trigger waittill(#"trigger");
        e_player = s_notify.activator;
        if (isplayer(e_player)) {
            v_origin = e_player.origin;
            break;
        }
    }
    level thread function_eff26b37(v_origin);
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 1, eflags: 0x0
// Checksum 0x2e1d2e59, Offset: 0x3cb8
// Size: 0x1d4
function function_eff26b37(v_player_origin) {
    a_mdl_heads = getentarray("mdl_pap_quest_head", "targetname");
    a_mdl_heads = util::get_array_of_closest(v_player_origin, a_mdl_heads);
    n_heads = level.var_97929e50;
    level.var_97929e50 = 0;
    foreach (mdl_head in a_mdl_heads) {
        if (mdl_head flag::get(#"hash_26125a3306681e2")) {
            continue;
        }
        mdl_head flag::set(#"hash_26125a3306681e2");
        mdl_head function_9e9b81c9();
        mdl_head thread function_a6816a11();
        level.var_56ff5460++;
        n_heads--;
        if (n_heads <= 0) {
            break;
        }
    }
    if (level.var_56ff5460 >= 4) {
        var_4e018c15 = getent("t_pap_quest_place_head", "targetname");
        var_4e018c15 triggerenable(0);
        return;
    }
    function_601f7915();
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x9176c39a, Offset: 0x3e98
// Size: 0x44c
function function_9e9b81c9() {
    if (level flag::get(#"hash_3d833ecc64915d8d") && !level flag::get(#"hash_1eda3c39867cbe53")) {
        var_9b705cdf = #"hash_6723503c3bb785e2";
        str_flag = #"hash_1eda3c39867cbe53";
        str_tower = #"danu";
    } else if (level flag::get(#"hash_d38ff215be3a4fc") && !level flag::get(#"hash_1b7828aafd3f83f4")) {
        var_9b705cdf = #"hash_1210f36a23333b2f";
        str_flag = #"hash_1b7828aafd3f83f4";
        str_tower = #"ra";
    } else if (level flag::get(#"hash_4142472dec557d03") && !level flag::get(#"hash_15b79db61753c205")) {
        var_9b705cdf = #"hash_aa23a6c8df723cc";
        str_flag = #"hash_15b79db61753c205";
        str_tower = #"odin";
    } else if (level flag::get(#"hash_45b6b1ee5d5038b4") && !level flag::get(#"hash_34c1fdccaa5279bc")) {
        var_9b705cdf = #"hash_93244ef9fadd30f";
        str_flag = #"hash_34c1fdccaa5279bc";
        str_tower = #"zeus";
    }
    level zm_ui_inventory::function_31a39683(var_9b705cdf, 2);
    level flag::set(str_flag);
    str_fx_tag = "j_neck";
    str_encounter = get_encounter(str_tower);
    if (str_encounter == #"both") {
        if (!isdefined(level.var_db39bcda)) {
            level.var_db39bcda = #"destroyer";
        }
        str_encounter = level.var_db39bcda;
    }
    switch (str_encounter) {
    case #"destroyer":
        str_fx_tag = undefined;
        self setmodel(#"hash_7c166ef26a8ce946");
        break;
    case #"marauder":
        str_fx_tag = undefined;
        self setmodel(#"c_t8_zmb_dlc0_zombie_marauder_decapitated_head1");
        break;
    case #"tigers":
        str_fx_tag = undefined;
        self setmodel(#"hash_7046550bbfeaf740");
        break;
    }
    self show();
    self playsound(#"hash_3d7066af9c9bf849");
    self thread fx::play("fx_challenge_head_blood_burst", self getcentroid(), undefined, undefined, 1, undefined, 1, 0);
    self thread fx::play("fx_challenge_head_blood_drips", self getcentroid(), undefined, #"hash_691806c47ba12fac", 1, str_fx_tag, 1, 0);
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 1, eflags: 0x0
// Checksum 0x3d29d562, Offset: 0x42f0
// Size: 0xae
function get_encounter(str_tower) {
    switch (str_tower) {
    case #"danu":
        str_encounter = level.var_1961da8a;
        break;
    case #"ra":
        str_encounter = level.var_4e8f3f53;
        break;
    case #"odin":
        str_encounter = level.var_491f6684;
        break;
    case #"zeus":
        str_encounter = level.var_82ec401b;
        break;
    }
    return str_encounter;
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x39009242, Offset: 0x43a8
// Size: 0x6c
function function_a6816a11() {
    level scene::play(self.var_5cba1969, "Shot 1");
    level.var_2a993a38++;
    if (level.var_2a993a38 >= 4) {
        level flag::set(#"hash_2cf71ce4a3d1c081");
    }
}

// Namespace zm_towers_pap_quest/zm_towers_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x9cf73647, Offset: 0x4420
// Size: 0x144
function function_c2fd1876() {
    level flag::wait_till(#"hash_2cf71ce4a3d1c081");
    var_4e018c15 = getent("t_pap_quest_place_head", "targetname");
    if (isdefined(var_4e018c15)) {
        var_4e018c15 delete();
    }
    var_50d2a215 = getentarray("script_brush_lgt_pap_door", "targetname");
    foreach (a_clip in var_50d2a215) {
        a_clip delete();
    }
    exploder::exploder("exp_lgt_pap");
    level flag::set("zm_towers_pap_quest_sentinel_artifact_exploded");
}

/#

    // Namespace zm_towers_pap_quest/zm_towers_pap_quest
    // Params 1, eflags: 0x0
    // Checksum 0x743ccb54, Offset: 0x4570
    // Size: 0x324
    function function_5ddcc755(str_head) {
        switch (str_head) {
        case #"danu":
            var_996b224d = #"hash_18134dc5b9b39a96";
            var_6cbdf539 = #"hash_589679a12150767a";
            var_8e4166f3 = #"hash_3d833ecc64915d8d";
            str_clientfield = #"hash_6723503c3bb785e2";
            break;
        case #"ra":
            var_996b224d = #"hash_582eea77824b014d";
            var_6cbdf539 = #"hash_4abb12b14a38d2e9";
            var_8e4166f3 = #"hash_d38ff215be3a4fc";
            str_clientfield = #"hash_1210f36a23333b2f";
            break;
        case #"odin":
            var_996b224d = #"hash_5cc500f9282cd290";
            var_6cbdf539 = #"hash_15f5946d4968f144";
            var_8e4166f3 = #"hash_4142472dec557d03";
            str_clientfield = #"hash_aa23a6c8df723cc";
            break;
        case #"zeus":
            var_996b224d = #"hash_20c64c155f7a0065";
            var_6cbdf539 = #"hash_355567a6fa6d44d1";
            var_8e4166f3 = #"hash_45b6b1ee5d5038b4";
            str_clientfield = #"hash_93244ef9fadd30f";
            break;
        case #"all":
            function_5ddcc755("<dev string:x67>");
            function_5ddcc755("<dev string:x6c>");
            function_5ddcc755("<dev string:x6f>");
            function_5ddcc755("<dev string:x74>");
            return;
        }
        level flag::set(#"hash_2a7d461c7eff8179");
        if (level flag::get(#"hash_2cf71ce4a3d1c081") || level flag::get(var_996b224d)) {
            return;
        }
        function_ebc9afcc();
        level zm_ui_inventory::function_31a39683(str_clientfield, 1);
        level flag::set(var_996b224d);
        level flag::set(var_6cbdf539);
        level flag::set(var_8e4166f3);
        function_3242b8a();
        level.var_97929e50++;
        level thread function_a9787b48();
    }

    // Namespace zm_towers_pap_quest/zm_towers_pap_quest
    // Params 1, eflags: 0x0
    // Checksum 0xc02b1cdb, Offset: 0x48a0
    // Size: 0x1d2
    function function_e94d155c(str_enemy) {
        level.var_b8c9a640 = 1;
        switch (str_enemy) {
        case #"destroyers":
            level.var_1961da8a = #"destroyer";
            level.var_4e8f3f53 = #"destroyer";
            level.var_491f6684 = #"destroyer";
            level.var_82ec401b = #"destroyer";
            iprintlnbold("<dev string:x79>");
            break;
        case #"marauders":
            level.var_1961da8a = #"marauder";
            level.var_4e8f3f53 = #"marauder";
            level.var_491f6684 = #"marauder";
            level.var_82ec401b = #"marauder";
            iprintlnbold("<dev string:x9d>");
            break;
        case #"tigers":
            level.var_1961da8a = #"tigers";
            level.var_4e8f3f53 = #"tigers";
            level.var_491f6684 = #"tigers";
            level.var_82ec401b = #"tigers";
            iprintlnbold("<dev string:xc0>");
            break;
        }
    }

#/
