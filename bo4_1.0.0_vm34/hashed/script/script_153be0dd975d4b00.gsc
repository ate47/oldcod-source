#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_audio;

#namespace zm_trap_buy_buttons;

// Namespace zm_trap_buy_buttons/namespace_1f7665f4
// Params 0, eflags: 0x2
// Checksum 0x8a51d311, Offset: 0x140
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_trap_buy_buttons", &__init__, &__main__, undefined);
}

// Namespace zm_trap_buy_buttons/namespace_1f7665f4
// Params 0, eflags: 0x0
// Checksum 0x7cd2eb61, Offset: 0x190
// Size: 0x24
function __init__() {
    callback::on_finalize_initialization(&init);
}

// Namespace zm_trap_buy_buttons/namespace_1f7665f4
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1c0
// Size: 0x4
function __main__() {
    
}

// Namespace zm_trap_buy_buttons/namespace_1f7665f4
// Params 0, eflags: 0x0
// Checksum 0x66d3ba78, Offset: 0x1d0
// Size: 0x74
function init() {
    level.a_s_trap_buttons = struct::get_array("s_trap_button", "targetname");
    scene::add_scene_func("p8_fxanim_zm_towers_trap_switch_bundle", &function_8edd4db5, "init");
    level thread function_1b8272d7();
}

// Namespace zm_trap_buy_buttons/namespace_1f7665f4
// Params 1, eflags: 0x0
// Checksum 0x23b4d8b1, Offset: 0x250
// Size: 0x4c
function function_8edd4db5(a_ents) {
    if (!isdefined(self.script_int)) {
        a_ents[#"prop 1"] clientfield::set("trap_switch_green", 1);
    }
}

// Namespace zm_trap_buy_buttons/namespace_1f7665f4
// Params 1, eflags: 0x0
// Checksum 0xae45db11, Offset: 0x2a8
// Size: 0x98
function function_ec7d377b(str_id) {
    foreach (s_trap_button in level.a_s_trap_buttons) {
        if (s_trap_button.script_string === str_id) {
            s_trap_button thread function_11934821();
        }
    }
}

// Namespace zm_trap_buy_buttons/namespace_1f7665f4
// Params 1, eflags: 0x0
// Checksum 0x94be86fa, Offset: 0x348
// Size: 0x98
function function_e050b6cf(str_id) {
    foreach (s_trap_button in level.a_s_trap_buttons) {
        if (s_trap_button.script_string === str_id) {
            s_trap_button thread function_dfbbff0d();
        }
    }
}

// Namespace zm_trap_buy_buttons/namespace_1f7665f4
// Params 1, eflags: 0x0
// Checksum 0xa7b06626, Offset: 0x3e8
// Size: 0x98
function function_711324ec(str_id) {
    foreach (s_trap_button in level.a_s_trap_buttons) {
        if (s_trap_button.script_string === str_id) {
            s_trap_button thread function_cf0175fb();
        }
    }
}

// Namespace zm_trap_buy_buttons/namespace_1f7665f4
// Params 0, eflags: 0x0
// Checksum 0x575a8b66, Offset: 0x488
// Size: 0x126
function function_1b8272d7() {
    level endon(#"game_ended");
    while (true) {
        s_notify = level waittill(#"traps_activated", #"traps_available", #"traps_cooldown");
        if (isdefined(s_notify.var_f6bb8854)) {
            switch (s_notify._notify) {
            case #"traps_activated":
                function_ec7d377b(s_notify.var_f6bb8854);
                break;
            case #"traps_available":
                function_e050b6cf(s_notify.var_f6bb8854);
                break;
            case #"traps_cooldown":
                function_711324ec(s_notify.var_f6bb8854);
                break;
            }
        }
    }
}

// Namespace zm_trap_buy_buttons/namespace_1f7665f4
// Params 0, eflags: 0x0
// Checksum 0x473d9235, Offset: 0x5b8
// Size: 0x8c
function function_11934821() {
    self thread scene::play("Shot 1");
    self.scene_ents[#"prop 1"] clientfield::set("trap_switch_green", 0);
    self.scene_ents[#"prop 1"] clientfield::set("trap_switch_red", 1);
}

// Namespace zm_trap_buy_buttons/namespace_1f7665f4
// Params 0, eflags: 0x0
// Checksum 0x62a1aa2c, Offset: 0x650
// Size: 0x8c
function function_dfbbff0d() {
    self thread scene::play("Shot 2");
    self.scene_ents[#"prop 1"] clientfield::set("trap_switch_smoke", 0);
    self.scene_ents[#"prop 1"] clientfield::set("trap_switch_green", 1);
}

// Namespace zm_trap_buy_buttons/namespace_1f7665f4
// Params 0, eflags: 0x0
// Checksum 0x6c1982c7, Offset: 0x6e8
// Size: 0x6c
function function_cf0175fb() {
    self.scene_ents[#"prop 1"] clientfield::set("trap_switch_red", 0);
    self.scene_ents[#"prop 1"] clientfield::set("trap_switch_smoke", 1);
}

