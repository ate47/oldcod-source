#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace flashgrenades;

// Namespace flashgrenades/flashgrenades
// Params 0, eflags: 0x0
// Checksum 0xc79ca0a1, Offset: 0x1a8
// Size: 0x64
function init_shared() {
    level.var_ffec0318 = "";
    level.var_330113ce = "";
    level.var_159d2484 = "";
    callback::on_connect(&monitorflash);
}

// Namespace flashgrenades/flashgrenades
// Params 1, eflags: 0x0
// Checksum 0x411ce68, Offset: 0x218
// Size: 0x7e
function flashrumbleloop(duration) {
    self endon(#"hash_8d28e1a5");
    self endon(#"hash_563b2ebc");
    self notify(#"hash_563b2ebc");
    goaltime = gettime() + duration * 1000;
    while (gettime() < goaltime) {
        self playrumbleonentity("damage_heavy");
        waitframe(1);
    }
}

// Namespace flashgrenades/flashgrenades
// Params 4, eflags: 0x0
// Checksum 0x872a1032, Offset: 0x2a0
// Size: 0x3ec
function function_8e149bc3(amount_distance, amount_angle, attacker, var_b4b1c76e) {
    hurtattacker = 0;
    hurtvictim = 1;
    duration = amount_distance * 3.5;
    min_duration = 2.5;
    var_528f6a39 = 2.5;
    if (duration < min_duration) {
        duration = min_duration;
    }
    if (isdefined(attacker) && attacker == self) {
        duration /= 3;
    }
    if (duration < 0.25) {
        return;
    }
    rumbleduration = undefined;
    if (duration > 2) {
        rumbleduration = 0.75;
    } else {
        rumbleduration = 0.25;
    }
    assert(isdefined(self.team));
    if (level.teambased && isdefined(attacker) && isdefined(attacker.team) && attacker.team == self.team && attacker != self) {
        friendlyfire = [[ level.figure_out_friendly_fire ]](self);
        if (friendlyfire == 0) {
            return;
        } else if (friendlyfire == 1) {
        } else if (friendlyfire == 2) {
            duration *= 0.5;
            rumbleduration *= 0.5;
            hurtvictim = 0;
            hurtattacker = 1;
        } else if (friendlyfire == 3) {
            duration *= 0.5;
            rumbleduration *= 0.5;
            hurtattacker = 1;
        }
    }
    if (self hasperk("specialty_flashprotection")) {
        duration *= 0.1;
        rumbleduration *= 0.1;
    }
    if (hurtvictim) {
        if (!var_b4b1c76e && (self util::mayapplyscreeneffect() || self isremotecontrolling())) {
            if (isdefined(attacker) && self != attacker && isplayer(attacker)) {
                attacker addweaponstat(getweapon("flash_grenade"), "hits", 1);
                attacker addweaponstat(getweapon("flash_grenade"), "used", 1);
            }
            self thread applyflash(duration, rumbleduration, attacker);
        }
    }
    if (hurtattacker) {
        if (attacker util::mayapplyscreeneffect()) {
            attacker thread applyflash(duration, rumbleduration, attacker);
        }
    }
}

// Namespace flashgrenades/flashgrenades
// Params 0, eflags: 0x0
// Checksum 0xf16f063c, Offset: 0x698
// Size: 0xa8
function monitorflash() {
    self endon(#"disconnect");
    self endon(#"hash_15683a6d");
    self.flashendtime = 0;
    while (true) {
        waitresult = self waittill("flashbang");
        if (!isalive(self)) {
            continue;
        }
        self function_8e149bc3(waitresult.distance, waitresult.angle, waitresult.attacker, 1);
    }
}

// Namespace flashgrenades/flashgrenades
// Params 0, eflags: 0x0
// Checksum 0x86655ae1, Offset: 0x748
// Size: 0xd0
function function_de4f854a() {
    self endon(#"death");
    self.flashendtime = 0;
    while (true) {
        waitresult = self waittill("flashbang");
        driver = self getseatoccupant(0);
        if (!isdefined(driver) || !isalive(driver)) {
            continue;
        }
        driver function_8e149bc3(waitresult.distance, waitresult.angle, waitresult.attacker, 0);
    }
}

// Namespace flashgrenades/flashgrenades
// Params 3, eflags: 0x0
// Checksum 0x4957ac07, Offset: 0x820
// Size: 0x166
function applyflash(duration, rumbleduration, attacker) {
    if (!isdefined(self.var_53c623c1) || duration > self.var_53c623c1) {
        self.var_53c623c1 = duration;
    }
    if (!isdefined(self.var_b3800d86) || rumbleduration > self.var_b3800d86) {
        self.var_b3800d86 = rumbleduration;
    }
    self thread function_125a6838(duration);
    waitframe(1);
    if (isdefined(self.var_53c623c1)) {
        if (self hasperk("specialty_flashprotection") == 0) {
            self shellshock("flashbang", self.var_53c623c1, 0);
        }
        self.flashendtime = gettime() + self.var_53c623c1 * 1000;
        self.lastflashedby = attacker;
    }
    if (isdefined(self.var_b3800d86)) {
        self thread flashrumbleloop(self.var_b3800d86);
    }
    self.var_53c623c1 = undefined;
    self.var_b3800d86 = undefined;
}

// Namespace flashgrenades/flashgrenades
// Params 1, eflags: 0x0
// Checksum 0x14b0c871, Offset: 0x990
// Size: 0x16c
function function_125a6838(duration) {
    self endon(#"death");
    self endon(#"disconnect");
    var_d514ab92 = spawn("script_origin", (0, 0, 1));
    var_d514ab92.origin = self.origin;
    var_d514ab92 linkto(self);
    var_d514ab92 thread deleteentonownerdeath(self);
    var_d514ab92 playsound(level.var_ffec0318);
    var_d514ab92 playloopsound(level.var_330113ce);
    if (duration > 0.5) {
        wait duration - 0.5;
    }
    var_d514ab92 playsound(level.var_ffec0318);
    var_d514ab92 stoploopsound(0.5);
    wait 0.5;
    var_d514ab92 notify(#"delete");
    var_d514ab92 delete();
}

// Namespace flashgrenades/flashgrenades
// Params 1, eflags: 0x0
// Checksum 0xc567d2b4, Offset: 0xb08
// Size: 0x3c
function deleteentonownerdeath(owner) {
    self endon(#"delete");
    owner waittill("death");
    self delete();
}

