#using script_335d0650ed05d36d;
#using script_3e196d275a6fb180;
#using script_44b0b8420eabacad;
#using script_491ff5a2ba670762;
#using script_5ee699b0aaf564c4;
#using script_6167e26342be354b;
#using script_7d712f77ab8d0c16;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\match_record;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace spawning;

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x6
// Checksum 0x8e445f26, Offset: 0x130
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"spawning_shared", &preinit, undefined, undefined, undefined);
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x4
// Checksum 0xcfdfbfcc, Offset: 0x178
// Size: 0x294
function private preinit() {
    if (!isdefined(level.spawnsystem)) {
        level.spawnsystem = spawnstruct();
    }
    if (!isdefined(level.players)) {
        level.players = [];
    }
    if (!isdefined(level.numplayerswaitingtoenterkillcam)) {
        level.numplayerswaitingtoenterkillcam = 0;
    }
    if (!isdefined(level.spawnmins)) {
        level.spawnmins = (0, 0, 0);
    }
    if (!isdefined(level.spawnmaxs)) {
        level.spawnmaxs = (0, 0, 0);
    }
    if (!isdefined(level.spawnminsmaxsprimed)) {
        level.spawnminsmaxsprimed = 0;
    }
    if (!isdefined(level.default_spawn_lists)) {
        level.default_spawn_lists = [];
    }
    if (!isdefined(level.spawnsystem.var_3709dc53)) {
        level.spawnsystem.var_3709dc53 = 1;
    }
    function_8e22661a();
    init_teams();
    function_d0149d6b();
    function_f210e027();
    function_d9deb7d7();
    namespace_aaddef5a::function_98ebe1b4();
    callback::add_callback(#"init_teams", &init_teams);
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    callback::on_joined_team(&on_joined_team);
    if (!isdefined(level.default_spawn_lists)) {
        level.default_spawn_lists = [];
    } else if (!isarray(level.default_spawn_lists)) {
        level.default_spawn_lists = array(level.default_spawn_lists);
    }
    level.default_spawn_lists[level.default_spawn_lists.size] = "normal";
    /#
        level thread spawnpoint_debug();
    #/
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x932f4180, Offset: 0x418
// Size: 0xe
function on_player_connect() {
    self.spawn = {};
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0x13b3acdb, Offset: 0x430
// Size: 0x22
function on_joined_team(*params) {
    if (!isdefined(self.spawn)) {
        self.spawn = {};
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x4
// Checksum 0xc54b1a80, Offset: 0x460
// Size: 0x1aa
function private function_8e22661a() {
    level.spawnsystem.var_a9293f4a = randomint(1033);
    level.spawnsystem.var_d9984264 = isdefined(getgametypesetting(#"spawnprotectiontime")) ? getgametypesetting(#"spawnprotectiontime") : 0;
    level.spawnsystem.spawntraptriggertime = isdefined(getgametypesetting(#"spawntraptriggertime")) ? getgametypesetting(#"spawntraptriggertime") : 0;
    level.spawnsystem.deathcirclerespawn = isdefined(getgametypesetting(#"deathcirclerespawn")) ? getgametypesetting(#"deathcirclerespawn") : 0;
    level.spawnsystem.var_c2cc011f = isdefined(getgametypesetting(#"hash_4bdd1bd86b610871")) ? getgametypesetting(#"hash_4bdd1bd86b610871") : 0;
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0x11732a7d, Offset: 0x618
// Size: 0x88
function add_default_spawnlist(spawnlist) {
    if (!isdefined(level.default_spawn_lists)) {
        level.default_spawn_lists = [];
    } else if (!isarray(level.default_spawn_lists)) {
        level.default_spawn_lists = array(level.default_spawn_lists);
    }
    level.default_spawn_lists[level.default_spawn_lists.size] = spawnlist;
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x600b6af, Offset: 0x6a8
// Size: 0x17c
function init_teams() {
    spawnsystem = level.spawnsystem;
    spawnsystem.ispawn_teammask = [];
    spawnsystem.var_c2989de = 1;
    spawnsystem.var_146943ea = 1;
    spawnsystem.ispawn_teammask[#"none"] = spawnsystem.var_c2989de;
    spawnsystem.ispawn_teammask[#"neutral"] = spawnsystem.var_146943ea;
    all = spawnsystem.var_c2989de;
    count = 1;
    if (!isdefined(level.teams)) {
        level.teams = [];
    }
    foreach (team, _ in level.teams) {
        spawnsystem.ispawn_teammask[team] = 1 << count;
        all |= spawnsystem.ispawn_teammask[team];
        count++;
    }
    spawnsystem.ispawn_teammask[#"all"] = all;
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0xaf369f37, Offset: 0x830
// Size: 0x248
function onspawnplayer(predictedspawn = 0) {
    spawnoverride = 0;
    if (isdefined(level.var_cda5136b)) {
        spawnoverride = self [[ level.var_cda5136b ]](predictedspawn);
    }
    spawnresurrect = 0;
    spawn = undefined;
    if (spawnoverride) {
        if (predictedspawn && isdefined(self.tacticalinsertion)) {
            self function_e1a7c3d9(self.tacticalinsertion.origin, self.tacticalinsertion.angles);
        }
        return undefined;
    }
    if (!isdefined(spawn) || !isdefined(spawn.origin)) {
        spawn = function_89116a1e(predictedspawn);
        if (is_true(level.var_ae517a5)) {
            self.var_fe682535 = spawn;
        }
    }
    if (!isdefined(spawn.origin)) {
        println("<dev string:x38>");
        callback::abort_level();
    }
    if (predictedspawn) {
        self function_e1a7c3d9(spawn.origin, spawn.angles);
    } else {
        self spawn(spawn.origin, spawn.angles);
        self.lastspawntime = gettime();
        if (!spawnresurrect && !spawnoverride) {
            influencers::create_player_spawn_influencers(spawn.origin);
        }
        if (squad_spawn::function_d072f205()) {
            if (squad_spawn::function_61e7d9a8(self)) {
                squad_spawn::spawninvehicle(self);
            }
            squad_spawn::function_bb63189b(self);
        }
    }
    return spawn;
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0x6656b4ea, Offset: 0xa80
// Size: 0x24
function function_d62887a1(predictedspawn) {
    onspawnplayer(predictedspawn);
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0x1a9114da, Offset: 0xab0
// Size: 0x152
function function_89116a1e(predictedspawn) {
    /#
        if (isdefined(self.devguilockspawn) && self.devguilockspawn) {
            return {#origin:self.resurrect_origin, #angles:self.resurrect_angles};
        }
    #/
    if (isdefined(level.resurrect_override_spawn)) {
        if (self [[ level.resurrect_override_spawn ]](predictedspawn)) {
            return {#origin:self.resurrect_origin, #angles:self.resurrect_angles};
        }
    }
    if (isdefined(self.var_b7cc4567)) {
        return self.var_b7cc4567;
    }
    if (usestartspawns()) {
        spawn = self function_f53e594f();
    }
    if (squad_spawn::function_403f2d91(self)) {
        spawn = squad_spawn::getspawnpoint(self);
    }
    if (!isdefined(spawn)) {
        spawn = function_99ca1277(self, predictedspawn);
    }
    return spawn;
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x4
// Checksum 0x38983600, Offset: 0xc10
// Size: 0x1de
function private getspawnlists(player, point_team) {
    lists = [];
    if (player.spawn.response === "spawnOnObjective") {
        spawnlist = function_c49f39df(player.var_612ad92b);
        lists[lists.size] = spawnlist;
    } else if (isdefined(level.var_811300ad) && level.var_811300ad.size) {
        lists = function_a782529(player);
    }
    if (!lists.size) {
        foreach (spawnlist in level.default_spawn_lists) {
            if (!isdefined(lists)) {
                lists = [];
            } else if (!isarray(lists)) {
                lists = array(lists);
            }
            lists[lists.size] = spawnlist;
        }
        if (is_spawn_trapped(point_team)) {
            if (!isdefined(lists)) {
                lists = [];
            } else if (!isarray(lists)) {
                lists = array(lists);
            }
            lists[lists.size] = "fallback";
        }
    }
    return lists;
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x4
// Checksum 0x27178037, Offset: 0xdf8
// Size: 0xf6
function private function_594e5666() {
    if (isdefined(level.var_963c3f1b)) {
        return level.var_963c3f1b;
    }
    point = level.mapcenter;
    s_trace = groundtrace(point + (0, 0, 10000), point + (0, 0, -10000), 0, self);
    if (s_trace[#"fraction"] < 1) {
        point = s_trace[#"position"];
    }
    level.var_963c3f1b = [];
    level.var_963c3f1b[#"origin"] = point;
    level.var_963c3f1b[#"angles"] = (0, 0, 0);
    return level.var_963c3f1b;
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x4
// Checksum 0xa84f9bc5, Offset: 0xef8
// Size: 0x322
function private function_99ca1277(player, predictedspawn) {
    if (level.teambased) {
        point_team = player.pers[#"team"];
        influencer_team = player.pers[#"team"];
        vis_team_mask = util::getotherteamsmask(player.pers[#"team"]);
    } else {
        point_team = #"none";
        influencer_team = #"none";
        vis_team_mask = level.spawnsystem.ispawn_teammask[#"all"];
    }
    if (level.teambased && isdefined(game.switchedsides) && game.switchedsides && level.spawnsystem.var_3709dc53) {
        point_team = util::getotherteam(point_team);
    }
    if (!is_true(level.var_6e2d52c5)) {
        lists = getspawnlists(player, point_team);
        spawn_point = getbestspawnpoint(point_team, influencer_team, vis_team_mask, player, predictedspawn, lists);
    }
    if (!isdefined(spawn_point)) {
        spawn_point = function_594e5666();
    }
    if (!predictedspawn && sessionmodeismultiplayergame()) {
        mpspawnpointsused = {#reason:"point used", #var_c734ddf2:getplayerspawnid(player), #x:spawn_point[#"origin"][0], #y:spawn_point[#"origin"][1], #z:spawn_point[#"origin"][2], #var_50641dd5:0};
        function_92d1707f(#"hash_608dde355fff78f5", mpspawnpointsused);
    }
    spawn = spawnstruct();
    spawn.origin = spawn_point[#"origin"];
    spawn.angles = spawn_point[#"angles"];
    return spawn;
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x47cefcc1, Offset: 0x1228
// Size: 0x104
function on_player_spawned() {
    self endon(#"disconnect");
    waitframe(1);
    var_f8e6b703 = self match_record::get_player_stat(#"hash_ec4aea1a8bbd82");
    if (isdefined(self.spawn.var_a9914487)) {
        if (isdefined(var_f8e6b703)) {
            self match_record::set_stat(#"lives", var_f8e6b703, #"spawn_type", self.spawn.var_a9914487);
        }
    }
    if (isdefined(self.spawn.var_4db23b)) {
        if (isdefined(var_f8e6b703)) {
            self match_record::set_stat(#"lives", var_f8e6b703, #"hash_4b3e577f8ed51943", self.spawn.var_4db23b);
        }
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0xd45e2de1, Offset: 0x1338
// Size: 0x22
function function_f53e594f() {
    return function_77b7335(self.team, "start_spawn");
}

