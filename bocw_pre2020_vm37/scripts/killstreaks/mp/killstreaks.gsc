#using script_20b49c655167d21c;
#using script_4721de209091b1a6;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreak_vehicle;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\mp\killstreak_weapons;
#using scripts\killstreaks\mp\killstreakrules;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\player\player_utils;

#namespace killstreaks;

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x6
// Checksum 0x5a217e9a, Offset: 0x170
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"killstreaks", &function_70a657d8, undefined, undefined, #"weapons");
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x5 linked
// Checksum 0x62d6e1b8, Offset: 0x1c0
// Size: 0xbc
function private function_70a657d8() {
    init_shared();
    killstreakrules::init();
    killstreak_detect::init_shared();
    callback::on_start_gametype(&init);
    callback::add_callback(#"menu_response", &on_menu_response);
    player::function_cf3aa03d(&killstreak_weapons::onplayerkilled);
    level.var_1492d026 = &namespace_f9b02f80::play_killstreak_start_dialog;
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x1 linked
// Checksum 0x918314f, Offset: 0x288
// Size: 0x15c
function init() {
    /#
        level.killstreak_init_start_time = getmillisecondsraw();
        thread debug_ricochet_protection();
    #/
    function_447e6858();
    level.var_b0dc03c7 = &function_395f82d0;
    level.var_19a15e42 = &function_daabc818;
    namespace_f9b02f80::init();
    callback::callback(#"hash_45f35669076bc317");
    function_f1707039();
    level thread function_d3106952();
    function_1f7e617a();
    /#
        level.killstreak_init_end_time = getmillisecondsraw();
        elapsed_time = level.killstreak_init_end_time - level.killstreak_init_start_time;
        println("<dev string:x38>" + elapsed_time + "<dev string:x59>");
        level thread killstreak_debug_think();
    #/
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x5 linked
// Checksum 0xff1acdd0, Offset: 0x3f0
// Size: 0x134
function private function_f1707039() {
    level.var_4b42d599 = [];
    for (i = 0; i < 4; i++) {
        level.var_4b42d599[i] = "killstreaks.killstreak" + i + ".inUse";
        clientfield::register_clientuimodel(level.var_4b42d599[i], 1, 1, "int");
    }
    level.var_46b33f90[i] = [];
    level.var_173b8ed7 = max(8, 4);
    for (i = 0; i < level.var_173b8ed7; i++) {
        level.var_46b33f90[i] = "killstreaks.killstreak" + i + ".spaceFull";
        clientfield::register_clientuimodel(level.var_46b33f90[i], 1, 1, "int");
    }
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x5 linked
// Checksum 0x8a0ef14a, Offset: 0x530
// Size: 0x58
function private function_1f7e617a() {
    level.var_b84cb28e = [];
    level.var_b84cb28e[0] = 2;
    level.var_b84cb28e[3] = 0;
    level.var_b84cb28e[1] = 1;
    level.var_b84cb28e[-1] = 3;
}

// Namespace killstreaks/killstreaks
// Params 1, eflags: 0x5 linked
// Checksum 0xea5ebd8a, Offset: 0x590
// Size: 0x324
function private on_menu_response(eventstruct) {
    if (self function_8cc6b278()) {
        return;
    }
    if (eventstruct.response === "scorestreak_pool_purchase" && level.var_5b544215 === 1) {
        var_5b220756 = level.var_b84cb28e[eventstruct.intpayload];
        if (isdefined(var_5b220756)) {
            if (var_5b220756 == 3) {
                if (isdefined(self.pers[#"killstreaks"])) {
                    var_2a5574a6 = self.pers[#"killstreaks"].size - 1;
                    if (var_2a5574a6 >= 0) {
                        killstreakweapon = get_killstreak_weapon(self.pers[#"killstreaks"][var_2a5574a6]);
                        self switchtoweapon(killstreakweapon);
                    }
                }
            } else {
                purchased = globallogic_score::function_13123cee(self, var_5b220756);
                if (purchased) {
                    killstreaktype = get_by_menu_name(self.killstreak[var_5b220756]);
                    killstreakweapon = get_killstreak_weapon(killstreaktype);
                    self switchtoweapon(killstreakweapon);
                }
            }
        }
        return;
    }
    if (eventstruct.response === "scorestreak_pool_purchase_and_use" && level.var_5b544215 === 1) {
        eventstruct = eventstruct;
        var_180d3406 = getscriptbundlelist(level.var_d1455682.var_a45c9c63);
        var_b133a8aa = getscriptbundle(var_180d3406[eventstruct.intpayload]);
        killstreakbundle = getscriptbundle(var_b133a8aa.killstreakbundle);
        if (isdefined(killstreakbundle)) {
            unlockableindex = getitemindexfromref(var_b133a8aa.unlockableitem);
            iteminfo = getunlockableiteminfofromindex(unlockableindex, 0);
            purchased = globallogic_score::function_8b375624(self, killstreakbundle.var_d3413870, iteminfo.momentum);
            if (purchased) {
                self give(killstreakbundle.var_d3413870);
                self switchtoweapon(killstreakbundle.ksweapon);
            }
        }
    }
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x1 linked
// Checksum 0xda2634d5, Offset: 0x8c0
// Size: 0x18
function function_3b4959c6() {
    return isdefined(level.var_d1455682.var_a45c9c63);
}

// Namespace killstreaks/killstreaks
// Params 1, eflags: 0x5 linked
// Checksum 0x62b95503, Offset: 0x8e0
// Size: 0x4c
function private function_395f82d0(killstreaktype) {
    globallogic_score::_setplayermomentum(self, self.momentum - self function_dceb5542(level.killstreaks[killstreaktype].itemindex));
}

// Namespace killstreaks/killstreaks
// Params 4, eflags: 0x5 linked
// Checksum 0x623ccd4b, Offset: 0x938
// Size: 0x44
function private function_daabc818(event, player, victim, weapon) {
    scoreevents::processscoreevent(event, player, victim, weapon);
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x5 linked
// Checksum 0xbf296f6e, Offset: 0x988
// Size: 0x336
function private function_d3106952() {
    self notify("677346d280aca4b0");
    self endon("677346d280aca4b0");
    if (function_3b4959c6()) {
        return;
    }
    wait 5;
    var_7d46072 = 1;
    var_e9414fa = 0;
    start_time = util::get_start_time();
    while (!level.gameended) {
        players = getplayers();
        if (players.size == 0) {
            wait 1;
            continue;
        }
        foreach (player in players) {
            if (!isdefined(player)) {
                continue;
            }
            if (!isdefined(player.killstreak)) {
                continue;
            }
            var_6370491b = getarraykeys(player.killstreak);
            foreach (key in var_6370491b) {
                if (!isdefined(key)) {
                    continue;
                }
                var_63fd3e67 = player killstreakrules::iskillstreakallowed(player.killstreak[key], player.team, 1);
                player clientfield::set_player_uimodel(level.var_46b33f90[key], !var_63fd3e67);
            }
            if (isdefined(player.pers[#"killstreaks"]) && player.pers[#"killstreaks"].size > 0) {
                var_8c992ad8 = player.pers[#"killstreaks"][player.pers[#"killstreaks"].size - 1];
                var_63fd3e67 = player killstreakrules::iskillstreakallowed(var_8c992ad8, player.team, 1);
                player clientfield::set_player_uimodel(level.var_46b33f90[3], !var_63fd3e67);
            }
            var_e9414fa++;
            if (var_e9414fa >= var_7d46072) {
                waitframe(1);
                var_e9414fa = 0;
            }
        }
    }
}

