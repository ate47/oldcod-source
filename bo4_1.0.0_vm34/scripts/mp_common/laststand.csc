#using script_330e1a53a92b38cc;
#using script_3b8f43c68572f06;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace laststand;

// Namespace laststand/laststand
// Params 0, eflags: 0x2
// Checksum 0x8d42a26f, Offset: 0x1b8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"laststand", &__init__, undefined, undefined);
}

// Namespace laststand/laststand
// Params 0, eflags: 0x0
// Checksum 0xae9002d5, Offset: 0x200
// Size: 0x16c
function __init__() {
    revive_hud::register("revive_hud");
    mp_revive_prompt::register("mp_revive_prompt_1");
    mp_revive_prompt::register("mp_revive_prompt_2");
    mp_revive_prompt::register("mp_revive_prompt_3");
    clientfield::register("clientuimodel", "hudItems.laststand.progress", 1, 5, "float", &laststand_postfx, 0, 0);
    clientfield::register("clientuimodel", "hudItems.laststand.beingRevived", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "EnemyTeamLastLivesData.numPlayersDowned", 1, 3, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "PlayerTeamLastLivesData.numPlayersDowned", 1, 3, "int", undefined, 0, 0);
    level thread wait_and_set_revive_shader_constant();
}

// Namespace laststand/laststand
// Params 7, eflags: 0x0
// Checksum 0x74d1343a, Offset: 0x378
// Size: 0x1cc
function laststand_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = function_f97e7787(localclientnum);
    if (newval) {
        if (!self postfx::function_7348f3a5("pstfx_drowning")) {
            self postfx::playpostfxbundle("pstfx_drowning");
            value = 0.99;
            self postfx::function_babe55b3("pstfx_drowning", #"outer radius", value);
            self postfx::function_babe55b3("pstfx_drowning", #"inner radius", value - 0.3);
            self postfx::function_babe55b3("pstfx_drowning", #"opacity", 1);
        }
        if (newval > 0.5) {
            if (oldval == 0) {
                oldval = newval;
                newval = oldval - 0.05;
            }
            player thread function_762df491(oldval, newval);
        }
        return;
    }
    if (self postfx::function_7348f3a5("pstfx_drowning")) {
        postfx::stoppostfxbundle("pstfx_drowning");
    }
}

// Namespace laststand/laststand
// Params 2, eflags: 0x0
// Checksum 0x85febb9a, Offset: 0x550
// Size: 0xe8
function function_762df491(oldval, newval) {
    self endon(#"death");
    duration = 1;
    while (duration > 0) {
        value = oldval - (oldval - newval) * (1 - duration);
        duration -= 0.1;
        self postfx::function_babe55b3("pstfx_drowning", #"outer radius", value);
        self postfx::function_babe55b3("pstfx_drowning", #"inner radius", value - 0.8);
        wait 0.1;
    }
}

// Namespace laststand/laststand
// Params 0, eflags: 0x0
// Checksum 0x6eb00f4f, Offset: 0x640
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

