#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreak_vehicle;
#using scripts\killstreaks\killstreaks_shared;

#namespace killstreaks;

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x6
// Checksum 0x8118fec7, Offset: 0xd8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"killstreaks", &preinit, undefined, undefined, #"renderoverridebundle");
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x4
// Checksum 0xf496a726, Offset: 0x128
// Size: 0x44
function private preinit() {
    init_shared();
    killstreak_vehicle::init();
    killstreak_detect::init_shared();
    function_f1707039();
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x4
// Checksum 0xdbfbe740, Offset: 0x178
// Size: 0x2b4
function private function_f1707039() {
    level.var_4b42d599 = [];
    for (i = 0; i < 4; i++) {
        level.var_4b42d599[i] = "killstreaks.killstreak" + i + ".inUse";
        clientfield::register_clientuimodel(level.var_4b42d599[i], #"killstreak_rewards", [#"killstreak" + (isdefined(i) ? "" + i : ""), #"inuse"], 1, 1, "int", undefined, 0, 0);
    }
    level.var_46b33f90 = [];
    level.var_ce69c3cb = [];
    level.var_a0d81b28 = max(8, 4);
    for (i = 0; i < level.var_a0d81b28; i++) {
        level.var_46b33f90[i] = "killstreaks.killstreak" + i + ".spaceFull";
        clientfield::register_clientuimodel(level.var_46b33f90[i], #"killstreak_rewards", [#"killstreak" + (isdefined(i) ? "" + i : ""), #"hash_3bbe3fe57a438e3c"], 1, 1, "int", undefined, 0, 0);
        level.var_ce69c3cb[i] = "killstreaks.killstreak" + i + ".noTargets";
        clientfield::register_clientuimodel(level.var_ce69c3cb[i], #"killstreak_rewards", [#"killstreak" + (isdefined(i) ? "" + i : ""), #"hash_361ce27ba0208918"], 1, 1, "int", undefined, 0, 0);
    }
}

