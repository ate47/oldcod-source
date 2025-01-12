#using script_67c9a990c0db216c;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\map;
#using scripts\core_common\music_shared;
#using scripts\core_common\player\player_insertion;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace namespace_66d6aa44;

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0xf0abb952, Offset: 0x258
// Size: 0x14
function function_3f3466c9() {
    level.intromovie = 1;
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0x6faba67, Offset: 0x278
// Size: 0x24
function function_148b501d() {
    if (!isdefined(level.var_2e8c3a11)) {
        return 0;
    }
    return gettime() - level.var_2e8c3a11;
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 2, eflags: 0x1 linked
// Checksum 0x66eef449, Offset: 0x2a8
// Size: 0x36
function function_a10bb198(*a_ents, str_side) {
    str_team = util::get_team_mapping(str_side);
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 3, eflags: 0x1 linked
// Checksum 0x5f6b4790, Offset: 0x2e8
// Size: 0x168
function function_aad02bd0(*a_ents, str_side, *var_9c1ed9ea) {
    str_team = util::get_team_mapping(var_9c1ed9ea);
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
// Params 2, eflags: 0x1 linked
// Checksum 0x31caa97a, Offset: 0x458
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
// Params 1, eflags: 0x1 linked
// Checksum 0x9977e014, Offset: 0x5d8
// Size: 0x2c
function function_75125d25(var_9b8a5ad2 = 1) {
    level.var_3a701785 = var_9b8a5ad2;
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 3, eflags: 0x1 linked
// Checksum 0xb1d22aa0, Offset: 0x610
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
// Params 0, eflags: 0x1 linked
// Checksum 0x544c0d48, Offset: 0x6d0
// Size: 0x12e
function function_41a307f8() {
    if (!util::isfirstround()) {
        return false;
    }
    if (currentsessionmode() == 4 || (isdefined(getgametypesetting(#"prematchperiod")) ? getgametypesetting(#"prematchperiod") : 0) <= 0) {
        return false;
    }
    if (!is_true(level.var_d1455682.var_19447e5b)) {
        return false;
    }
    if (!getdvarint(#"hash_3c02566432466eb2", 0)) {
        return false;
    }
    if (!getdvarint(#"hash_57dcfee3f242f541", 0)) {
        return false;
    }
    if (!is_true(level.inprematchperiod)) {
        return false;
    }
    return true;
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x1 linked
// Checksum 0x37b5e20d, Offset: 0x808
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
// Checksum 0x29e8f30e, Offset: 0x938
// Size: 0x1a
function isplaying() {
    return is_true(level.var_ae517a5);
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0x25687451, Offset: 0x960
// Size: 0x6c
function function_a277ee35() {
    var_43a36c6f = function_6681bbf6();
    if (!isdefined(var_43a36c6f)) {
        return;
    }
    thread scene::init_streamer(var_43a36c6f.var_30a9de1, "sidea");
    thread scene::init_streamer(var_43a36c6f.var_704cf864, "sideb");
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x1 linked
// Checksum 0x58ec1e93, Offset: 0x9d8
// Size: 0x5a
function function_6681bbf6() {
    var_65792f8b = map::get_script_bundle();
    if (!isdefined(var_65792f8b) || !isdefined(var_65792f8b.var_f9631c9d)) {
        return undefined;
    }
    return getscriptbundle(var_65792f8b.var_f9631c9d);
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x1 linked
// Checksum 0x86a25f50, Offset: 0xa40
// Size: 0x44
function function_4898fc47(var_52b46a06) {
    if (level.var_d1455682.var_3316a534 !== 1) {
        return false;
    }
    if (!isdefined(var_52b46a06.var_d74b6b9c)) {
        return false;
    }
    return true;
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x1 linked
// Checksum 0xde74d2dd, Offset: 0xa90
// Size: 0x70
function function_b69a4f47(var_2f252ea4) {
    clientfield::register("toplayer", var_2f252ea4.uniqueid, 1, 1, "int");
    if (is_true(var_2f252ea4.var_51388671)) {
        level.var_6e9fbf44[level.var_6e9fbf44.size] = var_2f252ea4;
    }
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x1 linked
// Checksum 0x840269ec, Offset: 0xb08
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
// Params 1, eflags: 0x1 linked
// Checksum 0xa5477145, Offset: 0xc00
// Size: 0x264
function function_fa3eed17(var_43a36c6f) {
    level callback::callback(#"hash_4428d68b23082312");
    level.var_b82a5c35 = 1;
    if (!isdefined(var_43a36c6f)) {
        return;
    }
    if (function_4898fc47(var_43a36c6f)) {
        thread scene::init_streamer(var_43a36c6f.var_d74b6b9c, #"all");
        return;
    }
    function_75125d25();
    level flag::wait_till_timeout(0.5, #"hash_22ca95de91eb92b");
    thread scene::init_streamer(var_43a36c6f.var_30a9de1, "sidea");
    thread scene::init_streamer(var_43a36c6f.var_704cf864, "sideb");
    thread scene::add_scene_func(var_43a36c6f.var_30a9de1, &function_a10bb198, "init", "sidea");
    thread scene::add_scene_func(var_43a36c6f.var_704cf864, &function_a10bb198, "init", "sideb");
    thread scene::add_scene_func(var_43a36c6f.var_30a9de1, &function_aad02bd0, "play", "sidea", var_43a36c6f.var_70e6c400);
    thread scene::add_scene_func(var_43a36c6f.var_704cf864, &function_aad02bd0, "play", "sideb", var_43a36c6f.var_a3282882);
    thread scene::add_scene_func(var_43a36c6f.var_30a9de1, &function_46c380f6, "done", "sidea");
    thread scene::add_scene_func(var_43a36c6f.var_704cf864, &function_46c380f6, "done", "sideb");
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x1 linked
// Checksum 0x21d72235, Offset: 0xe70
// Size: 0x2c
function function_24d0c33d() {
    setdvar(#"hash_6ae50e8489bccba9", 10000);
}

// Namespace namespace_66d6aa44/level_init
// Params 1, eflags: 0x40
// Checksum 0x85fb878a, Offset: 0xea8
// Size: 0x164
function event_handler[level_init] function_9347830c(*eventstruct) {
    lui::add_luimenu("full_screen_movie", &full_screen_movie::register);
    clientfield::register("world", "hide_intro_models", 1, 1, "int");
    clientfield::register_clientuimodel("closeLoadingMovie", 1, 1, "int", 1);
    callback::add_callback(#"hash_4fd893d99ecc3458", &function_a8506505);
    var_43a36c6f = function_6681bbf6();
    level.var_6e9fbf44 = [];
    function_e526b83(var_43a36c6f);
    level.var_23e297bc = 1;
    if (function_14956b80()) {
        level thread function_fa3eed17(var_43a36c6f);
    }
    if (function_41a307f8()) {
        function_24d0c33d();
    }
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x1 linked
// Checksum 0x1ca552c2, Offset: 0x1018
// Size: 0x110
function function_266bf421(team) {
    foreach (player in getplayers(team)) {
        spawn = function_77b7335(player.team, "start_spawn");
        if (isdefined(spawn)) {
            player dontinterpolate();
            player setorigin(spawn.origin);
            player setplayerangles(spawn.angles);
        }
    }
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x1 linked
// Checksum 0xea79cc7f, Offset: 0x1130
// Size: 0xe4
function function_27c20de5() {
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
// Checksum 0xad335a04, Offset: 0x1220
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
// Params 1, eflags: 0x1 linked
// Checksum 0x3830c802, Offset: 0x1380
// Size: 0x3c
function function_948a4239(waittime) {
    level endon(#"game_ended");
    wait waittime;
    function_ba9e4286();
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 3, eflags: 0x1 linked
// Checksum 0x53ca37fa, Offset: 0x13c8
// Size: 0xa4
function function_2259ff3c(callback, waittime, var_7a3dfae) {
    level endon(#"game_ended");
    waittime = max(0, waittime);
    [[ callback ]](var_7a3dfae, #"hash_15a3c76e013b75c1");
    wait waittime;
    level thread function_7703471b(var_7a3dfae);
    level flag::set(#"hash_15a3c76e013b75c1");
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x5 linked
// Checksum 0x3f41b8f0, Offset: 0x1478
// Size: 0x144
function private function_7703471b(var_7a3dfae) {
    array::thread_all(getplayers(), &val::set, #"hash_e582e563a685d4b", "freezecontrols", 1);
    array::thread_all(getplayers(), &val::set, #"hash_e582e563a685d4b", "disablegadgets", 1);
    wait var_7a3dfae;
    array::thread_all(getplayers(), &val::reset, #"hash_e582e563a685d4b", "freezecontrols");
    array::thread_all(getplayers(), &val::reset, #"hash_e582e563a685d4b", "disablegadgets");
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x1 linked
// Checksum 0x36609452, Offset: 0x15c8
// Size: 0x4c
function function_4fe2578f() {
    wait float(function_60d95f53()) / 1000 * 4;
    function_ba9e4286();
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 2, eflags: 0x0
// Checksum 0x68cbafba, Offset: 0x1620
// Size: 0x4ac
function function_e94b8e1a(var_66cbfaf2, *var_2a832857) {
    scenes = [];
    var_5a990409 = 0;
    level.var_ae517a5 = 1;
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
    thread function_948a4239(var_5a990409);
    if (level.var_6e9fbf44.size > 0) {
        foreach (player in getplayers()) {
            foreach (postfxbundle in level.var_6e9fbf44) {
                player clientfield::set_to_player(postfxbundle.uniqueid, 1);
            }
        }
    }
    if (function_41a307f8()) {
        thread function_4fe2578f();
    }
    scene::function_1e327c20(scenes);
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
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x1 linked
// Checksum 0x2e30634f, Offset: 0x1ad8
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
// Checksum 0xc1855f2f, Offset: 0x1b70
// Size: 0x5a
function function_cffd1b80(team) {
    var_2e4886d4 = function_cf2c009a(team);
    if (!isdefined(var_2e4886d4)) {
        return;
    }
    scenelength = scene::function_12479eba(var_2e4886d4);
    return scenelength;
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0x97dcb9ac, Offset: 0x1bd8
// Size: 0xe6
function function_7ef87935() {
    if (!function_41a307f8()) {
        return;
    }
    starttime = gettime();
    while (!isdefined(level.var_c1c633b5) && gettime() < starttime + getdvarint(#"hash_6ae50e8489bccba9", 0)) {
        waitframe(1);
    }
    if (!isdefined(level.var_c1c633b5)) {
        return;
    }
    timeremaining = getdvarint(#"hash_6ae50e8489bccba9", 0) - gettime() - level.var_c1c633b5;
    if (timeremaining > 0) {
        wait float(timeremaining) / 1000;
    }
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x1 linked
// Checksum 0x9cfb697, Offset: 0x1cc8
// Size: 0x38
function function_ba9e4286() {
    if (isdefined(level.intromovie)) {
        level notify(#"hash_17a43cf90df06446");
    }
    level.var_8efd30f2 = 1;
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x1 linked
// Checksum 0x9b573994, Offset: 0x1d08
// Size: 0x64
function function_f4ec1bf4() {
    self clientfield::set_player_uimodel("closeLoadingMovie", 1);
    self setclientuivisibilityflag("hud_visible", 1);
    self setclientuivisibilityflag("weapon_hud_visible", 1);
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x1 linked
// Checksum 0x6eb671d2, Offset: 0x1d78
// Size: 0x4c
function function_392b4c2f() {
    self endon(#"disconnect");
    level waittill(#"hash_17a43cf90df06446");
    if (!isdefined(self)) {
        return;
    }
    self function_f4ec1bf4();
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x1 linked
// Checksum 0x6d88459f, Offset: 0x1dd0
// Size: 0x70
function function_d380d64d() {
    if (is_true(level.intromovie)) {
        function_f5692e0c("intro_precinematic_loop", undefined, self);
        self thread function_392b4c2f();
        if (!isdefined(level.var_c1c633b5)) {
            level.var_c1c633b5 = gettime();
        }
    }
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x1 linked
// Checksum 0xc4aa2d7f, Offset: 0x1e48
// Size: 0x9c
function function_a8506505() {
    if (!function_41a307f8() || !isdefined(level.intromovie)) {
        self function_f4ec1bf4();
        return;
    }
    self lui::screen_fade_out(0, (0, 0, 0), undefined, 0);
    waittillframeend();
    function_d380d64d();
    self lui::screen_fade_in(0.5);
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0x8b87e735, Offset: 0x1ef0
// Size: 0xf4
function function_2aaeab97() {
    if (!function_14956b80()) {
        return;
    }
    player_insertion::function_63977a98(0);
    var_52b46a06 = function_6681bbf6();
    if (!isdefined(var_52b46a06.var_d74b6b9c)) {
        return;
    }
    player_insertion::function_d28162a2(isdefined(var_52b46a06.var_3545b69a) ? var_52b46a06.var_3545b69a : 0);
    player_insertion::function_1a50e8a5(isdefined(var_52b46a06.var_73a4076) ? var_52b46a06.var_73a4076 : 0);
    function_27c20de5();
    function_ba9e4286();
    scene::function_1e327c20(var_52b46a06.var_d74b6b9c);
}

