#using script_72401f526ba71638;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace namespace_1fd59e39;

// Namespace namespace_1fd59e39/namespace_1fd59e39
// Params 0, eflags: 0x6
// Checksum 0xeaf3f1f7, Offset: 0x1f0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_7fd3c8de50685459", &function_70a657d8, undefined, undefined, #"hash_13a43d760497b54d");
}

// Namespace namespace_1fd59e39/namespace_1fd59e39
// Params 0, eflags: 0x5 linked
// Checksum 0x3b4a4cc9, Offset: 0x240
// Size: 0x284
function private function_70a657d8() {
    clientfield::register("allplayers", "" + #"hash_59400ab6cbfaec5d", 1, 1, "int");
    namespace_1b527536::function_36e0540e(#"aether_shroud", 1, 40, "field_upgrade_aether_shroud_item_sr");
    namespace_1b527536::function_36e0540e(#"hash_164c43cbd0ee958", 1, 40, "field_upgrade_aether_shroud_1_item_sr");
    namespace_1b527536::function_36e0540e(#"hash_164c73cbd0eee71", 1, 40, "field_upgrade_aether_shroud_2_item_sr");
    namespace_1b527536::function_36e0540e(#"hash_164c63cbd0eecbe", 1, 40, "field_upgrade_aether_shroud_3_item_sr");
    namespace_1b527536::function_36e0540e(#"hash_164c93cbd0ef1d7", 1, 40, "field_upgrade_aether_shroud_4_item_sr");
    namespace_1b527536::function_36e0540e(#"hash_164c83cbd0ef024", 2, 40, "field_upgrade_aether_shroud_5_item_sr");
    namespace_1b527536::function_dbd391bf(#"aether_shroud", &function_84c43da8);
    namespace_1b527536::function_dbd391bf(#"hash_164c43cbd0ee958", &function_84c43da8);
    namespace_1b527536::function_dbd391bf(#"hash_164c73cbd0eee71", &function_84c43da8);
    namespace_1b527536::function_dbd391bf(#"hash_164c63cbd0eecbe", &function_84c43da8);
    namespace_1b527536::function_dbd391bf(#"hash_164c93cbd0ef1d7", &function_84c43da8);
    namespace_1b527536::function_dbd391bf(#"hash_164c83cbd0ef024", &function_84c43da8);
}

// Namespace namespace_1fd59e39/namespace_1fd59e39
// Params 1, eflags: 0x1 linked
// Checksum 0x4da4025e, Offset: 0x4d0
// Size: 0x202
function function_84c43da8(params) {
    self namespace_1b527536::function_460882e2();
    weapon = params.weapon;
    switch (weapon.name) {
    case #"aether_shroud":
        self thread function_ff022837(5);
        break;
    case #"hash_164c43cbd0ee958":
        self thread function_ff022837(5);
        self player::fill_current_clip();
        break;
    case #"hash_164c73cbd0eee71":
        self thread function_ff022837(8);
        self player::fill_current_clip();
        break;
    case #"hash_164c63cbd0eecbe":
        self thread function_ff022837(8);
        self player::fill_current_clip();
        self thread function_c5e5e928(500);
        break;
    case #"hash_164c83cbd0ef024":
    case #"hash_164c93cbd0ef1d7":
        self thread function_ff022837(8);
        self player::fill_current_clip();
        self thread function_c5e5e928(500);
        self thread function_df6782a4(1.5, 8);
        break;
    }
}

// Namespace namespace_1fd59e39/namespace_1fd59e39
// Params 1, eflags: 0x1 linked
// Checksum 0xfd4537c7, Offset: 0x6e0
// Size: 0x104
function function_ff022837(n_duration) {
    self notify("5a4d9829dcd881c5");
    self endon("5a4d9829dcd881c5");
    self endon(#"disconnect");
    self clientfield::set("" + #"hash_59400ab6cbfaec5d", 1);
    self val::set(#"aether_shroud", "ignoreme", 1);
    self waittilltimeout(n_duration, #"scene_igc_shot_started");
    self clientfield::set("" + #"hash_59400ab6cbfaec5d", 0);
    self val::reset(#"aether_shroud", "ignoreme");
}

// Namespace namespace_1fd59e39/namespace_1fd59e39
// Params 1, eflags: 0x1 linked
// Checksum 0xb071616a, Offset: 0x7f0
// Size: 0x3fc
function function_c5e5e928(var_e14b4254) {
    v_angles = self.angles;
    a_v_points = [];
    for (i = 1; i <= 10; i++) {
        var_92848b84 = i / 10 * var_e14b4254;
        v_point = self getplayercamerapos() + anglestoforward(v_angles) * var_92848b84;
        v_point = groundtrace(v_point + (0, 0, 8), v_point + (0, 0, -100000), 0, self)[#"position"];
        if (!isdefined(a_v_points)) {
            a_v_points = [];
        } else if (!isarray(a_v_points)) {
            a_v_points = array(a_v_points);
        }
        a_v_points[a_v_points.size] = v_point;
    }
    if (zm_utility::is_survival()) {
        for (i = a_v_points.size - 1; i >= 0; i--) {
            v_dest = a_v_points[i];
            if (ispointonnavmesh(v_dest, 15) && self util::is_player_looking_at(v_dest, 0.8, 0, self)) {
                v_teleport = v_dest;
                break;
            }
        }
    } else {
        for (i = a_v_points.size - 1; i >= 0; i--) {
            v_dest = a_v_points[i];
            if (zm_utility::check_point_in_playable_area(v_dest) && zm_utility::check_point_in_enabled_zone(v_dest, 1) && self util::is_player_looking_at(v_dest, 0.8, 0, self)) {
                v_teleport = v_dest;
                break;
            }
        }
    }
    if (isdefined(v_teleport)) {
        v_teleport = groundtrace(v_teleport + (0, 0, 24) + (0, 0, 8), v_teleport + (0, 0, 24) + (0, 0, -100000), 0, self)[#"position"];
        v_dir = v_teleport - self.origin;
        v_dir = (v_dir[0], v_dir[1], 1);
        v_dir = vectornormalize(v_dir);
        self playsound(#"hash_3d03d5d52c39fe35");
        var_dcbe57af = self getvelocity();
        n_length = length(var_dcbe57af);
        var_7bfb3e25 = var_dcbe57af + v_dir * n_length;
        self dontinterpolate();
        self setorigin(v_teleport);
        self setvelocity(var_7bfb3e25);
    }
}

// Namespace namespace_1fd59e39/namespace_1fd59e39
// Params 2, eflags: 0x1 linked
// Checksum 0x35d3a325, Offset: 0xbf8
// Size: 0xa4
function function_df6782a4(var_77d307ea, n_duration) {
    self notify("71984132b1efd361");
    self endon("71984132b1efd361");
    self endon(#"disconnect");
    var_af6c0f7c = self getmovespeedscale();
    self setmovespeedscale(var_77d307ea);
    self waittilltimeout(n_duration, #"scene_igc_shot_started");
    self setmovespeedscale(var_af6c0f7c);
}

