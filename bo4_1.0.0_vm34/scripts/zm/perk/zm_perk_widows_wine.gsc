#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;

#namespace zm_perk_widows_wine;

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x2
// Checksum 0xd3c2b468, Offset: 0x298
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_widows_wine", &__init__, undefined, undefined);
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0x4fc70ed5, Offset: 0x2e0
// Size: 0xa4
function __init__() {
    enable_widows_wine_perk_for_level();
    zm_utility::register_slowdown(#"hash_54016f8b03c9745e", 0.7, 12);
    zm_utility::register_slowdown(#"hash_6b28a9e80349ad7e", 0.8, 6);
    zm_utility::register_slowdown(#"hash_fa4899571ae8dbd", 0.85, 3);
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0x700180ab, Offset: 0x390
// Size: 0x1e4
function enable_widows_wine_perk_for_level() {
    zm_perks::register_perk_basic_info(#"specialty_widowswine", "perk_widows_wine", 3000, #"zombie/perk_widowswine", getweapon("zombie_perk_bottle_widows_wine"), getweapon("zombie_perk_totem_winters_wail"), #"zmperkswidowswail");
    zm_perks::register_perk_precache_func(#"specialty_widowswine", &widows_wine_precache);
    zm_perks::register_perk_clientfields(#"specialty_widowswine", &widows_wine_register_clientfield, &widows_wine_set_clientfield);
    zm_perks::register_perk_machine(#"specialty_widowswine", &widows_wine_perk_machine_setup);
    zm_perks::register_perk_host_migration_params(#"specialty_widowswine", "vending_widowswine", "widow_light");
    zm_perks::register_perk_threads(#"specialty_widowswine", &widows_wine_perk_activate, &widows_wine_perk_lost, &reset_charges);
    if (isdefined(level.custom_widows_wine_perk_threads) && level.custom_widows_wine_perk_threads) {
        level thread [[ level.custom_widows_wine_perk_threads ]]();
    }
    init_widows_wine();
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0xcd6f607d, Offset: 0x580
// Size: 0x106
function widows_wine_precache() {
    if (isdefined(level.var_5eedae98)) {
        [[ level.var_5eedae98 ]]();
        return;
    }
    level._effect[#"widow_light"] = "zombie/fx_perk_widows_wine_zmb";
    level.machine_assets[#"specialty_widowswine"] = spawnstruct();
    level.machine_assets[#"specialty_widowswine"].weapon = getweapon("zombie_perk_bottle_widows_wine");
    level.machine_assets[#"specialty_widowswine"].off_model = "p7_zm_vending_widows_wine";
    level.machine_assets[#"specialty_widowswine"].on_model = "p7_zm_vending_widows_wine";
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0x1902cc64, Offset: 0x690
// Size: 0xf4
function widows_wine_register_clientfield() {
    clientfield::register("clientuimodel", "hudItems.perks.widows_wine", 1, 2, "int");
    clientfield::register("actor", "winters_wail_freeze", 1, 1, "int");
    clientfield::register("vehicle", "winters_wail_freeze", 1, 1, "int");
    clientfield::register("allplayers", "winters_wail_explosion", 1, 1, "counter");
    clientfield::register("allplayers", "winters_wail_slow_field", 1, 1, "int");
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 1, eflags: 0x0
// Checksum 0x5a7dcdfe, Offset: 0x790
// Size: 0x2c
function widows_wine_set_clientfield(state) {
    self clientfield::set_player_uimodel("hudItems.perks.widows_wine", state);
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 4, eflags: 0x0
// Checksum 0x45f7d9d0, Offset: 0x7c8
// Size: 0xb6
function widows_wine_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
    use_trigger.script_sound = "mus_perks_widow_jingle";
    use_trigger.script_string = "widowswine_perk";
    use_trigger.script_label = "mus_perks_widow_sting";
    use_trigger.target = "vending_widowswine";
    perk_machine.script_string = "widowswine_perk";
    perk_machine.targetname = "vending_widowswine";
    if (isdefined(bump_trigger)) {
        bump_trigger.script_string = "widowswine_perk";
    }
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0x45b564f, Offset: 0x888
// Size: 0x24
function init_widows_wine() {
    zm_perks::register_perk_damage_override_func(&widows_wine_damage_callback);
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0x35c3b071, Offset: 0x8b8
// Size: 0x74
function widows_wine_perk_activate() {
    self.var_dbaf669e = zm_perks::function_ec1dff78(#"specialty_widowswine");
    if (!isdefined(self.var_db280fb0)) {
        self.var_db280fb0 = 100;
        self.var_380695d = self function_c1526966();
        self thread function_a17538a8();
    }
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0xb71e6e2e, Offset: 0x938
// Size: 0x33c
function widows_wine_contact_explosion() {
    self endon(#"disconnect");
    level endon(#"end_game");
    self clientfield::increment("winters_wail_explosion");
    a_ai_targets = self getenemiesinradius(self.origin, 256);
    a_ai_targets = arraysortclosest(a_ai_targets, self.origin);
    foreach (ai_target in a_ai_targets) {
        b_freeze = 0;
        switch (ai_target.var_29ed62b2) {
        case #"heavy":
            var_99943f74 = #"hash_6b28a9e80349ad7e";
            var_932ae9e2 = 6;
            break;
        case #"miniboss":
            var_99943f74 = #"hash_fa4899571ae8dbd";
            var_932ae9e2 = 3;
            break;
        case #"boss":
            continue;
        default:
            var_99943f74 = #"hash_54016f8b03c9745e";
            var_932ae9e2 = 12;
            b_freeze = 1;
            break;
        }
        n_dist_sq = distancesquared(self.origin, ai_target.origin);
        if (b_freeze && n_dist_sq <= 10000) {
            ai_target thread function_4226e4c3(self);
        } else {
            ai_target thread widows_wine_slow_zombie(self, var_99943f74, var_932ae9e2);
        }
        waitframe(1);
    }
    if (!self hasperk(#"specialty_widowswine")) {
        return;
    }
    self.var_db280fb0 -= self function_7daedcea();
    self.var_380695d -= 1;
    self zm_perks::function_2b57e880(self.var_dbaf669e, self.var_db280fb0 / 100);
    self zm_perks::function_69e1eb5d(self.var_dbaf669e, self.var_380695d);
    if (self hasperk(#"specialty_mod_widowswine")) {
        self thread function_59179da9();
    }
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0xf34ac177, Offset: 0xc80
// Size: 0x284
function function_59179da9() {
    self notify(#"start_slow_field");
    self endoncallback(&function_5d8b76c1, #"disconnect", #"player_downed", #"start_slow_field");
    level endoncallback(&function_5d8b76c1, #"end_game");
    n_end_time = gettime() + int(5 * 1000);
    self clientfield::set("winters_wail_slow_field", 1);
    while (gettime() < n_end_time) {
        a_ai = self getenemiesinradius(self.origin, 256);
        foreach (ai in a_ai) {
            switch (ai.var_29ed62b2) {
            case #"heavy":
                var_99943f74 = #"hash_6b28a9e80349ad7e";
                var_932ae9e2 = 6;
                break;
            case #"miniboss":
                var_99943f74 = #"hash_fa4899571ae8dbd";
                var_932ae9e2 = 3;
                break;
            case #"boss":
                continue;
            default:
                var_99943f74 = #"hash_54016f8b03c9745e";
                var_932ae9e2 = 12;
                break;
            }
            ai thread widows_wine_slow_zombie(self, var_99943f74, var_932ae9e2);
        }
        wait 0.1;
    }
    self thread function_5d8b76c1();
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 1, eflags: 0x0
// Checksum 0xc315be82, Offset: 0xf10
// Size: 0xa4
function function_5d8b76c1(var_e34146dc) {
    if (isdefined(var_e34146dc) && (var_e34146dc == "disconnect" || var_e34146dc == "start_slow_field")) {
        return;
    }
    if (isplayer(self)) {
        self clientfield::set("winters_wail_slow_field", 0);
        return;
    }
    array::thread_all(level.players, &clientfield::set, "winters_wail_slow_field", 0);
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 15, eflags: 0x0
// Checksum 0x1c172abd, Offset: 0xfc0
// Size: 0xdc
function widows_wine_vehicle_damage_response(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(weapon) && weapon == level.w_widows_wine_grenade && !(isdefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon)) {
        self thread widows_wine_vehicle_behavior(eattacker, weapon);
        return 0;
    }
    return idamage;
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 10, eflags: 0x0
// Checksum 0x9c7fab3f, Offset: 0x10a8
// Size: 0x12a
function widows_wine_damage_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime) {
    if (self hasperk(#"specialty_widowswine") && self has_charge() && !self bgb::is_enabled(#"zm_bgb_burned_out")) {
        if (smeansofdeath == "MOD_MELEE" && isai(eattacker) || smeansofdeath == "MOD_EXPLOSIVE" && isvehicle(eattacker)) {
            self thread widows_wine_contact_explosion();
            return idamage;
        }
    }
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 1, eflags: 0x0
// Checksum 0x8f3ebcb0, Offset: 0x11e0
// Size: 0x184
function function_4226e4c3(e_player) {
    self notify(#"widows_wine_cocoon");
    self endon(#"widows_wine_cocoon");
    if (isdefined(self.kill_on_wine_coccon) && self.kill_on_wine_coccon) {
        self kill();
    }
    if (!(isdefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon)) {
        self.b_widows_wine_cocoon = 1;
        self.e_widows_wine_player = e_player;
        self zm_utility::freeze_ai();
        self.var_3780023 = 1;
        self clientfield::set("winters_wail_freeze", 1);
        if (isdefined(e_player)) {
            e_player zm_score::add_to_player_score(20);
        }
    }
    self waittilltimeout(16, #"death");
    if (!isdefined(self)) {
        return;
    }
    self zm_utility::function_31a2964e();
    self.b_widows_wine_cocoon = undefined;
    self.var_3780023 = 0;
    if (!(isdefined(self.b_widows_wine_slow) && self.b_widows_wine_slow)) {
        self clientfield::set("winters_wail_freeze", 0);
    }
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 3, eflags: 0x0
// Checksum 0x60f6c1b7, Offset: 0x1370
// Size: 0x154
function widows_wine_slow_zombie(e_player, var_99943f74, var_932ae9e2) {
    self notify(#"widows_wine_slow");
    self endon(#"widows_wine_slow");
    if (isdefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon) {
        self thread function_4226e4c3(e_player);
        return;
    }
    if (!(isdefined(self.b_widows_wine_slow) && self.b_widows_wine_slow)) {
        self.b_widows_wine_slow = 1;
        self clientfield::set("winters_wail_freeze", 1);
        if (isdefined(e_player)) {
            e_player zm_score::add_to_player_score(10);
        }
    }
    self thread zm_utility::function_447d3917(var_99943f74);
    self waittilltimeout(var_932ae9e2, #"death");
    if (!isdefined(self)) {
        return;
    }
    self.b_widows_wine_slow = undefined;
    if (!(isdefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon)) {
        self clientfield::set("winters_wail_freeze", 0);
    }
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 2, eflags: 0x0
// Checksum 0x881dbace, Offset: 0x14d0
// Size: 0x114
function widows_wine_vehicle_behavior(attacker, weapon) {
    self endon(#"death");
    self.b_widows_wine_cocoon = 1;
    if (isdefined(self.archetype)) {
        if (self.archetype == "raps") {
            self clientfield::set("winters_wail_freeze", 1);
            self._override_raps_combat_speed = 5;
            wait 6;
            self dodamage(self.health + 1000, self.origin, attacker, undefined, "none", "MOD_EXPLOSIVE", 0, weapon);
            return;
        }
        if (self.archetype == "parasite") {
            waitframe(1);
            self dodamage(self.maxhealth, self.origin);
        }
    }
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 3, eflags: 0x0
// Checksum 0x4eb2e6e6, Offset: 0x15f0
// Size: 0x86
function widows_wine_perk_lost(b_pause, str_perk, str_result) {
    self notify(#"stop_widows_wine");
    self endon(#"death");
    self zm_perks::function_2b57e880(self.var_dbaf669e, 0);
    self zm_perks::function_69e1eb5d(self.var_dbaf669e, 0);
    self.var_dbaf669e = undefined;
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0x276f45e8, Offset: 0x1680
// Size: 0x3a
function has_charge() {
    if (isdefined(self.var_db280fb0) && self.var_db280fb0 >= self function_7daedcea()) {
        return true;
    }
    return false;
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0xec735a7b, Offset: 0x16c8
// Size: 0x30
function function_c1526966() {
    if (self hasperk(#"specialty_mod_widowswine")) {
        return 3;
    }
    return 2;
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0xdbc56219, Offset: 0x1700
// Size: 0x30
function function_7daedcea() {
    n_total_charges = self function_c1526966();
    return 100 / n_total_charges;
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0x6406025d, Offset: 0x1738
// Size: 0x90
function function_a17538a8() {
    self endon(#"disconnect");
    while (true) {
        wait 1;
        self.var_db280fb0 += 0.16;
        self.var_db280fb0 = math::clamp(self.var_db280fb0, 0, 100);
        self function_ccd0ed8f();
    }
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0x3254e148, Offset: 0x17d0
// Size: 0x114
function function_ccd0ed8f() {
    var_35f93aa0 = self function_7daedcea();
    self.var_380695d = int(floor(self.var_db280fb0 / var_35f93aa0));
    if (self hasperk(#"specialty_widowswine")) {
        self zm_perks::function_69e1eb5d(self.var_dbaf669e, self.var_380695d);
    }
    n_progress = (self.var_db280fb0 - self.var_380695d * var_35f93aa0) / var_35f93aa0;
    if (self hasperk(#"specialty_widowswine")) {
        self zm_perks::function_2b57e880(self.var_dbaf669e, n_progress);
    }
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0x25e9b167, Offset: 0x18f0
// Size: 0x24
function reset_charges() {
    self.var_db280fb0 = 100;
    self function_ccd0ed8f();
}

