#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace burnplayer;

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x2
// Checksum 0x5970911f, Offset: 0x198
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("burnplayer", &__init__, undefined, undefined);
}

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x0
// Checksum 0xab34dbad, Offset: 0x1d8
// Size: 0x64
function __init__() {
    clientfield::register("allplayers", "burn", 1, 1, "int");
    clientfield::register("playercorpse", "burned_effect", 1, 1, "int");
}

// Namespace burnplayer/burnplayer
// Params 5, eflags: 0x0
// Checksum 0x9009e751, Offset: 0x248
// Size: 0xbc
function setplayerburning(duration, interval, damageperinterval, attacker, weapon) {
    self clientfield::set("burn", 1);
    self thread watchburntimer(duration);
    self thread watchburndamage(interval, damageperinterval, attacker, weapon);
    self thread watchforwater();
    self thread watchburnfinished();
}

// Namespace burnplayer/burnplayer
// Params 3, eflags: 0x0
// Checksum 0x17dcfc56, Offset: 0x310
// Size: 0xb4
function takingburndamage(eattacker, weapon, smeansofdeath) {
    if (isdefined(self.doing_scripted_burn_damage)) {
        self.doing_scripted_burn_damage = undefined;
        return;
    }
    if (weapon == level.weaponnone) {
        return;
    }
    if (weapon.burnduration == 0) {
        return;
    }
    self setplayerburning(weapon.burnduration / 1000, weapon.burndamageinterval / 1000, weapon.burndamage, eattacker, weapon);
}

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x0
// Checksum 0x490d871c, Offset: 0x3d0
// Size: 0x44
function watchburnfinished() {
    self endon(#"disconnect");
    self waittill("death", "burn_finished");
    self clientfield::set("burn", 0);
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x0
// Checksum 0x72ec748f, Offset: 0x420
// Size: 0x52
function watchburntimer(duration) {
    self notify(#"burnplayer_watchburntimer");
    self endon(#"burnplayer_watchburntimer");
    self endon(#"disconnect");
    self endon(#"death");
    wait duration;
    self notify(#"burn_finished");
}

// Namespace burnplayer/burnplayer
// Params 4, eflags: 0x0
// Checksum 0xa07a43d6, Offset: 0x480
// Size: 0xc2
function watchburndamage(interval, damage, attacker, weapon) {
    if (damage == 0) {
        return;
    }
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"burnplayer_watchburntimer");
    self endon(#"burn_finished");
    while (true) {
        wait interval;
        self.doing_scripted_burn_damage = 1;
        self dodamage(damage, self.origin, attacker, undefined, undefined, "MOD_BURNED", 0, weapon);
        self.doing_scripted_burn_damage = undefined;
    }
}

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x0
// Checksum 0xf68db246, Offset: 0x550
// Size: 0x60
function watchforwater() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"burn_finished");
    while (true) {
        if (self isplayerunderwater()) {
            self notify(#"burn_finished");
        }
        wait 0.05;
    }
}

