#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace sticky_grenade;

// Namespace sticky_grenade/spike_charge
// Params 0, eflags: 0x6
// Checksum 0xfad9d29d, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"spike_charge", &preinit, undefined, undefined, undefined);
}

// Namespace sticky_grenade/spike_charge
// Params 0, eflags: 0x4
// Checksum 0x8e7a0b00, Offset: 0xf0
// Size: 0xbc
function private preinit() {
    level._effect[#"spike_light"] = #"weapon/fx_light_spike_launcher";
    callback::add_weapon_type(#"spike_launcher", &spawned);
    callback::add_weapon_type(#"spike_launcher_cpzm", &spawned);
    callback::add_weapon_type(#"spike_charge", &spawned_spike_charge);
}

// Namespace sticky_grenade/spike_charge
// Params 1, eflags: 0x0
// Checksum 0x7c66c681, Offset: 0x1b8
// Size: 0x24
function spawned(localclientnum) {
    self thread fx_think(localclientnum);
}

// Namespace sticky_grenade/spike_charge
// Params 1, eflags: 0x0
// Checksum 0xcc3ddf39, Offset: 0x1e8
// Size: 0x3c
function spawned_spike_charge(localclientnum) {
    self thread fx_think(localclientnum);
    self thread spike_detonation(localclientnum);
}

// Namespace sticky_grenade/spike_charge
// Params 1, eflags: 0x0
// Checksum 0xf1abb71c, Offset: 0x230
// Size: 0x10a
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
// Checksum 0xa2f7aae8, Offset: 0x348
// Size: 0x4a
function start_light_fx(localclientnum) {
    self.fx = util::playfxontag(localclientnum, level._effect[#"spike_light"], self, "tag_fx");
}

// Namespace sticky_grenade/spike_charge
// Params 1, eflags: 0x0
// Checksum 0x8a8dc7b2, Offset: 0x3a0
// Size: 0x4e
function stop_light_fx(localclientnum) {
    if (isdefined(self.fx) && self.fx != 0) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

// Namespace sticky_grenade/spike_charge
// Params 1, eflags: 0x0
// Checksum 0xda79f40, Offset: 0x3f8
// Size: 0x114
function spike_detonation(localclientnum) {
    spike_position = self.origin;
    while (isdefined(self)) {
        waitframe(1);
    }
    if (!isigcactive(localclientnum)) {
        player = function_5c10bd79(localclientnum);
        explosion_distance = distancesquared(spike_position, player.origin);
        if (explosion_distance <= sqr(450)) {
            player thread postfx::playpostfxbundle(#"pstfx_dust_chalk");
        }
        if (explosion_distance <= sqr(300)) {
            player thread postfx::playpostfxbundle(#"pstfx_dust_concrete");
        }
    }
}

