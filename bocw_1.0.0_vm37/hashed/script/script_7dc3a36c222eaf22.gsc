#using script_306215d6cfd5f1f4;
#using script_6167e26342be354b;
#using scripts\core_common\spectating;
#using scripts\core_common\system_shared;
#using scripts\core_common\territory_util;

#namespace spectate_view;

// Namespace spectate_view/spectate_view
// Params 0, eflags: 0x6
// Checksum 0x97977535, Offset: 0xe0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"spectate_view", &preinit, undefined, undefined, #"spectating");
}

// Namespace spectate_view/ui_menuresponse
// Params 1, eflags: 0x40
// Checksum 0x6de0746, Offset: 0x130
// Size: 0x174
function event_handler[ui_menuresponse] codecallback_menuresponse(eventstruct) {
    spawningplayer = self;
    menu = eventstruct.menu;
    response = eventstruct.response;
    targetclientnum = eventstruct.intpayload;
    if (!isdefined(menu)) {
        menu = "";
    }
    if (!isdefined(response)) {
        response = "";
    }
    if (!isdefined(targetclientnum)) {
        targetclientnum = 0;
    }
    if (menu == "Hud_NavigableUI") {
        if (self.sessionstate === "playing") {
            return;
        }
        if (response == "set_spawn_view_overhead" && !level.var_1c15a724) {
            self function_86df9236();
            return;
        }
        if (response == "set_spawn_view_squad" && level.var_1ba484ad == 2 && !level.var_1c15a724) {
            self function_86df9236();
            return;
        }
        if (response == "set_spawn_view_squad" && !level.var_8bace951) {
            self function_888901cb();
        }
    }
}

// Namespace spectate_view/spectate_view
// Params 0, eflags: 0x4
// Checksum 0x7f882b36, Offset: 0x2b0
// Size: 0x9c
function private preinit() {
    level.var_5d013349 = currentsessionmode() != 4 && (isdefined(getgametypesetting(#"hash_2c55a3723cd9fdf9")) ? getgametypesetting(#"hash_2c55a3723cd9fdf9") : 0);
    if (level.var_5d013349) {
        level.var_18c9a2d1 = &function_363802ea;
    }
}

// Namespace spectate_view/spectate_view
// Params 1, eflags: 0x0
// Checksum 0x55fe5782, Offset: 0x358
// Size: 0x24
function function_500047aa(view) {
    if (self.spectate_view === view) {
        return true;
    }
    return false;
}

// Namespace spectate_view/spectate_view
// Params 2, eflags: 0x0
// Checksum 0x916054de, Offset: 0x388
// Size: 0x44
function function_363802ea(*players, *attacker) {
    self function_86df9236();
    self squad_spawn::function_e2ec8e07(1);
}

// Namespace spectate_view/spectate_view
// Params 0, eflags: 0x0
// Checksum 0x45e66edd, Offset: 0x3d8
// Size: 0x2c
function function_86df9236() {
    self.spectate_view = 1;
    self squad_spawn::function_a0bd2fd6(1);
}

// Namespace spectate_view/spectate_view
// Params 0, eflags: 0x0
// Checksum 0x4937e987, Offset: 0x410
// Size: 0x24
function function_888901cb() {
    self.spectate_view = 0;
    self squad_spawn::function_a0bd2fd6(0);
}

