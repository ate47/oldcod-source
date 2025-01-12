#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\zm_zodt8;
#using scripts\zm\zm_zodt8_pap_quest;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb_pack;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_items;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_zodt8_tutorial;

// Namespace zm_zodt8_tutorial/level_init
// Params 1, eflags: 0x40
// Checksum 0x5eace1ca, Offset: 0x1cf8
// Size: 0x354
function event_handler[level_init] main(eventstruct) {
    if (util::get_game_type() != "ztutorial") {
        return;
    }
    setgametypesetting(#"zmtalismansenabled", 0);
    level.var_7200d8ac = array();
    level.var_82f400d0 = array();
    level.weaponbasemelee = getweapon(#"knife");
    clientfield::register("actor", "tutorial_keyline_fx", 1, 2, "int");
    clientfield::register("zbarrier", "tutorial_keyline_fx", 1, 2, "int");
    clientfield::register("item", "tutorial_keyline_fx", 1, 2, "int");
    clientfield::register("scriptmover", "tutorial_keyline_fx", 1, 2, "int");
    clientfield::register("scriptmover", "" + #"hash_1b509b0ba634a25a", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_1390e08de02cbdc7", 1, 1, "int");
    clientfield::register("worlduimodel", "hudItems.ztut.showLocation", 1, 1, "int");
    clientfield::register("worlduimodel", "hudItems.ztut.showPerks", 1, 1, "int");
    clientfield::register("worlduimodel", "hudItems.ztut.showEquipment", 1, 1, "int");
    clientfield::register("worlduimodel", "hudItems.ztut.showShield", 1, 1, "int");
    clientfield::register("worlduimodel", "hudItems.ztut.showSpecial", 1, 1, "int");
    clientfield::register("worlduimodel", "hudItems.ztut.showElixirs", 1, 1, "int");
    callback::on_spawned(&on_player_spawned);
    init_level_vars();
    level thread tutorial();
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x3020c898, Offset: 0x2058
// Size: 0x1c4
function init_level_vars() {
    function_6ef513ea();
    level flag::init("tutorial_reset");
    level flag::init("tutorial_intro_screen_over");
    level.fn_custom_round_ai_spawn = undefined;
    level.var_c39b7fc1 = 1;
    level.var_ec8913c8 = -1;
    level.var_7b92db95 = &function_5ebfa6b7;
    level.var_805d0ecc = &function_1d194b3;
    level.var_acbbfe4f = &function_290ba8ca;
    level.player_death_override = &tutorial_reset;
    level.zm_bgb_anywhere_but_here_validation_override = &function_7eb6d7a6;
    level.var_2c12d9a6 = &function_3e0d5673;
    level.player_out_of_playable_area_override = &function_488dc57e;
    level.var_dae44d7d = &function_23d761a6;
    level._supress_survived_screen = 1;
    level.disablescoreevents = 1;
    level.zm_disable_recording_stats = 1;
    zm_transform::function_17652056(getentarray("zombie_spawner_catalyst_plasma", "targetname")[0], "catalyst_plasma_tutorial", undefined, 5, undefined, undefined, "aib_vign_zm_zod_catalyst_plasma_spawn_pre_split_tutorial", "aib_vign_zm_zod_catalyst_plasma_spawn_post_split_tutorial");
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xafc86046, Offset: 0x2228
// Size: 0x6
function function_488dc57e() {
    return false;
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x893a9705, Offset: 0x2238
// Size: 0xe2
function function_23d761a6() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] setclientuivisibilityflag("weapon_hud_visible", 0);
        players[i] setclientminiscoreboardhide(1);
        players[i] notify(#"report_bgb_consumption");
        players[i] notify(#"hide_equipment_hint_text");
    }
    wait 0.5;
    exitlevel(0);
    wait 666;
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0xea860148, Offset: 0x2328
// Size: 0x10
function function_1d194b3(drop_point) {
    return true;
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0xc51bc389, Offset: 0x2340
// Size: 0xce
function function_290ba8ca(a_items) {
    var_396b7f83 = getent("tutorial_forced_shield_part", "targetname");
    assert(isdefined(var_396b7f83));
    for (i = 0; i < a_items.size; i++) {
        if (a_items[i] == var_396b7f83) {
            temp = a_items[0];
            a_items[0] = a_items[i];
            a_items[i] = temp;
            break;
        }
    }
    return a_items;
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x6ecfaf9c, Offset: 0x2418
// Size: 0x54
function freeze_player_controls() {
    self val::set("tutorial_reset", "freezecontrols", 1);
    self val::set("tutorial_reset", "disable_weapons", 1);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xaaeea15e, Offset: 0x2478
// Size: 0x54
function function_d626232c() {
    self val::reset("tutorial_reset", "freezecontrols");
    self val::reset("tutorial_reset", "disable_weapons");
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x6de17c1f, Offset: 0x24d8
// Size: 0x11e
function function_9c7587fd() {
    foreach (zombie in level.var_7200d8ac) {
        if (isdefined(zombie)) {
            zombie delete();
        }
    }
    level.var_7200d8ac = [];
    foreach (zombie in level.var_82f400d0) {
        if (isdefined(zombie)) {
            zombie delete();
        }
    }
    level.var_82f400d0 = [];
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xe74c3c36, Offset: 0x2600
// Size: 0x2b8
function tutorial_reset() {
    if (isbot(self)) {
        return false;
    }
    if (level flag::get("tutorial_reset")) {
        return true;
    }
    level notify(#"tutorial_reset");
    level flag::set("tutorial_reset");
    self freeze_player_controls();
    self lui::screen_fade_out(0.5, "white");
    if (self.health <= 50 && !isdefined(self.var_a21db7db)) {
        level thread function_179be094("vox_narr_beginner_downed_0");
        self.var_a21db7db = 1;
    }
    self.health = self.maxhealth;
    a_w_primary = self getweaponslistprimaries();
    foreach (w_primary in a_w_primary) {
        self setweaponammoclip(w_primary, w_primary.clipsize);
        self givemaxammo(w_primary);
    }
    if (isdefined(self.reset_score)) {
        self function_dcf5d4e5(self.reset_score);
    }
    function_9c7587fd();
    if (isdefined(level.tutorial_reset)) {
        self [[ level.tutorial_reset ]]();
    }
    wait 0.5;
    self lui::screen_fade_in(0.5, "white");
    self function_d626232c();
    self setstance("stand");
    level flag::clear("tutorial_reset");
    return true;
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xe89cb33c, Offset: 0x28c0
// Size: 0x5a
function function_7eb6d7a6() {
    node = getnode("tutorial_elixers", "targetname");
    return isdefined(node) && isdefined(node.origin) && isdefined(node.angles);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xba0e226e, Offset: 0x2928
// Size: 0x3a
function function_3e0d5673() {
    level notify(#"tutorial_used_anywhere_but_here");
    return getnode("tutorial_elixers", "targetname");
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0x38bf6568, Offset: 0x2970
// Size: 0x5c
function function_fd73337(toggle) {
    if (isdefined(toggle) && toggle) {
        level flag::set("spawn_zombies");
        return;
    }
    level flag::clear("spawn_zombies");
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x9ccf4a54, Offset: 0x29d8
// Size: 0x52
function function_6ef513ea() {
    var_277eb774 = "grand_stair_lower_chest";
    level.random_pandora_box_start = 0;
    level.start_chest_name = var_277eb774;
    level.open_chest_location = [];
    level.open_chest_location[0] = var_277eb774;
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x32ebaa89, Offset: 0x2a38
// Size: 0x1e6
function on_player_spawned() {
    if (isbot(self)) {
        assert(!isdefined(level.tutorialbot));
        level.tutorialbot = self;
        self endon(#"disconnect");
        self zm_laststand::function_7996dd34(0);
        self ai::set_behavior_attribute("control", "autonomous");
        self zm_audio::function_7fc61e0e();
        self waittill(#"death");
        level.tutorialbot = undefined;
        return;
    }
    if (isplayer(self)) {
        assert(!isdefined(level.tutorialplayer));
        level.tutorialplayer = self;
        self endon(#"disconnect");
        self zm_laststand::function_7996dd34(0);
        self bgb_pack::function_7dc4cba2(0, 1);
        self bgb_pack::function_7dc4cba2(1, 1);
        self bgb_pack::function_7dc4cba2(3, 1);
        self thread function_46b8c07a();
        self waittill(#"death");
        level.tutorialplayer = undefined;
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xe279cbfd, Offset: 0x2c28
// Size: 0x156
function function_46b8c07a() {
    self endon(#"death");
    while (true) {
        var_107240b5 = 0;
        a_w_primary = self getweaponslistprimaries();
        foreach (w_primary in a_w_primary) {
            if (self getweaponammostock(w_primary) > 0 || self getweaponammoclip(w_primary) > 0) {
                var_107240b5 = 1;
            }
        }
        if (isdefined(var_107240b5) && !var_107240b5) {
            if (!isdefined(self.var_8d676a23)) {
                level thread function_179be094("vox_narr_beginner_ammo_out_0");
                self.var_8d676a23 = 1;
            }
            tutorial_reset();
        }
        waitframe(1);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0xbddb6001, Offset: 0x2d88
// Size: 0xcc
function open_door(str_door_name) {
    a_e_zombie_doors = getentarray(str_door_name, "target");
    foreach (zombie_door in a_e_zombie_doors) {
        zombie_door notify(#"trigger", {#activator:zombie_door, #is_forced:1});
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0x33cac2ec, Offset: 0x2e60
// Size: 0x74
function function_650064bc(targetname) {
    node = getnode(targetname, "targetname");
    self setorigin(node.origin);
    self setplayerangles(node.angles);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0xd00f421f, Offset: 0x2ee0
// Size: 0x124
function function_f8dd2ace(num) {
    if (num == 0) {
        clientfield::set_world_uimodel("hudItems.ztut.showLocation", 1);
        return;
    }
    if (num == 1) {
        clientfield::set_world_uimodel("hudItems.ztut.showPerks", 1);
        return;
    }
    if (num == 2) {
        clientfield::set_world_uimodel("hudItems.ztut.showEquipment", 1);
        return;
    }
    if (num == 3) {
        clientfield::set_world_uimodel("hudItems.ztut.showShield", 1);
        return;
    }
    if (num == 4) {
        clientfield::set_world_uimodel("hudItems.ztut.showSpecial", 1);
        return;
    }
    if (num == 5) {
        clientfield::set_world_uimodel("hudItems.ztut.showElixirs", 1);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0xfa28cda2, Offset: 0x3010
// Size: 0x1a
function function_15ec65a(reset) {
    level.tutorial_reset = reset;
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xe57fde9f, Offset: 0x3038
// Size: 0x1c
function function_e7d4a54b() {
    function_15ec65a(undefined);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xfd3b8f29, Offset: 0x3060
// Size: 0x76
function function_49a5e5c8() {
    waitframe(3);
    s_spawn_pos = self.s_spawn_pos;
    self forceteleport(s_spawn_pos.origin, s_spawn_pos.angles);
    self notify(#"risen", {#find_flesh_struct_string:self.script_string});
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 3, eflags: 0x0
// Checksum 0x63a8ebd4, Offset: 0x30e0
// Size: 0x578
function function_30c9f3e1(spawnerstr, ignore = 0, bot = undefined) {
    level endon(#"tutorial_reset");
    s_spawn_pos = struct::get(spawnerstr, "targetname");
    a_spawners = getentarray("spawner_zm_zombie", "targetname");
    spawner = a_spawners[randomint(a_spawners.size)];
    zombie = zombie_utility::spawn_zombie(spawner);
    zombie.s_spawn_pos = s_spawn_pos;
    zombie.script_string = "find_flesh";
    zombie.custom_location = &function_49a5e5c8;
    zombie.b_ignore_cleanup = 1;
    foreach (str in array("tutorial_zm_spawner_barrier")) {
        if (str == spawnerstr) {
            foreach (exterior_goal in level.exterior_goals) {
                if (distancesquared(s_spawn_pos.origin, exterior_goal.origin) < 100 * 100) {
                    zombie.script_string = exterior_goal.script_string;
                    break;
                }
            }
        }
    }
    if (isdefined(zombie)) {
        if (ignore) {
            if (!isdefined(level.var_82f400d0)) {
                level.var_82f400d0 = [];
            } else if (!isarray(level.var_82f400d0)) {
                level.var_82f400d0 = array(level.var_82f400d0);
            }
            level.var_82f400d0[level.var_82f400d0.size] = zombie;
            array::remove_undefined(level.var_82f400d0);
        } else {
            if (!isdefined(level.var_7200d8ac)) {
                level.var_7200d8ac = [];
            } else if (!isarray(level.var_7200d8ac)) {
                level.var_7200d8ac = array(level.var_7200d8ac);
            }
            level.var_7200d8ac[level.var_7200d8ac.size] = zombie;
            array::remove_undefined(level.var_7200d8ac);
        }
        zombie.favoriteenemy = level.tutorialplayer;
        if (spawnerstr == "tutorial_catalyst_spawner") {
            zombie setcandamage(0);
            zombie.var_b7fcaf8e = 0;
            wait 1;
            zm_transform::function_3b866d7e(zombie, "catalyst_plasma_tutorial");
            level endon(#"transformation_interrupted");
            eventstruct = level waittill(#"transformation_complete");
            zombie = eventstruct.new_ai[0];
        }
        if (isdefined(bot)) {
            assert(isbot(bot));
            bot setentitytarget(zombie);
        }
    }
    level notify(#"hash_1de610a8af6a216f", {#new_zombie:zombie});
    if (s_spawn_pos.targetname == "tutorial_zm_spawner_points_3" || s_spawn_pos.targetname == "tutorial_zm_spawner_points_4") {
        a_s_spot = struct::get_array("zone_state_rooms_rear_spawns", "targetname");
        arraysortclosest(a_s_spot, zombie.origin);
        zombie thread zm_spawner::function_48cfc7df(a_s_spot[0]);
    }
    return zombie;
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0x38ab76e4, Offset: 0x3660
// Size: 0xae
function function_774c1edc(var_75e37b61) {
    level endon(#"tutorial_reset");
    foreach (spawnerstr in var_75e37b61) {
        if (spawnerstr == "tutorial_zm_spawner_points_4") {
            wait 3;
        }
        function_30c9f3e1(spawnerstr);
        waitframe(3);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xf3413bbf, Offset: 0x3718
// Size: 0x5e
function function_490844cd() {
    while (level.var_7200d8ac.size > 0 || level flag::get("tutorial_reset")) {
        function_526005d6(level.var_7200d8ac);
        waitframe(1);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 2, eflags: 0x0
// Checksum 0xb79cfc46, Offset: 0x3780
// Size: 0x9c
function waittill_trigger(trig_name, activator = undefined) {
    trig = getent(trig_name, "targetname");
    while (true) {
        eventstruct = trig waittill(#"trigger");
        if (!isdefined(activator) || activator == eventstruct.activator) {
            break;
        }
        waitframe(1);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0xa0fa4f2b, Offset: 0x3828
// Size: 0x6c
function function_dcf5d4e5(points) {
    if (self.score < points) {
        self zm_score::add_to_player_score(points - self.score);
        return;
    }
    if (self.score > points) {
        self zm_score::minus_to_player_score(self.score - points);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0x6bc1286a, Offset: 0x38a0
// Size: 0x64
function function_aefc64(weaponname) {
    weapon = getweapon(weaponname);
    assert(isdefined(weapon));
    self giveweapon(weapon);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0xac31566c, Offset: 0x3910
// Size: 0x54
function set_bot_goal(nodename) {
    node = getnode(nodename, "targetname");
    self setgoal(node, 1);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0x77ec770e, Offset: 0x3970
// Size: 0x54
function set_character(n_char) {
    self.characterindex = n_char;
    if (isdefined(level.givecustomcharacters)) {
        self [[ level.givecustomcharacters ]]();
        self player_role::set(n_char);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x9488b8fb, Offset: 0x39d0
// Size: 0x324
function function_5e84708b() {
    self.dontspeak = 1;
    self zm_laststand::function_7996dd34(0);
    self set_character(zm_characters::get_character_index(array(#"hash_7180c6cf382f6010", #"hash_14e91ceb9a7b3eb6")));
    self.var_871d24d3[0] = #"specialty_staminup";
    self.var_871d24d3[1] = #"specialty_extraammo";
    self.var_871d24d3[2] = #"specialty_cooldown";
    self.var_871d24d3[3] = #"specialty_deadshot";
    self.var_59353358[0] = 0;
    self.var_59353358[1] = 0;
    self.var_59353358[2] = 0;
    self.var_59353358[3] = 0;
    self zm_perks::function_4a5cdd0d(0, level._custom_perks[#"specialty_staminup"].alias);
    self zm_perks::function_4a5cdd0d(1, level._custom_perks[#"specialty_extraammo"].alias);
    self zm_perks::function_4a5cdd0d(2, level._custom_perks[#"specialty_cooldown"].alias);
    self zm_perks::function_4a5cdd0d(3, level._custom_perks[#"specialty_deadshot"].alias);
    self.bgb_pack[0] = "zm_bgb_arsenal_accelerator";
    self.bgb_pack[1] = "zm_bgb_danger_closest";
    self.bgb_pack[2] = "zm_bgb_anywhere_but_here";
    self.bgb_pack[3] = "zm_bgb_always_done_swiftly";
    for (i = 0; i < 4; i++) {
        if (isdefined(self.bgb_pack[i]) && isdefined(level.bgb[self.bgb_pack[i]])) {
            self bgb_pack::function_4805408e(i, level.bgb[self.bgb_pack[i]].item_index);
        }
    }
    self freeze_player_controls();
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x7212786b, Offset: 0x3d00
// Size: 0x288
function tutorial() {
    level endon(#"end_game");
    waitframe(1);
    level.var_491f7949 = &function_6ba592a6;
    level.var_d2cc48b6 = spawn("script_origin", (0, 0, 0));
    function_fd73337(0);
    level.player_out_of_playable_area_monitor = 0;
    level flag::wait_till("initial_players_connected");
    level.tutorialplayer function_5e84708b();
    zombie_utility::set_zombie_var(#"zombie_use_failsafe", 0);
    level flag::set(#"disable_fast_travel");
    function_9a9ad929();
    if (level.gamedifficulty > 1) {
        level.gamedifficulty = 1;
    }
    level thread function_6503443d(level.gamedifficulty);
    open_door("engine_room_door");
    level function_f8dd2ace(0);
    level flag::wait_till("start_zombie_round_logic");
    switch (level.gamedifficulty) {
    case 0:
        level.tutorialplayer function_408e85b0();
    case 1:
        level.tutorialplayer function_c7576fc7();
        break;
    }
    level.tutorialplayer function_319b02e(0);
    self thread lui::screen_fade_out(3);
    wait 1;
    function_6cfecc66(array("vox_narr_advance_blight_kill_0", "vox_narr_advance_end_0"), "vo_end");
    level notify(#"end_game");
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xbcaf8a5c, Offset: 0x3f90
// Size: 0x24
function function_5ebfa6b7() {
    level flag::wait_till("tutorial_intro_screen_over");
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x6dc4e124, Offset: 0x3fc0
// Size: 0xa
function function_6ba592a6() {
    wait 1;
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0xeab0c50d, Offset: 0x3fd8
// Size: 0x224
function function_6503443d(n_difficulty) {
    wait 2;
    if (n_difficulty == 0) {
        exploder::exploder("exp_lgt_start_iceberg_spotlights");
        exploder::exploder("exp_lgt_forecastle_gamplay");
        exploder::exploder("exp_lgt_forecastle_pre_clean");
        util::delay("smokestack01", undefined, &scene::play, "p8_fxanim_zm_zod_smokestack_01_bundle", "Shot 1");
        util::delay("smokestack02", undefined, &scene::play, "p8_fxanim_zm_zod_smokestack_02_bundle", "Shot 1");
        util::delay("wire_snaps", undefined, &scene::play, "p8_fxanim_zm_zod_smokestack_wire_snap_bundle");
        level thread scene::play("p8_fxanim_zm_zod_iceberg_bundle", "iceberg_impact");
        level thread scene::play("p8_fxanim_zm_zod_skybox_bundle", "impact");
    } else if (n_difficulty == 1) {
        level thread scene::play("p8_fxanim_zm_zod_smokestack_01_bundle", "Shot 1");
        level thread scene::play("p8_fxanim_zm_zod_smokestack_02_bundle", "Shot 1");
        level thread scene::play("p8_fxanim_zm_zod_smokestack_wire_snap_bundle", "Shot 1");
        level thread scene::play_from_time("p8_fxanim_zm_zod_iceberg_bundle", "iceberg_impact", undefined, 0.5);
    }
    level thread zm_zodt8::change_water_height_fore(1);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x914b6a56, Offset: 0x4208
// Size: 0x244
function function_408e85b0() {
    self set_character(zm_characters::get_character_index(array(#"hash_f531a8c2df891cc", #"hash_26072a3b34719d22")));
    self function_650064bc("tutorial_beginner_start");
    self takeallweapons();
    self function_aefc64("pistol_topbreak_t8");
    self giveweapon(level.weaponbasemelee);
    self function_dcf5d4e5(2500);
    self freeze_player_controls();
    self thread function_f00701e8();
    self function_893d751f();
    self function_e99ae54b();
    self wallbuy();
    self points();
    self doorbuy();
    self rounds();
    self function_bf611d86();
    self magicbox();
    self function_76637ffa();
    function_bd7e60bb(3);
    level thread zm_audio::function_a08f940c();
    wait 3;
    self lui::screen_fade_out(5);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x76bdf315, Offset: 0x4458
// Size: 0x162
function function_f00701e8() {
    m_door = getent("tutorial_door", "targetname");
    m_clip = getent("tutorial_door_clip", "targetname");
    m_door linkto(m_clip);
    m_door setcandamage(1);
    m_door.health = 10000;
    do {
        s_notify = m_door waittill(#"damage");
        m_door.health = 10000;
    } while (s_notify.mod != "MOD_MELEE");
    self playrumbleonentity("damage_light");
    earthquake(0.2, 0.4, self.origin, 500);
    m_clip rotateyaw(97, 1, 0, 0.5);
    level.var_ab61aef4 = 1;
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xaf6802b5, Offset: 0x45c8
// Size: 0x6c
function function_5dc5c133() {
    self function_650064bc("tutorial_beginner_start");
    self function_774c1edc(array("tutorial_zm_spawner_shoot_zombie"));
    level.var_7200d8ac[0] thread function_b1200496(self);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0xcaafa8ae, Offset: 0x4640
// Size: 0xa0
function function_b1200496(e_player) {
    eventstruct = self waittill(#"death");
    if (!isdefined(eventstruct) || !isdefined(eventstruct.weapon)) {
        return;
    }
    if (isdefined(eventstruct.mod) && eventstruct.mod != "MOD_PISTOL_BULLET") {
        e_player thread tutorial_reset();
        return;
    }
    level notify(#"zombie_shot");
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x6fe8f5d1, Offset: 0x46e8
// Size: 0x2d4
function function_893d751f() {
    function_d23a7dd0("blocker_shoot_zombie");
    self.reset_score = self.score;
    function_b70c01cd();
    function_15ec65a(&function_5dc5c133);
    function_179be094("vox_narr_beginner_start_0");
    self function_774c1edc(array("tutorial_zm_spawner_shoot_zombie"));
    level.var_7200d8ac[0] thread function_b1200496(self);
    self function_d626232c();
    level flag::set("tutorial_intro_screen_over");
    level thread function_179be094("vox_narr_beginner_start_1");
    self thread function_7ea4b365(#"hash_49df76352370f4a6", "shoot_zombie_completed", &function_5f41b7ea);
    self thread function_5f28d5d3("vox_narr_beginner_kill_nag_0", 6, "shoot_zombie_completed");
    level waittill(#"zombie_shot");
    function_e7d4a54b();
    self notify(#"shoot_zombie_completed");
    self notify(#"hash_c366d831c1ff919");
    function_179be094("vox_narr_beginner_kill_first_0", 0.3);
    w_pistol = self getcurrentweapon();
    if (self getweaponammoclip(w_pistol) != self getweaponammoclipsize(w_pistol)) {
        level thread function_179be094("vox_narr_beginner_reload_0", 0.4);
        self thread function_7ea4b365(#"hash_42258c918b04d5f2", "reload_completed");
        self function_f7065f6e();
    }
    function_d23a7dd0("blocker_shoot_zombie", 0);
    function_d23a7dd0("blocker_pre_wall_buy", 1);
    wait 0.5;
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x58596dc6, Offset: 0x49c8
// Size: 0x13e
function function_e99ae54b() {
    level thread function_179be094("vox_narr_beginner_crouch_0", 0.5);
    self thread function_5f28d5d3("vox_narr_beginner_crouch_nag_0", 8, "crouch_completed");
    self thread function_7ea4b365(#"hash_1544925c6fc2b561", "crouch_completed", &function_f898ebab);
    waittill_trigger("tutorial_finish_crouch");
    self notify(#"crouch_completed");
    waitframe(1);
    level thread function_179be094("vox_narr_beginner_sprint_0");
    self thread function_7ea4b365(#"hash_2e816a34f4c828df", "sprint_completed", &function_39d34565);
    waittill_trigger("tutorial_finish_pronesprint");
    self notify(#"sprint_completed");
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xf4556c81, Offset: 0x4b10
// Size: 0x1fc
function wallbuy() {
    mdl_wallbuy = getent("shader_wallbuy", "targetname");
    mdl_wallbuy clientfield::set("tutorial_keyline_fx", 1);
    s_objective = struct::get("objective_pos_wall_buy", "targetname");
    s_objective function_5fdd500f();
    level thread function_179be094("vox_narr_beginner_buy_0");
    self thread function_5f28d5d3("vox_narr_beginner_buy_nag_0", 8, "wallbuy_completed");
    function_9a9ad929(0);
    level waittill(#"weapon_bought");
    s_objective function_5fdd500f(0);
    mdl_wallbuy delete();
    self notify(#"wallbuy_completed");
    function_9a9ad929();
    function_d23a7dd0("blocker_post_wall_buy");
    level thread function_179be094("vox_narr_beginner_switch_0");
    self function_7ea4b365(#"hash_b7646fef6461730", "switch_completed", &function_2ed53260);
    function_179be094("vox_narr_beginner_round_start_0");
    function_d23a7dd0("blocker_pre_wall_buy", 0);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x2209e7d9, Offset: 0x4d18
// Size: 0x64
function points_reset() {
    self function_650064bc("tutorial_points_start");
    self thread function_774c1edc(array("tutorial_zm_spawner_points_1", "tutorial_zm_spawner_points_2", "tutorial_zm_spawner_points_3", "tutorial_zm_spawner_points_4"));
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x29288b25, Offset: 0x4d88
// Size: 0x146
function points() {
    self.reset_score = self.score;
    function_15ec65a(&points_reset);
    self thread function_774c1edc(array("tutorial_zm_spawner_points_1", "tutorial_zm_spawner_points_2", "tutorial_zm_spawner_points_3", "tutorial_zm_spawner_points_4"));
    wait 3;
    level thread function_179be094("vox_narr_beginner_aim_0");
    self thread function_7ea4b365(#"hash_c360659fdde1ca7", "ads_completed", &function_ffdf238d);
    self function_490844cd();
    function_e7d4a54b();
    function_179be094("vox_narr_beginner_kill_all_0", 0.5);
    function_179be094("vox_narr_beginner_points_0", 0.5);
    self notify(#"ads_completed");
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x8ba7a235, Offset: 0x4ed8
// Size: 0x184
function doorbuy() {
    function_179be094("vox_narr_beginner_door_0", 0.3);
    self thread function_5f28d5d3("vox_narr_beginner_door_nag_0", 8, "door_completed");
    function_b70c01cd(0);
    s_objective = struct::get("objective_pos_door_buy", "targetname");
    s_objective function_5fdd500f();
    function_e12ad69e("state_rooms_to_lower_stairs_door", "p8_kit_zod_sta_05_door_28_left_painted_wood_01", 1);
    function_e12ad69e("state_rooms_to_lower_stairs_door", "p8_kit_zod_sta_05_door_28_right_painted_wood_01", 1);
    level waittill(#"door_opened", #"junk purchased");
    self notify(#"door_completed");
    s_objective function_5fdd500f(0);
    function_e12ad69e("state_rooms_to_lower_stairs_door", "p8_kit_zod_sta_05_door_28_left_painted_wood_01", 0);
    function_e12ad69e("state_rooms_to_lower_stairs_door", "p8_kit_zod_sta_05_door_28_right_painted_wood_01", 0);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x6b4eabdd, Offset: 0x5068
// Size: 0x5c
function function_44aa3f4a() {
    self function_650064bc("tutorial_rounds_start");
    self function_774c1edc(array("tutorial_zm_spawner_rounds_1", "tutorial_zm_spawner_rounds_2", "tutorial_zm_spawner_rounds_3"));
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xd86be9be, Offset: 0x50d0
// Size: 0xdc
function rounds() {
    function_d23a7dd0("blocker_pre_repair");
    function_bd7e60bb(2);
    level thread zm_audio::function_3aef57a7();
    level thread function_179be094("vox_narr_beginner_round_expl_0", 0.8);
    self.reset_score = self.score;
    function_15ec65a(&function_44aa3f4a);
    self function_774c1edc(array("tutorial_zm_spawner_rounds_1", "tutorial_zm_spawner_rounds_2", "tutorial_zm_spawner_rounds_3"));
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x2cbca982, Offset: 0x51b8
// Size: 0x4c
function function_28664132() {
    self function_650064bc("tutorial_barrierrepair_start");
    self function_774c1edc(array("tutorial_zm_spawner_barrier"));
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x65fee4fd, Offset: 0x5210
// Size: 0x38c
function function_bf611d86() {
    waittill_trigger("tutorial_start_barrierrepair");
    zm_blockers::open_all_zbarriers();
    self.reset_score = self.score;
    self.is_drinking = 1;
    function_15ec65a(&function_28664132);
    self function_774c1edc(array("tutorial_zm_spawner_barrier"));
    function_179be094("vox_narr_beginner_carp_down_0");
    self function_490844cd();
    self.is_drinking = 0;
    self thread function_179be094("vox_narr_beginner_carp_0", 0.5);
    foreach (s_goal in level.exterior_goals) {
        if (s_goal.script_string == "millionaire_window") {
            s_goal.zbarrier clientfield::set("tutorial_keyline_fx", 1);
        }
    }
    s_objective = struct::get("objective_pos_repair", "targetname");
    s_objective function_5fdd500f();
    self thread function_5f28d5d3("vox_narr_beginner_carp_nag_0", 8, "boarding_window");
    for (var_22050ee = 0; var_22050ee < 6; var_22050ee++) {
        self waittill(#"boarding_window");
    }
    self notify(#"boarding_complete");
    foreach (s_goal in level.exterior_goals) {
        if (s_goal.script_string == "millionaire_window") {
            s_goal.zbarrier clientfield::set("tutorial_keyline_fx", 2);
        }
    }
    s_objective function_5fdd500f(0);
    function_179be094("vox_narr_beginner_carp_points_0");
    function_e7d4a54b();
    function_d23a7dd0("blocker_pre_repair", 0);
    waittill_trigger("tutorial_finish_barrierrepair");
    function_d23a7dd0("blocker_post_repair");
    function_d23a7dd0("blocker_post_wall_buy", 0);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0x68410c14, Offset: 0x55a8
// Size: 0x58
function function_ae49692f(a_keys) {
    a_keys = [];
    forced_weapon = getweapon("smg_drum_pistol_t8");
    arrayinsert(a_keys, forced_weapon, 0);
    return a_keys;
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x579c6c7b, Offset: 0x5608
// Size: 0x26c
function magicbox() {
    self.reset_score = self.score;
    self.is_drinking = 1;
    function_6cfecc66(array("vox_narr_beginner_box_0", "vox_narr_beginner_box_1"), "chest_opened");
    self.is_drinking = 0;
    level.chests[level.chest_index].zbarrier clientfield::set("tutorial_keyline_fx", 1);
    s_objective = struct::get("objective_pos_box", "targetname");
    s_objective function_5fdd500f();
    level.customrandomweaponweights = &function_ae49692f;
    level.chests[level.chest_index].zbarrier waittill(#"opened");
    level.chests[level.chest_index].zbarrier clientfield::set("tutorial_keyline_fx", 2);
    s_objective function_5fdd500f(0);
    while (level.chests[level.chest_index].zbarrier.weapon == level.weaponnone) {
        waitframe(1);
    }
    self notify(#"weapon_settled");
    level thread function_179be094("vox_narr_beginner_box_2");
    level.chests[level.chest_index].zbarrier waittill(#"weapon_grabbed");
    level.customrandomweaponweights = undefined;
    level.var_642d32dc = 1;
    function_179be094("vox_narr_beginner_box_3", 2);
    function_179be094("vox_narr_beginner_box_down_0", 1.2);
    function_179be094("vox_narr_beginner_end_0", 1);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x89d9f6d, Offset: 0x5880
// Size: 0x74
function function_3ec1f896() {
    self function_650064bc("tutorial_playerwilldie_start");
    self function_774c1edc(array("tutorial_zm_spawner_playerwilldie_1", "tutorial_zm_spawner_playerwilldie_2", "tutorial_zm_spawner_playerwilldie_3", "tutorial_zm_spawner_playerwilldie_4", "tutorial_zm_spawner_playerwilldie_5", "tutorial_zm_spawner_playerwilldie_6"));
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x7e5a2811, Offset: 0x5900
// Size: 0x184
function function_76637ffa() {
    self.reset_score = self.score;
    function_15ec65a(&function_3ec1f896);
    self function_774c1edc(array("tutorial_zm_spawner_playerwilldie_1", "tutorial_zm_spawner_playerwilldie_2", "tutorial_zm_spawner_playerwilldie_3", "tutorial_zm_spawner_playerwilldie_4", "tutorial_zm_spawner_playerwilldie_5", "tutorial_zm_spawner_playerwilldie_6"));
    wait 2;
    level thread function_179be094("vox_narr_beginner_end_1");
    if (isdefined(level.var_ab61aef4)) {
        self function_774c1edc(array("tutorial_zm_spawner_playerwilldie_1", "tutorial_zm_spawner_playerwilldie_2", "tutorial_zm_spawner_playerwilldie_3", "tutorial_zm_spawner_playerwilldie_4", "tutorial_zm_spawner_playerwilldie_5", "tutorial_zm_spawner_playerwilldie_6"));
        wait 3;
        self function_774c1edc(array("tutorial_zm_spawner_playerwilldie_1", "tutorial_zm_spawner_playerwilldie_2", "tutorial_zm_spawner_playerwilldie_3", "tutorial_zm_spawner_playerwilldie_4", "tutorial_zm_spawner_playerwilldie_5", "tutorial_zm_spawner_playerwilldie_6"));
    }
    self function_490844cd();
    function_e7d4a54b();
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x3eba4170, Offset: 0x5a90
// Size: 0x6f4
function function_c7576fc7() {
    self set_character(zm_characters::get_character_index(array(#"hash_68255d9ce2a09382", #"hash_1a427f842f175b3c")));
    self function_650064bc("tutorial_intermediate_start");
    var_bdd1a74f = getweapon("zitem_rocketshield_part_2");
    var_97cf2ce6 = getweapon("zitem_rocketshield_part_3");
    self giveweapon(var_bdd1a74f);
    waitframe(1);
    self giveweapon(var_97cf2ce6);
    zm_blockers::open_all_zbarriers();
    self function_dcf5d4e5(2850);
    self takeallweapons();
    self function_aefc64("pistol_topbreak_t8");
    self function_aefc64("ar_accurate_t8");
    self giveweapon(level.weaponbasemelee);
    self zm_perks::function_79567d8a(#"specialty_staminup", 0);
    self zm_perks::function_79567d8a(#"specialty_extraammo", 1);
    self freeze_player_controls();
    function_bd7e60bb(8);
    if (level.gamedifficulty == 0) {
        wait 2;
        self lui::screen_fade_in(1);
    } else {
        function_179be094("vox_narr_inter_start_0");
        wait 1;
        level flag::set("tutorial_intro_screen_over");
    }
    self function_d626232c();
    self perks();
    self equipment();
    self bot();
    self function_69fb16d8();
    self catalyst();
    self cooperative();
    self crafting();
    self power();
    self val::set("round_reset", "takedamage", 0);
    self lui::screen_fade_out(5);
    level thread bot::remove_bot(level.tutorialbot);
    self set_character(zm_characters::get_character_index(array(#"hash_3e63362aea484e09", #"hash_5a906d7137467771")));
    self function_650064bc("tutorial_advanced_start");
    self.is_drinking = 0;
    a_pap = struct::get_array("pap_quest_interact", "targetname");
    a_pap[0].unitrigger_stub thread zodt8_pap_quest::function_7e9ee9fa(self);
    a_pap[1].unitrigger_stub thread zodt8_pap_quest::function_7e9ee9fa(self);
    a_pap[2].unitrigger_stub thread zodt8_pap_quest::function_7e9ee9fa(self);
    self takeallweapons();
    self function_aefc64("smg_handling_t8");
    self function_aefc64("ar_stealth_t8");
    self function_aefc64("hero_hammer_lv1");
    self function_aefc64("zhield_dw");
    self giveweapon(level.weaponbasemelee);
    self zm_perks::function_79567d8a(#"specialty_staminup", 0);
    self zm_perks::function_79567d8a(#"specialty_extraammo", 1);
    self zm_perks::function_79567d8a(#"specialty_cooldown", 2);
    self zm_perks::function_79567d8a(#"specialty_deadshot", 3);
    self freeze_player_controls();
    self function_dcf5d4e5(5500);
    self function_d626232c();
    self val::set("round_reset", "takedamage", 1);
    self special_weapons();
    self function_2ef5434f();
    self pap();
    self fast_travel();
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xf02cdc8d, Offset: 0x6190
// Size: 0x1c4
function perks() {
    function_b70c01cd();
    self.is_drinking = 1;
    function_f8dd2ace(1);
    function_6cfecc66(array("vox_narr_inter_perks_0", "vox_narr_inter_perks_1"), "vo_done");
    self thread function_5f28d5d3("vox_narr_inter_perks_nag_0", 5, "perk_purchased");
    self.is_drinking = 0;
    var_b98412fc = function_7aa712d3("p8_fxanim_zm_vapor_altar_zeus_mod");
    var_b98412fc clientfield::set("tutorial_keyline_fx", 1);
    s_objective = struct::get("objective_pos_altar", "targetname");
    s_objective function_5fdd500f();
    self waittill(#"perk_purchased");
    var_b98412fc clientfield::set("tutorial_keyline_fx", 2);
    s_objective function_5fdd500f(0);
    function_6cfecc66(array("vox_narr_inter_perks_2", "vox_narr_inter_door_0"), "vo_done");
    function_b70c01cd(0);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x1ce0eebf, Offset: 0x6360
// Size: 0x12c
function function_39409fb7() {
    self function_650064bc("tutorial_equipment_start");
    a_grenades = getentarray("grenade", "classname");
    array::delete_all(a_grenades);
    function_774c1edc(array("tutorial_zm_spawner_equipment_1", "tutorial_zm_spawner_equipment_2", "tutorial_zm_spawner_equipment_3"));
    array::thread_all(level.var_7200d8ac, &function_b3f1ee2f);
    self thread function_21e4d60e();
    w_weapon = getweapon("sticky_grenade");
    self gadgetpowerset(self gadgetgetslot(w_weapon), 100);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x452dcb3, Offset: 0x6498
// Size: 0x64
function function_21e4d60e() {
    level endon(#"hash_7985df6134faf927", #"end_game");
    self endon(#"death");
    level waittill(#"bad_kill");
    tutorial_reset();
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xf777c4b7, Offset: 0x6508
// Size: 0xf0
function function_b3f1ee2f() {
    level endon(#"hash_7985df6134faf927", #"bad_kill");
    self.health = 50;
    self.var_77966006 = &function_6dd3654e;
    eventstruct = self waittill(#"death");
    sticky_grenade = getweapon("eq_acid_bomb");
    if (!isdefined(eventstruct) || !isdefined(eventstruct.weapon)) {
        return;
    }
    if (eventstruct.weapon != sticky_grenade) {
        level notify(#"bad_kill");
        return;
    }
    level notify(#"hash_7985df6134faf927");
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x1b59e5d8, Offset: 0x6600
// Size: 0x3b4
function equipment() {
    function_e12ad69e("suites_promenade_door", "p8_kit_zod_lou_05_door_left_painted_wood_01", 1);
    s_objective = struct::get("objective_pos_door_buy_2", "targetname");
    s_objective function_5fdd500f();
    level thread function_5f28d5d3("vox_narr_inter_door_1", 5, "door_opened");
    level waittill(#"door_opened", #"junk purchased");
    function_e12ad69e("suites_promenade_door", "p8_kit_zod_lou_05_door_left_painted_wood_01", 0);
    s_objective function_5fdd500f(0);
    function_d23a7dd0("barrier_acid_bomb");
    self thread function_179be094("vox_narr_inter_grenade_0");
    self thread function_5f28d5d3("vox_narr_inter_grenade_nag_0", 6, "grenade_fire");
    function_774c1edc(array("tutorial_zm_spawner_equipment_1", "tutorial_zm_spawner_equipment_2", "tutorial_zm_spawner_equipment_3"));
    array::thread_all(level.var_7200d8ac, &function_b3f1ee2f);
    self thread function_21e4d60e();
    function_f8dd2ace(2);
    self.reset_score = self.score;
    self thread function_7ea4b365(#"hash_3d6f9490b9f55db5", "equipment_completed", &function_f0d630c7);
    sticky_grenade = getweapon("eq_acid_bomb");
    self giveweapon(sticky_grenade);
    function_15ec65a(&function_39409fb7);
    level waittill(#"hash_7985df6134faf927");
    self notify(#"equipment_completed");
    function_e7d4a54b();
    foreach (ai_zombie in level.var_7200d8ac) {
        if (isdefined(ai_zombie) && isalive(ai_zombie)) {
            ai_zombie dodamage(ai_zombie.health + 100, ai_zombie.origin);
        }
    }
    function_179be094("vox_narr_inter_grenade_kill_0");
    function_d23a7dd0("barrier_acid_bomb", 0);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xa06a6256, Offset: 0x69c0
// Size: 0x9c
function function_2b4ab899() {
    level endon(#"end_game");
    level endon(#"tutorial_reset");
    wait 0.6;
    level.var_970b5764 = zm_powerups::specific_powerup_drop("nuke", self.origin, #"allies", 0.1, undefined, 1);
    self kill();
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x810cb67a, Offset: 0x6a68
// Size: 0x15a
function function_2a96914() {
    self function_650064bc("tutorial_bot_start");
    if (isdefined(level.var_970b5764)) {
        level.var_970b5764 delete();
    }
    level.var_970b5764 = undefined;
    zombie = function_30c9f3e1("tutorial_zm_spawner_bot_1", 1, level.tutorialbot);
    zombie thread function_2b4ab899();
    function_774c1edc(array("tutorial_zm_spawner_bot_2", "tutorial_zm_spawner_bot_3", "tutorial_zm_spawner_bot_4", "tutorial_zm_spawner_bot_5"));
    foreach (ai_zombie in level.var_7200d8ac) {
        ai_zombie.var_77966006 = &function_6dd3654e;
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x76b79321, Offset: 0x6bd0
// Size: 0xc0
function function_35a4d681() {
    level endon(#"end_game");
    level endon(#"hash_5cefed971a2f1a52");
    self endon(#"death");
    self waittill(#"player_downed");
    self endon(#"player_revived", #"zombified", #"disconnect");
    max_time = self.bleedout_time;
    while (true) {
        self.bleedout_time = max_time;
        waitframe(1);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x7e9c0ca6, Offset: 0x6c98
// Size: 0x324
function bot() {
    self.reset_score = self.score;
    trigger::wait_till("tutorial_spawn_nuke");
    level thread function_179be094("vox_narr_inter_nuke_0");
    self thread function_5f28d5d3("vox_narr_inter_nuke_nag_0", 8, "nuke_triggered");
    var_62dce603 = getnode("tutorial_bot_spawn", "targetname");
    sessionmode = currentsessionmode();
    bot::add_fixed_spawn_bot(#"allies", var_62dce603.origin, var_62dce603.angles[1], zm_characters::get_character_index(array(#"hash_7180c6cf382f6010", #"hash_14e91ceb9a7b3eb6")));
    waitframe(1);
    level.tutorialbot thread function_35a4d681();
    level.tutorialbot function_dcf5d4e5(2000);
    level.tutorialbot dodamage(level.tutorialbot.health, level.tutorialbot.origin);
    zombie = function_30c9f3e1("tutorial_zm_spawner_bot_1", 1, level.tutorialbot);
    zombie thread function_2b4ab899();
    waitframe(3);
    function_774c1edc(array("tutorial_zm_spawner_bot_2", "tutorial_zm_spawner_bot_3", "tutorial_zm_spawner_bot_4", "tutorial_zm_spawner_bot_5"));
    foreach (ai_zombie in level.var_7200d8ac) {
        ai_zombie.var_77966006 = &function_6dd3654e;
    }
    function_15ec65a(&function_2a96914);
    self thread function_e365670a();
    self waittill(#"nuke_triggered");
    function_e7d4a54b();
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x55391470, Offset: 0x6fc8
// Size: 0x66
function function_e365670a() {
    self endon(#"nuke_triggered");
    self endon(#"death");
    while (true) {
        if (self zm_laststand::is_reviving_any()) {
            tutorial_reset();
        }
        waitframe(1);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x4356e2af, Offset: 0x7038
// Size: 0xec
function function_69fb16d8() {
    level thread function_179be094("vox_narr_inter_nuke_use_0", 4);
    level.tutorialbot waittill(#"stop_revive_trigger");
    level thread function_179be094("vox_narr_inter_bruno_revive_0");
    level.tutorialbot function_aefc64("ar_damage_t8");
    level.tutorialbot set_bot_goal("tutorial_bot_ramp");
    waittill_trigger("tutorial_finish_bot_revive", self);
    level.tutorialbot set_bot_goal("tutorial_bot_upper_deck");
    function_d23a7dd0("barrier_post_revive");
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x9b48be23, Offset: 0x7130
// Size: 0x1a6
function catalyst() {
    level.tutorialbot ai::set_behavior_attribute("revive", 0);
    level.player_death_override = undefined;
    level thread function_179be094("vox_narr_inter_cat_zmb_0");
    function_30c9f3e1("tutorial_catalyst_spawner", 1, level.tutorialbot);
    level waittill(#"hash_528115ad9eebc84f");
    self dodamage(self.health + 100, self.origin);
    level.tutorialbot set_bot_goal("tutorial_bot_before_revive");
    function_179be094("vox_narr_inter_cat_zmb_downed_0");
    level thread function_179be094("vox_narr_inter_cat_zmb_downed_1");
    level.tutorialbot ai::set_behavior_attribute("revive", 1);
    level.tutorialbot setgoal(self, 1);
    level.tutorialbot bot::set_revive_target(self);
    self waittill(#"stop_revive_trigger");
    level.player_death_override = &tutorial_reset;
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xc36cce74, Offset: 0x72e0
// Size: 0xfc
function cooperative() {
    level.tutorialbot set_bot_goal("tutorial_bot_open_door");
    waittill_trigger("tutorial_bot_open_door_trigger", level.tutorialbot);
    function_179be094("vox_narr_inter_teamwork_0");
    open_door("library_boat_deck_door");
    function_d23a7dd0("barrier_pre_shield");
    level.tutorialbot zm_score::player_reduce_points("take_specified", 1500);
    level thread function_6cfecc66(array("vox_narr_inter_teamwork_1", "vox_narr_inter_shield_part_0"), "vo_done");
    function_b70c01cd();
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xa1b1fcab, Offset: 0x73e8
// Size: 0x474
function crafting() {
    level.tutorialbot set_bot_goal("tutorial_bot_shield_part");
    var_88bda816 = getent("tutorial_forced_shield_part", "targetname");
    var_88bda816 clientfield::set("tutorial_keyline_fx", 1);
    s_objective = struct::get("objective_pos_shield", "targetname");
    s_objective function_5fdd500f();
    var_275de9da = getweapon("zitem_rocketshield_part_1");
    while (!zm_items::player_has(self, var_275de9da)) {
        waitframe(1);
    }
    s_objective function_5fdd500f(0);
    function_179be094("vox_narr_inter_shield_0");
    self thread function_7ea4b365(#"hash_5de9dee0c0a470e5", "inventory_completed", &function_e4386d37, 8);
    function_d23a7dd0("barrier_pre_shield", 0);
    function_d23a7dd0("barrier_post_shield");
    level.tutorialbot set_bot_goal("tutorial_bot_crafting");
    var_5310e714 = getent("tutorial_table", "targetname");
    var_5310e714 clientfield::set("tutorial_keyline_fx", 1);
    s_objective = struct::get("objective_pos_table", "targetname");
    s_objective function_5fdd500f();
    level thread function_179be094("vox_narr_inter_shield_1");
    self waittill(#"crafting_success");
    var_5310e714 delete();
    var_a17b973 = getent("shield_model", "targetname");
    var_a17b973 clientfield::set("tutorial_keyline_fx", 1);
    level thread function_179be094("vox_narr_inter_shield_build_0");
    shield = getweapon("zhield_dw");
    while (!self hasweapon(shield)) {
        waitframe(1);
    }
    var_a17b973 clientfield::set("tutorial_keyline_fx", 2);
    s_objective function_5fdd500f(0);
    function_f8dd2ace(3);
    self thread function_7ea4b365(#"hash_4253963241ceddbb", "shield_equipped");
    level thread function_179be094("vox_narr_inter_shield_up_0");
    while (!(self getcurrentweapon() == shield)) {
        waitframe(1);
    }
    self notify(#"shield_equipped");
    wait 1;
    self thread function_7ea4b365(#"hash_6b53132afa3ea5ef", "shield_attack");
    function_179be094("vox_narr_inter_switch_1");
    function_d23a7dd0("barrier_post_shield", 0);
    function_d23a7dd0("barrier_pre_power");
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x5d6e24fd, Offset: 0x7868
// Size: 0x168
function function_5a799751() {
    level endon(#"tutorial_reset");
    self val::set(#"devgui", "ignoreme");
    self val::set(#"devgui", "takedamage", 0);
    self set_bot_goal("tutorial_bot_before_power");
    self waittill(#"goal");
    while (level.var_7200d8ac.size > 0) {
        function_526005d6(level.var_7200d8ac);
        e_target = level.var_7200d8ac[randomint(level.var_7200d8ac.size)];
        self setentitytarget(e_target);
        e_target waittill(#"death");
        wait randomfloatrange(1, 2);
        function_526005d6(level.var_7200d8ac);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x71e3485d, Offset: 0x79d8
// Size: 0x84
function power_reset() {
    self function_650064bc("tutorial_power_start");
    function_774c1edc(array("tutorial_zm_spawner_power_1", "tutorial_zm_spawner_power_2", "tutorial_zm_spawner_power_3", "tutorial_zm_spawner_power_4", "tutorial_zm_spawner_power_5"));
    level.tutorialbot thread function_5a799751();
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x7b690d15, Offset: 0x7a68
// Size: 0x232
function power() {
    level thread function_179be094("vox_narr_inter_power_0", 1);
    function_15ec65a(&power_reset);
    self.reset_score = self.score;
    e_power = function_7aa712d3("p8_fxanim_zm_zod_sentinel_chaos_wheel_mod");
    e_power clientfield::set("tutorial_keyline_fx", 1);
    s_objective = struct::get("objective_pos_power", "targetname");
    s_objective function_5fdd500f();
    function_774c1edc(array("tutorial_zm_spawner_power_1", "tutorial_zm_spawner_power_2", "tutorial_zm_spawner_power_3", "tutorial_zm_spawner_power_4", "tutorial_zm_spawner_power_5"));
    level.tutorialbot thread function_5a799751();
    function_490844cd();
    function_d23a7dd0("barrier_pre_power", 0);
    level.tutorialbot set_bot_goal("tutorial_bot_power");
    level thread function_179be094("vox_narr_inter_power_1", 1.5);
    level flag::wait_till("power_on");
    self.is_drinking = 1;
    s_objective function_5fdd500f(0);
    e_power clientfield::set("tutorial_keyline_fx", 2);
    wait 10;
    level thread function_179be094("vox_narr_inter_power_on_0");
    wait 5;
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x68e0424b, Offset: 0x7ca8
// Size: 0x1a4
function function_2733abd8() {
    self function_650064bc("tutorial_special_weapons_start");
    function_30c9f3e1("tutorial_zm_spawner_specialweapons_charge");
    function_774c1edc(array("tutorial_zm_spawner_specialweapons_1", "tutorial_zm_spawner_specialweapons_2", "tutorial_zm_spawner_specialweapons_3", "tutorial_zm_spawner_specialweapons_4", "tutorial_zm_spawner_specialweapons_5", "tutorial_zm_spawner_specialweapons_6", "tutorial_zm_spawner_specialweapons_7", "tutorial_zm_spawner_specialweapons_8", "tutorial_zm_spawner_specialweapons_9", "tutorial_zm_spawner_specialweapons_10"));
    self gadgetpowerset(2, 100);
    if (ispc() && !(isdefined(self gamepadusedlast()) && self gamepadusedlast())) {
        self thread function_7ea4b365(#"hash_77e4f27eadd05e61", "hammer_equipped", &function_cf9c6edd);
    } else {
        self thread function_7ea4b365(#"hash_49608704d6c3dc17", "hammer_equipped", &function_cf9c6edd);
    }
    self thread function_e6821ff7();
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x30baa487, Offset: 0x7e58
// Size: 0x374
function special_weapons() {
    function_f8dd2ace(4);
    self.reset_score = self.score;
    level flag::init("special_weapon_activated");
    function_15ec65a(&function_2733abd8);
    function_30c9f3e1("tutorial_zm_spawner_specialweapons_charge");
    self lui::screen_fade_in(1);
    level thread function_179be094("vox_narr_advance_special_weapon_0");
    if (ispc() && !(isdefined(self gamepadusedlast()) && self gamepadusedlast())) {
        self thread function_7ea4b365(#"hash_77e4f27eadd05e61", "hammer_equipped", &function_cf9c6edd);
    } else {
        self thread function_7ea4b365(#"hash_49608704d6c3dc17", "hammer_equipped", &function_cf9c6edd);
    }
    self thread function_e6821ff7();
    level.var_b43e213c = "run";
    level.var_b02d530a = "sprint";
    function_774c1edc(array("tutorial_zm_spawner_specialweapons_1", "tutorial_zm_spawner_specialweapons_2", "tutorial_zm_spawner_specialweapons_3", "tutorial_zm_spawner_specialweapons_4", "tutorial_zm_spawner_specialweapons_5", "tutorial_zm_spawner_specialweapons_6", "tutorial_zm_spawner_specialweapons_7", "tutorial_zm_spawner_specialweapons_8", "tutorial_zm_spawner_specialweapons_9", "tutorial_zm_spawner_specialweapons_10"));
    level flag::wait_till("special_weapon_activated");
    level thread function_179be094("vox_narr_advance_hammer_0");
    hammer = getweapon("hero_hammer_lv1");
    while (self getcurrentweapon() == hammer && level.var_7200d8ac.size > 0) {
        waitframe(1);
        array::remove_undefined(level.var_7200d8ac);
    }
    function_179be094("vox_narr_advance_kill_hammer_0");
    array::remove_undefined(level.var_7200d8ac);
    if (level.var_7200d8ac.size > 0) {
        function_179be094("vox_narr_advance_kill_hammer_2");
    }
    function_490844cd();
    function_e7d4a54b();
    function_179be094("vox_narr_advance_kill_hammer_1");
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x9549974, Offset: 0x81d8
// Size: 0x64
function function_e6821ff7() {
    self endon(#"hammer_equipped", #"death");
    wait 5;
    level thread function_179be094("vox_narr_advance_hammer_nag_0");
    wait 3;
    tutorial_reset();
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xaf6506c6, Offset: 0x8248
// Size: 0xdc
function function_2ef5434f() {
    function_179be094("vox_narr_advance_elixir_0", 1);
    level.var_ec8913c8 = 2;
    function_f8dd2ace(5);
    self thread function_7ea4b365(#"hash_52ed5bafc1e1a62c", "tutorial_used_anywhere_but_here");
    level waittill(#"tutorial_used_anywhere_but_here");
    self function_650064bc("tutorial_elixers");
    level.var_ec8913c8 = -1;
    setdvar(#"zombie_unlock_all", 0);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x5b5df347, Offset: 0x8330
// Size: 0x54
function function_c06b5356() {
    level endon(#"end_game");
    self endon(#"death");
    self waittill(#"pap_timeout");
    tutorial_reset();
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x8c93c158, Offset: 0x8390
// Size: 0x7c
function function_e5e9181c() {
    self function_aefc64("smg_handling_t8");
    self function_aefc64("ar_stealth_t8");
    self function_650064bc("tutorial_PAP_start");
    self thread function_c06b5356();
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xceabec70, Offset: 0x8418
// Size: 0x1f4
function pap() {
    self.reset_score = self.score;
    self.is_drinking = 1;
    var_48d6f0f5 = getent("t_use_water_pump_fore", "targetname");
    var_48d6f0f5 hide();
    function_179be094("vox_narr_advance_elixir_1");
    self.is_drinking = 0;
    a_pap = getentarray("zm_pack_a_punch", "targetname");
    a_pap[3] clientfield::set("tutorial_keyline_fx", 1);
    s_objective = struct::get("objective_pos_pap", "targetname");
    s_objective function_5fdd500f();
    level thread function_179be094("vox_narr_advance_pap_0", 1);
    function_15ec65a(&function_e5e9181c);
    self thread function_c06b5356();
    self waittill(#"pap_taken");
    a_pap[3] clientfield::set("tutorial_keyline_fx", 2);
    s_objective function_5fdd500f(0);
    function_e7d4a54b();
    level thread function_179be094("vox_narr_advance_pap_use_0", 0.5);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x24d7985a, Offset: 0x8618
// Size: 0x6c
function function_68aabbe() {
    self function_650064bc("tutorial_fast_travel_start");
    function_774c1edc(array("tutorial_zm_spawner_fast_travel_1", "tutorial_zm_spawner_fast_travel_2", "tutorial_zm_spawner_fast_travel_3", "tutorial_zm_spawner_fast_travel_4", "tutorial_zm_spawner_fast_travel_5"));
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x652ab75, Offset: 0x8690
// Size: 0x174
function fast_travel() {
    level flag::clear(#"disable_fast_travel");
    function_15ec65a(&function_68aabbe);
    function_774c1edc(array("tutorial_zm_spawner_fast_travel_1", "tutorial_zm_spawner_fast_travel_2", "tutorial_zm_spawner_fast_travel_3", "tutorial_zm_spawner_fast_travel_4", "tutorial_zm_spawner_fast_travel_5"));
    s_objective = struct::get("objective_pos_fast_travel", "targetname");
    s_objective function_5fdd500f();
    self.var_56c7266a = 0;
    while (!self.var_56c7266a) {
        waitframe(1);
    }
    level.zm_disable_recording_stats = 0;
    /#
        iprintlnbold("<dev string:x30>" + self getentnum());
    #/
    self zm_utility::giveachievement_wrapper("ZM_TUTORIAL_COMPLETION", 0);
    level.zm_disable_recording_stats = 1;
    s_objective function_5fdd500f(0);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0x94a47341, Offset: 0x8810
// Size: 0x7c
function function_bd7e60bb(n_round_number) {
    level.zombie_health = zombie_utility::ai_calculate_health(zombie_utility::get_zombie_var(#"zombie_health_start"), n_round_number);
    zm_round_logic::set_round_number(n_round_number);
    setroundsplayed(n_round_number);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0x1e6789bd, Offset: 0x8898
// Size: 0x4e
function function_9a9ad929(b_disable = 1) {
    if (b_disable) {
        level.func_override_wallbuy_prompt = &function_f4ae9db7;
        return;
    }
    level.func_override_wallbuy_prompt = undefined;
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 2, eflags: 0x4
// Checksum 0xacd182f5, Offset: 0x88f0
// Size: 0x16
function private function_f4ae9db7(e_player, player_has_weapon) {
    return false;
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0xf0cf9ced, Offset: 0x8910
// Size: 0x208
function function_b70c01cd(b_disable = 1) {
    var_667e2b8a = getentarray("zombie_door", "targetname");
    foreach (t_door in var_667e2b8a) {
        if (b_disable) {
            t_door notify(#"kill_door_think");
            t_door setinvisibletoall();
            continue;
        }
        t_door thread zm_blockers::blocker_update_prompt_visibility();
        t_door thread zm_blockers::door_think();
        t_door setvisibletoall();
    }
    var_bd25e1ce = getentarray("zombie_debris", "targetname");
    foreach (t_door in var_bd25e1ce) {
        if (b_disable) {
            t_door notify(#"kill_door_think");
            t_door setinvisibletoall();
            continue;
        }
        t_door thread zm_blockers::blocker_update_prompt_visibility();
        t_door setvisibletoall();
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x4
// Checksum 0xced18108, Offset: 0x8b20
// Size: 0x2c
function private function_6dd3654e(entity) {
    entity setgoal(entity.origin);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 4, eflags: 0x0
// Checksum 0xcc6d24cb, Offset: 0x8b58
// Size: 0x9e
function function_7ea4b365(str_text, str_notify, func_timeout, n_timeout = 8) {
    level flag::wait_till_clear("tutorial_reset");
    self thread zm_equipment::show_hint_text(str_text, n_timeout);
    if (isdefined(func_timeout)) {
        self thread [[ func_timeout ]]();
    }
    self waittill(str_notify);
    self notify(#"hide_equipment_hint_text");
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x50c49f31, Offset: 0x8c00
// Size: 0x62
function function_5f41b7ea() {
    self endon(#"death", #"shoot_zombie_completed");
    while (true) {
        if (self isfiring()) {
            self notify(#"shoot_zombie_completed");
            return;
        }
        waitframe(1);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xe73bae60, Offset: 0x8c70
// Size: 0x72
function function_f898ebab() {
    self endon(#"death", #"crouch_completed");
    while (true) {
        if (self getstance() == "crouch") {
            self notify(#"crouch_completed");
            return;
        }
        waitframe(1);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x6080f52b, Offset: 0x8cf0
// Size: 0x62
function function_39d34565() {
    self endon(#"death", #"sprint_completed");
    while (true) {
        if (self issprinting()) {
            self notify(#"sprint_completed");
            return;
        }
        waitframe(1);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xb044cab4, Offset: 0x8d60
// Size: 0x62
function function_ffdf238d() {
    self endon(#"death", #"ads_completed");
    while (true) {
        if (self adsbuttonpressed()) {
            self notify(#"ads_completed");
            return;
        }
        waitframe(1);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0xcd91401d, Offset: 0x8dd0
// Size: 0x62
function function_f7065f6e() {
    self endon(#"death", #"reload_completed");
    while (true) {
        if (self isreloading()) {
            self notify(#"reload_completed");
            return;
        }
        waitframe(1);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x5b604726, Offset: 0x8e40
// Size: 0x62
function function_2ed53260() {
    self endon(#"death", #"switch_completed");
    while (true) {
        if (self weaponswitchbuttonpressed()) {
            self notify(#"switch_completed");
            return;
        }
        waitframe(1);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x48d61f33, Offset: 0x8eb0
// Size: 0x62
function function_f0d630c7() {
    self endon(#"death", #"equipment_completed");
    while (true) {
        if (self isthrowinggrenade()) {
            self notify(#"equipment_completed");
            return;
        }
        waitframe(1);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x2a5e6dea, Offset: 0x8f20
// Size: 0x62
function function_e4386d37() {
    self endon(#"death", #"inventory_completed");
    while (true) {
        if (self inventorybuttonpressed()) {
            self notify(#"inventory_completed");
            return;
        }
        waitframe(1);
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 0, eflags: 0x0
// Checksum 0x30664cca, Offset: 0x8f90
// Size: 0xa6
function function_cf9c6edd() {
    self endon(#"death", #"hammer_equipped");
    hammer = getweapon("hero_hammer_lv1");
    while (!(self getcurrentweapon() == hammer)) {
        waitframe(1);
    }
    level flag::set("special_weapon_activated");
    self notify(#"hammer_equipped");
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0x2f2823fb, Offset: 0x9040
// Size: 0xc6
function function_7aa712d3(str_model_name) {
    var_9bf6ee71 = undefined;
    a_models = getentarray("script_model", "classname");
    foreach (var_d2646312 in a_models) {
        if (var_d2646312.model == str_model_name) {
            var_9bf6ee71 = var_d2646312;
            return var_9bf6ee71;
        }
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 3, eflags: 0x0
// Checksum 0x2c67e5d9, Offset: 0x9110
// Size: 0x138
function function_e12ad69e(str_door, str_model, var_c1d019a8 = 1) {
    a_models = getentarray(str_door, "targetname");
    foreach (e_model in a_models) {
        if (isdefined(e_model.model) && e_model.model == str_model) {
            if (isdefined(var_c1d019a8) && var_c1d019a8) {
                e_model clientfield::set("tutorial_keyline_fx", 1);
                continue;
            }
            e_model clientfield::set("tutorial_keyline_fx", 2);
        }
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 2, eflags: 0x0
// Checksum 0xc448f8f9, Offset: 0x9250
// Size: 0x74
function function_179be094(str_alias, n_delay) {
    if (isdefined(n_delay)) {
        wait n_delay;
    }
    level.var_d2cc48b6 stopsounds();
    waitframe(1);
    waitframe(1);
    level.var_d2cc48b6 zm_vo::vo_say(str_alias, 0, 0, 1, 1);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 2, eflags: 0x0
// Checksum 0x88f97935, Offset: 0x92d0
// Size: 0x98
function function_6cfecc66(a_str_alias, str_endon) {
    self endon(str_endon);
    foreach (str_alias in a_str_alias) {
        function_179be094(str_alias);
        wait 0.3;
    }
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 3, eflags: 0x0
// Checksum 0xfe0c60f7, Offset: 0x9370
// Size: 0x44
function function_5f28d5d3(str_alias, n_time, str_endon) {
    self endon(str_endon);
    wait n_time;
    level thread function_179be094(str_alias);
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 1, eflags: 0x0
// Checksum 0x8f9d816a, Offset: 0x93c0
// Size: 0xce
function function_5fdd500f(b_on = 1) {
    if (isdefined(b_on) && b_on) {
        self.objective_id = gameobjects::get_next_obj_id();
        objective_add(self.objective_id, "active", self.origin, #"hash_410c56f34d7ed87");
        function_eeba3a5c(self.objective_id, 1);
        return;
    }
    gameobjects::release_obj_id(self.objective_id);
    self.objective_id = undefined;
}

// Namespace zm_zodt8_tutorial/zm_zodt8_tutorial
// Params 2, eflags: 0x0
// Checksum 0x709d3273, Offset: 0x9498
// Size: 0x3b8
function function_d23a7dd0(str_barrier, b_on = 1) {
    var_58e90f8 = (0, 0, 48);
    var_5fe3b92d = struct::get_array(str_barrier, "targetname");
    if (isdefined(b_on) && b_on) {
        foreach (s_position in var_5fe3b92d) {
            s_position.mdl_pos = util::spawn_model("tag_origin", s_position.origin, s_position.angles);
            s_position.mdl_pos clientfield::set("" + #"hash_1b509b0ba634a25a", 1);
            s_position.mdl_fx = util::spawn_model(#"p8_zm_power_door_symbol_01", s_position.origin + var_58e90f8, s_position.angles);
            s_position.mdl_fx clientfield::set("" + #"hash_1390e08de02cbdc7", 1);
            s_position.var_44febfef = util::spawn_model("collision_player_wall_128x128x10", s_position.origin + var_58e90f8, s_position.angles);
            s_position.var_44febfef disconnectpaths();
            s_position.var_44febfef ghost();
        }
        return;
    }
    foreach (s_position in var_5fe3b92d) {
        if (isdefined(s_position.mdl_pos)) {
            s_position.mdl_pos clientfield::set("" + #"hash_1b509b0ba634a25a", 0);
            util::wait_network_frame();
            s_position.mdl_pos delete();
        }
        if (isdefined(s_position.mdl_fx)) {
            s_position.mdl_fx clientfield::set("" + #"hash_1390e08de02cbdc7", 0);
            util::wait_network_frame();
            s_position.mdl_fx delete();
        }
        if (isdefined(s_position.var_44febfef)) {
            s_position.var_44febfef notsolid();
            s_position.var_44febfef connectpaths();
            s_position.var_44febfef delete();
        }
    }
}

