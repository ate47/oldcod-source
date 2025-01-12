#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_electric_cherry;

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 0, eflags: 0x2
// Checksum 0xa9e897a6, Offset: 0x170
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_electric_cherry", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0xd0ff0cdc, Offset: 0x1b8
// Size: 0x14
function __init__() {
    function_252b307b();
}

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0xe8be97a, Offset: 0x1d8
// Size: 0xa4
function function_252b307b() {
    zm_perks::register_perk_mod_basic_info(#"specialty_mod_electriccherry", "mod_electric_cherry", #"specialty_electriccherry", 4000);
    zm_perks::register_perk_threads(#"specialty_mod_electriccherry", &function_268940de, &function_4e4ae7b0);
    zm::register_actor_damage_callback(&function_41885dcd);
}

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0xf3bb5418, Offset: 0x288
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

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x24e0800b, Offset: 0x380
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

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0xa523f55c, Offset: 0x468
// Size: 0x126
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
    if (self.ai_state !== "zombie_think") {
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

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0xcf34c1f4, Offset: 0x598
// Size: 0x13a
function electric_cherry_reload_attack() {
    self endon(#"death", #"specialty_mod_electriccherry" + "_stop");
    self endon(#"death", #"specialty_mod_electriccherry" + "_take");
    self.consecutive_electric_cherry_attacks = 0;
    self.var_a45a9ddc = 0;
    self.var_de21f388 = 0;
    while (true) {
        s_results = self waittill(#"reload_start");
        w_current = self getcurrentweapon();
        n_clip_current = self getweaponammoclip(w_current);
        n_clip_max = w_current.clipsize;
        self thread check_for_reload_complete(w_current, n_clip_current, n_clip_max);
        if (isdefined(self)) {
            self notify(#"hash_54480fc7f7e6f243");
        }
    }
}

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 3, eflags: 0x0
// Checksum 0xd119c1d, Offset: 0x6e0
// Size: 0x104
function check_for_reload_complete(weapon, n_clip_current, n_clip_max) {
    self endon(#"death", #"specialty_mod_electriccherry" + "_stop", #"specialty_mod_electriccherry" + "_take", "player_lost_weapon_" + weapon.name);
    self thread weapon_replaced_monitor(weapon);
    while (true) {
        self waittill(#"reload");
        current_weapon = self getcurrentweapon();
        if (current_weapon == weapon && !weapon.isabilityweapon) {
            self thread function_437f8912(weapon, n_clip_current, n_clip_max);
            break;
        }
    }
}

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 1, eflags: 0x0
// Checksum 0x5c0e10b0, Offset: 0x7f0
// Size: 0xbc
function weapon_replaced_monitor(weapon) {
    self endon(#"death", "weapon_reload_complete_" + weapon.name);
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

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 12, eflags: 0x0
// Checksum 0xa2c1ad42, Offset: 0x8b8
// Size: 0x1b6
function function_41885dcd(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (isplayer(attacker) && attacker hasperk(#"specialty_mod_electriccherry") && meansofdeath == "MOD_MELEE" && attacker.var_de21f388 > 0) {
        if (!attacker.var_a45a9ddc) {
            attacker thread function_aa60d713();
        }
        var_6c6c1a87 = damage * 3;
        if (self.archetype === "zombie" || self.archetype === "catalyst") {
            self thread electric_cherry_death_fx();
            return self.health;
        } else if (self.health <= var_6c6c1a87) {
            self thread electric_cherry_death_fx();
            return var_6c6c1a87;
        } else {
            self thread electric_cherry_stun();
            self thread electric_cherry_shock_fx();
            return var_6c6c1a87;
        }
    }
    return -1;
}

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 3, eflags: 0x0
// Checksum 0x47dbec88, Offset: 0xa78
// Size: 0x8c
function function_437f8912(w_current, n_clip_current, n_clip_max) {
    n_fraction = n_clip_current / n_clip_max;
    if (n_fraction == 0) {
        n_time = 10;
    } else {
        n_time = 10 - n_fraction * 10;
    }
    if (n_time < 2) {
        return;
    }
    self thread function_764d3e6e(n_time);
}

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 1, eflags: 0x0
// Checksum 0x47b3feb2, Offset: 0xb10
// Size: 0x74
function function_764d3e6e(n_time) {
    if (self.var_de21f388 < n_time) {
        self.var_de21f388 = n_time;
        n_counter = math::clamp(self.var_de21f388, 0, 10);
        n_counter /= 10;
        self zm_perks::function_2b57e880(3, n_counter);
    }
}

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x1047e697, Offset: 0xb90
// Size: 0x9c
function function_aa60d713() {
    self endon(#"disconnect");
    self thread function_d39e6b77();
    wait self.var_de21f388;
    self playsoundtoplayer(#"hash_ea37a7d6cf6bfb3", self);
    self notify(#"hash_5435513976a87bce");
    self.var_a45a9ddc = 0;
    self.var_de21f388 = 0;
    self zm_perks::function_2b57e880(3, 0);
}

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x7f4d3a0d, Offset: 0xc38
// Size: 0x1c
function function_268940de() {
    self thread electric_cherry_reload_attack();
}

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x1a2fa9cc, Offset: 0xc60
// Size: 0x148
function function_d39e6b77() {
    self endon(#"disconnect", #"hash_3e7b66a5a89792d4", #"hash_5435513976a87bce");
    self.var_a45a9ddc = 1;
    self playsoundtoplayer(#"hash_2283cbfbc6b9e736", self);
    var_290f03ae = self.var_de21f388;
    n_time_left = var_290f03ae;
    self zm_perks::function_2b57e880(3, 1);
    while (true) {
        wait 0.1;
        n_time_left -= 0.1;
        n_time_left = math::clamp(n_time_left, 0, var_290f03ae);
        n_percentage = n_time_left / var_290f03ae;
        n_percentage = math::clamp(n_percentage, 0.02, var_290f03ae);
        self zm_perks::function_2b57e880(3, n_percentage);
    }
}

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 3, eflags: 0x0
// Checksum 0xca2261b1, Offset: 0xdb0
// Size: 0x64
function function_4e4ae7b0(b_pause, str_perk, str_result) {
    self notify(#"specialty_mod_electriccherry" + "_take");
    self.var_a45a9ddc = undefined;
    self.var_de21f388 = undefined;
    self zm_perks::function_2b57e880(3, 0);
}

