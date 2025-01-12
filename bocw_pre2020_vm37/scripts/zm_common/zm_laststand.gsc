#using script_243ea03c7a285692;
#using script_3751b21462a54a7d;
#using script_48f7c4ab73137f8;
#using script_5f261a5d57de5f7c;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\trials\zm_trial_disable_perks;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;

#namespace zm_laststand;

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x6
// Checksum 0x66b4767f, Offset: 0x460
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_laststand", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x5 linked
// Checksum 0xfe2484c3, Offset: 0x4a8
// Size: 0x294
function private function_70a657d8() {
    level flag::init("solo_revive");
    level.revive_hud = revive_hud::register();
    level.var_ff482f76 = zm_laststand_client::register();
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_spawned);
    callback::on_disconnect(&function_4d3cb10);
    callback::on_ai_killed(&on_ai_killed);
    callback::on_item_pickup(&on_item_pickup);
    clientfield::register_clientuimodel("ZMInventoryPersonal.self_revive_count", 1, 7, "int");
    clientfield::register("allplayers", "zm_last_stand_postfx", 1, 1, "int");
    level.laststand_update_clientfields = [];
    for (i = 0; i < 5; i++) {
        level.laststand_update_clientfields[i] = "laststand_update" + i;
        clientfield::register("world", level.laststand_update_clientfields[i], 1, 5, "float");
        clientfield::register_clientuimodel("WorldSpaceIndicators.bleedOutModel" + i + ".hide", 1, 1, "int");
    }
    level.weaponsuicide = getweapon(#"death_self");
    if (!isdefined(getdvar(#"revive_trigger_radius"))) {
        setdvar(#"revive_trigger_radius", 100);
    }
    if (!isdefined(level.var_3ea7f9f4)) {
        level.var_3ea7f9f4 = 1;
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x8f860821, Offset: 0x748
// Size: 0x34
function on_player_connect() {
    self thread function_b7c101fa();
    self thread function_6155752d();
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xfc8786b6, Offset: 0x788
// Size: 0xe
function on_spawned() {
    self.var_39c78617 = undefined;
}

// Namespace zm_laststand/zm_laststand
// Params 9, eflags: 0x1 linked
// Checksum 0x1184cdb3, Offset: 0x7a0
// Size: 0x1ec
function player_last_stand_stats(einflictor, attacker, *idamage, *smeansofdeath, *weapon, *vdir, *shitloc, *psoffsettime, *deathanimduration) {
    if (isdefined(deathanimduration) && isplayer(deathanimduration) && deathanimduration != self) {
        if ("zcleansed" == level.gametype) {
            demo::kill_bookmark(deathanimduration, self, psoffsettime);
            potm::kill_bookmark(deathanimduration, self, psoffsettime);
        }
        if ("zcleansed" == level.gametype) {
            if (!is_true(deathanimduration.is_zombie)) {
                deathanimduration.kills++;
            } else {
                deathanimduration.downs++;
            }
        } else {
            deathanimduration.kills++;
        }
    }
    self increment_downed_stat();
    if (level flag::get("solo_game") && self function_618fd37e() == 0 && getnumconnectedplayers() < 2) {
        self zm_stats::increment_client_stat("deaths");
        self zm_stats::increment_player_stat("deaths");
        self zm_stats::function_8f10788e("boas_deaths");
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xf3aa6dbd, Offset: 0x998
// Size: 0x17c
function increment_downed_stat() {
    if ("zcleansed" != level.gametype) {
        self.downs++;
    }
    self zm_stats::increment_global_stat("TOTAL_DOWNS");
    self zm_stats::increment_map_stat("TOTAL_DOWNS");
    self zm_stats::function_f1a1191d("TOTAL_DOWNS");
    self zm_stats::function_2726a7c2("TOTAL_DOWNS");
    self zm_stats::increment_client_stat("downs");
    self zm_stats::function_8f10788e("boas_downs");
    self add_weighted_down();
    self zm_stats::increment_player_stat("downs");
    if (!zm_utility::is_survival()) {
        zonename = self zm_utility::get_current_zone();
        if (!isdefined(zonename)) {
            zonename = "";
        }
        self recordplayerdownzombies(zonename);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x926106e1, Offset: 0xb20
// Size: 0xa4
function registerfxanim_warehouse_explo(pause_enabled) {
    for (slot = 0; slot < 3; slot++) {
        if (!isdefined(self._gadgets_player[slot])) {
            continue;
        }
        if (isdefined(level.var_a53a05b5) && level.var_a53a05b5 == slot) {
            self zm_hero_weapon::function_76505465(slot, pause_enabled);
            continue;
        }
        self function_19ed70ca(slot, pause_enabled);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 9, eflags: 0x1 linked
// Checksum 0x4983fa2b, Offset: 0xbd0
// Size: 0x89c
function playerlaststand(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    self notify(#"entering_last_stand");
    self disableweaponcycling();
    self registerfxanim_warehouse_explo(1);
    if (self laststand::player_is_in_laststand()) {
        return;
    }
    if (is_true(self.in_zombify_call)) {
        return;
    }
    self thread player_last_stand_stats(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    if (smeansofdeath == "MOD_SUICIDE" || self === attacker) {
        self zm_stats::increment_client_stat("suicides");
        self zm_stats::increment_player_stat("suicides");
        self zm_stats::function_8f10788e("boas_suicides");
    }
    if (self namespace_e86ffa8::function_8923370c(1)) {
        self setmovespeedscale(2);
    }
    self allowjump(0);
    currweapon = self getcurrentweapon();
    self stats::function_e24eec31(currweapon, #"deathsduringuse", 1);
    if (self function_618fd37e() > 0 && !is_true(level.var_28bbd30a)) {
        if (!zm_utility::is_survival() && (level.players.size == 1 || is_true(self.var_20f86af4))) {
            self thread wait_and_revive();
        } else {
            self thread function_3699b145();
        }
    }
    self zm_utility::clear_is_drinking();
    self zm_score::player_downed_penalty();
    self disableoffhandweapons();
    if (self isusingoffhand()) {
        self forceoffhandend();
    }
    if (smeansofdeath != "MOD_SUICIDE" && smeansofdeath != "MOD_FALLING") {
        if (!is_true(self.intermission) && !function_70fcc093()) {
            self util::delay(0.5, "death", &zm_audio::create_and_play_dialog, #"revive", #"down");
        } else {
            self thread zm_audio::create_and_play_dialog(#"general", #"exert_death");
        }
    }
    if (isdefined(level._zombie_minigun_powerup_last_stand_func)) {
        self thread [[ level._zombie_minigun_powerup_last_stand_func ]]();
    }
    if (isdefined(level._zombie_tesla_powerup_last_stand_func)) {
        self thread [[ level._zombie_tesla_powerup_last_stand_func ]]();
    }
    if (self hasperk(#"specialty_electriccherry")) {
        if (isdefined(level.custom_laststand_func)) {
            self thread [[ level.custom_laststand_func ]]();
        }
    }
    if (isdefined(self.intermission) && self.intermission) {
        wait 0.5;
        self stopsounds();
        level waittill(#"forever");
    }
    self clientfield::set("zm_last_stand_postfx", 1);
    self.health = 1;
    self.laststand = 1;
    self val::set(#"laststand", "ignoreme");
    callback::callback(#"on_player_laststand");
    if (!is_true(self.no_revive_trigger) || !is_true(self.var_39c78617)) {
        self revive_trigger_spawn();
    }
    if (is_true(self.is_zombie)) {
        self takeallweapons();
        if (isdefined(attacker) && isplayer(attacker) && attacker != self) {
            attacker notify(#"killed_a_zombie_player", einflictor);
        }
    } else {
        self laststand_disable_player_weapons();
        self laststand_give_pistol();
    }
    if (isdefined(self.var_c4890291)) {
        self.var_c4890291 = [];
    }
    if (!isdefined(self.n_downs)) {
        self.n_downs = 0;
    }
    self.n_downs += 1;
    bleedout_time = getdvarfloat(#"hash_1116ba0f929df636", isdefined(self.var_b92e42da) ? self.var_b92e42da : getdvarfloat(#"player_laststandbleedouttime", 0));
    if (zm_custom::function_901b751c(#"zmlimiteddownsamount") && self.n_downs > zm_custom::function_901b751c(#"zmlimiteddownsamount")) {
        bleedout_time = 0;
    }
    if (isdefined(self.n_bleedout_time_multiplier)) {
        bleedout_time *= self.n_bleedout_time_multiplier;
    }
    if (isdefined(self.var_5c4f1263)) {
        bleedout_time *= self.var_5c4f1263;
    }
    self thread laststand_bleedout(bleedout_time);
    demo::bookmark(#"player_downed", gettime(), self);
    potm::bookmark(#"player_downed", gettime(), self);
    self notify(#"player_downed");
    self thread refire_player_downed();
    self thread laststand::function_d4c9e1b5();
    self thread auto_revive_on_notify();
    if (self function_1a2fa922()) {
        self playsound(#"hash_19b37c3454f86a4a");
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xc84afd96, Offset: 0x1478
// Size: 0x126
function function_70fcc093() {
    if (isdefined(level.var_e1d82d33)) {
        foreach (player in function_a1ef346b(self.team)) {
            if (isplayer(player) && player != self) {
                s_path = generatenavmeshpath(self.origin, player.origin);
                if (isdefined(s_path)) {
                    if (isdefined(s_path.pathdistance)) {
                        if (s_path.pathdistance < level.var_e1d82d33) {
                            return true;
                        }
                    }
                } else {
                    return true;
                }
                waitframe(1);
            }
        }
    }
    return false;
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x3e880939, Offset: 0x15a8
// Size: 0x7c
function auto_revive_on_notify() {
    self endon(#"death", #"player_revived");
    s_result = self waittill(#"auto_revive", #"remote_revive");
    self thread auto_revive(s_result.reviver);
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xbe58e62e, Offset: 0x1630
// Size: 0xaa
function function_1a2fa922() {
    if (level.players.size > 1) {
        foreach (e_player in level.players) {
            if (zm_utility::is_player_valid(e_player)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x4c22b3fa, Offset: 0x16e8
// Size: 0x34c
function wait_and_revive() {
    self endoncallback(&function_e0f05bad, #"player_revived", #"death");
    level flag::set("wait_and_revive");
    level.wait_and_revive = 1;
    if (is_true(self.waiting_to_revive)) {
        return;
    }
    self.waiting_to_revive = 1;
    if (isdefined(level.exit_level_func)) {
        self thread [[ level.exit_level_func ]]();
    } else if (getplayers().size == 1) {
        player = getplayers()[0];
        level.move_away_points = positionquery_source_navigation(player.origin, 480, 960, 120, 20);
        if (!isdefined(level.move_away_points)) {
            level.move_away_points = positionquery_source_navigation(player.last_valid_position, 480, 960, 120, 20);
        }
    }
    var_3269dfa3 = (isdefined(self.var_b92e42da) ? self.var_b92e42da : getdvarfloat(#"player_laststandbleedouttime", 0)) * 0.25;
    var_3269dfa3 = getdvarfloat(#"hash_1d447d6b4492bf4f", var_3269dfa3);
    self thread laststand::revive_hud_show_n_fade(#"zombie/reviving_solo", var_3269dfa3);
    var_c564fe97 = level waittilltimeout(var_3269dfa3, #"end_of_round");
    if (var_c564fe97._notify === "end_of_round") {
        self thread laststand::revive_hud_show_n_fade(#"zombie/reviving_solo", 1);
    }
    while (self.var_16735873 === 1) {
        wait 0.1;
    }
    if (isdefined(level.a_revive_success_perk_func)) {
        foreach (func in level.a_revive_success_perk_func) {
            self [[ func ]]();
        }
    }
    self thread function_e0f05bad();
    self thread auto_revive(self, 1, 1);
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xafd0ed14, Offset: 0x1a40
// Size: 0x4a
function function_e0f05bad(*var_c34665fc) {
    level flag::clear("wait_and_revive");
    level.wait_and_revive = 0;
    if (isdefined(self)) {
        self.waiting_to_revive = 0;
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x7699930a, Offset: 0x1a98
// Size: 0x4e
function refire_player_downed() {
    self endon(#"player_revived", #"death");
    wait 1;
    if (self.num_perks) {
        self notify(#"player_downed");
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x2b296097, Offset: 0x1af0
// Size: 0x236
function laststand_disable_player_weapons() {
    self disableweaponcycling();
    var_df4942c2 = self getweaponslist(1);
    self.lastactiveweapon = self.lastnonkillstreakweapon;
    self.laststandpistol = function_549df594();
    foreach (weapon in var_df4942c2) {
        if (zm_weapons::get_base_weapon(weapon) == zm_weapons::get_base_weapon(self.laststandpistol)) {
            function_f351748e(weapon);
        }
        if (weapon == level.weaponrevivetool || weapon === self.weaponrevivetool) {
            self zm_stats::increment_client_stat("failed_sacrifices");
            self zm_stats::increment_player_stat("failed_sacrifices");
            continue;
        }
        if (weapon.isperkbottle) {
            self takeweapon(weapon);
            self.lastactiveweapon = level.weaponnone;
            continue;
        }
        if (isdefined(zm_utility::get_gamemode_var("item_meat_weapon")) && weapon == zm_utility::get_gamemode_var("item_meat_weapon")) {
            self takeweapon(weapon);
            self.lastactiveweapon = level.weaponnone;
        }
    }
    self notify(#"weapons_taken_for_last_stand");
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x43991b17, Offset: 0x1d30
// Size: 0x292
function laststand_enable_player_weapons(b_bled_out) {
    self endon(#"death");
    if (isdefined(self.laststandpistol)) {
        if (isdefined(self.var_1d2409c1)) {
            function_a9cb028f();
            self.var_1d2409c1 = undefined;
        } else {
            self takeweapon(self.laststandpistol);
        }
    }
    if (!is_true(b_bled_out)) {
        self enableweaponcycling();
        self enableoffhandweapons();
        self registerfxanim_warehouse_explo(0);
        if (self.lastactiveweapon != level.weaponnone && self hasweapon(self.lastactiveweapon, 1) && !zm_loadout::is_placeable_mine(self.lastactiveweapon) && !zm_equipment::is_equipment(self.lastactiveweapon) && !zm_loadout::is_hero_weapon(self.lastactiveweapon) && !self.lastactiveweapon.isriotshield) {
            self switchtoweapon(self.lastactiveweapon);
        } else if (self getweaponslistprimaries().size) {
            self switchtoweapon();
        } else {
            zm_weapons::give_fallback_weapon();
        }
        do {
            s_waitresult = self waittilltimeout(2.5, #"weapon_change_complete");
        } while (self getcurrentweapon() === level.weaponnone);
    }
    self.laststandpistol = undefined;
    self notify(#"hash_9b426cce825928d");
    if (is_true(b_bled_out)) {
        waitframe(1);
        self.s_loadout = zm_weapons::player_get_loadout();
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xd07853aa, Offset: 0x1fd0
// Size: 0x18
function laststand_has_players_weapons_returned() {
    if (isdefined(self.laststandpistol)) {
        return false;
    }
    return true;
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xfc217e80, Offset: 0x1ff0
// Size: 0x34
function function_cbfcda16() {
    if (level.players.size > 1) {
        return level.default_laststandpistol;
    }
    return level.default_solo_laststandpistol;
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xa9968870, Offset: 0x2030
// Size: 0x148
function function_5ff83684() {
    level.pistol_values = [];
    level.pistol_values[level.pistol_values.size] = level.default_laststandpistol;
    level.pistol_values[level.pistol_values.size] = getweapon(#"pistol_semiauto_t9");
    level.pistol_values[level.pistol_values.size] = getweapon(#"pistol_burst_t9");
    level.pistol_value_solo_replace_below = level.pistol_values.size - 1;
    level.pistol_values[level.pistol_values.size] = level.default_solo_laststandpistol;
    level.pistol_values[level.pistol_values.size] = getweapon(#"hash_e58e352069bc0a5");
    level.pistol_values[level.pistol_values.size] = getweapon(#"hash_7ea686a9e6a34c98");
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0xb1e80081, Offset: 0x2180
// Size: 0xa8
function function_aac4b2c9(weapon) {
    assert(weapon.weapclass === "<dev string:x38>" || weapon.weapclass === "<dev string:x38>" || weapon.weapclass === "<dev string:x38>", "<dev string:x42>");
    level flag::wait_till(#"load_main_complete");
    level.pistol_values[level.pistol_values.size] = weapon;
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xd350c9db, Offset: 0x2230
// Size: 0x1b6
function function_6155752d() {
    self endon(#"disconnect");
    self.var_d84718d1 = [];
    while (true) {
        s_result = self waittill(#"weapon_change_complete");
        if (isinarray(self.var_d84718d1, s_result.weapon) || laststand::player_is_in_laststand()) {
            continue;
        }
        switch (s_result.weapon.weapclass) {
        case #"pistol spread":
        case #"pistolspread":
        case #"pistol":
            if (is_true(level.var_d3cfc0c0) && zm_weapons::is_weapon_upgraded(s_result.weapon)) {
                continue;
            } else {
                if (!isdefined(self.var_d84718d1)) {
                    self.var_d84718d1 = [];
                } else if (!isarray(self.var_d84718d1)) {
                    self.var_d84718d1 = array(self.var_d84718d1);
                }
                self.var_d84718d1[self.var_d84718d1.size] = s_result.weapon;
            }
            continue;
        default:
            continue;
        }
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x250622a9, Offset: 0x23f0
// Size: 0x11c
function function_25a89622() {
    if (self zm_loadout::has_powerup_weapon()) {
        self.lastactiveweapon = level.weaponnone;
    }
    if (isdefined(self.w_min_last_stand_pistol_override)) {
        self function_f161bb2d();
    }
    if (!self hasweapon(self.laststandpistol, 0)) {
        self giveweapon(self.laststandpistol);
    }
    if (isdefined(self.var_1d2409c1)) {
        self setweaponammoclip(self.laststandpistol, self.laststandpistol.clipsize);
    }
    self setweaponammostock(self.laststandpistol, self.laststandpistol.clipsize * 2);
    self switchtoweapon(self.laststandpistol);
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xcb9d77e0, Offset: 0x2518
// Size: 0xd6
function function_f161bb2d() {
    for (i = 0; i < level.pistol_values.size; i++) {
        if (level.pistol_values[i] == self.w_min_last_stand_pistol_override) {
            n_min_last_stand_pistol_value = i;
            break;
        }
    }
    for (k = 0; k < level.pistol_values.size; k++) {
        if (level.pistol_values[k] == self.laststandpistol) {
            n_default_last_stand_pistol_value = k;
            break;
        }
    }
    if (n_min_last_stand_pistol_value > n_default_last_stand_pistol_value) {
        self.hadpistol = 0;
        self.laststandpistol = self.w_min_last_stand_pistol_override;
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xd6f4bb64, Offset: 0x25f8
// Size: 0x1a2
function function_549df594() {
    var_2a32d68 = self.var_d84718d1;
    if (!isdefined(var_2a32d68)) {
        var_2a32d68 = [];
    } else if (!isarray(var_2a32d68)) {
        var_2a32d68 = array(var_2a32d68);
    }
    if (!isinarray(var_2a32d68, function_cbfcda16())) {
        var_2a32d68[var_2a32d68.size] = function_cbfcda16();
    }
    var_d3702e29 = 0;
    w_pistol = var_2a32d68[0];
    foreach (var_21ae1e3c in var_2a32d68) {
        for (j = 0; j < level.pistol_values.size; j++) {
            if (level.pistol_values[j] == var_21ae1e3c.rootweapon) {
                if (j > var_d3702e29) {
                    var_d3702e29 = j;
                    w_pistol = var_21ae1e3c;
                }
                break;
            }
        }
    }
    return self getbuildkitweapon(w_pistol);
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x19605f89, Offset: 0x27a8
// Size: 0xb6
function function_f351748e(weapon) {
    var_1d2409c1 = spawnstruct();
    var_1d2409c1.n_clip = self getweaponammoclip(weapon);
    var_1d2409c1.var_d54402a8 = 0;
    if (weapon.dualwieldweapon != level.weaponnone) {
        var_1d2409c1.var_d54402a8 = self getweaponammoclip(weapon.dualwieldweapon);
    }
    var_1d2409c1.n_stock = self getweaponammostock(weapon);
    self.var_1d2409c1 = var_1d2409c1;
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xea9b05cf, Offset: 0x2868
// Size: 0xcc
function function_a9cb028f() {
    var_1d2409c1 = self.var_1d2409c1;
    weapon = self.laststandpistol;
    if (self hasweapon(weapon, 1)) {
        self setweaponammoclip(weapon, var_1d2409c1.n_clip);
        if (weapon.dualwieldweapon != level.weaponnone) {
            self setweaponammoclip(weapon.dualwieldweapon, var_1d2409c1.var_d54402a8);
        }
        self setweaponammostock(weapon, var_1d2409c1.n_stock);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 3, eflags: 0x1 linked
// Checksum 0x9af53e0b, Offset: 0x2940
// Size: 0xbc
function laststand_clean_up_on_disconnect(e_revivee, w_reviver, w_revive_tool) {
    self endon(#"do_revive_ended_normally", #"death");
    revivetrigger = e_revivee.revivetrigger;
    e_revivee waittill(#"disconnect");
    if (isdefined(revivetrigger)) {
        revivetrigger delete();
    }
    if (isdefined(w_reviver) && isdefined(w_revive_tool)) {
        self revive_give_back_weapons(w_reviver, w_revive_tool);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x8acb3f38, Offset: 0x2a08
// Size: 0x9a
function laststand_clean_up_reviving_any(e_revivee) {
    self endon(#"do_revive_ended_normally", #"disconnect");
    e_revivee waittill(#"disconnect", #"zombified", #"stop_revive_trigger");
    if (!isdefined(self.is_reviving_any)) {
        self.is_reviving_any = 0;
    }
    self.is_reviving_any--;
    if (self.is_reviving_any < 0) {
        self.is_reviving_any = 0;
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x91ef21cd, Offset: 0x2ab0
// Size: 0x7c
function laststand_give_pistol() {
    assert(isdefined(self.laststandpistol));
    assert(self.laststandpistol != level.weaponnone);
    function_25a89622();
    self thread wait_switch_weapon(1, self.laststandpistol);
}

// Namespace zm_laststand/zm_laststand
// Params 2, eflags: 0x1 linked
// Checksum 0x195a63e9, Offset: 0x2b38
// Size: 0x64
function wait_switch_weapon(n_delay, w_weapon) {
    self endon(#"player_revived", #"zombified", #"disconnect");
    wait n_delay;
    self switchtoweapon(w_weapon);
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xbdd677c6, Offset: 0x2ba8
// Size: 0x45c
function laststand_bleedout(delay) {
    self endon(#"player_revived", #"zombified", #"disconnect", #"instakill_player");
    level endon(#"end_game", #"round_reset");
    if (level flag::get("round_reset")) {
        return;
    }
    self thread zm_perks::function_b4c0e0ee(delay);
    if (is_true(level.var_5b7d2700)) {
        return;
    }
    if (is_true(self.is_zombie) || is_true(self.var_39c78617)) {
        self notify(#"bled_out");
        globallogic_player::function_b2873ebe();
        level notify(#"player_bled_out", {#player:self});
        self callback::callback(#"on_player_bleedout");
        util::wait_network_frame();
        self bleed_out();
        return;
    }
    self clientfield::set("zmbLastStand", 1);
    self.bleedout_time = delay;
    n_default_bleedout_time = getdvarfloat(#"player_laststandbleedouttime", 0);
    if (!level.var_ff482f76 zm_laststand_client::is_open(self)) {
        level.var_ff482f76 zm_laststand_client::open(self, 0);
    }
    level.var_ff482f76 zm_laststand_client::set_num_downs(self, self.n_downs);
    level.var_ff482f76 zm_laststand_client::set_revive_progress(self, 0);
    while (self.bleedout_time > 0) {
        self.bleedout_time -= 1;
        level clientfield::set("laststand_update" + self getentitynumber(), self.bleedout_time / delay);
        level.var_ff482f76 zm_laststand_client::set_bleedout_progress(self, self.bleedout_time / delay);
        wait 1;
    }
    while (self.var_16735873 === 1) {
        wait 0.1;
    }
    while (isdefined(self.revivetrigger) && (is_true(self.revivetrigger.beingrevived) || is_true(self.var_d1e03242))) {
        wait 0.1;
    }
    self notify(#"bled_out");
    globallogic_player::function_b2873ebe();
    level notify(#"player_bled_out", {#player:self});
    self callback::callback(#"on_player_bleedout");
    self.var_ea7ea155 = 1;
    util::wait_network_frame();
    level.var_ff482f76 zm_laststand_client::close(self);
    self bleed_out();
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xbd6c93fc, Offset: 0x3010
// Size: 0x30c
function bleed_out() {
    self endon(#"disconnect");
    self notify(#"stop_revive_trigger");
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
        self.revivetrigger = undefined;
    }
    foreach (talent in self.var_7341f980) {
        namespace_791d0451::function_4c1d0e25(talent);
    }
    self laststand_enable_player_weapons(1);
    self.laststand = undefined;
    self clientfield::set("zmbLastStand", 0);
    self zm_stats::increment_client_stat("deaths");
    self zm_stats::increment_player_stat("deaths");
    self zm_stats::function_8f10788e("boas_deaths");
    self recordplayerdeathzombies();
    self.last_bleed_out_time = gettime();
    self zm_equipment::take();
    demo::bookmark(#"zm_player_bledout", gettime(), self, undefined, 1);
    potm::bookmark(#"zm_player_bledout", gettime(), self, undefined, 1);
    level notify(#"bleed_out", {#character_index:self.characterindex});
    self undolaststand();
    self clientfield::set("zm_last_stand_postfx", 0);
    zm_player::function_8ef51109(self, 1);
    self.var_ea7ea155 = undefined;
    self suicide();
    if (is_true(level.is_zombie_level)) {
        self thread [[ level.player_becomes_zombie ]]();
        self.statusicon = "hud_status_dead";
        return;
    }
    self val::reset(#"laststand", "ignoreme");
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x5fe4fcf4, Offset: 0x3328
// Size: 0x8e
function can_suicide() {
    if (!isalive(self)) {
        return false;
    }
    if (!self laststand::player_is_in_laststand()) {
        return false;
    }
    if (!isdefined(self.suicideprompt)) {
        return false;
    }
    if (is_true(self.is_zombie)) {
        return false;
    }
    if (is_true(level.intermission)) {
        return false;
    }
    return true;
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x66e7e5fb, Offset: 0x33c0
// Size: 0x3c
function is_suiciding(*revivee) {
    return self usebuttonpressed() && can_suicide();
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xeff0c10c, Offset: 0x3408
// Size: 0x270
function function_4d3cb10() {
    level notify(#"notify_check_self_revive_for_hotjoin");
    level endon(#"notify_check_self_revive_for_hotjoin");
    var_9156a121 = 0;
    var_972a361b = 0;
    waitframe(1);
    a_e_players = getplayers();
    if (a_e_players.size == 1) {
        var_9156a121 = 1;
        if (!level flag::get("solo_game")) {
            var_972a361b = 1;
            level flag::set("solo_game");
        }
    } else if (level flag::get("solo_game")) {
        var_972a361b = 1;
        level flag::clear("solo_game");
    }
    if (var_972a361b && !zm_utility::is_standard() && !zm_utility::is_trials()) {
        foreach (e_player in a_e_players) {
            if (is_true(e_player.var_240cf7be)) {
                if (var_9156a121) {
                    e_player function_3d685b5f(int(max(0, e_player.var_d66589da - e_player.var_308dc243)));
                    continue;
                }
                e_player function_3d685b5f(int(max(0, e_player.var_5d4c5daf - e_player.var_308dc243)));
            }
        }
    }
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x19ce955b, Offset: 0x3680
// Size: 0x88
function function_3d685b5f(self_revive_count) {
    self_revive_count = int(max(self_revive_count, 0));
    self.var_72249004 = self_revive_count;
    self clientfield::set_player_uimodel("ZMInventoryPersonal.self_revive_count", self_revive_count);
    if (isdefined(level.var_c1fe3c83)) {
        self [[ level.var_c1fe3c83 ]]();
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x402d1dc, Offset: 0x3710
// Size: 0xa
function function_618fd37e() {
    return self.var_72249004;
}

// Namespace zm_laststand/zm_laststand
// Params 2, eflags: 0x1 linked
// Checksum 0x96f437c2, Offset: 0x3728
// Size: 0x9c
function function_3a00302e(n_count = 1, var_d47c52b4 = 1) {
    if (var_d47c52b4) {
        self.var_d66589da += n_count;
        self.var_5d4c5daf += n_count;
    }
    self function_3d685b5f(self function_618fd37e() + n_count);
}

// Namespace zm_laststand/zm_laststand
// Params 2, eflags: 0x1 linked
// Checksum 0x4bd80827, Offset: 0x37d0
// Size: 0x84
function function_409dc98e(n_count = 1, b_revived = 1) {
    if (b_revived) {
        self.var_308dc243 += n_count;
    }
    self function_3d685b5f(self function_618fd37e() - n_count);
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x7146ba66, Offset: 0x3860
// Size: 0x204
function function_b7c101fa() {
    self endon(#"disconnect");
    self.var_72249004 = 0;
    self.var_308dc243 = 0;
    self.var_d66589da = int(zombie_utility::function_d2dfacfd(#"hash_67ae1b8cbb7c985"));
    self.var_5d4c5daf = int(zombie_utility::function_d2dfacfd(#"hash_3098c53bba6402d3"));
    level thread function_4d3cb10();
    self waittill(#"spawned");
    if (!zm_utility::is_survival()) {
        level flag::wait_till("start_zombie_round_logic");
    } else {
        self function_3d685b5f(0);
        return;
    }
    if (getplayers().size == 1) {
        self_revive_count = self.var_d66589da;
        self.var_240cf7be = 1;
    } else {
        self_revive_count = self.var_5d4c5daf;
    }
    var_48f2f554 = zm_custom::function_901b751c(#"zmselfreviveamount");
    if (var_48f2f554) {
        self.var_d66589da = int(var_48f2f554);
        self.var_5d4c5daf = int(var_48f2f554);
        self function_3d685b5f(var_48f2f554);
        return;
    }
    self function_3d685b5f(self_revive_count);
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xecb854c9, Offset: 0x3a70
// Size: 0x24
function function_3699b145() {
    self.var_c2bb0cce = 1;
    self thread function_76043ec3();
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x4801005f, Offset: 0x3aa0
// Size: 0x200
function function_76043ec3() {
    self endon(#"disconnect", #"zombified", #"player_revived", #"bled_out");
    level endon(#"end_game");
    while (self usebuttonpressed()) {
        wait 1;
    }
    if (!isdefined(self.var_c2bb0cce)) {
        return;
    }
    self.var_c6a6f334 = 0;
    while (true) {
        wait 0.1;
        if (!isdefined(self.var_c2bb0cce)) {
            continue;
        }
        if (!self function_550c4ac4()) {
            continue;
        }
        n_duration = revive_get_revive_time(self);
        self_revive_success = function_73d6c609(n_duration);
        if (self_revive_success) {
            if (isdefined(level.a_revive_success_perk_func)) {
                foreach (func in level.a_revive_success_perk_func) {
                    self [[ func ]]();
                }
            }
            if (isdefined(self.var_ff5f8752)) {
                self thread zm_audio::create_and_play_dialog(#"revive", self.var_ff5f8752);
            }
            self thread auto_revive(self, 1, 1);
        }
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x948e3ef5, Offset: 0x3ca8
// Size: 0x34
function function_550c4ac4() {
    return self usebuttonpressed() && function_30b9cdd5();
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x5fdfdb36, Offset: 0x3ce8
// Size: 0x96
function function_30b9cdd5() {
    if (!isalive(self)) {
        return false;
    }
    if (is_true(self.var_c6a6f334)) {
        return false;
    }
    if (!isdefined(self.var_c2bb0cce)) {
        return false;
    }
    if (is_true(self.is_zombie)) {
        return false;
    }
    if (is_true(level.intermission)) {
        return false;
    }
    return true;
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x5442fe0b, Offset: 0x3d88
// Size: 0x136
function function_73d6c609(n_duration) {
    self endoncallback(&function_a7f11faa, #"player_revived", #"zombified", #"bled_out", #"disconnect");
    level endon(#"end_game");
    var_722c6f25 = 0;
    b_success = 0;
    while (true) {
        while (self function_550c4ac4()) {
            waitframe(1);
            var_722c6f25 += 0.05;
            level.var_ff482f76 zm_laststand_client::set_revive_progress(self, var_722c6f25 / n_duration);
            if (var_722c6f25 >= n_duration) {
                b_success = 1;
                break;
            }
        }
        var_722c6f25 = 0;
        if (is_true(b_success)) {
            return b_success;
        }
        waitframe(1);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xde378441, Offset: 0x3ec8
// Size: 0x1c
function function_a7f11faa(var_c34665fc) {
    if (var_c34665fc != "disconnect") {
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xa869df2b, Offset: 0x3ef0
// Size: 0x174
function revive_trigger_spawn() {
    if (is_true(level.var_28bbd30a)) {
        return;
    }
    radius = getdvarint(#"revive_trigger_radius", 100);
    self.revivetrigger = spawn("trigger_radius", (0, 0, 0), 0, radius, radius);
    self.revivetrigger sethintstring("");
    self.revivetrigger setcursorhint("HINT_NOICON");
    self.revivetrigger setmovingplatformenabled(1);
    self.revivetrigger enablelinkto();
    self.revivetrigger.origin = self.origin;
    self.revivetrigger linkto(self);
    self.revivetrigger setinvisibletoplayer(self);
    self.revivetrigger.beingrevived = 0;
    self.revivetrigger.createtime = gettime();
    self thread revive_trigger_think();
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xc282753, Offset: 0x4070
// Size: 0x6ac
function revive_trigger_think(t_secondary) {
    self endon(#"disconnect", #"zombified", #"stop_revive_trigger", #"death");
    level endon(#"end_game");
    while (true) {
        wait 0.1;
        if (isdefined(t_secondary)) {
            t_revive = t_secondary;
        } else if (isdefined(self.revivetrigger)) {
            if (!isdefined(self.revivetrigger)) {
                break;
            }
            t_revive = self.revivetrigger;
        } else {
            self notify(#"stop_revive_trigger");
            return;
        }
        t_revive sethintstring("");
        foreach (e_player in getplayers()) {
            n_depth = 0;
            n_depth = self depthinwater();
            if (isdefined(t_secondary)) {
                if (e_player can_revive(self, 1, 1) && e_player istouching(t_revive) || n_depth > 20) {
                    t_revive setrevivehintstring(#"hash_12272c5573321d90", self.team);
                    break;
                }
                continue;
            }
            if (e_player can_revive_via_override(self) || e_player can_revive(self) || n_depth > 20) {
                t_revive setrevivehintstring(#"hash_12272c5573321d90", self.team);
                break;
            }
        }
        foreach (e_reviver in getplayers()) {
            if (!isdefined(e_reviver) || self == e_reviver && !isdefined(self.var_6d772cb) || !e_reviver is_reviving(self, t_secondary)) {
                continue;
            }
            if (is_true(level.var_3ea7f9f4) && e_reviver zm_loadout::has_hero_weapon()) {
                w_reviver = undefined;
                w_revive_tool = undefined;
            } else if (!isdefined(self.var_6d772cb) && (!isdefined(e_reviver.s_revive_override_used) || e_reviver.s_revive_override_used.b_use_revive_tool)) {
                w_revive_tool = level.weaponrevivetool;
                if (isdefined(e_reviver.weaponrevivetool)) {
                    w_revive_tool = e_reviver.weaponrevivetool;
                }
                w_reviver = e_reviver getcurrentweapon();
                assert(isdefined(w_reviver));
                if (w_reviver == w_revive_tool) {
                    continue;
                }
                e_reviver giveweapon(w_revive_tool);
                e_reviver switchtoweapon(w_revive_tool);
                e_reviver setweaponammostock(w_revive_tool, 1);
                e_reviver disableweaponcycling();
                e_reviver disableoffhandweapons();
                e_reviver disableweaponswitchhero();
                e_reviver thread revive_give_back_weapons_when_done(w_reviver, w_revive_tool, self);
            } else {
                w_reviver = undefined;
                w_revive_tool = undefined;
            }
            if (isdefined(self.revivevox) && !is_true(self.var_54cb40e6)) {
                e_reviver thread zm_audio::create_and_play_dialog(#"revive", self.revivevox);
            }
            b_revive_successful = e_reviver revive_do_revive(self, w_reviver, w_revive_tool, t_secondary);
            if (isdefined(e_reviver)) {
                e_reviver notify(#"revive_done");
            }
            if (b_revive_successful) {
                if (isdefined(level.a_revive_success_perk_func)) {
                    foreach (func in level.a_revive_success_perk_func) {
                        self [[ func ]]();
                    }
                }
                level.var_ff482f76 zm_laststand_client::close(self);
                self thread revive_success(e_reviver);
                self notify(#"stop_revive_trigger");
                return;
            }
            if (isdefined(e_reviver)) {
                e_reviver zm_vo::vo_stop();
            }
        }
    }
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x6befdd8a, Offset: 0x4728
// Size: 0x12c
function function_8fd9d8b9(e_reviver) {
    self endon(#"death");
    zm_vo::vo_stop();
    if (e_reviver === self && isdefined(self.var_ff5f8752)) {
        self.last_vo_played_time = 0;
        zm_audio::create_and_play_dialog(#"revive", self.var_ff5f8752);
    }
    self notify(#"hash_1fe68a6b935c321d", {#reviver:e_reviver});
    if (!isdefined(self.var_6d772cb) && !is_true(self.var_54cb40e6)) {
        if (isplayer(e_reviver) && isdefined(e_reviver.var_c107ed3)) {
            self thread zm_audio::create_and_play_dialog(#"revive", e_reviver.var_c107ed3, undefined, 1);
        }
    }
}

// Namespace zm_laststand/zm_laststand
// Params 2, eflags: 0x1 linked
// Checksum 0x6a45d1fe, Offset: 0x4860
// Size: 0x8c
function revive_give_back_weapons_wait(e_reviver, e_revivee) {
    e_revivee endon(#"disconnect", #"zombified", #"stop_revive_trigger", #"death");
    level endon(#"end_game");
    e_reviver waittill(#"revive_done");
}

// Namespace zm_laststand/zm_laststand
// Params 3, eflags: 0x1 linked
// Checksum 0xd22b6787, Offset: 0x48f8
// Size: 0x5c
function revive_give_back_weapons_when_done(w_reviver, w_revive_tool, e_revivee) {
    self endon(#"death");
    revive_give_back_weapons_wait(self, e_revivee);
    self revive_give_back_weapons(w_reviver, w_revive_tool);
}

// Namespace zm_laststand/zm_laststand
// Params 2, eflags: 0x1 linked
// Checksum 0xb5f21501, Offset: 0x4960
// Size: 0x14c
function revive_give_back_weapons(w_reviver, w_revive_tool) {
    self takeweapon(w_revive_tool);
    if (self laststand::player_is_in_laststand()) {
        return;
    }
    self enableoffhandweapons();
    if (!is_true(self.var_b6840ea0)) {
        self enableweaponswitchhero();
    }
    self enableweaponcycling();
    if (w_reviver != level.weaponnone && !zm_loadout::is_placeable_mine(w_reviver) && !zm_equipment::is_equipment(w_reviver) && !w_reviver.isflourishweapon && self hasweapon(w_reviver)) {
        self zm_weapons::switch_back_primary_weapon(w_reviver, 0, 1);
        return;
    }
    self zm_weapons::switch_back_primary_weapon();
}

// Namespace zm_laststand/zm_laststand
// Params 3, eflags: 0x1 linked
// Checksum 0xe3d4130a, Offset: 0x4ab8
// Size: 0x326
function can_revive(e_revivee, ignore_sight_checks = 0, ignore_touch_checks = 0) {
    if (!isdefined(e_revivee.revivetrigger)) {
        return false;
    }
    if (!isalive(self)) {
        return false;
    }
    if (self laststand::player_is_in_laststand()) {
        return false;
    }
    if (self.team != e_revivee.team) {
        return false;
    }
    if (is_true(self.is_zombie)) {
        return false;
    }
    if (self zm_loadout::has_powerup_weapon()) {
        return false;
    }
    if (!is_true(level.var_3ea7f9f4) && self zm_loadout::has_hero_weapon()) {
        return false;
    }
    if (is_true(level.can_revive_use_depthinwater_test) && e_revivee depthinwater() > 10) {
        return true;
    }
    if (isdefined(level.can_revive) && ![[ level.can_revive ]](e_revivee)) {
        return false;
    }
    if (isdefined(level.var_1461fd14) && ![[ level.var_1461fd14 ]](e_revivee)) {
        return false;
    }
    if (!ignore_sight_checks && isdefined(level.revive_trigger_should_ignore_sight_checks)) {
        ignore_sight_checks = [[ level.revive_trigger_should_ignore_sight_checks ]](self);
        if (ignore_sight_checks && is_true(e_revivee.revivetrigger.beingrevived)) {
            ignore_touch_checks = 1;
        }
    }
    if (!ignore_touch_checks) {
        if (!self istouching(e_revivee.revivetrigger)) {
            return false;
        }
    }
    if (!ignore_sight_checks) {
        if (!self laststand::is_facing(e_revivee)) {
            return false;
        }
        if (!sighttracepassed(self.origin + (0, 0, 50), e_revivee.origin + (0, 0, 30), 0, undefined)) {
            return false;
        }
        if (!bullettracepassed(self.origin + (0, 0, 50), e_revivee.origin + (0, 0, 30), 0, undefined)) {
            return false;
        }
    }
    if (is_true(e_revivee.var_d1e03242)) {
        return false;
    }
    return true;
}

// Namespace zm_laststand/zm_laststand
// Params 2, eflags: 0x1 linked
// Checksum 0x2ba7a837, Offset: 0x4de8
// Size: 0xbc
function is_reviving(e_revivee, t_secondary) {
    if (self is_reviving_via_override(e_revivee)) {
        return true;
    }
    if (isdefined(t_secondary)) {
        return (self usebuttonpressed() && self can_revive(e_revivee, 1, 1) && self istouching(t_secondary));
    }
    return self usebuttonpressed() && can_revive(e_revivee);
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x94a5b9c0, Offset: 0x4eb0
// Size: 0x1a
function is_reviving_any() {
    return is_true(self.is_reviving_any);
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x673be96b, Offset: 0x4ed8
// Size: 0x76
function revive_get_revive_time(e_revivee) {
    revivetime = 3;
    if (self namespace_e86ffa8::function_8923370c(0)) {
        revivetime *= self function_bd85bc2f();
    }
    if (isdefined(self.get_revive_time)) {
        revivetime = self [[ self.get_revive_time ]](e_revivee);
    }
    return revivetime;
}

// Namespace zm_laststand/zm_laststand
// Params 4, eflags: 0x1 linked
// Checksum 0x70ef84a6, Offset: 0x4f58
// Size: 0x438
function revive_do_revive(e_revivee, w_reviver, w_revive_tool, t_secondary) {
    assert(self is_reviving(e_revivee, t_secondary));
    revivetime = self revive_get_revive_time(e_revivee);
    if (!isdefined(e_revivee.var_6fc48a11)) {
        e_revivee.var_6fc48a11 = 0;
    }
    revived = 0;
    e_revivee notify(#"player_being_revived");
    e_revivee.revivetrigger.beingrevived = 1;
    e_revivee thread laststand::revive_hud_show_n_fade(#"hash_12e2c5e29f8ce6ad", 3, self);
    e_revivee.revivetrigger sethintstring("");
    if (isplayer(e_revivee)) {
        e_revivee startrevive(self);
        e_revivee.var_c6a6f334 = 1;
    }
    self thread laststand_clean_up_on_disconnect(e_revivee, w_reviver, w_revive_tool);
    if (!isdefined(self.is_reviving_any)) {
        self.is_reviving_any = 0;
    }
    self.is_reviving_any++;
    self thread laststand_clean_up_reviving_any(e_revivee);
    if (!isdefined(self.revive_progress)) {
        self.revive_progress = 0;
    }
    self.revive_progress += 1;
    self thread check_for_failed_revive(e_revivee);
    while (isdefined(self) && self is_reviving(e_revivee, t_secondary)) {
        waitframe(1);
        e_revivee.var_6fc48a11 += 0.05;
        level.var_ff482f76 zm_laststand_client::set_revive_progress(e_revivee, e_revivee.var_6fc48a11 / revivetime);
        if (is_true(e_revivee.revivetrigger.auto_revive)) {
            break;
        }
        if (e_revivee.var_6fc48a11 >= revivetime) {
            e_revivee.laststand = undefined;
            revived = 1;
            break;
        }
    }
    if (!is_true(e_revivee.revivetrigger.auto_revive) && !revived) {
        if (isplayer(e_revivee)) {
            e_revivee stoprevive(self);
        }
    }
    e_revivee.revivetrigger sethintstring(#"hash_12272c5573321d90");
    e_revivee.revivetrigger.beingrevived = 0;
    if (isdefined(self)) {
        self notify(#"do_revive_ended_normally");
        if (!isdefined(self.is_reviving_any)) {
            self.is_reviving_any = 0;
        }
        self.is_reviving_any--;
        if (self.is_reviving_any < 0) {
            self.is_reviving_any = 0;
        }
        self.revive_progress = 0;
    }
    e_revivee.var_c6a6f334 = 0;
    if (!revived) {
        e_revivee thread checkforbleedout(self);
        e_revivee thread function_2cc9a315(revivetime);
        e_revivee thread function_7165ead0();
    } else {
        e_revivee.var_6fc48a11 = 0;
        level.var_ff482f76 zm_laststand_client::set_revive_progress(e_revivee, 0);
    }
    return revived;
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x69480203, Offset: 0x5398
// Size: 0xde
function function_2cc9a315(revivetime) {
    self endon(#"player_being_revived", #"player_revived", #"disconnect", #"bled_out");
    while (!is_true(self.var_c6a6f334) && isdefined(self.var_6fc48a11) && self.var_6fc48a11 >= 0) {
        self.var_6fc48a11 -= 0.05;
        level.var_ff482f76 zm_laststand_client::set_revive_progress(self, self.var_6fc48a11 / revivetime);
        waitframe(1);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xa16b7f3a, Offset: 0x5480
// Size: 0x62
function function_7165ead0() {
    self endon(#"player_being_revived", #"player_revived", #"disconnect");
    self waittill(#"bled_out");
    if (isdefined(self.var_6fc48a11)) {
        self.var_6fc48a11 = 0;
    }
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x2e60fb9c, Offset: 0x54f0
// Size: 0x60
function checkforbleedout(player) {
    if (isdefined(player) && zm_utility::is_classic()) {
        if (!isdefined(player.failed_revives)) {
            player.failed_revives = 0;
        }
        player.failed_revives++;
        player notify(#"player_failed_revive");
    }
}

// Namespace zm_laststand/zm_laststand
// Params 4, eflags: 0x1 linked
// Checksum 0x5b3eafce, Offset: 0x5558
// Size: 0x16c
function auto_revive(reviver, b_track_stats = 1, var_c0ab6a65, var_3f8e593d = 0) {
    level endon(#"end_game");
    self endoncallback(&function_48ce762a, #"disconnect");
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger.auto_revive = 1;
        if (self.revivetrigger.beingrevived) {
            while (true) {
                if (!isdefined(self.revivetrigger) || !self.revivetrigger.beingrevived) {
                    break;
                }
                util::wait_network_frame();
            }
        }
        if (isdefined(self.revivetrigger)) {
            self.revivetrigger.auto_trigger = 0;
        }
    }
    level.var_ff482f76 zm_laststand_client::close(self);
    self notify(#"stop_revive_trigger");
    self thread revive_success(reviver, b_track_stats, var_c0ab6a65, var_3f8e593d);
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x726d8fa2, Offset: 0x56d0
// Size: 0x34
function function_48ce762a(*param) {
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
    }
}

// Namespace zm_laststand/zm_laststand
// Params 4, eflags: 0x1 linked
// Checksum 0xfef888f, Offset: 0x5710
// Size: 0x194
function revive_success(reviver, b_track_stats = 1, var_c0ab6a65, var_5f465b1 = 0) {
    level endon(#"end_game");
    if (!isplayer(self)) {
        self notify(#"player_revived", {#reviver:reviver});
        return;
    }
    self thread function_8fd9d8b9(reviver);
    if (isplayer(reviver) && is_true(b_track_stats)) {
        reviver xp_revive_once_per_round(self);
        if (!is_true(level.isresetting_grief)) {
            reviver thread check_for_sacrifice();
        }
    }
    if (self namespace_e86ffa8::function_8923370c(3) || var_5f465b1) {
        self zm_utility::set_max_health();
        reviver zm_utility::set_max_health();
    }
    self revive_internal(reviver, b_track_stats, var_c0ab6a65);
}

// Namespace zm_laststand/zm_laststand
// Params 3, eflags: 0x5 linked
// Checksum 0x9bc4241d, Offset: 0x58b0
// Size: 0x550
function private revive_internal(reviver, b_track_stats, var_c0ab6a65 = 0) {
    self reviveplayer();
    self zm_utility::set_max_health();
    self clientfield::set("zmbLastStand", 0);
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
        self.revivetrigger = undefined;
    }
    self clientfield::set("zm_last_stand_postfx", 0);
    self val::set("zm_laststand", "allowdeath", 0);
    self util::delay(2, "death", &val::reset, "zm_laststand", "allowdeath");
    self util::delay(2, "death", &val::reset, "laststand", "ignoreme");
    self.laststand = undefined;
    if (var_c0ab6a65) {
        self function_409dc98e();
    }
    self setmovespeedscale(1);
    self allowjump(1);
    if (isplayer(reviver)) {
        reviver notify(#"player_did_a_revive", {#revived_player:self});
        level scoreevents::doscoreeventcallback("scoreEventZM", {#attacker:reviver, #scoreevent:"revived_teammate_zm"});
        if (!is_true(level.isresetting_grief) && is_true(b_track_stats) && reviver != self) {
            reviver.revives++;
            reviver zm_stats::increment_client_stat("revives");
            reviver zm_stats::increment_player_stat("revives");
            reviver zm_stats::function_f1a1191d("revives");
            reviver zm_stats::function_3468f864("revives");
            reviver zm_stats::function_7bc347f6("revives");
            reviver zm_stats::function_8f10788e("boas_revives");
            self recordplayerrevivezombies(reviver);
            demo::bookmark(#"zm_player_revived", gettime(), reviver, self);
            potm::bookmark(#"zm_player_revived", gettime(), reviver, self);
        }
    }
    self notify(#"player_revived", {#reviver:reviver, #var_a4916eac:self.var_84280a99});
    s_params = spawnstruct();
    s_params.e_revivee = self;
    s_params.e_reviver = reviver;
    s_params.var_84280a99 = self.var_84280a99;
    self callback::callback(#"on_player_revived", s_params);
    waitframe(1);
    if (isdefined(self)) {
        self thread laststand_enable_player_weapons();
    }
    if (getplayers().size == 1) {
        ais = getactorarray();
        foreach (ai in ais) {
            zm_utility::get_closest_valid_player(ai.origin, undefined, 1);
        }
    }
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xf0a2ac7a, Offset: 0x5e08
// Size: 0xaa
function xp_revive_once_per_round(player_being_revived) {
    if (!isdefined(self.number_revives_per_round)) {
        self.number_revives_per_round = [];
    }
    if (!isdefined(self.number_revives_per_round[player_being_revived.characterindex])) {
        self.number_revives_per_round[player_being_revived.characterindex] = 0;
    }
    if (self != player_being_revived && self.number_revives_per_round[player_being_revived.characterindex] == 0) {
        scoreevents::processscoreevent("revive_an_ally", self);
    }
    self.number_revives_per_round[player_being_revived.characterindex]++;
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x8a149080, Offset: 0x5ec0
// Size: 0x8c
function revive_force_revive(reviver) {
    assert(isdefined(self));
    assert(isplayer(self));
    assert(self laststand::player_is_in_laststand());
    self thread revive_success(reviver);
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x55920ddc, Offset: 0x5f58
// Size: 0x224
function revive_hud_think() {
    level endon(#"last_player_died");
    while (true) {
        wait 0.1;
        if (!laststand::player_any_player_in_laststand()) {
            continue;
        }
        players = getplayers();
        playertorevive = undefined;
        for (i = 0; i < players.size; i++) {
            if (!isdefined(players[i].revivetrigger) || !isdefined(players[i].revivetrigger.createtime)) {
                continue;
            }
            if (!isdefined(playertorevive) || playertorevive.revivetrigger.createtime > players[i].revivetrigger.createtime) {
                playertorevive = players[i];
            }
        }
        if (isdefined(playertorevive)) {
            for (i = 0; i < players.size; i++) {
                if (players[i] laststand::player_is_in_laststand()) {
                    continue;
                }
                if (util::get_game_type() == "vs") {
                    if (players[i].team != playertorevive.team) {
                        continue;
                    }
                }
                if (zm_utility::is_encounter()) {
                    if (players[i].sessionteam != playertorevive.sessionteam) {
                        continue;
                    }
                    if (is_true(level.hide_revive_message)) {
                        continue;
                    }
                }
                players[i] thread laststand::revive_hud_show_n_fade(#"hash_453f3038b87fbc77", 3, playertorevive);
            }
            playertorevive.revivetrigger.createtime = undefined;
            wait 3.5;
        }
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x36616b20, Offset: 0x6188
// Size: 0x9c
function check_for_sacrifice() {
    self endon(#"death", #"sacrifice_denied");
    self util::delay_notify("sacrifice_denied", 1);
    self waittill(#"player_downed");
    self zm_stats::increment_client_stat("sacrifices");
    self zm_stats::increment_player_stat("sacrifices");
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x7dd27a9d, Offset: 0x6230
// Size: 0xdc
function check_for_failed_revive(e_revivee) {
    self notify(#"checking_for_failed_revive");
    self endon(#"disconnect", #"checking_for_failed_revive");
    e_revivee endon(#"disconnect", #"player_revived");
    e_revivee waittill(#"bled_out");
    self zm_stats::increment_client_stat("failed_revives");
    self zm_stats::increment_player_stat("failed_revives");
    self zm_stats::function_8f10788e("boas_failed_revives");
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xc90b5cb7, Offset: 0x6318
// Size: 0xc4
function add_weighted_down() {
    if (!level.curr_gametype_affects_rank) {
        return;
    }
    weighted_down = 1000;
    if (level.round_number > 0) {
        weighted_down = int(1000 / ceil(level.round_number / 5));
    }
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return;
    }
    self stats::function_dad108fa(#"weighted_downs", weighted_down);
}

// Namespace zm_laststand/zm_laststand
// Params 3, eflags: 0x0
// Checksum 0x497017d0, Offset: 0x63e8
// Size: 0xc8
function register_revive_override(func_is_reviving, func_can_revive = undefined, b_use_revive_tool = 0) {
    if (!isdefined(self.a_s_revive_overrides)) {
        self.a_s_revive_overrides = [];
    }
    s_revive_override = spawnstruct();
    s_revive_override.func_is_reviving = func_is_reviving;
    if (isdefined(func_can_revive)) {
        s_revive_override.func_can_revive = func_can_revive;
    } else {
        s_revive_override.func_can_revive = func_is_reviving;
    }
    s_revive_override.b_use_revive_tool = b_use_revive_tool;
    self.a_s_revive_overrides[self.a_s_revive_overrides.size] = s_revive_override;
    return s_revive_override;
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x232b3f4f, Offset: 0x64b8
// Size: 0x3c
function deregister_revive_override(s_revive_override) {
    if (isdefined(self) && isdefined(self.a_s_revive_overrides)) {
        arrayremovevalue(self.a_s_revive_overrides, s_revive_override);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xcc012266, Offset: 0x6500
// Size: 0x72
function can_revive_via_override(e_revivee) {
    if (isdefined(self) && isdefined(self.a_s_revive_overrides)) {
        for (i = 0; i < self.a_s_revive_overrides.size; i++) {
            if (self [[ self.a_s_revive_overrides[i].func_can_revive ]](e_revivee)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xaf2fdaa3, Offset: 0x6580
// Size: 0xc4
function is_reviving_via_override(e_revivee) {
    if (isdefined(self) && isdefined(self.a_s_revive_overrides)) {
        if (isdefined(e_revivee.var_84280a99) && e_revivee.var_84280a99 !== self) {
            return false;
        }
        for (i = 0; i < self.a_s_revive_overrides.size; i++) {
            if (self [[ self.a_s_revive_overrides[i].func_is_reviving ]](e_revivee)) {
                self.s_revive_override_used = self.a_s_revive_overrides[i];
                return true;
            }
        }
    }
    if (isdefined(self)) {
        self.s_revive_override_used = undefined;
    }
    return false;
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x41595cb0, Offset: 0x6650
// Size: 0xa4
function instakill_player() {
    self.var_39c78617 = 1;
    self notify(#"instakill_player");
    if (self laststand::player_is_in_laststand()) {
        level.var_ff482f76 zm_laststand_client::close(self);
        waitframe(4);
        bleed_out();
        return;
    }
    self dodamage(self.maxhealth + 666, self.origin);
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x885ad202, Offset: 0x6700
// Size: 0x112
function on_ai_killed(s_params) {
    e_player = s_params.eattacker;
    if (isplayer(e_player) && (e_player namespace_791d0451::function_56cedda7(#"hash_504b3df717f88c4e") || is_true(e_player.var_5f465b1)) && e_player laststand::player_is_in_laststand()) {
        if (e_player namespace_791d0451::function_56cedda7(#"hash_504b3df717f88c4e")) {
            namespace_791d0451::function_4c1d0e25(#"hash_504b3df717f88c4e");
        }
        e_player thread auto_revive(e_player, 1, 0, 1);
        e_player notify(#"stop_revive_trigger");
        e_player.var_5f465b1 = undefined;
    }
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x1fc43662, Offset: 0x6820
// Size: 0x84
function on_item_pickup(s_params) {
    item = s_params.item;
    var_a6762160 = item.var_a6762160;
    if (var_a6762160.name === #"self_revive_sr_item") {
        if (self function_618fd37e() < 1) {
            self function_3a00302e(1);
        }
    }
}

