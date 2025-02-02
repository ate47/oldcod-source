#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;

#namespace shellshock;

// Namespace shellshock/shellshock
// Params 0, eflags: 0x2
// Checksum 0x1e5a9ebb, Offset: 0xf8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"shellshock", &__init__, undefined, undefined);
}

// Namespace shellshock/shellshock
// Params 0, eflags: 0x0
// Checksum 0xc90fe500, Offset: 0x140
// Size: 0x3e
function __init__() {
    callback::on_start_gametype(&main);
    level.shellshockonplayerdamage = &on_damage;
}

// Namespace shellshock/shellshock
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x188
// Size: 0x4
function main() {
    
}

// Namespace shellshock/shellshock
// Params 3, eflags: 0x0
// Checksum 0xf2d1039d, Offset: 0x198
// Size: 0x12c
function on_damage(cause, damage, weapon) {
    if (cause == "MOD_EXPLOSIVE" || cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH" || cause == "MOD_PROJECTILE" || cause == "MOD_PROJECTILE_SPLASH") {
        time = 0;
        if (damage >= 90) {
            time = 4;
        } else if (damage >= 50) {
            time = 3;
        } else if (damage >= 25) {
            time = 2;
        } else if (damage > 10) {
            time = 2;
        }
        if (time) {
            if (self util::mayapplyscreeneffect()) {
                self shellshock(#"frag_grenade_mp", 0.5);
            }
        }
    }
}

// Namespace shellshock/shellshock
// Params 0, eflags: 0x0
// Checksum 0xe4adec9, Offset: 0x2d0
// Size: 0x2e
function endondeath() {
    self waittill(#"death");
    waittillframeend();
    self notify(#"end_explode");
}

// Namespace shellshock/shellshock
// Params 1, eflags: 0x0
// Checksum 0xc5b13f20, Offset: 0x308
// Size: 0x36
function endontimer(timer) {
    self endon(#"disconnect");
    wait timer;
    self notify(#"end_on_timer");
}

// Namespace shellshock/shellshock
// Params 1, eflags: 0x0
// Checksum 0x12e363e, Offset: 0x348
// Size: 0x54
function rcbomb_earthquake(position) {
    playrumbleonposition("grenade_rumble", position);
    earthquake(0.5, 0.5, self.origin, 512);
}

