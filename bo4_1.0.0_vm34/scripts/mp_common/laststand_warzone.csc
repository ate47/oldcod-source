#using script_3b8f43c68572f06;
#using script_5ed83e40423c3935;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace laststand_warzone;

// Namespace laststand_warzone/laststand_warzone
// Params 0, eflags: 0x2
// Checksum 0xd5c591a8, Offset: 0x1a0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"laststand", &__init__, undefined, undefined);
}

// Namespace laststand_warzone/laststand_warzone
// Params 0, eflags: 0x0
// Checksum 0x72cc5bf3, Offset: 0x1e8
// Size: 0x194
function __init__() {
    if (!sessionmodeiswarzonegame()) {
        return;
    }
    setdvar(#"hash_211a0d7f1fd46cfa", 0);
    revive_hud::register("revive_hud");
    wz_revive_prompt::register("wz_revive_prompt_1");
    wz_revive_prompt::register("wz_revive_prompt_2");
    wz_revive_prompt::register("wz_revive_prompt_3");
    clientfield::register("clientuimodel", "hudItems.laststand.progress", 1, 5, "float", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.laststand.beingRevived", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.laststand.revivingClientNum", 1, 6, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.laststand.reviveProgress", 1, 5, "float", undefined, 0, 0);
    level thread wait_and_set_revive_shader_constant();
}

// Namespace laststand_warzone/laststand_warzone
// Params 0, eflags: 0x0
// Checksum 0x72892658, Offset: 0x388
// Size: 0xc8
function wait_and_set_revive_shader_constant() {
    while (true) {
        waitresult = level waittill(#"notetrack");
        localclientnum = waitresult.localclientnum;
        if (waitresult.notetrack == "revive_shader_constant") {
            player = function_f97e7787(localclientnum);
            player mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 0, getservertime(localclientnum) / 1000);
        }
    }
}

