#using script_167b322dbacbc3f5;
#using script_1cc417743d7c262d;
#using script_1f41849126bfc83d;
#using script_335d0650ed05d36d;
#using script_46192c58ea066d7f;
#using script_471b31bd963b388e;
#using script_4ba46a0f73534383;
#using script_4e6bcfa8856b2a96;
#using script_b9a55edd207e4ca;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_world;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\oob;
#using scripts\core_common\perks;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\laststand;
#using scripts\mp_common\player\player_killed;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\player\player_utils;
#using scripts\wz_common\wz_rat;

#namespace fireteam_dirty_bomb;

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x6
// Checksum 0x3c2945c8, Offset: 0x6c8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_16dead24d6def3d5", &function_62730899, undefined, undefined, #"territory");
}

// Namespace fireteam_dirty_bomb/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xacb0bd40, Offset: 0x718
// Size: 0x11cc
function event_handler[gametype_init] main(*eventstruct) {
    if (util::get_game_type() != "fireteam_dirty_bomb") {
        return;
    }
    setdvar(#"scr_maxinventory_scorestreaks", 1);
    level.var_e2636f91 = 0;
    namespace_2938acdc::init();
    spawning::addsupportedspawnpointtype("tdm");
    level.onstartgametype = &onstartgametype;
    level.onscorelimit = &onscorelimit;
    callback::on_spawned(&onplayerspawned);
    callback::on_player_killed(&on_player_killed);
    callback::on_vehicle_spawned(&on_vehicle_spawned);
    callback::add_callback(#"hash_40cd438036ae13df", &function_1f93e91f);
    callback::add_callback(#"hash_740a58650e79dbfd", &function_c3623479);
    level callback::add_callback(#"hash_259e3bcba73a2f14", &function_c0e544cc);
    laststand_mp::function_367cfa1b(&function_95002a59);
    player::function_3c5cc656(&function_610d3790);
    clientfield::register("toplayer", "using_bomb", 1, 2, "int");
    clientfield::register_clientuimodel("hudItems.uraniumCarryCount", 1, 4, "int");
    clientfield::register_clientuimodel("hudItems.uraniumMaxCarry", 1, 4, "int");
    clientfield::register_clientuimodel("hudItems.uraniumFullCarry", 1, 1, "int");
    clientfield::register("toplayer", "ftdb_inZone", 1, 1, "int");
    clientfield::register("allplayers", "carryingUranium", 1, 1, "int");
    clientfield::register("scriptmover", "ftdb_zoneCircle", 1, 3, "int");
    clientfield::function_5b7d846d("hud_items_dirty_bomb.bomb_respawn_disabled", 1, 1, "int");
    laststand_mp::function_eb8c0e47(&onplayerrevived);
    level.can_revive = &function_45a85e5b;
    level.dirtybombusebar = dirtybomb_usebar::register();
    level.var_b7821ed9 = &function_b7821ed9;
    level.var_34842a14 = 1;
    level.var_ce802423 = 1;
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
    level.var_d86d5820 = isdefined(getgametypesetting(#"hash_78f99a9c357836ba")) ? getgametypesetting(#"hash_78f99a9c357836ba") : 0;
    level.var_60693fca = (isdefined(getgametypesetting(#"hash_37aefeabeef0ec6c")) ? getgametypesetting(#"hash_37aefeabeef0ec6c") : 0) * 100;
    level.var_60e3f99c = 99999;
    level.var_77720414 = isdefined(getgametypesetting(#"hash_2778e754fc66aac")) ? getgametypesetting(#"hash_2778e754fc66aac") : 0;
    level.var_e65e9422 = isdefined(getgametypesetting(#"hash_540ba194e715168b")) ? getgametypesetting(#"hash_540ba194e715168b") : 0;
    level.var_5f31e806 = isdefined(getgametypesetting(#"hash_3c99ef02f267efaf")) ? getgametypesetting(#"hash_3c99ef02f267efaf") : 1;
    level.var_c836026 = isdefined(getgametypesetting(#"hash_3c7edd02f2510961")) ? getgametypesetting(#"hash_3c7edd02f2510961") : 5;
    level.var_3a9e7236 = is_true(getgametypesetting(#"hash_301e41804f45eb50"));
    level.var_696298a2 = getweapon(#"briefcase_bomb");
    level.var_b9f31e66 = isdefined(getgametypesetting(#"hash_3eeecb0a77c21db1")) ? getgametypesetting(#"hash_3eeecb0a77c21db1") : 100;
    level.var_8c05a764 = isdefined(getgametypesetting(#"hash_2e824e2ee213574d")) ? getgametypesetting(#"hash_2e824e2ee213574d") : 10;
    level.var_89a6bd00 = isdefined(getgametypesetting(#"hash_7b5af9a43263b4a9")) ? getgametypesetting(#"hash_7b5af9a43263b4a9") : 15;
    level.var_65a0fe4d = isdefined(getgametypesetting(#"hash_7b3feba4324cd527")) ? getgametypesetting(#"hash_7b3feba4324cd527") : 30;
    level.var_2c9f7c6b = isdefined(getgametypesetting(#"hash_1cf5e61c49992dc3")) ? getgametypesetting(#"hash_1cf5e61c49992dc3") : 0;
    level.var_cd139dc0 = (isdefined(getgametypesetting(#"hash_7f837b709840950")) ? getgametypesetting(#"hash_7f837b709840950") : 1) * 100;
    level.var_67432513 = (isdefined(getgametypesetting(#"hash_6cd4374035db175e")) ? getgametypesetting(#"hash_6cd4374035db175e") : 0) * 100;
    level.var_d18d7655 = (isdefined(getgametypesetting(#"hash_786ee581eedabff0")) ? getgametypesetting(#"hash_786ee581eedabff0") : 0) * 100;
    level.var_7108bd31 = isdefined(getgametypesetting(#"hash_eff3a2f99071600")) ? getgametypesetting(#"hash_eff3a2f99071600") : 0;
    level.var_c0839e43 = isdefined(getgametypesetting(#"hash_162ebc3912b68841")) ? getgametypesetting(#"hash_162ebc3912b68841") : 0;
    level.var_de7aa071 = isdefined(getgametypesetting(#"hash_570912155889089e")) ? getgametypesetting(#"hash_570912155889089e") : 0;
    level.var_aa6b51f5 = isdefined(getgametypesetting(#"hash_5d04a19b625d7300")) ? getgametypesetting(#"hash_5d04a19b625d7300") : 0;
    level.var_35b75d82 = isdefined(getgametypesetting(#"hash_371e83f096bf0548")) ? getgametypesetting(#"hash_371e83f096bf0548") : 0;
    level.var_380f7d22 = 200;
    namespace_681edb36::function_dd83b835();
    level thread function_afa7ee8d();
    item_world::function_861f348d(#"gamemode_pickup", &function_18f58ab2);
    level.var_d539e0dd = &function_3f63e44f;
    level.var_2f418a15 = [];
    level.var_ac7be286 = [];
    level.var_910f361c = [];
    level.var_d8fd137b = [];
    level.var_d8fd137b[0] = #"hash_2854f6c09dd9a316";
    level.var_d8fd137b[1] = #"hash_2854f5c09dd9a163";
    level.var_d8fd137b[2] = #"hash_2854f4c09dd99fb0";
    level.var_d8fd137b[3] = #"hash_2854fbc09dd9ab95";
    level.var_d8fd137b[4] = #"hash_2854fac09dd9a9e2";
    level.onrespawndelay = &playerrespawndelay;
    /#
        if (getdvarint(#"hash_74074ce39d0658e7", 0)) {
            level.var_12ff620b = 0;
            level.var_26c7635a = 3;
            level.var_3990ce92 = 1;
            level.var_932f538d = 1;
            level.var_e39b6425 = 3;
            level.var_b06a1891 = 5;
            level.var_f4a1440c = 5;
            level.var_46f2c796 = 3;
            level.var_7108bd31 = 15;
            level.var_c0839e43 = 1;
            level.var_de7aa071 = 5;
        }
    #/
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x4
// Checksum 0xe5fcd4cf, Offset: 0x18f0
// Size: 0x46
function private onplayerrevived(revivee, *reviver) {
    if (isplayer(reviver)) {
        reviver.var_c83d0859 = undefined;
        reviver.var_1eaa0d81 = undefined;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0xa08ecbb8, Offset: 0x1940
// Size: 0x52
function private function_ec3e7325(player) {
    assert(isplayer(player));
    return player clientfield::get_player_uimodel("hudItems.uraniumMaxCarry");
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0xdfd51825, Offset: 0x19a0
// Size: 0x58
function private function_cc2c46fd(player) {
    assert(isplayer(player));
    return player clientfield::get_player_uimodel("hudItems.uraniumMaxCarry") == 10;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0xb7d0b0e, Offset: 0x1a00
// Size: 0x134
function private function_523bd02(canpickup) {
    assert(isplayer(self));
    if (!isplayer(self)) {
        return;
    }
    if (!isalive(self)) {
        return;
    }
    if (canpickup) {
        self clientfield::set_player_uimodel("hudItems.uraniumFullCarry", 0);
        return;
    }
    if (isdefined(self.var_48c5e502) && self.var_48c5e502 > gettime()) {
        return;
    }
    self.var_48c5e502 = gettime() + int(4 * 1000);
    self clientfield::set_player_uimodel("hudItems.uraniumFullCarry", 1);
    wait 2;
    if (isplayer(self)) {
        self clientfield::set_player_uimodel("hudItems.uraniumFullCarry", 0);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0x2e57796, Offset: 0x1b40
// Size: 0x2be
function private function_3f63e44f(item) {
    assert(isdefined(item));
    assert(isdefined(item.itementry));
    if (item.itementry.itemtype == #"generic") {
        switch (item.itementry.name) {
        case #"uranium_item_t9":
            var_e3483afe = self clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
            canpickup = function_ec3e7325(self) > var_e3483afe;
            self thread function_523bd02(canpickup);
            return canpickup;
        case #"uranium_pouch_item_t9":
            return !function_cc2c46fd(self);
        case #"armor_pouch_item_t9":
            return !namespace_234f0efc::function_d912fa6e(self);
        }
    } else if (item.itementry.itemtype == #"scorestreak") {
        if (is_true(self.selectinglocation)) {
            return 0;
        }
        weapons = self getweaponslist();
        foreach (weapon in weapons) {
            var_16f12c31 = item_world_util::function_3531b9ba(weapon.name);
            if (isdefined(var_16f12c31) && self getweaponammostock(weapon) > 0) {
                return 0;
            }
        }
    } else if (item.itementry.itemtype == #"armor_shard") {
        return (self.var_c52363ab > self.var_7d7d976a);
    }
    return 1;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 7, eflags: 0x4
// Checksum 0xceef7477, Offset: 0x1e08
// Size: 0x118
function private function_18f58ab2(item, player, networkid, itemid, itemcount, var_aec6fa7f, slot) {
    pickup = 0;
    switch (item.itementry.name) {
    case #"uranium_item_t9":
        pickup = function_bf46e093(item, player, networkid, itemid, itemcount, var_aec6fa7f, slot);
        break;
    case #"uranium_pouch_item_t9":
        pickup = function_fa78e80b(item, player, networkid, itemid, itemcount, var_aec6fa7f, slot);
        break;
    case #"armor_pouch_item_t9":
        pickup = namespace_234f0efc::function_dd8cb464(item, player, networkid, itemid, itemcount, var_aec6fa7f, slot);
        break;
    }
    return itemcount - pickup;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 7, eflags: 0x4
// Checksum 0x37ad3477, Offset: 0x1f28
// Size: 0x24e
function private function_bf46e093(item, player, *networkid, *itemid, itemcount, *var_aec6fa7f, *slot) {
    var_e3483afe = var_aec6fa7f clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
    pickup = int(min(function_ec3e7325(var_aec6fa7f) - var_e3483afe, slot));
    var_aec6fa7f clientfield::set_player_uimodel("hudItems.uraniumCarryCount", var_e3483afe + pickup);
    if (var_e3483afe + pickup > 0) {
        var_aec6fa7f clientfield::set("carryingUranium", 1);
        var_aec6fa7f function_53d7badf(1);
    }
    if (pickup > 0) {
        var_aec6fa7f playsound("fly_uranium_pickup");
        if (!isdefined(itemcount.var_d25a1503) || itemcount.var_d25a1503 != var_aec6fa7f.team) {
            scoreevents::processscoreevent(#"hash_64121166dc49f54a", var_aec6fa7f);
        }
    }
    if (var_e3483afe + pickup >= function_ec3e7325(var_aec6fa7f) || !is_true(var_aec6fa7f.var_2faaa10)) {
        var_aec6fa7f globallogic_audio::leader_dialog_on_player("dirtyBombUraniumMaxHold");
        var_aec6fa7f.var_2faaa10 = 1;
    }
    if (!isdefined(var_aec6fa7f.var_96c3af63)) {
        var_aec6fa7f luinotifyevent(#"hash_6b67aa04e378d681", 1, 14);
        var_aec6fa7f.var_96c3af63 = 1;
    }
    return pickup;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 7, eflags: 0x4
// Checksum 0xda1c1abc, Offset: 0x2180
// Size: 0x7c
function private function_fa78e80b(*item, player, *networkid, *itemid, *itemcount, *var_aec6fa7f, *slot) {
    if (!function_cc2c46fd(slot)) {
        slot clientfield::set_player_uimodel("hudItems.uraniumMaxCarry", 10);
        return true;
    }
    return false;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0xcc0279e5, Offset: 0x2208
// Size: 0x74
function private function_62730899() {
    if (util::get_game_type() != "fireteam_dirty_bomb") {
        return;
    }
    if (isdefined(level.territory) && level.territory.name != "zoo") {
        namespace_2938acdc::function_4212369d();
        namespace_2938acdc::function_20d09030();
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x413b9f6b, Offset: 0x2288
// Size: 0xc4
function onstartgametype() {
    if (level.var_96cdb906 != 0) {
        level thread function_8e2fb040();
    }
    if (level.var_2c9f7c6b) {
        level thread function_d897b60a();
    }
    level thread function_65f0fe7f();
    level thread function_8249279b();
    /#
        if (getdvarint(#"hash_26399e7b3c887ffb", 0)) {
            level thread function_64d94faa();
        }
    #/
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xf11121a1, Offset: 0x2358
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
// Checksum 0x9fd9d538, Offset: 0x23e0
// Size: 0xe4
function onplayerspawned() {
    self function_c3f27004();
    self.var_4ad2bfd3 = 0;
    self.var_cfc4949c = 1;
    self.var_6dc4d968 = 0;
    self.var_c83d0859 = undefined;
    self.var_1eaa0d81 = undefined;
    self clientfield::set_player_uimodel("hudItems.uraniumCarryCount", 0);
    self clientfield::set_player_uimodel("hudItems.uraniumMaxCarry", 5);
    self clientfield::set_player_uimodel("hudItems.uraniumFullCarry", 0);
    self clientfield::set("carryingUranium", 0);
    self function_53d7badf(0);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0x22c37bac, Offset: 0x24d0
// Size: 0x384
function on_player_killed(params) {
    aliveplayers = function_a1cff525(self.squad);
    if (aliveplayers.size == 0) {
        if (params.eattacker util::isenemyplayer(self)) {
            params.eattacker globallogic_audio::leader_dialog_on_player("dirtyBombFireteamWiped");
        }
    } else if (aliveplayers.size == 1) {
        if (!isdefined(level.var_e2384c19) && !aliveplayers[0] laststand::player_is_in_laststand()) {
            aliveplayers[0] globallogic_audio::leader_dialog_on_player("dirtyBombFireteamWipedFriendly");
        }
    }
    if (params.eattacker util::isenemyplayer(self)) {
        if (is_true(self.var_c83d0859)) {
            scoreevents::processscoreevent(#"hash_b15e641945148d4", params.eattacker, self, params.weapon);
        } else if (is_true(self.var_1eaa0d81)) {
            scoreevents::processscoreevent(#"hash_5d532825a2d0023", params.eattacker, self, params.weapon);
        }
        if (self clientfield::get_player_uimodel("hudItems.uraniumCarryCount") >= 5) {
            scoreevents::processscoreevent(#"hash_e9913b29988d98d", params.eattacker, self, params.weapon);
        }
    }
    self clientfield::set_to_player("ftdb_inZone", 0);
    self function_80d6d39b();
    self.var_9dc65a85 = 0;
    self.var_c83d0859 = undefined;
    self.var_1eaa0d81 = undefined;
    if (!getdvarint(#"hash_766c487cde5735c8", 0)) {
        var_4c42f7cf = 0;
        var_4c42f7cf = self namespace_234f0efc::function_d5766919(var_4c42f7cf);
        var_4c42f7cf = self function_d67bd905(var_4c42f7cf + 1);
        var_4c42f7cf = self namespace_234f0efc::function_b31f892b(var_4c42f7cf + 1);
        var_4c42f7cf = self namespace_234f0efc::function_e50b5cec(var_4c42f7cf + 1);
        var_4c42f7cf = self function_15d1af86(var_4c42f7cf + 1);
        var_4c42f7cf = self namespace_234f0efc::drop_armor(var_4c42f7cf + 1);
    }
    if (!isdefined(level.var_e2384c19)) {
        self.var_6dc4d968 = 1;
    }
    level function_28039abb();
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 4, eflags: 0x0
// Checksum 0x9da3b326, Offset: 0x2860
// Size: 0xce
function function_610d3790(*einflictor, victim, *idamage, *weapon) {
    if (is_true(weapon.var_c83d0859) || is_true(weapon.var_1eaa0d81)) {
        self.pers[#"objectiveekia"]++;
        self.objectiveekia = self.pers[#"objectiveekia"];
        self.pers[#"objectives"]++;
        self.objectives = self.pers[#"objectives"];
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 5, eflags: 0x4
// Checksum 0xe100bcea, Offset: 0x2938
// Size: 0x216
function private function_95002a59(attacker, victim, inflictor, weapon, meansofdeath) {
    if (attacker == self) {
        return;
    }
    var_e9d49a33 = 0;
    self notify(#"minigame_laststand");
    if (isdefined(weapon) && killstreaks::is_killstreak_weapon(weapon)) {
        var_e9d49a33 = 1;
    }
    if (!var_e9d49a33) {
        overrideentitycamera = player::function_c0f28ff9(attacker, weapon);
        var_50d1e41a = potm::function_775b9ad1(weapon, meansofdeath);
        potm::function_66d09fea(#"hash_11588f7b0737f095", attacker, self, inflictor, var_50d1e41a, overrideentitycamera);
    }
    if (isdefined(attacker)) {
        attacker.pers[#"downs"] = (isdefined(attacker.pers[#"downs"]) ? attacker.pers[#"downs"] : 0) + 1;
        attacker.downs = attacker.pers[#"downs"];
        if (is_true(victim.var_c83d0859) || is_true(victim.var_1eaa0d81)) {
            [[ level.var_37d62931 ]](attacker, 1);
            attacker.pers[#"objscore"]++;
            attacker.objscore = attacker.pers[#"objscore"];
        }
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x32e66fe9, Offset: 0x2b58
// Size: 0x54
function on_vehicle_spawned() {
    if (self.scriptvehicletype === "helicopter_heavy") {
        globallogic_audio::function_61e17de0("dirtyBombVehSpawn", getplayers(undefined, self.origin, 6000));
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xb771187c, Offset: 0x2bb8
// Size: 0x4c
function function_c3623479(vehicle) {
    globallogic_audio::function_61e17de0("dirtyBombVehSpawn", getplayers(undefined, vehicle.origin, 6000));
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xab3afb40, Offset: 0x2c10
// Size: 0x124
function function_1f93e91f(params) {
    if (isdefined(params.vehicletype)) {
        droppoint = params.droppoint;
        offset = (0, 0, 10000);
        trace = groundtrace(params.droppoint + offset, params.droppoint - offset, 0, undefined, 0);
        if (isdefined(trace[#"position"])) {
            droppoint = trace[#"position"];
        }
        globallogic_audio::function_61e17de0("dirtyBombVehDrop", getplayers(undefined, droppoint, 6000));
        return;
    }
    globallogic_audio::function_61e17de0("dirtyBombSupplyDrop", getplayers());
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xf3f8fca6, Offset: 0x2d40
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
// Params 5, eflags: 0x4
// Checksum 0xe497e85d, Offset: 0x2e08
// Size: 0x114
function private function_a997e9c5(index, id, origin, angles, var_fd3ba46d = 0) {
    self endon(#"disconnect");
    dropitem = level item_drop::drop_item(index, undefined, 1, 0, id, origin, angles, 2);
    if (var_fd3ba46d && isplayer(self)) {
        dropitem hidefromplayer(self);
        self waittill(#"death_delay_finished");
        if (isplayer(self) && isdefined(dropitem)) {
            dropitem showtoplayer(self);
        }
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0xcc02cc11, Offset: 0x2f28
// Size: 0x1da
function private function_15d1af86(var_4c42f7cf) {
    if (!isplayer(self)) {
        assert(0);
        return;
    }
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
        self thread function_a997e9c5(var_4c42f7cf + index, itempoint.id, self.origin, (0, randomintrange(0, 360), 0), index == var_e3483afe - 1);
    }
    return var_4c42f7cf + index;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0xbb81d35f, Offset: 0x3110
// Size: 0xfa
function private function_d67bd905(var_4c42f7cf) {
    assert(isplayer(self));
    index = 0;
    if (function_cc2c46fd(self)) {
        itempoint = function_4ba8fde("uranium_pouch_item_t9");
        level thread item_drop::drop_item(var_4c42f7cf + index, undefined, 1, 0, itempoint.id, self.origin, (0, randomintrange(0, 360), 0), 2);
        index++;
        self clientfield::set_player_uimodel("hudItems.uraniumMaxCarry", 5);
    }
    return var_4c42f7cf + index;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x1ad94de, Offset: 0x3218
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
// Checksum 0xc610de3c, Offset: 0x32f0
// Size: 0x73e
function function_d897b60a() {
    level endon(#"game_ended");
    updatepass = 0;
    while (true) {
        foreach (index, player in getplayers()) {
            if (index % 10 == updatepass) {
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
                        player thread function_6ade1bbf(0);
                    }
                    continue;
                }
                var_cc03b04e = player clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
                var_4a68766 = player function_8e4e3bb2();
                if (var_4a68766) {
                    player clientfield::set_to_player("ftdb_inZone", 1);
                } else {
                    player clientfield::set_to_player("ftdb_inZone", 0);
                }
                if (var_4a68766) {
                    if (gettime() >= player.radiation.var_f1c51b06 + level.var_a6cec0dc) {
                        var_2f42039 = level.var_81a49fc0 * var_cc03b04e;
                        var_cad9861a = level.var_ee660ce0 * (1 + var_2f42039);
                        player.radiation.var_abd7d46a -= var_cad9861a;
                        while (player.radiation.var_abd7d46a < 0 && player.radiation.var_32adf91d < level.var_c43aac04) {
                            player.radiation.var_32adf91d++;
                            player.radiation.var_abd7d46a += level.radiation.levels[player.radiation.var_32adf91d].maxhealth;
                            var_56bea7c = 1;
                        }
                        if (player.radiation.var_abd7d46a < 0) {
                            player.radiation.var_abd7d46a = 0;
                        }
                        if (var_56bea7c) {
                            var_76f7b10e = 0;
                            if (player.radiation.var_32adf91d == 1) {
                                player luinotifyevent(#"hash_7adc508fd96535c9", 0);
                                var_76f7b10e = 2;
                            }
                            player globallogic_audio::leader_dialog_on_player("dirtyBombRadStage" + player.radiation.var_32adf91d);
                            player thread function_6ade1bbf(var_76f7b10e);
                        }
                        player function_3c1f8280();
                        player.radiation.var_f1c51b06 = gettime();
                    }
                } else {
                    if (player.radiation.var_32adf91d == 0 && player.radiation.var_abd7d46a >= level.radiation.levels[0].maxhealth) {
                        if (is_true(player.var_cfc4949c)) {
                            player.var_cfc4949c = undefined;
                            player thread function_6ade1bbf(0);
                        }
                        player function_3c1f8280();
                        continue;
                    }
                    if (gettime() >= player.radiation.var_f1c51b06 + level.var_bb0c0222) {
                        var_4a34487 = level.var_a22f8001 * var_cc03b04e;
                        var_ac8e5dcc = level.var_f569833a * (1 - var_4a34487);
                        player.radiation.var_abd7d46a += var_ac8e5dcc;
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
                            player thread function_6ade1bbf(0);
                        }
                        player.radiation.var_f1c51b06 = gettime();
                    }
                }
                player function_9b065f90();
            }
        }
        updatepass = (updatepass + 1) % 10;
        waitframe(1);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0x6cffdb31, Offset: 0x3a38
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
// Params 0, eflags: 0x4
// Checksum 0x955b11ed, Offset: 0x3bb8
// Size: 0x34c
function private function_8249279b() {
    level endon(#"game_ended");
    while (true) {
        players = getplayers();
        var_cf0783b8 = [];
        foreach (player in getplayers()) {
            var_cf0783b8[player getentitynumber()] = player;
        }
        foreach (bomb in level.var_2f418a15) {
            if (!isdefined(bomb) || !isdefined(bomb.state) || !isdefined(bomb.trigger)) {
                continue;
            }
            if (bomb.state != 4) {
                continue;
            }
            var_3e08ae5 = getplayers(undefined, bomb.origin, 120);
            foreach (player in var_3e08ae5) {
                if (player istouching(bomb.trigger)) {
                    player val::set(#"fireteam_dirty_bomb", "disable_weapon_pickup", 1);
                    var_cf0783b8[player getentitynumber()] = undefined;
                }
            }
        }
        arrayremovevalue(var_cf0783b8, undefined, 1);
        foreach (player in var_cf0783b8) {
            player val::set(#"fireteam_dirty_bomb", "disable_weapon_pickup", 0);
        }
        wait 0.5;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x23cb2471, Offset: 0x3f10
// Size: 0x2c4
function function_f917644c() {
    var_cc03b04e = self clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
    if (var_cc03b04e == 0) {
        return;
    }
    itempoint = function_4ba8fde(#"uranium_item_t9");
    originoffset = (0, 0, 6);
    dropangles = self.angles + (0, randomintrange(-30, 30), 0);
    forward = anglestoforward(dropangles);
    droporigin = self.origin + originoffset + forward * (randomfloatrange(10, 30) + 18);
    traceresults = physicstraceex(self.origin + originoffset, droporigin, (0, 0, 0), (0, 0, 0), self, 1);
    if (traceresults[#"fraction"] < 1) {
        droporigin = traceresults[#"position"] - forward * 18;
    } else {
        droporigin -= forward * 18;
    }
    waitframe(1);
    if (!isdefined(self)) {
        return;
    }
    dropitem = self item_drop::drop_item(0, undefined, 1, 1, itempoint.id, droporigin, dropangles, 2);
    if (!isdefined(dropitem)) {
        return;
    }
    dropitem item_drop::function_801fcc9e(int(2 * 1000));
    dropitem.var_d25a1503 = self.team;
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
// Checksum 0xa6a3b1ee, Offset: 0x41e0
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
// Params 1, eflags: 0x0
// Checksum 0x4d5824a7, Offset: 0x4280
// Size: 0x2dc
function function_6ade1bbf(timedelay) {
    self endon(#"death", #"disconnect");
    level endon(#"game_ended");
    wait timedelay;
    if (!isdefined(self.radiation.var_32adf91d)) {
        return;
    }
    if (self.radiation.var_32adf91d == level.var_4fdf11d8) {
        radiation_ui::function_59621e3c(self, #"dot");
    }
    if (self.radiation.var_32adf91d >= 2) {
        self.heal.var_c8777194 = 1;
        self.n_regen_delay = 9;
        radiation_ui::function_59621e3c(self, #"hash_53d8a06b13ec49d9");
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
        radiation_ui::function_59621e3c(self, #"disable_perks");
        return;
    }
    self loadout::give_talents();
    self loadout::give_perks();
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x87492a43, Offset: 0x4568
// Size: 0xb4
function function_3c1f8280() {
    radiation_ui::function_137e7814(self, self.radiation.var_32adf91d);
    var_60ece81c = level.radiation.levels[self.radiation.var_32adf91d].maxhealth;
    percenthealth = self.radiation.var_abd7d46a / var_60ece81c;
    radiation_ui::function_835a6746(self, percenthealth);
    radiation_ui::function_36a2c924(self, 1 - percenthealth);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x53163698, Offset: 0x4628
// Size: 0x21a
function function_8e4e3bb2() {
    foreach (var_9bbce2cd in level.var_ac7be286) {
        var_8e392e0f = var_9bbce2cd.var_8e392e0f;
        if (distance2dsquared(self.origin, var_9bbce2cd.origin) < var_8e392e0f * var_8e392e0f) {
            return true;
        }
        ringindex = var_9bbce2cd.var_261dd536;
        for (var_1fa72977 = ringindex + 1; distance2dsquared(self.origin, var_9bbce2cd.origin) < (var_1fa72977 * 1000 + 1000) * (var_1fa72977 * 1000 + 1000) && var_1fa72977 > 0; var_1fa72977--) {
        }
        if (var_1fa72977 > ringindex) {
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
// Checksum 0x4dcf02f2, Offset: 0x4850
// Size: 0xe8
function function_c7c0cee2(var_9bbce2cd, ringindex) {
    assert(isplayer(self));
    for (i = 0; i < var_9bbce2cd.var_e17ae8be[ringindex].size; i++) {
        var_ac287808 = var_9bbce2cd.var_e17ae8be[ringindex][i];
        if (!isdefined(var_ac287808.model.curradius)) {
            continue;
        }
        if (distance2dsquared(self.origin, var_ac287808.origin) < var_ac287808.model.curradius * var_ac287808.model.curradius) {
            return true;
        }
    }
    return false;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x3af6494d, Offset: 0x4940
// Size: 0x3a0
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
            wait level.var_4e3c4685;
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
            luinotifyevent(#"hash_2977456e1832eba6");
            clientfield::set_world_uimodel("hud_items_dirty_bomb.bomb_respawn_disabled", 1);
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
            clientfield::set_world_uimodel("hud_items_dirty_bomb.bomb_respawn_disabled", 0);
        }
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xae4ee0d1, Offset: 0x4ce8
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
// Checksum 0xa081258f, Offset: 0x4e20
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
// Checksum 0x8419c500, Offset: 0x4e80
// Size: 0x21c
function function_ceb4a5e9() {
    if (level.dirtybombs.size < level.var_96cdb906) {
        level.dirtybombs = struct::get_array("fireteam_dirty_bomb", "variantname");
    }
    for (i = 0; i < level.var_96cdb906; i++) {
        bombindex = randomint(level.dirtybombs.size);
        var_5c73f0a2 = 0;
        attempts = 0;
        do {
            foreach (bomb in level.var_2f418a15) {
                if (bomb == level.dirtybombs[bombindex]) {
                    bombindex = randomint(level.dirtybombs.size);
                    var_5c73f0a2 = 1;
                    attempts++;
                    break;
                }
            }
            if (var_5c73f0a2) {
                bombindex = randomint(level.dirtybombs.size);
            }
        } while (var_5c73f0a2 && attempts < 10);
        level.var_2f418a15[level.var_2f418a15.size] = level.dirtybombs[bombindex];
        level.dirtybombs[bombindex] = level.dirtybombs[level.dirtybombs.size - 1];
        level.dirtybombs[level.dirtybombs.size - 1] = undefined;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x251f5db8, Offset: 0x50a8
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
// Checksum 0xf0f879bb, Offset: 0x5230
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
// Checksum 0xc6733732, Offset: 0x5300
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
// Params 4, eflags: 0x0
// Checksum 0x43f57d16, Offset: 0x5418
// Size: 0xac
function function_93098bd9(dialogkey, team, origin, radius) {
    if (!isdefined(dialogkey)) {
        assert(0);
        return;
    }
    if (!isdefined(team)) {
        assert(0);
        return;
    }
    players = getplayers(team, origin, radius);
    if (players.size > 0) {
        globallogic_audio::function_61e17de0(dialogkey, players);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 4, eflags: 0x0
// Checksum 0x35bbb569, Offset: 0x54d0
// Size: 0x100
function function_e43bca0f(dialogkey, skipteam, origin, radius) {
    if (!isdefined(dialogkey)) {
        assert(0);
        return;
    }
    if (!isdefined(skipteam)) {
        assert(0);
        return;
    }
    foreach (team, _ in level.teams) {
        if (team != skipteam) {
            function_93098bd9(dialogkey, team, origin, radius);
        }
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x1346c8d3, Offset: 0x55d8
// Size: 0x1f4
function function_c5d8437d() {
    function_cd2bee53();
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
// Checksum 0x7c94d6cd, Offset: 0x57d8
// Size: 0xea
function function_1c3c84b4() {
    function_cd2bee53();
    for (i = 0; i < level.var_2f418a15.size; i++) {
        bomb = level.var_2f418a15[i];
        if (isdefined(bomb.state) && bomb.state != 0) {
            continue;
        }
        bomb.objindex = i % 5;
        bomb function_f37d284();
        bomb function_b801b00c();
        objective_setgamemodeflags(bomb.objectiveid, 5);
        bomb.state = 1;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x69b1a522, Offset: 0x58d0
// Size: 0xc4
function function_cd2bee53() {
    if (level.var_910f361c.size == 0) {
        return;
    }
    foreach (objid in level.var_910f361c) {
        objective_delete(objid);
        gameobjects::release_obj_id(objid);
    }
    level.var_910f361c = [];
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0xaca2a451, Offset: 0x59a0
// Size: 0x12c
function private function_f37d284() {
    self.model = spawn("script_model", self.origin + (0, 0, 0));
    self.model.angles = self.angles;
    self.model setmodel("p9_wz_dirty_bomb_01");
    self.model.killcament = spawn("script_model", self.model.origin + (0, 0, 40));
    self.model.killcament setmodel(#"tag_origin");
    self.model.killcament.angles = (0, 0, 0);
    self.model.killcament setweapon(level.weaponnone);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0x96e39347, Offset: 0x5ad8
// Size: 0x64
function private function_b801b00c() {
    self.objectiveid = gameobjects::get_next_obj_id();
    objective = level.var_d8fd137b[self.objindex];
    objective_add(self.objectiveid, "active", self.model, objective);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0xc3695851, Offset: 0x5b48
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
// Checksum 0x962575f6, Offset: 0x5cd8
// Size: 0x254
function private function_fcc87504(triggerstruct) {
    if (is_true(level.gameended)) {
        return;
    }
    activator = triggerstruct.activator;
    if (is_true(activator.var_9dc65a85)) {
        return;
    }
    bomb = self.bomb;
    if (!function_a4521a9b(activator)) {
        return;
    }
    if (!function_ad9de896(activator, bomb)) {
        return;
    }
    activator playloopsound(#"hash_444112674e0eba78");
    activator.var_c83d0859 = 1;
    for (success = activator function_99898a2d(bomb); success && bomb.state == 2; success = activator function_99898a2d(bomb)) {
        if (!function_a4521a9b(activator)) {
            break;
        }
        if (!function_ad9de896(activator, bomb)) {
            break;
        }
        self triggerenable(1);
    }
    activator stoploopsound();
    if (isalive(activator) && !activator inlaststand()) {
        activator.var_c83d0859 = undefined;
    }
    var_a5d31314 = activator clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
    if (bomb.state == 2 && var_a5d31314 <= 0) {
        bomb.model playsoundtoplayer(#"hash_1cc6a788d45a7d48", activator);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0x9146269, Offset: 0x5f38
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
// Params 1, eflags: 0x4
// Checksum 0x5be5bc4c, Offset: 0x60d0
// Size: 0x34
function private function_45a85e5b(revivee) {
    if (!isdefined(self) || !isdefined(revivee)) {
        return false;
    }
    return self.var_1eaa0d81 !== 1;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x0
// Checksum 0x1c79c475, Offset: 0x6110
// Size: 0x11c
function function_ad9de896(player, bomb) {
    if (!isplayer(player)) {
        assert(0);
        return false;
    }
    if (!isdefined(bomb)) {
        assert(0);
        return false;
    }
    if (!isdefined(bomb.model)) {
        return false;
    }
    var_14448f85 = (0, 0, 24);
    camerapos = player getplayercamerapos();
    traceresult = bullettrace(camerapos, bomb.origin + var_14448f85, 0, player, 0, 0);
    if (traceresult[#"entity"] !== bomb.model) {
        return false;
    }
    return true;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0x92091c7, Offset: 0x6238
// Size: 0x60
function function_a4521a9b(player) {
    if (player isinvehicle()) {
        return false;
    }
    var_cc03b04e = player clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
    if (var_cc03b04e > 0) {
        return true;
    }
    return false;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0x5a00404a, Offset: 0x62a0
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
// Checksum 0x1047ba2b, Offset: 0x6360
// Size: 0x4a4
function function_3b72c4b2(player) {
    if (game.state != #"playing") {
        return;
    }
    if (self.state != 2) {
        return;
    }
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
        function_e2d09d87(player.team);
    }
    scoreevents::processscoreevent(#"hash_405ccdd657f10e0e", player);
    player clientfield::set_player_uimodel("hudItems.uraniumCarryCount", var_cc03b04e - 1);
    [[ level.var_37d62931 ]](player, 1);
    player.pers[#"dirty_bomb_deposits"] = (isdefined(player.pers[#"dirty_bomb_deposits"]) ? player.pers[#"dirty_bomb_deposits"] : 0) + 1;
    player.dirty_bomb_deposits = player.pers[#"dirty_bomb_deposits"];
    player.pers[#"objscore"]++;
    player.objscore = player.pers[#"objscore"];
    player stats::function_bb7eedf0(#"dirty_bomb_deposits", 1);
    if (game.state != #"playing") {
        return;
    }
    level function_28039abb();
    if (var_cc03b04e - 1 <= 0) {
        player clientfield::set("carryingUranium", 0);
        player function_53d7badf(0);
    }
    if (self.var_cc03b04e >= level.var_3990ce92) {
        self function_5c84cd7c();
        if (isdefined(player)) {
            function_93098bd9("dirtyBombPrimedFriendly", player.team, self.origin, 4500);
            function_e43bca0f("dirtyBombPrimedEnemy", player.team, self.origin, 4500);
            players = getplayers(player.team);
            foreach (var_7b66d20c in players) {
                if (!isdefined(var_7b66d20c.var_b0a8d09c) && isalive(var_7b66d20c)) {
                    var_7b66d20c luinotifyevent(#"hash_6b67aa04e378d681", 1, 15);
                    var_7b66d20c.var_b0a8d09c = 1;
                }
            }
        }
        self thread function_4b31d6ba();
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xf8432da4, Offset: 0x6810
// Size: 0x11c
function function_704fdca0(player) {
    self endon(#"disconnect");
    if (self.state == 2) {
        player function_3bf6db8b(#"defaultstate", self.trigger);
        player clientfield::set_to_player("using_bomb", 1);
    } else if (self.state == 4) {
        self.trigger function_6e23e4cb(player);
        player function_3bf6db8b(#"detonating", self.trigger);
        player clientfield::set_to_player("using_bomb", 2);
    }
    player.var_9dc65a85 = 1;
    objective_setplayerusing(self.objectiveid, player);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0xd4aff007, Offset: 0x6938
// Size: 0x5a
function private function_63909e4a() {
    if (!isplayer(self)) {
        return;
    }
    if (isalive(self) && !self inlaststand()) {
        self.var_1eaa0d81 = undefined;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xf8580d79, Offset: 0x69a0
// Size: 0x164
function function_ea25bba7(player) {
    if (self.state == 2) {
        player function_80d6d39b(&function_a4521a9b);
        player.var_c83d0859 = undefined;
    } else if (self.state == 4) {
        player function_80d6d39b();
        self.trigger function_6e23e4cb();
        player function_63909e4a();
        if (!getdvarint(#"hash_6d01658e46435b76", 0)) {
            player enableweaponcycling();
            player thread take_use_weapon(level.var_696298a2);
            player killstreaks::switch_to_last_non_killstreak_weapon();
        } else {
            player setlowready(0);
        }
    }
    player.var_9dc65a85 = 0;
    if (isdefined(self.objectiveid)) {
        objective_clearplayerusing(self.objectiveid, player);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0x33e0be51, Offset: 0x6b10
// Size: 0xdc
function take_use_weapon(useweapon) {
    self endon(#"use_hold", #"death", #"disconnect");
    level endon(#"game_ended");
    while (self getcurrentweapon() == useweapon && !self.throwinggrenade) {
        waitframe(1);
    }
    if (is_true(useweapon.var_d2751f9d)) {
        self val::reset(#"gameobject_use", "disable_gestures");
    }
    self takeweapon(useweapon);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x68ea0db0, Offset: 0x6bf8
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
// Checksum 0xae41658c, Offset: 0x6d78
// Size: 0x82
function function_b43466d5() {
    self.model.killcament delete();
    self.model delete();
    objective_delete(self.objectiveid);
    gameobjects::release_obj_id(self.objectiveid);
    self.var_cc03b04e = undefined;
    self.state = 0;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xce0deb33, Offset: 0x6e08
// Size: 0x6c
function function_5c84cd7c() {
    self.state = 3;
    function_4339912c(self.objectiveid);
    self.model playsound(#"hash_2013c3b9f7d5a632");
    self.trigger delete();
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xd6cebb53, Offset: 0x6e80
// Size: 0xe4
function function_4b31d6ba() {
    level endon(#"game_ended");
    if (level.var_e39b6425 != 0) {
        self.model playsound(#"hash_4835397d4779d016");
        wait level.var_e39b6425;
        self.model stopsound(#"hash_4835397d4779d016");
        self.model playsound(#"hash_1e349183ce55d6ff");
    }
    self function_99c4c4e5();
    self thread function_dc70ca08();
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x3d6d24d4, Offset: 0x6f70
// Size: 0xbc
function function_99c4c4e5() {
    self.state = 4;
    function_6da98133(self.objectiveid);
    objective_setgamemodeflags(self.objectiveid, 3);
    objective_setprogress(self.objectiveid, 0);
    self function_6a9ca122();
    self.trigger thread function_f9f4b255();
    if (level.var_2f418a15.size == 1) {
        self thread function_2eeb579c();
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0x54b71900, Offset: 0x7038
// Size: 0x1de
function private function_6a9ca122() {
    self.trigger = spawn("trigger_radius_use", self.origin + (0, 0, 12), 0, 120, 90, 1);
    self.trigger triggerignoreteam();
    self.trigger setcursorhint("HINT_NOICON");
    self.trigger triggerenable(1);
    self.trigger usetriggerignoreuseholdtime();
    self.trigger sethintstring("MENU/PROMPT_DIRTY_BOMB_DETONATE");
    self.trigger callback::on_trigger(&function_2f5dd98c);
    self.trigger.bomb = self;
    self.var_dac45cd5 = spawn("trigger_radius", self.origin + (0, 0, 12), 0, 120, 90, 1);
    self.var_dac45cd5 triggerignoreteam();
    self.var_dac45cd5 triggerenable(0);
    self.var_dac45cd5 callback::on_trigger(&function_43bfe93d);
    self.var_dac45cd5 setinvisibletoall();
    self.var_dac45cd5.bomb = self;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0xb08dc71a, Offset: 0x7220
// Size: 0xb4
function private function_2f5dd98c(triggerstruct) {
    if (is_true(level.gameended)) {
        return;
    }
    activator = triggerstruct.activator;
    if (is_true(activator.var_9dc65a85)) {
        return;
    }
    bomb = self.bomb;
    if (bomb.state != 4) {
        return;
    }
    if (isdefined(bomb.trigger.activator)) {
        return;
    }
    activator function_84cb44bc(bomb);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0x88f3cb90, Offset: 0x72e0
// Size: 0x24e
function private function_84cb44bc(bomb) {
    self endon(#"disconnect");
    if (bomb.state == 4) {
        if (!getdvarint(#"hash_6d01658e46435b76", 0)) {
            if (self isswitchingweapons()) {
                return;
            }
            useweapon = level.var_696298a2;
            if (is_true(useweapon.var_d2751f9d)) {
                self val::set(#"gameobject_use", "disable_gestures");
            }
            if (!self hasweapon(useweapon)) {
                self giveweapon(useweapon);
            }
            self setweaponammostock(useweapon, 0);
            self setweaponammoclip(useweapon, 0);
            self switchtoweapon(useweapon);
            self disableweaponcycling();
        } else {
            self setlowready(1);
        }
        bomb.trigger setinvisibletoall();
        bomb.trigger setvisibletoplayer(self);
        bomb.var_dac45cd5 triggerenable(1);
        bomb.var_dac45cd5 setvisibletoteam(self.team);
        bomb.var_dac45cd5 setinvisibletoplayer(self);
        self.var_1eaa0d81 = 1;
        bomb thread function_704fdca0(self);
        bomb.trigger.activator = self;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0x9c739ecf, Offset: 0x7538
// Size: 0xe4
function private function_43bfe93d(triggerstruct) {
    if (is_true(level.gameended)) {
        return;
    }
    activator = triggerstruct.activator;
    if (is_true(activator.var_9dc65a85)) {
        return;
    }
    bomb = self.bomb;
    if (bomb.state != 4) {
        return;
    }
    if (!isdefined(bomb.trigger.activator) || bomb.trigger.activator.team != activator.team) {
        return;
    }
    activator function_f79653f(bomb);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0x26a38bf, Offset: 0x7628
// Size: 0xa4
function private function_f79653f(bomb) {
    self endon(#"disconnect");
    if (bomb.state == 4) {
        if (!isdefined(bomb.trigger.assists)) {
            bomb.trigger.assists = [];
        }
        bomb.trigger.assists[bomb.trigger.assists.size] = self;
        bomb thread function_704fdca0(self);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x4
// Checksum 0x3c03e9a9, Offset: 0x76d8
// Size: 0x574
function private function_f9f4b255() {
    self endon(#"death");
    self.assists = [];
    prevtime = gettime();
    var_e18791f4 = int(level.var_b06a1891 * 1000);
    totalprogress = 0;
    var_b1c451bf = int(level.var_f4a1440c / 0.05 * 1000);
    bomb = self.bomb;
    while (isdefined(bomb) && bomb.state == 4) {
        if (isdefined(self.activator)) {
            bomb.model playloopsound(#"hash_5093c3a0e7047aa", 0.5);
            var_39c4d694 = !self.activator function_8e1791eb(bomb);
            if (var_39c4d694) {
                bomb thread function_ea25bba7(self.activator);
                bomb.var_dac45cd5 triggerenable(0);
                bomb.var_dac45cd5 setinvisibletoall();
                bomb.trigger setvisibletoall();
                self.activator function_63909e4a();
            }
            for (i = 0; i < self.assists.size; i++) {
                player = self.assists[i];
                if (var_39c4d694) {
                    bomb thread function_ea25bba7(player);
                    continue;
                }
                if (!player function_75a48e71(bomb)) {
                    bomb thread function_ea25bba7(player);
                    for (j = i; j < self.assists.size; j++) {
                        if (j + 1 >= self.assists.size) {
                            self.assists[j] = undefined;
                            continue;
                        }
                        self.assists[j] = self.assists[j + 1];
                    }
                    i--;
                }
            }
            if (var_39c4d694) {
                self.assists = [];
            }
            deltatime = gettime() - prevtime;
            progress = deltatime * (1 + self.assists.size);
            progress = min(progress, var_b1c451bf);
            totalprogress += progress;
            if (totalprogress >= var_e18791f4) {
                bomb thread function_5c0f763b(self.activator);
                break;
            }
            if (totalprogress > 0) {
                if (isdefined(bomb.objectiveid)) {
                    objective_setprogress(bomb.objectiveid, totalprogress / var_e18791f4);
                }
                self.activator function_9db99d2f(totalprogress / var_e18791f4);
                self.activator function_45c10c43(self.assists.size + 1);
                foreach (player in self.assists) {
                    player function_9db99d2f(totalprogress / var_e18791f4);
                    player function_45c10c43(self.assists.size + 1);
                }
            }
            if (var_39c4d694) {
                self.activator = undefined;
            }
        } else if (!level.var_3a9e7236) {
            totalprogress = 0;
            if (isdefined(bomb.objectiveid)) {
                objective_setprogress(bomb.objectiveid, 0);
            }
        }
        if (!isdefined(self.activator)) {
            bomb.model stoploopsound(0.25);
        }
        prevtime = gettime();
        wait 0.05;
    }
    if (isdefined(bomb) && isdefined(bomb.model)) {
        bomb.model stoploopsound(0.25);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0x9395ceb1, Offset: 0x7c58
// Size: 0x15e
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
    if (!isdefined(bomb.var_fe46e837)) {
        bomb.var_fe46e837 = [];
    }
    playerentnum = self getentitynumber();
    if (!isdefined(bomb.var_fe46e837[playerentnum]) || bomb.var_fe46e837[playerentnum] < gettime()) {
        bomb.var_fe46e837[playerentnum] = gettime() + 1;
        if (!function_ad9de896(self, bomb)) {
            return false;
        }
    }
    return true;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0x953abebe, Offset: 0x7dc0
// Size: 0xb6
function function_75a48e71(bomb) {
    if (bomb.state != 4) {
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
    if (!bomb.var_dac45cd5 istriggerenabled()) {
        return false;
    }
    if (!self istouching(bomb.var_dac45cd5)) {
        return false;
    }
    return true;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x3ae60637, Offset: 0x7e80
// Size: 0x84
function function_dc70ca08() {
    self endon(#"hash_51134d620e14f47b");
    level endon(#"game_ended");
    if (level.var_451f847f == 0) {
        return;
    }
    wait level.var_451f847f;
    while (isdefined(self.trigger.activator)) {
        waitframe(1);
    }
    waitframe(1);
    self function_1283ff24(undefined);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x9e0237e0, Offset: 0x7f10
// Size: 0x84
function function_2eeb579c() {
    self endon(#"hash_51134d620e14f47b");
    level endon(#"game_ended");
    if (level.var_d86d5820 == 0) {
        return;
    }
    wait level.var_d86d5820;
    while (isdefined(self.trigger.activator)) {
        waitframe(1);
    }
    waitframe(1);
    self function_1283ff24(undefined);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xd1226548, Offset: 0x7fa0
// Size: 0x364
function function_5c0f763b(player) {
    if (!isdefined(player)) {
        return;
    }
    self notify(#"hash_51134d620e14f47b");
    if (level.var_77720414) {
        player globallogic_score::giveteamscoreforobjective(player.team, level.var_77720414);
        function_e2d09d87(player.team);
    }
    level function_28039abb();
    scoreevents::processscoreevent(#"hash_179603173879ec50", player);
    if (isdefined(player.var_e2e8198f) && player.var_e2e8198f >= gettime() - int(3 * 1000)) {
        scoreevents::processscoreevent(#"hash_54db302236ce9572", player);
    }
    [[ level.var_37d62931 ]](player, 1);
    player.pers[#"dirty_bomb_detonates"] = (isdefined(player.pers[#"dirty_bomb_detonates"]) ? player.pers[#"dirty_bomb_detonates"] : 0) + 1;
    player.dirty_bomb_detonates = player.pers[#"dirty_bomb_detonates"];
    player.pers[#"objscore"]++;
    player.objscore = player.pers[#"objscore"];
    player stats::function_bb7eedf0(#"dirty_bomb_detonates", 1);
    player function_80d6d39b();
    if (!getdvarint(#"hash_6d01658e46435b76", 0)) {
        player enableweaponcycling();
        player thread take_use_weapon(level.var_696298a2);
        player killstreaks::switch_to_last_non_killstreak_weapon();
    } else {
        player setlowready(0);
    }
    player.var_9dc65a85 = 0;
    player function_63909e4a();
    if (isdefined(self.objectiveid)) {
        objective_clearplayerusing(self.objectiveid, player);
    }
    for (i = 0; i < self.trigger.assists.size; i++) {
        self thread function_ea25bba7(self.trigger.assists[i]);
    }
    self function_1283ff24(player);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xfe596dd4, Offset: 0x8310
// Size: 0xf0
function function_1a29cdb0(winningteam) {
    if (!isdefined(level.var_edac6118)) {
        level.var_edac6118 = 0;
    }
    if (!level.var_edac6118) {
        foreach (losingteam, _ in level.teams) {
            if (losingteam != winningteam) {
                globallogic_audio::function_61e17de0("objLosing", getplayers(losingteam));
            }
        }
        level.var_edac6118 = 1;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0x627e5ae7, Offset: 0x8408
// Size: 0x188
function function_e2d09d87(team) {
    if (!isdefined(level.dirtyBombScore50)) {
        level.dirtyBombScore50 = [];
    }
    if (!isdefined(level.dirtyBombScore75)) {
        level.dirtyBombScore75 = [];
    }
    if (!isdefined(team)) {
        return;
    }
    scorelimit = level.scorelimit < 0 ? 1 : level.scorelimit;
    scorepercentage = getteamscore(team) / scorelimit;
    if (scorepercentage >= 0.75) {
        if (!isdefined(level.dirtyBombScore75[team])) {
            globallogic_audio::function_61e17de0("dirtyBombScore75", getplayers(team));
        }
        level.dirtyBombScore75[team] = 1;
        function_1a29cdb0(team);
        return;
    }
    if (scorepercentage >= 0.5) {
        if (!isdefined(level.dirtyBombScore50[team])) {
            globallogic_audio::function_61e17de0("dirtyBombScore50", getplayers(team));
        }
        level.dirtyBombScore50[team] = 1;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0x38fda2dc, Offset: 0x8598
// Size: 0x134
function function_28039abb(var_aaba141c) {
    if (!isdefined(level.var_7392007f)) {
        level.var_7392007f = "";
    }
    var_aaba141c = function_7fc57bc9();
    var_9c1ed9ea = undefined;
    if (var_aaba141c >= 0.925) {
        var_9c1ed9ea = "ftdb_endgame_high";
    } else if (var_aaba141c >= 0.85) {
        var_9c1ed9ea = "ftdb_endgame_med";
    } else if (var_aaba141c >= 0.75) {
        var_9c1ed9ea = "ftdb_endgame_low";
    }
    if (!isdefined(var_9c1ed9ea)) {
        return;
    }
    if (level.var_7392007f != var_9c1ed9ea) {
        globallogic_audio::function_6fbfba95(var_9c1ed9ea);
        level.var_7392007f = var_9c1ed9ea;
        if (!is_true(level.var_acf54eb7)) {
            level.var_acf54eb7 = 1;
            clientfield::set("sndDeactivateSquadSpawnMusic", 1);
        }
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x29b95d5c, Offset: 0x86d8
// Size: 0x112
function function_7fc57bc9() {
    if (!isdefined(level.teams)) {
        return 0;
    }
    scorelimit = level.scorelimit < 0 ? 1 : level.scorelimit;
    var_ab9897d4 = [];
    foreach (team in level.teams) {
        array::add(var_ab9897d4, getteamscore(team) / scorelimit);
    }
    array::sort_by_value(var_ab9897d4);
    return var_ab9897d4[0];
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xe1311c09, Offset: 0x87f8
// Size: 0x13c
function function_1283ff24(player) {
    if (game.state != #"playing") {
        return;
    }
    if (isdefined(self.objectiveid)) {
        objective_setgamemodeflags(self.objectiveid, 1);
        objective_setteam(self.objectiveid, isdefined(player.team) ? player.team : #"hash_34db99d80fb3607f");
        objective_setprogress(self.objectiveid, 0);
    }
    self.state = 5;
    self.trigger delete();
    self.var_dac45cd5 delete();
    if (isdefined(self.model)) {
        self.model clientfield::set("ftdb_zoneCircle", 3);
    }
    self thread bombcountdown(player);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0x78f9d1a7, Offset: 0x8940
// Size: 0x154
function bombcountdown(player) {
    level endon(#"game_ended");
    if (isdefined(player)) {
        function_93098bd9("dirtyBombArmedFriendly", player.team, self.origin, 4500);
        function_e43bca0f("dirtyBombArmedEnemy", player.team, self.origin, 4500);
    } else {
        globallogic_audio::function_61e17de0("dirtyBombArmedEnemy", getplayers(undefined, self.origin, 4500));
    }
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
// Checksum 0x7cf9c115, Offset: 0x8aa0
// Size: 0x4ac
function function_91c39737(player) {
    origin = self.origin;
    damage = level.var_60e3f99c;
    playsoundatposition("exp_dirty_bomb_explo", origin + (0, 0, 60));
    if (isdefined(player)) {
        function_93098bd9("dirtyBombDetonatedFriendly", player.team, self.origin, 4500);
        function_e43bca0f("dirtyBombDetonatedEnemy", player.team, self.origin, 4500);
    } else {
        globallogic_audio::function_61e17de0("dirtyBombDetonatedEnemy", getplayers(undefined, self.origin, 4500));
    }
    entities = getdamageableentarray(origin, level.var_60693fca, 1);
    foreach (entity in entities) {
        if (!isalive(entity)) {
            continue;
        }
        if (isplayer(entity)) {
            entity.var_f5dc0dbf = 1;
            if (isdefined(player.team) && isdefined(entity.team) && entity.team == player.team) {
                entity dodamage(damage, origin, entity, self.model, undefined, "MOD_EXPLOSIVE");
                continue;
            }
        }
        entity.killcamkilledbyent = self.model.killcament;
        entity.killcament = self.model.killcament;
        entity dodamage(damage, origin, player, self.model, undefined, "MOD_EXPLOSIVE");
    }
    fwd = (0, 0, 1);
    right = (0, -1, 0);
    playfx("wz/fx9_dirtybomb_exp", origin, fwd, right);
    if (isentity(self.model)) {
        self.model.killcament delete();
        self.model delete();
    }
    if (isdefined(self.objectiveid)) {
        objective_setgamemodeflags(self.objectiveid, 4);
        level.var_910f361c[level.var_910f361c.size] = self.objectiveid;
        objective_setinvisibletoall(self.objectiveid);
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
    self.state = 0;
    if (level.var_2f418a15.size == 1 && level.var_2f418a15[0].state == 4) {
        level.var_2f418a15[0] thread function_2eeb579c();
    }
    if (level.var_2c9f7c6b) {
        self thread function_57172b7();
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0x68e610d7, Offset: 0x8f58
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
// Checksum 0x8c844c67, Offset: 0x9028
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
// Checksum 0xecf87090, Offset: 0x9138
// Size: 0x10a
function private function_3bf6db8b(state, usetrigger) {
    if (!level.dirtybombusebar dirtybomb_usebar::is_open(self)) {
        level.dirtybombusebar dirtybomb_usebar::open(self, 4);
    }
    level.dirtybombusebar dirtybomb_usebar::set_state(self, state);
    level.dirtybombusebar dirtybomb_usebar::function_f0df5702(self, 0);
    if (isarray(usetrigger.assists)) {
        level.dirtybombusebar dirtybomb_usebar::function_4aa46834(self, usetrigger.assists.size + 1);
    }
    usetrigger setinvisibletoplayer(self, 1);
    self.var_814cca3f = usetrigger;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0xe9635474, Offset: 0x9250
// Size: 0xe6
function private function_80d6d39b(var_aaa102e3 = undefined) {
    if (!isplayer(self)) {
        return;
    }
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
// Checksum 0x76c453b3, Offset: 0x9340
// Size: 0x4c
function private function_9db99d2f(frac) {
    if (level.dirtybombusebar dirtybomb_usebar::is_open(self)) {
        level.dirtybombusebar dirtybomb_usebar::function_f0df5702(self, frac);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x4
// Checksum 0x7f55f18, Offset: 0x9398
// Size: 0x4c
function private function_45c10c43(count) {
    if (level.dirtybombusebar dirtybomb_usebar::is_open(self)) {
        level.dirtybombusebar dirtybomb_usebar::function_4aa46834(self, count);
    }
}

/#

    // Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
    // Params 0, eflags: 0x0
    // Checksum 0x1024282c, Offset: 0x93f0
    // Size: 0x4d4
    function function_64d94faa() {
        level endon(#"game_ended");
        level.var_8c48fd1 = 0;
        level.var_a0cb7a38 = [];
        while (true) {
            waitframe(1);
            level.var_2c9f7c6b = isdefined(getgametypesetting(#"hash_1cf5e61c49992dc3")) ? getgametypesetting(#"hash_1cf5e61c49992dc3") : 0;
            level.var_cd139dc0 = (isdefined(getgametypesetting(#"hash_7f837b709840950")) ? getgametypesetting(#"hash_7f837b709840950") : 0) * 100;
            level.var_67432513 = (isdefined(getgametypesetting(#"hash_6cd4374035db175e")) ? getgametypesetting(#"hash_6cd4374035db175e") : 0) * 100;
            level.var_d18d7655 = (isdefined(getgametypesetting(#"hash_786ee581eedabff0")) ? getgametypesetting(#"hash_786ee581eedabff0") : 0) * 100;
            level.var_7108bd31 = isdefined(getgametypesetting(#"hash_eff3a2f99071600")) ? getgametypesetting(#"hash_eff3a2f99071600") : 0;
            level.var_c0839e43 = isdefined(getgametypesetting(#"hash_162ebc3912b68841")) ? getgametypesetting(#"hash_162ebc3912b68841") : 0;
            level.var_de7aa071 = isdefined(getgametypesetting(#"hash_570912155889089e")) ? getgametypesetting(#"hash_570912155889089e") : 0;
            level.var_aa6b51f5 = isdefined(getgametypesetting(#"hash_5d04a19b625d7300")) ? getgametypesetting(#"hash_5d04a19b625d7300") : 0;
            level.var_35b75d82 = isdefined(getgametypesetting(#"hash_371e83f096bf0548")) ? getgametypesetting(#"hash_371e83f096bf0548") : 0;
            level.var_380f7d22 = getdvarint(#"hash_59bc959721744fcb", 200);
            players = getplayers();
            foreach (player in players) {
                if (player usebuttonpressed() && !is_true(level.var_a0cb7a38[level.var_8c48fd1])) {
                    level.var_2f418a15[level.var_8c48fd1] thread function_33e28605(level.var_8c48fd1);
                    level.var_8c48fd1++;
                    level.var_8c48fd1 %= 3;
                    wait 0.5;
                }
            }
        }
    }

    // Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
    // Params 1, eflags: 0x0
    // Checksum 0xef83c207, Offset: 0x98d0
    // Size: 0x4c
    function function_33e28605(var_f07efec7) {
        level.var_a0cb7a38[var_f07efec7] = 1;
        self function_57172b7();
        level.var_a0cb7a38[var_f07efec7] = 0;
    }

    // Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
    // Params 0, eflags: 0x0
    // Checksum 0x82fc173a, Offset: 0x9928
    // Size: 0x1fe
    function function_3d8141ab() {
        level endon(#"game_ended");
        while (!isdefined(self.var_b06ed2fa)) {
            waitframe(1);
        }
        while (isdefined(self.var_b06ed2fa)) {
            var_1b8f1752 = self.var_b06ed2fa getscale();
            sphere(self.var_b06ed2fa.origin, level.var_cd139dc0 * var_1b8f1752, (0, 1, 0), 0.5, 1, 100, 1);
            foreach (ring in self.var_e17ae8be) {
                foreach (circle in ring) {
                    var_a13932b6 = circle.model getscale();
                    sphere(circle.model.origin, self.circleradius * var_a13932b6, (0, 1, 0), 0.5, 1, 100, 1);
                }
            }
            waitframe(1);
        }
    }

#/

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x279e36ce, Offset: 0x9b30
// Size: 0x250
function function_57172b7() {
    level endon(#"game_ended");
    /#
        if (getdvarint(#"hash_1216cbfbf11758ce", 0)) {
            self thread function_3d8141ab();
        }
    #/
    level.var_ac7be286[level.var_ac7be286.size] = self;
    self function_6a583613();
    globallogic_audio::function_61e17de0("dirtyBombRadExpand", getplayers(undefined, self.origin, 4500));
    self.var_261dd536++;
    while (self.var_261dd536 < self.numrings) {
        self function_87a78a13();
        self.var_261dd536++;
    }
    wait level.var_c0839e43;
    globallogic_audio::function_61e17de0("dirtyBombRadRecede", getplayers(undefined, self.origin, 4500));
    self.var_261dd536--;
    while (self.var_261dd536 >= 0) {
        self function_5c839f44();
        self.var_261dd536--;
    }
    var_a8c6fd3b = level.var_de7aa071 / (self.numrings + 1);
    wait var_a8c6fd3b;
    self function_ea7ab3a9();
    for (i = 0; i < level.var_ac7be286.size; i++) {
        if (self == level.var_ac7be286[i]) {
            level.var_ac7be286[i] = level.var_ac7be286[level.var_ac7be286.size - 1];
            level.var_ac7be286[level.var_ac7be286.size - 1] = undefined;
        }
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xcc0f77fd, Offset: 0x9d88
// Size: 0x4c
function function_6a583613() {
    self.var_8e392e0f = level.var_cd139dc0;
    self.var_261dd536 = 0;
    self function_218080fb();
    self function_cd602d73();
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x7ef4986a, Offset: 0x9de0
// Size: 0x2da
function function_218080fb() {
    self.var_fa06c0e = [];
    self.var_e17ae8be = [];
    self.var_3401d807 = [];
    initialradius = level.var_cd139dc0;
    maxradius = randomintrange(level.var_d18d7655, level.var_67432513);
    self.numrings = int((maxradius - initialradius) / 800 + 0.5);
    var_92d713c7 = level.var_aa6b51f5;
    self.var_91017512 = (maxradius - initialradius) / (self.numrings - 1);
    self.circleradius = 800;
    for (i = 0; i < self.numrings; i++) {
        self.var_fa06c0e[i] = [];
        self.var_e17ae8be[i] = [];
        self.var_3401d807[i] = [];
        var_4fc3d1c0 = initialradius + self.var_91017512 * i;
        numcircles = int(var_4fc3d1c0 * 2 * 3.14159 / self.circleradius / 1 / (1 + var_92d713c7) + 0.5);
        angledelta = 360 / numcircles;
        for (j = 0; j < numcircles; j++) {
            angle = angledelta * j;
            vector = (cos(angle), sin(angle), 0);
            origin = self.origin + vectorscale(vector, var_4fc3d1c0);
            if (level.var_380f7d22 > 0) {
                offsetangle = randomint(360);
                offsetvector = (cos(offsetangle), sin(offsetangle), 0);
                var_3413960f = randomint(level.var_380f7d22);
                origin += vectorscale(offsetvector, var_3413960f);
            }
            self.var_fa06c0e[i][j] = origin;
        }
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x8d9be399, Offset: 0xa0c8
// Size: 0xba
function function_cd602d73() {
    self.var_b06ed2fa = spawn("script_model", self.origin);
    self.var_b06ed2fa.team = #"neutral";
    self.var_b06ed2fa setmodel("tag_origin");
    self.var_b06ed2fa clientfield::set("ftdb_zoneCircle", 2);
    self.var_b06ed2fa.numrings = self.numrings;
    self.var_b06ed2fa.var_2c8491dd = self;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xcca600bc, Offset: 0xa190
// Size: 0x2b4
function function_87a78a13() {
    var_b75abae3 = level.var_7108bd31 / self.numrings;
    if (self.var_261dd536 >= 2) {
        nextradius = self.var_8e392e0f + self.var_91017512;
        currentscale = self.var_8e392e0f / level.var_cd139dc0;
        var_ac2ef1c2 = nextradius / level.var_cd139dc0;
        self thread function_6941b393(currentscale, var_ac2ef1c2, var_b75abae3);
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
                origin = self.var_fa06c0e[j][index];
                self.var_fa06c0e[j][index] = self.var_fa06c0e[j][self.var_fa06c0e[j].size - 1];
                self.var_fa06c0e[j][self.var_fa06c0e[j].size - 1] = undefined;
                var_5162de87 = self function_2be7a212(j, origin);
                var_5162de87 thread function_60c3117b(0.1, 1, 5, 0);
                break;
            }
            index -= self.var_fa06c0e[j].size;
        }
    }
    if (self.var_261dd536 >= 2) {
        self thread function_f8afee63(self.var_261dd536 - 2);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x37d853d5, Offset: 0xa450
// Size: 0x204
function function_5c839f44() {
    var_b75abae3 = level.var_de7aa071 / (self.numrings + 1);
    if (self.var_261dd536 + 1 < self.numrings) {
        nextradius = self.var_8e392e0f - self.var_91017512;
        currentscale = self.var_8e392e0f / level.var_cd139dc0;
        var_ac2ef1c2 = nextradius / level.var_cd139dc0;
        if (self.var_261dd536 > 0) {
            self thread function_6941b393(currentscale, var_ac2ef1c2, var_b75abae3);
        } else {
            self thread function_6941b393(currentscale, var_ac2ef1c2, var_b75abae3 * 2);
        }
    }
    maxindex = self.var_e17ae8be[self.var_261dd536].size;
    var_7a62ca2 = self.var_261dd536 - 1;
    if (var_7a62ca2 >= 0) {
        for (i = 0; i < self.var_3401d807[var_7a62ca2].size; i++) {
            var_5162de87 = self function_2be7a212(var_7a62ca2, self.var_3401d807[var_7a62ca2][i]);
        }
    }
    if (maxindex == 0) {
        wait var_b75abae3;
        return;
    }
    loopmax = maxindex - 1;
    var_1082b7c4 = var_b75abae3 / maxindex;
    for (i = loopmax; i >= 0; i--) {
        wait var_1082b7c4;
        self thread function_40c81ea4(self.var_261dd536, i);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0x5f3586ca, Offset: 0xa660
// Size: 0x16e
function function_f8afee63(ringindex) {
    self endon(#"death");
    level endon(#"game_ended");
    for (i = self.var_fa06c0e[ringindex].size - 1; i >= 0; i--) {
        self.var_fa06c0e[ringindex][i] = undefined;
    }
    for (i = self.var_e17ae8be[ringindex].size - 1; i >= 0; i--) {
        self.var_e17ae8be[ringindex][i].model clientfield::set("ftdb_zoneCircle", 4);
        self.var_3401d807[ringindex][self.var_3401d807[ringindex].size] = self.var_e17ae8be[ringindex][i].model.origin;
        util::wait_network_frame(1);
        self.var_e17ae8be[ringindex][i].model delete();
        self.var_e17ae8be[ringindex][i] = undefined;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x0
// Checksum 0x5d5d42d4, Offset: 0xa7d8
// Size: 0x306
function function_2be7a212(ringindex, origin) {
    origin += (0, 0, 16);
    var_9912c765 = (0, 0, 200);
    attempts = 1;
    uptrace = bullettrace(origin, origin + var_9912c765, 0, self);
    downtrace = bullettrace(origin, origin - var_9912c765, 0, self);
    while (downtrace[#"fraction"] == 1 && uptrace[#"fraction"] == 1 && attempts < 10) {
        uptrace = bullettrace(origin + var_9912c765 * attempts, origin + var_9912c765 * (attempts + 1), 0, self);
        downtrace = bullettrace(origin - var_9912c765 * attempts, origin - var_9912c765 * (attempts + 1), 0, self);
        attempts++;
    }
    if (downtrace[#"fraction"] <= uptrace[#"fraction"]) {
        origin = downtrace[#"position"];
    } else {
        origin = uptrace[#"position"];
    }
    radindex = self.var_e17ae8be[ringindex].size;
    self.var_e17ae8be[ringindex][radindex] = {};
    self.var_e17ae8be[ringindex][radindex].origin = origin;
    self.var_e17ae8be[ringindex][radindex].model = spawn("script_model", origin);
    self.var_e17ae8be[ringindex][radindex].model.team = #"neutral";
    self.var_e17ae8be[ringindex][radindex].model setmodel("tag_origin");
    self.var_e17ae8be[ringindex][radindex].model clientfield::set("ftdb_zoneCircle", 1);
    self.var_e17ae8be[ringindex][radindex].model.var_2c8491dd = self;
    return self.var_e17ae8be[ringindex][radindex].model;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 4, eflags: 0x0
// Checksum 0x5a3c4306, Offset: 0xaae8
// Size: 0x1ac
function function_60c3117b(startscale, var_5ad0dc76, duration, var_8253fe22) {
    self endon(#"death");
    level endon(#"game_ended");
    starttime = gettime();
    if (startscale < 0.1) {
        startscale = 0.1;
    }
    self setscale(startscale);
    waitframe(1);
    while (gettime() < starttime + int(duration * 1000)) {
        timefrac = (gettime() - starttime) / int(duration * 1000);
        scale = startscale + timefrac * (var_5ad0dc76 - startscale);
        if (scale < 0.1) {
            self setscale(0.1);
            return;
        }
        self setscale(scale);
        if (var_8253fe22) {
            self.var_2c8491dd.var_8e392e0f = level.var_cd139dc0 * scale;
        } else {
            self.curradius = scale * self.var_2c8491dd.circleradius;
        }
        waitframe(1);
    }
    self setscale(var_5ad0dc76);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 3, eflags: 0x0
// Checksum 0x9bf8e211, Offset: 0xaca0
// Size: 0x84
function function_6941b393(startscale, endscale, duration) {
    self endon(#"death");
    level endon(#"game_ended");
    var_65bcb0ae = duration / 2;
    wait var_65bcb0ae;
    self.var_b06ed2fa function_60c3117b(startscale, endscale, var_65bcb0ae, 1);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x0
// Checksum 0xe8454712, Offset: 0xad30
// Size: 0x9c
function function_40c81ea4(ringindex, circleindex) {
    self endon(#"death");
    level endon(#"game_ended");
    var_867cdc1a = self.var_e17ae8be[ringindex][circleindex];
    var_867cdc1a.model function_60c3117b(1, 0.1, 5, 0);
    self function_7886d66d(ringindex, var_867cdc1a);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x0
// Checksum 0x1e9e9f81, Offset: 0xadd8
// Size: 0x92
function function_7886d66d(ringindex, var_867cdc1a) {
    var_867cdc1a.model clientfield::set("ftdb_zoneCircle", 4);
    util::wait_network_frame(1);
    var_867cdc1a.model delete();
    self.var_e17ae8be[ringindex][self.var_e17ae8be[ringindex].size - 1] = undefined;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0x9eedf6d8, Offset: 0xae78
// Size: 0x6e
function function_ea7ab3a9() {
    if (isdefined(self.var_b06ed2fa)) {
        self.var_b06ed2fa clientfield::set("ftdb_zoneCircle", 4);
        util::wait_network_frame(1);
        self.var_b06ed2fa delete();
        self.var_b06ed2fa = undefined;
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 0, eflags: 0x0
// Checksum 0xf6f01aaf, Offset: 0xaef0
// Size: 0x5c
function function_afa7ee8d() {
    level endon(#"game_ended");
    level waittill(#"item_world_reset");
    level thread function_588a586d(#"dirty_bomb_stash", level.var_b9f31e66);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x0
// Checksum 0x3c431c78, Offset: 0xaf58
// Size: 0x1a4
function function_588a586d(targetname, probability) {
    level flag::wait_till(#"item_world_reset");
    dynents = item_world::function_7a0c5d2e(probability, targetname);
    var_b0d9d129 = spawnstruct();
    var_81e77cec = [];
    var_d73eec3b = [];
    foreach (dynent in dynents) {
        dynent.onuse = &chest_opened;
        if (function_ffdbe8c2(dynent) == 3) {
            var_81e77cec[var_81e77cec.size] = dynent;
            continue;
        }
        var_d73eec3b[var_d73eec3b.size] = dynent;
    }
    var_81e77cec = array::randomize(var_81e77cec);
    var_b0d9d129.targetname = targetname;
    var_b0d9d129.var_81e77cec = var_81e77cec;
    var_b0d9d129.var_d73eec3b = var_d73eec3b;
    level thread function_361e7925(var_b0d9d129);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 2, eflags: 0x0
// Checksum 0x80988ef, Offset: 0xb108
// Size: 0x22c
function function_657c0cbf(container, var_b0d9d129) {
    level endon(#"game_ended");
    wait level.var_8c05a764;
    item_world::function_160294c7(container);
    wait randomintrange(level.var_89a6bd00, level.var_65a0fe4d);
    if (var_b0d9d129.var_81e77cec.size <= 0) {
        return;
    }
    if (isdefined(var_b0d9d129.var_81e77cec[0].itemlistbundle.var_7fb0967b)) {
        var_b9ea4e83 = sqr(var_b0d9d129.var_81e77cec[0].itemlistbundle.var_7fb0967b);
        for (var_8017ce8 = 0; var_8017ce8 < var_b0d9d129.var_81e77cec.size; var_8017ce8++) {
            var_da1a8a8a = var_b0d9d129.var_81e77cec[var_8017ce8];
            var_9bf5a850 = 1;
            for (var_31371606 = 0; var_31371606 < var_b0d9d129.var_d73eec3b.size; var_31371606++) {
                var_f51e9342 = var_b0d9d129.var_d73eec3b[var_31371606];
                if (distancesquared(var_da1a8a8a.origin, var_f51e9342.origin) < var_b9ea4e83) {
                    var_9bf5a850 = 0;
                    break;
                }
            }
            if (var_9bf5a850) {
                break;
            }
            var_da1a8a8a = undefined;
        }
    }
    if (!isdefined(var_da1a8a8a)) {
        var_da1a8a8a = var_b0d9d129.var_81e77cec[0];
    }
    arrayremoveindex(var_b0d9d129.var_81e77cec, 0, 0);
    item_world::function_8eee98dd(var_da1a8a8a);
    var_da1a8a8a.onuse = &chest_opened;
    var_b0d9d129.var_d73eec3b[var_b0d9d129.var_d73eec3b.size] = var_da1a8a8a;
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xfd56f238, Offset: 0xb340
// Size: 0xb0
function function_361e7925(var_b0d9d129) {
    level endon(#"game_ended");
    while (true) {
        container = level waittill(var_b0d9d129.targetname + "_opened");
        arrayremovevalue(var_b0d9d129.var_d73eec3b, container, 0);
        var_b0d9d129.var_81e77cec[var_b0d9d129.var_81e77cec.size] = container;
        level thread function_657c0cbf(container, var_b0d9d129);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 3, eflags: 0x0
// Checksum 0xa4220be2, Offset: 0xb3f8
// Size: 0x5e
function chest_opened(*activator, *laststate, state) {
    if (state == 2) {
        level notify((isdefined(self.targetname) ? self.targetname : self.target) + "_opened", self);
    }
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0x24f0dcc0, Offset: 0xb460
// Size: 0x9c
function function_c0e544cc(params) {
    player = params.player;
    player endon(#"death", #"disconnect");
    while (true) {
        if (player isonground()) {
            break;
        }
        wait 1;
    }
    player luinotifyevent(#"hash_6b67aa04e378d681", 1, 13);
}

// Namespace fireteam_dirty_bomb/fireteam_dirty_bomb
// Params 1, eflags: 0x0
// Checksum 0xeca58240, Offset: 0xb508
// Size: 0x1d6
function function_b7821ed9(var_b77770ba) {
    if (isdefined(var_b77770ba) && var_b77770ba % 2 == 0) {
        return;
    }
    if (!isdefined(level.var_2f418a15) || level.var_2f418a15.size <= 0) {
        return;
    }
    bomborigin = level.var_2f418a15[randomintrange(0, level.var_2f418a15.size)].origin;
    if (!isdefined(bomborigin)) {
        return;
    }
    for (index = 0; index < 10; index++) {
        radius = randomfloatrange(0, 1);
        var_bd74a98c = sqrt(radius) * 3000;
        degree = randomintrange(0, 360);
        x = var_bd74a98c * cos(degree);
        y = var_bd74a98c * sin(degree);
        droppoint = (bomborigin[0] + x, bomborigin[1] + y, bomborigin[2]);
        if (!oob::chr_party(droppoint)) {
            if (isdefined(function_9cc082d2(droppoint, 15000))) {
                return droppoint;
            }
        }
    }
}

