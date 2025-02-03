#using scripts\core_common\system_shared;

#namespace activities;

// Namespace activities/activities_util
// Params 0, eflags: 0x6
// Checksum 0xbad50d6b, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"activities", &preinit, undefined, undefined, undefined);
}

// Namespace activities/activities_util
// Params 0, eflags: 0x4
// Checksum 0x8dda0a0d, Offset: 0xd0
// Size: 0x3a
function private preinit() {
    level.activities = {};
    level.activities.var_7e507488 = clientsysregister("a:obj");
}

// Namespace activities/activities_util
// Params 1, eflags: 0x0
// Checksum 0x76a0f810, Offset: 0x118
// Size: 0x22
function function_b73af3c(name) {
    level.activities.levelname = name;
}

// Namespace activities/activities_util
// Params 1, eflags: 0x0
// Checksum 0xd3818d61, Offset: 0x148
// Size: 0x10c
function function_59e67711(objective) {
    if (isdefined(level.activities.levelname)) {
        clientsyssetstate(level.activities.var_7e507488, "0," + objective + "," + level.gameskill + "," + level.var_1c5d2bf4 + "," + level.activities.levelname);
        level.activities.levelname = undefined;
        return;
    }
    clientsyssetstate(level.activities.var_7e507488, "1," + objective + "," + level.gameskill + "," + level.var_1c5d2bf4);
}

