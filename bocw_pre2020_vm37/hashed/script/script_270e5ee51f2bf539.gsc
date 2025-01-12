#using script_774302f762d76254;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\zm_gametype;

#namespace doa;

// Namespace doa/doa
// Params 0, eflags: 0x2
// Checksum 0xbc6dd1fc, Offset: 0x188
// Size: 0x34
function autoexec function_aeb1baea() {
    level.var_f18a6bd6 = &function_5e443ed1;
    waittillframeend();
    level.var_f18a6bd6 = &function_5e443ed1;
}

// Namespace doa/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x380b1f79, Offset: 0x1c8
// Size: 0x9c
function event_handler[gametype_init] main(*eventstruct) {
    level.var_6877b1e9 = 1;
    zm_gametype::main();
    level.onspawnplayerunified = undefined;
    level.onspawnplayer = &spawning::onspawnplayer;
    level.onplayerdisconnect = &globallogic::blank;
    callback::on_spawned(&on_player_spawned);
    level thread namespace_4dae815d::init();
}

// Namespace doa/doa
// Params 0, eflags: 0x0
// Checksum 0x8c6bdc5a, Offset: 0x270
// Size: 0x124
function function_5e443ed1() {
    level._loadstarted = 1;
    level.takelivesondeath = 0;
    level thread onallplayersready();
    level.aitriggerspawnflags = getaitriggerflags();
    level.vehicletriggerspawnflags = getvehicletriggerflags();
    level.var_82dda526 = 1;
    level.var_869c7fba = 1;
    level.defaultclass = "CLASS_CUSTOM1";
    level.weaponnone = getweapon(#"none");
    level.weaponnull = getweapon(#"weapon_null");
    level.numlives = 1;
    system::function_c11b0642();
    level flag::set(#"load_main_complete");
}

// Namespace doa/doa
// Params 0, eflags: 0x0
// Checksum 0x2e0807d, Offset: 0x3a0
// Size: 0x2cc
function onallplayersready() {
    level endon(#"game_ended");
    changeadvertisedstatus(0);
    while (isloadingcinematicplaying()) {
        wait 0.1;
    }
    while (!getnumexpectedplayers(1)) {
        wait 0.1;
    }
    player_count_actual = 0;
    while (player_count_actual < getnumexpectedplayers(1)) {
        players = getplayers();
        player_count_actual = 0;
        for (i = 0; i < players.size; i++) {
            if (players[i].sessionstate == "playing" && !isbot(players[i])) {
                player_count_actual++;
            }
        }
        println("<dev string:x38>" + getnumconnectedplayers() + "<dev string:x51>" + getnumexpectedplayers(1));
        wait 0.1;
    }
    setinitialplayersconnected();
    a_e_players = getplayers();
    if (a_e_players.size == 1) {
        level flag::set("solo_game");
        level.solo_lives_given = 0;
    }
    level flag::set("all_players_connected");
    function_9a8ab40f();
    while (!aretexturesloaded()) {
        wait 0.1;
    }
    level util::streamer_wait(undefined, 2, 30);
    level flag::set("initial_fade_in_complete");
    level flag::set("gameplay_started");
    level clientfield::set("gameplay_started", 1);
    changeadvertisedstatus(1);
}

// Namespace doa/doa
// Params 1, eflags: 0x0
// Checksum 0x30f805fe, Offset: 0x678
// Size: 0x3c
function function_d797f41f(n_waittime = 1) {
    wait n_waittime;
    music::setmusicstate("none");
}

// Namespace doa/doa
// Params 0, eflags: 0x0
// Checksum 0x750ef3d0, Offset: 0x6c0
// Size: 0xce
function function_9a8ab40f() {
    do {
        wait 0.1;
        var_183929a8 = 0;
        a_players = getplayers();
        foreach (player in a_players) {
            if (!player isloadingcinematicplaying()) {
                var_183929a8++;
            }
        }
    } while (a_players.size > var_183929a8);
}

// Namespace doa/doa
// Params 0, eflags: 0x0
// Checksum 0x20717a95, Offset: 0x798
// Size: 0x54
function on_player_spawned() {
    self val::reset(#"hash_5bb0dd6b277fc20c", "freezecontrols");
    self val::reset(#"hash_5bb0dd6b277fc20c", "disablegadgets");
}

// Namespace doa/doa
// Params 2, eflags: 0x0
// Checksum 0x54568fa2, Offset: 0x7f8
// Size: 0xa4
function default_onspawnspectator(origin, angles) {
    if (isdefined(origin) && isdefined(angles)) {
        self spawn(origin, angles);
        return;
    }
    arenas = struct::get_array("arena_center", "targetname");
    spawnpoint = arenas[0];
    self spawn(spawnpoint.origin, spawnpoint.angles);
}

