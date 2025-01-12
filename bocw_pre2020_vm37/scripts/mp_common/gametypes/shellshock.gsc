#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\util;

#namespace shellshock;

// Namespace shellshock/shellshock
// Params 0, eflags: 0x6
// Checksum 0x403a6647, Offset: 0x108
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"shellshock", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace shellshock/shellshock
// Params 0, eflags: 0x5 linked
// Checksum 0x4d53a704, Offset: 0x150
// Size: 0x3c
function private function_70a657d8() {
    callback::on_start_gametype(&init);
    level.shellshockonplayerdamage = &on_damage;
}

// Namespace shellshock/shellshock
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x198
// Size: 0x4
function init() {
    
}

// Namespace shellshock/shellshock
// Params 5, eflags: 0x1 linked
// Checksum 0x7de0ed0c, Offset: 0x1a8
// Size: 0x184
function on_damage(eattacker, einflictor, weapon, smeansofdeath, idamage) {
    if (self util::isflashbanged()) {
        return;
    }
    if (self.health <= 0) {
        self clientfield::set_to_player("sndMelee", 0);
    }
    if (smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH") {
        if (weapon.explosionradius == 0) {
            return;
        }
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
// Checksum 0x37939301, Offset: 0x338
// Size: 0x2e
function end_on_death() {
    self waittill(#"death");
    waittillframeend();
    self notify(#"end_explode");
}

// Namespace shellshock/shellshock
// Params 1, eflags: 0x0
// Checksum 0xca9495ef, Offset: 0x370
// Size: 0x36
function end_on_timer(timer) {
    self endon(#"disconnect");
    wait timer;
    self notify(#"end_on_timer");
}

// Namespace shellshock/shellshock
// Params 1, eflags: 0x0
// Checksum 0xda781f31, Offset: 0x3b0
// Size: 0x54
function rcbomb_earthquake(position) {
    playrumbleonposition("grenade_rumble", position);
    earthquake(0.5, 0.5, self.origin, 512);
}

// Namespace shellshock/shellshock
// Params 0, eflags: 0x0
// Checksum 0x55badc42, Offset: 0x410
// Size: 0x4e
function reset_meleesnd() {
    self endon(#"death");
    wait 6;
    self clientfield::set_to_player("sndMelee", 0);
    self notify(#"snd_melee_end");
}

