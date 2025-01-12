#using script_2de5679484626dc8;
#using script_2f560596a9a134ab;
#using script_36f4be19da8eb6d0;
#using script_7f6cd71c43c45c57;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_silver_zones;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace namespace_f0b43eb5;

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x6
// Checksum 0x5ac3d83e, Offset: 0x2e0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_1c32fc6c324d3e66", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x2e9fec0, Offset: 0x328
// Size: 0x35c
function function_70a657d8() {
    if (!zm_utility::function_7ab3b826() || zm_utility::is_survival()) {
        return;
    }
    level.var_996e8a57 = zm_dac_challenges_hud::register();
    level.var_94b8d201 = [];
    level.var_572d28a8 = 0;
    level.var_d3a8f03b = 500;
    clientfield::register("scriptmover", "" + #"hash_653b5827e6fbe5f9", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_21f5fab6a3d22093", 1, 3, "int");
    clientfield::register("scriptmover", "" + #"hash_19bbbc55e95ee629", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_31bea9cf1e6f76a0", 1, getminbitcountfornum(90), "int");
    clientfield::register("toplayer", "" + #"hash_216c75103f478671", 1, 4, "int");
    level flag::init("fl_challenges_active");
    level thread function_ca842288();
    level thread function_d60e999d();
    level thread function_3770ad7d();
    /#
        level thread function_37597f29();
    #/
    callback::on_connecting(&on_player_connect);
    callback::on_ai_killed(&on_ai_killed);
    callback::on_ai_damage(&on_ai_damage);
    callback::on_player_damage(&function_52588bfe);
    callback::on_item_pickup(&on_item_pickup);
    callback::on_bleedout(&function_2bf355c2);
    callback::on_disconnect(&function_2bf355c2);
    namespace_f999c142::init();
    level.var_857878e6 = &function_857878e6;
    level.var_8b7ab859 = 1000;
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x348c72e7, Offset: 0x690
// Size: 0x474
function function_ca842288() {
    create_challenge(12, 90, undefined, undefined, #"hash_3bdcf2e3da872b82");
    create_challenge(8, 90, undefined, undefined, #"hash_36e507e5e9d08f90");
    create_challenge(9, 90, undefined, undefined, #"hash_690b442afa94cfc1");
    create_challenge(10, 90, undefined, undefined, #"hash_28ce1cda153c0a06");
    create_challenge(11, 90, undefined, undefined, #"hash_519ac5a8b2182c8a");
    create_challenge(13, 90, undefined, undefined, #"hash_7f0e608df4c4686");
    create_challenge(24, 90, undefined, #"smg_standard_t9", #"hash_87bce29b0fa2164");
    create_challenge(25, 90, undefined, #"shotgun_pump_t9", #"hash_87bce29b0fa2164");
    create_challenge(26, 90, undefined, #"pistol_burst_t9", #"hash_87bce29b0fa2164");
    create_challenge(27, 90, undefined, #"tr_damagesemi_t9", #"hash_87bce29b0fa2164");
    create_challenge(28, 90, undefined, #"sniper_standard_t9", #"hash_87bce29b0fa2164");
    create_challenge(29, 90, undefined, #"smg_heavy_t9", #"hash_87bce29b0fa2164");
    create_challenge(31, 90, undefined, undefined, #"hash_71b243b9d0bccf46");
    create_challenge(32, 90, undefined, undefined, #"hash_315bf90cd69bb944");
    create_challenge(33, 90, undefined, undefined, #"hash_50836bd59115cbda");
    create_challenge(34, 90, undefined, undefined, #"hash_3604a168f38f9e17");
    level.var_2dffd020 = 0;
    level.var_107cca82 = getent("trial_terminal", "targetname");
    level.var_107cca82 zm_unitrigger::create(&function_5586b077, 100, &function_6d69e771);
    zm_unitrigger::unitrigger_force_per_player_triggers(level.var_107cca82.s_unitrigger, 1);
    level.var_d2bdec66 = 0;
    level.var_edbe6a7f = [];
    level.var_edbe6a7f[0] = 0;
    level.var_edbe6a7f[1] = 0;
    level.var_edbe6a7f[2] = 0;
    level.var_edbe6a7f[3] = 0;
    level thread game_over();
    array::thread_all(getplayers(), &clientfield::set_to_player, "" + #"hash_216c75103f478671", 0);
    level flag::wait_till("power_on");
    level flag::set("fl_challenges_active");
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x9c53da46, Offset: 0xb10
// Size: 0x44
function on_player_connect() {
    if (!isbot(self)) {
        self.var_642ed51a = undefined;
        self.var_94041ad9 = 0;
        self thread function_73143c19();
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x76626764, Offset: 0xb60
// Size: 0x24
function function_857878e6() {
    self.var_94041ad9 = 1;
    self thread function_73143c19();
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xbc72f03e, Offset: 0xb90
// Size: 0x34c
function function_73143c19() {
    self endon(#"death");
    self.var_9e09931e = 0;
    level flag::wait_till("fl_challenges_active");
    function_111530dd();
    level.var_32e6afcd = getentarray("reward_terminal", "targetname");
    level.var_e41b2a3f = 0;
    n_index = self getentitynumber();
    if (isdefined(self.var_94041ad9) && !self.var_94041ad9) {
        if (!isdefined(level.var_edbe6a7f[n_index]) || level.var_edbe6a7f[n_index] != 0) {
            level.var_edbe6a7f[n_index] = 0;
            self thread function_2bf355c2();
        }
    }
    n_tribute = level.var_edbe6a7f[n_index];
    namespace_f999c142::set_tribute(0);
    if (n_tribute > 0 || is_active()) {
        util::wait_network_frame();
        if (n_tribute > 0) {
            self function_2bb8d916();
        }
        if (is_active()) {
            self function_432b2abf();
            self function_b4759cf8();
        }
    }
    self.var_6b3806e8 = 0;
    self.var_207f01b0 = 0;
    if (!isdefined(self.var_642ed51a)) {
        self.var_642ed51a = self function_798d2fc2();
        var_2d7950ce = getentarray(self.var_642ed51a.target, "targetname");
        foreach (target in var_2d7950ce) {
            if (target.script_noteworthy === "loot_origin") {
                self.var_642ed51a.var_e3345cac = target;
            }
            if (target.script_noteworthy === "reward_origin") {
                self.var_642ed51a.var_f693bf0b = util::spawn_model("tag_origin", target.origin, target.angles);
            }
        }
    }
    namespace_f999c142::function_ab6fd86c(self, self.var_642ed51a);
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x1d5e5302, Offset: 0xee8
// Size: 0x2b8
function function_111530dd() {
    switch (level.var_d2bdec66) {
    case 0:
        var_7b667696 = 60;
        break;
    case 1:
        var_7b667696 = 40;
        break;
    case 2:
        var_7b667696 = 20;
        break;
    default:
        var_7b667696 = 0;
        break;
    }
    n_round_number = zm_utility::get_round_number();
    if (getdvarint(#"hash_1ca7459bb8b222dd", 0) || level.var_d2bdec66 < 3 && n_round_number >= 5 && math::cointoss(var_7b667696)) {
        level.var_2dffd020 = 2;
        foreach (player in getplayers()) {
            if (player function_34ebccf9()) {
                continue;
            }
            player clientfield::set_to_player("" + #"hash_216c75103f478671", 3);
        }
        return;
    }
    level.var_2dffd020 = 1;
    foreach (player in getplayers()) {
        if (player function_34ebccf9()) {
            continue;
        }
        player clientfield::set_to_player("" + #"hash_216c75103f478671", 2);
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x55148bf5, Offset: 0x11a8
// Size: 0x54
function function_798d2fc2() {
    self endon(#"end_game");
    n_index = self getentitynumber();
    var_642ed51a = level.var_32e6afcd[n_index];
    return var_642ed51a;
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x4776c4b5, Offset: 0x1208
// Size: 0x1c
function function_2bb8d916() {
    self namespace_f999c142::function_ae2c0ba5();
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x0
// Checksum 0x6fc15c45, Offset: 0x1230
// Size: 0xac
function function_2ed00fa6(reward_terminal) {
    a_players = getplayers();
    foreach (player in a_players) {
        if (player.var_642ed51a === reward_terminal) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0xafbeff1c, Offset: 0x12e8
// Size: 0x84
function function_52588bfe(params) {
    self endon(#"end_game");
    self.var_d5e64932 = gettime() / 1000;
    amount = params.idamage;
    if (isdefined(amount)) {
        if (is_challenge_active(10)) {
            self thread function_673cba18(10, amount);
        }
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0x263d85ab, Offset: 0x1378
// Size: 0x3e4
function on_ai_killed(s_params) {
    e_player = s_params.eattacker;
    str_hit_loc = s_params.shitloc;
    weapon = s_params.weapon;
    means_of_death = s_params.smeansofdeath;
    if (isplayer(e_player)) {
        if (is_challenge_active(9)) {
            if (isdefined(weapon) && weapon.inventorytype == #"offhand") {
                level notify(#"kill_with_equipment", {#e_player:e_player, #means_of_death:means_of_death});
            }
        }
        if (is_challenge_active(24) || is_challenge_active(25) || is_challenge_active(26) || is_challenge_active(27) || is_challenge_active(28) || is_challenge_active(29)) {
            if (isdefined(weapon) && weapons::getbaseweapon(weapon) == getweapon(level.s_active_challenge.var_8edbca81)) {
                level notify(#"kill_with_weapons", {#e_player:e_player});
            }
        }
        if (is_challenge_active(13)) {
            if (isdefined(str_hit_loc)) {
                if (str_hit_loc == #"helmet" || str_hit_loc == #"head") {
                    level notify(#"zombie_challenge_kill", {#e_player:s_params.eattacker});
                }
            }
        }
        if (is_challenge_active(8)) {
            if (isdefined(weapon) && zm_weapons::is_wonder_weapon(weapon)) {
                level notify(#"kill_with_IEU", {#e_player:e_player});
            }
        }
        if (is_challenge_active(1) || is_challenge_active(2) || is_challenge_active(3) || is_challenge_active(4) || is_challenge_active(5) || is_challenge_active(6) || is_challenge_active(7)) {
            level thread function_5e882c6f(e_player, self.origin);
        }
        if (is_challenge_active(33)) {
            if (isdefined(level.var_45cda120)) {
                arrayremovevalue(level.var_45cda120, self);
            }
        }
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0x2495a19c, Offset: 0x1768
// Size: 0xe8
function on_ai_damage(s_params) {
    e_player = s_params.eattacker;
    str_hit_loc = s_params.shitloc;
    weapon = s_params.weapon;
    means_of_death = s_params.smeansofdeath;
    if (isplayer(e_player)) {
        if (is_challenge_active(12)) {
            if (means_of_death == "MOD_MELEE" || isdefined(weapon) && "MOD_IMPACT" === means_of_death) {
                level notify(#"player_melees_zombie", {#e_player:e_player});
            }
        }
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0x97c5f4a, Offset: 0x1858
// Size: 0x114
function on_item_pickup(params) {
    if (isplayer(self)) {
        if (is_challenge_active(32)) {
            if (!isdefined(self.var_bab6e523)) {
                self.var_bab6e523 = [];
            }
            if (!isinarray(self.var_bab6e523, params.item)) {
                if (!isdefined(self.var_bab6e523)) {
                    self.var_bab6e523 = [];
                } else if (!isarray(self.var_bab6e523)) {
                    self.var_bab6e523 = array(self.var_bab6e523);
                }
                self.var_bab6e523[self.var_bab6e523.size] = params.item;
                self namespace_f999c142::function_53a333a8(level.s_active_challenge.n_id);
            }
        }
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 5, eflags: 0x1 linked
// Checksum 0xd9b74c79, Offset: 0x1978
// Size: 0x168
function create_challenge(n_challenge, var_6346e7b, zonename, weaponname, var_e09af826) {
    s_challenge = {#n_id:n_challenge, #var_4427ebb1:zonename, #var_6346e7b:var_6346e7b, #n_count:0, #var_4365b81b:var_e09af826, #var_8edbca81:weaponname};
    if (!isdefined(level.var_94b8d201)) {
        level.var_94b8d201 = [];
    } else if (!isarray(level.var_94b8d201)) {
        level.var_94b8d201 = array(level.var_94b8d201);
    }
    if (!isinarray(level.var_94b8d201, s_challenge)) {
        level.var_94b8d201[level.var_94b8d201.size] = s_challenge;
    }
    level.var_94b8d201 = array::randomize(level.var_94b8d201);
    return s_challenge;
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0x561ed40, Offset: 0x1ae8
// Size: 0x19c
function function_5586b077(e_player) {
    if (is_true(e_player.var_a77f845b)) {
        return false;
    } else if (is_true(e_player.var_11507a67)) {
        var_9137c22c = e_player zm_utility::function_d6046228(#"hash_62ce0492bff3907b", #"hash_4be3e681b9e66331");
        self sethintstringforplayer(e_player, var_9137c22c);
        return true;
    } else if (level.var_2dffd020 == 0) {
        self sethintstringforplayer(e_player, #"hash_b81e285f17abe6");
        return true;
    } else if (level.var_2dffd020 == 1 || level.var_2dffd020 == 2) {
        if (level.var_2dffd020 == 2) {
            self sethintstringforplayer(e_player, #"hash_1fbfa2022387011d", level.var_d3a8f03b);
        } else {
            self sethintstringforplayer(e_player, #"hash_1d71f5286d92646", level.var_d3a8f03b);
        }
        return true;
    }
    return false;
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xc053ef89, Offset: 0x1c90
// Size: 0x194
function function_6d69e771() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"trigger");
        e_player = waitresult.activator;
        if (!zm_utility::can_use(e_player, 0)) {
            continue;
        }
        if (!level flag::get("power_on") || zm_trial_disable_buys::is_active()) {
            continue;
        }
        if (e_player function_34ebccf9()) {
            e_player notify(#"hash_811de57ec6a72cd");
            continue;
        }
        if (level.var_2dffd020 == 1 || level.var_2dffd020 == 2) {
            if (e_player zm_score::can_player_purchase(level.var_d3a8f03b)) {
                e_player playsound(#"hash_73188c838e8d29c7");
                e_player thread zm_score::minus_to_player_score(level.var_d3a8f03b);
                level thread start_challenge(e_player);
                level.var_c6ab748f = 0;
            }
        }
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0xad0df5b5, Offset: 0x1e30
// Size: 0x11c
function start_challenge(e_player) {
    if (isdefined(level.s_active_challenge)) {
        stop_challenge();
        waitframe(1);
    }
    if (isdefined(e_player)) {
        s_challenge = get_challenge(e_player);
    }
    if (!isdefined(s_challenge)) {
        return;
    }
    waitframe(1);
    foreach (player in getplayers()) {
        player thread function_34b03961(1);
    }
    level thread function_8f0594cb(s_challenge);
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0x1620eb7b, Offset: 0x1f58
// Size: 0x186
function stop_challenge(var_d46ce3db = 0) {
    stop_timer();
    if (isdefined(level.s_active_challenge.var_3e17832)) {
        level [[ level.s_active_challenge.var_3e17832 ]]();
    }
    wait 0.1;
    level.s_active_challenge = undefined;
    foreach (player in getplayers()) {
        player thread function_7e30f24c();
        if (var_d46ce3db) {
            player thread function_34b03961();
            continue;
        }
        player clientfield::set_to_player("" + #"hash_216c75103f478671", 2);
    }
    function_111530dd();
    level notify(#"hash_53f7c8af221e6090");
    waitframe(1);
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x2ea87069, Offset: 0x20e8
// Size: 0x40
function function_34ebccf9() {
    if (is_true(self.var_11507a67) || is_true(self.var_a77f845b)) {
        return true;
    }
    return false;
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0xa2030a73, Offset: 0x2130
// Size: 0x3d6
function function_34b03961(var_851cec80 = 0) {
    self endon(#"disconnect");
    if (self function_34ebccf9()) {
        return;
    }
    if (var_851cec80) {
        self clientfield::set_to_player("" + #"hash_216c75103f478671", 1);
        return;
    }
    var_2b372cf6 = array::random(array(#"radio", #"audiolog", #"hash_daeb8129dc8e394"));
    if (level.var_2dffd020 === 4 && self.var_207f01b0 >= 0.2) {
        self.var_11507a67 = 1;
        self.var_207f01b0 = 0;
        switch (var_2b372cf6) {
        case #"hash_daeb8129dc8e394":
            var_3e22312c = 4;
            var_2a2ba09f = 5;
            break;
        case #"audiolog":
            var_3e22312c = 6;
            var_2a2ba09f = 7;
            break;
        case #"radio":
            var_3e22312c = 8;
            var_2a2ba09f = 9;
            break;
        }
        self clientfield::set_to_player("" + #"hash_216c75103f478671", var_3e22312c);
        self function_c21d733d(1);
        self waittill(#"hash_811de57ec6a72cd");
        self function_c21d733d(0);
        self.var_11507a67 = undefined;
        self.var_a77f845b = 1;
        self clientfield::set_to_player("" + #"hash_216c75103f478671", var_2a2ba09f);
        self function_2cf64a66(var_2b372cf6);
        self.var_a77f845b = undefined;
        if (level.var_2dffd020 === 3 || level.var_2dffd020 === 4) {
            self clientfield::set_to_player("" + #"hash_216c75103f478671", 1);
        } else if (level.var_2dffd020 == 2) {
            self clientfield::set_to_player("" + #"hash_216c75103f478671", 3);
        } else {
            self clientfield::set_to_player("" + #"hash_216c75103f478671", 2);
        }
    } else if (level.var_2dffd020 == 2) {
        self clientfield::set_to_player("" + #"hash_216c75103f478671", 3);
    } else {
        self clientfield::set_to_player("" + #"hash_216c75103f478671", 2);
    }
    self.var_207f01b0 = 0;
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0x95a1d029, Offset: 0x2510
// Size: 0x108
function function_2cf64a66(var_2b372cf6) {
    switch (var_2b372cf6) {
    case #"hash_daeb8129dc8e394":
        str_sound = undefined;
        break;
    case #"audiolog":
        str_sound = undefined;
        break;
    case #"radio":
        str_sound = undefined;
        break;
    }
    if (isdefined(str_sound)) {
        level.var_107cca82 playsoundtoplayer(str_sound, self);
        n_wait_time = float(soundgetplaybacktime(str_sound)) / 1000;
        n_wait_time = max(n_wait_time, 2.5);
    } else {
        n_wait_time = 6;
    }
    wait n_wait_time;
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0x80fe3ba1, Offset: 0x2620
// Size: 0x754
function function_8f0594cb(s_challenge) {
    level endon(#"hash_53f7c8af221e6090");
    if (level.var_2dffd020 == 2) {
        level.var_2dffd020 = 4;
        level.var_d2bdec66++;
        /#
            iprintlnbold("<dev string:x38>" + level.var_d2bdec66 + "<dev string:x49>");
        #/
    } else {
        level.var_2dffd020 = 3;
    }
    level.s_active_challenge = s_challenge;
    level.var_62ecc169 = gettime() / 1000;
    switch (level.s_active_challenge.n_id) {
    case 12:
        /#
            iprintlnbold("<dev string:x55>");
        #/
        level.s_active_challenge.var_c376bcd5 = &function_727cdea9;
        break;
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
    case 6:
    case 7:
        /#
            iprintlnbold("<dev string:x6b>" + level.s_active_challenge.var_4427ebb1);
        #/
        level.s_active_challenge.var_c376bcd5 = &function_f51adffa;
        level.s_active_challenge.var_3e17832 = &function_9742c28f;
        break;
    case 8:
        /#
            iprintlnbold("<dev string:x76>");
        #/
        level.s_active_challenge.var_c376bcd5 = &function_3cdac153;
        break;
    case 9:
        /#
            iprintlnbold("<dev string:x87>");
        #/
        level.s_active_challenge.var_c376bcd5 = &function_77d6b526;
        break;
    case 10:
        /#
            iprintlnbold("<dev string:x9e>");
        #/
        break;
    case 11:
        /#
            iprintlnbold("<dev string:xad>");
        #/
        level.s_active_challenge.var_c376bcd5 = &function_c8657c04;
        break;
    case 13:
        /#
            iprintlnbold("<dev string:xba>");
        #/
        level.s_active_challenge.var_c376bcd5 = &function_c106ffd8;
        break;
    case 14:
    case 15:
    case 16:
    case 17:
    case 18:
        /#
            iprintlnbold("<dev string:xcd>" + level.s_active_challenge.var_4427ebb1);
        #/
        level.s_active_challenge.var_c376bcd5 = &function_1d60215;
        level.s_active_challenge.var_3e17832 = &function_6be352fc;
        break;
    case 19:
    case 20:
    case 21:
    case 22:
    case 23:
        level.s_active_challenge.var_c376bcd5 = &function_9d848c55;
        break;
    case 24:
    case 25:
    case 26:
    case 27:
    case 28:
    case 29:
        level.s_active_challenge.var_c376bcd5 = &function_415e97cb;
        break;
    case 31:
        level.s_active_challenge.var_c376bcd5 = &function_c53ffd70;
        break;
    case 32:
        break;
    case 33:
        level.s_active_challenge.var_c376bcd5 = &function_dedaaa32;
        break;
    case 34:
        level.s_active_challenge.var_c376bcd5 = &function_aa899f53;
        break;
    }
    foreach (player in getplayers()) {
        player.var_6b3806e8 = 0;
        player thread set_challenge_text(level.s_active_challenge.var_4365b81b);
    }
    if (isdefined(level.s_active_challenge.var_c376bcd5)) {
        level thread [[ level.s_active_challenge.var_c376bcd5 ]]();
    }
    start_timer(s_challenge.var_6346e7b + 1);
    /#
        iprintlnbold("<dev string:xd9>");
    #/
    level waittilltimeout(s_challenge.var_6346e7b + 1, #"round_reset");
    /#
        iprintlnbold("<dev string:xe7>");
    #/
    stop_challenge(1);
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x3721b614, Offset: 0x2d80
// Size: 0x2a0
function function_f51adffa() {
    switch (level.s_active_challenge.n_id) {
    case 1:
        level.var_80ec74ca = #"hash_13d46153d7766815";
        break;
    case 2:
        level.var_80ec74ca = #"hash_440b7da12cea8586";
        break;
    case 3:
        level.var_80ec74ca = #"hash_4337a05b520ed70a";
        break;
    case 4:
        level.var_80ec74ca = #"hash_79a511f14faa48a4";
        break;
    case 5:
        level.var_80ec74ca = #"hash_1305f8d6d3e6faeb";
        break;
    case 6:
        level.var_80ec74ca = #"hash_36c2aafba152f58b";
        break;
    case 7:
        level.var_80ec74ca = #"hash_6432998c34b45ab5";
        break;
    }
    level.var_be2ff8ca = zm_utility::function_d7db256e(level.var_80ec74ca, undefined, 1);
    level.var_4427ebb1 = level.s_active_challenge.var_4427ebb1;
    level.var_2c5f83d = zm_silver_zones::function_27028b8e(level.var_4427ebb1);
    /#
        iprintlnbold("<dev string:xf2>");
    #/
    foreach (player in getplayers()) {
        player thread function_d7362784(level.s_active_challenge.n_id, level.var_2c5f83d, undefined);
        player thread set_challenge_text(level.s_active_challenge.var_4365b81b, level.var_2c5f83d);
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 3, eflags: 0x1 linked
// Checksum 0x87b30580, Offset: 0x3028
// Size: 0x1e2
function function_d7362784(var_ecffa2a8, var_2c5f83d, vol_override = undefined) {
    self notify(#"hash_26da5491f8ef4fd8");
    self endon(#"hash_26da5491f8ef4fd8", #"death");
    self.var_95cfa01d = 1;
    self.var_b05f25ad = 0;
    while (is_challenge_active(var_ecffa2a8)) {
        if (isdefined(vol_override)) {
            if (self istouching(vol_override)) {
                self.var_b05f25ad = 1;
                self function_fcd5d27c(1);
            } else {
                self.var_b05f25ad = 0;
                self function_fcd5d27c(0);
            }
        } else {
            var_a76cae76 = zm_silver_zones::function_27028b8e(self.zone_name);
            if (var_2c5f83d === var_a76cae76) {
                self.var_b05f25ad = 1;
                self function_fcd5d27c(1);
            } else {
                self.var_b05f25ad = 0;
                self function_fcd5d27c(0);
            }
        }
        if (is_true(self.var_95cfa01d) && is_true(self.var_b05f25ad)) {
            self.var_f94035ca = gettime() / 1000;
        }
        waitframe(1);
    }
    self.var_95cfa01d = 0;
    self.var_b05f25ad = 0;
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x295be3a3, Offset: 0x3218
// Size: 0x24
function function_9742c28f() {
    zm_utility::function_b1f3be5c(level.var_be2ff8ca, level.var_80ec74ca);
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xfefa91c0, Offset: 0x3248
// Size: 0x24
function function_727cdea9() {
    self thread function_9ffc76ea("player_melees_zombie");
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xffff6e15, Offset: 0x3278
// Size: 0x24
function function_3cdac153() {
    self thread function_9ffc76ea("kill_with_IEU");
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xf6f9d3d6, Offset: 0x32a8
// Size: 0x24
function function_c106ffd8() {
    level thread function_9ffc76ea("zombie_challenge_kill");
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xbe4b8f27, Offset: 0x32d8
// Size: 0x24
function function_77d6b526() {
    self thread function_9ffc76ea("kill_with_equipment");
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x9472a1d7, Offset: 0x3308
// Size: 0x24
function function_c53ffd70() {
    self thread function_9ffc76ea("board_repaired");
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x7a2ee34c, Offset: 0x3338
// Size: 0xb0
function function_aa899f53() {
    self thread function_9ffc76ea("give_perk_vapor");
    foreach (player in getplayers()) {
        player thread function_a27e2f13();
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xfa08eb88, Offset: 0x33f0
// Size: 0x78
function function_a27e2f13() {
    level endon(#"hash_53f7c8af221e6090", #"disconnect");
    while (true) {
        self waittill(#"perk_bought");
        self namespace_f999c142::function_53a333a8(level.s_active_challenge.n_id);
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xc43e02f7, Offset: 0x3470
// Size: 0x1f4
function function_415e97cb() {
    switch (level.s_active_challenge.n_id) {
    case 24:
        var_4c25f9e8 = #"hash_59d228ecf0a71415";
        break;
    case 25:
        var_4c25f9e8 = #"hash_819627439bd987b";
        break;
    case 26:
        var_4c25f9e8 = #"hash_418a6e1ea0e081c6";
        break;
    case 27:
        var_4c25f9e8 = #"hash_366d779c4411e20c";
        break;
    case 28:
        var_4c25f9e8 = #"hash_743ef88da2399f13";
        break;
    case 29:
        var_4c25f9e8 = #"hash_7db3b20f2c5a984f";
        break;
    }
    foreach (player in getplayers()) {
        if (isdefined(var_4c25f9e8)) {
            player thread function_cbc84593();
            player set_challenge_text(level.s_active_challenge.var_4365b81b, var_4c25f9e8);
        }
    }
    self thread function_9ffc76ea("kill_with_weapons");
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xcbbf28d7, Offset: 0x3670
// Size: 0xae
function function_cbc84593() {
    level endon(#"hash_53f7c8af221e6090", #"disconnect");
    while (true) {
        if (weapons::getbaseweapon(self.currentweapon) == getweapon(level.s_active_challenge.var_8edbca81)) {
            self function_fcd5d27c(1);
        } else {
            self function_fcd5d27c(0);
        }
        waitframe(1);
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x4e94cfc9, Offset: 0x3728
// Size: 0x384
function function_1d60215() {
    level endon(#"hash_53f7c8af221e6090");
    switch (level.s_active_challenge.n_id) {
    case 14:
        level.var_c699da9d = #"hash_217e1f450f80ad11";
        break;
    case 15:
        level.var_c699da9d = #"hash_63547c6c2ff145bc";
        break;
    case 16:
        level.var_c699da9d = #"hash_6306967c9981a4d9";
        break;
    case 17:
        level.var_c699da9d = #"hash_bacbba99032042e";
        break;
    case 18:
        level.var_c699da9d = #"hash_1214e3a8eabe504b";
        break;
    default:
        return;
    }
    var_e04fa7d = zm_silver_zones::function_27028b8e(level.s_active_challenge.var_4427ebb1);
    foreach (player in getplayers()) {
        player thread function_d7362784(level.s_active_challenge.n_id, var_e04fa7d, undefined);
        player thread set_challenge_text(level.s_active_challenge.var_4365b81b, var_e04fa7d);
    }
    level.var_acc31847 = zm_utility::function_d7db256e(level.var_c699da9d, undefined, 1);
    while (true) {
        n_time = gettime() / 1000;
        foreach (player in getplayers()) {
            if (!isdefined(player.var_f94035ca)) {
                player.var_f94035ca = 0;
            }
            dt = n_time - player.var_f94035ca;
            if (is_true(player.var_b05f25ad) && dt <= 2) {
                player namespace_f999c142::function_53a333a8(level.s_active_challenge.n_id);
                continue;
            }
            player.var_f94035ca = n_time;
        }
        wait 2;
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xbbca73b7, Offset: 0x3ab8
// Size: 0x24
function function_6be352fc() {
    zm_utility::function_b1f3be5c(level.var_acc31847, level.var_c699da9d);
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 2, eflags: 0x1 linked
// Checksum 0x80370eef, Offset: 0x3ae8
// Size: 0x94
function function_5e882c6f(e_player, var_2b625b6e) {
    str_zone = zm_zonemgr::get_zone_from_position(var_2b625b6e);
    if (isdefined(str_zone)) {
        var_c8470518 = zm_silver_zones::function_27028b8e(str_zone);
        if (level.var_2c5f83d === var_c8470518) {
            e_player namespace_f999c142::function_53a333a8(level.s_active_challenge.n_id);
        }
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xd132dc8, Offset: 0x3b88
// Size: 0x15e
function function_9d848c55() {
    level endon(#"hash_53f7c8af221e6090");
    var_ec94d80d = zm_silver_zones::function_27028b8e(level.s_active_challenge.var_4427ebb1);
    foreach (player in getplayers()) {
        player thread set_challenge_text(level.s_active_challenge.var_4365b81b, var_ec94d80d);
        player thread function_d7362784(level.s_active_challenge.n_id, var_ec94d80d, undefined);
    }
    while (true) {
        level waittill(#"end_of_round");
        self thread function_fd702c53(2);
        waitframe(1);
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0x936207a, Offset: 0x3cf0
// Size: 0x1b6
function function_fd702c53(var_10d69e4a) {
    self notify("56b30423a95d867e");
    self endon("56b30423a95d867e");
    level endon(#"hash_53f7c8af221e6090");
    var_e7c42ee3 = undefined;
    while (true) {
        foreach (player in function_a1ef346b()) {
            if (!player.var_b05f25ad) {
                var_e7c42ee3 = 0;
                break;
            }
        }
        if (!isdefined(var_e7c42ee3)) {
            var_e7c42ee3 = 1;
        }
        if (isdefined(var_e7c42ee3) && var_e7c42ee3) {
            foreach (player in getplayers()) {
                player namespace_f999c142::function_53a333a8(level.s_active_challenge.n_id);
            }
        } else {
            level.var_1562259b = 0;
            break;
        }
        wait var_10d69e4a;
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 2, eflags: 0x1 linked
// Checksum 0xe7424e17, Offset: 0x3eb0
// Size: 0x164
function function_673cba18(var_ecffa2a8, n_damage) {
    self notify("590fc0ee06fe99de");
    self endon("590fc0ee06fe99de");
    self endon(#"death");
    level endon(#"hash_53f7c8af221e6090");
    n_start_health = self.health;
    while (is_challenge_active(var_ecffa2a8)) {
        if (self laststand::player_is_in_laststand()) {
            break;
        }
        if (self.sessionstate === "spectator") {
            break;
        }
        if (self.health == self.maxhealth) {
            self namespace_f999c142::function_53a333a8(level.s_active_challenge.n_id, undefined, n_damage);
            break;
        } else {
            n_delta = self.health - n_start_health;
            if (n_delta >= 50) {
                self namespace_f999c142::function_53a333a8(level.s_active_challenge.n_id, undefined, n_damage);
                n_start_health += 50;
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xfb3a9bfa, Offset: 0x4020
// Size: 0x15c
function function_c8657c04() {
    level endon(#"hash_53f7c8af221e6090");
    for (var_53a794b0 = gettime() / 1000; true; var_53a794b0 = n_time) {
        wait 2;
        n_time = gettime() / 1000;
        foreach (player in getplayers()) {
            b_reward = 0;
            if (!isdefined(player.var_d5e64932)) {
                b_reward = 1;
            } else {
                n_time_since_last_damage = n_time - player.var_d5e64932;
                if (n_time_since_last_damage > 15) {
                    b_reward = 1;
                }
            }
            if (b_reward) {
                player namespace_f999c142::function_53a333a8(level.s_active_challenge.n_id);
            }
        }
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0x6bf53609, Offset: 0x4188
// Size: 0x120
function function_9ffc76ea(str_notify) {
    level endon(#"hash_53f7c8af221e6090");
    while (true) {
        waitresult = level waittill(str_notify);
        if (isdefined(waitresult.e_player)) {
            e_player = waitresult.e_player;
        } else {
            e_player = waitresult.player;
        }
        var_c4979a70 = 1;
        if (level.s_active_challenge.n_id == 9) {
            means_of_death = waitresult.means_of_death;
            if ("MOD_GRENADE" === means_of_death || "MOD_GRENADE_SPLASH" === means_of_death) {
                var_c4979a70 = 8;
            }
        }
        e_player namespace_f999c142::function_53a333a8(level.s_active_challenge.n_id, undefined, var_c4979a70);
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x45ac7a01, Offset: 0x42b0
// Size: 0x78
function function_d60e999d() {
    level endon(#"end_game");
    level flag::wait_till("start_zombie_round_logic");
    function_9e7dc4fb();
    while (true) {
        level waittill(#"end_of_round");
        function_9e7dc4fb();
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x1dc79c5e, Offset: 0x4330
// Size: 0xa8
function function_9e7dc4fb() {
    n_round_number = zm_utility::get_round_number();
    if (n_round_number >= 10) {
        level.var_572d28a8--;
        if (level.var_572d28a8 <= 0) {
            level.var_d3a8f03b = int(level.var_d3a8f03b + 500);
            level.var_572d28a8 = 5;
        }
    } else {
        level.var_d3a8f03b = 500;
    }
    level.var_48442709 = 500;
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xb1db261f, Offset: 0x43e0
// Size: 0x78
function function_3770ad7d() {
    level endon(#"end_game");
    while (true) {
        waitresult = level waittill(#"powerup_dropped");
        powerup = waitresult.powerup;
        if (isdefined(powerup)) {
            powerup function_25b4619d();
        }
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xb360ace5, Offset: 0x4460
// Size: 0xcc
function function_25b4619d() {
    self endon(#"powerup_timedout");
    waitresult = self waittill(#"powerup_grabbed");
    /#
        iprintlnbold("<dev string:x102>");
    #/
    e_player = waitresult.e_grabber;
    if (is_challenge_active(32) && isplayer(e_player)) {
        e_player namespace_f999c142::function_53a333a8(level.s_active_challenge.n_id);
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x420d3685, Offset: 0x4538
// Size: 0x18e
function function_cd955018() {
    level endon(#"hash_53f7c8af221e6090");
    while (true) {
        var_ed9ebb4a = getaiarchetypearray(#"zombie");
        foreach (zombie in var_ed9ebb4a) {
            if (!is_true(zombiebehavior::zombiehaslegs(zombie)) && !isinarray(level.var_45cda120, zombie)) {
                if (!isdefined(level.var_45cda120)) {
                    level.var_45cda120 = [];
                } else if (!isarray(level.var_45cda120)) {
                    level.var_45cda120 = array(level.var_45cda120);
                }
                level.var_45cda120[level.var_45cda120.size] = zombie;
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x2ebb185c, Offset: 0x46d0
// Size: 0xc8
function function_dedaaa32() {
    level endon(#"hash_53f7c8af221e6090");
    level.var_45cda120 = [];
    level thread function_cd955018();
    foreach (player in getplayers()) {
        player thread function_4d9793b2();
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x6701548d, Offset: 0x47a0
// Size: 0x12a
function function_4d9793b2() {
    level endon(#"hash_53f7c8af221e6090");
    while (true) {
        if (!is_true(level.var_45cda120.size == 0)) {
            foreach (zombie in level.var_45cda120) {
                n_dis = distance2d(self.origin, zombie.origin);
                if (n_dis <= 150) {
                    self namespace_f999c142::function_53a333a8(level.s_active_challenge.n_id);
                }
            }
        }
        wait 2;
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0x133107e4, Offset: 0x48d8
// Size: 0x42
function is_challenge_active(var_ecffa2a8) {
    if (isdefined(level.s_active_challenge) && level.s_active_challenge.n_id == var_ecffa2a8) {
        return true;
    }
    return false;
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0xe4f4f9da, Offset: 0x4928
// Size: 0x1b0
function get_challenge(e_player) {
    var_99d6574b = undefined;
    var_52da6798 = level.var_94b8d201.size;
    var_881d9045 = 1000;
    var_1211943c = arraycopy(level.var_94b8d201);
    if (!namespace_b376a999::function_a93a6096(e_player)) {
        foreach (s_challenge in var_1211943c) {
            if (s_challenge.n_id == 8) {
                arrayremovevalue(var_1211943c, s_challenge);
            }
        }
    }
    foreach (s_challenge in var_1211943c) {
        if (s_challenge.n_count < var_881d9045) {
            var_881d9045 = s_challenge.n_count;
            var_99d6574b = s_challenge;
        }
    }
    var_99d6574b.n_count++;
    return var_99d6574b;
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x6c21e9c2, Offset: 0x4ae0
// Size: 0x1c
function is_active() {
    if (isdefined(level.s_active_challenge)) {
        return true;
    }
    return false;
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x12f00eb7, Offset: 0x4b08
// Size: 0xd0
function game_over() {
    level waittill(#"end_game");
    if (is_active()) {
        stop_challenge();
    }
    foreach (player in getplayers()) {
        player set_tributeavailable(0);
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xf570d5e7, Offset: 0x4be0
// Size: 0xc4
function function_2bf355c2() {
    n_index = self getentitynumber();
    if (isdefined(level.var_32e6afcd[n_index].var_f693bf0b)) {
        level.var_32e6afcd[n_index].var_f693bf0b clientfield::set("" + #"hash_21f5fab6a3d22093", 0);
    }
    if (isdefined(level.var_32e6afcd[n_index].var_f92a5f81)) {
        level.var_32e6afcd[n_index].var_f92a5f81 delete();
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x9813f15c, Offset: 0x4cb0
// Size: 0x44
function function_432b2abf() {
    if (!level.var_996e8a57 zm_dac_challenges_hud::is_open(self)) {
        level.var_996e8a57 zm_dac_challenges_hud::open(self);
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 2, eflags: 0x1 linked
// Checksum 0x2ff0b0a0, Offset: 0x4d00
// Size: 0x114
function set_challenge_text(challenge_text, location_name = #"") {
    self endon(#"death");
    self function_432b2abf();
    if (isdefined(challenge_text)) {
        level.var_996e8a57 zm_dac_challenges_hud::set_challengetext(self, challenge_text);
    }
    if (isdefined(location_name)) {
        level.var_996e8a57 zm_dac_challenges_hud::set_bottomtext(self, location_name);
    }
    if (level.var_2dffd020 === 4) {
        level.var_996e8a57 zm_dac_challenges_hud::function_c079b98b(self, 1);
    } else {
        level.var_996e8a57 zm_dac_challenges_hud::function_c079b98b(self, 0);
    }
    self function_b4759cf8();
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x657a22a, Offset: 0x4e20
// Size: 0x54
function function_b4759cf8() {
    if (isdefined(self)) {
        level.var_996e8a57 zm_dac_challenges_hud::set_state(self, #"hash_6038b42ab4ce959d");
        level.var_996e8a57 zm_dac_challenges_hud::set_rewardhidden(self, 0);
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xd5bc2202, Offset: 0x4e80
// Size: 0x84
function function_7e30f24c() {
    if (isdefined(self)) {
        level.var_996e8a57 zm_dac_challenges_hud::set_state(self, #"hash_3045a78750b13a96");
    }
    if (isdefined(self.var_9e09931e) && is_true(self.var_9e09931e === 0)) {
        level.var_996e8a57 zm_dac_challenges_hud::set_rewardhidden(self, 1);
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0x2605340c, Offset: 0x4f10
// Size: 0x54
function set_tributeavailable(var_9d5acba) {
    if (level.var_996e8a57 zm_dac_challenges_hud::is_open(self)) {
        if (isdefined(var_9d5acba)) {
            level.var_996e8a57 zm_dac_challenges_hud::set_tributeavailable(self, var_9d5acba);
        }
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0x69b60915, Offset: 0x4f70
// Size: 0x5c
function function_c21d733d(b_enable = 1) {
    if (level.var_996e8a57 zm_dac_challenges_hud::is_open(self)) {
        level.var_996e8a57 zm_dac_challenges_hud::function_c21d733d(self, b_enable);
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0x8df4156f, Offset: 0x4fd8
// Size: 0x5c
function function_fcd5d27c(var_3f4d60e3 = 1) {
    if (level.var_996e8a57 zm_dac_challenges_hud::is_open(self)) {
        level.var_996e8a57 zm_dac_challenges_hud::set_binlocation(self, var_3f4d60e3);
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x0
// Checksum 0xcd110c5e, Offset: 0x5040
// Size: 0x44
function function_fd8a137e() {
    if (level.var_996e8a57 zm_dac_challenges_hud::is_open(self)) {
        level.var_996e8a57 zm_dac_challenges_hud::close(self);
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xefac8873, Offset: 0x5090
// Size: 0x3c
function function_34a533b1() {
    self function_432b2abf();
    level.var_996e8a57 zm_dac_challenges_hud::increment_progress(self);
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x1 linked
// Checksum 0x668a405b, Offset: 0x50d8
// Size: 0xb8
function start_timer(n_time_seconds) {
    foreach (player in getplayers()) {
        player clientfield::set_to_player("" + #"hash_31bea9cf1e6f76a0", n_time_seconds);
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0xfc937d1a, Offset: 0x5198
// Size: 0xb0
function stop_timer() {
    foreach (player in getplayers()) {
        player clientfield::set_to_player("" + #"hash_31bea9cf1e6f76a0", 0);
    }
}

/#

    // Namespace namespace_f0b43eb5/namespace_f0b43eb5
    // Params 0, eflags: 0x0
    // Checksum 0xb438074d, Offset: 0x5250
    // Size: 0x8c
    function function_37597f29() {
        adddebugcommand("<dev string:x119>");
        adddebugcommand("<dev string:x17c>");
        adddebugcommand("<dev string:x1e7>");
        adddebugcommand("<dev string:x246>");
        zm_devgui::add_custom_devgui_callback(&cmd);
    }

    // Namespace namespace_f0b43eb5/namespace_f0b43eb5
    // Params 1, eflags: 0x0
    // Checksum 0xfd53a050, Offset: 0x52e8
    // Size: 0x172
    function cmd(cmd) {
        switch (cmd) {
        case #"hash_c56ce3c06931cbb":
            function_d938cbd8();
            break;
        case #"hash_1f6dfb788a3261dc":
            function_df5afb5e();
            break;
        case #"hash_7cdc8834ffee5ac":
            function_5e613eb7();
            break;
        case #"hash_625423e17a0da5e2":
            if (getdvarint(#"hash_1ca7459bb8b222dd", 0)) {
                setdvar(#"hash_1ca7459bb8b222dd", 0);
                /#
                    iprintlnbold("<dev string:x2b3>");
                #/
            } else {
                setdvar(#"hash_1ca7459bb8b222dd", 1);
                /#
                    iprintlnbold("<dev string:x2cd>");
                #/
            }
            break;
        default:
            break;
        }
    }

    // Namespace namespace_f0b43eb5/namespace_f0b43eb5
    // Params 0, eflags: 0x0
    // Checksum 0x2221af4f, Offset: 0x5468
    // Size: 0x34
    function function_d938cbd8() {
        if (is_active()) {
            stop_challenge(1);
        }
    }

    // Namespace namespace_f0b43eb5/namespace_f0b43eb5
    // Params 0, eflags: 0x0
    // Checksum 0x3e33b796, Offset: 0x54a8
    // Size: 0xc0
    function function_df5afb5e() {
        var_ed9ebb4a = getaiarchetypearray(#"zombie");
        foreach (zombie in var_ed9ebb4a) {
            zombie zombie_utility::function_df5afb5e(1);
        }
    }

    // Namespace namespace_f0b43eb5/namespace_f0b43eb5
    // Params 0, eflags: 0x0
    // Checksum 0x5dc4ae3d, Offset: 0x5570
    // Size: 0xa0
    function function_5e613eb7() {
        foreach (player in getplayers()) {
            player namespace_f999c142::function_53a333a8("<dev string:x2e6>", 200);
        }
    }

#/
