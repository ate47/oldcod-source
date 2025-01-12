#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/lui_shared;
#using scripts/core_common/postfx_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace gadget_overdrive;

// Namespace gadget_overdrive/gadget_overdrive
// Params 0, eflags: 0x2
// Checksum 0xbad09f5a, Offset: 0x438
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_overdrive", &__init__, undefined, undefined);
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 0, eflags: 0x0
// Checksum 0x8d2780bf, Offset: 0x478
// Size: 0xd4
function __init__() {
    callback::on_localclient_connect(&on_player_connect);
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    callback::on_localclient_shutdown(&on_localplayer_shutdown);
    clientfield::register("toplayer", "overdrive_state", 1, 1, "int", &player_overdrive_handler, 0, 1);
    visionset_mgr::register_visionset_info("overdrive", 1, 15, undefined, "overdrive_initialize");
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0xb273c6e3, Offset: 0x558
// Size: 0x24
function on_localplayer_shutdown(localclientnum) {
    self overdrive_shutdown(localclientnum);
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0x136ffb6b, Offset: 0x588
// Size: 0x6c
function on_localplayer_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    filter::init_filter_overdrive(self);
    filter::disable_filter_overdrive(self, 3);
    disablespeedblur(localclientnum);
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0xdbbc55f0, Offset: 0x600
// Size: 0xc
function on_player_connect(local_client_num) {
    
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 7, eflags: 0x0
// Checksum 0xd138dab3, Offset: 0x618
// Size: 0x214
function player_overdrive_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.localplayers[localclientnum]) && (!self islocalplayer() || isspectating(localclientnum, 0) || self getentitynumber() != level.localplayers[localclientnum] getentitynumber())) {
        return;
    }
    if (newval != oldval && newval) {
        enablespeedblur(localclientnum, getdvarfloat("scr_overdrive_amount", 0.15), getdvarfloat("scr_overdrive_inner_radius", 0.6), getdvarfloat("scr_overdrive_outer_radius", 1), getdvarint("scr_overdrive_velShouldScale", 1), getdvarint("scr_overdrive_velScale", 220));
        filter::enable_filter_overdrive(self, 3);
        self usealternateaimparams();
        self thread activation_flash(localclientnum);
        self boost_fx_on_velocity(localclientnum);
        return;
    }
    if (newval != oldval && !newval) {
        self overdrive_shutdown(localclientnum);
    }
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0x80045df0, Offset: 0x838
// Size: 0x13e
function activation_flash(localclientnum) {
    self notify(#"activation_flash");
    self endon(#"activation_flash");
    self endon(#"death");
    self endon(#"stop_player_fx");
    self endon(#"disable_cybercom");
    self.whiteflashfade = 1;
    lui::screen_fade(getdvarfloat("scr_overdrive_flash_fade_in_time", 0.075), getdvarfloat("scr_overdrive_flash_alpha", 0.7), 0, "white");
    wait getdvarfloat("scr_overdrive_flash_fade_in_time", 0.075);
    lui::screen_fade(getdvarfloat("scr_overdrive_flash_fade_out_time", 0.45), 0, getdvarfloat("scr_overdrive_flash_alpha", 0.7), "white");
    self.whiteflashfade = undefined;
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0xb146d7b, Offset: 0x980
// Size: 0x94
function enable_boost_camera_fx(localclientnum) {
    if (isdefined(self.firstperson_fx_overdrive)) {
        stopfx(localclientnum, self.firstperson_fx_overdrive);
        self.firstperson_fx_overdrive = undefined;
    }
    self.firstperson_fx_overdrive = playfxoncamera(localclientnum, "player/fx_plyr_ability_screen_blur_overdrive", (0, 0, 0), (1, 0, 0), (0, 0, 1));
    self thread watch_stop_player_fx(localclientnum, self.firstperson_fx_overdrive);
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 2, eflags: 0x0
// Checksum 0xad7a6287, Offset: 0xa20
// Size: 0x86
function watch_stop_player_fx(localclientnum, fx) {
    self notify(#"watch_stop_player_fx");
    self endon(#"watch_stop_player_fx");
    self endon(#"death");
    self waittill("stop_player_fx", "death", "disable_cybercom");
    if (isdefined(fx)) {
        stopfx(localclientnum, fx);
        self.firstperson_fx_overdrive = undefined;
    }
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0x8595d7c4, Offset: 0xab0
// Size: 0x8c
function stop_boost_camera_fx(localclientnum) {
    self notify(#"stop_player_fx");
    if (isdefined(self.whiteflashfade) && self.whiteflashfade) {
        lui::screen_fade(getdvarfloat("scr_overdrive_flash_fade_out_time", 0.45), 0, getdvarfloat("scr_overdrive_flash_alpha", 0.7), "white");
    }
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0xd856de8, Offset: 0xb48
// Size: 0x5c
function overdrive_boost_fx_interrupt_handler(localclientnum) {
    self endon(#"overdrive_boost_fx_interrupt_handler");
    self endon(#"end_overdrive_boost_fx");
    self endon(#"death");
    self waittill("death", "disable_cybercom");
    self overdrive_shutdown(localclientnum);
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0xa5236132, Offset: 0xbb0
// Size: 0x82
function overdrive_shutdown(localclientnum) {
    if (isdefined(localclientnum)) {
        self stop_boost_camera_fx(localclientnum);
        self clearalternateaimparams();
        filter::disable_filter_overdrive(self, 3);
        disablespeedblur(localclientnum);
        self notify(#"end_overdrive_boost_fx");
    }
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0x160dbf3d, Offset: 0xc40
// Size: 0x1d6
function boost_fx_on_velocity(localclientnum) {
    self endon(#"disable_cybercom");
    self endon(#"death");
    self endon(#"end_overdrive_boost_fx");
    self endon(#"disconnect");
    self enable_boost_camera_fx(localclientnum);
    self thread overdrive_boost_fx_interrupt_handler(localclientnum);
    wait getdvarfloat("scr_overdrive_boost_fx_time", 0.75);
    while (isdefined(self)) {
        v_player_velocity = self getvelocity();
        v_player_forward = anglestoforward(self.angles);
        n_dot = vectordot(vectornormalize(v_player_velocity), v_player_forward);
        n_speed = length(v_player_velocity);
        if (n_speed >= getdvarint("scr_overdrive_boost_speed_tol", 280) && n_dot > 0.8) {
            if (!isdefined(self.firstperson_fx_overdrive)) {
                self enable_boost_camera_fx(localclientnum);
            }
        } else if (isdefined(self.firstperson_fx_overdrive)) {
            self stop_boost_camera_fx(localclientnum);
        }
        waitframe(1);
    }
}

