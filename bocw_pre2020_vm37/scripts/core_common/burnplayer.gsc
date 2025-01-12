#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace burnplayer;

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x6
// Checksum 0xe6d43336, Offset: 0xc0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"burnplayer", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x5 linked
// Checksum 0xcb790cc6, Offset: 0x108
// Size: 0x64
function private function_70a657d8() {
    clientfield::register("allplayers", "burn", 1, 1, "int");
    clientfield::register("playercorpse", "burned_effect", 1, 1, "int");
}

// Namespace burnplayer/burnplayer
// Params 5, eflags: 0x1 linked
// Checksum 0xe110907e, Offset: 0x178
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
// Checksum 0x289bc6d8, Offset: 0x238
// Size: 0xbc
function takingburndamage(eattacker, weapon, *smeansofdeath) {
    if (isdefined(self.doing_scripted_burn_damage)) {
        self.doing_scripted_burn_damage = undefined;
        return;
    }
    if (smeansofdeath == level.weaponnone) {
        return;
    }
    if (smeansofdeath.burnduration == 0) {
        return;
    }
    self setplayerburning(float(smeansofdeath.burnduration) / 1000, float(smeansofdeath.burndamageinterval) / 1000, smeansofdeath.burndamage, weapon, smeansofdeath);
}

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x1 linked
// Checksum 0xa89233b3, Offset: 0x300
// Size: 0x5c
function watchburnfinished() {
    self endon(#"disconnect");
    self waittill(#"death", #"burn_finished");
    self clientfield::set("burn", 0);
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x1 linked
// Checksum 0x1e79eb4c, Offset: 0x368
// Size: 0x66
function watchburntimer(duration) {
    self notify(#"burnplayer_watchburntimer");
    self endon(#"burnplayer_watchburntimer", #"disconnect", #"death");
    wait duration;
    self notify(#"burn_finished");
}

// Namespace burnplayer/burnplayer
// Params 4, eflags: 0x1 linked
// Checksum 0x39be4eac, Offset: 0x3d8
// Size: 0xd2
function watchburndamage(interval, damage, attacker, weapon) {
    if (damage == 0) {
        return;
    }
    self endon(#"disconnect", #"death", #"burnplayer_watchburntimer", #"burn_finished");
    while (true) {
        wait interval;
        self.doing_scripted_burn_damage = 1;
        self dodamage(damage, self.origin, attacker, undefined, undefined, "MOD_BURNED", 0, weapon);
        self.doing_scripted_burn_damage = undefined;
    }
}

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x1 linked
// Checksum 0x256150af, Offset: 0x4b8
// Size: 0x74
function watchforwater() {
    self endon(#"disconnect", #"death", #"burn_finished");
    while (true) {
        if (self isplayerunderwater()) {
            self notify(#"burn_finished");
        }
        wait 0.05;
    }
}

