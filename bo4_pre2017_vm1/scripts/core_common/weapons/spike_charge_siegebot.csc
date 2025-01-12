#using scripts/core_common/callbacks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace spike_charge_siegebot;

// Namespace spike_charge_siegebot/spike_charge_siegebot
// Params 0, eflags: 0x2
// Checksum 0xa6a0dea3, Offset: 0x230
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("spike_charge_siegebot", &__init__, undefined, undefined);
}

// Namespace spike_charge_siegebot/spike_charge_siegebot
// Params 0, eflags: 0x0
// Checksum 0x37c74b58, Offset: 0x270
// Size: 0xec
function __init__() {
    level._effect["spike_charge_siegebot_light"] = "light/fx_light_red_spike_charge_os";
    callback::add_weapon_type("spike_charge_siegebot", &spawned);
    callback::add_weapon_type("spike_charge_siegebot_theia", &spawned);
    callback::add_weapon_type("siegebot_launcher_turret", &spawned);
    callback::add_weapon_type("siegebot_launcher_turret_theia", &spawned);
    callback::add_weapon_type("siegebot_javelin_turret", &spawned);
}

// Namespace spike_charge_siegebot/spike_charge_siegebot
// Params 1, eflags: 0x0
// Checksum 0xaf0d15a1, Offset: 0x368
// Size: 0x24
function spawned(localclientnum) {
    self thread fx_think(localclientnum);
}

// Namespace spike_charge_siegebot/spike_charge_siegebot
// Params 1, eflags: 0x0
// Checksum 0x6e0b180, Offset: 0x398
// Size: 0x12c
function fx_think(localclientnum) {
    self notify(#"light_disable");
    self endon(#"death");
    self endon(#"light_disable");
    self util::waittill_dobj(localclientnum);
    for (interval = 0.3; ; interval = math::clamp(interval / 1.2, 0.08, 0.3)) {
        self stop_light_fx(localclientnum);
        self start_light_fx(localclientnum);
        self playsound(localclientnum, "wpn_semtex_alert");
        util::server_wait(localclientnum, interval, 0.01, "player_switch");
        self util::waittill_dobj(localclientnum);
    }
}

// Namespace spike_charge_siegebot/spike_charge_siegebot
// Params 1, eflags: 0x0
// Checksum 0x1a8bf9dc, Offset: 0x4d0
// Size: 0x6c
function start_light_fx(localclientnum) {
    player = getlocalplayer(localclientnum);
    self.fx = playfxontag(localclientnum, level._effect["spike_charge_siegebot_light"], self, "tag_fx");
}

// Namespace spike_charge_siegebot/spike_charge_siegebot
// Params 1, eflags: 0x0
// Checksum 0x1961527f, Offset: 0x548
// Size: 0x56
function stop_light_fx(localclientnum) {
    if (isdefined(self.fx) && self.fx != 0) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

