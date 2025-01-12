#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\potm_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb_pack;
#using scripts\zm_common\zm_contracts;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace bgb;

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x6
// Checksum 0x6f208564, Offset: 0x2c8
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"bgb", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x5 linked
// Checksum 0xade987f0, Offset: 0x320
// Size: 0x2d4
function private function_70a657d8() {
    callback::on_connect(&on_player_connect);
    if (!is_true(level.bgb_in_use)) {
        return;
    }
    level.weaponbgbgrab = getweapon(#"zombie_bgb_grab");
    level.var_ddff6359 = array(getweapon(#"hash_d0f29de78e218ad"), getweapon(#"hash_5e07292c519531e6"), getweapon(#"hash_305e5faa9ecb625a"), getweapon(#"hash_23cc1f9c16b375c3"), getweapon(#"hash_155cc0a9ba3c3260"), getweapon(#"hash_2394c41f048f7d2"), getweapon(#"hash_4565adf3abc61ea3"));
    level.bgb = [];
    clientfield::register_clientuimodel("zmhud.bgb_current", 1, 8, "int", 0);
    clientfield::register_clientuimodel("zmhud.bgb_display", 1, 1, "int", 0);
    clientfield::register_clientuimodel("zmhud.bgb_timer", 1, 8, "float", 0);
    clientfield::register_clientuimodel("zmhud.bgb_activations_remaining", 1, 3, "int", 0);
    clientfield::register_clientuimodel("zmhud.bgb_invalid_use", 1, 1, "counter", 0);
    clientfield::register_clientuimodel("zmhud.bgb_one_shot_use", 1, 1, "counter", 0);
    clientfield::register("toplayer", "bgb_blow_bubble", 1, 1, "counter");
    zm::register_vehicle_damage_callback(&vehicle_damage_override);
    zm_perks::register_lost_perk_override(&lost_perk_override);
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x5 linked
// Checksum 0xb0450f82, Offset: 0x600
// Size: 0x74
function private postinit() {
    if (!is_true(level.bgb_in_use)) {
        return;
    }
    bgb_finalize();
    /#
        level thread setup_devgui();
    #/
    level._effect[#"samantha_steal"] = #"zombie/fx_monkey_lightning_zmb";
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x5 linked
// Checksum 0x87728bb0, Offset: 0x680
// Size: 0x56
function private on_player_connect() {
    self.bgb = #"none";
    if (!is_true(level.bgb_in_use)) {
        return;
    }
    self thread bgb_player_init();
    self.var_1898de24 = [];
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x5 linked
// Checksum 0xba8c43d5, Offset: 0x6e0
// Size: 0x740
function private bgb_player_init() {
    if (isdefined(self.bgb_pack)) {
        for (i = 0; i < 4; i++) {
            if (isdefined(self.bgb_pack[i]) && isdefined(level.bgb[self.bgb_pack[i]])) {
                self bgb_pack::function_7b91e81c(i, level.bgb[self.bgb_pack[i]].item_index);
            }
        }
        return;
    }
    self.bgb_pack = self getbubblegumpack();
    for (x = 0; x < self.bgb_pack.size; x++) {
        if (isstring(self.bgb_pack[x])) {
            self.bgb_pack[x] = hash(self.bgb_pack[x]);
        }
    }
    self.bgb_pack_randomized = [];
    var_6e18a410 = array();
    for (i = 0; i < 4; i++) {
        str_bgb = self.bgb_pack[i];
        if (str_bgb == #"weapon_null") {
            continue;
        }
        if (zm_custom::function_3ac936c6(str_bgb)) {
            var_6e18a410[i] = str_bgb;
            continue;
        }
        if (str_bgb != #"weapon_null" && self getbgbremaining(str_bgb) > 0) {
            self thread zm_custom::function_deae84ba();
        }
    }
    self.bgb_pack = var_6e18a410;
    /#
        if (isdefined(self.var_d03d9cf3)) {
            self.bgb_pack = self.var_d03d9cf3;
        }
    #/
    self.bgb_stats = [];
    foreach (bgb in self.bgb_pack) {
        if (bgb == #"weapon_null") {
            continue;
        }
        if (isdefined(level.bgb) && isdefined(level.bgb[bgb]) && !is_true(level.bgb[bgb].consumable)) {
            continue;
        }
        self.bgb_stats[bgb] = spawnstruct();
        if (!isbot(self)) {
            self.bgb_stats[bgb].var_c2a984f0 = self getbgbremaining(bgb);
        } else {
            self.bgb_stats[bgb].var_c2a984f0 = 0;
        }
        self.bgb_stats[bgb].bgb_used_this_game = 0;
    }
    self init_weapon_cycling();
    self thread bgb_player_monitor();
    self thread bgb_end_game();
    for (i = 0; i < 4; i++) {
        if (isdefined(self.bgb_pack[i]) && isdefined(level.bgb[self.bgb_pack[i]])) {
            self bgb_pack::function_7b91e81c(i, level.bgb[self.bgb_pack[i]].item_index);
        }
    }
    if (zm_custom::function_901b751c(#"zmelixirsdurables")) {
        var_66dd5e25 = array(#"zm_bgb_nowhere_but_there", #"zm_bgb_now_you_see_me");
        n_rank = self rank::getrank() + 1;
        foreach (bgb in level.bgb) {
            str_name = bgb.name;
            if (bgb.rarity === 0 && str_name != #"zm_bgb_point_drops" && !array::contains(self.bgb_pack, str_name)) {
                var_544e77f8 = level.bgb[str_name].var_a1750d43;
                if ((!isdefined(var_544e77f8) || isdefined(var_544e77f8) && n_rank >= var_544e77f8 || function_bea73b01() == 1) && zm_custom::function_3ac936c6(str_name)) {
                    if (!isinarray(var_66dd5e25, str_name)) {
                        if (!isdefined(self.var_2b74c8fe)) {
                            self.var_2b74c8fe = [];
                        } else if (!isarray(self.var_2b74c8fe)) {
                            self.var_2b74c8fe = array(self.var_2b74c8fe);
                        }
                        self.var_2b74c8fe[self.var_2b74c8fe.size] = str_name;
                    }
                    if (!isdefined(self.var_82971641)) {
                        self.var_82971641 = [];
                    } else if (!isarray(self.var_82971641)) {
                        self.var_82971641 = array(self.var_82971641);
                    }
                    self.var_82971641[self.var_82971641.size] = str_name;
                }
            }
        }
    }
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x5 linked
// Checksum 0x3cfed8f, Offset: 0xe28
// Size: 0x3c
function private bgb_end_game() {
    self endon(#"disconnect");
    self waittill(#"report_bgb_consumption");
    self thread take();
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x5 linked
// Checksum 0x164fa76d, Offset: 0xe70
// Size: 0x1f2
function private bgb_finalize() {
    foreach (v in level.bgb) {
        v.item_index = getitemindexfromref(v.name);
        var_ddcb67f4 = getunlockableiteminfofromindex(v.item_index, 2);
        v.stat_index = isdefined(var_ddcb67f4) && isdefined(var_ddcb67f4.var_2f8e25b8) ? var_ddcb67f4.var_2f8e25b8 : 0;
        var_5415dfb9 = function_b143666d(v.item_index, 2);
        if (!isdefined(var_ddcb67f4) || !isdefined(var_5415dfb9)) {
            println("<dev string:x38>" + v.name + "<dev string:x4a>");
            continue;
        }
        if (!isdefined(var_5415dfb9.bgbrarity)) {
            var_5415dfb9.bgbrarity = 0;
        }
        v.rarity = var_5415dfb9.bgbrarity;
        if (0 == v.rarity || 1 == v.rarity) {
            v.consumable = 0;
        } else {
            v.consumable = 1;
        }
        v.camo_index = var_5415dfb9.var_daefc551;
        v.dlc_index = var_ddcb67f4.dlc;
    }
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x5 linked
// Checksum 0xc04aeb35, Offset: 0x1070
// Size: 0xd0
function private bgb_player_monitor() {
    self endon(#"disconnect");
    while (true) {
        waitresult = level waittill(#"between_round_over", #"restart_round");
        str_return = waitresult._notify;
        if (isdefined(level.var_b77403b9)) {
            if (!is_true(self [[ level.var_b77403b9 ]]())) {
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
    // Checksum 0x8f945f35, Offset: 0x1148
    // Size: 0x254
    function private setup_devgui() {
        waittillframeend();
        setdvar(#"bgb_acquire_devgui", "<dev string:x7b>");
        setdvar(#"hash_7877ee182ba11433", -1);
        bgb_devgui_base = "<dev string:x7f>";
        keys = getarraykeys(level.bgb);
        foreach (key in keys) {
            name = function_9e72a96(level.bgb[key].name);
            adddebugcommand(bgb_devgui_base + name + "<dev string:x96>" + "<dev string:xa7>" + "<dev string:xbd>" + name + "<dev string:xc2>");
        }
        adddebugcommand(bgb_devgui_base + "<dev string:xc9>" + "<dev string:xdf>" + "<dev string:xbd>" + "<dev string:xf4>" + "<dev string:xc2>");
        for (i = 0; i < 4; i++) {
            playernum = i + 1;
            adddebugcommand(bgb_devgui_base + "<dev string:xfa>" + playernum + "<dev string:x10c>" + "<dev string:xdf>" + "<dev string:xbd>" + i + "<dev string:xc2>");
        }
        level thread bgb_devgui_think();
    }

    // Namespace bgb/zm_bgb
    // Params 0, eflags: 0x4
    // Checksum 0x6a5ef732, Offset: 0x13a8
    // Size: 0x90
    function private bgb_devgui_think() {
        for (;;) {
            var_522737d6 = getdvarstring(#"bgb_acquire_devgui");
            if (var_522737d6 != "<dev string:x7b>") {
                bgb_devgui_acquire(var_522737d6);
            }
            setdvar(#"bgb_acquire_devgui", "<dev string:x7b>");
            wait 0.5;
        }
    }

    // Namespace bgb/zm_bgb
    // Params 1, eflags: 0x4
    // Checksum 0x6f1527dc, Offset: 0x1440
    // Size: 0x13c
    function private bgb_devgui_acquire(bgb_name) {
        bgb_name = hash(bgb_name);
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
            players[i] bgb_gumball_anim(bgb_name);
            if (isdefined(level.bgb[bgb_name].activation_func)) {
                players[i] thread run_activation_func(bgb_name);
            }
        }
    }

    // Namespace bgb/zm_bgb
    // Params 0, eflags: 0x4
    // Checksum 0x16f59c22, Offset: 0x1588
    // Size: 0x142
    function private bgb_debug_text_display_init() {
        self.bgb_debug_text = newdebughudelem(self);
        self.bgb_debug_text.elemtype = "<dev string:x117>";
        self.bgb_debug_text.font = "<dev string:x11f>";
        self.bgb_debug_text.fontscale = 1.8;
        self.bgb_debug_text.horzalign = "<dev string:x12c>";
        self.bgb_debug_text.vertalign = "<dev string:x134>";
        self.bgb_debug_text.alignx = "<dev string:x12c>";
        self.bgb_debug_text.aligny = "<dev string:x134>";
        self.bgb_debug_text.x = 15;
        self.bgb_debug_text.y = 35;
        self.bgb_debug_text.sort = 2;
        self.bgb_debug_text.color = (1, 1, 1);
        self.bgb_debug_text.alpha = 1;
        self.bgb_debug_text.hidewheninmenu = 1;
    }

    // Namespace bgb/zm_bgb
    // Params 2, eflags: 0x4
    // Checksum 0x674ea790, Offset: 0x16d8
    // Size: 0x1be
    function private bgb_set_debug_text(name, activations_remaining) {
        if (!isdefined(self.bgb_debug_text)) {
            return;
        }
        if (isdefined(activations_remaining)) {
        }
        self notify(#"bgb_set_debug_text_thread");
        self endon(#"bgb_set_debug_text_thread", #"disconnect");
        self.bgb_debug_text fadeovertime(0.05);
        self.bgb_debug_text.alpha = 1;
        prefix = "<dev string:x13b>";
        short_name = name;
        if (issubstr(name, prefix)) {
            short_name = getsubstr(name, prefix.size);
        }
        if (isdefined(activations_remaining)) {
            self.bgb_debug_text settext("<dev string:x146>" + short_name + "<dev string:x14f>" + activations_remaining + "<dev string:x174>");
        } else {
            self.bgb_debug_text settext("<dev string:x146>" + short_name);
        }
        wait 1;
        if (#"none" == name) {
            self.bgb_debug_text fadeovertime(1);
            self.bgb_debug_text.alpha = 0;
        }
    }

    // Namespace bgb/zm_bgb
    // Params 1, eflags: 0x0
    // Checksum 0xf3d0e6ea, Offset: 0x18a0
    // Size: 0x114
    function bgb_print_stats(bgb) {
        printtoprightln(function_9e72a96(bgb) + "<dev string:x17e>" + self.bgb_stats[bgb].var_c2a984f0, (1, 1, 1));
        printtoprightln(function_9e72a96(bgb) + "<dev string:x19b>" + self.bgb_stats[bgb].bgb_used_this_game, (1, 1, 1));
        n_available = self.bgb_stats[bgb].var_c2a984f0 - self.bgb_stats[bgb].bgb_used_this_game;
        printtoprightln(function_9e72a96(bgb) + "<dev string:x1b3>" + n_available, (1, 1, 1));
    }

#/

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x5 linked
// Checksum 0x90c01c14, Offset: 0x19c0
// Size: 0x58
function private has_consumable_bgb(bgb) {
    if (!isdefined(self.bgb_stats[bgb]) || !is_true(level.bgb[bgb].consumable)) {
        return 0;
    }
    return 1;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x1 linked
// Checksum 0xcfaea173, Offset: 0x1a20
// Size: 0xd4
function sub_consumable_bgb(bgb) {
    if (!has_consumable_bgb(bgb)) {
        return;
    }
    if (isdefined(level.bgb[bgb].var_f8d9ac8c) && ![[ level.bgb[bgb].var_f8d9ac8c ]]()) {
        return;
    }
    self.bgb_stats[bgb].bgb_used_this_game++;
    if (level flag::exists("first_consumables_used")) {
        level flag::set("first_consumables_used");
    }
    /#
        bgb_print_stats(bgb);
    #/
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x1 linked
// Checksum 0x427e99dd, Offset: 0x1b00
// Size: 0xac
function get_bgb_available(bgb) {
    if (!isdefined(bgb)) {
        return false;
    }
    if (!isdefined(self.bgb_stats[bgb])) {
        return true;
    }
    var_cb4d0349 = self.bgb_stats[bgb].var_c2a984f0;
    n_bgb_used_this_game = self.bgb_stats[bgb].bgb_used_this_game;
    n_bgb_remaining = var_cb4d0349 - n_bgb_used_this_game;
    if (is_true(level.var_4af38aa3)) {
        return true;
    }
    return 0 < n_bgb_remaining;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x5 linked
// Checksum 0x35c7ddfa, Offset: 0x1bb8
// Size: 0xc4
function private function_b331a28c(bgb) {
    if (!is_true(level.bgb[bgb].var_50206ca3)) {
        return;
    }
    self val::set(#"bgb_activation", "takedamage", 0);
    s_result = self waittilltimeout(2, #"bgb_bubble_blow_complete");
    if (isdefined(self)) {
        self val::reset(#"bgb_activation", "takedamage");
    }
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x5 linked
// Checksum 0xfc0d13ce, Offset: 0x1c88
// Size: 0x72
function private function_1f3eb76f(bgb) {
    if (!is_true(level.bgb[bgb].var_f1f46d6b)) {
        return;
    }
    self.var_e75517b1 = 1;
    self waittilltimeout(2, #"bgb_bubble_blow_complete");
    if (isdefined(self)) {
        self.var_e75517b1 = 0;
    }
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x1 linked
// Checksum 0xfe4ca8a1, Offset: 0x1d08
// Size: 0x2b0
function bgb_gumball_anim(bgb) {
    self endon(#"disconnect");
    level endon(#"end_game");
    if (self isinmovemode("ufo", "noclip")) {
        return false;
    }
    if (self laststand::player_is_in_laststand()) {
        return false;
    }
    weapon = bgb_get_gumball_anim_weapon(bgb);
    if (!isdefined(weapon)) {
        return false;
    }
    while (self isswitchingweapons() || self isusingoffhand() || self isthrowinggrenade() || self ismeleeing() || self function_61efcfe5() || self function_f071483d()) {
        waitframe(1);
    }
    while (is_true(self.var_1d940ef6)) {
        waitframe(1);
    }
    while (self getcurrentweapon() == level.weaponnone) {
        waitframe(1);
    }
    weapon_options = self function_6eff28b5(level.bgb[bgb].camo_index, 0, 0);
    self thread gestures::function_f3e2696f(bgb, weapon, weapon_options, 2.5, &function_16670e75, &function_3b2a02d8, &function_62f40b0d);
    while (self isswitchingweapons()) {
        waitframe(1);
    }
    evt = self waittilltimeout(3, #"hash_593f920e9efd2ecd", #"bgb_gumball_anim_give");
    if (isdefined(evt) && evt.bgb === bgb) {
        if (evt._notify == #"bgb_gumball_anim_give") {
            return true;
        }
    }
    return false;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x1 linked
// Checksum 0xc9e052af, Offset: 0x1fc0
// Size: 0x14c
function function_a6c704c(bgb) {
    self endon(#"disconnect");
    level endon(#"end_game");
    self thread function_b331a28c(bgb);
    self thread function_1f3eb76f(bgb);
    util::delay(#"offhand_fire", "death", &zm_audio::create_and_play_dialog, #"elixir", #"drink");
    if (is_true(level.bgb[bgb].var_4a9b0cdc) || self function_e98aa964(1)) {
        self notify(#"hash_27b238d082f65849", bgb);
        self activation_start();
        self thread run_activation_func(bgb);
        return true;
    }
    return false;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x1 linked
// Checksum 0xc8118820, Offset: 0x2118
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
// Params 1, eflags: 0x5 linked
// Checksum 0x249b2350, Offset: 0x21d8
// Size: 0x7c
function private bgb_get_gumball_anim_weapon(bgb) {
    var_ab8d8da3 = undefined;
    if (isdefined(level.bgb[bgb])) {
        n_rarity = level.bgb[bgb].rarity;
        if (isdefined(level.var_ddff6359) && isdefined(n_rarity)) {
            var_ab8d8da3 = level.var_ddff6359[n_rarity];
        }
    }
    return var_ab8d8da3;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x1 linked
// Checksum 0xbf5e8958, Offset: 0x2260
// Size: 0x5c
function function_16670e75(bgb) {
    if (!isdefined(self)) {
        return;
    }
    if (self laststand::player_is_in_laststand()) {
        return;
    }
    self thread function_b331a28c(bgb);
    self thread function_1f3eb76f(bgb);
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x1 linked
// Checksum 0x49d39266, Offset: 0x22c8
// Size: 0x2d4
function function_3b2a02d8(bgb) {
    if (!isdefined(self)) {
        return;
    }
    if (self laststand::player_is_in_laststand()) {
        return;
    }
    self notify(#"bgb_gumball_anim_give", {#bgb:bgb});
    self thread give(bgb);
    zm_audio::create_and_play_dialog(#"elixir", #"drink");
    self zm_stats::increment_client_stat("bgbs_chewed");
    self zm_stats::increment_player_stat("bgbs_chewed");
    self zm_stats::increment_challenge_stat(#"gum_gobbler_consume");
    self zm_stats::function_8f10788e("boas_bgbs_chewed");
    self zm_stats::function_c0c6ab19(#"hash_67f429ee3f93764d");
    if (level.bgb[bgb].rarity > 0) {
        self zm_stats::increment_challenge_stat(#"hash_41d41d501c70fb30");
    }
    self stats::inc_stat(#"bgb_stats", bgb, #"used", #"statvalue", 1);
    health = 0;
    if (isdefined(self.health)) {
        health = self.health;
    }
    if (is_true(level.bgb[bgb].consumable)) {
        self luinotifyevent(#"zombie_bgb_used", 1, level.bgb[bgb].item_index);
    }
    self recordmapevent(4, gettime(), self.origin, level.round_number, level.bgb[bgb].stat_index, health);
    demo::bookmark(#"zm_player_bgb_grab", gettime(), self);
    potm::bookmark(#"zm_player_bgb_grab", gettime(), self);
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x1 linked
// Checksum 0xf4c0682c, Offset: 0x25a8
// Size: 0x46
function function_62f40b0d(bgb, *var_f3b15ce0) {
    if (!isdefined(self)) {
        return;
    }
    self notify(#"hash_593f920e9efd2ecd", {#bgb:var_f3b15ce0});
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x5 linked
// Checksum 0x20051a2f, Offset: 0x25f8
// Size: 0x7c
function private bgb_clear_monitors_and_clientfields() {
    self notify(#"bgb_limit_monitor");
    self notify(#"bgb_activation_monitor");
    self clientfield::set_player_uimodel("zmhud.bgb_display", 0);
    self clientfield::set_player_uimodel("zmhud.bgb_activations_remaining", 0);
    self clear_timer();
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x5 linked
// Checksum 0x37b50f91, Offset: 0x2680
// Size: 0x5cc
function private bgb_limit_monitor() {
    self notify(#"bgb_limit_monitor");
    self endon(#"bgb_limit_monitor", #"death", #"bgb_update");
    self clientfield::set_player_uimodel("zmhud.bgb_display", 1);
    self playsoundtoplayer(#"hash_56cc165edb993de8", self);
    switch (level.bgb[self.bgb].limit_type) {
    case #"activated":
        for (i = level.bgb[self.bgb].limit; i > 0; i--) {
            if (i != level.bgb[self.bgb].limit) {
                self playsoundtoplayer(#"hash_7bb31f4a25cf34a", self);
            }
            level.bgb[self.bgb].var_dbe7d224 = i;
            if (level.bgb[self.bgb].var_57eb02e) {
                function_f0d592c9();
            } else {
                self set_timer(i, level.bgb[self.bgb].limit);
            }
            self clientfield::set_player_uimodel("zmhud.bgb_activations_remaining", i);
            /#
                self thread bgb_set_debug_text(self.bgb, i);
            #/
            self waittill(#"bgb_activation");
            while (is_true(self get_active())) {
                waitframe(1);
            }
        }
        if (isdefined(self.bgb) && isdefined(level.bgb[self.bgb])) {
            level.bgb[self.bgb].var_dbe7d224 = 0;
        }
        self playsoundtoplayer(#"hash_b8e60131176554b", self);
        if (isdefined(self.bgb) && isdefined(level.bgb[self.bgb])) {
            self set_timer(0, level.bgb[self.bgb].limit);
        }
        while (is_true(self.bgb_activation_in_progress)) {
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
        assert(0, "<dev string:x1c3>" + self.bgb + "<dev string:x1e6>" + level.bgb[self.bgb].limit_type + "<dev string:x1f9>");
        break;
    }
    self thread take();
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x5 linked
// Checksum 0xa3d349c7, Offset: 0x2c58
// Size: 0x94
function private bgb_bled_out_monitor() {
    self endon(#"disconnect", #"bgb_update");
    self notify(#"bgb_bled_out_monitor");
    self endon(#"bgb_bled_out_monitor");
    self waittill(#"bled_out");
    self notify(#"bgb_about_to_take_on_bled_out");
    wait 0.1;
    self thread take();
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x4
// Checksum 0x3d6a9b6, Offset: 0x2cf8
// Size: 0xd2
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
        if (!self function_e98aa964(0)) {
            continue;
        }
        if (self function_a6c704c(self.bgb)) {
            self notify(#"bgb_activation", self.bgb);
        }
    }
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x1 linked
// Checksum 0x955e5ddb, Offset: 0x2dd8
// Size: 0x1a4
function function_e98aa964(var_3e37f503 = 0, var_8593b089 = self.bgb) {
    var_ceb582a8 = isdefined(level.bgb[var_8593b089].validation_func) && !self [[ level.bgb[var_8593b089].validation_func ]]();
    var_e6b14ccc = isdefined(level.var_67713b46) && !self [[ level.var_67713b46 ]]();
    if (!var_3e37f503 && is_true(self.is_drinking) || is_true(self.bgb_activation_in_progress) && !is_true(self.var_ec8a9710) || self laststand::player_is_in_laststand() || var_ceb582a8 || var_e6b14ccc || is_true(self.var_16735873) || is_true(self.var_30cbff55)) {
        self clientfield::increment_uimodel("zmhud.bgb_invalid_use");
        return false;
    }
    return true;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x4
// Checksum 0x5ff9a549, Offset: 0x2f88
// Size: 0xac
function private function_1fdcef80(bgb) {
    self endon(#"disconnect", #"bled_out", #"bgb_update");
    if (is_true(level.bgb[bgb].var_5a047886)) {
        function_9c8e12d1(6);
    } else {
        return;
    }
    self waittill(#"bgb_activation_request");
    self thread take();
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x1 linked
// Checksum 0x8a9a43fe, Offset: 0x3040
// Size: 0x4c
function function_9c8e12d1(n_value) {
    self setactionslot(1, "bgb");
    self clientfield::set_player_uimodel("zmhud.bgb_activations_remaining", n_value);
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0xd3cc1c59, Offset: 0x3098
// Size: 0x2c
function function_f37655df(*n_value) {
    self clientfield::set_player_uimodel("zmhud.bgb_activations_remaining", 0);
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0x7eb49b40, Offset: 0x30d0
// Size: 0x2a
function function_57eb02e(name) {
    level.bgb[name].var_57eb02e = 1;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x1 linked
// Checksum 0x4a376611, Offset: 0x3108
// Size: 0x8c
function do_one_shot_use(skip_demo_bookmark = 0) {
    self clientfield::increment_uimodel("zmhud.bgb_one_shot_use");
    if (!skip_demo_bookmark) {
        demo::bookmark(#"zm_player_bgb_activate", gettime(), self);
        potm::bookmark(#"zm_player_bgb_activate", gettime(), self);
    }
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x1 linked
// Checksum 0x767a3ddb, Offset: 0x31a0
// Size: 0x12
function activation_start() {
    self.bgb_activation_in_progress = 1;
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x5 linked
// Checksum 0xd4349f26, Offset: 0x31c0
// Size: 0x1e
function private activation_complete() {
    self.bgb_activation_in_progress = 0;
    self notify(#"activation_complete");
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x5 linked
// Checksum 0x331024af, Offset: 0x31e8
// Size: 0x1a
function private set_active(b_is_active) {
    self.bgb_active = b_is_active;
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x1 linked
// Checksum 0xc3bba60e, Offset: 0x3210
// Size: 0x1a
function get_active() {
    return is_true(self.bgb_active);
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x1 linked
// Checksum 0x27ffed64, Offset: 0x3238
// Size: 0x44
function is_active(name) {
    if (!isdefined(self.bgb)) {
        return false;
    }
    return self.bgb == name && is_true(self.bgb_active);
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0x36dcd7ac, Offset: 0x3288
// Size: 0xa2
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
// Checksum 0xd84eeff1, Offset: 0x3338
// Size: 0x64
function increment_ref_count(name) {
    if (!isdefined(level.bgb[name])) {
        return 0;
    }
    var_d1efe11 = level.bgb[name].ref_count;
    level.bgb[name].ref_count++;
    return var_d1efe11;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0xea549041, Offset: 0x33a8
// Size: 0x56
function decrement_ref_count(name) {
    if (!isdefined(level.bgb[name])) {
        return 0;
    }
    level.bgb[name].ref_count--;
    return level.bgb[name].ref_count;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x5 linked
// Checksum 0x66990ae1, Offset: 0x3408
// Size: 0x8a
function private calc_remaining_duration_lerp(start_time, end_time) {
    if (0 >= end_time - start_time) {
        return 0;
    }
    now = gettime();
    frac = float(end_time - now) / float(end_time - start_time);
    return math::clamp(frac, 0, 1);
}

// Namespace bgb/zm_bgb
// Params 3, eflags: 0x5 linked
// Checksum 0xd1e92119, Offset: 0x34a0
// Size: 0x112
function private function_af43111c(var_f205d85d, percent, var_5f12e334 = 0) {
    self endon(#"disconnect", #"hash_6ae783a3051b411b");
    if (var_5f12e334) {
        self.var_4b0fb2fb = 1;
    }
    start_time = gettime();
    end_time = start_time + 1000;
    var_2cd46f25 = var_f205d85d;
    while (var_2cd46f25 > percent) {
        var_2cd46f25 = lerpfloat(percent, var_f205d85d, calc_remaining_duration_lerp(start_time, end_time));
        self clientfield::set_player_uimodel("zmhud.bgb_timer", var_2cd46f25);
        waitframe(1);
    }
    if (var_5f12e334) {
        self.var_76c47001 = var_2cd46f25;
        self.var_4b0fb2fb = undefined;
    }
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x5 linked
// Checksum 0xaf7f53c7, Offset: 0x35c0
// Size: 0xb4
function private bgb_set_timer_clientfield(percent, var_5f12e334 = 0) {
    self notify(#"hash_6ae783a3051b411b");
    var_f205d85d = self clientfield::get_player_uimodel("zmhud.bgb_timer");
    if (percent < var_f205d85d && 0.1 <= var_f205d85d - percent) {
        self thread function_af43111c(var_f205d85d, percent, var_5f12e334);
        return;
    }
    self clientfield::set_player_uimodel("zmhud.bgb_timer", percent);
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x5 linked
// Checksum 0xf4056219, Offset: 0x3680
// Size: 0x1c
function private function_f0d592c9() {
    self bgb_set_timer_clientfield(1);
}

// Namespace bgb/zm_bgb
// Params 3, eflags: 0x1 linked
// Checksum 0x707d1e49, Offset: 0x36a8
// Size: 0x64
function set_timer(current, max, var_5f12e334 = 0) {
    if (!is_true(self.var_4b0fb2fb)) {
        self bgb_set_timer_clientfield(current / max, var_5f12e334);
    }
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x1 linked
// Checksum 0x57433bd7, Offset: 0x3718
// Size: 0x13e
function run_timer(max) {
    self endon(#"disconnect");
    self notify(#"bgb_run_timer");
    self endon(#"bgb_run_timer");
    current = max;
    self.var_ec8a9710 = 1;
    while (current > 0) {
        self set_timer(current, max);
        waitframe(1);
        if (isdefined(self.var_76c47001)) {
            current = max * self.var_76c47001;
            self.var_76c47001 = undefined;
            continue;
        }
        if (!is_true(self.var_4b0fb2fb)) {
            current -= float(function_60d95f53()) / 1000;
        }
    }
    self notify(#"hash_347d2afccb8337ab");
    self clear_timer();
    self.var_ec8a9710 = undefined;
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x1 linked
// Checksum 0xb5f64e99, Offset: 0x3860
// Size: 0x2e
function clear_timer() {
    self bgb_set_timer_clientfield(0);
    self notify(#"bgb_run_timer");
}

// Namespace bgb/zm_bgb
// Params 7, eflags: 0x1 linked
// Checksum 0x2546c9e8, Offset: 0x3898
// Size: 0x52e
function register(name, limit_type, limit, enable_func, disable_func, validation_func, activation_func) {
    assert(isdefined(name), "<dev string:x20f>");
    assert(#"none" != name, "<dev string:x238>" + #"none" + "<dev string:x25d>");
    assert(!isdefined(level.bgb[name]), "<dev string:x297>" + name + "<dev string:x2b1>");
    assert(isdefined(limit_type), "<dev string:x297>" + name + "<dev string:x2d2>");
    assert(isdefined(limit), "<dev string:x297>" + name + "<dev string:x2f3>");
    assert(!isdefined(enable_func) || isfunctionptr(enable_func), "<dev string:x297>" + name + "<dev string:x30f>");
    assert(!isdefined(disable_func) || isfunctionptr(disable_func), "<dev string:x297>" + name + "<dev string:x349>");
    switch (limit_type) {
    case #"activated":
        assert(!isdefined(validation_func) || isfunctionptr(validation_func), "<dev string:x297>" + name + "<dev string:x384>" + limit_type + "<dev string:x3d3>");
        assert(isdefined(activation_func), "<dev string:x297>" + name + "<dev string:x3d8>" + limit_type + "<dev string:x3d3>");
        assert(isfunctionptr(activation_func), "<dev string:x297>" + name + "<dev string:x40f>" + limit_type + "<dev string:x3d3>");
    case #"time":
    case #"rounds":
        assert(isint(limit), "<dev string:x297>" + name + "<dev string:x451>" + limit + "<dev string:x45f>" + limit_type + "<dev string:x3d3>");
        break;
    case #"event":
        assert(isfunctionptr(limit), "<dev string:x297>" + name + "<dev string:x484>" + limit_type + "<dev string:x3d3>");
        break;
    default:
        assert(0, "<dev string:x297>" + name + "<dev string:x1e6>" + limit_type + "<dev string:x1f9>");
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
        level.bgb[name].var_57eb02e = 0;
    }
    level.bgb[name].ref_count = 0;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0x9ae9a850, Offset: 0x3dd0
// Size: 0x6e
function register_actor_damage_override(name, actor_damage_override_func) {
    assert(isdefined(level.bgb[name]), "<dev string:x4bc>" + name + "<dev string:x4ec>");
    level.bgb[name].actor_damage_override_func = actor_damage_override_func;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0x840f5b56, Offset: 0x3e48
// Size: 0x6e
function register_vehicle_damage_override(name, vehicle_damage_override_func) {
    assert(isdefined(level.bgb[name]), "<dev string:x506>" + name + "<dev string:x4ec>");
    level.bgb[name].vehicle_damage_override_func = vehicle_damage_override_func;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0x837831c, Offset: 0x3ec0
// Size: 0x6e
function register_actor_death_override(name, actor_death_override_func) {
    assert(isdefined(level.bgb[name]), "<dev string:x538>" + name + "<dev string:x4ec>");
    level.bgb[name].actor_death_override_func = actor_death_override_func;
}

// Namespace bgb/zm_bgb
// Params 3, eflags: 0x0
// Checksum 0x3ad611bf, Offset: 0x3f38
// Size: 0x8e
function register_lost_perk_override(name, lost_perk_override_func, lost_perk_override_func_always_run) {
    assert(isdefined(level.bgb[name]), "<dev string:x567>" + name + "<dev string:x4ec>");
    level.bgb[name].lost_perk_override_func = lost_perk_override_func;
    level.bgb[name].lost_perk_override_func_always_run = lost_perk_override_func_always_run;
}

// Namespace bgb/zm_bgb
// Params 3, eflags: 0x0
// Checksum 0xfc55cf73, Offset: 0x3fd0
// Size: 0x8e
function function_c2721e81(name, add_to_player_score_override_func, add_to_player_score_override_func_always_run) {
    assert(isdefined(level.bgb[name]), "<dev string:x594>" + name + "<dev string:x4ec>");
    level.bgb[name].add_to_player_score_override_func = add_to_player_score_override_func;
    level.bgb[name].add_to_player_score_override_func_always_run = add_to_player_score_override_func_always_run;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0x8359ea8f, Offset: 0x4068
// Size: 0x6e
function function_72469efe(name, var_50206ca3) {
    assert(isdefined(level.bgb[name]), "<dev string:x5cb>" + name + "<dev string:x4ec>");
    level.bgb[name].var_50206ca3 = var_50206ca3;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0x7d51f608, Offset: 0x40e0
// Size: 0x6e
function function_8a5d8cfb(name, var_f1f46d6b) {
    assert(isdefined(level.bgb[name]), "<dev string:x604>" + name + "<dev string:x4ec>");
    level.bgb[name].var_f1f46d6b = var_f1f46d6b;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0x6fdd321, Offset: 0x4158
// Size: 0x6e
function function_be42abb0(name, var_f8d9ac8c) {
    assert(isdefined(level.bgb[name]), "<dev string:x637>" + name + "<dev string:x4ec>");
    level.bgb[name].var_f8d9ac8c = var_f8d9ac8c;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0xa4927a85, Offset: 0x41d0
// Size: 0x6a
function function_afe7b8e7(name) {
    assert(isdefined(level.bgb[name]), "<dev string:x666>" + name + "<dev string:x4ec>");
    level.bgb[name].var_5a047886 = 1;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0x5e9d34d1, Offset: 0x4248
// Size: 0x6a
function function_e1f37ce7(name) {
    assert(isdefined(level.bgb[name]), "<dev string:x68c>" + name + "<dev string:x4ec>");
    level.bgb[name].var_4a9b0cdc = 1;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0x9e467eaa, Offset: 0x42c0
// Size: 0x9e
function function_1fee6b3(name, n_rank) {
    assert(isdefined(level.bgb[name]), "<dev string:x68c>" + name + "<dev string:x4ec>");
    assert(isdefined(n_rank), "<dev string:x6bf>" + name + "<dev string:x6e5>");
    level.bgb[name].var_a1750d43 = n_rank;
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x1 linked
// Checksum 0x3e330978, Offset: 0x4368
// Size: 0x224
function give(name) {
    self thread take();
    if (#"none" == name) {
        return;
    }
    assert(isdefined(level.bgb[name]), "<dev string:x708>" + name + "<dev string:x4ec>");
    self notify(#"bgb_update", {#var_3aee8e4:name, #var_826ddd38:self.bgb});
    self notify("bgb_update_give_" + name);
    self.bgb = name;
    self clientfield::set_player_uimodel("zmhud.bgb_current", level.bgb[name].item_index);
    self luinotifyevent(#"zombie_bgb_notification", 1, level.bgb[name].item_index);
    self luinotifyeventtospectators(#"zombie_bgb_notification", 1, level.bgb[name].item_index);
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
// Params 0, eflags: 0x1 linked
// Checksum 0x7415e263, Offset: 0x4598
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
    self notify(#"bgb_update", {#var_3aee8e4:#"none", #var_826ddd38:self.bgb});
    self notify("bgb_update_take_" + self.bgb);
    self.bgb = #"none";
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x1 linked
// Checksum 0x3152bd3a, Offset: 0x46d8
// Size: 0x4c
function get_enabled() {
    if (isplayer(self) && isdefined(self.bgb)) {
        return self.bgb;
    }
    return #"none";
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x1 linked
// Checksum 0x38eda6ce, Offset: 0x4730
// Size: 0x60
function is_enabled(name) {
    assert(isdefined(self.bgb), "<dev string:x71e>");
    if (!isdefined(self) || !isdefined(self.bgb)) {
        return false;
    }
    return self.bgb === name;
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0xf2b4e8ef, Offset: 0x4798
// Size: 0x3c
function any_enabled() {
    assert(isdefined(self.bgb));
    return self.bgb !== #"none";
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x1 linked
// Checksum 0xb45c759b, Offset: 0x47e0
// Size: 0xc4
function is_team_enabled(bgb_name) {
    foreach (player in getplayers()) {
        assert(isdefined(player.bgb));
        if (player.bgb === bgb_name) {
            return true;
        }
    }
    return false;
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x1 linked
// Checksum 0x4fc79f18, Offset: 0x48b0
// Size: 0x88
function get_player_dropped_powerup_origin() {
    powerup_origin = self.origin + vectorscale(anglestoforward((0, self getplayerangles()[1], 0)), 60) + (0, 0, 5);
    self zm_stats::increment_challenge_stat(#"gum_gobbler_powerups");
    return powerup_origin;
}

// Namespace bgb/zm_bgb
// Params 3, eflags: 0x0
// Checksum 0xf6ca2018, Offset: 0x4940
// Size: 0xbc
function function_c6cd71d5(str_powerup, v_origin, *var_22a4c702 = self get_player_dropped_powerup_origin()) {
    e_powerup = zm_powerups::specific_powerup_drop(v_origin, var_22a4c702, undefined, 0.1, undefined, undefined, 1, 1, 1, 1);
    e_powerup.var_2b5ec373 = self;
    if (isplayer(self)) {
        self zm_stats::increment_challenge_stat(#"hash_3ebae93ea866519c");
    }
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x0
// Checksum 0x2b02b3ce, Offset: 0x4a08
// Size: 0x238
function function_9d8118f5(v_origin) {
    if (!self isonground() && !self isplayerswimming()) {
        return 0;
    }
    if (!isdefined(v_origin)) {
        v_origin = self get_player_dropped_powerup_origin();
    }
    var_116b3a00 = 1;
    var_806b07bd = util::spawn_model("tag_origin", v_origin + (0, 0, 40));
    v_origin = var_806b07bd.origin;
    if (isdefined(var_806b07bd) && !var_806b07bd zm_player::in_enabled_playable_area(96) && !var_806b07bd zm_player::in_life_brush()) {
        var_116b3a00 = 0;
    }
    if (self zm_utility::function_ab9a9770() || var_806b07bd zm_utility::function_ab9a9770()) {
        var_116b3a00 = 0;
    }
    v_close = getclosestpointonnavmesh(v_origin, 128, 24);
    if (var_116b3a00 && (!isdefined(v_close) || v_close[2] - v_origin[2] > 40 / 4) && !self isplayerswimming()) {
        var_116b3a00 = 0;
    }
    if (var_116b3a00 && !is_true(bullettracepassed(self geteye(), v_origin, 0, self, undefined, 0, 1))) {
        var_116b3a00 = 0;
    }
    if (isdefined(var_806b07bd)) {
        var_806b07bd delete();
    }
    return var_116b3a00;
}

// Namespace bgb/zm_bgb
// Params 12, eflags: 0x1 linked
// Checksum 0x30271651, Offset: 0x4c48
// Size: 0x126
function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (isplayer(attacker)) {
        name = attacker get_enabled();
        if (name !== #"none" && isdefined(level.bgb[name]) && isdefined(level.bgb[name].actor_damage_override_func)) {
            damage = [[ level.bgb[name].actor_damage_override_func ]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
        }
    }
    return damage;
}

// Namespace bgb/zm_bgb
// Params 15, eflags: 0x1 linked
// Checksum 0x41a114a4, Offset: 0x4d78
// Size: 0x166
function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (!is_true(level.bgb_in_use)) {
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
// Params 1, eflags: 0x1 linked
// Checksum 0xa77e24a, Offset: 0x4ee8
// Size: 0xda
function actor_death_override(attacker) {
    if (!is_true(level.bgb_in_use)) {
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
// Params 1, eflags: 0x1 linked
// Checksum 0x3c036bff, Offset: 0x4fd0
// Size: 0x218
function lost_perk_override(perk) {
    b_result = 0;
    if (!is_true(level.bgb_in_use)) {
        return b_result;
    }
    keys = getarraykeys(level.bgb);
    for (i = 0; i < keys.size; i++) {
        name = keys[i];
        if (is_true(level.bgb[name].lost_perk_override_func_always_run) && isdefined(level.bgb[name].lost_perk_override_func)) {
            b_result = [[ level.bgb[name].lost_perk_override_func ]](perk, self, undefined);
            if (b_result) {
                return b_result;
            }
        }
    }
    foreach (player in function_a1ef346b()) {
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
// Params 2, eflags: 0x1 linked
// Checksum 0x8a4894e, Offset: 0x51f0
// Size: 0x1a2
function add_to_player_score_override(n_points, str_awarded_by) {
    if (!is_true(level.bgb_in_use)) {
        return n_points;
    }
    str_enabled = self get_enabled();
    keys = getarraykeys(level.bgb);
    for (i = 0; i < keys.size; i++) {
        str_bgb = keys[i];
        if (str_bgb === str_enabled) {
            continue;
        }
        if (is_true(level.bgb[str_bgb].add_to_player_score_override_func_always_run) && isdefined(level.bgb[str_bgb].add_to_player_score_override_func)) {
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
// Checksum 0xd0a3b400, Offset: 0x53a0
// Size: 0xac
function function_3fa57f3f() {
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
// Checksum 0x8592b7b2, Offset: 0x5458
// Size: 0x20a
function function_f51e3503(n_max_distance, var_5250f4f6, var_8bc18989) {
    self endon(#"disconnect", #"bled_out", #"bgb_update");
    self.var_9c42f3fe = [];
    while (true) {
        foreach (e_player in level.players) {
            if (e_player == self) {
                continue;
            }
            arrayremovevalue(self.var_9c42f3fe, undefined);
            var_fd14be26 = array::contains(self.var_9c42f3fe, e_player);
            var_d9cac58e = zm_utility::is_player_valid(e_player, 0, 1) && function_b70b2809(n_max_distance, self, e_player);
            if (!var_fd14be26 && var_d9cac58e) {
                array::add(self.var_9c42f3fe, e_player, 0);
                if (isdefined(var_5250f4f6)) {
                    self thread [[ var_5250f4f6 ]](e_player);
                }
                continue;
            }
            if (var_fd14be26 && !var_d9cac58e) {
                arrayremovevalue(self.var_9c42f3fe, e_player);
                if (isdefined(var_8bc18989)) {
                    self thread [[ var_8bc18989 ]](e_player);
                }
            }
        }
        waitframe(1);
    }
}

// Namespace bgb/zm_bgb
// Params 3, eflags: 0x5 linked
// Checksum 0x39671ba9, Offset: 0x5670
// Size: 0x70
function private function_b70b2809(n_distance, var_7b235bec, var_f8084a8) {
    var_8c1c6c8d = n_distance * n_distance;
    var_a91ae6d4 = distancesquared(var_7b235bec.origin, var_f8084a8.origin);
    if (var_a91ae6d4 <= var_8c1c6c8d) {
        return true;
    }
    return false;
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0x40e1391d, Offset: 0x56e8
// Size: 0x24
function function_b57e693f() {
    self clientfield::increment_uimodel("zmhud.bgb_invalid_use");
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x1 linked
// Checksum 0x3bf8cec4, Offset: 0x5718
// Size: 0x24
function suspend_weapon_cycling() {
    self flag::clear("bgb_weapon_cycling");
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x1 linked
// Checksum 0x96e4c703, Offset: 0x5748
// Size: 0x24
function resume_weapon_cycling() {
    self flag::set("bgb_weapon_cycling");
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x1 linked
// Checksum 0x722a194b, Offset: 0x5778
// Size: 0x64
function init_weapon_cycling() {
    if (!self flag::exists("bgb_weapon_cycling")) {
        self flag::init("bgb_weapon_cycling");
    }
    self flag::set("bgb_weapon_cycling");
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0x96f78796, Offset: 0x57e8
// Size: 0x24
function function_303bde69() {
    self flag::wait_till("bgb_weapon_cycling");
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0x449b214e, Offset: 0x5818
// Size: 0x13c
function function_bd839f2c(e_reviver, var_84280a99) {
    if (is_true(self.var_bdeb0f02) || isdefined(e_reviver) && isdefined(self.bgb) && self is_enabled(#"zm_bgb_near_death_experience") || isdefined(e_reviver) && isdefined(e_reviver.bgb) && e_reviver is_enabled(#"zm_bgb_near_death_experience") || isdefined(e_reviver) && isdefined(self.bgb) && self is_enabled(#"zm_bgb_phoenix_up") || isdefined(e_reviver) && isdefined(e_reviver.bgb) && e_reviver is_enabled(#"zm_bgb_phoenix_up") || isdefined(var_84280a99)) {
        return true;
    }
    return false;
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0xae555e83, Offset: 0x5960
// Size: 0x9e
function bgb_revive_watcher() {
    self endon(#"death");
    self.var_bdeb0f02 = 1;
    waitresult = self waittill(#"player_revived");
    e_reviver = waitresult.reviver;
    waitframe(1);
    if (is_true(self.var_bdeb0f02)) {
        self notify(#"bgb_revive");
        self.var_bdeb0f02 = undefined;
    }
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x1 linked
// Checksum 0x897ff13c, Offset: 0x5a08
// Size: 0x26
function function_69b88b5() {
    if (!is_true(self.ready_for_score_events)) {
        return false;
    }
    return true;
}

