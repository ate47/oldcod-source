#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm\zm_towers_util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_items;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_traps;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;

#namespace zm_traps_hellpools;

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 0, eflags: 0x2
// Checksum 0x7102bb8c, Offset: 0x368
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_traps_hellpools", &__init__, &__main__, undefined);
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 0, eflags: 0x0
// Checksum 0xd5e31cb8, Offset: 0x3b8
// Size: 0x3c
function __init__() {
    level thread function_8036e08();
    callback::on_finalize_initialization(&init);
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x400
// Size: 0x4
function __main__() {
    
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 0, eflags: 0x0
// Checksum 0x3872d438, Offset: 0x410
// Size: 0x54
function init() {
    level flag::wait_till("all_players_spawned");
    zm_crafting::function_80bf4df3(#"zblueprint_trap_hellpools", &function_e78a54eb);
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 0, eflags: 0x0
// Checksum 0xd51fe2f6, Offset: 0x470
// Size: 0x3a4
function function_8036e08() {
    level.a_e_hellpools = getentarray("mdl_hellpool_lava_grate", "targetname");
    foreach (e_hellpool in level.a_e_hellpools) {
        e_hellpool flag::init("activated");
        e_hellpool notsolid();
    }
    level.a_s_hellpool_cauldron = struct::get_array("s_hellpool_cauldron", "targetname");
    level.var_2bbd5014 = getentarray("zm_towers_hellpool_ghost", "script_label");
    foreach (part in level.var_2bbd5014) {
        if (part trigger::is_trigger_of_type("trigger_use_new")) {
            part triggerenable(0);
            continue;
        }
        part hide();
    }
    mdl_clip = getent("mdl_acid_trap_cauldron_piece_clip", "targetname");
    mdl_clip notsolid();
    var_ba81031 = getweapon(#"hash_72cba96681a7af18");
    zm_items::function_187a472b(var_ba81031, &function_bf155271);
    a_zombie_traps = getentarray("zombie_trap", "targetname");
    level.var_174215c8 = array::filter(a_zombie_traps, 0, &function_31bc50b1);
    foreach (var_666ea0 in level.var_174215c8) {
        var_666ea0 function_d77a4cf3();
    }
    zm_traps::register_trap_basic_info("hellpool", &function_de65e76b, &function_5f1c3ac3);
    zm_traps::register_trap_damage("hellpool", &function_a88b2e3a, &function_8f25b295);
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 0, eflags: 0x0
// Checksum 0xfdc5705a, Offset: 0x820
// Size: 0x7bc
function function_e78a54eb() {
    var_14d365fa = self.script_noteworthy;
    switch (var_14d365fa) {
    case #"odin":
        level.var_593fd093 = struct::get("zm_towers_hellpool_odin_scene", "script_noteworthy");
        level.var_593fd093 scene::init();
        var_64ae39f = getentarray("zm_towers_hellpool_odin", "script_noteworthy");
        foreach (part in var_64ae39f) {
            if (part trigger::is_trigger_of_type("trigger_use_new")) {
                part triggerenable(1);
                continue;
            }
            part show();
        }
        foreach (s_trap_button in level.a_s_trap_buttons) {
            if (s_trap_button.script_int === 3) {
                s_trap_button.scene_ents[#"prop 1"] clientfield::set("trap_switch_green", 1);
            }
        }
        break;
    case #"zeus":
        level.var_593fd093 = struct::get("zm_towers_hellpool_zeus_scene", "script_noteworthy");
        level.var_593fd093 scene::init();
        var_64ae39f = getentarray("zm_towers_hellpool_zeus", "script_noteworthy");
        foreach (part in var_64ae39f) {
            if (part trigger::is_trigger_of_type("trigger_use_new")) {
                part triggerenable(1);
                continue;
            }
            part show();
        }
        foreach (s_trap_button in level.a_s_trap_buttons) {
            if (s_trap_button.script_int === 4) {
                s_trap_button.scene_ents[#"prop 1"] clientfield::set("trap_switch_green", 1);
            }
        }
        break;
    case #"danu":
        level.var_593fd093 = struct::get("zm_towers_hellpool_danu_scene", "script_noteworthy");
        level.var_593fd093 scene::init();
        var_64ae39f = getentarray("zm_towers_hellpool_danu", "script_noteworthy");
        foreach (part in var_64ae39f) {
            if (part trigger::is_trigger_of_type("trigger_use_new")) {
                part triggerenable(1);
                continue;
            }
            part show();
        }
        foreach (s_trap_button in level.a_s_trap_buttons) {
            if (s_trap_button.script_int === 1) {
                s_trap_button.scene_ents[#"prop 1"] clientfield::set("trap_switch_green", 1);
            }
        }
        break;
    case #"ra":
        level.var_593fd093 = struct::get("zm_towers_hellpool_ra_scene", "script_noteworthy");
        level.var_593fd093 scene::init();
        var_64ae39f = getentarray("zm_towers_hellpool_ra", "script_noteworthy");
        foreach (part in var_64ae39f) {
            if (part trigger::is_trigger_of_type("trigger_use_new")) {
                part triggerenable(1);
                continue;
            }
            part show();
        }
        foreach (s_trap_button in level.a_s_trap_buttons) {
            if (s_trap_button.script_int === 2) {
                s_trap_button.scene_ents[#"prop 1"] clientfield::set("trap_switch_green", 1);
            }
        }
        break;
    }
    level thread zm_crafting::function_4b55c808("zblueprint_trap_hellpools");
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 2, eflags: 0x0
// Checksum 0xbe5dafb1, Offset: 0xfe8
// Size: 0x5c
function function_bf155271(e_holder, w_item) {
    mdl_clip = getent("mdl_acid_trap_cauldron_piece_clip", "targetname");
    if (isdefined(mdl_clip)) {
        mdl_clip delete();
    }
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 1, eflags: 0x0
// Checksum 0x7bd47e66, Offset: 0x1050
// Size: 0x20
function function_31bc50b1(e_ent) {
    return e_ent.script_noteworthy == "hellpool";
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 0, eflags: 0x0
// Checksum 0x53aa1404, Offset: 0x1078
// Size: 0x24
function function_d77a4cf3() {
    self flag::init("activated");
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x10a8
// Size: 0x4
function function_5f1c3ac3() {
    
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 0, eflags: 0x0
// Checksum 0xdb317564, Offset: 0x10b8
// Size: 0x1d4
function function_de65e76b() {
    self._trap_duration = 15;
    self._trap_cooldown_time = 60;
    if (isdefined(level.sndtrapfunc)) {
        level thread [[ level.sndtrapfunc ]](self, 1);
    }
    self notify(#"trap_activate");
    level notify(#"trap_activate", self);
    wait 1;
    self.activated_by_player thread function_3dd640cb(self.script_string);
    foreach (e_trap in level.var_174215c8) {
        if (e_trap.script_string === self.script_string) {
            e_trap thread zm_traps::trap_damage();
        }
    }
    self waittilltimeout(self._trap_duration, #"trap_deactivate");
    foreach (e_trap in level.var_174215c8) {
        if (e_trap.script_string === self.script_string) {
            e_trap notify(#"trap_done");
        }
    }
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 1, eflags: 0x0
// Checksum 0xd7ebe43, Offset: 0x1298
// Size: 0x158
function function_3dd640cb(str_id) {
    self.b_activated = 1;
    foreach (e_hellpool in level.a_e_hellpools) {
        if (e_hellpool.script_string === str_id) {
            e_hellpool thread activate_trap(self);
        }
    }
    level notify(#"traps_activated", {#var_f6bb8854:str_id});
    wait 15;
    level notify(#"traps_cooldown", {#var_f6bb8854:str_id});
    n_cooldown = zm_traps::function_4bcd0324(60, self);
    wait n_cooldown;
    level notify(#"traps_available", {#var_f6bb8854:str_id});
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 1, eflags: 0x0
// Checksum 0xf0f5b197, Offset: 0x13f8
// Size: 0x8c
function activate_trap(e_player) {
    if (!self flag::get("activated")) {
        self flag::set("activated");
        if (isdefined(e_player)) {
            self.activated_by_player = e_player;
        }
        self thread function_1cf4d968();
        wait 15;
        self deactivate_trap();
    }
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 0, eflags: 0x0
// Checksum 0xdb30d4b5, Offset: 0x1490
// Size: 0x6e
function deactivate_trap() {
    if (self flag::get("activated")) {
        self function_a10ff096();
        self flag::clear("activated");
        self notify(#"deactivate");
    }
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 0, eflags: 0x0
// Checksum 0x14ad2b53, Offset: 0x1508
// Size: 0x98
function function_1cf4d968() {
    foreach (s_cauldron in level.a_s_hellpool_cauldron) {
        if (s_cauldron.script_string === self.script_string) {
            self thread function_f91c7243(s_cauldron);
        }
    }
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 0, eflags: 0x0
// Checksum 0xd96d7f38, Offset: 0x15a8
// Size: 0x98
function function_a10ff096() {
    foreach (s_cauldron in level.a_s_hellpool_cauldron) {
        if (s_cauldron.script_string === self.script_string) {
            self thread function_9345ca23(s_cauldron);
        }
    }
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 1, eflags: 0x0
// Checksum 0x8298797d, Offset: 0x1648
// Size: 0x5c
function function_f91c7243(s_cauldron) {
    s_cauldron thread scene::play("shot 1");
    level waittill(#"hash_189e686c493a2a23");
    s_cauldron thread function_47aa6519();
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 1, eflags: 0x0
// Checksum 0x61a5cf9b, Offset: 0x16b0
// Size: 0x2c
function function_9345ca23(s_cauldron) {
    s_cauldron thread scene::play("shot 3");
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 0, eflags: 0x0
// Checksum 0x3507413f, Offset: 0x16e8
// Size: 0x24
function function_47aa6519() {
    self thread scene::play("shot 2");
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 1, eflags: 0x0
// Checksum 0x1aa9a2db, Offset: 0x1718
// Size: 0x174
function function_8f25b295(e_trap) {
    if (isactor(self) && !(isdefined(self.marked_for_death) && self.marked_for_death)) {
        self.marked_for_death = 1;
        if (isplayer(e_trap.activated_by_player)) {
            e_trap.activated_by_player zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_TRAP");
        }
        if (self.var_29ed62b2 == #"miniboss" || self.var_29ed62b2 == #"heavy") {
            return;
        }
        self clientfield::set("acid_trap_death_fx", 1);
        wait 0.75;
        if (isalive(self)) {
            level notify(#"trap_kill", {#e_victim:self, #e_trap:e_trap});
            self dodamage(self.health + 666, self.origin, e_trap);
        }
    }
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 1, eflags: 0x0
// Checksum 0xfc0d25f5, Offset: 0x1898
// Size: 0x16c
function function_a88b2e3a(t_damage) {
    self endoncallback(&function_cfe48a50, #"death", #"disconnect");
    if (isalive(self) && !(isdefined(self.var_3c76c9cc) && self.var_3c76c9cc)) {
        self.var_3c76c9cc = 1;
        if (isplayer(self)) {
            if (!self laststand::player_is_in_laststand()) {
                params = getstatuseffect(#"hash_baee445ed1d9b99");
                if (zm_utility::is_standard()) {
                    params.dotdamage = int(params.dotdamage / 2);
                }
                self status_effect::status_effect_apply(params);
                self clientfield::set_to_player("acid_trap_postfx", 1);
            }
            self function_cfe48a50();
        }
    }
}

// Namespace zm_traps_hellpools/zm_towers_traps_hellpools
// Params 1, eflags: 0x0
// Checksum 0xb8e6e8ba, Offset: 0x1a10
// Size: 0x44
function function_cfe48a50(var_e34146dc) {
    wait 1;
    if (isdefined(self)) {
        self.var_3c76c9cc = 0;
        self clientfield::set_to_player("acid_trap_postfx", 0);
    }
}

