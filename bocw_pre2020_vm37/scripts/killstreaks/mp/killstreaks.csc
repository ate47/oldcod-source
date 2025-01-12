#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreak_vehicle;
#using scripts\killstreaks\killstreaks_shared;

#namespace killstreaks;

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x6
// Checksum 0x13bba23d, Offset: 0xc8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"killstreaks", &function_70a657d8, undefined, undefined, #"renderoverridebundle");
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x5 linked
// Checksum 0xf80bfa95, Offset: 0x118
// Size: 0x44
function private function_70a657d8() {
    init_shared();
    killstreak_vehicle::init();
    killstreak_detect::init_shared();
    function_f1707039();
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x5 linked
// Checksum 0xea0198d8, Offset: 0x168
// Size: 0x1f4
function private function_f1707039() {
    level.var_4b42d599 = [];
    for (i = 0; i < 4; i++) {
        level.var_4b42d599[i] = "killstreaks.killstreak" + i + ".inUse";
        clientfield::register_clientuimodel(level.var_4b42d599[i], #"hash_38b7a28901866ae4", [#"killstreak" + (isdefined(i) ? "" + i : ""), #"inuse"], 1, 1, "int", undefined, 0, 0);
    }
    level.var_46b33f90[i] = [];
    level.var_173b8ed7 = max(8, 4);
    for (i = 0; i < level.var_173b8ed7; i++) {
        level.var_46b33f90[i] = "killstreaks.killstreak" + i + ".spaceFull";
        clientfield::register_clientuimodel(level.var_46b33f90[i], #"hash_38b7a28901866ae4", [#"killstreak" + (isdefined(i) ? "" + i : ""), #"hash_3bbe3fe57a438e3c"], 1, 1, "int", undefined, 0, 0);
    }
}

