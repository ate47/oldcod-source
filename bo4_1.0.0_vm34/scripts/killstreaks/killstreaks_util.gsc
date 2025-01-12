#using scripts\abilities\ability_util;
#using scripts\core_common\util_shared;

#namespace killstreaks;

// Namespace killstreaks/killstreaks_util
// Params 3, eflags: 0x0
// Checksum 0xaa5021e2, Offset: 0x78
// Size: 0x3f0
function switch_to_last_non_killstreak_weapon(immediate, awayfromball, gameended) {
    ball = getweapon(#"ball");
    if (isdefined(ball) && self hasweapon(ball) && !(isdefined(awayfromball) && awayfromball)) {
        self switchtoweaponimmediate(ball);
        self disableweaponcycling();
        self disableoffhandweapons();
    } else if (isdefined(self.laststand) && self.laststand) {
        if (isdefined(self.laststandpistol) && self hasweapon(self.laststandpistol)) {
            self switchtoweapon(self.laststandpistol);
        }
    } else if (isdefined(self.lastnonkillstreakweapon) && self hasweapon(self.lastnonkillstreakweapon) && self getcurrentweapon() != self.lastnonkillstreakweapon) {
        if (ability_util::is_hero_weapon(self.lastnonkillstreakweapon)) {
            if (self.lastnonkillstreakweapon.gadget_heroversion_2_0) {
                if (self.lastnonkillstreakweapon.isgadget && self getammocount(self.lastnonkillstreakweapon) > 0) {
                    slot = self gadgetgetslot(self.lastnonkillstreakweapon);
                    if (self util::gadget_is_in_use(slot)) {
                        return self switchtoweapon(self.lastnonkillstreakweapon);
                    } else {
                        return 1;
                    }
                }
            } else if (self getammocount(self.lastnonkillstreakweapon) > 0) {
                return self switchtoweapon(self.lastnonkillstreakweapon);
            }
            if (isdefined(awayfromball) && awayfromball && isdefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon)) {
                self switchtoweapon(self.lastdroppableweapon);
            } else {
                self switchtoweapon();
            }
            return 1;
        } else if (isdefined(immediate) && immediate) {
            self switchtoweaponimmediate(self.lastnonkillstreakweapon, isdefined(gameended) && gameended);
        } else {
            self switchtoweapon(self.lastnonkillstreakweapon);
        }
    } else if (isdefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon) && self getcurrentweapon() != self.lastdroppableweapon) {
        self switchtoweapon(self.lastdroppableweapon);
    } else {
        return 0;
    }
    return 1;
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0x9a711ec2, Offset: 0x470
// Size: 0x34
function hasuav(team_or_entnum) {
    if (!isdefined(level.activeuavs)) {
        return true;
    }
    return level.activeuavs[team_or_entnum] > 0;
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0x33a502c5, Offset: 0x4b0
// Size: 0x34
function hassatellite(team_or_entnum) {
    if (!isdefined(level.activesatellites)) {
        return true;
    }
    return level.activesatellites[team_or_entnum] > 0;
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0x8e1ce515, Offset: 0x4f0
// Size: 0x3c
function function_49792b6f(weapon) {
    if (isdefined(level.var_d184eaf5) && isdefined(level.var_d184eaf5[weapon])) {
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0x275f6b9a, Offset: 0x538
// Size: 0x60
function is_killstreak_weapon(weapon) {
    if (weapon == level.weaponnone || weapon.notkillstreak) {
        return false;
    }
    if (weapon.isspecificuse || is_weapon_associated_with_killstreak(weapon)) {
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0xb2cb8554, Offset: 0x5a0
// Size: 0x5a
function get_killstreak_weapon(killstreak) {
    if (!isdefined(killstreak)) {
        return level.weaponnone;
    }
    assert(isdefined(level.killstreaks[killstreak]));
    return level.killstreaks[killstreak].weapon;
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0x454849f8, Offset: 0x608
// Size: 0x30
function is_weapon_associated_with_killstreak(weapon) {
    return isdefined(level.killstreakweapons) && isdefined(level.killstreakweapons[weapon]);
}

