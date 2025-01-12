#using script_39eae6a6b493fe9e;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\potm_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\callings\zm_callings;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb_pack;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace bgb;

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x2
// Checksum 0x8bca36f5, Offset: 0x330
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"bgb", &__init__, &__main__, undefined);
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x4
// Checksum 0xa1949ba2, Offset: 0x380
// Size: 0x30c
function private __init__() {
    callback::on_spawned(&on_player_spawned);
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    level.weaponbgbgrab = getweapon(#"zombie_bgb_grab");
    level.var_30732406 = array(getweapon(#"hash_d0f29de78e218ad"), getweapon(#"hash_5e07292c519531e6"), getweapon(#"hash_305e5faa9ecb625a"), getweapon(#"hash_23cc1f9c16b375c3"), getweapon(#"hash_2394c41f048f7d2"), getweapon(#"hash_155cc0a9ba3c3260"), getweapon(#"hash_4565adf3abc61ea3"));
    level.bgb = [];
    clientfield::register("clientuimodel", "zmhud.bgb_current", 1, 8, "int");
    clientfield::register("clientuimodel", "zmhud.bgb_display", 1, 1, "int");
    clientfield::register("clientuimodel", "zmhud.bgb_timer", 1, 8, "float");
    clientfield::register("clientuimodel", "zmhud.bgb_activations_remaining", 1, 3, "int");
    clientfield::register("clientuimodel", "zmhud.bgb_invalid_use", 1, 1, "counter");
    clientfield::register("clientuimodel", "zmhud.bgb_one_shot_use", 1, 1, "counter");
    clientfield::register("toplayer", "bgb_blow_bubble", 1, 1, "counter");
    zm::register_vehicle_damage_callback(&vehicle_damage_override);
    zm_perks::register_lost_perk_override(&lost_perk_override);
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x4
// Checksum 0xd6a0cc82, Offset: 0x698
// Size: 0x82
function private __main__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb_finalize();
    /#
        level thread setup_devgui();
    #/
    level._effect[#"samantha_steal"] = #"zombie/fx_monkey_lightning_zmb";
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x4
// Checksum 0xa581bf56, Offset: 0x728
// Size: 0x56
function private on_player_spawned() {
    self.bgb = #"none";
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    self thread bgb_player_init();
    self.var_c6eb402a = [];
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x4
// Checksum 0x8d825c1f, Offset: 0x788
// Size: 0x3de
function private bgb_player_init() {
    if (isdefined(self.bgb_pack)) {
        return;
    }
    self.bgb_pack = self getbubblegumpack();
    for (x = 0; x < self.bgb_pack.size; x++) {
        if (isstring(self.bgb_pack[x])) {
            self.bgb_pack[x] = hash(self.bgb_pack[x]);
        }
    }
    self.bgb_pack_randomized = [];
    var_610269db = array();
    for (i = 0; i < 4; i++) {
        str_bgb = self.bgb_pack[i];
        if (str_bgb == #"weapon_null") {
            continue;
        }
        if (zm_custom::function_25d3f3c8(str_bgb)) {
            var_610269db[i] = str_bgb;
        }
    }
    self.bgb_pack = var_610269db;
    /#
        if (isdefined(self.var_8a709287)) {
            self.bgb_pack = self.var_8a709287;
        }
    #/
    self.bgb_stats = [];
    foreach (bgb in self.bgb_pack) {
        if (bgb == #"weapon_null") {
            continue;
        }
        if (isdefined(level.bgb) && isdefined(level.bgb[bgb]) && !(isdefined(level.bgb[bgb].consumable) && level.bgb[bgb].consumable)) {
            continue;
        }
        self.bgb_stats[bgb] = spawnstruct();
        if (!isbot(self)) {
            if (isstring(bgb)) {
                self.bgb_stats[bgb].var_e0b06b47 = self getbgbremaining(bgb);
            }
        } else {
            self.bgb_stats[bgb].var_e0b06b47 = 0;
        }
        self.bgb_stats[bgb].bgb_used_this_game = 0;
    }
    self init_weapon_cycling();
    self thread bgb_player_monitor();
    self thread bgb_end_game();
    for (i = 0; i < 4; i++) {
        if (isdefined(self.bgb_pack[i]) && isdefined(level.bgb[self.bgb_pack[i]])) {
            self bgb_pack::function_4805408e(i, level.bgb[self.bgb_pack[i]].item_index);
        }
    }
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x4
// Checksum 0xed3e0a76, Offset: 0xb70
// Size: 0x18c
function private bgb_end_game() {
    self endon(#"disconnect");
    if (!level flag::exists("consumables_reported")) {
        level flag::init("consumables_reported");
    }
    self flag::init("finished_reporting_consumables");
    self waittill(#"report_bgb_consumption");
    self thread take();
    foreach (bgb in self.bgb_pack) {
        if (!isdefined(self.bgb_stats[bgb]) || !self.bgb_stats[bgb].bgb_used_this_game) {
            continue;
        }
        level flag::set("consumables_reported");
        self reportlootconsume(bgb, self.bgb_stats[bgb].bgb_used_this_game);
    }
    self flag::set("finished_reporting_consumables");
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x4
// Checksum 0x8235859d, Offset: 0xd08
// Size: 0x212
function private bgb_finalize() {
    foreach (v in level.bgb) {
        v.item_index = getitemindexfromref(v.name);
        var_d5b592f2 = getunlockableiteminfofromindex(v.item_index, 2);
        v.stat_index = isdefined(var_d5b592f2) && isdefined(var_d5b592f2.var_eba4dbee) ? var_d5b592f2.var_eba4dbee : 0;
        var_692bb69 = function_b679234(v.item_index, 2);
        if (!isdefined(var_d5b592f2) || !isdefined(var_692bb69)) {
            println("<dev string:x30>" + v.name + "<dev string:x3f>");
            continue;
        }
        if (!isdefined(var_692bb69.bgbrarity)) {
            var_692bb69.bgbrarity = 0;
        }
        v.rarity = var_692bb69.bgbrarity;
        if (0 == v.rarity || 1 == v.rarity) {
            v.consumable = 0;
        } else {
            v.consumable = 1;
        }
        v.camo_index = var_692bb69.var_1e35fe46;
        v.dlc_index = var_d5b592f2.dlc;
    }
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x4
// Checksum 0xf4c4a007, Offset: 0xf28
// Size: 0xd0
function private bgb_player_monitor() {
    self endon(#"disconnect");
    while (true) {
        waitresult = level waittill(#"between_round_over", #"restart_round");
        str_return = waitresult._notify;
        if (isdefined(level.var_4824bb2d)) {
            if (!(isdefined(self [[ level.var_4824bb2d ]]()) && self [[ level.var_4824bb2d ]]())) {
                continue;
            }
        }
        if (str_return === "restart_round") {
            level waittill(#"between_round_over");
        }
    }
}

/#

    // Namespace bgb/zm_bgb
    // Params 0, eflags: 0x4
    // Checksum 0x3f39a1e2, Offset: 0x1000
    // Size: 0x244
    function private setup_devgui() {
        waittillframeend();
        setdvar(#"bgb_acquire_devgui", "<dev string:x6d>");
        setdvar(#"hash_7877ee182ba11433", -1);
        bgb_devgui_base = "<dev string:x6e>";
        keys = getarraykeys(level.bgb);
        foreach (key in keys) {
            name = function_15979fa9(level.bgb[key].name);
            adddebugcommand(bgb_devgui_base + name + "<dev string:x82>" + "<dev string:x90>" + "<dev string:xa3>" + name + "<dev string:xa5>");
        }
        adddebugcommand(bgb_devgui_base + "<dev string:xa9>" + "<dev string:xbc>" + "<dev string:xa3>" + "<dev string:xce>" + "<dev string:xa5>");
        for (i = 0; i < 4; i++) {
            playernum = i + 1;
            adddebugcommand(bgb_devgui_base + "<dev string:xd1>" + playernum + "<dev string:xe0>" + "<dev string:xbc>" + "<dev string:xa3>" + i + "<dev string:xa5>");
        }
        level thread bgb_devgui_think();
    }

    // Namespace bgb/zm_bgb
    // Params 0, eflags: 0x4
    // Checksum 0x798a6d54, Offset: 0x1250
    // Size: 0x90
    function private bgb_devgui_think() {
        for (;;) {
            var_fe9a7d67 = getdvarstring(#"bgb_acquire_devgui");
            if (var_fe9a7d67 != "<dev string:x6d>") {
                bgb_devgui_acquire(var_fe9a7d67);
            }
            setdvar(#"bgb_acquire_devgui", "<dev string:x6d>");
            wait 0.5;
        }
    }

    // Namespace bgb/zm_bgb
    // Params 1, eflags: 0x4
    // Checksum 0x759f6b7c, Offset: 0x12e8
    // Size: 0xfe
    function private bgb_devgui_acquire(bgb_name) {
        playerid = getdvarint(#"hash_7877ee182ba11433", 0);
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (playerid != -1 && playerid != i) {
                continue;
            }
            if (#"none" == bgb_name) {
                players[i] thread take();
                continue;
            }
            players[i] thread bgb_gumball_anim(bgb_name, 0, 0);
        }
    }

    // Namespace bgb/zm_bgb
    // Params 0, eflags: 0x4
    // Checksum 0x4012ef26, Offset: 0x13f0
    // Size: 0x142
    function private bgb_debug_text_display_init() {
        self.bgb_debug_text = newdebughudelem(self);
        self.bgb_debug_text.elemtype = "<dev string:xe8>";
        self.bgb_debug_text.font = "<dev string:xed>";
        self.bgb_debug_text.fontscale = 1.8;
        self.bgb_debug_text.horzalign = "<dev string:xf7>";
        self.bgb_debug_text.vertalign = "<dev string:xfc>";
        self.bgb_debug_text.alignx = "<dev string:xf7>";
        self.bgb_debug_text.aligny = "<dev string:xfc>";
        self.bgb_debug_text.x = 15;
        self.bgb_debug_text.y = 35;
        self.bgb_debug_text.sort = 2;
        self.bgb_debug_text.color = (1, 1, 1);
        self.bgb_debug_text.alpha = 1;
        self.bgb_debug_text.hidewheninmenu = 1;
    }

    // Namespace bgb/zm_bgb
    // Params 2, eflags: 0x4
    // Checksum 0x455c988b, Offset: 0x1540
    // Size: 0x1be
    function private bgb_set_debug_text(name, activations_remaining) {
        if (!isdefined(self.bgb_debug_text)) {
            return;
        }
        if (isdefined(activations_remaining)) {
        }
        self notify(#"bgb_set_debug_text_thread");
        self endon(#"bgb_set_debug_text_thread");
        self endon(#"disconnect");
        self.bgb_debug_text fadeovertime(0.05);
        self.bgb_debug_text.alpha = 1;
        prefix = "<dev string:x100>";
        short_name = name;
        if (issubstr(name, prefix)) {
            short_name = getsubstr(name, prefix.size);
        }
        if (isdefined(activations_remaining)) {
            self.bgb_debug_text settext("<dev string:x108>" + short_name + "<dev string:x10e>" + activations_remaining + "<dev string:x130>");
        } else {
            self.bgb_debug_text settext("<dev string:x108>" + short_name);
        }
        wait 1;
        if (#"none" == name) {
            self.bgb_debug_text fadeovertime(1);
            self.bgb_debug_text.alpha = 0;
        }
    }

    // Namespace bgb/zm_bgb
    // Params 1, eflags: 0x0
    // Checksum 0xa193d737, Offset: 0x1708
    // Size: 0xe4
    function bgb_print_stats(bgb) {
        printtoprightln(bgb + "<dev string:x137>" + self.bgb_stats[bgb].var_e0b06b47, (1, 1, 1));
        printtoprightln(bgb + "<dev string:x151>" + self.bgb_stats[bgb].bgb_used_this_game, (1, 1, 1));
        n_available = self.bgb_stats[bgb].var_e0b06b47 - self.bgb_stats[bgb].bgb_used_this_game;
        printtoprightln(bgb + "<dev string:x166>" + n_available, (1, 1, 1));
    }

#/

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x4
// Checksum 0x2223a1c8, Offset: 0x17f8
// Size: 0x6a
function private has_consumable_bgb(bgb) {
    if (!isdefined(self.bgb_stats[bgb]) || !(isdefined(level.bgb[bgb].consumable) && level.bgb[bgb].consumable)) {
        return 0;
    }
    return 1;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0xb0dd5570, Offset: 0x1870
// Size: 0x10c
function sub_consumable_bgb(bgb) {
    if (!has_consumable_bgb(bgb)) {
        return;
    }
    if (isdefined(level.bgb[bgb].var_35e23ba2) && ![[ level.bgb[bgb].var_35e23ba2 ]]()) {
        return;
    }
    self.bgb_stats[bgb].bgb_used_this_game++;
    if (level flag::exists("first_consumables_used")) {
        level flag::set("first_consumables_used");
    }
    self luinotifyevent(#"zombie_bgb_used", 1, level.bgb[bgb].item_index);
    /#
        bgb_print_stats(bgb);
    #/
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0x3e7b9053, Offset: 0x1988
// Size: 0x80
function get_bgb_available(bgb) {
    if (!isdefined(self.bgb_stats[bgb])) {
        return true;
    }
    var_3232aae6 = self.bgb_stats[bgb].var_e0b06b47;
    n_bgb_used_this_game = self.bgb_stats[bgb].bgb_used_this_game;
    n_bgb_remaining = var_3232aae6 - n_bgb_used_this_game;
    return 0 < n_bgb_remaining;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x4
// Checksum 0x88c1afc4, Offset: 0x1a10
// Size: 0xd4
function private function_c3e0b2ba(bgb, var_aad41617) {
    if (!(isdefined(level.bgb[bgb].var_7ca0e2a7) && level.bgb[bgb].var_7ca0e2a7)) {
        return;
    }
    self val::set(#"bgb_activation", "takedamage", 0);
    s_result = self waittilltimeout(2, #"bgb_bubble_blow_complete");
    if (isdefined(self)) {
        self val::reset(#"bgb_activation", "takedamage");
    }
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x4
// Checksum 0xcad300a1, Offset: 0x1af0
// Size: 0x8a
function private function_25a7074d(bgb, var_aad41617) {
    if (!(isdefined(level.bgb[bgb].var_36554bf3) && level.bgb[bgb].var_36554bf3)) {
        return;
    }
    self.var_fc6fd274 = 1;
    self waittilltimeout(2, #"bgb_bubble_blow_complete");
    if (isdefined(self)) {
        self.var_fc6fd274 = 0;
    }
}

// Namespace bgb/zm_bgb
// Params 3, eflags: 0x0
// Checksum 0xe1e37725, Offset: 0x1b88
// Size: 0x548
function bgb_gumball_anim(bgb, var_aad41617, var_ab813c3f = 1) {
    self endon(#"disconnect");
    level endon(#"end_game");
    if (self isinmovemode("ufo", "noclip")) {
        return 0;
    }
    if (var_aad41617 || var_ab813c3f) {
        self thread function_c3e0b2ba(bgb);
        self thread function_25a7074d(bgb);
        self thread zm_audio::create_and_play_dialog("elixir", "drink");
    }
    while (self isswitchingweapons() || self function_500afda2() || self isusingoffhand() || self isthrowinggrenade() || self ismeleeing() || self function_61d1659d() || self function_ff9045a2()) {
        waitframe(1);
    }
    while (self getcurrentweapon() == level.weaponnone) {
        waitframe(1);
    }
    if (!var_aad41617) {
        gun = self function_bb702b0a(bgb, var_aad41617);
        evt = self waittilltimeout(2.5, #"fake_death", #"death", #"player_downed", #"weapon_change_complete", #"disconnect", #"offhand_fire");
    }
    succeeded = 0;
    if (isdefined(evt) && evt._notify == "offhand_fire" || var_aad41617) {
        succeeded = 1;
        if (var_aad41617) {
            if (isdefined(level.bgb[bgb].var_7ea552f4) && level.bgb[bgb].var_7ea552f4 || self function_b616fe7a(1)) {
                self notify(#"hash_27b238d082f65849", bgb);
                self activation_start();
                self thread run_activation_func(bgb);
            } else {
                succeeded = 0;
            }
        } else {
            self notify(#"bgb_gumball_anim_give", bgb);
            self thread give(bgb);
            self zm_stats::increment_client_stat("bgbs_chewed");
            self zm_stats::increment_player_stat("bgbs_chewed");
            self zm_stats::increment_challenge_stat("GUM_GOBBLER_CONSUME");
            self zm_callings::function_7cafbdd3(15);
            self stats::inc_stat(#"itemstats", level.bgb[bgb].stat_index, #"stats", #"used", #"statvalue", 1);
            health = 0;
            if (isdefined(self.health)) {
                health = self.health;
            }
            self recordmapevent(4, gettime(), self.origin, level.round_number, level.bgb[bgb].item_index, health);
            demo::bookmark(#"zm_player_bgb_grab", gettime(), self);
            potm::bookmark(#"zm_player_bgb_grab", gettime(), self);
        }
    }
    if (!var_aad41617) {
        self function_a4493f0e(gun, bgb, var_aad41617);
    }
    return succeeded;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0x4aef78a, Offset: 0x20d8
// Size: 0xb4
function run_activation_func(bgb) {
    self endon(#"disconnect");
    self set_active(1);
    self do_one_shot_use();
    self notify(#"bgb_bubble_blow_complete");
    self [[ level.bgb[bgb].activation_func ]]();
    self set_active(0);
    self activation_complete();
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x4
// Checksum 0xe6fbdeb9, Offset: 0x2198
// Size: 0x54
function private bgb_get_gumball_anim_weapon(bgb, var_aad41617) {
    n_rarity = level.bgb[bgb].rarity;
    var_248d0a6e = level.var_30732406[n_rarity];
    return var_248d0a6e;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x4
// Checksum 0x63213d9c, Offset: 0x21f8
// Size: 0xd0
function private function_bb702b0a(bgb, var_aad41617) {
    w_original = self getcurrentweapon();
    weapon = bgb_get_gumball_anim_weapon(bgb, var_aad41617);
    if (self giveandfireoffhand(weapon, self calcweaponoptions(level.bgb[bgb].camo_index, 0, 0))) {
        self zm_utility::increment_is_drinking(1);
        self zm_utility::disable_player_move_states(1);
    }
    return w_original;
}

// Namespace bgb/zm_bgb
// Params 3, eflags: 0x4
// Checksum 0x7b4f2108, Offset: 0x22d0
// Size: 0x174
function private function_a4493f0e(w_original, bgb, var_aad41617) {
    assert(!w_original.isperkbottle);
    assert(w_original != level.weaponrevivetool);
    self zm_utility::enable_player_move_states();
    if (self zm_utility::is_multiple_drinking()) {
        self zm_utility::decrement_is_drinking();
        return;
    } else if (w_original != level.weaponnone && !zm_loadout::is_placeable_mine(w_original) && !zm_equipment::is_equipment_that_blocks_purchase(w_original)) {
        if (zm_loadout::is_melee_weapon(w_original)) {
            self zm_utility::decrement_is_drinking();
            return;
        }
    }
    if (!self laststand::player_is_in_laststand() && !(isdefined(self.intermission) && self.intermission)) {
        self zm_utility::decrement_is_drinking();
    }
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x4
// Checksum 0x264be9e1, Offset: 0x2450
// Size: 0x7c
function private bgb_clear_monitors_and_clientfields() {
    self notify(#"bgb_limit_monitor");
    self notify(#"bgb_activation_monitor");
    self clientfield::set_player_uimodel("zmhud.bgb_display", 0);
    self clientfield::set_player_uimodel("zmhud.bgb_activations_remaining", 0);
    self clear_timer();
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x4
// Checksum 0x736f1ebe, Offset: 0x24d8
// Size: 0x59c
function private bgb_limit_monitor() {
    self endon(#"disconnect");
    self endon(#"bgb_update");
    self notify(#"bgb_limit_monitor");
    self endon(#"bgb_limit_monitor");
    self clientfield::set_player_uimodel("zmhud.bgb_display", 1);
    self playsoundtoplayer(#"hash_56cc165edb993de8", self);
    switch (level.bgb[self.bgb].limit_type) {
    case #"activated":
        for (i = level.bgb[self.bgb].limit; i > 0; i--) {
            if (i != level.bgb[self.bgb].limit) {
                self playsoundtoplayer(#"hash_7bb31f4a25cf34a", self);
            }
            level.bgb[self.bgb].var_32fa3cb7 = i;
            if (level.bgb[self.bgb].var_336ffc4e) {
                function_497386b0();
            } else {
                self set_timer(i, level.bgb[self.bgb].limit);
            }
            self clientfield::set_player_uimodel("zmhud.bgb_activations_remaining", i);
            /#
                self thread bgb_set_debug_text(self.bgb, i);
            #/
            self waittill(#"bgb_activation");
            while (isdefined(self get_active()) && self get_active()) {
                waitframe(1);
            }
        }
        level.bgb[self.bgb].var_32fa3cb7 = 0;
        self playsoundtoplayer(#"hash_b8e60131176554b", self);
        self set_timer(0, level.bgb[self.bgb].limit);
        while (isdefined(self.bgb_activation_in_progress) && self.bgb_activation_in_progress) {
            waitframe(1);
        }
        break;
    case #"time":
        /#
            self thread bgb_set_debug_text(self.bgb);
        #/
        self thread run_timer(level.bgb[self.bgb].limit);
        self waittill(#"hash_347d2afccb8337ab");
        self playsoundtoplayer(#"hash_b8e60131176554b", self);
        break;
    case #"rounds":
        /#
            self thread bgb_set_debug_text(self.bgb);
        #/
        count = level.bgb[self.bgb].limit + 1;
        for (i = 0; i < count; i++) {
            if (i != 0) {
                self playsoundtoplayer(#"hash_7bb31f4a25cf34a", self);
            }
            self set_timer(count - i, count);
            level waittill(#"end_of_round");
        }
        self playsoundtoplayer(#"hash_b8e60131176554b", self);
        break;
    case #"event":
        /#
            self thread bgb_set_debug_text(self.bgb);
        #/
        self bgb_set_timer_clientfield(1);
        self [[ level.bgb[self.bgb].limit ]]();
        self playsoundtoplayer(#"hash_b8e60131176554b", self);
        break;
    default:
        assert(0, "<dev string:x173>" + self.bgb + "<dev string:x193>" + level.bgb[self.bgb].limit_type + "<dev string:x1a3>");
        break;
    }
    self thread take();
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x4
// Checksum 0xd2ce7df1, Offset: 0x2a80
// Size: 0x94
function private bgb_bled_out_monitor() {
    self endon(#"disconnect");
    self endon(#"bgb_update");
    self notify(#"bgb_bled_out_monitor");
    self endon(#"bgb_bled_out_monitor");
    self waittill(#"bled_out");
    self notify(#"bgb_about_to_take_on_bled_out");
    wait 0.1;
    self thread take();
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x4
// Checksum 0x6931870d, Offset: 0x2b20
// Size: 0xda
function private bgb_activation_monitor() {
    self endon(#"disconnect");
    self notify(#"bgb_activation_monitor");
    self endon(#"bgb_activation_monitor");
    if ("activated" != level.bgb[self.bgb].limit_type) {
        return;
    }
    for (;;) {
        self waittill(#"bgb_activation_request");
        waitframe(1);
        if (!self function_b616fe7a(0)) {
            continue;
        }
        if (self bgb_gumball_anim(self.bgb, 1, 0)) {
            self notify(#"bgb_activation", self.bgb);
        }
    }
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0x8c5549be, Offset: 0x2c08
// Size: 0x18c
function function_b616fe7a(var_5827b083 = 0, str_check = self.bgb) {
    var_bb1d9487 = isdefined(level.bgb[str_check].validation_func) && !self [[ level.bgb[str_check].validation_func ]]();
    var_847ec8da = isdefined(level.var_9cef605e) && !self [[ level.var_9cef605e ]]();
    if (!var_5827b083 && isdefined(self.is_drinking) && self.is_drinking || isdefined(self.bgb_activation_in_progress) && self.bgb_activation_in_progress && !(isdefined(self.var_ed99bdee) && self.var_ed99bdee) || self laststand::player_is_in_laststand() || var_bb1d9487 || var_847ec8da || isdefined(self.var_56c7266a) && self.var_56c7266a || isdefined(self.var_f5a65081) && self.var_f5a65081) {
        self clientfield::increment_uimodel("zmhud.bgb_invalid_use");
        return false;
    }
    return true;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x4
// Checksum 0xbb4bf249, Offset: 0x2da0
// Size: 0xbc
function private function_5fc6d844(bgb) {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_update");
    if (isdefined(level.bgb[bgb].var_50fe45f6) && level.bgb[bgb].var_50fe45f6) {
        function_650ca64(6);
    } else {
        return;
    }
    self waittill(#"bgb_activation_request");
    self thread take();
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0x59fa3e4, Offset: 0x2e68
// Size: 0x4c
function function_650ca64(n_value) {
    self setactionslot(1, "bgb");
    self clientfield::set_player_uimodel("zmhud.bgb_activations_remaining", n_value);
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0xa9155512, Offset: 0x2ec0
// Size: 0x2c
function function_eabb0903(n_value) {
    self clientfield::set_player_uimodel("zmhud.bgb_activations_remaining", 0);
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0x9277b4d, Offset: 0x2ef8
// Size: 0x2a
function function_336ffc4e(name) {
    level.bgb[name].var_336ffc4e = 1;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0xe4c2ce99, Offset: 0x2f30
// Size: 0x8c
function do_one_shot_use(skip_demo_bookmark = 0) {
    self clientfield::increment_uimodel("zmhud.bgb_one_shot_use");
    if (!skip_demo_bookmark) {
        demo::bookmark(#"zm_player_bgb_activate", gettime(), self);
        potm::bookmark(#"zm_player_bgb_activate", gettime(), self);
    }
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0x8607b53c, Offset: 0x2fc8
// Size: 0x12
function activation_start() {
    self.bgb_activation_in_progress = 1;
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x4
// Checksum 0xbb5be5b7, Offset: 0x2fe8
// Size: 0x1e
function private activation_complete() {
    self.bgb_activation_in_progress = 0;
    self notify(#"activation_complete");
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x4
// Checksum 0x95596a6f, Offset: 0x3010
// Size: 0x1a
function private set_active(b_is_active) {
    self.bgb_active = b_is_active;
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0xcdd248a8, Offset: 0x3038
// Size: 0x18
function get_active() {
    return isdefined(self.bgb_active) && self.bgb_active;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0xe3a92f91, Offset: 0x3058
// Size: 0x42
function is_active(name) {
    if (!isdefined(self.bgb)) {
        return false;
    }
    return self.bgb == name && isdefined(self.bgb_active) && self.bgb_active;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0xb10a8948, Offset: 0x30a8
// Size: 0x92
function is_team_active(name) {
    foreach (player in level.players) {
        if (player is_active(name)) {
            return true;
        }
    }
    return false;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0x2865dc89, Offset: 0x3148
// Size: 0x64
function increment_ref_count(name) {
    if (!isdefined(level.bgb[name])) {
        return 0;
    }
    var_ad8303b0 = level.bgb[name].ref_count;
    level.bgb[name].ref_count++;
    return var_ad8303b0;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0x895f64d6, Offset: 0x31b8
// Size: 0x56
function decrement_ref_count(name) {
    if (!isdefined(level.bgb[name])) {
        return 0;
    }
    level.bgb[name].ref_count--;
    return level.bgb[name].ref_count;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x4
// Checksum 0xfb53c5b9, Offset: 0x3218
// Size: 0x92
function private calc_remaining_duration_lerp(start_time, end_time) {
    if (0 >= end_time - start_time) {
        return 0;
    }
    now = gettime();
    frac = float(end_time - now) / float(end_time - start_time);
    return math::clamp(frac, 0, 1);
}

// Namespace bgb/zm_bgb
// Params 3, eflags: 0x4
// Checksum 0x98a1336a, Offset: 0x32b8
// Size: 0x122
function private function_f9fad8b3(var_eeab9300, percent, var_31d0846 = 0) {
    self endon(#"disconnect");
    self endon(#"hash_6ae783a3051b411b");
    if (var_31d0846) {
        self.var_ab183ec2 = 1;
    }
    start_time = gettime();
    end_time = start_time + 1000;
    var_6d8b0ec7 = var_eeab9300;
    while (var_6d8b0ec7 > percent) {
        var_6d8b0ec7 = lerpfloat(percent, var_eeab9300, calc_remaining_duration_lerp(start_time, end_time));
        self clientfield::set_player_uimodel("zmhud.bgb_timer", var_6d8b0ec7);
        waitframe(1);
    }
    if (var_31d0846) {
        self.var_8e164588 = var_6d8b0ec7;
        self.var_ab183ec2 = undefined;
    }
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x4
// Checksum 0x93fa44c8, Offset: 0x33e8
// Size: 0xc4
function private bgb_set_timer_clientfield(percent, var_31d0846 = 0) {
    self notify(#"hash_6ae783a3051b411b");
    var_eeab9300 = self clientfield::get_player_uimodel("zmhud.bgb_timer");
    if (percent < var_eeab9300 && 0.1 <= var_eeab9300 - percent) {
        self thread function_f9fad8b3(var_eeab9300, percent, var_31d0846);
        return;
    }
    self clientfield::set_player_uimodel("zmhud.bgb_timer", percent);
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x4
// Checksum 0x589bf7c0, Offset: 0x34b8
// Size: 0x1c
function private function_497386b0() {
    self bgb_set_timer_clientfield(1);
}

// Namespace bgb/zm_bgb
// Params 3, eflags: 0x0
// Checksum 0x318382e8, Offset: 0x34e0
// Size: 0x64
function set_timer(current, max, var_31d0846 = 0) {
    if (!(isdefined(self.var_ab183ec2) && self.var_ab183ec2)) {
        self bgb_set_timer_clientfield(current / max, var_31d0846);
    }
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0x368b64d3, Offset: 0x3550
// Size: 0x126
function run_timer(max) {
    self endon(#"disconnect");
    self notify(#"bgb_run_timer");
    self endon(#"bgb_run_timer");
    current = max;
    self.var_ed99bdee = 1;
    while (current > 0) {
        self set_timer(current, max);
        waitframe(1);
        if (isdefined(self.var_8e164588)) {
            current = max * self.var_8e164588;
            self.var_8e164588 = undefined;
            continue;
        }
        current -= float(function_f9f48566()) / 1000;
    }
    self notify(#"hash_347d2afccb8337ab");
    self clear_timer();
    self.var_ed99bdee = undefined;
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0x25ffc85f, Offset: 0x3680
// Size: 0x2e
function clear_timer() {
    self bgb_set_timer_clientfield(0);
    self notify(#"bgb_run_timer");
}

// Namespace bgb/zm_bgb
// Params 7, eflags: 0x0
// Checksum 0xcf408732, Offset: 0x36b8
// Size: 0x54e
function register(name, limit_type, limit, enable_func, disable_func, validation_func, activation_func) {
    assert(isdefined(name), "<dev string:x1b6>");
    assert(#"none" != name, "<dev string:x1dc>" + #"none" + "<dev string:x1fe>");
    assert(!isdefined(level.bgb[name]), "<dev string:x235>" + name + "<dev string:x24c>");
    assert(isdefined(limit_type), "<dev string:x235>" + name + "<dev string:x26a>");
    assert(isdefined(limit), "<dev string:x235>" + name + "<dev string:x288>");
    assert(!isdefined(enable_func) || isfunctionptr(enable_func), "<dev string:x235>" + name + "<dev string:x2a1>");
    assert(!isdefined(disable_func) || isfunctionptr(disable_func), "<dev string:x235>" + name + "<dev string:x2d8>");
    switch (limit_type) {
    case #"activated":
        assert(!isdefined(validation_func) || isfunctionptr(validation_func), "<dev string:x235>" + name + "<dev string:x310>" + limit_type + "<dev string:x35c>");
        assert(isdefined(activation_func), "<dev string:x235>" + name + "<dev string:x35e>" + limit_type + "<dev string:x35c>");
        assert(isfunctionptr(activation_func), "<dev string:x235>" + name + "<dev string:x392>" + limit_type + "<dev string:x35c>");
    case #"time":
    case #"rounds":
        assert(isint(limit), "<dev string:x235>" + name + "<dev string:x3d1>" + limit + "<dev string:x3dc>" + limit_type + "<dev string:x35c>");
        break;
    case #"event":
        assert(isfunctionptr(limit), "<dev string:x235>" + name + "<dev string:x3fe>" + limit_type + "<dev string:x35c>");
        break;
    default:
        assert(0, "<dev string:x235>" + name + "<dev string:x193>" + limit_type + "<dev string:x1a3>");
        break;
    }
    level.bgb[name] = spawnstruct();
    level.bgb[name].name = name;
    level.bgb[name].limit_type = limit_type;
    level.bgb[name].limit = limit;
    level.bgb[name].enable_func = enable_func;
    level.bgb[name].disable_func = disable_func;
    level.bgb[name].validation_func = validation_func;
    if ("activated" == limit_type) {
        level.bgb[name].activation_func = activation_func;
        level.bgb[name].var_336ffc4e = 0;
    }
    level.bgb[name].ref_count = 0;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0x4b40e2f3, Offset: 0x3c10
// Size: 0x72
function register_actor_damage_override(name, actor_damage_override_func) {
    assert(isdefined(level.bgb[name]), "<dev string:x433>" + name + "<dev string:x460>");
    level.bgb[name].actor_damage_override_func = actor_damage_override_func;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0x17f234e8, Offset: 0x3c90
// Size: 0x72
function register_vehicle_damage_override(name, vehicle_damage_override_func) {
    assert(isdefined(level.bgb[name]), "<dev string:x477>" + name + "<dev string:x460>");
    level.bgb[name].vehicle_damage_override_func = vehicle_damage_override_func;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0xf5fcf8dc, Offset: 0x3d10
// Size: 0x72
function register_actor_death_override(name, actor_death_override_func) {
    assert(isdefined(level.bgb[name]), "<dev string:x4a6>" + name + "<dev string:x460>");
    level.bgb[name].actor_death_override_func = actor_death_override_func;
}

// Namespace bgb/zm_bgb
// Params 3, eflags: 0x0
// Checksum 0x7d2e6463, Offset: 0x3d90
// Size: 0x96
function register_lost_perk_override(name, lost_perk_override_func, lost_perk_override_func_always_run) {
    assert(isdefined(level.bgb[name]), "<dev string:x4d2>" + name + "<dev string:x460>");
    level.bgb[name].lost_perk_override_func = lost_perk_override_func;
    level.bgb[name].lost_perk_override_func_always_run = lost_perk_override_func_always_run;
}

// Namespace bgb/zm_bgb
// Params 3, eflags: 0x0
// Checksum 0xea545004, Offset: 0x3e30
// Size: 0x96
function function_ff4b2998(name, add_to_player_score_override_func, add_to_player_score_override_func_always_run) {
    assert(isdefined(level.bgb[name]), "<dev string:x4fc>" + name + "<dev string:x460>");
    level.bgb[name].add_to_player_score_override_func = add_to_player_score_override_func;
    level.bgb[name].add_to_player_score_override_func_always_run = add_to_player_score_override_func_always_run;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0xaaef112f, Offset: 0x3ed0
// Size: 0x72
function function_4cda71bf(name, var_7ca0e2a7) {
    assert(isdefined(level.bgb[name]), "<dev string:x530>" + name + "<dev string:x460>");
    level.bgb[name].var_7ca0e2a7 = var_7ca0e2a7;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0x2471d318, Offset: 0x3f50
// Size: 0x72
function function_e1ef21fb(name, var_36554bf3) {
    assert(isdefined(level.bgb[name]), "<dev string:x566>" + name + "<dev string:x460>");
    level.bgb[name].var_36554bf3 = var_36554bf3;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0xc369e73, Offset: 0x3fd0
// Size: 0x72
function function_93da425(name, var_35e23ba2) {
    assert(isdefined(level.bgb[name]), "<dev string:x596>" + name + "<dev string:x460>");
    level.bgb[name].var_35e23ba2 = var_35e23ba2;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0xaf49a158, Offset: 0x4050
// Size: 0x6a
function function_2060b89(name) {
    assert(isdefined(level.bgb[name]), "<dev string:x5c2>" + name + "<dev string:x460>");
    level.bgb[name].var_50fe45f6 = 1;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0x83a2bf72, Offset: 0x40c8
// Size: 0x6a
function function_f132da9c(name) {
    assert(isdefined(level.bgb[name]), "<dev string:x5e5>" + name + "<dev string:x460>");
    level.bgb[name].var_7ea552f4 = 1;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0x3b97928b, Offset: 0x4140
// Size: 0x1ec
function give(name) {
    self thread take();
    if (#"none" == name) {
        return;
    }
    assert(isdefined(level.bgb[name]), "<dev string:x615>" + name + "<dev string:x460>");
    self notify(#"bgb_update", {#var_74b6bea2:name, #var_57733485:self.bgb});
    self notify("bgb_update_give_" + name);
    self.bgb = name;
    self clientfield::set_player_uimodel("zmhud.bgb_current", level.bgb[name].item_index);
    self luinotifyevent(#"zombie_bgb_notification", 1, level.bgb[name].item_index);
    if (isdefined(level.bgb[name].enable_func)) {
        self thread [[ level.bgb[name].enable_func ]]();
    }
    if (isdefined("activated" == level.bgb[name].limit_type)) {
        self setactionslot(1, "bgb");
    }
    self thread bgb_limit_monitor();
    self thread bgb_bled_out_monitor();
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0x52bc8e5f, Offset: 0x4338
// Size: 0x132
function take() {
    if (#"none" == self.bgb) {
        return;
    }
    self setactionslot(1, "");
    /#
        self thread bgb_set_debug_text(#"none");
    #/
    if (isdefined(level.bgb[self.bgb].disable_func)) {
        self thread [[ level.bgb[self.bgb].disable_func ]]();
    }
    self bgb_clear_monitors_and_clientfields();
    self notify(#"bgb_update", {#var_74b6bea2:#"none", #var_57733485:self.bgb});
    self notify("bgb_update_take_" + self.bgb);
    self.bgb = #"none";
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0xad88ee64, Offset: 0x4478
// Size: 0x4c
function get_enabled() {
    if (isplayer(self) && isdefined(self.bgb)) {
        return self.bgb;
    }
    return #"none";
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0xaece8345, Offset: 0x44d0
// Size: 0x38
function is_enabled(name) {
    assert(isdefined(self.bgb));
    return self.bgb == name;
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0x50c6ba7c, Offset: 0x4510
// Size: 0x3c
function any_enabled() {
    assert(isdefined(self.bgb));
    return self.bgb !== #"none";
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0x2c7c4700, Offset: 0x4558
// Size: 0xac
function is_team_enabled(bgb_name) {
    foreach (player in level.players) {
        assert(isdefined(player.bgb));
        if (player.bgb == bgb_name) {
            return true;
        }
    }
    return false;
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0x71675149, Offset: 0x4610
// Size: 0x80
function get_player_dropped_powerup_origin() {
    powerup_origin = self.origin + vectorscale(anglestoforward((0, self getplayerangles()[1], 0)), 60) + (0, 0, 5);
    self zm_stats::increment_challenge_stat("GUM_GOBBLER_POWERUPS");
    return powerup_origin;
}

// Namespace bgb/zm_bgb
// Params 3, eflags: 0x0
// Checksum 0xb36287c6, Offset: 0x4698
// Size: 0xdc
function function_dea74fb0(str_powerup, v_origin = self get_player_dropped_powerup_origin(), var_f9bb25f4) {
    e_powerup = zm_powerups::specific_powerup_drop(str_powerup, v_origin, undefined, 0.1, undefined, undefined, 1);
    wait 1;
    if (isdefined(e_powerup) && !e_powerup zm_player::in_enabled_playable_area(var_f9bb25f4) && !e_powerup zm_player::in_life_brush()) {
        level thread function_434235f9(e_powerup);
    }
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0x116f1892, Offset: 0x4780
// Size: 0x37c
function function_434235f9(e_powerup) {
    if (!isdefined(e_powerup)) {
        return;
    }
    e_powerup notify(#"powerup_stolen");
    e_powerup ghost();
    e_powerup.var_499ed1ba = util::spawn_model(e_powerup.model, e_powerup.origin, e_powerup.angles);
    e_powerup.var_499ed1ba linkto(e_powerup);
    direction = e_powerup.origin;
    direction = (direction[1], direction[0], 0);
    if (direction[1] < 0 || direction[0] > 0 && direction[1] > 0) {
        direction = (direction[0], direction[1] * -1, 0);
    } else if (direction[0] < 0) {
        direction = (direction[0] * -1, direction[1], 0);
    }
    if (!(isdefined(e_powerup.sndnosamlaugh) && e_powerup.sndnosamlaugh)) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (isalive(players[i])) {
                players[i] playlocalsound(level.zmb_laugh_alias);
            }
        }
    }
    playfxontag(level._effect[#"samantha_steal"], e_powerup, "tag_origin");
    e_powerup.var_499ed1ba unlink();
    e_powerup.var_499ed1ba movez(60, 1, 0.25, 0.25);
    e_powerup.var_499ed1ba vibrate(direction, 1.5, 2.5, 1);
    e_powerup.var_499ed1ba waittill(#"movedone");
    if (isdefined(self.damagearea)) {
        self.damagearea delete();
    }
    if (isdefined(e_powerup) && isdefined(e_powerup.var_499ed1ba)) {
        e_powerup.var_499ed1ba delete();
    }
    if (isdefined(e_powerup)) {
        if (isdefined(e_powerup.damagearea)) {
            e_powerup.damagearea delete();
        }
        e_powerup zm_powerups::powerup_delete();
    }
}

// Namespace bgb/zm_bgb
// Params 12, eflags: 0x0
// Checksum 0x95ab6520, Offset: 0x4b08
// Size: 0x15e
function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return damage;
    }
    if (isplayer(attacker)) {
        name = attacker get_enabled();
        if (name !== #"none" && isdefined(level.bgb[name]) && isdefined(level.bgb[name].actor_damage_override_func)) {
            damage = [[ level.bgb[name].actor_damage_override_func ]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
        }
    }
    return damage;
}

// Namespace bgb/zm_bgb
// Params 15, eflags: 0x0
// Checksum 0x2e5361e7, Offset: 0x4c70
// Size: 0x182
function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return idamage;
    }
    if (isplayer(eattacker)) {
        name = eattacker get_enabled();
        if (name !== #"none" && isdefined(level.bgb[name]) && isdefined(level.bgb[name].vehicle_damage_override_func)) {
            idamage = [[ level.bgb[name].vehicle_damage_override_func ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
        }
    }
    return idamage;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0xa423c2a9, Offset: 0x4e00
// Size: 0xe2
function actor_death_override(attacker) {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return 0;
    }
    if (isplayer(attacker)) {
        name = attacker get_enabled();
        if (name !== #"none" && isdefined(level.bgb[name]) && isdefined(level.bgb[name].actor_death_override_func)) {
            damage = [[ level.bgb[name].actor_death_override_func ]](attacker);
        }
    }
    return damage;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0xd7926602, Offset: 0x4ef0
// Size: 0x234
function lost_perk_override(perk) {
    b_result = 0;
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return b_result;
    }
    keys = getarraykeys(level.bgb);
    for (i = 0; i < keys.size; i++) {
        name = keys[i];
        if (isdefined(level.bgb[name].lost_perk_override_func_always_run) && level.bgb[name].lost_perk_override_func_always_run && isdefined(level.bgb[name].lost_perk_override_func)) {
            b_result = [[ level.bgb[name].lost_perk_override_func ]](perk, self, undefined);
            if (b_result) {
                return b_result;
            }
        }
    }
    foreach (player in level.activeplayers) {
        name = player get_enabled();
        if (name !== #"none" && isdefined(level.bgb[name]) && isdefined(level.bgb[name].lost_perk_override_func)) {
            b_result = [[ level.bgb[name].lost_perk_override_func ]](perk, self, player);
            if (b_result) {
                return b_result;
            }
        }
    }
    return b_result;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0x8c89618d, Offset: 0x5130
// Size: 0x1c6
function add_to_player_score_override(n_points, str_awarded_by) {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return n_points;
    }
    str_enabled = self get_enabled();
    keys = getarraykeys(level.bgb);
    for (i = 0; i < keys.size; i++) {
        str_bgb = keys[i];
        if (str_bgb === str_enabled) {
            continue;
        }
        if (isdefined(level.bgb[str_bgb].add_to_player_score_override_func_always_run) && level.bgb[str_bgb].add_to_player_score_override_func_always_run && isdefined(level.bgb[str_bgb].add_to_player_score_override_func)) {
            n_points = [[ level.bgb[str_bgb].add_to_player_score_override_func ]](n_points, str_awarded_by, 0);
        }
    }
    if (str_enabled !== #"none" && isdefined(level.bgb[str_enabled]) && isdefined(level.bgb[str_enabled].add_to_player_score_override_func)) {
        n_points = [[ level.bgb[str_enabled].add_to_player_score_override_func ]](n_points, str_awarded_by, 1);
    }
    return n_points;
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0x49aef905, Offset: 0x5300
// Size: 0xbe
function function_d51db887() {
    keys = array::randomize(getarraykeys(level.bgb));
    for (i = 0; i < keys.size; i++) {
        if (level.bgb[keys[i]].rarity != 1) {
            continue;
        }
        if (level.bgb[keys[i]].dlc_index > 0) {
            continue;
        }
        return keys[i];
    }
}

// Namespace bgb/zm_bgb
// Params 3, eflags: 0x0
// Checksum 0x1c63c24b, Offset: 0x53c8
// Size: 0x1fa
function function_4ed517b9(n_max_distance, var_98a3e738, var_287a7adb) {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_update");
    self.var_6638f10b = [];
    while (true) {
        foreach (e_player in level.players) {
            if (e_player == self) {
                continue;
            }
            array::remove_undefined(self.var_6638f10b);
            var_368e2240 = array::contains(self.var_6638f10b, e_player);
            var_50fd5a04 = zm_utility::is_player_valid(e_player, 0, 1) && function_2469cfe8(n_max_distance, self, e_player);
            if (!var_368e2240 && var_50fd5a04) {
                array::add(self.var_6638f10b, e_player, 0);
                if (isdefined(var_98a3e738)) {
                    self thread [[ var_98a3e738 ]](e_player);
                }
                continue;
            }
            if (var_368e2240 && !var_50fd5a04) {
                arrayremovevalue(self.var_6638f10b, e_player);
                if (isdefined(var_287a7adb)) {
                    self thread [[ var_287a7adb ]](e_player);
                }
            }
        }
        waitframe(1);
    }
}

// Namespace bgb/zm_bgb
// Params 3, eflags: 0x4
// Checksum 0xe1e870c3, Offset: 0x55d0
// Size: 0x7c
function private function_2469cfe8(n_distance, var_d21815c4, var_441f84ff) {
    var_31dc18aa = n_distance * n_distance;
    var_2931dc75 = distancesquared(var_d21815c4.origin, var_441f84ff.origin);
    if (var_2931dc75 <= var_31dc18aa) {
        return true;
    }
    return false;
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0x385e4fdd, Offset: 0x5658
// Size: 0x24
function function_ca189700() {
    self clientfield::increment_uimodel("zmhud.bgb_invalid_use");
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0x65a99fa5, Offset: 0x5688
// Size: 0x24
function suspend_weapon_cycling() {
    self flag::clear("bgb_weapon_cycling");
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0x80a95bf7, Offset: 0x56b8
// Size: 0x24
function resume_weapon_cycling() {
    self flag::set("bgb_weapon_cycling");
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0xc9882cbf, Offset: 0x56e8
// Size: 0x64
function init_weapon_cycling() {
    if (!self flag::exists("bgb_weapon_cycling")) {
        self flag::init("bgb_weapon_cycling");
    }
    self flag::set("bgb_weapon_cycling");
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0x2247acf7, Offset: 0x5758
// Size: 0x24
function function_378bff5d() {
    self flag::wait_till("bgb_weapon_cycling");
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0x197d6f2, Offset: 0x5788
// Size: 0x12c
function function_4eb7f9bd(e_reviver, var_471b53c6) {
    if (isdefined(self.var_df0decf1) && self.var_df0decf1 || isdefined(e_reviver) && isdefined(self.bgb) && self is_enabled(#"zm_bgb_near_death_experience") || isdefined(e_reviver.bgb) && e_reviver is_enabled(#"zm_bgb_near_death_experience") || isdefined(e_reviver) && isdefined(self.bgb) && self is_enabled(#"zm_bgb_phoenix_up") || isdefined(e_reviver.bgb) && e_reviver is_enabled(#"zm_bgb_phoenix_up") || isdefined(var_471b53c6)) {
        return true;
    }
    return false;
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0x4d3ef49f, Offset: 0x58c0
// Size: 0xa6
function bgb_revive_watcher() {
    self endon(#"disconnect");
    self endon(#"death");
    self.var_df0decf1 = 1;
    waitresult = self waittill(#"player_revived");
    e_reviver = waitresult.reviver;
    waitframe(1);
    if (isdefined(self.var_df0decf1) && self.var_df0decf1) {
        self notify(#"bgb_revive");
        self.var_df0decf1 = undefined;
    }
}

