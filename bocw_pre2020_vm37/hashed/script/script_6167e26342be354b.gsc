#using script_44b0b8420eabacad;
#using script_5ee699b0aaf564c4;
#using script_75da5547b1822294;
#using script_7dc3a36c222eaf22;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\match_record;
#using scripts\core_common\math_shared;
#using scripts\core_common\oob;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;

#namespace squad_spawn;

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x6
// Checksum 0x46a58ba8, Offset: 0x448
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_4ceb0867dc2d780f", &init, undefined, undefined, undefined);
}

// Namespace squad_spawn/ui_menuresponse
// Params 1, eflags: 0x40
// Checksum 0x33bc9b50, Offset: 0x490
// Size: 0x1ce
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
        if (response == "spectatePlayer") {
            var_26c5324a = getentbynum(targetclientnum);
            self.var_a271f211 = targetclientnum;
            if (isalive(var_26c5324a)) {
                var_53227942 spectating::function_26c5324a(var_26c5324a);
            }
            return;
        }
        if (response == "spawnOnPlayer") {
            var_53227942.var_f7900902 = 0;
            var_53227942.var_d50e861c = "spawnOnPlayer";
            var_53227942.var_d690fc0b = getentbynum(targetclientnum);
            return;
        }
        if (response == "spawnOnObjective") {
            var_53227942.var_f7900902 = 0;
            var_53227942.var_d50e861c = "spawnOnObjective";
            var_53227942.var_612ad92b = targetclientnum;
            return;
        }
        if (response == "autoSpawn") {
            var_53227942.var_f7900902 = 0;
            var_53227942.var_d50e861c = "autoSpawn";
        }
    }
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x1 linked
// Checksum 0x910a077e, Offset: 0x668
// Size: 0x5b4
function init() {
    if (!function_d072f205()) {
        return;
    }
    match_record::set_stat(#"hash_405bc5b0e581dd5e", 1);
    level.var_d2f7a339 = getgametypesetting(#"hash_361f7fe066281093");
    level.var_1c15a724 = getgametypesetting(#"hash_4dd37bf6da89131");
    level.var_8bace951 = getgametypesetting(#"hash_655d904d5995891f");
    if (!isdefined(level.var_f0257219)) {
        level.var_f0257219 = 0;
    }
    if (!isdefined(level.var_97b04ad0)) {
        level.var_97b04ad0 = (-4, -4, -4);
    }
    if (!isdefined(level.var_1dc6484c)) {
        level.var_1dc6484c = (4, 4, 4);
    }
    if (!isdefined(level.var_64a19c03)) {
        level.var_64a19c03 = 4;
    }
    if (!isdefined(level.var_4f091b08)) {
        level.var_4f091b08 = (-4, -4, -4);
    }
    if (!isdefined(level.var_7d121ad7)) {
        level.var_7d121ad7 = (4, 4, 4);
    }
    if (!isdefined(level.var_10f21cf8)) {
        level.var_10f21cf8 = [];
    }
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    callback::on_player_killed(&on_player_killed);
    scoreevents::registerscoreeventcallback("playerKilled", &scoreeventplayerkill);
    setdvar(#"hash_301150d9ff502ccc", 0);
    setdvar(#"hash_3b0f87edc15cba8b", 1);
    level.onspawnplayer = &on_spawn_player;
    /#
        thread function_134fed80();
        setdvar(#"hash_15f42bd141a09b05", 0);
        setdvar(#"hash_1baf26ac31b0f2d2", 800);
    #/
    if (function_d072f205()) {
        level thread function_bae8dea9();
    }
    if (isdefined(level.var_d1455682.squadspawnsettings)) {
        var_393bca70 = getscriptbundle(level.var_d1455682.squadspawnsettings);
    }
    setdvar(#"hash_4de24bfd1d2e60e2", getsetting("maxEnemyInfluence", 0, var_393bca70));
    setdvar(#"hash_3950aff61b5eb579", getsetting("maxFriendlyInfluence", 0, var_393bca70));
    setdvar(#"hash_448da75ac3058f88", getsetting("maxTargetPlayerInfluence", 0, var_393bca70));
    setdvar(#"hash_64315367e45f68ed", getsetting("minDistanceFromEnemyPlayer", 0, var_393bca70));
    setdvar(#"hash_4c4f79641bd0a4a8", getsetting("maxPlayerInfluencerDistance", 0, var_393bca70));
    setdvar(#"hash_11e4c0fa5ecb0ca8", getsetting("minDistanceFromTargetPlayer", 0, var_393bca70));
    setdvar(#"hash_b5fdc515c12876e", getsetting("maxDistanceFromTargetPlayer", 0, var_393bca70));
    var_8f11cf88 = getsetting("minDistanceFromEnemyPlayer", 0, var_393bca70);
    level.var_9b9900e6 = var_8f11cf88 * var_8f11cf88;
    var_a73479b4 = getsetting("maxPlayerInfluencerDistance", 0, var_393bca70);
    level.var_d6cbe602 = var_a73479b4 * var_a73479b4;
    function_ba7bef31();
    setupclientfields();
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 3, eflags: 0x1 linked
// Checksum 0x28ac5723, Offset: 0xc28
// Size: 0xa4
function getsetting(fieldname, defaultvalue, var_393bca70) {
    if (!isdefined(var_393bca70) && !isdefined(level.var_d1455682.squadspawnsettings)) {
        return defaultvalue;
    }
    if (!isdefined(var_393bca70)) {
        var_393bca70 = getscriptbundle(level.var_d1455682.squadspawnsettings);
    }
    if (isdefined(var_393bca70) && isdefined(var_393bca70.(fieldname))) {
        return var_393bca70.(fieldname);
    }
    return defaultvalue;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x5 linked
// Checksum 0xb2ad5a22, Offset: 0xcd8
// Size: 0xf4
function private setupclientfields() {
    clientfield::register_clientuimodel("hudItems.squadSpawnOnStatus", 1, 3, "int");
    clientfield::register_clientuimodel("hudItems.squadSpawnActive", 1, 1, "int");
    clientfield::register_clientuimodel("hudItems.squadSpawnRespawnStatus", 1, 2, "int");
    clientfield::register_clientuimodel("hudItems.squadSpawnViewType", 1, 1, "int");
    clientfield::register_clientuimodel("hudItems.squadAutoSpawnPromptActive", 1, 1, "int");
    clientfield::register_clientuimodel("hudItems.squadSpawnSquadWipe", 1, 1, "int");
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x5 linked
// Checksum 0x4bc0792, Offset: 0xdd8
// Size: 0x28c
function private function_ba7bef31() {
    level.var_e5939f31 = [];
    level.var_e5939f31[level.var_e5939f31.size] = {#angle:20, #distance:100};
    level.var_e5939f31[level.var_e5939f31.size] = {#angle:-20, #distance:100};
    level.var_e5939f31[level.var_e5939f31.size] = {#angle:55, #distance:100};
    level.var_e5939f31[level.var_e5939f31.size] = {#angle:-55, #distance:100};
    level.var_e5939f31[level.var_e5939f31.size] = {#angle:85, #distance:100};
    level.var_e5939f31[level.var_e5939f31.size] = {#angle:-85, #distance:100};
    level.var_e5939f31[level.var_e5939f31.size] = {#angle:110, #distance:100};
    level.var_e5939f31[level.var_e5939f31.size] = {#angle:250, #distance:100};
    level.var_e5939f31[level.var_e5939f31.size] = {#angle:160, #distance:100};
    level.var_e5939f31[level.var_e5939f31.size] = {#angle:200, #distance:100};
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x1 linked
// Checksum 0x203cad6b, Offset: 0x1070
// Size: 0x272
function function_941bd62f() {
    /#
        if (isdefined(self.devguilockspawn) && self.devguilockspawn) {
            return {#origin:self.resurrect_origin, #angles:self.resurrect_angles};
        }
    #/
    if (!isdefined(self.var_d50e861c)) {
    } else if (self.var_d50e861c === "spawnOnPlayer") {
        spawn = function_154cf7ca(self);
    } else if (self.var_d50e861c === "spawnOnObjective") {
        spawn = getspawnpoint(self);
    } else if (self.var_d50e861c === "autoSpawn" && !getgametypesetting(#"hash_1e71b5ce1cd845b3")) {
        function_279d5c68(self.team, 0);
        spawn = getspawnpoint(self);
    } else if (getgametypesetting(#"hash_5d65f5abcdad24fe") && self.var_f7900902 < gettime()) {
        if (self.var_d50e861c === "spawnOnObjective" || !function_154cf7ca(self)) {
            spawn = getspawnpoint(self);
        }
    } else if (isdefined(level.var_b8da6142) && [[ level.var_b8da6142 ]](self)) {
        if (!function_154cf7ca(self)) {
            spawn = getspawnpoint(self);
        }
    } else {
        var_58d1e914 = function_c65231e2(self.squad);
        if (var_58d1e914.size <= 1) {
            spawn = getspawnpoint(self);
        }
    }
    return spawn;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0x824b32e8, Offset: 0x12f0
// Size: 0x27e
function on_spawn_player(predictedspawn = 0) {
    spawn = self function_941bd62f();
    if (!isdefined(spawn) || !isdefined(spawn.origin)) {
        spawn = spawning::function_89116a1e(predictedspawn);
    }
    self.var_f7900902 = undefined;
    if (predictedspawn) {
        self spawning::function_e1a7c3d9(spawn.origin, spawn.angles);
    } else {
        self.lastspawntime = gettime();
        if (isdefined(self.var_d50e861c) && self.var_d50e861c == "autoSpawn" && getgametypesetting(#"hash_1e71b5ce1cd845b3")) {
            self.var_e0f25826 = 1;
            self namespace_aaddef5a::function_96d350e9(spawn);
        } else if (is_true(self.var_20250438) && getgametypesetting(#"hash_1e71b5ce1cd845b3")) {
            self.var_e0f25826 = 1;
            self namespace_aaddef5a::function_96d350e9(spawn);
        } else {
            self spawn(spawn.origin, spawn.angles);
            influencers::create_player_spawn_influencers(spawn.origin);
            if (function_61e7d9a8(self)) {
                spawninvehicle(self);
            } else if (isdefined(self.var_d50e861c) && self.var_d50e861c == "spawnOnPlayer") {
                self.var_a9914487 = 1;
            }
        }
        self.respawntimerstarttime = undefined;
        self.userespawntime = undefined;
    }
    self clientfield::set_player_uimodel("hudItems.squadSpawnRespawnStatus", 0);
    self.var_4db23b = function_e5b0d177(self);
    self.var_20250438 = undefined;
    return spawn;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0x768979bc, Offset: 0x1578
// Size: 0xb2
function function_e5b0d177(player) {
    var_58d1e914 = function_a1cff525(player.squad);
    foreach (var_b5123467 in var_58d1e914) {
        if (var_b5123467.var_83de62a2 == 0) {
            return true;
        }
    }
    return false;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x0
// Checksum 0x991d35fe, Offset: 0x1638
// Size: 0x1c4
function spawn_player() {
    if (!function_d072f205()) {
        return;
    }
    if (self.sessionstate == "dead" && self namespace_8a203916::function_500047aa(1)) {
        self ghost();
        self notsolid();
        self val::set(#"hash_a97d206e86519b9", "freezecontrols", 1);
        self val::set(#"hash_a97d206e86519b9", "disablegadgets", 1);
        self endon(#"death", #"disconnect");
        wait 1.25 - float(function_60d95f53()) / 1000;
        self show();
        self solid();
        self val::reset(#"hash_a97d206e86519b9", "freezecontrols");
        self val::reset(#"hash_a97d206e86519b9", "disablegadgets");
    }
    function_bb63189b(self);
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0xc60088b3, Offset: 0x1808
// Size: 0x6c
function function_a0bd2fd6(enabled) {
    if (!function_d072f205()) {
        return;
    }
    if (enabled) {
        self clientfield::set_player_uimodel("hudItems.squadSpawnViewType", 1);
        return;
    }
    self clientfield::set_player_uimodel("hudItems.squadSpawnViewType", 0);
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 2, eflags: 0x1 linked
// Checksum 0xc83a8952, Offset: 0x1880
// Size: 0xb8
function function_279d5c68(team, *enabled) {
    team_players = getplayers(enabled);
    foreach (team_player in team_players) {
        team_player function_e2ec8e07(0);
    }
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0xe410f09f, Offset: 0x1940
// Size: 0x3c
function function_e2ec8e07(enabled) {
    self clientfield::set_player_uimodel("hudItems.squadAutoSpawnPromptActive", enabled ? 1 : 0);
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0xcc0cd805, Offset: 0x1988
// Size: 0x3c
function function_8c7462a6(enabled) {
    self clientfield::set_player_uimodel("hudItems.squadSpawnSquadWipe", enabled ? 1 : 0);
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 2, eflags: 0x0
// Checksum 0xc49ca607, Offset: 0x19d0
// Size: 0xc0
function function_3aa3c147(squad, enabled) {
    foreach (var_cc6fd54 in function_c65231e2(squad)) {
        var_cc6fd54 clientfield::set_player_uimodel("hudItems.squadSpawnSquadWipe", enabled ? 1 : 0);
    }
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x1 linked
// Checksum 0xf30f9dbe, Offset: 0x1a98
// Size: 0x44
function function_5f976259() {
    self clientfield::set_player_uimodel("hudItems.squadSpawnActive", 1);
    self setclientuivisibilityflag("hud_visible", 0);
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x1 linked
// Checksum 0x45dd9d37, Offset: 0x1ae8
// Size: 0x44
function function_c953ceb() {
    self clientfield::set_player_uimodel("hudItems.squadSpawnActive", 0);
    self setclientuivisibilityflag("hud_visible", 1);
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0xc228c06b, Offset: 0x1b38
// Size: 0x34
function function_bb63189b(player) {
    player.var_8791b6ff = undefined;
    player.var_276f15f0 = undefined;
    player function_c953ceb();
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 2, eflags: 0x0
// Checksum 0xfbef98cf, Offset: 0x1b78
// Size: 0x84
function function_5f24fd47(player, userespawntime) {
    player.var_f7900902 = undefined;
    player.var_3717c53b = userespawntime;
    player function_5f976259();
    if (player namespace_8a203916::function_500047aa(1)) {
        player namespace_8a203916::function_86df9236();
        return;
    }
    player namespace_8a203916::function_888901cb();
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 2, eflags: 0x0
// Checksum 0x180c46f6, Offset: 0x1c08
// Size: 0x108
function onplayerdamaged(player, attacker) {
    if (!function_d072f205()) {
        return;
    }
    if (!isdefined(attacker)) {
        return;
    }
    if (player isinvehicle()) {
        return;
    }
    var_ecbf2401 = attacker getentitynumber();
    if (isdefined(player.var_cc060afa[var_ecbf2401]) && player.var_cc060afa[var_ecbf2401] > gettime()) {
        return;
    }
    damagearea = spawnstruct();
    damagearea.createdtime = gettime();
    damagearea.attacker = attacker;
    damagearea.origin = player.origin;
    level.var_10f21cf8[level.var_10f21cf8.size] = damagearea;
    player.var_cc060afa[var_ecbf2401] = 500 + gettime();
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x5 linked
// Checksum 0x466fe083, Offset: 0x1d18
// Size: 0x92
function private function_5e178d15(damagearea) {
    if (damagearea.createdtime + getsetting("damageAreaLifetimeMS", 0) < gettime()) {
        return true;
    }
    if (!isdefined(damagearea.attacker)) {
        return true;
    }
    if (isdefined(damagearea.attacker.deathtime)) {
        if (damagearea.createdtime < damagearea.attacker.deathtime) {
            return true;
        }
    }
    return false;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x1 linked
// Checksum 0x3ca99e33, Offset: 0x1db8
// Size: 0x74
function function_33d9297() {
    for (index = level.var_10f21cf8.size - 1; index >= 0; index--) {
        if (function_5e178d15(level.var_10f21cf8[index])) {
            arrayremoveindex(level.var_10f21cf8, index, 0);
        }
    }
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0x508ba53f, Offset: 0x1e38
// Size: 0x132
function function_ef8e6bd1(player) {
    damagearearadius = getsetting("damageAreaRadius", 0);
    radiussq = damagearearadius * damagearearadius;
    if (!isdefined(player.var_b7d9b739) || player.var_b7d9b739 < gettime()) {
        player.var_b7d9b739 = gettime() + 250;
        player.var_e72b96de = 0;
        foreach (damagearea in level.var_10f21cf8) {
            if (distancesquared(player.origin, damagearea.origin) < radiussq) {
                player.var_e72b96de = 1;
            }
        }
    }
    return player.var_e72b96de;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x1 linked
// Checksum 0xb3cf0210, Offset: 0x1f78
// Size: 0x7e
function function_6a7e8977() {
    self.var_f7900902 = gettime() + int((isdefined(getgametypesetting(#"hash_c8636144ad47ac9")) ? getgametypesetting(#"hash_c8636144ad47ac9") : 0) * 1000);
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x1 linked
// Checksum 0x32eab00a, Offset: 0x2000
// Size: 0x24
function function_250e04e5() {
    self clientfield::set_player_uimodel("hudItems.squadSpawnRespawnStatus", 1);
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x1 linked
// Checksum 0x3be5d9ea, Offset: 0x2030
// Size: 0x24
function function_44c6679() {
    self clientfield::set_player_uimodel("hudItems.squadSpawnRespawnStatus", 3);
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x5 linked
// Checksum 0x713470f6, Offset: 0x2060
// Size: 0xa6
function private function_61f1a8b6(player) {
    var_4e655dbe = function_bfb027d2(player);
    if (player.var_83de62a2 != var_4e655dbe) {
        timesincelastupdate = gettime() - (isdefined(player.var_b30b9f4a) ? player.var_b30b9f4a : 0);
        if (var_4e655dbe != 1 || timesincelastupdate > 200) {
            player.var_83de62a2 = var_4e655dbe;
            player.var_b30b9f4a = gettime();
        }
    }
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x5 linked
// Checksum 0x56c486c6, Offset: 0x2110
// Size: 0x140
function private function_6d9e5aa2() {
    foreach (player in level.players) {
        if (isdefined(player.var_a271f211)) {
            if (level.numlives && !player.pers[#"lives"]) {
                player clientfield::set_player_uimodel("hudItems.squadSpawnOnStatus", 6);
                continue;
            }
            var_70be3582 = getentbynum(player.var_a271f211);
            if (isdefined(var_70be3582) && var_70be3582.squad === player.squad) {
                player clientfield::set_player_uimodel("hudItems.squadSpawnOnStatus", player.var_83de62a2);
            }
        }
    }
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x0
// Checksum 0x8d400304, Offset: 0x2258
// Size: 0x10c
function function_2ffd5f18() {
    if (is_true(self.var_312f13e0)) {
        return false;
    } else if (is_true(self.var_20250438)) {
        return true;
    } else if (self.var_d50e861c === "spawnOnPlayer") {
        return true;
    } else if (self.var_d50e861c === "spawnOnObjective") {
        return true;
    } else if (self.var_d50e861c === "autoSpawn") {
        return true;
    } else if (level.var_f0257219 && self.var_f7900902 < gettime()) {
        return true;
    } else if (getgametypesetting(#"hash_5d65f5abcdad24fe") && [[ level.var_b8da6142 ]](self)) {
        return true;
    }
    return false;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x5 linked
// Checksum 0x4eadeb69, Offset: 0x2370
// Size: 0x8a
function private function_5cdf64e2() {
    profilestart();
    foreach (player in level.players) {
        function_61f1a8b6(player);
    }
    profilestop();
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x5 linked
// Checksum 0x3da32257, Offset: 0x2408
// Size: 0x70
function private function_bae8dea9() {
    level endon(#"game_ended");
    while (true) {
        waitframe(1);
        if (!isdefined(level.players)) {
            continue;
        }
        function_5cdf64e2();
        function_6d9e5aa2();
        function_33d9297();
    }
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0xe6c7e878, Offset: 0x2480
// Size: 0x1ca
function function_154cf7ca(player) {
    if (player.var_d50e861c === "spawnOnPlayer" && isdefined(player.var_d690fc0b)) {
        targetplayer = player.var_d690fc0b;
        player.var_d690fc0b = undefined;
    }
    if (!isdefined(targetplayer)) {
        targetplayer = function_c4505fb0(player);
    }
    if (!isdefined(targetplayer)) {
        return undefined;
    }
    spawn = function_e402b74e(player, targetplayer);
    if (!isdefined(spawn)) {
        return undefined;
    }
    scoreevents::processscoreevent(#"hash_1c4cca7457aefbb9", player, undefined, undefined);
    var_58d1e914 = function_a1cff525(self.squad);
    if (var_58d1e914.size == 1) {
        scoreevents::processscoreevent(#"hash_6d563fdc029e8394", targetplayer, player, undefined);
    } else {
        scoreevents::processscoreevent(#"squad_spawn", targetplayer, player, undefined);
    }
    if (!isdefined(targetplayer.var_63d5b544) || targetplayer.var_63d5b544 + int(5 * 1000) > gettime()) {
        player battlechatter::play_dialog("spawnedSquad", 1);
        targetplayer.var_63d5b544 = gettime();
    }
    return spawn;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x4
// Checksum 0xab28a13a, Offset: 0x2658
// Size: 0xa6
function private spawnplayer(player) {
    timepassed = undefined;
    if (isdefined(player.respawntimerstarttime) && is_true(player.userespawntime)) {
        timepassed = float(gettime() - player.respawntimerstarttime) / 1000;
    }
    player thread [[ level.spawnclient ]](timepassed);
    player.respawntimerstarttime = undefined;
    player.userespawntime = undefined;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x5 linked
// Checksum 0x77413dc0, Offset: 0x2708
// Size: 0x80
function private function_c4505fb0(var_53227942) {
    if (isdefined(var_53227942.currentspectatingclient)) {
        var_51485b9d = getentbynum(var_53227942.currentspectatingclient);
        if (isdefined(var_51485b9d) && var_51485b9d.squad === var_53227942.squad && function_714da39d(var_51485b9d)) {
            return var_51485b9d;
        }
    }
    return undefined;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 2, eflags: 0x1 linked
// Checksum 0xbda26158, Offset: 0x2790
// Size: 0x172
function function_e402b74e(var_53227942, targetplayer) {
    if (targetplayer isinvehicle()) {
        vehicle = targetplayer getvehicleoccupied();
        vehicleseat = function_f099b0f1(vehicle);
        if (!isdefined(vehicleseat)) {
            return 0;
        }
        var_53227942.var_fa04792a = 1;
        var_53227942.var_6cf7bca4 = vehicleseat;
    } else {
        var_6b26b855 = util::get_start_time();
        if (getdvarint(#"hash_3b0f87edc15cba8b", 0) == 0) {
            var_8b889046 = function_9036b334(targetplayer);
        } else {
            var_8b889046 = function_15bb9eb1(targetplayer);
        }
        util::note_elapsed_time(var_6b26b855, "squad spawn point");
        if (!isdefined(var_8b889046)) {
            return 0;
        }
        var_53227942.var_fa04792a = 0;
        var_53227942.var_276f15f0 = var_8b889046;
    }
    var_53227942.var_8791b6ff = targetplayer;
    return getspawnpoint(self);
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0x7b9d5f96, Offset: 0x2910
// Size: 0x24
function function_403f2d91(var_53227942) {
    if (!isdefined(var_53227942.var_8791b6ff)) {
        return false;
    }
    return true;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x1 linked
// Checksum 0x73c997e9, Offset: 0x2940
// Size: 0x6a
function function_d072f205() {
    return currentsessionmode() != 4 && (isdefined(getgametypesetting(#"hash_2b1f40bc711c41f3")) ? getgametypesetting(#"hash_2b1f40bc711c41f3") : 0);
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 3, eflags: 0x1 linked
// Checksum 0xcea6c7d7, Offset: 0x29b8
// Size: 0x522
function function_d95ba61f(origin, angles, var_92d9ac4b) {
    var_6e8e0d1a = var_92d9ac4b - origin;
    var_5bc46b67 = lengthsquared(var_6e8e0d1a);
    var_b8a577cc = vectornormalize(var_6e8e0d1a);
    forward = anglestoforward(angles);
    var_cbb2a503 = vectornormalize(forward);
    if (getdvar(#"hash_734f370c46f37dab", 0)) {
        if (var_5bc46b67 <= 40000) {
            var_8788f2da = angles;
        } else {
            var_4c857686 = var_b8a577cc - var_cbb2a503;
            ratio = (var_5bc46b67 - 40000) / 360000;
            ratio = math::clamp(ratio, 0, 0.8);
            var_4c857686 *= ratio;
            new_vector = var_4c857686 + var_cbb2a503;
            var_6f4eb347 = vectornormalize(new_vector);
            var_8788f2da = axistoangles(var_6f4eb347, anglestoup(angles));
        }
    } else {
        var_8788f2da = angles;
    }
    tracestart = origin + (0, 0, 72);
    forwardpoint = tracestart + forward * 300;
    var_a5a53f73 = physicstrace(tracestart, forwardpoint);
    if (var_a5a53f73[#"fraction"] == 1) {
        return var_8788f2da;
    } else {
        bestangles = var_8788f2da;
        var_3360e6f8 = var_a5a53f73[#"fraction"];
    }
    var_cf041923 = forward * -1;
    var_13ef855 = tracestart + var_cf041923 * 300;
    var_ef688df7 = physicstrace(tracestart, var_13ef855);
    if (var_ef688df7[#"fraction"] == 1) {
        return axistoangles(var_cf041923, anglestoup(var_8788f2da));
    } else if (var_ef688df7[#"fraction"] > var_3360e6f8) {
        bestangles = axistoangles(var_cf041923, anglestoup(var_8788f2da));
        var_3360e6f8 = var_ef688df7[#"fraction"];
    }
    rightdir = rotatepointaroundaxis(forward, (0, 0, 1), 90);
    rightpoint = tracestart + rightdir * 300;
    var_3bb4bb28 = physicstrace(tracestart, rightpoint);
    if (var_3bb4bb28[#"fraction"] == 1) {
        return axistoangles(rightdir, anglestoup(var_8788f2da));
    } else if (var_3bb4bb28[#"fraction"] > var_3360e6f8) {
        bestangles = axistoangles(rightdir, anglestoup(var_8788f2da));
        var_3360e6f8 = var_3bb4bb28[#"fraction"];
    }
    leftdir = rightdir * -1;
    leftpoint = tracestart + leftdir * 300;
    var_eea13cc2 = physicstrace(tracestart, leftpoint);
    if (var_eea13cc2[#"fraction"] == 1) {
        return axistoangles(leftdir, anglestoup(var_8788f2da));
    } else if (var_eea13cc2[#"fraction"] > var_3360e6f8) {
        bestangles = axistoangles(leftdir, anglestoup(var_8788f2da));
    }
    return bestangles;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0xa8ee65d0, Offset: 0x2ee8
// Size: 0xa6
function getspawnpoint(var_53227942) {
    if (!isdefined(var_53227942.var_276f15f0) || !isdefined(var_53227942.var_8791b6ff)) {
        return undefined;
    }
    spawnpoint = spawnstruct();
    spawnpoint.origin = var_53227942.var_276f15f0;
    spawnpoint.angles = function_d95ba61f(spawnpoint.origin, var_53227942.var_8791b6ff.angles, var_53227942.var_8791b6ff.origin);
    return spawnpoint;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0x70460d98, Offset: 0x2f98
// Size: 0x3a
function function_1d4b97fe(player) {
    return vectornormalize(anglestoright(player.angles));
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 2, eflags: 0x1 linked
// Checksum 0x2031dde0, Offset: 0x2fe0
// Size: 0x28
function function_5d7c4291(left, right) {
    return right.score < left.score;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0xaa2e8bb7, Offset: 0x3010
// Size: 0x1e2
function function_9036b334(targetplayer) {
    var_e28b355b = function_631ffd96(targetplayer);
    if (isdefined(var_e28b355b) && var_e28b355b.size > 0) {
        array::bubble_sort(var_e28b355b, &function_5d7c4291);
        var_f8884e48 = var_e28b355b[0];
        enemyplayers = getenemyplayers(targetplayer.team, targetplayer.origin, 7500);
        for (var_5e88e432 = 0; var_5e88e432 < var_e28b355b.size; var_5e88e432++) {
            tracestart = var_e28b355b[var_5e88e432].origin + (0, 0, 65);
            var_5effde35 = 0;
            foreach (player in enemyplayers) {
                if (sighttracepassed(tracestart, player.origin + (0, 0, 65), 0, player)) {
                    var_5effde35 = 1;
                    break;
                }
            }
            if (!var_5effde35) {
                var_f8884e48 = var_e28b355b[var_5e88e432];
                break;
            }
        }
        placespawnpoint(var_f8884e48);
        return var_f8884e48.origin;
    }
    return undefined;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0xb12ca121, Offset: 0x3200
// Size: 0x560
function function_631ffd96(player) {
    /#
        var_515e3326 = util::get_start_time();
    #/
    if (getdvarint(#"hash_301150d9ff502ccc", 0) == 0) {
        var_e9c23651 = "findSpawnpointsOnPlayer (tgraph) ";
        var_b639173c = function_caa2944b(player);
    } else if (getdvarint(#"hash_301150d9ff502ccc", 0) == 1) {
        var_b639173c = function_5e631ac0(player);
        var_e9c23651 = "findSpawnpointsOnPlayer (navmesh) ";
    }
    util::note_elapsed_time(var_515e3326, "find points algorithm time");
    nearbyplayers = getplayers(#"all", player.origin, 7500);
    var_393bca70 = undefined;
    if (isdefined(level.var_d1455682.squadspawnsettings)) {
        var_393bca70 = getscriptbundle(level.var_d1455682.squadspawnsettings);
    }
    var_a17303fd = getsetting("maxDistanceFromTargetPlayer", 1, var_393bca70);
    maxtargetdistance = var_a17303fd * var_a17303fd;
    var_e28b355b = [];
    maxplayerinfluencerdistance = getsetting("maxPlayerInfluencerDistance", var_393bca70);
    maxenemyinfluence = getsetting("maxEnemyInfluence", 0, var_393bca70);
    maxfriendlyinfluence = getsetting("maxFriendlyInfluence", 0, var_393bca70);
    maxtargetplayerinfluence = getsetting("maxTargetPlayerInfluence", 0, var_393bca70);
    foreach (var_1010a68 in var_b639173c) {
        var_34b9fef4 = 0;
        var_4566a74c = 0;
        foreach (nearbyplayer in nearbyplayers) {
            if (nearbyplayer == player) {
                continue;
            }
            if (!isalive(nearbyplayer)) {
                continue;
            }
            /#
                if (nearbyplayer isinmovemode("<dev string:x38>", "<dev string:x3f>")) {
                    continue;
                }
            #/
            distance = distancesquared(nearbyplayer.origin, var_1010a68);
            isenemy = nearbyplayer.team !== player.team;
            if (distance < level.var_9b9900e6 && player util::isenemyplayer(nearbyplayer)) {
                var_4566a74c = 1;
                break;
            }
            if (distance > level.var_d6cbe602) {
                continue;
            }
            percentage = 1 - maxplayerinfluencerdistance / distance;
            if (isenemy) {
                var_34b9fef4 += percentage * maxenemyinfluence;
                continue;
            }
            var_34b9fef4 += percentage * maxfriendlyinfluence;
        }
        if (var_4566a74c) {
            continue;
        }
        var_fda6fb8f = distancesquared(player.origin, var_1010a68);
        var_64582d52 = min(var_fda6fb8f / maxtargetdistance, 1);
        var_34b9fef4 += (1 - var_64582d52) * maxtargetplayerinfluence;
        spawnpoint = {#origin:var_1010a68, #score:var_34b9fef4};
        var_e28b355b[var_e28b355b.size] = spawnpoint;
    }
    util::note_elapsed_time(var_515e3326, var_e9c23651);
    return var_e28b355b;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 3, eflags: 0x0
// Checksum 0x38b8c8a5, Offset: 0x3768
// Size: 0x2e6
function function_c93ea96(player, offset, startdirection) {
    dir = rotatepointaroundaxis(startdirection, (0, 0, 1), offset.angle);
    var_f630c27d = player geteyeapprox() + dir * 4;
    var_15e4d538 = var_f630c27d + dir * offset.distance;
    traceresults = physicstrace(var_f630c27d, var_15e4d538, level.var_97b04ad0, level.var_1dc6484c, player);
    var_b2c7da84 = traceresults[#"position"];
    if (is_true(traceresults[#"startsolid"])) {
        return undefined;
    }
    if (traceresults[#"fraction"] < 1) {
        var_b2c7da84 = traceresults[#"position"] + level.var_64a19c03 * dir * -1;
        distance = traceresults[#"fraction"] * (offset.distance - level.var_64a19c03);
        if (distance < getgametypesetting(#"hash_531cc9c63ae86a93")) {
            return undefined;
        }
    }
    var_36fdf614 = var_b2c7da84 + (0, 0, getgametypesetting(#"hash_3c31c3f19402e1f"));
    var_a4898797 = level.var_a4898797;
    var_67c52b11 = var_b2c7da84 + (0, 0, var_a4898797 * -1);
    var_67a707f4 = physicstrace(var_36fdf614, var_67c52b11, level.var_4f091b08, level.var_7d121ad7);
    if (var_67a707f4[#"fraction"] == 1 || is_true(traceresults[#"startsolid"])) {
        return undefined;
    }
    if (isdefined(var_67a707f4[#"entity"]) && isplayer(var_67a707f4[#"entity"])) {
        return undefined;
    }
    return var_67a707f4[#"position"] + var_67a707f4[#"normal"] * -4;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0xd55bd2e0, Offset: 0x3a58
// Size: 0x26
function function_714da39d(player) {
    return function_bfb027d2(player) == 0;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0x8ead2b82, Offset: 0x3a88
// Size: 0x53e
function function_bfb027d2(player) {
    if (!isalive(player)) {
        return 3;
    }
    if (player inlaststand()) {
        return 4;
    }
    if (player isinfreefall()) {
        return 7;
    }
    if (player function_9a0edd92()) {
        return 7;
    }
    if (player ishidden()) {
        return 6;
    }
    if ((isdefined(player.var_e03e3ae5) ? player.var_e03e3ae5 : 0) + int((isdefined(getgametypesetting(#"hash_2596f9e3d6e26ac9")) ? getgametypesetting(#"hash_2596f9e3d6e26ac9") : 0) * 1000) > gettime() && isdefined(player.var_4a755632)) {
        foreach (var_49604bcb in player.var_4a755632) {
            if (!isdefined(var_49604bcb.lastdamagedtime)) {
                continue;
            }
            if (!isdefined(var_49604bcb.entity)) {
                continue;
            }
            if (var_49604bcb.lastdamagedtime + int((isdefined(getgametypesetting(#"hash_2596f9e3d6e26ac9")) ? getgametypesetting(#"hash_2596f9e3d6e26ac9") : 0) * 1000) > gettime() && var_49604bcb.lastdamagedtime > (isdefined(var_49604bcb.entity.deathtime) ? var_49604bcb.entity.deathtime : 0)) {
                return 2;
            }
        }
    }
    if (is_true(player.lastdamagewasfromenemy) && (isdefined(player.var_e2e8198f) ? player.var_e2e8198f : 0) + int((isdefined(getgametypesetting(#"hash_2596f9e3d6e26ac9")) ? getgametypesetting(#"hash_2596f9e3d6e26ac9") : 0) * 1000) > gettime()) {
        return 2;
    }
    if (player laststand::player_is_in_laststand()) {
        return 4;
    }
    if (player isremotecontrolling()) {
        return 6;
    }
    if (player isinvehicle()) {
        vehicle = player getvehicleoccupied();
        if (isdefined(vehicle)) {
            vehicleseat = function_f099b0f1(vehicle);
            if (!isdefined(vehicleseat)) {
                return 5;
            }
        }
    }
    if (player isplayerswimming()) {
        return 6;
    }
    if (player isonladder()) {
        return 6;
    }
    if ((isdefined(player.var_12db485c) ? player.var_12db485c : 0) < gettime()) {
        player.var_708884c0 = gettime() + randomintrange(100, 400);
        enemies = player getenemiesinradius(player.origin, isdefined(getgametypesetting(#"hash_718b497c5205e74b")) ? getgametypesetting(#"hash_718b497c5205e74b") : 0);
        if (enemies.size > 0) {
            return 1;
        }
    }
    if (function_ef8e6bd1(player)) {
        return 2;
    }
    return 0;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0x8ded6f08, Offset: 0x3fd0
// Size: 0x10a
function function_f099b0f1(vehicle) {
    if (!isvehicle(vehicle)) {
        return undefined;
    }
    if (!vehicle isvehicleusable()) {
        return undefined;
    }
    for (seatindex = 0; seatindex < 11; seatindex++) {
        if (!vehicle function_dcef0ba1(seatindex)) {
            continue;
        }
        if (!vehicle function_154190ec(seatindex)) {
            continue;
        }
        var_3693c73b = vehicle function_defc91b2(seatindex);
        if (!isdefined(var_3693c73b) || var_3693c73b < 0) {
            continue;
        }
        if (vehicle isvehicleseatoccupied(seatindex)) {
            continue;
        }
        return seatindex;
    }
    return undefined;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0x4fa9d94b, Offset: 0x40e8
// Size: 0x2e
function function_61e7d9a8(player) {
    return isdefined(player.var_fa04792a) && player.var_fa04792a == 1;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0xe9851ec0, Offset: 0x4120
// Size: 0xd2
function spawninvehicle(player) {
    targetplayer = player.var_8791b6ff;
    if (!isdefined(targetplayer)) {
        return;
    }
    if (!targetplayer isinvehicle()) {
        return;
    }
    vehicle = targetplayer getvehicleoccupied();
    if (!isdefined(vehicle)) {
        return;
    }
    if (vehicle isvehicleseatoccupied(player.var_6cf7bca4)) {
        return;
    }
    vehicle::function_bc2025e(player);
    vehicle usevehicle(player, player.var_6cf7bca4);
    player.var_a9914487 = 2;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x1 linked
// Checksum 0x7a6c5020, Offset: 0x4200
// Size: 0x82
function on_player_spawned() {
    if (!function_d072f205()) {
        return;
    }
    function_279d5c68(self.team, 0);
    if (is_true(level.droppedtagrespawn)) {
        self clientfield::set_player_uimodel("hudItems.squadSpawnRespawnStatus", 2);
    }
    self.var_a271f211 = undefined;
    self.var_cc060afa = [];
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0x23dc32ce, Offset: 0x4290
// Size: 0x1ec
function function_46196357(squad) {
    level endon(#"game_ended");
    foreach (var_cc6fd54 in function_c65231e2(squad)) {
        var_cc6fd54 function_8c7462a6(1);
        var_cc6fd54.var_312f13e0 = 1;
        var_cc6fd54 notify(#"hash_33713849648e651d");
    }
    var_67899abe = isdefined(getgametypesetting(#"hash_78d9e3544c3a5eaf")) ? getgametypesetting(#"hash_78d9e3544c3a5eaf") : 0;
    wait var_67899abe;
    foreach (var_cc6fd54 in function_c65231e2(squad)) {
        var_cc6fd54 function_8c7462a6(0);
        var_cc6fd54.var_312f13e0 = 0;
        var_cc6fd54.var_20250438 = 1;
        var_cc6fd54 notify(#"hash_33713849648e651d");
    }
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0x9b02812b, Offset: 0x4488
// Size: 0x84
function on_player_killed(*params) {
    aliveplayers = function_a1cff525(self.squad);
    var_72ea2bd8 = function_c65231e2(self.squad);
    if (aliveplayers.size == 0 && var_72ea2bd8.size > 1) {
        thread function_46196357(self.squad);
    }
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 0, eflags: 0x1 linked
// Checksum 0x47730eab, Offset: 0x4518
// Size: 0x5c
function on_player_connect() {
    if (level.var_d2f7a339 && self.team != #"spectator") {
        self namespace_8a203916::function_86df9236();
        return;
    }
    self namespace_8a203916::function_888901cb();
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0x9e32af59, Offset: 0x4580
// Size: 0x268
function scoreeventplayerkill(data) {
    victim = data.victim;
    if (!isdefined(victim)) {
        return;
    }
    attacker = data.attacker;
    if (!isdefined(attacker) || !isplayer(attacker)) {
        return;
    }
    time = data.time;
    attacker.lastkilltime = time;
    if (isdefined(victim.lastkilltime) && victim.lastkilltime > time - int(10 * 1000)) {
        if (isdefined(victim.lastkilledplayer) && victim.lastkilledplayer.squad == attacker.squad && attacker != victim.lastkilledplayer) {
            scoreevents::processscoreevent("squad_avenged_member", attacker, victim);
        }
    }
    if (isdefined(victim.damagedplayers) && isdefined(attacker.clientid)) {
        foreach (var_abe8cf31, var_87de3b91 in victim.damagedplayers) {
            if (var_abe8cf31 === attacker.clientid) {
                continue;
            }
            if (!isdefined(var_87de3b91.entity)) {
                continue;
            }
            if (attacker.squad != var_87de3b91.entity.squad) {
                continue;
            }
            if (time - var_87de3b91.time < int(5 * 1000)) {
                scoreevents::processscoreevent("squad_member_saved", attacker, victim);
            }
        }
    }
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0x205218ba, Offset: 0x47f0
// Size: 0x15a
function function_caa2944b(player) {
    var_e0995b29 = player.origin - vectorscale(anglestoforward(player.angles), 500);
    var_24a29762 = ai::t_cylinder(var_e0995b29, 1000, 100);
    var_e50a845c = tacticalquery("squad_spawn_query", player.origin, var_24a29762);
    var_8f161336 = [];
    counter = 0;
    foreach (tpoint in var_e50a845c) {
        counter++;
        if (counter % 3 != 0) {
            continue;
        }
        var_8f161336[var_8f161336.size] = tpoint.origin;
    }
    return var_8f161336;
}

// Namespace squad_spawn/namespace_cd4d78f1
// Params 1, eflags: 0x1 linked
// Checksum 0xae655f8a, Offset: 0x4958
// Size: 0x234
function function_5e631ac0(player) {
    var_8f161336 = [];
    startdirection = function_1d4b97fe(player);
    mindistance = getsetting("minDistanceFromTargetPlayer", 0);
    maxdistance = getsetting("maxDistanceFromTargetPlayer", 0);
    var_e71ce6f1 = [];
    var_e71ce6f1[var_e71ce6f1.size] = mindistance;
    var_e71ce6f1[var_e71ce6f1.size] = maxdistance * 0.5;
    var_e71ce6f1[var_e71ce6f1.size] = maxdistance;
    for (index = 1; index < 3; index++) {
        dir = rotatepointaroundaxis(startdirection, (0, 0, 1), -50 * index);
        var_f630c27d = player geteyeapprox() + dir * 4;
        foreach (var_eb701739 in var_e71ce6f1) {
            endpoint = var_f630c27d + dir * var_eb701739;
            navmeshpoint = getclosestpointonnavmesh(endpoint, 500);
            if (isdefined(navmeshpoint) && !oob::function_1a0f9f54(navmeshpoint) && territory::is_inside(navmeshpoint)) {
                var_8f161336[var_8f161336.size] = navmeshpoint;
            }
        }
    }
    return var_8f161336;
}

/#

    // Namespace squad_spawn/namespace_cd4d78f1
    // Params 0, eflags: 0x4
    // Checksum 0x16d4eff5, Offset: 0x4b98
    // Size: 0xa0
    function private function_2e6f6dfb() {
        level.var_e44deb9 = [];
        level.var_e44deb9[0] = "<dev string:x49>";
        level.var_e44deb9[1] = "<dev string:x55>";
        level.var_e44deb9[2] = "<dev string:x68>";
        level.var_e44deb9[3] = "<dev string:x7d>";
        level.var_e44deb9[4] = "<dev string:x85>";
        level.var_e44deb9[5] = "<dev string:x93>";
        level.var_e44deb9[6] = "<dev string:xa3>";
    }

    // Namespace squad_spawn/namespace_cd4d78f1
    // Params 0, eflags: 0x4
    // Checksum 0x697615cb, Offset: 0x4c40
    // Size: 0x124
    function private function_134fed80() {
        if (!isdefined(level.var_e44deb9)) {
            function_2e6f6dfb();
        }
        while (true) {
            if (isdefined(level.players)) {
                break;
            }
            waitframe(1);
        }
        while (true) {
            waitframe(1);
            if (!getdvarint(#"hash_15f42bd141a09b05", 0)) {
                continue;
            }
            foreach (player in level.players) {
                if (player.entnum == 0) {
                    continue;
                }
                function_9ee62d04(player);
            }
        }
    }

    // Namespace squad_spawn/namespace_cd4d78f1
    // Params 1, eflags: 0x0
    // Checksum 0xa5e28eb5, Offset: 0x4d70
    // Size: 0x2b0
    function function_9ee62d04(player) {
        if (!isdefined(player.var_83de62a2)) {
            return;
        }
        if (isdefined(player.var_b1f6419a)) {
            distancesqr = distancesquared(player.origin, player.var_b1f6419a);
        }
        player.var_85736169 = function_631ffd96(player);
        array::bubble_sort(player.var_85736169, &function_5d7c4291);
        player.var_b1f6419a = player.origin;
        pointindex = 0;
        foreach (point in player.var_85736169) {
            pointindex++;
            color = (0, 1, 0);
            if (player.var_83de62a2 > 0) {
                color = (1, 0, 0);
            }
            sphere(point.origin, 4, color, 1, 1);
            print3d(point.origin + (0, 0, 50), isdefined(point.score) ? "<dev string:xb1>" + point.score : "<dev string:xb1>", (0, 0, 1), 1, 2, 0, 1);
            line(point.origin + (0, 0, 60), point.origin + (0, 0, 210), (1, 0, 0));
            print3d(point.origin + (0, 0, 160), "<dev string:xb5>" + (isdefined(pointindex) ? "<dev string:xb1>" + pointindex : "<dev string:xb1>"), (1, 0, 0), 1, 2, 0, 1);
        }
    }

#/
