#using scripts\core_common\ai\archetype_tiger;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\ai\zm_ai_tiger;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;

#namespace zombie_tiger_util;

// Namespace zombie_tiger_util/ai_tiger_util
// Params 0, eflags: 0x2
// Checksum 0xcea9feb8, Offset: 0x128
// Size: 0x54
function autoexec __init__system__() {
    system::register(#"zombie_tiger_util", &__init__, &__main__, #"zm_ai_tiger");
}

// Namespace zombie_tiger_util/ai_tiger_util
// Params 0, eflags: 0x0
// Checksum 0x84ec6d59, Offset: 0x188
// Size: 0xac
function __init__() {
    level.var_7933b524 = getentarray("zombie_tiger_spawner", "script_noteworthy");
    if (level.var_7933b524.size == 0) {
        assertmsg("<dev string:x30>");
        return;
    }
    zm_round_spawning::register_archetype("tiger", &function_dfb12b47, &round_spawn, &spawn_single, 25);
}

// Namespace zombie_tiger_util/ai_tiger_util
// Params 0, eflags: 0x0
// Checksum 0xa7618fb5, Offset: 0x240
// Size: 0x6c
function __main__() {
    zm_score::function_c723805e("tiger", level.var_7933b524[0] ai::function_a0dbf10a().var_6e960a0e);
    spawner::add_archetype_spawn_function("tiger", &function_7a934fda);
}

// Namespace zombie_tiger_util/ai_tiger_util
// Params 0, eflags: 0x0
// Checksum 0x7985e3ef, Offset: 0x2b8
// Size: 0xac
function function_7a934fda() {
    self thread function_50973412();
    var_bb073684 = zm_ai_utility::function_55a1bfd1(0);
    var_bb073684 *= isdefined(level.var_702ddaaa) ? level.var_702ddaaa : 1;
    var_bb073684 = int(var_bb073684);
    self.health = var_bb073684;
    self.maxhealth = var_bb073684;
    self zm_score::function_c4374c52();
}

// Namespace zombie_tiger_util/ai_tiger_util
// Params 2, eflags: 0x0
// Checksum 0x71244c03, Offset: 0x370
// Size: 0x1e8
function spawn_single(b_force_spawn = 0, var_b7959229) {
    if (!b_force_spawn && !function_c6c06b21()) {
        return undefined;
    }
    players = getplayers();
    if (isdefined(var_b7959229)) {
        s_spawn_loc = var_b7959229;
    } else if (isdefined(level.var_a320d973)) {
        s_spawn_loc = [[ level.var_a320d973 ]]();
    } else if (level.zm_loc_types[#"tiger_location"].size > 0) {
        s_spawn_loc = array::random(level.zm_loc_types[#"tiger_location"]);
    }
    if (!isdefined(s_spawn_loc)) {
        return undefined;
    }
    ai = zombie_utility::spawn_zombie(level.var_7933b524[0], "tiger");
    if (isdefined(ai)) {
        ai.script_string = s_spawn_loc.script_string;
        ai.find_flesh_struct_string = s_spawn_loc.find_flesh_struct_string;
        ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
        ai thread zombie_utility::round_spawn_failsafe();
        ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
        if (isdefined(level.tiger_on_spawned)) {
            ai thread [[ level.tiger_on_spawned ]](s_spawn_loc);
        }
    }
    return ai;
}

// Namespace zombie_tiger_util/ai_tiger_util
// Params 0, eflags: 0x0
// Checksum 0xc403137b, Offset: 0x560
// Size: 0xba
function function_c6c06b21() {
    var_467b08cf = function_92aa3641();
    var_e2e67bd4 = function_a4453f86();
    if (!(isdefined(level.var_1e301b4e) && level.var_1e301b4e) && isdefined(level.var_c643d497) && level.var_c643d497 || var_467b08cf >= var_e2e67bd4 || !level flag::get("spawn_zombies")) {
        return false;
    }
    return true;
}

// Namespace zombie_tiger_util/ai_tiger_util
// Params 0, eflags: 0x0
// Checksum 0x79ba6d81, Offset: 0x628
// Size: 0x8a
function function_a4453f86() {
    switch (level.players.size) {
    case 1:
        return 3;
    case 2:
        return 5;
    case 3:
        return 7;
    default:
        return 10;
    }
}

// Namespace zombie_tiger_util/ai_tiger_util
// Params 0, eflags: 0x0
// Checksum 0x396f272a, Offset: 0x6c0
// Size: 0xb4
function function_92aa3641() {
    var_6b9bec1f = getaiarchetypearray("tiger");
    var_467b08cf = var_6b9bec1f.size;
    foreach (ai_tiger in var_6b9bec1f) {
        if (!isalive(ai_tiger)) {
            var_467b08cf--;
        }
    }
    return var_467b08cf;
}

// Namespace zombie_tiger_util/ai_tiger_util
// Params 0, eflags: 0x0
// Checksum 0xcb017260, Offset: 0x780
// Size: 0xb0
function function_500a498e() {
    switch (level.players.size) {
    case 1:
        n_default_wait = 1;
        break;
    case 2:
        n_default_wait = 0.75;
        break;
    case 3:
        n_default_wait = 0.5;
        break;
    default:
        n_default_wait = 0.25;
        break;
    }
    wait n_default_wait;
}

// Namespace zombie_tiger_util/ai_tiger_util
// Params 0, eflags: 0x0
// Checksum 0xc0154728, Offset: 0x838
// Size: 0x54
function function_50973412() {
    self endon(#"death");
    if (level flag::get("special_round")) {
        self ai::set_behavior_attribute("sprint", 1);
    }
}

// Namespace zombie_tiger_util/ai_tiger_util
// Params 1, eflags: 0x0
// Checksum 0x8009daa3, Offset: 0x898
// Size: 0x4a
function function_dfb12b47(var_e14d9cae) {
    var_13385fd5 = int(floor(var_e14d9cae / 25));
    return var_13385fd5;
}

// Namespace zombie_tiger_util/ai_tiger_util
// Params 0, eflags: 0x0
// Checksum 0x41acd0d5, Offset: 0x8f0
// Size: 0x3c
function round_spawn() {
    ai = spawn_single();
    if (isdefined(ai)) {
        level.zombie_total--;
        return true;
    }
    return false;
}

