#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\perks;
#using scripts\core_common\weapons_shared;
#using scripts\weapons\weapon_utils;

#namespace armor;

// Namespace armor/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x89f1169e, Offset: 0x158
// Size: 0x2c
function event_handler[gametype_init] main(eventstruct) {
    callback::on_connect(&on_player_connect);
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0xa03f6cd5, Offset: 0x190
// Size: 0x96
function on_player_connect() {
    self.lightarmor = {#amount:0, #max:0, #var_a435981b:1, #var_1be68dcd:1};
    self.var_99df9de0 = {#var_a435981b:1, #var_1be68dcd:1};
}

// Namespace armor/armor
// Params 1, eflags: 0x0
// Checksum 0xd9fdbcd8, Offset: 0x230
// Size: 0x104
function setlightarmorhp(newvalue) {
    if (isdefined(newvalue)) {
        self.lightarmor.amount = newvalue;
        if (isplayer(self) && self.lightarmor.max > 0) {
            lightarmorpercent = math::clamp(self.lightarmor.amount / self.lightarmor.max, 0, 1);
            self setcontrolleruimodelvalue("hudItems.armorPercent", lightarmorpercent);
        }
        return;
    }
    self.lightarmor.amount = 0;
    self.lightarmor.max = 0;
    self setcontrolleruimodelvalue("hudItems.armorPercent", 0);
}

// Namespace armor/armor
// Params 3, eflags: 0x0
// Checksum 0x203b0874, Offset: 0x340
// Size: 0x11c
function setlightarmor(optionalarmorvalue, var_a435981b, var_1be68dcd) {
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
    if (!isdefined(var_a435981b)) {
        var_a435981b = 1;
    }
    self.lightarmor.var_a435981b = var_a435981b;
    if (!isdefined(var_1be68dcd)) {
        var_1be68dcd = 1;
    }
    self.lightarmor.var_1be68dcd = var_1be68dcd;
    self setlightarmorhp(self.lightarmor.max);
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0x2bfb1245, Offset: 0x468
// Size: 0x5c
function removelightarmorondeath() {
    self endon(#"disconnect");
    self endon(#"give_light_armor");
    self endon(#"remove_light_armor");
    self waittill(#"death");
    unsetlightarmor();
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0xe9d1f8fd, Offset: 0x4d0
// Size: 0x2e
function unsetlightarmor() {
    self setlightarmorhp(0);
    self notify(#"remove_light_armor");
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0xfc25abb5, Offset: 0x508
// Size: 0x54
function removelightarmoronmatchend() {
    self endon(#"disconnect");
    self endon(#"remove_light_armor");
    level waittill(#"game_ended");
    self thread unsetlightarmor();
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0xd7919604, Offset: 0x568
// Size: 0x16
function haslightarmor() {
    return self.lightarmor.amount > 0;
}

// Namespace armor/armor
// Params 6, eflags: 0x0
// Checksum 0x2d669b7a, Offset: 0x588
// Size: 0x180
function function_ccf62ba6(einflictor, eattacker, idamage, smeansofdeath, weapon, shitloc) {
    if (self.lightarmor.amount > 0) {
        if (weapon.ignoreslightarmor && smeansofdeath != "MOD_MELEE") {
            return idamage;
        } else if (weapon.meleeignoreslightarmor && smeansofdeath == "MOD_MELEE") {
            return idamage;
        } else if (smeansofdeath != "MOD_FALLING" && !weapon_utils::ismeleemod(smeansofdeath) && !weapons::isheadshot(shitloc, smeansofdeath)) {
            damage_to_armor = idamage * self.lightarmor.var_1be68dcd;
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
// Checksum 0x63560977, Offset: 0x710
// Size: 0x34
function get_armor() {
    total_armor = self.armor;
    total_armor += self.lightarmor.amount;
    return total_armor;
}

// Namespace armor/armor
// Params 7, eflags: 0x0
// Checksum 0x9c074155, Offset: 0x750
// Size: 0x142
function set_armor(amount, max_armor, var_a435981b = 1, var_1be68dcd = 1, var_5a8aeb92 = 1, var_b194e8d2 = 1, var_718e1e82 = 0) {
    assert(isdefined(amount));
    self.var_73b9d5c8 = undefined;
    self.var_d7ff854d = undefined;
    self.var_99df9de0.var_a435981b = var_a435981b;
    self.var_99df9de0.var_1be68dcd = var_1be68dcd;
    self.var_99df9de0.var_5a8aeb92 = var_5a8aeb92;
    self.var_99df9de0.var_b194e8d2 = var_b194e8d2;
    self.var_99df9de0.var_718e1e82 = var_718e1e82;
    self.maxarmor = max_armor;
    self.armor = amount;
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0x8e6d2a75, Offset: 0x8a0
// Size: 0x1e
function has_armor() {
    return self get_armor() > 0;
}

// Namespace armor/armor
// Params 1, eflags: 0x0
// Checksum 0x266f10cc, Offset: 0x8c8
// Size: 0x4c
function get_damage_time_threshold_ms(not_damaged_time_seconds = 0.5) {
    damage_time_threshold_ms = gettime() - int(not_damaged_time_seconds * 1000);
    return damage_time_threshold_ms;
}

// Namespace armor/armor
// Params 2, eflags: 0x0
// Checksum 0x8dd51e5, Offset: 0x920
// Size: 0x12e
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
// Checksum 0x9663246b, Offset: 0xa58
// Size: 0x34
function get_empty_bars() {
    if (self.armorperbar <= 0) {
        return 0;
    }
    return (self.maxarmor - self.armor) / self.armorperbar;
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0x67acee16, Offset: 0xa98
// Size: 0x3e
function at_peak_armor_bars() {
    if (self.armorperbar <= 0) {
        return true;
    }
    return self.armor == self.maxarmor && self.maxarmor >= self.spawnarmor;
}

// Namespace armor/armor
// Params 1, eflags: 0x0
// Checksum 0xf086f55c, Offset: 0xae0
// Size: 0x8a
function update_max_armor(bonus_bars = 0) {
    var_63d4c66a = 1;
    if (var_63d4c66a) {
        return;
    }
    new_max_bars = get_max_armor_bars(bonus_bars);
    self.maxarmor = int(ceil(new_max_bars * self.armorperbar));
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0x5522e26e, Offset: 0xb78
// Size: 0x22
function has_armor_bar_capability() {
    return self hasperk(#"specialty_armor");
}

// Namespace armor/armor
// Params 1, eflags: 0x0
// Checksum 0xe150f4c2, Offset: 0xba8
// Size: 0x7a
function get_max_armor_bars(bonus_bars) {
    if (self.armorperbar <= 0) {
        return 0;
    }
    return math::clamp(ceil(self.armor / self.armorperbar) + bonus_bars, 0, max(self.armorbarmaxcount, 1));
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0xe847607f, Offset: 0xc30
// Size: 0x22
function get_armor_bars() {
    return math::clamp(self.armorbarcount, 1, 10);
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0xf77a7ea7, Offset: 0xc60
// Size: 0x7a
function function_b9712125() {
    armortier = 0;
    if (self hasperk(#"specialty_armor_tier_three")) {
        armortier = 2;
    } else if (self hasperk(#"specialty_armor_tier_two")) {
        armortier = 1;
    }
    self.armortier = armortier;
}

// Namespace armor/armor
// Params 1, eflags: 0x4
// Checksum 0x49b675b6, Offset: 0xce8
// Size: 0x126
function private function_4b82f479(smeansofdeath) {
    if (!isdefined(smeansofdeath)) {
        return true;
    }
    if (smeansofdeath == "MOD_HEAD_SHOT" && self.var_99df9de0.var_718e1e82) {
        return true;
    }
    if (sessionmodeiswarzonegame()) {
        if (smeansofdeath == "MOD_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_WEAPON_BUTT") {
            return true;
        }
    } else {
        if (smeansofdeath == "MOD_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PISTOL_BULLET") {
            return true;
        }
        if (weapon_utils::isexplosivedamage(smeansofdeath)) {
            return true;
        }
    }
    return false;
}

// Namespace armor/armor
// Params 4, eflags: 0x0
// Checksum 0xc04ed750, Offset: 0xe18
// Size: 0x522
function apply_damage(weapon, damage, smeansofdeath, eattacker) {
    if (self.armor <= 0) {
        return damage;
    }
    if (isdefined(self.var_1dee8972)) {
        return damage;
    }
    if (!self function_4b82f479(smeansofdeath)) {
        return damage;
    }
    var_50da8409 = weapon.var_40c4837d;
    if (var_50da8409 <= 0) {
        var_50da8409 = 1;
    }
    var_a435981b = weapon.var_afc853f4;
    var_ecaf7d0b = weapon.var_ecaf7d0b;
    var_a435981b *= var_ecaf7d0b ? self.var_99df9de0.var_5a8aeb92 : self.var_99df9de0.var_a435981b;
    var_50da8409 *= var_ecaf7d0b ? self.var_99df9de0.var_b194e8d2 : self.var_99df9de0.var_1be68dcd;
    if (sessionmodeismultiplayergame() && weapon_utils::isexplosivedamage(smeansofdeath)) {
        var_a435981b = 1;
    }
    var_53bc6d74 = damage * var_50da8409;
    var_73c10795 = 0;
    if (var_53bc6d74 > 0) {
        armor_damage = float(math::clamp(var_53bc6d74, 0, self.armor));
        var_7c501432 = damage * (1 - var_a435981b);
        var_40342be7 = math::clamp(var_53bc6d74 - self.armor, 0, var_53bc6d74);
        var_73c10795 = var_7c501432 * var_40342be7 / var_53bc6d74;
        self.armor -= int(ceil(armor_damage));
        if (var_73c10795 > 0) {
            var_73c10795 *= self function_a7a85103(#"hash_47245d009e766628");
        }
    }
    self update_max_armor();
    if (isdefined(level.var_6ba3c5f4)) {
        self [[ level.var_6ba3c5f4 ]]();
    }
    if (self.armor <= 0) {
        self.var_73b9d5c8 = eattacker;
        self.var_d7ff854d = gettime();
        self playsoundtoplayer(#"prj_bullet_impact_armor_broken", self);
        self thread function_3da7da36();
        self function_c818fd0f(#"hash_6be738527a4213aa");
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
        if (isdefined(level.var_1d70db78)) {
            self [[ level.var_1d70db78 ]]();
        }
    }
    remaining_damage = int(ceil(math::clamp(damage * var_a435981b + var_73c10795, 0, damage)));
    return remaining_damage;
}

// Namespace armor/armor
// Params 0, eflags: 0x0
// Checksum 0xf236443f, Offset: 0x1348
// Size: 0x14c
function function_3da7da36() {
    self notify("3497855af9686f5f");
    self endon("3497855af9686f5f");
    self endon(#"disconnect");
    cooldown_time = 0;
    self clientfield::set_player_uimodel("hudItems.armorIsOnCooldown", 0);
    if (!isdefined(self.var_bb3cb3b)) {
        cooldown_time = self function_e7eddab8();
        self.var_bb3cb3b = gettime() + cooldown_time;
    }
    if (cooldown_time <= 0) {
        return;
    }
    self clientfield::set_player_uimodel("hudItems.armorIsOnCooldown", 1);
    while (isdefined(self.var_bb3cb3b) && self.var_bb3cb3b > gettime()) {
        if (!isalive(self) && self function_cfd61891() == 0) {
            self.var_bb3cb3b += 250;
        }
        wait 0.25;
    }
    self clientfield::set_player_uimodel("hudItems.armorIsOnCooldown", 0);
}

