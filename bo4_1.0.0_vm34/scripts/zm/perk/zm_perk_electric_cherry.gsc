#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\trials\zm_trial_restrict_loadout;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_net;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace zm_perk_electric_cherry;

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x2
// Checksum 0xad4ea153, Offset: 0x320
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_electric_cherry", &__init__, undefined, undefined);
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x8c7b75a5, Offset: 0x368
// Size: 0x14
function __init__() {
    enable_electric_cherry_perk_for_level();
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0xf8c7c915, Offset: 0x388
// Size: 0x1d4
function enable_electric_cherry_perk_for_level() {
    zm_perks::register_perk_basic_info(#"specialty_electriccherry", "perk_electric_cherry", 3000, #"zombie/perk_electric_cherry", getweapon("zombie_perk_bottle_cherry"), getweapon("zombie_perk_totem_electric_burst"), #"zmperkselectricburst");
    zm_perks::register_perk_precache_func(#"specialty_electriccherry", &electric_cherry_precache);
    zm_perks::register_perk_clientfields(#"specialty_electriccherry", &electric_cherry_register_clientfield, &electric_cherry_set_clientfield);
    zm_perks::register_perk_machine(#"specialty_electriccherry", &electric_cherry_perk_machine_setup);
    zm_perks::register_perk_host_migration_params(#"specialty_electriccherry", "vending_electriccherry", "electric_cherry_light");
    zm_perks::register_perk_threads(#"specialty_electriccherry", &electric_cherry_reload_attack, &electric_cherry_perk_lost);
    if (isdefined(level.custom_electric_cherry_perk_threads) && level.custom_electric_cherry_perk_threads) {
        level thread [[ level.custom_electric_cherry_perk_threads ]]();
    }
    init_electric_cherry();
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x4a39ea85, Offset: 0x568
// Size: 0x10e
function electric_cherry_precache() {
    if (isdefined(level.var_ad083728)) {
        [[ level.var_ad083728 ]]();
        return;
    }
    level._effect[#"electric_cherry_light"] = #"hash_1442db17b83460ad";
    level.machine_assets[#"specialty_electriccherry"] = spawnstruct();
    level.machine_assets[#"specialty_electriccherry"].weapon = getweapon("zombie_perk_bottle_cherry");
    level.machine_assets[#"specialty_electriccherry"].off_model = "p7_zm_vending_nuke";
    level.machine_assets[#"specialty_electriccherry"].on_model = "p7_zm_vending_nuke";
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0xdfd56ded, Offset: 0x680
// Size: 0x34
function electric_cherry_register_clientfield() {
    clientfield::register("clientuimodel", "hudItems.perks.electric_cherry", 1, 2, "int");
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 1, eflags: 0x0
// Checksum 0x716cae1b, Offset: 0x6c0
// Size: 0x2c
function electric_cherry_set_clientfield(state) {
    self clientfield::set_player_uimodel("hudItems.perks.electric_cherry", state);
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 4, eflags: 0x0
// Checksum 0xae8270e5, Offset: 0x6f8
// Size: 0xb6
function electric_cherry_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
    use_trigger.script_sound = "mus_perks_stamin_jingle";
    use_trigger.script_string = "marathon_perk";
    use_trigger.script_label = "mus_perks_stamin_sting";
    use_trigger.target = "vending_marathon";
    perk_machine.script_string = "marathon_perk";
    perk_machine.targetname = "vending_marathon";
    if (isdefined(bump_trigger)) {
        bump_trigger.script_string = "marathon_perk";
    }
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x9451f9de, Offset: 0x7b8
// Size: 0x164
function init_electric_cherry() {
    level._effect[#"electric_cherry_explode"] = #"hash_413a313438a3a4e1";
    level.custom_laststand_func = &electric_cherry_laststand;
    zombie_utility::set_zombie_var(#"tesla_head_gib_chance", 50);
    clientfield::register("allplayers", "electric_cherry_reload_fx", 1, 2, "int");
    clientfield::register("actor", "tesla_death_fx", 1, 1, "int");
    clientfield::register("vehicle", "tesla_death_fx_veh", 1, 1, "int");
    clientfield::register("actor", "tesla_shock_eyes_fx", 1, 1, "int");
    clientfield::register("vehicle", "tesla_shock_eyes_fx_veh", 1, 1, "int");
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0xf2c4f4c6, Offset: 0x928
// Size: 0x268
function function_1867899c() {
    init_electric_cherry();
    while (true) {
        machine = getentarray("vendingelectric_cherry", "targetname");
        machine_triggers = getentarray("vending_electriccherry", "target");
        for (i = 0; i < machine.size; i++) {
            machine[i] setmodel("p7_zm_vending_nuke");
        }
        level thread zm_perks::do_initial_power_off_callback(machine, "electriccherry");
        array::thread_all(machine_triggers, &zm_perks::set_power_on, 0);
        level waittill(#"hash_42d507b7c2393cca");
        for (i = 0; i < machine.size; i++) {
            machine[i] setmodel("p7_zm_vending_nuke");
            machine[i] vibrate((0, -100, 0), 0.3, 0.4, 3);
            machine[i] playsound(#"zmb_perks_power_on");
            machine[i] thread zm_perks::perk_fx("electriccherry");
            machine[i] thread zm_perks::play_loop_on_machine();
        }
        level notify(#"hash_48f16fc02f9369b9");
        array::thread_all(machine_triggers, &zm_perks::set_power_on, 1);
        level waittill(#"hash_491dd93f072b6bbc");
        array::thread_all(machine_triggers, &zm_perks::turn_perk_off);
    }
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x6ab382d, Offset: 0xb98
// Size: 0xf0
function electric_cherry_host_migration_func() {
    a_electric_cherry_perk_machines = getentarray("vending_electriccherry", "targetname");
    foreach (perk_machine in a_electric_cherry_perk_machines) {
        if (isdefined(perk_machine.model) && perk_machine.model == "p7_zm_vending_nuke") {
            perk_machine zm_perks::perk_fx(undefined, 1);
            perk_machine thread zm_perks::perk_fx("electriccherry");
        }
    }
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0xb68480a0, Offset: 0xc90
// Size: 0x26e
function electric_cherry_laststand() {
    visionsetlaststand("zombie_last_stand", 1);
    if (isdefined(self)) {
        playfx(level._effect[#"electric_cherry_explode"], self.origin);
        self playsound(#"hash_75ba32e48680203a");
        self notify(#"electric_cherry_start");
        waitframe(1);
        a_zombies = zombie_utility::get_round_enemy_array();
        a_zombies = util::get_array_of_closest(self.origin, a_zombies, undefined, undefined, 500);
        for (i = 0; i < a_zombies.size; i++) {
            if (isalive(self) && isalive(a_zombies[i]) && !zm_trial_restrict_loadout::is_active()) {
                if (a_zombies[i].health <= 1000) {
                    a_zombies[i] thread electric_cherry_death_fx();
                    if (isdefined(self.var_5d79e160)) {
                        self.var_5d79e160++;
                    }
                    self zm_score::add_to_player_score(40);
                } else {
                    a_zombies[i] thread electric_cherry_stun();
                    a_zombies[i] thread electric_cherry_shock_fx();
                }
                wait 0.1;
                if (isalive(self) && isalive(a_zombies[i])) {
                    a_zombies[i] dodamage(1000, self.origin, self, self, "none");
                }
            }
        }
        self notify(#"electric_cherry_end");
    }
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0xde3a4804, Offset: 0xf08
// Size: 0xec
function electric_cherry_death_fx() {
    self endon(#"death");
    if (!(isdefined(self.head_gibbed) && self.head_gibbed)) {
        if (isvehicle(self)) {
            self clientfield::set("tesla_shock_eyes_fx_veh", 1);
        } else {
            self clientfield::set("tesla_shock_eyes_fx", 1);
        }
        return;
    }
    if (isvehicle(self)) {
        self clientfield::set("tesla_death_fx_veh", 1);
        return;
    }
    self clientfield::set("tesla_death_fx", 1);
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x984e11d, Offset: 0x1000
// Size: 0xdc
function electric_cherry_shock_fx() {
    self endon(#"death");
    if (isvehicle(self)) {
        self clientfield::set("tesla_shock_eyes_fx_veh", 1);
    } else {
        self clientfield::set("tesla_shock_eyes_fx", 1);
    }
    self waittill(#"stun_fx_end");
    if (isvehicle(self)) {
        self clientfield::set("tesla_shock_eyes_fx_veh", 0);
        return;
    }
    self clientfield::set("tesla_shock_eyes_fx", 0);
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0xfc8454af, Offset: 0x10e8
// Size: 0x10e
function electric_cherry_stun() {
    self endon(#"death");
    self notify(#"stun_zombie");
    self endon(#"stun_zombie");
    if (self.health <= 0) {
        /#
            iprintln("<dev string:x30>");
        #/
        return;
    }
    self ai::stun();
    self val::set(#"electric_cherry_stun", "ignoreall", 1);
    wait 4;
    if (isdefined(self)) {
        self ai::clear_stun();
        self val::reset(#"electric_cherry_stun", "ignoreall");
        self notify(#"stun_fx_end");
    }
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x37e0f8e0, Offset: 0x1200
// Size: 0x52a
function electric_cherry_reload_attack() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"specialty_electriccherry" + "_stop");
    self endon(#"specialty_electriccherry" + "_take");
    self.wait_on_reload = [];
    self.consecutive_electric_cherry_attacks = 0;
    while (true) {
        self waittill(#"reload_start");
        current_weapon = self getcurrentweapon();
        if (isinarray(self.wait_on_reload, current_weapon)) {
            continue;
        }
        if (current_weapon.isabilityweapon) {
            continue;
        }
        self.wait_on_reload[self.wait_on_reload.size] = current_weapon;
        self.consecutive_electric_cherry_attacks++;
        n_clip_current = 1;
        n_clip_max = 10;
        n_fraction = n_clip_current / n_clip_max;
        perk_radius = math::linear_map(n_fraction, 1, 0, 32, 128);
        perk_dmg = math::linear_map(n_fraction, 1, 0, 1, 1045);
        self thread check_for_reload_complete(current_weapon);
        if (isdefined(self)) {
            switch (self.consecutive_electric_cherry_attacks) {
            case 0:
            case 1:
                n_zombie_limit = undefined;
                break;
            case 2:
                n_zombie_limit = 8;
                break;
            case 3:
                n_zombie_limit = 4;
                break;
            case 4:
                n_zombie_limit = 2;
                break;
            default:
                n_zombie_limit = 0;
                break;
            }
            self thread electric_cherry_cooldown_timer(current_weapon);
            if (isdefined(n_zombie_limit) && n_zombie_limit == 0) {
                continue;
            }
            self thread electric_cherry_reload_fx(n_fraction);
            self notify(#"electric_cherry_start");
            self playsound(#"hash_75ba32e48680203a");
            a_zombies = getaiteamarray(level.zombie_team);
            a_zombies = util::get_array_of_closest(self.origin, a_zombies, undefined, undefined, perk_radius);
            n_zombies_hit = 0;
            for (i = 0; i < a_zombies.size; i++) {
                if (isalive(self) && isalive(a_zombies[i]) && !zm_trial_restrict_loadout::is_active()) {
                    if (isdefined(n_zombie_limit)) {
                        if (n_zombies_hit < n_zombie_limit) {
                            n_zombies_hit++;
                        } else {
                            break;
                        }
                    }
                    if (a_zombies[i].health <= perk_dmg) {
                        a_zombies[i] thread electric_cherry_death_fx();
                        if (isdefined(self.var_5d79e160)) {
                            self.var_5d79e160++;
                        }
                        self zm_score::add_to_player_score(40);
                    } else {
                        if (!isdefined(a_zombies[i].is_brutus)) {
                            a_zombies[i] thread electric_cherry_stun();
                        }
                        a_zombies[i] thread electric_cherry_shock_fx();
                    }
                    wait 0.1;
                    if (isdefined(a_zombies[i]) && isalive(a_zombies[i])) {
                        a_zombies[i] dodamage(perk_dmg, self.origin, self, self, "none");
                    }
                }
            }
            self notify(#"electric_cherry_end");
        }
    }
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 1, eflags: 0x0
// Checksum 0xf80b5a18, Offset: 0x1738
// Size: 0xd6
function electric_cherry_cooldown_timer(current_weapon) {
    self notify(#"electric_cherry_cooldown_started");
    self endon(#"electric_cherry_cooldown_started");
    self endon(#"death");
    self endon(#"disconnect");
    n_reload_time = 0.25;
    if (self hasperk(#"specialty_fastreload")) {
        n_reload_time *= getdvarfloat(#"perk_weapreloadmultiplier", 0);
    }
    n_cooldown_time = n_reload_time + 3;
    wait n_cooldown_time;
    self.consecutive_electric_cherry_attacks = 0;
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 1, eflags: 0x0
// Checksum 0x8ee60b8c, Offset: 0x1818
// Size: 0xe8
function check_for_reload_complete(weapon) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon("player_lost_weapon_" + weapon.name);
    self thread weapon_replaced_monitor(weapon);
    while (true) {
        self waittill(#"reload");
        current_weapon = self getcurrentweapon();
        if (current_weapon == weapon) {
            arrayremovevalue(self.wait_on_reload, weapon);
            self notify("weapon_reload_complete_" + weapon.name);
            break;
        }
    }
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 1, eflags: 0x0
// Checksum 0x8d862540, Offset: 0x1908
// Size: 0xdc
function weapon_replaced_monitor(weapon) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon("weapon_reload_complete_" + weapon.name);
    while (true) {
        self waittill(#"weapon_change");
        primaryweapons = self getweaponslistprimaries();
        if (!isinarray(primaryweapons, weapon)) {
            self notify("player_lost_weapon_" + weapon.name);
            arrayremovevalue(self.wait_on_reload, weapon);
            break;
        }
    }
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 1, eflags: 0x0
// Checksum 0x6aee0144, Offset: 0x19f0
// Size: 0xec
function electric_cherry_reload_fx(n_fraction) {
    self endon(#"death");
    if (n_fraction >= 0.67) {
        self clientfield::set("electric_cherry_reload_fx", 1);
    } else if (n_fraction >= 0.33 && n_fraction < 0.67) {
        self clientfield::set("electric_cherry_reload_fx", 2);
    } else {
        self clientfield::set("electric_cherry_reload_fx", 3);
    }
    wait 1;
    self clientfield::set("electric_cherry_reload_fx", 0);
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 3, eflags: 0x0
// Checksum 0x6ee586fd, Offset: 0x1ae8
// Size: 0x38
function electric_cherry_perk_lost(b_pause, str_perk, str_result) {
    self notify(#"specialty_electriccherry" + "_take");
}

