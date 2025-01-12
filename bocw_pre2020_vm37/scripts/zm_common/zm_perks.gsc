#using script_301f64a4090c381a;
#using script_3751b21462a54a7d;
#using script_5f261a5d57de5f7c;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\perks;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\trials\zm_trial_disable_perks;
#using scripts\zm_common\trials\zm_trial_randomize_perks;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_contracts;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;

#namespace zm_perks;

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0x18ccb3ee, Offset: 0x690
// Size: 0x474
function init() {
    if (!isdefined(level.var_c3e5c4cd)) {
        level.var_c3e5c4cd = zm_utility::get_story();
    }
    level.perk_purchase_limit = 4;
    if (!isdefined(level.var_91ac8112)) {
        level.var_91ac8112 = [];
    } else if (!isarray(level.var_91ac8112)) {
        level.var_91ac8112 = array(level.var_91ac8112);
    }
    perks_register_clientfield();
    if (!level.enable_magic) {
        return;
    }
    /#
        if (is_true(level.var_1e2493f8)) {
            return;
        }
    #/
    if (!isdefined(level._custom_perks)) {
        level._custom_perks = [];
    } else if (!isarray(level._custom_perks)) {
        level._custom_perks = array(level._custom_perks);
    }
    perk_machine_spawn_init();
    level.var_76a7ad28 = [];
    vending_weapon_upgrade_trigger = [];
    level.machine_assets = [];
    level.perk_machines = [];
    if (!isdefined(level.custom_vending_precaching)) {
        level.custom_vending_precaching = &default_vending_precaching;
    }
    [[ level.custom_vending_precaching ]]();
    zmsettings = zm_utility::function_10e38d86();
    zombie_utility::set_zombie_var(#"zombie_perk_cost", zmsettings.var_1037e7d, 0);
    if (level._custom_perks.size > 0) {
        a_keys = getarraykeys(level._custom_perks);
        for (i = 0; i < a_keys.size; i++) {
            b_enabled = 1;
            if (!isinarray(level.var_b8be892e, a_keys[i])) {
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
    callback::on_spawned(&on_player_spawned);
    register_lost_perk_override(&function_d1cad55c);
    /#
        level thread function_545a79c();
    #/
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0xb45dff53, Offset: 0xb10
// Size: 0x444
function on_player_connect() {
    if (!isdefined(self.var_c27f1e90)) {
        self.var_c27f1e90 = [];
    } else if (!isarray(self.var_c27f1e90)) {
        self.var_c27f1e90 = array(self.var_c27f1e90);
    }
    if (!isdefined(self.var_c4193958)) {
        self.var_c4193958 = [];
    } else if (!isarray(self.var_c4193958)) {
        self.var_c4193958 = array(self.var_c4193958);
    }
    if (!isdefined(self.var_47654123)) {
        self.var_47654123 = [];
    } else if (!isarray(self.var_47654123)) {
        self.var_47654123 = array(self.var_47654123);
    }
    if (!isdefined(self.var_774e0ad7)) {
        self.var_774e0ad7 = [];
    } else if (!isarray(self.var_774e0ad7)) {
        self.var_774e0ad7 = array(self.var_774e0ad7);
    }
    if (!isdefined(self.var_cd5d9345)) {
        self.var_cd5d9345 = [];
    } else if (!isarray(self.var_cd5d9345)) {
        self.var_cd5d9345 = array(self.var_cd5d9345);
    }
    if (!isdefined(self.var_67ba1237)) {
        self.var_67ba1237 = [];
    } else if (!isarray(self.var_67ba1237)) {
        self.var_67ba1237 = array(self.var_67ba1237);
    }
    if (!isdefined(self.var_eabca645)) {
        self.var_eabca645 = [];
    } else if (!isarray(self.var_eabca645)) {
        self.var_eabca645 = array(self.var_eabca645);
    }
    if (!isdefined(self.var_466b927f)) {
        self.var_466b927f = [];
    } else if (!isarray(self.var_466b927f)) {
        self.var_466b927f = array(self.var_466b927f);
    }
    self.var_ab375b18 = 0;
    j = 0;
    for (i = 1; i <= 4; i++) {
        var_96861ec8 = self zm_loadout::get_loadout_item("specialty" + i);
        s_perk = getunlockableiteminfofromindex(var_96861ec8, 3);
        str_perk = "";
        if (isdefined(s_perk)) {
            if (isdefined(s_perk.specialties) && isdefined(s_perk.specialties[0])) {
                str_perk = hash(s_perk.specialties[0]);
            }
            if (!isinarray(level.var_b8be892e, str_perk)) {
                str_perk = "";
            }
        } else {
            /#
                iprintlnbold("<dev string:x38>" + self.name + "<dev string:x5a>");
            #/
        }
        self.var_c27f1e90[j] = str_perk;
        self.var_47654123[j] = str_perk == #"specialty_mystery" ? 1 : 0;
        self.var_c4193958[j] = "";
        j++;
    }
    /#
        self function_756e6a6d();
    #/
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0x49f6afc5, Offset: 0xf60
// Size: 0x1c
function on_player_spawned() {
    self thread function_7723353c();
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0xd6ac4945, Offset: 0xf88
// Size: 0x2a
function get_perk_machines() {
    if (!isdefined(level.perk_machines)) {
        level.perk_machines = [];
    }
    return level.perk_machines;
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0x638c91e0, Offset: 0xfc0
// Size: 0x430
function perk_machine_think(str_key, s_custom_perk) {
    str_endon = str_key + "_power_thread_end";
    level endon(str_endon);
    str_on = s_custom_perk.alias + "_on";
    str_off = s_custom_perk.alias + "_off";
    str_notify = str_key + "_power_on";
    var_a1247076 = 0;
    while (true) {
        machine = getentarray(s_custom_perk.radiant_machine_name, "targetname");
        for (i = 0; i < machine.size; i++) {
            machine[i] setmodel(level.machine_assets[str_key].off_model);
            machine[i] solid();
            machine[i].script_notify = str_key;
            level.perk_machines[level.perk_machines.size] = machine[i];
            if (!isdefined(machine[i].n_obj_id)) {
                machine[i].n_obj_id = gameobjects::get_next_obj_id();
                objective_add(machine[i].n_obj_id, "active", machine[i], #"hash_75209b2b8f60e888");
            }
        }
        level thread do_initial_power_off_callback(machine, str_key);
        array::thread_all(machine, &set_power_on, 0);
        var_7d94aac5 = get_perk_machine_start_state(str_key);
        if (!var_a1247076 && var_7d94aac5) {
            waitframe(1);
        } else {
            level waittill(str_on);
        }
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
        var_a1247076 = 1;
        level waittill(str_off);
        if (isdefined(level.machine_assets[str_key].power_off_callback)) {
            array::thread_all(machine, level.machine_assets[str_key].power_off_callback);
        }
        array::thread_all(machine, &turn_perk_off);
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0x1a65767f, Offset: 0x13f8
// Size: 0xa0
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
// Params 2, eflags: 0x1 linked
// Checksum 0x99fb40c6, Offset: 0x14a0
// Size: 0x94
function do_initial_power_off_callback(machine_array, perkname) {
    if (!isdefined(level.machine_assets[perkname])) {
        println("<dev string:x82>");
        return;
    }
    if (!isdefined(level.machine_assets[perkname].power_off_callback)) {
        return;
    }
    waitframe(1);
    array::thread_all(machine_array, level.machine_assets[perkname].power_off_callback);
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0x79542b2, Offset: 0x1540
// Size: 0x1a
function set_power_on(state) {
    self.power_on = state;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0x8b8c2dbb, Offset: 0x1568
// Size: 0x14c
function turn_perk_off(ishidden) {
    self notify(#"stop_loopsound");
    if (!is_true(self.b_keep_when_turned_off)) {
        newmachine = spawn("script_model", self.origin);
        newmachine.angles = self.angles;
        newmachine.targetname = self.targetname;
        if (is_true(ishidden)) {
            newmachine.ishidden = 1;
            newmachine ghost();
            newmachine notsolid();
        }
        if (isdefined(self.n_obj_id)) {
            objective_delete(self.n_obj_id);
            gameobjects::release_obj_id(self.n_obj_id);
            self.n_obj_id = undefined;
        }
        self delete();
        return;
    }
    perk_fx(undefined, 1);
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0x773fb01e, Offset: 0x16c0
// Size: 0xb4
function play_loop_on_machine() {
    if (isdefined(level.var_29a12b0)) {
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
// Params 2, eflags: 0x1 linked
// Checksum 0xc517e203, Offset: 0x1780
// Size: 0x17a
function perk_fx(fx, turnofffx) {
    if (isdefined(turnofffx)) {
        self.perk_fx = 0;
        if (is_true(self.b_keep_when_turned_off) && isdefined(self.s_fxloc)) {
            self.s_fxloc delete();
        }
        return;
    }
    wait 3;
    if (!isdefined(self)) {
        return;
    }
    if (!is_true(self.b_keep_when_turned_off)) {
        if (isdefined(self) && !is_true(self.perk_fx)) {
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
// Params 0, eflags: 0x1 linked
// Checksum 0x9ab2f82a, Offset: 0x1908
// Size: 0x1f0
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
                    iprintlnbold("<dev string:xe4>");
                #/
            }
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x5dfb4f3a, Offset: 0x1b00
// Size: 0xbc
function reset_vending_hint_string() {
    perk = self.script_noteworthy;
    if (isdefined(level._custom_perks)) {
        if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].cost) && isdefined(level._custom_perks[perk].hint_string)) {
            n_cost = function_6f418fda(perk);
            self sethintstring(level._custom_perks[perk].hint_string, n_cost);
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0x215f0e38, Offset: 0x1bc8
// Size: 0x7a
function function_6f418fda(perk) {
    if (isfunctionptr(level._custom_perks[perk].cost)) {
        n_cost = [[ level._custom_perks[perk].cost ]]();
    } else {
        n_cost = level._custom_perks[perk].cost;
    }
    return n_cost;
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0x56fcaf9d, Offset: 0x1c50
// Size: 0x1b6
function vending_trigger_can_player_use(player, var_93e7ba4f) {
    if (!isplayer(player)) {
        return false;
    }
    if (player laststand::player_is_in_laststand() || is_true(player.intermission)) {
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
    if (is_true(var_93e7ba4f)) {
        var_7dbbbf1f = array::exclude(level.var_b8be892e, player.perks_active);
        if (!isdefined(var_7dbbbf1f)) {
            return false;
        }
        if (isdefined(self.stub) && isdefined(self.stub.machine) && isdefined(player.var_c27f1e90[self.stub.machine.script_int])) {
            if (!isinarray(level.var_b8be892e, player.var_c27f1e90[self.stub.machine.script_int])) {
                return false;
            }
        }
    }
    return true;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0x8cbce8d2, Offset: 0x1e10
// Size: 0x26e
function function_f29c0595() {
    self endon(#"death");
    wait 0.01;
    perk = self.script_noteworthy;
    level.revive_machine_is_solo = 0;
    if (isdefined(perk) && perk == #"hash_7f98b3dd3cce95aa") {
        level flag::wait_till("start_zombie_round_logic");
        self endon(#"stop_quickrevive_logic");
        level.quick_revive_trigger = self;
        if (level.players.size == 1) {
            level.revive_machine_is_solo = 1;
        }
    }
    cost = zombie_utility::function_d2dfacfd(#"zombie_perk_cost");
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
// Params 0, eflags: 0x1 linked
// Checksum 0xffc1b4ed, Offset: 0x2088
// Size: 0x500
function vending_trigger_think() {
    self endon(#"death");
    perk = hash(self.script_noteworthy);
    cost = self.stub.cost;
    n_slot = self.stub.script_int;
    self thread zm_audio::sndperksjingles_timer();
    for (;;) {
        waitresult = self waittill(#"trigger");
        player = waitresult.activator;
        var_f2a92d5e = 0;
        if (isdefined(self.stub.machine)) {
            var_f2a92d5e = self.stub.machine.power_on;
        }
        if (!var_f2a92d5e) {
            wait 0.1;
            continue;
        }
        index = zm_utility::get_player_index(player);
        if (!vending_trigger_can_player_use(player, 0)) {
            wait 0.1;
            continue;
        }
        if (player function_6c32d092(perk) || player has_perk_paused(perk)) {
            cheat = 0;
            /#
                if (getdvarint(#"zombie_cheat", 0) >= 5) {
                    cheat = 1;
                }
            #/
            if (cheat != 1) {
                zm_utility::play_sound_on_ent("no_purchase");
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
        if (n_slot === 0 && is_true(player.talisman_perk_reducecost_1)) {
            current_cost -= player.talisman_perk_reducecost_1;
        }
        if (n_slot === 1 && is_true(player.talisman_perk_reducecost_2)) {
            current_cost -= player.talisman_perk_reducecost_2;
        }
        if (n_slot === 2 && is_true(player.talisman_perk_reducecost_3)) {
            current_cost -= player.talisman_perk_reducecost_3;
        }
        if (n_slot === 3 && is_true(player.talisman_perk_reducecost_4)) {
            current_cost -= player.talisman_perk_reducecost_4;
        }
        if (!player zm_score::can_player_purchase(current_cost)) {
            zm_utility::play_sound_on_ent("no_purchase");
            player zm_audio::create_and_play_dialog(#"general", #"outofmoney");
            continue;
        }
        if (!player zm_utility::can_player_purchase_perk()) {
            zm_utility::play_sound_on_ent("no_purchase");
            continue;
        }
        sound = "evt_bottle_dispense";
        playsoundatposition(sound, self.origin);
        player zm_score::minus_to_player_score(current_cost);
        bb::logpurchaseevent(player, self, current_cost, perk, 0, "_perk", "_purchased");
        player recordmapevent(29, gettime(), self.origin, level.round_number, perk);
        player.perk_purchased = perk;
        player notify(#"perk_purchased", {#perk:perk});
        self thread zm_audio::sndperksjingles_player(1);
        self thread vending_trigger_post_think(player, perk);
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0xcda4fd05, Offset: 0x2590
// Size: 0x21c
function vending_trigger_post_think(player, perk) {
    player endon(#"disconnect", #"end_game", #"perk_abort_drinking");
    player perk_give_bottle_begin(perk);
    evt = player waittilltimeout(3.5, #"fake_death", #"death", #"player_downed", #"offhand_end", #"perk_abort_drinking", #"disconnect");
    if (evt._notify == "offhand_end" || evt._notify == #"timeout") {
        player thread wait_give_perk(perk);
    }
    if (player laststand::player_is_in_laststand() || is_true(player.intermission)) {
        return;
    }
    player notify(#"burp");
    if (isdefined(level.var_c4bedce3)) {
        player [[ level.var_c4bedce3 ]](perk);
    }
    player.perk_purchased = undefined;
    if (isdefined(self) && !is_true(self.stub.machine.power_on)) {
        wait 1;
        if (isdefined(self)) {
            perk_pause(self.script_noteworthy);
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0x9eb5f29c, Offset: 0x27b8
// Size: 0x164
function wait_give_perk(perk) {
    self endon(#"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
    self waittilltimeout(0.5, #"burp", #"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
    talent = namespace_791d0451::function_b852953c(perk);
    self namespace_791d0451::function_3fecad82(talent, 0);
    self namespace_791d0451::function_f7886822(talent, 1);
    self thread give_perk_presentation(talent);
    self notify(#"perk_bought", {#var_16c042b8:talent});
    self zm_stats::increment_challenge_stat(#"survivalist_buy_perk");
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0xdc0c57f8, Offset: 0x2928
// Size: 0x84
function give_perk_presentation(perk) {
    self endon(#"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
    self zm_audio::playerexert("burp");
    self thread function_305131b1(perk);
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0xdf7548ed, Offset: 0x29b8
// Size: 0x94
function function_305131b1(perk) {
    self endon(#"death");
    b_played = self zm_audio::create_and_play_dialog(#"perk", perk);
    if (!is_true(b_played)) {
        self zm_audio::create_and_play_dialog(#"perk", #"generic");
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0xef2e33c9, Offset: 0x2a58
// Size: 0x41e
function function_a7ae070c(var_16c042b8, var_b169f6df = 0) {
    self namespace_791d0451::function_3fecad82(var_16c042b8);
    if (isdefined(level._custom_perks[var_16c042b8].var_658e2856)) {
        if (isarray(level._custom_perks[var_16c042b8].var_658e2856)) {
            foreach (specialty in level._custom_perks[var_16c042b8].var_658e2856) {
                self namespace_791d0451::function_3fecad82(specialty);
            }
        } else {
            self namespace_791d0451::function_3fecad82(level._custom_perks[var_16c042b8].var_658e2856);
        }
    }
    if (!var_b169f6df) {
        self.num_perks++;
    }
    if (!isinarray(self.var_67ba1237, var_16c042b8)) {
        if (!isdefined(self.var_67ba1237)) {
            self.var_67ba1237 = [];
        } else if (!isarray(self.var_67ba1237)) {
            self.var_67ba1237 = array(self.var_67ba1237);
        }
        self.var_67ba1237[self.var_67ba1237.size] = var_16c042b8;
        self.var_eabca645[level._custom_perks[var_16c042b8].alias] = self.var_ab375b18;
        self.var_ab375b18++;
    }
    var_9a0250b7 = level._custom_perks[var_16c042b8].alias;
    self namespace_791d0451::function_f7886822(var_16c042b8);
    if (isdefined(level._custom_perks[var_16c042b8]) && isdefined(level._custom_perks[var_16c042b8].player_thread_give)) {
        self thread [[ level._custom_perks[var_16c042b8].player_thread_give ]]();
    }
    if (!zm_trial_randomize_perks::is_active()) {
        demo::bookmark(#"zm_player_perk", gettime(), self);
        potm::bookmark(#"zm_player_perk", gettime(), self);
        self zm_stats::increment_client_stat("perks_drank");
        self zm_stats::increment_client_stat(var_16c042b8 + "_drank");
        self zm_stats::increment_player_stat(var_16c042b8 + "_drank");
        self zm_stats::increment_player_stat("perks_drank");
        if (!isdefined(self.perk_history)) {
            self.perk_history = [];
        } else if (!isarray(self.perk_history)) {
            self.perk_history = array(self.perk_history);
        }
        if (!isinarray(self.perk_history, var_16c042b8)) {
            self.perk_history[self.perk_history.size] = var_16c042b8;
        }
    }
    self notify(#"perk_acquired", {#var_16c042b8:var_16c042b8});
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xcb4fee2f, Offset: 0x2e80
// Size: 0x32
function vending_set_hintstring(perk) {
    switch (perk) {
    case #"specialty_armorvest":
        break;
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x7c828e72, Offset: 0x2ec0
// Size: 0x32e
function perk_think(perk) {
    self endon(#"disconnect");
    perk_str = perk + "_stop";
    result = self waittill(#"fake_death", #"death", #"player_downed", perk_str);
    result = result._notify;
    self perks::perk_unsetperk(perk);
    if (isdefined(level._custom_perks[perk].var_658e2856)) {
        if (isarray(level._custom_perks[perk].var_658e2856)) {
            foreach (specialty in level._custom_perks[perk].var_658e2856) {
                perks::perk_unsetperk(specialty);
            }
        } else {
            perks::perk_unsetperk(level._custom_perks[perk].var_658e2856);
        }
    }
    self.num_perks--;
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_take)) {
        self thread [[ level._custom_perks[perk].player_thread_take ]](0, perk_str, result, -1);
    }
    self set_perk_clientfield(perk, 0);
    self.perk_purchased = undefined;
    if (isdefined(level.var_a903ab55)) {
        self [[ level.var_a903ab55 ]](perk);
    }
    self function_2ac7579(-1, 0, level._custom_perks[hash(perk)].alias);
    if (isinarray(self.var_67ba1237, perk)) {
        arrayremovevalue(self.var_67ba1237, perk, 1);
        arrayremoveindex(self.var_eabca645, level._custom_perks[hash(perk)].alias, 1);
        self.var_ab375b18--;
    }
    self notify(#"extra_perk_lost");
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0xb2e56953, Offset: 0x31f8
// Size: 0x68
function set_perk_clientfield(perk, state) {
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].clientfield_set)) {
        self [[ level._custom_perks[perk].clientfield_set ]](state);
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0x9de8add0, Offset: 0x3268
// Size: 0x5c
function perk_give_bottle_begin(str_perk) {
    weapon = get_perk_weapon(str_perk);
    self thread gestures::function_f3e2696f(self, weapon, undefined, 2.5, undefined, undefined, undefined);
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0x1e130b08, Offset: 0x32d0
// Size: 0xaa
function get_perk_weapon(str_perk) {
    weapon = "";
    assert(isdefined(str_perk), "<dev string:xf5>");
    if (!isdefined(str_perk)) {
        return weapon;
    }
    if (!isdefined(level._custom_perks)) {
        return weapon;
    }
    if (isdefined(level._custom_perks[str_perk]) && isdefined(level._custom_perks[str_perk].perk_bottle_weapon)) {
        weapon = level._custom_perks[str_perk].perk_bottle_weapon;
    }
    return weapon;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0x9ffef3aa, Offset: 0x3388
// Size: 0x9e
function get_perk_weapon_model(str_perk) {
    weapon = get_perk_weapon(str_perk);
    assert(isdefined(weapon), "<dev string:x11b>" + str_perk);
    assert(isdefined(weapon.worldmodel), "<dev string:x138>" + str_perk);
    if (isdefined(weapon)) {
        return weapon.worldmodel;
    }
    return "tag_origin";
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xa2198702, Offset: 0x3430
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
// Params 1, eflags: 0x1 linked
// Checksum 0xa9f38480, Offset: 0x3478
// Size: 0x8e
function function_b2cba45a(var_9bf8fb5c) {
    if (self.var_67ba1237.size >= 6) {
        return undefined;
    }
    var_16c042b8 = self function_5ea0c6cf(var_9bf8fb5c);
    if (isdefined(var_16c042b8)) {
        self function_a7ae070c(var_16c042b8);
        return var_16c042b8;
    }
    self playsoundtoplayer(level.zmb_laugh_alias, self);
    return undefined;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x1c74d6b0, Offset: 0x3510
// Size: 0x118
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
// Params 1, eflags: 0x1 linked
// Checksum 0x37210923, Offset: 0x3630
// Size: 0x82
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
// Params 1, eflags: 0x1 linked
// Checksum 0x48693d59, Offset: 0x36c0
// Size: 0x1d8
function quantum_bomb_give_nearest_perk_result(position) {
    [[ level.var_77926928 ]](position);
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
            player function_a7ae070c(perk);
            player [[ level.var_cbbe9244 ]]();
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0x663f8b6c, Offset: 0x38a0
// Size: 0x32c
function perk_pause(perk) {
    if (is_true(level.dont_unset_perk_when_machine_paused)) {
        return;
    }
    for (j = 0; j < getplayers().size; j++) {
        player = getplayers()[j];
        if (player function_e56d8ef4(perk)) {
            continue;
        }
        if (!isdefined(player.var_c4890291)) {
            player.var_c4890291 = [];
        }
        player.var_c4890291[perk] = is_true(player.var_c4890291[perk]) || player hasperk(perk);
        if (player.var_c4890291[perk]) {
            player perks::perk_unsetperk(perk);
            if (isdefined(level._custom_perks[perk].var_658e2856)) {
                if (isarray(level._custom_perks[perk].var_658e2856)) {
                    foreach (specialty in level._custom_perks[perk].var_658e2856) {
                        perks::perk_unsetperk(specialty);
                    }
                } else {
                    perks::perk_unsetperk(level._custom_perks[perk].var_658e2856);
                }
            }
            n_slot = player function_c1efcc57(perk);
            player function_2ac7579(n_slot, 0, level._custom_perks[perk].alias);
            player set_perk_clientfield(perk, 2);
            if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_take)) {
                player thread [[ level._custom_perks[perk].player_thread_take ]](1, undefined, undefined, -1);
            }
            println("<dev string:x161>" + player.name + "<dev string:x16f>" + perk + "<dev string:x180>");
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0x4782deb4, Offset: 0x3bd8
// Size: 0x2f4
function perk_unpause(perk) {
    if (is_true(level.dont_unset_perk_when_machine_paused)) {
        return;
    }
    if (!isdefined(perk)) {
        return;
    }
    for (j = 0; j < getplayers().size; j++) {
        player = getplayers()[j];
        if (isdefined(player.var_c4890291) && is_true(player.var_c4890291[perk])) {
            player.var_c4890291[perk] = 0;
            player set_perk_clientfield(perk, 1);
            n_slot = player function_c1efcc57(perk);
            player function_2ac7579(n_slot, 1, level._custom_perks[perk].alias);
            player perks::perk_setperk(perk);
            if (isdefined(level._custom_perks[perk].var_658e2856)) {
                if (isarray(level._custom_perks[perk].var_658e2856)) {
                    foreach (specialty in level._custom_perks[perk].var_658e2856) {
                        perks::perk_setperk(specialty);
                    }
                } else {
                    perks::perk_setperk(level._custom_perks[perk].var_658e2856);
                }
            }
            println("<dev string:x161>" + player.name + "<dev string:x185>" + perk + "<dev string:x180>");
            player zm_utility::set_max_health();
            if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_give)) {
                player thread [[ level._custom_perks[perk].player_thread_give ]]();
            }
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0xece8446, Offset: 0x3ed8
// Size: 0x100
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
// Params 1, eflags: 0x1 linked
// Checksum 0xa29e5842, Offset: 0x3fe0
// Size: 0x100
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
// Checksum 0xdcd22045, Offset: 0x40e8
// Size: 0x98
function function_d053f137() {
    if (isdefined(level.var_b8be892e)) {
        foreach (var_83225a27 in level.var_b8be892e) {
            perk_pause(var_83225a27);
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xc7d652b9, Offset: 0x4188
// Size: 0x98
function function_d087adc6() {
    if (isdefined(level.var_b8be892e)) {
        foreach (var_83225a27 in level.var_b8be892e) {
            perk_unpause(var_83225a27);
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0xea55a031, Offset: 0x4228
// Size: 0x46
function has_perk_paused(perk) {
    if (isdefined(self.var_c4890291) && isdefined(self.var_c4890291[perk]) && self.var_c4890291[perk]) {
        return true;
    }
    return false;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0x911e116f, Offset: 0x4278
// Size: 0x7a
function getvendingmachinenotify() {
    if (!isdefined(self)) {
        return "";
    }
    str_perk = undefined;
    if (isdefined(level._custom_perks[self.script_notify]) && isdefined(isdefined(level._custom_perks[self.script_notify].alias))) {
        str_perk = level._custom_perks[self.script_notify].alias;
    }
    return str_perk;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0x596d9e0c, Offset: 0x4300
// Size: 0x12
function function_80cb4982() {
    return self.var_67ba1237.size >= 6;
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0xf39036e2, Offset: 0x4320
// Size: 0x24c
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
// Params 0, eflags: 0x1 linked
// Checksum 0xb3518596, Offset: 0x4578
// Size: 0x998
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
    if (is_true(level.randomize_perk_machine_location)) {
        a_s_random_perk_locs = struct::get_array("perk_random_machine_location", "targetname");
        if (a_s_random_perk_locs.size > 0) {
            a_s_random_perk_locs = array::randomize(a_s_random_perk_locs);
        }
        n_random_perks_assigned = 0;
    }
    foreach (s_spawn_pos in a_s_spawn_pos) {
        perk = s_spawn_pos.script_noteworthy;
        if (isdefined(perk) && isdefined(s_spawn_pos.model)) {
            if (is_true(level.randomize_perk_machine_location) && a_s_random_perk_locs.size > 0 && isdefined(s_spawn_pos.script_notify)) {
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
            unitrigger_stub.prompt_and_visibility_func = &function_5296af32;
            zm_unitrigger::register_static_unitrigger(unitrigger_stub, &vending_trigger_think);
            perk_machine = spawn("script_model", s_spawn_pos.origin);
            if (!isdefined(s_spawn_pos.angles)) {
                s_spawn_pos.angles = (0, 0, 0);
            }
            perk_machine.angles = s_spawn_pos.angles;
            perk_machine setmodel(s_spawn_pos.model);
            if (is_true(level._no_vending_machine_bump_trigs)) {
                bump_trigger = undefined;
            } else {
                bump_trigger = spawn("trigger_radius", s_spawn_pos.origin + (0, 0, 30), 0, 40, 80, 1);
                bump_trigger.script_activated = 1;
                bump_trigger.script_sound = "zmb_perks_bump_bottle";
                bump_trigger.targetname = "audio_bump_trigger";
            }
            if (is_true(level._no_vending_machine_auto_collision)) {
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
            unitrigger_stub thread function_f29c0595();
            unitrigger_stub thread electric_perks_dialog();
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0x71b823ba, Offset: 0x4f18
// Size: 0x296
function function_5296af32(player) {
    perk = self.script_noteworthy;
    var_f2a92d5e = 0;
    if (isdefined(self.stub.machine)) {
        var_f2a92d5e = self.stub.machine.power_on;
    }
    if (isdefined(perk) && !player function_6c32d092(hash(perk)) && self vending_trigger_can_player_use(player, 0) && !player has_perk_paused(perk) && !player zm_utility::in_revive_trigger() && !zm_equipment::is_equipment_that_blocks_purchase(player getcurrentweapon()) && !player zm_equipment::hacker_active()) {
        b_is_invis = 0;
        if (!var_f2a92d5e) {
            self.stub.hint_string = #"zombie/need_power";
            self.stub.hint_parm1 = undefined;
        } else {
            cost = zombie_utility::function_d2dfacfd(#"zombie_perk_cost");
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
        zm_unitrigger::function_d0676c62(self.stub, self, player);
    } else {
        b_is_invis = 1;
    }
    return !b_is_invis;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x889fafe3, Offset: 0x51b8
// Size: 0x1e8
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
// Params 2, eflags: 0x1 linked
// Checksum 0xba42b7cd, Offset: 0x53a8
// Size: 0x50
function function_9760a58b(perk, b_enable = 1) {
    if (!isdefined(level.var_b023322)) {
        level.var_b023322 = [];
    }
    level.var_b023322[perk] = b_enable;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0x60b425a7, Offset: 0x5400
// Size: 0x9a
function get_perk_machine_start_state(perk) {
    if (is_true(level.vending_machines_powered_on_at_start)) {
        return 1;
    }
    if (is_true(level.var_b023322[perk])) {
        return 1;
    }
    if (perk == #"hash_7f98b3dd3cce95aa") {
        assert(isdefined(level.revive_machine_is_solo));
        return level.revive_machine_is_solo;
    }
    return 0;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0x4273a65a, Offset: 0x54a8
// Size: 0xe0
function perks_register_clientfield() {
    if (is_true(level.zombiemode_using_perk_intro_fx)) {
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
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x61ca34f3, Offset: 0x5590
// Size: 0x634
function function_89e748a7() {
    for (i = 0; i < 4; i++) {
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".itemIndex", 1, 5, "int", 0);
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".state", 1, 2, "int", 0);
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".progress", 1, 5, "float", 0);
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".chargeCount", 1, 3, "int", 0);
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".timerActive", 1, 1, "int", 0);
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".bleedoutOrderIndex", 1, 2, "int", 0);
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".bleedoutActive", 1, 1, "int", 0);
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".specialEffectActive", 1, 1, "int", 0);
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".modifierActive", 6000, 1, "int", 0);
    }
    clientfield::register_clientuimodel("hudItems.perkVapor.bleedoutProgress", 9000, 8, "float", 0);
    for (i = 0; i < 6; i++) {
        n_version = 1;
        if (i >= 4) {
            n_version = 8000;
        }
        clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".itemIndex", n_version, 5, "int", 0);
        clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".state", n_version, 2, "int", 0);
        clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".progress", n_version, 5, "float", 0);
        clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".chargeCount", n_version, 3, "int", 0);
        clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".timerActive", n_version, 1, "int", 0);
        clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".specialEffectActive", n_version, 1, "int", 0);
    }
    clientfield::register("scriptmover", "" + #"hash_cf74c35ecc5a49", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_35fe26fc5cb223b3", 1, 3, "int");
    clientfield::register("toplayer", "" + #"hash_6fb426c48a4877e0", 1, 3, "int");
    clientfield::register("toplayer", "" + #"hash_345845080e40675d", 1, 3, "int");
    clientfield::register("toplayer", "" + #"hash_1da6660f0414562", 1, 3, "int");
    if (level.var_c3e5c4cd == 2) {
        clientfield::register("world", "" + #"hash_46334db9e3c76275", 1, 1, "int");
        clientfield::register("scriptmover", "" + #"hash_50eb488e58f66198", 1, 1, "int");
        clientfield::register("allplayers", "" + #"hash_222c3403d2641ea6", 1, 3, "int");
        clientfield::register("toplayer", "" + #"hash_17283692696da23b", 1, 1, "counter");
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0x70e9d1c0, Offset: 0x5bd0
// Size: 0x7e
function function_ad1814a1(n_index, var_b0ab4cec) {
    if (isdefined(n_index) && n_index >= 0 && n_index < 6) {
        return true;
    }
    println("<dev string:x198>" + function_9e72a96(var_b0ab4cec) + "<dev string:x1a7>");
    return false;
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0xd2c36c0d, Offset: 0x5c58
// Size: 0x56
function function_81bc6765(var_481d50cb, var_b0ab4cec) {
    if (var_481d50cb == -1) {
        if (function_ad1814a1(self.var_eabca645[var_b0ab4cec], var_b0ab4cec)) {
        }
        return;
    }
    if (var_481d50cb > 4) {
    }
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x1 linked
// Checksum 0xc5dd3eaf, Offset: 0x5cb8
// Size: 0x1c
function function_2ac7579(var_481d50cb, *var_dc149467, var_b0ab4cec) {
    
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x0
// Checksum 0x8634c3cf, Offset: 0x5d58
// Size: 0x13e
function function_13880aa5(var_481d50cb, var_87eb3522 = 0, var_b0ab4cec) {
    assert(isdefined(var_481d50cb), "<dev string:x1e1>");
    if (!isdefined(var_481d50cb)) {
        return;
    }
    if (!isdefined(self.var_f18b8e91)) {
        self.var_f18b8e91 = [];
    }
    if (var_87eb3522 == 1 && isdefined(var_b0ab4cec) && self.var_f18b8e91[var_b0ab4cec] !== 1) {
        self.var_f18b8e91[var_b0ab4cec] = 1;
        self playsoundtoplayer(#"hash_7e01de7cf0aa4995", self);
    } else if (var_87eb3522 != 1) {
        self.var_f18b8e91[var_b0ab4cec] = var_87eb3522;
    }
    if (var_481d50cb == -1 && isdefined(var_b0ab4cec)) {
        if (function_ad1814a1(self.var_eabca645[var_b0ab4cec], var_b0ab4cec)) {
        }
        return;
    }
    if (var_481d50cb > 4) {
    }
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x0
// Checksum 0x2e4ed074, Offset: 0x5ea0
// Size: 0x8a
function function_f2ff97a6(var_481d50cb, *var_c3d1c893, var_b0ab4cec) {
    assert(isdefined(var_c3d1c893), "<dev string:x1e1>");
    if (!isdefined(var_c3d1c893)) {
        return;
    }
    if (var_c3d1c893 == -1 && isdefined(var_b0ab4cec)) {
        if (function_ad1814a1(self.var_eabca645[var_b0ab4cec], var_b0ab4cec)) {
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x0
// Checksum 0x675bb799, Offset: 0x5f38
// Size: 0x8a
function function_f0ac059f(var_481d50cb, *b_active, var_b0ab4cec) {
    assert(isdefined(b_active), "<dev string:x1e1>");
    if (!isdefined(b_active)) {
        return;
    }
    if (b_active == -1 && isdefined(var_b0ab4cec)) {
        if (function_ad1814a1(self.var_eabca645[var_b0ab4cec], var_b0ab4cec)) {
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x0
// Checksum 0x91c08f7b, Offset: 0x5fd0
// Size: 0x8a
function function_c8c7bc5(var_481d50cb, *b_active, var_b0ab4cec) {
    assert(isdefined(b_active), "<dev string:x1e1>");
    if (!isdefined(b_active)) {
        return;
    }
    if (b_active == -1 && isdefined(var_b0ab4cec)) {
        if (function_ad1814a1(self.var_eabca645[var_b0ab4cec], var_b0ab4cec)) {
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0x548469da, Offset: 0x6068
// Size: 0x20
function function_b8c12b0f(var_481d50cb, *b_active) {
    if (b_active > 4) {
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0x5a793f26, Offset: 0x6090
// Size: 0x7c
function function_4acf7b43(n_slot, var_16c042b8) {
    if (!isdefined(level._custom_perks)) {
        return;
    }
    if (isdefined(level._custom_perks[var_16c042b8])) {
        var_52905dda = level._custom_perks[var_16c042b8].alias;
    }
    if (isdefined(var_52905dda)) {
        self thread function_81bc6765(n_slot, var_52905dda);
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x9f748193, Offset: 0x6118
// Size: 0xa0
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
// Params 1, eflags: 0x1 linked
// Checksum 0xc25e4100, Offset: 0x61c0
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
// Params 0, eflags: 0x1 linked
// Checksum 0xb47725aa, Offset: 0x6300
// Size: 0x17c
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
// Params 2, eflags: 0x1 linked
// Checksum 0x52e7a75f, Offset: 0x6488
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
// Params 2, eflags: 0x1 linked
// Checksum 0x38673327, Offset: 0x65a8
// Size: 0xf0
function spare_change(str_trigger = "audio_bump_trigger", str_sound = "zmb_perks_bump_bottle") {
    a_t_audio = getentarray(str_trigger, "targetname");
    foreach (t_audio_bump in a_t_audio) {
        if (t_audio_bump.script_sound === str_sound) {
            t_audio_bump thread check_for_change();
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0xc7591091, Offset: 0x66a0
// Size: 0xc4
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
// Checksum 0x475de922, Offset: 0x6770
// Size: 0x9c
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
// Params 1, eflags: 0x0
// Checksum 0x838da879, Offset: 0x6818
// Size: 0x44
function register_revive_success_perk_func(revive_func) {
    if (!isdefined(level.a_revive_success_perk_func)) {
        level.a_revive_success_perk_func = [];
    }
    level.a_revive_success_perk_func[level.a_revive_success_perk_func.size] = revive_func;
}

// Namespace zm_perks/zm_perks
// Params 7, eflags: 0x1 linked
// Checksum 0x3d53bf58, Offset: 0x6868
// Size: 0x318
function register_perk_basic_info(str_perk, str_alias, n_perk_cost, str_hint_string, w_perk_bottle_weapon, var_1408cd4c, *var_6334ae50) {
    assert(isdefined(str_alias), "<dev string:x206>");
    assert(isdefined(n_perk_cost), "<dev string:x247>");
    assert(isdefined(str_hint_string), "<dev string:x289>");
    assert(isdefined(w_perk_bottle_weapon), "<dev string:x2cd>");
    assert(isdefined(var_1408cd4c), "<dev string:x315>");
    _register_undefined_perk(str_alias);
    level._custom_perks[str_alias].alias = n_perk_cost;
    level._custom_perks[str_alias].cost = str_hint_string;
    level._custom_perks[str_alias].hint_string = w_perk_bottle_weapon;
    level._custom_perks[str_alias].perk_bottle_weapon = var_1408cd4c;
    level._custom_perks[str_alias].var_66de8d1c = var_6334ae50;
    if (!getgametypesetting(#"magic")) {
        return;
    }
    if (!isdefined(level.var_b8be892e)) {
        level.var_b8be892e = [];
    }
    if (!isdefined(level.var_b8be892e)) {
        level.var_b8be892e = [];
    } else if (!isarray(level.var_b8be892e)) {
        level.var_b8be892e = array(level.var_b8be892e);
    }
    if (!isinarray(level.var_b8be892e, str_alias)) {
        level.var_b8be892e[level.var_b8be892e.size] = str_alias;
    }
    if (!isdefined(level.var_fa3df1eb)) {
        level.var_fa3df1eb = [];
    }
    if (str_alias != #"specialty_mystery") {
        if (!isdefined(level.var_fa3df1eb)) {
            level.var_fa3df1eb = [];
        } else if (!isarray(level.var_fa3df1eb)) {
            level.var_fa3df1eb = array(level.var_fa3df1eb);
        }
        if (!isinarray(level.var_fa3df1eb, str_alias)) {
            level.var_fa3df1eb[level.var_fa3df1eb.size] = str_alias;
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 5, eflags: 0x0
// Checksum 0x299b92a4, Offset: 0x6b88
// Size: 0x17c
function register_perk_mod_basic_info(str_perk, str_alias, var_771fabd4, var_5a736864, n_cost) {
    assert(isdefined(str_perk), "<dev string:x362>");
    assert(isdefined(str_alias), "<dev string:x3a7>");
    assert(isdefined(var_5a736864), "<dev string:x3ed>");
    assert(isdefined(n_cost), "<dev string:x439>");
    _register_undefined_perk(str_perk);
    level._custom_perks[str_perk].alias = str_alias;
    level._custom_perks[str_perk].var_60e3692f = var_771fabd4;
    level._custom_perks[str_perk].n_cost = n_cost;
    if (!isdefined(level.var_5355c665)) {
        level.var_5355c665 = [];
    } else if (!isarray(level.var_5355c665)) {
        level.var_5355c665 = array(level.var_5355c665);
    }
    level.var_5355c665[var_5a736864] = str_perk;
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x1 linked
// Checksum 0x7b1521b6, Offset: 0x6d10
// Size: 0xae
function register_perk_machine(str_perk, func_perk_machine_setup, func_perk_machine_thread) {
    assert(isdefined(str_perk), "<dev string:x47c>");
    assert(isdefined(func_perk_machine_setup), "<dev string:x4ba>");
    _register_undefined_perk(str_perk);
    level._custom_perks[str_perk].perk_machine_set_kvps = func_perk_machine_setup;
    if (isdefined(func_perk_machine_thread)) {
        level._custom_perks[str_perk].perk_machine_thread = func_perk_machine_thread;
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0x9a229007, Offset: 0x6dc8
// Size: 0x8e
function register_perk_machine_power_override(str_perk, func_perk_machine_power_override) {
    assert(isdefined(str_perk), "<dev string:x507>");
    assert(isdefined(func_perk_machine_power_override), "<dev string:x554>");
    _register_undefined_perk(str_perk);
    if (isdefined(func_perk_machine_power_override)) {
        level._custom_perks[str_perk].perk_machine_power_override_thread = func_perk_machine_power_override;
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0xd2dc68ff, Offset: 0x6e60
// Size: 0x86
function register_perk_precache_func(str_perk, func_precache) {
    assert(isdefined(str_perk), "<dev string:x5b9>");
    assert(isdefined(func_precache), "<dev string:x5fd>");
    _register_undefined_perk(str_perk);
    level._custom_perks[str_perk].precache_func = func_precache;
}

// Namespace zm_perks/zm_perks
// Params 4, eflags: 0x1 linked
// Checksum 0xd1581b3f, Offset: 0x6ef0
// Size: 0xce
function register_perk_threads(str_perk, func_give_player_perk, func_take_player_perk, var_9a0b6a21) {
    assert(isdefined(str_perk), "<dev string:x646>");
    assert(isdefined(func_give_player_perk), "<dev string:x684>");
    _register_undefined_perk(str_perk);
    level._custom_perks[str_perk].player_thread_give = func_give_player_perk;
    level._custom_perks[str_perk].player_thread_take = func_take_player_perk;
    if (isdefined(var_9a0b6a21)) {
        level._custom_perks[str_perk].var_9a0b6a21 = var_9a0b6a21;
    }
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x1 linked
// Checksum 0x78a734c6, Offset: 0x6fc8
// Size: 0xc6
function register_perk_clientfields(str_perk, func_clientfield_register, func_clientfield_set) {
    assert(isdefined(str_perk), "<dev string:x6cf>");
    assert(isdefined(func_clientfield_register), "<dev string:x712>");
    assert(isdefined(func_clientfield_set), "<dev string:x766>");
    _register_undefined_perk(str_perk);
    level._custom_perks[str_perk].clientfield_register = func_clientfield_register;
    level._custom_perks[str_perk].clientfield_set = func_clientfield_set;
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x1 linked
// Checksum 0x2d76c865, Offset: 0x7098
// Size: 0xc6
function register_perk_host_migration_params(str_perk, str_radiant_name, str_effect_name) {
    assert(isdefined(str_perk), "<dev string:x7b5>");
    assert(isdefined(str_radiant_name), "<dev string:x801>");
    assert(isdefined(str_effect_name), "<dev string:x855>");
    _register_undefined_perk(str_perk);
    level._custom_perks[str_perk].radiant_machine_name = str_radiant_name;
    level._custom_perks[str_perk].machine_light_effect = str_effect_name;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0xfcbee73f, Offset: 0x7168
// Size: 0x60
function _register_undefined_perk(str_perk) {
    if (!isdefined(level._custom_perks)) {
        level._custom_perks = [];
    }
    if (!isdefined(level._custom_perks[str_perk])) {
        level._custom_perks[str_perk] = spawnstruct();
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0xb028ba8, Offset: 0x71d0
// Size: 0x6c
function register_perk_damage_override_func(func_damage_override) {
    assert(isdefined(func_damage_override), "<dev string:x8a8>");
    if (!isdefined(level.perk_damage_override)) {
        level.perk_damage_override = [];
    }
    array::add(level.perk_damage_override, func_damage_override, 0);
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x89690aa8, Offset: 0x7248
// Size: 0x86
function function_2ae97a14(str_perk, var_feae8586) {
    assert(isdefined(str_perk), "<dev string:x8ff>");
    assert(isdefined(var_feae8586), "<dev string:x93e>");
    _register_undefined_perk(str_perk);
    level._custom_perks[str_perk].var_658e2856 = var_feae8586;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x5a602477, Offset: 0x72d8
// Size: 0x1a
function function_6b2d8dc0() {
    return struct::get_array("perk_vapor_altar");
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0x3630f70b, Offset: 0x7300
// Size: 0x32
function function_9a0e9d65() {
    if (!isdefined(self) || !isdefined(self.var_466b927f)) {
        return false;
    }
    return self.var_466b927f.size >= 4;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0xd650b5f1, Offset: 0x7340
// Size: 0x50
function function_80514167() {
    if (!isdefined(self) || !isdefined(self.var_466b927f) || !isdefined(self.var_67ba1237)) {
        return false;
    }
    return !self.var_466b927f.size && !self.var_67ba1237.size;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x4eeeb75d, Offset: 0x7398
// Size: 0x5c
function function_39440031() {
    for (i = 0; i < 4; i++) {
        if (isdefined(self.var_c27f1e90[i])) {
            function_4acf7b43(i, self.var_c27f1e90[i]);
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x97703837, Offset: 0x7400
// Size: 0x594
function perk_vapor_altar_init() {
    function_8c7cee86();
    a_s_spawn_pos = [];
    a_structs = array::randomize(struct::get_array("perk_vapor_altar"));
    foreach (struct in a_structs) {
        if (!isdefined(struct.script_int) || struct.script_int == -1) {
            for (i = 0; i < 4; i++) {
                if (!is_true(function_c210fc2e(i, a_structs))) {
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
            unitrigger_stub.prompt_and_visibility_func = &function_b7f2c635;
            zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_f5da744e);
            zm_unitrigger::function_c4a5fdf5(unitrigger_stub, 1);
            if (!isdefined(s_spawn_pos.angles)) {
                s_spawn_pos.angles = (0, 0, 0);
            }
            if (is_true(level._no_vending_machine_bump_trigs)) {
                bump_trigger = undefined;
            } else {
                bump_trigger = spawn("trigger_radius", s_spawn_pos.origin + (0, 0, 30), 0, 40, 80, 1);
                bump_trigger.script_activated = 1;
                bump_trigger.script_sound = "zmb_perks_bump_bottle";
                bump_trigger.targetname = "audio_bump_trigger";
            }
            if (is_true(level._no_vending_machine_auto_collision)) {
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
            unitrigger_stub.var_3468124 = s_spawn_pos;
            unitrigger_stub.var_3468124.var_2977c27 = "off";
            unitrigger_stub thread function_b2ac6ee7();
            unitrigger_stub thread function_8b413937(s_spawn_pos);
            level.var_76a7ad28[level.var_76a7ad28.size] = unitrigger_stub;
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0x3007685e, Offset: 0x79a0
// Size: 0x43c
function function_8c7cee86() {
    var_5297120 = struct::get_array("random_perk_vapor_altar", "script_noteworthy");
    if (isdefined(level.var_c032ff64)) {
        var_c4c69578 = [[ level.var_c032ff64 ]]();
    }
    if (var_5297120.size > 0) {
        var_ae36fbfd = [];
        for (i = 0; i <= 4; i++) {
            var_ae36fbfd[i] = [];
        }
        foreach (var_7a9ec77b in var_5297120) {
            if (!isdefined(var_7a9ec77b.script_int) || var_7a9ec77b.script_int > 3 || var_7a9ec77b.script_int < -1) {
                if (!isdefined(var_ae36fbfd[0])) {
                    var_ae36fbfd[0] = [];
                } else if (!isarray(var_ae36fbfd[0])) {
                    var_ae36fbfd[0] = array(var_ae36fbfd[0]);
                }
                var_ae36fbfd[0][var_ae36fbfd[0].size] = var_7a9ec77b;
                continue;
            }
            if (!isdefined(var_ae36fbfd[var_7a9ec77b.script_int + 1])) {
                var_ae36fbfd[var_7a9ec77b.script_int + 1] = [];
            } else if (!isarray(var_ae36fbfd[var_7a9ec77b.script_int + 1])) {
                var_ae36fbfd[var_7a9ec77b.script_int + 1] = array(var_ae36fbfd[var_7a9ec77b.script_int + 1]);
            }
            var_ae36fbfd[var_7a9ec77b.script_int + 1][var_ae36fbfd[var_7a9ec77b.script_int + 1].size] = var_7a9ec77b;
        }
        foreach (var_ec770e5d in var_ae36fbfd) {
            s_loc = array::random(var_ec770e5d);
            if (isdefined(var_c4c69578)) {
                s_loc = var_c4c69578;
            }
            if (isdefined(s_loc)) {
                arrayremovevalue(var_ec770e5d, s_loc, 0);
            }
            foreach (var_7a9ec77b in var_ec770e5d) {
                e_clip = getent(var_7a9ec77b.target2, "targetname");
                var_528a3a32 = struct::get(var_7a9ec77b.target2);
                if (isdefined(e_clip)) {
                    e_clip delete();
                }
                if (isdefined(var_528a3a32)) {
                    var_528a3a32 struct::delete();
                }
                var_7a9ec77b struct::delete();
            }
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0xdca5166e, Offset: 0x7de8
// Size: 0xae
function function_c210fc2e(n_index, a_structs) {
    foreach (struct in a_structs) {
        if (isdefined(struct.script_int) && struct.script_int == n_index) {
            return true;
        }
    }
    return false;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0x23321320, Offset: 0x7ea0
// Size: 0x686
function function_b7f2c635(player) {
    n_slot = self.stub.script_int;
    perk = player.var_47654123[n_slot] ? #"specialty_mystery" : player.var_c27f1e90[n_slot];
    if (self.stub.var_36d60c16 !== 1 && player getstance() === "prone" && distancesquared(self.origin, player.origin) < 9216) {
        self.stub.var_36d60c16 = 1;
        player zm_score::add_to_player_score(100);
        self playsoundtoplayer(#"hash_30fa33e2fb90b58f", player);
    }
    if (player.var_47654123[n_slot] && !isdefined(player function_5ea0c6cf())) {
        return false;
    }
    if (is_true(self.stub.var_e80aca0a)) {
        return false;
    }
    if (!isdefined(n_slot) || !isdefined(player.var_c27f1e90) || !isdefined(player.var_c27f1e90[n_slot]) || player.var_c27f1e90[n_slot] == "") {
        return false;
    }
    if (zm_custom::function_8b8fa6e5(player)) {
        return false;
    }
    if (isdefined(player.perk_purchased)) {
        return false;
    }
    var_99442276 = 0;
    if (self.stub.var_3468124.var_2977c27 == "off") {
        self sethintstringforplayer(player, #"zombie/need_power");
        return true;
    }
    if (zm_trial_disable_buys::is_active()) {
        self sethintstringforplayer(player, #"hash_55d25caf8f7bbb2f");
        return true;
    }
    if (zm_trial_disable_perks::is_active() || !zm_custom::function_901b751c(#"zmperksactive") || zm_trial_randomize_perks::is_active()) {
        self sethintstringforplayer(player, #"hash_77db65489366a43");
        return true;
    }
    if (self.stub.var_3468124.var_2977c27 == "on" && isdefined(perk) && !player hasperk(perk) && self vending_trigger_can_player_use(player, 1) && !player has_perk_paused(perk) && !player zm_utility::in_revive_trigger() && !zm_equipment::is_equipment_that_blocks_purchase(player getcurrentweapon()) && !player zm_equipment::hacker_active()) {
        var_99442276 = 1;
    }
    if (var_99442276) {
        b_is_invis = 0;
        if (isdefined(level._custom_perks)) {
            if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].cost) && isdefined(level._custom_perks[perk].hint_string)) {
                n_cost = level function_44915d1(perk, n_slot);
                if (isdefined(level.var_256aa316)) {
                    var_c591876d = [[ level.var_256aa316 ]](perk);
                } else {
                    var_c591876d = level._custom_perks[perk].hint_string;
                }
            }
        }
        if (n_slot == 0 && is_true(player.talisman_perk_reducecost_1)) {
            n_cost -= player.talisman_perk_reducecost_1;
        }
        if (n_slot == 1 && is_true(player.talisman_perk_reducecost_2)) {
            n_cost -= player.talisman_perk_reducecost_2;
        }
        if (n_slot == 2 && is_true(player.talisman_perk_reducecost_3)) {
            n_cost -= player.talisman_perk_reducecost_3;
        }
        if (n_slot == 3 && is_true(player.talisman_perk_reducecost_4)) {
            n_cost -= player.talisman_perk_reducecost_4;
        }
        n_cost = player namespace_e38c57c1::function_863dc0ef(n_cost);
        n_cost = int(max(n_cost, 0));
        if (isdefined(var_c591876d) && var_c591876d !== " ") {
            self sethintstringforplayer(player, var_c591876d, n_cost);
        }
    } else {
        b_is_invis = 1;
    }
    return !b_is_invis;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0x5937830d, Offset: 0x8530
// Size: 0x790
function function_f5da744e() {
    self endon(#"death");
    n_slot = self.stub.script_int;
    n_cost = self.stub.cost;
    if (level.var_c3e5c4cd == 1) {
        self thread function_9da4880b();
    }
    for (;;) {
        waitresult = self waittill(#"trigger");
        player = waitresult.activator;
        if (self.stub.var_3468124.var_2977c27 != "on") {
            continue;
        }
        if (!vending_trigger_can_player_use(player, 1) || zm_trial_disable_buys::is_active() || zm_trial_disable_perks::is_active() || !zm_custom::function_901b751c(#"zmperksactive")) {
            wait 0.1;
            continue;
        }
        perk = player.var_47654123[n_slot] ? #"specialty_mystery" : player.var_c27f1e90[n_slot];
        if (!isdefined(player.var_c27f1e90) || player.var_c27f1e90.size <= n_slot) {
            return;
        }
        if (player.var_47654123[n_slot] && !isdefined(player function_5ea0c6cf())) {
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
                zm_utility::play_sound_on_ent("no_purchase");
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
                n_cost = level function_44915d1(perk, n_slot);
            }
        }
        current_cost = n_cost;
        if (n_slot == 0 && is_true(player.talisman_perk_reducecost_1)) {
            current_cost -= player.talisman_perk_reducecost_1;
        }
        if (n_slot == 1 && is_true(player.talisman_perk_reducecost_2)) {
            current_cost -= player.talisman_perk_reducecost_2;
        }
        if (n_slot == 2 && is_true(player.talisman_perk_reducecost_3)) {
            current_cost -= player.talisman_perk_reducecost_3;
        }
        if (n_slot == 3 && is_true(player.talisman_perk_reducecost_4)) {
            current_cost -= player.talisman_perk_reducecost_4;
        }
        current_cost = player namespace_e38c57c1::function_863dc0ef(current_cost);
        current_cost = int(max(current_cost, 0));
        if (!player zm_score::can_player_purchase(current_cost)) {
            zm_utility::play_sound_on_ent("no_purchase");
            player zm_audio::create_and_play_dialog(#"general", #"outofmoney");
            continue;
        }
        player thread zm_audio::create_and_play_dialog(#"altar", #"interact");
        playsoundatposition(#"hash_489cdfeed1ac55bd", self.origin);
        if (level.var_c3e5c4cd == 1 && !self.var_3cfb2018) {
            playsoundatposition(#"hash_1e20f59360c2377e", self.origin);
        }
        player zm_score::minus_to_player_score(current_cost);
        bb::logpurchaseevent(player, self, current_cost, perk, 0, "_perk", "_purchased");
        if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].alias)) {
            perkhash = level._custom_perks[perk].alias;
        }
        if (!ishash(perkhash)) {
            assertmsg("<dev string:x983>");
            perkhash = -1;
        }
        n_round_number = level.round_number;
        if (!isint(n_round_number)) {
            assertmsg("<dev string:x9bb>");
            n_round_number = 0;
        }
        player recordmapevent(29, gettime(), self.origin, n_round_number, perkhash);
        player.perk_purchased = perk;
        player notify(#"perk_purchased", {#perk:perk});
        if (player.var_47654123[n_slot]) {
            perk = player function_5ea0c6cf();
        }
        self thread taking_cover_tanks_(player, perk, n_slot, self.stub.var_3468124);
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0xe11bd0a9, Offset: 0x8cc8
// Size: 0x13e
function function_9da4880b() {
    self endon(#"death");
    self.var_3cfb2018 = 0;
    while (true) {
        wait randomintrange(90, 180);
        if (self.stub.var_3468124.var_2977c27 != "on") {
            continue;
        }
        if (math::cointoss() && !self.var_3cfb2018) {
            self.var_3cfb2018 = 1;
            str_alias = #"hash_84373a7c4b63d22" + randomintrangeinclusive(1, 5);
            playsoundatposition(str_alias, self.origin);
            n_wait = float(soundgetplaybacktime(str_alias)) / 1000;
            wait n_wait;
            self.var_3cfb2018 = 0;
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 4, eflags: 0x1 linked
// Checksum 0x87c3af7e, Offset: 0x8e10
// Size: 0x284
function taking_cover_tanks_(player, perk, n_slot, var_3468124) {
    player endon(#"disconnect", #"end_game");
    player function_fb633f9d(n_slot, 5);
    var_3468124 thread function_e9df56d1();
    player perk_give_bottle_begin(perk);
    evt = player waittilltimeout(3, #"fake_death", #"death", #"player_downed", #"offhand_fire", #"perk_abort_drinking", #"disconnect");
    player.perk_purchased = undefined;
    if (is_true(player.intermission)) {
        return;
    }
    if (evt._notify == #"offhand_fire" || evt._notify == #"timeout") {
        if (player.var_47654123[n_slot]) {
            player function_f9385a02(perk, n_slot);
            player thread function_ef7f9ab0(n_slot);
        }
        player thread function_9bdf581f(perk, n_slot, 1);
        if (isdefined(level.var_c4bedce3)) {
            player [[ level.var_c4bedce3 ]](perk);
        }
        return;
    }
    if (player.var_47654123[n_slot]) {
        player function_81bc6765(n_slot, level._custom_perks[#"specialty_mystery"].alias);
        player function_2ac7579(n_slot, 0);
    }
    player function_fb633f9d(n_slot, 0);
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x5 linked
// Checksum 0x1e4630e, Offset: 0x90a0
// Size: 0xea
function private function_44915d1(var_16c042b8, n_slot) {
    if (n_slot == 3) {
        var_f53f24dd = level.var_5355c665[var_16c042b8];
        n_cost = level._custom_perks[var_f53f24dd].n_cost;
    } else if (isfunctionptr(level._custom_perks[var_16c042b8].cost)) {
        n_cost = [[ level._custom_perks[var_16c042b8].cost ]]();
    } else {
        n_cost = level._custom_perks[var_16c042b8].cost;
    }
    if (isdefined(level.var_1f3f3e7b)) {
        n_cost = [[ level.var_1f3f3e7b ]](n_cost, n_slot);
    }
    return n_cost;
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0x9c46cd13, Offset: 0x9198
// Size: 0x1d8
function function_d11d4952() {
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
                    iprintlnbold("<dev string:xe4>");
                #/
            }
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0x3a2224c5, Offset: 0x9378
// Size: 0x14a
function function_b2ac6ee7() {
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
// Params 3, eflags: 0x1 linked
// Checksum 0x32ed07b0, Offset: 0x94d0
// Size: 0x92c
function function_9bdf581f(perk, n_slot, b_bought = 0) {
    self endon(#"player_downed", #"disconnect", #"perk_abort_drinking");
    level endon(#"end_game");
    level notify(#"hash_4e566c83cdfabe44", {#e_player:self, #perk:perk});
    self perks::perk_setperk(perk);
    if (isdefined(level._custom_perks[perk].var_658e2856)) {
        if (isarray(level._custom_perks[perk].var_658e2856)) {
            foreach (specialty in level._custom_perks[perk].var_658e2856) {
                perks::perk_setperk(specialty);
            }
        } else {
            perks::perk_setperk(level._custom_perks[perk].var_658e2856);
        }
    }
    if (is_true(b_bought)) {
        self thread give_perk_presentation(perk);
        self notify(#"perk_bought", {#var_16c042b8:perk, #n_slot:n_slot});
        self zm_stats::increment_challenge_stat(#"survivalist_buy_perk");
        self zm_stats::function_c0c6ab19(#"perks_used");
        if (zm_utility::is_standard()) {
            self zm_stats::function_c0c6ab19(#"perks_activated");
        }
    }
    if (n_slot < 4) {
        var_9a0250b7 = level._custom_perks[hash(perk)].alias;
        self function_2ac7579(n_slot, 1);
        if (self.var_47654123[n_slot]) {
            self function_81bc6765(n_slot, var_9a0250b7);
        } else if (!is_true(b_bought)) {
            self function_fb633f9d(n_slot, 6);
        }
        self stats::inc_stat(#"perk_stats", var_9a0250b7, #"given", #"statvalue", 1);
    } else {
        self stats::inc_stat(#"perk_stats", level._custom_perks[perk].var_60e3692f, #"modifier_given", #"statvalue", 1);
    }
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_give)) {
        self thread [[ level._custom_perks[perk].player_thread_give ]]();
    }
    self set_perk_clientfield(perk, 1);
    demo::bookmark(#"zm_player_perk", gettime(), self);
    potm::bookmark(#"zm_player_perk", gettime(), self);
    if (!zm_trial_randomize_perks::is_active()) {
        self zm_stats::increment_client_stat("perks_drank");
        self zm_stats::increment_player_stat("perks_drank");
        if (!isdefined(self.perk_history)) {
            self.perk_history = [];
        } else if (!isarray(self.perk_history)) {
            self.perk_history = array(self.perk_history);
        }
        if (!isinarray(self.perk_history, perk)) {
            self.perk_history[self.perk_history.size] = perk;
        }
    }
    if (!isdefined(self.var_466b927f)) {
        self.var_466b927f = [];
    } else if (!isarray(self.var_466b927f)) {
        self.var_466b927f = array(self.var_466b927f);
    }
    if (!isinarray(self.var_466b927f, perk)) {
        self.var_466b927f[self.var_466b927f.size] = perk;
    }
    function_fc0e5f36();
    if (isdefined(self.talisman_perk_permanent) && self.talisman_perk_permanent - 1 == n_slot || zm_utility::is_standard()) {
        if (!isdefined(self.var_774e0ad7)) {
            self.var_774e0ad7 = [];
        } else if (!isarray(self.var_774e0ad7)) {
            self.var_774e0ad7 = array(self.var_774e0ad7);
        }
        if (!isinarray(self.var_774e0ad7, perk)) {
            self.var_774e0ad7[self.var_774e0ad7.size] = perk;
        }
    } else if (n_slot < 4) {
        if (!isdefined(self.var_cd5d9345)) {
            self.var_cd5d9345 = [];
        } else if (!isarray(self.var_cd5d9345)) {
            self.var_cd5d9345 = array(self.var_cd5d9345);
        }
        if (!isinarray(self.var_cd5d9345, perk)) {
            self.var_cd5d9345[self.var_cd5d9345.size] = perk;
        }
    }
    self notify(#"perk_acquired", {#var_16c042b8:perk});
    self thread function_329ae65e(perk, n_slot);
    if (self.var_466b927f.size == 4 || is_true(self.talisman_perk_mod_single) && n_slot == 3) {
        var_7bc3cbfd = self.var_c27f1e90[3];
        if (var_7bc3cbfd == #"specialty_mystery") {
            var_7bc3cbfd = self.var_c4193958[3];
        }
        var_f53f24dd = level.var_5355c665[var_7bc3cbfd];
        /#
            if (isstring(var_7bc3cbfd)) {
                var_7bc3cbfd = hash(var_7bc3cbfd);
            }
            assert(isdefined(var_f53f24dd), "<dev string:x9f8>" + function_9e72a96(var_7bc3cbfd));
        #/
        if (isdefined(var_f53f24dd) && !isinarray(self.var_466b927f, var_f53f24dd)) {
            self notify(#"hash_13948ef3726b968f", {#var_f53f24dd:var_f53f24dd});
            self function_df87281a(var_f53f24dd);
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0xbd328ea6, Offset: 0x9e08
// Size: 0x5c
function function_ef7f9ab0(n_slot) {
    self endon(#"disconnect");
    while (self zm_utility::is_drinking()) {
        wait 0.1;
    }
    self function_fb633f9d(n_slot, 0);
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0xbae3d738, Offset: 0x9e70
// Size: 0x5c
function function_fc0e5f36() {
    var_1108cad = array::exclude(level.var_fa3df1eb, self.perk_history);
    if (!var_1108cad.size) {
        self zm_utility::function_659819fa(#"zm_trophy_perkaholic_relapse");
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0xc879f9f6, Offset: 0x9ed8
// Size: 0x494
function function_329ae65e(perk, n_slot) {
    self endon(#"disconnect");
    perk_str = perk + "_stop";
    do {
        s_result = self waittill(perk_str);
        result = s_result._notify;
    } while (!is_true(s_result.var_613b7621) && self lost_perk_override(perk));
    var_ac32c1b8 = 0;
    self perks::perk_unsetperk(perk);
    if (is_true(self.var_47654123[n_slot]) && self.var_c27f1e90[n_slot] == perk) {
        self.var_c27f1e90[n_slot] = #"specialty_mystery";
        self.var_c4193958[n_slot] = "";
        var_ac32c1b8 = 1;
    }
    if (isdefined(level._custom_perks[perk].var_658e2856)) {
        if (isarray(level._custom_perks[perk].var_658e2856)) {
            foreach (specialty in level._custom_perks[perk].var_658e2856) {
                perks::perk_unsetperk(specialty);
            }
        } else {
            perks::perk_unsetperk(level._custom_perks[perk].var_658e2856);
        }
    }
    self.num_perks--;
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_take)) {
        self thread [[ level._custom_perks[perk].player_thread_take ]](0, perk_str, result, n_slot);
    }
    self set_perk_clientfield(perk, 0);
    if (n_slot < 4) {
        self function_2ac7579(n_slot, 0);
        if (self.var_47654123[n_slot]) {
            if (var_ac32c1b8) {
                self function_81bc6765(n_slot, level._custom_perks[#"specialty_mystery"].alias);
            }
        } else {
            self function_fb633f9d(n_slot, 0);
        }
    }
    if (isdefined(level.var_a903ab55)) {
        self [[ level.var_a903ab55 ]](perk);
    }
    arrayremovevalue(self.var_466b927f, perk, 0);
    if (!is_true(s_result.var_fe7072f6)) {
        arrayremovevalue(self.var_cd5d9345, perk, 0);
    }
    self notify(#"perk_vapor_lost");
    var_5fe29258 = self.var_c27f1e90[4];
    if (isdefined(var_5fe29258) && isinarray(self.var_466b927f, var_5fe29258)) {
        if (is_true(self.talisman_perk_mod_single) && n_slot < 3) {
            return;
        }
        self notify(var_5fe29258 + "_stop");
        self function_b8c12b0f(3, 0);
        self function_528f82a9();
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0xa01db2af, Offset: 0xa378
// Size: 0x54
function function_c1efcc57(str_name) {
    for (x = 0; x < self.var_c27f1e90.size; x++) {
        if (self.var_c27f1e90[x] == str_name) {
            return x;
        }
    }
    return -1;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x5ce2fc08, Offset: 0xa3d8
// Size: 0xc4
function function_9b641809(n_slot) {
    var_16c042b8 = self.var_c27f1e90[n_slot];
    if (isdefined(level._custom_perks[var_16c042b8].var_9a0b6a21)) {
        self [[ level._custom_perks[var_16c042b8].var_9a0b6a21 ]]();
    }
    if (n_slot == 3) {
        var_fc6c6fba = level.var_5355c665[var_16c042b8];
        if (isdefined(level._custom_perks[var_fc6c6fba].var_9a0b6a21)) {
            self [[ level._custom_perks[var_fc6c6fba].var_9a0b6a21 ]]();
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xd9f698fb, Offset: 0xa4a8
// Size: 0x68
function function_9829d4a9(n_slot) {
    var_16c042b8 = self.var_67ba1237[n_slot];
    if (isdefined(var_16c042b8) && isdefined(level._custom_perks[var_16c042b8].var_9a0b6a21)) {
        self [[ level._custom_perks[var_16c042b8].var_9a0b6a21 ]]();
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x3ee59f71, Offset: 0xa518
// Size: 0x244
function function_59fb56ff(b_show) {
    if (is_true(b_show)) {
        assert(isdefined(self.var_3468124), "<dev string:xa21>");
        self.var_e80aca0a = 0;
        if (isdefined(self.var_3468124.var_73bd396b)) {
            self.var_3468124.var_73bd396b show();
            self.var_3468124.var_73bd396b solid();
        }
        if (isdefined(self.clip)) {
            self.clip show();
            self.clip solid();
        }
        if (isdefined(self.bump)) {
            self.bump show();
            self.bump solid();
        }
        return;
    }
    assert(isdefined(self.var_3468124), "<dev string:xa21>");
    self.var_e80aca0a = 1;
    if (isdefined(self.var_3468124.var_73bd396b)) {
        self.var_3468124.var_73bd396b ghost();
        self.var_3468124.var_73bd396b notsolid();
    }
    if (isdefined(self.clip)) {
        self.clip ghost();
        self.clip notsolid();
    }
    if (isdefined(self.bump)) {
        self.bump ghost();
        self.bump notsolid();
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xd72a953c, Offset: 0xa768
// Size: 0x130
function function_cc24f525() {
    self endon(#"disconnect");
    foreach (n_slot, var_16c042b8 in self.var_c27f1e90) {
        if (!isinarray(self.var_466b927f, var_16c042b8)) {
            if (var_16c042b8 == #"specialty_mystery") {
                var_16c042b8 = self function_5ea0c6cf();
                self.var_47654123[n_slot] = 1;
                self function_f9385a02(var_16c042b8, n_slot);
            } else {
                self.var_47654123[n_slot] = 0;
            }
            self thread function_9bdf581f(var_16c042b8, n_slot);
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0x4abb53d9, Offset: 0xa8a0
// Size: 0x1ac
function function_29387491(var_16c042b8, n_slot) {
    self endon(#"fake_death", #"death", #"player_downed", #"perk_abort_drinking");
    if (var_16c042b8 == #"specialty_mystery") {
        var_ddd879da = 1;
        var_16c042b8 = self function_5ea0c6cf();
        if (!isdefined(var_16c042b8)) {
            return;
        }
    }
    self perk_give_bottle_begin(var_16c042b8);
    s_result = self waittilltimeout(3, #"offhand_fire");
    if (isdefined(n_slot)) {
        if (is_true(var_ddd879da)) {
            self.var_47654123[n_slot] = 1;
            self function_f9385a02(var_16c042b8, n_slot);
            self thread function_ef7f9ab0(n_slot);
        } else {
            self.var_47654123[n_slot] = 0;
        }
        self thread function_9bdf581f(var_16c042b8, n_slot);
        return;
    }
    if (!self function_80cb4982()) {
        self thread function_a7ae070c(var_16c042b8);
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0xdc4d11f4, Offset: 0xaa58
// Size: 0x112
function function_f9385a02(var_330ce459, n_slot) {
    str_perk = self.var_c4193958[n_slot];
    if (str_perk != "") {
        if (self hasperk(str_perk)) {
            self notify(str_perk + "_stop");
            if (n_slot == 3) {
                var_de7ee14b = level.var_5355c665[hash(str_perk)];
                if (isdefined(var_de7ee14b) && self hasperk(var_de7ee14b)) {
                    self notify(var_de7ee14b + "_stop");
                }
            }
            arrayremovevalue(self.var_774e0ad7, str_perk, 0);
        }
    }
    self.var_c4193958[n_slot] = var_330ce459;
    self.var_c27f1e90[n_slot] = var_330ce459;
    waitframe(1);
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0xba803b0a, Offset: 0xab78
// Size: 0xba
function function_5ea0c6cf(var_9bf8fb5c) {
    var_cc1db3c1 = array::exclude(level.var_b8be892e, self.var_67ba1237);
    var_cc1db3c1 = array::exclude(var_cc1db3c1, self.var_c27f1e90);
    var_cc1db3c1 = array::exclude(var_cc1db3c1, #"specialty_mystery");
    if (isarray(var_9bf8fb5c)) {
        var_cc1db3c1 = array::exclude(var_cc1db3c1, var_9bf8fb5c);
    }
    return array::random(var_cc1db3c1);
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x5 linked
// Checksum 0x4ac2c008, Offset: 0xac40
// Size: 0x24c
function private function_7723353c() {
    self endon(#"disconnect");
    if (is_true(self.is_hotjoining) || self util::is_spectating()) {
        return;
    }
    self waittill(#"perks_initialized");
    s_perk = undefined;
    if (is_true(self.talisman_perk_start_1) && isdefined(self.var_c27f1e90[0])) {
        n_slot = 0;
        str_perk = self.var_c27f1e90[0];
        self.talisman_perk_start_1 = 0;
    }
    if (is_true(self.talisman_perk_start_2) && isdefined(self.var_c27f1e90[1])) {
        n_slot = 1;
        str_perk = self.var_c27f1e90[1];
        self.talisman_perk_start_2 = 0;
    }
    if (is_true(self.talisman_perk_start_3) && isdefined(self.var_c27f1e90[2])) {
        n_slot = 2;
        str_perk = self.var_c27f1e90[2];
        self.talisman_perk_start_3 = 0;
    }
    if (is_true(self.talisman_perk_start_4) && isdefined(self.var_c27f1e90[3])) {
        n_slot = 3;
        str_perk = self.var_c27f1e90[3];
        self.talisman_perk_start_4 = 0;
    }
    level flag::wait_till("initial_blackscreen_passed");
    if (isdefined(str_perk)) {
        if (str_perk == #"specialty_mystery") {
            str_perk = self function_5ea0c6cf();
            self function_f9385a02(str_perk, n_slot);
        }
        self function_9bdf581f(str_perk, n_slot);
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0xe5034c50, Offset: 0xae98
// Size: 0x244
function function_8b413937(var_3468124) {
    level endon(#"end_game");
    var_4324192b = var_3468124.var_21c535b;
    var_b6b0d4b0 = struct::get(var_3468124.target, "targetname");
    if (isdefined(var_4324192b) && var_4324192b > -1) {
        if (isdefined(var_b6b0d4b0)) {
            var_b6b0d4b0 thread scene::play("off");
        } else {
            var_3468124 function_a30c73b9("off");
        }
        if (var_4324192b == 0) {
            level flag::wait_till("power_on");
        } else {
            level flag::wait_till("power_on" + var_4324192b);
        }
    }
    var_3468124.var_2977c27 = "on";
    if (isdefined(var_b6b0d4b0)) {
        level scene::add_scene_func(var_b6b0d4b0.scriptbundlename, &function_72c30be7, "on", var_3468124);
        var_b6b0d4b0 thread scene::play("on");
        var_3468124.var_2839b015 = var_b6b0d4b0.scriptbundlename;
    } else {
        var_3468124 function_a30c73b9("on");
        waitframe(1);
        var_3468124.var_73bd396b clientfield::set("" + #"hash_cf74c35ecc5a49", 1);
    }
    var_3468124 function_a1bad730();
    if (level.var_c3e5c4cd == 2 && var_3468124.script_int == 2) {
        level thread function_ba56adf1(var_3468124.origin, var_3468124.angles);
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0x39bcfca0, Offset: 0xb0e8
// Size: 0x2e
function function_72c30be7(var_dd74d130, var_3468124) {
    var_3468124.var_73bd396b = var_dd74d130[#"prop 1"];
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0x57f33969, Offset: 0xb120
// Size: 0x34c
function function_a30c73b9(str_state) {
    s_statue = struct::get(self.target2);
    if (!isdefined(s_statue)) {
        return;
    }
    if (!isdefined(self.var_73bd396b)) {
        if (isdefined(self.script_int)) {
            if (level.var_c3e5c4cd == 1) {
                switch (self.script_int) {
                case 0:
                    var_1d373a09 = #"p8_fxanim_zm_perk_vending_brew_mod";
                    self.var_2839b015 = #"p8_fxanim_zm_perk_vending_brew_bundle";
                    break;
                case 1:
                    var_1d373a09 = #"p8_fxanim_zm_perk_vending_cola_mod";
                    self.var_2839b015 = #"p8_fxanim_zm_perk_vending_cola_bundle";
                    break;
                case 2:
                    var_1d373a09 = #"p8_fxanim_zm_perk_vending_soda_mod";
                    self.var_2839b015 = #"p8_fxanim_zm_perk_vending_soda_bundle";
                    break;
                case 3:
                    var_1d373a09 = #"p8_fxanim_zm_perk_vending_tonic_mod";
                    self.var_2839b015 = #"p8_fxanim_zm_perk_vending_tonic_bundle";
                    break;
                }
            } else {
                switch (self.script_int) {
                case 0:
                    var_1d373a09 = #"p8_fxanim_zm_vapor_altar_danu_mod";
                    self.var_2839b015 = #"p8_fxanim_zm_vapor_altar_danu_bundle";
                    break;
                case 1:
                    var_1d373a09 = #"p8_fxanim_zm_vapor_altar_ra_mod";
                    self.var_2839b015 = #"p8_fxanim_zm_vapor_altar_ra_bundle";
                    break;
                case 2:
                    var_1d373a09 = #"p8_fxanim_zm_vapor_altar_zeus_mod";
                    self.var_2839b015 = #"p8_fxanim_zm_vapor_altar_zeus_bundle";
                    var_30a7cd8c = 1;
                    break;
                case 3:
                    var_1d373a09 = #"p8_fxanim_zm_vapor_altar_odin_mod";
                    self.var_2839b015 = #"p8_fxanim_zm_vapor_altar_odin_bundle";
                    break;
                }
            }
        }
        assert(isdefined(var_1d373a09), "<dev string:xa55>");
        self.var_73bd396b = util::spawn_model(var_1d373a09, s_statue.origin, s_statue.angles);
        if (is_true(var_30a7cd8c)) {
            waitframe(1);
            self.var_73bd396b clientfield::set("" + #"hash_50eb488e58f66198", 1);
        }
    }
    self.var_73bd396b thread scene::play(self.var_2839b015, str_state, self.var_73bd396b);
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0xd3e4981e, Offset: 0xb478
// Size: 0x17e
function function_a1bad730() {
    var_97cf25f9 = scene::get_all_shot_names(self.var_2839b015, 1);
    var_953913d1 = array("use1", "use2", "use3", "use4", "use5", "use6");
    foreach (var_3541a62b in var_953913d1) {
        if (isinarray(var_97cf25f9, var_3541a62b)) {
            if (!isdefined(self.var_31cb501c)) {
                self.var_31cb501c = [];
            } else if (!isarray(self.var_31cb501c)) {
                self.var_31cb501c = array(self.var_31cb501c);
            }
            self.var_31cb501c[self.var_31cb501c.size] = var_3541a62b;
        }
    }
    if (isdefined(self.var_31cb501c)) {
        self.var_2a08e958 = 0;
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0x1a2966fa, Offset: 0xb600
// Size: 0xaa
function function_e9df56d1() {
    if (!isdefined(self.var_31cb501c)) {
        return;
    }
    self.var_73bd396b scene::play(self.var_2839b015, self.var_31cb501c[self.var_2a08e958], self.var_73bd396b);
    self.var_73bd396b thread scene::play(self.var_2839b015, self.var_2977c27, self.var_73bd396b);
    self.var_2a08e958++;
    if (self.var_2a08e958 == self.var_31cb501c.size) {
        self.var_2a08e958 = 0;
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0x9e1ed441, Offset: 0xb6b8
// Size: 0x10e
function function_efd2c9e6() {
    if (!isdefined(self.var_73bd396b)) {
        return;
    }
    if (level.var_c3e5c4cd == 1) {
        self.var_73bd396b thread scene::play(self.var_2839b015, "disable", self.var_73bd396b);
    }
    n_slot = self.script_int;
    foreach (e_player in function_a1ef346b()) {
        e_player function_fb633f9d(n_slot, 7);
    }
    self.var_2977c27 = "disable";
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0x12c8bd34, Offset: 0xb7d0
// Size: 0x170
function function_1e721859() {
    if (!isdefined(self.var_73bd396b)) {
        return;
    }
    if (level.var_c3e5c4cd == 1) {
        self.var_73bd396b thread scene::play(self.var_2839b015, "on", self.var_73bd396b);
    }
    self.var_2977c27 = "on";
    n_slot = self.script_int;
    a_players = function_a1ef346b();
    foreach (e_player in a_players) {
        if (isinarray(e_player.var_466b927f, e_player.var_c27f1e90[n_slot]) && !e_player.var_47654123[n_slot]) {
            n_state = 6;
        } else {
            n_state = 0;
        }
        e_player function_fb633f9d(n_slot, n_state);
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0x4aafd215, Offset: 0xb948
// Size: 0xf4
function function_adc671f5(n_slot) {
    a_s_altars = struct::get_array("perk_vapor_altar");
    foreach (s_altar in a_s_altars) {
        if (s_altar.script_int == n_slot) {
            if (s_altar.var_2977c27 == "on") {
                return 1;
            }
            return 0;
        }
    }
    assertmsg("<dev string:xa83>" + n_slot);
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0x64adb059, Offset: 0xba48
// Size: 0x17c
function function_3b63b27f(var_3468124) {
    if (!isdefined(level.var_46cdd0e7)) {
        level.var_46cdd0e7 = 0;
    }
    n_altar = var_3468124.script_int;
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
        if (!level.var_46cdd0e7) {
            level.var_46cdd0e7 = 1;
            playsoundatposition(str_soundalias, var_3468124.origin);
            wait 30;
            level.var_46cdd0e7 = 0;
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xe3ce8c39, Offset: 0xbbd0
// Size: 0x14c
function function_3bcaebcb(var_403110e0) {
    if (!isdefined(var_403110e0)) {
        return;
    }
    if (!isdefined(var_403110e0.stub)) {
        return;
    }
    if (!isdefined(var_403110e0.stub.var_3468124)) {
        return;
    }
    n_altar = var_403110e0.stub.var_3468124.script_int;
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
// Params 2, eflags: 0x1 linked
// Checksum 0x51ec41d5, Offset: 0xbd28
// Size: 0x1f4
function function_fb633f9d(n_slot, n_state) {
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(level.var_b8be892e) || !isdefined(self.var_c27f1e90)) {
        return;
    }
    if (!isinarray(level.var_b8be892e, self.var_c27f1e90[n_slot])) {
        return;
    }
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
            if (level function_adc671f5(n_slot)) {
                self clientfield::set_to_player(str_clientfield, self getentitynumber() + 1);
            }
            return;
        }
        if (!level function_adc671f5(n_slot) && n_state != 7) {
            return;
        }
        self clientfield::set_to_player(str_clientfield, n_state);
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0x82aa15f2, Offset: 0xbf28
// Size: 0x116
function function_ba56adf1(var_c188cf87, var_59ad3e22) {
    level endon(#"end_game");
    level flag::wait_till("all_players_spawned");
    level clientfield::set("" + #"hash_46334db9e3c76275", 1);
    while (true) {
        a_e_players = arraysortclosest(level.players, var_c188cf87, undefined, 0, 750);
        a_e_players = array::filter(a_e_players, 0, &function_66c0d837, var_c188cf87, var_59ad3e22);
        if (a_e_players.size) {
            a_e_players[0] function_c99f4d81(var_c188cf87, var_59ad3e22);
        }
        wait 4;
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0x98156011, Offset: 0xc048
// Size: 0x10e
function function_c99f4d81(var_c188cf87, var_59ad3e22) {
    self endon(#"death", #"disconnect");
    b_first_loop = 1;
    while (function_66c0d837(self, var_c188cf87, var_59ad3e22)) {
        if (b_first_loop) {
            b_first_loop = 0;
            level.var_223d9df6 = self;
            n_clientfield_val = self getentitynumber() + 1;
            self clientfield::set("" + #"hash_222c3403d2641ea6", n_clientfield_val);
        }
        wait 1;
    }
    self clientfield::set("" + #"hash_222c3403d2641ea6", 0);
    level.var_223d9df6 = undefined;
}

// Namespace zm_perks/zm_perks
// Params 3, eflags: 0x1 linked
// Checksum 0x6137dc90, Offset: 0xc160
// Size: 0xec
function function_66c0d837(e_player, var_c188cf87, var_59ad3e22) {
    if (zm_utility::is_player_valid(e_player) && distancesquared(e_player.origin, var_c188cf87) < 562500 && abs(e_player.origin[2] - var_c188cf87[2]) < 85 && vectordot(vectornormalize(e_player.origin - var_c188cf87), anglestoforward(var_59ad3e22)) > 0) {
        return true;
    }
    return false;
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0x8c99051a, Offset: 0xc258
// Size: 0xb4
function function_df87281a(var_16c042b8, b_extra = 0) {
    if (b_extra) {
        self function_a7ae070c(var_16c042b8);
    } else {
        self.var_c27f1e90[4] = var_16c042b8;
        self function_9bdf581f(var_16c042b8, 4);
        self function_b8c12b0f(3, 1);
    }
    self function_4d342a8f();
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0x4e4a4952, Offset: 0xc318
// Size: 0x44
function function_4d342a8f() {
    if (!self hasperk(#"hash_5930cf0eb070e35a")) {
        perks::perk_setperk(#"hash_5930cf0eb070e35a");
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0xc5ef6be4, Offset: 0xc368
// Size: 0x44
function function_528f82a9() {
    if (self hasperk(#"hash_5930cf0eb070e35a")) {
        perks::perk_unsetperk(#"hash_5930cf0eb070e35a");
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x0
// Checksum 0xd4fdd3aa, Offset: 0xc3b8
// Size: 0x2a
function function_c709e667(str_name) {
    return isinarray(level.var_5355c665, str_name);
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0xc7fcabc1, Offset: 0xc3f0
// Size: 0xb4
function function_b4c0e0ee(n_bleedout_time) {
    self endon(#"player_revived", #"disconnect", #"bled_out");
    level endon(#"round_reset");
    self thread function_d3b5e743();
    if (is_true(self.var_39c78617)) {
        return;
    }
    n_wait = (n_bleedout_time - 0.1) / 4;
    self function_28ac0614(n_wait);
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x1 linked
// Checksum 0x27a44fb8, Offset: 0xc4b0
// Size: 0x6c
function function_d3b5e743() {
    self endon(#"player_revived", #"disconnect");
    level endon(#"round_reset");
    self waittill(#"bled_out");
    self function_28ac0614(undefined, 1);
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0xde50107c, Offset: 0xc528
// Size: 0x344
function function_28ac0614(var_bbb2c705, var_613b7621 = 0) {
    if (isdefined(self.var_cd5d9345)) {
        var_cd5d9345 = arraycopy(self.var_cd5d9345);
    } else {
        var_cd5d9345 = [];
    }
    var_cd0340f4 = isdefined(var_bbb2c705) && zombie_utility::function_d2dfacfd("perks_decay") && zm_custom::function_901b751c(#"zmperkdecay") == 1;
    if (var_cd0340f4) {
        self function_dc10fc94(var_cd5d9345, var_bbb2c705);
        foreach (var_d105825e in var_cd5d9345) {
            if (self namespace_791d0451::function_56cedda7(var_d105825e)) {
                if (var_d105825e == #"hash_504b3df717f88c4e") {
                    self.var_5f465b1 = 1;
                }
                self namespace_791d0451::function_4c1d0e25(var_d105825e);
            }
            if (zm_trial_disable_perks::is_active()) {
                b_wait = self zm_trial_disable_perks::lose_perk(var_d105825e);
            } else {
                self notify(var_d105825e + "_stop", {#var_613b7621:var_613b7621});
                b_wait = 1;
            }
            if (b_wait && !is_true(self.var_39c78617)) {
                self waittilltimeout(var_bbb2c705, #"instakill_player");
            }
        }
        return;
    }
    if (level.enable_magic && is_true(zm_custom::function_901b751c(#"zmperksactive"))) {
        for (i = 3; i >= 0; i--) {
            if (zm_trial_disable_perks::is_active()) {
                self zm_trial_disable_perks::lose_perk(self.var_c27f1e90[i]);
                continue;
            }
            if (isinarray(self.var_466b927f, self.var_c27f1e90[i])) {
                self notify(self.var_c27f1e90[i] + "_stop", {#var_613b7621:var_613b7621});
            }
        }
    }
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x5 linked
// Checksum 0xce3854d, Offset: 0xc878
// Size: 0x21c
function private function_dc10fc94(var_cd5d9345, var_bbb2c705) {
    var_8b77bf0c = arraycopy(var_cd5d9345);
    var_c25e1f9c = array(0, 1, 2, 3);
    var_b0696a17 = [];
    if (var_8b77bf0c.size <= 1) {
        for (n_slot = 0; n_slot < 4; n_slot++) {
        }
        var_b0696a17 = array::reverse(var_c25e1f9c);
    } else {
        arrayremoveindex(var_8b77bf0c, 0);
        for (n_slot = 3; n_slot >= 0; n_slot--) {
            if (var_8b77bf0c.size) {
                var_224c0c9c = function_c1efcc57(var_8b77bf0c[0]);
                arrayremoveindex(var_8b77bf0c, 0);
                arrayremovevalue(var_c25e1f9c, var_224c0c9c);
                if (var_224c0c9c >= 0 && var_224c0c9c < 4) {
                }
            }
            if (!isdefined(var_224c0c9c)) {
                var_224c0c9c = var_c25e1f9c[0];
                arrayremoveindex(var_c25e1f9c, 0);
            }
            if (var_224c0c9c >= 0 && var_224c0c9c < 4) {
                if (!isdefined(var_b0696a17)) {
                    var_b0696a17 = [];
                } else if (!isarray(var_b0696a17)) {
                    var_b0696a17 = array(var_b0696a17);
                }
                var_b0696a17[var_b0696a17.size] = var_224c0c9c;
            }
            var_224c0c9c = undefined;
        }
    }
    self thread set_bleedout_progress(var_bbb2c705, var_b0696a17);
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x5 linked
// Checksum 0x7fd40281, Offset: 0xcaa0
// Size: 0x134
function private set_bleedout_progress(var_bbb2c705, *var_b0696a17) {
    self endon(#"player_revived", #"zombified", #"disconnect");
    level endon(#"end_game", #"round_reset");
    if (var_b0696a17 == 0) {
        var_b0696a17 = 0.001;
    }
    var_73db1c5d = 0;
    n_time_elapsed = 0;
    while (var_73db1c5d < 4) {
        n_perc = math::clamp(n_time_elapsed / var_b0696a17, 0, 1);
        var_78835e6 = 1 * (n_perc + var_73db1c5d) / 4;
        if (n_perc == 1) {
            n_time_elapsed = 0;
            var_73db1c5d++;
        }
        n_time_elapsed += 0.05;
        wait 0.05;
    }
}

// Namespace zm_perks/zm_perks
// Params 0, eflags: 0x0
// Checksum 0xac4bd4c, Offset: 0xcbe0
// Size: 0x1a4
function function_2babacc2() {
    var_8cf447e1 = [];
    foreach (var_16c042b8 in self.var_774e0ad7) {
        n_slot = function_c1efcc57(var_16c042b8);
        if (n_slot >= 0) {
            self function_9bdf581f(var_16c042b8, n_slot, 0);
            if (!isdefined(var_8cf447e1)) {
                var_8cf447e1 = [];
            } else if (!isarray(var_8cf447e1)) {
                var_8cf447e1 = array(var_8cf447e1);
            }
            var_8cf447e1[var_8cf447e1.size] = n_slot;
        }
    }
    for (i = 0; i < 4; i++) {
        if (isinarray(var_8cf447e1, i) && !self.var_47654123[i]) {
            n_state = 6;
        } else {
            n_state = 0;
        }
        self function_fb633f9d(i, n_state);
    }
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0x4e24cc4c, Offset: 0xcd90
// Size: 0x2e
function function_e56d8ef4(str_perk_name) {
    if (isinarray(self.var_774e0ad7, str_perk_name)) {
        return true;
    }
    return false;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x5 linked
// Checksum 0x41786638, Offset: 0xcdc8
// Size: 0x2e
function private function_d1cad55c(var_16c042b8) {
    if (function_e56d8ef4(var_16c042b8)) {
        return true;
    }
    return false;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0x57e385da, Offset: 0xce00
// Size: 0x88
function register_lost_perk_override(func_override) {
    if (!isdefined(level.var_91ac8112)) {
        level.var_91ac8112 = [];
    } else if (!isarray(level.var_91ac8112)) {
        level.var_91ac8112 = array(level.var_91ac8112);
    }
    level.var_91ac8112[level.var_91ac8112.size] = func_override;
}

// Namespace zm_perks/zm_perks
// Params 1, eflags: 0x1 linked
// Checksum 0xf3da4fe9, Offset: 0xce90
// Size: 0xb4
function lost_perk_override(perk) {
    if (!self laststand::player_is_in_laststand()) {
        return false;
    }
    foreach (var_a4dddafc in level.var_91ac8112) {
        if (self [[ var_a4dddafc ]](perk)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x0
// Checksum 0x4b2bfe64, Offset: 0xcf50
// Size: 0x2a4
function function_b2dfd295(perk, var_8c7df7fc) {
    str_endon = "return_perk_on_revive_" + perk;
    self notify(str_endon);
    self endon(str_endon, #"disconnect", #"bled_out");
    if (!isdefined(self.var_1898de24)) {
        self.var_1898de24 = [];
    } else if (!isarray(self.var_1898de24)) {
        self.var_1898de24 = array(self.var_1898de24);
    }
    if (!isinarray(self.var_1898de24, var_8c7df7fc)) {
        self.var_1898de24[self.var_1898de24.size] = var_8c7df7fc;
    }
    for (x = 0; x < self.var_c27f1e90.size; x++) {
        if (self.var_c27f1e90[x] == perk) {
            var_c3f41835 = x;
        }
    }
    if (var_c3f41835 === 4) {
        return;
    }
    waitresult = self waittill(#"player_revived");
    e_reviver = waitresult.reviver;
    var_84280a99 = waitresult.var_a4916eac;
    foreach (var_8c7df7fc in self.var_1898de24) {
        if (self [[ var_8c7df7fc ]](e_reviver, var_84280a99)) {
            var_54b72e0c = 1;
            break;
        }
    }
    if (!is_true(var_54b72e0c)) {
        return;
    }
    waitframe(1);
    if (isdefined(var_c3f41835)) {
        if (self.var_47654123[var_c3f41835]) {
            self thread function_f9385a02(perk, var_c3f41835);
        }
        self thread function_9bdf581f(perk, var_c3f41835);
        return;
    }
    self thread function_a7ae070c(perk);
}

// Namespace zm_perks/zm_perks
// Params 2, eflags: 0x1 linked
// Checksum 0x418ffeb8, Offset: 0xd200
// Size: 0x40
function register_actor_damage_override(str_perk, actor_damage_override_func) {
    if (!isdefined(level.var_f5021cbd)) {
        level.var_f5021cbd = [];
    }
    level.var_f5021cbd[str_perk] = actor_damage_override_func;
}

// Namespace zm_perks/zm_perks
// Params 12, eflags: 0x1 linked
// Checksum 0x1f1fe76, Offset: 0xd248
// Size: 0x300
function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (isplayer(attacker)) {
        if (isarray(attacker.var_466b927f)) {
            foreach (str_perk in attacker.var_466b927f) {
                if (isdefined(level.var_f5021cbd[str_perk])) {
                    damage = [[ level.var_f5021cbd[str_perk] ]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
                }
            }
        }
        if (isarray(attacker.var_67ba1237)) {
            foreach (str_perk in attacker.var_67ba1237) {
                if (isdefined(level.var_f5021cbd[str_perk])) {
                    damage = [[ level.var_f5021cbd[str_perk] ]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
                }
            }
        }
        if (isarray(attacker.var_7341f980)) {
            foreach (str_perk in attacker.var_7341f980) {
                var_83490188 = namespace_e86ffa8::function_cde018a9(str_perk);
                if (isdefined(level.var_f5021cbd[var_83490188])) {
                    damage = [[ level.var_f5021cbd[var_83490188] ]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
                }
            }
        }
    }
    return damage;
}

/#

    // Namespace zm_perks/zm_perks
    // Params 0, eflags: 0x0
    // Checksum 0x87bca9ef, Offset: 0xd550
    // Size: 0xa7c
    function function_756e6a6d() {
        ip1 = self getentitynumber() + 1;
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:xac5>" + ip1 + "<dev string:xb07>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:xb22>" + ip1 + "<dev string:xb64>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:xb7e>" + ip1 + "<dev string:xbc7>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:xbe9>" + ip1 + "<dev string:xc2c>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:xc48>" + ip1 + "<dev string:xc90>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:xcb0>" + ip1 + "<dev string:xcf7>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:xd17>" + ip1 + "<dev string:xd59>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:xd73>" + ip1 + "<dev string:xdb8>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:xdd5>" + ip1 + "<dev string:xe1a>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:xe38>" + ip1 + "<dev string:xe77>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:xe8f>" + ip1 + "<dev string:xed0>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:xeea>" + ip1 + "<dev string:xf2d>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:xf49>" + ip1 + "<dev string:xf8a>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:xfa4>" + ip1 + "<dev string:xff0>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x100a>" + ip1 + "<dev string:x104e>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x106a>" + ip1 + "<dev string:x10b1>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x10d1>" + ip1 + "<dev string:x1113>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x112e>" + ip1 + "<dev string:x1164>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x117c>" + ip1 + "<dev string:x11b2>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x11ca>" + ip1 + "<dev string:x1200>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x1218>" + ip1 + "<dev string:x124e>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x1266>" + ip1 + "<dev string:x129e>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x12b4>" + ip1 + "<dev string:x12ea>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x1302>" + ip1 + "<dev string:x1338>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x1350>" + ip1 + "<dev string:x1386>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x139e>" + ip1 + "<dev string:x13d4>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x13ec>" + ip1 + "<dev string:x1424>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x143a>" + ip1 + "<dev string:x147a>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x149c>" + ip1 + "<dev string:x14dc>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x14fe>" + ip1 + "<dev string:x153e>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x1560>" + ip1 + "<dev string:x15a0>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x15c2>" + ip1 + "<dev string:x1604>");
        adddebugcommand("<dev string:xaa4>" + self.name + "<dev string:xabe>" + ip1 + "<dev string:x1624>" + ip1 + "<dev string:x165c>");
    }

    // Namespace zm_perks/zm_perks
    // Params 0, eflags: 0x0
    // Checksum 0x11876ac2, Offset: 0xdfd8
    // Size: 0x15c0
    function function_545a79c() {
        level notify(#"zombie_vapor_devgui");
        level endon(#"zombie_vapor_devgui");
        for (;;) {
            cmd = getdvarstring(#"zombie_vapor_devgui");
            str_perk = undefined;
            var_eb4c64e8 = undefined;
            var_f79903dc = undefined;
            var_4ee327af = undefined;
            var_dfa7102 = undefined;
            var_8d1a1acc = undefined;
            var_b1cb5669 = undefined;
            var_c4819a86 = undefined;
            switch (cmd) {
            case #"hash_47e87df26f2bb654":
            case #"hash_a687f7ed9396339":
            case #"hash_714bd7d5b19367cb":
            case #"hash_2b731e891eadd00a":
                str_perk = #"specialty_shield";
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_2c6e9bd17e4c70e5":
            case #"hash_22db822f8cebba1f":
            case #"hash_3547aac06cbbd656":
            case #"hash_1fc0acc0b9c31200":
                str_perk = #"specialty_berserker";
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_72cd05a9f7096d18":
            case #"hash_696b25a08319319f":
            case #"hash_5fdbbc96a07023ea":
            case #"hash_59dfac7d036a7f11":
                str_perk = #"specialty_awareness";
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_20e1f2a12f575ad":
            case #"hash_37f041c2ceccaa32":
            case #"hash_1067d35a903aa090":
            case #"hash_60a8ca620122ce03":
                str_perk = #"specialty_camper";
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_4d8a429ced485336":
            case #"hash_451695d8096ae1b8":
            case #"hash_4e334d102e76aa39":
            case #"hash_3797acd439d9338b":
                str_perk = #"specialty_mystery";
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_582c07780b2a70d7":
            case #"hash_460157accd31661c":
            case #"hash_7a8b3d3703b1d56e":
            case #"hash_2ad319babe68ddd9":
                str_perk = #"specialty_phdflopper";
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_7237eda7099e624d":
            case #"hash_7b790d5f36b4c12":
            case #"hash_b5286c82d1f26c3":
            case #"hash_3fe4509a2ac36a60":
                str_perk = #"specialty_cooldown";
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_1e0b58a0910c3247":
            case #"hash_52f021b5af5b6f01":
            case #"hash_17377d35be324020":
            case #"hash_4d0551e8fc1a3eaa":
                str_perk = #"specialty_additionalprimaryweapon";
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_215605bc01af2e0":
            case #"hash_272741eeae13ac9a":
            case #"hash_3c2392a146da0ca1":
            case #"hash_77c9ba94611f14a7":
                str_perk = #"hash_210097a75bb6c49a";
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_6650c5a8596d4707":
            case #"hash_4b97c729fbbb68e5":
            case #"hash_2ad8c584d069c098":
            case #"hash_12b3c2d6eb971006":
                str_perk = #"hash_602a1b6107105f07";
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_591f1871abf8a417":
            case #"hash_77bfaaec70d8daa":
            case #"hash_1f2e309303a233e8":
            case #"hash_30bfdad9100956cd":
                str_perk = #"hash_7f98b3dd3cce95aa";
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_2b9b74bc8b7a95b9":
            case #"hash_4dd9c0937255fe1a":
            case #"hash_338cf8868ad12888":
            case #"hash_3985b954c5d57fd7":
                str_perk = #"specialty_electriccherry";
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_3e92ee8a1f94e218":
            case #"hash_400b86629283f29f":
            case #"hash_73cbb686dc065831":
            case #"hash_6bc1e0d615f04132":
                str_perk = #"specialty_widowswine";
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_74a3737c1fa820fa":
            case #"hash_5cebc01e01fc9e18":
            case #"hash_3419add8481e7fa1":
            case #"hash_4d21953ef7610b73":
                str_perk = #"specialty_extraammo";
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_4c6b49a740457f87":
            case #"hash_572d09f7e8a7b929":
            case #"hash_5d8694f5297752a4":
            case #"hash_31f8545325031336":
                str_perk = #"specialty_etherealrazor";
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_5ffd9216593e9fb":
            case #"hash_6e080192e412f0e6":
            case #"hash_23b50d4339535dd5":
            case #"hash_6e7de8150825b688":
                str_perk = #"specialty_zombshell";
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_42ed16109e9963d6":
            case #"hash_7a33b4202b9ebdc8":
            case #"hash_3eb60ad87ca70645":
            case #"hash_2bc2dabec1637ab7":
                str_perk = #"specialty_wolf_protector";
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_36d28b98c683b0ed":
            case #"hash_2621dbc67d96d6b6":
            case #"hash_122b73a9059c70bc":
            case #"hash_796b16a6e51d3223":
                var_f79903dc = 0;
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_2621dac67d96d503":
            case #"hash_122b76a9059c75d5":
            case #"hash_36d28898c683abd4":
            case #"hash_796b17a6e51d33d6":
                var_f79903dc = 1;
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_122b75a9059c7422":
            case #"hash_36d28998c683ad87":
            case #"hash_2621d9c67d96d350":
            case #"hash_796b18a6e51d3589":
                var_f79903dc = 2;
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_36d28698c683a86e":
            case #"hash_122b70a9059c6ba3":
            case #"hash_2621e0c67d96df35":
            case #"hash_796b19a6e51d373c":
                var_f79903dc = 3;
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_63368be670c1631":
            case #"hash_4e75f62ab878637a":
            case #"hash_2227c4347bf7aff7":
            case #"hash_56baf79467fa8098":
                var_f79903dc = 4;
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_2a94a682beedaf35":
            case #"hash_5c050766529e83a8":
            case #"hash_4205942f3e57758a":
            case #"hash_75d5e1ee4bb9b063":
                var_4ee327af = 0;
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_2a94a382beedaa1c":
            case #"hash_4205932f3e5773d7":
            case #"hash_75d5e2ee4bb9b216":
            case #"hash_5c050a66529e88c1":
                var_4ee327af = 1;
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_75d5e3ee4bb9b3c9":
            case #"hash_5c050966529e870e":
            case #"hash_4205922f3e577224":
            case #"hash_2a94a482beedabcf":
                var_4ee327af = 2;
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_5c050c66529e8c27":
            case #"hash_75d5e4ee4bb9b57c":
            case #"hash_2a94a182beeda6b6":
            case #"hash_4205912f3e577071":
                var_4ee327af = 3;
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_20102f0482e5bdb9":
            case #"hash_5a852048c409f6b7":
            case #"hash_19d7dd5f676b170c":
            case #"hash_e3aea524ee28666":
                var_4ee327af = 4;
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_21a07f54e2de98fe":
            case #"hash_6fa3e37013c04980":
            case #"hash_57ed1fb7940f33b5":
            case #"hash_37e9f4522a62290f":
                var_dfa7102 = 0;
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_21a07e54e2de974b":
            case #"hash_57ed1cb7940f2e9c":
            case #"hash_6fa3e67013c04e99":
            case #"hash_37e9f5522a622ac2":
                var_dfa7102 = 1;
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_21a07d54e2de9598":
            case #"hash_6fa3e57013c04ce6":
            case #"hash_57ed1db7940f304f":
            case #"hash_37e9f6522a622c75":
                var_dfa7102 = 2;
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_57ed1ab7940f2b36":
            case #"hash_37e9ef522a622090":
            case #"hash_21a08454e2dea17d":
            case #"hash_6fa3e87013c051ff":
                var_dfa7102 = 3;
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_11bcb93b01611b04":
            case #"hash_78960bd8157b64e2":
            case #"hash_58bb5da598842e39":
            case #"hash_79a3bb05585eb7fb":
                var_dfa7102 = 4;
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case #"hash_5eee967ea5d92169":
            case #"hash_1f66bfabd16987cb":
            case #"hash_560a015fd8fc8f56":
            case #"hash_4a38f3e91e628364":
                var_c4819a86 = 1;
                var_8d1a1acc = strtok(cmd, "<dev string:x1673>");
                var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
                break;
            case 0:
                break;
            }
            if (isdefined(var_eb4c64e8)) {
                foreach (player in level.players) {
                    if (isdefined(player)) {
                        if (var_eb4c64e8 == player getentitynumber()) {
                            var_b1cb5669 = player;
                            break;
                        }
                    }
                }
            }
            if (isdefined(var_b1cb5669)) {
                if (isdefined(str_perk)) {
                    var_b1cb5669 function_36710277(str_perk);
                } else if (isdefined(var_f79903dc)) {
                    var_b1cb5669 function_869a50c0(var_f79903dc);
                } else if (isdefined(var_4ee327af)) {
                    var_b1cb5669 function_413a7dd7(var_4ee327af);
                } else if (isdefined(var_dfa7102)) {
                    var_b1cb5669 function_a18c6089(var_dfa7102);
                } else if (is_true(var_c4819a86)) {
                    var_b1cb5669 function_b2cba45a();
                }
            }
            setdvar(#"zombie_vapor_devgui", "<dev string:x1678>");
            wait 0.5;
        }
    }

    // Namespace zm_perks/zm_perks
    // Params 1, eflags: 0x0
    // Checksum 0xb7c8d9a2, Offset: 0xf5a0
    // Size: 0x146
    function function_36710277(var_16c042b8) {
        if (self.var_466b927f.size >= 4) {
            iprintlnbold("<dev string:x167c>");
            return;
        }
        if (isinarray(self.var_c27f1e90, var_16c042b8)) {
            iprintlnbold("<dev string:x1695>");
            return;
        }
        for (i = 0; i < 4; i++) {
            if (!isinarray(self.var_466b927f, self.var_c27f1e90[i])) {
                self thread function_81bc6765(i, level._custom_perks[var_16c042b8].alias);
                self.var_c27f1e90[i] = var_16c042b8;
                if (i == 3) {
                    self.var_c27f1e90[4] = level.var_5355c665[var_16c042b8];
                }
                self function_29387491(var_16c042b8, i);
                return;
            }
        }
    }

    // Namespace zm_perks/zm_perks
    // Params 1, eflags: 0x0
    // Checksum 0x69bc3049, Offset: 0xf6f0
    // Size: 0x9c
    function function_869a50c0(n_slot) {
        if (n_slot < 4) {
            var_16c042b8 = self.var_c27f1e90[n_slot];
            if (isinarray(self.var_466b927f, var_16c042b8)) {
                iprintlnbold("<dev string:x16b8>");
                return;
            }
            self function_29387491(var_16c042b8, n_slot);
            return;
        }
        self function_cc24f525();
    }

    // Namespace zm_perks/zm_perks
    // Params 1, eflags: 0x0
    // Checksum 0xe84fd15d, Offset: 0xf798
    // Size: 0x138
    function function_413a7dd7(n_slot) {
        if (n_slot < 4) {
            var_16c042b8 = self.var_c27f1e90[n_slot];
            if (!isinarray(self.var_466b927f, var_16c042b8)) {
                iprintlnbold("<dev string:x16d7>");
                return;
            }
            self notify(var_16c042b8 + "<dev string:x16ef>", {#var_613b7621:1});
            return;
        }
        foreach (var_16c042b8 in self.var_c27f1e90) {
            if (isinarray(self.var_466b927f, var_16c042b8)) {
                self notify(var_16c042b8 + "<dev string:x16ef>", {#var_613b7621:1});
            }
        }
    }

    // Namespace zm_perks/zm_perks
    // Params 1, eflags: 0x0
    // Checksum 0x8d8ffaef, Offset: 0xf8d8
    // Size: 0x74
    function function_a18c6089(n_slot) {
        if (n_slot < 4) {
            self function_9b641809(n_slot);
            return;
        }
        for (i = 0; i < 4; i++) {
            self function_9b641809(i);
        }
    }

#/
