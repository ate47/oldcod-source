#using scripts\core_common\activecamo_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_contracts;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_challenges;

// Namespace zm_challenges/zm_challenges
// Params 0, eflags: 0x6
// Checksum 0x7b6cf09f, Offset: 0x1a8
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"zm_challenges", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace zm_challenges/zm_challenges
// Params 0, eflags: 0x5 linked
// Checksum 0x75189dea, Offset: 0x200
// Size: 0xe4
function private function_70a657d8() {
    callback::on_connect(&on_connect);
    callback::on_spawned(&on_spawned);
    callback::on_player_damage(&on_damaged);
    callback::on_laststand(&on_laststand);
    callback::on_bleedout(&on_bleedout);
    callback::on_challenge_complete(&on_challenge_complete);
    zm_spawner::register_zombie_death_event_callback(&death_check_for_challenge_updates);
}

// Namespace zm_challenges/zm_challenges
// Params 0, eflags: 0x5 linked
// Checksum 0x506f5830, Offset: 0x2f0
// Size: 0x34
function private postinit() {
    level thread spent_points_tracking();
    level thread function_a9f6b8ef();
}

// Namespace zm_challenges/zm_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xf3dfc2b6, Offset: 0x330
// Size: 0xd4
function on_connect() {
    self thread round_tracking();
    self thread perk_drink_tracking();
    self thread function_73696786();
    self thread function_12a35616();
    self thread function_a3cd4521();
    self.var_152810ff = [];
    self.var_152810ff[0] = 0;
    self.var_152810ff[1] = 0;
    self.var_152810ff[2] = 0;
    self.var_152810ff[3] = 0;
    self.var_152810ff[4] = 0;
}

// Namespace zm_challenges/zm_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x410
// Size: 0x4
function on_spawned() {
    
}

// Namespace zm_challenges/zm_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x5f9a2749, Offset: 0x420
// Size: 0x34
function on_damaged(*params) {
    self.var_152810ff[1] = 1;
    self.var_152810ff[4] = 1;
}

// Namespace zm_challenges/zm_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xb094cfb6, Offset: 0x460
// Size: 0x18
function on_laststand() {
    self.var_152810ff[2] = 1;
}

// Namespace zm_challenges/zm_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x2bbacf7e, Offset: 0x480
// Size: 0x18
function on_bleedout() {
    self.var_152810ff[3] = 1;
}

