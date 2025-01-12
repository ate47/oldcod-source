#using script_165beea08a63a243;
#using script_335d0650ed05d36d;
#using script_336275a0ba841d18;
#using script_340a2e805e35f7a2;
#using script_34ab99a4ca1a43d;
#using script_3e196d275a6fb180;
#using script_3e57cc1a9084fdd6;
#using script_44b0b8420eabacad;
#using script_4d1e366b77f0b4b;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\oob;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\zm\weapons\zm_weap_cymbal_monkey;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_spawner;

#namespace zonslaught;

// Namespace zonslaught/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xf25f4d4e, Offset: 0x2c0
// Size: 0x3ec
function event_handler[gametype_init] main(*eventstruct) {
    level.var_2f5a329e = 1;
    spawning::addsupportedspawnpointtype("tdm");
    println("<dev string:x38>");
    level.zm_disable_recording_stats = 1;
    level.dog_round_count = 0;
    clientfield::register("actor", "enemy_on_radar", 1, 1, "int");
    clientfield::register("scriptmover", "boss_zone_on_radar", 1, 2, "int");
    clientfield::register_clientuimodel("hudItems.onslaught.wave_number", 1, 7, "int");
    clientfield::register_clientuimodel("hudItems.onslaught.bosskill_count", 1, 7, "int");
    clientfield::register_clientuimodel("hudItems.onslaught.zombie_count", 1, 7, "int");
    clientfield::register_clientuimodel("hudItems.onslaught.time_min", 1, 7, "int");
    clientfield::register_clientuimodel("hudItems.onslaught.time_sec", 1, 6, "int");
    clientfield::register_clientuimodel("hudItems.onslaught.death_circle_countdown", 1, 6, "int");
    clientfield::register("toplayer", "onslaught_timer", 18000, getminbitcountfornum(540), "int");
    clientfield::register("scriptmover", "orb_spawn", 1, 1, "int");
    clientfield::register("scriptmover", "bot_claim_fx", 1, 2, "int");
    clientfield::register("actor", "orb_soul_capture_fx", 1, 3, "int");
    namespace_51f64aa9::function_2ce126c4();
    level.customspawnlogic = &function_716def93;
    level.var_6c4ec3fc = &function_8af3b312;
    level.var_64e71357 = 1;
    level.var_1f966535 = 4;
    level.var_b20199e0 = &function_b20199e0;
    level.var_b48509f9 = 4;
    level.resurrect_override_spawn = &overridespawn;
    setdvar(#"hash_36389ea046a2ce6", 1);
    setdvar(#"hash_42c75b39576494a5", 0);
    zm_gametype::main();
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    namespace_58949729::function_5a12541e();
    callback::on_spawned(&on_player_spawn);
}

// Namespace zonslaught/zonslaught
// Params 1, eflags: 0x0
// Checksum 0xa6128925, Offset: 0x6b8
// Size: 0x30c
function overridespawn(*ispredictedspawn) {
    if (isdefined(level.var_4d75ad83)) {
        if (!isdefined(self.resurrect_origin)) {
            self.resurrect_origin = level.var_4d75ad83.origin;
            self.resurrect_angles = level.var_4d75ad83.angles;
        }
        return true;
    }
    checkdist = 500;
    var_273a84a9 = [];
    if (!isdefined(var_273a84a9)) {
        var_273a84a9 = [];
    } else if (!isarray(var_273a84a9)) {
        var_273a84a9 = array(var_273a84a9);
    }
    var_273a84a9[var_273a84a9.size] = "tdm";
    if (!isdefined(var_273a84a9)) {
        var_273a84a9 = [];
    } else if (!isarray(var_273a84a9)) {
        var_273a84a9 = array(var_273a84a9);
    }
    var_273a84a9[var_273a84a9.size] = "ctf";
    var_8fb1964e = spawning::function_d400d613(#"mp_spawn_point", var_273a84a9);
    spawns = var_8fb1964e[#"tdm"];
    if (!isdefined(spawns)) {
        spawns = var_8fb1964e[#"ctf"];
    }
    var_8e971f37 = spawns[randomint(spawns.size)];
    var_8e971f37.used = 1;
    foreach (spawnpt in spawns) {
        if (is_true(spawnpt.used)) {
            continue;
        }
        var_b3dbfd56 = spawnpt.origin;
        distsq = distancesquared(var_b3dbfd56, var_8e971f37.origin);
        if (distsq < checkdist * checkdist) {
            level.var_4d75ad83 = spawnpt;
            level.var_4d75ad83.used = 1;
            break;
        }
    }
    if (!isdefined(self.resurrect_origin)) {
        self.resurrect_origin = var_8e971f37.origin;
        self.resurrect_angles = var_8e971f37.angles;
    }
    level.var_8a579fdb = var_8e971f37;
    return true;
}

// Namespace zonslaught/zonslaught
// Params 0, eflags: 0x0
// Checksum 0x97098358, Offset: 0x9d0
// Size: 0x2c
function function_b20199e0() {
    self namespace_65181344::function_fd87c780(#"special_ammo_drop", 1, 2);
}

// Namespace zonslaught/zonslaught
// Params 0, eflags: 0x0
// Checksum 0xdbbd256d, Offset: 0xa08
// Size: 0x14
function function_8af3b312() {
    spawning::addspawns();
}

// Namespace zonslaught/zonslaught
// Params 1, eflags: 0x0
// Checksum 0x6b54ba2a, Offset: 0xa28
// Size: 0x24
function function_716def93(predictedspawn) {
    self spawning::onspawnplayer(predictedspawn);
}

// Namespace zonslaught/zonslaught
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xa58
// Size: 0x4
function onprecachegametype() {
    
}

// Namespace zonslaught/zonslaught
// Params 1, eflags: 0x0
// Checksum 0x8f955432, Offset: 0xa68
// Size: 0x3c
function function_6878d990(ai_zombie) {
    ai_zombie endon(#"death");
    ai_zombie zm_cleanup::no_target_override(ai_zombie);
}

// Namespace zonslaught/zonslaught
// Params 0, eflags: 0x0
// Checksum 0x19b825ff, Offset: 0xab0
// Size: 0x2e4
function onstartgametype() {
    zm_behavior::function_70a657d8();
    zm_cleanup::function_70a657d8();
    zm_spawner::init();
    zm_behavior::postinit();
    zm_cleanup::postinit();
    spawning::function_7a87efaa();
    zm_powerups::powerup_round_start();
    if (isdefined(level.zombie_powerups[#"small_ammo"])) {
        level.zombie_powerups[#"small_ammo"].only_affects_grabber = 0;
    }
    if (isdefined(level.zombie_powerups[#"random_weapon"])) {
        level.zombie_powerups[#"random_weapon"].only_affects_grabber = 0;
    }
    if (isdefined(level.zombie_powerups[#"free_perk"])) {
        level.zombie_powerups[#"free_perk"].only_affects_grabber = 0;
    }
    if (isdefined(level.zombie_powerups[#"full_ammo"])) {
        level.zombie_powerups[#"full_ammo"].only_affects_grabber = 0;
    }
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    structs = struct::get_array("player_respawn_point", "targetname");
    foreach (struct in structs) {
        level.spawnmins = math::expand_mins(level.spawnmins, struct.origin);
        level.spawnmaxs = math::expand_maxs(level.spawnmaxs, struct.origin);
    }
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    level.do_randomized_zigzag_path = 0;
    level.no_target_override = &function_6878d990;
}

// Namespace zonslaught/zonslaught
// Params 0, eflags: 0x0
// Checksum 0x5a665e8f, Offset: 0xda0
// Size: 0x5a
function on_player_spawn() {
    self.specialty = self getloadoutperks(0);
    self zm::register_perks();
    self.var_f22c83f5 = 1;
    self.var_d66589da = 0;
    self.var_5d4c5daf = 0;
}

