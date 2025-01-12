#using script_5f261a5d57de5f7c;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace ammomod_napalmburst;

// Namespace ammomod_napalmburst/ammomod_napalmburst
// Params 0, eflags: 0x1 linked
// Checksum 0x59587158, Offset: 0x228
// Size: 0x30c
function function_4e4244c1() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("ammomod_napalmburst", 0.1, 0, 5, 5, 1, &result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr", undefined, #"fire");
    aat::register("ammomod_napalmburst_1", 0.1, 0, 5, 5, 1, &result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr", undefined, #"fire");
    aat::register("ammomod_napalmburst_2", 0.1, 0, 5, 5, 1, &result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr", undefined, #"fire");
    aat::register("ammomod_napalmburst_3", 0.1, 0, 5, 5, 1, &result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr", undefined, #"fire");
    aat::register("ammomod_napalmburst_4", 0.1, 0, 5, 5, 1, &result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr", undefined, #"fire");
    aat::register("ammomod_napalmburst_5", 0.1, 0, 5, 5, 1, &result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr", undefined, #"fire");
    clientfield::register("actor", "zm_ammomod_napalmburst_explosion", 1, 1, "counter");
    clientfield::register("vehicle", "zm_ammomod_napalmburst_explosion", 1, 1, "counter");
    clientfield::register("actor", "zm_ammomod_napalmburst_burn", 1, 1, "int");
    clientfield::register("vehicle", "zm_ammomod_napalmburst_burn", 1, 1, "int");
    level.var_f5c624c2 = &function_7b53716a;
}

// Namespace ammomod_napalmburst/ammomod_napalmburst
// Params 1, eflags: 0x5 linked
// Checksum 0x8c19a010, Offset: 0x540
// Size: 0xcc
function private function_e8018847(aat_name) {
    switch (aat_name) {
    case #"ammomod_napalmburst":
    default:
        return 0;
    case #"ammomod_napalmburst_1":
        return 1;
    case #"ammomod_napalmburst_2":
        return 2;
    case #"ammomod_napalmburst_3":
        return 3;
    case #"ammomod_napalmburst_4":
        return 4;
    case #"ammomod_napalmburst_5":
        return 5;
    }
    return 0;
}

// Namespace ammomod_napalmburst/ammomod_napalmburst
// Params 5, eflags: 0x1 linked
// Checksum 0xaf0df0f0, Offset: 0x618
// Size: 0x1c4
function result(death, attacker, mod, weapon, vpoint = self.origin) {
    playfx("zm_weapons/fx9_aat_bul_impact_fire", vpoint);
    aat_name = attacker aat::getaatonweapon(weapon, 1);
    tier = function_e8018847(aat_name);
    if (is_true(death) && function_4f7f29ab(attacker) && tier >= 5) {
        level thread function_c8e3a0dc(self, self.origin, attacker, mod, weapon);
        return;
    }
    if (self.var_6f84b820 === #"special") {
        if (tier >= 4) {
            self thread function_80b0dbe5(attacker, weapon, tier);
            self thread function_be5234be(attacker, mod, weapon, tier);
        }
        return;
    }
    if (self.var_6f84b820 === #"normal") {
        self thread function_80b0dbe5(attacker, weapon, tier);
        self thread function_be5234be(attacker, mod, weapon, tier);
    }
}

// Namespace ammomod_napalmburst/ammomod_napalmburst
// Params 1, eflags: 0x5 linked
// Checksum 0xe1eb14a3, Offset: 0x7e8
// Size: 0xc2
function private function_4f7f29ab(e_attacker) {
    n_current_time = float(gettime()) / 1000;
    if (isplayer(e_attacker)) {
        if (!isdefined(e_attacker.aat_cooldown_start[#"zm_ammomod_napalmburst_explosion"])) {
            return true;
        } else if (isdefined(e_attacker.aat_cooldown_start[#"zm_ammomod_napalmburst_explosion"]) && n_current_time >= e_attacker.aat_cooldown_start[#"zm_ammomod_napalmburst_explosion"] + 30) {
            return true;
        }
    }
    return false;
}

// Namespace ammomod_napalmburst/ammomod_napalmburst
// Params 2, eflags: 0x1 linked
// Checksum 0x49fb8784, Offset: 0x8b8
// Size: 0x3c
function function_7b53716a(player, weapon) {
    function_c8e3a0dc(undefined, self.origin, player, "MOD_EXPLOSIVE", weapon);
}

// Namespace ammomod_napalmburst/ammomod_napalmburst
// Params 5, eflags: 0x1 linked
// Checksum 0x9d7cde9a, Offset: 0x900
// Size: 0x258
function function_c8e3a0dc(var_4589e270, var_23255fc5, e_attacker, *mod, w_weapon) {
    if (isdefined(var_23255fc5)) {
        var_23255fc5 thread clientfield::increment("zm_ammomod_napalmburst_explosion");
        if (isactor(var_23255fc5)) {
            var_23255fc5 zombie_death_gib(mod, w_weapon);
        }
    }
    n_range = 256;
    if (isplayer(mod)) {
        mod.aat_cooldown_start[#"zm_ammomod_napalmburst_explosion"] = float(gettime()) / 1000;
        n_range = mod namespace_e86ffa8::function_cd6787b(2) ? 512 : 256;
    }
    a_potential_targets = getentitiesinradius(e_attacker, n_range, 15);
    count = 0;
    foreach (zombie in a_potential_targets) {
        if (!isalive(zombie)) {
            continue;
        }
        if (count >= 5) {
            return;
        }
        if (var_23255fc5 === zombie) {
            continue;
        }
        if (isalive(zombie)) {
            zombie thread function_80b0dbe5(mod, w_weapon, 5);
            zombie thread function_be5234be(mod, undefined, w_weapon, 5);
        }
        count++;
        util::wait_network_frame();
    }
}

// Namespace ammomod_napalmburst/ammomod_napalmburst
// Params 3, eflags: 0x1 linked
// Checksum 0xe95139ea, Offset: 0xb60
// Size: 0x24e
function function_80b0dbe5(e_attacker, w_weapon, tier) {
    self notify(#"hash_8ba8465d56bb40e");
    self endon(#"hash_8ba8465d56bb40e", #"death");
    self thread clientfield::set("zm_ammomod_napalmburst_burn", 1);
    self.var_8a5e4369 = 1;
    var_70ab6bc = self.maxhealth * 0.02;
    var_9b6cf9b5 = self.maxhealth * 0.05;
    if (tier >= 3) {
        var_70ab6bc *= 2;
        var_9b6cf9b5 *= 2;
    }
    i = 0;
    var_9fa954e6 = 5;
    if (tier >= 2) {
        var_9fa954e6 = 10;
    }
    var_2c5684be = 0;
    while (i <= var_9fa954e6) {
        if (tier >= 1 && !var_2c5684be) {
            self dodamage(var_9b6cf9b5, self.origin, e_attacker, undefined, "none", "MOD_AAT", 0, w_weapon);
            var_2c5684be = 1;
        } else {
            self dodamage(var_70ab6bc, self.origin, e_attacker, undefined, "none", "MOD_AAT", 0, w_weapon);
        }
        i++;
        wait 1;
    }
    if (self ishidden()) {
        while (self ishidden()) {
            wait 1;
        }
        wait 1;
    }
    self.var_8a5e4369 = undefined;
    self thread clientfield::set("zm_ammomod_napalmburst_burn", 0);
    self notify(#"hash_1a322c9f227ee");
}

// Namespace ammomod_napalmburst/ammomod_napalmburst
// Params 4, eflags: 0x1 linked
// Checksum 0x49f0b01b, Offset: 0xdb8
// Size: 0xec
function function_be5234be(attacker, mod, weapon, tier = 0) {
    self notify(#"hash_382c4508f36af706");
    self endon(#"hash_382c4508f36af706", #"hash_1a322c9f227ee");
    self waittill(#"death");
    if (isdefined(self)) {
        if (is_true(self.var_8a5e4369) && function_4f7f29ab(attacker) && tier == 5) {
            level thread function_c8e3a0dc(self, self.origin, attacker, mod, weapon);
        }
    }
}

// Namespace ammomod_napalmburst/ammomod_napalmburst
// Params 2, eflags: 0x1 linked
// Checksum 0xbeb5efd5, Offset: 0xeb0
// Size: 0xa4
function zombie_death_gib(*e_attacker, *w_weapon) {
    self clientfield::set("zm_ammomod_napalmburst_burn", 1);
    gibserverutils::gibhead(self);
    if (math::cointoss()) {
        gibserverutils::gibleftarm(self);
    } else {
        gibserverutils::gibrightarm(self);
    }
    gibserverutils::giblegs(self);
}

