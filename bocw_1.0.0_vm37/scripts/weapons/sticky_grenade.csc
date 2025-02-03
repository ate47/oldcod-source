#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace sticky_grenade;

// Namespace sticky_grenade/sticky_grenade
// Params 0, eflags: 0x6
// Checksum 0x6bbae0fd, Offset: 0xe0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"sticky_grenade", &preinit, undefined, undefined, undefined);
}

// Namespace sticky_grenade/sticky_grenade
// Params 0, eflags: 0x4
// Checksum 0x1935b7c7, Offset: 0x128
// Size: 0x2a4
function private preinit() {
    callback::add_weapon_type(#"sticky_grenade", &spawned);
    callback::add_weapon_type(#"eq_sticky_grenade", &spawned);
    callback::add_weapon_type(#"hash_4b92b1a2aa3037f5", &spawned);
    callback::add_weapon_type(#"eq_cluster_semtex_grenade", &spawned);
    callback::add_weapon_type(#"hash_66401df7cd6bf292", &function_6054cc1e);
    callback::add_weapon_type(#"sig_bow_explosive", &function_117f61b8);
    callback::add_weapon_type(#"hash_494e1edad9bd44fd", &function_117f61b8);
    callback::add_weapon_type(#"hash_494e1ddad9bd434a", &function_117f61b8);
    callback::add_weapon_type(#"hash_494e18dad9bd3acb", &function_117f61b8);
    callback::add_weapon_type(#"sig_bow_quickshot", &spawned_arrow);
    callback::add_weapon_type(#"sig_bow_quickshot2", &spawned_arrow);
    callback::add_weapon_type(#"sig_bow_quickshot3", &spawned_arrow);
    callback::add_weapon_type(#"sig_bow_quickshot4", &spawned_arrow);
    callback::add_weapon_type(#"sig_bow_quickshot5", &spawned_arrow);
}

// Namespace sticky_grenade/sticky_grenade
// Params 1, eflags: 0x0
// Checksum 0xf8ce6dd6, Offset: 0x3d8
// Size: 0x44
function spawned(localclientnum) {
    if (self isgrenadedud()) {
        return;
    }
    self thread fx_think(localclientnum, 1);
}

// Namespace sticky_grenade/sticky_grenade
// Params 1, eflags: 0x0
// Checksum 0xb639bcc, Offset: 0x428
// Size: 0x44
function spawned_arrow(localclientnum) {
    if (self isgrenadedud()) {
        return;
    }
    self thread fx_think(localclientnum, 2);
}

// Namespace sticky_grenade/sticky_grenade
// Params 1, eflags: 0x0
// Checksum 0xfb6a70c7, Offset: 0x478
// Size: 0x3c
function function_6054cc1e(localclientnum) {
    if (self isgrenadedud()) {
        return;
    }
    self thread function_c879d0fd(localclientnum);
}

// Namespace sticky_grenade/sticky_grenade
// Params 1, eflags: 0x0
// Checksum 0x1c110083, Offset: 0x4c0
// Size: 0x74
function function_117f61b8(localclientnum) {
    if (self isgrenadedud()) {
        return;
    }
    handle = self playsound(localclientnum, #"wpn_semtex_countdown");
    self thread stop_sound_on_ent_shutdown(handle);
}

// Namespace sticky_grenade/sticky_grenade
// Params 1, eflags: 0x0
// Checksum 0xb70a8d9, Offset: 0x540
// Size: 0x34
function stop_sound_on_ent_shutdown(handle) {
    self waittill(#"death");
    stopsound(handle);
}

// Namespace sticky_grenade/sticky_grenade
// Params 2, eflags: 0x0
// Checksum 0xc315d72b, Offset: 0x580
// Size: 0x29a
function fx_think(localclientnum, var_1e60ee48) {
    self notify(#"light_disable");
    self endon(#"light_disable");
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    handle = self playsound(localclientnum, #"wpn_semtex_countdown");
    self thread stop_sound_on_ent_shutdown(handle);
    for (interval = 0.3; isdefined(self); interval = math::clamp(interval / 1.2, 0.08, 0.3)) {
        self stop_light_fx(localclientnum);
        localplayer = function_5c10bd79(localclientnum);
        if (!isdefined(localplayer)) {
            continue;
        }
        if (!localplayer isentitylinkedtotag(self, "j_head") && !localplayer isentitylinkedtotag(self, "j_elbow_le") && !localplayer isentitylinkedtotag(self, "j_spineupper")) {
            if (isdefined(self.weapon.customsettings)) {
                var_e6fbac16 = getscriptbundle(self.weapon.customsettings);
                if (isdefined(var_e6fbac16.var_b941081f) && isdefined(var_e6fbac16.var_40772cbe)) {
                    self start_light_fx(localclientnum, var_e6fbac16.var_b941081f, var_e6fbac16.var_40772cbe);
                }
            }
        }
        self fullscreen_fx(localclientnum, var_1e60ee48);
        util::server_wait(localclientnum, interval, 0.01, "player_switch");
        self util::waittill_dobj(localclientnum);
    }
}

// Namespace sticky_grenade/sticky_grenade
// Params 3, eflags: 0x0
// Checksum 0x5817cd72, Offset: 0x828
// Size: 0x52
function start_light_fx(localclientnum, fx, tag) {
    self stop_light_fx(localclientnum);
    self.fx = util::playfxontag(localclientnum, fx, self, tag);
}

// Namespace sticky_grenade/sticky_grenade
// Params 1, eflags: 0x0
// Checksum 0x758e2686, Offset: 0x888
// Size: 0x4e
function stop_light_fx(localclientnum) {
    if (isdefined(self.fx) && self.fx != 0) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

// Namespace sticky_grenade/sticky_grenade
// Params 1, eflags: 0x0
// Checksum 0xac9f3959, Offset: 0x8e0
// Size: 0x17a
function function_c879d0fd(localclientnum) {
    self notify(#"light_disable");
    self endon(#"light_disable");
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    interval = 0.3;
    if (isdefined(self.weapon.customsettings)) {
        var_e6fbac16 = getscriptbundle(self.weapon.customsettings);
        if (isdefined(var_e6fbac16.var_b941081f) && isdefined(var_e6fbac16.var_40772cbe)) {
            for (;;) {
                self stop_light_fx(localclientnum);
                self start_light_fx(localclientnum, var_e6fbac16.var_b941081f, var_e6fbac16.var_40772cbe);
                util::server_wait(localclientnum, interval, 0.01, "player_switch");
                self util::waittill_dobj(localclientnum);
                interval = math::clamp(interval / 1.2, 0.08, 0.3);
            }
        }
    }
}

// Namespace sticky_grenade/sticky_grenade
// Params 2, eflags: 0x0
// Checksum 0x88f6a3e7, Offset: 0xa68
// Size: 0xd8
function sticky_indicator(localclientnum, indicator) {
    stickyimagemodel = createuimodel(function_1df4c3b0(localclientnum, #"hud_items"), "stuckImageIndex");
    setuimodelvalue(stickyimagemodel, indicator);
    player = function_5c10bd79(localclientnum);
    while (isdefined(self)) {
        waitframe(1);
    }
    setuimodelvalue(stickyimagemodel, 0);
    if (isdefined(player)) {
        player notify(#"sticky_shutdown");
    }
}

// Namespace sticky_grenade/sticky_grenade
// Params 2, eflags: 0x0
// Checksum 0x7955b9ef, Offset: 0xb48
// Size: 0x124
function fullscreen_fx(localclientnum, indicator) {
    if (function_1cbf351b(localclientnum)) {
        return;
    }
    if (util::is_player_view_linked_to_entity(localclientnum)) {
        return;
    }
    if (self function_ca024039()) {
        return;
    }
    parent = self getparententity();
    if (isdefined(parent) && parent function_21c0fa55()) {
        parent playrumbleonentity(localclientnum, "buzz_high");
        self playsound(localclientnum, #"wpn_semtex_alert");
        if (getdvarint(#"ui_hud_hardcore", 0) == 0) {
            self thread sticky_indicator(localclientnum, indicator);
        }
    }
}

