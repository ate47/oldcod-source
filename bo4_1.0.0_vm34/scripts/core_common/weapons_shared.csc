#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace weapons_shared;

// Namespace weapons_shared/weapons_shared
// Params 0, eflags: 0x2
// Checksum 0x41d13fcf, Offset: 0xf0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"weapon_shared", &__init__, undefined, undefined);
}

// Namespace weapons_shared/weapons_shared
// Params 0, eflags: 0x0
// Checksum 0x1ffea4c2, Offset: 0x138
// Size: 0x9c
function __init__() {
    callback::on_spawned(&on_player_spawned);
    level.weaponnone = getweapon(#"none");
    level.weapon_sig_minigun = getweapon(#"sig_minigun");
    vehicle::add_vehicletype_callback("swivel_mount", &function_96b8394d);
}

// Namespace weapons_shared/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0x6960d0ed, Offset: 0x1e0
// Size: 0x54
function on_player_spawned(local_client_num) {
    if (self function_60dbc438()) {
        self thread function_ebf84e89(local_client_num);
        self thread function_496b472e(local_client_num);
    }
}

// Namespace weapons_shared/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0x1f65538f, Offset: 0x240
// Size: 0x24
function function_96b8394d(local_client_num) {
    self thread function_3eb625ce(local_client_num);
}

// Namespace weapons_shared/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0x9082c349, Offset: 0x270
// Size: 0x5c
function function_3eb625ce(local_client_num) {
    if (self function_2a8c9709() && !isthirdperson(local_client_num)) {
        self sethighdetail(1);
    }
}

// Namespace weapons_shared/weapons_shared
// Params 2, eflags: 0x0
// Checksum 0x88d6f64e, Offset: 0x2d8
// Size: 0x6c
function function_33be840d(local_client_num, objective_id) {
    self waittill(#"death", #"disconnect", #"team_changed");
    if (isdefined(objective_id)) {
        objective_delete(local_client_num, objective_id);
    }
}

// Namespace weapons_shared/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0x9da91430, Offset: 0x350
// Size: 0xd4
function function_8e7bf94(weapon) {
    assert(isdefined(weapon.customsettings), "<dev string:x30>" + weapon.name);
    if (!isdefined(level.var_d5c4e7b3)) {
        level.var_d5c4e7b3 = [];
    }
    var_a716620c = hash(weapon.name);
    if (!isdefined(level.var_d5c4e7b3[var_a716620c])) {
        level.var_d5c4e7b3[var_a716620c] = getscriptbundle(weapon.customsettings);
    }
    return level.var_d5c4e7b3[var_a716620c];
}

// Namespace weapons_shared/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0x2b1edcf6, Offset: 0x430
// Size: 0x150
function function_496b472e(local_client_num) {
    if (level.weapon_sig_minigun == level.weaponnone) {
        return;
    }
    level notify("sig_minigun_force_stream_watcher_singleton" + local_client_num);
    level endon("sig_minigun_force_stream_watcher_singleton" + local_client_num);
    local_player = self;
    if (!isdefined(level.var_62a92bc8)) {
        level.var_62a92bc8 = 0;
    }
    while (true) {
        var_e56170f0 = function_a729094e(local_client_num, level.weapon_sig_minigun);
        if (!var_e56170f0 && level.var_62a92bc8) {
            stopforcestreamingxmodel(#"hash_253fe56e77e698b3");
            level.var_62a92bc8 = 0;
        } else if (var_e56170f0 && !level.var_62a92bc8) {
            forcestreamxmodel(#"hash_253fe56e77e698b3");
            level.var_62a92bc8 = 1;
        }
        wait 0.1;
    }
}

// Namespace weapons_shared/weapons_shared
// Params 1, eflags: 0x0
// Checksum 0x2ed683a0, Offset: 0x588
// Size: 0x850
function function_ebf84e89(local_client_num) {
    player = self;
    player endon(#"death", #"disconnect");
    wait randomfloatrange(0.1, 0.5);
    var_aee87844 = #"mountable_point";
    obj_id = undefined;
    var_e9b2a4a2 = 0;
    var_71a89b98 = 0;
    mountable_point = (0, 0, 0);
    var_a1e05345 = 0;
    var_868bb043 = 0;
    while (true) {
        if (isdefined(player.var_91253889) && isdefined(obj_id) && getdvarint(#"hash_2281c2e9e7f377ec", 0)) {
            if (!var_868bb043 && var_e9b2a4a2) {
                objective_add(local_client_num, obj_id, "active", var_aee87844, mountable_point);
                objective_setgamemodeflags(local_client_num, obj_id, var_a1e05345);
                /#
                    if (getdvarint(#"hash_45f38774fd8ac214", 0) > 0) {
                        sphere(mountable_point, 2, (0.1, 0.9, 0.1), 0.8, 1, 16, 1);
                    }
                #/
            } else if (objective_state(local_client_num, obj_id) != "invisible") {
                objective_setstate(local_client_num, obj_id, "invisible");
            }
        }
        if (!var_71a89b98) {
            wait 0.5;
        }
        wait 0.016;
        if (false) {
            start_time = util::get_start_time();
        }
        var_e9b2a4a2 = 0;
        var_71a89b98 = 0;
        var_a1e05345 = 0;
        var_868bb043 = 0;
        current_weapon = getcurrentweapon(local_client_num);
        if (current_weapon == level.weaponnone) {
            continue;
        }
        if (!current_weapon.mountable) {
            continue;
        }
        var_71a89b98 = 1;
        if (!isdefined(player.var_91253889)) {
            player.var_91253889 = util::getnextobjid(local_client_num);
            player thread function_33be840d(local_client_num, player.var_91253889);
        }
        obj_id = player.var_91253889;
        var_b76b40a6 = isads(local_client_num);
        if (var_b76b40a6) {
            var_e9b2a4a2 = 1;
            var_a1e05345 = 1;
            var_868bb043 = 1;
            continue;
        }
        origin = getlocalclientpos(local_client_num);
        mountable_point = origin;
        cam_angles = getcamanglesbylocalclientnum(local_client_num);
        forward = anglestoforward(cam_angles);
        forward = vectornormalize((forward[0], forward[1], 0));
        height_offset = 24;
        trace_distance = getdvarint(#"hash_25637aefbe36f6f5", 300);
        forward_vector = vectorscale(forward, trace_distance);
        trace_start = origin + (0, 0, height_offset);
        trace_end = trace_start + forward_vector;
        trace_result = bullettrace(trace_start, trace_end, 0, player);
        if (trace_result[#"fraction"] < 1 && trace_result[#"normal"][2] < 0.7) {
            hit_distance = trace_result[#"fraction"] * trace_distance;
            player_radius = 15;
            var_a2654400 = 100;
            var_6b6f161e = trace_start + vectorscale(forward, hit_distance - player_radius);
            var_caba71ed = var_6b6f161e + (0, 0, var_a2654400 * -1);
            ground_trace = bullettrace(var_6b6f161e, var_caba71ed, 0, player);
            if (ground_trace[#"fraction"] < 1) {
                var_16bfc3e = var_6b6f161e + vectorscale((0, 0, -1), ground_trace[#"fraction"] * var_a2654400);
                var_e9b2a4a2 = function_e4cb05f9(local_client_num, current_weapon, var_16bfc3e, trace_result[#"normal"] * -1);
                var_2922bd05 = trace_result[#"position"][2];
                min_height = 30;
                max_height = 50;
                var_33b23cab = max_height - min_height;
                var_597cbfa = vectorscale(forward, 3);
                var_af7726b9 = trace_result[#"position"] + var_597cbfa;
                var_80ad9b42 = (var_af7726b9[0], var_af7726b9[1], var_16bfc3e[2] + min_height);
                var_af7726b9 = (var_af7726b9[0], var_af7726b9[1], var_16bfc3e[2] + max_height);
                var_4058be9c = bullettrace(var_af7726b9, var_80ad9b42, 0, player);
                if (var_4058be9c[#"fraction"] < 1) {
                    var_106c3ec5 = var_af7726b9 + vectorscale((0, 0, -1), var_4058be9c[#"fraction"] * var_33b23cab);
                    var_2922bd05 = var_106c3ec5[2];
                }
                mountable_point = (trace_result[#"position"][0], trace_result[#"position"][1], var_2922bd05);
                if (var_e9b2a4a2) {
                    if (hit_distance < current_weapon.var_cb2ed731 + player_radius) {
                        var_a1e05345 = 1;
                    }
                }
            }
        }
        if (false) {
            util::note_elapsed_time(start_time, "mountable previs time: ");
        }
    }
}

