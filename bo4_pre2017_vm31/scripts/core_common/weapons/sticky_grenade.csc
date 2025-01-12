#using scripts/core_common/callbacks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace sticky_grenade;

// Namespace sticky_grenade/sticky_grenade
// Params 0, eflags: 0x2
// Checksum 0xc2efe296, Offset: 0x208
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("sticky_grenade", &__init__, undefined, undefined);
}

// Namespace sticky_grenade/sticky_grenade
// Params 0, eflags: 0x0
// Checksum 0x87b4870b, Offset: 0x248
// Size: 0x4c
function __init__() {
    level._effect["grenade_light"] = "weapon/fx_equip_light_os";
    callback::add_weapon_type("sticky_grenade", &spawned);
}

// Namespace sticky_grenade/sticky_grenade
// Params 1, eflags: 0x0
// Checksum 0xab48f6a6, Offset: 0x2a0
// Size: 0x44
function spawned(localclientnum) {
    if (self isgrenadedud()) {
        return;
    }
    self thread fx_think(localclientnum);
}

// Namespace sticky_grenade/sticky_grenade
// Params 1, eflags: 0x0
// Checksum 0xd50ee205, Offset: 0x2f0
// Size: 0x34
function stop_sound_on_ent_shutdown(handle) {
    self waittill("death");
    stopsound(handle);
}

// Namespace sticky_grenade/sticky_grenade
// Params 1, eflags: 0x0
// Checksum 0x6c37cc90, Offset: 0x330
// Size: 0x20c
function fx_think(localclientnum) {
    self notify(#"light_disable");
    self endon(#"light_disable");
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    handle = self playsound(localclientnum, "wpn_semtex_countdown");
    self thread stop_sound_on_ent_shutdown(handle);
    for (interval = 0.3; ; interval = math::clamp(interval / 1.2, 0.08, 0.3)) {
        self stop_light_fx(localclientnum);
        localplayer = getlocalplayer(localclientnum);
        if (!localplayer isentitylinkedtotag(self, "j_head") && !localplayer isentitylinkedtotag(self, "j_elbow_le") && !localplayer isentitylinkedtotag(self, "j_spineupper")) {
            self start_light_fx(localclientnum);
        }
        self fullscreen_fx(localclientnum);
        util::server_wait(localclientnum, interval, 0.01, "player_switch");
        self util::waittill_dobj(localclientnum);
    }
}

// Namespace sticky_grenade/sticky_grenade
// Params 1, eflags: 0x0
// Checksum 0xec2d9b1f, Offset: 0x548
// Size: 0x6c
function start_light_fx(localclientnum) {
    player = getlocalplayer(localclientnum);
    self.fx = playfxontag(localclientnum, level._effect["grenade_light"], self, "tag_fx");
}

// Namespace sticky_grenade/sticky_grenade
// Params 1, eflags: 0x0
// Checksum 0x9b135a0f, Offset: 0x5c0
// Size: 0x56
function stop_light_fx(localclientnum) {
    if (isdefined(self.fx) && self.fx != 0) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

// Namespace sticky_grenade/sticky_grenade
// Params 2, eflags: 0x0
// Checksum 0xd63eeb4c, Offset: 0x620
// Size: 0xcc
function sticky_indicator(player, localclientnum) {
    controllermodel = getuimodelforcontroller(localclientnum);
    stickyimagemodel = createuimodel(controllermodel, "hudItems.stickyImage");
    setuimodelvalue(stickyimagemodel, 1);
    player thread function_d3627562(stickyimagemodel);
    while (isdefined(self)) {
        waitframe(1);
    }
    setuimodelvalue(stickyimagemodel, 0);
    player notify(#"sticky_shutdown");
}

// Namespace sticky_grenade/sticky_grenade
// Params 1, eflags: 0x0
// Checksum 0x5e6388a7, Offset: 0x6f8
// Size: 0x4c
function function_d3627562(stickyimagemodel) {
    self endon(#"sticky_shutdown");
    self endon(#"death");
    self waittill("player_flashback");
    setuimodelvalue(stickyimagemodel, 0);
}

// Namespace sticky_grenade/sticky_grenade
// Params 1, eflags: 0x0
// Checksum 0xfc5c523c, Offset: 0x750
// Size: 0x12c
function fullscreen_fx(localclientnum) {
    player = getlocalplayer(localclientnum);
    if (isdefined(player)) {
        if (player getinkillcam(localclientnum)) {
            return;
        } else if (player util::is_player_view_linked_to_entity(localclientnum)) {
            return;
        }
    }
    if (self isfriendly(localclientnum)) {
        return;
    }
    parent = self getparententity();
    if (isdefined(parent) && parent == player) {
        parent playrumbleonentity(localclientnum, "buzz_high");
        if (getdvarint("ui_hud_hardcore") == 0) {
            self thread sticky_indicator(player, localclientnum);
        }
    }
}

