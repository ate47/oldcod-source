#using script_61828ad9e71c6616;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;

#namespace killstreaks;

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x6
// Checksum 0xa830996b, Offset: 0x138
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"killstreaks", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x5 linked
// Checksum 0xd2a5957a, Offset: 0x180
// Size: 0x84
function private function_70a657d8() {
    init_shared();
    killstreak_detect::init_shared();
    killstreakrules::init();
    callback::on_start_gametype(&init);
    callback::add_callback(#"menu_response", &on_menu_response);
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x1 linked
// Checksum 0x14e05bec, Offset: 0x210
// Size: 0x14c
function init() {
    /#
        level.killstreak_init_start_time = getmillisecondsraw();
        thread debug_ricochet_protection();
    #/
    function_447e6858();
    level.var_b0dc03c7 = &function_395f82d0;
    level.var_19a15e42 = &function_daabc818;
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
// Checksum 0x75e6d766, Offset: 0x368
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
// Checksum 0xb26c7ae, Offset: 0x4a8
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
// Checksum 0xb80ab5f, Offset: 0x508
// Size: 0x2dc
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
            } else if (true) {
                killstreaktype = get_by_menu_name(self.killstreak[var_5b220756]);
                killstreakweapon = get_killstreak_weapon(killstreaktype);
                self switchtoweapon(killstreakweapon);
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
            if (true) {
                self give(killstreakbundle.var_d3413870);
                self switchtoweapon(killstreakbundle.ksweapon);
            }
        }
    }
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x1 linked
// Checksum 0x50860be4, Offset: 0x7f0
// Size: 0x18
function function_3b4959c6() {
    return isdefined(level.var_d1455682.var_a45c9c63);
}

// Namespace killstreaks/killstreaks
// Params 1, eflags: 0x5 linked
// Checksum 0x5fa86748, Offset: 0x810
// Size: 0xc
function private function_395f82d0(*killstreaktype) {
    
}

// Namespace killstreaks/killstreaks
// Params 4, eflags: 0x5 linked
// Checksum 0xe4308b84, Offset: 0x828
// Size: 0x24
function private function_daabc818(*event, *player, *victim, *weapon) {
    
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x5 linked
// Checksum 0x6b26d43, Offset: 0x858
// Size: 0x33c
function private function_d3106952() {
    self notify("7d150a3ade455ed4");
    self endon("7d150a3ade455ed4");
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
        waitframe(1);
    }
}

