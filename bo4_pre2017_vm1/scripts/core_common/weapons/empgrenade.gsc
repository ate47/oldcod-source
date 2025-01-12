#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace empgrenade;

// Namespace empgrenade/empgrenade
// Params 0, eflags: 0x2
// Checksum 0x3c6e90f, Offset: 0x248
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("empgrenade", &__init__, undefined, undefined);
}

// Namespace empgrenade/empgrenade
// Params 0, eflags: 0x0
// Checksum 0x73f9eb5, Offset: 0x288
// Size: 0x84
function __init__() {
    clientfield::register("toplayer", "empd", 1, 1, "int");
    clientfield::register("toplayer", "empd_monitor_distance", 1, 1, "int");
    callback::on_spawned(&on_player_spawned);
}

// Namespace empgrenade/empgrenade
// Params 0, eflags: 0x0
// Checksum 0xad38a69b, Offset: 0x318
// Size: 0x3c
function on_player_spawned() {
    self endon(#"disconnect");
    self thread monitorempgrenade();
    self thread begin_other_grenade_tracking();
}

// Namespace empgrenade/empgrenade
// Params 0, eflags: 0x0
// Checksum 0xb05c4ac8, Offset: 0x360
// Size: 0x260
function monitorempgrenade() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"killempmonitor");
    self.empendtime = 0;
    while (true) {
        waitresult = self waittill("emp_grenaded");
        attacker = waitresult.attacker;
        explosionpoint = waitresult.position;
        if (!isalive(self) || self hasperk("specialty_immuneemp")) {
            continue;
        }
        hurtvictim = 1;
        hurtattacker = 0;
        /#
            assert(isdefined(self.team));
        #/
        if (level.teambased && isdefined(attacker) && isdefined(attacker.team) && attacker.team == self.team && attacker != self) {
            friendlyfire = [[ level.figure_out_friendly_fire ]](self);
            if (friendlyfire == 0) {
                continue;
            } else if (friendlyfire == 1) {
                hurtattacker = 0;
                hurtvictim = 1;
            } else if (friendlyfire == 2) {
                hurtvictim = 0;
                hurtattacker = 1;
            } else if (friendlyfire == 3) {
                hurtattacker = 1;
                hurtvictim = 1;
            }
        }
        if (hurtvictim && isdefined(self)) {
            self thread applyemp(attacker, explosionpoint);
        }
        if (hurtattacker && isdefined(attacker)) {
            attacker thread applyemp(attacker, explosionpoint);
        }
    }
}

