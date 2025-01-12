#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace burnplayer;

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x2
// Checksum 0xe66f88fe, Offset: 0xb8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"burnplayer", &__init__, undefined, undefined);
}

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x0
// Checksum 0x6869c399, Offset: 0x100
// Size: 0x64
function __init__() {
    clientfield::register("allplayers", "burn", 1, 1, "int");
    clientfield::register("playercorpse", "burned_effect", 1, 1, "int");
}

// Namespace burnplayer/burnplayer
// Params 5, eflags: 0x0
// Checksum 0xabbf34e7, Offset: 0x170
// Size: 0xb4
function setplayerburning(duration, interval, damageperinterval, attacker, weapon) {
    self clientfield::set("burn", 1);
    self thread watchburntimer(duration);
    self thread watchburndamage(interval, damageperinterval, attacker, weapon);
    self thread watchforwater();
    self thread watchburnfinished();
}

// Namespace burnplayer/burnplayer
// Params 3, eflags: 0x0
// Checksum 0x97922a4d, Offset: 0x230
// Size: 0xc4
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
    self setplayerburning(float(weapon.burnduration) / 1000, float(weapon.burndamageinterval) / 1000, weapon.burndamage, eattacker, weapon);
}

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x0
// Checksum 0x7417079d, Offset: 0x300
// Size: 0x5c
function watchburnfinished() {
    self endon(#"disconnect");
    self waittill(#"death", #"burn_finished");
    self clientfield::set("burn", 0);
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x0
// Checksum 0xef8ba0a5, Offset: 0x368
// Size: 0x66
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
// Checksum 0x4cd8eb1e, Offset: 0x3d8
// Size: 0xd2
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
// Checksum 0xb5ee0efa, Offset: 0x4b8
// Size: 0x74
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

