#using scripts\core_common\callbacks_shared;
#using scripts\core_common\popups_shared;
#using scripts\core_common\system_shared;
#using scripts\mp_common\draft;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\util;

#namespace menus;

// Namespace menus/menus
// Params 0, eflags: 0x2
// Checksum 0x41778f52, Offset: 0x1d8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"menus", &__init__, undefined, undefined);
}

// Namespace menus/menus
// Params 0, eflags: 0x0
// Checksum 0xafc2c58c, Offset: 0x220
// Size: 0x64
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
    callback::on_menu_response(&on_menu_response);
}

// Namespace menus/menus
// Params 0, eflags: 0x0
// Checksum 0x9f119059, Offset: 0x290
// Size: 0x1d2
function init() {
    game.menu = [];
    game.menu[#"menu_start_menu"] = "StartMenu_Main";
    game.menu[#"menu_team"] = "ChangeTeam";
    game.menu[#"menu_class"] = "class";
    game.menu[#"menu_changeclass"] = "PositionDraft";
    game.menu[#"menu_changeclass_offline"] = "PositionDraft";
    foreach (str_team in level.teams) {
        game.menu["menu_changeclass_" + str_team] = "PositionDraft";
    }
    game.menu[#"menu_controls"] = "ingame_controls";
    game.menu[#"menu_options"] = "ingame_options";
    game.menu[#"menu_leavegame"] = "popup_leavegame";
}

// Namespace menus/menus
// Params 0, eflags: 0x0
// Checksum 0xebbb1ba6, Offset: 0x470
// Size: 0x3c
function on_player_connect() {
    self.menu_response_callbacks = [];
    self callback::function_1dea870d(#"menu_response", &on_menu_response);
}

// Namespace menus/menus
// Params 1, eflags: 0x0
// Checksum 0xe30cd44d, Offset: 0x4b8
// Size: 0x7f8
function on_menu_response(params) {
    menu = params.menu;
    response = params.response;
    intpayload = params.intpayload;
    if (isdefined(self.menu_response_callbacks[menu])) {
        self thread [[ self.menu_response_callbacks[menu] ]](response, intpayload);
    }
    if (response == "back") {
        self closeingamemenu();
        if (level.console) {
            if (menu == game.menu[#"menu_changeclass"] || menu == game.menu[#"menu_changeclass_offline"] || menu == game.menu[#"menu_team"] || menu == game.menu[#"menu_controls"]) {
                if (isdefined(level.teams[self.pers[#"team"]])) {
                    self openmenu(game.menu[#"menu_start_menu"]);
                }
            }
        }
        return;
    }
    if (menu == "changeteam" && level.allow_teamchange) {
        self closeingamemenu();
        self openmenu(game.menu[#"menu_team"]);
    }
    if (response == "endgame") {
        if (level.splitscreen) {
            level.skipvote = 1;
            if (!level.gameended) {
                level thread globallogic::forceend();
            }
        }
        return;
    }
    if (response == "killserverpc") {
        level thread globallogic::killserverpc();
        return;
    }
    if (response == "endround") {
        if (!level.gameended) {
            self globallogic::gamehistoryplayerquit();
            level thread globallogic::forceend();
            return;
        }
        if (!ispc()) {
            self closeingamemenu();
        }
        self iprintln(#"hash_6e4cedc56165f367");
        return;
    }
    if (response == "autocontrol") {
        self [[ level.autocontrolplayer ]]();
        return;
    }
    if (menu == game.menu[#"menu_team"] && level.allow_teamchange) {
        switch (response) {
        case #"autoassign":
            self [[ level.autoassign ]](1, undefined);
            break;
        case #"spectator":
            self [[ level.spectator ]]();
            break;
        default:
            self [[ level.teammenu ]](response);
            break;
        }
        return;
    }
    if (menu == game.menu[#"menu_changeclass"] || menu == game.menu[#"menu_changeclass_offline"]) {
        if (response == "changecharacter" || response == "randomcharacter" || response == "ready" || response == "opendraft" || response == "closedraft") {
            self [[ level.draftmenu ]](response, intpayload);
        } else if (response == "change_specialist") {
            self [[ level.specialistmenu ]](intpayload);
        } else if (response == "weapon_updated") {
            if (self.dead !== 1 && self.health != 0) {
                self iprintlnbold(game.strings[#"hash_b71875e85956ea"]);
            }
        } else if (response != "cancel") {
            if (response == "draft") {
                characterindex = intpayload;
                draft::select_character(characterindex, 0, 0);
                return;
            }
            self [[ level.curclass ]](response, undefined, 1);
        }
        return;
    }
    if (menu == "spectate") {
        player = util::getplayerfromclientnum(intpayload);
        if (isdefined(player)) {
            self setcurrentspectatorclient(player);
        }
        return;
    }
    if (menu == "sprays_and_gestures") {
        /#
            iprintlnbold("<dev string:x30>" + intpayload);
        #/
        return;
    }
    if (menu == "callout_items") {
        if (!isdefined(level.var_d6894ff1)) {
            level.var_d6894ff1 = getscriptbundlelist(#"callout_wheel");
        }
        var_f757aabf = intpayload % 100;
        var_1983216c = int(intpayload / 100) % 10;
        var_ec3534d2 = int(intpayload / 1000);
        callout = getscriptbundle(level.var_d6894ff1[var_f757aabf]);
        var_666fbe27 = callout.title;
        if (var_1983216c == 1) {
            var_666fbe27 = isdefined(callout.var_615ecef0) ? callout.var_615ecef0 : callout.var_f04ce1a9;
        } else if (var_1983216c == 2) {
            var_666fbe27 = callout.titleready;
        }
        if (isdefined(callout)) {
            team = self.pers[#"team"];
            popups::displayteammessagetoteam(var_666fbe27, self, team, var_ec3534d2, 1);
            if (isdefined(level.var_30f43eae)) {
                self [[ level.var_30f43eae ]](callout);
            }
        }
    }
}

// Namespace menus/menus
// Params 2, eflags: 0x0
// Checksum 0xdba61534, Offset: 0xcb8
// Size: 0x3e
function register_menu_response_callback(menu, callback) {
    if (!isdefined(self.menu_response_callbacks)) {
        self.menu_response_callbacks = [];
    }
    self.menu_response_callbacks[menu] = callback;
}

