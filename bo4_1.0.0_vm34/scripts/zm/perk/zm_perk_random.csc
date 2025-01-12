#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;

#namespace zm_perk_random;

// Namespace zm_perk_random/zm_perk_random
// Params 0, eflags: 0x2
// Checksum 0xcf5b5126, Offset: 0x208
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_random", &__init__, undefined, undefined);
}

// Namespace zm_perk_random/zm_perk_random
// Params 0, eflags: 0x0
// Checksum 0x6c9f2416, Offset: 0x250
// Size: 0x34a
function __init__() {
    clientfield::register("scriptmover", "perk_bottle_cycle_state", 1, 2, "int", &start_bottle_cycling, 0, 0);
    clientfield::register("zbarrier", "set_client_light_state", 1, 2, "int", &set_light_state, 0, 0);
    clientfield::register("zbarrier", "init_perk_random_machine", 1, 1, "int", &perk_random_machine_init, 0, 0);
    clientfield::register("zbarrier", "client_stone_emmissive_blink", 1, 1, "int", &perk_random_machine_rock_emissive, 0, 0);
    clientfield::register("scriptmover", "turn_active_perk_light_green", 1, 1, "int", &turn_on_active_light_green, 0, 0);
    clientfield::register("scriptmover", "turn_on_location_indicator", 1, 1, "int", &turn_on_location_indicator, 0, 0);
    clientfield::register("zbarrier", "lightning_bolt_FX_toggle", 1, 1, "int", &lightning_bolt_fx_toggle, 0, 0);
    clientfield::register("scriptmover", "turn_active_perk_ball_light", 1, 1, "int", &turn_on_active_ball_light, 0, 0);
    clientfield::register("scriptmover", "zone_captured", 1, 1, "int", &zone_captured_cb, 0, 0);
    level._effect[#"perk_machine_light_yellow"] = #"hash_63cff764b54ceca2";
    level._effect[#"perk_machine_light_red"] = #"hash_5b7d2edb8392ef21";
    level._effect[#"perk_machine_light_green"] = #"hash_130f1aaf8384975";
    level._effect[#"perk_machine_location"] = #"hash_53e8ba7551663778";
}

// Namespace zm_perk_random/zm_perk_random
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x5a8
// Size: 0x4
function init_animtree() {
    
}

// Namespace zm_perk_random/zm_perk_random
// Params 7, eflags: 0x0
// Checksum 0xcb37c0fb, Offset: 0x5b8
// Size: 0x3c
function turn_on_location_indicator(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace zm_perk_random/zm_perk_random
// Params 7, eflags: 0x0
// Checksum 0x4b925593, Offset: 0x600
// Size: 0x1be
function lightning_bolt_fx_toggle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdemoplaying() && getdemoversion() < 17) {
        return;
    }
    self notify("lightning_bolt_fx_toggle" + localclientnum);
    self endon("lightning_bolt_fx_toggle" + localclientnum);
    player = function_f97e7787(localclientnum);
    player endon(#"death");
    if (!isdefined(self._location_indicator)) {
        self._location_indicator = [];
    }
    while (true) {
        if (newval == 1 && !isigcactive(localclientnum)) {
            if (!isdefined(self._location_indicator[localclientnum])) {
                self._location_indicator[localclientnum] = playfx(localclientnum, level._effect[#"perk_machine_location"], self.origin);
            }
        } else if (isdefined(self._location_indicator[localclientnum])) {
            stopfx(localclientnum, self._location_indicator[localclientnum]);
            self._location_indicator[localclientnum] = undefined;
        }
        wait 1;
    }
}

// Namespace zm_perk_random/zm_perk_random
// Params 7, eflags: 0x0
// Checksum 0x8a054d8a, Offset: 0x7c8
// Size: 0xdc
function zone_captured_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.mapped_const)) {
        self mapshaderconstant(localclientnum, 1, "ScriptVector0");
        self.mapped_const = 1;
    }
    if (newval == 1) {
        return;
    }
    self.artifact_glow_setting = 1;
    self.machinery_glow_setting = 0;
    self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
}

// Namespace zm_perk_random/zm_perk_random
// Params 7, eflags: 0x0
// Checksum 0xc195ca35, Offset: 0x8b0
// Size: 0xae
function perk_random_machine_rock_emissive(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        piece = self zbarriergetpiece(3);
        piece.blinking = 1;
        piece thread rock_emissive_think(localclientnum);
        return;
    }
    if (newval == 0) {
        self.blinking = 0;
    }
}

// Namespace zm_perk_random/zm_perk_random
// Params 1, eflags: 0x0
// Checksum 0x753e2d22, Offset: 0x968
// Size: 0x80
function rock_emissive_think(localclientnum) {
    level endon(#"demo_jump");
    while (isdefined(self.blinking) && self.blinking) {
        self rock_emissive_fade(localclientnum, 8, 0);
        self rock_emissive_fade(localclientnum, 0, 8);
    }
}

// Namespace zm_perk_random/zm_perk_random
// Params 3, eflags: 0x0
// Checksum 0x1115cf26, Offset: 0x9f0
// Size: 0x178
function rock_emissive_fade(localclientnum, n_max_val, n_min_val) {
    n_start_time = gettime();
    n_end_time = n_start_time + 0.5 * 1000;
    b_is_updating = 1;
    while (b_is_updating) {
        n_time = gettime();
        if (n_time >= n_end_time) {
            n_shader_value = mapfloat(n_start_time, n_end_time, n_min_val, n_max_val, n_end_time);
            b_is_updating = 0;
        } else {
            n_shader_value = mapfloat(n_start_time, n_end_time, n_min_val, n_max_val, n_time);
        }
        if (isdefined(self)) {
            self mapshaderconstant(localclientnum, 0, "scriptVector2", n_shader_value, 0, 0);
            self mapshaderconstant(localclientnum, 0, "scriptVector0", 0, n_shader_value, 0);
            self mapshaderconstant(localclientnum, 0, "scriptVector0", 0, 0, n_shader_value);
        }
        wait 0.01;
    }
}

// Namespace zm_perk_random/zm_perk_random
// Params 7, eflags: 0x4
// Checksum 0xf2741b1d, Offset: 0xb70
// Size: 0xb2
function private perk_random_machine_init(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.perk_random_machine_fx)) {
        return;
    }
    if (!isdefined(self)) {
        return;
    }
    self.perk_random_machine_fx = [];
    self.perk_random_machine_fx["tag_animate" + 1] = [];
    self.perk_random_machine_fx["tag_animate" + 2] = [];
    self.perk_random_machine_fx["tag_animate" + 3] = [];
}

// Namespace zm_perk_random/zm_perk_random
// Params 7, eflags: 0x0
// Checksum 0x67e078c6, Offset: 0xc30
// Size: 0x192
function set_light_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    a_n_piece_indices = array(1, 2, 3);
    foreach (n_piece_index in a_n_piece_indices) {
        if (newval == 0) {
            perk_random_machine_play_fx(localclientnum, n_piece_index, "tag_animate", undefined);
            continue;
        }
        if (newval == 3) {
            perk_random_machine_play_fx(localclientnum, n_piece_index, "tag_animate", level._effect[#"perk_machine_light_red"]);
            continue;
        }
        if (newval == 1) {
            perk_random_machine_play_fx(localclientnum, n_piece_index, "tag_animate", level._effect[#"perk_machine_light_green"]);
            continue;
        }
        if (newval == 2) {
        }
    }
}

// Namespace zm_perk_random/zm_perk_random
// Params 5, eflags: 0x4
// Checksum 0x293fab3, Offset: 0xdd0
// Size: 0x108
function private perk_random_machine_play_fx(localclientnum, piece_index, tag, fx, deleteimmediate = 1) {
    piece = self zbarriergetpiece(piece_index);
    if (isdefined(self.perk_random_machine_fx[tag + piece_index][localclientnum])) {
        deletefx(localclientnum, self.perk_random_machine_fx[tag + piece_index][localclientnum], deleteimmediate);
        self.perk_random_machine_fx[tag + piece_index][localclientnum] = undefined;
    }
    if (isdefined(fx)) {
        self.perk_random_machine_fx[tag + piece_index][localclientnum] = util::playfxontag(localclientnum, fx, piece, tag);
    }
}

// Namespace zm_perk_random/zm_perk_random
// Params 7, eflags: 0x0
// Checksum 0x81526b96, Offset: 0xee0
// Size: 0x98
function turn_on_active_light_green(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.artifact_glow_setting = 1;
        self.machinery_glow_setting = 0.7;
        self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
    }
}

// Namespace zm_perk_random/zm_perk_random
// Params 7, eflags: 0x0
// Checksum 0xeb8f9b9, Offset: 0xf80
// Size: 0x98
function turn_on_active_ball_light(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.artifact_glow_setting = 1;
        self.machinery_glow_setting = 1;
        self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
    }
}

// Namespace zm_perk_random/zm_perk_random
// Params 7, eflags: 0x0
// Checksum 0xc019bf55, Offset: 0x1020
// Size: 0x7c
function start_bottle_cycling(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self thread start_vortex_fx(localclientnum);
        return;
    }
    self thread stop_vortex_fx(localclientnum);
}

// Namespace zm_perk_random/zm_perk_random
// Params 1, eflags: 0x0
// Checksum 0xefc655bf, Offset: 0x10a8
// Size: 0xfc
function start_vortex_fx(localclientnum) {
    self endon(#"activation_electricity_finished");
    self endon(#"death");
    if (!isdefined(self.glow_location)) {
        self.glow_location = spawn(localclientnum, self.origin, "script_model");
        self.glow_location.angles = self.angles;
        self.glow_location setmodel(#"tag_origin");
    }
    self thread fx_activation_electric_loop(localclientnum);
    self thread fx_artifact_pulse_thread(localclientnum);
    wait 0.5;
    self thread fx_bottle_cycling(localclientnum);
}

// Namespace zm_perk_random/zm_perk_random
// Params 1, eflags: 0x0
// Checksum 0xd7375a89, Offset: 0x11b0
// Size: 0xd4
function stop_vortex_fx(localclientnum) {
    self endon(#"death");
    self notify(#"bottle_cycling_finished");
    wait 0.5;
    if (!isdefined(self)) {
        return;
    }
    self notify(#"activation_electricity_finished");
    if (isdefined(self.glow_location)) {
        self.glow_location delete();
    }
    self.artifact_glow_setting = 1;
    self.machinery_glow_setting = 0.7;
    self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
}

// Namespace zm_perk_random/zm_perk_random
// Params 1, eflags: 0x0
// Checksum 0xf676cfd, Offset: 0x1290
// Size: 0x106
function fx_artifact_pulse_thread(localclientnum) {
    self endon(#"activation_electricity_finished");
    self endon(#"death");
    while (isdefined(self)) {
        shader_amount = sin(getrealtime() * 0.2);
        if (shader_amount < 0) {
            shader_amount *= -1;
        }
        shader_amount = 0.75 - shader_amount * 0.75;
        self.artifact_glow_setting = shader_amount;
        self.machinery_glow_setting = 1;
        self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
        waitframe(1);
    }
}

// Namespace zm_perk_random/zm_perk_random
// Params 1, eflags: 0x0
// Checksum 0x6d893b68, Offset: 0x13a0
// Size: 0x50
function fx_activation_electric_loop(localclientnum) {
    self endon(#"activation_electricity_finished");
    self endon(#"death");
    while (true) {
        if (isdefined(self.glow_location)) {
        }
        wait 0.1;
    }
}

// Namespace zm_perk_random/zm_perk_random
// Params 1, eflags: 0x0
// Checksum 0xa1fa7ed8, Offset: 0x13f8
// Size: 0x40
function fx_bottle_cycling(localclientnum) {
    self endon(#"bottle_cycling_finished");
    while (true) {
        if (isdefined(self.glow_location)) {
        }
        wait 0.1;
    }
}

// Namespace zm_perk_random/zm_perk_random
// Params 1, eflags: 0x0
// Checksum 0x8c0d08fb, Offset: 0x1440
// Size: 0x78
function function_df33cead(localclientnum) {
    self endon(#"hash_fcaf7071581a306");
    self endon(#"death");
    level endon(#"demo_jump");
    while (isdefined(self)) {
        if (isdefined(self)) {
        }
        wait randomfloatrange(3, 4);
    }
}

