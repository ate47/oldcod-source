#using script_50dc2248b1a1cde;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_towers_challenges;

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 0, eflags: 0x2
// Checksum 0x530d581a, Offset: 0xa8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_towers_challenges", &__init__, &__main__, undefined);
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 0, eflags: 0x0
// Checksum 0xc8828ef2, Offset: 0xf8
// Size: 0x26
function __init__() {
    level.var_99983d5 = zm_towers_challenges_hud::register("zm_towers_challenges");
}

// Namespace zm_towers_challenges/zm_towers_challenges
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x128
// Size: 0x4
function __main__() {
    
}

