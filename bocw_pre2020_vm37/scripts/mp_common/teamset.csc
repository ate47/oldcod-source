#using scripts\core_common\system_shared;

#namespace teamset;

// Namespace teamset/teamset
// Params 0, eflags: 0x6
// Checksum 0x36a300dd, Offset: 0x68
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"teamset_seals", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace teamset/teamset
// Params 0, eflags: 0x5 linked
// Checksum 0x41266028, Offset: 0xb0
// Size: 0x34
function private function_70a657d8() {
    level.allies_team = #"allies";
    level.axis_team = #"axis";
}

