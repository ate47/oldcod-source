#using scripts\core_common\system_shared;
#using scripts\weapons\hacker_tool;
#using scripts\weapons\tacticalinsertion;

#namespace tacticalinsertion;

// Namespace tacticalinsertion/tacticalinsertion
// Params 0, eflags: 0x2
// Checksum 0xee8e49dc, Offset: 0x80
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"tacticalinsertion", &__init__, undefined, undefined);
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 0, eflags: 0x0
// Checksum 0x50246e0a, Offset: 0xc8
// Size: 0x2e
function __init__() {
    init_shared();
    level.var_78c70625 = &function_2fdba83f;
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 0, eflags: 0x0
// Checksum 0x5730fd57, Offset: 0x100
// Size: 0x2c
function function_2fdba83f() {
    self hacker_tool::registerwithhackertool(level.equipmenthackertoolradius, level.equipmenthackertooltimems);
}

