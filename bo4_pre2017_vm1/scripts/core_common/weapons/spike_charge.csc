#using scripts/core_common/callbacks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/postfx_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace sticky_grenade;

// Namespace sticky_grenade/spike_charge
// Params 0, eflags: 0x2
// Checksum 0xa9797601, Offset: 0x1f8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("spike_charge", &__init__, undefined, undefined);
}

// Namespace sticky_grenade/spike_charge
// Params 0, eflags: 0x0
// Checksum 0x7db222f9, Offset: 0x238
// Size: 0x9c
function __init__() {
    level._effect["spike_light"] = "weapon/fx_light_spike_launcher";
    callback::add_weapon_type("spike_launcher", &spawned);
    callback::add_weapon_type("spike_launcher_cpzm", &spawned);
    callback::add_weapon_type("spike_charge", &spawned_spike_charge);
}

// Namespace sticky_grenade/spike_charge
// Params 1, eflags: 0x0
// Checksum 0xdebc29f1, Offset: 0x2e0
// Size: 0x24
function spawned(localclientnum) {
    self thread fx_think(localclientnum);
}

// Namespace sticky_grenade/spike_charge
// Params 1, eflags: 0x0
// Checksum 0x6147669b, Offset: 0x310
// Size: 0x3c
function spawned_spike_charge(localclientnum) {
    self thread fx_think(localclientnum);
    self thread spike_detonation(localclientnum);
}

// Namespace sticky_grenade/spike_charge
// Params 1, eflags: 0x0
// Checksum 0xc96503a2, Offset: 0x358
// Size: 0x10c
function fx_think(localclientnum) {
    self notify(#"light_disable");
    self endon(#"death");
    self endon(#"light_disable");
    self util::waittill_dobj(localclientnum);
    for (interval = 0.3; ; interval = math::clamp(interval / 1.2, 0.08, 0.3)) {
        self stop_light_fx(localclientnum);
        self start_light_fx(localclientnum);
        util::server_wait(localclientnum, interval, 0.01, "player_switch");
        self util::waittill_dobj(localclientnum);
    }
}

// Namespace sticky_grenade/spike_charge
// Params 1, eflags: 0x0
// Checksum 0x455c54dc, Offset: 0x470
// Size: 0x6c
function start_light_fx(localclientnum) {
    player = getlocalplayer(localclientnum);
    self.fx = playfxontag(localclientnum, level._effect["spike_light"], self, "tag_fx");
}

// Namespace sticky_grenade/spike_charge
// Params 1, eflags: 0x0
// Checksum 0x9fc7d2bb, Offset: 0x4e8
// Size: 0x56
function stop_light_fx(localclientnum) {
    if (isdefined(self.fx) && self.fx != 0) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

// Namespace sticky_grenade/spike_charge
// Params 1, eflags: 0x0
// Checksum 0x44535380, Offset: 0x548
// Size: 0x104
function spike_detonation(localclientnum) {
    spike_position = self.origin;
    while (isdefined(self)) {
        waitframe(1);
    }
    if (!isigcactive(localclientnum)) {
        player = getlocalplayer(localclientnum);
        explosion_distance = distancesquared(spike_position, player.origin);
        if (explosion_distance <= 450 * 450) {
            player thread postfx::playpostfxbundle("pstfx_dust_chalk");
        }
        if (explosion_distance <= 300 * 300) {
            player thread postfx::playpostfxbundle("pstfx_dust_concrete");
        }
    }
}

