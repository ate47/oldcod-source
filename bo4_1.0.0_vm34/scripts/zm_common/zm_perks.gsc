#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\perks;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\callings\zm_callings;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\trials\zm_trial_disable_perks;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_power;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_perks;

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xac152ecc, Offset: 0x5c8
// Size: 0x444
function init() {
    level.perk_purchase_limit = 4;
    if (!isdefined(level.var_eef7bfa1)) {
        level.var_eef7bfa1 = [];
    } else if (!isarray(level.var_eef7bfa1)) {
        level.var_eef7bfa1 = array(level.var_eef7bfa1);
    }
    perks_register_clientfield();
    if (!level.enable_magic || !(isdefined(zm_custom::function_5638f689(#"zmperksactive")) && zm_custom::function_5638f689(#"zmperksactive"))) {
        return;
    }
    function_aa9d5b3f();
    level.var_8b1c4f80 = [];
    perk_vapor_altar_init();
    vending_weapon_upgrade_trigger = [];
    level.machine_assets = [];
    level.perk_machines = [];
    if (!isdefined(level.custom_vending_precaching)) {
        level.custom_vending_precaching = &default_vending_precaching;
    }
    [[ level.custom_vending_precaching ]]();
    zombie_utility::set_zombie_var(#"zombie_perk_cost", 2000);
    if (level._custom_perks.size > 0) {
        a_keys = getarraykeys(level._custom_perks);
        for (i = 0; i < a_keys.size; i++) {
            b_enabled = 1;
            if (!array::contains(level.var_3d574fc8, a_keys[i])) {
                b_enabled = 0;
            }
            if (b_enabled) {
                if (isdefined(level._custom_perks[a_keys[i]].perk_machine_thread)) {
                    level thread [[ level._custom_perks[a_keys[i]].perk_machine_thread ]]();
                }
                if (isdefined(level._custom_perks[a_keys[i]].perk_machine_power_override_thread)) {
                    level thread [[ level._custom_perks[a_keys[i]].perk_machine_power_override_thread ]]();
                    continue;
                }
                if (isdefined(level._custom_perks[a_keys[i]].alias) && isdefined(level._custom_perks[a_keys[i]].radiant_machine_name) && isdefined(level._custom_perks[a_keys[i]].machine_light_effect)) {
                    level thread perk_machine_think(a_keys[i], level._custom_perks[a_keys[i]]);
                }
            }
        }
    }
    if (isdefined(level.quantum_bomb_register_result_func)) {
        [[ level.quantum_bomb_register_result_func ]]("give_nearest_perk", &quantum_bomb_give_nearest_perk_result, 10, &quantum_bomb_give_nearest_perk_validation);
    }
    level thread perk_hostmigration();
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&function_206b420e);
    register_lost_perk_override(&function_5ad021c0);
    /#
        level thread function_a376d553();
    #/
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xed180252, Offset: 0xa18
// Size: 0x404
function on_player_connect() {
    if (!isdefined(self.var_871d24d3)) {
        self.var_871d24d3 = [];
    } else if (!isarray(self.var_871d24d3)) {
        self.var_871d24d3 = array(self.var_871d24d3);
    }
    if (!isdefined(self.var_c4fbbdc2)) {
        self.var_c4fbbdc2 = [];
    } else if (!isarray(self.var_c4fbbdc2)) {
        self.var_c4fbbdc2 = array(self.var_c4fbbdc2);
    }
    if (!isdefined(self.var_59353358)) {
        self.var_59353358 = [];
    } else if (!isarray(self.var_59353358)) {
        self.var_59353358 = array(self.var_59353358);
    }
    if (!isdefined(self.var_b318c4f9)) {
        self.var_b318c4f9 = [];
    } else if (!isarray(self.var_b318c4f9)) {
        self.var_b318c4f9 = array(self.var_b318c4f9);
    }
    if (!isdefined(self.var_83ef9ace)) {
        self.var_83ef9ace = [];
    } else if (!isarray(self.var_83ef9ace)) {
        self.var_83ef9ace = array(self.var_83ef9ace);
    }
    if (!isdefined(self.var_59fcabb7)) {
        self.var_59fcabb7 = [];
    } else if (!isarray(self.var_59fcabb7)) {
        self.var_59fcabb7 = array(self.var_59fcabb7);
    }
    if (!isdefined(self.var_ee217989)) {
        self.var_ee217989 = [];
    } else if (!isarray(self.var_ee217989)) {
        self.var_ee217989 = array(self.var_ee217989);
    }
    j = 0;
    for (i = 1; i <= 4; i++) {
        var_9a6b6100 = self zm_loadout::get_loadout_item("specialty" + i);
        s_perk = getunlockableiteminfofromindex(var_9a6b6100, 3);
        if (isdefined(s_perk)) {
            if (!array::contains(level.var_3d574fc8, s_perk.specialties[0])) {
                s_perk = undefined;
                str_perk = "";
            }
        }
        if (isdefined(s_perk)) {
            str_perk = s_perk.specialties[0];
            if (isstring(str_perk)) {
                str_perk = hash(str_perk);
            }
        }
        assert(isdefined(str_perk), "<dev string:x30>" + self.name + "<dev string:x4f>");
        self.var_871d24d3[j] = str_perk;
        self.var_59353358[j] = str_perk == #"specialty_mystery" ? 1 : 0;
        self.var_c4fbbdc2[j] = "";
        j++;
    }
    /#
        self function_5f0434b6();
    #/
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x5f378bd6, Offset: 0xe28
// Size: 0x2a
function get_perk_machines() {
    if (!isdefined(level.perk_machines)) {
        level.perk_machines = [];
    }
    return level.perk_machines;
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x5952a3a, Offset: 0xe60
// Size: 0x398
function perk_machine_think(str_key, s_custom_perk) {
    str_endon = str_key + "_power_thread_end";
    level endon(str_endon);
    str_on = s_custom_perk.alias + "_on";
    str_off = s_custom_perk.alias + "_off";
    str_notify = str_key + "_power_on";
    while (true) {
        machine = getentarray(s_custom_perk.radiant_machine_name, "targetname");
        for (i = 0; i < machine.size; i++) {
            machine[i] setmodel(level.machine_assets[str_key].off_model);
            machine[i] solid();
            machine[i].script_noteworthy = str_key;
            level.perk_machines[level.perk_machines.size] = machine[i];
        }
        level thread do_initial_power_off_callback(machine, str_key);
        array::thread_all(machine, &set_power_on, 0);
        level waittill(str_on);
        for (i = 0; i < machine.size; i++) {
            machine[i] setmodel(level.machine_assets[str_key].on_model);
            machine[i] vibrate((0, -100, 0), 0.3, 0.4, 3);
            machine[i] playsound(#"zmb_perks_power_on");
            machine[i] thread perk_fx(s_custom_perk.machine_light_effect);
            machine[i] thread play_loop_on_machine();
        }
        level notify(str_notify);
        array::thread_all(machine, &set_power_on, 1);
        if (isdefined(level.machine_assets[str_key].power_on_callback)) {
            array::thread_all(machine, level.machine_assets[str_key].power_on_callback);
        }
        level waittill(str_off);
        if (isdefined(level.machine_assets[str_key].power_off_callback)) {
            array::thread_all(machine, level.machine_assets[str_key].power_off_callback);
        }
        array::thread_all(machine, &turn_perk_off);
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xc4f3dfb2, Offset: 0x1200
// Size: 0xae
function default_vending_precaching() {
    if (level._custom_perks.size > 0) {
        a_keys = getarraykeys(level._custom_perks);
        for (i = 0; i < a_keys.size; i++) {
            if (isdefined(level._custom_perks[a_keys[i]].precache_func)) {
                level [[ level._custom_perks[a_keys[i]].precache_func ]]();
            }
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0xf9184a89, Offset: 0x12b8
// Size: 0x94
function do_initial_power_off_callback(machine_array, perkname) {
    if (!isdefined(level.machine_assets[perkname])) {
        println("<dev string:x74>");
        return;
    }
    if (!isdefined(level.machine_assets[perkname].power_off_callback)) {
        return;
    }
    waitframe(1);
    array::thread_all(machine_array, level.machine_assets[perkname].power_off_callback);
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x74983b1d, Offset: 0x1358
// Size: 0x1a
function set_power_on(state) {
    self.power_on = state;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xc1f6e72d, Offset: 0x1380
// Size: 0x114
function turn_perk_off(ishidden) {
    self notify(#"stop_loopsound");
    if (!(isdefined(self.b_keep_when_turned_off) && self.b_keep_when_turned_off)) {
        newmachine = spawn("script_model", self.origin);
        newmachine.angles = self.angles;
        newmachine.targetname = self.targetname;
        if (isdefined(ishidden) && ishidden) {
            newmachine.ishidden = 1;
            newmachine ghost();
            newmachine notsolid();
        }
        self delete();
        return;
    }
    perk_fx(undefined, 1);
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x219399c3, Offset: 0x14a0
// Size: 0xb4
function play_loop_on_machine() {
    if (isdefined(level.var_6a008207)) {
        return;
    }
    sound_ent = spawn("script_origin", self.origin);
    sound_ent playloopsound(#"zmb_perks_machine_loop");
    sound_ent linkto(self);
    self waittill(#"stop_loopsound");
    sound_ent unlink();
    sound_ent delete();
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x3910d6d4, Offset: 0x1560
// Size: 0x17a
function perk_fx(fx, turnofffx) {
    if (isdefined(turnofffx)) {
        self.perk_fx = 0;
        if (isdefined(self.b_keep_when_turned_off) && self.b_keep_when_turned_off && isdefined(self.s_fxloc)) {
            self.s_fxloc delete();
        }
        return;
    }
    wait 3;
    if (!isdefined(self)) {
        return;
    }
    if (!(isdefined(self.b_keep_when_turned_off) && self.b_keep_when_turned_off)) {
        if (isdefined(self) && !(isdefined(self.perk_fx) && self.perk_fx)) {
            playfxontag(level._effect[fx], self, "tag_origin");
            self.perk_fx = 1;
        }
        return;
    }
    if (isdefined(self) && !isdefined(self.s_fxloc)) {
        self.s_fxloc = util::spawn_model("tag_origin", self.origin);
        playfxontag(level._effect[fx], self.s_fxloc, "tag_origin");
        self.perk_fx = 1;
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xc3fc5a56, Offset: 0x16e8
// Size: 0x202
function electric_perks_dialog() {
    self endon(#"death");
    wait 0.01;
    level flag::wait_till("start_zombie_round_logic");
    players = getplayers();
    if (players.size == 1) {
        return;
    }
    self endon(#"warning_dialog");
    level endon(#"switch_flipped");
    timer = 0;
    while (true) {
        wait 0.5;
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (!isdefined(players[i])) {
                continue;
            }
            dist = distancesquared(players[i].origin, self.origin);
            if (dist > 4900) {
                timer = 0;
                continue;
            }
            if (dist < 4900 && timer < 3) {
                wait 0.5;
                timer++;
            }
            if (dist < 4900 && timer == 3) {
                if (!isdefined(players[i])) {
                    continue;
                }
                players[i] thread zm_utility::do_player_vo("vox_start", 5);
                wait 3;
                self notify(#"warning_dialog");
                /#
                    iprintlnbold("<dev string:xd3>");
                #/
            }
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x393ca76c, Offset: 0x18f8
// Size: 0xbc
function reset_vending_hint_string() {
    perk = self.script_noteworthy;
    if (isdefined(level._custom_perks)) {
        if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].cost) && isdefined(level._custom_perks[perk].hint_string)) {
            n_cost = function_657ee744(perk);
            self sethintstring(level._custom_perks[perk].hint_string, n_cost);
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xf5d3d240, Offset: 0x19c0
// Size: 0x7a
function function_657ee744(perk) {
    if (isfunctionptr(level._custom_perks[perk].cost)) {
        n_cost = [[ level._custom_perks[perk].cost ]]();
    } else {
        n_cost = level._custom_perks[perk].cost;
    }
    return n_cost;
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x4c7d3b7d, Offset: 0x1a48
// Size: 0x19e
function vending_trigger_can_player_use(player, var_857f9c8) {
    if (player laststand::player_is_in_laststand() || isdefined(player.intermission) && player.intermission) {
        return false;
    }
    if (player zm_utility::in_revive_trigger()) {
        return false;
    }
    if (player isthrowinggrenade()) {
        return false;
    }
    if (player isswitchingweapons()) {
        return false;
    }
    if (player zm_utility::is_drinking()) {
        return false;
    }
    if (isdefined(var_857f9c8) && var_857f9c8) {
        var_be51d13d = array::exclude(level.var_3d574fc8, player.perks_active);
        if (!isdefined(var_be51d13d)) {
            return false;
        }
        if (isdefined(self.stub) && isdefined(self.stub.machine) && isdefined(player.var_871d24d3[self.stub.machine.script_int])) {
            if (!isinarray(level.var_3d574fc8, player.var_871d24d3[self.stub.machine.script_int])) {
                return false;
            }
        }
    }
    return true;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xeb15d0a9, Offset: 0x1bf0
// Size: 0x276
function function_846f73f5() {
    self endon(#"death");
    wait 0.01;
    perk = self.script_noteworthy;
    level.revive_machine_is_solo = 0;
    if (isdefined(perk) && perk == #"specialty_quickrevive") {
        level flag::wait_till("start_zombie_round_logic");
        self endon(#"stop_quickrevive_logic");
        level.quick_revive_trigger = self;
        if (level.players.size == 1) {
            level.revive_machine_is_solo = 1;
        }
    }
    cost = zombie_utility::get_zombie_var(#"zombie_perk_cost");
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].cost)) {
        if (isint(level._custom_perks[perk].cost)) {
            cost = level._custom_perks[perk].cost;
        } else {
            cost = [[ level._custom_perks[perk].cost ]]();
        }
    }
    self.cost = cost;
    notify_name = perk + "_power_on";
    level waittill(notify_name);
    if (!isdefined(level._perkmachinenetworkchoke)) {
        level._perkmachinenetworkchoke = 0;
    } else {
        level._perkmachinenetworkchoke++;
    }
    for (i = 0; i < level._perkmachinenetworkchoke; i++) {
        util::wait_network_frame();
    }
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].hint_string)) {
        self.hint_string = level._custom_perks[perk].hint_string;
        self.hint_parm1 = cost;
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x1d21a2a2, Offset: 0x1e70
// Size: 0x570
function vending_trigger_think() {
    self endon(#"death");
    perk = self.script_noteworthy;
    cost = self.stub.cost;
    n_slot = self.stub.script_int;
    self thread zm_audio::sndperksjingles_timer();
    for (;;) {
        waitresult = self waittill(#"trigger");
        player = waitresult.activator;
        var_f36ee911 = 0;
        if (isdefined(self.stub.machine)) {
            var_f36ee911 = self.stub.machine.power_on;
        }
        if (!var_f36ee911) {
            wait 0.1;
            continue;
        }
        index = zm_utility::get_player_index(player);
        if (!vending_trigger_can_player_use(player, 1)) {
            wait 0.1;
            continue;
        }
        if (player hasperk(perk) || player has_perk_paused(perk)) {
            cheat = 0;
            /#
                if (getdvarint(#"zombie_cheat", 0) >= 5) {
                    cheat = 1;
                }
            #/
            if (cheat != 1) {
                self playsound(#"evt_perk_deny");
                continue;
            }
        }
        if (isdefined(level.custom_perk_validation)) {
            valid = self [[ level.custom_perk_validation ]](player);
            if (!valid) {
                continue;
            }
        }
        current_cost = cost;
        if (n_slot == 0 && isdefined(player.talisman_perk_reducecost_1) && player.talisman_perk_reducecost_1) {
            current_cost -= player.talisman_perk_reducecost_1;
        }
        if (n_slot == 1 && isdefined(player.talisman_perk_reducecost_2) && player.talisman_perk_reducecost_2) {
            current_cost -= player.talisman_perk_reducecost_2;
        }
        if (n_slot == 2 && isdefined(player.talisman_perk_reducecost_3) && player.talisman_perk_reducecost_3) {
            current_cost -= player.talisman_perk_reducecost_3;
        }
        if (n_slot == 3 && isdefined(player.talisman_perk_reducecost_4) && player.talisman_perk_reducecost_4) {
            current_cost -= player.talisman_perk_reducecost_4;
        }
        if (!player zm_score::can_player_purchase(current_cost)) {
            self playsound(#"evt_perk_deny");
            player zm_audio::create_and_play_dialog("general", "outofmoney");
            continue;
        }
        if (!player zm_utility::can_player_purchase_perk()) {
            self playsound(#"evt_perk_deny");
            continue;
        }
        sound = "evt_bottle_dispense";
        playsoundatposition(sound, self.origin);
        player zm_score::minus_to_player_score(current_cost);
        bb::logpurchaseevent(player, self, current_cost, perk, 0, "_perk", "_purchased");
        perkhash = -1;
        if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].hash_id)) {
            perkhash = level._custom_perks[perk].hash_id;
        }
        player recordmapevent(29, gettime(), self.origin, level.round_number, perkhash);
        player.perk_purchased = perk;
        player notify(#"perk_purchased", {#perk:perk});
        self thread zm_audio::sndperksjingles_player(1);
        self thread vending_trigger_post_think(player, perk);
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0xd92ac3ed, Offset: 0x23e8
// Size: 0x21c
function vending_trigger_post_think(player, perk) {
    player endon(#"disconnect", #"end_game", #"perk_abort_drinking");
    player perk_give_bottle_begin(perk);
    evt = player waittilltimeout(3, #"fake_death", #"death", #"player_downed", #"offhand_end", #"perk_abort_drinking", #"disconnect");
    if (evt._notify == "offhand_end" || evt._notify == #"timeout") {
        player thread wait_give_perk(perk, 1);
    }
    if (player laststand::player_is_in_laststand() || isdefined(player.intermission) && player.intermission) {
        return;
    }
    player notify(#"burp");
    if (isdefined(level.var_7b162f9e)) {
        player [[ level.var_7b162f9e ]](perk);
    }
    player.perk_purchased = undefined;
    if (!(isdefined(self.stub.machine.power_on) && self.stub.machine.power_on)) {
        wait 1;
        perk_pause(self.script_noteworthy);
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0xa41fd30c, Offset: 0x2610
// Size: 0xcc
function wait_give_perk(perk, bought) {
    self endon(#"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
    self waittilltimeout(0.5, #"burp", #"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
    self give_perk(perk, bought);
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xb2ac9d15, Offset: 0x26e8
// Size: 0xcc
function give_perk_presentation(perk) {
    self endon(#"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
    self zm_audio::playerexert("burp");
    self thread function_2877a25e(perk);
    self setblur(9, 0.1);
    wait 0.1;
    self setblur(0, 0.1);
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x4a407cc9, Offset: 0x27c0
// Size: 0x74
function function_2877a25e(perk) {
    self endon(#"death");
    b_played = self zm_audio::create_and_play_dialog("perk", perk);
    if (!b_played) {
        self zm_audio::create_and_play_dialog("perk", "generic");
    }
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x0
// Checksum 0x48092cc2, Offset: 0x2840
// Size: 0x4fc
function give_perk(perk, bought, var_a72d8b79 = 0) {
    self perks::perk_setperk(perk);
    if (isdefined(level._custom_perks[perk].var_c860c5b4)) {
        if (isarray(level._custom_perks[perk].var_c860c5b4)) {
            foreach (specialty in level._custom_perks[perk].var_c860c5b4) {
                perks::perk_setperk(specialty);
            }
        } else {
            perks::perk_setperk(level._custom_perks[perk].var_c860c5b4);
        }
    }
    if (!var_a72d8b79) {
        self.num_perks++;
    }
    if (isdefined(bought) && bought) {
        self thread give_perk_presentation(perk);
        self notify(#"perk_bought", {#var_70221ebf:perk});
        self zm_stats::increment_challenge_stat("SURVIVALIST_BUY_PERK");
    }
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_give)) {
        self thread [[ level._custom_perks[perk].player_thread_give ]]();
    }
    self set_perk_clientfield(perk, 1);
    demo::bookmark(#"zm_player_perk", gettime(), self);
    potm::bookmark(#"zm_player_perk", gettime(), self);
    self zm_stats::increment_client_stat("perks_drank");
    self zm_stats::increment_client_stat(perk + "_drank");
    self zm_stats::increment_player_stat(perk + "_drank");
    self zm_stats::increment_player_stat("perks_drank");
    if (!isdefined(self.perk_history)) {
        self.perk_history = [];
    } else if (!isarray(self.perk_history)) {
        self.perk_history = array(self.perk_history);
    }
    if (!isinarray(self.perk_history, perk)) {
        self.perk_history[self.perk_history.size] = perk;
    }
    if (!isdefined(self.var_59fcabb7)) {
        self.var_59fcabb7 = [];
    } else if (!isarray(self.var_59fcabb7)) {
        self.var_59fcabb7 = array(self.var_59fcabb7);
    }
    if (!isinarray(self.var_59fcabb7, perk)) {
        self.var_59fcabb7[self.var_59fcabb7.size] = perk;
    }
    if (isdefined(self.talisman_perk_permanent) && self.var_871d24d3[self.talisman_perk_permanent] === perk || zm_utility::is_standard()) {
        if (!isdefined(self.var_b318c4f9)) {
            self.var_b318c4f9 = [];
        } else if (!isarray(self.var_b318c4f9)) {
            self.var_b318c4f9 = array(self.var_b318c4f9);
        }
        if (!isinarray(self.var_b318c4f9, perk)) {
            self.var_b318c4f9[self.var_b318c4f9.size] = perk;
        }
    }
    self notify(#"perk_acquired");
    self thread perk_think(perk);
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x8b4ae7a7, Offset: 0x2d48
// Size: 0x32
function vending_set_hintstring(perk) {
    switch (perk) {
    case #"specialty_armorvest":
        break;
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x66e1c39b, Offset: 0x2d88
// Size: 0x28e
function perk_think(perk) {
    self endon(#"disconnect");
    perk_str = perk + "_stop";
    result = self waittill(#"fake_death", #"death", #"player_downed", perk_str);
    result = result._notify;
    self perks::perk_unsetperk(perk);
    if (isdefined(level._custom_perks[perk].var_c860c5b4)) {
        if (isarray(level._custom_perks[perk].var_c860c5b4)) {
            foreach (specialty in level._custom_perks[perk].var_c860c5b4) {
                perks::perk_unsetperk(specialty);
            }
        } else {
            perks::perk_unsetperk(level._custom_perks[perk].var_c860c5b4);
        }
    }
    self.num_perks--;
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_take)) {
        self thread [[ level._custom_perks[perk].player_thread_take ]](0, perk_str, result);
    }
    self set_perk_clientfield(perk, 0);
    self.perk_purchased = undefined;
    if (isdefined(level.var_a72d0823)) {
        self [[ level.var_a72d0823 ]](perk);
    }
    if (isinarray(self.var_59fcabb7, perk)) {
        arrayremovevalue(self.var_59fcabb7, perk, 0);
    }
    self notify(#"hash_2cb946ae6981d56c");
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0xe5f65705, Offset: 0x3020
// Size: 0x68
function set_perk_clientfield(perk, state) {
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].clientfield_set)) {
        self [[ level._custom_perks[perk].clientfield_set ]](state);
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x8dec17d2, Offset: 0x3090
// Size: 0x44
function perk_give_bottle_begin(str_perk) {
    weapon = get_perk_weapon(str_perk);
    self giveandfireoffhand(weapon);
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xd18d6330, Offset: 0x30e0
// Size: 0xd6
function get_perk_weapon(str_perk) {
    weapon = "";
    if (zm_utility::get_story() == 1) {
        if (isdefined(level._custom_perks[str_perk]) && isdefined(level._custom_perks[str_perk].perk_bottle_weapon)) {
            weapon = level._custom_perks[str_perk].perk_bottle_weapon;
        }
    } else if (isdefined(level._custom_perks[str_perk]) && isdefined(level._custom_perks[str_perk].var_e82f552b)) {
        weapon = level._custom_perks[str_perk].var_e82f552b;
    }
    return weapon;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xfc1fe04b, Offset: 0x31c0
// Size: 0x3a
function get_perk_weapon_model(str_perk) {
    weapon = get_perk_weapon(str_perk);
    return weapon.worldmodel;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x7af0c083, Offset: 0x3208
// Size: 0x3c
function perk_abort_drinking(post_delay) {
    if (zm_utility::is_drinking()) {
        self notify(#"perk_abort_drinking");
        if (isdefined(post_delay)) {
            wait post_delay;
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x68ae978e, Offset: 0x3250
// Size: 0x1b6
function function_57435073(var_756935b2) {
    var_afac2e26 = getarraykeys(level._custom_perks);
    if (isdefined(var_756935b2)) {
        var_afac2e26 = array::exclude(var_afac2e26, var_756935b2);
    }
    foreach (str_perk in level.var_fb762d80) {
        arrayremovevalue(var_afac2e26, hash(str_perk));
    }
    var_afac2e26 = array::randomize(var_afac2e26);
    for (i = 0; i < var_afac2e26.size; i++) {
        if (!self hasperk(var_afac2e26[i])) {
            var_ff2247e3 = function_ec1dff78(var_afac2e26[i]);
            if (var_ff2247e3 >= 0) {
                continue;
            }
            self give_perk(var_afac2e26[i], 0);
            return var_afac2e26[i];
        }
    }
    self playsoundtoplayer(level.zmb_laugh_alias, self);
    return undefined;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x2104dbda, Offset: 0x3410
// Size: 0x12c
function lose_random_perk() {
    a_str_perks = getarraykeys(level._custom_perks);
    perks = [];
    for (i = 0; i < a_str_perks.size; i++) {
        perk = a_str_perks[i];
        if (isdefined(self.perk_purchased) && self.perk_purchased == perk) {
            continue;
        }
        if (self hasperk(perk) || self has_perk_paused(perk)) {
            perks[perks.size] = perk;
        }
    }
    if (perks.size > 0) {
        perks = array::randomize(perks);
        perk = perks[0];
        perk_str = perk + "_stop";
        self notify(perk_str);
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x4e14a3d5, Offset: 0x3548
// Size: 0x168
function function_60bc41e4() {
    random_perk = undefined;
    perks = [];
    for (i = 0; i < self.var_871d24d3.size; i++) {
        perk = self.var_871d24d3[i];
        if (isdefined(self.perk_purchased) && self.perk_purchased == perk) {
            continue;
        }
        if (!self hasperk(perk) && !self has_perk_paused(perk)) {
            perks[perks.size] = perk;
        }
    }
    if (perks.size > 0) {
        perks = array::randomize(perks);
        random_perk = perks[0];
        n_index = self function_ec1dff78(random_perk);
        self function_79567d8a(random_perk, n_index);
    } else {
        self playsoundtoplayer(level.zmb_laugh_alias, self);
    }
    return random_perk;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x3cadd07b, Offset: 0x36b8
// Size: 0x8c
function quantum_bomb_give_nearest_perk_validation(position) {
    vending_machines = get_perk_machines();
    range_squared = 32400;
    for (i = 0; i < vending_machines.size; i++) {
        if (distancesquared(vending_machines[i].origin, position) < range_squared) {
            return true;
        }
    }
    return false;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x1664ba71, Offset: 0x3750
// Size: 0x1fa
function quantum_bomb_give_nearest_perk_result(position) {
    [[ level.var_c5e1e17b ]](position);
    vending_machines = get_perk_machines();
    nearest = 0;
    for (i = 1; i < vending_machines.size; i++) {
        if (distancesquared(vending_machines[i].origin, position) < distancesquared(vending_machines[nearest].origin, position)) {
            nearest = i;
        }
    }
    players = getplayers();
    perk = vending_machines[nearest].script_noteworthy;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (player.sessionstate == "spectator" || player laststand::player_is_in_laststand()) {
            continue;
        }
        if (!player hasperk(perk) && (!isdefined(player.perk_purchased) || player.perk_purchased != perk) && randomint(5)) {
            player give_perk(perk);
            player [[ level.var_e09b9d69 ]]();
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x1ecc75d, Offset: 0x3958
// Size: 0x33e
function perk_pause(perk) {
    if (isdefined(level.dont_unset_perk_when_machine_paused) && level.dont_unset_perk_when_machine_paused) {
        return;
    }
    for (j = 0; j < getplayers().size; j++) {
        player = getplayers()[j];
        if (player function_8521d0ed(perk)) {
            continue;
        }
        if (!isdefined(player.var_9fff94cd)) {
            player.var_9fff94cd = [];
        }
        player.var_9fff94cd[perk] = isdefined(player.var_9fff94cd[perk]) && player.var_9fff94cd[perk] || player hasperk(perk);
        if (player.var_9fff94cd[perk]) {
            player perks::perk_unsetperk(perk);
            if (isdefined(level._custom_perks[perk].var_c860c5b4)) {
                if (isarray(level._custom_perks[perk].var_c860c5b4)) {
                    foreach (specialty in level._custom_perks[perk].var_c860c5b4) {
                        perks::perk_unsetperk(specialty);
                    }
                } else {
                    perks::perk_unsetperk(level._custom_perks[perk].var_c860c5b4);
                }
            }
            n_slot = player function_ec1dff78(perk);
            player function_6dd07430(n_slot, 0);
            player set_perk_clientfield(perk, 2);
            if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_take)) {
                player thread [[ level._custom_perks[perk].player_thread_take ]](1);
            }
            println("<dev string:xe1>" + player.name + "<dev string:xec>" + perk + "<dev string:xfa>");
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x16fb02d9, Offset: 0x3ca0
// Size: 0x2f6
function perk_unpause(perk) {
    if (isdefined(level.dont_unset_perk_when_machine_paused) && level.dont_unset_perk_when_machine_paused) {
        return;
    }
    if (!isdefined(perk)) {
        return;
    }
    for (j = 0; j < getplayers().size; j++) {
        player = getplayers()[j];
        if (isdefined(player.var_9fff94cd) && isdefined(player.var_9fff94cd[perk]) && player.var_9fff94cd[perk]) {
            player.var_9fff94cd[perk] = 0;
            player set_perk_clientfield(perk, 1);
            n_slot = player function_ec1dff78(perk);
            player function_6dd07430(n_slot, 1);
            player perks::perk_setperk(perk);
            if (isdefined(level._custom_perks[perk].var_c860c5b4)) {
                if (isarray(level._custom_perks[perk].var_c860c5b4)) {
                    foreach (specialty in level._custom_perks[perk].var_c860c5b4) {
                        perks::perk_setperk(specialty);
                    }
                } else {
                    perks::perk_setperk(level._custom_perks[perk].var_c860c5b4);
                }
            }
            println("<dev string:xe1>" + player.name + "<dev string:xfc>" + perk + "<dev string:xfa>");
            player zm_utility::set_max_health();
            if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_give)) {
                player thread [[ level._custom_perks[perk].player_thread_give ]]();
            }
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x95730e16, Offset: 0x3fa0
// Size: 0xf0
function perk_pause_all_perks(power_zone) {
    vending_machines = get_perk_machines();
    foreach (trigger in vending_machines) {
        if (!isdefined(power_zone)) {
            perk_pause(trigger.script_noteworthy);
            continue;
        }
        if (isdefined(trigger.script_int) && trigger.script_int == power_zone) {
            perk_pause(trigger.script_noteworthy);
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x8939fbd5, Offset: 0x4098
// Size: 0xf0
function perk_unpause_all_perks(power_zone) {
    vending_machines = get_perk_machines();
    foreach (trigger in vending_machines) {
        if (!isdefined(power_zone)) {
            perk_unpause(trigger.script_noteworthy);
            continue;
        }
        if (isdefined(trigger.script_int) && trigger.script_int == power_zone) {
            perk_unpause(trigger.script_noteworthy);
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xca8b04a4, Offset: 0x4190
// Size: 0x90
function function_196c940c() {
    if (isdefined(level.var_3d574fc8)) {
        foreach (var_b6318641 in level.var_3d574fc8) {
            perk_pause(var_b6318641);
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xf113ebee, Offset: 0x4228
// Size: 0x90
function function_53af54f9() {
    if (isdefined(level.var_3d574fc8)) {
        foreach (var_b6318641 in level.var_3d574fc8) {
            perk_unpause(var_b6318641);
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x22de0591, Offset: 0x42c0
// Size: 0x46
function has_perk_paused(perk) {
    if (isdefined(self.var_9fff94cd) && isdefined(self.var_9fff94cd[perk]) && self.var_9fff94cd[perk]) {
        return true;
    }
    return false;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x565f7969, Offset: 0x4310
// Size: 0x7a
function getvendingmachinenotify() {
    if (!isdefined(self)) {
        return "";
    }
    str_perk = undefined;
    if (isdefined(level._custom_perks[self.script_noteworthy]) && isdefined(isdefined(level._custom_perks[self.script_noteworthy].alias))) {
        str_perk = level._custom_perks[self.script_noteworthy].alias;
    }
    return str_perk;
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0xce47a536, Offset: 0x4398
// Size: 0x274
function perk_machine_removal(machine, replacement_model) {
    if (!isdefined(machine)) {
        return;
    }
    trig = getent(machine, "script_noteworthy");
    machine_model = undefined;
    if (isdefined(trig)) {
        trig notify(#"warning_dialog");
        if (isdefined(trig.target)) {
            parts = getentarray(trig.target, "targetname");
            for (i = 0; i < parts.size; i++) {
                if (isdefined(parts[i].classname) && parts[i].classname == "script_model") {
                    machine_model = parts[i];
                    continue;
                }
                if (isdefined(parts[i].script_noteworthy && parts[i].script_noteworthy == "clip")) {
                    model_clip = parts[i];
                    continue;
                }
                parts[i] delete();
            }
        }
        if (isdefined(replacement_model) && isdefined(machine_model)) {
            machine_model setmodel(replacement_model);
        } else if (!isdefined(replacement_model) && isdefined(machine_model)) {
            machine_model delete();
            if (isdefined(model_clip)) {
                model_clip delete();
            }
            if (isdefined(trig.clip)) {
                trig.clip delete();
            }
        }
        if (isdefined(trig.bump)) {
            trig.bump delete();
        }
        trig delete();
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x50e32839, Offset: 0x4618
// Size: 0xa68
function perk_machine_spawn_init() {
    match_string = "";
    location = level.scr_zm_map_start_location;
    if ((location == "default" || location == "") && isdefined(level.default_start_location)) {
        location = level.default_start_location;
    }
    match_string = level.scr_zm_ui_gametype + "_perks_" + location;
    a_s_spawn_pos = [];
    if (isdefined(level.override_perk_targetname)) {
        structs = struct::get_array(level.override_perk_targetname, "targetname");
    } else {
        structs = struct::get_array("zm_perk_machine", "targetname");
    }
    foreach (struct in structs) {
        if (isdefined(struct.script_string)) {
            tokens = strtok(struct.script_string, " ");
            foreach (token in tokens) {
                if (token == match_string) {
                    a_s_spawn_pos[a_s_spawn_pos.size] = struct;
                }
            }
            continue;
        }
        a_s_spawn_pos[a_s_spawn_pos.size] = struct;
    }
    if (a_s_spawn_pos.size == 0) {
        return;
    }
    if (isdefined(level.randomize_perk_machine_location) && level.randomize_perk_machine_location) {
        a_s_random_perk_locs = struct::get_array("perk_random_machine_location", "targetname");
        if (a_s_random_perk_locs.size > 0) {
            a_s_random_perk_locs = array::randomize(a_s_random_perk_locs);
        }
        n_random_perks_assigned = 0;
    }
    foreach (s_spawn_pos in a_s_spawn_pos) {
        perk = s_spawn_pos.script_noteworthy;
        if (isdefined(perk) && isdefined(s_spawn_pos.model)) {
            if (isdefined(level.randomize_perk_machine_location) && level.randomize_perk_machine_location && a_s_random_perk_locs.size > 0 && isdefined(s_spawn_pos.script_notify)) {
                s_new_loc = a_s_random_perk_locs[n_random_perks_assigned];
                s_spawn_pos.origin = s_new_loc.origin;
                s_spawn_pos.angles = s_new_loc.angles;
                if (isdefined(s_new_loc.script_int)) {
                    s_spawn_pos.script_int = s_new_loc.script_int;
                }
                if (isdefined(s_new_loc.target)) {
                    s_tell_location = struct::get(s_new_loc.target);
                    if (isdefined(s_tell_location)) {
                        util::spawn_model("p7_zm_perk_bottle_broken_" + perk, s_tell_location.origin, s_tell_location.angles);
                    }
                }
                n_random_perks_assigned++;
            }
            width = 64;
            height = 128;
            length = 64;
            up = 60;
            fwd = 20;
            forward = anglestoright(s_spawn_pos.angles) * fwd;
            unitrigger_stub = spawnstruct();
            unitrigger_stub.origin = s_spawn_pos.origin + (0, 0, up) + forward;
            unitrigger_stub.angles = s_spawn_pos.angles;
            unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
            unitrigger_stub.cursor_hint = "HINT_NOICON";
            unitrigger_stub.script_width = width;
            unitrigger_stub.script_height = height;
            unitrigger_stub.script_length = length;
            unitrigger_stub.require_look_at = 0;
            unitrigger_stub.targetname = "zombie_vending";
            unitrigger_stub.script_noteworthy = perk;
            unitrigger_stub.hint_string = #"zombie/need_power";
            unitrigger_stub.hint_parm1 = undefined;
            unitrigger_stub.hint_parm2 = undefined;
            if (isdefined(s_spawn_pos.script_int)) {
                unitrigger_stub.script_int = s_spawn_pos.script_int;
            }
            zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
            unitrigger_stub.prompt_and_visibility_func = &function_2de9ce50;
            zm_unitrigger::register_static_unitrigger(unitrigger_stub, &vending_trigger_think);
            perk_machine = spawn("script_model", s_spawn_pos.origin);
            if (!isdefined(s_spawn_pos.angles)) {
                s_spawn_pos.angles = (0, 0, 0);
            }
            perk_machine.angles = s_spawn_pos.angles;
            perk_machine setmodel(s_spawn_pos.model);
            if (isdefined(level._no_vending_machine_bump_trigs) && level._no_vending_machine_bump_trigs) {
                bump_trigger = undefined;
            } else {
                bump_trigger = spawn("trigger_radius", s_spawn_pos.origin + (0, 0, 30), 0, 40, 80, 1);
                bump_trigger.script_activated = 1;
                bump_trigger.script_sound = "zmb_perks_bump_bottle";
                bump_trigger.targetname = "audio_bump_trigger";
            }
            if (isdefined(level._no_vending_machine_auto_collision) && level._no_vending_machine_auto_collision) {
                collision = undefined;
            } else {
                collision = spawn("script_model", s_spawn_pos.origin, 1);
                collision.angles = s_spawn_pos.angles;
                collision setmodel(#"zm_collision_perks1");
                collision.script_noteworthy = "clip";
                collision disconnectpaths();
            }
            unitrigger_stub.clip = collision;
            unitrigger_stub.machine = perk_machine;
            unitrigger_stub.bump = bump_trigger;
            if (isdefined(s_spawn_pos.script_notify)) {
                perk_machine.script_notify = s_spawn_pos.script_notify;
            }
            if (isdefined(s_spawn_pos.target)) {
                perk_machine.target = s_spawn_pos.target;
            }
            if (isdefined(s_spawn_pos.blocker_model)) {
                unitrigger_stub.blocker_model = s_spawn_pos.blocker_model;
            }
            if (isdefined(s_spawn_pos.script_int)) {
                perk_machine.script_int = s_spawn_pos.script_int;
            }
            if (isdefined(s_spawn_pos.turn_on_notify)) {
                perk_machine.turn_on_notify = s_spawn_pos.turn_on_notify;
            }
            unitrigger_stub.script_sound = "mus_perks_speed_jingle";
            unitrigger_stub.script_string = "speedcola_perk";
            unitrigger_stub.script_label = "mus_perks_speed_sting";
            unitrigger_stub.target = "vending_sleight";
            perk_machine.script_string = "speedcola_perk";
            perk_machine.targetname = "vending_sleight";
            if (isdefined(bump_trigger)) {
                bump_trigger.script_string = "speedcola_perk";
            }
            if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].perk_machine_set_kvps)) {
                [[ level._custom_perks[perk].perk_machine_set_kvps ]](unitrigger_stub, perk_machine, bump_trigger, collision);
            }
            unitrigger_stub thread function_846f73f5();
            unitrigger_stub thread electric_perks_dialog();
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xf01a0c92, Offset: 0x5088
// Size: 0x286
function function_2de9ce50(player) {
    perk = self.script_noteworthy;
    var_f36ee911 = 0;
    if (isdefined(self.stub.machine)) {
        var_f36ee911 = self.stub.machine.power_on;
    }
    if (isdefined(perk) && !player hasperk(perk) && self vending_trigger_can_player_use(player, 1) && !player has_perk_paused(perk) && !player zm_utility::in_revive_trigger() && !zm_equipment::is_equipment_that_blocks_purchase(player getcurrentweapon()) && !player zm_equipment::hacker_active()) {
        b_is_invis = 0;
        if (!var_f36ee911) {
            self.stub.hint_string = "ZOMBIE/NEED_POWER";
            self.stub.hint_parm1 = undefined;
        } else {
            cost = zombie_utility::get_zombie_var(#"zombie_perk_cost");
            if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].cost)) {
                if (isint(level._custom_perks[perk].cost)) {
                    cost = level._custom_perks[perk].cost;
                } else {
                    cost = [[ level._custom_perks[perk].cost ]]();
                }
            }
            self.stub.hint_string = level._custom_perks[perk].hint_string;
            self.stub.hint_parm1 = cost;
        }
        zm_unitrigger::function_f4c6e130(self.stub, self, player);
    } else {
        b_is_invis = 1;
    }
    return !b_is_invis;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x19286879, Offset: 0x5318
// Size: 0x214
function check_player_has_perk(perk) {
    self endon(#"death");
    /#
        if (getdvarint(#"zombie_cheat", 0) >= 5) {
            return;
        }
    #/
    dist = 16384;
    while (true) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (distancesquared(players[i].origin, self.origin) < dist) {
                if (!players[i] hasperk(perk) && self vending_trigger_can_player_use(players[i], 1) && !players[i] has_perk_paused(perk) && !players[i] zm_utility::in_revive_trigger() && !zm_equipment::is_equipment_that_blocks_purchase(players[i] getcurrentweapon()) && !players[i] zm_equipment::hacker_active()) {
                    self setinvisibletoplayer(players[i], 0);
                    continue;
                }
                self setinvisibletoplayer(players[i], 1);
            }
        }
        wait 0.1;
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xd4d90d21, Offset: 0x5538
// Size: 0x7a
function get_perk_machine_start_state(perk) {
    if (isdefined(level.vending_machines_powered_on_at_start) && level.vending_machines_powered_on_at_start) {
        return 1;
    }
    if (perk == #"specialty_quickrevive") {
        assert(isdefined(level.revive_machine_is_solo));
        return level.revive_machine_is_solo;
    }
    return 0;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xf86f2a45, Offset: 0x55c0
// Size: 0x5a4
function perks_register_clientfield() {
    if (isdefined(level.zombiemode_using_perk_intro_fx) && level.zombiemode_using_perk_intro_fx) {
        clientfield::register("scriptmover", "clientfield_perk_intro_fx", 1, 1, "int");
    }
    if (isdefined(level._custom_perks)) {
        a_keys = getarraykeys(level._custom_perks);
        for (i = 0; i < a_keys.size; i++) {
            if (isdefined(level._custom_perks[a_keys[i]].clientfield_register)) {
                level [[ level._custom_perks[a_keys[i]].clientfield_register ]]();
            }
        }
    }
    for (i = 0; i < 4; i++) {
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".itemIndex", 1, 5, "int");
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".state", 1, 2, "int");
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".progress", 1, 5, "float");
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".chargeCount", 1, 2, "int");
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".timerActive", 1, 1, "int");
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".bleedoutOrderIndex", 1, 2, "int");
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".bleedoutActive", 1, 1, "int");
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".bleedoutProgress", 1, 5, "float");
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".specialEffectActive", 1, 1, "int");
    }
    clientfield::register("scriptmover", "" + #"hash_cf74c35ecc5a49", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_35fe26fc5cb223b3", 1, 3, "int");
    clientfield::register("toplayer", "" + #"hash_6fb426c48a4877e0", 1, 3, "int");
    clientfield::register("toplayer", "" + #"hash_345845080e40675d", 1, 3, "int");
    clientfield::register("toplayer", "" + #"hash_1da6660f0414562", 1, 3, "int");
    if (zm_utility::get_story() == 2) {
        clientfield::register("world", "" + #"hash_46334db9e3c76275", 1, 1, "int");
        clientfield::register("scriptmover", "" + #"hash_50eb488e58f66198", 1, 1, "int");
        clientfield::register("allplayers", "" + #"hash_222c3403d2641ea6", 1, 3, "int");
        clientfield::register("toplayer", "" + #"hash_17283692696da23b", 1, 1, "counter");
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x47a34cc9, Offset: 0x5b70
// Size: 0x3c
function function_a35981f(var_808ef910, var_db8481c1) {
    self clientfield::set_player_uimodel("hudItems.perkVapor." + var_808ef910 + ".itemIndex", var_db8481c1);
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x30e4e87d, Offset: 0x5bb8
// Size: 0x54
function function_4a5cdd0d(var_808ef910, var_1b219480) {
    self clientfield::set_player_uimodel("hudItems.perkVapor." + var_808ef910 + ".itemIndex", getitemindexfromref(var_1b219480));
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0xeeac52b6, Offset: 0x5c18
// Size: 0x3c
function function_6dd07430(var_808ef910, var_e2a074d9) {
    self clientfield::set_player_uimodel("hudItems.perkVapor." + var_808ef910 + ".state", var_e2a074d9);
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x11dbb796, Offset: 0x5c60
// Size: 0xbc
function function_2b57e880(var_808ef910, var_5303c843) {
    if (var_808ef910 != -1) {
        if (var_5303c843 == 1 && self.var_445e9569 !== 1) {
            self.var_445e9569 = 1;
            self playsoundtoplayer(#"hash_7e01de7cf0aa4995", self);
        } else if (var_5303c843 != 1) {
            self.var_445e9569 = var_5303c843;
        }
        self clientfield::set_player_uimodel("hudItems.perkVapor." + var_808ef910 + ".progress", var_5303c843);
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x453e2016, Offset: 0x5d28
// Size: 0x4c
function function_69e1eb5d(var_808ef910, var_3de5a9b6) {
    if (var_808ef910 != -1) {
        self clientfield::set_player_uimodel("hudItems.perkVapor." + var_808ef910 + ".chargeCount", var_3de5a9b6);
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x16009c9d, Offset: 0x5d80
// Size: 0x5c
function function_25bb08(n_slot, var_70221ebf) {
    var_39434b4b = level._custom_perks[var_70221ebf].alias;
    if (isdefined(var_39434b4b)) {
        self thread function_4a5cdd0d(n_slot, var_39434b4b);
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xd8a67929, Offset: 0x5de8
// Size: 0x98
function thread_bump_trigger() {
    for (;;) {
        waitresult = self waittill(#"trigger");
        trigplayer = waitresult.activator;
        trigplayer playsound(self.script_sound);
        while (zm_utility::is_player_valid(trigplayer) && trigplayer istouching(self)) {
            wait 0.5;
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xf3491709, Offset: 0x5e88
// Size: 0x136
function players_are_in_perk_area(perk_machine) {
    perk_area_origin = level.quick_revive_default_origin;
    if (isdefined(perk_machine._linked_ent)) {
        perk_area_origin = perk_machine._linked_ent.origin;
        if (isdefined(perk_machine._linked_ent_offset)) {
            perk_area_origin += perk_machine._linked_ent_offset;
        }
    }
    in_area = 0;
    players = getplayers();
    dist_check = 9216;
    foreach (player in players) {
        if (distancesquared(player.origin, perk_area_origin) < dist_check) {
            return true;
        }
    }
    return false;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x914e19e3, Offset: 0x5fc8
// Size: 0x174
function perk_hostmigration() {
    level endon(#"end_game");
    level notify(#"perk_hostmigration");
    level endon(#"perk_hostmigration");
    while (true) {
        level waittill(#"host_migration_end");
        if (isdefined(level._custom_perks) && level._custom_perks.size > 0) {
            a_keys = getarraykeys(level._custom_perks);
            foreach (key in a_keys) {
                if (isdefined(level._custom_perks[key].radiant_machine_name) && isdefined(level._custom_perks[key].machine_light_effect)) {
                    level thread host_migration_func(level._custom_perks[key], key);
                }
            }
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0xb76ad002, Offset: 0x6148
// Size: 0x118
function host_migration_func(s_custom_perk, keyname) {
    a_machines = getentarray(s_custom_perk.radiant_machine_name, "targetname");
    foreach (perk in a_machines) {
        if (isdefined(perk.model) && perk.model == level.machine_assets[keyname].on_model) {
            perk perk_fx(undefined, 1);
            perk thread perk_fx(s_custom_perk.machine_light_effect);
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x9946f205, Offset: 0x6268
// Size: 0xe8
function spare_change(str_trigger = "audio_bump_trigger", str_sound = "zmb_perks_bump_bottle") {
    a_t_audio = getentarray(str_trigger, "targetname");
    foreach (t_audio_bump in a_t_audio) {
        if (t_audio_bump.script_sound === str_sound) {
            t_audio_bump thread check_for_change();
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x4e60bd0e, Offset: 0x6358
// Size: 0xbc
function check_for_change() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"trigger");
        player = waitresult.activator;
        if (player getstance() == "prone") {
            player zm_score::add_to_player_score(100);
            zm_utility::play_sound_at_pos("purchase", player.origin);
            break;
        }
        wait 0.1;
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x94c8a153, Offset: 0x6420
// Size: 0xa4
function get_perk_array() {
    perk_array = [];
    if (level._custom_perks.size > 0) {
        a_keys = getarraykeys(level._custom_perks);
        for (i = 0; i < a_keys.size; i++) {
            if (self hasperk(a_keys[i])) {
                perk_array[perk_array.size] = a_keys[i];
            }
        }
    }
    return perk_array;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xf2bd5da5, Offset: 0x64d0
// Size: 0x22
function function_aa9d5b3f() {
    if (!isdefined(level._custom_perks)) {
        level._custom_perks = [];
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x8d38ddc3, Offset: 0x6500
// Size: 0x46
function register_revive_success_perk_func(revive_func) {
    if (!isdefined(level.a_revive_success_perk_func)) {
        level.a_revive_success_perk_func = [];
    }
    level.a_revive_success_perk_func[level.a_revive_success_perk_func.size] = revive_func;
}

// Namespace zm_perks/zm_perks
// Params 7, eflags: 0x0
// Checksum 0x900c8689, Offset: 0x6550
// Size: 0x522
function register_perk_basic_info(str_perk, str_alias, n_perk_cost, str_hint_string, w_perk_bottle_weapon, var_cb646405, var_e4c6448c) {
    assert(isdefined(str_perk), "<dev string:x10c>");
    assert(isdefined(str_alias), "<dev string:x14a>");
    assert(isdefined(n_perk_cost), "<dev string:x189>");
    assert(isdefined(str_hint_string), "<dev string:x1ca>");
    assert(isdefined(w_perk_bottle_weapon), "<dev string:x20f>");
    assert(isdefined(var_cb646405), "<dev string:x259>");
    _register_undefined_perk(str_perk);
    level._custom_perks[str_perk].alias = str_alias;
    level._custom_perks[str_perk].hash_id = stathash(str_alias);
    level._custom_perks[str_perk].cost = n_perk_cost;
    level._custom_perks[str_perk].hint_string = str_hint_string;
    level._custom_perks[str_perk].perk_bottle_weapon = w_perk_bottle_weapon;
    level._custom_perks[str_perk].var_e82f552b = var_cb646405;
    if (!getgametypesetting(#"magic") || !(isdefined(zm_custom::function_5638f689(#"zmperksactive")) && zm_custom::function_5638f689(#"zmperksactive"))) {
        return;
    }
    if (!isdefined(level.var_3d574fc8)) {
        level.var_3d574fc8 = [];
    }
    if (isdefined(var_e4c6448c) && isdefined(zm_custom::function_5638f689(var_e4c6448c)) && zm_custom::function_5638f689(var_e4c6448c)) {
        if (!isdefined(level.var_3d574fc8)) {
            level.var_3d574fc8 = [];
        } else if (!isarray(level.var_3d574fc8)) {
            level.var_3d574fc8 = array(level.var_3d574fc8);
        }
        if (!isinarray(level.var_3d574fc8, hash(str_perk))) {
            level.var_3d574fc8[level.var_3d574fc8.size] = hash(str_perk);
        }
    } else if (!isdefined(var_e4c6448c)) {
        if (!isdefined(level.var_3d574fc8)) {
            level.var_3d574fc8 = [];
        } else if (!isarray(level.var_3d574fc8)) {
            level.var_3d574fc8 = array(level.var_3d574fc8);
        }
        if (!isinarray(level.var_3d574fc8, hash(str_perk))) {
            level.var_3d574fc8[level.var_3d574fc8.size] = hash(str_perk);
        }
    }
    if (!isdefined(level.var_9b40a9a5)) {
        level.var_9b40a9a5 = [];
    }
    if (str_perk != #"specialty_mystery") {
        if (!isdefined(level.var_9b40a9a5)) {
            level.var_9b40a9a5 = [];
        } else if (!isarray(level.var_9b40a9a5)) {
            level.var_9b40a9a5 = array(level.var_9b40a9a5);
        }
        if (!isinarray(level.var_9b40a9a5, hash(str_perk))) {
            level.var_9b40a9a5[level.var_9b40a9a5.size] = hash(str_perk);
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 4, eflags: 0x0
// Checksum 0x4311bfc4, Offset: 0x6a80
// Size: 0x19e
function register_perk_mod_basic_info(str_perk, str_alias, var_2026d4f0, n_cost) {
    assert(isdefined(str_perk), "<dev string:x29c>");
    assert(isdefined(str_alias), "<dev string:x2de>");
    assert(isdefined(var_2026d4f0), "<dev string:x321>");
    assert(isdefined(n_cost), "<dev string:x36a>");
    _register_undefined_perk(str_perk);
    level._custom_perks[str_perk].alias = str_alias;
    level._custom_perks[str_perk].hash_id = stathash(str_alias);
    level._custom_perks[str_perk].n_cost = n_cost;
    if (!isdefined(level.var_fb762d80)) {
        level.var_fb762d80 = [];
    } else if (!isarray(level.var_fb762d80)) {
        level.var_fb762d80 = array(level.var_fb762d80);
    }
    level.var_fb762d80[var_2026d4f0] = str_perk;
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x0
// Checksum 0x2b9762f3, Offset: 0x6c28
// Size: 0xf2
function register_perk_machine(str_perk, func_perk_machine_setup, func_perk_machine_thread) {
    assert(isdefined(str_perk), "<dev string:x3aa>");
    assert(isdefined(func_perk_machine_setup), "<dev string:x3e5>");
    _register_undefined_perk(str_perk);
    if (!isdefined(level._custom_perks[str_perk].perk_machine_set_kvps)) {
        level._custom_perks[str_perk].perk_machine_set_kvps = func_perk_machine_setup;
    }
    if (!isdefined(level._custom_perks[str_perk].perk_machine_thread) && isdefined(func_perk_machine_thread)) {
        level._custom_perks[str_perk].perk_machine_thread = func_perk_machine_thread;
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x8661c4b2, Offset: 0x6d28
// Size: 0xb2
function register_perk_machine_power_override(str_perk, func_perk_machine_power_override) {
    assert(isdefined(str_perk), "<dev string:x42f>");
    assert(isdefined(func_perk_machine_power_override), "<dev string:x479>");
    _register_undefined_perk(str_perk);
    if (!isdefined(level._custom_perks[str_perk].perk_machine_power_override_thread) && isdefined(func_perk_machine_power_override)) {
        level._custom_perks[str_perk].perk_machine_power_override_thread = func_perk_machine_power_override;
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0xac0a757e, Offset: 0x6de8
// Size: 0xa6
function register_perk_precache_func(str_perk, func_precache) {
    assert(isdefined(str_perk), "<dev string:x4db>");
    assert(isdefined(func_precache), "<dev string:x51c>");
    _register_undefined_perk(str_perk);
    if (!isdefined(level._custom_perks[str_perk].precache_func)) {
        level._custom_perks[str_perk].precache_func = func_precache;
    }
}

// Namespace zm_perks/zm_perks
// Params 4, eflags: 0x0
// Checksum 0xd19ba5f3, Offset: 0x6e98
// Size: 0x132
function register_perk_threads(str_perk, func_give_player_perk, func_take_player_perk, var_64a282c9) {
    assert(isdefined(str_perk), "<dev string:x562>");
    assert(isdefined(func_give_player_perk), "<dev string:x59d>");
    _register_undefined_perk(str_perk);
    if (!isdefined(level._custom_perks[str_perk].player_thread_give)) {
        level._custom_perks[str_perk].player_thread_give = func_give_player_perk;
    }
    if (!isdefined(level._custom_perks[str_perk].player_thread_take)) {
        level._custom_perks[str_perk].player_thread_take = func_take_player_perk;
    }
    if (isdefined(var_64a282c9) && !isdefined(level._custom_perks[str_perk].var_64a282c9)) {
        level._custom_perks[str_perk].var_64a282c9 = var_64a282c9;
    }
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x0
// Checksum 0xe2b17bb3, Offset: 0x6fd8
// Size: 0x106
function register_perk_clientfields(str_perk, func_clientfield_register, func_clientfield_set) {
    assert(isdefined(str_perk), "<dev string:x5e5>");
    assert(isdefined(func_clientfield_register), "<dev string:x625>");
    assert(isdefined(func_clientfield_set), "<dev string:x676>");
    _register_undefined_perk(str_perk);
    if (!isdefined(level._custom_perks[str_perk].clientfield_register)) {
        level._custom_perks[str_perk].clientfield_register = func_clientfield_register;
    }
    if (!isdefined(level._custom_perks[str_perk].clientfield_set)) {
        level._custom_perks[str_perk].clientfield_set = func_clientfield_set;
    }
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x0
// Checksum 0xf9cc66c1, Offset: 0x70e8
// Size: 0x106
function register_perk_host_migration_params(str_perk, str_radiant_name, str_effect_name) {
    assert(isdefined(str_perk), "<dev string:x6c2>");
    assert(isdefined(str_radiant_name), "<dev string:x70b>");
    assert(isdefined(str_effect_name), "<dev string:x75c>");
    _register_undefined_perk(str_perk);
    if (!isdefined(level._custom_perks[str_perk].var_cc657044)) {
        level._custom_perks[str_perk].radiant_machine_name = str_radiant_name;
    }
    if (!isdefined(level._custom_perks[str_perk].var_39737b3d)) {
        level._custom_perks[str_perk].machine_light_effect = str_effect_name;
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x13dd2bc, Offset: 0x71f8
// Size: 0x66
function _register_undefined_perk(str_perk) {
    if (!isdefined(level._custom_perks)) {
        level._custom_perks = [];
    }
    if (!isdefined(level._custom_perks[str_perk])) {
        level._custom_perks[str_perk] = spawnstruct();
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x1ecae35c, Offset: 0x7268
// Size: 0x6c
function register_perk_damage_override_func(func_damage_override) {
    assert(isdefined(func_damage_override), "<dev string:x7ac>");
    if (!isdefined(level.perk_damage_override)) {
        level.perk_damage_override = [];
    }
    array::add(level.perk_damage_override, func_damage_override, 0);
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x6d1cfea1, Offset: 0x72e0
// Size: 0x8a
function function_b769b7fb(str_perk, var_5b6d1dae) {
    assert(isdefined(str_perk), "<dev string:x800>");
    assert(isdefined(var_5b6d1dae), "<dev string:x83c>");
    _register_undefined_perk(str_perk);
    level._custom_perks[str_perk].var_c860c5b4 = var_5b6d1dae;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x36335382, Offset: 0x7378
// Size: 0x1a
function function_aa548720() {
    return struct::get_array("perk_vapor_altar");
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x918f6688, Offset: 0x73a0
// Size: 0x606
function perk_vapor_altar_init() {
    function_51e85f6b();
    a_s_spawn_pos = [];
    a_structs = array::randomize(struct::get_array("perk_vapor_altar"));
    foreach (struct in a_structs) {
        if (!isdefined(struct.script_int) || struct.script_int == -1) {
            for (i = 0; i < 4; i++) {
                if (!(isdefined(function_b9375b7c(i, a_structs)) && function_b9375b7c(i, a_structs))) {
                    struct.script_int = i;
                    break;
                }
            }
        }
        a_s_spawn_pos[struct.script_int] = struct;
    }
    if (a_s_spawn_pos.size == 0) {
        return;
    }
    foreach (s_spawn_pos in a_s_spawn_pos) {
        n_slot = s_spawn_pos.script_int;
        if (isdefined(n_slot)) {
            forward = anglestoright(s_spawn_pos.angles) * 0;
            unitrigger_stub = spawnstruct();
            unitrigger_stub.origin = s_spawn_pos.origin + (0, 0, 0) + forward;
            unitrigger_stub.angles = s_spawn_pos.angles;
            unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
            unitrigger_stub.cursor_hint = "HINT_NOICON";
            unitrigger_stub.script_width = 64;
            unitrigger_stub.script_height = 64;
            unitrigger_stub.script_length = 64;
            unitrigger_stub.require_look_at = 0;
            unitrigger_stub.targetname = "perk_vapor_altar_stub";
            unitrigger_stub.script_int = n_slot;
            unitrigger_stub.hint_string = #"zombie/need_power";
            unitrigger_stub.hint_parm1 = undefined;
            unitrigger_stub.hint_parm2 = undefined;
            zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
            unitrigger_stub.prompt_and_visibility_func = &function_ac8ebe81;
            zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_ef65b63b);
            zm_unitrigger::function_9946242d(unitrigger_stub, 1);
            if (!isdefined(s_spawn_pos.angles)) {
                s_spawn_pos.angles = (0, 0, 0);
            }
            if (isdefined(level._no_vending_machine_bump_trigs) && level._no_vending_machine_bump_trigs) {
                bump_trigger = undefined;
            } else {
                bump_trigger = spawn("trigger_radius", s_spawn_pos.origin + (0, 0, 30), 0, 40, 80, 1);
                bump_trigger.script_activated = 1;
                bump_trigger.script_sound = "zmb_perks_bump_bottle";
                bump_trigger.targetname = "audio_bump_trigger";
            }
            if (isdefined(level._no_vending_machine_auto_collision) && level._no_vending_machine_auto_collision) {
                collision = undefined;
            } else {
                collision = spawn("script_model", s_spawn_pos.origin, 1);
                collision.angles = s_spawn_pos.angles;
                collision setmodel(#"zm_collision_perks1");
                collision.script_noteworthy = "clip";
                collision disconnectpaths();
            }
            unitrigger_stub.clip = collision;
            unitrigger_stub.bump = bump_trigger;
            if (isdefined(s_spawn_pos.blocker_model)) {
                unitrigger_stub.blocker_model = s_spawn_pos.blocker_model;
            }
            unitrigger_stub.var_dd23f742 = s_spawn_pos;
            unitrigger_stub.var_dd23f742.var_548e0166 = "off";
            unitrigger_stub thread function_84b9f268();
            unitrigger_stub thread function_fb513384(s_spawn_pos);
            level.var_8b1c4f80[level.var_8b1c4f80.size] = unitrigger_stub;
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x6ba8084b, Offset: 0x79b0
// Size: 0x41c
function function_51e85f6b() {
    var_45aa9631 = struct::get_array("random_perk_vapor_altar", "script_noteworthy");
    if (var_45aa9631.size > 0) {
        var_649e241d = [];
        for (i = 0; i <= 4; i++) {
            var_649e241d[i] = [];
        }
        foreach (var_e59ca19d in var_45aa9631) {
            if (!isdefined(var_e59ca19d.script_int) || var_e59ca19d.script_int > 3 || var_e59ca19d.script_int < -1) {
                if (!isdefined(var_649e241d[0])) {
                    var_649e241d[0] = [];
                } else if (!isarray(var_649e241d[0])) {
                    var_649e241d[0] = array(var_649e241d[0]);
                }
                var_649e241d[0][var_649e241d[0].size] = var_e59ca19d;
                continue;
            }
            if (!isdefined(var_649e241d[var_e59ca19d.script_int + 1])) {
                var_649e241d[var_e59ca19d.script_int + 1] = [];
            } else if (!isarray(var_649e241d[var_e59ca19d.script_int + 1])) {
                var_649e241d[var_e59ca19d.script_int + 1] = array(var_649e241d[var_e59ca19d.script_int + 1]);
            }
            var_649e241d[var_e59ca19d.script_int + 1][var_649e241d[var_e59ca19d.script_int + 1].size] = var_e59ca19d;
        }
        foreach (var_c5e0b1bd in var_649e241d) {
            s_loc = array::random(var_c5e0b1bd);
            if (isdefined(s_loc)) {
                arrayremovevalue(var_c5e0b1bd, s_loc, 0);
            }
            foreach (var_e59ca19d in var_c5e0b1bd) {
                e_clip = getent(var_e59ca19d.target2, "targetname");
                var_ec065b15 = struct::get(var_e59ca19d.target2);
                if (isdefined(e_clip)) {
                    e_clip delete();
                }
                if (isdefined(var_ec065b15)) {
                    var_ec065b15 struct::delete();
                }
                var_e59ca19d struct::delete();
            }
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0xebe0c5ce, Offset: 0x7dd8
// Size: 0xa2
function function_b9375b7c(n_index, a_structs) {
    foreach (struct in a_structs) {
        if (isdefined(struct.script_int) && struct.script_int == n_index) {
            return true;
        }
    }
    return false;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x63764bb0, Offset: 0x7e88
// Size: 0x5ae
function function_ac8ebe81(player) {
    n_slot = self.stub.script_int;
    perk = player.var_59353358[n_slot] ? #"specialty_mystery" : player.var_871d24d3[n_slot];
    if (self.stub.var_101b4f7f !== 1 && player getstance() === "prone" && distancesquared(self.origin, player.origin) < 9216) {
        self.stub.var_101b4f7f = 1;
        player zm_score::add_to_player_score(100);
        self playsoundtoplayer(#"hash_30fa33e2fb90b58f", player);
    }
    if (!isdefined(n_slot) || !isdefined(player.var_871d24d3) || !isdefined(player.var_871d24d3[n_slot]) || player.var_871d24d3[n_slot] == "") {
        return false;
    }
    if (zm_custom::function_f24cfbd2(player)) {
        return false;
    }
    var_2ccd7617 = 0;
    if (self.stub.var_dd23f742.var_548e0166 == "off") {
        self sethintstringforplayer(player, #"zombie/need_power");
        return true;
    }
    if (zm_trial_disable_buys::is_active()) {
        self sethintstringforplayer(player, #"hash_55d25caf8f7bbb2f");
        return true;
    }
    if (zm_trial_disable_perks::is_active()) {
        self sethintstringforplayer(player, #"hash_77db65489366a43");
        return true;
    }
    if (self.stub.var_dd23f742.var_548e0166 == "on" && isdefined(perk) && !player hasperk(perk) && self vending_trigger_can_player_use(player, 1) && !player has_perk_paused(perk) && !player zm_utility::in_revive_trigger() && !zm_equipment::is_equipment_that_blocks_purchase(player getcurrentweapon()) && !player zm_equipment::hacker_active()) {
        var_2ccd7617 = 1;
    }
    if (var_2ccd7617) {
        b_is_invis = 0;
        if (isdefined(level._custom_perks)) {
            if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].cost) && isdefined(level._custom_perks[perk].hint_string)) {
                n_cost = level function_be6c662b(perk, n_slot);
                if (isdefined(level.var_888148a6)) {
                    var_526695e3 = [[ level.var_888148a6 ]](perk);
                } else {
                    var_526695e3 = level._custom_perks[perk].hint_string;
                }
            }
        }
        if (n_slot == 0 && isdefined(player.talisman_perk_reducecost_1) && player.talisman_perk_reducecost_1) {
            n_cost -= player.talisman_perk_reducecost_1;
        }
        if (n_slot == 1 && isdefined(player.talisman_perk_reducecost_2) && player.talisman_perk_reducecost_2) {
            n_cost -= player.talisman_perk_reducecost_2;
        }
        if (n_slot == 2 && isdefined(player.talisman_perk_reducecost_3) && player.talisman_perk_reducecost_3) {
            n_cost -= player.talisman_perk_reducecost_3;
        }
        if (n_slot == 3 && isdefined(player.talisman_perk_reducecost_4) && player.talisman_perk_reducecost_4) {
            n_cost -= player.talisman_perk_reducecost_4;
        }
        if (isdefined(var_526695e3)) {
            self sethintstringforplayer(player, var_526695e3, n_cost);
        }
    } else {
        b_is_invis = 1;
    }
    return !b_is_invis;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x2cb5b0f1, Offset: 0x8440
// Size: 0x760
function function_ef65b63b() {
    self endon(#"death");
    n_slot = self.stub.script_int;
    n_cost = self.stub.cost;
    for (;;) {
        waitresult = self waittill(#"trigger");
        player = waitresult.activator;
        if (self.stub.var_dd23f742.var_548e0166 != "on") {
            continue;
        }
        if (!vending_trigger_can_player_use(player, 1) || zm_trial_disable_buys::is_active() || zm_trial_disable_perks::is_active()) {
            wait 0.1;
            continue;
        }
        perk = player.var_59353358[n_slot] ? #"specialty_mystery" : player.var_871d24d3[n_slot];
        if (!isdefined(player.var_871d24d3) || player.var_871d24d3.size <= n_slot) {
            return;
        }
        if (player hasperk(perk) || player has_perk_paused(perk)) {
            cheat = 0;
            /#
                if (getdvarint(#"zombie_cheat", 0) >= 5) {
                    cheat = 1;
                }
            #/
            if (cheat != 1) {
                self playsound(#"evt_perk_deny");
                continue;
            }
        }
        if (isdefined(level.custom_perk_validation)) {
            valid = self [[ level.custom_perk_validation ]](player);
            if (!valid) {
                continue;
            }
        }
        if (isdefined(level._custom_perks)) {
            if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].cost) && isdefined(level._custom_perks[perk].hint_string)) {
                n_cost = level function_be6c662b(perk, n_slot);
            }
        }
        current_cost = n_cost;
        if (n_slot == 0 && isdefined(player.talisman_perk_reducecost_1) && player.talisman_perk_reducecost_1) {
            current_cost -= player.talisman_perk_reducecost_1;
        }
        if (n_slot == 1 && isdefined(player.talisman_perk_reducecost_2) && player.talisman_perk_reducecost_2) {
            current_cost -= player.talisman_perk_reducecost_2;
        }
        if (n_slot == 2 && isdefined(player.talisman_perk_reducecost_3) && player.talisman_perk_reducecost_3) {
            current_cost -= player.talisman_perk_reducecost_3;
        }
        if (n_slot == 3 && isdefined(player.talisman_perk_reducecost_4) && player.talisman_perk_reducecost_4) {
            current_cost -= player.talisman_perk_reducecost_4;
        }
        if (!player zm_score::can_player_purchase(current_cost)) {
            self playsound(#"evt_perk_deny");
            player zm_audio::create_and_play_dialog("general", "outofmoney");
            continue;
        }
        player thread zm_audio::create_and_play_dialog("altar", "interact");
        playsoundatposition(#"hash_489cdfeed1ac55bd", self.origin);
        player zm_score::minus_to_player_score(current_cost);
        bb::logpurchaseevent(player, self, current_cost, perk, 0, "_perk", "_purchased");
        perkhash = -1;
        if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].hash_id)) {
            perkhash = level._custom_perks[perk].hash_id;
        }
        player recordmapevent(29, gettime(), self.origin, level.round_number, perkhash);
        player.perk_purchased = perk;
        player notify(#"perk_purchased", {#perk:perk});
        if (player.var_59353358[n_slot]) {
            perk = player function_8e5fbcc0();
            player function_4a5cdd0d(n_slot, level._custom_perks[hash(perk)].alias);
            str_perk = player.var_c4fbbdc2[n_slot];
            if (str_perk != "") {
                if (player hasperk(str_perk)) {
                    player notify(str_perk + "_stop");
                    if (n_slot == 3) {
                        var_5fd8c0d8 = level.var_fb762d80[hash(str_perk)];
                        if (isdefined(var_5fd8c0d8) && player hasperk(var_5fd8c0d8)) {
                            player notify(var_5fd8c0d8 + "_stop");
                        }
                    }
                }
            }
            player.var_c4fbbdc2[n_slot] = perk;
            player.var_871d24d3[n_slot] = perk;
        }
        self thread function_dbd6062(player, perk, n_slot, self.stub.var_dd23f742);
    }
}

// Namespace zm_perks/zm_perks
// Params 4, eflags: 0x0
// Checksum 0x47002175, Offset: 0x8ba8
// Size: 0x20a
function function_dbd6062(player, perk, n_slot, var_dd23f742) {
    player endon(#"disconnect", #"end_game", #"perk_abort_drinking");
    player function_41d8134(n_slot, 5);
    var_dd23f742 thread function_dddea327();
    player perk_give_bottle_begin(perk);
    evt = player waittilltimeout(3, #"fake_death", #"death", #"player_downed", #"offhand_end", #"perk_abort_drinking", #"disconnect");
    if (evt._notify == "offhand_end" || evt._notify == #"timeout") {
        player thread function_79567d8a(perk, n_slot, 1);
    }
    if (player laststand::player_is_in_laststand() || isdefined(player.intermission) && player.intermission) {
        return;
    }
    player notify(#"burp");
    if (isdefined(level.var_7b162f9e)) {
        player [[ level.var_7b162f9e ]](perk);
    }
    player.perk_purchased = undefined;
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x4
// Checksum 0x328248db, Offset: 0x8dc0
// Size: 0xc2
function private function_be6c662b(var_70221ebf, n_slot) {
    if (n_slot == 3) {
        var_24521dd6 = level.var_fb762d80[var_70221ebf];
        n_cost = level._custom_perks[var_24521dd6].n_cost;
    } else if (isfunctionptr(level._custom_perks[var_70221ebf].cost)) {
        n_cost = [[ level._custom_perks[var_70221ebf].cost ]]();
    } else {
        n_cost = level._custom_perks[var_70221ebf].cost;
    }
    return n_cost;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x5c6ebad9, Offset: 0x8e90
// Size: 0x1ea
function function_5d5c8288() {
    self endon(#"death");
    wait 0.01;
    level flag::wait_till("start_zombie_round_logic");
    players = getplayers();
    self endon(#"warning_dialog");
    level endon(#"switch_flipped");
    timer = 0;
    for (;;) {
        wait 0.5;
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (!isdefined(players[i])) {
                continue;
            }
            dist = distancesquared(players[i].origin, self.origin);
            if (dist > 4900) {
                timer = 0;
                continue;
            }
            if (dist < 4900 && timer < 3) {
                wait 0.5;
                timer++;
            }
            if (dist < 4900 && timer == 3) {
                if (!isdefined(players[i])) {
                    continue;
                }
                players[i] thread zm_utility::do_player_vo("vox_start", 5);
                wait 3;
                self notify(#"warning_dialog");
                /#
                    iprintlnbold("<dev string:xd3>");
                #/
            }
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xfc0cfb68, Offset: 0x9088
// Size: 0x14a
function function_84b9f268() {
    self endon(#"death");
    wait 0.01;
    n_slot = self.script_int;
    start_on = 1;
    if (!isdefined(self.cost)) {
        cost = 500 * (n_slot + 1) + 1000;
        self.cost = cost;
    }
    if (!start_on) {
        notify_name = "perk_vapor_altar_" + n_slot + "_power_on";
        level waittill(notify_name);
    }
    start_on = 0;
    if (!isdefined(level._perkmachinenetworkchoke)) {
        level._perkmachinenetworkchoke = 0;
    } else {
        level._perkmachinenetworkchoke++;
    }
    for (i = 0; i < level._perkmachinenetworkchoke; i++) {
        util::wait_network_frame();
    }
    self.hint_string = #"zombie/usealtar";
    self.hint_parm1 = self.cost;
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x0
// Checksum 0xe175df46, Offset: 0x91e0
// Size: 0x77c
function function_79567d8a(perk, n_slot, b_bought = 0) {
    self endon(#"player_downed", #"disconnect", #"perk_abort_drinking");
    level endon(#"end_game");
    self perks::perk_setperk(perk);
    if (isdefined(level._custom_perks[perk].var_c860c5b4)) {
        if (isarray(level._custom_perks[perk].var_c860c5b4)) {
            foreach (specialty in level._custom_perks[perk].var_c860c5b4) {
                perks::perk_setperk(specialty);
            }
        } else {
            perks::perk_setperk(level._custom_perks[perk].var_c860c5b4);
        }
    }
    if (isdefined(b_bought) && b_bought) {
        self thread give_perk_presentation(perk);
        self notify(#"perk_bought", {#var_70221ebf:perk});
        self zm_stats::increment_challenge_stat("SURVIVALIST_BUY_PERK");
        self zm_callings::function_7cafbdd3(16);
    }
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_give)) {
        self thread [[ level._custom_perks[perk].player_thread_give ]]();
    }
    if (n_slot < 4) {
        self function_6dd07430(n_slot, 1);
        if (!(isdefined(b_bought) && b_bought)) {
            self function_41d8134(n_slot, 6);
        }
    }
    self set_perk_clientfield(perk, 1);
    demo::bookmark(#"zm_player_perk", gettime(), self);
    potm::bookmark(#"zm_player_perk", gettime(), self);
    self zm_stats::increment_client_stat("perks_drank");
    self zm_stats::increment_client_stat(perk + "_drank");
    self zm_stats::increment_player_stat(perk + "_drank");
    self zm_stats::increment_player_stat("perks_drank");
    if (!isdefined(self.perk_history)) {
        self.perk_history = [];
    } else if (!isarray(self.perk_history)) {
        self.perk_history = array(self.perk_history);
    }
    if (!isinarray(self.perk_history, perk)) {
        self.perk_history[self.perk_history.size] = perk;
    }
    if (!isdefined(self.var_ee217989)) {
        self.var_ee217989 = [];
    } else if (!isarray(self.var_ee217989)) {
        self.var_ee217989 = array(self.var_ee217989);
    }
    if (!isinarray(self.var_ee217989, perk)) {
        self.var_ee217989[self.var_ee217989.size] = perk;
    }
    function_f35164e8();
    if (isdefined(self.talisman_perk_permanent) && self.talisman_perk_permanent - 1 == n_slot || zm_utility::is_standard()) {
        if (!isdefined(self.var_b318c4f9)) {
            self.var_b318c4f9 = [];
        } else if (!isarray(self.var_b318c4f9)) {
            self.var_b318c4f9 = array(self.var_b318c4f9);
        }
        if (!isinarray(self.var_b318c4f9, perk)) {
            self.var_b318c4f9[self.var_b318c4f9.size] = perk;
        }
    } else if (n_slot < 4) {
        if (!isdefined(self.var_83ef9ace)) {
            self.var_83ef9ace = [];
        } else if (!isarray(self.var_83ef9ace)) {
            self.var_83ef9ace = array(self.var_83ef9ace);
        }
        if (!isinarray(self.var_83ef9ace, perk)) {
            self.var_83ef9ace[self.var_83ef9ace.size] = perk;
        }
    }
    self notify(#"perk_acquired");
    self thread function_c34e210b(perk, n_slot);
    if (self.var_ee217989.size == 4 || isdefined(self.talisman_perk_mod_single) && self.talisman_perk_mod_single && n_slot == 3) {
        var_261bd5f0 = self.var_871d24d3[3];
        if (var_261bd5f0 == #"specialty_mystery") {
            var_261bd5f0 = self.var_c4fbbdc2[3];
        }
        var_24521dd6 = level.var_fb762d80[var_261bd5f0];
        /#
            if (isstring(var_261bd5f0)) {
                var_261bd5f0 = hash(var_261bd5f0);
            }
            assert(isdefined(var_24521dd6), "<dev string:x87e>" + function_15979fa9(var_261bd5f0));
        #/
        if (!isinarray(self.var_ee217989, var_24521dd6)) {
            self function_bcf744a7(var_24521dd6);
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x80a71d8c, Offset: 0x9968
// Size: 0x54
function function_f35164e8() {
    var_5bda2074 = array::exclude(level.var_9b40a9a5, self.perk_history);
    if (!var_5bda2074.size) {
        self zm_utility::giveachievement_wrapper("zm_trophy_perkaholic_relapse");
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x835f6bc5, Offset: 0x99c8
// Size: 0x38c
function function_c34e210b(perk, n_slot) {
    self endon(#"disconnect");
    perk_str = perk + "_stop";
    do {
        s_result = self waittill(perk_str);
        result = s_result._notify;
    } while (!(isdefined(s_result.var_39af19e) && s_result.var_39af19e) && self lost_perk_override(perk));
    self perks::perk_unsetperk(perk);
    if (isdefined(level._custom_perks[perk].var_c860c5b4)) {
        if (isarray(level._custom_perks[perk].var_c860c5b4)) {
            foreach (specialty in level._custom_perks[perk].var_c860c5b4) {
                perks::perk_unsetperk(specialty);
            }
        } else {
            perks::perk_unsetperk(level._custom_perks[perk].var_c860c5b4);
        }
    }
    self.num_perks--;
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_take)) {
        self thread [[ level._custom_perks[perk].player_thread_take ]](0, perk_str, result);
    }
    self set_perk_clientfield(perk, 0);
    if (n_slot < 4) {
        self function_6dd07430(n_slot, 0);
        self function_41d8134(n_slot, 0);
    }
    self.perk_purchased = undefined;
    if (isdefined(level.var_a72d0823)) {
        self [[ level.var_a72d0823 ]](perk);
    }
    arrayremovevalue(self.var_ee217989, perk, 0);
    if (!(isdefined(s_result.var_d136d40a) && s_result.var_d136d40a)) {
        arrayremovevalue(self.var_83ef9ace, perk, 0);
    }
    self notify(#"hash_2cb946ae6981d56c");
    var_7b6a56a0 = self.var_871d24d3[4];
    if (isdefined(var_7b6a56a0) && isinarray(self.var_ee217989, var_7b6a56a0)) {
        if (isdefined(self.talisman_perk_mod_single) && self.talisman_perk_mod_single && n_slot < 3) {
            return;
        }
        self notify(var_7b6a56a0 + "_stop");
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x3643ffaa, Offset: 0x9d60
// Size: 0x56
function function_ec1dff78(str_name) {
    for (x = 0; x < self.var_871d24d3.size; x++) {
        if (self.var_871d24d3[x] == str_name) {
            return x;
        }
    }
    return -1;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x9832dcdd, Offset: 0x9dc0
// Size: 0x2a
function function_39e56b81(str_name) {
    return isinarray(level.var_fb762d80, str_name);
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x55a3ed36, Offset: 0x9df8
// Size: 0x82
function function_8e5fbcc0() {
    var_8183cdf2 = array::exclude(level.var_3d574fc8, self.var_59fcabb7);
    var_8183cdf2 = array::exclude(var_8183cdf2, self.var_871d24d3);
    var_8183cdf2 = array::exclude(var_8183cdf2, #"specialty_mystery");
    return array::random(var_8183cdf2);
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xbeb153e1, Offset: 0x9e88
// Size: 0x60
function function_c4ed75d2(n_slot) {
    var_70221ebf = self.var_871d24d3[n_slot];
    if (isdefined(level._custom_perks[var_70221ebf].var_64a282c9)) {
        self [[ level._custom_perks[var_70221ebf].var_64a282c9 ]]();
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x4
// Checksum 0xf584d6ac, Offset: 0x9ef0
// Size: 0x1dc
function private function_206b420e() {
    self endon(#"disconnect");
    self waittill(#"perks_initialized");
    s_perk = undefined;
    if (isdefined(self.talisman_perk_start_1) && self.talisman_perk_start_1 && isdefined(self.var_871d24d3[0])) {
        n_slot = 0;
        str_perk = self.var_871d24d3[0];
        self.talisman_perk_start_1 = 0;
    }
    if (isdefined(self.talisman_perk_start_2) && self.talisman_perk_start_2 && isdefined(self.var_871d24d3[1])) {
        n_slot = 1;
        str_perk = self.var_871d24d3[1];
        self.talisman_perk_start_2 = 0;
    }
    if (isdefined(self.talisman_perk_start_3) && self.talisman_perk_start_3 && isdefined(self.var_871d24d3[2])) {
        n_slot = 2;
        str_perk = self.var_871d24d3[2];
        self.talisman_perk_start_3 = 0;
    }
    if (isdefined(self.talisman_perk_start_4) && self.talisman_perk_start_4 && isdefined(self.var_871d24d3[3])) {
        n_slot = 3;
        str_perk = self.var_871d24d3[3];
        self.talisman_perk_start_4 = 0;
    }
    if (isdefined(str_perk)) {
        self function_79567d8a(str_perk, n_slot);
        self function_6dd07430(n_slot, 1);
        self thread function_4a5cdd0d(n_slot, str_perk);
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x66fe93f3, Offset: 0xa0d8
// Size: 0x26c
function function_fb513384(var_dd23f742) {
    level endon(#"end_game");
    var_94f62038 = var_dd23f742.var_84d8f199;
    var_ba803cf9 = struct::get(var_dd23f742.target, "targetname");
    if (isdefined(var_94f62038) && var_94f62038 > -1) {
        if (isdefined(var_ba803cf9)) {
            var_ba803cf9 thread scene::play("off");
        } else {
            var_dd23f742 function_11d46cb2("off");
        }
        if (var_94f62038 == 0) {
            level flag::wait_till("power_on");
        } else {
            level flag::wait_till("power_on" + var_94f62038);
        }
    }
    var_dd23f742.var_548e0166 = "on";
    if (isdefined(var_ba803cf9)) {
        level scene::add_scene_func(var_ba803cf9.scriptbundlename, &function_f943a4f2, "on", var_dd23f742);
        var_ba803cf9 thread scene::play("on");
        var_dd23f742.var_18adee09 = var_ba803cf9.scriptbundlename;
    } else {
        var_dd23f742 function_11d46cb2("on");
        waitframe(1);
        var_dd23f742.mdl_altar clientfield::set("" + #"hash_cf74c35ecc5a49", 1);
    }
    var_dd23f742 function_b83bef3a();
    if (zm_utility::get_story() == 2 && var_dd23f742.script_int == 2) {
        level thread function_25becb92(var_dd23f742.origin, var_dd23f742.angles);
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x5b96c4eb, Offset: 0xa350
// Size: 0x64
function function_f943a4f2(var_8c4b44d4, var_dd23f742) {
    var_dd23f742.mdl_altar = var_8c4b44d4[#"prop 1"];
    var_dd23f742.mdl_altar clientfield::set("" + #"hash_cf74c35ecc5a49", 1);
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xe72173e6, Offset: 0xa3c0
// Size: 0x34c
function function_11d46cb2(str_state) {
    s_statue = struct::get(self.target2);
    if (!isdefined(s_statue)) {
        return;
    }
    if (!isdefined(self.mdl_altar)) {
        if (isdefined(self.script_int)) {
            if (zm_utility::get_story() == 1) {
                switch (self.script_int) {
                case 0:
                    var_34c68aba = #"p8_fxanim_zm_perk_vending_brew_mod";
                    self.var_18adee09 = #"p8_fxanim_zm_perk_vending_brew_bundle";
                    break;
                case 1:
                    var_34c68aba = #"p8_fxanim_zm_perk_vending_cola_mod";
                    self.var_18adee09 = #"p8_fxanim_zm_perk_vending_cola_bundle";
                    break;
                case 2:
                    var_34c68aba = #"p8_fxanim_zm_perk_vending_soda_mod";
                    self.var_18adee09 = #"p8_fxanim_zm_perk_vending_soda_bundle";
                    break;
                case 3:
                    var_34c68aba = #"p8_fxanim_zm_perk_vending_tonic_mod";
                    self.var_18adee09 = #"p8_fxanim_zm_perk_vending_tonic_bundle";
                    break;
                }
            } else {
                switch (self.script_int) {
                case 0:
                    var_34c68aba = #"p8_fxanim_zm_vapor_altar_danu_mod";
                    self.var_18adee09 = #"p8_fxanim_zm_vapor_altar_danu_bundle";
                    break;
                case 1:
                    var_34c68aba = #"p8_fxanim_zm_vapor_altar_ra_mod";
                    self.var_18adee09 = #"p8_fxanim_zm_vapor_altar_ra_bundle";
                    break;
                case 2:
                    var_34c68aba = #"p8_fxanim_zm_vapor_altar_zeus_mod";
                    self.var_18adee09 = #"p8_fxanim_zm_vapor_altar_zeus_bundle";
                    var_5086cd82 = 1;
                    break;
                case 3:
                    var_34c68aba = #"p8_fxanim_zm_vapor_altar_odin_mod";
                    self.var_18adee09 = #"p8_fxanim_zm_vapor_altar_odin_bundle";
                    break;
                }
            }
        }
        assert(isdefined(var_34c68aba), "<dev string:x8a4>");
        self.mdl_altar = util::spawn_model(var_34c68aba, s_statue.origin, s_statue.angles);
        if (isdefined(var_5086cd82) && var_5086cd82) {
            waitframe(1);
            self.mdl_altar clientfield::set("" + #"hash_50eb488e58f66198", 1);
        }
    }
    self.mdl_altar thread scene::play(self.var_18adee09, str_state, self.mdl_altar);
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xe526485f, Offset: 0xa718
// Size: 0x17a
function function_b83bef3a() {
    var_12f9358d = scene::get_all_shot_names(self.var_18adee09, 1);
    var_6e82f472 = array("use1", "use2", "use3", "use4", "use5", "use6");
    foreach (var_8c16b923 in var_6e82f472) {
        if (isinarray(var_12f9358d, var_8c16b923)) {
            if (!isdefined(self.var_a2477191)) {
                self.var_a2477191 = [];
            } else if (!isarray(self.var_a2477191)) {
                self.var_a2477191 = array(self.var_a2477191);
            }
            self.var_a2477191[self.var_a2477191.size] = var_8c16b923;
        }
    }
    if (isdefined(self.var_a2477191)) {
        self.var_a205292b = 0;
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x4d60ef6b, Offset: 0xa8a0
// Size: 0xaa
function function_dddea327() {
    if (!isdefined(self.var_a2477191)) {
        return;
    }
    self.mdl_altar scene::play(self.var_18adee09, self.var_a2477191[self.var_a205292b], self.mdl_altar);
    self.mdl_altar thread scene::play(self.var_18adee09, self.var_548e0166, self.mdl_altar);
    self.var_a205292b++;
    if (self.var_a205292b == self.var_a2477191.size) {
        self.var_a205292b = 0;
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xbe94e799, Offset: 0xa958
// Size: 0xfe
function function_29a9ca48() {
    if (!isdefined(self.mdl_altar)) {
        return;
    }
    if (zm_utility::get_story() == 1) {
        self.mdl_altar thread scene::play(self.var_18adee09, "disable", self.mdl_altar);
    }
    n_slot = self.script_int;
    foreach (e_player in level.activeplayers) {
        e_player function_41d8134(n_slot, 7);
    }
    self.var_548e0166 = "disable";
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xcd43d762, Offset: 0xaa60
// Size: 0x140
function function_dbc1588c() {
    if (!isdefined(self.mdl_altar)) {
        return;
    }
    if (zm_utility::get_story() == 1) {
        self.mdl_altar thread scene::play(self.var_18adee09, "on", self.mdl_altar);
    }
    self.var_548e0166 = "on";
    n_slot = self.script_int;
    foreach (e_player in level.activeplayers) {
        if (isinarray(e_player.var_ee217989, e_player.var_871d24d3[n_slot])) {
            n_state = 6;
        } else {
            n_state = 0;
        }
        e_player function_41d8134(n_slot, n_state);
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xafeab6c3, Offset: 0xaba8
// Size: 0xec
function function_fdc66e96(n_slot) {
    a_s_altars = struct::get_array("perk_vapor_altar");
    foreach (s_altar in a_s_altars) {
        if (s_altar.script_int == n_slot) {
            if (s_altar.var_548e0166 == "on") {
                return 1;
            }
            return 0;
        }
    }
    assertmsg("<dev string:x8cf>" + n_slot);
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xc574d2a, Offset: 0xaca0
// Size: 0x182
function function_cf30ba62(var_dd23f742) {
    if (!isdefined(level.var_b1061964)) {
        level.var_b1061964 = 0;
    }
    n_altar = var_dd23f742.script_int;
    switch (n_altar) {
    case 0:
        str_soundalias = #"hash_53f8a70357ec0da8";
        break;
    case 1:
        str_soundalias = #"hash_7e0bcff9cf221f89";
        break;
    case 2:
        str_soundalias = #"hash_7fce3a84b4e750f5";
        break;
    case 3:
        str_soundalias = #"hash_329003fa3cbc92be";
        break;
    default:
        return;
    }
    while (true) {
        wait randomintrange(45, 90);
        if (!level.var_b1061964) {
            level.var_b1061964 = 1;
            playsoundatposition(str_soundalias, var_dd23f742.origin);
            wait 30;
            level.var_b1061964 = 0;
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xbce28369, Offset: 0xae30
// Size: 0x15c
function function_f3c76792(var_d2af4096) {
    if (!isdefined(var_d2af4096)) {
        return;
    }
    if (!isdefined(var_d2af4096.stub)) {
        return;
    }
    if (!isdefined(var_d2af4096.stub.var_dd23f742)) {
        return;
    }
    n_altar = var_d2af4096.stub.var_dd23f742.script_int;
    switch (n_altar) {
    case 0:
        str_soundalias = #"hash_53f8a70357ec0da8";
        break;
    case 1:
        str_soundalias = #"hash_7e0bcff9cf221f89";
        break;
    case 2:
        str_soundalias = #"hash_7fce3a84b4e750f5";
        break;
    case 3:
        str_soundalias = #"hash_329003fa3cbc92be";
        break;
    default:
        return;
    }
    self playsoundontag(str_soundalias, "j_head");
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x154bd076, Offset: 0xaf98
// Size: 0x194
function function_41d8134(n_slot, n_state) {
    switch (n_slot) {
    case 0:
        str_clientfield = "" + #"hash_35fe26fc5cb223b3";
        break;
    case 1:
        str_clientfield = "" + #"hash_6fb426c48a4877e0";
        break;
    case 2:
        str_clientfield = "" + #"hash_345845080e40675d";
        break;
    case 3:
        str_clientfield = "" + #"hash_1da6660f0414562";
        break;
    }
    if (isdefined(str_clientfield)) {
        if (n_state == 0) {
            if (level function_fdc66e96(n_slot)) {
                self clientfield::set_to_player(str_clientfield, self getentitynumber() + 1);
            }
            return;
        }
        if (!level function_fdc66e96(n_slot) && n_state != 7) {
            return;
        }
        self clientfield::set_to_player(str_clientfield, n_state);
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x51f27a0a, Offset: 0xb138
// Size: 0x11e
function function_25becb92(var_94c8d761, var_479b662f) {
    level endon(#"end_game");
    level flag::wait_till("all_players_spawned");
    level clientfield::set("" + #"hash_46334db9e3c76275", 1);
    while (true) {
        a_e_players = arraysortclosest(level.players, var_94c8d761, undefined, 0, 750);
        a_e_players = array::filter(a_e_players, 0, &function_81fe7a33, var_94c8d761, var_479b662f);
        if (a_e_players.size) {
            a_e_players[0] function_4b788ff1(var_94c8d761, var_479b662f);
        }
        wait 4;
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x56baeee8, Offset: 0xb260
// Size: 0x10e
function function_4b788ff1(var_94c8d761, var_479b662f) {
    self endon(#"death", #"disconnect");
    b_first_loop = 1;
    while (function_81fe7a33(self, var_94c8d761, var_479b662f)) {
        if (b_first_loop) {
            b_first_loop = 0;
            level.var_8f6a7a80 = self;
            n_clientfield_val = self getentitynumber() + 1;
            self clientfield::set("" + #"hash_222c3403d2641ea6", n_clientfield_val);
        }
        wait 1;
    }
    self clientfield::set("" + #"hash_222c3403d2641ea6", 0);
    level.var_8f6a7a80 = undefined;
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x0
// Checksum 0x7e696297, Offset: 0xb378
// Size: 0xf4
function function_81fe7a33(e_player, var_94c8d761, var_479b662f) {
    if (zm_utility::is_player_valid(e_player) && distancesquared(e_player.origin, var_94c8d761) < 562500 && abs(e_player.origin[2] - var_94c8d761[2]) < 80 && vectordot(vectornormalize(e_player.origin - var_94c8d761), anglestoforward(var_479b662f)) > 0) {
        return true;
    }
    return false;
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x7d2db203, Offset: 0xb478
// Size: 0x7c
function function_bcf744a7(var_70221ebf, b_extra = 0) {
    if (b_extra) {
        self give_perk(var_70221ebf, 0);
        return;
    }
    self.var_871d24d3[4] = var_70221ebf;
    self function_79567d8a(var_70221ebf, 4);
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x8108e6c7, Offset: 0xb500
// Size: 0xac
function function_95f1ffa(n_bleedout_time) {
    self endon(#"player_revived", #"disconnect", #"bled_out");
    level endon(#"round_reset");
    self thread function_4dd55bc2();
    if (isdefined(self.var_b02abc40) && self.var_b02abc40) {
        return;
    }
    n_wait = n_bleedout_time / 4;
    self function_4edde9fa(n_wait);
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xd5048068, Offset: 0xb5b8
// Size: 0x6c
function function_4dd55bc2() {
    self endon(#"player_revived", #"disconnect");
    level endon(#"round_reset");
    self waittill(#"bled_out");
    self function_4edde9fa(undefined, 1);
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0xa8a15cab, Offset: 0xb630
// Size: 0x256
function function_4edde9fa(var_77b0b958, var_39af19e = 0) {
    var_83ef9ace = arraycopy(self.var_83ef9ace);
    var_e01cf76b = isdefined(var_77b0b958) && zombie_utility::get_zombie_var("perks_decay") && zm_custom::function_5638f689(#"zmperkdecay") == 1;
    if (var_e01cf76b) {
        self function_550e640f(var_83ef9ace, var_77b0b958);
        foreach (var_4605d06f in var_83ef9ace) {
            if (zm_trial_disable_perks::is_active()) {
                b_wait = self zm_trial_disable_perks::lose_perk(var_4605d06f);
            } else {
                self notify(var_4605d06f + "_stop", {#var_39af19e:var_39af19e});
                b_wait = 1;
            }
            if (b_wait) {
                wait var_77b0b958;
            }
        }
        return;
    }
    for (i = 3; i >= 0; i--) {
        if (zm_trial_disable_perks::is_active()) {
            self zm_trial_disable_perks::lose_perk(self.var_871d24d3[i]);
            continue;
        }
        if (isinarray(self.var_ee217989, self.var_871d24d3[i])) {
            self notify(self.var_871d24d3[i] + "_stop", {#var_39af19e:var_39af19e});
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x4
// Checksum 0x5a016f70, Offset: 0xb890
// Size: 0x32c
function private function_550e640f(var_83ef9ace, var_77b0b958) {
    var_97c0ff2f = arraycopy(var_83ef9ace);
    var_751ebe80 = array(0, 1, 2, 3);
    var_169695f4 = [];
    if (var_97c0ff2f.size <= 1) {
        for (n_slot = 0; n_slot < 4; n_slot++) {
            self clientfield::set_player_uimodel("hudItems.perkVapor." + n_slot + ".bleedoutOrderIndex", n_slot);
            self clientfield::set_player_uimodel("hudItems.perkVapor." + n_slot + ".bleedoutProgress", 1);
            self clientfield::set_player_uimodel("hudItems.perkVapor." + n_slot + ".bleedoutActive", 0);
        }
        var_169695f4 = array::reverse(var_751ebe80);
    } else {
        arrayremoveindex(var_97c0ff2f, 0);
        for (n_slot = 3; n_slot >= 0; n_slot--) {
            if (var_97c0ff2f.size) {
                var_c348c905 = function_ec1dff78(var_97c0ff2f[0]);
                arrayremoveindex(var_97c0ff2f, 0);
                arrayremovevalue(var_751ebe80, var_c348c905);
                self clientfield::set_player_uimodel("hudItems.perkVapor." + var_c348c905 + ".bleedoutActive", 1);
            }
            if (!isdefined(var_c348c905)) {
                var_c348c905 = var_751ebe80[0];
                arrayremoveindex(var_751ebe80, 0);
                self clientfield::set_player_uimodel("hudItems.perkVapor." + var_c348c905 + ".bleedoutActive", 0);
            }
            if (!isdefined(var_169695f4)) {
                var_169695f4 = [];
            } else if (!isarray(var_169695f4)) {
                var_169695f4 = array(var_169695f4);
            }
            var_169695f4[var_169695f4.size] = var_c348c905;
            self clientfield::set_player_uimodel("hudItems.perkVapor." + var_c348c905 + ".bleedoutOrderIndex", n_slot);
            self clientfield::set_player_uimodel("hudItems.perkVapor." + var_c348c905 + ".bleedoutProgress", 1);
            var_c348c905 = undefined;
        }
    }
    self thread set_bleedout_progress(var_77b0b958, var_169695f4);
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x4
// Checksum 0x8dce28d3, Offset: 0xbbc8
// Size: 0x13c
function private set_bleedout_progress(var_77b0b958, var_169695f4) {
    self endon(#"player_revived", #"zombified", #"disconnect");
    level endon(#"end_game", #"round_reset");
    var_404d862e = 0;
    n_time_elapsed = 0;
    while (var_404d862e < 4) {
        n_perc = math::clamp(n_time_elapsed / var_77b0b958, 0, 1);
        self clientfield::set_player_uimodel("hudItems.perkVapor." + var_169695f4[var_404d862e] + ".bleedoutProgress", 1 - n_perc);
        if (n_perc == 1) {
            n_time_elapsed = 0;
            var_404d862e++;
        }
        n_time_elapsed += 0.05;
        wait 0.05;
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x96de5022, Offset: 0xbd10
// Size: 0x1ae
function function_87304102() {
    var_707859c5 = [];
    foreach (var_70221ebf in self.var_b318c4f9) {
        n_slot = function_ec1dff78(var_70221ebf);
        if (n_slot >= 0) {
            self function_79567d8a(var_70221ebf, n_slot, 0);
            if (!isdefined(var_707859c5)) {
                var_707859c5 = [];
            } else if (!isarray(var_707859c5)) {
                var_707859c5 = array(var_707859c5);
            }
            var_707859c5[var_707859c5.size] = n_slot;
            continue;
        }
        self give_perk(var_70221ebf, 0, 1);
    }
    for (i = 0; i < 4; i++) {
        if (isinarray(var_707859c5, i)) {
            n_state = 6;
        } else {
            n_state = 0;
        }
        self function_41d8134(i, n_state);
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x43f7d682, Offset: 0xbec8
// Size: 0x66
function function_8521d0ed(str_perk_name) {
    if (isstring(str_perk_name)) {
        str_perk_name = hash(str_perk_name);
    }
    if (isinarray(self.var_b318c4f9, str_perk_name)) {
        return true;
    }
    return false;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x4
// Checksum 0x64a2d3c3, Offset: 0xbf38
// Size: 0x2e
function private function_5ad021c0(var_70221ebf) {
    if (function_8521d0ed(var_70221ebf)) {
        return true;
    }
    return false;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x79d3fc46, Offset: 0xbf70
// Size: 0x92
function register_lost_perk_override(func_override) {
    if (!isdefined(level.var_eef7bfa1)) {
        level.var_eef7bfa1 = [];
    } else if (!isarray(level.var_eef7bfa1)) {
        level.var_eef7bfa1 = array(level.var_eef7bfa1);
    }
    level.var_eef7bfa1[level.var_eef7bfa1.size] = func_override;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x2a569704, Offset: 0xc010
// Size: 0xa6
function lost_perk_override(perk) {
    if (!self laststand::player_is_in_laststand()) {
        return false;
    }
    foreach (var_44a5c2de in level.var_eef7bfa1) {
        if (self [[ var_44a5c2de ]](perk)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0xbb11dd17, Offset: 0xc0c0
// Size: 0x26c
function function_dde955e2(perk, var_90bf4844) {
    str_endon = "return_perk_on_revive_" + perk;
    self notify(str_endon);
    self endon(str_endon, #"disconnect", #"bled_out");
    if (!isdefined(self.var_c6eb402a)) {
        self.var_c6eb402a = [];
    } else if (!isarray(self.var_c6eb402a)) {
        self.var_c6eb402a = array(self.var_c6eb402a);
    }
    if (!isinarray(self.var_c6eb402a, var_90bf4844)) {
        self.var_c6eb402a[self.var_c6eb402a.size] = var_90bf4844;
    }
    for (x = 0; x < self.var_871d24d3.size; x++) {
        if (self.var_871d24d3[x] == perk) {
            var_ff2247e3 = x;
        }
    }
    if (var_ff2247e3 === 4) {
        return;
    }
    waitresult = self waittill(#"player_revived");
    e_reviver = waitresult.reviver;
    var_471b53c6 = waitresult.var_5d981de2;
    foreach (var_90bf4844 in self.var_c6eb402a) {
        if (self [[ var_90bf4844 ]](e_reviver, var_471b53c6)) {
            var_78d60d91 = 1;
            break;
        }
    }
    if (!(isdefined(var_78d60d91) && var_78d60d91)) {
        return;
    }
    waitframe(1);
    if (isdefined(var_ff2247e3)) {
        self thread function_79567d8a(perk, var_ff2247e3);
        return;
    }
    self thread give_perk(perk, 0);
}

/#

    // Namespace zm_perks/zm_perks
    // Params 0, eflags: 0x0
    // Checksum 0xcc71a813, Offset: 0xc338
    // Size: 0x8ec
    function function_5f0434b6() {
        ip1 = self getentitynumber() + 1;
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:x908>" + ip1 + "<dev string:x947>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:x95f>" + ip1 + "<dev string:x99e>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:x9b5>" + ip1 + "<dev string:x9fb>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xa1a>" + ip1 + "<dev string:xa5a>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xa73>" + ip1 + "<dev string:xab8>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xad5>" + ip1 + "<dev string:xb14>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xb2b>" + ip1 + "<dev string:xb6d>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xb87>" + ip1 + "<dev string:xbc3>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xbd8>" + ip1 + "<dev string:xc16>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xc2d>" + ip1 + "<dev string:xc6d>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xc86>" + ip1 + "<dev string:xcc4>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xcdb>" + ip1 + "<dev string:xd24>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xd3b>" + ip1 + "<dev string:xd7c>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xd95>" + ip1 + "<dev string:xdc8>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xddd>" + ip1 + "<dev string:xe10>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xe25>" + ip1 + "<dev string:xe58>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xe6d>" + ip1 + "<dev string:xea0>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xeb5>" + ip1 + "<dev string:xeea>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xefd>" + ip1 + "<dev string:xf30>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xf45>" + ip1 + "<dev string:xf78>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xf8d>" + ip1 + "<dev string:xfc0>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:xfd5>" + ip1 + "<dev string:x1008>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:x101d>" + ip1 + "<dev string:x1052>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:x1065>" + ip1 + "<dev string:x10a2>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:x10c1>" + ip1 + "<dev string:x10fe>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:x111d>" + ip1 + "<dev string:x115a>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:x1179>" + ip1 + "<dev string:x11b6>");
        adddebugcommand("<dev string:x8ed>" + self.name + "<dev string:x904>" + ip1 + "<dev string:x11d5>" + ip1 + "<dev string:x1214>");
    }

    // Namespace zm_perks/zm_perks
    // Params 0, eflags: 0x0
    // Checksum 0xbd454c6f, Offset: 0xcc30
    // Size: 0x1288
    function function_a376d553() {
        level notify(#"zombie_vapor_devgui");
        level endon(#"zombie_vapor_devgui");
        for (;;) {
            cmd = getdvarstring(#"zombie_vapor_devgui");
            str_perk = undefined;
            var_283c87ca = undefined;
            var_8b0ba1ae = undefined;
            var_d29535bc = undefined;
            var_bf7923b8 = undefined;
            var_eebdfae3 = undefined;
            var_a42af83 = undefined;
            switch (cmd) {
            case #"hash_714bd7d5b19367cb":
            case #"hash_2b731e891eadd00a":
            case #"hash_a687f7ed9396339":
            case #"hash_47e87df26f2bb654":
                str_perk = #"specialty_shield";
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_22db822f8cebba1f":
            case #"hash_1fc0acc0b9c31200":
            case #"hash_2c6e9bd17e4c70e5":
            case #"hash_3547aac06cbbd656":
                str_perk = #"specialty_berserker";
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_59dfac7d036a7f11":
            case #"hash_5fdbbc96a07023ea":
            case #"hash_696b25a08319319f":
            case #"hash_72cd05a9f7096d18":
                str_perk = #"specialty_awareness";
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_20e1f2a12f575ad":
            case #"hash_1067d35a903aa090":
            case #"hash_60a8ca620122ce03":
            case #"hash_37f041c2ceccaa32":
                str_perk = #"specialty_camper";
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_2ad319babe68ddd9":
            case #"hash_582c07780b2a70d7":
            case #"hash_7a8b3d3703b1d56e":
            case #"hash_460157accd31661c":
                str_perk = #"specialty_phdflopper";
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_7b790d5f36b4c12":
            case #"hash_b5286c82d1f26c3":
            case #"hash_3fe4509a2ac36a60":
            case #"hash_7237eda7099e624d":
                str_perk = #"specialty_cooldown";
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_17377d35be324020":
            case #"hash_52f021b5af5b6f01":
            case #"hash_4d0551e8fc1a3eaa":
            case #"hash_1e0b58a0910c3247":
                str_perk = #"specialty_additionalprimaryweapon";
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_215605bc01af2e0":
            case #"hash_3c2392a146da0ca1":
            case #"hash_272741eeae13ac9a":
            case #"hash_77c9ba94611f14a7":
                str_perk = #"specialty_deadshot";
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_2ad8c584d069c098":
            case #"hash_6650c5a8596d4707":
            case #"hash_12b3c2d6eb971006":
            case #"hash_4b97c729fbbb68e5":
                str_perk = #"specialty_staminup";
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_30bfdad9100956cd":
            case #"hash_591f1871abf8a417":
            case #"hash_77bfaaec70d8daa":
            case #"hash_1f2e309303a233e8":
                str_perk = #"specialty_quickrevive";
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_3985b954c5d57fd7":
            case #"hash_4dd9c0937255fe1a":
            case #"hash_338cf8868ad12888":
            case #"hash_2b9b74bc8b7a95b9":
                str_perk = #"specialty_electriccherry";
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_73cbb686dc065831":
            case #"hash_6bc1e0d615f04132":
            case #"hash_400b86629283f29f":
            case #"hash_3e92ee8a1f94e218":
                str_perk = #"specialty_widowswine";
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_4d21953ef7610b73":
            case #"hash_74a3737c1fa820fa":
            case #"hash_5cebc01e01fc9e18":
            case #"hash_3419add8481e7fa1":
                str_perk = #"specialty_extraammo";
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_122b73a9059c70bc":
            case #"hash_2621dbc67d96d6b6":
            case #"hash_36d28b98c683b0ed":
            case #"hash_796b16a6e51d3223":
                var_8b0ba1ae = 0;
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_122b76a9059c75d5":
            case #"hash_2621dac67d96d503":
            case #"hash_36d28898c683abd4":
            case #"hash_796b17a6e51d33d6":
                var_8b0ba1ae = 1;
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_122b75a9059c7422":
            case #"hash_2621d9c67d96d350":
            case #"hash_36d28998c683ad87":
            case #"hash_796b18a6e51d3589":
                var_8b0ba1ae = 2;
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_796b19a6e51d373c":
            case #"hash_122b70a9059c6ba3":
            case #"hash_36d28698c683a86e":
            case #"hash_2621e0c67d96df35":
                var_8b0ba1ae = 3;
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_4e75f62ab878637a":
            case #"hash_63368be670c1631":
            case #"hash_56baf79467fa8098":
            case #"hash_2227c4347bf7aff7":
                var_8b0ba1ae = 4;
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_5c050766529e83a8":
            case #"hash_75d5e1ee4bb9b063":
            case #"hash_4205942f3e57758a":
            case #"hash_2a94a682beedaf35":
                var_d29535bc = 0;
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_2a94a382beedaa1c":
            case #"hash_75d5e2ee4bb9b216":
            case #"hash_5c050a66529e88c1":
            case #"hash_4205932f3e5773d7":
                var_d29535bc = 1;
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_75d5e3ee4bb9b3c9":
            case #"hash_5c050966529e870e":
            case #"hash_2a94a482beedabcf":
            case #"hash_4205922f3e577224":
                var_d29535bc = 2;
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_4205912f3e577071":
            case #"hash_75d5e4ee4bb9b57c":
            case #"hash_2a94a182beeda6b6":
            case #"hash_5c050c66529e8c27":
                var_d29535bc = 3;
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_20102f0482e5bdb9":
            case #"hash_19d7dd5f676b170c":
            case #"hash_e3aea524ee28666":
            case #"hash_5a852048c409f6b7":
                var_d29535bc = 4;
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_37e9f4522a62290f":
            case #"hash_6fa3e37013c04980":
            case #"hash_21a07f54e2de98fe":
            case #"hash_57ed1fb7940f33b5":
                var_bf7923b8 = 0;
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_37e9f5522a622ac2":
            case #"hash_21a07e54e2de974b":
            case #"hash_57ed1cb7940f2e9c":
            case #"hash_6fa3e67013c04e99":
                var_bf7923b8 = 1;
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_37e9f6522a622c75":
            case #"hash_21a07d54e2de9598":
            case #"hash_6fa3e57013c04ce6":
            case #"hash_57ed1db7940f304f":
                var_bf7923b8 = 2;
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_37e9ef522a622090":
            case #"hash_21a08454e2dea17d":
            case #"hash_6fa3e87013c051ff":
            case #"hash_57ed1ab7940f2b36":
                var_bf7923b8 = 3;
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case #"hash_58bb5da598842e39":
            case #"hash_11bcb93b01611b04":
            case #"hash_78960bd8157b64e2":
            case #"hash_79a3bb05585eb7fb":
                var_bf7923b8 = 4;
                var_eebdfae3 = strtok(cmd, "<dev string:x1231>");
                var_283c87ca = int(var_eebdfae3[1]) - 1;
                break;
            case 0:
                break;
            }
            if (isdefined(var_283c87ca)) {
                foreach (player in level.players) {
                    if (isdefined(player)) {
                        if (var_283c87ca == player getentitynumber()) {
                            var_a42af83 = player;
                            break;
                        }
                    }
                }
            }
            if (isdefined(var_a42af83)) {
                if (isdefined(str_perk)) {
                    var_a42af83 function_db92ccd1(str_perk);
                } else if (isdefined(var_8b0ba1ae)) {
                    var_a42af83 function_be078e24(var_8b0ba1ae);
                } else if (isdefined(var_d29535bc)) {
                    var_a42af83 function_6aba3a2e(var_d29535bc);
                } else if (isdefined(var_bf7923b8)) {
                    var_a42af83 function_af10fa81(var_bf7923b8);
                }
            }
            setdvar(#"zombie_vapor_devgui", "<dev string:x1233>");
            wait 0.5;
        }
    }

    // Namespace zm_perks/zm_perks
    // Params 1, eflags: 0x0
    // Checksum 0x7a0439a9, Offset: 0xdec0
    // Size: 0x120
    function function_db92ccd1(var_70221ebf) {
        if (self.var_ee217989.size >= 4) {
            iprintlnbold("<dev string:x1234>");
            return;
        }
        if (isinarray(self.var_871d24d3, var_70221ebf)) {
            iprintlnbold("<dev string:x124a>");
            return;
        }
        for (i = 0; i < 4; i++) {
            if (!isinarray(self.var_ee217989, self.var_871d24d3[i])) {
                self thread function_4a5cdd0d(i, level._custom_perks[var_70221ebf].alias);
                self.var_871d24d3[i] = var_70221ebf;
                self function_d5f64ca1(var_70221ebf, i);
                return;
            }
        }
    }

    // Namespace zm_perks/zm_perks
    // Params 1, eflags: 0x0
    // Checksum 0x9daf6c3d, Offset: 0xdfe8
    // Size: 0x118
    function function_be078e24(n_slot) {
        if (n_slot < 4) {
            var_70221ebf = self.var_871d24d3[n_slot];
            if (isinarray(self.var_ee217989, var_70221ebf)) {
                iprintlnbold("<dev string:x126a>");
                return;
            }
            self function_d5f64ca1(var_70221ebf, n_slot);
            return;
        }
        foreach (i, var_70221ebf in self.var_871d24d3) {
            if (!isinarray(self.var_ee217989, var_70221ebf)) {
                self thread function_79567d8a(var_70221ebf, i);
            }
        }
    }

    // Namespace zm_perks/zm_perks
    // Params 1, eflags: 0x0
    // Checksum 0xafb96185, Offset: 0xe108
    // Size: 0x128
    function function_6aba3a2e(n_slot) {
        if (n_slot < 4) {
            var_70221ebf = self.var_871d24d3[n_slot];
            if (!isinarray(self.var_ee217989, var_70221ebf)) {
                iprintlnbold("<dev string:x1286>");
                return;
            }
            self notify(var_70221ebf + "<dev string:x129b>", {#var_39af19e:1});
            return;
        }
        foreach (var_70221ebf in self.var_871d24d3) {
            if (isinarray(self.var_ee217989, var_70221ebf)) {
                self notify(var_70221ebf + "<dev string:x129b>", {#var_39af19e:1});
            }
        }
    }

    // Namespace zm_perks/zm_perks
    // Params 1, eflags: 0x0
    // Checksum 0xe58c3f76, Offset: 0xe238
    // Size: 0x76
    function function_af10fa81(n_slot) {
        if (n_slot < 4) {
            self function_c4ed75d2(n_slot);
            return;
        }
        for (i = 0; i < 4; i++) {
            self function_c4ed75d2(i);
        }
    }

    // Namespace zm_perks/zm_perks
    // Params 2, eflags: 0x0
    // Checksum 0xb6669d75, Offset: 0xe2b8
    // Size: 0x124
    function function_d5f64ca1(var_70221ebf, n_slot) {
        self endon(#"disconnect", #"end_game", #"perk_abort_drinking");
        self perk_give_bottle_begin(var_70221ebf);
        evt = self waittilltimeout(3, #"fake_death", #"death", #"player_downed", #"offhand_end", #"perk_abort_drinking", #"disconnect");
        if (evt._notify == "<dev string:x12a1>" || evt._notify == #"timeout") {
            self thread function_79567d8a(var_70221ebf, n_slot);
        }
    }

#/
