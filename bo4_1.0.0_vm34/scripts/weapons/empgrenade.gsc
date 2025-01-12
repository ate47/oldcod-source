#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace empgrenade;

// Namespace empgrenade/empgrenade
// Params 0, eflags: 0x2
// Checksum 0x2ea00074, Offset: 0xf8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"empgrenade", &__init__, undefined, undefined);
}

// Namespace empgrenade/empgrenade
// Params 0, eflags: 0x0
// Checksum 0x47d94499, Offset: 0x140
// Size: 0x84
function __init__() {
    clientfield::register("toplayer", "empd", 1, 1, "int");
    clientfield::register("toplayer", "empd_monitor_distance", 1, 1, "int");
    callback::on_spawned(&on_player_spawned);
}

// Namespace empgrenade/empgrenade
// Params 0, eflags: 0x0
// Checksum 0x1d82fbce, Offset: 0x1d0
// Size: 0x2c
function on_player_spawned() {
    self endon(#"disconnect");
    self thread monitorempgrenade();
}

// Namespace empgrenade/empgrenade
// Params 0, eflags: 0x0
// Checksum 0xf31395e0, Offset: 0x208
// Size: 0x260
function monitorempgrenade() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"killempmonitor");
    self.empendtime = 0;
    while (true) {
        waitresult = self waittill(#"emp_grenaded");
        attacker = waitresult.attacker;
        explosionpoint = waitresult.position;
        if (!isalive(self) || self hasperk(#"specialty_immuneemp")) {
            continue;
        }
        hurtvictim = 1;
        hurtattacker = 0;
        assert(isdefined(self.team));
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
// Checksum 0x3e46f322, Offset: 0x470
// Size: 0x37c
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
        if (emp_time_left_ms > int(currentempduration * 1000)) {
            self.empduration = float(emp_time_left_ms) / 1000;
        } else {
            self.empduration = currentempduration;
        }
    } else {
        self.empduration = currentempduration;
    }
    self.empgrenaded = 1;
    self shellshock(#"emp_shock", 1);
    self clientfield::set_to_player("empd", 1);
    self.empstarttime = gettime();
    self.empendtime = self.empstarttime + int(self.empduration * 1000);
    self.empedby = attacker;
    shutdownemprebootindicatormenu();
    emprebootmenu = self openluimenu("EmpRebootIndicator");
    self setluimenudata(emprebootmenu, #"endtime", int(self.empendtime));
    self setluimenudata(emprebootmenu, #"starttime", int(self.empstarttime));
    self thread emprumbleloop(0.75);
    self setempjammed(1);
    self thread empgrenadedeathwaiter();
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
// Checksum 0xdc879c38, Offset: 0x7f8
// Size: 0x74
function empgrenadedeathwaiter() {
    self notify(#"empgrenadedeathwaiter");
    self endon(#"empgrenadedeathwaiter");
    self endon(#"empgrenadetimedout");
    self waittill(#"death", #"hash_3ffb993d40af48ca");
    if (isdefined(self)) {
        self checktoturnoffemp();
    }
}

// Namespace empgrenade/empgrenade
// Params 0, eflags: 0x0
// Checksum 0x22c35aa1, Offset: 0x878
// Size: 0x9c
function checktoturnoffemp() {
    if (isdefined(self)) {
        self.empgrenaded = 0;
        shutdownemprebootindicatormenu();
        if (isdefined(level.emp_shared.enemyempactivefunc)) {
            if (self [[ level.emp_shared.enemyempactivefunc ]]()) {
                return;
            }
        }
        self setempjammed(0);
        self clientfield::set_to_player("empd", 0);
    }
}

// Namespace empgrenade/empgrenade
// Params 0, eflags: 0x0
// Checksum 0x6c2f06f, Offset: 0x920
// Size: 0x4c
function shutdownemprebootindicatormenu() {
    emprebootmenu = self getluimenu("EmpRebootIndicator");
    if (isdefined(emprebootmenu)) {
        self closeluimenu(emprebootmenu);
    }
}

// Namespace empgrenade/empgrenade
// Params 1, eflags: 0x0
// Checksum 0x19370351, Offset: 0x978
// Size: 0x8e
function emprumbleloop(duration) {
    self endon(#"emp_rumble_loop");
    self notify(#"emp_rumble_loop");
    goaltime = gettime() + int(duration * 1000);
    while (gettime() < goaltime) {
        self playrumbleonentity("damage_heavy");
        waitframe(1);
    }
}

// Namespace empgrenade/empgrenade
// Params 2, eflags: 0x0
// Checksum 0xeeaa49f3, Offset: 0xa10
// Size: 0xfc
function watchempexplosion(owner, weapon) {
    owner endon(#"disconnect");
    owner endon(#"team_changed");
    self endon(#"trophy_destroyed");
    owner stats::function_4f10b697(weapon, #"used", 1);
    waitresult = self waittill(#"explode", #"death");
    if (waitresult._notify == "explode") {
        level empexplosiondamageents(owner, weapon, waitresult.position, 425, 1);
    }
}

// Namespace empgrenade/empgrenade
// Params 5, eflags: 0x0
// Checksum 0xc310caf9, Offset: 0xb18
// Size: 0x118
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

// Namespace empgrenade/grenade_fire
// Params 1, eflags: 0x40
// Checksum 0xffa17bbf, Offset: 0xc38
// Size: 0x9c
function event_handler[grenade_fire] function_4e68c98f(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    grenade = eventstruct.projectile;
    weapon = eventstruct.weapon;
    if (grenade util::ishacked()) {
        return;
    }
    if (weapon.isemp) {
        grenade thread watchempexplosion(self, weapon);
    }
}

