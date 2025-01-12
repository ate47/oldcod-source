#using script_13ba67412d79c7f;
#using script_151cd5772fe546db;
#using script_2f226180773b89b9;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\zm_common\zm_powerups;

#namespace zstandard;

// Namespace zstandard/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x8a850862, Offset: 0x1b8
// Size: 0x29c
function event_handler[gametype_init] main(eventstruct) {
    createuimodel(getglobaluimodel(), "ZMHudGlobal.trials.gameStartTime");
    callback::on_localclient_connect(&on_localplayer_connect);
    callback::on_finalize_initialization(&finalize_clientfields);
    level.var_49197edc = zm_arcade_timer::register("zm_arcade_timer");
    level.var_bb57ff69 = zm_trial_timer::register("zm_trial_timer");
    level.var_6be65be5 = self_revive_visuals_rush::register("self_revive_visuals_rush");
    level._zombie_gamemodeprecache = &onprecachegametype;
    level._zombie_gamemodemain = &onstartgametype;
    for (i = 0; i < 4; i++) {
        clientfield::register("worlduimodel", "PlayerList.client" + i + ".playerIsDowned", 1, 1, "int", undefined, 0, 0);
        clientfield::register("worlduimodel", "PlayerList.client" + i + ".multiplier_count", 1, 8, "int", undefined, 0, 0);
        clientfield::register("worlduimodel", "PlayerList.client" + i + ".multiplier_blink", 1, 1, "int", undefined, 0, 0);
        clientfield::register("worlduimodel", "PlayerList.client" + i + ".self_revives", 1, 8, "int", undefined, 0, 0);
    }
    zm_powerups::include_zombie_powerup("pack_a_punch");
    zm_powerups::add_zombie_powerup("pack_a_punch", "powerup_pack_a_punch");
    zm_powerups::include_zombie_powerup("extra_lives");
    zm_powerups::add_zombie_powerup("extra_lives");
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x4
// Checksum 0x2d224544, Offset: 0x460
// Size: 0x9c
function private finalize_clientfields(localclientnum) {
    clientfield::register("toplayer", "zm_trials_timer", 1, getminbitcountfornum(300), "int", &function_8b303904, 0, 1);
    clientfield::register("worlduimodel", "ZMHudGlobal.trials.gameStartTime", 1, 31, "int", undefined, 0, 0);
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x508
// Size: 0x4
function onprecachegametype() {
    
}

// Namespace zstandard/zstandard
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x518
// Size: 0x4
function onstartgametype() {
    
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x4
// Checksum 0x120545f, Offset: 0x528
// Size: 0x44
function private on_localplayer_connect(localclientnum) {
    timer_model = function_c6d62a53(localclientnum);
    setuimodelvalue(timer_model, 0);
}

// Namespace zstandard/zstandard
// Params 1, eflags: 0x4
// Checksum 0xb97aa552, Offset: 0x578
// Size: 0x4a
function private function_c6d62a53(localclientnum) {
    controller_model = getuimodelforcontroller(localclientnum);
    return createuimodel(controller_model, "ZMHud.trialsTimer");
}

// Namespace zstandard/zstandard
// Params 7, eflags: 0x4
// Checksum 0x2f18e12e, Offset: 0x5d0
// Size: 0xc4
function private function_8b303904(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!function_9a47ed7f(localclientnum)) {
        timer_model = function_c6d62a53(localclientnum);
        duration_msec = newval * 1000;
        setuimodelvalue(timer_model, getservertime(localclientnum, 1) + duration_msec);
    }
}

