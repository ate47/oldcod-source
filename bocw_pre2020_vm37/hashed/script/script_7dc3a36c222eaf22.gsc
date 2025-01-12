#using script_306215d6cfd5f1f4;
#using script_6167e26342be354b;
#using script_75da5547b1822294;
#using scripts\core_common\spectating;
#using scripts\core_common\system_shared;

#namespace namespace_8a203916;

// Namespace namespace_8a203916/namespace_8a203916
// Params 0, eflags: 0x6
// Checksum 0xd515c44c, Offset: 0xe0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_62a9656d2aaa46aa", &function_70a657d8, undefined, undefined, #"spectating");
}

// Namespace namespace_8a203916/ui_menuresponse
// Params 1, eflags: 0x40
// Checksum 0xbda70ea1, Offset: 0x130
// Size: 0x174
function event_handler[ui_menuresponse] codecallback_menuresponse(eventstruct) {
    var_53227942 = self;
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

// Namespace namespace_8a203916/namespace_8a203916
// Params 0, eflags: 0x5 linked
// Checksum 0xaee1d52d, Offset: 0x2b0
// Size: 0x9c
function private function_70a657d8() {
    level.var_5d013349 = currentsessionmode() != 4 && (isdefined(getgametypesetting(#"hash_2c55a3723cd9fdf9")) ? getgametypesetting(#"hash_2c55a3723cd9fdf9") : 0);
    if (level.var_5d013349) {
        level.var_18c9a2d1 = &function_363802ea;
    }
}

// Namespace namespace_8a203916/namespace_8a203916
// Params 1, eflags: 0x1 linked
// Checksum 0x80ffda18, Offset: 0x358
// Size: 0x24
function function_500047aa(view) {
    if (self.var_8a203916 === view) {
        return true;
    }
    return false;
}

// Namespace namespace_8a203916/namespace_8a203916
// Params 2, eflags: 0x1 linked
// Checksum 0xcd3cc94f, Offset: 0x388
// Size: 0x44
function function_363802ea(*players, *attacker) {
    self function_86df9236();
    self squad_spawn::function_e2ec8e07(1);
}

// Namespace namespace_8a203916/namespace_8a203916
// Params 0, eflags: 0x1 linked
// Checksum 0xc8337280, Offset: 0x3d8
// Size: 0x2c
function function_86df9236() {
    self.var_8a203916 = 1;
    self squad_spawn::function_a0bd2fd6(1);
}

// Namespace namespace_8a203916/namespace_8a203916
// Params 0, eflags: 0x1 linked
// Checksum 0x89de529a, Offset: 0x410
// Size: 0x24
function function_888901cb() {
    self.var_8a203916 = 0;
    self squad_spawn::function_a0bd2fd6(0);
}

