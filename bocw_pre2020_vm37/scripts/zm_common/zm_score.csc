#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_score;

// Namespace zm_score/zm_score
// Params 0, eflags: 0x6
// Checksum 0x20c7b4dd, Offset: 0x118
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_score", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_score/zm_score
// Params 0, eflags: 0x5 linked
// Checksum 0xe9a285d2, Offset: 0x160
// Size: 0x194
function private function_70a657d8() {
    level.var_697c8943 = array(90, 80, 70, 60, 50, 40, 30, 20, 10);
    foreach (subdivision in level.var_697c8943) {
        score_cf_register_info("damage" + subdivision, 1, 7);
    }
    score_cf_register_info("death_head", 1, 3, undefined);
    score_cf_register_info("death_melee", 1, 3, undefined);
    score_cf_register_info("transform_kill", 1, 3, undefined);
    clientfield::register_clientuimodel("hudItems.doublePointsActive", #"hash_6f4b11a0bee9b73d", #"doublepointsactive", 1, 1, "int", undefined, 0, 0);
}

// Namespace zm_score/zm_score
// Params 4, eflags: 0x1 linked
// Checksum 0xe1ed7177, Offset: 0x300
// Size: 0xfc
function score_cf_register_info(name, version, max_count, func_callback) {
    for (i = 0; i < 5; i++) {
        clientfield::function_5b7d846d("PlayerList.client" + i + ".score_cf_" + name, #"hash_97df1852304b867", [hash(isdefined(i) ? "" + i : ""), #"score_cf_" + name], version, getminbitcountfornum(max_count), "counter", func_callback, 0, 0);
    }
}

