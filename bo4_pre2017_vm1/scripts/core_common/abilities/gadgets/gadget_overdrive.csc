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
function autoexec function_2dc19561() {
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
    clientfield::register("toplayer", "overdrive_state", 1, 1, "int", &function_6c1d8418, 0, 1);
    visionset_mgr::register_visionset_info("overdrive", 1, 15, undefined, "overdrive_initialize");
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0xb273c6e3, Offset: 0x558
// Size: 0x24
function on_localplayer_shutdown(localclientnum) {
    self function_8e10aa46(localclientnum);
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0x136ffb6b, Offset: 0x588
// Size: 0x6c
function on_localplayer_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    filter::function_1f1af853(self);
    filter::function_d17703cb(self, 3);
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
function function_6c1d8418(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.localplayers[localclientnum]) && (!self islocalplayer() || isspectating(localclientnum, 0) || self getentitynumber() != level.localplayers[localclientnum] getentitynumber())) {
        return;
    }
    if (newval != oldval && newval) {
        enablespeedblur(localclientnum, getdvarfloat("scr_overdrive_amount", 0.15), getdvarfloat("scr_overdrive_inner_radius", 0.6), getdvarfloat("scr_overdrive_outer_radius", 1), getdvarint("scr_overdrive_velShouldScale", 1), getdvarint("scr_overdrive_velScale", 220));
        filter::function_46839542(self, 3);
        self usealternateaimparams();
        self thread function_435df4ae(localclientnum);
        self function_7f9030dd(localclientnum);
        return;
    }
    if (newval != oldval && !newval) {
        self function_8e10aa46(localclientnum);
    }
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0x80045df0, Offset: 0x838
// Size: 0x13e
function function_435df4ae(localclientnum) {
    self notify(#"hash_435df4ae");
    self endon(#"hash_435df4ae");
    self endon(#"death");
    self endon(#"stop_player_fx");
    self endon(#"disable_cybercom");
    self.var_e9fb6bcc = 1;
    lui::screen_fade(getdvarfloat("scr_overdrive_flash_fade_in_time", 0.075), getdvarfloat("scr_overdrive_flash_alpha", 0.7), 0, "white");
    wait getdvarfloat("scr_overdrive_flash_fade_in_time", 0.075);
    lui::screen_fade(getdvarfloat("scr_overdrive_flash_fade_out_time", 0.45), 0, getdvarfloat("scr_overdrive_flash_alpha", 0.7), "white");
    self.var_e9fb6bcc = undefined;
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0xb146d7b, Offset: 0x980
// Size: 0x94
function function_f8cd963(localclientnum) {
    if (isdefined(self.var_f913815c)) {
        stopfx(localclientnum, self.var_f913815c);
        self.var_f913815c = undefined;
    }
    self.var_f913815c = playfxoncamera(localclientnum, "player/fx_plyr_ability_screen_blur_overdrive", (0, 0, 0), (1, 0, 0), (0, 0, 1));
    self thread function_795d8024(localclientnum, self.var_f913815c);
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 2, eflags: 0x0
// Checksum 0xad7a6287, Offset: 0xa20
// Size: 0x86
function function_795d8024(localclientnum, fx) {
    self notify(#"hash_795d8024");
    self endon(#"hash_795d8024");
    self endon(#"death");
    self waittill("stop_player_fx", "death", "disable_cybercom");
    if (isdefined(fx)) {
        stopfx(localclientnum, fx);
        self.var_f913815c = undefined;
    }
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0x8595d7c4, Offset: 0xab0
// Size: 0x8c
function function_26d7266e(localclientnum) {
    self notify(#"stop_player_fx");
    if (isdefined(self.var_e9fb6bcc) && self.var_e9fb6bcc) {
        lui::screen_fade(getdvarfloat("scr_overdrive_flash_fade_out_time", 0.45), 0, getdvarfloat("scr_overdrive_flash_alpha", 0.7), "white");
    }
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0xd856de8, Offset: 0xb48
// Size: 0x5c
function function_2e0c658b(localclientnum) {
    self endon(#"hash_2e0c658b");
    self endon(#"hash_6cc6e004");
    self endon(#"death");
    self waittill("death", "disable_cybercom");
    self function_8e10aa46(localclientnum);
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0xa5236132, Offset: 0xbb0
// Size: 0x82
function function_8e10aa46(localclientnum) {
    if (isdefined(localclientnum)) {
        self function_26d7266e(localclientnum);
        self clearalternateaimparams();
        filter::function_d17703cb(self, 3);
        disablespeedblur(localclientnum);
        self notify(#"hash_6cc6e004");
    }
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0x160dbf3d, Offset: 0xc40
// Size: 0x1d6
function function_7f9030dd(localclientnum) {
    self endon(#"disable_cybercom");
    self endon(#"death");
    self endon(#"hash_6cc6e004");
    self endon(#"disconnect");
    self function_f8cd963(localclientnum);
    self thread function_2e0c658b(localclientnum);
    wait getdvarfloat("scr_overdrive_boost_fx_time", 0.75);
    while (isdefined(self)) {
        v_player_velocity = self getvelocity();
        v_player_forward = anglestoforward(self.angles);
        n_dot = vectordot(vectornormalize(v_player_velocity), v_player_forward);
        n_speed = length(v_player_velocity);
        if (n_speed >= getdvarint("scr_overdrive_boost_speed_tol", 280) && n_dot > 0.8) {
            if (!isdefined(self.var_f913815c)) {
                self function_f8cd963(localclientnum);
            }
        } else if (isdefined(self.var_f913815c)) {
            self function_26d7266e(localclientnum);
        }
        waitframe(1);
    }
}

