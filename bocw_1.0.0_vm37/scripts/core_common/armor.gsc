#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\perks;
#using scripts\weapons\weapon_utils;

#namespace armor;

// Namespace armor/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x79df6ceb, Offset: 0x168
// Size: 0x2c
function event_handler[gametype_init] main(*eventstruct) {
    callback::on_connect(&on_player_connect);
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0x7110bfcf, Offset: 0x1a0
// Size: 0xbc
function function_9c8b5737() {
    self.lightarmor = {#amount:0, #max:0, #var_2274e560:1, #var_cdeeec29:1};
    self.var_59a874a7 = {#var_2274e560:1, #var_cdeeec29:1};
    self set_armor(0, 0, 0, 1, 0);
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0x11e21e33, Offset: 0x268
// Size: 0x1c
function on_player_connect() {
    self function_9c8b5737();
}

// Namespace armor/armor
// Params 1, eflags: 0x0
// Checksum 0x66a3b27d, Offset: 0x290
// Size: 0xc2
function setlightarmorhp(newvalue) {
    if (isdefined(newvalue)) {
        self.lightarmor.amount = newvalue;
        if (isplayer(self) && self.lightarmor.max > 0) {
            lightarmorpercent = math::clamp(self.lightarmor.amount / self.lightarmor.max, 0, 1);
        }
        return;
    }
    self.lightarmor.amount = 0;
    self.lightarmor.max = 0;
}

// Namespace armor/armor
// Params 3, eflags: 0x0
// Checksum 0xb7cd417e, Offset: 0x360
// Size: 0x11c
function setlightarmor(optionalarmorvalue, var_2274e560, var_cdeeec29) {
    self notify(#"give_light_armor");
    if (isdefined(self.lightarmor.amount)) {
        unsetlightarmor();
    }
    self thread removelightarmorondeath();
    self thread removelightarmoronmatchend();
    if (!isdefined(optionalarmorvalue)) {
        optionalarmorvalue = 150;
    }
    self.lightarmor.max = optionalarmorvalue;
    if (!isdefined(var_2274e560)) {
        var_2274e560 = 1;
    }
    self.lightarmor.var_2274e560 = var_2274e560;
    if (!isdefined(var_cdeeec29)) {
        var_cdeeec29 = 1;
    }
    self.lightarmor.var_cdeeec29 = var_cdeeec29;
    self setlightarmorhp(self.lightarmor.max);
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0xc6a4d03, Offset: 0x488
// Size: 0x5c
function removelightarmorondeath() {
    self endon(#"disconnect", #"give_light_armor", #"remove_light_armor");
    self waittill(#"death");
    unsetlightarmor();
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0xcd4195cb, Offset: 0x4f0
// Size: 0x2e
function unsetlightarmor() {
    self setlightarmorhp(0);
    self notify(#"remove_light_armor");
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0x388ab65a, Offset: 0x528
// Size: 0x54
function removelightarmoronmatchend() {
    self endon(#"disconnect", #"remove_light_armor");
    level waittill(#"game_ended");
    self thread unsetlightarmor();
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0xc9a9b910, Offset: 0x588
// Size: 0x16
function haslightarmor() {
    return self.lightarmor.amount > 0;
}

// Namespace armor/armor
// Params 6, eflags: 0x0
// Checksum 0xbdd9af80, Offset: 0x5a8
// Size: 0x178
function function_a77114f2(*einflictor, *eattacker, idamage, smeansofdeath, weapon, shitloc) {
    if (isdefined(self.lightarmor) && self.lightarmor.amount > 0) {
        if (weapon.ignoreslightarmor && smeansofdeath != "MOD_MELEE") {
            return idamage;
        } else if (weapon.meleeignoreslightarmor && smeansofdeath == "MOD_MELEE") {
            return idamage;
        } else if (smeansofdeath != "MOD_FALLING" && !weapons::isheadshot(weapon, shitloc, smeansofdeath)) {
            damage_to_armor = idamage * self.lightarmor.var_cdeeec29;
            self.lightarmor.amount = self.lightarmorhp - damage_to_armor;
            idamage = 0;
            if (self.lightarmor.amount <= 0) {
                idamage = abs(self.lightarmor.amount);
                unsetlightarmor();
            }
        }
    }
    return idamage;
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0x330ceae1, Offset: 0x728
// Size: 0x6c
function get_armor() {
    total_armor = 0;
    if (isdefined(self.armor)) {
        total_armor = self.armor;
    }
    if (isdefined(self.lightarmor) && isdefined(self.lightarmor.amount)) {
        total_armor += self.lightarmor.amount;
    }
    return total_armor;
}

// Namespace armor/armor
// Params 13, eflags: 0x0
// Checksum 0x8f027327, Offset: 0x7a0
// Size: 0x26e
function set_armor(amount, max_armor, armortier, var_2274e560 = 1, var_cdeeec29 = 1, var_5164d2e2 = 1, var_e6683a43 = 1, var_22c3ab38 = 1, var_9f307988 = 1, var_7a80f06e = 1, explosive_damage_scale = 1, var_35e3563e = 1, var_4aad1e44 = undefined) {
    assert(isdefined(amount));
    self.var_d6f11c60 = undefined;
    self.var_e6c1bab8 = undefined;
    self.var_59a874a7.var_2274e560 = var_2274e560;
    self.var_59a874a7.var_22c3ab38 = var_22c3ab38;
    self.var_59a874a7.var_9f307988 = var_9f307988;
    self.var_59a874a7.var_7a80f06e = var_7a80f06e;
    self.var_59a874a7.var_cdeeec29 = var_cdeeec29;
    self.var_59a874a7.var_5164d2e2 = var_5164d2e2;
    self.var_59a874a7.var_e6683a43 = var_e6683a43;
    self.var_59a874a7.explosive_damage_scale = explosive_damage_scale;
    self.var_59a874a7.var_35e3563e = var_35e3563e;
    self.var_59a874a7.var_4aad1e44 = var_4aad1e44;
    if (isdefined(var_4aad1e44)) {
        self.var_59a874a7.var_735ae1ee = getscriptbundle(var_4aad1e44);
    }
    self.armortier = armortier;
    self.maxarmor = max_armor;
    self.armor = amount;
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0xed433e34, Offset: 0xa18
// Size: 0x1e
function has_armor() {
    return self get_armor() > 0;
}

// Namespace armor/armor
// Params 1, eflags: 0x0
// Checksum 0x4e9d71c7, Offset: 0xa40
// Size: 0x4c
function get_damage_time_threshold_ms(not_damaged_time_seconds = 0.5) {
    damage_time_threshold_ms = gettime() - int(not_damaged_time_seconds * 1000);
    return damage_time_threshold_ms;
}

// Namespace armor/armor
// Params 2, eflags: 0x0
// Checksum 0x4d1c85da, Offset: 0xa98
// Size: 0x11e
function boost_armor(bars_to_give, damage_time_threshold_ms) {
    player = self;
    if (!isdefined(player)) {
        return;
    }
    if (bars_to_give <= 0) {
        return;
    }
    if (!player has_armor_bar_capability()) {
        return;
    }
    if (player at_peak_armor_bars()) {
        return;
    }
    if (isdefined(damage_time_threshold_ms) && isdefined(player.lastdamagetime) && player.lastdamagetime > 0 && player.lastdamagetime > damage_time_threshold_ms) {
        return;
    }
    empty_bars = get_empty_bars();
    if (empty_bars < bars_to_give) {
        player update_max_armor(1);
    }
    player.armor += int(bars_to_give * player.armorperbar);
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0x8d91dee3, Offset: 0xbc0
// Size: 0x34
function get_empty_bars() {
    if (self.armorperbar <= 0) {
        return 0;
    }
    return (self.maxarmor - self.armor) / self.armorperbar;
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0xa3244e07, Offset: 0xc00
// Size: 0x3e
function at_peak_armor_bars() {
    if (self.armorperbar <= 0) {
        return true;
    }
    return self.armor == self.maxarmor && self.maxarmor >= self.spawnarmor;
}

// Namespace armor/armor
// Params 1, eflags: 0x0
// Checksum 0x2a9728e1, Offset: 0xc48
// Size: 0x8a
function update_max_armor(bonus_bars = 0) {
    var_59fec421 = 1;
    if (var_59fec421) {
        return;
    }
    new_max_bars = get_max_armor_bars(bonus_bars);
    self.maxarmor = int(ceil(new_max_bars * self.armorperbar));
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0xd60c1795, Offset: 0xce0
// Size: 0x22
function has_armor_bar_capability() {
    return self hasperk(#"specialty_armor");
}

// Namespace armor/armor
// Params 1, eflags: 0x0
// Checksum 0xc55db949, Offset: 0xd10
// Size: 0x7a
function get_max_armor_bars(bonus_bars) {
    if (self.armorperbar <= 0) {
        return 0;
    }
    return math::clamp(ceil(self.armor / self.armorperbar) + bonus_bars, 0, max(self.armorbarmaxcount, 1));
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0xfbc2784f, Offset: 0xd98
// Size: 0x22
function get_armor_bars() {
    return math::clamp(self.armorbarcount, 1, 10);
}

// Namespace armor/armor
// Params 2, eflags: 0x4
// Checksum 0x28247d7f, Offset: 0xdc8
// Size: 0x246
function private function_37f4e0e0(smeansofdeath, shitloc) {
    if (is_true(level.var_4ead52cc) && self laststand::player_is_in_laststand()) {
        return false;
    }
    if (!isdefined(smeansofdeath)) {
        return true;
    }
    isexplosivedamage = weapons::isexplosivedamage(smeansofdeath);
    if (isdefined(self.var_59a874a7) && isdefined(self.var_59a874a7.var_735ae1ee) && !is_true(isexplosivedamage)) {
        if (!isdefined(self.var_59a874a7.var_735ae1ee.(shitloc))) {
            return false;
        }
        if (self.var_59a874a7.var_735ae1ee.(shitloc) == 0) {
            return false;
        }
        if (smeansofdeath == "MOD_HEAD_SHOT") {
            return true;
        }
    }
    if (level.var_d89ef54a === 1 || sessionmodeiszombiesgame()) {
        if (smeansofdeath == "MOD_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_WEAPON_BUTT") {
            return true;
        }
        if (isexplosivedamage) {
            return true;
        }
    } else {
        if (smeansofdeath == "MOD_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_IMPACT" && shitloc !== "head") {
            return true;
        }
        if (isexplosivedamage) {
            return true;
        }
    }
    if (is_true(level.var_369305cf)) {
        return true;
    }
    return false;
}

// Namespace armor/armor
// Params 1, eflags: 0x4
// Checksum 0x63f37ade, Offset: 0x1018
// Size: 0x30
function private function_7538fede(weapon) {
    if (weapon.name == #"ar_stealth_t8_operator") {
        return true;
    }
    return false;
}

// Namespace armor/armor
// Params 5, eflags: 0x0
// Checksum 0x3d97665d, Offset: 0x1050
// Size: 0x812
function apply_damage(weapon, damage, smeansofdeath, eattacker, shitloc) {
    if (self.armor <= 0) {
        return damage;
    }
    if (isdefined(self.var_d44d1214)) {
        return damage;
    }
    if (!self function_37f4e0e0(smeansofdeath, shitloc)) {
        return damage;
    }
    if (!isdefined(weapon)) {
        return damage;
    }
    var_737c8f6e = weapon.var_f857d6a0;
    if (!isdefined(var_737c8f6e) || var_737c8f6e <= 0) {
        var_737c8f6e = 1;
    }
    if (!isdefined(self.var_59a874a7)) {
        self function_9c8b5737();
    }
    var_737c8f6e *= is_true(weapon.var_ed6ea786) ? self.var_59a874a7.var_e6683a43 : self.var_59a874a7.var_cdeeec29;
    var_2274e560 = weapon.var_7b0ea85;
    if (weapons::isexplosivedamage(smeansofdeath)) {
        var_2274e560 = self.var_59a874a7.explosive_damage_scale;
        var_737c8f6e = self.var_59a874a7.var_35e3563e;
    } else {
        if (smeansofdeath == "MOD_MELEE") {
            if (weapons::ispunch(weapon)) {
                var_2274e560 *= self.var_59a874a7.var_22c3ab38;
            } else {
                var_2274e560 *= self.var_59a874a7.var_9f307988;
            }
        } else if (smeansofdeath == "MOD_MELEE_WEAPON_BUTT") {
            if (function_7538fede(weapon)) {
                var_2274e560 *= self.var_59a874a7.var_9f307988;
            } else {
                var_2274e560 *= self.var_59a874a7.var_7a80f06e;
            }
        } else {
            var_2274e560 *= weapon.var_ed6ea786 ? self.var_59a874a7.var_5164d2e2 : self.var_59a874a7.var_2274e560;
        }
        if (isdefined(self.var_59a874a7) && isdefined(self.var_59a874a7.var_735ae1ee)) {
            var_2274e560 += (1 - var_2274e560) * (1 - self.var_59a874a7.var_735ae1ee.(shitloc));
        }
    }
    if (is_true(level.var_369305cf)) {
        var_2274e560 = 0;
        if (self isjuking()) {
            damage = 0;
        }
    }
    var_aacd5df1 = damage * var_737c8f6e;
    var_9bb721d3 = 0;
    if (var_aacd5df1 > 0) {
        armor_damage = float(math::clamp(var_aacd5df1, 0, self.armor));
        var_e27873f2 = damage * (1 - var_2274e560);
        var_b1417997 = math::clamp(var_aacd5df1 - self.armor, 0, var_aacd5df1);
        var_9bb721d3 = var_e27873f2 * var_b1417997 / var_aacd5df1;
        self.armor -= int(ceil(armor_damage));
        if (isdefined(self.var_3f1410dd)) {
            self.var_3f1410dd.damage_taken += int(ceil(armor_damage));
        }
        if (var_9bb721d3 > 0) {
            var_9bb721d3 *= self function_e95ae03(#"hash_47245d009e766628");
        }
    }
    self update_max_armor();
    if (isdefined(level.var_dea62998)) {
        self [[ level.var_dea62998 ]]();
    }
    if (self.armor <= 0) {
        self.var_d6f11c60 = eattacker;
        self.var_e6c1bab8 = gettime();
        self playsoundtoplayer(#"prj_bullet_impact_armor_broken", self);
        self thread function_386de852();
        self function_51df9c0c(#"hash_6be738527a4213aa");
        if (perks::perk_hasperk(#"specialty_armor")) {
            self perks::perk_unsetperk(#"specialty_armor");
            playfxontag(#"hash_4a955131370a3720", self, "j_spineupper");
        }
        if (perks::perk_hasperk(#"specialty_armor_tier_two")) {
            self perks::perk_unsetperk(#"specialty_armor_tier_two");
            playfxontag(#"hash_56c8182de62c1c6", self, "j_spineupper");
        }
        if (perks::perk_hasperk(#"specialty_armor_tier_three")) {
            self perks::perk_unsetperk(#"specialty_armor_tier_three");
            playfxontag(#"hash_3c6a01bd4394d4f3", self, "j_spineupper");
        }
        if (isdefined(level.var_67f4fd41)) {
            self [[ level.var_67f4fd41 ]]();
        }
        if (isdefined(self.var_67f4fd41)) {
            self [[ self.var_67f4fd41 ]](eattacker, weapon);
        }
    }
    if (isdefined(self.var_ea1458aa) && isdefined(eattacker) && isdefined(eattacker.clientid)) {
        if (!isdefined(self.var_ea1458aa.attackerdamage)) {
            self.var_ea1458aa.attackerdamage = [];
        }
        if (!isdefined(self.var_ea1458aa.attackerdamage[eattacker.clientid])) {
            self.var_ea1458aa.attackerdamage[eattacker.clientid] = spawnstruct();
        }
        var_d72bd991 = self.var_ea1458aa.attackerdamage[eattacker.clientid];
        var_d72bd991.var_a74d2db8 = gettime();
    }
    remaining_damage = int(ceil(math::clamp(damage * var_2274e560 + var_9bb721d3, 0, damage)));
    return remaining_damage;
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0xfc6e398b, Offset: 0x1870
// Size: 0x14c
function function_386de852() {
    self notify("23bb02011a3250f9");
    self endon("23bb02011a3250f9");
    self endon(#"disconnect");
    cooldown_time = 0;
    self clientfield::set_player_uimodel("hudItems.armorIsOnCooldown", 0);
    if (!isdefined(self.var_a06951b7)) {
        cooldown_time = self function_6d32a13b();
        self.var_a06951b7 = gettime() + cooldown_time;
    }
    if (cooldown_time <= 0) {
        return;
    }
    self clientfield::set_player_uimodel("hudItems.armorIsOnCooldown", 1);
    while (isdefined(self.var_a06951b7) && self.var_a06951b7 > gettime()) {
        if (!isalive(self) && self function_725b4d91() == 0) {
            self.var_a06951b7 += 250;
        }
        wait 0.25;
    }
    self clientfield::set_player_uimodel("hudItems.armorIsOnCooldown", 0);
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0xd875c23, Offset: 0x19c8
// Size: 0xa2
function has_helmet() {
    if (isdefined(self.var_59a874a7) && isdefined(self.var_59a874a7.var_735ae1ee)) {
        return ((isdefined(self.var_59a874a7.var_735ae1ee.helmet) ? self.var_59a874a7.var_735ae1ee.helmet : 0) || (isdefined(self.var_59a874a7.var_735ae1ee.head) ? self.var_59a874a7.var_735ae1ee.head : 0));
    }
    return false;
}

