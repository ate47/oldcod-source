#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\gamestate_util;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\laststand;
#using scripts\mp_common\player\player_killed;
#using scripts\mp_common\teams\teams;

#namespace wz_contracts;

// Namespace wz_contracts/wz_contracts
// Params 0, eflags: 0x6
// Checksum 0x8ff1e8db, Offset: 0x110
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"wz_contracts", &preinit, undefined, undefined, undefined);
}

// Namespace wz_contracts/wz_contracts
// Params 0, eflags: 0x4
// Checksum 0xc1a30f37, Offset: 0x158
// Size: 0x54
function private preinit() {
    if (!isdefined(level.challengescallbacks)) {
        level.challengescallbacks = [];
    }
    contracts::init_player_contract_events();
    callback::on_finalize_initialization(&finalize_init);
}

// Namespace wz_contracts/wz_contracts
// Params 0, eflags: 0x0
// Checksum 0x190fbe66, Offset: 0x1b8
// Size: 0x5bc
function finalize_init() {
    if (can_process_contracts()) {
        callback::on_connect(&on_player_connect);
        callback::on_player_killed(&on_player_killed);
        callback::on_player_damage(&on_player_damage);
        callback::on_downed(&on_player_downed);
        callback::on_revived(&on_player_revived);
        callback::on_ai_killed(&on_ai_killed);
        callback::on_vehicle_killed(&on_vehicle_killed);
        callback::on_item_pickup(&on_player_item_pickup);
        callback::on_item_use(&function_9d4c3c52);
        callback::on_stash_open(&on_stash_open);
        callback::add_callback("on_driving_wz_vehicle", &on_driving_wz_vehicle);
        callback::add_callback(#"hash_677c43609aa6ce47", &function_5648f82);
        level.var_79a93566 = &function_902ef0de;
        level.var_f202fa67 = &function_a221f6d7;
        level.var_e3551fe4 = &function_a7cdb8f0;
        level.var_c3e2bb05 = 4;
        level.var_bd3ddb14 = &function_bd3ddb14;
        level.var_d9ae19f0 = &function_d9ae19f0;
        level.var_29ab88df = &function_29ab88df;
        level callback::add_callback(#"hash_7119d854cd41a4fd", &function_28ba0ba6);
        level callback::add_callback(#"vehicle_emped", &function_362499ea);
        level.operator_weapons = [#"ar_fastfire_t8_operator":1, #"ar_stealth_t8_operator":1, #"tr_longburst_t8_operator":1, #"tr_midburst_t8_operator":1, #"tr_powersemi_t8_operator":1, #"sniper_fastrechamber_t8_operator":1, #"sniper_quickscope_t8_operator":1, #"lmg_spray_t8_operator":1, #"lmg_standard_t8_operator":1, #"smg_accurate_t8_operator":1, #"smg_fastfire_t8_operator":1, #"pistol_revolver_t8_operator":1];
        level.var_f290f0ba = [#"hash_6a0d13acf3e5687d":1, #"hash_33f7121f70c3065f":2, #"hash_2b546c0315159617":3, #"hash_3ad3de90342f2d4b":4, #"hash_61373b747c6a21fd":5, #"hash_43647ef7af66f82f":6, #"hash_49e8a607ea22e650":7, #"zombie_stash_graveyard_quest":8, #"hash_ca8b234ad1fea38":9, #"hash_4ee6deffa30cc6e2":10, #"hash_47a63bc4a605b45f":11, #"hash_779cba7072600ad1":12, #"hash_75cc919e81dc8b19":13, #"hash_2a93e93b275c38ed":14, #"hash_734bf5054445e0df":15, #"hash_408b3ed7db6f9401":16, #"hash_550872d1d1938f94":17, #"zombie_stash_graveyard_ee":18, #"hash_a211476d10546c":19, #"hash_7d028af90dad72ae":20, #"zombie_supply_stash_boxinggym":21, #"zombie_supply_stash_diner":22, #"zombie_supply_stash_lighthouse":23, #"hash_2783dbab1f862606":24, #"hash_6dea2e4afc816818":25, #"hash_4b49cb98f0fd776a":26, #"hash_468067e2be6e3cfd":27, #"zombie_stash_graveyard":28, #"hospital_stash":29, #"hash_78f8f730158519ff":30];
        callback::add_callback(#"hash_5775ae80fc576ea6", &function_314e09eb);
        /#
            thread devgui_setup();
        #/
    }
}

// Namespace wz_contracts/wz_contracts
// Params 0, eflags: 0x0
// Checksum 0x9abcafe0, Offset: 0x780
// Size: 0x2c
function on_player_connect() {
    self contracts::setup_player_contracts(3, &function_1d4c6768);
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0xe4d27b37, Offset: 0x7b8
// Size: 0xfc
function on_ai_killed(params) {
    if (isplayer(params.eattacker)) {
        attacker = params.eattacker;
        if ("_zombie" === self.scoretype) {
            attacker increment_wz_contract(#"contract_wz_kill_zombies");
        }
        if (isdefined(params.weapon)) {
            weapon = params.weapon;
            if (weapon.statname == #"ray_gun" || weapon.statname == #"ray_gun_mk2") {
                attacker increment_wz_contract(#"hash_662a7934c69c5aa7");
            }
        }
    }
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0xfda1928b, Offset: 0x8c0
// Size: 0xc4
function on_vehicle_killed(params) {
    if (isdefined(params)) {
        if (isplayer(params.eattacker)) {
            attacker = params.eattacker;
            if (!attacker util::isenemyteam(self.team)) {
                return;
            }
            if (isdefined(params.weapon)) {
                weapon = params.weapon;
                if (weapon.statname == #"eq_tripwire") {
                    attacker increment_wz_contract(#"hash_5468af4499f0c7fe");
                }
            }
        }
    }
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0xe4321599, Offset: 0x990
// Size: 0xc14
function on_player_killed(*death_params) {
    if (teams::is_all_dead(self.team) || !self player::function_73da2f89()) {
        self function_521ac7e5();
    }
    if (!isdefined(self.laststandparams)) {
        return;
    }
    attacker = self.laststandparams.attacker;
    weapon = self.laststandparams.weapon;
    if (!isplayer(attacker)) {
        return;
    }
    if (!attacker util::isenemyteam(self.team)) {
        return;
    }
    entnum = self getentitynumber();
    if (isdefined(attacker.var_9a787df5) && is_true(attacker.var_9a787df5[entnum])) {
        attacker increment_wz_contract(#"hash_1567f7b8fb5d379a");
    } else {
        attacker increment_wz_contract(#"hash_4bc7882cf1404beb");
    }
    if (death_circle::is_active() && isdefined(level.deathcircleindex)) {
        if (!isdefined(attacker.var_4f1edabd) || attacker.var_4f1edabd < level.deathcircleindex) {
            attacker.var_4f1edabd = level.deathcircleindex;
            attacker increment_wz_contract(#"hash_427ce6c8328c38d0");
        }
    }
    if (attacker isinvehicle() && !attacker isremotecontrolling()) {
        e_vehicle = attacker getvehicleoccupied();
        n_seat = e_vehicle getoccupantseat(attacker);
        if (isdefined(n_seat) && n_seat != 0) {
            attacker increment_wz_contract(#"hash_222aca7930cc6c4f");
        }
        turret_weapon = e_vehicle seatgetweapon(n_seat);
        if (isdefined(turret_weapon) && self.laststandparams.smeansofdeath != "MOD_CRUSH") {
            attacker increment_wz_contract(#"hash_6e74e2826c57979a");
        }
    }
    if (isdefined(level.deathcircle.players) && array::contains(level.deathcircle.players, attacker)) {
        attacker increment_wz_contract(#"hash_27068f5b82298af6");
    }
    if (isdefined(self.var_156bf46e)) {
        vehicle = self.var_156bf46e;
        if (isdefined(vehicle) && isvehicle(vehicle) && !vehicle isremotecontrol()) {
            attacker increment_wz_contract(#"hash_3a8e1cd16ced090d");
        }
    }
    if (attacker isplayerswimming()) {
        attacker increment_wz_contract(#"contract_wz_swimming_kill");
    }
    if (isdefined(attacker.var_700a5910)) {
        dt = (gettime() - attacker.var_700a5910) / 1000;
        if (dt <= 3) {
            attacker increment_wz_contract(#"hash_d0e756015e4f2e4");
        }
    }
    if (attacker === self.var_53b73ccf) {
        dt = (gettime() - self.var_2481a15b) / 1000;
        if (dt <= 2) {
            attacker increment_wz_contract(#"contract_wz_kill_player_you_downed");
        }
    }
    if (self laststand_mp::is_reviving_any()) {
        attacker increment_wz_contract(#"hash_579396af83d0d2b6");
    }
    var_96f43b4d = attacker.origin[2] - self.origin[2];
    if (var_96f43b4d >= 787.402) {
        attacker increment_wz_contract(#"hash_165a9439e9bfe79e");
    }
    if (isdefined(self.laststunnedtime)) {
        if (isdefined(self.var_45b88627)) {
            var_38dce50e = self.var_45b88627;
        } else {
            var_38dce50e = gettime();
        }
        dt = (var_38dce50e - self.laststunnedtime) / 1000;
        if (dt <= 3) {
            attacker increment_wz_contract(#"contract_wz_kill_concussed_player");
        }
    }
    if (isdefined(attacker) && isdefined(attacker.pers) && isdefined(attacker.pers[#"characterindex"])) {
        n_character_index = attacker.pers[#"characterindex"];
        rf = getplayerrolefields(n_character_index, currentsessionmode());
        if (isdefined(rf)) {
            if (!isdefined(rf.modecategory)) {
                rf.modecategory = 0;
            }
            switch (rf.modecategory) {
            case 0:
                attacker increment_wz_contract(#"contract_wz_zm_player_character_kill");
                break;
            case 1:
                attacker increment_wz_contract(#"contract_wz_mp_player_character_kill");
                break;
            case 2:
                break;
            case 3:
                attacker increment_wz_contract(#"contract_wz_wz_player_character_kill");
                break;
            }
        }
    }
    if (isdefined(weapon)) {
        if (weapon.statname == #"melee_bowie") {
            if (!isdefined(attacker.var_6f3e3a9c)) {
                attacker.var_6f3e3a9c = 1;
                attacker thread function_e49226a4();
            } else {
                attacker.var_6f3e3a9c++;
                if (attacker.var_6f3e3a9c >= 2) {
                    attacker.var_6f3e3a9c = undefined;
                    attacker increment_wz_contract(#"hash_375ede206821cb1");
                }
            }
        }
        if (weapon.statname == #"hatchet") {
            n_dist = distance(attacker.origin, self.origin);
            if (n_dist >= 3937.01) {
                attacker increment_wz_contract(#"hash_29c133baf1e0570a");
            }
        }
        var_49f7c24a = 0;
        weaponclass = util::getweaponclass(weapon);
        if (isdefined(weaponclass)) {
            switch (weaponclass) {
            case #"weapon_assault":
                attacker increment_wz_contract(#"contract_wz_ar_kill");
                var_49f7c24a = 1;
                break;
            case #"weapon_lmg":
                attacker increment_wz_contract(#"contract_wz_lmg_kill");
                var_49f7c24a = 1;
                break;
            case #"weapon_pistol":
                attacker increment_wz_contract(#"contract_wz_pistol_kill");
                var_49f7c24a = 1;
                break;
            case #"weapon_cqb":
                attacker increment_wz_contract(#"contract_wz_shotgun_kill");
                var_49f7c24a = 1;
                break;
            case #"weapon_smg":
                attacker increment_wz_contract(#"contract_wz_smg_kill");
                var_49f7c24a = 1;
                break;
            case #"weapon_sniper":
                attacker increment_wz_contract(#"contract_wz_sniper_kill");
                var_49f7c24a = 1;
                break;
            case #"weapon_grenade":
                if (!isdefined(attacker.var_c9daf540)) {
                    attacker.var_c9daf540 = 1;
                    attacker thread function_db2da6f7();
                } else {
                    attacker.var_c9daf540++;
                    if (attacker.var_c9daf540 >= 2) {
                        attacker.var_c9daf540 = undefined;
                        attacker increment_wz_contract(#"hash_6d2f5796b496e676");
                    }
                }
                break;
            default:
                break;
            }
        }
        if (var_49f7c24a) {
            if (!isdefined(attacker.var_9c8d1c79)) {
                attacker.var_9c8d1c79 = [];
            }
            if (attacker.var_9c8d1c79.size < 3 && !array::contains(attacker.var_9c8d1c79, weapon)) {
                array::add(attacker.var_9c8d1c79, weapon, 0);
                if (attacker.var_9c8d1c79.size >= 3) {
                    attacker increment_wz_contract(#"contract_wz_kill_with_different_guns");
                }
            }
        }
        if (weapon.inventorytype === "offhand") {
            attacker increment_wz_contract(#"contract_wz_equipment_kill");
        }
        if (is_true(level.operator_weapons[weapon.name])) {
            attacker increment_wz_contract(#"contract_wz_operator_kill");
        }
    }
}

// Namespace wz_contracts/wz_contracts
// Params 0, eflags: 0x0
// Checksum 0x5def635e, Offset: 0x15b0
// Size: 0x3e
function function_e49226a4() {
    self endon(#"death");
    wait 10;
    if (isplayer(self)) {
        self.var_6f3e3a9c = undefined;
    }
}

// Namespace wz_contracts/wz_contracts
// Params 0, eflags: 0x0
// Checksum 0x1f19a9e8, Offset: 0x15f8
// Size: 0x3e
function function_db2da6f7() {
    self endon(#"disconnect");
    wait 0.25;
    if (isplayer(self)) {
        self.var_c9daf540 = undefined;
    }
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0x4c1de34f, Offset: 0x1640
// Size: 0x84
function on_player_damage(params) {
    if (!isdefined(params)) {
        return;
    }
    attacker = params.eattacker;
    if (isplayer(attacker)) {
        if (attacker != self) {
            if (!isdefined(self.var_9a787df5)) {
                self.var_9a787df5 = [];
            }
            self.var_9a787df5[attacker getentitynumber()] = 1;
        }
    }
}

// Namespace wz_contracts/wz_contracts
// Params 0, eflags: 0x0
// Checksum 0x82cbac97, Offset: 0x16d0
// Size: 0x7a
function on_player_downed() {
    if (isdefined(self.laststandparams)) {
        attacker = self.laststandparams.attacker;
        if (!isplayer(attacker)) {
            return;
        }
        if (!attacker util::isenemyteam(self.team)) {
            return;
        }
        self.var_53b73ccf = attacker;
        self.var_2481a15b = gettime();
    }
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0xdcc64762, Offset: 0x1758
// Size: 0xbc
function on_player_revived(params) {
    if (isdefined(params.reviver)) {
        e_reviver = params.reviver;
        e_reviver increment_wz_contract(#"hash_4b331df1cf084980");
        if (isdefined(level.deathcircle.players) && array::contains(level.deathcircle.players, e_reviver)) {
            e_reviver increment_wz_contract(#"hash_3ff60e8cd6dabd89");
        }
    }
}

// Namespace wz_contracts/wz_contracts
// Params 0, eflags: 0x0
// Checksum 0x47f8d543, Offset: 0x1820
// Size: 0x7e
function can_process_contracts() {
    if (getdvarint(#"contracts_enabled", 0) == 0) {
        return false;
    }
    if (getdvarint(#"contracts_enabled_wz", 1) == 0) {
        return false;
    }
    if (!sessionmodeiswarzonegame()) {
        return false;
    }
    return true;
}

// Namespace wz_contracts/wz_contracts
// Params 2, eflags: 0x0
// Checksum 0xa90d09dd, Offset: 0x18a8
// Size: 0x7c
function increment_wz_contract(var_38280f2f, delta = 1) {
    if (!can_process_contracts() || !self contracts::is_contract_active(var_38280f2f)) {
        return;
    }
    if (level.inprematchperiod) {
        return;
    }
    self function_902ef0de(var_38280f2f, delta);
}

// Namespace wz_contracts/wz_contracts
// Params 2, eflags: 0x4
// Checksum 0x9ba6d3c5, Offset: 0x1930
// Size: 0x40c
function private function_902ef0de(var_38280f2f, delta) {
    /#
        if (getdvarint(#"scr_contract_debug_multiplier", 0) > 0) {
            delta *= getdvarint(#"scr_contract_debug_multiplier", 1);
        }
    #/
    if (delta <= 0) {
        return;
    }
    target_value = self.pers[#"contracts"][var_38280f2f].target_value;
    old_progress = isdefined(self.pers[#"contracts"][var_38280f2f].current_value) ? self.pers[#"contracts"][var_38280f2f].current_value : self.pers[#"contracts"][var_38280f2f].var_59cb904f;
    if (old_progress == target_value) {
        return;
    }
    new_progress = int(old_progress + delta);
    if (new_progress > target_value) {
        new_progress = target_value;
    }
    if (new_progress != old_progress) {
        self.pers[#"contracts"][var_38280f2f].current_value = new_progress;
        if (isdefined(level.contract_ids[var_38280f2f])) {
            self luinotifyevent(#"hash_4b04b1cb4b3498d0", 2, level.contract_ids[var_38280f2f], new_progress);
        }
    }
    if (old_progress < target_value && target_value <= new_progress) {
        var_9d12108c = isdefined(self.team) && isdefined(self.timeplayed[self.team]) ? self.timeplayed[self.team] : 0;
        self.pers[#"contracts"][var_38280f2f].var_be5bf249 = self stats::get_stat_global(#"time_played_total") - self.pers[#"hash_5651f00c6c1790a4"] + var_9d12108c;
        params = spawnstruct();
        params.player = self;
        params.var_38280f2f = var_38280f2f;
        self callback::callback(#"contract_complete", params);
        if (isdefined(level.contract_ids[var_38280f2f])) {
            self luinotifyevent(#"hash_1739c4bd5baf83bc", 1, level.contract_ids[var_38280f2f]);
        }
    }
    /#
        if (getdvarint(#"scr_contract_debug", 0) > 0) {
            iprintln(function_9e72a96(var_38280f2f) + "<dev string:x38>" + new_progress + "<dev string:x47>" + target_value);
            if (old_progress < target_value && target_value <= new_progress) {
                iprintln(function_9e72a96(var_38280f2f) + "<dev string:x4c>");
            }
        }
    #/
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x4
// Checksum 0x53b151ad, Offset: 0x1d48
// Size: 0x84
function private function_a221f6d7(var_38280f2f) {
    switch (var_38280f2f) {
    case #"contract_wz_quads_placement":
    case #"hash_42580a6cc2bf989e":
    case #"contract_wz_solo_placement":
    case #"hash_48730ce04835417f":
    case #"contract_wz_win_without_healing":
    case #"contract_wz_win_match":
        return true;
    }
    return false;
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x4
// Checksum 0x8fb80935, Offset: 0x1dd8
// Size: 0xe4
function private function_a7cdb8f0(var_38280f2f) {
    switch (var_38280f2f) {
    case #"hash_114034ef741c57c":
    case #"hash_67444eea6c3a2b4":
    case #"hash_137173b281445b4d":
    case #"hash_158213f4ee12211e":
    case #"hash_17ed7af10aadfdbf":
    case #"hash_1dbb5150a78086fb":
    case #"contract_wz_time_played":
    case #"hash_395b9be57a35044e":
    case #"hash_47ce5d5ec0614886":
    case #"hash_533d85cab61c7cbe":
    case #"hash_6bdbeb895b012fb2":
    case #"hash_6f4d7d1506be4c97":
        return true;
    }
    return false;
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0x77632dee, Offset: 0x1ec8
// Size: 0x22
function function_1d4c6768(slot) {
    return contracts::function_d17bcd3c(slot);
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0x879a8ce2, Offset: 0x1ef8
// Size: 0x2c
function function_bd3ddb14(e_player) {
    e_player increment_wz_contract(#"hash_101e4b07a4707d36");
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0xfa2af927, Offset: 0x1f30
// Size: 0x3c
function function_d9ae19f0(e_player) {
    e_player.var_b2f09f9f = 1;
    e_player increment_wz_contract(#"hash_6c95edbb431aa4e2");
}

// Namespace wz_contracts/wz_contracts
// Params 0, eflags: 0x0
// Checksum 0xa72baf56, Offset: 0x1f78
// Size: 0x92
function function_521ac7e5() {
    if (isdefined(self.var_56bd2c02)) {
        return;
    }
    team = self.team;
    var_9d12108c = isdefined(team) && isdefined(self.timeplayed[team]) ? self.timeplayed[team] : 0;
    self.var_56bd2c02 = self stats::get_stat_global(#"time_played_total") + var_9d12108c;
}

// Namespace wz_contracts/wz_contracts
// Params 0, eflags: 0x0
// Checksum 0x988ab14a, Offset: 0x2018
// Size: 0x92
function function_4ec3f8fe() {
    if (isdefined(self.var_c619a827)) {
        return;
    }
    team = self.team;
    var_9d12108c = isdefined(team) && isdefined(self.timeplayed[team]) ? self.timeplayed[team] : 0;
    self.var_c619a827 = self stats::get_stat_global(#"time_played_total") + var_9d12108c;
}

// Namespace wz_contracts/wz_contracts
// Params 2, eflags: 0x0
// Checksum 0x69738a3b, Offset: 0x20b8
// Size: 0x1a6
function function_29ab88df(a_players, var_c1735b56) {
    teamsize = getgametypesetting("maxTeamPlayers");
    foreach (player in a_players) {
        player function_4ec3f8fe();
        switch (teamsize) {
        case 1:
            if (var_c1735b56 <= 10) {
                player increment_wz_contract(#"contract_wz_solo_placement");
            }
            break;
        case 2:
            if (var_c1735b56 <= 5) {
                player increment_wz_contract(#"hash_48730ce04835417f");
            }
            break;
        case 4:
            if (var_c1735b56 <= 3) {
                player increment_wz_contract(#"contract_wz_quads_placement");
            }
            break;
        }
    }
}

// Namespace wz_contracts/wz_contracts
// Params 0, eflags: 0x0
// Checksum 0xc75e4c9e, Offset: 0x2268
// Size: 0xa8
function function_28ba0ba6() {
    a_players = get_alive_players();
    foreach (player in a_players) {
        player increment_wz_contract(#"hash_76a6aeacc63e7ce7");
    }
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0x9bf376b5, Offset: 0x2318
// Size: 0xbc
function function_362499ea(params) {
    player = params.attacker;
    if (isplayer(player)) {
        vehicle = params.vehicle;
        if (player util::isenemyteam(vehicle.team)) {
            var_bbc128bb = vehicle getspeedmph();
            if (var_bbc128bb > 0) {
                player increment_wz_contract(#"hash_614322e468d90148");
            }
        }
    }
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0xed1f27fa, Offset: 0x23e0
// Size: 0x1dc
function on_player_item_pickup(params) {
    if (!gamestate::is_state(#"playing") || !isdefined(params.item)) {
        return;
    }
    item = params.item;
    if (isplayer(self)) {
        if (!isdefined(self.var_7c5ea163)) {
            self.var_7c5ea163 = 0;
        }
        self.var_7c5ea163++;
        itementry = item.itementry;
        self increment_wz_contract(#"contract_wz_item_scavenged");
        if (itementry.itemtype == #"backpack") {
            if (!is_true(self.var_9ed7994f)) {
                self.var_9ed7994f = 1;
                self increment_wz_contract(#"contract_wz_backpack_scavenged");
            }
        }
        if (isdefined(item.targetname)) {
            if (isdefined(level.var_f290f0ba[item.targetname])) {
                if (!isdefined(self.var_b4dfe8d3)) {
                    self.var_b4dfe8d3 = [];
                }
                self.var_b4dfe8d3[item.targetname] = 1;
                if (self.var_b4dfe8d3.size >= 2 && !is_true(self.var_8958535a)) {
                    self.var_8958535a = 1;
                    self increment_wz_contract(#"hash_16305079185fffb7");
                }
            }
        }
    }
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0xf071b56a, Offset: 0x25c8
// Size: 0x94
function function_314e09eb(*item) {
    if (isdefined(self.inventory) && isdefined(self.inventory.consumed)) {
        if ((isdefined(self.inventory.consumed.size + 1) ? self.inventory.consumed.size + 1 : 0) >= 5) {
            increment_wz_contract(#"hash_5d572a379b7adf62");
        }
    }
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0x11a8e341, Offset: 0x2668
// Size: 0xc4
function function_9d4c3c52(params) {
    if (!gamestate::is_state(#"playing") || !isdefined(params.item)) {
        return;
    }
    item = params.item;
    if (isplayer(self)) {
        itementry = item.itementry;
        if (itementry.itemtype == #"armor_shard") {
            self increment_wz_contract(#"hash_209c6ecb45a25a6a");
        }
    }
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0xec85057c, Offset: 0x2738
// Size: 0x3ec
function function_9b431779(n_time_played) {
    n_time_played = float(n_time_played) / 60000;
    self increment_wz_contract(#"contract_wz_time_played", n_time_played);
    switch (level.gametype) {
    case #"warzone_solo":
    case #"warzone_escape_solo":
        self increment_wz_contract(#"hash_1dbb5150a78086fb", n_time_played);
        break;
    case #"warzone_duo":
    case #"warzone_escape_duo":
        self increment_wz_contract(#"hash_67444eea6c3a2b4", n_time_played);
        break;
    case #"warzone_quad":
    case #"warzone_escape_quad":
        self increment_wz_contract(#"hash_6f4d7d1506be4c97", n_time_played);
        break;
    case #"warzone_closequarters_duo":
    case #"warzone_closequarters_solo":
    case #"warzone_closequarters_quads":
        self increment_wz_contract(#"hash_bc7c4d0a20fd6b5", n_time_played);
        break;
    case #"warzone_hot_pursuit":
        self increment_wz_contract(#"hash_47ce5d5ec0614886", n_time_played);
        break;
    case #"warzone_hardcore_duo":
    case #"warzone_hardcore_quad":
    case #"warzone_hardcore_solo":
        self increment_wz_contract(#"hash_395b9be57a35044e", n_time_played);
        break;
    case #"warzone_ambush_quads":
    case #"warzone_ambush_duo":
    case #"warzone_ambush_solo":
        self increment_wz_contract(#"hash_114034ef741c57c", n_time_played);
        break;
    case #"warzone_dbno_quad":
    case #"hash_6ebd226da5b61bfb":
    case #"warzone_dbno":
        self increment_wz_contract(#"hash_137173b281445b4d", n_time_played);
        break;
    case #"warzone_bigteam_quad":
    case #"warzone_bigteam_dbno_quad":
        self increment_wz_contract(#"hash_16f3e3af0442596a", n_time_played);
        break;
    case #"warzone_spectre_rising":
        self increment_wz_contract(#"hash_533d85cab61c7cbe", n_time_played);
        break;
    }
    var_819e1b79 = isdefined(getgametypesetting(#"wzplayerinsertiontypeindex")) ? getgametypesetting(#"wzplayerinsertiontypeindex") : 0;
    if (var_819e1b79 == 1) {
        self increment_wz_contract(#"hash_17ed7af10aadfdbf", n_time_played);
    }
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0xba568d77, Offset: 0x2b30
// Size: 0x14e
function get_alive_players(disconnected_player) {
    a_alive_players = [];
    foreach (team in level.teams) {
        var_22d28a75 = getplayers(team);
        foreach (player in var_22d28a75) {
            if (player === disconnected_player) {
                continue;
            }
            if (isalive(player)) {
                a_alive_players[a_alive_players.size] = player;
            }
        }
    }
    return a_alive_players;
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0x6c77df14, Offset: 0x2c88
// Size: 0x19c
function on_driving_wz_vehicle(params) {
    if (level.inprematchperiod) {
        return;
    }
    vehicle = params.vehicle;
    player = params.player;
    seatindex = params.seatindex;
    var_9a8c81d3 = isairborne(vehicle);
    var_9f80c1b9 = vehicle.vehicleclass === "boat";
    var_e20fb13a = !var_9a8c81d3 && !var_9f80c1b9;
    if (var_9a8c81d3) {
        player.var_925d487 = 1;
    } else if (var_9f80c1b9) {
        player.var_8a507747 = 1;
    } else if (var_e20fb13a) {
        player.var_45708ffb = 1;
        if (seatindex == 0) {
            vehicle thread function_6fcfeebb(player);
        }
    }
    if (is_true(player.var_925d487) && is_true(player.var_8a507747) && is_true(player.var_45708ffb)) {
        player increment_wz_contract(#"contract_wz_entered_air_sea_land_vehicles");
    }
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0x7dc9a724, Offset: 0x2e30
// Size: 0x140
function function_6fcfeebb(player) {
    self endon(#"death");
    if (!isplayer(player)) {
        return;
    }
    player endon(#"exit_vehicle");
    player endon(#"death");
    player endon(#"disconnect");
    player endon(#"change_seat");
    while (true) {
        self waittill(#"veh_inair");
        time = gettime();
        self waittill(#"veh_landed");
        land_time = gettime();
        var_3cb46af = float(land_time - time) / 1000;
        if (var_3cb46af >= 2) {
            player increment_wz_contract(#"hash_64c765ebb1ad37db");
        }
    }
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0x1d1948af, Offset: 0x2f78
// Size: 0x9c
function on_stash_open(params) {
    if (!gamestate::is_state(#"playing") || !isdefined(params.activator)) {
        return;
    }
    activator = params.activator;
    if (isplayer(activator)) {
        if (isdefined(self.birthtime)) {
            activator increment_wz_contract(#"hash_20b07175517ed179");
        }
    }
}

// Namespace wz_contracts/wz_contracts
// Params 1, eflags: 0x0
// Checksum 0x20466d30, Offset: 0x3020
// Size: 0x20e
function function_5648f82(team) {
    teamsize = getgametypesetting("maxTeamPlayers");
    if (isdefined(team)) {
        foreach (player in getplayers(team)) {
            player increment_wz_contract(#"contract_wz_win_match");
            if (!isdefined(player.var_7c5ea163)) {
                player.var_7c5ea163 = 0;
            }
            if (player.var_7c5ea163 <= 20) {
                player increment_wz_contract(#"hash_42580a6cc2bf989e");
            }
            if (!is_true(player.var_b2f09f9f)) {
                player increment_wz_contract(#"contract_wz_win_without_healing");
            }
            switch (teamsize) {
            case 1:
                player increment_wz_contract(#"contract_wz_solo_placement");
                break;
            case 2:
                player increment_wz_contract(#"hash_48730ce04835417f");
                break;
            case 4:
                player increment_wz_contract(#"contract_wz_quads_placement");
                break;
            }
        }
    }
}

/#

    // Namespace wz_contracts/wz_contracts
    // Params 0, eflags: 0x0
    // Checksum 0x7378a517, Offset: 0x3238
    // Size: 0xa24
    function devgui_setup() {
        devgui_base = "<dev string:x6e>";
        wait 3;
        contracts::function_e07e542b(devgui_base, undefined);
        var_c8d599b5 = "<dev string:x7f>";
        var_78a6fb52 = devgui_base + "<dev string:xbc>";
        util::function_3f749abc(var_78a6fb52 + "<dev string:xd4>", var_c8d599b5 + "<dev string:xda>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xf1>", var_c8d599b5 + "<dev string:xf8>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x110>", var_c8d599b5 + "<dev string:x11a>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x135>", var_c8d599b5 + "<dev string:x140>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x15c>", var_c8d599b5 + "<dev string:x163>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x17b>", var_c8d599b5 + "<dev string:x185>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x1a0>", var_c8d599b5 + "<dev string:x1ad>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x1cb>", var_c8d599b5 + "<dev string:x1d7>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x1f4>", var_c8d599b5 + "<dev string:x1fb>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x218>", var_c8d599b5 + "<dev string:x239>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x25e>", var_c8d599b5 + "<dev string:x27a>");
        var_78a6fb52 = devgui_base + "<dev string:x2a2>";
        util::function_3f749abc(var_78a6fb52 + "<dev string:x2b3>", var_c8d599b5 + "<dev string:x2d3>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x2ff>", var_c8d599b5 + "<dev string:x314>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x33a>", var_c8d599b5 + "<dev string:x352>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x37d>", var_c8d599b5 + "<dev string:x38d>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x3a9>", var_c8d599b5 + "<dev string:x3c2>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x3e7>", var_c8d599b5 + "<dev string:x3fe>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x421>", var_c8d599b5 + "<dev string:x435>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x455>", var_c8d599b5 + "<dev string:x46c>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x48f>", var_c8d599b5 + "<dev string:x4a8>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x4cd>", var_c8d599b5 + "<dev string:x4ec>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x517>", var_c8d599b5 + "<dev string:x536>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x517>", var_c8d599b5 + "<dev string:x561>");
        var_78a6fb52 = devgui_base + "<dev string:x596>";
        util::function_3f749abc(var_78a6fb52 + "<dev string:x5a8>", var_c8d599b5 + "<dev string:x5b9>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x5d6>", var_c8d599b5 + "<dev string:x5ee>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x612>", var_c8d599b5 + "<dev string:x633>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x660>", var_c8d599b5 + "<dev string:x673>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x692>", var_c8d599b5 + "<dev string:x6b1>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x6d9>", var_c8d599b5 + "<dev string:x6f8>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x720>", var_c8d599b5 + "<dev string:x73f>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x767>", var_c8d599b5 + "<dev string:x783>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x7aa>", var_c8d599b5 + "<dev string:x7ce>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x802>", var_c8d599b5 + "<dev string:x819>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x83c>", var_c8d599b5 + "<dev string:x84f>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x86e>", var_c8d599b5 + "<dev string:x880>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x89e>", var_c8d599b5 + "<dev string:x8b0>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x8ce>", var_c8d599b5 + "<dev string:x8e1>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x900>", var_c8d599b5 + "<dev string:x91a>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x940>", var_c8d599b5 + "<dev string:x962>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x98d>", var_c8d599b5 + "<dev string:x9a3>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x9c5>", var_c8d599b5 + "<dev string:x9d7>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:x9f5>", var_c8d599b5 + "<dev string:xa0c>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xa2e>", var_c8d599b5 + "<dev string:xa42>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xa62>", var_c8d599b5 + "<dev string:xa79>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xaa1>", var_c8d599b5 + "<dev string:xac2>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xaef>", var_c8d599b5 + "<dev string:xb07>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xb2a>", var_c8d599b5 + "<dev string:xb41>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xb65>", var_c8d599b5 + "<dev string:xb75>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xb91>", var_c8d599b5 + "<dev string:xba8>");
        var_78a6fb52 = devgui_base + "<dev string:xbd1>";
        util::function_3f749abc(var_78a6fb52 + "<dev string:xbe1>", var_c8d599b5 + "<dev string:xbf8>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xc13>", var_c8d599b5 + "<dev string:xc27>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xc47>", var_c8d599b5 + "<dev string:xc5b>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xc7a>", var_c8d599b5 + "<dev string:xc8f>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xcaf>", var_c8d599b5 + "<dev string:xccc>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xcf5>", var_c8d599b5 + "<dev string:xd10>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xd37>", var_c8d599b5 + "<dev string:xd4f>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xd73>", var_c8d599b5 + "<dev string:xd89>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xdab>", var_c8d599b5 + "<dev string:xdbf>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xddf>", var_c8d599b5 + "<dev string:xdf9>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xe1f>", var_c8d599b5 + "<dev string:xe3c>");
        util::function_3f749abc(var_78a6fb52 + "<dev string:xe65>", var_c8d599b5 + "<dev string:xe84>");
    }

#/
