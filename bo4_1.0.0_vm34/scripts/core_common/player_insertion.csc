#using script_1e43d05a138e08b9;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace player_insertion;

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x2
// Checksum 0xc498d93f, Offset: 0x298
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"player_insertion", &__init__, undefined, undefined);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0x93c64639, Offset: 0x2e0
// Size: 0xcc
function __init__() {
    spawnpoints = struct::get_array("infil_spawn", "targetname");
    /#
        if (spawnpoints.size == 0) {
            spawnpoints = struct::get_array("<dev string:x30>", "<dev string:x3f>");
        }
    #/
    if (spawnpoints.size != 0) {
        level.var_5823dc5c = spawnpoints;
    }
    init_clientfields();
    wz_wingsuit_hud::register("wz_wingsuit_hud");
    callback::on_localplayer_spawned(&on_localplayer_spawned);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xfe84cf0d, Offset: 0x3b8
// Size: 0x28c
function init_clientfields() {
    clientfield::register("vehicle", "infiltration_transport", 1, 1, "int", &function_f172face, 0, 0);
    clientfield::register("vehicle", "infiltration_landing_gear", 1, 1, "int", &function_a72fc87e, 0, 0);
    clientfield::register("toplayer", "infiltration_final_warning", 1, 1, "int", &function_2a2a1f11, 0, 0);
    clientfield::register("toplayer", "infiltration_rumble", 1, 1, "int", &function_75a8452b, 0, 0);
    clientfield::register("toplayer", "infiltration_vehicle", 1, 1, "int", &function_9e3223e4, 0, 0);
    clientfield::register("scriptmover", "infiltration_camera", 1, 2, "int", &function_5b683bb9, 0, 0);
    clientfield::register("scriptmover", "infiltration_jump_point", 1, 1, "int", &function_1c22d354, 0, 0);
    clientfield::register("scriptmover", "infiltration_force_drop_point", 1, 1, "int", &function_56d055ff, 0, 0);
    clientfield::register("toplayer", "heatblurpostfx", 1, 1, "int", &function_b84195d4, 0, 0);
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0xd148a672, Offset: 0x650
// Size: 0x1a4
function function_f172face(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (true) {
            self function_9019beea("tag_cargo_ramp_control_animate", 1);
            self function_9019beea("tag_door_left_control_animate", 1);
            self function_9019beea("tag_door_right_control_animate", 1);
        } else {
            self function_9019beea("tag_ramp_control_animate", 1);
        }
        self playsound(0, #"hash_329be5a324e42ee1");
        self playsound(0, #"hash_7ba1b4b83540b238");
        return;
    }
    if (true) {
        self function_9019beea("tag_cargo_ramp_control_animate", 0);
        self function_9019beea("tag_door_left_control_animate", 0);
        self function_9019beea("tag_door_right_control_animate", 0);
        return;
    }
    self function_9019beea("tag_ramp_control_animate", 0);
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0x2db33aaa, Offset: 0x800
// Size: 0x8c
function function_a72fc87e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (true) {
        if (newval) {
            self function_9019beea("tag_landing_gear_control_animate", 1);
            return;
        }
        self function_9019beea("tag_landing_gear_control_animate", 0);
    }
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0x80b44429, Offset: 0x898
// Size: 0x84
function function_2a2a1f11(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self function_40efd9db()) {
        if (newval == 1) {
            self playsound(0, #"hash_783bdfd900c11eed");
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0x63f62422, Offset: 0x928
// Size: 0xf6
function function_75a8452b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (newval == 1) {
        self playrumblelooponentity(0, #"hash_4250c3326e0f75e3");
        wait 1.2;
        self stoprumble(0, #"hash_4250c3326e0f75e3");
        self thread function_13807c26(localclientnum);
        return;
    }
    self stoprumble(0, #"hash_5f4c8cad06be5f5d");
    self notify(#"hash_6086f2e51a2e628a");
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x4
// Checksum 0xb57785a0, Offset: 0xa28
// Size: 0xd8
function private function_13807c26(localclientnum) {
    self notify("47daa1087bf664d1");
    self endon("47daa1087bf664d1");
    self endon(#"death");
    self endon(#"hash_6086f2e51a2e628a");
    while (true) {
        self playrumbleonentity(0, #"hash_5f4c8cad06be5f5d");
        wait 1.25;
        self stoprumble(0, #"hash_5f4c8cad06be5f5d");
        wait randomfloatrange(3, 5);
    }
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0xb63fb586, Offset: 0xb08
// Size: 0xf4
function function_5b683bb9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.var_8f0bf4fb = self;
    player = function_f97e7787(localclientnum);
    if (!isdefined(player)) {
        return;
    }
    if (newval == 0) {
        player camerasetupdatecallback();
        return;
    }
    if (newval == 1) {
        self camerasetupdatecallback(&function_2faec26b);
        return;
    }
    if (newval == 2) {
        self camerasetupdatecallback(&function_a907ddd5);
    }
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x0
// Checksum 0xfde5bbc6, Offset: 0xc08
// Size: 0x134
function function_2faec26b(localclientnum, delta_t) {
    player = function_f97e7787(localclientnum);
    if (!isdefined(player)) {
        return;
    }
    if (!isdefined(level.var_8f0bf4fb)) {
        player camerasetposition(player.origin);
        player camerasetlookat(player.angles);
        return;
    }
    focuspos = level.var_8f0bf4fb.origin;
    focusangles = level.var_8f0bf4fb.angles;
    cameravec = anglestoforward(focusangles);
    camerapos = focuspos - 1600 * cameravec;
    player camerasetposition(camerapos);
    player camerasetlookat(focusangles);
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x0
// Checksum 0x99ac960d, Offset: 0xd48
// Size: 0x134
function function_a907ddd5(localclientnum, delta_t) {
    player = function_f97e7787(localclientnum);
    if (!isdefined(player)) {
        return;
    }
    if (!isdefined(level.var_8f0bf4fb)) {
        player camerasetposition(player.origin);
        player camerasetlookat(player.angles);
        return;
    }
    focuspos = level.var_8f0bf4fb.origin;
    focusangles = player getcamangles();
    cameravec = anglestoforward(focusangles);
    camerapos = focuspos - 1600 * cameravec;
    player camerasetposition(camerapos);
    player camerasetlookat(focusangles);
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0xe1082123, Offset: 0xe88
// Size: 0x4a
function function_1c22d354(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.var_a448e28e = self;
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0x44bb1ab5, Offset: 0xee0
// Size: 0x4a
function function_56d055ff(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.var_a8ef8c25 = self;
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0xaed7f729, Offset: 0xf38
// Size: 0x24
function on_localplayer_spawned(localclientnum) {
    self thread function_e4b69622(localclientnum);
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0x8571705a, Offset: 0xf68
// Size: 0x1a4
function function_e4b69622(localclientnum) {
    self notify("51614b0a2b656af8");
    self endon("51614b0a2b656af8");
    self endon(#"death");
    self endon(#"hash_70483f3d5a2f87f0");
    while (true) {
        if (isdefined(level.var_a448e28e) && isdefined(level.var_a8ef8c25)) {
            break;
        }
        waitframe(1);
    }
    jump_point = level.var_a448e28e.origin;
    force_drop_point = level.var_a8ef8c25.origin;
    direction = anglestoforward(level.var_a448e28e.angles);
    start_point = jump_point - direction * 100000;
    end_point = force_drop_point + direction * 100000;
    var_7fddeb25 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.freeFallStartAltitude");
    setuimodelvalue(var_7fddeb25, jump_point[2]);
    function_f490e80f(localclientnum, start_point, end_point, jump_point, force_drop_point);
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0x8034d6b0, Offset: 0x1118
// Size: 0xd4
function function_9e3223e4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_636e7d72(1);
        function_19df4d41(localclientnum, 1);
        return;
    }
    self notify(#"hash_70483f3d5a2f87f0");
    function_8acf1886(localclientnum);
    function_19df4d41(localclientnum, 0);
    self function_636e7d72(0);
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x4
// Checksum 0x95f5acbb, Offset: 0x11f8
// Size: 0x84
function private function_b84195d4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self codeplaypostfxbundle("pstfx_heat_distortion");
        return;
    }
    self codestoppostfxbundle("pstfx_heat_distortion");
}

