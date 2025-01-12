#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_utility;

#namespace zm_altbody;

// Namespace zm_altbody/zm_altbody
// Params 0, eflags: 0x2
// Checksum 0xd7791d99, Offset: 0x130
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_altbody", &__init__, undefined, undefined);
}

// Namespace zm_altbody/zm_altbody
// Params 0, eflags: 0x0
// Checksum 0xf511f264, Offset: 0x178
// Size: 0x13c
function __init__() {
    clientfield::register("clientuimodel", "player_lives", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "player_mana", 1, 8, "float", &set_player_mana, 0, 1);
    clientfield::register("toplayer", "player_in_afterlife", 1, 1, "int", &toggle_player_altbody, 0, 1);
    clientfield::register("allplayers", "player_altbody", 1, 1, "int", &toggle_player_altbody_3p, 0, 1);
    setupclientfieldcodecallbacks("toplayer", 1, "player_in_afterlife");
}

// Namespace zm_altbody/zm_altbody
// Params 9, eflags: 0x0
// Checksum 0x40a9f1f9, Offset: 0x2c0
// Size: 0x18a
function init(name, trigger_name, trigger_hint, visionset_name, visionset_priority, enter_callback, exit_callback, enter_3p_callback, exit_3p_callback) {
    if (!isdefined(level.altbody_enter_callbacks)) {
        level.altbody_enter_callbacks = [];
    }
    if (!isdefined(level.altbody_exit_callbacks)) {
        level.altbody_exit_callbacks = [];
    }
    if (!isdefined(level.altbody_enter_3p_callbacks)) {
        level.altbody_enter_3p_callbacks = [];
    }
    if (!isdefined(level.altbody_exit_3p_callbacks)) {
        level.altbody_exit_3p_callbacks = [];
    }
    if (!isdefined(level.altbody_visionsets)) {
        level.altbody_visionsets = [];
    }
    level.altbody_name = name;
    if (isdefined(visionset_name)) {
        level.altbody_visionsets[name] = visionset_name;
        visionset_mgr::register_visionset_info(visionset_name, 1, 1, visionset_name, visionset_name);
    }
    level.altbody_enter_callbacks[name] = enter_callback;
    level.altbody_exit_callbacks[name] = exit_callback;
    level.altbody_enter_3p_callbacks[name] = enter_3p_callback;
    level.altbody_exit_3p_callbacks[name] = exit_3p_callback;
}

// Namespace zm_altbody/zm_altbody
// Params 7, eflags: 0x0
// Checksum 0xe406154d, Offset: 0x458
// Size: 0x4a
function set_player_mana(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.mana = newval;
}

// Namespace zm_altbody/zm_altbody
// Params 7, eflags: 0x0
// Checksum 0x8367598e, Offset: 0x4b0
// Size: 0x144
function toggle_player_altbody(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.altbody)) {
        self.altbody = 0;
    }
    self usealternatehud(newval);
    if (self.altbody !== newval) {
        self.altbody = newval;
        if (bwastimejump) {
            self thread clear_transition(localclientnum, newval);
        } else {
            self thread cover_transition(localclientnum, newval);
        }
        if (newval == 1) {
            callback = level.altbody_enter_callbacks[level.altbody_name];
            if (isdefined(callback)) {
                self [[ callback ]](localclientnum);
            }
            return;
        }
        callback = level.altbody_exit_callbacks[level.altbody_name];
        if (isdefined(callback)) {
            self [[ callback ]](localclientnum);
        }
    }
}

// Namespace zm_altbody/zm_altbody
// Params 7, eflags: 0x0
// Checksum 0x3528f9a4, Offset: 0x600
// Size: 0xe0
function toggle_player_altbody_3p(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self function_60dbc438()) {
        return;
    }
    self.altbody_3p = newval;
    if (newval == 1) {
        callback = level.altbody_enter_3p_callbacks[level.altbody_name];
        if (isdefined(callback)) {
            self [[ callback ]](localclientnum);
        }
        return;
    }
    callback = level.altbody_exit_3p_callbacks[level.altbody_name];
    if (isdefined(callback)) {
        self [[ callback ]](localclientnum);
    }
}

// Namespace zm_altbody/zm_altbody
// Params 2, eflags: 0x0
// Checksum 0x86ad51b0, Offset: 0x6e8
// Size: 0xbc
function cover_transition(localclientnum, onoff) {
    if (!self util::function_162f7df2(localclientnum)) {
        return;
    }
    if (isdemoplaying() && demoisanyfreemovecamera()) {
        return;
    }
    lui::screen_fade_out(0.05);
    level waittilltimeout(0.15, #"demo_jump");
    if (isdefined(self)) {
        lui::screen_fade_in(0.1);
    }
}

// Namespace zm_altbody/zm_altbody
// Params 2, eflags: 0x0
// Checksum 0xc7d967c3, Offset: 0x7b0
// Size: 0x2c
function clear_transition(localclientnum, onoff) {
    lui::screen_fade_in(0);
}

