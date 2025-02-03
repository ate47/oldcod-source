#using script_396f7d71538c9677;
#using script_44b0b8420eabacad;
#using script_5ee699b0aaf564c4;
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
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\system_shared;
#using scripts\core_common\territory_util;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;

#namespace squad_spawn;

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x6
// Checksum 0xaadbec39, Offset: 0x488
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"squad_spawning", &init, undefined, undefined, undefined);
}

// Namespace squad_spawn/ui_menuresponse
// Params 1, eflags: 0x40
// Checksum 0x47a97f90, Offset: 0x4d0
// Size: 0x1fe
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
        if (response == "spectatePlayer") {
            var_26c5324a = getentbynum(targetclientnum);
            self.var_a271f211 = targetclientnum;
            if (isalive(var_26c5324a)) {
                spawningplayer spectating::function_26c5324a(var_26c5324a);
            }
            return;
        }
        if (response == "spawnOnPlayer") {
            spawningplayer.spawn.var_e8f87696 = 0;
            spawningplayer.spawn.response = "spawnOnPlayer";
            spawningplayer.var_d690fc0b = getentbynum(targetclientnum);
            return;
        }
        if (response == "spawnOnObjective") {
            spawningplayer.spawn.var_e8f87696 = 0;
            spawningplayer.spawn.response = "spawnOnObjective";
            spawningplayer.var_612ad92b = targetclientnum;
            return;
        }
        if (response == "autoSpawn") {
            spawningplayer.spawn.var_e8f87696 = 0;
            spawningplayer.spawn.response = "autoSpawn";
        }
    }
}

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x0
// Checksum 0xc7f6bc29, Offset: 0x6d8
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

