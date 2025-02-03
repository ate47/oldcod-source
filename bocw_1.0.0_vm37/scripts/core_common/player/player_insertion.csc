#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace player_insertion;

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x6
// Checksum 0xb463f3db, Offset: 0x368
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"player_insertion", &preinit, undefined, undefined, undefined);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x4
// Checksum 0xb00d7bf9, Offset: 0x3b0
// Size: 0x114
function private preinit() {
    if (level.var_f2814a96 !== 0 && level.var_f2814a96 !== 2) {
        return;
    }
    level.playerinsertion = 1;
    spawnpoints = struct::get_array("infil_spawn", "targetname");
    /#
        if (spawnpoints.size == 0) {
            spawnpoints = struct::get_array("<dev string:x38>", "<dev string:x4a>");
        }
    #/
    if (spawnpoints.size != 0) {
        level.var_1194a9a5 = spawnpoints;
    }
    init_clientfields();
    level.var_a3c42585 = getgametypesetting(#"hash_15a01ec180d4ba8e");
    callback::on_localclient_connect(&on_localclient_connect);
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xeec2ee91, Offset: 0x4d0
// Size: 0x42c
function init_clientfields() {
    clientfield::register("vehicle", "infiltration_transport", 1, 1, "int", &function_d8beedc9, 0, 0);
    clientfield::register("vehicle", "infiltration_landing_gear", 1, 1, "int", &function_ba7d9848, 0, 0);
    clientfield::register("toplayer", "infiltration_jump_warning", 1, 1, "int", &function_ded53cc6, 0, 0);
    clientfield::register("toplayer", "infiltration_final_warning", 1, 1, "int", &function_ea3cc318, 0, 0);
    clientfield::register("toplayer", "inside_infiltration_vehicle", 1, 1, "int", &inside_infiltration_vehicle, 0, 0);
    clientfield::register("world", "infiltration_compass", 1, 2, "int", &function_4da7bee9, 0, 0);
    clientfield::register("scriptmover", "infiltration_camera", 1, 3, "int", &function_7bac6764, 0, 0);
    clientfield::register("scriptmover", "infiltration_plane", 1, 2, "int", &infil_plane, 0, 0);
    clientfield::register("scriptmover", "infiltration_ent", 1, 2, "int", &infil_ent, 0, 0);
    clientfield::register("scriptmover", "infiltration_jump_point", 1, 2, "int", &function_73a03a18, 0, 0);
    clientfield::register("scriptmover", "infiltration_force_drop_point", 1, 2, "int", &function_f1c37912, 0, 0);
    clientfield::register("toplayer", "heatblurpostfx", 1, 1, "int", &function_c9851cb, 0, 0);
    clientfield::register("vehicle", "warpportalfx", 1, 1, "int", &function_c0c7c219, 0, 0);
    clientfield::register("vehicle", "warpportalfx_launch", 1, 1, "counter", &function_9767bbd8, 0, 0);
    clientfield::register("toplayer", "warpportal_fx_wormhole", 1, 1, "int", undefined, 0, 0);
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0x98541598, Offset: 0x908
// Size: 0x1cc
function function_20cba65e(player) {
    assert(isplayer(player));
    if (!isdefined(player)) {
        return 0;
    }
    teams = array(#"allies", #"axis");
    for (index = 3; index <= getgametypesetting(#"teamcount"); index++) {
        teams[teams.size] = #"team" + index;
    }
    var_aa3d62e3 = [];
    for (index = 0; index < teams.size; index++) {
        var_aa3d62e3[teams[index]] = index;
    }
    for (index = 0; index < max(isdefined(getgametypesetting(#"hash_731988b03dc6ee17")) ? getgametypesetting(#"hash_731988b03dc6ee17") : 1, 1); index++) {
        if (isdefined(var_aa3d62e3[player.team]) && var_aa3d62e3[player.team] == index % (teams.size - 1)) {
            return index;
        }
    }
    return 0;
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x0
// Checksum 0x8e146c02, Offset: 0xae0
// Size: 0x8c
function on_localclient_connect(localclientnum) {
    var_7eb8f61a = isdefined(getgametypesetting(#"wzplayerinsertiontypeindex")) ? getgametypesetting(#"wzplayerinsertiontypeindex") : 0;
    if (var_7eb8f61a == 1) {
        level thread function_6c4ae982(localclientnum);
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x4
// Checksum 0xbd6b211c, Offset: 0xb78
// Size: 0x16
function private function_a4c14f8c(value) {
    return value & 1;
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x4
// Checksum 0xcb0c9ca, Offset: 0xb98
// Size: 0x18
function private function_ff16ec5f(value) {
    return ~value & 1;
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x4
// Checksum 0xac8e652f, Offset: 0xbb8
// Size: 0x16
function private function_76a4b21e(value) {
    return value >> 1;
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x4
// Checksum 0xf657e4ba, Offset: 0xbd8
// Size: 0x1ac
function private function_6c4ae982(localclientnum) {
    var_d5823792 = 0;
    var_b9d612e8 = 0;
    var_a106daf5 = 0;
    while (true) {
        local_player = function_5c10bd79(localclientnum);
        if (isdefined(local_player)) {
            if (!local_player hasdobj(localclientnum)) {
                waitframe(1);
                continue;
            }
        }
        if (isdefined(local_player)) {
            wormhole_fx = local_player clientfield::get_to_player("warpportal_fx_wormhole");
            if (wormhole_fx === 1 && !var_d5823792) {
                var_d5823792 = 1;
                playsound(localclientnum, #"hash_37244e4f8de40dd5");
                local_player codeplaypostfxbundle("pstfx_wz_esc_tele_reveal");
                local_player codeplaypostfxbundle("pstfx_wz_esc_tele_sprites");
            } else if (wormhole_fx === 0 && var_d5823792) {
                var_d5823792 = 0;
                local_player function_3f145588("pstfx_wz_esc_tele_reveal");
                local_player function_3f145588("pstfx_wz_esc_tele_sprites");
            }
        } else {
            return;
        }
        waitframe(1);
    }
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0x5f4f9d01, Offset: 0xd90
// Size: 0x60
function function_d8beedc9(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        level notify(#"hash_5975d5f569535c41");
    }
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0x2bb6983d, Offset: 0xdf8
// Size: 0x8c
function function_ba7d9848(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (true) {
        if (bwastimejump) {
            self function_d309e55a("tag_landing_gear_control_animate", 1);
            return;
        }
        self function_d309e55a("tag_landing_gear_control_animate", 0);
    }
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0xe1d6333b, Offset: 0xe90
// Size: 0x74
function function_ded53cc6(*localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1 && fieldname != bwastimejump) {
        self playsound(0, #"hash_7ba1b4b83540b238");
    }
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0x5621ec18, Offset: 0xf10
// Size: 0x94
function function_ea3cc318(*localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (self function_da43934d()) {
        if (bwastimejump == 1 && fieldname != bwastimejump) {
            self playsound(0, #"hash_783bdfd900c11eed");
        }
    }
}

// Namespace player_insertion/player_insertion
// Params 1, eflags: 0x4
// Checksum 0x7ac56670, Offset: 0xfb0
// Size: 0x6c
function private function_8c515e6(player) {
    self notify("7c6ff3d6cda434b3");
    self endon("7c6ff3d6cda434b3");
    self waittill(#"death");
    if (isdefined(player) && player isplayer()) {
        player camerasetupdatecallback();
    }
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0x9b3a07ee, Offset: 0x1028
// Size: 0x1fc
function function_7bac6764(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    level endon(#"game_ended");
    player = function_5c10bd79(fieldname);
    if (!isdefined(player)) {
        return;
    }
    while (!isplayer(player)) {
        waitframe(1);
        player = function_5c10bd79(fieldname);
    }
    insertionindex = function_20cba65e(player);
    var_1e7db62f = function_a4c14f8c(bwastimejump);
    if (insertionindex != var_1e7db62f) {
        return;
    }
    value = function_76a4b21e(bwastimejump);
    if (value == 0) {
        player camerasetupdatecallback();
        return;
    }
    if (value == 1) {
        level.var_88a92c26 = self;
        self camerasetupdatecallback(&function_cbe63de1);
        self thread function_8c515e6(player);
        player function_ec94346();
        return;
    }
    if (value == 2) {
        level.var_88a92c26 = self;
        self camerasetupdatecallback(&function_c8ea4bcc);
        self thread function_8c515e6(player);
    }
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0x3cb7e55a, Offset: 0x1230
// Size: 0xa4
function infil_plane(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (is_true(level.var_a3c42585)) {
        return;
    }
    function_1b88c5(fieldname, function_a4c14f8c(bwastimejump), self);
    self setcompassicon("t8_hud_waypoints_drone_hunter_scaled_down");
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0x8aa8800, Offset: 0x12e0
// Size: 0xcc
function infil_ent(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (is_true(level.var_a3c42585)) {
        return;
    }
    var_1e7db62f = function_a4c14f8c(bwastimejump);
    var_36f945fe = function_ff16ec5f(bwastimejump);
    function_c8ae746a(fieldname, var_1e7db62f, 1);
    function_c8ae746a(fieldname, var_36f945fe, 0);
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x0
// Checksum 0xcdad495e, Offset: 0x13b8
// Size: 0x1d4
function function_cbe63de1(localclientnum, *delta_t) {
    player = function_5c10bd79(delta_t);
    if (!isdefined(player)) {
        return;
    }
    if (!isdefined(level.var_88a92c26)) {
        player camerasetposition(player.origin);
        player camerasetlookat(player.angles);
        return;
    }
    focuspos = level.var_88a92c26.origin;
    focusangles = level.var_88a92c26.angles;
    assert(isdefined(focusangles), "<dev string:x58>");
    if (!isdefined(focusangles)) {
        focusangles = player getcamangles();
        if (!isdefined(focusangles)) {
            focusangles = isdefined(player.angles) ? player.angles : (0, 0, 0);
        }
    }
    cameravec = anglestoforward(focusangles);
    camerapos = focuspos - (isdefined(level.var_427d6976.("insertionCameraFollowDistance")) ? level.var_427d6976.("insertionCameraFollowDistance") : 1600) * cameravec;
    player camerasetposition(camerapos);
    player camerasetlookat(focusangles);
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x0
// Checksum 0xa112aa1f, Offset: 0x1598
// Size: 0x24c
function function_c8ea4bcc(localclientnum, *delta_t) {
    player = function_5c10bd79(delta_t);
    if (!isdefined(player)) {
        return;
    }
    if (!isdefined(level.var_88a92c26)) {
        player camerasetposition(player.origin);
        player camerasetlookat(player.angles);
        return;
    }
    focuspos = level.var_88a92c26.origin;
    focusangles = player getcamangles();
    if (!isdefined(focusangles)) {
        player camerasetlookat(player.angles);
        focusangles = player getcamangles();
        if (!isdefined(focusangles)) {
            focusangles = isdefined(player.angles) ? player.angles : (0, 0, 0);
        }
    }
    cameravec = anglestoforward(focusangles);
    camerapos = focuspos - (isdefined(level.var_427d6976.("insertionCameraFollowDistance")) ? level.var_427d6976.("insertionCameraFollowDistance") : 1600) * cameravec;
    player camerasetposition(camerapos);
    player camerasetlookat(focusangles);
    player function_36b630a3(0);
    player callback::add_entity_callback(#"freefall", &function_c9a18304);
    player callback::add_entity_callback(#"on_start_gametype", &function_c9a18304);
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x0
// Checksum 0xc5491991, Offset: 0x17f0
// Size: 0x3c
function function_84ba1c41(local_client_num, eventstruct) {
    if (!eventstruct.parachute) {
        function_f9e5d4d3(local_client_num, eventstruct);
    }
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x0
// Checksum 0xd4d410f9, Offset: 0x1838
// Size: 0x94
function function_f9e5d4d3(*local_client_num, *eventstruct) {
    if (is_true(self.infiltrating)) {
        self.infiltrating = undefined;
        self callback::function_52ac9652(#"parachute", &function_84ba1c41);
        self callback::function_52ac9652(#"death", &function_f9e5d4d3);
    }
}

// Namespace player_insertion/player_insertion
// Params 0, eflags: 0x0
// Checksum 0xc63d3627, Offset: 0x18d8
// Size: 0x74
function function_ec94346() {
    self.infiltrating = 1;
    self callback::add_entity_callback(#"parachute", &function_84ba1c41);
    self callback::add_entity_callback(#"death", &function_f9e5d4d3);
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x0
// Checksum 0x865ac5cc, Offset: 0x1958
// Size: 0x3c
function function_c9a18304(*local_client_num, eventstruct) {
    if (eventstruct.freefall) {
        self function_36b630a3(1);
    }
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0x35522b6f, Offset: 0x19a0
// Size: 0xcc
function function_73a03a18(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    var_1e7db62f = function_a4c14f8c(bwastimejump);
    if (!isdefined(level.var_a3ede655)) {
        level.var_a3ede655 = [];
    } else if (!isarray(level.var_a3ede655)) {
        level.var_a3ede655 = array(level.var_a3ede655);
    }
    level.var_a3ede655[var_1e7db62f] = self;
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0x84722c5e, Offset: 0x1a78
// Size: 0xcc
function function_f1c37912(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    var_1e7db62f = function_a4c14f8c(bwastimejump);
    if (!isdefined(level.var_697988b1)) {
        level.var_697988b1 = [];
    } else if (!isarray(level.var_697988b1)) {
        level.var_697988b1 = array(level.var_697988b1);
    }
    level.var_697988b1[var_1e7db62f] = self;
}

// Namespace player_insertion/player_insertion
// Params 2, eflags: 0x0
// Checksum 0x95a7f13e, Offset: 0x1b50
// Size: 0x264
function function_65cca2e1(localclientnum, var_1e7db62f) {
    if (is_true(level.var_a3c42585)) {
        return;
    }
    self notify(#"hash_503cb9224ca331c" + var_1e7db62f);
    self endon(#"hash_503cb9224ca331c" + var_1e7db62f);
    while (true) {
        if (isdefined(level.var_a3ede655) && isdefined(level.var_a3ede655[var_1e7db62f]) && isdefined(level.var_697988b1) && isdefined(level.var_697988b1[var_1e7db62f])) {
            break;
        }
        waitframe(1);
    }
    jump_point = level.var_a3ede655[var_1e7db62f].origin;
    force_drop_point = level.var_697988b1[var_1e7db62f].origin;
    direction = anglestoforward(level.var_a3ede655[var_1e7db62f].angles);
    start_point = jump_point - direction * 150000;
    end_point = force_drop_point + direction * 150000;
    var_5a20cc9d = createuimodel(function_1df4c3b0(localclientnum, #"hud_items"), "freeFallStartAltitude");
    setuimodelvalue(var_5a20cc9d, jump_point[2]);
    var_7eb8f61a = isdefined(getgametypesetting(#"wzplayerinsertiontypeindex")) ? getgametypesetting(#"wzplayerinsertiontypeindex") : 0;
    if (var_7eb8f61a == 0 || var_7eb8f61a == 3) {
        function_4dfe3112(localclientnum, var_1e7db62f, start_point, end_point, jump_point, force_drop_point);
    }
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0x55b1fe91, Offset: 0x1dc0
// Size: 0x15c
function function_4da7bee9(localclientnum, oldval, newval, *bnewent, binitialsnap, *fieldname, *bwastimejump) {
    if (is_true(level.var_a3c42585)) {
        return;
    }
    for (var_1e7db62f = 0; var_1e7db62f < 2; var_1e7db62f++) {
        oldvalue = binitialsnap & 1;
        value = fieldname & 1;
        fieldname >>= 1;
        binitialsnap >>= 1;
        if (oldvalue == value && !bwastimejump) {
            continue;
        }
        if (value) {
            level thread function_65cca2e1(bnewent, var_1e7db62f);
            continue;
        }
        self notify(#"hash_503cb9224ca331c" + var_1e7db62f);
        function_c8ae746a(bnewent, var_1e7db62f, 0);
        function_71fec565(bnewent, var_1e7db62f);
    }
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x0
// Checksum 0xe317956a, Offset: 0x1f28
// Size: 0x140
function inside_infiltration_vehicle(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    setuimodelvalue(createuimodel(function_1df4c3b0(fieldname, #"hud_items"), "infiltrationVehicle"), bwastimejump);
    if (bwastimejump) {
        if (!is_true(level.var_a3c42585)) {
            self function_811196d1(1);
        }
        return;
    }
    self notify(#"hash_70483f3d5a2f87f0");
    if (!is_true(level.var_a3c42585)) {
        self function_811196d1(0);
    }
    self camerasetupdatecallback();
    level notify(#"hash_413d64e47311dcf8");
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x4
// Checksum 0x28536bb9, Offset: 0x2070
// Size: 0x84
function private function_c9851cb(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self codeplaypostfxbundle("pstfx_heat_distortion");
        return;
    }
    self codestoppostfxbundle("pstfx_heat_distortion");
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x4
// Checksum 0x5c7703b5, Offset: 0x2100
// Size: 0x64
function private function_9767bbd8(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    playfx(bwastimejump, #"hash_3697b0b0d7cd6874", self.origin);
}

// Namespace player_insertion/player_insertion
// Params 7, eflags: 0x4
// Checksum 0x3ababcd3, Offset: 0x2170
// Size: 0x132
function private function_c0c7c219(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        player = function_5c10bd79(fieldname);
        player function_ec94346();
        if (isdefined(self.var_227361c6)) {
            stopfx(fieldname, self.var_227361c6);
        }
        self.var_227361c6 = playfx(fieldname, #"hash_28b5c6ccaabb4afe", self.origin);
        return;
    }
    if (isdefined(self.var_227361c6)) {
        stopfx(fieldname, self.var_227361c6);
    }
    self.var_227361c6 = playfx(fieldname, #"hash_45086f1ffcabbf47", self.origin);
}

