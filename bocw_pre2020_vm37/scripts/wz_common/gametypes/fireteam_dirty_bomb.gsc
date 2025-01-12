#using script_167b322dbacbc3f5;
#using script_1cc417743d7c262d;
#using script_1f41849126bfc83d;
#using script_335d0650ed05d36d;
#using script_340a2e805e35f7a2;
#using script_408211ac7ff6ef56;
#using script_44b0b8420eabacad;
#using script_471b31bd963b388e;
#using script_4ba46a0f73534383;
#using script_4e6bcfa8856b2a96;
#using script_7dc3a36c222eaf22;
#using script_b9a55edd207e4ca;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_world;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\perks;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\player\player_loadout;

#namespace fireteam_dirty_bomb;

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x6
// Checksum 0xab253194, Offset: 0x560
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_112a74f076cda31", &function_62730899, undefined, undefined, #"territory");
}

// Namespace fireteam_dirty_bomb/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x484dc416, Offset: 0x5b0
// Size: 0xd44
function event_handler[gametype_init] main(*eventstruct) {
    namespace_2938acdc::init();
    spawning::addsupportedspawnpointtype("tdm");
    level.var_61d4f517 = 1;
    level.onstartgametype = &onstartgametype;
    level.onscorelimit = &onscorelimit;
    callback::on_spawned(&onplayerspawned);
    callback::on_player_killed(&on_player_killed);
    callback::on_vehicle_spawned(&on_vehicle_spawned);
    callback::add_callback(#"hash_40cd438036ae13df", &function_1f93e91f);
    callback::add_callback(#"hash_740a58650e79dbfd", &function_c3623479);
    clientfield::register("toplayer", "using_bomb", 1, 2, "int");
    clientfield::register_clientuimodel("hudItems.uraniumCarryCount", 1, 4, "int");
    clientfield::register("toplayer", "ftdb_inZone", 1, 1, "int");
    clientfield::register("allplayers", "carryingUranium", 1, 1, "int");
    clientfield::register("scriptmover", "ftdb_zoneCircle", 1, 2, "int");
    level.dirtybombusebar = dirtybomb_usebar::register();
    level.var_2064692e = isdefined(getgametypesetting(#"hash_2c23b61a946618e5", 0)) ? getgametypesetting(#"hash_2c23b61a946618e5", 0) : 0;
    level.var_96cdb906 = isdefined(getgametypesetting(#"hash_78b20ae470a01292")) ? getgametypesetting(#"hash_78b20ae470a01292") : 0;
    level.var_73871ea9 = isdefined(getgametypesetting(#"hash_5e81c41c0b8501db")) ? getgametypesetting(#"hash_5e81c41c0b8501db") : 0;
    level.var_12ff620b = isdefined(getgametypesetting(#"hash_5427188d61d31f49")) ? getgametypesetting(#"hash_5427188d61d31f49") : 0;
    level.var_26c7635a = isdefined(getgametypesetting(#"hash_2eae1dd81a5d55d6")) ? getgametypesetting(#"hash_2eae1dd81a5d55d6") : 0;
    level.var_5a7ddc70 = isdefined(getgametypesetting(#"hash_6b7a67833a5d1ece")) ? getgametypesetting(#"hash_6b7a67833a5d1ece") : 0;
    level.var_3990ce92 = isdefined(getgametypesetting(#"hash_3ca893637b9e53ce")) ? getgametypesetting(#"hash_3ca893637b9e53ce") : 0;
    level.var_932f538d = isdefined(getgametypesetting(#"hash_2298689819f46c81")) ? getgametypesetting(#"hash_2298689819f46c81") : 0;
    level.var_e39b6425 = isdefined(getgametypesetting(#"hash_5e96d382e9e9c267")) ? getgametypesetting(#"hash_5e96d382e9e9c267") : 0;
    level.var_4e3c4685 = isdefined(getgametypesetting(#"hash_2115537cc1f85d3c")) ? getgametypesetting(#"hash_2115537cc1f85d3c") : 0;
    level.var_b06a1891 = isdefined(getgametypesetting(#"hash_448f94b2a3abdbb9")) ? getgametypesetting(#"hash_448f94b2a3abdbb9") : 0;
    level.var_f4a1440c = isdefined(getgametypesetting(#"hash_f9fc752cf48653")) ? getgametypesetting(#"hash_f9fc752cf48653") : 0;
    level.var_46f2c796 = isdefined(getgametypesetting(#"hash_982be25d9d36fcb")) ? getgametypesetting(#"hash_982be25d9d36fcb") : 0;
    level.var_451f847f = isdefined(getgametypesetting(#"hash_26632e4a6a693312")) ? getgametypesetting(#"hash_26632e4a6a693312") : 0;
    level.var_60693fca = (isdefined(getgametypesetting(#"hash_37aefeabeef0ec6c")) ? getgametypesetting(#"hash_37aefeabeef0ec6c") : 0) * 100;
    level.var_60e3f99c = 99999;
    level.var_77720414 = isdefined(getgametypesetting(#"hash_2778e754fc66aac")) ? getgametypesetting(#"hash_2778e754fc66aac") : 0;
    level.var_e65e9422 = isdefined(getgametypesetting(#"hash_540ba194e715168b")) ? getgametypesetting(#"hash_540ba194e715168b") : 0;
    level.var_5f31e806 = isdefined(getgametypesetting(#"hash_3c99ef02f267efaf")) ? getgametypesetting(#"hash_3c99ef02f267efaf") : 1;
    level.var_c836026 = isdefined(getgametypesetting(#"hash_3c7edd02f2510961")) ? getgametypesetting(#"hash_3c7edd02f2510961") : 5;
    level.var_3a9e7236 = is_true(getgametypesetting(#"hash_301e41804f45eb50"));
    level.var_2c9f7c6b = isdefined(getgametypesetting(#"hash_1cf5e61c49992dc3")) ? getgametypesetting(#"hash_1cf5e61c49992dc3") : 0;
    level.var_cd139dc0 = isdefined(getgametypesetting(#"hash_7f837b709840950")) ? getgametypesetting(#"hash_7f837b709840950") : 1;
    level.var_67432513 = isdefined(getgametypesetting(#"hash_6cd4374035db175e")) ? getgametypesetting(#"hash_6cd4374035db175e") : 0;
    level.var_d18d7655 = isdefined(getgametypesetting(#"hash_786ee581eedabff0")) ? getgametypesetting(#"hash_786ee581eedabff0") : 0;
    level.var_7108bd31 = isdefined(getgametypesetting(#"hash_eff3a2f99071600")) ? getgametypesetting(#"hash_eff3a2f99071600") : 0;
    level.var_c0839e43 = isdefined(getgametypesetting(#"hash_162ebc3912b68841")) ? getgametypesetting(#"hash_162ebc3912b68841") : 0;
    level.var_de7aa071 = isdefined(getgametypesetting(#"hash_570912155889089e")) ? getgametypesetting(#"hash_570912155889089e") : 0;
    level.var_aa6b51f5 = isdefined(getgametypesetting(#"hash_5d04a19b625d7300")) ? getgametypesetting(#"hash_5d04a19b625d7300") : 0;
    level.var_35b75d82 = isdefined(getgametypesetting(#"hash_371e83f096bf0548")) ? getgametypesetting(#"hash_371e83f096bf0548") : 0;
    namespace_681edb36::function_dd83b835();
    level thread function_afa7ee8d();
    item_world::function_861f348d(#"hash_75a7db904ba5faed", &function_18f58ab2);
    level.var_d539e0dd = &function_3f63e44f;
    level.var_2f418a15 = [];
    level.var_ac7be286 = [];
    level.var_d8fd137b = [];
    level.var_d8fd137b[0] = #"hash_2854f6c09dd9a316";
    level.var_d8fd137b[1] = #"hash_2854f5c09dd9a163";
    level.var_d8fd137b[2] = #"hash_2854f4c09dd99fb0";
    level.var_d8fd137b[3] = #"hash_2854fbc09dd9ab95";
    level.var_d8fd137b[4] = #"hash_2854fac09dd9a9e2";
    level.onrespawndelay = &playerrespawndelay;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0x6ef26fd9, Offset: 0x1300
// Size: 0x1a8
function private function_3f63e44f(item) {
    assert(isdefined(item));
    assert(isdefined(item.var_a6762160));
    if (item.var_a6762160.handler == #"hash_75a7db904ba5faed") {
        var_e3483afe = self clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
        if (5 > var_e3483afe) {
            return true;
        }
        return false;
    }
    if (item.var_a6762160.itemtype == #"scorestreak") {
        weapons = self getweaponslist();
        foreach (weapon in weapons) {
            var_16f12c31 = item_world_util::function_3531b9ba(weapon.name);
            if (isdefined(var_16f12c31) && self getweaponammostock(weapon) > 0) {
                return false;
            }
        }
    }
    return true;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 7, eflags: 0x4
// Checksum 0x60ed6a97, Offset: 0x14b0
// Size: 0x17a
function private function_18f58ab2(*item, player, *networkid, itemid, itemcount, *var_aec6fa7f, *slot) {
    level.var_17705e90 = var_aec6fa7f;
    var_e3483afe = itemcount clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
    pickup = int(min(5 - var_e3483afe, slot));
    itemcount clientfield::set_player_uimodel("hudItems.uraniumCarryCount", var_e3483afe + pickup);
    if (var_e3483afe + pickup > 0) {
        itemcount clientfield::set("carryingUranium", 1);
        itemcount function_53d7badf(1);
    }
    if (pickup > 0) {
        itemcount playsound("fly_uranium_pickup");
    }
    if (var_e3483afe + pickup >= 5) {
        itemcount globallogic_audio::leader_dialog_on_player("dirtyBombUraniumMaxHold");
    }
    return slot - pickup;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0x5b9d368f, Offset: 0x1638
// Size: 0x5c
function private function_62730899() {
    if (isdefined(level.territory) && level.territory.name != "zoo") {
        namespace_2938acdc::function_4212369d();
        namespace_2938acdc::function_20d09030();
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xcb58bb87, Offset: 0x16a0
// Size: 0xac
function onstartgametype() {
    if (level.var_96cdb906 != 0) {
        level thread function_8e2fb040();
    }
    if (level.var_2c9f7c6b) {
        level thread function_d897b60a();
    }
    level thread function_65f0fe7f();
    /#
        if (getdvarint(#"hash_26399e7b3c887ffb", 0)) {
            level thread function_64d94faa();
        }
    #/
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xa01da342, Offset: 0x1758
// Size: 0x7c
function onscorelimit() {
    if (!level.endgameonscorelimit) {
        return false;
    }
    round::function_870759fb();
    thread globallogic::end_round(3);
    while (level.var_2f418a15.size > 0) {
        level.var_2f418a15[0] function_91c39737();
    }
    return true;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x240e3c1e, Offset: 0x17e0
// Size: 0x94
function onplayerspawned() {
    self function_c3f27004();
    self.var_4ad2bfd3 = 0;
    self.var_cfc4949c = 1;
    self.var_6dc4d968 = 0;
    self clientfield::set_player_uimodel("hudItems.uraniumCarryCount", 0);
    self clientfield::set("carryingUranium", 0);
    self function_53d7badf(0);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0x1ddb364d, Offset: 0x1880
// Size: 0xe4
function on_player_killed(params) {
    aliveplayers = function_a1cff525(self.squad);
    if (aliveplayers.size == 0) {
        if (params.eattacker util::isenemyplayer(self)) {
            params.eattacker globallogic_audio::leader_dialog_on_player("dirtyBombFireteamWiped");
        }
        return;
    }
    if (aliveplayers.size == 1) {
        if (!isdefined(level.var_e2384c19) && !aliveplayers[0] laststand::player_is_in_laststand()) {
            aliveplayers[0] globallogic_audio::leader_dialog_on_player("dirtyBombFireteamWipedFriendly");
        }
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x519859cc, Offset: 0x1970
// Size: 0x54
function on_vehicle_spawned() {
    if (self.var_8e1ce84 === "helicopter_heavy") {
        globallogic_audio::function_61e17de0("dirtyBombVehSpawn", getplayers(undefined, self.origin, 1000));
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xf9600c4f, Offset: 0x19d0
// Size: 0x4c
function function_c3623479(vehicle) {
    globallogic_audio::function_61e17de0("dirtyBombVehSpawn", getplayers(undefined, vehicle.origin, 1000));
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xc7f7fd29, Offset: 0x1a28
// Size: 0x74
function function_1f93e91f(vehicletype) {
    if (isdefined(vehicletype)) {
        globallogic_audio::function_61e17de0("dirtyBombVehDrop", getplayers());
        return;
    }
    globallogic_audio::function_61e17de0("dirtyBombSupplyDrop", getplayers());
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xcd778243, Offset: 0x1aa8
// Size: 0xba
function function_c3f27004() {
    if (!isdefined(level.radiation)) {
        return;
    }
    if (level.radiation.levels.size <= 0) {
        return;
    }
    self.radiation = {};
    self.radiation.var_abd7d46a = level.radiation.levels[0].maxhealth;
    self.radiation.var_32adf91d = 0;
    self.radiation.sickness = [];
    self.radiation.var_393e0e31 = 0;
    self.radiation.var_f1c51b06 = 0;
    self.radiation.var_1389a65a = 0;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0x7a2539d1, Offset: 0x1b70
// Size: 0x1c4
function private function_15d1af86() {
    assert(isplayer(self));
    var_e3483afe = self clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
    var_468a16f = 1;
    if (isdefined(self.laststandparams) && isdefined(self.laststandparams.attacker) && isplayer(self.laststandparams.attacker) && self.laststandparams.attacker == self) {
        var_468a16f = 0;
    }
    var_e3483afe += var_468a16f;
    self clientfield::set_player_uimodel("hudItems.uraniumCarryCount", 0);
    self clientfield::set("carryingUranium", 0);
    self function_53d7badf(0);
    itempoint = function_4ba8fde(#"uranium_item_t9");
    for (index = 0; index < var_e3483afe; index++) {
        level thread item_drop::drop_item(index, undefined, 1, 0, itempoint.id, self.origin, (0, randomintrange(0, 360), 0), 2);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0x604c0e4d, Offset: 0x1d40
// Size: 0xcc
function private drop_armor() {
    assert(isplayer(self));
    itempoint = function_4ba8fde(#"hash_fb37841b0d2d7e7");
    for (index = 0; index < self.var_7d7d976a; index++) {
        level thread item_drop::drop_item(index, undefined, 1, 0, itempoint.id, self.origin, (0, randomintrange(0, 360), 0), 2);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0xeb56400, Offset: 0x1e18
// Size: 0x204
function private function_d5766919() {
    assert(isplayer(self));
    weapons = self getweaponslist();
    foreach (weapon in weapons) {
        var_16f12c31 = item_world_util::function_3531b9ba(weapon.name);
        if (!isdefined(var_16f12c31)) {
            continue;
        }
        hasammo = self getweaponammostock(weapon) > 0;
        if (hasammo) {
            itempoint = function_4ba8fde(var_16f12c31);
            level thread item_drop::drop_item(0, undefined, 1, 0, itempoint.id, self.origin, (0, randomintrange(0, 360), 0), 2);
            killstreakbundle = getscriptbundle(itempoint.var_a6762160.killstreak);
            killstreaks::take(killstreakbundle.var_d3413870);
            self takeweapon(weapon);
        }
    }
    self.pers[#"killstreaks"] = [];
}

// Namespace fireteam_dirty_bomb/player_killed
// Params 1, eflags: 0x40
// Checksum 0x8130d630, Offset: 0x2028
// Size: 0xaa
function event_handler[player_killed] codecallback_playerkilled(*eventstruct) {
    if (sessionmodeiswarzonegame() && isplayer(self)) {
        self function_80d6d39b();
        self.var_9dc65a85 = 0;
        function_15d1af86();
        drop_armor();
        function_d5766919();
        if (!isdefined(level.var_e2384c19)) {
            self.var_6dc4d968 = 1;
        }
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x2b93bb4, Offset: 0x20e0
// Size: 0xcc
function playerrespawndelay() {
    var_d34d1e15 = 0;
    if (is_true(level.waverespawndelay)) {
        var_d34d1e15 = self globallogic_spawn::timeuntilwavespawn(level.playerrespawndelay);
    } else {
        var_d34d1e15 = level.playerrespawndelay;
    }
    if (isdefined(level.var_e2384c19) && !is_true(self.var_6dc4d968)) {
        var_18947c8c = level.var_e2384c19 - float(gettime()) / 1000;
        if (var_18947c8c > var_d34d1e15) {
            return var_18947c8c;
        }
    }
    return var_d34d1e15;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xfff0ae74, Offset: 0x21b8
// Size: 0x706
function function_d897b60a() {
    level endon(#"game_ended");
    var_1a1c0d86 = 0;
    while (true) {
        foreach (index, player in getplayers()) {
            if (index % 10 == var_1a1c0d86) {
                if (!isdefined(player.radiation)) {
                    continue;
                }
                var_56bea7c = 0;
                if (player.sessionstate != "playing" || !isalive(player)) {
                    player.radiation.var_abd7d46a = level.radiation.levels[0].maxhealth;
                    var_56bea7c = player.radiation.var_32adf91d != 0;
                    player.radiation.var_32adf91d = 0;
                    player.radiation.var_f1c51b06 = 0;
                    if (var_56bea7c) {
                        player function_6ade1bbf();
                    }
                    player function_3c1f8280();
                    player clientfield::set_to_player("ftdb_inZone", 0);
                    continue;
                }
                var_cc03b04e = player clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
                var_4a68766 = player function_8e4e3bb2();
                if (var_4a68766) {
                    player clientfield::set_to_player("ftdb_inZone", 1);
                } else {
                    player clientfield::set_to_player("ftdb_inZone", 0);
                }
                if (var_cc03b04e > 0 || var_4a68766) {
                    if (gettime() >= player.radiation.var_f1c51b06 + level.var_a6cec0dc) {
                        scalar = var_cc03b04e * level.var_159e6a83;
                        player.radiation.var_abd7d46a -= scalar * level.var_c4b33b66;
                        if (var_4a68766) {
                            player.radiation.var_abd7d46a -= level.var_ee660ce0;
                        }
                        while (player.radiation.var_abd7d46a < 0 && player.radiation.var_32adf91d < level.var_c43aac04) {
                            player.radiation.var_32adf91d++;
                            player.radiation.var_abd7d46a += level.radiation.levels[player.radiation.var_32adf91d].maxhealth;
                            var_56bea7c = 1;
                        }
                        if (player.radiation.var_abd7d46a < 0) {
                            player.radiation.var_abd7d46a = 0;
                        }
                        if (var_56bea7c) {
                            player function_6ade1bbf();
                            player globallogic_audio::leader_dialog_on_player("dirtyBombRadStage" + player.radiation.var_32adf91d);
                        }
                        player function_3c1f8280();
                        player.radiation.var_f1c51b06 = gettime();
                    }
                } else {
                    if (player.radiation.var_32adf91d == 0 && player.radiation.var_abd7d46a >= level.radiation.levels[0].maxhealth) {
                        if (is_true(player.var_cfc4949c)) {
                            player.var_cfc4949c = undefined;
                            player function_6ade1bbf();
                        }
                        player function_3c1f8280();
                        continue;
                    }
                    if (gettime() >= player.radiation.var_f1c51b06 + level.var_bb0c0222) {
                        player.radiation.var_abd7d46a += level.var_f569833a;
                        while (player.radiation.var_32adf91d > 0 && player.radiation.var_abd7d46a > level.radiation.levels[player.radiation.var_32adf91d].maxhealth) {
                            player.radiation.var_abd7d46a -= level.radiation.levels[player.radiation.var_32adf91d].maxhealth;
                            player.radiation.var_32adf91d--;
                            var_56bea7c = 1;
                        }
                        if (player.radiation.var_abd7d46a > level.radiation.levels[player.radiation.var_32adf91d].maxhealth) {
                            player.radiation.var_abd7d46a = level.radiation.levels[player.radiation.var_32adf91d].maxhealth;
                        }
                        player function_3c1f8280();
                        if (var_56bea7c) {
                            player function_6ade1bbf();
                        }
                        player.radiation.var_f1c51b06 = gettime();
                    }
                }
                player function_9b065f90();
            }
        }
        var_1a1c0d86 = (var_1a1c0d86 + 1) % 10;
        waitframe(1);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0x289ba9f8, Offset: 0x28c8
// Size: 0x172
function private function_65f0fe7f() {
    level endon(#"game_ended");
    while (true) {
        foreach (player in getplayers()) {
            if (!isalive(player) || player inlaststand()) {
                continue;
            }
            isbuttonpressed = player function_28655ef2() || player actionslottwobuttonpressed();
            if (!isbuttonpressed || is_false(player.var_c60ad697)) {
                player.var_c60ad697 = !isbuttonpressed;
                continue;
            }
            player.var_c60ad697 = 0;
            player function_f917644c();
        }
        waitframe(1);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x382035a3, Offset: 0x2a48
// Size: 0x18c
function function_f917644c() {
    var_cc03b04e = self clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
    if (var_cc03b04e == 0) {
        return;
    }
    dropitem = self item_drop::drop_item(0, undefined, 1, 1, level.var_17705e90, self.origin + anglestoforward(self.angles) * randomfloatrange(10, 30), self.angles + (0, randomintrange(-30, 30), 0), 2);
    dropitem item_drop::function_801fcc9e(int(2 * 1000));
    self clientfield::set_player_uimodel("hudItems.uraniumCarryCount", var_cc03b04e - 1);
    self.var_4ad2bfd3 = gettime();
    self function_58b29f4f();
    var_cc03b04e = self clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
    if (var_cc03b04e <= 0) {
        function_53d7badf(0);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xe4b73eb8, Offset: 0x2be0
// Size: 0x96
function function_9b065f90() {
    if (self.radiation.var_32adf91d == level.var_4fdf11d8) {
        if (gettime() >= self.radiation.var_1389a65a + level.var_77a24482) {
            self dodamage(level.var_f87355e5, self.origin, undefined, undefined, "none", "MOD_DEATH_CIRCLE", 0, level.weaponnone);
            self.radiation.var_1389a65a = gettime();
        }
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x3c5dba2b, Offset: 0x2c80
// Size: 0x284
function function_6ade1bbf() {
    if (self.radiation.var_32adf91d == level.var_4fdf11d8) {
        namespace_6615ea91::function_59621e3c(self, #"dot");
    }
    if (self.radiation.var_32adf91d >= 2) {
        self.heal.var_c8777194 = 1;
        self.n_regen_delay = 9;
        namespace_6615ea91::function_59621e3c(self, #"hash_53d8a06b13ec49d9");
    } else {
        self.n_regen_delay = 1;
    }
    if (self.radiation.var_32adf91d >= 1) {
        self function_e6f9e3cd();
        self perks::perk_reset_all();
        self function_b5feff95(#"specialty_sprint");
        self function_b5feff95(#"specialty_sprintreload");
        self function_b5feff95(#"specialty_forwardspawninteract");
        self function_b5feff95(#"specialty_slide");
        self function_b5feff95(#"specialty_sprintheal");
        self perks::perk_setperk(#"specialty_sprint");
        self perks::perk_setperk(#"specialty_sprintreload");
        self perks::perk_setperk(#"specialty_forwardspawninteract");
        self perks::perk_setperk(#"specialty_slide");
        self perks::perk_setperk(#"specialty_sprintheal");
        namespace_6615ea91::function_59621e3c(self, #"disable_perks");
        return;
    }
    self loadout::give_talents();
    self loadout::give_perks();
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x994f2d13, Offset: 0x2f10
// Size: 0xb4
function function_3c1f8280() {
    namespace_6615ea91::function_137e7814(self, self.radiation.var_32adf91d);
    var_60ece81c = level.radiation.levels[self.radiation.var_32adf91d].maxhealth;
    percenthealth = self.radiation.var_abd7d46a / var_60ece81c;
    namespace_6615ea91::function_835a6746(self, percenthealth);
    namespace_6615ea91::function_36a2c924(self, 1 - percenthealth);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xfca38242, Offset: 0x2fd0
// Size: 0x232
function function_8e4e3bb2() {
    foreach (var_9bbce2cd in level.var_ac7be286) {
        var_8e392e0f = level.var_cd139dc0 * var_9bbce2cd.var_b06ed2fa getscale();
        if (function_a5f0096a(self.origin, var_9bbce2cd.origin) < var_8e392e0f * var_8e392e0f) {
            return true;
        }
        var_d9612d9 = var_9bbce2cd.var_261dd536;
        for (var_1fa72977 = var_d9612d9 + 1; function_a5f0096a(self.origin, var_9bbce2cd.origin) < (var_1fa72977 * 1000 + 1000) * (var_1fa72977 * 1000 + 1000) && var_1fa72977 > 0; var_1fa72977--) {
        }
        if (var_1fa72977 > var_d9612d9) {
            continue;
        }
        if (var_9bbce2cd.var_e17ae8be.size > var_1fa72977 - 1 && var_1fa72977 > 0) {
            if (self function_c7c0cee2(var_9bbce2cd, var_1fa72977 - 1)) {
                return true;
            }
        }
        if (var_9bbce2cd.var_e17ae8be.size > var_1fa72977) {
            if (self function_c7c0cee2(var_9bbce2cd, var_1fa72977)) {
                return true;
            }
        }
        if (var_9bbce2cd.var_e17ae8be.size > var_1fa72977 + 1) {
            if (self function_c7c0cee2(var_9bbce2cd, var_1fa72977 + 1)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x0
// Checksum 0x8cf522af, Offset: 0x3210
// Size: 0xc0
function function_c7c0cee2(var_9bbce2cd, var_d9612d9) {
    for (i = 0; i < var_9bbce2cd.var_e17ae8be[var_d9612d9].size; i++) {
        var_ac287808 = var_9bbce2cd.var_e17ae8be[var_d9612d9][i];
        if (!isdefined(var_ac287808.model.var_301e0bf7)) {
            continue;
        }
        if (function_a5f0096a(self.origin, var_ac287808.origin) < var_ac287808.model.var_301e0bf7 * var_ac287808.model.var_301e0bf7) {
            return true;
        }
    }
    return false;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x9f1c3af2, Offset: 0x32d8
// Size: 0x3ee
function function_8e2fb040() {
    level endon(#"game_ended");
    level.dirtybombs = struct::get_array("fireteam_dirty_bomb", "variantname");
    if (level.dirtybombs.size == 0) {
        return;
    }
    function_87b2107c(level.dirtybombs);
    foreach (bomb in level.dirtybombs) {
        bomb.state = 0;
    }
    function_693f50f5();
    level flag::wait_till(#"insertion_begin_completed");
    while (true) {
        function_c5d8437d();
        if (level.var_4e3c4685 != 0) {
            setmatchflag("bomb_timer_a", 1);
            setbombtimer("A", int(gettime() + 1000 + int(level.var_4e3c4685 * 1000)));
            wait level.var_4e3c4685;
            setbombtimer("A", 0);
            setmatchflag("bomb_timer_a", 0);
            function_a05584ae();
        } else {
            while (true) {
                var_d8b86297 = 0;
                for (i = 0; i < level.var_2f418a15.size; i++) {
                    if (level.var_2f418a15[i].state != 0) {
                        var_d8b86297 = 1;
                        break;
                    }
                }
                if (!var_d8b86297) {
                    break;
                }
                waitframe(1);
            }
        }
        function_693f50f5();
        if (level.var_26c7635a != 0) {
            level.var_e2384c19 = float(gettime()) / 1000 + level.var_26c7635a;
            foreach (player in level.players) {
                if (!isalive(player)) {
                    player notify(#"hash_33713849648e651d");
                }
            }
            if (level.var_12ff620b < level.var_26c7635a) {
                wait level.var_12ff620b;
                function_1c3c84b4();
                wait level.var_26c7635a - level.var_12ff620b;
            } else {
                wait level.var_26c7635a;
            }
            level.var_e2384c19 = undefined;
        }
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0x973dc454, Offset: 0x36d0
// Size: 0x12a
function function_87b2107c(&structs) {
    var_e8a4ae59 = 64;
    var_a3c01952 = 1024;
    foreach (struct in structs) {
        startorigin = struct.origin + (0, 0, var_e8a4ae59);
        endorigin = startorigin - (0, 0, var_a3c01952);
        trace = physicstraceex(startorigin, endorigin, (-0.5, -0.5, -0.5), (0.5, 0.5, 0.5), undefined, 1);
        struct.origin = trace[#"position"];
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xd4eba4c2, Offset: 0x3808
// Size: 0x54
function function_693f50f5() {
    if (level.var_2064692e == 0) {
        function_ceb4a5e9();
        return;
    }
    if (level.var_2064692e == 1) {
        function_5757c66f();
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x2fd023c8, Offset: 0x3868
// Size: 0x21c
function function_ceb4a5e9() {
    if (level.dirtybombs.size < level.var_96cdb906) {
        level.dirtybombs = struct::get_array("fireteam_dirty_bomb", "variantname");
    }
    for (i = 0; i < level.var_96cdb906; i++) {
        var_f4f4fee1 = randomint(level.dirtybombs.size);
        var_5c73f0a2 = 0;
        attempts = 0;
        do {
            foreach (bomb in level.var_2f418a15) {
                if (bomb == level.dirtybombs[var_f4f4fee1]) {
                    var_f4f4fee1 = randomint(level.dirtybombs.size);
                    var_5c73f0a2 = 1;
                    attempts++;
                    break;
                }
            }
            if (var_5c73f0a2) {
                var_f4f4fee1 = randomint(level.dirtybombs.size);
            }
        } while (var_5c73f0a2 && attempts < 10);
        level.var_2f418a15[level.var_2f418a15.size] = level.dirtybombs[var_f4f4fee1];
        level.dirtybombs[var_f4f4fee1] = level.dirtybombs[level.dirtybombs.size - 1];
        level.dirtybombs[level.dirtybombs.size - 1] = undefined;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x8a3646de, Offset: 0x3a90
// Size: 0x17c
function function_5757c66f() {
    if (!isdefined(level.var_d83e193a) || level.var_d83e193a.size <= 0) {
        function_18b08e66();
    }
    var_704364cb = getarraykeys(level.var_d83e193a);
    setindex = randomint(var_704364cb.size);
    var_2a0f16b1 = var_704364cb[setindex];
    level.var_d83e193a[var_2a0f16b1] = undefined;
    var_2e89cb0a = 0;
    foreach (bomb in level.dirtybombs) {
        if (bomb.state != 0) {
            continue;
        }
        if (bomb.var_6956912d == var_2a0f16b1) {
            level.var_2f418a15[level.var_2f418a15.size] = bomb;
            var_2e89cb0a++;
        }
        if (var_2e89cb0a >= level.var_96cdb906) {
            break;
        }
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x2803e0cf, Offset: 0x3c18
// Size: 0xc4
function function_18b08e66() {
    if (!isdefined(level.var_d83e193a)) {
        level.var_d83e193a = [];
    }
    foreach (bomb in level.dirtybombs) {
        if (!isdefined(level.var_d83e193a[bomb.var_6956912d])) {
            level.var_d83e193a[bomb.var_6956912d] = bomb.var_6956912d;
        }
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 3, eflags: 0x0
// Checksum 0x5ea5ab79, Offset: 0x3ce8
// Size: 0x110
function function_a9d8729c(dialogkey, origin, radius) {
    var_4b3fe4a6 = [];
    nearbyplayers = getplayers(undefined, origin, radius);
    foreach (player in nearbyplayers) {
        if (!array::contains(var_4b3fe4a6, player.team)) {
            var_4b3fe4a6[var_4b3fe4a6.size] = player.team;
            globallogic_audio::leader_dialog(dialogkey, player.team);
        }
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xc34b5ad6, Offset: 0x3e00
// Size: 0x1e4
function function_c5d8437d() {
    for (i = 0; i < level.var_2f418a15.size; i++) {
        bomb = level.var_2f418a15[i];
        if (!isdefined(bomb.state) || bomb.state == 0) {
            bomb.objindex = i % 5;
            bomb function_f37d284();
            bomb function_b801b00c();
        } else if (isdefined(bomb.state) && bomb.state != 1) {
            continue;
        }
        bomb function_fb51b5a4();
        objective_setgamemodeflags(bomb.objectiveid, 2);
        bomb.var_cc03b04e = 0;
        bomb.state = 2;
    }
    if (!is_true(level.var_169e6bcb)) {
        globallogic_audio::function_61e17de0("dirtyBombOnline", getplayers());
        level.var_169e6bcb = 1;
        return;
    }
    globallogic_audio::function_61e17de0("dirtyBombActive" + level.var_2f418a15.size, getplayers());
    globallogic_audio::function_61e17de0("dirtyBombRespawnEnabled", getplayers());
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x8c82ac7b, Offset: 0x3ff0
// Size: 0xba
function function_1c3c84b4() {
    for (i = 0; i < level.var_2f418a15.size; i++) {
        bomb = level.var_2f418a15[i];
        if (isdefined(bomb.state) && bomb.state != 0) {
            continue;
        }
        bomb.objindex = i % 5;
        bomb function_f37d284();
        bomb function_b801b00c();
        bomb.state = 1;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0x80cd3847, Offset: 0x40b8
// Size: 0x54
function private function_f37d284() {
    self.model = spawn("script_model", self.origin + (0, 0, 0));
    self.model setmodel("p9_dirty_bomb");
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0xafd9f53d, Offset: 0x4118
// Size: 0x64
function private function_b801b00c() {
    self.objectiveid = gameobjects::get_next_obj_id();
    objective = level.var_d8fd137b[self.objindex];
    objective_add(self.objectiveid, "active", self.model, objective);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0xa11f2147, Offset: 0x4188
// Size: 0x182
function private function_fb51b5a4() {
    self.trigger = spawn("trigger_radius", self.origin + (0, 0, 12), 0, 120, 90, 1);
    self.trigger triggerignoreteam();
    self.trigger triggerenable(1);
    self.trigger callback::on_trigger(&function_fcc87504);
    self.trigger setinvisibletoall();
    foreach (player in getplayers()) {
        if (function_a4521a9b(player)) {
            self.trigger setinvisibletoplayer(player, 0);
        }
    }
    self.trigger.bomb = self;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0x68ad5e12, Offset: 0x4318
// Size: 0x1d4
function private function_fcc87504(var_7d32de2) {
    if (is_true(level.gameended)) {
        return;
    }
    activator = var_7d32de2.activator;
    if (is_true(activator.var_9dc65a85)) {
        return;
    }
    bomb = self.bomb;
    if (!function_a4521a9b(activator)) {
        return;
    }
    activator playloopsound(#"hash_444112674e0eba78");
    success = activator function_99898a2d(bomb);
    var_452b50cb = success;
    while (success && bomb.state == 2) {
        if (!function_a4521a9b(activator)) {
            break;
        }
        self triggerenable(1);
        success = activator function_99898a2d(bomb);
    }
    activator stoploopsound();
    var_a5d31314 = activator clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
    if (bomb.state == 2 && var_a5d31314 <= 0) {
        bomb.model playsoundtoplayer(#"hash_1cc6a788d45a7d48", activator);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0xd9db3172, Offset: 0x44f8
// Size: 0x190
function private function_99898a2d(bomb) {
    self endon(#"disconnect");
    trigger = bomb.trigger;
    success = 0;
    if (isdefined(bomb)) {
        prevtime = gettime();
        var_e18791f4 = int(level.var_932f538d * 1000);
        totalprogress = 0;
        bomb thread function_704fdca0(self);
        while (self function_ce8f2021(bomb)) {
            progress = gettime() - prevtime;
            totalprogress += progress;
            prevtime = gettime();
            if (totalprogress >= var_e18791f4) {
                success = 1;
                bomb thread function_3b72c4b2(self);
                break;
            }
            if (totalprogress > 0) {
                self function_9db99d2f(totalprogress / var_e18791f4);
            }
            waitframe(1);
        }
        if (!success) {
            bomb thread function_ea25bba7(self);
        }
    }
    self function_80d6d39b(&function_a4521a9b);
    return success;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xda3f404d, Offset: 0x4690
// Size: 0x48
function function_a4521a9b(player) {
    var_cc03b04e = player clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
    if (var_cc03b04e > 0) {
        return true;
    }
    return false;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xc493e0fd, Offset: 0x46e0
// Size: 0xb6
function function_ce8f2021(bomb) {
    if (bomb.state != 2) {
        return false;
    }
    if (!isalive(self)) {
        return false;
    }
    if (self inlaststand()) {
        return false;
    }
    if (!isdefined(bomb.trigger)) {
        return false;
    }
    if (!bomb.trigger istriggerenabled()) {
        return false;
    }
    if (!self istouching(bomb.trigger)) {
        return false;
    }
    return true;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0x685ba61a, Offset: 0x47a0
// Size: 0x1bc
function function_3b72c4b2(player) {
    player function_80d6d39b(&function_a4521a9b);
    player.var_9dc65a85 = 0;
    objective_clearplayerusing(self.objectiveid, player);
    var_cc03b04e = player clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
    if (var_cc03b04e <= 0) {
        return;
    }
    if (!isdefined(self.var_cc03b04e)) {
        self.var_cc03b04e = 0;
    }
    self.var_cc03b04e++;
    objective_setprogress(self.objectiveid, self.var_cc03b04e / level.var_3990ce92);
    if (level.var_e65e9422) {
        player globallogic_score::giveteamscoreforobjective(player.team, level.var_e65e9422);
    }
    player clientfield::set_player_uimodel("hudItems.uraniumCarryCount", var_cc03b04e - 1);
    if (var_cc03b04e - 1 <= 0) {
        player clientfield::set("carryingUranium", 0);
        player function_53d7badf(0);
    }
    if (self.var_cc03b04e >= level.var_3990ce92) {
        self function_5c84cd7c();
        self thread function_4b31d6ba();
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xb25ed001, Offset: 0x4968
// Size: 0x11c
function function_704fdca0(player) {
    if (self.state == 2) {
        player function_3bf6db8b(#"defaultstate", self.trigger);
        player clientfield::set_to_player("using_bomb", 1);
    } else if (self.state == 4) {
        self.trigger function_6e23e4cb(player);
        player function_3bf6db8b(#"detonating", self.trigger);
        player clientfield::set_to_player("using_bomb", 2);
        player setlowready(1);
    }
    player.var_9dc65a85 = 1;
    objective_setplayerusing(self.objectiveid, player);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xf880f5b8, Offset: 0x4a90
// Size: 0xbc
function function_ea25bba7(player) {
    if (self.state == 2) {
        player function_80d6d39b(&function_a4521a9b);
    } else if (self.state == 4) {
        player function_80d6d39b();
        self.trigger function_6e23e4cb();
        player setlowready(0);
    }
    player.var_9dc65a85 = 0;
    objective_clearplayerusing(self.objectiveid, player);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xdd09a25f, Offset: 0x4b58
// Size: 0x174
function function_a05584ae() {
    var_a737309d = 0;
    for (i = 0; i < level.var_2f418a15.size; i++) {
        if (level.var_2f418a15[i].state == 2) {
            level.var_2f418a15[i] function_b43466d5();
            level.var_2f418a15[i] = level.var_2f418a15[level.var_2f418a15.size - 1];
            level.var_2f418a15[level.var_2f418a15.size - 1] = undefined;
            i--;
            var_a737309d++;
        }
    }
    if (var_a737309d == 1) {
        globallogic_audio::function_61e17de0("dirtyBombOffline", getplayers());
    } else if (var_a737309d > 1) {
        globallogic_audio::function_61e17de0("dirtyBombOfflineMult", getplayers());
    }
    globallogic_audio::function_61e17de0("dirtyBombRespawnDisabled", getplayers());
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x96affee1, Offset: 0x4cd8
// Size: 0x62
function function_b43466d5() {
    self.model delete();
    objective_delete(self.objectiveid);
    gameobjects::release_obj_id(self.objectiveid);
    self.var_cc03b04e = undefined;
    self.state = 0;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xfb83a202, Offset: 0x4d48
// Size: 0x6c
function function_5c84cd7c() {
    self.state = 3;
    function_4339912c(self.objectiveid);
    self.model playsound(#"hash_2013c3b9f7d5a632");
    self.trigger delete();
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xecd0a95f, Offset: 0x4dc0
// Size: 0xcc
function function_4b31d6ba() {
    level endon(#"game_ended");
    globallogic_audio::function_61e17de0("dirtyBombPrimed", getplayers(undefined, self.origin, 1000));
    if (level.var_e39b6425 != 0) {
        wait level.var_e39b6425;
        self.model playsound(#"hash_1e349183ce55d6ff");
    }
    self function_99c4c4e5();
    self thread function_dc70ca08();
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xa84646d1, Offset: 0x4e98
// Size: 0x94
function function_99c4c4e5() {
    self.state = 4;
    function_6da98133(self.objectiveid);
    objective_setgamemodeflags(self.objectiveid, 3);
    objective_setprogress(self.objectiveid, 0);
    self function_6a9ca122();
    self.trigger thread function_f9f4b255();
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0x973a3f54, Offset: 0x4f38
// Size: 0x116
function private function_6a9ca122() {
    self.trigger = spawn("trigger_radius_use", self.origin + (0, 0, 12), 0, 120, 90, 1);
    self.trigger triggerignoreteam();
    self.trigger setcursorhint("HINT_NOICON");
    self.trigger triggerenable(1);
    self.trigger usetriggerignoreuseholdtime();
    self.trigger sethintstring("MENU/PROMPT_DIRTY_BOMB_DETONATE");
    self.trigger callback::on_trigger(&function_2f5dd98c);
    self.trigger.bomb = self;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0xc489f5df, Offset: 0x5058
// Size: 0xfc
function private function_2f5dd98c(var_7d32de2) {
    if (is_true(level.gameended)) {
        return;
    }
    activator = var_7d32de2.activator;
    if (is_true(activator.var_9dc65a85)) {
        return;
    }
    bomb = self.bomb;
    if (bomb.state != 4) {
        return;
    }
    if (bomb.trigger.var_ef7458f2.size > 0 && bomb.trigger.var_ef7458f2[0].team != activator.team) {
        return;
    }
    bomb thread function_704fdca0(activator);
    activator function_84cb44bc(bomb);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0xbff0740, Offset: 0x5160
// Size: 0x74
function private function_84cb44bc(bomb) {
    self endon(#"disconnect");
    if (bomb.state == 4) {
        bomb.trigger.var_ef7458f2[bomb.trigger.var_ef7458f2.size] = self;
        bomb thread function_704fdca0(self);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0x53e89d52, Offset: 0x51e0
// Size: 0x3f4
function private function_f9f4b255() {
    self endon(#"death");
    self.var_ef7458f2 = [];
    prevtime = gettime();
    var_e18791f4 = int(level.var_b06a1891 * 1000);
    totalprogress = 0;
    var_b1c451bf = int(level.var_f4a1440c / 0.05 * 1000);
    bomb = self.bomb;
    while (bomb.state == 4) {
        if (self.var_ef7458f2.size > 0) {
            bomb.model playloopsound(#"hash_5093c3a0e7047aa", 0.5);
            for (i = 0; i < self.var_ef7458f2.size; i++) {
                player = self.var_ef7458f2[i];
                if (!player function_8e1791eb(bomb)) {
                    bomb thread function_ea25bba7(player);
                    for (j = i; j < self.var_ef7458f2.size; j++) {
                        if (j + 1 >= self.var_ef7458f2.size) {
                            self.var_ef7458f2[j] = undefined;
                            continue;
                        }
                        self.var_ef7458f2[j] = self.var_ef7458f2[j + 1];
                    }
                    i--;
                }
            }
            deltatime = gettime() - prevtime;
            progress = deltatime * self.var_ef7458f2.size;
            progress = min(progress, var_b1c451bf);
            totalprogress += progress;
            if (totalprogress >= var_e18791f4) {
                bomb thread function_5c0f763b(self.var_ef7458f2[0]);
                break;
            }
            if (totalprogress > 0) {
                if (isdefined(bomb.objectiveid)) {
                    objective_setprogress(bomb.objectiveid, totalprogress / var_e18791f4);
                }
                foreach (player in self.var_ef7458f2) {
                    player function_9db99d2f(totalprogress / var_e18791f4);
                }
            }
        } else if (!level.var_3a9e7236) {
            totalprogress = 0;
            if (isdefined(bomb.objectiveid)) {
                objective_setprogress(bomb.objectiveid, totalprogress / var_e18791f4);
            }
        }
        if (self.var_ef7458f2.size <= 0) {
            bomb.model stoploopsound(0.25);
        }
        prevtime = gettime();
        wait 0.05;
    }
    bomb.model stoploopsound(0.25);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xeaba81c, Offset: 0x55e0
// Size: 0xce
function function_8e1791eb(bomb) {
    if (bomb.state != 4) {
        return false;
    }
    if (!isalive(self)) {
        return false;
    }
    if (self inlaststand()) {
        return false;
    }
    if (!self usebuttonpressed()) {
        return false;
    }
    if (!isdefined(bomb.trigger)) {
        return false;
    }
    if (!bomb.trigger istriggerenabled()) {
        return false;
    }
    if (!self istouching(bomb.trigger)) {
        return false;
    }
    return true;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x25976d9a, Offset: 0x56b8
// Size: 0xbc
function function_dc70ca08() {
    self endon(#"hash_51134d620e14f47b");
    level endon(#"game_ended");
    if (level.var_451f847f == 0) {
        return;
    }
    wait level.var_451f847f;
    while (isdefined(self.trigger.var_ef7458f2) && isarray(self.trigger.var_ef7458f2) && self.trigger.var_ef7458f2.size > 0) {
        waitframe(1);
    }
    self function_1283ff24(undefined);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xbdb1f7ff, Offset: 0x5780
// Size: 0x1c4
function function_5c0f763b(player) {
    self notify(#"hash_51134d620e14f47b");
    if (level.var_77720414) {
        player globallogic_score::giveteamscoreforobjective(player.team, level.var_77720414);
        var_d3de83e3 = getteamscore(player.team) / level.scorelimit;
        if (var_d3de83e3 > 0.75) {
            globallogic_audio::function_61e17de0("dirtyBombScore75", getplayers());
        } else if (var_d3de83e3 > 0.5) {
            globallogic_audio::function_61e17de0("dirtyBombScore50", getplayers());
        }
    }
    player function_80d6d39b();
    player setlowready(0);
    player.var_9dc65a85 = 0;
    objective_clearplayerusing(self.objectiveid, player);
    for (i = 1; i < self.trigger.var_ef7458f2.size; i++) {
        self thread function_ea25bba7(self.trigger.var_ef7458f2[i]);
    }
    self function_1283ff24(player);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0x6580de5f, Offset: 0x5950
// Size: 0xf4
function function_1283ff24(player) {
    objective_setgamemodeflags(self.objectiveid, 1);
    objective_setteam(self.objectiveid, isdefined(player.team) ? player.team : #"hash_34db99d80fb3607f");
    objective_setprogress(self.objectiveid, 0);
    self.state = 5;
    self.trigger delete();
    self.model clientfield::set("ftdb_zoneCircle", 3);
    self thread function_5d6231a6(player);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xf323fa4b, Offset: 0x5a50
// Size: 0xec
function function_5d6231a6(player) {
    level endon(#"game_ended");
    globallogic_audio::function_61e17de0("dirtyBombArmed", getplayers(undefined, self.origin, 1000));
    if (level.var_46f2c796 != 0) {
        self.model playloopsound(#"hash_78cdfb1438b360bf", 1);
        wait level.var_46f2c796;
        if (isdefined(self.model)) {
            self.model stoploopsound(0.5);
        }
    }
    self function_91c39737(player);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xedf136c4, Offset: 0x5b48
// Size: 0x39c
function function_91c39737(player) {
    origin = self.origin;
    damage = level.var_60e3f99c;
    playsoundatposition("exp_dirty_bomb_explo", origin + (0, 0, 60));
    globallogic_audio::function_61e17de0("dirtyBombDetonated", getplayers(undefined, origin, 1000));
    entities = getdamageableentarray(origin, level.var_60693fca, 1);
    foreach (entity in entities) {
        if (!isalive(entity)) {
            continue;
        }
        if (isplayer(entity)) {
            entity.var_f5dc0dbf = 1;
            if (isdefined(player.team) && isdefined(entity.team) && entity.team == player.team) {
                entity dodamage(damage, origin, entity, undefined, undefined, "MOD_EXPLOSIVE");
                continue;
            }
        }
        entity dodamage(damage, origin, player, undefined, undefined, "MOD_EXPLOSIVE");
    }
    fwd = (0, 0, 1);
    right = (0, -1, 0);
    playfx("killstreaks/fx9_artillery_strike_exp_rnr", origin, fwd, right);
    if (isentity(self.model)) {
        self.model delete();
    }
    if (isdefined(self.objectiveid)) {
        objective_delete(self.objectiveid);
        gameobjects::release_obj_id(self.objectiveid);
        self.objectiveid = undefined;
    }
    /#
        var_f1db48c8 = level.var_2f418a15.size;
    #/
    for (i = 0; i < level.var_2f418a15.size; i++) {
        if (level.var_2f418a15[i] == self) {
            level.var_2f418a15[i] = level.var_2f418a15[level.var_2f418a15.size - 1];
            level.var_2f418a15[level.var_2f418a15.size - 1] = undefined;
            break;
        }
    }
    /#
        if (var_f1db48c8 == level.var_2f418a15.size) {
            assert(0);
        }
    #/
    self.state = 0;
    if (level.var_2c9f7c6b) {
        self thread function_57172b7();
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0x6a62eb89, Offset: 0x5ef0
// Size: 0xc8
function private function_53d7badf(visible) {
    foreach (bomb in level.var_2f418a15) {
        if (!isdefined(bomb.state) || bomb.state != 2) {
            continue;
        }
        bomb.trigger setinvisibletoplayer(self, !visible);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0xa5468b9f, Offset: 0x5fc0
// Size: 0x104
function private function_6e23e4cb(var_f87ac426 = undefined) {
    if (isdefined(var_f87ac426)) {
        self setinvisibletoall();
        foreach (player in getplayers()) {
            if (player != var_f87ac426 && player.team == var_f87ac426.team) {
                self setvisibletoplayer(player);
            }
        }
        return;
    }
    self setvisibletoall();
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x4
// Checksum 0x59c8bec7, Offset: 0x60d0
// Size: 0xc2
function private function_3bf6db8b(state, usetrigger) {
    if (!level.dirtybombusebar dirtybomb_usebar::is_open(self)) {
        level.dirtybombusebar dirtybomb_usebar::open(self);
    }
    level.dirtybombusebar dirtybomb_usebar::set_state(self, state);
    level.dirtybombusebar dirtybomb_usebar::function_f0df5702(self, 0);
    usetrigger setinvisibletoplayer(self, 1);
    self.var_814cca3f = usetrigger;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0x76570b3b, Offset: 0x61a0
// Size: 0xd6
function private function_80d6d39b(var_aaa102e3 = undefined) {
    self clientfield::set_to_player("using_bomb", 0);
    if (level.dirtybombusebar dirtybomb_usebar::is_open(self)) {
        level.dirtybombusebar dirtybomb_usebar::close(self);
    }
    if (isdefined(self.var_814cca3f)) {
        if (!isfunctionptr(var_aaa102e3) || [[ var_aaa102e3 ]](self)) {
            self.var_814cca3f setinvisibletoplayer(self, 0);
        }
        self.var_814cca3f = undefined;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0x7b90297b, Offset: 0x6280
// Size: 0x4c
function private function_9db99d2f(frac) {
    if (level.dirtybombusebar dirtybomb_usebar::is_open(self)) {
        level.dirtybombusebar dirtybomb_usebar::function_f0df5702(self, frac);
    }
}

/#

    // Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
    // Params 0, eflags: 0x0
    // Checksum 0x73f9fe37, Offset: 0x62d8
    // Size: 0x42c
    function function_64d94faa() {
        level endon(#"game_ended");
        while (true) {
            waitframe(1);
            level.var_2c9f7c6b = isdefined(getgametypesetting(#"hash_1cf5e61c49992dc3")) ? getgametypesetting(#"hash_1cf5e61c49992dc3") : 0;
            level.var_cd139dc0 = isdefined(getgametypesetting(#"hash_7f837b709840950")) ? getgametypesetting(#"hash_7f837b709840950") : 0;
            level.var_67432513 = isdefined(getgametypesetting(#"hash_6cd4374035db175e")) ? getgametypesetting(#"hash_6cd4374035db175e") : 0;
            level.var_d18d7655 = isdefined(getgametypesetting(#"hash_786ee581eedabff0")) ? getgametypesetting(#"hash_786ee581eedabff0") : 0;
            level.var_7108bd31 = isdefined(getgametypesetting(#"hash_eff3a2f99071600")) ? getgametypesetting(#"hash_eff3a2f99071600") : 0;
            level.var_c0839e43 = isdefined(getgametypesetting(#"hash_162ebc3912b68841")) ? getgametypesetting(#"hash_162ebc3912b68841") : 0;
            level.var_de7aa071 = isdefined(getgametypesetting(#"hash_570912155889089e")) ? getgametypesetting(#"hash_570912155889089e") : 0;
            level.var_aa6b51f5 = isdefined(getgametypesetting(#"hash_5d04a19b625d7300")) ? getgametypesetting(#"hash_5d04a19b625d7300") : 0;
            level.var_35b75d82 = isdefined(getgametypesetting(#"hash_371e83f096bf0548")) ? getgametypesetting(#"hash_371e83f096bf0548") : 0;
            players = getplayers();
            foreach (player in players) {
                if (player usebuttonpressed() && !is_true(level.var_a0cb7a38)) {
                    level.var_2f418a15[0] thread function_57172b7();
                }
            }
        }
    }

#/

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xe64d1a7d, Offset: 0x6710
// Size: 0x1a4
function function_57172b7() {
    /#
        level.var_a0cb7a38 = 1;
    #/
    level.var_ac7be286[level.var_ac7be286.size] = self;
    self function_6a583613();
    while (self.var_261dd536 < level.var_243d612d) {
        self function_87a78a13();
        globallogic_audio::function_61e17de0("dirtyBombRadExpand", getplayers(undefined, self.origin, 1000));
    }
    wait level.var_c0839e43;
    while (self.var_261dd536 >= 0) {
        self function_5c839f44();
        globallogic_audio::function_61e17de0("dirtyBombRadRecede", getplayers(undefined, self.origin, 1000));
    }
    for (i = 0; i < level.var_ac7be286.size; i++) {
        if (self == level.var_ac7be286[i]) {
            level.var_ac7be286[i] = level.var_ac7be286[level.var_ac7be286.size - 1];
            level.var_ac7be286[level.var_ac7be286.size - 1] = undefined;
        }
    }
    /#
        level.var_a0cb7a38 = 0;
    #/
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xeccb05e3, Offset: 0x68c0
// Size: 0x54
function function_6a583613() {
    self.var_8e392e0f = level.var_cd139dc0;
    self.var_261dd536 = 0;
    self function_218080fb();
    if (self.var_8e392e0f > 0) {
        self function_cd602d73();
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xcc0ef49e, Offset: 0x6920
// Size: 0x1f6
function function_218080fb() {
    self.var_fa06c0e = [];
    self.var_e17ae8be = [];
    initialradius = level.var_cd139dc0;
    maxradius = level.var_67432513;
    level.var_243d612d = (maxradius - initialradius) / 1000;
    numrings = level.var_243d612d;
    var_92d713c7 = level.var_aa6b51f5;
    self.var_91017512 = 1000;
    self.circleradius = 800;
    for (i = 0; i < numrings; i++) {
        self.var_fa06c0e[i] = [];
        self.var_e17ae8be[i] = [];
        var_4fc3d1c0 = initialradius + self.var_91017512 * i;
        var_f79106a4 = int(var_4fc3d1c0 * 2 * 3.14159 / self.circleradius / 1 / (1 + var_92d713c7) + 0.5);
        angledelta = 360 / var_f79106a4;
        for (j = 0; j < var_f79106a4; j++) {
            angle = angledelta * j;
            vector = (cos(angle), sin(angle), 0);
            origin = self.origin + vectorscale(vector, var_4fc3d1c0);
            self.var_fa06c0e[i][j] = origin;
        }
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x9f797fee, Offset: 0x6b20
// Size: 0x1d4
function function_87a78a13() {
    self.var_261dd536++;
    var_b75abae3 = level.var_7108bd31 / level.var_243d612d;
    if (self.var_261dd536 >= 2) {
        self.var_8e392e0f += self.var_91017512;
        self thread function_11e66df1();
    }
    maxindex = 0;
    for (i = 0; i < self.var_261dd536; i++) {
        maxindex += self.var_fa06c0e[i].size;
    }
    var_806fff0a = int(maxindex * level.var_35b75d82);
    var_1082b7c4 = var_b75abae3 / var_806fff0a;
    for (i = 0; i < var_806fff0a; i++) {
        wait var_1082b7c4;
        index = randomint(maxindex);
        maxindex--;
        for (j = 0; j < self.var_261dd536; j++) {
            if (index < self.var_fa06c0e[j].size) {
                self function_2be7a212(j, index);
                break;
            }
            index -= self.var_fa06c0e[j].size;
        }
    }
    if (self.var_261dd536 >= 2) {
        self function_ca3c6cb3(self.var_261dd536 - 2);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x863b131a, Offset: 0x6d00
// Size: 0x154
function function_5c839f44() {
    self.var_261dd536--;
    self.var_8e392e0f -= self.var_91017512;
    if (self.var_261dd536 < 0 || self.var_8e392e0f <= 0) {
        self function_ea7ab3a9(1);
        return;
    }
    var_b75abae3 = level.var_de7aa071 / level.var_243d612d;
    maxindex = self.var_e17ae8be[self.var_261dd536].size;
    self function_cd602d73();
    if (maxindex == 0) {
        wait var_b75abae3;
        return;
    }
    var_7158f69 = maxindex;
    var_1082b7c4 = var_b75abae3 / maxindex;
    for (i = 0; i < var_7158f69; i++) {
        wait var_1082b7c4;
        index = randomint(maxindex);
        maxindex--;
        self function_7886d66d(self.var_261dd536, index);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xf6f1781, Offset: 0x6e60
// Size: 0xe6
function function_ca3c6cb3(var_d9612d9) {
    for (i = self.var_fa06c0e[var_d9612d9].size - 1; i >= 0; i--) {
        self.var_fa06c0e[var_d9612d9][i] = undefined;
    }
    for (i = self.var_e17ae8be[var_d9612d9].size - 1; i >= 0; i--) {
        self.var_e17ae8be[var_d9612d9][i].fx delete();
        self.var_e17ae8be[var_d9612d9][i].model delete();
        self.var_e17ae8be[var_d9612d9][i] = undefined;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x0
// Checksum 0xabd127a7, Offset: 0x6f50
// Size: 0x494
function function_2be7a212(var_d9612d9, circleindex) {
    origin = self.var_fa06c0e[var_d9612d9][circleindex];
    self.var_fa06c0e[var_d9612d9][circleindex] = self.var_fa06c0e[var_d9612d9][self.var_fa06c0e[var_d9612d9].size - 1];
    self.var_fa06c0e[var_d9612d9][self.var_fa06c0e[var_d9612d9].size - 1] = undefined;
    /#
        if (getdvarint(#"hash_1216cbfbf11758ce", 0)) {
            sphere(origin, self.circleradius, (0, 1, 0), 0.5, 1, 100, 100000);
        }
    #/
    origin += (0, 0, 16);
    var_9912c765 = (0, 0, 200);
    attempts = 1;
    var_a468ec72 = bullettrace(origin, origin + var_9912c765, 0, self);
    var_68011b79 = bullettrace(origin, origin - var_9912c765, 0, self);
    while (var_68011b79[#"fraction"] == 1 && var_a468ec72[#"fraction"] == 1 && attempts < 10) {
        var_a468ec72 = bullettrace(origin + var_9912c765 * attempts, origin + var_9912c765 * (attempts + 1), 0, self);
        var_68011b79 = bullettrace(origin - var_9912c765 * attempts, origin - var_9912c765 * (attempts + 1), 0, self);
        attempts++;
    }
    if (var_68011b79[#"fraction"] <= var_a468ec72[#"fraction"]) {
        origin = var_68011b79[#"position"];
    } else {
        origin = var_a468ec72[#"position"];
    }
    var_70a055ba = self.var_e17ae8be[var_d9612d9].size;
    self.var_e17ae8be[var_d9612d9][var_70a055ba] = {};
    self.var_e17ae8be[var_d9612d9][var_70a055ba].origin = origin;
    self.var_e17ae8be[var_d9612d9][var_70a055ba].fx = spawnfx("wz/fx9_dirtybomb_radiation_zone", origin + (0, 0, 80));
    self.var_e17ae8be[var_d9612d9][var_70a055ba].fx.team = #"neutral";
    triggerfx(self.var_e17ae8be[var_d9612d9][var_70a055ba].fx, 0.001);
    self.var_e17ae8be[var_d9612d9][var_70a055ba].model = spawn("script_model", origin);
    self.var_e17ae8be[var_d9612d9][var_70a055ba].model.team = #"neutral";
    self.var_e17ae8be[var_d9612d9][var_70a055ba].model setmodel("tag_origin");
    self.var_e17ae8be[var_d9612d9][var_70a055ba].model clientfield::set("ftdb_zoneCircle", 1);
    self.var_e17ae8be[var_d9612d9][var_70a055ba].model.var_2c8491dd = self;
    self.var_e17ae8be[var_d9612d9][var_70a055ba].model thread function_b4596451();
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x92ea91f7, Offset: 0x73f0
// Size: 0x10c
function function_b4596451() {
    self endon(#"death");
    starttime = gettime();
    self setscale(0.1);
    wait 0.5;
    while (gettime() < starttime + int(5 * 1000)) {
        scale = (gettime() - starttime) / int(5 * 1000);
        self setscale(scale);
        self.var_301e0bf7 = scale * self.var_2c8491dd.circleradius;
        waitframe(1);
    }
    self setscale(1);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x0
// Checksum 0xc5ee881, Offset: 0x7508
// Size: 0xbe
function function_7886d66d(var_d9612d9, circleindex) {
    self.var_e17ae8be[var_d9612d9][circleindex].fx delete();
    self.var_e17ae8be[var_d9612d9][circleindex].model delete();
    self.var_e17ae8be[var_d9612d9][circleindex] = self.var_e17ae8be[var_d9612d9][self.var_e17ae8be[var_d9612d9].size - 1];
    self.var_e17ae8be[var_d9612d9][self.var_e17ae8be[var_d9612d9].size - 1] = undefined;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xdc9872f9, Offset: 0x75d0
// Size: 0x54
function function_11e66df1() {
    self endon(#"death");
    var_558245a8 = level.var_7108bd31 / level.var_243d612d / 2;
    wait var_558245a8;
    function_cd602d73();
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x8005bb8, Offset: 0x7630
// Size: 0x1c4
function function_cd602d73() {
    self function_ea7ab3a9(0);
    /#
        if (getdvarint(#"hash_1216cbfbf11758ce", 0)) {
            sphere(self.origin, self.var_8e392e0f, (0, 1, 0), 0.5, 1, 100, 100000);
        }
    #/
    self.var_98123c0 = spawnfx("wz/fx9_dirtybomb_radiation_zone", self.origin + (0, 0, 80));
    self.var_98123c0.team = #"neutral";
    triggerfx(self.var_98123c0, 0.001);
    if (!isdefined(self.var_b06ed2fa)) {
        self.var_b06ed2fa = spawn("script_model", self.origin);
        self.var_b06ed2fa.team = #"neutral";
        self.var_b06ed2fa setmodel("tag_origin");
        self.var_b06ed2fa clientfield::set("ftdb_zoneCircle", 2);
    }
    self.var_b06ed2fa thread function_a8d5a90b(self.var_8e392e0f / level.var_cd139dc0);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0x52df26be, Offset: 0x7800
// Size: 0x13c
function function_a8d5a90b(var_5ad0dc76) {
    self endon(#"death");
    starttime = gettime();
    duration = level.var_7108bd31 / level.var_243d612d / 2;
    startscale = max(self getscale(), 0.1);
    while (gettime() < starttime + int(duration * 1000)) {
        timefrac = (gettime() - starttime) / int(duration * 1000);
        var_c7d44e82 = timefrac * var_5ad0dc76 + (1 - timefrac) * startscale;
        self setscale(var_c7d44e82);
        waitframe(1);
    }
    self setscale(var_5ad0dc76);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0x7500f55d, Offset: 0x7948
// Size: 0x76
function function_ea7ab3a9(var_21da2251) {
    if (isdefined(self.var_98123c0)) {
        self.var_98123c0 delete();
        self.var_98123c0 = undefined;
    }
    if (var_21da2251) {
        if (isdefined(self.var_b06ed2fa)) {
            self.var_b06ed2fa delete();
            self.var_b06ed2fa = undefined;
        }
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x0
// Checksum 0x691fbdbb, Offset: 0x79c8
// Size: 0x48
function function_a5f0096a(point1, point2) {
    vector = point2 - point1;
    return vector[0] * vector[0] + vector[1] * vector[1];
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xd5d4bfac, Offset: 0x7a18
// Size: 0xde
function function_afa7ee8d() {
    level endon(#"game_ended");
    level waittill(#"item_world_reset");
    chests = getdynentarray(#"dirty_bomb_stash");
    foreach (chest in chests) {
        chest.onuse = &function_8741e97;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 3, eflags: 0x0
// Checksum 0x1bd195ea, Offset: 0x7b00
// Size: 0x3c
function function_8741e97(*activator, *laststate, state) {
    if (state == 2) {
        self thread function_8100d47a();
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xc3d3272f, Offset: 0x7b48
// Size: 0x62
function function_8100d47a() {
    level endon(#"game_ended");
    wait randomintrange(45, 60);
    item_world::function_8eee98dd(self);
    self.onuse = &function_8741e97;
}

