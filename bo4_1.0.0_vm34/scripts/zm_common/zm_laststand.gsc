#using script_243ea03c7a285692;
#using script_30a4b3e6d6d5e540;
#using script_48f7c4ab73137f8;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
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
#using scripts\zm_common\zm_weapons;

#namespace zm_laststand;

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x2
// Checksum 0xe1641ad3, Offset: 0x3a8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_laststand", &__init__, undefined, undefined);
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x11fcd583, Offset: 0x3f0
// Size: 0x232
function __init__() {
    level flag::init("solo_revive");
    level.revive_hud = revive_hud::register("revive_hud");
    level.var_70cb425c = zm_laststand_client::register("zm_laststand_client");
    level.var_7d6b01fb = self_revive_visuals::register("self_revive_visuals");
    callback::on_connect(&on_player_connect);
    callback::on_disconnect(&function_f78fbdf8);
    clientfield::register("clientuimodel", "ZMInventoryPersonal.self_revive_count", 1, 7, "int");
    clientfield::register("allplayers", "zm_last_stand_postfx", 1, 1, "int");
    level.laststand_update_clientfields = [];
    for (i = 0; i < 4; i++) {
        level.laststand_update_clientfields[i] = "laststand_update" + i;
        clientfield::register("world", level.laststand_update_clientfields[i], 1, 5, "float");
    }
    level.weaponsuicide = getweapon(#"death_self");
    if (!isdefined(getdvar(#"revive_trigger_radius"))) {
        setdvar(#"revive_trigger_radius", 75);
    }
    if (!isdefined(level.var_8b7dbdf3)) {
        level.var_8b7dbdf3 = 1;
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x64f28344, Offset: 0x630
// Size: 0x34
function on_player_connect() {
    self thread function_22e99229();
    self thread function_a4e3b1ac();
}

// Namespace zm_laststand/zm_laststand
// Params 9, eflags: 0x0
// Checksum 0x42fe521b, Offset: 0x670
// Size: 0x324
function player_last_stand_stats(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (isdefined(attacker) && isplayer(attacker) && attacker != self) {
        if ("zcleansed" == level.gametype) {
            demo::kill_bookmark(attacker, self, einflictor);
            potm::kill_bookmark(attacker, self, einflictor);
        }
        if ("zcleansed" == level.gametype) {
            if (!(isdefined(attacker.is_zombie) && attacker.is_zombie)) {
                attacker.kills++;
            } else {
                attacker.downs++;
            }
        } else {
            attacker.kills++;
        }
        attacker zm_stats::increment_client_stat("kills");
        attacker zm_stats::increment_player_stat("kills");
        attacker zm_stats::function_ed968b89("kills");
        attacker stats::function_4f10b697(weapon, #"kills", 1);
        if (zm_utility::is_headshot(weapon, shitloc, smeansofdeath)) {
            attacker.headshots++;
            attacker zm_stats::increment_client_stat("headshots");
            attacker stats::function_4f10b697(weapon, #"headshots", 1);
            attacker zm_stats::increment_player_stat("headshots");
            attacker zm_stats::function_ed968b89("headshots");
        }
    }
    self increment_downed_stat();
    if (level flag::get("solo_game") && self function_d75050c0() == 0 && getnumconnectedplayers() < 2) {
        self zm_stats::increment_client_stat("deaths");
        self zm_stats::increment_player_stat("deaths");
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x301c8b45, Offset: 0x9a0
// Size: 0x14c
function increment_downed_stat() {
    if ("zcleansed" != level.gametype) {
        self.downs++;
    }
    self zm_stats::increment_global_stat("TOTAL_DOWNS");
    self zm_stats::increment_map_stat("TOTAL_DOWNS");
    self zm_stats::function_ed968b89("TOTAL_DOWNS");
    self zm_stats::function_5d6859c1("TOTAL_DOWNS");
    self zm_stats::increment_client_stat("downs");
    self add_weighted_down();
    self zm_stats::increment_player_stat("downs");
    zonename = self zm_utility::get_current_zone();
    if (!isdefined(zonename)) {
        zonename = "";
    }
    self recordplayerdownzombies(zonename);
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x5067d825, Offset: 0xaf8
// Size: 0xa6
function function_d454a713(pause_enabled) {
    for (slot = 0; slot < 3; slot++) {
        if (!isdefined(self._gadgets_player[slot])) {
            continue;
        }
        if (isdefined(level.var_97b2d700) && level.var_97b2d700 == slot) {
            self zm_hero_weapon::function_cc0db168(slot, pause_enabled);
            continue;
        }
        self function_1d590050(slot, pause_enabled);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 9, eflags: 0x0
// Checksum 0xdf65e7eb, Offset: 0xba8
// Size: 0x774
function playerlaststand(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    self notify(#"entering_last_stand");
    self disableweaponcycling();
    self function_d454a713(1);
    if (self laststand::player_is_in_laststand()) {
        return;
    }
    if (isdefined(self.in_zombify_call) && self.in_zombify_call) {
        return;
    }
    self thread player_last_stand_stats(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    if (smeansofdeath == "MOD_SUICIDE") {
        self zm_stats::increment_client_stat("suicides");
        self zm_stats::increment_player_stat("suicides");
    }
    self allowjump(0);
    currweapon = self getcurrentweapon();
    self stats::function_4f10b697(currweapon, #"deathsduringuse", 1);
    if (self function_d75050c0() > 0 && !(isdefined(level.var_210e347b) && level.var_210e347b)) {
        if (level.players.size == 1) {
            self thread wait_and_revive();
        } else {
            self thread function_fad9fb74();
        }
    }
    self zm_utility::clear_is_drinking();
    self zm_score::player_downed_penalty();
    self disableoffhandweapons();
    if (smeansofdeath != "MOD_SUICIDE" && smeansofdeath != "MOD_FALLING") {
        if (!(isdefined(self.intermission) && self.intermission)) {
            self zm_audio::create_and_play_dialog("revive", "down");
        } else if (isdefined(level.var_204265bc) && !self [[ level.var_204265bc ]]()) {
            self zm_audio::create_and_play_dialog("general", "exert_death");
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
    if (!(isdefined(self.no_revive_trigger) && self.no_revive_trigger) || !(isdefined(self.var_b02abc40) && self.var_b02abc40)) {
        self revive_trigger_spawn();
    }
    if (isdefined(self.is_zombie) && self.is_zombie) {
        self takeallweapons();
        if (isdefined(attacker) && isplayer(attacker) && attacker != self) {
            attacker notify(#"killed_a_zombie_player", einflictor);
        }
    } else {
        self laststand_disable_player_weapons();
        self laststand_give_pistol();
    }
    if (isdefined(self.var_9fff94cd)) {
        self.var_9fff94cd = [];
    }
    if (!isdefined(self.n_downs)) {
        self.n_downs = 0;
    }
    self.n_downs += 1;
    bleedout_time = getdvarfloat(#"hash_1116ba0f929df636", isdefined(self.var_5e981063) ? self.var_5e981063 : getdvarfloat(#"player_laststandbleedouttime", 0));
    if (zm_custom::function_5638f689(#"zmlimiteddownsamount") && self.n_downs > zm_custom::function_5638f689(#"zmlimiteddownsamount")) {
        bleedout_time = 0;
    }
    if (isdefined(self.n_bleedout_time_multiplier)) {
        bleedout_time *= self.n_bleedout_time_multiplier;
    }
    if (isdefined(self.var_8a21af29)) {
        bleedout_time *= self.var_8a21af29;
    }
    self thread laststand_bleedout(bleedout_time);
    demo::bookmark(#"player_downed", gettime(), self);
    potm::bookmark(#"player_downed", gettime(), self);
    self notify(#"player_downed");
    self thread refire_player_downed();
    self thread laststand::function_692e99d6();
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0xedf9381d, Offset: 0x1328
// Size: 0x374
function wait_and_revive() {
    self endoncallback(&function_94b250d4, #"player_revived");
    level flag::set("wait_and_revive");
    level.wait_and_revive = 1;
    if (isdefined(self.waiting_to_revive) && self.waiting_to_revive) {
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
    var_23fa0a7d = (isdefined(self.var_5e981063) ? self.var_5e981063 : getdvarfloat(#"player_laststandbleedouttime", 0)) * 0.25;
    var_23fa0a7d = getdvarfloat(#"hash_1d447d6b4492bf4f", var_23fa0a7d);
    self thread laststand::revive_hud_show_n_fade(#"zombie/reviving_solo", var_23fa0a7d);
    var_aedfa8b1 = level waittilltimeout(var_23fa0a7d, #"end_of_round");
    if (var_aedfa8b1._notify === "end_of_round") {
        self thread laststand::revive_hud_show_n_fade(#"zombie/reviving_solo", 1);
    }
    self function_edd56797();
    self notify(#"hash_2c308c99381677bf");
    util::wait_network_frame();
    if (isdefined(level.a_revive_success_perk_func)) {
        foreach (func in level.a_revive_success_perk_func) {
            self [[ func ]]();
        }
    }
    if (isdefined(self.var_89929aa3)) {
        self zm_audio::create_and_play_dialog("revive", self.var_89929aa3);
    }
    self thread auto_revive(self);
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x51c7802, Offset: 0x16a8
// Size: 0x46
function function_94b250d4(var_e34146dc) {
    level flag::clear("wait_and_revive");
    level.wait_and_revive = 0;
    self.waiting_to_revive = 0;
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0xca49eeee, Offset: 0x16f8
// Size: 0x4e
function refire_player_downed() {
    self endon(#"player_revived", #"death");
    wait 1;
    if (self.num_perks) {
        self notify(#"player_downed");
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0xc001d406, Offset: 0x1750
// Size: 0x216
function laststand_disable_player_weapons() {
    self disableweaponcycling();
    var_6f845c3d = self getweaponslist(1);
    self.lastactiveweapon = self getcurrentweapon();
    self.laststandpistol = function_de0526ba();
    foreach (weapon in var_6f845c3d) {
        if (weapon == self.laststandpistol) {
            function_c7da284b(weapon);
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
// Params 1, eflags: 0x0
// Checksum 0xf679bf76, Offset: 0x1970
// Size: 0x22a
function laststand_enable_player_weapons(b_bled_out) {
    self endon(#"death");
    if (isdefined(self.laststandpistol)) {
        if (isdefined(self.var_2d7f1095)) {
            function_9ea141da();
            self.var_2d7f1095 = undefined;
        } else {
            self takeweapon(self.laststandpistol);
        }
    }
    if (!(isdefined(b_bled_out) && b_bled_out)) {
        self enableweaponcycling();
        self enableoffhandweapons();
        self function_d454a713(0);
        if (self.lastactiveweapon != level.weaponnone && self hasweapon(self.lastactiveweapon) && !zm_loadout::is_placeable_mine(self.lastactiveweapon) && !zm_equipment::is_equipment(self.lastactiveweapon) && !zm_loadout::is_hero_weapon(self.lastactiveweapon)) {
            self switchtoweapon(self.lastactiveweapon);
        } else if (self getweaponslistprimaries().size) {
            self switchtoweapon();
        } else {
            zm_weapons::give_fallback_weapon();
        }
        do {
            waitframe(1);
        } while (self isswitchingweapons());
    }
    self.laststandpistol = undefined;
    self notify(#"hash_9b426cce825928d");
    if (isdefined(b_bled_out) && b_bled_out) {
        waitframe(1);
        self.s_loadout = zm_weapons::player_get_loadout();
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0xcd85857d, Offset: 0x1ba8
// Size: 0x18
function laststand_has_players_weapons_returned() {
    if (isdefined(self.laststandpistol)) {
        return false;
    }
    return true;
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0xc23eae72, Offset: 0x1bc8
// Size: 0x34
function function_fd992155() {
    if (level.players.size > 1) {
        return level.default_laststandpistol;
    }
    return level.default_solo_laststandpistol;
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x70a6d6fa, Offset: 0x1c08
// Size: 0x22a
function function_14393746() {
    level.pistol_values = [];
    level.pistol_values[level.pistol_values.size] = level.default_laststandpistol;
    level.pistol_values[level.pistol_values.size] = getweapon(#"pistol_standard_t8");
    level.pistol_values[level.pistol_values.size] = getweapon(#"pistol_burst_t8");
    level.pistol_values[level.pistol_values.size] = getweapon(#"pistol_revolver_t8");
    level.pistol_value_solo_replace_below = level.pistol_values.size - 1;
    level.pistol_values[level.pistol_values.size] = level.default_solo_laststandpistol;
    level.pistol_values[level.pistol_values.size] = getweapon(#"pistol_standard_t8_upgraded");
    level.pistol_values[level.pistol_values.size] = getweapon(#"pistol_burst_t8_upgraded");
    level.pistol_values[level.pistol_values.size] = getweapon(#"pistol_revolver_t8_upgraded");
    level.pistol_values[level.pistol_values.size] = getweapon(#"ray_gun");
    level.pistol_values[level.pistol_values.size] = getweapon(#"ray_gun_upgraded");
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x4f275849, Offset: 0x1e40
// Size: 0x1b6
function function_a4e3b1ac() {
    self endon(#"disconnect");
    self.var_f7b8fa0e = [];
    while (true) {
        s_result = self waittill(#"weapon_change_complete");
        if (isinarray(self.var_f7b8fa0e, s_result.weapon) || laststand::player_is_in_laststand()) {
            continue;
        }
        switch (s_result.weapon.weapclass) {
        case #"pistol spread":
        case #"pistolspread":
        case #"pistol":
            if (isdefined(level.var_af8efa7) && level.var_af8efa7 && zm_weapons::is_weapon_upgraded(s_result.weapon)) {
                continue;
            } else {
                if (!isdefined(self.var_f7b8fa0e)) {
                    self.var_f7b8fa0e = [];
                } else if (!isarray(self.var_f7b8fa0e)) {
                    self.var_f7b8fa0e = array(self.var_f7b8fa0e);
                }
                self.var_f7b8fa0e[self.var_f7b8fa0e.size] = s_result.weapon;
            }
            continue;
        default:
            continue;
        }
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x299345c0, Offset: 0x2000
// Size: 0x11c
function function_cffb8d72() {
    if (self zm_loadout::has_powerup_weapon()) {
        self.lastactiveweapon = level.weaponnone;
    }
    if (isdefined(self.w_min_last_stand_pistol_override)) {
        self function_8e0506f6();
    }
    if (!self hasweapon(self.laststandpistol)) {
        self giveweapon(self.laststandpistol);
    }
    if (isdefined(self.var_2d7f1095)) {
        self setweaponammoclip(self.laststandpistol, self.laststandpistol.clipsize);
    }
    self setweaponammostock(self.laststandpistol, self.laststandpistol.clipsize * 2);
    self switchtoweapon(self.laststandpistol);
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x7ffa3786, Offset: 0x2128
// Size: 0xe2
function function_8e0506f6() {
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
// Params 0, eflags: 0x0
// Checksum 0x566ddb20, Offset: 0x2218
// Size: 0x17c
function function_de0526ba() {
    var_1411be3d = self.var_f7b8fa0e;
    if (!isdefined(var_1411be3d)) {
        var_1411be3d = [];
    } else if (!isarray(var_1411be3d)) {
        var_1411be3d = array(var_1411be3d);
    }
    if (!isinarray(var_1411be3d, function_fd992155())) {
        var_1411be3d[var_1411be3d.size] = function_fd992155();
    }
    var_67ce8d2e = 0;
    foreach (var_5ca9e112 in var_1411be3d) {
        for (j = 0; j < level.pistol_values.size; j++) {
            if (level.pistol_values[j] == var_5ca9e112.rootweapon) {
                if (j > var_67ce8d2e) {
                    var_67ce8d2e = j;
                }
                break;
            }
        }
    }
    return level.pistol_values[var_67ce8d2e];
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0xd355b205, Offset: 0x23a0
// Size: 0xc2
function function_c7da284b(weapon) {
    var_2d7f1095 = spawnstruct();
    var_2d7f1095.n_clip = self getweaponammoclip(weapon);
    var_2d7f1095.var_ce340648 = 0;
    if (weapon.dualwieldweapon != level.weaponnone) {
        var_2d7f1095.var_ce340648 = self getweaponammoclip(weapon.dualwieldweapon);
    }
    var_2d7f1095.n_stock = self getweaponammostock(weapon);
    self.var_2d7f1095 = var_2d7f1095;
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x68d512cb, Offset: 0x2470
// Size: 0xcc
function function_9ea141da() {
    var_2d7f1095 = self.var_2d7f1095;
    weapon = self.laststandpistol;
    if (self hasweapon(weapon)) {
        self setweaponammoclip(weapon, var_2d7f1095.n_clip);
        if (weapon.dualwieldweapon != level.weaponnone) {
            self setweaponammoclip(weapon.dualwieldweapon, var_2d7f1095.var_ce340648);
        }
        self setweaponammostock(weapon, var_2d7f1095.n_stock);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 3, eflags: 0x0
// Checksum 0xdcd53709, Offset: 0x2548
// Size: 0xac
function laststand_clean_up_on_disconnect(e_revivee, w_reviver, w_revive_tool) {
    self endon(#"do_revive_ended_normally");
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
// Params 1, eflags: 0x0
// Checksum 0xd6934c1b, Offset: 0x2600
// Size: 0x76
function laststand_clean_up_reviving_any(e_revivee) {
    self endon(#"do_revive_ended_normally");
    e_revivee waittill(#"disconnect", #"zombified", #"stop_revive_trigger");
    self.is_reviving_any--;
    if (self.is_reviving_any < 0) {
        self.is_reviving_any = 0;
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x4c97016d, Offset: 0x2680
// Size: 0x7c
function laststand_give_pistol() {
    assert(isdefined(self.laststandpistol));
    assert(self.laststandpistol != level.weaponnone);
    function_cffb8d72();
    self thread wait_switch_weapon(1, self.laststandpistol);
}

// Namespace zm_laststand/zm_laststand
// Params 2, eflags: 0x0
// Checksum 0x7e10c1f7, Offset: 0x2708
// Size: 0x64
function wait_switch_weapon(n_delay, w_weapon) {
    self endon(#"player_revived", #"zombified", #"disconnect");
    wait n_delay;
    self switchtoweapon(w_weapon);
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x8b70d23e, Offset: 0x2778
// Size: 0x38c
function laststand_bleedout(delay) {
    self endon(#"player_revived", #"zombified", #"disconnect");
    level endon(#"end_game", #"round_reset");
    if (level flag::get("round_reset")) {
        return;
    }
    self thread zm_perks::function_95f1ffa(delay);
    if (isdefined(level.var_c8eb41dc) && level.var_c8eb41dc) {
        return;
    }
    if (isdefined(self.is_zombie) && self.is_zombie || isdefined(self.var_b02abc40) && self.var_b02abc40) {
        self notify(#"bled_out");
        globallogic_player::function_dd466180();
        util::wait_network_frame();
        self bleed_out();
        return;
    }
    self clientfield::set("zmbLastStand", 1);
    self.bleedout_time = delay;
    n_default_bleedout_time = getdvarfloat(#"player_laststandbleedouttime", 0);
    level.var_70cb425c zm_laststand_client::open(self, 0);
    level.var_70cb425c zm_laststand_client::set_revive_progress(self, 0);
    while (self.bleedout_time > 0) {
        self.bleedout_time -= 1;
        level clientfield::set("laststand_update" + self getentitynumber(), self.bleedout_time / delay);
        level.var_70cb425c zm_laststand_client::set_bleedout_progress(self, self.bleedout_time / delay);
        wait 1;
    }
    while (isdefined(self.revivetrigger) && isdefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived) {
        wait 0.1;
    }
    self notify(#"bled_out");
    globallogic_player::function_dd466180();
    level notify(#"player_bled_out", {#player:self});
    self callback::callback(#"on_player_bleedout");
    util::wait_network_frame();
    level.var_70cb425c zm_laststand_client::close(self);
    level.var_7d6b01fb self_revive_visuals::close(self);
    self bleed_out();
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x1ad1e641, Offset: 0x2b10
// Size: 0x24c
function bleed_out() {
    self notify(#"stop_revive_trigger");
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
        self.revivetrigger = undefined;
    }
    self laststand_enable_player_weapons(1);
    self.laststand = undefined;
    self clientfield::set("zmbLastStand", 0);
    self zm_stats::increment_client_stat("deaths");
    self zm_stats::increment_player_stat("deaths");
    self recordplayerdeathzombies();
    self.last_bleed_out_time = gettime();
    self zm_equipment::take();
    demo::bookmark(#"zm_player_bledout", gettime(), self, undefined, 1);
    potm::bookmark(#"zm_player_bledout", gettime(), self, undefined, 1);
    level notify(#"bleed_out", {#character_index:self.characterindex});
    self undolaststand();
    self clientfield::set("zm_last_stand_postfx", 0);
    zm_player::function_cb9259f5(self);
    self suicide();
    if (isdefined(level.is_zombie_level) && level.is_zombie_level) {
        self thread [[ level.player_becomes_zombie ]]();
        self.statusicon = "hud_status_dead";
        return;
    }
    self val::reset(#"laststand", "ignoreme");
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x16709b87, Offset: 0x2d68
// Size: 0x90
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
    if (isdefined(self.is_zombie) && self.is_zombie) {
        return false;
    }
    if (isdefined(level.intermission) && level.intermission) {
        return false;
    }
    return true;
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0xa703df6b, Offset: 0x2e00
// Size: 0x3c
function is_suiciding(revivee) {
    return self usebuttonpressed() && can_suicide();
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x11d7b86b, Offset: 0x2e48
// Size: 0x250
function function_f78fbdf8() {
    level notify(#"hash_ec82a2f41cadbea");
    level endon(#"hash_ec82a2f41cadbea");
    var_df7637b1 = 0;
    var_8d9b189f = 0;
    waitframe(1);
    a_e_players = getplayers();
    if (a_e_players.size == 1) {
        var_df7637b1 = 1;
        if (!level flag::get("solo_game")) {
            var_8d9b189f = 1;
            level flag::set("solo_game");
        }
    } else if (level flag::get("solo_game")) {
        var_8d9b189f = 1;
        level flag::clear("solo_game");
    }
    if (var_8d9b189f && !zm_utility::is_standard()) {
        foreach (e_player in a_e_players) {
            if (var_df7637b1) {
                e_player function_7996dd34(int(max(0, e_player.var_98a50951 - e_player.var_c615b5f3)));
                continue;
            }
            if (isdefined(e_player.var_2171dd3a) && e_player.var_2171dd3a) {
                e_player function_7996dd34(int(max(0, e_player.var_596952e7 - e_player.var_c615b5f3)));
            }
        }
    }
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x8a32e3cc, Offset: 0x30a0
// Size: 0x60
function function_7996dd34(self_revive_count) {
    self.var_d692c624 = self_revive_count;
    self clientfield::set_player_uimodel("ZMInventoryPersonal.self_revive_count", self_revive_count);
    if (isdefined(level.var_a3406d4)) {
        self [[ level.var_a3406d4 ]]();
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x3b6aa9cc, Offset: 0x3108
// Size: 0xa
function function_d75050c0() {
    return self.var_d692c624;
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x20aaa0dc, Offset: 0x3120
// Size: 0x6c
function function_1cc4ccbf(var_6ac14905 = 1) {
    if (var_6ac14905) {
        self.var_98a50951++;
        self.var_596952e7++;
    }
    self function_7996dd34(self function_d75050c0() + 1);
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0xe590768d, Offset: 0x3198
// Size: 0x5c
function function_edd56797(b_revived = 1) {
    if (b_revived) {
        self.var_c615b5f3++;
    }
    self function_7996dd34(self function_d75050c0() - 1);
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0xad6523c, Offset: 0x3200
// Size: 0x1cc
function function_22e99229() {
    self endon(#"disconnect");
    self.var_d692c624 = 0;
    self.var_c615b5f3 = 0;
    self.var_98a50951 = int(zombie_utility::get_zombie_var(#"hash_67ae1b8cbb7c985"));
    self.var_596952e7 = int(zombie_utility::get_zombie_var(#"hash_3098c53bba6402d3"));
    level thread function_f78fbdf8();
    self waittill(#"spawned");
    level flag::wait_till("start_zombie_round_logic");
    if (getplayers().size == 1) {
        self_revive_count = self.var_98a50951;
        self.var_2171dd3a = 1;
    } else {
        self_revive_count = self.var_596952e7;
    }
    var_be331071 = zm_custom::function_5638f689(#"zmselfreviveamount");
    if (var_be331071) {
        self.var_98a50951 = int(var_be331071);
        self.var_596952e7 = int(var_be331071);
        self function_7996dd34(var_be331071);
        return;
    }
    self function_7996dd34(self_revive_count);
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x7279d48a, Offset: 0x33d8
// Size: 0x44
function function_fad9fb74() {
    level.var_7d6b01fb self_revive_visuals::open(self, 0);
    self.var_75b9c25a = 1;
    self thread function_7d92bdfd();
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x9a178aa5, Offset: 0x3428
// Size: 0x238
function function_7d92bdfd() {
    self endon(#"disconnect", #"zombified", #"player_revived", #"bled_out");
    level endon(#"end_game");
    while (self usebuttonpressed()) {
        wait 1;
    }
    if (!isdefined(self.var_75b9c25a)) {
        return;
    }
    self.var_9f1ad8fc = 0;
    while (true) {
        wait 0.1;
        if (!isdefined(self.var_75b9c25a)) {
            continue;
        }
        if (!self function_278fe5df()) {
            continue;
        }
        n_duration = revive_get_revive_time(self);
        self_revive_success = function_dd80c131(n_duration);
        if (self_revive_success) {
            self function_edd56797();
            self notify(#"hash_2c308c99381677bf");
            util::wait_network_frame();
            if (isdefined(level.a_revive_success_perk_func)) {
                foreach (func in level.a_revive_success_perk_func) {
                    self [[ func ]]();
                }
            }
            if (isdefined(self.var_89929aa3)) {
                self zm_audio::create_and_play_dialog("revive", self.var_89929aa3);
            }
            self notify(#"stop_revive_trigger");
            self thread auto_revive(self);
        }
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0xc381750e, Offset: 0x3668
// Size: 0x34
function function_278fe5df() {
    return self usebuttonpressed() && function_e03a3596();
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x452ce9a7, Offset: 0x36a8
// Size: 0x94
function function_e03a3596() {
    if (!isalive(self)) {
        return false;
    }
    if (isdefined(self.var_9f1ad8fc) && self.var_9f1ad8fc) {
        return false;
    }
    if (!isdefined(self.var_75b9c25a)) {
        return false;
    }
    if (isdefined(self.is_zombie) && self.is_zombie) {
        return false;
    }
    if (isdefined(level.intermission) && level.intermission) {
        return false;
    }
    return true;
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x8d48b43, Offset: 0x3748
// Size: 0x154
function function_dd80c131(n_duration) {
    self endoncallback(&function_229606c6, #"player_revived", #"zombified", #"bled_out", #"disconnect");
    level endon(#"end_game");
    var_a0ef9208 = 0;
    b_success = 0;
    while (true) {
        while (self function_278fe5df()) {
            waitframe(1);
            var_a0ef9208 += 0.05;
            level.var_7d6b01fb self_revive_visuals::set_revive_progress(self, var_a0ef9208 / n_duration);
            if (var_a0ef9208 >= n_duration) {
                b_success = 1;
                break;
            }
        }
        if (isdefined(b_success) && b_success) {
            return b_success;
        } else {
            level.var_7d6b01fb self_revive_visuals::set_revive_progress(self, 0);
            var_a0ef9208 = 0;
        }
        waitframe(1);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0xe368d097, Offset: 0x38a8
// Size: 0x3c
function function_229606c6(var_e34146dc) {
    if (var_e34146dc != "disconnect") {
        level.var_7d6b01fb self_revive_visuals::set_revive_progress(self, 0);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0xcdf223bb, Offset: 0x38f0
// Size: 0x17c
function revive_trigger_spawn() {
    if (isdefined(level.var_210e347b) && level.var_210e347b) {
        return;
    }
    radius = getdvarint(#"revive_trigger_radius", 75);
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
// Params 1, eflags: 0x0
// Checksum 0x616001ae, Offset: 0x3a78
// Size: 0x64a
function revive_trigger_think(t_secondary) {
    self endon(#"disconnect", #"zombified", #"stop_revive_trigger", #"death");
    level endon(#"end_game");
    while (true) {
        wait 0.1;
        if (isdefined(t_secondary)) {
            t_revive = t_secondary;
        } else {
            t_revive = self.revivetrigger;
        }
        t_revive sethintstring("");
        for (i = 0; i < level.players.size; i++) {
            n_depth = 0;
            n_depth = self depthinwater();
            if (isdefined(t_secondary)) {
                if (level.players[i] can_revive(self, 1, 1) && level.players[i] istouching(t_revive) || n_depth > 20) {
                    t_revive setrevivehintstring(#"hash_12272c5573321d90", self.team);
                    break;
                }
                continue;
            }
            if (level.players[i] can_revive_via_override(self) || level.players[i] can_revive(self) || n_depth > 20) {
                t_revive setrevivehintstring(#"hash_12272c5573321d90", self.team);
                break;
            }
        }
        for (i = 0; i < level.players.size; i++) {
            e_reviver = level.players[i];
            if (self == e_reviver && !isdefined(self.var_e916a9ce) || !e_reviver is_reviving(self, t_secondary)) {
                continue;
            }
            if (isdefined(self.var_471b53c6) && e_reviver != self.var_471b53c6) {
                continue;
            }
            if (isdefined(level.var_8b7dbdf3) && level.var_8b7dbdf3 && e_reviver zm_loadout::has_hero_weapon()) {
                w_reviver = undefined;
                w_revive_tool = undefined;
            } else if (!isdefined(self.var_e916a9ce) && (!isdefined(e_reviver.s_revive_override_used) || e_reviver.s_revive_override_used.b_use_revive_tool)) {
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
            if (isdefined(self.revivevox)) {
                e_reviver thread zm_audio::create_and_play_dialog("revive", self.revivevox);
            }
            b_revive_successful = e_reviver revive_do_revive(self, w_reviver, w_revive_tool, t_secondary);
            e_reviver notify(#"revive_done");
            if (b_revive_successful) {
                if (!isdefined(self.var_e916a9ce)) {
                    self thread function_f2438248(e_reviver);
                }
                if (isdefined(level.a_revive_success_perk_func)) {
                    foreach (func in level.a_revive_success_perk_func) {
                        self [[ func ]]();
                    }
                }
                self thread revive_success(e_reviver);
                level.var_70cb425c zm_laststand_client::close(self);
                level.var_7d6b01fb self_revive_visuals::close(self);
                self notify(#"stop_revive_trigger");
                return;
            }
            e_reviver stopsounds();
        }
    }
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x1e754cac, Offset: 0x40d0
// Size: 0x6c
function function_f2438248(e_reviver) {
    self endon(#"death");
    if (isdefined(e_reviver.var_8e64fac1)) {
        do {
            waitframe(1);
        } while (e_reviver.isspeaking);
        self thread zm_audio::create_and_play_dialog("revive", e_reviver.var_8e64fac1);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 2, eflags: 0x0
// Checksum 0xb10afa26, Offset: 0x4148
// Size: 0x8c
function revive_give_back_weapons_wait(e_reviver, e_revivee) {
    e_revivee endon(#"disconnect", #"zombified", #"stop_revive_trigger", #"death");
    level endon(#"end_game");
    e_reviver waittill(#"revive_done");
}

// Namespace zm_laststand/zm_laststand
// Params 3, eflags: 0x0
// Checksum 0x640c8106, Offset: 0x41e0
// Size: 0x4c
function revive_give_back_weapons_when_done(w_reviver, w_revive_tool, e_revivee) {
    revive_give_back_weapons_wait(self, e_revivee);
    self revive_give_back_weapons(w_reviver, w_revive_tool);
}

// Namespace zm_laststand/zm_laststand
// Params 2, eflags: 0x0
// Checksum 0x8f552db2, Offset: 0x4238
// Size: 0x134
function revive_give_back_weapons(w_reviver, w_revive_tool) {
    self takeweapon(w_revive_tool);
    self enableweaponcycling();
    self enableoffhandweapons();
    self enableweaponswitchhero();
    if (self laststand::player_is_in_laststand()) {
        return;
    }
    if (w_reviver != level.weaponnone && !zm_loadout::is_placeable_mine(w_reviver) && !zm_equipment::is_equipment(w_reviver) && !w_reviver.isflourishweapon && self hasweapon(w_reviver)) {
        self zm_weapons::switch_back_primary_weapon(w_reviver);
        return;
    }
    self zm_weapons::switch_back_primary_weapon();
}

// Namespace zm_laststand/zm_laststand
// Params 3, eflags: 0x0
// Checksum 0x900709d, Offset: 0x4378
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
    if (isdefined(self.is_zombie) && self.is_zombie) {
        return false;
    }
    if (self zm_loadout::has_powerup_weapon()) {
        return false;
    }
    if (!(isdefined(level.var_8b7dbdf3) && level.var_8b7dbdf3) && self zm_loadout::has_hero_weapon()) {
        return false;
    }
    if (isdefined(level.can_revive_use_depthinwater_test) && level.can_revive_use_depthinwater_test && e_revivee depthinwater() > 10) {
        return true;
    }
    if (isdefined(level.can_revive) && ![[ level.can_revive ]](e_revivee)) {
        return false;
    }
    if (isdefined(level.var_ae6ced2b) && ![[ level.var_ae6ced2b ]](e_revivee)) {
        return false;
    }
    if (!ignore_sight_checks && isdefined(level.revive_trigger_should_ignore_sight_checks)) {
        ignore_sight_checks = [[ level.revive_trigger_should_ignore_sight_checks ]](self);
        if (ignore_sight_checks && isdefined(e_revivee.revivetrigger.beingrevived) && e_revivee.revivetrigger.beingrevived) {
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
    return true;
}

// Namespace zm_laststand/zm_laststand
// Params 2, eflags: 0x0
// Checksum 0x69040535, Offset: 0x46a8
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
// Checksum 0xa703d5ee, Offset: 0x4770
// Size: 0x18
function is_reviving_any() {
    return isdefined(self.is_reviving_any) && self.is_reviving_any;
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x9e9462ab, Offset: 0x4790
// Size: 0x6e
function revive_get_revive_time(e_revivee) {
    revivetime = 3;
    if (self hasperk(#"specialty_quickrevive")) {
        revivetime = 2;
    }
    if (isdefined(self.get_revive_time)) {
        revivetime = self [[ self.get_revive_time ]](e_revivee);
    }
    return revivetime;
}

// Namespace zm_laststand/zm_laststand
// Params 4, eflags: 0x0
// Checksum 0xc1f59e5c, Offset: 0x4808
// Size: 0x420
function revive_do_revive(e_revivee, w_reviver, w_revive_tool, t_secondary) {
    assert(self is_reviving(e_revivee, t_secondary));
    revivetime = self revive_get_revive_time(e_revivee);
    if (!isdefined(e_revivee.var_cd2ba39d)) {
        e_revivee.var_cd2ba39d = 0;
    }
    revived = 0;
    e_revivee notify(#"player_being_revived");
    e_revivee.revivetrigger.beingrevived = 1;
    e_revivee thread laststand::revive_hud_show_n_fade(#"hash_12e2c5e29f8ce6ad", 3, self);
    e_revivee.revivetrigger sethintstring("");
    if (isplayer(e_revivee)) {
        e_revivee startrevive(self);
        e_revivee.var_9f1ad8fc = 1;
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
    while (self is_reviving(e_revivee, t_secondary)) {
        waitframe(1);
        e_revivee.var_cd2ba39d += 0.05;
        level.var_70cb425c zm_laststand_client::set_revive_progress(e_revivee, e_revivee.var_cd2ba39d / revivetime);
        if (isdefined(e_revivee.revivetrigger.auto_revive) && e_revivee.revivetrigger.auto_revive) {
            break;
        }
        if (e_revivee.var_cd2ba39d >= revivetime) {
            revived = 1;
            break;
        }
    }
    if (!(isdefined(e_revivee.revivetrigger.auto_revive) && e_revivee.revivetrigger.auto_revive) && !revived) {
        if (isplayer(e_revivee)) {
            e_revivee stoprevive(self);
        }
    }
    e_revivee.revivetrigger sethintstring(#"hash_12272c5573321d90");
    e_revivee.revivetrigger.beingrevived = 0;
    self notify(#"do_revive_ended_normally");
    self.is_reviving_any--;
    self.revive_progress = 0;
    e_revivee.var_9f1ad8fc = 0;
    if (!revived) {
        e_revivee thread checkforbleedout(self);
        e_revivee thread function_5dcb1f13(revivetime);
        e_revivee thread function_ba124b1a();
    } else {
        e_revivee.var_cd2ba39d = 0;
        level.var_70cb425c zm_laststand_client::set_revive_progress(e_revivee, 0);
    }
    return revived;
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x99b064f4, Offset: 0x4c30
// Size: 0xd6
function function_5dcb1f13(revivetime) {
    self endon(#"player_being_revived", #"player_revived", #"disconnect", #"bled_out");
    while (!(isdefined(self.var_9f1ad8fc) && self.var_9f1ad8fc) && isdefined(self.var_cd2ba39d) && self.var_cd2ba39d >= 0) {
        self.var_cd2ba39d -= 0.05;
        level.var_70cb425c zm_laststand_client::set_revive_progress(self, self.var_cd2ba39d / revivetime);
        waitframe(1);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x72ed8e10, Offset: 0x4d10
// Size: 0x62
function function_ba124b1a() {
    self endon(#"player_being_revived", #"player_revived", #"disconnect");
    self waittill(#"bled_out");
    if (isdefined(self.var_cd2ba39d)) {
        self.var_cd2ba39d = 0;
    }
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x49767e51, Offset: 0x4d80
// Size: 0xa0
function checkforbleedout(player) {
    self endon(#"player_revived", #"disconnect");
    player endon(#"disconnect");
    if (isdefined(player) && zm_utility::is_classic()) {
        if (!isdefined(player.failed_revives)) {
            player.failed_revives = 0;
        }
        player.failed_revives++;
        player notify(#"player_failed_revive");
    }
}

// Namespace zm_laststand/zm_laststand
// Params 2, eflags: 0x0
// Checksum 0x7392c23f, Offset: 0x4e28
// Size: 0x144
function auto_revive(reviver, b_track_stats = 1) {
    level endon(#"end_game");
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
    level.var_70cb425c zm_laststand_client::close(self);
    level.var_7d6b01fb self_revive_visuals::close(self);
    self notify(#"stop_revive_trigger");
    self revive_internal(reviver, b_track_stats);
}

// Namespace zm_laststand/zm_laststand
// Params 2, eflags: 0x0
// Checksum 0x57f275c1, Offset: 0x4f78
// Size: 0xf4
function revive_success(reviver, b_track_stats = 1) {
    level endon(#"end_game");
    if (!isplayer(self)) {
        self notify(#"player_revived", {#reviver:reviver});
        return;
    }
    if (isdefined(b_track_stats) && b_track_stats) {
        reviver xp_revive_once_per_round(self);
        if (!(isdefined(level.isresetting_grief) && level.isresetting_grief)) {
            reviver thread check_for_sacrifice();
        }
    }
    self revive_internal(reviver, b_track_stats);
}

// Namespace zm_laststand/zm_laststand
// Params 2, eflags: 0x4
// Checksum 0x62e76649, Offset: 0x5078
// Size: 0x394
function private revive_internal(reviver, b_track_stats) {
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
    self allowjump(1);
    if (isplayer(reviver)) {
        reviver notify(#"player_did_a_revive", {#revived_player:self});
        if (!(isdefined(level.isresetting_grief) && level.isresetting_grief) && isdefined(b_track_stats) && b_track_stats) {
            reviver.revives++;
            reviver zm_stats::increment_client_stat("revives");
            reviver zm_stats::increment_player_stat("revives");
            reviver zm_stats::function_ed968b89("revives");
            self recordplayerrevivezombies(reviver);
            demo::bookmark(#"zm_player_revived", gettime(), reviver, self);
            potm::bookmark(#"zm_player_revived", gettime(), reviver, self);
        }
    }
    self notify(#"player_revived", {#reviver:reviver, #var_5d981de2:self.var_471b53c6});
    s_params = spawnstruct();
    s_params.e_revivee = self;
    s_params.e_reviver = reviver;
    s_params.var_471b53c6 = self.var_471b53c6;
    self callback::callback(#"on_player_revived", s_params);
    waitframe(1);
    self thread laststand_enable_player_weapons();
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x7123f4d1, Offset: 0x5418
// Size: 0xa2
function xp_revive_once_per_round(player_being_revived) {
    if (!isdefined(self.number_revives_per_round)) {
        self.number_revives_per_round = [];
    }
    if (!isdefined(self.number_revives_per_round[player_being_revived.characterindex])) {
        self.number_revives_per_round[player_being_revived.characterindex] = 0;
    }
    if (self.number_revives_per_round[player_being_revived.characterindex] == 0) {
        scoreevents::processscoreevent("revive_an_ally", self);
    }
    self.number_revives_per_round[player_being_revived.characterindex]++;
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x59692225, Offset: 0x54c8
// Size: 0x8c
function revive_force_revive(reviver) {
    assert(isdefined(self));
    assert(isplayer(self));
    assert(self laststand::player_is_in_laststand());
    self thread revive_success(reviver);
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0xce29c831, Offset: 0x5560
// Size: 0x260
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
                    if (isdefined(level.hide_revive_message) && level.hide_revive_message) {
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
// Params 0, eflags: 0x0
// Checksum 0x25660b96, Offset: 0x57c8
// Size: 0x9c
function check_for_sacrifice() {
    self endon(#"death", #"sacrifice_denied");
    self util::delay_notify("sacrifice_denied", 1);
    self waittill(#"player_downed");
    self zm_stats::increment_client_stat("sacrifices");
    self zm_stats::increment_player_stat("sacrifices");
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0xb6a331b6, Offset: 0x5870
// Size: 0xbc
function check_for_failed_revive(e_revivee) {
    self notify(#"checking_for_failed_revive");
    self endon(#"disconnect", #"checking_for_failed_revive");
    e_revivee endon(#"disconnect", #"player_revived");
    e_revivee waittill(#"bled_out");
    self zm_stats::increment_client_stat("failed_revives");
    self zm_stats::increment_player_stat("failed_revives");
}

// Namespace zm_laststand/zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x2dce654c, Offset: 0x5938
// Size: 0xcc
function add_weighted_down() {
    if (!level.curr_gametype_affects_rank) {
        return;
    }
    weighted_down = 1000;
    if (level.round_number > 0) {
        weighted_down = int(1000 / ceil(level.round_number / 5));
    }
    if (!level.onlinegame || isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    self stats::function_b48aa4e(#"weighted_downs", weighted_down);
}

// Namespace zm_laststand/zm_laststand
// Params 3, eflags: 0x0
// Checksum 0xdae7c77e, Offset: 0x5a10
// Size: 0xda
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
// Checksum 0xa60c96bc, Offset: 0x5af8
// Size: 0x34
function deregister_revive_override(s_revive_override) {
    if (isdefined(self.a_s_revive_overrides)) {
        arrayremovevalue(self.a_s_revive_overrides, s_revive_override);
    }
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x21c74b0, Offset: 0x5b38
// Size: 0x6c
function can_revive_via_override(e_revivee) {
    if (isdefined(self.a_s_revive_overrides)) {
        for (i = 0; i < self.a_s_revive_overrides.size; i++) {
            if (self [[ self.a_s_revive_overrides[i].func_can_revive ]](e_revivee)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_laststand/zm_laststand
// Params 1, eflags: 0x0
// Checksum 0xd5ee078b, Offset: 0x5bb0
// Size: 0x8c
function is_reviving_via_override(e_revivee) {
    if (isdefined(self.a_s_revive_overrides)) {
        for (i = 0; i < self.a_s_revive_overrides.size; i++) {
            if (self [[ self.a_s_revive_overrides[i].func_is_reviving ]](e_revivee)) {
                self.s_revive_override_used = self.a_s_revive_overrides[i];
                return true;
            }
        }
    }
    self.s_revive_override_used = undefined;
    return false;
}

