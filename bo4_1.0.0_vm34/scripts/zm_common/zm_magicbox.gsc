#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\callings\zm_callings;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_daily_challenges;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_magicbox;

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x2
// Checksum 0x6b1df3a8, Offset: 0x618
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_magicbox", &__init__, &__main__, undefined);
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x7b8a5f46, Offset: 0x668
// Size: 0x33c
function __init__() {
    level.start_chest_name = "start_chest";
    level._effect[#"hash_2ff87d61167ea531"] = #"hash_d66a9f5776f1fba";
    level._effect[#"hash_4048cb4967032c4a"] = #"hash_1e43d43c6586fcb5";
    level._effect[#"lght_marker"] = #"zombie/fx_weapon_box_marker_zmb";
    level._effect[#"lght_marker_flare"] = #"zombie/fx_weapon_box_marker_fl_zmb";
    level._effect[#"poltergeist"] = #"zombie/fx_barrier_buy_zmb";
    clientfield::register("zbarrier", "magicbox_open_fx", 1, 1, "int");
    clientfield::register("zbarrier", "magicbox_closed_fx", 1, 1, "int");
    clientfield::register("zbarrier", "magicbox_leave_fx", 1, 1, "counter");
    clientfield::register("zbarrier", "zbarrier_show_sounds", 1, 1, "counter");
    clientfield::register("zbarrier", "zbarrier_leave_sounds", 1, 1, "counter");
    clientfield::register("zbarrier", "force_stream_magicbox", 1, 1, "int");
    clientfield::register("zbarrier", "force_stream_magicbox_leave", 1, 1, "int");
    clientfield::register("scriptmover", "force_stream", 1, 1, "int");
    clientfield::register("zbarrier", "t8_magicbox_crack_glow_fx", 1, 1, "int");
    clientfield::register("zbarrier", "t8_magicbox_ambient_fx", 1, 1, "int");
    clientfield::register("zbarrier", "" + #"hash_2fcdae6b889933c7", 1, 1, "int");
    level thread magicbox_host_migration();
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xf9805204, Offset: 0x9b0
// Size: 0xe4
function __main__() {
    if (!isdefined(level.chest_joker_model)) {
        level.chest_joker_model = "p7_zm_teddybear";
    }
    if (!isdefined(level.magic_box_zbarrier_state_func)) {
        level.magic_box_zbarrier_state_func = &process_magic_box_zbarrier_state;
    }
    if (!isdefined(level.magic_box_check_equipment)) {
        level.magic_box_check_equipment = &default_magic_box_check_equipment;
    }
    waitframe(1);
    treasure_chest_init(level.start_chest_name);
    level thread function_5d355585();
    if (zm_custom::function_5638f689(#"zmmysteryboxlimitround")) {
        level thread function_c2aedf84();
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xc317317d, Offset: 0xaa0
// Size: 0x35c
function treasure_chest_init(start_chest_name) {
    level flag::init("moving_chest_enabled");
    level flag::init("moving_chest_now");
    level flag::init("chest_has_been_used");
    level flag::init("chest_weapon_has_been_taken");
    level.chest_moves = 0;
    level.chest_level = 0;
    level.chests = struct::get_array("treasure_chest_use", "targetname");
    if (level.chests.size == 0) {
        return;
    }
    for (i = 0; i < level.chests.size; i++) {
        level.chests[i].box_hacks = [];
        level.chests[i].orig_origin = level.chests[i].origin;
        level.chests[i] get_chest_pieces();
        if (isdefined(level.chests[i].zombie_cost)) {
            level.chests[i].old_cost = level.chests[i].zombie_cost;
            continue;
        }
        level.chests[i].old_cost = 950;
    }
    if (!level.enable_magic || zm_custom::function_5638f689(#"zmmysteryboxstate") == 0) {
        foreach (chest in level.chests) {
            chest hide_chest();
        }
        return;
    }
    level.chest_accessed = 0;
    if (level.chests.size > 1) {
        level flag::set("moving_chest_enabled");
        level.chests = array::randomize(level.chests);
    } else {
        level.chest_index = 0;
        level.chests[0].no_fly_away = 1;
    }
    init_starting_chest_location(start_chest_name);
    array::thread_all(level.chests, &treasure_chest_think);
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xa99bdad6, Offset: 0xe08
// Size: 0x47c
function init_starting_chest_location(start_chest_name) {
    level.chest_index = 0;
    start_chest_found = 0;
    if (level.chests.size == 1) {
        start_chest_found = 1;
        if (isdefined(level.chests[level.chest_index].zbarrier)) {
            level.chests[level.chest_index].zbarrier set_magic_box_zbarrier_state("initial");
            level.chests[level.chest_index] thread zm_audio::function_2b96f4d0("box", 0, -1, 500, "left");
        }
    } else if (zm_custom::function_5638f689(#"zmmysteryboxstate") == 3) {
        for (i = 0; i < level.chests.size; i++) {
            level.chests[i] function_25db8647();
            level.chests[i].no_fly_away = 1;
            level.chests[i] thread show_chest();
        }
    } else if (zm_custom::function_5638f689(#"zmmysteryboxstate") == 1) {
        level.chest_index = -1;
        for (i = 0; i < level.chests.size; i++) {
            level.chests[i] hide_chest();
        }
    } else {
        for (i = 0; i < level.chests.size; i++) {
            if (isdefined(level.random_pandora_box_start) && level.random_pandora_box_start == 1) {
                if (start_chest_found || isdefined(level.chests[i].start_exclude) && level.chests[i].start_exclude == 1) {
                    level.chests[i] hide_chest();
                } else {
                    level.chest_index = i;
                    level.chests[i] thread function_25db8647();
                    start_chest_found = 1;
                }
                continue;
            }
            if (start_chest_found || !isdefined(level.chests[i].script_noteworthy) || !issubstr(level.chests[i].script_noteworthy, start_chest_name)) {
                level.chests[i] hide_chest();
                continue;
            }
            level.chest_index = i;
            level.chests[i] thread function_25db8647();
            start_chest_found = 1;
        }
    }
    if (!isdefined(level.pandora_show_func)) {
        if (isdefined(level.custom_pandora_show_func)) {
            level.pandora_show_func = level.custom_pandora_show_func;
        } else {
            level.pandora_show_func = &default_pandora_show_func;
        }
    }
    if (!(isdefined(zm_custom::function_5638f689(#"zmmysteryboxstate") == 1) && zm_custom::function_5638f689(#"zmmysteryboxstate") == 1)) {
        level.chests[level.chest_index] thread [[ level.pandora_show_func ]]();
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x5fa7fe03, Offset: 0x1290
// Size: 0x1a
function set_treasure_chest_cost(cost) {
    level.zombie_treasure_chest_cost = cost;
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x4f9c0039, Offset: 0x12b8
// Size: 0x24e
function get_chest_pieces() {
    self.chest_box = getent(self.script_noteworthy + "_zbarrier", "script_noteworthy");
    self.chest_rubble = [];
    rubble = getentarray(self.script_noteworthy + "_rubble", "script_noteworthy");
    for (i = 0; i < rubble.size; i++) {
        if (distancesquared(self.origin, rubble[i].origin) < 10000) {
            self.chest_rubble[self.chest_rubble.size] = rubble[i];
        }
    }
    self.zbarrier = getent(self.script_noteworthy + "_zbarrier", "script_noteworthy");
    if (isdefined(self.zbarrier)) {
        self.zbarrier zbarrierpieceuseboxriselogic(3);
        self.zbarrier zbarrierpieceuseboxriselogic(4);
    }
    self.unitrigger_stub = zm_unitrigger::function_9916df24(104, 45, 50);
    zm_unitrigger::function_3fc5694(self.unitrigger_stub, self.origin + anglestoright(self.angles) * -22.5, self.angles);
    zm_unitrigger::function_2e5dcd8b(self.unitrigger_stub, &boxtrigger_update_prompt);
    zm_unitrigger::unitrigger_force_per_player_triggers(self.unitrigger_stub, 1);
    self.unitrigger_stub.trigger_target = self;
    self.zbarrier.owner = self;
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xda1bf00f, Offset: 0x1510
// Size: 0x90
function boxtrigger_update_prompt(player) {
    can_use = self boxstub_update_prompt(player);
    if (isdefined(self.hint_string)) {
        if (isdefined(self.hint_parm1)) {
            self sethintstring(self.hint_string, self.hint_parm1);
        } else {
            self sethintstring(self.hint_string);
        }
    }
    return can_use;
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x1f9a4401, Offset: 0x15a8
// Size: 0x36e
function boxstub_update_prompt(player) {
    if (isdefined(self.stub.var_24e0d010) && self.stub.var_24e0d010) {
        return false;
    }
    if (isdefined(self.stub.trigger_target.is_locked) && self.stub.trigger_target.is_locked) {
        return false;
    }
    if (!self trigger_visible_to_player(player)) {
        return false;
    }
    if (isdefined(level.func_magicbox_update_prompt_use_override)) {
        if (self [[ level.func_magicbox_update_prompt_use_override ]](player)) {
            if (zm_utility::is_standard()) {
                return true;
            } else {
                return false;
            }
        }
    }
    self.hint_parm1 = undefined;
    if (isdefined(self.stub.trigger_target.grab_weapon_hint) && self.stub.trigger_target.grab_weapon_hint) {
        cursor_hint = "HINT_WEAPON";
        cursor_hint_weapon = self.stub.trigger_target.grab_weapon;
        self setcursorhint(cursor_hint, cursor_hint_weapon);
        if (isdefined(level.magic_box_check_equipment) && [[ level.magic_box_check_equipment ]](cursor_hint_weapon)) {
            self.hint_string = #"hash_53005c8d5b45bca3";
            if (!(isdefined(self.stub.trigger_target.var_aca61d1d) && self.stub.trigger_target.var_aca61d1d) && isdefined(self.stub.trigger_target.var_c3b9c385) && self.stub.trigger_target.var_c3b9c385) {
                self.hint_string = #"hash_4320539409034300";
            }
        } else {
            self.hint_string = #"hash_6a4c5538a960189d";
            if (!(isdefined(self.stub.trigger_target.var_aca61d1d) && self.stub.trigger_target.var_aca61d1d) && isdefined(self.stub.trigger_target.var_c3b9c385) && self.stub.trigger_target.var_c3b9c385) {
                self.hint_string = #"hash_4a972ee1265d60a";
            }
        }
    } else if (zm_trial_disable_buys::is_active()) {
        return false;
    } else {
        self setcursorhint("HINT_NOICON");
        self.hint_parm1 = self.stub.trigger_target.zombie_cost;
        self.hint_string = zm_utility::get_hint_string(self, "default_treasure_chest");
    }
    return true;
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x70fa47f5, Offset: 0x1920
// Size: 0x22
function default_magic_box_check_equipment(weapon) {
    return zm_loadout::is_offhand_weapon(weapon);
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x981cbfe, Offset: 0x1950
// Size: 0x1d8
function trigger_visible_to_player(player) {
    self setinvisibletoplayer(player);
    visible = 1;
    var_94c2e113 = self.stub.trigger_target;
    if (isdefined(var_94c2e113.chest_user) && !isdefined(var_94c2e113.box_rerespun)) {
        wpn_current = var_94c2e113.chest_user getcurrentweapon();
        if (player != var_94c2e113.chest_user && !(isdefined(var_94c2e113.var_aca61d1d) && var_94c2e113.var_aca61d1d) || zm_loadout::is_placeable_mine(wpn_current) || wpn_current.isheroweapon || wpn_current.isgadget || wpn_current.isriotshield || var_94c2e113.chest_user zm_equipment::hacker_active()) {
            visible = 0;
        }
    } else if (!player can_buy_weapon()) {
        visible = 0;
    }
    if (player bgb::is_enabled(#"zm_bgb_disorderly_combat")) {
        visible = 0;
    }
    if (isdefined(level.var_694c1302)) {
        if (!self [[ level.var_694c1302 ]](player)) {
            visible = 0;
        }
    }
    if (!visible) {
        return false;
    }
    self setvisibletoplayer(player);
    return true;
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x3bad9b9b, Offset: 0x1b30
// Size: 0x58
function magicbox_unitrigger_think() {
    self endon(#"kill_trigger");
    while (true) {
        self.stub.trigger_target notify(#"trigger", self waittill(#"trigger"));
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x2b680e1e, Offset: 0x1b90
// Size: 0x24
function play_crazi_sound() {
    self playlocalsound(#"hash_7d764f09cd3dea92");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x72819ac6, Offset: 0x1bc0
// Size: 0x168
function function_25db8647() {
    self.hidden = 0;
    self.zbarrier.state = "initial";
    level flag::wait_till("all_players_spawned");
    if (isdefined(self.zbarrier)) {
        self.zbarrier set_magic_box_zbarrier_state("initial");
        self thread zm_audio::function_2b96f4d0("box", 0, -1, 500, "left");
        if (self.zbarrier.classname === "zbarrier_zm_esc_magicbox") {
            self.zbarrier thread function_293cc97d();
        } else if (self.zbarrier.script_string === "t8_magicbox") {
            self.zbarrier thread function_9d211654();
            self.zbarrier clientfield::set("t8_magicbox_ambient_fx", 1);
        }
    }
    level notify(#"hash_e39eca74fa250b4", {#s_magic_box:self});
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xd637e37f, Offset: 0x1d30
// Size: 0x178
function show_chest() {
    self.zbarrier set_magic_box_zbarrier_state("arriving");
    self.zbarrier waittilltimeout(5, #"arrived");
    self thread [[ level.pandora_show_func ]]();
    if (self.zbarrier.script_string !== "t8_magicbox") {
        self.zbarrier clientfield::set("magicbox_closed_fx", 1);
    } else {
        self.zbarrier clientfield::set("t8_magicbox_ambient_fx", 1);
    }
    thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &magicbox_unitrigger_think);
    self.zbarrier clientfield::increment("zbarrier_show_sounds");
    self.hidden = 0;
    if (isdefined(self.box_hacks[#"summon_box"])) {
        self [[ self.box_hacks[#"summon_box"] ]](0);
    }
    level notify(#"hash_e39eca74fa250b4", {#s_magic_box:self});
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x4ec6f1af, Offset: 0x1eb0
// Size: 0x2e0
function hide_chest(doboxleave) {
    if (isdefined(self.unitrigger_stub)) {
        thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
    }
    if (isdefined(self.pandora_light)) {
        self.pandora_light delete();
    }
    if (self.zbarrier.script_string === "t8_magicbox") {
        self.zbarrier clientfield::set("t8_magicbox_ambient_fx", 0);
    }
    self.zbarrier clientfield::set("magicbox_closed_fx", 0);
    self.hidden = 1;
    if (isdefined(self.box_hacks) && isdefined(self.box_hacks[#"summon_box"])) {
        self [[ self.box_hacks[#"summon_box"] ]](1);
    }
    if (isdefined(self.zbarrier)) {
        if (isdefined(doboxleave) && doboxleave) {
            self.zbarrier clientfield::increment("zbarrier_leave_sounds");
            self.zbarrier thread magic_box_zbarrier_leave();
            if (self.zbarrier.script_string === "t8_magicbox") {
                self.zbarrier thread function_db1fa7b1();
            }
            self.zbarrier waittill(#"left");
            if (self.zbarrier.script_string !== "t8_magicbox") {
                if (isdefined(level.var_61728fdb)) {
                    str_fx = level.var_61728fdb;
                } else {
                    str_fx = level._effect[#"poltergeist"];
                }
                playfx(str_fx, self.zbarrier.origin, anglestoup(self.zbarrier.angles), anglestoforward(self.zbarrier.angles));
            }
        } else {
            self.zbarrier thread set_magic_box_zbarrier_state("away");
        }
    }
    level notify(#"hash_e39eca74fa250b4", {#s_magic_box:self});
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x4
// Checksum 0x3588de77, Offset: 0x2198
// Size: 0x2c
function private function_db1fa7b1() {
    wait 0.5;
    self clientfield::increment("magicbox_leave_fx");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xe9826843, Offset: 0x21d0
// Size: 0x20c
function default_pandora_fx_func() {
    self endon(#"death");
    self.pandora_light = spawn("script_model", self.zbarrier.origin);
    s_pandora_fx_pos_override = struct::get(self.target, "targetname");
    if (isdefined(s_pandora_fx_pos_override) && s_pandora_fx_pos_override.script_noteworthy === "pandora_fx_pos_override") {
        self.pandora_light.origin = s_pandora_fx_pos_override.origin;
    }
    self.pandora_light.angles = self.zbarrier.angles + (-90, 0, -90);
    self.pandora_light setmodel(#"tag_origin");
    if (!(isdefined(level._box_initialized) && level._box_initialized)) {
        level flag::wait_till("start_zombie_round_logic");
        level._box_initialized = 1;
    }
    wait 1;
    if (isdefined(self) && isdefined(self.pandora_light)) {
        if (self.zbarrier.script_string === "t8_magicbox") {
            playfxontag(level._effect[#"hash_2ff87d61167ea531"], self.pandora_light, "tag_origin");
            return;
        }
        playfxontag(level._effect[#"lght_marker"], self.pandora_light, "tag_origin");
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 3, eflags: 0x0
// Checksum 0x8f770ed4, Offset: 0x23e8
// Size: 0xf4
function default_pandora_show_func(anchor, anchortarget, pieces) {
    if (!isdefined(self.pandora_light)) {
        if (!isdefined(level.pandora_fx_func)) {
            level.pandora_fx_func = &default_pandora_fx_func;
        }
        self thread [[ level.pandora_fx_func ]]();
    }
    if (self.zbarrier.script_string === "t8_magicbox") {
        playfx(level._effect[#"hash_4048cb4967032c4a"], self.pandora_light.origin);
        return;
    }
    playfx(level._effect[#"lght_marker_flare"], self.pandora_light.origin);
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x325eb6b2, Offset: 0x24e8
// Size: 0x5c
function function_9d211654() {
    self clientfield::set("t8_magicbox_crack_glow_fx", 1);
    self waittill(#"zbarrier_state_change");
    self clientfield::set("t8_magicbox_crack_glow_fx", 0);
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xfe0063e3, Offset: 0x2550
// Size: 0x74
function function_293cc97d() {
    self clientfield::set("" + #"hash_2fcdae6b889933c7", 1);
    self waittill(#"zbarrier_state_change");
    self clientfield::set("" + #"hash_2fcdae6b889933c7", 0);
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xeb94462e, Offset: 0x25d0
// Size: 0x54
function unregister_unitrigger_on_kill_think() {
    self notify(#"unregister_unitrigger_on_kill_think");
    self endon(#"unregister_unitrigger_on_kill_think");
    self waittill(#"kill_chest_think");
    thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x3bec6942, Offset: 0x2630
// Size: 0x1344
function treasure_chest_think() {
    self endon(#"kill_chest_think");
    user = undefined;
    user_cost = undefined;
    self.box_rerespun = undefined;
    self.weapon_out = undefined;
    self thread unregister_unitrigger_on_kill_think();
    while (true) {
        if (!isdefined(self.forced_user)) {
            waitresult = self waittill(#"trigger");
            user = waitresult.activator;
            if (user == level || isdefined(user.var_4d17ef23) && user.var_4d17ef23) {
                continue;
            }
        } else {
            user = self.forced_user;
        }
        if (!user can_buy_weapon() || isdefined(self.disabled) && self.disabled || zm_trial_disable_buys::is_active() || isdefined(self.being_removed) && self.being_removed) {
            wait 0.1;
            continue;
        }
        reduced_cost = undefined;
        if (isdefined(self.auto_open) && zm_utility::is_player_valid(user)) {
            if (!isdefined(self.var_c20f8a07)) {
                user zm_score::minus_to_player_score(self.zombie_cost);
                user_cost = self.zombie_cost;
            } else {
                user_cost = 0;
            }
            self.chest_user = user;
            break;
        } else if (zm_utility::is_player_valid(user) && user zm_score::can_player_purchase(self.zombie_cost)) {
            user zm_score::minus_to_player_score(self.zombie_cost);
            user_cost = self.zombie_cost;
            self.chest_user = user;
            break;
        } else if (isdefined(reduced_cost) && user zm_score::can_player_purchase(reduced_cost)) {
            user zm_score::minus_to_player_score(reduced_cost);
            user_cost = reduced_cost;
            self.chest_user = user;
            break;
        } else if (!user zm_score::can_player_purchase(self.zombie_cost)) {
            zm_utility::play_sound_at_pos("no_purchase", self.origin);
            user zm_audio::create_and_play_dialog("general", "outofmoney");
            continue;
        }
        waitframe(1);
    }
    level flag::set("chest_has_been_used");
    demo::bookmark(#"zm_player_use_magicbox", gettime(), user);
    potm::bookmark(#"zm_player_use_magicbox", gettime(), user);
    user zm_stats::increment_client_stat("use_magicbox");
    user zm_stats::increment_player_stat("use_magicbox");
    user zm_stats::increment_challenge_stat("SURVIVALIST_BUY_MAGIC_BOX");
    user zm_daily_challenges::increment_magic_box();
    user zm_callings::function_7cafbdd3(20);
    user zm_callings::function_7cafbdd3(18);
    if (isplayer(self.chest_user)) {
        self.chest_user util::delay(0, "death", &zm_audio::create_and_play_dialog, "box", "interact");
    }
    self thread watch_for_emp_close();
    self thread zm_trial_disable_buys::function_713cd670();
    if (isdefined(level.var_b954edb)) {
        self thread [[ level.var_b954edb ]]();
    }
    self._box_open = 1;
    self._box_opened_by_fire_sale = 0;
    if (isdefined(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) && zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on") && !isdefined(self.auto_open) && self [[ level._zombiemode_check_firesale_loc_valid_func ]]()) {
        self._box_opened_by_fire_sale = 1;
    }
    if (zm_custom::function_5638f689(#"zmmysteryboxlimit")) {
        if (!isdefined(level.var_27dbeb11)) {
            level.var_27dbeb11 = 0;
        }
        level.var_27dbeb11 += 1;
        if (level.var_27dbeb11 >= zm_custom::function_5638f689(#"zmmysteryboxlimit")) {
            zm_powerups::powerup_remove_from_regular_drops("fire_sale");
            level thread function_681ae0fd();
        }
    }
    if (zm_custom::function_5638f689(#"zmmysteryboxlimitround")) {
        if (level.var_43224db9 !== level.round_number) {
            level.var_a8f0b8a1 = 1;
            level.var_43224db9 = level.round_number;
        } else {
            level.var_a8f0b8a1 += 1;
        }
    }
    if (isdefined(self.chest_lid)) {
        self.chest_lid thread treasure_chest_lid_open();
    }
    if (isdefined(self.zbarrier)) {
        self.zbarrier set_magic_box_zbarrier_state("open");
    }
    self.timedout = 0;
    self.weapon_out = 1;
    self.zbarrier thread treasure_chest_weapon_spawn(self, user);
    if (isdefined(level.custom_treasure_chest_glowfx)) {
        self.zbarrier thread [[ level.custom_treasure_chest_glowfx ]]();
    } else {
        self.zbarrier thread treasure_chest_glowfx();
    }
    thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
    self.zbarrier waittill(#"randomization_done", #"box_hacked_respin");
    if (isdefined(user)) {
        if (level flag::get("moving_chest_now") && !self._box_opened_by_fire_sale && isdefined(user_cost)) {
            user zm_score::add_to_player_score(user_cost, 0, "magicbox_bear");
        }
    }
    if (level flag::get("moving_chest_now") && !zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on") && !self._box_opened_by_fire_sale) {
        self thread treasure_chest_move(self.chest_user);
    } else {
        if (!(isdefined(self.unbearable_respin) && self.unbearable_respin)) {
            if (isdefined(user)) {
                self.grab_weapon_hint = 1;
                self.grab_weapon = self.zbarrier.weapon;
                self.chest_user = user;
                bb::logpurchaseevent(user, self, user_cost, self.grab_weapon, 0, "_magicbox", "_offered");
                weaponidx = undefined;
                if (isdefined(self.grab_weapon)) {
                    weaponidx = matchrecordgetweaponindex(self.grab_weapon);
                }
                if (isdefined(weaponidx)) {
                    user recordmapevent(10, gettime(), user.origin, level.round_number, weaponidx);
                }
                thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &magicbox_unitrigger_think);
                if (!(isdefined(self.zbarrier.weapon.isheroweapon) && self.zbarrier.weapon.isheroweapon) && zm_utility::get_number_of_valid_players() > 1) {
                    self thread function_91d3b36a();
                }
            }
            if (isdefined(self.zbarrier) && !(isdefined(self.zbarrier.var_41ea08e9) && self.zbarrier.var_41ea08e9)) {
                self thread treasure_chest_timeout();
            }
        }
        while (!(isdefined(self.var_41ea08e9) && self.var_41ea08e9)) {
            waitresult = self waittill(#"trigger");
            grabber = waitresult.activator;
            self.weapon_out = undefined;
            if (isdefined(level.magic_box_grab_by_anyone) && level.magic_box_grab_by_anyone || isdefined(self.var_aca61d1d) && self.var_aca61d1d) {
                if (isplayer(grabber)) {
                    user = grabber;
                }
            }
            if (isdefined(user)) {
                wpn_current = user getcurrentweapon();
                if (grabber != level && grabber zm_utility::is_drinking() || grabber == user && wpn_current == level.weaponnone || grabber == user && wpn_current.isriotshield) {
                    wait 0.1;
                    continue;
                }
                if (grabber != level && isdefined(self.box_rerespun) && self.box_rerespun) {
                    user = grabber;
                }
            }
            if (grabber == user || grabber == level) {
                self.box_rerespun = undefined;
                current_weapon = level.weaponnone;
                if (zm_utility::is_player_valid(user)) {
                    current_weapon = user getcurrentweapon();
                }
                if (grabber == user && zm_utility::is_player_valid(user) && !user zm_utility::is_drinking() && !zm_loadout::is_placeable_mine(current_weapon) && !zm_equipment::is_equipment(current_weapon) && !user zm_utility::is_player_revive_tool(current_weapon) && !current_weapon.isheroweapon && !current_weapon.isgadget) {
                    bb::logpurchaseevent(user, self, user_cost, self.zbarrier.weapon, 0, "_magicbox", "_grabbed");
                    weaponidx = undefined;
                    if (isdefined(self.zbarrier) && isdefined(self.zbarrier.weapon)) {
                        weaponidx = matchrecordgetweaponindex(self.zbarrier.weapon);
                    }
                    if (isdefined(weaponidx)) {
                        user recordmapevent(11, gettime(), user.origin, level.round_number, weaponidx);
                    }
                    self notify(#"user_grabbed_weapon");
                    user notify(#"user_grabbed_weapon");
                    user thread treasure_chest_give_weapon(self.zbarrier.weapon);
                    if (isplayer(self.var_147a1de)) {
                        self.var_147a1de zm_utility::giveachievement_wrapper("zm_trophy_straw_purchase");
                        self.var_147a1de = undefined;
                    }
                    demo::bookmark(#"zm_player_grabbed_magicbox", gettime(), user);
                    potm::bookmark(#"zm_player_grabbed_magicbox", gettime(), user);
                    user zm_stats::increment_client_stat("grabbed_from_magicbox");
                    user zm_stats::increment_player_stat("grabbed_from_magicbox");
                    if (isdefined(level.var_9760ce17)) {
                        self [[ level.var_9760ce17 ]](user);
                    }
                    break;
                } else if (grabber == level) {
                    self.timedout = 1;
                    if (isdefined(user)) {
                        bb::logpurchaseevent(user, self, user_cost, self.zbarrier.weapon, 0, "_magicbox", "_returned");
                        weaponidx = undefined;
                        if (isdefined(self.zbarrier) && isdefined(self.zbarrier.weapon)) {
                            weaponidx = matchrecordgetweaponindex(self.zbarrier.weapon);
                        }
                        if (isdefined(weaponidx)) {
                            user recordmapevent(12, gettime(), user.origin, level.round_number, weaponidx);
                        }
                    }
                    break;
                }
            }
            waitframe(1);
        }
        self.grab_weapon_hint = 0;
        self.zbarrier notify(#"weapon_grabbed");
        if (!(isdefined(self._box_opened_by_fire_sale) && self._box_opened_by_fire_sale)) {
            level.chest_accessed += 1;
        }
        thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
        if (isdefined(self.chest_lid)) {
            self.chest_lid thread treasure_chest_lid_close(self.timedout);
        }
        if (isdefined(self.zbarrier)) {
            self.zbarrier set_magic_box_zbarrier_state("close");
            zm_utility::play_sound_at_pos("close_chest", self.origin);
            self.zbarrier waittill(#"closed");
            wait 1;
        } else {
            wait 3;
        }
        if (zm_custom::function_5638f689(#"zmmysteryboxlimitround")) {
            if (level.var_a8f0b8a1 >= zm_custom::function_5638f689(#"zmmysteryboxlimitround")) {
                level waittill(#"end_of_round");
            }
        }
        if (isdefined(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) && zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on") && self [[ level._zombiemode_check_firesale_loc_valid_func ]]() || zm_custom::function_5638f689(#"zmmysteryboxstate") == 3 || zm_custom::function_5638f689(#"zmmysteryboxstate") == 1 || self == level.chests[level.chest_index]) {
            thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &magicbox_unitrigger_think);
        }
    }
    self._box_open = 0;
    self._box_opened_by_fire_sale = 0;
    self.unbearable_respin = undefined;
    self.chest_user = undefined;
    self notify(#"chest_accessed");
    level flag::set("chest_weapon_has_been_taken");
    if (zm_custom::function_5638f689(#"zmmysteryboxlimit")) {
        if (level.var_27dbeb11 >= zm_custom::function_5638f689(#"zmmysteryboxlimit")) {
            return;
        }
    }
    self thread treasure_chest_think();
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x85cb8565, Offset: 0x3980
// Size: 0x1ea
function function_91d3b36a() {
    self.chest_user endon(#"bled_out", #"death");
    self.zbarrier endon(#"weapon_grabbed");
    self.var_aca61d1d = 0;
    self.var_c3b9c385 = 0;
    var_916bc8a6 = self.chest_user;
    var_f0ae993 = self.zbarrier.weapon_model;
    for (var_67b5dd94 = undefined; !isdefined(var_67b5dd94); var_67b5dd94 = zm_unitrigger::function_316f5c43(self.unitrigger_stub, var_916bc8a6)) {
        util::wait_network_frame();
    }
    var_67b5dd94 endon(#"kill_trigger");
    var_f0ae993 endon(#"death");
    while (true) {
        self.var_c3b9c385 = 0;
        if (var_916bc8a6 util::is_looking_at(var_f0ae993)) {
            self.var_c3b9c385 = 1;
        }
        if (var_916bc8a6 meleebuttonpressed() && self.var_c3b9c385 && var_916bc8a6 istouching(var_67b5dd94)) {
            self.var_aca61d1d = 1;
            self.var_147a1de = var_916bc8a6;
            var_f0ae993 clientfield::set("powerup_fx", 1);
            var_916bc8a6 thread zm_audio::create_and_play_dialog("magicbox", "share");
            break;
        }
        waitframe(1);
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xbb904236, Offset: 0x3b78
// Size: 0x1ce
function watch_for_emp_close() {
    self endon(#"chest_accessed");
    self.var_41ea08e9 = 0;
    if (!zm_utility::should_watch_for_emp()) {
        return;
    }
    if (isdefined(self.zbarrier)) {
        self.zbarrier.var_41ea08e9 = 0;
    }
    while (true) {
        waitresult = level waittill(#"emp_detonate");
        if (distancesquared(waitresult.position, self.origin) < waitresult.radius * waitresult.radius) {
            break;
        }
    }
    if (level flag::get("moving_chest_now")) {
        return;
    }
    self.var_41ea08e9 = 1;
    if (isdefined(self.zbarrier)) {
        self.zbarrier.var_41ea08e9 = 1;
        self.zbarrier notify(#"box_hacked_respin");
        if (isdefined(self.zbarrier.weapon_model)) {
            self.zbarrier.weapon_model notify(#"kill_weapon_movement");
        }
        if (isdefined(self.zbarrier.weapon_model_dw)) {
            self.zbarrier.weapon_model_dw notify(#"kill_weapon_movement");
        }
    }
    wait 0.1;
    self notify(#"trigger", {#activator:level});
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x76b192f, Offset: 0x3d50
// Size: 0x17e
function can_buy_weapon() {
    if (zm_custom::function_5638f689(#"zmmysteryboxlimitround")) {
        if ((isdefined(level.var_a8f0b8a1) ? level.var_a8f0b8a1 : 0) >= zm_custom::function_5638f689(#"zmmysteryboxlimitround")) {
            return false;
        }
    }
    if (self zm_utility::is_drinking()) {
        return false;
    }
    if (self zm_equipment::hacker_active()) {
        return false;
    }
    current_weapon = self getcurrentweapon();
    if (zm_loadout::is_placeable_mine(current_weapon) || zm_equipment::is_equipment_that_blocks_purchase(current_weapon)) {
        return false;
    }
    if (self zm_utility::in_revive_trigger()) {
        return false;
    }
    if (current_weapon == level.weaponnone) {
        return false;
    }
    if (current_weapon.isheroweapon || current_weapon.isgadget || current_weapon.isriotshield) {
        return false;
    }
    if (!self zm_laststand::laststand_has_players_weapons_returned()) {
        return false;
    }
    return true;
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xca0731db, Offset: 0x3ed8
// Size: 0x174
function default_box_move_logic() {
    index = -1;
    for (i = 0; i < level.chests.size; i++) {
        if (issubstr(level.chests[i].script_noteworthy, "move" + level.chest_moves + 1) && i != level.chest_index) {
            index = i;
            break;
        }
    }
    if (index != -1) {
        level.chest_index = index;
    } else {
        level.chest_index++;
    }
    if (level.chest_index >= level.chests.size) {
        temp_chest_name = level.chests[level.chest_index - 1].script_noteworthy;
        level.chest_index = 0;
        level.chests = array::randomize(level.chests);
        if (temp_chest_name == level.chests[level.chest_index].script_noteworthy) {
            level.chest_index++;
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x7a49eb53, Offset: 0x4058
// Size: 0x426
function treasure_chest_move(player_vox) {
    level waittill(#"weapon_fly_away_start");
    players = getplayers();
    array::thread_all(players, &play_crazi_sound);
    level thread function_c72b3fa0();
    if (isdefined(player_vox)) {
        player_vox util::delay(15, "game_ended", &zm_audio::create_and_play_dialog, "magicbox", "move");
    }
    level waittill(#"weapon_fly_away_end");
    if (isdefined(self.zbarrier)) {
        self hide_chest(1);
    }
    wait 0.1;
    post_selection_wait_duration = 7;
    if (zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on") == 1 && self [[ level._zombiemode_check_firesale_loc_valid_func ]]()) {
        current_sale_time = zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_time");
        util::wait_network_frame();
        self thread fire_sale_fix();
        zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", current_sale_time);
        while (zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_time") > 0) {
            wait 0.1;
        }
    } else {
        post_selection_wait_duration += 5;
    }
    level.verify_chest = 0;
    if (isdefined(level._zombiemode_custom_box_move_logic)) {
        [[ level._zombiemode_custom_box_move_logic ]]();
    } else {
        default_box_move_logic();
    }
    if (isdefined(level.chests[level.chest_index].box_hacks[#"summon_box"])) {
        level.chests[level.chest_index] [[ level.chests[level.chest_index].box_hacks[#"summon_box"] ]](0);
    }
    wait post_selection_wait_duration;
    if (level.chests[level.chest_index].zbarrier.script_string !== "t8_magicbox") {
        if (isdefined(level.var_61728fdb)) {
            str_fx = level.var_61728fdb;
        } else {
            str_fx = level._effect[#"poltergeist"];
        }
        playfx(str_fx, level.chests[level.chest_index].zbarrier.origin, anglestoup(level.chests[level.chest_index].zbarrier.angles), anglestoforward(level.chests[level.chest_index].zbarrier.angles));
    }
    level.chests[level.chest_index] show_chest();
    level flag::clear("moving_chest_now");
    self.zbarrier.chest_moving = 0;
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x1b863f8c, Offset: 0x4488
// Size: 0x54
function function_c72b3fa0() {
    level endon(#"game_over");
    level endon(#"hash_5002eab927d4056d");
    wait 5;
    level thread zm_audio::sndannouncerplayvox("boxmove");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xa2e4d042, Offset: 0x44e8
// Size: 0x11a
function fire_sale_fix() {
    if (!isdefined(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on"))) {
        return;
    }
    if (zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) {
        self.old_cost = 950;
        self thread show_chest();
        self.zombie_cost = 10;
        zm_unitrigger::function_81f99740(self.unitrigger_stub, self, "default_treasure_chest", self.zombie_cost);
        util::wait_network_frame();
        level waittill(#"fire_sale_off");
        while (isdefined(self._box_open) && self._box_open) {
            wait 0.1;
        }
        self hide_chest(1);
        self.zombie_cost = self.old_cost;
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xad443a1, Offset: 0x4610
// Size: 0xf6
function check_for_desirable_chest_location() {
    if (!isdefined(level.desirable_chest_location)) {
        return level.chest_index;
    }
    if (level.chests[level.chest_index].script_noteworthy == level.desirable_chest_location) {
        level.desirable_chest_location = undefined;
        return level.chest_index;
    }
    for (i = 0; i < level.chests.size; i++) {
        if (level.chests[i].script_noteworthy == level.desirable_chest_location) {
            level.desirable_chest_location = undefined;
            return i;
        }
    }
    /#
        iprintln(level.desirable_chest_location + "<dev string:x30>");
    #/
    level.desirable_chest_location = undefined;
    return level.chest_index;
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x3e2fd32b, Offset: 0x4710
// Size: 0x90
function rotateroll_box() {
    angles = 40;
    angles2 = 0;
    while (isdefined(self)) {
        self rotateroll(angles + angles2, 0.5);
        wait 0.7;
        angles2 = 40;
        self rotateroll(angles * -2, 0.5);
        wait 0.7;
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xd5712d7f, Offset: 0x47a8
// Size: 0x8e
function verify_chest_is_open() {
    for (i = 0; i < level.open_chest_location.size; i++) {
        if (isdefined(level.open_chest_location[i])) {
            if (level.open_chest_location[i] == level.chests[level.chest_index].script_noteworthy) {
                level.verify_chest = 1;
                return;
            }
        }
    }
    level.verify_chest = 0;
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xb95f5aa4, Offset: 0x4840
// Size: 0x96
function treasure_chest_timeout() {
    self endon(#"user_grabbed_weapon");
    self.zbarrier endon(#"box_hacked_respin", #"box_hacked_rerespin");
    n_timeout = isdefined(level.var_2571eede) ? level.var_2571eede : 12;
    wait n_timeout;
    self notify(#"trigger", {#activator:level});
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x72c6f721, Offset: 0x48e0
// Size: 0x4c
function treasure_chest_lid_open() {
    openroll = 105;
    opentime = 0.5;
    self rotateroll(105, opentime, opentime * 0.5);
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xce785d60, Offset: 0x4938
// Size: 0x66
function treasure_chest_lid_close(timedout) {
    closeroll = -105;
    closetime = 0.5;
    self rotateroll(closeroll, closetime, closetime * 0.5);
    self notify(#"lid_closed");
}

// Namespace zm_magicbox/zm_magicbox
// Params 2, eflags: 0x0
// Checksum 0xe77722ec, Offset: 0x49a8
// Size: 0x19e
function function_ba366d66(player, weapon) {
    if (!zm_weapons::get_is_in_box(weapon)) {
        return 0;
    }
    if (isdefined(player) && player zm_weapons::has_weapon_or_upgrade(weapon)) {
        return 0;
    }
    if (!zm_weapons::limited_weapon_below_quota(weapon, player)) {
        return 0;
    }
    if (isdefined(player) && !player zm_weapons::player_can_use_content(weapon)) {
        return 0;
    }
    if (isdefined(level.custom_magic_box_selection_logic)) {
        if (!isdefined(player) || ![[ level.custom_magic_box_selection_logic ]](weapon, player)) {
            return 0;
        }
    }
    if (weapon.name == #"ray_gun") {
        if (!isdefined(player) || player zm_weapons::has_weapon_or_upgrade(getweapon(#"raygun_mark2"))) {
            return 0;
        }
    }
    if (isdefined(player) && isdefined(level.special_weapon_magicbox_check)) {
        return player [[ level.special_weapon_magicbox_check ]](weapon);
    }
    if (isinarray(level.var_5a17cfc9, weapon)) {
        return 0;
    }
    return 1;
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xe8c5da4d, Offset: 0x4b50
// Size: 0x194
function function_8bac3d61(player) {
    keys = array::randomize(getarraykeys(level.zombie_weapons));
    if (isdefined(player)) {
        if (isdefined(level.customrandomweaponweights)) {
            keys = player [[ level.customrandomweaponweights ]](keys);
        }
        if (isdefined(player.var_f15dc7c3)) {
            keys = player [[ player.var_f15dc7c3 ]](keys);
        }
    }
    /#
        forced_weapon_name = getdvarstring(#"scr_force_weapon");
        forced_weapon = getweapon(forced_weapon_name);
        if (forced_weapon_name != "<dev string:x4d>" && isdefined(level.zombie_weapons[forced_weapon])) {
            arrayinsert(keys, forced_weapon, 0);
        }
    #/
    if (isdefined(player)) {
        for (i = 0; i < keys.size; i++) {
            if (function_ba366d66(player, keys[i])) {
                return keys[i];
            }
        }
    }
    return keys[0];
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x325c541a, Offset: 0x4cf0
// Size: 0x32
function weapon_show_hint_choke() {
    level._weapon_show_hint_choke = 0;
    while (true) {
        waitframe(1);
        level._weapon_show_hint_choke = 0;
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 4, eflags: 0x0
// Checksum 0xb0bf6916, Offset: 0x4d30
// Size: 0x37c
function decide_hide_show_hint(endon_notify, second_endon_notify, onlyplayer, can_buy_weapon_extra_check_func) {
    self endon(#"death");
    if (isdefined(endon_notify)) {
        self endon(endon_notify);
    }
    if (isdefined(second_endon_notify)) {
        self endon(second_endon_notify);
    }
    if (!isdefined(level._weapon_show_hint_choke)) {
        level thread weapon_show_hint_choke();
    }
    use_choke = 0;
    if (isdefined(level._use_choke_weapon_hints) && level._use_choke_weapon_hints == 1) {
        use_choke = 1;
    }
    while (true) {
        last_update = gettime();
        if (isdefined(self.chest_user) && !isdefined(self.box_rerespun)) {
            if (zm_loadout::is_placeable_mine(self.chest_user getcurrentweapon()) || self.chest_user zm_equipment::hacker_active()) {
                self setinvisibletoplayer(self.chest_user);
            } else {
                self setvisibletoplayer(self.chest_user);
            }
        } else if (isdefined(onlyplayer)) {
            if (onlyplayer can_buy_weapon() && (!isdefined(can_buy_weapon_extra_check_func) || onlyplayer [[ can_buy_weapon_extra_check_func ]](self.weapon)) && !onlyplayer bgb::is_enabled(#"zm_bgb_disorderly_combat")) {
                self setinvisibletoplayer(onlyplayer, 0);
            } else {
                self setinvisibletoplayer(onlyplayer, 1);
            }
        } else {
            players = getplayers();
            for (i = 0; i < players.size; i++) {
                if (players[i] can_buy_weapon() && (!isdefined(can_buy_weapon_extra_check_func) || players[i] [[ can_buy_weapon_extra_check_func ]](self.weapon)) && !players[i] bgb::is_enabled(#"zm_bgb_disorderly_combat")) {
                    self setinvisibletoplayer(players[i], 0);
                    continue;
                }
                self setinvisibletoplayer(players[i], 1);
            }
        }
        if (use_choke) {
            while (level._weapon_show_hint_choke > 4 && gettime() < last_update + 150) {
                waitframe(1);
            }
        } else {
            wait 0.1;
        }
        level._weapon_show_hint_choke++;
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x7dc908e3, Offset: 0x50b8
// Size: 0x4a
function get_left_hand_weapon_model_name(weapon) {
    dw_weapon = weapon.dualwieldweapon;
    if (dw_weapon != level.weaponnone) {
        return dw_weapon.worldmodel;
    }
    return weapon.worldmodel;
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x47c8a538, Offset: 0x5110
// Size: 0xfc
function clean_up_hacked_box() {
    self waittill(#"box_hacked_respin");
    self endon(#"box_spin_done");
    if (isdefined(self.weapon_model)) {
        self.weapon_model delete();
        self.weapon_model = undefined;
    }
    if (isdefined(self.weapon_model_dw)) {
        self.weapon_model_dw delete();
        self.weapon_model_dw = undefined;
    }
    self hidezbarrierpiece(3);
    self hidezbarrierpiece(4);
    self setzbarrierpiecestate(3, "closed");
    self setzbarrierpiecestate(4, "closed");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xe5ba8927, Offset: 0x5218
// Size: 0x4c
function treasure_chest_firesale_active() {
    return isdefined(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) && zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on");
}

// Namespace zm_magicbox/zm_magicbox
// Params 2, eflags: 0x0
// Checksum 0x9055e4bc, Offset: 0x5270
// Size: 0x3d6
function treasure_chest_should_move(chest, player) {
    if (getdvarint(#"magic_chest_movable", 0) && !(isdefined(chest._box_opened_by_fire_sale) && chest._box_opened_by_fire_sale) && !treasure_chest_firesale_active() && self [[ level._zombiemode_check_firesale_loc_valid_func ]]()) {
        random = randomint(100);
        chance_of_joker = 0;
        if (zm_trial::is_trial_mode() && level.chest_accessed >= 3) {
            return true;
        }
        if (!isdefined(level.chest_min_move_usage)) {
            level.chest_min_move_usage = 4;
            if (zm_custom::function_5638f689(#"zmmysteryboxlimitmove")) {
                if (zm_custom::function_5638f689(#"zmmysteryboxlimitmove") < 4) {
                    level.chest_min_move_usage = zm_custom::function_5638f689(#"zmmysteryboxlimitmove") - 1;
                }
            }
        }
        if (level.chest_accessed < level.chest_min_move_usage) {
            chance_of_joker = -1;
        }
        if (zm_custom::function_5638f689(#"zmmysteryboxlimitmove")) {
            var_20d2ffed = level.chest_accessed - zm_custom::function_5638f689(#"zmmysteryboxlimitmove") * level.chest_moves;
            if (level.chest_accessed >= zm_custom::function_5638f689(#"zmmysteryboxlimitmove")) {
                chance_of_joker = 100;
            } else {
                chance_of_joker = -1;
            }
        } else if (chance_of_joker >= 0) {
            chance_of_joker = level.chest_accessed + 20;
            if (level.chest_moves == 0 && level.chest_accessed >= 8) {
                chance_of_joker = 100;
            }
            if (level.chest_accessed >= 4 && level.chest_accessed < 8) {
                if (random < 15) {
                    chance_of_joker = 100;
                } else {
                    chance_of_joker = -1;
                }
            }
            if (level.chest_moves > 0) {
                if (level.chest_accessed >= 8 && level.chest_accessed < 13) {
                    if (random < 30) {
                        chance_of_joker = 100;
                    } else {
                        chance_of_joker = -1;
                    }
                }
                if (level.chest_accessed >= 13) {
                    if (random < 50) {
                        chance_of_joker = 100;
                    } else {
                        chance_of_joker = -1;
                    }
                }
            }
        }
        if (isdefined(chest.no_fly_away)) {
            chance_of_joker = -1;
        }
        if (isdefined(level.var_3e719d28)) {
            chance_of_joker = [[ level.var_3e719d28 ]](chance_of_joker);
        }
        if (isdefined(level.var_642d32dc) && level.var_642d32dc) {
            level.var_642d32dc = 0;
            chance_of_joker = 100;
        }
        if (chance_of_joker > random) {
            return true;
        }
    }
    return false;
}

// Namespace zm_magicbox/zm_magicbox
// Params 4, eflags: 0x0
// Checksum 0xd46cedd3, Offset: 0x5650
// Size: 0x78
function spawn_joker_weapon_model(player, model, origin, angles) {
    weapon_model = spawn("script_model", origin);
    if (isdefined(angles)) {
        weapon_model.angles = angles;
    }
    weapon_model setmodel(model);
    return weapon_model;
}

// Namespace zm_magicbox/zm_magicbox
// Params 3, eflags: 0x0
// Checksum 0x1024aa66, Offset: 0x56d0
// Size: 0x144
function treasure_chest_weapon_locking(player, weapon, onoff) {
    if (isdefined(self.locked_model)) {
        self.locked_model delete();
        self.locked_model = undefined;
    }
    if (onoff) {
        if (weapon == level.weaponnone) {
            self.locked_model = spawn_joker_weapon_model(player, level.chest_joker_model, self.origin, (0, 0, 0));
        } else if (isdefined(player)) {
            self.locked_model = zm_utility::spawn_buildkit_weapon_model(player, weapon, undefined, self.origin, (0, 0, 0));
        } else {
            self.locked_model = util::spawn_model(weapon.worldmodel, self.origin, (0, 0, 0));
        }
        self.locked_model ghost();
        self.locked_model clientfield::set("force_stream", 1);
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 3, eflags: 0x0
// Checksum 0xa7a332c3, Offset: 0x5820
// Size: 0xd16
function treasure_chest_weapon_spawn(chest, player, respin) {
    if (isdefined(level.var_4c4bfda)) {
        self.owner endon(#"box_locked");
        self thread [[ level.var_4c4bfda ]]();
    }
    self endon(#"box_hacked_respin");
    self thread clean_up_hacked_box();
    assert(isdefined(player));
    self.chest_moving = 0;
    move_the_box = treasure_chest_should_move(chest, player);
    preferred_weapon = undefined;
    if (move_the_box) {
        preferred_weapon = level.weaponnone;
    } else {
        preferred_weapon = function_8bac3d61(player);
    }
    chest treasure_chest_weapon_locking(player, preferred_weapon, 1);
    self.weapon = level.weaponnone;
    modelname = undefined;
    rand = undefined;
    var_43c9379a = isdefined(level.var_f3085ac4) ? level.var_f3085ac4 : 40;
    if (player hasperk(#"specialty_cooldown")) {
        var_43c9379a = min(var_43c9379a, 10);
    }
    var_6a1f35a1 = 1;
    if (var_43c9379a < 40) {
        var_6a1f35a1 = var_43c9379a / 40;
    }
    assert(var_6a1f35a1 >= 0.1 && var_6a1f35a1 <= 2, "<dev string:x4e>");
    if (isdefined(chest.zbarrier)) {
        if (isdefined(level.custom_magic_box_do_weapon_rise)) {
            chest.zbarrier thread [[ level.custom_magic_box_do_weapon_rise ]]();
        } else {
            chest.zbarrier thread magic_box_do_weapon_rise(var_6a1f35a1);
        }
    }
    for (i = 0; i < var_43c9379a; i++) {
        if (i < var_43c9379a * 0.5) {
            waitframe(1);
            continue;
        }
        if (i < var_43c9379a * 0.75) {
            wait 0.1;
            continue;
        }
        if (i < var_43c9379a * 0.875) {
            wait 0.2;
            continue;
        }
        if (i < var_43c9379a * 0.95) {
            wait 0.3;
        }
    }
    if (isdefined(level.var_c6955e8b)) {
        [[ level.var_c6955e8b ]]();
    }
    new_firesale = move_the_box && treasure_chest_firesale_active();
    if (new_firesale) {
        move_the_box = 0;
        preferred_weapon = function_8bac3d61(player);
    }
    if (!move_the_box && function_ba366d66(player, preferred_weapon)) {
        rand = preferred_weapon;
    } else {
        rand = function_8bac3d61(player);
    }
    self.weapon = rand;
    if (!move_the_box && rand === getweapon("homunculus")) {
        self thread zm_vo::vo_say("vox_homu_homun_raise_" + randomintrangeinclusive(0, 6), 0, 0, 0, 1);
    }
    if (isdefined(level.func_magicbox_weapon_spawned)) {
        self thread [[ level.func_magicbox_weapon_spawned ]](self.weapon);
    }
    wait 0.1;
    if (isdefined(level.custom_magicbox_float_height)) {
        v_float = anglestoup(self.angles) * level.custom_magicbox_float_height;
    } else {
        v_float = anglestoup(self.angles) * 40;
    }
    self.model_dw = undefined;
    if (isdefined(player)) {
        self.weapon_model = zm_utility::spawn_buildkit_weapon_model(player, rand, undefined, self.origin + v_float, (self.angles[0] * -1, self.angles[1] + 180, self.angles[2] * -1));
    } else {
        self.weapon_model = util::spawn_model(rand.worldmodel, self.origin + v_float, (self.angles[0] * -1, self.angles[1] + 180, self.angles[2] * -1));
    }
    if (rand.isdualwield) {
        dweapon = rand;
        if (isdefined(rand.dualwieldweapon) && rand.dualwieldweapon != level.weaponnone) {
            dweapon = rand.dualwieldweapon;
        }
        if (isdefined(player)) {
            self.weapon_model_dw = zm_utility::spawn_buildkit_weapon_model(player, dweapon, undefined, self.weapon_model.origin - (3, 3, 3), self.weapon_model.angles);
        } else {
            self.weapon_model_dw = util::spawn_model(dweapon.worldmodel, self.weapon_model.origin - (3, 3, 3), self.weapon_model.angles);
        }
    }
    if (move_the_box && !(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on") && self [[ level._zombiemode_check_firesale_loc_valid_func ]]())) {
        self.weapon_model setmodel(level.chest_joker_model);
        if (isdefined(self.weapon_model_dw)) {
            self.weapon_model_dw delete();
            self.weapon_model_dw = undefined;
        }
        if (isplayer(chest.chest_user) && chest.chest_user bgb::is_enabled(#"zm_bgb_unbearable")) {
            level.chest_accessed = 0;
            chest.unbearable_respin = 1;
            chest.chest_user notify(#"zm_bgb_unbearable", {#chest:chest});
            chest waittill(#"forever");
        }
        if (self.script_string === "t8_magicbox") {
            self thread function_a4fa5f6c();
        }
        self.chest_moving = 1;
        level flag::set("moving_chest_now");
        level.chest_accessed = 0;
        level.chest_moves++;
    }
    self notify(#"randomization_done");
    if (isdefined(self.chest_moving) && self.chest_moving) {
        if (isdefined(level.chest_joker_custom_movement)) {
            self thread [[ level.chest_joker_custom_movement ]]();
        } else {
            v_origin = self.weapon_model.origin;
            self.weapon_model delete();
            self.weapon_model = spawn("script_model", v_origin);
            self.weapon_model setmodel(level.chest_joker_model);
            self.weapon_model.angles = self.angles + (0, 180, 0);
            wait 0.5;
            level notify(#"weapon_fly_away_start");
            wait 2;
            if (isdefined(self.weapon_model)) {
                v_fly_away = self.origin + anglestoup(self.angles) * 500;
                self.weapon_model moveto(v_fly_away, 4, 3);
            }
            if (isdefined(self.weapon_model_dw)) {
                v_fly_away = self.origin + anglestoup(self.angles) * 500;
                self.weapon_model_dw moveto(v_fly_away, 4, 3);
            }
            self.weapon_model waittill(#"movedone");
            self.weapon_model delete();
            if (isdefined(self.weapon_model_dw)) {
                self.weapon_model_dw delete();
                self.weapon_model_dw = undefined;
            }
            self notify(#"box_moving");
            level notify(#"weapon_fly_away_end");
        }
    } else {
        if (!isdefined(respin)) {
            if (isdefined(chest.box_hacks[#"respin"])) {
                self [[ chest.box_hacks[#"respin"] ]](chest, player);
            }
        } else if (isdefined(chest.box_hacks[#"respin_respin"])) {
            self [[ chest.box_hacks[#"respin_respin"] ]](chest, player);
        }
        if (isdefined(level.custom_magic_box_timer_til_despawn)) {
            self.weapon_model thread [[ level.custom_magic_box_timer_til_despawn ]](self);
        } else {
            self.weapon_model thread timer_til_despawn(v_float);
        }
        if (isdefined(self.weapon_model_dw)) {
            if (isdefined(level.custom_magic_box_timer_til_despawn)) {
                self.weapon_model_dw thread [[ level.custom_magic_box_timer_til_despawn ]](self);
            } else {
                self.weapon_model_dw thread timer_til_despawn(v_float);
            }
        }
        self waittill(#"weapon_grabbed");
        self thread zm_vo::vo_stop();
        if (!chest.timedout) {
            if (isdefined(self.weapon_model)) {
                self.weapon_model delete();
            }
            if (isdefined(self.weapon_model_dw)) {
                self.weapon_model_dw delete();
            }
        }
    }
    chest treasure_chest_weapon_locking(player, preferred_weapon, 0);
    self.weapon = level.weaponnone;
    self notify(#"box_spin_done");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x537519ab, Offset: 0x6540
// Size: 0x110
function function_e4e638c2() {
    v_origin = self.origin;
    self.weapon_model delete();
    self.weapon_model = util::spawn_model(level.chest_joker_model, v_origin, self.angles);
    self.weapon_model scene::init("p8_fxanim_zm_zod_magic_box_skull_drop_bundle", self.weapon_model);
    wait 0.5;
    level notify(#"weapon_fly_away_start");
    if (isdefined(self.weapon_model)) {
        self.weapon_model scene::play("p8_fxanim_zm_zod_magic_box_skull_drop_bundle", self.weapon_model);
    }
    self.weapon_model delete();
    self notify(#"box_moving");
    level notify(#"weapon_fly_away_end");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x65bf9e5, Offset: 0x6658
// Size: 0x18
function chest_get_min_usage() {
    min_usage = 4;
    return min_usage;
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x37cc156a, Offset: 0x6678
// Size: 0xfe
function chest_get_max_usage() {
    max_usage = 6;
    players = getplayers();
    if (level.chest_moves == 0) {
        if (players.size == 1) {
            max_usage = 3;
        } else if (players.size == 2) {
            max_usage = 4;
        } else if (players.size == 3) {
            max_usage = 5;
        } else {
            max_usage = 6;
        }
    } else if (players.size == 1) {
        max_usage = 4;
    } else if (players.size == 2) {
        max_usage = 4;
    } else if (players.size == 3) {
        max_usage = 5;
    } else {
        max_usage = 7;
    }
    return max_usage;
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x365cb903, Offset: 0x6780
// Size: 0xac
function timer_til_despawn(v_float) {
    self endon(#"kill_weapon_movement");
    var_700562a5 = isdefined(level.var_2571eede) ? level.var_2571eede : 12;
    self moveto(self.origin - v_float * 0.85, var_700562a5, var_700562a5 * 0.5);
    wait var_700562a5;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xf1097ba0, Offset: 0x6838
// Size: 0xe4
function treasure_chest_glowfx() {
    self clientfield::set("magicbox_open_fx", 1);
    self clientfield::set("magicbox_closed_fx", 0);
    ret_val = self waittill(#"weapon_grabbed", #"box_moving");
    self clientfield::set("magicbox_open_fx", 0);
    if (self.script_string !== "t8_magicbox") {
        if ("box_moving" != ret_val._notify) {
            self clientfield::set("magicbox_closed_fx", 1);
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x247ea0b0, Offset: 0x6928
// Size: 0x3d4
function treasure_chest_give_weapon(weapon) {
    self.last_box_weapon = gettime();
    if (should_upgrade_weapon(self, weapon)) {
        if (self zm_weapons::can_upgrade_weapon(weapon)) {
            weapon = zm_weapons::get_upgrade_weapon(weapon);
            self notify(#"zm_bgb_crate_power_used");
        }
    }
    if (weapon.name == #"ray_gun" || weapon.name == #"raygun_mark2") {
        playsoundatposition(#"mus_raygun_stinger", (0, 0, 0));
        str_vo_line = "get_raygun";
    } else if (zm_weapons::is_wonder_weapon(weapon)) {
        str_vo_line = "get_wonder";
    } else if (weapon === getweapon(#"homunculus") || weapon === getweapon(#"cymbal_monkey")) {
        str_vo_line = "get_homunculus";
    } else {
        switch (weapon.weapclass) {
        case #"mg":
            str_vo_line = "get_lmg";
            break;
        case #"spread":
            str_vo_line = "get_shotgun";
            break;
        case #"pistol":
            str_vo_line = "get_pistol";
            break;
        case #"rocketlauncher":
            str_vo_line = "get_launcher";
            break;
        case #"smg":
            str_vo_line = "get_smg";
            break;
        case #"rifle":
            if (weapon.issniperweapon) {
                str_vo_line = "get_sniper";
            } else if (zm_weapons::is_tactical_rifle(weapon)) {
                str_vo_line = "get_tactical";
            } else {
                str_vo_line = "get_ar";
            }
            break;
        default:
            break;
        }
    }
    if (isdefined(str_vo_line)) {
        if (str_vo_line == "get_homunculus") {
            self thread function_b9f21553();
        } else {
            self zm_audio::create_and_play_dialog("magicbox", str_vo_line);
        }
    }
    if (zm_loadout::is_hero_weapon(weapon) && !self hasweapon(weapon)) {
        self give_hero_weapon(weapon);
    } else if (zm_loadout::is_offhand_weapon(weapon)) {
        self give_offhand_weapon(weapon);
    } else {
        self.var_b15f6b06 = 1;
        w_give = self zm_weapons::weapon_give(weapon);
    }
    self callback::callback(#"hash_7d40e25056b9275c", weapon);
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x4
// Checksum 0x27123a30, Offset: 0x6d08
// Size: 0x9c
function private function_b9f21553() {
    var_7eefddc4 = "vox_homu_homun_pickup_" + self zm_vo::function_d70b100f() + "_" + randomintrangeinclusive(0, 6);
    if (soundexists(var_7eefddc4)) {
        self zm_vo::vo_say(var_7eefddc4);
        wait 1;
    }
    self thread zm_audio::create_and_play_dialog("magicbox", "get_homunculus");
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x5179bb8e, Offset: 0x6db0
// Size: 0x3c
function give_hero_weapon(weapon) {
    self zm_hero_weapon::hero_give_weapon(weapon, 0);
    self zm_hero_weapon::function_d8c1ed52();
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x13ec0e1a, Offset: 0x6df8
// Size: 0xec
function give_offhand_weapon(weapon) {
    offhandslot = 0;
    if (isdefined(self._gadgets_player[offhandslot])) {
        self takeweapon(self._gadgets_player[offhandslot]);
    }
    self giveweapon(weapon);
    self zm_audio::create_and_play_dialog("magicbox", "get_offhand");
    waitframe(1);
    slot = self gadgetgetslot(weapon);
    self gadgetpowerset(slot, 100);
    self gadgetcharging(slot, 0);
}

// Namespace zm_magicbox/zm_magicbox
// Params 2, eflags: 0x0
// Checksum 0x5bcc2ea8, Offset: 0x6ef0
// Size: 0x66
function should_upgrade_weapon(player, weapon) {
    if (isdefined(level.magicbox_should_upgrade_weapon_override)) {
        return [[ level.magicbox_should_upgrade_weapon_override ]](player, weapon);
    }
    if (player bgb::is_enabled(#"zm_bgb_crate_power")) {
        return 1;
    }
    return 0;
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xd3142549, Offset: 0x6f60
// Size: 0x614
function function_5d355585() {
    level endon(#"end_game");
    /#
        if (getdvarint(#"hash_69310927ddaeaa87", 0)) {
            return;
        }
    #/
    var_650a75d6 = 0;
    foreach (chest in level.chests) {
        if (chest.zbarrier.script_string === "t8_magicbox") {
            var_650a75d6 = 1;
            if (!isdefined(chest.zone_name)) {
                var_9c46979f = vectornormalize(anglestoright(chest.zbarrier.angles)) * -64;
                chest.zone_name = zm_zonemgr::get_zone_from_position(chest.zbarrier.origin + var_9c46979f, 1);
                for (n_z_offset = 8; !isdefined(chest.zone_name) && n_z_offset <= 64; n_z_offset += 8) {
                    chest.zone_name = zm_zonemgr::get_zone_from_position(chest.zbarrier.origin + var_9c46979f + (0, 0, n_z_offset), 1);
                }
                if (!isdefined(chest.zone_name)) {
                    assert(0, "<dev string:x85>" + chest.zbarrier.origin + "<dev string:xad>");
                }
            }
        }
    }
    if (!var_650a75d6) {
        return;
    }
    level.var_2e149bf1 = 0;
    var_29090cc7 = 0;
    while (true) {
        a_players = getplayers();
        var_6aca6a18 = 0;
        foreach (chest in level.chests) {
            if (!var_6aca6a18 && (!(isdefined(chest.hidden) && chest.hidden) || chest.zbarrier.state === "arriving" || chest.zbarrier.state === "leaving")) {
                foreach (e_player in a_players) {
                    if (isdefined(e_player.am_i_valid) && e_player.am_i_valid) {
                        var_40a0385a = isdefined(e_player.zone_name) ? hash(e_player.zone_name) : e_player.zone_name;
                        if (e_player.zone_name === chest.zone_name || isinarray(zm_cleanup::get_adjacencies_to_zone(chest.zone_name), var_40a0385a)) {
                            var_88887f58 = level.var_2e149bf1 ? 16000000 : 9000000;
                            if (distancesquared(e_player.origin, chest.origin) < var_88887f58) {
                                var_6aca6a18 = 1;
                                break;
                            }
                        }
                    }
                }
            }
        }
        if (var_6aca6a18 && !level.var_2e149bf1) {
            level.var_2e149bf1 = 1;
            level.chests[0].zbarrier clientfield::set("force_stream_magicbox", 1);
        }
        if (!var_6aca6a18 && level.var_2e149bf1) {
            level.var_2e149bf1 = 0;
            level.chests[0].zbarrier clientfield::set("force_stream_magicbox", 0);
        }
        if (level.var_2e149bf1) {
            var_29090cc7 += 0.3;
            if (var_29090cc7 > 120) {
                level.var_2e149bf1 = 0;
                var_29090cc7 = 0;
            }
        } else {
            var_29090cc7 = 0;
        }
        wait 0.3;
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x7ef8092d, Offset: 0x7580
// Size: 0x84
function function_a4fa5f6c() {
    level.chests[0].zbarrier clientfield::set("force_stream_magicbox_leave", 1);
    self function_2dc9df53(60);
    level.chests[0].zbarrier clientfield::set("force_stream_magicbox_leave", 0);
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xe23d6881, Offset: 0x7610
// Size: 0xc8
function function_2dc9df53(n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    do {
        s_notify = level waittill(#"hash_e39eca74fa250b4");
    } while (s_notify.s_magic_box.zbarrier == self || s_notify.s_magic_box != level.chests[level.chest_index]);
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x45aa540, Offset: 0x76e0
// Size: 0x1e4
function magic_box_do_weapon_rise(var_6a1f35a1) {
    self endon(#"box_hacked_respin");
    self setzbarrierpiecestate(3, "closed");
    self setzbarrierpiecestate(4, "closed");
    util::wait_network_frame();
    self zbarrierpieceuseboxriselogic(3);
    self zbarrierpieceuseboxriselogic(4);
    self showzbarrierpiece(3);
    self showzbarrierpiece(4);
    self setzbarrierpiecestate(3, "opening", var_6a1f35a1);
    self setzbarrierpiecestate(4, "opening", var_6a1f35a1);
    if (var_6a1f35a1 != 1) {
        self waittill(#"randomization_done");
        self setzbarrierpiecestate(3, "open");
        self setzbarrierpiecestate(4, "open");
    } else {
        while (self getzbarrierpiecestate(3) != "open") {
            wait 0.5;
        }
    }
    self hidezbarrierpiece(3);
    self hidezbarrierpiece(4);
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xb946e822, Offset: 0x78d0
// Size: 0x3c
function magic_box_do_teddy_flyaway() {
    self showzbarrierpiece(3);
    self setzbarrierpiecestate(3, "closing");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x6679488f, Offset: 0x7918
// Size: 0x76
function is_chest_active() {
    curr_state = self.zbarrier get_magic_box_zbarrier_state();
    if (level flag::get("moving_chest_now")) {
        return false;
    }
    if (curr_state == "open" || curr_state == "close") {
        return true;
    }
    return false;
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xcbde830a, Offset: 0x7998
// Size: 0xc8
function function_62979381() {
    self endon(#"zbarrier_state_change");
    self setzbarrierpiecestate(0, "closed");
    if (self.script_string !== "t8_magicbox") {
        while (true) {
            wait randomfloatrange(180, 1800);
            self setzbarrierpiecestate(0, "opening");
            wait randomfloatrange(180, 1800);
            self setzbarrierpiecestate(0, "closing");
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x4f97cd0e, Offset: 0x7a68
// Size: 0x5c
function function_e9fa0f99() {
    self setzbarrierpiecestate(1, "opening");
    if (self.script_string !== "t8_magicbox") {
        self clientfield::set("magicbox_closed_fx", 1);
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x8a1079d0, Offset: 0x7ad0
// Size: 0x54
function magic_box_zbarrier_leave() {
    self set_magic_box_zbarrier_state("leaving");
    self waittill(#"left");
    self set_magic_box_zbarrier_state("away");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x57055160, Offset: 0x7b30
// Size: 0x66
function function_93405f4b() {
    self setzbarrierpiecestate(1, "opening");
    while (self getzbarrierpiecestate(1) == "opening") {
        waitframe(1);
    }
    self notify(#"arrived");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x29a07eb2, Offset: 0x7ba0
// Size: 0x96
function function_81f65101() {
    if (self.script_string === "t8_magicbox") {
        self clientfield::set("t8_magicbox_ambient_fx", 0);
    }
    self setzbarrierpiecestate(1, "closing");
    while (self getzbarrierpiecestate(1) == "closing") {
        wait 0.1;
    }
    self notify(#"left");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xbd90b1b4, Offset: 0x7c40
// Size: 0x66
function function_fae0fcab() {
    self setzbarrierpiecestate(2, "opening");
    while (self getzbarrierpiecestate(2) == "opening") {
        wait 0.1;
    }
    self notify(#"opened");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x39a57783, Offset: 0x7cb0
// Size: 0x66
function function_e9b50559() {
    self setzbarrierpiecestate(2, "closing");
    while (self getzbarrierpiecestate(2) == "closing") {
        wait 0.1;
    }
    self notify(#"closed");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xb9b1ace7, Offset: 0x7d20
// Size: 0xa
function get_magic_box_zbarrier_state() {
    return self.state;
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xdb7e28dc, Offset: 0x7d38
// Size: 0x7c
function set_magic_box_zbarrier_state(state) {
    for (i = 0; i < self getnumzbarrierpieces(); i++) {
        self hidezbarrierpiece(i);
    }
    self notify(#"zbarrier_state_change");
    self [[ level.magic_box_zbarrier_state_func ]](state);
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x4801da30, Offset: 0x7dc0
// Size: 0x262
function process_magic_box_zbarrier_state(state) {
    switch (state) {
    case #"away":
        self showzbarrierpiece(0);
        self thread function_62979381();
        self.state = "away";
        break;
    case #"arriving":
        self showzbarrierpiece(1);
        self thread function_93405f4b();
        self.state = "arriving";
        break;
    case #"initial":
        self showzbarrierpiece(1);
        self thread function_e9fa0f99();
        thread zm_unitrigger::register_static_unitrigger(self.owner.unitrigger_stub, &magicbox_unitrigger_think);
        self.state = "initial";
        break;
    case #"open":
        self showzbarrierpiece(2);
        self thread function_fae0fcab();
        self.state = "open";
        break;
    case #"close":
        self showzbarrierpiece(2);
        self thread function_e9b50559();
        self.state = "close";
        break;
    case #"leaving":
        self showzbarrierpiece(1);
        self thread function_81f65101();
        self.state = "leaving";
        break;
    default:
        if (isdefined(level.custom_magicbox_state_handler)) {
            self [[ level.custom_magicbox_state_handler ]](state);
        }
        break;
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xf3a144b7, Offset: 0x8030
// Size: 0x1f2
function function_b8398043(str_state) {
    switch (str_state) {
    case #"away":
        self.state = "away";
        if (!isdefined(self.var_bc9343a5)) {
            a_str_tokens = strtok2(self.script_noteworthy, "zbarrier");
            var_130d90d1 = a_str_tokens[0] + "plinth";
            self.var_bc9343a5 = struct::get(var_130d90d1, "targetname");
            assert(isdefined(self.var_bc9343a5), "<dev string:xd3>" + var_130d90d1);
        }
        self.var_bc9343a5 scene::play();
        break;
    case #"arriving":
        if (!isdefined(self.var_bc9343a5)) {
            a_str_tokens = strtok2(self.script_noteworthy, "zbarrier");
            var_130d90d1 = a_str_tokens[0] + "plinth";
            self.var_bc9343a5 = struct::get(var_130d90d1, "targetname");
            assert(isdefined(self.var_bc9343a5), "<dev string:xd3>" + var_130d90d1);
        }
        self.var_bc9343a5 scene::stop(1);
    default:
        self process_magic_box_zbarrier_state(str_state);
        break;
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xb1acee7f, Offset: 0x8230
// Size: 0x1cc
function magicbox_host_migration() {
    level endon(#"end_game");
    level notify(#"mb_hostmigration");
    level endon(#"mb_hostmigration");
    while (true) {
        level waittill(#"host_migration_end");
        if (!isdefined(level.chests)) {
            continue;
        }
        foreach (chest in level.chests) {
            if (!(isdefined(chest.hidden) && chest.hidden)) {
                if (isdefined(chest) && isdefined(chest.pandora_light)) {
                    if (chest.zbarrier.script_string === "t8_magicbox") {
                        playfxontag(level._effect[#"hash_2ff87d61167ea531"], chest.pandora_light, "tag_origin");
                    } else {
                        playfxontag(level._effect[#"lght_marker"], chest.pandora_light, "tag_origin");
                    }
                }
            }
            util::wait_network_frame();
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x1d7a0eed, Offset: 0x8408
// Size: 0x80
function function_681ae0fd() {
    foreach (s_chest in level.chests) {
        level thread function_54738e19(s_chest);
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x4251fc8b, Offset: 0x8490
// Size: 0x4e
function function_54738e19(s_chest) {
    while (isdefined(s_chest._box_open) && s_chest._box_open) {
        waitframe(1);
    }
    s_chest.unitrigger_stub.var_24e0d010 = 1;
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xb175160c, Offset: 0x84e8
// Size: 0x4a
function function_c2aedf84() {
    level endon(#"game_ended");
    while (true) {
        level waittill(#"start_of_round");
        level.var_a8f0b8a1 = undefined;
    }
}

