#using script_1cc417743d7c262d;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\gametypes\globallogic_utils;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_utility;

#namespace globallogic_audio;

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x6
// Checksum 0x2be643cf, Offset: 0x110
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_40da084132aa904b", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x5 linked
// Checksum 0x92401027, Offset: 0x158
// Size: 0x7c
function private function_70a657d8() {
    if (zm_utility::is_survival()) {
        level.var_bc01f047 = "srtaacom";
        level.var_7ee6af9f = "srcommander";
    } else {
        level.var_bc01f047 = "zmtaacom";
        level.var_7ee6af9f = "zmcommander";
    }
    callback::on_connect(&on_player_connect);
}

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xad51cc45, Offset: 0x1e0
// Size: 0xdc
function on_player_connect() {
    if (isdefined(level.var_462ca9bb)) {
        self.pers[level.var_bc01f047] = level.var_462ca9bb;
    } else {
        self.pers[level.var_bc01f047] = level.var_bc01f047 === "srtaacom" ? "sr_taacom" : "zm_taacom";
    }
    if (isdefined(level.var_e2f95698)) {
        self.pers[level.var_7ee6af9f] = level.var_e2f95698;
        return;
    }
    self.pers[level.var_7ee6af9f] = level.var_7ee6af9f === "srcommander" ? "sr_commander" : "zm_commander";
}

