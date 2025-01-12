#using script_2c5daa95f8fec03c;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;

#namespace zombie_gladiator_util;

// Namespace zombie_gladiator_util/ai_gladiator_util
// Params 0, eflags: 0x2
// Checksum 0xe063fb0c, Offset: 0x1d0
// Size: 0x54
function autoexec __init__system__() {
    system::register(#"zombie_gladiator_util", &__init__, &__main__, #"zm_ai_gladiator");
}

// Namespace zombie_gladiator_util/ai_gladiator_util
// Params 0, eflags: 0x0
// Checksum 0xf29928fc, Offset: 0x230
// Size: 0x124
function __init__() {
    level.var_6fcab724 = getentarray("zombie_gladiator_destroyer_spawner", "script_noteworthy");
    level.var_8006d917 = getentarray("zombie_gladiator_marauder_spawner", "script_noteworthy");
    level.var_65b4edd1 = arraycombine(level.var_6fcab724, level.var_8006d917, 0, 0);
    zm_round_spawning::register_archetype("gladiator_destroyer", &function_3847829d, &function_94a55d15, &function_33373b4f, 225);
    zm_round_spawning::register_archetype("gladiator_marauder", &function_3847829d, &function_f208ec89, &function_30d02c01, 75);
}

// Namespace zombie_gladiator_util/ai_gladiator_util
// Params 0, eflags: 0x0
// Checksum 0xe287e943, Offset: 0x360
// Size: 0x6c
function __main__() {
    spawner::add_archetype_spawn_function("gladiator", &function_3ac849d4);
    zm_score::function_c723805e("gladiator", level.var_6fcab724[0] ai::function_a0dbf10a().var_c42ea088);
}

// Namespace zombie_gladiator_util/ai_gladiator_util
// Params 0, eflags: 0x4
// Checksum 0xdf216b80, Offset: 0x3d8
// Size: 0x18c
function private function_3ac849d4() {
    n_hp = zm_ai_utility::function_55a1bfd1(1) * (isdefined(level.var_fff66c5c) ? level.var_fff66c5c : 1);
    if (self.var_ea94c12a == "gladiator_marauder") {
        n_hp *= 0.7;
        self.var_5f02c51 = 150;
        self playsound(#"zmb_ai_gladiator_spawn_mar");
    } else {
        self playsound(#"zmb_ai_gladiator_spawn_des");
    }
    self.health = int(n_hp);
    self.maxhealth = int(n_hp);
    self.ignore_nuke = 1;
    self.should_zigzag = 1;
    self zm_score::function_c4374c52();
    if (self.var_ea94c12a == "gladiator_destroyer") {
        namespace_9088c704::initweakpoints(self, "c_t8_zmb_gladiator_dst_weakpoint_def");
        return;
    }
    if (self.var_ea94c12a == "gladiator_marauder") {
        namespace_9088c704::initweakpoints(self, "c_t8_zmb_gladiator_mar_weakpoint_def");
    }
}

// Namespace zombie_gladiator_util/ai_gladiator_util
// Params 3, eflags: 0x0
// Checksum 0xddf412f9, Offset: 0x570
// Size: 0x138
function function_993ddc19(sp_spawner = level.var_65b4edd1[0], s_spot, str_type) {
    if (isdefined(str_type)) {
        switch (str_type) {
        case #"melee":
            sp_spawner = level.var_8006d917[0];
            break;
        case #"ranged":
            sp_spawner = level.var_6fcab724[0];
            break;
        }
    }
    ai = zombie_utility::spawn_zombie(sp_spawner, "gladiator", s_spot);
    if (isdefined(ai)) {
        if (isdefined(s_spot)) {
            ai.script_string = s_spot.script_string;
            ai.find_flesh_struct_string = s_spot.find_flesh_struct_string;
        }
        ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
        ai thread zombie_utility::round_spawn_failsafe();
    }
    return ai;
}

// Namespace zombie_gladiator_util/ai_gladiator_util
// Params 5, eflags: 0x0
// Checksum 0x2cbbd3ea, Offset: 0x6b0
// Size: 0x2bc
function function_e8c77e88(n_to_spawn = 1, str_type, var_e41e673a, b_force_spawn = 0, var_b7959229 = undefined) {
    n_spawned = 0;
    if (isdefined(str_type)) {
        if (str_type == "ranged") {
            var_8b8b9961 = level.var_6fcab724[0];
        }
        if (str_type == "melee") {
            var_8b8b9961 = level.var_8006d917[0];
        }
    } else {
        var_8b8b9961 = array::random(level.var_65b4edd1);
    }
    while (n_spawned < n_to_spawn) {
        if (!b_force_spawn && !function_d165d773()) {
            return n_spawned;
        }
        players = getplayers();
        if (isdefined(var_b7959229)) {
            s_spawn_loc = var_b7959229;
        } else if (isdefined(level.var_7b524729) && level flag::get("special_round")) {
            s_spawn_loc = [[ level.var_7b524729 ]](var_8b8b9961);
        } else if (isdefined(level.zm_loc_types[#"gladiator_location"]) && level.zm_loc_types[#"gladiator_location"].size) {
            s_spawn_loc = array::random(level.zm_loc_types[#"gladiator_location"]);
        }
        if (!isdefined(s_spawn_loc)) {
            return 0;
        }
        ai = function_993ddc19(var_8b8b9961);
        if (isdefined(ai)) {
            ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
            ai.script_string = s_spawn_loc.script_string;
            ai.find_flesh_struct_string = s_spawn_loc.find_flesh_struct_string;
            n_spawned++;
            if (isdefined(var_e41e673a)) {
                ai thread [[ var_e41e673a ]](s_spawn_loc);
            }
        }
        function_14e58f78();
    }
    return 1;
}

// Namespace zombie_gladiator_util/ai_gladiator_util
// Params 2, eflags: 0x0
// Checksum 0xee99cc6, Offset: 0x978
// Size: 0x208
function function_33373b4f(b_force_spawn = 0, var_b7959229) {
    if (!b_force_spawn && !function_d165d773()) {
        return undefined;
    }
    players = getplayers();
    if (isdefined(var_b7959229)) {
        s_spawn_loc = var_b7959229;
    } else if (isdefined(level.var_7b524729)) {
        s_spawn_loc = [[ level.var_7b524729 ]]();
    } else if (isdefined(level.zm_loc_types[#"gladiator_location"]) && level.zm_loc_types[#"gladiator_location"].size) {
        s_spawn_loc = array::random(level.zm_loc_types[#"gladiator_location"]);
    }
    if (!isdefined(s_spawn_loc)) {
        return undefined;
    }
    ai = zombie_utility::spawn_zombie(level.var_6fcab724[0], "gladiator");
    if (isdefined(ai)) {
        ai.script_string = s_spawn_loc.script_string;
        ai.find_flesh_struct_string = s_spawn_loc.find_flesh_struct_string;
        ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
        ai thread zombie_utility::round_spawn_failsafe();
        ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
        if (isdefined(level.var_68e5fb1f)) {
            ai thread [[ level.var_68e5fb1f ]](s_spawn_loc);
        }
    }
    return ai;
}

// Namespace zombie_gladiator_util/ai_gladiator_util
// Params 2, eflags: 0x0
// Checksum 0xef3c592a, Offset: 0xb88
// Size: 0x208
function function_30d02c01(b_force_spawn = 0, var_b7959229) {
    if (!b_force_spawn && !function_d165d773()) {
        return undefined;
    }
    players = getplayers();
    if (isdefined(var_b7959229)) {
        s_spawn_loc = var_b7959229;
    } else if (isdefined(level.var_7b524729)) {
        s_spawn_loc = [[ level.var_7b524729 ]]();
    } else if (isdefined(level.zm_loc_types[#"gladiator_location"]) && level.zm_loc_types[#"gladiator_location"].size) {
        s_spawn_loc = array::random(level.zm_loc_types[#"gladiator_location"]);
    }
    if (!isdefined(s_spawn_loc)) {
        return undefined;
    }
    ai = zombie_utility::spawn_zombie(level.var_8006d917[0], "gladiator");
    if (isdefined(ai)) {
        ai.script_string = s_spawn_loc.script_string;
        ai.find_flesh_struct_string = s_spawn_loc.find_flesh_struct_string;
        ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
        ai thread zombie_utility::round_spawn_failsafe();
        ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
        if (isdefined(level.var_68e5fb1f)) {
            ai thread [[ level.var_68e5fb1f ]](s_spawn_loc);
        }
    }
    return ai;
}

// Namespace zombie_gladiator_util/ai_gladiator_util
// Params 0, eflags: 0x0
// Checksum 0xa075c288, Offset: 0xd98
// Size: 0x9a
function function_d165d773() {
    var_b2d919bc = function_d839f61b();
    var_47b650bd = function_8c721deb();
    if (isdefined(level.var_ae44635d) && level.var_ae44635d || var_b2d919bc >= var_47b650bd || !level flag::get("spawn_zombies")) {
        return false;
    }
    return true;
}

// Namespace zombie_gladiator_util/ai_gladiator_util
// Params 0, eflags: 0x0
// Checksum 0xf209ef5f, Offset: 0xe40
// Size: 0xb4
function function_d839f61b() {
    var_8f144bed = getaiarchetypearray("gladiator");
    var_b2d919bc = var_8f144bed.size;
    foreach (ai in var_8f144bed) {
        if (!isalive(ai)) {
            var_b2d919bc--;
        }
    }
    return var_b2d919bc;
}

// Namespace zombie_gladiator_util/ai_gladiator_util
// Params 0, eflags: 0x0
// Checksum 0xb79872bc, Offset: 0xf00
// Size: 0xa0
function function_14e58f78() {
    switch (level.players.size) {
    case 1:
        n_default_wait = 8;
        break;
    case 2:
        n_default_wait = 5;
        break;
    case 3:
        n_default_wait = 3;
        break;
    default:
        n_default_wait = 1;
        break;
    }
    wait n_default_wait;
}

// Namespace zombie_gladiator_util/ai_gladiator_util
// Params 0, eflags: 0x0
// Checksum 0xdfd8d448, Offset: 0xfa8
// Size: 0x8a
function function_8c721deb() {
    switch (level.players.size) {
    case 1:
        return 3;
    case 2:
        return 4;
    case 3:
        return 5;
    default:
        return 6;
    }
}

// Namespace zombie_gladiator_util/ai_gladiator_util
// Params 1, eflags: 0x0
// Checksum 0x4174f2ab, Offset: 0x1040
// Size: 0x4a
function function_3847829d(var_e14d9cae) {
    var_13385fd5 = int(floor(var_e14d9cae / 225));
    return var_13385fd5;
}

// Namespace zombie_gladiator_util/ai_gladiator_util
// Params 0, eflags: 0x0
// Checksum 0x6cb1c93b, Offset: 0x1098
// Size: 0x3c
function function_f208ec89() {
    ai = function_30d02c01();
    if (isdefined(ai)) {
        level.zombie_total--;
        return true;
    }
    return false;
}

// Namespace zombie_gladiator_util/ai_gladiator_util
// Params 0, eflags: 0x0
// Checksum 0xe28396d6, Offset: 0x10e0
// Size: 0x3c
function function_94a55d15() {
    ai = function_33373b4f();
    if (isdefined(ai)) {
        level.zombie_total--;
        return true;
    }
    return false;
}

