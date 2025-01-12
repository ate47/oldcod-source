#using scripts/core_common/abilities/ability_gadgets;
#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/rank_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace ability_power;

// Namespace ability_power/ability_power
// Params 0, eflags: 0x2
// Checksum 0xb9f34ea3, Offset: 0x2d8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("ability_power", &__init__, undefined, undefined);
}

// Namespace ability_power/ability_power
// Params 0, eflags: 0x0
// Checksum 0x8b2af261, Offset: 0x318
// Size: 0x24
function __init__() {
    callback::on_connect(&on_player_connect);
}

/#

    // Namespace ability_power/ability_power
    // Params 2, eflags: 0x0
    // Checksum 0x2c6227b7, Offset: 0x348
    // Size: 0x10c
    function cpower_print(slot, str) {
        color = "<dev string:x28>";
        toprint = color + "<dev string:x2b>" + str;
        weaponname = "<dev string:x3c>";
        if (isdefined(self._gadgets_player[slot])) {
            weaponname = self._gadgets_player[slot].name;
        }
        if (getdvarint("<dev string:x41>") > 0) {
            self iprintlnbold(toprint);
            return;
        }
        println(self.playername + "<dev string:x59>" + weaponname + "<dev string:x59>" + toprint);
    }

#/

// Namespace ability_power/ability_power
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x460
// Size: 0x4
function on_player_connect() {
    
}

// Namespace ability_power/ability_power
// Params 1, eflags: 0x0
// Checksum 0xc87a842d, Offset: 0x470
// Size: 0x1e
function power_is_hero_ability(gadget) {
    return gadget.gadget_type != 0;
}

// Namespace ability_power/ability_power
// Params 2, eflags: 0x0
// Checksum 0x5cee34b2, Offset: 0x498
// Size: 0x78
function is_weapon_or_variant_same_as_gadget(weapon, gadget) {
    if (weapon == gadget) {
        return true;
    }
    if (isdefined(level.weaponlightninggun) && gadget == level.weaponlightninggun) {
        if (isdefined(level.weaponlightninggunarc) && weapon == level.weaponlightninggunarc) {
            return true;
        }
    }
    return false;
}

// Namespace ability_power/ability_power
// Params 4, eflags: 0x0
// Checksum 0x1189e978, Offset: 0x518
// Size: 0x26e
function power_gain_event_score(event, eattacker, score, weapon) {
    base_value = score;
    resource = self rank::getscoreinforesource(event);
    if (isdefined(resource)) {
        base_value = resource;
    }
    if (base_value > 0) {
        for (slot = 0; slot < 4; slot++) {
            gadget = self._gadgets_player[slot];
            if (isdefined(gadget)) {
                ignoreself = gadget.gadget_powergainscoreignoreself;
                if (isdefined(weapon) && ignoreself && is_weapon_or_variant_same_as_gadget(weapon, gadget)) {
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
                gametypefactor = getgametypesetting("scoreHeroPowerGainFactor");
                perkfactor = 1;
                if (self hasperk("specialty_overcharge")) {
                    perkfactor = getdvarfloat("gadgetPowerOverchargePerkScoreFactor");
                }
                if (scorefactor > 0 && gametypefactor > 0) {
                    gaintoadd = base_value * scorefactor * gametypefactor * perkfactor;
                    self power_gain_event(slot, eattacker, gaintoadd, "score");
                }
            }
        }
    }
}

// Namespace ability_power/ability_power
// Params 1, eflags: 0x0
// Checksum 0xca255b09, Offset: 0x790
// Size: 0x8e
function power_gain_event_damage_actor(eattacker) {
    basegain = 0;
    if (basegain > 0) {
        for (slot = 0; slot < 4; slot++) {
            if (isdefined(self._gadgets_player[slot])) {
                self power_gain_event(slot, eattacker, basegain, "damaged actor");
            }
        }
    }
}

// Namespace ability_power/ability_power
// Params 2, eflags: 0x0
// Checksum 0x7c67c7ad, Offset: 0x828
// Size: 0x18e
function power_gain_event_killed_actor(eattacker, meansofdeath) {
    basegain = 5;
    for (slot = 0; slot < 4; slot++) {
        if (isdefined(self._gadgets_player[slot])) {
            if (meansofdeath == "MOD_MELEE_ASSASSINATE" && self ability_util::gadget_is_camo_suit_on()) {
                if (self._gadgets_player[slot].gadget_powertakedowngain > 0) {
                    source = "assassinate actor";
                    self power_gain_event(slot, eattacker, self._gadgets_player[slot].gadget_powertakedowngain, source);
                }
            }
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
// Checksum 0x9588927b, Offset: 0x9c0
// Size: 0xf4
function power_gain_event(slot, eattacker, val, source) {
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    powertoadd = val;
    if (powertoadd > 0.1 || powertoadd < -0.1) {
        powerleft = self gadgetpowerchange(slot, powertoadd);
        /#
            self cpower_print(slot, "<dev string:x5c>" + powertoadd + "<dev string:x66>" + source + "<dev string:x71>" + powerleft);
        #/
    }
}

// Namespace ability_power/ability_power
// Params 5, eflags: 0x0
// Checksum 0x39ea4b30, Offset: 0xac0
// Size: 0x1ae
function power_loss_event_took_damage(eattacker, einflictor, weapon, smeansofdeath, idamage) {
    baseloss = idamage;
    for (slot = 0; slot < 4; slot++) {
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
// Checksum 0xcb963c53, Offset: 0xc78
// Size: 0xd4
function power_loss_event(slot, eattacker, val, source) {
    powertoremove = val * -1;
    if (powertoremove > 0.1 || powertoremove < -0.1) {
        powerleft = self gadgetpowerchange(slot, powertoremove);
        /#
            self cpower_print(slot, "<dev string:x80>" + powertoremove + "<dev string:x66>" + source + "<dev string:x71>" + powerleft);
        #/
    }
}

// Namespace ability_power/ability_power
// Params 1, eflags: 0x0
// Checksum 0x492d9c0a, Offset: 0xd58
// Size: 0x58
function power_drain_completely(slot) {
    powerleft = self gadgetpowerchange(slot, 0);
    powerleft = self gadgetpowerchange(slot, powerleft * -1);
}

// Namespace ability_power/ability_power
// Params 0, eflags: 0x0
// Checksum 0xad416d59, Offset: 0xdb8
// Size: 0x72
function ismovingpowerloss() {
    velocity = self getvelocity();
    speedsq = lengthsquared(velocity);
    return speedsq > self._gadgets_player.gadget_powermovespeed * self._gadgets_player.gadget_powermovespeed;
}

// Namespace ability_power/ability_power
// Params 2, eflags: 0x0
// Checksum 0x155a44c1, Offset: 0xe38
// Size: 0x248
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
                powerconsumpted += 1 * interval / 1000 * self._gadgets_player[slot].gadget_powersprintloss;
            } else if (self._gadgets_player[slot].gadget_powermoveloss && self ismovingpowerloss()) {
                powerconsumpted += 1 * interval / 1000 * self._gadgets_player[slot].gadget_powermoveloss;
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