// Namespace empgrenade/empgrenade
// Params 2, eflags: 0x0
// Checksum 0xe7b39171, Offset: 0x5c8
// Size: 0x36c
function applyemp(attacker, explosionpoint) {
    self notify(#"applyemp");
    self endon(#"applyemp");
    self endon(#"disconnect");
    self endon(#"death");
    waitframe(1);
    if (!(isdefined(self) && isalive(self))) {
        return;
    }
    if (self == attacker) {
        currentempduration = 1;
    } else {
        distancetoexplosion = distance(self.origin, explosionpoint);
        ratio = 1 - distancetoexplosion / 425;
        currentempduration = 3 + 3 * ratio;
    }
    if (isdefined(self.empendtime)) {
        emp_time_left_ms = self.empendtime - gettime();
        if (emp_time_left_ms > currentempduration * 1000) {
            self.empduration = emp_time_left_ms / 1000;
        } else {
            self.empduration = currentempduration;
        }
    } else {
        self.empduration = currentempduration;
    }
    self.empgrenaded = 1;
    self shellshock("emp_shock", 1);
    self clientfield::set_to_player("empd", 1);
    self.empstarttime = gettime();
    self.empendtime = self.empstarttime + self.empduration * 1000;
    self.empedby = attacker;
    shutdownemprebootindicatormenu();
    emprebootmenu = self openluimenu("EmpRebootIndicator");
    self setluimenudata(emprebootmenu, "endTime", int(self.empendtime));
    self setluimenudata(emprebootmenu, "startTime", int(self.empstarttime));
    self thread emprumbleloop(0.75);
    self setempjammed(1);
    self thread empgrenadedeathwaiter();
    self thread function_2be0d392();
    if (self.empduration > 0) {
        wait self.empduration;
    }
    if (isdefined(self)) {
        self notify(#"empgrenadetimedout");
        self checktoturnoffemp();
    }
}

// Namespace empgrenade/empgrenade
// Params 0, eflags: 0x0
// Checksum 0x86a86c6, Offset: 0x940
// Size: 0x54
function empgrenadedeathwaiter() {
    self notify(#"empgrenadedeathwaiter");
    self endon(#"empgrenadedeathwaiter");
    self endon(#"empgrenadetimedout");
    self waittill("death");
    if (isdefined(self)) {
        self checktoturnoffemp();
    }
}

// Namespace empgrenade/empgrenade
// Params 0, eflags: 0x0
// Checksum 0xad8881a6, Offset: 0x9a0
// Size: 0x54
function function_2be0d392() {
    self notify(#"hash_2be0d392");
    self endon(#"hash_2be0d392");
    self endon(#"empgrenadetimedout");
    self waittill("gadget_cleanse_on");
    if (isdefined(self)) {
        self checktoturnoffemp();
    }
}

// Namespace empgrenade/empgrenade
// Params 0, eflags: 0x0
// Checksum 0xc13a223d, Offset: 0xa00
// Size: 0x7c
function checktoturnoffemp() {
    if (isdefined(self)) {
        self.empgrenaded = 0;
        shutdownemprebootindicatormenu();
        if (self killstreaks::emp_isempd()) {
            return;
        }
        self setempjammed(0);
        self clientfield::set_to_player("empd", 0);
    }
}

// Namespace empgrenade/empgrenade
// Params 0, eflags: 0x0
// Checksum 0xaf858850, Offset: 0xa88
// Size: 0x54
function shutdownemprebootindicatormenu() {
    emprebootmenu = self getluimenu("EmpRebootIndicator");
    if (isdefined(emprebootmenu)) {
        self closeluimenu(emprebootmenu);
    }
}

// Namespace empgrenade/empgrenade
// Params 1, eflags: 0x0
// Checksum 0x16f243c6, Offset: 0xae8
// Size: 0x76
function emprumbleloop(duration) {
    self endon(#"emp_rumble_loop");
    self notify(#"emp_rumble_loop");
    goaltime = gettime() + duration * 1000;
    while (gettime() < goaltime) {
        self playrumbleonentity("damage_heavy");
        waitframe(1);
    }
}

// Namespace empgrenade/empgrenade
// Params 2, eflags: 0x0
// Checksum 0x153dbc22, Offset: 0xb68
// Size: 0xb4
function watchempexplosion(owner, weapon) {
    owner endon(#"disconnect");
    owner endon(#"team_changed");
    self endon(#"trophy_destroyed");
    owner addweaponstat(weapon, "used", 1);
    waitresult = self waittill("explode");
    level empexplosiondamageents(owner, weapon, waitresult.position, 425, 1);
}

// Namespace empgrenade/empgrenade
// Params 5, eflags: 0x0
// Checksum 0x5e53235b, Offset: 0xc28
// Size: 0x132
function empexplosiondamageents(owner, weapon, origin, radius, damageplayers) {
    ents = getdamageableentarray(origin, radius);
    if (!isdefined(damageplayers)) {
        damageplayers = 1;
    }
    foreach (ent in ents) {
        if (!damageplayers && isplayer(ent)) {
            continue;
        }
        ent dodamage(1, origin, owner, owner, "none", "MOD_GRENADE_SPLASH", 0, weapon);
    }
}

// Namespace empgrenade/empgrenade
// Params 0, eflags: 0x0
// Checksum 0x8d7a8b48, Offset: 0xd68
// Size: 0xd0
function begin_other_grenade_tracking() {
    self endon(#"death");
    self endon(#"disconnect");
    self notify(#"hash_916b3972");
    self endon(#"hash_916b3972");
    for (;;) {
        waitresult = self waittill("grenade_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        if (grenade util::ishacked()) {
            continue;
        }
        if (weapon.isemp) {
            grenade thread watchempexplosion(self, weapon);
        }
    }
}

