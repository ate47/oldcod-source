#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;

#namespace shellshock;

// Namespace shellshock/shellshock
// Params 0, eflags: 0x6
// Checksum 0x2342191b, Offset: 0x100
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"shellshock", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace shellshock/shellshock
// Params 0, eflags: 0x5 linked
// Checksum 0xf26cef21, Offset: 0x148
// Size: 0x3c
function private function_70a657d8() {
    callback::on_start_gametype(&main);
    level.shellshockonplayerdamage = &on_damage;
}

// Namespace shellshock/shellshock
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x190
// Size: 0x4
function main() {
    
}

// Namespace shellshock/shellshock
// Params 5, eflags: 0x1 linked
// Checksum 0x1035682, Offset: 0x1a0
// Size: 0x12c
function on_damage(eattacker, einflictor, weapon, smeansofdeath, idamage) {
    if (smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH") {
        if (idamage > 10) {
            if (self util::mayapplyscreeneffect() && self hasperk(#"specialty_flakjacket") == 0) {
                if (isdefined(einflictor.var_63be5750)) {
                    self [[ einflictor.var_63be5750 ]](eattacker, einflictor, weapon, smeansofdeath, idamage);
                    return;
                }
                self shellshock(#"frag_grenade_mp", 0.5);
            }
        }
    }
}

// Namespace shellshock/shellshock
// Params 0, eflags: 0x0
// Checksum 0xbc64fdbb, Offset: 0x2d8
// Size: 0x2e
function endondeath() {
    self waittill(#"death");
    waittillframeend();
    self notify(#"end_explode");
}

// Namespace shellshock/shellshock
// Params 1, eflags: 0x0
// Checksum 0xd7ce39a7, Offset: 0x310
// Size: 0x36
function endontimer(timer) {
    self endon(#"disconnect");
    wait timer;
    self notify(#"end_on_timer");
}

// Namespace shellshock/shellshock
// Params 1, eflags: 0x0
// Checksum 0xc6df4b0f, Offset: 0x350
// Size: 0x54
function rcbomb_earthquake(position) {
    playrumbleonposition("grenade_rumble", position);
    earthquake(0.5, 0.5, self.origin, 512);
}

