#using script_340a2e805e35f7a2;
#using script_3751b21462a54a7d;
#using script_471b31bd963b388e;
#using script_5f261a5d57de5f7c;
#using script_7fc996fe8678852;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\potm_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\zm_common\bb;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_contracts;
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
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;

#namespace zm_magicbox;

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x6
// Checksum 0xffe77c13, Offset: 0x5b8
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"zm_magicbox", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x5 linked
// Checksum 0x3ff0f7fa, Offset: 0x610
// Size: 0x33c
function private function_70a657d8() {
    level.start_chest_name = "start_chest";
    level._effect[#"hash_2ff87d61167ea531"] = #"hash_d66a9f5776f1fba";
    level._effect[#"hash_4048cb4967032c4a"] = #"hash_1e43d43c6586fcb5";
    level._effect[#"lght_marker"] = #"zombie/fx_weapon_box_marker_zmb";
    level._effect[#"lght_marker_flare"] = #"zombie/fx_weapon_box_marker_fl_zmb";
    level._effect[#"poltergeist"] = #"zombie/fx_barrier_buy_zmb";
    clientfield::register("zbarrier", "magicbox_open_fx", 1, 1, "int");
    clientfield::register("zbarrier", "magicbox_closed_fx", 1, 1, "int");
    clientfield::register("zbarrier", "magicbox_leave_fx", 1, 1, "counter");
    clientfield::register("zbarrier", "zbarrier_arriving_sounds", 1, 1, "counter");
    clientfield::register("zbarrier", "zbarrier_leaving_sounds", 1, 1, "counter");
    clientfield::register("zbarrier", "force_stream_magicbox", 1, 1, "int");
    clientfield::register("zbarrier", "force_stream_magicbox_leave", 1, 1, "int");
    clientfield::register("scriptmover", "force_stream", 1, 1, "int");
    clientfield::register("zbarrier", "" + #"hash_2fcdae6b889933c7", 1, 1, "int");
    clientfield::register("zbarrier", "" + #"hash_66b8b96e588ce1ac", 1, 3, "int");
    level thread magicbox_host_migration();
    namespace_8b6a9d79::function_b3464a7c("magicbox", &function_165d2388);
    callback::on_revived(&on_revived);
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x5 linked
// Checksum 0x5bed95f, Offset: 0x958
// Size: 0x11c
function private postinit() {
    level flag::wait_till("start_zombie_round_logic");
    if (!isdefined(level.chest_joker_model)) {
        level.chest_joker_model = "p9_zm_ndu_magic_box_bunny";
    }
    if (!isdefined(level.magic_box_zbarrier_state_func)) {
        level.magic_box_zbarrier_state_func = &process_magic_box_zbarrier_state;
    }
    if (!isdefined(level.magic_box_check_equipment)) {
        level.magic_box_check_equipment = &default_magic_box_check_equipment;
    }
    if (!zm_utility::is_survival()) {
        treasure_chest_init(level.start_chest_name);
        if (zm_custom::function_901b751c(#"zmmysteryboxlimitround")) {
            level thread function_338c302b();
        }
        level flag::set("magicbox_initialized");
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x44835dd8, Offset: 0xa80
// Size: 0xe0
function on_revived() {
    self endon(#"death");
    if (!self zm_laststand::laststand_has_players_weapons_returned()) {
        self waittill(#"hash_9b426cce825928d");
    }
    foreach (chest in level.chests) {
        if (isdefined(chest.trigger)) {
            chest.trigger function_3238e2f9(chest);
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0xc62178c3, Offset: 0xb68
// Size: 0x7c
function function_2dcb5cea(s_destination) {
    if (!zm_utility::is_survival()) {
        return;
    }
    level flag::wait_till("start_zombie_round_logic");
    waittillframeend();
    treasure_chest_init(level.start_chest_name, s_destination);
    level flag::set("magicbox_initialized");
}

// Namespace zm_magicbox/zm_magicbox
// Params 2, eflags: 0x1 linked
// Checksum 0x9a625e12, Offset: 0xbf0
// Size: 0x414
function treasure_chest_init(start_chest_name, s_destination) {
    level.chest_moves = 0;
    level.chest_level = 0;
    level flag::clear("moving_chest_now");
    level.chests = [];
    if (isdefined(s_destination)) {
        foreach (s_location in s_destination.locations) {
            if (namespace_8b6a9d79::function_fe9fb6fd(s_location)) {
                continue;
            }
            var_13b953fa = s_location.instances[#"magicbox"];
            if (isdefined(var_13b953fa)) {
                namespace_8b6a9d79::function_20d7e9c7(var_13b953fa);
            }
        }
    } else {
        foreach (location in level.var_7d45d0d4.locations) {
            var_13b953fa = location.instances[#"magicbox"];
            if (isdefined(var_13b953fa)) {
                namespace_8b6a9d79::function_20d7e9c7(var_13b953fa);
            }
        }
    }
    if (level.chests.size == 0) {
        return;
    }
    foreach (s_chest in level.chests) {
        s_chest.box_hacks = [];
        s_chest.orig_origin = s_chest.origin;
        if (isdefined(s_chest.zombie_cost)) {
            s_chest.old_cost = s_chest.zombie_cost;
            continue;
        }
        s_chest.old_cost = 950;
    }
    if (!level.enable_magic || zm_custom::function_901b751c(#"zmmysteryboxstate") == 0) {
        foreach (s_chest in level.chests) {
            s_chest hide_chest();
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
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x3c849743, Offset: 0x1010
// Size: 0x46c
function init_starting_chest_location(start_chest_name) {
    level.chest_index = 0;
    start_chest_found = 0;
    if (level.chests.size == 1) {
        start_chest_found = 1;
        if (isdefined(level.chests[level.chest_index].zbarrier)) {
            level.chests[level.chest_index].zbarrier set_magic_box_zbarrier_state("initial");
            level.chests[level.chest_index] thread zm_audio::function_ef9ba49c(#"box", 0, -1, 500, array("left", "trigger"));
        }
    } else if (zm_custom::function_901b751c(#"zmmysteryboxstate") == 3) {
        for (i = 0; i < level.chests.size; i++) {
            level.chests[i] function_2db086bf();
            level.chests[i].no_fly_away = 1;
            level.chests[i] thread show_chest();
        }
    } else if (zm_custom::function_901b751c(#"zmmysteryboxstate") == 1) {
        level.chest_index = -1;
        for (i = 0; i < level.chests.size; i++) {
            level.chests[i] hide_chest();
        }
    } else {
        for (i = 0; i < level.chests.size; i++) {
            if (is_true(level.random_pandora_box_start)) {
                if (start_chest_found || is_true(level.chests[i].start_exclude)) {
                    level.chests[i] hide_chest();
                } else {
                    level.chest_index = i;
                    level.chests[i] thread function_2db086bf();
                    start_chest_found = 1;
                }
                continue;
            }
            if (start_chest_found || !isdefined(level.chests[i].script_noteworthy) || !issubstr(level.chests[i].script_noteworthy, start_chest_name)) {
                level.chests[i] hide_chest();
                continue;
            }
            level.chest_index = i;
            level.chests[i] thread function_2db086bf();
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
    if (!is_true(zm_custom::function_901b751c(#"zmmysteryboxstate") == 1)) {
        level.chests[level.chest_index] thread [[ level.pandora_show_func ]]();
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x5 linked
// Checksum 0x7e9c6e78, Offset: 0x1488
// Size: 0x6c
function private function_62197845(str_notify) {
    if (str_notify === "death") {
        if (isdefined(self.weapon_model)) {
            self.weapon_model delete();
        }
        if (isdefined(self.weapon_model_dw)) {
            self.weapon_model_dw delete();
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x9ce23431, Offset: 0x1500
// Size: 0x1c
function set_treasure_chest_cost(cost) {
    level.zombie_treasure_chest_cost = cost;
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x98ce3f28, Offset: 0x1528
// Size: 0x26c
function function_165d2388(s_instance) {
    a_s_chests = s_instance.var_fe2612fe[#"magicbox_zbarrier"];
    foreach (s_chest in a_s_chests) {
        if (isdefined(s_chest.zbarrier)) {
            var_95140b5e = "zbarrier_" + s_chest.zbarrier;
        } else {
            var_95140b5e = "zbarrier_zmcore_magicbox";
        }
        s_chest.zbarrier = namespace_8b6a9d79::function_94974eef(s_chest, var_95140b5e);
        s_chest.zbarrier.owner = s_chest;
        if (isdefined(s_chest.zbarrier)) {
            s_chest.zbarrier zbarrierpieceuseboxriselogic(3);
            s_chest.zbarrier zbarrierpieceuseboxriselogic(4);
        }
        objid = gameobjects::get_next_obj_id();
        s_chest.zbarrier.var_e55c8b4e = objid;
        objective_add(objid, "active", s_chest.zbarrier, #"hash_62576f590f9ce606");
        s_chest function_76830bc7();
        if (!isdefined(level.chests)) {
            level.chests = [];
        } else if (!isarray(level.chests)) {
            level.chests = array(level.chests);
        }
        if (!isinarray(level.chests, s_chest)) {
            level.chests[level.chests.size] = s_chest;
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0xf8840ffd, Offset: 0x17a0
// Size: 0x112
function function_76830bc7() {
    if (!isdefined(self.trigger)) {
        self.trigger = namespace_8b6a9d79::function_214737c7(self, &function_c8745555, #"hash_40a3bd4c33eac8cc", self.zombie_cost, 72, 128, undefined, (0, 0, 24));
        self.trigger.zbarrier = self.zbarrier;
        self.trigger.s_chest = self;
        self.zbarrier.trigger = self.trigger;
    }
    self.trigger triggerenable(1);
    self.trigger setvisibletoall();
    self.trigger thread function_3a083565(self);
    self show_objective_icon(1);
    return self.trigger;
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x4f9b7812, Offset: 0x18c0
// Size: 0x86
function function_3a083565(s_chest) {
    self notify("300f9db8b5088cf4");
    self endon("300f9db8b5088cf4");
    self endon(#"death");
    if (isdefined(self.zbarrier)) {
        self.zbarrier endon(#"death");
    }
    while (isdefined(s_chest)) {
        function_3238e2f9(s_chest);
        wait 1;
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 2, eflags: 0x1 linked
// Checksum 0x8b29c9be, Offset: 0x1950
// Size: 0x11c
function show_objective_icon(b_show = 1, player) {
    assert(isdefined(self.zbarrier.var_e55c8b4e), "<dev string:x38>");
    if (isplayer(player)) {
        if (b_show) {
            objective_setvisibletoplayer(self.zbarrier.var_e55c8b4e, player);
        } else {
            objective_setinvisibletoplayer(self.zbarrier.var_e55c8b4e, player);
        }
        return;
    }
    if (b_show) {
        objective_setvisibletoall(self.zbarrier.var_e55c8b4e);
        return;
    }
    objective_setinvisibletoall(self.zbarrier.var_e55c8b4e);
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0xd59cb183, Offset: 0x1a78
// Size: 0x418
function function_3238e2f9(s_chest) {
    if (is_true(s_chest.var_dd0d4460)) {
        return 0;
    }
    if (is_true(s_chest.is_locked)) {
        return 0;
    }
    foreach (player in getplayers()) {
        if (!self trigger_visible_to_player(player)) {
            continue;
        }
        if (is_true(s_chest.grab_weapon_hint)) {
            cursor_hint = "HINT_WEAPON";
            cursor_hint_weapon = s_chest.grab_weapon;
            self setcursorhint(cursor_hint, cursor_hint_weapon);
            if (isdefined(level.magic_box_check_equipment) && [[ level.magic_box_check_equipment ]](cursor_hint_weapon)) {
                if (player function_8b1a219a()) {
                    self.hint_string = #"hash_51b8af0794e70749";
                } else {
                    self.hint_string = #"hash_53005c8d5b45bca3";
                }
                if (!is_true(s_chest.var_1f9dff37) && !is_true(s_chest.var_481aa649) && is_true(s_chest.var_c2f3a87c)) {
                    if (player function_8b1a219a()) {
                        self.hint_string = #"hash_90ca7c41027482c";
                    } else {
                        self.hint_string = #"hash_4320539409034300";
                    }
                }
            } else {
                if (player function_8b1a219a()) {
                    self.hint_string = #"hash_62a71d8ac2e7af43";
                } else {
                    self.hint_string = #"hash_6a4c5538a960189d";
                }
                if (!is_true(s_chest.var_1f9dff37) && !is_true(s_chest.var_481aa649) && is_true(s_chest.var_c2f3a87c)) {
                    if (player function_8b1a219a()) {
                        self.hint_string = #"hash_6b94377deeed6d0e";
                    } else {
                        self.hint_string = #"hash_4a972ee1265d60a";
                    }
                }
            }
        } else if (zm_trial_disable_buys::is_active()) {
            self sethintstring(#"hash_55d25caf8f7bbb2f");
        } else {
            self setcursorhint("HINT_NOICON");
            self.hint_parm1 = s_chest.zombie_cost;
            self.hint_string = zm_utility::get_hint_string(self, "default_treasure_chest");
        }
        if (isdefined(self.hint_parm1)) {
            self sethintstring(self.hint_string, self.hint_parm1);
            continue;
        }
        self sethintstring(self.hint_string);
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x24e62936, Offset: 0x1e98
// Size: 0x22
function default_magic_box_check_equipment(weapon) {
    return zm_loadout::is_offhand_weapon(weapon);
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x55864335, Offset: 0x1ec8
// Size: 0x328
function trigger_visible_to_player(player) {
    self setinvisibletoplayer(player);
    visible = 1;
    s_chest = self.s_chest;
    s_chest show_objective_icon(0, player);
    if (isdefined(s_chest.chest_user) && !isdefined(s_chest.box_rerespun)) {
        wpn_current = s_chest.chest_user getcurrentweapon();
        if (player != s_chest.chest_user && is_true(s_chest.var_1f9dff37) || player != s_chest.chest_user && !is_true(s_chest.var_481aa649) || zm_loadout::is_placeable_mine(wpn_current) || wpn_current.isheroweapon || wpn_current.isgadget || wpn_current.isriotshield || s_chest.chest_user zm_equipment::hacker_active()) {
            visible = 0;
        }
    } else if (distancesquared(player.origin, self.origin) > function_a3f6cdac(600) || !player can_buy_weapon()) {
        visible = 0;
    }
    if (player bgb::is_enabled(#"zm_bgb_disorderly_combat")) {
        visible = 0;
    }
    if (is_true(s_chest.weapon_out)) {
        if (player zm_weapons::has_weapon_or_upgrade(s_chest.zbarrier.weapon)) {
            return false;
        }
        if (is_true(s_chest.var_a7b092aa) || level flag::get("moving_chest_now")) {
            return false;
        }
    }
    if (isdefined(level.var_2f57e2d2)) {
        if (!self [[ level.var_2f57e2d2 ]](player)) {
            visible = 0;
        }
    }
    if (!visible) {
        return false;
    }
    self setvisibletoplayer(player);
    if (!is_true(s_chest._box_open)) {
        s_chest show_objective_icon(1, player);
    }
    return true;
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x539db75a, Offset: 0x21f8
// Size: 0x24
function play_crazi_sound() {
    self playlocalsound(#"hash_7d764f09cd3dea92");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0xa9513b2a, Offset: 0x2228
// Size: 0x120
function function_2db086bf() {
    self.hidden = 0;
    self.zbarrier.state = "initial";
    level flag::wait_till("start_zombie_round_logic");
    if (isdefined(self.zbarrier)) {
        self.zbarrier set_magic_box_zbarrier_state("initial");
        self thread zm_audio::function_ef9ba49c(#"box", 0, -1, 500, array("left", "trigger"));
        if (self.zbarrier.classname === "zbarrier_zm_esc_magicbox") {
            self.zbarrier thread function_ecf6901d();
        }
    }
    level notify(#"hash_e39eca74fa250b4", {#s_magic_box:self});
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0xc37cecb, Offset: 0x2350
// Size: 0x198
function show_chest() {
    if (!level.enable_magic || zm_custom::function_901b751c(#"zmmysteryboxstate") == 0) {
        return;
    }
    self.zbarrier endoncallback(&function_62197845, #"death");
    self.zbarrier set_magic_box_zbarrier_state("arriving");
    self.zbarrier waittilltimeout(5, #"arrived");
    assert(isdefined(level.pandora_show_func), "<dev string:x71>");
    if (isdefined(level.pandora_show_func)) {
        self thread [[ level.pandora_show_func ]]();
    }
    self.zbarrier clientfield::set("magicbox_closed_fx", 1);
    self function_76830bc7();
    self.hidden = 0;
    if (isdefined(self.box_hacks[#"summon_box"])) {
        self [[ self.box_hacks[#"summon_box"] ]](0);
    }
    level notify(#"hash_e39eca74fa250b4", {#s_magic_box:self});
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x600016cc, Offset: 0x24f0
// Size: 0x338
function hide_chest(doboxleave) {
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    if (isdefined(self.pandora_light)) {
        self.pandora_light delete();
    }
    self show_objective_icon(0);
    self.zbarrier clientfield::set("magicbox_closed_fx", 0);
    self.hidden = 1;
    self._box_open = 0;
    self._box_opened_by_fire_sale = 0;
    self.var_afba7c1f = undefined;
    self.unbearable_respin = undefined;
    self.chest_user = undefined;
    if (isdefined(self.box_hacks) && isdefined(self.box_hacks[#"summon_box"])) {
        self [[ self.box_hacks[#"summon_box"] ]](1);
    }
    if (isdefined(self.zbarrier)) {
        self.zbarrier endoncallback(&function_62197845, #"death");
        if (is_true(doboxleave)) {
            self.zbarrier thread magic_box_zbarrier_leave();
            if (self.zbarrier.state == "leaving") {
                s_result = self.zbarrier waittilltimeout(10, #"left", #"zbarrier_state_change");
                if (s_result._notify !== "left") {
                    self.zbarrier notify(#"timeout_away");
                    level notify(#"hash_e39eca74fa250b4", {#s_magic_box:self});
                    return;
                }
            }
            if (isdefined(level.var_678333a6)) {
                str_fx = level.var_678333a6;
            } else {
                str_fx = level._effect[#"poltergeist"];
            }
            playfx(str_fx, self.zbarrier.origin, anglestoup(self.zbarrier.angles), anglestoforward(self.zbarrier.angles));
        } else {
            self.zbarrier thread set_magic_box_zbarrier_state("away");
        }
    }
    level notify(#"hash_e39eca74fa250b4", {#s_magic_box:self});
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x91951ba3, Offset: 0x2830
// Size: 0x1a4
function default_pandora_fx_func() {
    self endon(#"death");
    self.pandora_light = spawn("script_model", self.zbarrier.origin);
    s_pandora_fx_pos_override = struct::get(self.target, "targetname");
    if (isdefined(s_pandora_fx_pos_override) && s_pandora_fx_pos_override.script_noteworthy === "pandora_fx_pos_override") {
        self.pandora_light.origin = s_pandora_fx_pos_override.origin;
    }
    self.pandora_light.angles = self.zbarrier.angles + (-90, 0, -90);
    self.pandora_light setmodel(#"tag_origin");
    if (!is_true(level._box_initialized)) {
        level flag::wait_till("start_zombie_round_logic");
        level._box_initialized = 1;
    }
    wait 1;
    if (isdefined(self) && isdefined(self.pandora_light)) {
        playfxontag(level._effect[#"lght_marker"], self.pandora_light, "tag_origin");
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 3, eflags: 0x1 linked
// Checksum 0x87737959, Offset: 0x29e0
// Size: 0x9c
function default_pandora_show_func(*anchor, *anchortarget, *pieces) {
    if (!isdefined(self.pandora_light)) {
        if (!isdefined(level.pandora_fx_func)) {
            level.pandora_fx_func = &default_pandora_fx_func;
        }
        self thread [[ level.pandora_fx_func ]]();
    }
    playfx(level._effect[#"lght_marker_flare"], self.pandora_light.origin);
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x9c7a142f, Offset: 0x2a88
// Size: 0x94
function function_ecf6901d() {
    self endoncallback(&function_62197845, #"death");
    self clientfield::set("" + #"hash_2fcdae6b889933c7", 1);
    self waittill(#"zbarrier_state_change");
    self clientfield::set("" + #"hash_2fcdae6b889933c7", 0);
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x62362154, Offset: 0x2b28
// Size: 0xd24
function function_c8745555(params) {
    s_chest = self.s_chest;
    if (!isdefined(s_chest.zbarrier)) {
        /#
            println("<dev string:x8e>" + s_chest.origin + "<dev string:x9e>");
            iprintlnbold("<dev string:x8e>" + s_chest.origin + "<dev string:x9e>");
        #/
        return;
    }
    s_chest.zbarrier endoncallback(&function_62197845, #"death");
    if (is_true(s_chest._box_open)) {
        return;
    }
    if (zm_custom::function_901b751c(#"zmmysteryboxlimit")) {
        if ((isdefined(level.var_bcd3620a) ? level.var_bcd3620a : 0) >= zm_custom::function_901b751c(#"zmmysteryboxlimit")) {
            return;
        }
    }
    s_chest.box_rerespun = undefined;
    s_chest.weapon_out = undefined;
    s_chest endon(#"kill_chest_think");
    user = undefined;
    user_cost = undefined;
    if (!isdefined(s_chest.forced_user)) {
        user = params.activator;
        if (user == level || is_true(user.var_838c00de)) {
            return;
        }
    } else {
        user = s_chest.forced_user;
    }
    s_chest.var_75c86f89 = undefined;
    if (!user can_buy_weapon() || is_true(s_chest.disabled) || zm_trial_disable_buys::is_active() || is_true(s_chest.being_removed)) {
        return;
    }
    reduced_cost = undefined;
    if (isdefined(s_chest.auto_open) && zm_utility::is_player_valid(user)) {
        if (!isdefined(s_chest.var_3b8f3332)) {
            user zm_score::minus_to_player_score(s_chest.zombie_cost);
            user_cost = s_chest.zombie_cost;
        } else {
            user_cost = 0;
        }
        s_chest.chest_user = user;
    } else if (zm_utility::is_player_valid(user) && user zm_score::can_player_purchase(s_chest.zombie_cost)) {
        user zm_score::minus_to_player_score(s_chest.zombie_cost);
        user_cost = s_chest.zombie_cost;
        s_chest.chest_user = user;
    } else if (isdefined(reduced_cost) && user zm_score::can_player_purchase(reduced_cost)) {
        user zm_score::minus_to_player_score(reduced_cost);
        user_cost = reduced_cost;
        s_chest.chest_user = user;
    } else if (!user zm_score::can_player_purchase(s_chest.zombie_cost)) {
        zm_utility::play_sound_at_pos("no_purchase", s_chest.origin);
        user zm_audio::create_and_play_dialog(#"general", #"outofmoney");
        return;
    }
    level flag::set("chest_has_been_used");
    demo::bookmark(#"zm_player_use_magicbox", gettime(), user);
    potm::bookmark(#"zm_player_use_magicbox", gettime(), user);
    user zm_stats::increment_client_stat("use_magicbox");
    user zm_stats::increment_player_stat("use_magicbox");
    user zm_stats::increment_challenge_stat(#"survivalist_buy_magic_box", undefined, 1);
    user zm_stats::function_8f10788e("boas_use_magicbox");
    user zm_daily_challenges::increment_magic_box();
    user zm_stats::function_c0c6ab19(#"boxbuys", 1, 1);
    user zm_stats::function_c0c6ab19(#"weapons_bought", 1, 1);
    user contracts::increment_zm_contract(#"contract_zm_weapons_bought", 1, #"zstandard");
    if (isplayer(s_chest.chest_user)) {
        s_chest.chest_user util::delay(0, "death", &zm_audio::create_and_play_dialog, #"box", #"interact");
        level notify(#"hash_39b0256c6c9885fc", {#var_c192c739:self, #e_player:s_chest.chest_user});
    }
    s_chest thread watch_for_emp_close();
    s_chest thread zm_trial_disable_buys::function_8327d26e();
    if (isdefined(level.var_f39bb42a)) {
        s_chest thread [[ level.var_f39bb42a ]]();
    }
    s_chest._box_open = 1;
    s_chest._box_opened_by_fire_sale = 0;
    if (is_true(zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on")) && !isdefined(s_chest.auto_open) && s_chest [[ level._zombiemode_check_firesale_loc_valid_func ]]()) {
        s_chest._box_opened_by_fire_sale = 1;
    }
    if (zm_custom::function_901b751c(#"zmmysteryboxlimit")) {
        if (!isdefined(level.var_bcd3620a)) {
            level.var_bcd3620a = 0;
        }
        level.var_bcd3620a += 1;
        if (level.var_bcd3620a >= zm_custom::function_901b751c(#"zmmysteryboxlimit")) {
            zm_powerups::powerup_remove_from_regular_drops("fire_sale");
            level thread function_7d384b90();
        }
    }
    if (zm_custom::function_901b751c(#"zmmysteryboxlimitround")) {
        if (level.var_fc02e2df !== level.round_number) {
            level.var_40f4f72d = 1;
            level.var_fc02e2df = level.round_number;
        } else {
            level.var_40f4f72d += 1;
        }
    }
    if (isdefined(s_chest.chest_lid)) {
        s_chest.chest_lid thread treasure_chest_lid_open();
    }
    if (isdefined(s_chest.zbarrier)) {
        s_chest.zbarrier set_magic_box_zbarrier_state("open");
    }
    s_chest.timedout = 0;
    s_chest.weapon_out = 1;
    s_chest.var_a7b092aa = 1;
    s_chest.zbarrier thread treasure_chest_weapon_spawn(s_chest, user);
    if (isdefined(level.custom_treasure_chest_glowfx)) {
        s_chest.zbarrier thread [[ level.custom_treasure_chest_glowfx ]]();
    } else {
        s_chest.zbarrier thread treasure_chest_glowfx();
    }
    self setinvisibletoall();
    s_chest show_objective_icon(0, user);
    s_chest.zbarrier waittill(#"randomization_done", #"box_hacked_respin");
    s_chest.var_a7b092aa = undefined;
    if (isdefined(user)) {
        if (level flag::get("moving_chest_now") && !s_chest._box_opened_by_fire_sale && isdefined(user_cost)) {
            user zm_score::add_to_player_score(user_cost, 0, "magicbox_bear");
        }
    }
    if (level flag::get("moving_chest_now") && !zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on") && !s_chest._box_opened_by_fire_sale) {
        s_chest thread treasure_chest_move(s_chest.chest_user);
    } else if (!is_true(s_chest.unbearable_respin) && !is_true(s_chest.var_afba7c1f)) {
        if (isdefined(user)) {
            s_chest.grab_weapon_hint = 1;
            if (!isdefined(s_chest.zbarrier.weapon.var_627c698b)) {
                s_chest.zbarrier.weapon = level.weaponnone;
            }
            s_chest.grab_weapon = s_chest.zbarrier.weapon.var_627c698b;
            s_chest.chest_user = user;
            bb::logpurchaseevent(user, s_chest, user_cost, s_chest.grab_weapon, 0, "_magicbox", "_offered");
            weaponidx = undefined;
            self function_3238e2f9(s_chest);
            if (isdefined(s_chest.grab_weapon)) {
                weaponidx = matchrecordgetweaponindex(s_chest.grab_weapon);
            }
            if (isdefined(weaponidx)) {
                user recordmapevent(10, gettime(), user.origin, level.round_number, weaponidx);
            }
            self setvisibletoplayer(s_chest.chest_user);
            if (!is_true(s_chest.zbarrier.weapon.isheroweapon) && zm_utility::get_number_of_valid_players() > 1 && !is_true(s_chest.var_1f9dff37)) {
                s_chest thread function_e4dcca48();
            }
        }
        if (isdefined(s_chest.zbarrier) && !is_true(s_chest.zbarrier.var_7672d70d)) {
            s_chest thread treasure_chest_timeout(user);
        }
    }
    self function_c6cfae9e(user, s_chest, user_cost);
}

// Namespace zm_magicbox/zm_magicbox
// Params 3, eflags: 0x1 linked
// Checksum 0xeb6bb, Offset: 0x3858
// Size: 0x8f4
function function_c6cfae9e(user, s_chest, user_cost) {
    self endon(#"death");
    while (!is_true(s_chest.var_7672d70d) && !is_true(s_chest.var_afba7c1f)) {
        waitresult = self waittill(#"trigger");
        grabber = waitresult.activator;
        s_chest.weapon_out = undefined;
        if (is_true(level.magic_box_grab_by_anyone) || is_true(s_chest.var_481aa649)) {
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
            if (grabber != level && isdefined(s_chest.box_rerespun) && s_chest.box_rerespun) {
                user = grabber;
            }
        }
        if (grabber == user || grabber == level) {
            s_chest.box_rerespun = undefined;
            current_weapon = level.weaponnone;
            if (zm_utility::is_player_valid(user)) {
                current_weapon = user getcurrentweapon();
            }
            if (killstreaks::is_killstreak_weapon(current_weapon)) {
                wait 0.1;
                continue;
            }
            if (grabber == user && zm_utility::is_player_valid(user) && !user zm_utility::is_drinking() && !zm_loadout::is_placeable_mine(current_weapon) && !zm_equipment::is_equipment(current_weapon) && !user zm_utility::is_player_revive_tool(current_weapon) && !current_weapon.isheroweapon && !current_weapon.isgadget) {
                bb::logpurchaseevent(user, s_chest, user_cost, s_chest.zbarrier.weapon, 0, "_magicbox", "_grabbed");
                weaponidx = undefined;
                if (isdefined(s_chest.zbarrier) && isdefined(s_chest.zbarrier.weapon.var_627c698b)) {
                    weaponidx = matchrecordgetweaponindex(s_chest.zbarrier.weapon.var_627c698b);
                }
                if (isdefined(weaponidx)) {
                    user recordmapevent(11, gettime(), user.origin, level.round_number, weaponidx);
                }
                s_chest notify(#"user_grabbed_weapon");
                user notify(#"user_grabbed_weapon");
                user thread treasure_chest_give_weapon(s_chest.zbarrier.weapon, s_chest.var_75c86f89, s_chest.zbarrier);
                demo::bookmark(#"zm_player_grabbed_magicbox", gettime(), user);
                potm::bookmark(#"zm_player_grabbed_magicbox", gettime(), user);
                user zm_stats::increment_client_stat("grabbed_from_magicbox");
                user zm_stats::increment_player_stat("grabbed_from_magicbox");
                user zm_stats::function_8f10788e("boas_grabbed_from_magicbox");
                if (isdefined(level.var_bb6907a4)) {
                    s_chest [[ level.var_bb6907a4 ]](user);
                }
                break;
            } else if (grabber == level) {
                s_chest.timedout = 1;
                if (isdefined(user)) {
                    bb::logpurchaseevent(user, s_chest, user_cost, s_chest.zbarrier.weapon.var_627c698b, 0, "_magicbox", "_returned");
                    weaponidx = undefined;
                    if (isdefined(s_chest.zbarrier.weapon.var_627c698b)) {
                        weaponidx = matchrecordgetweaponindex(s_chest.zbarrier.weapon.var_627c698b);
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
    s_chest.grab_weapon_hint = 0;
    s_chest.zbarrier notify(#"weapon_grabbed");
    if (!is_true(s_chest._box_opened_by_fire_sale)) {
        level.chest_accessed += 1;
    }
    if (isdefined(s_chest.chest_lid)) {
        s_chest.chest_lid thread treasure_chest_lid_close(s_chest.timedout);
    }
    self setinvisibletoall();
    if (isdefined(self.zbarrier)) {
        s_chest.zbarrier set_magic_box_zbarrier_state("close");
        zm_utility::play_sound_at_pos("close_chest", s_chest.origin);
        s_chest.zbarrier waittill(#"closed");
        wait 1;
    } else {
        wait 3;
    }
    if (is_true(zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on")) && s_chest [[ level._zombiemode_check_firesale_loc_valid_func ]]() || zm_custom::function_901b751c(#"zmmysteryboxstate") == 3 || zm_custom::function_901b751c(#"zmmysteryboxstate") == 1 || s_chest == level.chests[level.chest_index]) {
        self setinvisibletoall();
        s_chest show_objective_icon(0);
    } else {
        self setvisibletoall();
        s_chest show_objective_icon(1);
    }
    s_chest._box_open = 0;
    s_chest._box_opened_by_fire_sale = 0;
    s_chest.var_afba7c1f = undefined;
    s_chest.unbearable_respin = undefined;
    s_chest.chest_user = undefined;
    s_chest notify(#"chest_accessed");
    level flag::set("chest_weapon_has_been_taken");
    self function_3238e2f9(s_chest);
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x514e26c5, Offset: 0x4158
// Size: 0x23a
function function_e4dcca48() {
    self.chest_user endon(#"bled_out", #"death");
    self.zbarrier endon(#"weapon_grabbed");
    self.var_481aa649 = 0;
    self.var_c2f3a87c = 0;
    var_369ce419 = self.chest_user;
    var_63f52acb = self.zbarrier.weapon_model;
    if (isdefined(var_63f52acb)) {
        var_63f52acb endon(#"death");
    }
    var_13370b92 = self.trigger;
    var_13370b92 endon(#"death");
    while (true) {
        self.var_c2f3a87c = 0;
        if (isdefined(var_369ce419) && isdefined(var_63f52acb)) {
            if (var_369ce419 util::is_looking_at(var_63f52acb)) {
                self.var_c2f3a87c = 1;
            }
        }
        var_13370b92 function_3238e2f9(self);
        if (isdefined(var_369ce419) && var_369ce419 meleebuttonpressed() && self.var_c2f3a87c && var_369ce419 istouching(var_13370b92)) {
            self.var_481aa649 = 1;
            self.var_75c86f89 = var_369ce419;
            if (isdefined(var_63f52acb)) {
                var_63f52acb clientfield::set("powerup_fx", 1);
            }
            var_369ce419 thread zm_audio::create_and_play_dialog(#"magicbox", #"share");
            var_13370b92 setvisibletoall();
            var_13370b92 function_3238e2f9(self);
            break;
        }
        waitframe(1);
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x3dc4e138, Offset: 0x43a0
// Size: 0x1c6
function watch_for_emp_close() {
    self endon(#"chest_accessed");
    self.var_7672d70d = 0;
    if (!zm_utility::should_watch_for_emp()) {
        return;
    }
    if (isdefined(self.zbarrier)) {
        self.zbarrier.var_7672d70d = 0;
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
    self.var_7672d70d = 1;
    if (isdefined(self.zbarrier)) {
        self.zbarrier.var_7672d70d = 1;
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
// Params 1, eflags: 0x1 linked
// Checksum 0xce0f4341, Offset: 0x4570
// Size: 0x1c6
function can_buy_weapon(var_5429ee1f = 1) {
    if (!isdefined(self)) {
        return false;
    }
    if (var_5429ee1f && zm_custom::function_901b751c(#"zmmysteryboxlimitround")) {
        if ((isdefined(level.var_40f4f72d) ? level.var_40f4f72d : 0) >= zm_custom::function_901b751c(#"zmmysteryboxlimitround")) {
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
    if (killstreaks::is_killstreak_weapon(current_weapon)) {
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
// Params 0, eflags: 0x1 linked
// Checksum 0xc4a4db5c, Offset: 0x4740
// Size: 0x18c
function default_box_move_logic() {
    index = -1;
    for (i = 0; i < level.chests.size; i++) {
        if (isdefined(level.chests[i].script_noteworthy) && issubstr(level.chests[i].script_noteworthy, "move" + level.chest_moves + 1) && i != level.chest_index) {
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
        if (temp_chest_name === level.chests[level.chest_index].script_noteworthy) {
            level.chest_index++;
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x3332f074, Offset: 0x48d8
// Size: 0x426
function treasure_chest_move(player_vox) {
    if (isdefined(self.zbarrier)) {
        self.zbarrier endoncallback(&function_62197845, #"death");
    }
    level waittill(#"weapon_fly_away_start");
    players = getplayers();
    array::thread_all(players, &play_crazi_sound);
    level thread function_f81251c9();
    if (isdefined(player_vox)) {
        player_vox thread zm_audio::create_and_play_dialog(#"magicbox", #"move", undefined, 2);
    }
    level waittill(#"weapon_fly_away_end");
    if (isdefined(self.zbarrier)) {
        self hide_chest(1);
    }
    wait 0.1;
    post_selection_wait_duration = 7;
    if (isdefined(level._zombiemode_custom_box_move_logic)) {
        [[ level._zombiemode_custom_box_move_logic ]]();
    } else {
        default_box_move_logic();
    }
    if (zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on") == 1 && self [[ level._zombiemode_check_firesale_loc_valid_func ]]()) {
        current_sale_time = zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_time");
        util::wait_network_frame();
        self thread fire_sale_fix();
        zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", current_sale_time);
        while (zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_time") > 0) {
            wait 0.1;
        }
    } else {
        post_selection_wait_duration += 5;
    }
    level.verify_chest = 0;
    if (isdefined(level.chests[level.chest_index].box_hacks[#"summon_box"])) {
        level.chests[level.chest_index] [[ level.chests[level.chest_index].box_hacks[#"summon_box"] ]](0);
    }
    wait post_selection_wait_duration;
    if (isdefined(level.var_678333a6)) {
        str_fx = level.var_678333a6;
    } else {
        str_fx = level._effect[#"poltergeist"];
    }
    playfx(str_fx, level.chests[level.chest_index].zbarrier.origin, anglestoup(level.chests[level.chest_index].zbarrier.angles), anglestoforward(level.chests[level.chest_index].zbarrier.angles));
    level.chests[level.chest_index] show_chest();
    level flag::clear("moving_chest_now");
    self.zbarrier.chest_moving = 0;
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0xf2fb87c6, Offset: 0x4d08
// Size: 0x54
function function_f81251c9() {
    level endon(#"game_over", #"hash_5002eab927d4056d");
    wait 5;
    level thread zm_audio::sndannouncerplayvox(#"boxmove");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x59f4dcd9, Offset: 0x4d68
// Size: 0x16c
function fire_sale_fix() {
    if (!isdefined(zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on"))) {
        return;
    }
    if (zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on")) {
        self.old_cost = 950;
        self thread show_chest();
        self.zombie_cost = 10;
        util::wait_network_frame();
        level waittill(#"fire_sale_off");
        for (i = 0; i < level.chests.size; i++) {
            if (i == level.chest_index) {
                level.chests[i].was_temp = undefined;
                continue;
            }
            level.chests[i].was_temp = 1;
        }
        while (is_true(self._box_open)) {
            wait 0.1;
        }
        self.zombie_cost = self.old_cost;
        self hide_chest(1);
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0xd73aec79, Offset: 0x4ee0
// Size: 0xf0
function treasure_chest_timeout(user) {
    self endon(#"user_grabbed_weapon");
    self.zbarrier endoncallback(&function_62197845, #"box_hacked_respin", #"box_hacked_rerespin", #"death");
    n_timeout = isdefined(level.var_ad2674fe) ? level.var_ad2674fe : 12;
    wait n_timeout;
    self.trigger notify(#"trigger", {#activator:level});
    if (isdefined(user)) {
        if (isdefined(level.var_bb6907a4)) {
            self [[ level.var_bb6907a4 ]](user);
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0xab818342, Offset: 0x4fd8
// Size: 0x4c
function treasure_chest_lid_open() {
    openroll = 105;
    opentime = 0.5;
    self rotateroll(105, opentime, opentime * 0.5);
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x7c25ef0d, Offset: 0x5030
// Size: 0x66
function treasure_chest_lid_close(*timedout) {
    closeroll = -105;
    closetime = 0.5;
    self rotateroll(closeroll, closetime, closetime * 0.5);
    self notify(#"lid_closed");
}

// Namespace zm_magicbox/zm_magicbox
// Params 3, eflags: 0x1 linked
// Checksum 0x6b676a81, Offset: 0x50a0
// Size: 0x1f0
function function_db355791(player, item, var_21b5a3f4 = 1) {
    if (!isdefined(player)) {
        return 0;
    }
    if (!isdefined(player.var_16fc6934)) {
        if (var_21b5a3f4 && isinarray(player.var_ca56e806, item)) {
            return 0;
        }
    }
    if (isdefined(item.var_627c698b)) {
        if (player zm_weapons::has_weapon_or_upgrade(item.var_627c698b)) {
            return 0;
        }
        if (!player zm_weapons::player_can_use_content(item.var_627c698b)) {
            return 0;
        }
        if (isdefined(level.custom_magic_box_selection_logic) && ![[ level.custom_magic_box_selection_logic ]](item, player)) {
            return 0;
        }
        if (item.var_627c698b.name === #"ray_gun" && player zm_weapons::has_weapon_or_upgrade(getweapon(#"raygun_mark2"))) {
            return 0;
        }
        if (isdefined(level.special_weapon_magicbox_check)) {
            return player [[ level.special_weapon_magicbox_check ]](item.var_627c698b);
        }
        if (!zm_weapons::limited_weapon_below_quota(item.var_627c698b, player)) {
            return 0;
        }
        if (isdefined(level.var_cbc6587a) && isinarray(level.var_cbc6587a, item.var_627c698b)) {
            return 0;
        }
    }
    return 1;
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x815486ad, Offset: 0x5298
// Size: 0x842
function function_4aa1f177(player) {
    n_roll = randomint(100);
    var_257fe1c5 = 0;
    /#
        var_831166ae = getdvarint(#"hash_1c6e2da671662923", 0);
        if (var_831166ae) {
            n_roll = 96;
        }
    #/
    var_c1e65f4 = 95;
    var_9122699b = var_c1e65f4 - 95;
    if (n_roll >= var_c1e65f4) {
        var_754850f5 = arraycopy(level.var_e5067476);
    } else if (n_roll >= var_9122699b) {
        range = randomintrange(0, 100);
        low_threshold = 0;
        var_e7308a9 = level.var_e2f02558;
        foreach (i, weight in level.var_c0c63390) {
            if (range >= low_threshold && range < weight) {
                var_e7308a9 = i;
                break;
            }
            low_threshold = weight;
        }
        var_754850f5 = level.var_4da246c[var_e7308a9];
        var_257fe1c5 = 1;
    } else {
        return level.weaponnone;
    }
    /#
        if (var_831166ae) {
            var_754850f5 = [#"zm_magicbox_weapon_ray_gun_list"];
        }
    #/
    var_754850f5 = array::randomize(var_754850f5);
    var_ad162e6a = 0;
    if (isdefined(player)) {
        if (!isdefined(player.var_ca56e806)) {
            player.var_ca56e806 = [];
        } else if (!isarray(player.var_ca56e806)) {
            player.var_ca56e806 = array(player.var_ca56e806);
        }
        if (isdefined(level.customrandomweaponweights)) {
            var_754850f5 = player [[ level.customrandomweaponweights ]](var_754850f5);
        }
        if (isdefined(player.var_afb3ba4e)) {
            var_754850f5 = player [[ player.var_afb3ba4e ]](var_754850f5);
        }
        if (isdefined(player.var_abaf754e)) {
            if (isdefined(player.var_61c96978)) {
                player thread [[ player.var_61c96978 ]](self);
            }
            arrayinsert(var_754850f5, player.var_abaf754e, 0);
            var_ad162e6a = 1;
        }
    }
    /#
        var_915d93e6 = getdvarstring(#"hash_5577163bdcd854a2");
        if (isdefined(var_915d93e6) && var_915d93e6 != "<dev string:xc8>") {
            arrayinsert(var_754850f5, var_915d93e6, 0);
            var_ad162e6a = 1;
        }
    #/
    if (isdefined(player)) {
        if (var_ad162e6a) {
            var_4ac286cf = array(#"uncommon", #"rare", #"epic", #"legendary", #"ultra");
            weapon = function_830aff18(var_754850f5[0], player, var_4ac286cf, var_257fe1c5);
            return (isdefined(weapon) ? weapon : level.weaponnone);
        } else if (var_257fe1c5) {
            var_3afe334f = zm_utility::function_e3025ca5();
            switch (var_3afe334f) {
            case 0:
            case 1:
                var_dcdb4bb7 = 85;
                var_fef08b67 = 10;
                var_6c903ad5 = 3;
                var_f5e41acd = 1;
                var_82b1fc0d = 1;
                break;
            case 2:
                var_dcdb4bb7 = 35;
                var_fef08b67 = 50;
                var_6c903ad5 = 10;
                var_f5e41acd = 4;
                var_82b1fc0d = 1;
                break;
            case 3:
                var_dcdb4bb7 = 5;
                var_fef08b67 = 35;
                var_6c903ad5 = 50;
                var_f5e41acd = 8;
                var_82b1fc0d = 2;
                break;
            case 4:
                var_dcdb4bb7 = 0;
                var_fef08b67 = 5;
                var_6c903ad5 = 40;
                var_f5e41acd = 50;
                var_82b1fc0d = 5;
                break;
            case 5:
                var_dcdb4bb7 = 0;
                var_fef08b67 = 0;
                var_6c903ad5 = 25;
                var_f5e41acd = 70;
                var_82b1fc0d = 5;
                break;
            default:
                var_dcdb4bb7 = 0;
                var_fef08b67 = 0;
                var_6c903ad5 = 5;
                var_f5e41acd = 90;
                var_82b1fc0d = 5;
                break;
            }
            var_99bf86f3 = 100 - var_82b1fc0d;
            var_42bbb9f1 = var_99bf86f3 - var_f5e41acd;
            var_7a27b7c1 = var_42bbb9f1 - var_6c903ad5;
            var_d82105ed = var_7a27b7c1 - var_fef08b67;
            var_2b426a85 = var_d82105ed - var_dcdb4bb7;
            var_bf43f78f = randomint(100);
            if (var_bf43f78f >= var_99bf86f3) {
                var_4ac286cf = array(#"ultra");
            } else if (var_bf43f78f >= var_42bbb9f1) {
                var_4ac286cf = array(#"legendary");
            } else if (var_bf43f78f >= var_7a27b7c1) {
                var_4ac286cf = array(#"epic");
            } else if (var_bf43f78f >= var_d82105ed) {
                var_4ac286cf = array(#"rare");
            } else {
                var_4ac286cf = array(#"uncommon");
            }
        }
        foreach (var_986a7654 in var_754850f5) {
            weapon = function_830aff18(var_986a7654, player, var_4ac286cf, var_257fe1c5);
            if (isdefined(weapon)) {
                return weapon;
            }
        }
    }
    return level.weaponnone;
}

// Namespace zm_magicbox/zm_magicbox
// Params 4, eflags: 0x1 linked
// Checksum 0xe3f3b118, Offset: 0x5ae8
// Size: 0x34c
function function_830aff18(var_e05f8872, player, var_4ac286cf, var_257fe1c5 = 0) {
    var_517c3cf5 = getscriptbundle(var_e05f8872);
    if (var_517c3cf5.type === "itemspawnlist") {
        var_b8a06478 = arraycopy(var_517c3cf5.itemlist);
        var_b8a06478 = array::randomize(var_b8a06478);
        foreach (var_3bbf766e in var_b8a06478) {
            weapon = function_830aff18(var_3bbf766e.var_a6762160, player, var_4ac286cf, var_257fe1c5);
            if (isdefined(weapon)) {
                return weapon;
            }
        }
        return;
    }
    var_89230090 = var_517c3cf5;
    if (isdefined(var_89230090.var_a53e9db0)) {
        weapon = namespace_65181344::function_67456242(var_89230090);
        point = function_4ba8fde(var_89230090.name);
        item = item_drop::drop_item(0, weapon, 1, weapon.maxammo, point.id, self.origin, self.angles, 1);
        item.hidetime = 1;
        item hide();
    } else {
        weapon = item_world_util::function_35e06774(var_89230090, isdefined(var_89230090.attachments));
        point = function_4ba8fde(var_89230090.name);
        item = item_drop::drop_item(0, weapon, 1, weapon.maxammo, point.id, self.origin, self.angles, 1);
        item.hidetime = 1;
        item hide();
    }
    if (function_db355791(player, item, 0) && (!var_257fe1c5 || var_257fe1c5 && isinarray(var_4ac286cf, hash(var_89230090.rarity)))) {
        self.owner.var_c639ca3e = var_89230090.rarity;
        self.owner.var_9e7e27d7 = var_89230090.name;
        return item;
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0xb9c22390, Offset: 0x5e40
// Size: 0x30
function weapon_show_hint_choke() {
    level._weapon_show_hint_choke = 0;
    while (true) {
        waitframe(1);
        level._weapon_show_hint_choke = 0;
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 6, eflags: 0x1 linked
// Checksum 0x5bfa62d9, Offset: 0x5e78
// Size: 0x41c
function decide_hide_show_hint(endon_notify, second_endon_notify, onlyplayer, can_buy_weapon_extra_check_func, var_5429ee1f = 1, var_e6473bf1 = 600) {
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
            if (distancesquared(onlyplayer.origin, self.origin) <= function_a3f6cdac(var_e6473bf1) && onlyplayer can_buy_weapon(var_5429ee1f) && (!isdefined(can_buy_weapon_extra_check_func) || onlyplayer [[ can_buy_weapon_extra_check_func ]](self.weapon)) && !onlyplayer bgb::is_enabled(#"zm_bgb_disorderly_combat")) {
                self setinvisibletoplayer(onlyplayer, 0);
            } else {
                self setinvisibletoplayer(onlyplayer, 1);
            }
        } else {
            players = getplayers();
            for (i = 0; i < players.size; i++) {
                if (distancesquared(players[i].origin, self.origin) <= function_a3f6cdac(var_e6473bf1) && players[i] can_buy_weapon(var_5429ee1f) && (!isdefined(can_buy_weapon_extra_check_func) || players[i] [[ can_buy_weapon_extra_check_func ]](self.weapon)) && !players[i] bgb::is_enabled(#"zm_bgb_disorderly_combat")) {
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
// Checksum 0x5ee7d408, Offset: 0x62a0
// Size: 0x4a
function get_left_hand_weapon_model_name(weapon) {
    dw_weapon = weapon.dualwieldweapon;
    if (dw_weapon != level.weaponnone) {
        return dw_weapon.worldmodel;
    }
    return weapon.worldmodel;
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0xbaed6d8a, Offset: 0x62f8
// Size: 0x11c
function clean_up_hacked_box() {
    self endoncallback(&function_62197845, #"death");
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
// Params 0, eflags: 0x1 linked
// Checksum 0x4427867, Offset: 0x6420
// Size: 0x32
function treasure_chest_firesale_active() {
    return is_true(zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on"));
}

// Namespace zm_magicbox/zm_magicbox
// Params 2, eflags: 0x1 linked
// Checksum 0x494c0155, Offset: 0x6460
// Size: 0x44e
function treasure_chest_should_move(chest, player) {
    if (getdvarint(#"magic_chest_movable", 0) && !is_true(chest._box_opened_by_fire_sale) && !treasure_chest_firesale_active() && self [[ level._zombiemode_check_firesale_loc_valid_func ]]() && !is_true(player.var_c21099c0)) {
        chance_of_joker = 0;
        if (zm_trial::is_trial_mode()) {
            if (level.chest_accessed >= 3 || is_true(level.var_bb641599)) {
                return true;
            }
        }
        a_players = getplayers();
        level.chest_min_move_usage = 3 + a_players.size;
        if (level.chest_moves) {
            if (zm_utility::is_survival()) {
                level.chest_min_move_usage = 2;
            } else {
                level.chest_min_move_usage = 4;
            }
        }
        if (level.chest_accessed < level.chest_min_move_usage) {
            chance_of_joker = -1;
        }
        if (chance_of_joker >= 0) {
            if (level.chest_moves == 0) {
                chance_of_joker = 100;
            } else if (zm_utility::is_survival()) {
                switch (level.chest_accessed) {
                case 1:
                    chance_of_joker = 0;
                    break;
                case 2:
                case 3:
                    chance_of_joker = 15;
                    break;
                case 4:
                case 5:
                case 6:
                case 7:
                    chance_of_joker = 30;
                    break;
                default:
                    chance_of_joker = 50;
                    break;
                }
            } else {
                switch (level.chest_accessed) {
                case 1:
                case 2:
                case 3:
                    chance_of_joker = 0;
                    break;
                case 4:
                case 5:
                case 6:
                case 7:
                    chance_of_joker = 15;
                    break;
                case 8:
                case 9:
                case 10:
                case 11:
                    chance_of_joker = 30;
                    break;
                default:
                    chance_of_joker = 50;
                    break;
                }
            }
        }
        if (isdefined(chest.no_fly_away)) {
            chance_of_joker = -1;
        }
        if (isdefined(level.var_b0344a3c)) {
            chance_of_joker = [[ level.var_b0344a3c ]](chance_of_joker);
        }
        if (is_true(level.var_401aaa92)) {
            level.var_401aaa92 = 0;
            chance_of_joker = 100;
        }
        n_random = randomint(100);
        if (chance_of_joker > n_random) {
            return true;
        }
    }
    return false;
}

// Namespace zm_magicbox/zm_magicbox
// Params 4, eflags: 0x1 linked
// Checksum 0xb3a2c747, Offset: 0x68b8
// Size: 0x78
function spawn_joker_weapon_model(*player, model, origin, angles) {
    weapon_model = spawn("script_model", origin);
    if (isdefined(angles)) {
        weapon_model.angles = angles;
    }
    weapon_model setmodel(model);
    return weapon_model;
}

// Namespace zm_magicbox/zm_magicbox
// Params 3, eflags: 0x1 linked
// Checksum 0x96120f3a, Offset: 0x6938
// Size: 0x23c
function treasure_chest_weapon_locking(player, item, onoff) {
    if (isdefined(self.locked_model)) {
        self.locked_model delete();
        self.locked_model = undefined;
    }
    if (isdefined(item.var_627c698b)) {
        weapon = item.var_627c698b;
    } else {
        weapon = level.weaponnone;
    }
    if (onoff) {
        if (weapon == level.weaponnone) {
            self.locked_model = spawn_joker_weapon_model(player, level.chest_joker_model, self.origin, (0, 0, 0));
        } else if (isdefined(player)) {
            self.locked_model = zm_utility::spawn_buildkit_weapon_model(player, weapon, undefined, self.origin, (0, 0, 0));
            if (!isdefined(player.var_ca56e806)) {
                player.var_ca56e806 = [];
            } else if (!isarray(player.var_ca56e806)) {
                player.var_ca56e806 = array(player.var_ca56e806);
            }
            if (!isinarray(player.var_ca56e806, item)) {
                player.var_ca56e806[player.var_ca56e806.size] = item;
            }
            if (player.var_ca56e806.size > 8) {
                arrayremoveindex(player.var_ca56e806, 0);
            }
        } else {
            self.locked_model = util::spawn_model(item.model, self.origin, (0, 0, 0));
        }
        self.locked_model ghost();
        self.locked_model clientfield::set("force_stream", 1);
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 3, eflags: 0x1 linked
// Checksum 0x36ff10ff, Offset: 0x6b80
// Size: 0xf66
function treasure_chest_weapon_spawn(chest, player, respin) {
    if (isdefined(level.var_555605da)) {
        self.owner endon(#"box_locked");
        self thread [[ level.var_555605da ]]();
    }
    self endoncallback(&function_62197845, #"box_hacked_respin", #"death");
    self thread clean_up_hacked_box();
    assert(isdefined(player));
    self.chest_moving = 0;
    move_the_box = treasure_chest_should_move(chest, player);
    preferred_weapon = undefined;
    if (move_the_box) {
        preferred_weapon = level.weaponnone;
    } else {
        preferred_weapon = function_4aa1f177(player);
    }
    chest treasure_chest_weapon_locking(player, preferred_weapon, 1);
    self.weapon = level.weaponnone;
    modelname = undefined;
    rand = undefined;
    var_943077fe = isdefined(level.var_3ba4b305) ? level.var_3ba4b305 : 40;
    if (player hasperk(#"specialty_cooldown") || player namespace_e86ffa8::function_efb6dedf(4)) {
        var_943077fe = min(var_943077fe, 10);
    }
    var_f91a62a4 = 1;
    if (var_943077fe < 40) {
        var_f91a62a4 = var_943077fe / 40;
    }
    assert(var_f91a62a4 >= 0.1 && var_f91a62a4 <= 2, "<dev string:xcc>");
    if (chest.zbarrier iszbarrier()) {
        if (isdefined(level.custom_magic_box_do_weapon_rise)) {
            chest.zbarrier thread [[ level.custom_magic_box_do_weapon_rise ]]();
        } else {
            chest.zbarrier thread magic_box_do_weapon_rise(var_f91a62a4);
        }
        chest.zbarrier endoncallback(&function_62197845, #"death");
    }
    for (i = 0; i < var_943077fe; i++) {
        if (i < var_943077fe * 0.5) {
            waitframe(1);
            continue;
        }
        if (i < var_943077fe * 0.75) {
            wait 0.1;
            continue;
        }
        if (i < var_943077fe * 0.875) {
            wait 0.2;
            continue;
        }
        if (i < var_943077fe * 0.95) {
            wait 0.3;
        }
    }
    if (isdefined(level.var_9e2df930)) {
        [[ level.var_9e2df930 ]]();
    }
    if (!move_the_box && preferred_weapon == level.weaponnone) {
        if (isdefined(player)) {
            player iprintlnbold(#"zombie/magic_box_empty");
        }
        wait 1;
        if (isdefined(player)) {
            player zm_score::add_to_player_score(self.owner.zombie_cost, 0, "magicbox_bear");
        }
        self.owner.var_afba7c1f = 1;
        self notify(#"randomization_done");
        return;
    }
    new_firesale = move_the_box && treasure_chest_firesale_active();
    if (new_firesale) {
        move_the_box = 0;
        preferred_weapon = function_4aa1f177(player);
    }
    if (!move_the_box && function_db355791(player, preferred_weapon, 0)) {
        rand = preferred_weapon;
    } else {
        rand = self function_4aa1f177(player);
    }
    if (!isdefined(rand.var_627c698b)) {
        rand = level.weaponnone;
    }
    if (rand == level.weaponnone) {
        if (isdefined(player)) {
            player iprintlnbold(#"zombie/magic_box_empty");
        }
        wait 1;
        if (isdefined(player)) {
            player zm_score::add_to_player_score(self.owner.zombie_cost, 0, "magicbox_bear");
        }
        self.owner.var_afba7c1f = 1;
        self notify(#"randomization_done");
        return;
    }
    self.weapon = rand;
    if (!move_the_box && rand === getweapon(#"homunculus")) {
        self thread zm_vo::vo_say(#"hash_770c96a35322e11d", 0, 0, 0, 1);
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
        self.weapon_model = zm_utility::spawn_buildkit_weapon_model(player, rand.var_627c698b, undefined, self.origin + v_float, (self.angles[0] * -1, self.angles[1] + 180, self.angles[2] * -1));
    } else {
        self.weapon_model = util::spawn_model(rand.worldmodel, self.origin + v_float, (self.angles[0] * -1, self.angles[1] + 180, self.angles[2] * -1));
    }
    if (rand.var_627c698b.isdualwield) {
        dweapon = rand.var_627c698b;
        if (isdefined(rand.var_627c698b.dualwieldweapon) && rand.var_627c698b.dualwieldweapon != level.weaponnone) {
            dweapon = rand.var_627c698b.dualwieldweapon;
        }
        if (isdefined(player)) {
            self.weapon_model_dw = zm_utility::spawn_buildkit_weapon_model(player, dweapon, undefined, self.weapon_model.origin - (3, 3, 3), self.weapon_model.angles);
        } else {
            self.weapon_model_dw = util::spawn_model(dweapon.worldmodel, self.weapon_model.origin - (3, 3, 3), self.weapon_model.angles);
        }
    }
    if (move_the_box && !(zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on") && self [[ level._zombiemode_check_firesale_loc_valid_func ]]())) {
        self.weapon_model setmodel(level.chest_joker_model);
        if (isdefined(self.weapon_model_dw)) {
            self.weapon_model_dw delete();
            self.weapon_model_dw = undefined;
        }
        if (isplayer(chest.chest_user)) {
            if (chest.chest_user bgb::is_enabled(#"zm_bgb_unbearable")) {
                level.chest_accessed = 0;
                chest.unbearable_respin = 1;
                chest.chest_user notify(#"zm_bgb_unbearable", {#chest:chest});
                chest waittill(#"forever");
            } else {
                chest.chest_user contracts::increment_zm_contract(#"contract_zm_move_box");
            }
        }
        self.chest_moving = 1;
        level flag::set("moving_chest_now");
        level.chest_accessed = 0;
        level.chest_moves++;
    }
    self notify(#"randomization_done");
    if (is_true(self.chest_moving)) {
        self.owner.var_c639ca3e = undefined;
        self function_a6d171f4(#"none");
        if (isdefined(level.chest_joker_custom_movement)) {
            self thread [[ level.chest_joker_custom_movement ]]();
        } else {
            if (isdefined(self.weapon_model)) {
                v_origin = self.weapon_model.origin;
                self.weapon_model delete();
            }
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
            if (isdefined(self.weapon_model)) {
                self.weapon_model waittill(#"movedone");
                self.weapon_model delete();
            }
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
        if (isdefined(self.weapon_model)) {
            self.weapon_model zm_utility::function_36eb0acc(self.owner.var_c639ca3e);
        }
        if (isdefined(self.weapon_model_dw)) {
            self.weapon_model_dw zm_utility::function_36eb0acc(self.owner.var_c639ca3e);
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
// Params 1, eflags: 0x1 linked
// Checksum 0x4b273f46, Offset: 0x7af0
// Size: 0x262
function function_a6d171f4(var_13f9dee7) {
    if (!isdefined(var_13f9dee7) || var_13f9dee7 == "") {
        self clientfield::set("" + #"hash_66b8b96e588ce1ac", 0);
        return;
    }
    switch (var_13f9dee7) {
    case #"none":
        self clientfield::set("" + #"hash_66b8b96e588ce1ac", 1);
        break;
    case #"resource":
        self clientfield::set("" + #"hash_66b8b96e588ce1ac", 2);
        break;
    case #"uncommon":
        self clientfield::set("" + #"hash_66b8b96e588ce1ac", 3);
        break;
    case #"rare":
        self clientfield::set("" + #"hash_66b8b96e588ce1ac", 4);
        break;
    case #"epic":
        self clientfield::set("" + #"hash_66b8b96e588ce1ac", 5);
        break;
    case #"legendary":
        self clientfield::set("" + #"hash_66b8b96e588ce1ac", 6);
        break;
    case #"ultra":
        self clientfield::set("" + #"hash_66b8b96e588ce1ac", 7);
        break;
    default:
        self clientfield::set("" + #"hash_66b8b96e588ce1ac", 0);
        break;
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0xa8dc0f15, Offset: 0x7d60
// Size: 0xf4
function timer_til_despawn(v_float) {
    self endon(#"kill_weapon_movement");
    if (#"hash_30b0badbca0a10de" === self.model) {
        self.angles = (self.angles[0] + 90, self.angles[1], self.angles[2]);
    }
    var_3be81b3b = isdefined(level.var_ad2674fe) ? level.var_ad2674fe : 12;
    self moveto(self.origin - v_float * 0.85, var_3be81b3b, var_3be81b3b * 0.5);
    wait var_3be81b3b;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x1537e7ed, Offset: 0x7e60
// Size: 0x14c
function treasure_chest_glowfx() {
    self endoncallback(&function_62197845, #"death");
    self clientfield::set("magicbox_open_fx", 1);
    self clientfield::set("magicbox_closed_fx", 0);
    self waittill(#"randomization_done");
    self function_a6d171f4(self.owner.var_c639ca3e);
    self clientfield::set("magicbox_open_fx", 0);
    s_waitresult = self waittill(#"weapon_grabbed", #"box_moving");
    if (s_waitresult._notify == "weapon_grabbed") {
        self clientfield::set("magicbox_closed_fx", 1);
        self function_a6d171f4();
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 3, eflags: 0x1 linked
// Checksum 0xaf2ebdbc, Offset: 0x7fb8
// Size: 0x72c
function treasure_chest_give_weapon(item, var_75c86f89, e_chest) {
    self.last_box_weapon = gettime();
    weapon = isdefined(item.var_627c698b) ? item.var_627c698b : level.weaponnone;
    if (should_upgrade_weapon(self, weapon)) {
        if (self zm_weapons::can_upgrade_weapon(weapon)) {
            weapon = zm_weapons::get_upgrade_weapon(weapon);
            self notify(#"zm_bgb_crate_power_used");
        }
    }
    if (weapon.name == #"ray_gun" || weapon.name == #"ray_gun_mk2") {
        playsoundatposition(#"mus_raygun_stinger", (0, 0, 0));
        str_vo_line = #"raygun";
        if (weapon.name == #"ray_gun_mk2" && zm_audio::function_63f85f39(#"magicbox", #"raygun_mk2")) {
            str_vo_line = #"raygun_mk2";
        }
    } else if (zm_weapons::is_wonder_weapon(weapon)) {
        str_vo_line = #"wonder";
        if (isplayer(var_75c86f89) && var_75c86f89 != self) {
            var_75c86f89 zm_utility::function_659819fa(#"zm_trophy_straw_purchase");
        }
    } else if (weapon === getweapon(#"homunculus") || weapon === getweapon(#"cymbal_monkey")) {
        str_vo_line = #"homunculus";
    } else if (weapon === getweapon(#"special_ballisticknife_t8_dw")) {
        if (zm_audio::function_63f85f39(#"magicbox", #"ballistic")) {
            str_vo_line = #"ballistic";
        }
    } else {
        switch (weapon.weapclass) {
        case #"mg":
            str_vo_line = #"lmg";
            break;
        case #"spread":
            str_vo_line = #"shotgun";
            break;
        case #"pistol":
            str_vo_line = #"pistol";
            break;
        case #"rocketlauncher":
            str_vo_line = #"launcher";
            break;
        case #"smg":
            str_vo_line = #"smg";
            break;
        case #"rifle":
            if (weapon.issniperweapon) {
                str_vo_line = #"sniper";
            } else if (zm_weapons::is_tactical_rifle(weapon)) {
                str_vo_line = #"tactical";
            } else {
                str_vo_line = #"ar";
            }
            break;
        default:
            break;
        }
    }
    if (isdefined(str_vo_line)) {
        if (str_vo_line == #"homunculus") {
            self thread function_e62595c2(e_chest);
        } else {
            self thread zm_audio::create_and_play_dialog(#"magicbox", str_vo_line);
        }
    }
    if (zm_loadout::is_hero_weapon(weapon) && !self hasweapon(weapon)) {
        self give_hero_weapon(weapon);
    } else if (zm_loadout::is_offhand_weapon(weapon)) {
        self give_offhand_weapon(weapon, e_chest.owner.var_9e7e27d7);
    } else {
        self.var_966bfd1b = 1;
        if (item.var_a6762160.itemtype === #"scorestreak" || item.var_a6762160.itemtype === #"equipment" || item.var_a6762160.itemtype === #"tactical") {
            var_fa3df96 = self item_inventory::function_e66dcff5(item);
            if (isdefined(var_fa3df96)) {
                if (!item_world_util::function_db35e94f(item.networkid)) {
                    item.networkid = item_world_util::function_970b8d86(var_fa3df96);
                }
                item.hidetime = 0;
                if (self.inventory.items[var_fa3df96].networkid != 32767 && self.inventory.items[var_fa3df96].var_a6762160.name != item.var_a6762160.name) {
                    self item_inventory::function_fba40e6c(item);
                } else {
                    item_world::function_de2018e3(item, self, var_fa3df96);
                }
            }
        } else {
            self zm_weapons::function_98776900(item, 0, 0);
        }
    }
    self contracts::increment_zm_contract(#"contract_zm_magicbox", 1, #"zstandard");
    self callback::callback(#"hash_7d40e25056b9275c", weapon);
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x5 linked
// Checksum 0xa876323d, Offset: 0x86f0
// Size: 0xb4
function private function_e62595c2(e_chest) {
    e_chest zm_vo::vo_stop();
    b_said = zm_vo::vo_say(#"hash_6364370b57ccf050" + zm_vo::function_82f9bc9f() + "_homu");
    if (is_true(b_said)) {
        wait 1;
    }
    zm_audio::create_and_play_dialog(#"magicbox", #"homunculus");
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x9dad5a0e, Offset: 0x87b0
// Size: 0x3c
function give_hero_weapon(weapon) {
    self zm_hero_weapon::hero_give_weapon(weapon, 0);
    self zm_hero_weapon::function_23978edd();
}

// Namespace zm_magicbox/zm_magicbox
// Params 2, eflags: 0x1 linked
// Checksum 0x132120cd, Offset: 0x87f8
// Size: 0x1ec
function give_offhand_weapon(*weapon, var_e05f8872) {
    if (isdefined(var_e05f8872)) {
        for (i = 0; i < 5; i++) {
            point = function_4ba8fde(var_e05f8872);
            if (isdefined(point) && isdefined(point.var_a6762160)) {
                dropitem = self item_drop::drop_item(i, point.var_a6762160.weapon, 1, point.var_a6762160.amount, point.id, self.origin, self.angles);
                if (isdefined(dropitem)) {
                    var_641d3dc2 = dropitem.var_a6762160.itemtype != #"attachment";
                    var_a6762160 = dropitem.var_a6762160;
                    var_1035544d = self item_world::pickup_item(dropitem, var_641d3dc2);
                    if (is_true(var_1035544d)) {
                        if (isdefined(var_a6762160)) {
                            inventoryitem = self item_inventory::function_8babc9f9(var_a6762160);
                        }
                        if (isdefined(inventoryitem)) {
                            self item_inventory::equip_equipment(inventoryitem);
                        }
                        continue;
                    }
                    self item_inventory::function_fba40e6c(dropitem);
                }
            }
        }
    }
    self zm_audio::create_and_play_dialog(#"magicbox", #"offhand");
}

// Namespace zm_magicbox/zm_magicbox
// Params 2, eflags: 0x1 linked
// Checksum 0x541b2bd3, Offset: 0x89f0
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
// Params 1, eflags: 0x1 linked
// Checksum 0xf17213ff, Offset: 0x8a60
// Size: 0x244
function magic_box_do_weapon_rise(var_f91a62a4) {
    self endoncallback(&function_62197845, #"box_hacked_respin", #"death");
    self setzbarrierpiecestate(3, "closed");
    self setzbarrierpiecestate(4, "closed");
    util::wait_network_frame();
    self zbarrierpieceuseboxriselogic(3);
    self zbarrierpieceuseboxriselogic(4);
    self showzbarrierpiece(3);
    self showzbarrierpiece(4);
    self setzbarrierpiecestate(3, "opening", var_f91a62a4);
    self setzbarrierpiecestate(4, "opening", var_f91a62a4);
    if (var_f91a62a4 != 1) {
        self playsound(#"hash_59a4ec7cb3de7d13");
        self waittill(#"randomization_done");
        self setzbarrierpiecestate(3, "open");
        self setzbarrierpiecestate(4, "open");
    } else {
        self playsound(#"hash_1530a7e6184b9b2e");
        while (self getzbarrierpiecestate(3) != "open") {
            wait 0.5;
        }
    }
    self hidezbarrierpiece(3);
    self hidezbarrierpiece(4);
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x715d5d22, Offset: 0x8cb0
// Size: 0xd0
function function_15cd8d85() {
    self endoncallback(&function_62197845, #"death", #"zbarrier_state_change");
    self setzbarrierpiecestate(0, "closed");
    while (true) {
        wait randomfloatrange(180, 1800);
        self setzbarrierpiecestate(0, "opening");
        wait randomfloatrange(180, 1800);
        self setzbarrierpiecestate(0, "closing");
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0xa26a59ed, Offset: 0x8d88
// Size: 0x44
function function_f6a827d1() {
    self setzbarrierpiecestate(1, "opening");
    self clientfield::set("magicbox_closed_fx", 1);
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0xb38adee2, Offset: 0x8dd8
// Size: 0x84
function magic_box_zbarrier_leave() {
    self endoncallback(&function_62197845, #"death");
    self set_magic_box_zbarrier_state("leaving");
    self waittill(#"left", #"timeout_away");
    self set_magic_box_zbarrier_state("away");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x56cae0d8, Offset: 0x8e68
// Size: 0xa6
function function_24ce1c91() {
    self endoncallback(&function_62197845, #"death");
    self clientfield::increment("zbarrier_arriving_sounds");
    self setzbarrierpiecestate(1, "opening");
    while (self getzbarrierpiecestate(1) == "opening") {
        waitframe(1);
    }
    self notify(#"arrived");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x56e52edf, Offset: 0x8f18
// Size: 0xa6
function function_65b1adcb() {
    self endoncallback(&function_62197845, #"death");
    self clientfield::increment("zbarrier_leaving_sounds");
    self setzbarrierpiecestate(1, "closing");
    while (self getzbarrierpiecestate(1) == "closing") {
        wait 0.1;
    }
    self notify(#"left");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x5dc61491, Offset: 0x8fc8
// Size: 0x8e
function function_12804472() {
    self endoncallback(&function_62197845, #"death");
    self setzbarrierpiecestate(2, "opening");
    while (self getzbarrierpiecestate(2) == "opening") {
        wait 0.1;
    }
    self notify(#"opened");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x829a85f5, Offset: 0x9060
// Size: 0x8e
function function_cd5d65b0() {
    self endoncallback(&function_62197845, #"death");
    self setzbarrierpiecestate(2, "closing");
    while (self getzbarrierpiecestate(2) == "closing") {
        wait 0.1;
    }
    self notify(#"closed");
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x81aa679f, Offset: 0x90f8
// Size: 0xa
function get_magic_box_zbarrier_state() {
    return self.state;
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0xe61217d3, Offset: 0x9110
// Size: 0x7c
function set_magic_box_zbarrier_state(state) {
    for (i = 0; i < self getnumzbarrierpieces(); i++) {
        self hidezbarrierpiece(i);
    }
    self notify(#"zbarrier_state_change");
    self [[ level.magic_box_zbarrier_state_func ]](state);
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x83d85d5d, Offset: 0x9198
// Size: 0x232
function process_magic_box_zbarrier_state(state) {
    switch (state) {
    case #"away":
        self showzbarrierpiece(0);
        self thread function_15cd8d85();
        self.state = "away";
        break;
    case #"arriving":
        self showzbarrierpiece(1);
        self thread function_24ce1c91();
        self.state = "arriving";
        break;
    case #"initial":
        self showzbarrierpiece(1);
        self thread function_f6a827d1();
        self.state = "initial";
        break;
    case #"open":
        self showzbarrierpiece(2);
        self thread function_12804472();
        self.state = "open";
        break;
    case #"close":
        self showzbarrierpiece(2);
        self thread function_cd5d65b0();
        self.state = "close";
        break;
    case #"leaving":
        self showzbarrierpiece(1);
        self thread function_65b1adcb();
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
// Params 0, eflags: 0x1 linked
// Checksum 0xd7de481c, Offset: 0x93d8
// Size: 0x16c
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
            if (!is_true(chest.hidden)) {
                if (isdefined(chest) && isdefined(chest.pandora_light)) {
                    playfxontag(level._effect[#"lght_marker"], chest.pandora_light, "tag_origin");
                }
            }
            util::wait_network_frame();
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x95d4054, Offset: 0x9550
// Size: 0x90
function function_7d384b90() {
    foreach (s_chest in level.chests) {
        level thread function_d81704a5(s_chest);
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x1f288595, Offset: 0x95e8
// Size: 0x3e
function function_d81704a5(s_chest) {
    while (is_true(s_chest._box_open)) {
        waitframe(1);
    }
    s_chest.var_dd0d4460 = 1;
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0xa99e0205, Offset: 0x9630
// Size: 0x4c
function function_338c302b() {
    level endon(#"game_ended");
    while (true) {
        level waittill(#"start_of_round");
        level.var_40f4f72d = 0;
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x9688
// Size: 0x4
function magicbox_unitrigger_think() {
    
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xcea65d1b, Offset: 0x9698
// Size: 0x14
function function_35c66b27() {
    process_magic_box_zbarrier_state();
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x96b8
// Size: 0x4
function function_f5503c41() {
    
}