// Namespace zm_challenges/zm_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x1314bfbe, Offset: 0x4a0
// Size: 0x210
function round_tracking() {
    self endon(#"disconnect");
    while (true) {
        level waittill(#"end_of_round");
        if (zm_utility::is_trials() && level flag::get("round_reset")) {
            continue;
        }
        /#
            self debug_print("<dev string:x38>");
        #/
        self zm_stats::function_c0c6ab19(#"survive_rounds", 1, 1);
        if (level.round_number == 20 && zm_utility::is_classic() && !self.var_152810ff[4]) {
            /#
                self debug_print("<dev string:x62>");
            #/
            self zm_stats::increment_challenge_stat(#"hash_758b3285de8999f", undefined, 1);
        }
        if (!self.var_152810ff[1]) {
            /#
                self debug_print("<dev string:x9e>");
            #/
            self zm_stats::increment_challenge_stat(#"rounds_no_damage", undefined, 1);
        }
        if (!self.var_152810ff[2]) {
            /#
                self debug_print("<dev string:xd7>");
            #/
            self zm_stats::increment_challenge_stat(#"rounds_no_downs", undefined, 1);
        }
        self.var_152810ff[1] = 0;
        self.var_152810ff[2] = 0;
    }
}

// Namespace zm_challenges/zm_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xbd4abb9c, Offset: 0x6b8
// Size: 0x1fbe
function death_check_for_challenge_updates(e_attacker) {
    if (!isdefined(e_attacker)) {
        return;
    }
    if (!isplayer(e_attacker)) {
        return;
    }
    /#
        e_attacker debug_print("<dev string:x113>");
    #/
    e_attacker zm_stats::increment_challenge_stat(#"darkops_kills", undefined, 1);
    e_attacker zm_stats::function_c0c6ab19(#"kills");
    e_attacker contracts::increment_zm_contract(#"contract_zm_kills");
    e_attacker contracts::function_dff4c02f();
    if (isvehicle(self)) {
        str_damagemod = self.str_damagemod;
        w_damage = self.w_damage;
    } else {
        str_damagemod = self.damagemod;
        w_damage = self.damageweapon;
    }
    var_7050de53 = w_damage.inventorytype;
    switch (w_damage.inventorytype) {
    case #"dwlefthand":
        w_damage = w_damage.dualwieldweapon;
        break;
    case #"primary":
        if (!e_attacker playerads()) {
            e_attacker contracts::increment_zm_contract(#"hash_35f2db5e4f5935be");
        }
        break;
    }
    w_damage = zm_weapons::get_nonalternate_weapon(w_damage);
    if (isdefined(self.var_6f84b820)) {
        switch (self.var_6f84b820) {
        case #"special":
            /#
                e_attacker debug_print("<dev string:x139>");
            #/
            e_attacker zm_stats::increment_challenge_stat(#"heavy_kills");
            e_attacker stats::function_e24eec31(w_damage, #"specialkills", 1);
            e_attacker stats::inc_stat(#"item_stats", w_damage.name, #"specialkills", #"statvalue", 1);
            e_attacker thread activecamo::function_896ac347(w_damage, #"special_kills", 1);
            e_attacker thread activecamo::function_896ac347(w_damage, #"hash_39ab7cda18fd5c74", 1);
            e_attacker contracts::increment_zm_contract(#"contract_zm_special_kills");
            break;
        case #"elite":
            /#
                e_attacker debug_print("<dev string:x160>");
            #/
            e_attacker zm_stats::increment_challenge_stat(#"mini_boss_kills");
            e_attacker stats::function_e24eec31(w_damage, #"hash_20806ac72acd7d15", 1);
            e_attacker stats::inc_stat(#"item_stats", w_damage.name, #"hash_20806ac72acd7d15", #"statvalue", 1);
            e_attacker thread activecamo::function_896ac347(w_damage, #"elite_kills", 1);
            e_attacker thread activecamo::function_896ac347(w_damage, #"hash_39ab7cda18fd5c74", 1);
            e_attacker contracts::increment_zm_contract(#"hash_1bbcbc1ef268d554");
            break;
        case #"normal":
            /#
                e_attacker debug_print("<dev string:x185>");
            #/
            e_attacker stats::function_e24eec31(w_damage, #"verminkills", 1);
            e_attacker stats::inc_stat(#"item_stats", w_damage.name, #"verminkills", #"statvalue", 1);
            e_attacker thread activecamo::function_896ac347(w_damage, #"vermin_kills", 1);
            e_attacker thread activecamo::function_896ac347(w_damage, #"hash_39ab7cda18fd5c74", 1);
            e_attacker contracts::increment_zm_contract(#"contract_zm_vermin_kills");
            break;
        }
    }
    switch (self.archetype) {
    case #"catalyst":
        /#
            e_attacker debug_print("<dev string:x1ab>");
        #/
        e_attacker thread activecamo::function_896ac347(w_damage, #"hash_39ab7cda18fd5c74", 1);
        e_attacker contracts::increment_zm_contract(#"contract_zm_catalyst_kills");
        if (is_true(self.var_69a981e6)) {
            /#
                e_attacker debug_print("<dev string:x1d3>");
            #/
            e_attacker zm_stats::increment_challenge_stat(#"catalyst_transformation_denials");
        }
        break;
    }
    if (e_attacker zm_perks::function_9a0e9d65()) {
        e_attacker stats::function_e24eec31(w_damage, #"allperkkills", 1);
        e_attacker stats::inc_stat(#"item_stats", w_damage.name, #"allperkkills", #"statvalue", 1);
    } else if (e_attacker zm_perks::function_80514167()) {
        e_attacker stats::function_e24eec31(w_damage, #"noperkkills", 1);
        e_attacker stats::inc_stat(#"item_stats", w_damage.name, #"noperkkills", #"statvalue", 1);
    }
    if (self zm_utility::is_headshot(w_damage, self.damagelocation, str_damagemod)) {
        /#
            e_attacker debug_print("<dev string:x206>");
        #/
        e_attacker zm_stats::function_c0c6ab19(#"headshots");
        e_attacker contracts::increment_zm_contract(#"contract_zm_headshots");
        if (w_damage === e_attacker.var_2a62e678) {
            /#
                e_attacker debug_print("<dev string:x22e>");
            #/
            e_attacker zm_stats::increment_challenge_stat(#"perk_mule_kick_kills");
        }
        if (isdefined(e_attacker.var_807f94d7) && e_attacker.var_807f94d7 > 0) {
            /#
                e_attacker debug_print("<dev string:x26c>");
            #/
            e_attacker zm_stats::increment_challenge_stat(#"perk_stronghold_headshots");
        }
    }
    if (str_damagemod == "MOD_MELEE" && !zm_loadout::is_hero_weapon(w_damage)) {
        /#
            e_attacker debug_print("<dev string:x29f>");
        #/
        e_attacker zm_stats::increment_challenge_stat(#"zombie_hunter_kill_melee");
        e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_melee");
        e_attacker zm_stats::function_c0c6ab19(#"kills_melee");
        e_attacker contracts::increment_zm_contract(#"contract_zm_melee_kills");
    }
    if (str_damagemod === "MOD_GRENADE" || str_damagemod === "MOD_GRENADE_SPLASH" || str_damagemod === "MOD_EXPLOSIVE" || zm_weapons::is_explosive_weapon(w_damage)) {
        /#
            e_attacker debug_print("<dev string:x2c4>");
        #/
        e_attacker zm_stats::increment_challenge_stat(#"zombie_hunter_kill_explosives");
        e_attacker zm_stats::function_c0c6ab19(#"explosions");
        e_attacker contracts::increment_zm_contract(#"contract_zm_explosive_kills");
    }
    if (is_true(self.missinglegs)) {
        /#
            e_attacker debug_print("<dev string:x2ed>");
        #/
        e_attacker zm_stats::increment_challenge_stat(#"zombie_hunter_kill_crawler");
        e_attacker stats::function_e24eec31(w_damage, #"crawlerkills", 1);
        e_attacker stats::inc_stat(#"item_stats", w_damage.name, #"crawlerkills", #"statvalue", 1);
    }
    if (e_attacker zm_pap_util::function_b81da3fd(w_damage)) {
        /#
            e_attacker debug_print("<dev string:x314>");
        #/
        e_attacker zm_stats::increment_challenge_stat(#"double_pap_kills", undefined, 1);
        e_attacker zm_stats::function_c0c6ab19(#"hash_5d3dce1c38a95835");
        e_attacker zm_stats::function_c0c6ab19(#"repacked_kills");
        e_attacker contracts::increment_zm_contract(#"contract_zm_packed_kills");
        w_stat = zm_weapons::get_base_weapon(w_damage);
        e_attacker stats::function_e24eec31(w_damage, #"packedkills", 1);
        e_attacker stats::inc_stat(#"item_stats", w_damage.name, #"packedkills", #"statvalue", 1);
    } else if (zm_weapons::is_weapon_upgraded(w_damage)) {
        /#
            e_attacker debug_print("<dev string:x348>");
        #/
        e_attacker zm_stats::increment_challenge_stat(#"zombie_hunter_kill_packapunch");
        e_attacker zm_stats::function_c0c6ab19(#"hash_5d3dce1c38a95835");
        e_attacker contracts::increment_zm_contract(#"contract_zm_packed_kills");
        w_stat = zm_weapons::get_base_weapon(w_damage);
        e_attacker stats::function_e24eec31(w_damage, #"packedkills", 1);
        e_attacker stats::inc_stat(#"item_stats", w_damage.name, #"packedkills", #"statvalue", 1);
    } else {
        w_stat = zm_weapons::function_386dacbc(w_damage);
    }
    if (zm_weapons::is_wonder_weapon(w_damage)) {
        e_attacker contracts::increment_zm_contract(#"hash_1db0aaefc2baceb4");
    }
    if (isdefined(level.zombie_weapons[w_stat])) {
        switch (level.zombie_weapons[w_stat].weapon_classname) {
        case #"ar":
            /#
                e_attacker debug_print("<dev string:x375>");
            #/
            e_attacker zm_stats::increment_challenge_stat(#"ar_kills");
            e_attacker zm_stats::function_c0c6ab19(#"kills_ar");
            e_attacker contracts::increment_zm_contract(#"contract_zm_ar_kills");
            break;
        case #"lmg":
            /#
                e_attacker debug_print("<dev string:x397>");
            #/
            e_attacker zm_stats::increment_challenge_stat(#"lmg_kills");
            e_attacker zm_stats::function_c0c6ab19(#"kills_lmg");
            e_attacker contracts::increment_zm_contract(#"contract_zm_lmg_kills");
            break;
        case #"pistol":
            /#
                e_attacker debug_print("<dev string:x3ba>");
            #/
            e_attacker zm_stats::increment_challenge_stat(#"pistol_kills");
            e_attacker zm_stats::function_c0c6ab19(#"kills_pistol");
            e_attacker contracts::increment_zm_contract(#"contract_zm_pistol_kills");
            break;
        case #"shotgun":
            /#
                e_attacker debug_print("<dev string:x3e0>");
            #/
            e_attacker zm_stats::increment_challenge_stat(#"shotgun_kills");
            e_attacker zm_stats::function_c0c6ab19(#"kills_shotguns");
            e_attacker contracts::increment_zm_contract(#"contract_zm_shotgun_kills");
            break;
        case #"smg":
            /#
                e_attacker debug_print("<dev string:x407>");
            #/
            e_attacker zm_stats::increment_challenge_stat(#"smg_kills");
            e_attacker zm_stats::function_c0c6ab19(#"kills_smg");
            e_attacker contracts::increment_zm_contract(#"contract_zm_smg_kills");
            break;
        case #"sniper":
            /#
                e_attacker debug_print("<dev string:x42a>");
            #/
            e_attacker zm_stats::increment_challenge_stat(#"sniper_kills");
            e_attacker zm_stats::function_c0c6ab19(#"hash_2333d2f2b7271a56");
            e_attacker contracts::increment_zm_contract(#"contract_zm_sniper_kills");
            break;
        case #"tr":
            /#
                e_attacker debug_print("<dev string:x450>");
            #/
            e_attacker zm_stats::increment_challenge_stat(#"tr_kills");
            e_attacker zm_stats::function_c0c6ab19(#"hash_26d8f2fa0846a614");
            e_attacker contracts::increment_zm_contract(#"contract_zm_tr_kills");
            break;
        }
    }
    if (e_attacker zm_powerups::is_insta_kill_active()) {
        e_attacker stats::function_e24eec31(w_damage, #"instakills", 1);
        e_attacker stats::inc_stat(#"item_stats", w_damage.name, #"instakills", #"statvalue", 1);
    }
    if (w_damage.rootweapon.name == #"smg_handling_t8_dw" || w_damage.rootweapon.name == #"hash_1aea58adc540688c" || w_damage.rootweapon.name == #"smg_handling_t8_upgraded_dw" || w_damage.rootweapon.name == #"hash_3b19c698ebc05141") {
        /#
            e_attacker debug_print("<dev string:x472>");
        #/
        e_attacker zm_stats::increment_challenge_stat(#"hash_2a72be53205a8db3");
        return;
    }
    if (w_damage.statname === #"bowie_knife") {
        /#
            e_attacker debug_print("<dev string:x4ca>");
        #/
        e_attacker zm_stats::increment_challenge_stat(#"bowie_kills");
        return;
    }
    if (is_true(w_damage.var_ff0b00ba)) {
        /#
            e_attacker debug_print("<dev string:x4f5>");
        #/
        e_attacker zm_stats::function_c0c6ab19(#"kills_equipment");
        e_attacker contracts::increment_zm_contract(#"contract_zm_equip_kills");
    }
    if (zm_utility::is_frag_grenade(w_damage)) {
        /#
            e_attacker debug_print("<dev string:x51e>");
        #/
        e_attacker zm_stats::increment_challenge_stat(#"frag_kills");
        return;
    }
    if (zm_utility::is_claymore(w_damage)) {
        /#
            e_attacker debug_print("<dev string:x542>");
        #/
        e_attacker zm_stats::increment_challenge_stat(#"claymore_kills");
        return;
    }
    if (zm_utility::is_mini_turret(w_damage, 1)) {
        /#
            e_attacker debug_print("<dev string:x56a>");
        #/
        e_attacker zm_stats::increment_challenge_stat(#"sentry_kills");
        return;
    }
    if (zm_utility::function_b797694c(w_damage)) {
        /#
            e_attacker debug_print("<dev string:x595>");
        #/
        e_attacker zm_stats::increment_challenge_stat(#"acid_bomb_kills");
        return;
    }
    if (zm_utility::function_850e7499(w_damage, 1)) {
        /#
            e_attacker debug_print("<dev string:x5be>");
        #/
        e_attacker zm_stats::increment_challenge_stat(#"wraith_fire_kills");
        return;
    }
    if (is_true(w_damage.isriotshield)) {
        /#
            e_attacker debug_print("<dev string:x5e9>");
        #/
        e_attacker zm_stats::increment_challenge_stat(#"shield_kills");
        e_attacker contracts::increment_zm_contract(#"contract_zm_shield_kills");
        return;
    }
    if (zm_loadout::is_hero_weapon(w_damage) || zm_hero_weapon::function_6a32b8f(w_damage)) {
        e_attacker zm_stats::function_c0c6ab19(#"kills_special_weapons");
        e_attacker contracts::increment_zm_contract(#"hash_6f26e57c9ec1aff8");
        e_attacker contracts::function_ac03f21e();
        if (w_damage == getweapon(#"hero_chakram_lv1") || w_damage == getweapon(#"hero_chakram_lv2") || w_damage == getweapon(#"hero_chakram_lv3") || w_damage == getweapon(#"hero_flamethrower_t8_lv1") || w_damage == getweapon(#"hero_flamethrower_t8_lv2") || w_damage == getweapon(#"hero_flamethrower_t8_lv3")) {
            /#
                e_attacker debug_print("<dev string:x60f>");
            #/
            e_attacker zm_stats::increment_challenge_stat(#"hash_4aa750e907d2acba");
            if (w_damage == getweapon(#"hero_chakram_lv3") || w_damage == getweapon(#"hero_flamethrower_t8_lv3")) {
                /#
                    e_attacker debug_print("<dev string:x643>");
                #/
                e_attacker zm_stats::increment_challenge_stat(#"maxed_special_weapon_kills");
            }
            return;
        }
        if (w_damage == getweapon(#"hero_hammer_lv1") || w_damage == getweapon(#"hero_hammer_lv2") || w_damage == getweapon(#"hero_hammer_lv3") || w_damage == getweapon(#"hero_minigun_t8_lv1") || w_damage == getweapon(#"hero_minigun_t8_lv2") || w_damage == getweapon(#"hero_minigun_t8_lv3") || w_damage == getweapon(#"hash_492e530f9862f6cc") || w_damage == getweapon(#"hash_628d99860c78650f")) {
            /#
                e_attacker debug_print("<dev string:x67f>");
            #/
            e_attacker zm_stats::increment_challenge_stat(#"hash_3e5b9b81d573d194");
            if (w_damage == getweapon(#"hero_hammer_lv3") || w_damage == getweapon(#"hero_minigun_t8_lv3") || w_damage == getweapon(#"hash_628d99860c78650f") || w_damage == getweapon(#"hash_492e530f9862f6cc") && e_attacker hasweapon(getweapon(#"hero_minigun_t8_lv3"))) {
                /#
                    e_attacker debug_print("<dev string:x643>");
                #/
                e_attacker zm_stats::increment_challenge_stat(#"maxed_special_weapon_kills");
            }
            return;
        }
        if (w_damage == getweapon(#"hero_sword_pistol_lv1") || w_damage == getweapon(#"hero_sword_pistol_lv2") || w_damage == getweapon(#"hero_sword_pistol_lv3") || w_damage == getweapon(#"hero_katana_t8_lv1") || w_damage == getweapon(#"hero_katana_t8_lv2") || w_damage == getweapon(#"hero_katana_t8_lv3")) {
            /#
                e_attacker debug_print("<dev string:x6ad>");
            #/
            e_attacker zm_stats::increment_challenge_stat(#"hash_43bd32b7705f38fd");
            if (w_damage == getweapon(#"hero_sword_pistol_lv3") || w_damage == getweapon(#"hero_katana_t8_lv3")) {
                /#
                    e_attacker debug_print("<dev string:x643>");
                #/
                e_attacker zm_stats::increment_challenge_stat(#"maxed_special_weapon_kills");
            }
            return;
        }
        if (w_damage == getweapon(#"hero_scepter_lv1") || w_damage == getweapon(#"hero_scepter_lv2") || w_damage == getweapon(#"hero_scepter_lv3") || w_damage == getweapon(#"hero_gravityspikes_t8_lv1") || w_damage == getweapon(#"hero_gravityspikes_t8_lv2") || w_damage == getweapon(#"hero_gravityspikes_t8_lv3")) {
            /#
                e_attacker debug_print("<dev string:x6d9>");
            #/
            e_attacker zm_stats::increment_challenge_stat(#"hash_35c05a1d6c5fb3e1");
            if (w_damage == getweapon(#"hero_scepter_lv3") || w_damage == getweapon(#"hero_gravityspikes_t8_lv3")) {
                /#
                    e_attacker debug_print("<dev string:x643>");
                #/
                e_attacker zm_stats::increment_challenge_stat(#"maxed_special_weapon_kills");
            }
            return;
        }
    }
}

// Namespace zm_challenges/zm_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xeb38e139, Offset: 0x2680
// Size: 0xe0
function spent_points_tracking() {
    level endon(#"end_game");
    while (true) {
        result = level waittill(#"spent_points");
        player = result.player;
        n_points = result.points;
        player.var_152810ff[0] = player.var_152810ff[0] + n_points;
        /#
            player debug_print("<dev string:x70f>");
        #/
        player zm_stats::increment_challenge_stat(#"points_spent", n_points, 1);
    }
}

/#

    // Namespace zm_challenges/zm_challenges
    // Params 0, eflags: 0x0
    // Checksum 0xa730d0eb, Offset: 0x2768
    // Size: 0x24
    function increment_magic_box() {
        self debug_print("<dev string:x735>");
    }

#/

// Namespace zm_challenges/zm_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x189276ca, Offset: 0x2798
// Size: 0x58
function perk_drink_tracking() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"perk_bought");
        /#
            self debug_print("<dev string:x75e>");
        #/
    }
}

// Namespace zm_challenges/zm_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x5f93a254, Offset: 0x27f8
// Size: 0xc8
function function_73696786() {
    self endon(#"disconnect");
    var_c0e0819a = 1;
    while (true) {
        s_result = self waittill(#"hash_13948ef3726b968f");
        if (is_true(var_c0e0819a)) {
            /#
                self debug_print("<dev string:x783>");
            #/
            self zm_stats::increment_challenge_stat(#"perks_full");
            var_c0e0819a = undefined;
        }
        self function_b892d1da();
    }
}

// Namespace zm_challenges/zm_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x4958ab1e, Offset: 0x28c8
// Size: 0xa2
function function_12a35616() {
    self endon(#"disconnect");
    while (true) {
        waitresult = level waittill(#"blueprint_completed");
        if (isdefined(waitresult.produced) && is_true(waitresult.produced.isriotshield)) {
            /#
                self debug_print("<dev string:x7b2>");
            #/
            return;
        }
    }
}

// Namespace zm_challenges/zm_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x838846c7, Offset: 0x2978
// Size: 0x148
function function_a9f6b8ef() {
    level endon(#"end_game");
    if (zm_custom::function_901b751c(#"zmpapenabled") == 2 || zm_custom::function_901b751c(#"zmpapenabled") == 0) {
        return;
    }
    level flag::wait_till("pap_machine_active");
    foreach (player in level.players) {
        /#
            player debug_print("<dev string:x7db>");
        #/
        player zm_stats::increment_challenge_stat(#"pap_activation", undefined, 1);
    }
}

/#

    // Namespace zm_challenges/zm_challenges
    // Params 1, eflags: 0x0
    // Checksum 0x9b2aaebd, Offset: 0x2ac8
    // Size: 0x6c
    function debug_print(str_line) {
        if (getdvarint(#"zombie_debug", 0) > 0) {
            println("<dev string:x803>" + self.entity_num + "<dev string:x80e>" + str_line);
        }
    }

#/

// Namespace zm_challenges/zm_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x25741e12, Offset: 0x2b40
// Size: 0x36
function on_challenge_complete(params) {
    n_challenge_index = params.challenge_index;
    if (is_challenge(n_challenge_index)) {
    }
}

// Namespace zm_challenges/zm_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xcfee06b8, Offset: 0x2b80
// Size: 0xe
function is_challenge(*n_challenge_index) {
    return false;
}

// Namespace zm_challenges/zm_challenges
// Params 1, eflags: 0x0
// Checksum 0xe86b8081, Offset: 0x2b98
// Size: 0x124
function function_9a9ab6f6(var_1c48b665) {
    self zm_stats::increment_challenge_stat(var_1c48b665);
    foreach (var_6c7a7f72 in array(#"darkops_zod_ee", #"hash_6d5340d9e43ed73d", #"hash_ad3a508a80a0e6e")) {
        if (!self stats::get_stat_global(var_6c7a7f72)) {
            return;
        }
    }
    /#
        self debug_print("<dev string:x814>");
    #/
    self zm_stats::increment_challenge_stat(#"hash_405387fd6efe78b3");
}

// Namespace zm_challenges/zm_challenges
// Params 0, eflags: 0x5 linked
// Checksum 0x76f11bba, Offset: 0x2cc8
// Size: 0x1e4
function private function_b892d1da() {
    var_684d09cd = array(#"perk_additional_primary_weapon", #"perk_bandolier", #"perk_cooldown", #"perk_dead_shot", #"perk_death_perception", #"perk_dying_wish", #"perk_electric_cherry", #"perk_quick_revive", #"perk_slider", #"perk_staminup", #"perk_stronghold", #"perk_tortoise", #"perk_widows_wine");
    foreach (var_9b9f4901 in var_684d09cd) {
        if (!self stats::get_stat(#"perk_stats", var_9b9f4901, #"modifier_given", #"statvalue")) {
            return;
        }
    }
    /#
        self debug_print("<dev string:x844>");
    #/
    self zm_stats::increment_challenge_stat(#"hash_34f185c936027147", undefined, 1);
}

// Namespace zm_challenges/zm_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xe73ee267, Offset: 0x2eb8
// Size: 0x134
function function_bf0be8f1() {
    foreach (str_map in array("zm_zodt8", "zm_towers", "zm_escape")) {
        if (!self stats::get_stat(#"playerstatsbymap", str_map, #"hash_74e26ca9652802fb", level.gametype, #"stats", "FASTEST_TIME_TO_COMPLETE_ROUND_30", #"statvalue")) {
            return;
        }
    }
    /#
        self debug_print("<dev string:x87a>");
    #/
    self zm_stats::increment_challenge_stat(#"hash_c59a95e3be43538");
}

// Namespace zm_challenges/zm_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x26cfaf94, Offset: 0x2ff8
// Size: 0x304
function function_e40c9d13() {
    var_b361a853 = array(#"ar_accurate_t8_upgraded", #"ar_damage_t8_upgraded", #"ar_fastfire_t8_upgraded", #"ar_mg1909_t8_upgraded", #"ar_modular_t8_upgraded", #"ar_stealth_t8_upgraded", #"launcher_standard_t8_upgraded", #"lmg_double_t8_upgraded", #"lmg_heavy_t8_upgraded", #"lmg_spray_t8_upgraded", #"lmg_standard_t8_upgraded", #"pistol_burst_t8_upgraded", #"pistol_revolver_t8_upgraded", #"pistol_standard_t8_upgraded", #"pistol_topbreak_t8_upgraded", #"shotgun_pump_t8_upgraded", #"shotgun_semiauto_t8_upgraded", #"shotgun_trenchgun_t8_upgraded", #"smg_accurate_t8_upgraded", #"smg_capacity_t8_upgraded", #"smg_drum_pistol_t8_upgraded", #"smg_fastfire_t8_upgraded", #"smg_handling_t8_upgraded", #"smg_standard_t8_upgraded", #"sniper_powerbolt_t8_upgraded", #"sniper_powersemi_t8_upgraded", #"sniper_quickscope_t8_upgraded", #"tr_leveraction_t8_upgraded", #"tr_longburst_t8_upgraded", #"tr_midburst_t8_upgraded", #"tr_powersemi_t8_upgraded");
    foreach (var_5f8b3585 in var_b361a853) {
        if (!self stats::get_stat(#"item_stats", var_5f8b3585, #"doublepacked", #"statvalue")) {
            return;
        }
    }
    /#
        self debug_print("<dev string:x8ad>");
    #/
    self zm_stats::increment_challenge_stat(#"hash_40d2ff74fd37a2ab", undefined, 1);
}

// Namespace zm_challenges/zm_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xf22b1973, Offset: 0x3308
// Size: 0x131c
function function_a3cd4521() {
    if (self stats::get_stat(#"playerstatslist", #"hash_516183f89adeace1")) {
        return;
    }
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return;
    }
    self endon(#"disconnect");
    self waittill(#"spawned");
    level flag::wait_till("gameplay_started");
    var_a9d7bd6 = 0;
    if (self stats::function_af5584ca(#"kills") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"zombie_hunter_kill_melee") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"zombie_hunter_kill_headshot") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"zombie_hunter_kill_crawler") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"zombie_hunter_kill_packapunch") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"double_pap_kills") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"zombie_hunter_kill_explosives") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"special_kills") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"elite_kills") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"catalysts_killed") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"aat_catalyst_kills") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"catalyst_transformation_denials") == 3) {
        var_a9d7bd6++;
    }
    var_76f39460 = self stats::get_stat_challenge(#"zombie_hunter_mastery");
    if (var_76f39460 < var_a9d7bd6) {
        self stats::function_dad108fa(#"zombie_hunter_mastery", var_a9d7bd6 - var_76f39460);
    }
    var_a9d7bd6 = 0;
    if (self stats::function_af5584ca(#"survivalist_buy_magic_box") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"survivalist_buy_perk") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"survivalist_buy_wallbuy") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"survivalist_buy_door") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"survivalist_revive") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"survivalist_survive_rounds") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"rounds_no_downs") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"rounds_no_damage") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"survivalist_powerup") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"points_spent") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"fast_travels") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"perks_full") == 3) {
        var_a9d7bd6++;
    }
    var_76f39460 = self stats::get_stat_challenge(#"survivalist_mastery");
    if (var_76f39460 < var_a9d7bd6) {
        self stats::function_dad108fa(#"survivalist_mastery", var_a9d7bd6 - var_76f39460);
    }
    var_a9d7bd6 = 0;
    if (self stats::function_af5584ca(#"pap_activation") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"pap_weapon_packed") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"pap_weapon_double_packed") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"shield_kills") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"shields_built") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_3e5b9b81d573d194") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_4aa750e907d2acba") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_43bd32b7705f38fd") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_35c05a1d6c5fb3e1") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"scepter_revives") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"special_weapon_levels") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"maxed_special_weapon_kills") == 3) {
        var_a9d7bd6++;
    }
    var_76f39460 = self stats::get_stat_challenge(#"hash_24ccc77cf1df2b49");
    if (var_76f39460 < var_a9d7bd6) {
        self stats::function_dad108fa(#"hash_24ccc77cf1df2b49", var_a9d7bd6 - var_76f39460);
    }
    var_a9d7bd6 = 0;
    if (self stats::function_af5584ca(#"hash_41d41d501c70fb30") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_133575f669ffc55c") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"gum_gobbler_burned_out") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_19d6a97f1553f96f") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_3ebae93ea866519c") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_1f20f53b7084fdcb") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_733e96c5baacb1da") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_108042c8bd6693fb") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_5d098efca02f7c99") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"nowhere_but_there_revives") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_47646e52fcbb190e") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"talisman_used") == 3) {
        var_a9d7bd6++;
    }
    var_76f39460 = self stats::get_stat_challenge(#"hash_394c19e7ac92098c");
    if (var_76f39460 < var_a9d7bd6) {
        self stats::function_dad108fa(#"hash_394c19e7ac92098c", var_a9d7bd6 - var_76f39460);
    }
    var_a9d7bd6 = 0;
    if (self stats::function_af5584ca(#"pistol_kills") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"shotgun_kills") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"ar_kills") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"lmg_kills") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"sniper_kills") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"smg_kills") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"tr_kills") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"frag_kills") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"acid_bomb_kills") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"wraith_fire_kills") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"sentry_kills") == 3) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"claymore_kills") == 3) {
        var_a9d7bd6++;
    }
    var_76f39460 = self stats::get_stat_challenge(#"hash_452e07bec3b77c8e");
    if (var_76f39460 < var_a9d7bd6) {
        self stats::function_dad108fa(#"hash_452e07bec3b77c8e", var_a9d7bd6 - var_76f39460);
    }
    var_a9d7bd6 = 0;
    if (self stats::function_af5584ca(#"bowie_kills") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_63e3f06d30760b7e") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_2a72be53205a8db3") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_3a43a56f5f2aeacc") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_733f619bc1c13bdd") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_7ac3980eb0c9f12d") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_d0eb45f997dadf0") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"perk_mule_kick_kills") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"perk_electric_cherry_kills") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"perk_deadshot_kills") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"perk_slider_kills") == 5) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"perk_stronghold_headshots") == 5) {
        var_a9d7bd6++;
    }
    var_76f39460 = self stats::get_stat_challenge(#"hash_4b011cd0269a8502");
    if (var_76f39460 < var_a9d7bd6) {
        self stats::function_dad108fa(#"hash_4b011cd0269a8502", var_a9d7bd6 - var_76f39460);
    }
    var_a9d7bd6 = 0;
    if (self stats::function_af5584ca(#"hash_16aa183f2c51f999") == 1) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_69f53cb2579fba3e") == 1) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_6d551a71b5461906") == 1) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_405387fd6efe78b3") == 1) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"darkops_kills") == 1) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_47685630580f6b5f") == 1) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_34f185c936027147") == 1) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_2eed193144ed0fee") == 1) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_c59a95e3be43538") == 1) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_7a406e363a7db141") == 1) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_758b3285de8999f") == 1) {
        var_a9d7bd6++;
    }
    if (self stats::function_af5584ca(#"hash_40d2ff74fd37a2ab") == 1) {
        var_a9d7bd6++;
    }
    var_76f39460 = self stats::get_stat_challenge(#"hash_72a217263c8a78f");
    if (var_76f39460 < var_a9d7bd6) {
        self stats::function_dad108fa(#"hash_72a217263c8a78f", var_a9d7bd6 - var_76f39460);
    }
    self stats::set_stat(#"playerstatslist", #"hash_516183f89adeace1", 1);
}

