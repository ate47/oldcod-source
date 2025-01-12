#using script_1029986e2bc8ca8e;
#using script_113dd7f0ea2a1d4f;
#using script_12538a87a80a2978;
#using script_13d5d0aa9140d362;
#using script_16b1b77a76492c6a;
#using script_176597095ddfaa17;
#using script_18077945bb84ede7;
#using script_19367cd29a4485db;
#using script_1caf36ff04a85ff6;
#using script_1cc417743d7c262d;
#using script_1cd534c7e79b126f;
#using script_20dc0f45753888c7;
#using script_2125dd4d7e4788a5;
#using script_215d7818c548cb51;
#using script_24f3f1ee839aae55;
#using script_2593b2b2f6452617;
#using script_2618e0f3e5e11649;
#using script_2c58d3845b17c25a;
#using script_2cc90e725816de14;
#using script_31de501a61836a3a;
#using script_327978c21d18692a;
#using script_32b18d9fb454babf;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_34ab99a4ca1a43d;
#using script_355c6e84a79530cb;
#using script_35b8a6927c851193;
#using script_3751b21462a54a7d;
#using script_392e0c2534797e47;
#using script_3e57cc1a9084fdd6;
#using script_44b0b8420eabacad;
#using script_45fdb6cec5580007;
#using script_4ccfb58a9443a60b;
#using script_4d1e366b77f0b4b;
#using script_4dca2ab120688fc;
#using script_5725a8301835a95d;
#using script_5961deb533dad533;
#using script_5a0c35b811c39bea;
#using script_5ab5be2e8aaf56f8;
#using script_5dd920e119223a7c;
#using script_5ff9bbe37f3310b0;
#using script_6155d71e1c9a57eb;
#using script_6167e26342be354b;
#using script_6708b08fd2751700;
#using script_69d94a292b5a26e3;
#using script_6a4a2311f8a4697;
#using script_6b2d896ac43eb90;
#using script_6dd97fb55af61274;
#using script_6fc1886ffe877d6;
#using script_6fc2be37feeb317b;
#using script_789f2367a00401d8;
#using script_7a5293d92c61c788;
#using script_7b1cd3908a825fdd;
#using script_7c3f86aa290a6354;
#using script_7d23fdb2ec5be027;
#using script_7d7ac1f663edcdc8;
#using script_7fc996fe8678852;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\hud_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_free_fall;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\weapons\weapon_utils;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;

#namespace zsurvival;

