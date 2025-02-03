#using script_305d57cf0618009d;
#using script_67c9a990c0db216c;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\map;
#using scripts\core_common\music_shared;
#using scripts\core_common\player\player_insertion;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace namespace_66d6aa44;

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x218
// Size: 0x4
function function_3f3466c9() {
    
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0xbae8013e, Offset: 0x228
// Size: 0x24
function function_148b501d() {
    if (!isdefined(level.var_2e8c3a11)) {
        return 0;
    }
    return gettime() - level.var_2e8c3a11;
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 2, eflags: 0x0
// Checksum 0xc3d8a5fc, Offset: 0x258
// Size: 0x36
function function_a10bb198(*a_ents, str_side) {
    str_team = util::get_team_mapping(str_side);
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 3, eflags: 0x0
// Checksum 0xd1ded2b8, Offset: 0x298
// Size: 0x178
function function_aad02bd0(*a_ents, str_side, *var_9c1ed9ea) {
    str_team = util::get_team_mapping(var_9c1ed9ea);
    function_75125d25();
    function_f5692e0c("intro_cinematic", str_team);
    level clientfield::set("hide_intro_models", 1);
    script_models = getentarray("intro_scene_models", "targetname");
    var_4e756c46 = getentarray("intro_scene_models", "script_noteworthy");
    script_models = arraycombine(script_models, var_4e756c46);
    foreach (models in script_models) {
        models hide();
    }
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 2, eflags: 0x0
// Checksum 0xb34963ac, Offset: 0x418
// Size: 0x174
function function_46c380f6(*a_ents, str_side) {
    str_team = util::get_team_mapping(str_side);
    music::setmusicstatebyteam("none", str_team);
    level clientfield::set("hide_intro_models", 0);
    script_models = getentarray("intro_scene_models", "targetname");
    var_4e756c46 = getentarray("intro_scene_models", "script_noteworthy");
    script_models = arraycombine(script_models, var_4e756c46);
    foreach (models in script_models) {
        models show();
    }
    function_266bf421(str_team);
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x0
// Checksum 0x79fa853e, Offset: 0x598
// Size: 0x2c
function function_75125d25(b_state = 1) {
    level.var_3a701785 = b_state;
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 3, eflags: 0x0
// Checksum 0x9dce8433, Offset: 0x5d0
// Size: 0xb4
function function_f5692e0c(var_9c1ed9ea, str_team, player) {
    if (isdefined(game.musicset)) {
        var_9c1ed9ea += game.musicset;
    } else {
        var_9c1ed9ea += "_default";
    }
    if (isdefined(str_team)) {
        music::setmusicstatebyteam(var_9c1ed9ea, str_team);
        return;
    }
    if (isdefined(player)) {
        music::setmusicstate(var_9c1ed9ea, player);
        return;
    }
    music::setmusicstate(var_9c1ed9ea);
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0x20136db1, Offset: 0x690
// Size: 0x128
function function_14956b80() {
    if (!util::isfirstround()) {
        return false;
    }
    if (currentsessionmode() == 4 || (isdefined(getgametypesetting(#"prematchperiod")) ? getgametypesetting(#"prematchperiod") : 0) <= 0) {
        return false;
    }
    if (!is_true(level.var_d1455682.playintrocinematics)) {
        return false;
    }
    if (!getdvarint(#"hash_3c02566432466eb2", 0)) {
        return false;
    }
    if (!getdvarint(#"hash_2e7f94473567b19a", 0)) {
        return false;
    }
    if (!isdefined(function_6681bbf6())) {
        return false;
    }
    return true;
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0xcde9f252, Offset: 0x7c0
// Size: 0x1a
function isplaying() {
    return is_true(level.var_ae517a5);
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0xa259ca87, Offset: 0x7e8
// Size: 0x5a
function function_6681bbf6() {
    mapbundle = map::get_script_bundle();
    if (!isdefined(mapbundle) || !isdefined(mapbundle.var_f9631c9d)) {
        return undefined;
    }
    return getscriptbundle(mapbundle.var_f9631c9d);
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0x6cfe62a3, Offset: 0x850
// Size: 0x3e
function function_4898fc47() {
    var_43a36c6f = function_6681bbf6();
    if (isdefined(var_43a36c6f)) {
        return function_fd63b4bf(var_43a36c6f);
    }
    return 0;
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x4
// Checksum 0xd0aa00ae, Offset: 0x898
// Size: 0x44
function private function_fd63b4bf(var_52b46a06) {
    if (level.var_d1455682.var_3316a534 !== 1) {
        return false;
    }
    if (!isdefined(var_52b46a06.var_d74b6b9c)) {
        return false;
    }
    return true;
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x0
// Checksum 0x7f0c9265, Offset: 0x8e8
// Size: 0x70
function function_b69a4f47(var_2f252ea4) {
    clientfield::register("toplayer", var_2f252ea4.uniqueid, 1, 1, "int");
    if (is_true(var_2f252ea4.var_51388671)) {
        level.var_6e9fbf44[level.var_6e9fbf44.size] = var_2f252ea4;
    }
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x0
// Checksum 0x841e46e6, Offset: 0x960
// Size: 0xf0
function function_e526b83(var_43a36c6f) {
    if (!isdefined(var_43a36c6f.var_96c3f045)) {
        return;
    }
    var_20314119 = getscriptbundlelist(var_43a36c6f.var_96c3f045);
    if (!isdefined(var_20314119)) {
        return;
    }
    foreach (var_39796f0f in var_20314119) {
        var_c5470032 = getscriptbundle(var_39796f0f);
        function_b69a4f47(var_c5470032);
    }
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x0
// Checksum 0x87e4f7c4, Offset: 0xa58
// Size: 0xfc
function function_d15f17fe(*params) {
    if (isbot(self)) {
        return;
    }
    var_43a36c6f = function_6681bbf6();
    if (function_fd63b4bf(var_43a36c6f) && isdefined(var_43a36c6f.var_d74b6b9c)) {
        thread scene::init_streamer(var_43a36c6f.var_d74b6b9c, array(self));
        return;
    }
    str_scene = function_cf2c009a(self.team);
    if (isdefined(str_scene)) {
        thread scene::init_streamer(str_scene, array(self), 0, 0);
    }
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x0
// Checksum 0x9fca98d7, Offset: 0xb60
// Size: 0x204
function function_fa3eed17(var_43a36c6f) {
    level callback::callback(#"hash_4428d68b23082312");
    callback::on_joined_team(&function_d15f17fe);
    level.var_b82a5c35 = 1;
    if (!isdefined(var_43a36c6f)) {
        return;
    }
    if (!function_fd63b4bf(var_43a36c6f)) {
        level flag::wait_till_timeout(0.5, #"hash_22ca95de91eb92b");
        thread scene::add_scene_func(var_43a36c6f.var_30a9de1, &function_a10bb198, "init", "sidea");
        thread scene::add_scene_func(var_43a36c6f.var_704cf864, &function_a10bb198, "init", "sideb");
        thread scene::add_scene_func(var_43a36c6f.var_30a9de1, &function_aad02bd0, "play", "sidea", var_43a36c6f.var_70e6c400);
        thread scene::add_scene_func(var_43a36c6f.var_704cf864, &function_aad02bd0, "play", "sideb", var_43a36c6f.var_a3282882);
        thread scene::add_scene_func(var_43a36c6f.var_30a9de1, &function_46c380f6, "done", "sidea");
        thread scene::add_scene_func(var_43a36c6f.var_704cf864, &function_46c380f6, "done", "sideb");
    }
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0x25b7418d, Offset: 0xd70
// Size: 0x2c
function function_24d0c33d() {
    setdvar(#"hash_6ae50e8489bccba9", 10000);
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0x5fedd8cb, Offset: 0xda8
// Size: 0x14
function function_fcfa3b98() {
    function_e3dbd71b();
}

// Namespace namespace_66d6aa44/level_init
// Params 1, eflags: 0x40
// Checksum 0xa421a28c, Offset: 0xdc8
// Size: 0x13c
function event_handler[level_init] function_9347830c(*eventstruct) {
    lui::add_luimenu("full_screen_movie", &full_screen_movie::register);
    clientfield::register("world", "hide_intro_models", 1, 1, "int");
    clientfield::register_clientuimodel("closeLoadingMovie", 1, 1, "int", 1);
    callback::add_callback(#"on_game_playing", &function_fcfa3b98);
    var_43a36c6f = function_6681bbf6();
    level.var_6e9fbf44 = [];
    function_e526b83(var_43a36c6f);
    level.var_23e297bc = 1;
    if (function_14956b80()) {
        level thread function_fa3eed17(var_43a36c6f);
    }
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x0
// Checksum 0x71fd8c76, Offset: 0xf10
// Size: 0x128
function function_266bf421(team) {
    foreach (player in getplayers(team)) {
        player val::reset_all(#"scene_system");
        spawn = player spawning::function_f53e594f();
        if (isdefined(spawn)) {
            player dontinterpolate();
            player setorigin(spawn.origin);
            player setplayerangles(spawn.angles);
        }
    }
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0x19954aaa, Offset: 0x1040
// Size: 0x134
function function_27c20de5() {
    if (getdvarint(#"hash_66215a792350bd73")) {
        util::function_21678f2c(getplayers());
        return;
    }
    while (true) {
        b_ready = 0;
        foreach (player in getplayers()) {
            if (player isstreamerready(-1, 1) && level flag::get("first_player_spawned")) {
                waittillframeend();
                return;
            }
        }
        waitframe(1);
    }
    waittillframeend();
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0x92442ee6, Offset: 0x1180
// Size: 0x154
function function_5a8e7587() {
    function_27c20de5();
    level.var_ae517a5 = 1;
    level callback::callback(#"hash_4b4c187e584b34ac");
    level.var_2e8c3a11 = gettime();
    level.var_c1c633b5 = gettime();
    foreach (team in level.teams) {
        var_e70596ed = function_cf2c009a(team);
        if (!isdefined(var_e70596ed)) {
            continue;
        }
        if (getplayers(team).size) {
            self thread scene::init(var_e70596ed);
        }
    }
    setslowmotion(1, 0.2, 0);
    flag::set("intro_mp_cin_end");
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 3, eflags: 0x0
// Checksum 0xf48dc41, Offset: 0x12e0
// Size: 0x8c
function function_2259ff3c(callback, waittime, countdowntime) {
    level endon(#"game_ended");
    waittime = max(0, waittime);
    [[ callback ]](countdowntime, #"hash_15a3c76e013b75c1");
    wait waittime;
    level flag::set(#"hash_15a3c76e013b75c1");
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0xfe34092d, Offset: 0x1378
// Size: 0x34
function function_d24cf075() {
    self endon(#"disconnect");
    wait 0.2;
    self lui::function_a6eb5334(0);
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0x21746883, Offset: 0x13b8
// Size: 0x178
function function_b906539e() {
    if (!isdefined(level.teammenu)) {
        return;
    }
    level.var_fb99ff98 = 0;
    level.disableclassselection = 1;
    foreach (player in getplayers()) {
        if (!isdefined(player.var_77d6602a)) {
            continue;
        }
        switch (player.var_77d6602a) {
        case #"autoassign":
            player [[ level.autoassign ]](1, undefined);
            break;
        case #"spectator":
            player [[ level.spectator ]]();
            break;
        default:
            player [[ level.teammenu ]](player.var_77d6602a);
            break;
        }
        player.var_77d6602a = undefined;
    }
    level.disableclassselection = 0;
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 2, eflags: 0x0
// Checksum 0xbbfd0d89, Offset: 0x1538
// Size: 0x66c
function function_e94b8e1a(var_66cbfaf2, *var_2a832857) {
    players = getplayers();
    util::function_21678f2c(players);
    function_c403d032(players);
    scenes = [];
    var_5a990409 = 0;
    level.var_ae517a5 = 1;
    callback::remove_callback(#"joined_team", &function_d15f17fe);
    foreach (team in level.teams) {
        var_e70596ed = function_cf2c009a(team);
        if (!isdefined(var_e70596ed)) {
            continue;
        }
        if (getplayers(team).size) {
            scenes[scenes.size] = var_e70596ed;
        }
        scenelength = scene::function_12479eba(var_e70596ed);
        if (scenelength > var_5a990409) {
            var_5a990409 = scenelength;
        }
    }
    delaytime = var_5a990409 - 5 + 0.8;
    thread function_2259ff3c(var_2a832857, delaytime, 5);
    if (level.var_6e9fbf44.size > 0) {
        foreach (player in getplayers()) {
            foreach (postfxbundle in level.var_6e9fbf44) {
                player clientfield::set_to_player(postfxbundle.uniqueid, 1);
            }
        }
    }
    foreach (player in getplayers()) {
        player function_8ec328e1(0);
        player predictspawnpoint(player getplayercamerapos(), player getplayerangles());
    }
    level.var_fb99ff98 = 1;
    scene::function_1e327c20(scenes);
    player::function_80e763a4();
    foreach (player in getplayers()) {
        player function_8ec328e1(1);
        player function_b3086fd0();
    }
    /#
        if (getdvarint(#"hash_6a54249f0cc48945", 0)) {
            adddebugcommand("<dev string:x38>");
        }
    #/
    level callback::callback(#"hash_255b4626805810f5");
    if (level.var_6e9fbf44.size > 0) {
        foreach (player in getplayers()) {
            foreach (postfxbundle in level.var_6e9fbf44) {
                player clientfield::set_to_player(postfxbundle.uniqueid, 0);
            }
        }
    }
    level.var_ae517a5 = 0;
    music::setmusicstate("none");
    level thread util::delay(1, "game_ended", &function_75125d25, 0);
    thread function_bb23918f();
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0x1c99de8b, Offset: 0x1bb0
// Size: 0x1c
function function_bb23918f() {
    wait 0.4;
    function_b906539e();
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x0
// Checksum 0xb59f304d, Offset: 0x1bd8
// Size: 0x8e
function function_cf2c009a(team) {
    var_43a36c6f = function_6681bbf6();
    if (!isdefined(var_43a36c6f)) {
        return undefined;
    }
    if (team == util::get_team_mapping("sidea")) {
        return var_43a36c6f.var_30a9de1;
    } else if (team == util::get_team_mapping("sideb")) {
        return var_43a36c6f.var_704cf864;
    }
    return undefined;
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x0
// Checksum 0x6b8dede, Offset: 0x1c70
// Size: 0x5a
function function_cffd1b80(team) {
    scenename = function_cf2c009a(team);
    if (!isdefined(scenename)) {
        return;
    }
    scenelength = scene::function_12479eba(scenename);
    return scenelength;
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x0
// Checksum 0x1df28aa0, Offset: 0x1cd8
// Size: 0x21c
function function_2aaeab97(var_66cbfaf2) {
    if (!function_14956b80()) {
        return;
    }
    player_insertion::function_63977a98(0);
    var_52b46a06 = function_6681bbf6();
    if (!isdefined(var_52b46a06.var_d74b6b9c)) {
        return;
    }
    player_insertion::function_d28162a2(isdefined(var_52b46a06.blackscreentime) ? var_52b46a06.blackscreentime : 0);
    player_insertion::function_1a50e8a5(isdefined(var_52b46a06.var_73a4076) ? var_52b46a06.var_73a4076 : 0);
    players = getplayers();
    util::function_21678f2c(players);
    function_c403d032(players);
    if (isdefined(var_66cbfaf2)) {
        var_9d90ef8b = scene::function_12479eba(var_52b46a06.var_d74b6b9c);
        delaytime = var_9d90ef8b - 5 + 0.8;
        level thread function_2259ff3c(var_66cbfaf2, delaytime, 5);
    }
    function_75125d25();
    function_f5692e0c("intro_cinematic");
    scene::function_1e327c20(var_52b46a06.var_d74b6b9c);
    level thread util::delay(6, "game_ended", &function_75125d25, 0);
    array::thread_all(getplayers(), &function_8ec328e1, 1);
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 2, eflags: 0x0
// Checksum 0x957f8bf5, Offset: 0x1f00
// Size: 0x54
function function_a03c3a00(time, timeout) {
    if (self player::function_114b77dd(time, timeout)) {
        return;
    }
    self clientfield::set_player_uimodel("closeLoadingMovie", 1);
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x0
// Checksum 0xa3ea5ddc, Offset: 0x1f60
// Size: 0xbc
function function_8ec328e1(enable) {
    if (enable) {
        self val::reset(#"hash_549cbea73f5b2a54", "show_hud");
        self val::reset(#"hash_549cbea73f5b2a54", "show_weapon_hud");
        return;
    }
    self val::set(#"hash_549cbea73f5b2a54", "show_hud", 0);
    self val::set(#"hash_549cbea73f5b2a54", "show_weapon_hud", 0);
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0x7cd44b27, Offset: 0x2028
// Size: 0x34
function function_c1ec451() {
    return self clientfield::get_player_uimodel("closeLoadingMovie") == 0 ? 1 : 0;
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0x71483360, Offset: 0x2068
// Size: 0x24
function function_684bad0f() {
    self clientfield::set_player_uimodel("closeLoadingMovie", 1);
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0x9a6f9c48, Offset: 0x2098
// Size: 0xb8
function function_e3dbd71b() {
    var_94fab29 = player::function_51b57f72();
    time = gettime();
    foreach (player in getplayers()) {
        player function_a03c3a00(time, var_94fab29);
    }
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0xf9ead51e, Offset: 0x2158
// Size: 0xcc
function function_a8f822ee() {
    self endon(#"disconnect");
    while (!self player::function_114b77dd() && self function_c1ec451()) {
        self resetinactivitytimer();
        waitframe(1);
    }
    if (level flag::get(#"hash_263f55e6bcaa1891") && self function_c1ec451()) {
        self function_684bad0f();
        self function_8ec328e1(1);
    }
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x0
// Checksum 0xa6df9056, Offset: 0x2230
// Size: 0xa8
function function_c403d032(players) {
    arrayremovevalue(players, undefined);
    foreach (player in players) {
        player function_684bad0f();
    }
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 2, eflags: 0x0
// Checksum 0xbde3df70, Offset: 0x22e0
// Size: 0xac
function function_c0622ccd(players, force) {
    level flag::set(#"hash_263f55e6bcaa1891");
    if (force) {
        array::run_all(players, &function_684bad0f);
        array::thread_all(players, &function_8ec328e1, 1);
        return;
    }
    array::thread_all(players, &function_a8f822ee);
}

