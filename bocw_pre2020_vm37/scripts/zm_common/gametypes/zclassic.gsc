#using script_113dd7f0ea2a1d4f;
#using script_165beea08a63a243;
#using script_32b18d9fb454babf;
#using script_3411bb48d41bd3b;
#using script_34ab99a4ca1a43d;
#using script_6b2d896ac43eb90;
#using script_7b1cd3908a825fdd;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;

#namespace zclassic;

// Namespace zclassic/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x50cbcfe9, Offset: 0x1c0
// Size: 0x18c
function event_handler[gametype_init] main(*eventstruct) {
    level.var_2f5a329e = 1;
    level.var_75c2c45f = 50;
    if (!isdefined(level.var_31028c5d)) {
        level.var_31028c5d = prototype_hud::register();
    }
    zm_gametype::main();
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level._game_module_custom_spawn_init_func = &zm_gametype::custom_spawn_init_func;
    level._game_module_stat_update_func = &zm_stats::survival_classic_custom_stat_update;
    level._round_start_func = &zm_round_logic::round_start;
    level thread function_a24232f4();
    namespace_58949729::function_5a12541e();
    level thread intro_cinematic();
    callback::on_round_end(&on_round_end);
    callback::add_callback(#"on_exfil_start", &on_exfil_start);
    callback::on_spawned(&on_player_spawn);
}

// Namespace zclassic/zclassic
// Params 1, eflags: 0x1 linked
// Checksum 0xf7a95eab, Offset: 0x358
// Size: 0x3c
function on_exfil_start(*params) {
    spawner::add_archetype_spawn_function(#"zombie", &function_7a3ebb8a);
}

// Namespace zclassic/zclassic
// Params 0, eflags: 0x1 linked
// Checksum 0xd19d6241, Offset: 0x3a0
// Size: 0x96
function function_7a3ebb8a() {
    self endon(#"death");
    if (self.targetname !== #"exfil_ai") {
        return;
    }
    self.var_90d0c0ff = "anim_spawn_from_ground";
    self namespace_85745671::function_2089690e();
    if (isdefined(self)) {
        self pathmode("move allowed");
        self.completed_emerging_into_playable_area = 1;
        self.zombie_think_done = 1;
    }
}

// Namespace zclassic/zclassic
// Params 0, eflags: 0x1 linked
// Checksum 0xd1c1fab4, Offset: 0x440
// Size: 0x1c
function onprecachegametype() {
    level.canplayersuicide = &zm_gametype::canplayersuicide;
}

// Namespace zclassic/zclassic
// Params 0, eflags: 0x1 linked
// Checksum 0x9cba9ea8, Offset: 0x468
// Size: 0x1a4
function onstartgametype() {
    zm_behavior::function_70a657d8();
    zm_cleanup::function_70a657d8();
    zm_spawner::init();
    zm_behavior::postinit();
    zm_cleanup::postinit();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    structs = struct::get_array("player_respawn_point", "targetname");
    foreach (struct in structs) {
        level.spawnmins = math::expand_mins(level.spawnmins, struct.origin);
        level.spawnmaxs = math::expand_maxs(level.spawnmaxs, struct.origin);
    }
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
}

// Namespace zclassic/zclassic
// Params 0, eflags: 0x1 linked
// Checksum 0x2a1293e4, Offset: 0x618
// Size: 0x74
function on_player_spawn() {
    self.specialty = self getloadoutperks(0);
    self zm::register_perks();
    if (!level.var_31028c5d prototype_hud::is_open(self)) {
        level.var_31028c5d prototype_hud::open(self, 1);
    }
}

// Namespace zclassic/zclassic
// Params 0, eflags: 0x5 linked
// Checksum 0x7ff5f1a3, Offset: 0x698
// Size: 0x184
function private intro_cinematic() {
    level flag::wait_till("initial_blackscreen_passed");
    if (isdefined(level.var_dfee7fc2) && !getdvarint(#"hash_39af51993585a73e", 0)) {
        level scene::play(level.var_dfee7fc2);
        level.var_dfee7fc2 = undefined;
        foreach (player in getplayers()) {
            player dontinterpolate();
            player setorigin(player.spectator_respawn.origin);
            player setplayerangles(player.spectator_respawn.angles);
        }
    }
    gamestate::set_state("playing");
}

// Namespace zclassic/zclassic
// Params 0, eflags: 0x1 linked
// Checksum 0xa5963912, Offset: 0x828
// Size: 0xe0
function function_a24232f4() {
    level flag::wait_till_all(array(#"gameplay_started"));
    level thread namespace_dbb31ff3::function_5a22584f();
    foreach (destination in level.var_7d45d0d4.var_d60029a6) {
        level thread namespace_18bbc38e::function_7c05a985(destination);
    }
}

// Namespace zclassic/zclassic
// Params 0, eflags: 0x1 linked
// Checksum 0x672372fe, Offset: 0x910
// Size: 0x84
function on_round_end() {
    if (level.round_number % 5 == 0) {
        level flag::wait_till("rbz_exfil_allowed");
        level flag::set("rbz_exfil_beacon_active");
        wait 60;
        level flag::clear("rbz_exfil_beacon_active");
    }
}