// Namespace zsurvival/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x8d569c35, Offset: 0x6e0
// Size: 0x8fc
function event_handler[gametype_init] main(*eventstruct) {
    level.is_survival = 1;
    level.aat_in_use = 1;
    level.var_28ebc1e8 = 1;
    level.player_out_of_playable_area_monitor = 0;
    level.var_fdba6f4b = &function_889c6660;
    level.var_9602c8b2 = &function_5d7d3382;
    level.random_pandora_box_start = 1;
    level.var_ea32773 = &on_end_game;
    val::register("b_ignore_fow_damage", 1);
    val::default_value("b_ignore_fow_damage", 0);
    /#
        level.var_37778628 = &function_37778628;
        level thread namespace_ce1f29cc::function_9b928fad();
    #/
    level.var_72a4153b = 0;
    clientfield::register_clientuimodel("hudItems.streamerLoadFraction", 1, 5, "float", 1);
    clientfield::register_clientuimodel("hudItems.wzLoadFinished", 1, 1, "int", 1);
    clientfield::function_5b7d846d("hudItems.warzone.reinsertionPassengerCount", 1, 7, "int");
    clientfield::register_clientuimodel("hudItems.alivePlayerCount", 1, 7, "int", 0);
    clientfield::register_clientuimodel("hudItems.alivePlayerCountEnemy", 1, 7, "int", 0);
    clientfield::register_clientuimodel("hudItems.aliveTeammateCount", 1, 7, "int", 1);
    clientfield::register_clientuimodel("hudItems.spectatorsCount", 1, 7, "int", 1);
    clientfield::register_clientuimodel("hudItems.playerKills", 1, 9, "int", 0);
    clientfield::register_clientuimodel("hudItems.playerCleanUps", 1, 7, "int", 0);
    clientfield::register_clientuimodel("presence.modeparam", 1, 7, "int", 1);
    clientfield::register_clientuimodel("hudItems.showReinsertionPassengerCount", 1, 1, "int", 0);
    clientfield::register_clientuimodel("hudItems.playerLivesRemaining", 1, 3, "int");
    clientfield::register_clientuimodel("hudItems.playerCanRedeploy", 1, 1, "int");
    clientfield::function_5b7d846d("hudItems.warzone.collapse", 1, 21, "int");
    clientfield::function_5b7d846d("hudItems.warzone.waveRespawnTimer", 1, 21, "int");
    clientfield::function_5b7d846d("hudItems.warzone.collapseIndex", 1, 3, "int");
    clientfield::function_5b7d846d("hudItems.warzone.collapseCount", 1, 3, "int");
    clientfield::function_5b7d846d("hudItems.warzone.reinsertionIndex", 1, 3, "int");
    clientfield::register("world", "set_objective_fog", 1, 2, "int");
    clientfield::function_5b7d846d("hudItems.team1.roundsWon", 1, 4, "int");
    clientfield::function_5b7d846d("hudItems.team2.roundsWon", 1, 4, "int");
    level thread function_57292af3();
    zm_gametype::main();
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level._game_module_custom_spawn_init_func = &zm_gametype::custom_spawn_init_func;
    level._game_module_stat_update_func = &zm_stats::survival_classic_custom_stat_update;
    level.customspawnlogic = &function_716def93;
    callback::on_game_playing(&on_game_playing);
    callback::on_ai_spawned(&on_ai_spawned);
    callback::on_ai_killed(&on_ai_killed);
    callback::on_bleedout(&on_bleedout);
    callback::add_callback(#"hash_17028f0b9883e5be", &function_e58dff05);
    callback::add_callback(#"objective_ended", &function_37c1c391);
    callback::add_callback(#"hash_3886c79a26cace38", &function_12cbe47e);
    spawner::add_global_spawn_function(level.zombie_team, &namespace_85745671::function_2089690e);
    callback::on_spawned(&on_player_spawn);
    var_cc6e64ae = getdvarint(#"hash_7255c78e5d6bfa33", 1);
    if (var_cc6e64ae < 1) {
        namespace_553954de::function_7c97e961(1);
    } else {
        namespace_553954de::function_7c97e961(var_cc6e64ae);
    }
    if (!getdvarint(#"hash_7f960fed9c1533f", 1)) {
        namespace_60c38ce9::function_855c828f(level.realm);
        namespace_60c38ce9::init();
    }
    namespace_ce1f29cc::function_15bf0b91(level.realm);
    setdvar(#"hash_40eb8467241c4747", 1);
    setdvar(#"hash_2f4280545354c82c", 1);
    setdvar(#"hash_2ac8ade37339f558", 0);
    level.var_13339abf = array(#"ammo_small_caliber_item_t9_sr", #"ammo_ar_item_t9_sr", #"ammo_large_caliber_item_t9_sr", #"ammo_sniper_item_t9_sr", #"ammo_shotgun_item_t9_sr", #"ammo_special_item_t9_sr");
    namespace_58949729::function_5a12541e();
    level.var_dcf5a517 = 1;
    namespace_d0ab5955::init();
    namespace_2c949ef8::init();
    level.progress_bar = luielembar::register();
    level.var_8e86256f = luielembar::register();
    level.var_478e1780 = luielembar::register();
    level.var_b108ea74 = luielembar::register();
    level thread function_33cac8e7();
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x0
// Checksum 0xb1ebd235, Offset: 0xfe8
// Size: 0x31c
function function_57292af3() {
    callback::on_connect(&function_ee7f9c09);
    level flag::set(#"hash_4930756571725d11");
    level flag::wait_till(#"hash_7ace2c0d668c5128");
    s_destination = level.var_7767cea8[0];
    if (isdefined(s_destination.target2) && !getdvarint(#"hash_2682124b2df6958e", 0)) {
        s_scene = struct::get(s_destination.target2);
        level scene::function_27f5972e(s_scene.scriptbundlename);
        level flag::wait_till("initial_blackscreen_passed");
        level thread namespace_9b972177::function_57292af3();
        level scene::play(s_destination.target2, "targetname");
        level scene::function_f81475ae(s_scene.scriptbundlename);
        /#
            if (getdvarint(#"hash_6a54249f0cc48945", 0)) {
                adddebugcommand("<dev string:x38>");
            }
        #/
        foreach (player in getplayers()) {
            player dontinterpolate();
            player setorigin(player.resurrect_origin);
            player setplayerangles(player.resurrect_angles);
        }
    }
    level flag::clear(#"hash_4930756571725d11");
    callback::remove_on_connect(&function_ee7f9c09);
    array::thread_all(getplayers(), &val::reset, "intro_scene", "b_ignore_fow_damage");
    gamestate::set_state("playing");
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x0
// Checksum 0xb5793a17, Offset: 0x1310
// Size: 0x2c
function function_ee7f9c09() {
    self val::set("intro_scene", "b_ignore_fow_damage", 1);
}

// Namespace zsurvival/zsurvival
// Params 1, eflags: 0x0
// Checksum 0xf8447665, Offset: 0x1348
// Size: 0x8a
function function_716def93(ispredictedspawn) {
    if (ispredictedspawn) {
        self.resurrect_origin = (0, 0, 0);
        self.resurrect_angles = (0, 0, 0);
        return 1;
    }
    if (game.state == "pregame" || game.state == "playing") {
        return function_aad874d();
    }
    return function_182a24df();
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x0
// Checksum 0x4c135307, Offset: 0x13e0
// Size: 0x2f0
function function_aad874d() {
    if (!isdefined(level.var_7767cea8)) {
        return false;
    }
    teammask = getteammask(self.team);
    for (teamindex = 0; teammask > 1; teamindex++) {
        teammask >>= 1;
    }
    destindex = teamindex % level.var_7767cea8.size;
    dest = level.var_7767cea8[destindex];
    var_c1a973a4 = int(teamindex / level.var_7767cea8.size);
    var_92438b9c = var_c1a973a4 * level.maxteamplayers % dest.spawns.size;
    self.var_25fe2d03 = dest.globalindex;
    spawn = undefined;
    spawntime = gettime();
    if (!isdefined(dest.spawns[var_92438b9c].spawntime)) {
        dest.spawns[var_92438b9c].spawntime = spawntime;
        spawn = dest.spawns[var_92438b9c];
    } else {
        var_f5bb80c2 = var_92438b9c;
        var_e34bb789 = dest.spawns[var_f5bb80c2].spawntime;
        for (idx = 0; idx < level.maxteamplayers; idx++) {
            spawnindex = (idx + var_92438b9c) % dest.spawns.size;
            if (!isdefined(dest.spawns[spawnindex].spawntime)) {
                dest.spawns[spawnindex].spawntime = spawntime;
                spawn = dest.spawns[spawnindex];
                break;
            }
            if (dest.spawns[spawnindex].spawntime < var_e34bb789) {
                var_f5bb80c2 = spawnindex;
                var_e34bb789 = dest.spawns[spawnindex].spawntime;
            }
        }
        if (!isdefined(spawn)) {
            dest.spawns[var_f5bb80c2].spawntime = spawntime;
            spawn = dest.spawns[var_f5bb80c2];
        }
    }
    self.resurrect_origin = spawn.origin;
    self.resurrect_angles = spawn.angles;
    self spawn(spawn.origin, spawn.angles, "zsurvival");
    return true;
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x0
// Checksum 0x37bb6084, Offset: 0x16d8
// Size: 0x258
function function_182a24df() {
    targetorigin = self.lastdeathpos;
    targetangles = self.angles;
    players = [];
    foreach (player in getplayers(self.team)) {
        if (player != self && isalive(player)) {
            players[players.size] = player;
        }
    }
    if (players.size > 0) {
        player = players[randomint(players.size)];
        targetorigin = player.origin;
        targetangles = player.angles;
    } else if (isdefined(self.lastdeathpos)) {
        targetorigin = self.lastdeathpos;
        if (isdefined(level.deathcircle) && isdefined(level.deathcircle.var_5c54ab33)) {
            targetangles = vectortoangles(level.deathcircle.var_5c54ab33.origin - targetorigin);
        }
    } else {
        return function_aad874d();
    }
    fwd = anglestoforward(targetangles);
    spawnorigin = targetorigin - fwd * 64 + (0, 0, 50);
    self.resurrect_origin = spawnorigin;
    self.resurrect_angles = vectortoangles(fwd);
    self spawn(self.resurrect_origin, self.resurrect_angles, "zsurvival");
    return 1;
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x0
// Checksum 0xa6049d7b, Offset: 0x1938
// Size: 0x22c
function on_player_spawn() {
    self.specialty = [];
    self.playleaderdialog = 1;
    targetplayer = undefined;
    if (isdefined(self.var_f4710251)) {
        targetplayer = getentbynum(self.var_f4710251);
    } else if (is_false(self.wasaliveatmatchstart) && getdvarint(#"hash_11cc747390ab2f74", 1)) {
        var_67e0ed8d = array::randomize(function_a1ef346b());
        foreach (player in var_67e0ed8d) {
            if (player != self) {
                targetplayer = player;
                break;
            }
        }
    }
    if (isdefined(targetplayer) && isalive(targetplayer)) {
        spawn = squad_spawn::function_e402b74e(self, targetplayer);
        if (isdefined(spawn) && isdefined(spawn.origin)) {
            self dontinterpolate();
            self setorigin(spawn.origin);
            self setplayerangles(spawn.angles);
        }
        self.var_f4710251 = undefined;
    }
    self player_free_fall::allow_player_basejumping(1);
    self squads::function_c70b26ea();
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x0
// Checksum 0x94ec8118, Offset: 0x1b70
// Size: 0x1c
function onprecachegametype() {
    level.canplayersuicide = &zm_gametype::canplayersuicide;
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x0
// Checksum 0xae8c55c, Offset: 0x1b98
// Size: 0x18c
function onstartgametype() {
    zm_behavior::function_70a657d8();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    structs = struct::get_array("player_respawn_point", "targetname");
    foreach (struct in structs) {
        level.spawnmins = math::expand_mins(level.spawnmins, struct.origin);
        level.spawnmaxs = math::expand_maxs(level.spawnmaxs, struct.origin);
    }
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawning::function_7a87efaa();
    level thread function_e93291ff();
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x0
// Checksum 0xc83f53a3, Offset: 0x1d30
// Size: 0x30e
function function_e93291ff() {
    destinations = array(function_fef3deb1());
    if (destinations.size <= 0 || !isdefined(destinations[0])) {
        return;
    }
    destinations = arraysortclosest(destinations, (0, 0, 0));
    for (destindex = 0; destindex < destinations.size; destindex++) {
        destinations[destindex].globalindex = destindex;
    }
    level.var_7767cea8 = [];
    /#
        if (getdvarint(#"hash_270a21a654a1a79f", 0)) {
            level.var_94cbd997 = [];
            foreach (destination in destinations) {
                level.var_94cbd997 = arraycombine(level.var_94cbd997, namespace_8b6a9d79::function_f703a5a(destination), 0, 0);
            }
        }
    #/
    var_137456fd = getdvarint(#"wz_dest_id", -1);
    if (var_137456fd >= 0 && var_137456fd < destinations.size) {
        level.var_7767cea8[0] = destinations[var_137456fd];
        arrayremoveindex(destinations, var_137456fd);
    } else {
        while (destinations.size > 0 && level.var_7767cea8.size < 5) {
            destindex = randomint(destinations.size);
            level.var_7767cea8[level.var_7767cea8.size] = destinations[destindex];
            arrayremoveindex(destinations, destindex);
        }
    }
    foreach (dest in level.var_7767cea8) {
        dest.spawns = namespace_8b6a9d79::function_f703a5a(dest);
    }
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x0
// Checksum 0xaceddb, Offset: 0x2048
// Size: 0x12c
function on_game_playing() {
    level flag::wait_till("start_zombie_round_logic");
    level thread globallogic_audio::leader_dialog("matchStart");
    level thread globallogic_audio::leader_dialog("matchStartResponse");
    if (!getdvarint(#"hash_7f960fed9c1533f", 1)) {
        level thread namespace_60c38ce9::function_cb67cef1();
    }
    level thread namespace_ce1f29cc::update_hotzone_states();
    level thread namespace_ce1f29cc::function_9e0aba37();
    level thread zm_powerups::powerup_round_start();
    level thread namespace_9b972177::function_5d985962(1);
    function_d547b972();
    level thread function_fbb2b180();
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x4
// Checksum 0xb12bcdf7, Offset: 0x2180
// Size: 0xc2
function private function_fbb2b180() {
    function_3ca3c6e4();
    resetglass();
    if (isdefined(level.var_82eb1dab)) {
        foreach (deathmodel in level.var_82eb1dab) {
            deathmodel delete();
        }
        level.var_82eb1dab = undefined;
    }
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x0
// Checksum 0xa7fd6f94, Offset: 0x2250
// Size: 0x54
function on_ai_spawned() {
    if (!isactor(self)) {
        return;
    }
    self function_8f8f0c52(800);
    self zm_score::function_82732ced();
}

// Namespace zsurvival/zsurvival
// Params 1, eflags: 0x0
// Checksum 0xcc39d2d8, Offset: 0x22b0
// Size: 0x64
function on_ai_killed(s_params) {
    if (!isactor(self)) {
        return;
    }
    if (!isplayer(s_params.eattacker)) {
        return;
    }
    self thread zm_powerups::function_b753385f(s_params.weapon);
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x0
// Checksum 0xf41c5520, Offset: 0x2320
// Size: 0x30
function on_bleedout() {
    wait 2;
    self thread function_3fd71c32();
    self thread [[ level.spawnclient ]](0);
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x0
// Checksum 0xc74bfb51, Offset: 0x2358
// Size: 0x62
function function_3fd71c32() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self waittill(#"spawned");
    if (self.currentspectatingclient > -1) {
        self.var_f4710251 = self.currentspectatingclient;
    }
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x0
// Checksum 0xe80c74f5, Offset: 0x23c8
// Size: 0xa
function function_889c6660() {
    wait 1;
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x0
// Checksum 0x3e88bfe, Offset: 0x23e0
// Size: 0xc0
function function_fef3deb1() {
    level flag::wait_till(#"hash_7ace2c0d668c5128");
    var_842cdacd = namespace_18bbc38e::function_f3be07d7(level.var_7d45d0d4.var_5f2429b1);
    var_58b02068 = struct::get(var_842cdacd[0].target, "targetname");
    assert(isdefined(var_58b02068), "<dev string:x4d>" + level.var_7d45d0d4.var_5f2429b1.targetname);
    return var_58b02068;
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x4
// Checksum 0x9d37e45b, Offset: 0x24a8
// Size: 0x22c
function private function_33cac8e7() {
    level endon(#"game_ended");
    level flag::wait_till(#"hash_7ace2c0d668c5128");
    destinations = namespace_18bbc38e::function_2e165386();
    triggers = undefined;
    if (isdefined(destinations) && getdvarint(#"hash_d07e35f920d16a8", 1)) {
        triggers = [];
        foreach (destination in destinations) {
            if (isdefined(destination.var_fe2612fe[#"hash_3460aae6bb799a99"])) {
                foreach (struct in destination.var_fe2612fe[#"hash_3460aae6bb799a99"]) {
                    triggers[triggers.size] = getent(struct.targetname, "target");
                }
            }
        }
    }
    if (!getdvarint(#"hash_7f960fed9c1533f", 1)) {
        namespace_60c38ce9::init(triggers);
    }
    namespace_85745671::function_b7dc3ab4(triggers);
}

// Namespace zsurvival/zsurvival
// Params 1, eflags: 0x0
// Checksum 0xbd7ac6e9, Offset: 0x26e0
// Size: 0x44
function on_end_game(*waitresult) {
    if (!is_true(level.var_1726e2c7)) {
        level globallogic_audio::leader_dialog("matchEndLose");
    }
}

// Namespace zsurvival/zsurvival
// Params 1, eflags: 0x0
// Checksum 0x5d19f776, Offset: 0x2730
// Size: 0x330
function give_custom_loadout(takeoldweapon) {
    self endon(#"disconnect");
    if (!isdefined(takeoldweapon)) {
        takeoldweapon = 0;
    }
    if (takeoldweapon) {
        oldweapon = self getcurrentweapon();
        weapons = self getweaponslist();
        foreach (weapon in weapons) {
            self takeweapon(weapon);
        }
    }
    nullprimary = getweapon(#"null_offhand_primary");
    self giveweapon(nullprimary);
    self setweaponammoclip(nullprimary, 0);
    self switchtooffhand(nullprimary);
    if (self.firstspawn !== 0) {
    }
    bare_hands = getweapon(#"bare_hands");
    self giveweapon(bare_hands);
    self function_c9a111a(bare_hands);
    self switchtoweapon(bare_hands, 1);
    if (self.firstspawn !== 0) {
        self setspawnweapon(bare_hands);
    }
    self.specialty = self getloadoutperks(0);
    self zm::register_perks();
    var_69126206 = [];
    var_2e1bd530 = [];
    var_2e1bd530[0] = 3;
    var_2e1bd530[1] = 1;
    var_2e1bd530[2] = 0;
    if (level.usingmomentum === 1) {
        for (sortindex = 0; sortindex < var_69126206.size && sortindex < var_2e1bd530.size; sortindex++) {
            if (var_69126206[sortindex].weapon != level.weaponnone) {
                self function_d9b9c4c6(var_2e1bd530[sortindex], var_69126206[sortindex].weapon);
            }
        }
    }
    self thread function_798c4aa9();
    return bare_hands;
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x0
// Checksum 0x8450d858, Offset: 0x2a68
// Size: 0x27c
function function_798c4aa9() {
    self endon(#"disconnect");
    self notify("4e415e02d4172f56");
    self endon("4e415e02d4172f56");
    item_world::function_4de3ca98();
    while (!isdefined(self.inventory) || self.sessionstate !== "playing" || game.state !== "playing") {
        waitframe(1);
    }
    backpack = function_4ba8fde(#"backpack_item");
    backpack.count = 1;
    var_fa3df96 = self item_inventory::function_e66dcff5(backpack);
    item_world::function_de2018e3(backpack, self, var_fa3df96);
    var_ea8725b3 = getdvarstring(#"hash_7187c1ee48f0a1a");
    if (!isdefined(var_ea8725b3) || var_ea8725b3 == "") {
        var_ea8725b3 = array::random(array(#"ar_accurate_t9_item_sr", #"shotgun_pump_t9_item_sr", #"shotgun_semiauto_t9_item_sr", #"smg_standard_t9_item_sr", #"tr_longburst_t9_item_sr"));
    }
    item_weapon = function_4ba8fde(var_ea8725b3);
    var_fa3df96 = self item_inventory::function_e66dcff5(item_weapon);
    self item_world::function_de2018e3(item_weapon, self, var_fa3df96);
    weapon = namespace_a0d533d1::function_2b83d3ff(item_weapon);
    self setweaponammostock(weapon, weapon.maxammo);
    level flag::set(#"hash_394b4c458bf65ee1");
}

// Namespace zsurvival/zsurvival
// Params 1, eflags: 0x0
// Checksum 0x7af33cf7, Offset: 0x2cf0
// Size: 0x1a4
function function_37c1c391(params) {
    changeadvertisedstatus(0);
    completed = params.completed;
    instance = params.instance;
    scriptname = instance.content_script_name;
    var_5fc990bf = 0;
    if (isdefined(scriptname)) {
        var_5fc990bf = objective_manager::function_ae039b4(scriptname);
    }
    foreach (player in getplayers()) {
        player luinotifyevent(#"hash_5b1ff06d07e9002a", 3, completed, 0, var_5fc990bf);
    }
    util::delay(30, "game_ended", &namespace_ce1f29cc::function_fca72198);
    level util::delay(20, "game_ended", &flag::set, #"hash_44074059e3987765");
}

// Namespace zsurvival/zsurvival
// Params 1, eflags: 0x0
// Checksum 0xd656294d, Offset: 0x2ea0
// Size: 0x3c
function function_e58dff05(*params) {
    namespace_ce1f29cc::function_368a7cde();
    level flag::clear(#"hash_44074059e3987765");
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x0
// Checksum 0xdcb260e7, Offset: 0x2ee8
// Size: 0x16c
function function_5d7d3382() {
    var_481bf1b8 = isdefined(level.var_b48509f9) ? level.var_b48509f9 : 1;
    var_3f20795a = var_481bf1b8 - 1;
    if (var_3f20795a <= 0) {
        var_3f20795a = 0;
    }
    var_30c91b24 = int(100 * (pow(1.1, var_3f20795a) - 1));
    var_16359d49 = int(100 * (pow(1.33, var_3f20795a) - 1));
    n_random = randomint(100);
    if (n_random <= var_30c91b24) {
        self namespace_85745671::function_9758722("super_sprint");
        return;
    }
    if (n_random <= var_16359d49) {
        self namespace_85745671::function_9758722("sprint");
        return;
    }
    self namespace_85745671::function_9758722("run");
}

// Namespace zsurvival/zsurvival
// Params 1, eflags: 0x0
// Checksum 0x43537c4d, Offset: 0x3060
// Size: 0x64
function function_12cbe47e(s_params) {
    hud::function_c9800094(s_params.eattacker, s_params.var_dcc8dd60, int(ceil(s_params.idamage)), s_params.type);
}

/#

    // Namespace zsurvival/zsurvival
    // Params 1, eflags: 0x0
    // Checksum 0x82e40dbc, Offset: 0x30d0
    // Size: 0x1be
    function function_37778628(var_cc6e64ae) {
        if (var_cc6e64ae > 0) {
            if (!isdefined(level.var_7a303742)) {
                level.var_7a303742 = level.var_b48509f9;
            }
            namespace_553954de::function_7c97e961(var_cc6e64ae);
            iprintlnbold("<dev string:x74>" + var_cc6e64ae);
        } else if (isdefined(level.var_7a303742)) {
            namespace_553954de::function_7c97e961(level.var_7a303742);
            level.var_7a303742 = undefined;
            iprintlnbold("<dev string:x85>");
        }
        a_ai = getaiarray();
        foreach (ai in a_ai) {
            if (isalive(ai)) {
                if (var_cc6e64ae > 0) {
                    if (!isdefined(ai.var_fd23b38f)) {
                        ai.var_fd23b38f = ai.health;
                    }
                    continue;
                }
                if (isdefined(ai.var_fd23b38f)) {
                    ai.health = ai.var_fd23b38f;
                    ai.var_fd23b38f = undefined;
                }
            }
        }
    }

#/
