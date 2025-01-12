#using scripts\abilities\ability_gadgets;
#using scripts\abilities\ability_util;

#namespace ability_power;

/#

    // Namespace ability_power/ability_power
    // Params 2, eflags: 0x0
    // Checksum 0x120852b1, Offset: 0xc8
    // Size: 0x104
    function cpower_print(slot, str) {
        color = "<dev string:x30>";
        toprint = color + "<dev string:x33>" + str;
        weaponname = "<dev string:x44>";
        if (isdefined(self._gadgets_player[slot])) {
            weaponname = self._gadgets_player[slot].name;
        }
        if (getdvarint(#"scr_cpower_debug_prints", 0) > 0) {
            self iprintlnbold(toprint);
            return;
        }
        println(self.playername + "<dev string:x49>" + weaponname + "<dev string:x49>" + toprint);
    }

#/

// Namespace ability_power/ability_power
// Params 1, eflags: 0x0
// Checksum 0xdf4c0695, Offset: 0x1d8
// Size: 0x1a
function power_is_hero_ability(gadget) {
    return gadget.gadget_type != 0;
}

// Namespace ability_power/ability_power
// Params 2, eflags: 0x0
// Checksum 0xaac6de71, Offset: 0x200
// Size: 0x4a
function function_db8f789(gadget, weapon) {
    if (!isdefined(level.var_358401d2)) {
        level.var_358401d2 = [];
    }
    level.var_358401d2[gadget] = weapon;
}

// Namespace ability_power/ability_power
// Params 2, eflags: 0x0
// Checksum 0x1f154122, Offset: 0x258
// Size: 0xc2
function is_weapon_or_variant_same_as_gadget(weapon, gadget) {
    if (weapon == gadget) {
        return true;
    }
    if (isdefined(level.var_358401d2)) {
        keys = getarraykeys(level.var_358401d2);
        for (i = 0; i < keys.size; i++) {
            if (keys[i] == gadget && level.var_358401d2[keys[i]] == weapon) {
                return true;
            }
        }
    }
    return false;
}

// Namespace ability_power/ability_power
// Params 4, eflags: 0x0
// Checksum 0x644bd6fc, Offset: 0x328
// Size: 0x2fe
function power_gain_event_score(event, eattacker, score, weapon) {
    if (!isplayer(self)) {
        return;
    }
    var_49f8cc60 = 1;
    /#
        var_49f8cc60 *= getdvarfloat(#"hash_eae9a8ee387705d", 1);
    #/
    if (score > 0) {
        var_2fa71c6 = getdvarint(#"hash_74d01f2fd0317f08", 0) || isdefined(weapon) && weapon.var_c6b06173;
        for (slot = 0; slot < 3; slot++) {
            gadget = self._gadgets_player[slot];
            if (isdefined(gadget)) {
                ignoreself = gadget.gadget_powergainscoreignoreself;
                var_940e4d1b = isdefined(weapon) && is_weapon_or_variant_same_as_gadget(weapon, gadget);
                if (ignoreself && var_940e4d1b || var_2fa71c6 && !var_940e4d1b) {
                    continue;
                }
                ignorewhenactive = gadget.gadget_powergainscoreignorewhenactive;
                if (ignorewhenactive && self gadgetisactive(slot)) {
                    continue;
                }
                scorefactor = gadget.gadget_powergainscorefactor;
                if (isdefined(self.gadgetthiefactive) && self.gadgetthiefactive == 1) {
                    continue;
                }
                gametypefactor = getgametypesetting(#"scoreheropowergainfactor");
                perkfactor = 1;
                if (self hasperk(#"specialty_overcharge")) {
                    perkfactor = getdvarfloat(#"gadgetpoweroverchargeperkscorefactor", 0);
                }
                if (scorefactor > 0 && gametypefactor > 0) {
                    gaintoadd = score * scorefactor * gametypefactor * perkfactor * var_49f8cc60;
                    self power_gain_event(slot, eattacker, gaintoadd, "score");
                }
            }
        }
    }
}

// Namespace ability_power/ability_power
// Params 1, eflags: 0x0
// Checksum 0xb1bf8f2f, Offset: 0x630
// Size: 0x86
function power_gain_event_damage_actor(eattacker) {
    basegain = 0;
    if (basegain > 0) {
        for (slot = 0; slot < 3; slot++) {
            if (isdefined(self._gadgets_player[slot])) {
                self power_gain_event(slot, eattacker, basegain, "damaged actor");
            }
        }
    }
}

// Namespace ability_power/ability_power
// Params 2, eflags: 0x0
// Checksum 0x72f4197b, Offset: 0x6c0
// Size: 0xde
function power_gain_event_killed_actor(eattacker, meansofdeath) {
    basegain = 5;
    for (slot = 0; slot < 3; slot++) {
        if (isdefined(self._gadgets_player[slot])) {
            if (self._gadgets_player[slot].gadget_powerreplenishfactor > 0) {
                gaintoadd = basegain * self._gadgets_player[slot].gadget_powerreplenishfactor;
                if (gaintoadd > 0) {
                    source = "killed actor";
                    self power_gain_event(slot, eattacker, gaintoadd, source);
                }
            }
        }
    }
}

// Namespace ability_power/ability_power
// Params 4, eflags: 0x0
// Checksum 0xab1c3418, Offset: 0x7a8
// Size: 0x18c
function power_gain_event(slot, eattacker, val, source) {
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    powertoadd = val;
    if (abs(powertoadd) > 0.0001) {
        maxscore = self._gadgets_player[slot].var_4de4a175;
        if (maxscore && 0 < powertoadd) {
            if (powertoadd + self.var_5d9fd314[slot] > maxscore) {
                powertoadd = maxscore - self.var_5d9fd314[slot];
                if (0 >= powertoadd) {
                    return;
                }
            }
        }
        powerleft = self gadgetpowerchange(slot, powertoadd);
        if (0 < powertoadd) {
            self.var_5d9fd314[slot] = self.var_5d9fd314[slot] + powertoadd;
        }
        /#
            self cpower_print(slot, "<dev string:x4c>" + powertoadd + "<dev string:x56>" + source + "<dev string:x61>" + powerleft);
        #/
    }
}

// Namespace ability_power/ability_power
// Params 5, eflags: 0x0
// Checksum 0x1f62f83, Offset: 0x940
// Size: 0x176
function power_loss_event_took_damage(eattacker, einflictor, weapon, smeansofdeath, idamage) {
    baseloss = idamage;
    for (slot = 0; slot < 3; slot++) {
        if (isdefined(self._gadgets_player[slot])) {
            if (self gadgetisactive(slot)) {
                powerloss = baseloss * self._gadgets_player[slot].gadget_poweronlossondamage;
                if (powerloss > 0) {
                    self power_loss_event(slot, eattacker, powerloss, "took damage with power on");
                }
                if (self._gadgets_player[slot].gadget_flickerondamage > 0) {
                    self ability_gadgets::setflickering(slot, self._gadgets_player[slot].gadget_flickerondamage);
                }
                continue;
            }
            powerloss = baseloss * self._gadgets_player[slot].gadget_powerofflossondamage;
            if (powerloss > 0) {
                self power_loss_event(slot, eattacker, powerloss, "took damage");
            }
        }
    }
}

// Namespace ability_power/ability_power
// Params 4, eflags: 0x0
// Checksum 0x2903b169, Offset: 0xac0
// Size: 0xcc
function power_loss_event(slot, eattacker, val, source) {
    powertoremove = val * -1;
    if (powertoremove > 0.1 || powertoremove < -0.1) {
        powerleft = self gadgetpowerchange(slot, powertoremove);
        /#
            self cpower_print(slot, "<dev string:x70>" + powertoremove + "<dev string:x56>" + source + "<dev string:x61>" + powerleft);
        #/
    }
}

// Namespace ability_power/ability_power
// Params 1, eflags: 0x0
// Checksum 0x84488aa1, Offset: 0xb98
// Size: 0x4e
function power_drain_completely(slot) {
    powerleft = self gadgetpowerchange(slot, 0);
    powerleft = self gadgetpowerchange(slot, powerleft * -1);
}

// Namespace ability_power/ability_power
// Params 0, eflags: 0x0
// Checksum 0xc5909424, Offset: 0xbf0
// Size: 0x6e
function ismovingpowerloss() {
    velocity = self getvelocity();
    speedsq = lengthsquared(velocity);
    return speedsq > self._gadgets_player.gadget_powermovespeed * self._gadgets_player.gadget_powermovespeed;
}

// Namespace ability_power/ability_power
// Params 2, eflags: 0x0
// Checksum 0x89c6b8f7, Offset: 0xc68
// Size: 0x238
function power_consume_timer_think(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    time = gettime();
    while (true) {
        wait 0.1;
        if (!isdefined(self._gadgets_player[slot])) {
            return;
        }
        if (!self gadgetisactive(slot)) {
            return;
        }
        currenttime = gettime();
        interval = currenttime - time;
        time = currenttime;
        powerconsumpted = 0;
        if (self isonground()) {
            if (self._gadgets_player[slot].gadget_powersprintloss > 0 && self issprinting()) {
                powerconsumpted += 1 * float(interval) / 1000 * self._gadgets_player[slot].gadget_powersprintloss;
            } else if (self._gadgets_player[slot].gadget_powermoveloss && self ismovingpowerloss()) {
                powerconsumpted += 1 * float(interval) / 1000 * self._gadgets_player[slot].gadget_powermoveloss;
            }
        }
        if (powerconsumpted > 0.1) {
            self power_loss_event(slot, self, powerconsumpted, "consume");
            if (self._gadgets_player[slot].gadget_flickeronpowerloss > 0) {
                self ability_gadgets::setflickering(slot, self._gadgets_player[slot].gadget_flickeronpowerloss);
            }
        }
    }
}