// Namespace squad_spawn/spawning_squad
// Params 3, eflags: 0x0
// Checksum 0x45f0e25e, Offset: 0xc98
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

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x4
// Checksum 0x5a482026, Offset: 0xd48
// Size: 0xf4
function private setupclientfields() {
    clientfield::register_clientuimodel("hudItems.squadSpawnOnStatus", 1, 3, "int");
    clientfield::register_clientuimodel("hudItems.squadSpawnActive", 1, 1, "int");
    clientfield::register_clientuimodel("hudItems.squadSpawnRespawnStatus", 1, 2, "int");
    clientfield::register_clientuimodel("hudItems.squadSpawnViewType", 1, 1, "int");
    clientfield::register_clientuimodel("hudItems.squadAutoSpawnPromptActive", 1, 1, "int");
    clientfield::register_clientuimodel("hudItems.squadSpawnSquadWipe", 1, 1, "int");
}

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x4
// Checksum 0xd83ff09d, Offset: 0xe48
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

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x0
// Checksum 0x8755f1ec, Offset: 0x10e0
// Size: 0x2a2
function function_941bd62f() {
    /#
        if (isdefined(self.devguilockspawn) && self.devguilockspawn) {
            return {#origin:self.resurrect_origin, #angles:self.resurrect_angles};
        }
    #/
    if (!isdefined(self.spawn.response)) {
    } else if (self.spawn.response === "spawnOnPlayer") {
        spawn = function_154cf7ca(self);
    } else if (self.spawn.response === "spawnOnObjective") {
        spawn = getspawnpoint(self);
    } else if (self.spawn.response === "autoSpawn" && !getgametypesetting(#"hash_1e71b5ce1cd845b3")) {
        function_279d5c68(self.team, 0);
        spawn = getspawnpoint(self);
    } else if (getgametypesetting(#"hash_5d65f5abcdad24fe") && self.spawn.var_e8f87696 < gettime()) {
        if (self.spawn.response === "spawnOnObjective" || !function_154cf7ca(self)) {
            spawn = getspawnpoint(self);
        }
    } else if (isdefined(level.var_b8da6142) && [[ level.var_b8da6142 ]](self)) {
        if (!function_154cf7ca(self)) {
            spawn = getspawnpoint(self);
        }
    } else {
        squadmates = function_c65231e2(self.squad);
        if (squadmates.size <= 1) {
            spawn = getspawnpoint(self);
        }
    }
    return spawn;
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0x860953cc, Offset: 0x1390
// Size: 0xbe
function function_841e08f9(player) {
    if (!isdefined(level.inprematchperiod) || level.inprematchperiod) {
        return false;
    }
    if (!getgametypesetting(#"hash_1e71b5ce1cd845b3")) {
        return false;
    }
    if (is_true(player.var_20250438)) {
        return true;
    }
    if (!isdefined(player.spawn.response) || player.spawn.response == "autoSpawn") {
        return true;
    }
    return false;
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0x9dcc3f20, Offset: 0x1458
// Size: 0x236
function on_spawn_player(predictedspawn = 0) {
    spawn = self function_941bd62f();
    if (!isdefined(spawn) || !isdefined(spawn.origin)) {
        spawn = spawning::function_89116a1e(predictedspawn);
    }
    self.spawn.var_e8f87696 = undefined;
    if (predictedspawn) {
        self spawning::function_e1a7c3d9(spawn.origin, spawn.angles);
    } else {
        self.lastspawntime = gettime();
        if (function_841e08f9(self)) {
            self namespace_aaddef5a::function_96d350e9(spawn);
            self.spawn.var_a9914487 = 3;
        } else {
            self spawn(spawn.origin, spawn.angles);
            influencers::create_player_spawn_influencers(spawn.origin);
            if (function_61e7d9a8(self)) {
                spawninvehicle(self);
            } else if (isdefined(self.spawn.response) && self.spawn.response == "spawnOnPlayer") {
                self.spawn.var_a9914487 = 1;
            } else {
                self.spawn.var_a9914487 = 0;
            }
        }
        self.respawntimerstarttime = undefined;
        self.spawn.userespawntime = undefined;
    }
    self clientfield::set_player_uimodel("hudItems.squadSpawnRespawnStatus", 0);
    self.spawn.var_4db23b = function_e5b0d177(self);
    self.var_20250438 = undefined;
    return spawn;
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0x3ca4478f, Offset: 0x1698
// Size: 0xb2
function function_e5b0d177(player) {
    squadmates = function_a1cff525(player.squad);
    foreach (squadmate in squadmates) {
        if (squadmate.var_83de62a2 == 0) {
            return true;
        }
    }
    return false;
}

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x0
// Checksum 0xd3c1e679, Offset: 0x1758
// Size: 0x1c4
function spawn_player() {
    if (!function_d072f205()) {
        return;
    }
    if (self.sessionstate == "dead" && self spectate_view::function_500047aa(1)) {
        self ghost();
        self notsolid();
        self val::set(#"spawning_squad", "freezecontrols", 1);
        self val::set(#"spawning_squad", "disablegadgets", 1);
        self endon(#"death", #"disconnect");
        wait 1.25 - float(function_60d95f53()) / 1000;
        self show();
        self solid();
        self val::reset(#"spawning_squad", "freezecontrols");
        self val::reset(#"spawning_squad", "disablegadgets");
    }
    function_bb63189b(self);
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0xf3638ecf, Offset: 0x1928
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

// Namespace squad_spawn/spawning_squad
// Params 2, eflags: 0x0
// Checksum 0x50d97684, Offset: 0x19a0
// Size: 0xb8
function function_279d5c68(team, *enabled) {
    team_players = getplayers(enabled);
    foreach (team_player in team_players) {
        team_player function_e2ec8e07(0);
    }
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0xd5415109, Offset: 0x1a60
// Size: 0x3c
function function_e2ec8e07(enabled) {
    self clientfield::set_player_uimodel("hudItems.squadAutoSpawnPromptActive", enabled ? 1 : 0);
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0xbaaec624, Offset: 0x1aa8
// Size: 0x6c
function function_8c7462a6(enabled) {
    self clientfield::set_player_uimodel("hudItems.squadSpawnSquadWipe", enabled ? 1 : 0);
    self clientfield::set_player_uimodel("hudItems.squadSpawnRespawnStatus", enabled ? 0 : 1);
}

// Namespace squad_spawn/spawning_squad
// Params 2, eflags: 0x0
// Checksum 0xd63b64cb, Offset: 0x1b20
// Size: 0xc0
function function_3aa3c147(squad, enabled) {
    foreach (squadplayer in function_c65231e2(squad)) {
        squadplayer clientfield::set_player_uimodel("hudItems.squadSpawnSquadWipe", enabled ? 1 : 0);
    }
}

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x0
// Checksum 0xf6c4710a, Offset: 0x1be8
// Size: 0x44
function function_5f976259() {
    self clientfield::set_player_uimodel("hudItems.squadSpawnActive", 1);
    self setclientuivisibilityflag("hud_visible", 0);
}

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x0
// Checksum 0x30dcc14a, Offset: 0x1c38
// Size: 0x44
function function_c953ceb() {
    self clientfield::set_player_uimodel("hudItems.squadSpawnActive", 0);
    self setclientuivisibilityflag("hud_visible", 1);
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0x7168c79e, Offset: 0x1c88
// Size: 0x44
function function_bb63189b(player) {
    player.spawn.var_8791b6ff = undefined;
    player.spawn.var_276f15f0 = undefined;
    player function_c953ceb();
}

// Namespace squad_spawn/spawning_squad
// Params 2, eflags: 0x0
// Checksum 0xc94d955, Offset: 0x1cd8
// Size: 0x84
function function_5f24fd47(player, *userespawntime) {
    userespawntime.spawn.var_e8f87696 = undefined;
    userespawntime function_5f976259();
    if (userespawntime spectate_view::function_500047aa(1)) {
        userespawntime spectate_view::function_86df9236();
        return;
    }
    userespawntime spectate_view::function_888901cb();
}

// Namespace squad_spawn/spawning_squad
// Params 2, eflags: 0x0
// Checksum 0x3e77696c, Offset: 0x1d68
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

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x4
// Checksum 0x68270548, Offset: 0x1e78
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

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x0
// Checksum 0xdd978164, Offset: 0x1f18
// Size: 0x74
function function_33d9297() {
    for (index = level.var_10f21cf8.size - 1; index >= 0; index--) {
        if (function_5e178d15(level.var_10f21cf8[index])) {
            arrayremoveindex(level.var_10f21cf8, index, 0);
        }
    }
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0xffee13df, Offset: 0x1f98
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

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x0
// Checksum 0xaf4f56b6, Offset: 0x20d8
// Size: 0x82
function function_6a7e8977() {
    self.spawn.var_e8f87696 = gettime() + int((isdefined(getgametypesetting(#"hash_c8636144ad47ac9")) ? getgametypesetting(#"hash_c8636144ad47ac9") : 0) * 1000);
}

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x0
// Checksum 0xbccc20ba, Offset: 0x2168
// Size: 0x24
function function_250e04e5() {
    self clientfield::set_player_uimodel("hudItems.squadSpawnRespawnStatus", 1);
}

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x0
// Checksum 0xc02fae00, Offset: 0x2198
// Size: 0x24
function function_44c6679() {
    self clientfield::set_player_uimodel("hudItems.squadSpawnRespawnStatus", 3);
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x4
// Checksum 0x9fa834ef, Offset: 0x21c8
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

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x4
// Checksum 0xaaaed469, Offset: 0x2278
// Size: 0x19a
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
                if (player.var_1f88032b !== player.var_a271f211) {
                    player util::create_streamer_hint(var_70be3582.origin, var_70be3582.angles, 1, 8);
                }
                player.var_1f88032b = player.var_a271f211;
            }
        }
    }
}

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x0
// Checksum 0x8013683e, Offset: 0x2420
// Size: 0x12c
function function_2ffd5f18() {
    if (is_true(self.var_312f13e0)) {
        return false;
    } else if (is_true(self.var_20250438)) {
        return true;
    } else if (self.spawn.response === "spawnOnPlayer") {
        return true;
    } else if (self.spawn.response === "spawnOnObjective") {
        return true;
    } else if (self.spawn.response === "autoSpawn") {
        return true;
    } else if (level.var_f0257219 && self.spawn.var_e8f87696 < gettime()) {
        return true;
    } else if (getgametypesetting(#"hash_5d65f5abcdad24fe") && [[ level.var_b8da6142 ]](self)) {
        return true;
    }
    return false;
}

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x4
// Checksum 0x386a943b, Offset: 0x2558
// Size: 0x8a
function private updateplayers() {
    profilestart();
    foreach (player in level.players) {
        function_61f1a8b6(player);
    }
    profilestop();
}

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x4
// Checksum 0x6b91e929, Offset: 0x25f0
// Size: 0x70
function private function_bae8dea9() {
    level endon(#"game_ended");
    while (true) {
        waitframe(1);
        if (!isdefined(level.players)) {
            continue;
        }
        updateplayers();
        function_6d9e5aa2();
        function_33d9297();
    }
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x4
// Checksum 0x69516b9b, Offset: 0x2668
// Size: 0xb4
function private function_426b6bde(ent) {
    if (!isdefined(ent)) {
        return;
    }
    if (isplayer(ent)) {
        data = {#pos_x:ent.origin[0], #pos_y:ent.origin[1], #pos_z:ent.origin[2]};
        function_92d1707f(#"hash_7f298b21a2012331", data);
    }
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0xa07d68a3, Offset: 0x2728
// Size: 0x20a
function function_154cf7ca(player) {
    if (player.spawn.response === "spawnOnPlayer" && isdefined(player.var_d690fc0b)) {
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
        function_426b6bde(targetplayer);
        return undefined;
    }
    scoreevents::processscoreevent(#"hash_1c4cca7457aefbb9", player, undefined, undefined);
    squadmates = function_a1cff525(self.squad);
    if (squadmates.size == 1) {
        scoreevents::processscoreevent(#"hash_6d563fdc029e8394", targetplayer, player, undefined);
    } else {
        scoreevents::processscoreevent(#"squad_spawn", targetplayer, player, undefined);
    }
    if ((isdefined(targetplayer.var_23adeae5) ? targetplayer.var_23adeae5 : 0) < gettime()) {
        player battlechatter::play_dialog("spawnedSquad", 1);
        targetplayer.var_23adeae5 = gettime() + int(battlechatter::mpdialog_value("squadSpawnCooldown", 5) * 1000);
    }
    return spawn;
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x4
// Checksum 0x60258e3, Offset: 0x2940
// Size: 0xb2
function private spawnplayer(player) {
    timepassed = undefined;
    if (isdefined(player.respawntimerstarttime) && is_true(player.spawn.userespawntime)) {
        timepassed = float(gettime() - player.respawntimerstarttime) / 1000;
    }
    player thread [[ level.spawnclient ]](timepassed);
    player.respawntimerstarttime = undefined;
    player.spawn.userespawntime = undefined;
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x4
// Checksum 0x8f38b7bf, Offset: 0x2a00
// Size: 0x80
function private function_c4505fb0(spawningplayer) {
    if (isdefined(spawningplayer.currentspectatingclient)) {
        spectatingplayer = getentbynum(spawningplayer.currentspectatingclient);
        if (isdefined(spectatingplayer) && spectatingplayer.squad === spawningplayer.squad && function_714da39d(spectatingplayer)) {
            return spectatingplayer;
        }
    }
    return undefined;
}

// Namespace squad_spawn/spawning_squad
// Params 2, eflags: 0x0
// Checksum 0x4f85861d, Offset: 0x2a88
// Size: 0x1b2
function function_e402b74e(spawningplayer, targetplayer) {
    if (targetplayer isinvehicle() && !targetplayer isremotecontrolling()) {
        vehicle = targetplayer getvehicleoccupied();
        vehicleseat = function_f099b0f1(vehicle);
        if (!isdefined(vehicleseat)) {
            return 0;
        }
        spawningplayer.spawn.var_cb738111 = 1;
        spawningplayer.spawn.vehicleseat = vehicleseat;
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
        spawningplayer.spawn.var_cb738111 = 0;
        spawningplayer.spawn.var_276f15f0 = var_8b889046;
    }
    spawningplayer.spawn.var_8791b6ff = targetplayer;
    return getspawnpoint(self);
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0xb0e5a2a1, Offset: 0x2c48
// Size: 0x2c
function function_403f2d91(spawningplayer) {
    if (!isdefined(spawningplayer.spawn.var_8791b6ff)) {
        return false;
    }
    return true;
}

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x0
// Checksum 0x4b490c7, Offset: 0x2c80
// Size: 0x6a
function function_d072f205() {
    return currentsessionmode() != 4 && (isdefined(getgametypesetting(#"hash_2b1f40bc711c41f3")) ? getgametypesetting(#"hash_2b1f40bc711c41f3") : 0);
}

// Namespace squad_spawn/spawning_squad
// Params 3, eflags: 0x0
// Checksum 0x8a7442d3, Offset: 0x2cf8
// Size: 0x62e
function function_d95ba61f(origin, angles, var_92d9ac4b) {
    var_6e8e0d1a = var_92d9ac4b - origin;
    var_5bc46b67 = lengthsquared(var_6e8e0d1a);
    var_b8a577cc = vectornormalize(var_6e8e0d1a);
    forward = anglestoforward(angles);
    var_cbb2a503 = vectornormalize(forward);
    if (var_5bc46b67 <= sqr(500)) {
        if (sighttracepassed(origin + (0, 0, 72), var_92d9ac4b + (0, 0, 72), 0, undefined)) {
            var_8792667 = (0, 0, 1);
            trace = groundtrace(origin + (0, 0, 72), origin - (0, 0, 72), 0, undefined);
            if (trace[#"fraction"] != 1) {
                var_8792667 = trace[#"normal"];
            }
            return axistoangles(var_6e8e0d1a, var_8792667);
        }
    }
    if (getdvar(#"hash_734f370c46f37dab", 0)) {
        if (var_5bc46b67 <= 40000) {
            var_8788f2da = angles;
        } else {
            newdirection = var_b8a577cc - var_cbb2a503;
            ratio = (var_5bc46b67 - 40000) / 360000;
            ratio = math::clamp(ratio, 0, 0.8);
            newdirection *= ratio;
            new_vector = newdirection + var_cbb2a503;
            var_6f4eb347 = vectornormalize(new_vector);
            var_8788f2da = axistoangles(var_6f4eb347, anglestoup(angles));
        }
    } else {
        var_8788f2da = angles;
    }
    tracestart = origin + (0, 0, 72);
    forwardpoint = tracestart + forward * 200;
    var_a5a53f73 = physicstrace(tracestart, forwardpoint);
    if (var_a5a53f73[#"fraction"] == 1) {
        return var_8788f2da;
    } else {
        bestangles = var_8788f2da;
        var_3360e6f8 = var_a5a53f73[#"fraction"];
    }
    rightdir = rotatepointaroundaxis(forward, (0, 0, 1), 90);
    rightpoint = tracestart + rightdir * 200;
    var_3bb4bb28 = physicstrace(tracestart, rightpoint);
    if (var_3bb4bb28[#"fraction"] == 1) {
        return axistoangles(rightdir, anglestoup(var_8788f2da));
    } else if (var_3bb4bb28[#"fraction"] > var_3360e6f8) {
        bestangles = axistoangles(rightdir, anglestoup(var_8788f2da));
        var_3360e6f8 = var_3bb4bb28[#"fraction"];
    }
    leftdir = rightdir * -1;
    leftpoint = tracestart + leftdir * 200;
    var_eea13cc2 = physicstrace(tracestart, leftpoint);
    if (var_eea13cc2[#"fraction"] == 1) {
        return axistoangles(leftdir, anglestoup(var_8788f2da));
    } else if (var_eea13cc2[#"fraction"] > var_3360e6f8) {
        bestangles = axistoangles(leftdir, anglestoup(var_8788f2da));
        var_3360e6f8 = var_eea13cc2[#"fraction"];
    }
    var_cf041923 = forward * -1;
    var_13ef855 = tracestart + var_cf041923 * 200;
    var_ef688df7 = physicstrace(tracestart, var_13ef855);
    if (var_ef688df7[#"fraction"] == 1) {
        return axistoangles(var_cf041923, anglestoup(var_8788f2da));
    } else if (var_ef688df7[#"fraction"] > var_3360e6f8) {
        bestangles = axistoangles(var_cf041923, anglestoup(var_8788f2da));
        var_3360e6f8 = var_ef688df7[#"fraction"];
    }
    return bestangles;
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0x96d8b9c0, Offset: 0x3330
// Size: 0xce
function getspawnpoint(spawningplayer) {
    if (!isdefined(spawningplayer.spawn.var_276f15f0) || !isdefined(spawningplayer.spawn.var_8791b6ff)) {
        return undefined;
    }
    spawnpoint = spawnstruct();
    spawnpoint.origin = spawningplayer.spawn.var_276f15f0;
    spawnpoint.angles = function_d95ba61f(spawnpoint.origin, spawningplayer.spawn.var_8791b6ff.angles, spawningplayer.spawn.var_8791b6ff.origin);
    return spawnpoint;
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0xf8dccc52, Offset: 0x3408
// Size: 0x3a
function function_1d4b97fe(player) {
    return vectornormalize(anglestoright(player.angles));
}

// Namespace squad_spawn/spawning_squad
// Params 2, eflags: 0x0
// Checksum 0x8fd2d307, Offset: 0x3450
// Size: 0x28
function function_5d7c4291(left, right) {
    return right.score < left.score;
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0xf0eb2bb3, Offset: 0x3480
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

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0xe8b3394b, Offset: 0x3670
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

// Namespace squad_spawn/spawning_squad
// Params 3, eflags: 0x0
// Checksum 0xa40756e2, Offset: 0x3bd8
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

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0x3891612e, Offset: 0x3ec8
// Size: 0x26
function function_714da39d(player) {
    return function_bfb027d2(player) == 0;
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0xe7f961a4, Offset: 0x3ef8
// Size: 0x536
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
    if (player isparachuting()) {
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
    if (player isinvehicle() && !player isremotecontrolling()) {
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

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0x60374b3f, Offset: 0x4438
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

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0xbc00b765, Offset: 0x4550
// Size: 0x3e
function function_61e7d9a8(player) {
    return isdefined(player.spawn.var_cb738111) && player.spawn.var_cb738111 == 1;
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0x4ca1a47d, Offset: 0x4598
// Size: 0xf2
function spawninvehicle(player) {
    targetplayer = player.spawn.var_8791b6ff;
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
    if (vehicle isvehicleseatoccupied(player.spawn.vehicleseat)) {
        return;
    }
    vehicle::function_bc2025e(player);
    vehicle usevehicle(player, player.spawn.vehicleseat);
    player.spawn.var_a9914487 = 2;
}

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x0
// Checksum 0x28bd3880, Offset: 0x4698
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

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0xf5680cf2, Offset: 0x4728
// Size: 0x1ec
function function_46196357(squad) {
    level endon(#"game_ended");
    foreach (squadplayer in function_c65231e2(squad)) {
        squadplayer function_8c7462a6(1);
        squadplayer.var_312f13e0 = 1;
        squadplayer notify(#"hash_33713849648e651d");
    }
    var_67899abe = isdefined(getgametypesetting(#"hash_78d9e3544c3a5eaf")) ? getgametypesetting(#"hash_78d9e3544c3a5eaf") : 0;
    wait var_67899abe;
    foreach (squadplayer in function_c65231e2(squad)) {
        squadplayer function_8c7462a6(0);
        squadplayer.var_312f13e0 = 0;
        squadplayer.var_20250438 = 1;
        squadplayer notify(#"hash_33713849648e651d");
    }
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0xfc3d57c1, Offset: 0x4920
// Size: 0x254
function on_player_killed(params) {
    aliveplayers = function_a1cff525(self.squad);
    var_72ea2bd8 = function_c65231e2(self.squad);
    if (aliveplayers.size == 0 && var_72ea2bd8.size > 1) {
        if (is_true(level.var_5c49de55)) {
            if (game.var_5c49de55[self.team] <= 0) {
                game.var_794ec97[self.team] = 1;
                return;
            }
            game.var_5c49de55[self.team]--;
            foreach (player in var_72ea2bd8) {
                player clientfield::set_player_uimodel("squad_wipe_tokens.count", game.var_5c49de55[self.team]);
            }
        }
        thread function_46196357(self.squad);
        attacker = params.eattacker;
        if (var_72ea2bd8.size >= 3 && isplayer(attacker) && attacker util::isenemyplayer(self)) {
            scoreevents::processscoreevent(#"hash_44c301a9ab6ae990", attacker, self, params.weapon);
            if (attacker stats::get_stat_global(#"hash_13ea35c63c00066c") >= 10) {
                attacker giveachievement(#"mp_achievement_squad_wipes");
            }
        }
    }
}

// Namespace squad_spawn/spawning_squad
// Params 0, eflags: 0x0
// Checksum 0x6a6b68de, Offset: 0x4b80
// Size: 0x5c
function on_player_connect() {
    if (level.var_d2f7a339 && self.team != #"spectator") {
        self spectate_view::function_86df9236();
        return;
    }
    self spectate_view::function_888901cb();
}

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0x63040d55, Offset: 0x4be8
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

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0x4ed1a08c, Offset: 0x4e58
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

// Namespace squad_spawn/spawning_squad
// Params 1, eflags: 0x0
// Checksum 0xb23d8524, Offset: 0x4fc0
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

    // Namespace squad_spawn/spawning_squad
    // Params 0, eflags: 0x4
    // Checksum 0xeaa1be20, Offset: 0x5200
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

    // Namespace squad_spawn/spawning_squad
    // Params 0, eflags: 0x4
    // Checksum 0x5641f046, Offset: 0x52a8
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

    // Namespace squad_spawn/spawning_squad
    // Params 1, eflags: 0x0
    // Checksum 0x9891aadc, Offset: 0x53d8
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
