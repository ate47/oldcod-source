#using scripts\abilities\ability_util;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace killstreaks;

// Namespace killstreaks/killstreaks_util
// Params 3, eflags: 0x0
// Checksum 0x5d6f3646, Offset: 0x110
// Size: 0x428
function switch_to_last_non_killstreak_weapon(immediate, awayfromball, gameended) {
    if (self.sessionstate === "disconnected") {
        return 0;
    }
    ball = getweapon(#"ball");
    if (isdefined(ball) && self hasweapon(ball) && !is_true(awayfromball)) {
        self switchtoweaponimmediate(ball);
        self disableweaponcycling();
        self disableoffhandweapons();
    } else if (is_true(self.laststand)) {
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
            if (is_true(awayfromball) && isdefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon)) {
                self switchtoweapon(self.lastdroppableweapon);
            } else {
                self switchtoweapon();
            }
            return 1;
        } else if (is_true(immediate)) {
            self switchtoweaponimmediate(self.lastnonkillstreakweapon, is_true(gameended));
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
// Checksum 0x23c89319, Offset: 0x540
// Size: 0x4c
function hasuav(team_or_entnum) {
    if (!isdefined(level.activeuavs)) {
        return true;
    }
    if (!isdefined(level.activeuavs[team_or_entnum])) {
        return false;
    }
    return level.activeuavs[team_or_entnum] > 0;
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0xf46396d9, Offset: 0x598
// Size: 0x34
function hassatellite(team_or_entnum) {
    if (!isdefined(level.activesatellites)) {
        return true;
    }
    return level.activesatellites[team_or_entnum] > 0;
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0xb2115181, Offset: 0x5d8
// Size: 0x3c
function function_f479a2ff(weapon) {
    if (isdefined(level.var_3ff1b984) && isdefined(level.var_3ff1b984[weapon])) {
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0xc1391e3, Offset: 0x620
// Size: 0x8c
function function_e3a30c69(weapon) {
    assert(isdefined(isdefined(level.killstreakweapons[weapon])));
    killstreak = level.killstreaks[level.killstreakweapons[weapon]];
    return isdefined(killstreak.script_bundle.var_a82b593f) ? killstreak.script_bundle.var_a82b593f : 0;
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0x7efeb98b, Offset: 0x6b8
// Size: 0x70
function is_killstreak_weapon(weapon) {
    if (!isdefined(weapon)) {
        return false;
    }
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
// Checksum 0x4c7eefaf, Offset: 0x730
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
// Checksum 0x5620fa34, Offset: 0x798
// Size: 0x1e
function function_c5927b3f(weapon) {
    return isdefined(level.var_b1dfdc3b[weapon]);
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0x29b0f374, Offset: 0x7c0
// Size: 0x1e
function is_weapon_associated_with_killstreak(weapon) {
    return isdefined(level.killstreakweapons[weapon]);
}

// Namespace killstreaks/killstreaks_util
// Params 0, eflags: 0x0
// Checksum 0x669eea8d, Offset: 0x7e8
// Size: 0xa2
function function_4a1fb0f() {
    onkillstreak = 0;
    if (!isdefined(self.pers[#"kill_streak_before_death"])) {
        self.pers[#"kill_streak_before_death"] = 0;
    }
    streakplusone = self.pers[#"kill_streak_before_death"] + 1;
    if (self.pers[#"kill_streak_before_death"] >= 5) {
        onkillstreak = 1;
    }
    return onkillstreak;
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0x6ee3e8be, Offset: 0x898
// Size: 0x7e
function get_killstreak_team_kill_penalty_scale(weapon) {
    killstreak = get_killstreak_for_weapon(weapon);
    if (!isdefined(killstreak)) {
        return 1;
    }
    return isdefined(level.killstreaks[killstreak].teamkillpenaltyscale) ? level.killstreaks[killstreak].teamkillpenaltyscale : 1;
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0x406a94e8, Offset: 0x920
// Size: 0x5e
function get_killstreak_for_weapon(weapon) {
    if (!isdefined(level.killstreakweapons)) {
        return undefined;
    }
    if (isdefined(level.killstreakweapons[weapon])) {
        return level.killstreakweapons[weapon];
    }
    return level.killstreakweapons[weapon.rootweapon];
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0xbd63e033, Offset: 0x988
// Size: 0x8a
function get_killstreak_for_weapon_for_stats(weapon) {
    killstreak = get_killstreak_for_weapon(weapon);
    if (isdefined(killstreak)) {
        prefix = "inventory_";
        if (strstartswith(killstreak, prefix)) {
            killstreak = getsubstr(killstreak, prefix.size);
        }
    }
    return killstreak;
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0x74337460, Offset: 0xa20
// Size: 0x108
function function_a2c375bb(killstreaktype) {
    if (!isdefined(killstreaktype)) {
        return undefined;
    }
    if (self.usingkillstreakfrominventory === 1) {
        return 3;
    }
    killstreak_weapon = get_killstreak_weapon(killstreaktype);
    keys = getarraykeys(self.killstreak);
    foreach (key in keys) {
        if (self.killstreak[key] === killstreak_weapon.rootweapon.name) {
            return key;
        }
    }
    return undefined;
}

// Namespace killstreaks/killstreaks_util
// Params 2, eflags: 0x0
// Checksum 0xcf577734, Offset: 0xb30
// Size: 0xca
function function_fde227c6(weapon, stat_weapon) {
    assert(weapon.iscarriedkillstreak);
    assert(stat_weapon.iscarriedkillstreak);
    if (weapon.var_6f41c2a9) {
        assert(isdefined(level.var_6110cb51[stat_weapon]));
        assert(level.var_6110cb51[stat_weapon] != level.weaponnone);
        return level.var_6110cb51[stat_weapon];
    }
    return stat_weapon;
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0x74a2a3d, Offset: 0xc08
// Size: 0xd4
function function_fa6e0467(weapon) {
    if (weapon.iscliponly) {
        self setweaponammoclip(weapon, self.pers[#"held_killstreak_ammo_count"][weapon]);
        return;
    }
    self setweaponammoclip(weapon, self.pers[#"held_killstreak_clip_count"][weapon]);
    self setweaponammostock(weapon, self.pers[#"held_killstreak_ammo_count"][weapon] - self.pers[#"held_killstreak_clip_count"][weapon]);
}

// Namespace killstreaks/killstreaks_util
// Params 0, eflags: 0x0
// Checksum 0xfc30da3a, Offset: 0xce8
// Size: 0xaa
function function_43f4782d() {
    airsupport_height = struct::get("air_support_height", "targetname");
    if (isdefined(airsupport_height)) {
        height = airsupport_height.origin[2];
    } else {
        println("<dev string:x38>");
        height = 1000;
        if (isdefined(level.mapcenter)) {
            height += level.mapcenter[2];
        }
    }
    return height;
}

// Namespace killstreaks/killstreaks_util
// Params 6, eflags: 0x4
// Checksum 0x5f56d34e, Offset: 0xda0
// Size: 0x14c
function private function_a021023d(rotator, angle, radius, var_b468418b, var_93e44bb3, roll) {
    radiusoffset = radius + (var_b468418b == 0 ? 0 : randomint(var_b468418b));
    xoffset = cos(angle) * radiusoffset;
    yoffset = sin(angle) * radiusoffset;
    anglevector = vectornormalize((xoffset, yoffset, 0));
    anglevector *= radius;
    anglevector = (anglevector[0], anglevector[1], 0);
    angle_offset = 90 * (var_93e44bb3 > 0 ? 1 : -1);
    self linkto(rotator, "tag_origin", anglevector, (0, angle + angle_offset, roll));
}

// Namespace killstreaks/killstreaks_util
// Params 5, eflags: 0x0
// Checksum 0x3bc5aa9f, Offset: 0xef8
// Size: 0x84
function function_67d553c4(rotator, radius, var_b468418b, var_93e44bb3, roll = 0) {
    angle = randomint(360);
    self function_a021023d(rotator, angle, radius, var_b468418b, var_93e44bb3, roll);
}

// Namespace killstreaks/killstreaks_util
// Params 4, eflags: 0x0
// Checksum 0xd456963b, Offset: 0xf88
// Size: 0xe4
function function_d7123898(rotator, var_4fb9010a, var_93e44bb3, roll = 0) {
    originoffset = (var_4fb9010a[0], var_4fb9010a[1], rotator.origin[2]) - rotator.origin;
    angle = vectortoangles(originoffset)[1] - rotator.angles[1];
    radius = length(originoffset);
    self function_a021023d(rotator, angle, radius, 0, var_93e44bb3, roll);
}

// Namespace killstreaks/killstreaks_util
// Params 5, eflags: 0x0
// Checksum 0x65304fc7, Offset: 0x1078
// Size: 0x188
function function_f3875fb0(var_d22c85cf, height_offset, var_b6417305, var_93e44bb3, var_e690ed4e = 0) {
    height = int(function_43f4782d()) + height_offset;
    var_564cfb64 = (isdefined(var_d22c85cf[0]) ? var_d22c85cf[0] : level.mapcenter[0], isdefined(var_d22c85cf[1]) ? var_d22c85cf[1] : level.mapcenter[1], height);
    rotator = spawn("script_model", var_564cfb64);
    rotator setmodel(#"tag_origin");
    rotator.angles = (0, 115, 0);
    rotator hide();
    rotator thread function_1ddb2653(var_b6417305, var_93e44bb3);
    if (var_e690ed4e) {
        rotator thread function_8294e9b3();
    }
    rotator setforcenocull();
    return rotator;
}

// Namespace killstreaks/killstreaks_util
// Params 2, eflags: 0x0
// Checksum 0x651192ef, Offset: 0x1208
// Size: 0x66
function function_1ddb2653(seconds, direction) {
    self endon(#"death");
    for (;;) {
        self rotateyaw(360 * (direction > 0 ? 1 : -1), seconds);
        wait seconds;
    }
}

// Namespace killstreaks/killstreaks_util
// Params 0, eflags: 0x0
// Checksum 0x25ec79e5, Offset: 0x1278
// Size: 0x11e
function function_8294e9b3() {
    self endon(#"death");
    centerorigin = self.origin;
    for (;;) {
        z = randomintrange(-200, -100);
        time = randomintrange(3, 6);
        self moveto(centerorigin + (0, 0, z), time, 1, 1);
        wait time;
        z = randomintrange(100, 200);
        time = randomintrange(3, 6);
        self moveto(centerorigin + (0, 0, z), time, 1, 1);
        wait time;
    }
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0x569a9a7f, Offset: 0x13a0
// Size: 0xc4
function function_5a7ecb6b(var_56422be = 0.01) {
    self endon(#"death");
    scale = 0.1;
    for (scalestep = 0.1; scale < 1; scalestep -= var_56422be) {
        self setscale(scale);
        waitframe(1);
        scale += scalestep;
        if (scalestep > var_56422be + 0.01) {
        }
    }
    self setscale(1);
}

// Namespace killstreaks/killstreaks_util
// Params 1, eflags: 0x0
// Checksum 0xc52a7077, Offset: 0x1470
// Size: 0xbc
function outro_scaling(var_56422be = 0.001) {
    self endon(#"death");
    scale = 0.99;
    for (scalestep = 0.01; scale > 0.01; scalestep += var_56422be) {
        self setscale(scale);
        waitframe(1);
        scale -= scalestep;
        if (scalestep < 0.1) {
        }
    }
    self hide();
}

// Namespace killstreaks/killstreaks_util
// Params 2, eflags: 0x0
// Checksum 0x87287cf6, Offset: 0x1538
// Size: 0x7e
function function_e729ccee(attacker, weapon) {
    killstreaktype = get_killstreak_for_weapon(weapon);
    if (isdefined(killstreaktype) && (killstreaktype == "planemortar" || killstreaktype == "remote_missile")) {
        attacker.(killstreaktype + "_hitconfirmed") = 1;
    }
}

// Namespace killstreaks/killstreaks_util
// Params 3, eflags: 0x0
// Checksum 0x946713cd, Offset: 0x15c0
// Size: 0x16c
function function_eb52ba7(killstreaktype, team, killstreak_id) {
    var_88dc634d = hash(killstreaktype);
    if (isdefined(self.var_9fa3bd36[killstreak_id]) || isdefined(self.var_63fa6458[var_88dc634d])) {
        return;
    }
    session = {#spawnid:getplayerspawnid(self), #name:var_88dc634d, #starttime:gettime(), #endtime:0, #team:team, #kills:0};
    weapon = get_killstreak_weapon(killstreaktype);
    if (weapon.iscarriedkillstreak === 1) {
        if (!isdefined(self.var_63fa6458)) {
            self.var_63fa6458 = [];
        }
        self.var_63fa6458[var_88dc634d] = session;
        return;
    }
    if (!isdefined(self.var_9fa3bd36)) {
        self.var_9fa3bd36 = [];
    }
    self.var_9fa3bd36[killstreak_id] = session;
}

// Namespace killstreaks/killstreaks_util
// Params 2, eflags: 0x0
// Checksum 0x3b83577, Offset: 0x1738
// Size: 0x134
function function_fda235cf(killstreaktype, killstreak_id) {
    weapon = get_killstreak_weapon(killstreaktype);
    if (weapon.iscarriedkillstreak === 1) {
        var_88dc634d = hash(killstreaktype);
        if (isdefined(self.var_63fa6458[var_88dc634d])) {
            self.var_63fa6458[var_88dc634d].endtime = gettime();
            function_92d1707f(#"hash_25d8f7d855b13f45", self.var_63fa6458[var_88dc634d]);
            self.var_63fa6458[var_88dc634d] = undefined;
        }
        return;
    }
    if (isdefined(self.var_9fa3bd36[killstreak_id])) {
        self.var_9fa3bd36[killstreak_id].endtime = gettime();
        function_92d1707f(#"hash_25d8f7d855b13f45", self.var_9fa3bd36[killstreak_id]);
        self.var_9fa3bd36[killstreak_id] = undefined;
    }
}

