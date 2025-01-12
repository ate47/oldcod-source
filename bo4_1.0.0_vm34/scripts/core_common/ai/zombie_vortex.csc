#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;

#namespace zombie_vortex;

// Namespace zombie_vortex/zombie_vortex
// Params 0, eflags: 0x2
// Checksum 0x803a6fb5, Offset: 0x1c0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"vortex", &__init__, undefined, undefined);
}

// Namespace zombie_vortex/zombie_vortex
// Params 0, eflags: 0x0
// Checksum 0x955d8a18, Offset: 0x208
// Size: 0x114
function __init__() {
    visionset_mgr::register_visionset_info("zm_idgun_vortex" + "_visionset", 1, 30, undefined, "zm_idgun_vortex");
    visionset_mgr::register_overlay_info_style_speed_blur("zm_idgun_vortex" + "_blur", 1, 1, 0.08, 0.75, 0.9);
    clientfield::register("scriptmover", "vortex_start", 1, 2, "counter", &start_vortex, 0, 0);
    clientfield::register("allplayers", "vision_blur", 1, 1, "int", &vision_blur, 0, 0);
}

// Namespace zombie_vortex/zombie_vortex
// Params 7, eflags: 0x0
// Checksum 0xcea667ef, Offset: 0x328
// Size: 0x1dc
function start_vortex(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(newval) || newval == 0) {
        return;
    }
    e_player = function_f97e7787(localclientnum);
    vposition = self.origin;
    newval -= oldval;
    if (newval == 2) {
        var_98194156 = "zombie/fx_idgun_vortex_ug_zod_zmb";
        fx_vortex_explosion = "zombie/fx_idgun_vortex_explo_ug_zod_zmb";
        n_vortex_time = 10;
    } else {
        var_98194156 = "zombie/fx_idgun_vortex_zod_zmb";
        fx_vortex_explosion = "zombie/fx_idgun_vortex_explo_zod_zmb";
        n_vortex_time = 5;
    }
    vortex_fx_handle = playfx(localclientnum, var_98194156, vposition);
    setfxignorepause(localclientnum, vortex_fx_handle, 1);
    playsound(0, #"wpn_idgun_portal_start", vposition);
    audio::playloopat("wpn_idgun_portal_loop", vposition);
    self thread vortex_shake_and_rumble(localclientnum, vposition);
    self thread function_69096485(localclientnum, vortex_fx_handle, vposition, fx_vortex_explosion, n_vortex_time);
}

// Namespace zombie_vortex/zombie_vortex
// Params 2, eflags: 0x0
// Checksum 0x61430fee, Offset: 0x510
// Size: 0x60
function vortex_shake_and_rumble(localclientnum, v_vortex_origin) {
    self endon(#"vortex_stop");
    while (true) {
        self playrumbleonentity(localclientnum, "zod_idgun_vortex_interior");
        wait 0.075;
    }
}

// Namespace zombie_vortex/zombie_vortex
// Params 7, eflags: 0x0
// Checksum 0xa096e1ab, Offset: 0x578
// Size: 0x8c
function vision_blur(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        enablespeedblur(localclientnum, 0.1, 0.5, 0.75);
        return;
    }
    disablespeedblur(localclientnum);
}

// Namespace zombie_vortex/zombie_vortex
// Params 5, eflags: 0x0
// Checksum 0xbf20805e, Offset: 0x610
// Size: 0x224
function function_69096485(localclientnum, vortex_fx_handle, vposition, fx_vortex_explosion, n_vortex_time) {
    e_player = function_f97e7787(localclientnum);
    n_starttime = e_player getclienttime();
    n_currtime = e_player getclienttime() - n_starttime;
    n_vortex_time = int(n_vortex_time * 1000);
    while (n_currtime < n_vortex_time) {
        waitframe(1);
        n_currtime = e_player getclienttime() - n_starttime;
    }
    stopfx(localclientnum, vortex_fx_handle);
    audio::stoploopat("wpn_idgun_portal_loop", vposition);
    playsound(0, #"wpn_idgun_portal_stop", vposition);
    wait 0.15;
    self notify(#"vortex_stop");
    var_7d342267 = playfx(localclientnum, fx_vortex_explosion, vposition);
    setfxignorepause(localclientnum, var_7d342267, 1);
    playsound(0, #"wpn_idgun_portal_explode", vposition);
    waitframe(1);
    self playrumbleonentity(localclientnum, "zod_idgun_vortex_shockwave");
    vision_blur(localclientnum, undefined, 1);
    wait 0.1;
    vision_blur(localclientnum, undefined, 0);
}

