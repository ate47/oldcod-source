#using script_39eae6a6b493fe9e;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace zm_score;

// Namespace zm_score/zm_score
// Params 0, eflags: 0x2
// Checksum 0x8007ea29, Offset: 0x240
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_score", &__init__, undefined, undefined);
}

// Namespace zm_score/zm_score
// Params 0, eflags: 0x0
// Checksum 0x2c58ec55, Offset: 0x288
// Size: 0x1c2
function __init__() {
    level.var_bdf38bf2 = array(70, 60, 50, 40, 30, 20, 10);
    foreach (subdivision in level.var_bdf38bf2) {
        score_cf_register_info("damage" + subdivision, 1, 7);
    }
    score_cf_register_info("death_head", 1, 3);
    score_cf_register_info("death_melee", 1, 3);
    score_cf_register_info("transform_kill", 1, 3);
    clientfield::register("clientuimodel", "hudItems.doublePointsActive", 1, 1, "int");
    callback::on_spawned(&player_on_spawned);
    level callback::on_ai_killed(&function_f2ac4792);
    level.score_total = 0;
    level.a_func_score_events = [];
    level.var_746251cb = [];
}

// Namespace zm_score/zm_score
// Params 2, eflags: 0x0
// Checksum 0xe89d50b9, Offset: 0x458
// Size: 0x2a
function register_score_event(str_event, func_callback) {
    level.a_func_score_events[str_event] = func_callback;
}

// Namespace zm_score/zm_score
// Params 2, eflags: 0x0
// Checksum 0x59d5e747, Offset: 0x490
// Size: 0x2a
function function_c723805e(str_archetype, n_score) {
    level.var_746251cb[str_archetype] = n_score;
}

// Namespace zm_score/zm_score
// Params 1, eflags: 0x0
// Checksum 0x66a61b16, Offset: 0x4c8
// Size: 0x40
function function_7636d211(str_archetype) {
    if (isdefined(str_archetype) && isdefined(level.var_746251cb[str_archetype])) {
        return level.var_746251cb[str_archetype];
    }
    return 0;
}

// Namespace zm_score/zm_score
// Params 1, eflags: 0x0
// Checksum 0xdcb6c209, Offset: 0x510
// Size: 0x64
function function_f2ac4792(s_params) {
    if (isdefined(self.score_event) && isplayer(s_params.eattacker)) {
        scoreevents::processscoreevent(self.score_event, s_params.eattacker, undefined, s_params.weapon);
    }
}

// Namespace zm_score/zm_score
// Params 0, eflags: 0x0
// Checksum 0x2aab19d9, Offset: 0x580
// Size: 0x2c
function reset_doublexp_timer() {
    self notify(#"reset_doublexp_timer");
    self thread doublexp_timer();
}

// Namespace zm_score/zm_score
// Params 0, eflags: 0x0
// Checksum 0xd4a8e7d8, Offset: 0x5b8
// Size: 0xbc
function doublexp_timer() {
    self notify(#"doublexp_timer");
    self endon(#"doublexp_timer");
    self endon(#"reset_doublexp_timer");
    self endon(#"end_game");
    level flagsys::wait_till("start_zombie_round_logic");
    if (!level.onlinegame) {
        return;
    }
    wait 60;
    if (level.onlinegame) {
        if (!isdefined(self)) {
            return;
        }
        self doublexptimerfired();
    }
    self thread reset_doublexp_timer();
}

// Namespace zm_score/zm_score
// Params 0, eflags: 0x0
// Checksum 0x6756e0aa, Offset: 0x680
// Size: 0x42
function player_on_spawned() {
    util::wait_network_frame();
    self thread doublexp_timer();
    if (isdefined(self)) {
        self.ready_for_score_events = 1;
    }
}

// Namespace zm_score/zm_score
// Params 3, eflags: 0x0
// Checksum 0xd5b55db5, Offset: 0x6d0
// Size: 0x96
function score_cf_register_info(name, version, max_count) {
    for (i = 0; i < 4; i++) {
        clientfield::register("worlduimodel", "PlayerList.client" + i + ".score_cf_" + name, version, getminbitcountfornum(max_count), "counter");
    }
}

// Namespace zm_score/zm_score
// Params 2, eflags: 0x0
// Checksum 0x7beb159, Offset: 0x770
// Size: 0x5c
function score_cf_increment_info(name, var_16251bf0 = 0) {
    if (!var_16251bf0) {
        clientfield::increment_world_uimodel("PlayerList.client" + self.entity_num + ".score_cf_" + name);
    }
}

// Namespace zm_score/zm_score
// Params 8, eflags: 0x0
// Checksum 0xe6192856, Offset: 0x7d8
// Size: 0x728
function player_add_points(event, mod, hit_location, e_target, zombie_team, damage_weapon, var_410273f6, var_ee8f9d0 = 0) {
    if (level.intermission || isdefined(level.var_430873e5) && level.var_430873e5) {
        return;
    }
    if (!zm_utility::is_player_valid(self, 0, var_410273f6)) {
        return;
    }
    player_points = 0;
    multiplier = get_points_multiplier(self);
    if (isdefined(level.a_func_score_events[event])) {
        player_points = [[ level.a_func_score_events[event] ]](event, mod, hit_location, zombie_team, damage_weapon);
    } else {
        switch (event) {
        case #"rebuild_board":
        case #"carpenter_powerup":
        case #"nuke_powerup":
        case #"reviver":
        case #"bonus_points_powerup":
            player_points = mod;
            break;
        case #"bonus_points_powerup_shared":
            player_points = mod;
            multiplier = 1;
            break;
        case #"damage_points":
            switch (mod) {
            case 10:
            case 20:
            case 30:
            case 40:
            case 50:
            case 60:
            case 70:
            case 80:
            case 90:
            case 100:
            case 110:
            case 120:
            case 130:
            case 140:
            case 150:
            case 160:
            case 170:
            case 180:
            case 190:
            case 200:
                player_points = mod;
                if (mod > 70) {
                    self score_cf_increment_info("damage" + 70, var_ee8f9d0);
                } else {
                    self score_cf_increment_info("damage" + mod, var_ee8f9d0);
                }
                break;
            }
            break;
        case #"death":
            player_points = e_target.var_b7fcaf8e;
            if (!isdefined(player_points)) {
                player_points = 0;
            }
            var_4d9505ab = player_points;
            var_2f288385 = 0;
            while (var_4d9505ab > 0) {
                while (var_4d9505ab < level.var_bdf38bf2[var_2f288385] && var_2f288385 < level.var_bdf38bf2.size) {
                    var_2f288385++;
                }
                if (var_2f288385 == level.var_bdf38bf2.size) {
                    break;
                }
                var_4d9505ab -= level.var_bdf38bf2[var_2f288385];
                self score_cf_increment_info("damage" + level.var_bdf38bf2[var_2f288385], var_ee8f9d0);
            }
            player_points = self player_add_points_kill_bonus(mod, hit_location, damage_weapon, player_points);
            if (mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH") {
                self zm_stats::increment_client_stat("grenade_kills");
                self zm_stats::increment_player_stat("grenade_kills");
            }
            break;
        case #"riotshield_fling":
            player_points = mod;
            if (!var_ee8f9d0) {
                scoreevents::processscoreevent("kill", self, undefined, damage_weapon);
            }
            break;
        case #"transform_kill":
            self score_cf_increment_info("transform_kill", var_ee8f9d0);
            if (!var_ee8f9d0) {
                scoreevents::processscoreevent("transform_kill", self, undefined, damage_weapon);
            }
            player_points = zombie_utility::get_zombie_var(#"hash_68aa9b4c8de33261");
            break;
        default:
            assert(0, "<dev string:x30>");
            break;
        }
    }
    if (isdefined(level.player_score_override)) {
        player_points = self [[ level.player_score_override ]](damage_weapon, player_points);
    }
    player_points = multiplier * zm_utility::round_up_score(player_points, 10);
    if (isdefined(self.point_split_receiver) && (event == "death" || event == "ballistic_knife_death")) {
        split_player_points = player_points - zm_utility::round_up_score(player_points * self.point_split_keep_percent, 10);
        self.point_split_receiver add_to_player_score(split_player_points);
        player_points -= split_player_points;
    }
    self add_to_player_score(player_points, 1, event, var_ee8f9d0);
    if (var_ee8f9d0) {
        return;
    }
    self.pers[#"score"] = self.score;
    if (isdefined(level._game_module_point_adjustment)) {
        level [[ level._game_module_point_adjustment ]](self, zombie_team, player_points);
    }
}

// Namespace zm_score/zm_score
// Params 1, eflags: 0x0
// Checksum 0x33b98caa, Offset: 0xf08
// Size: 0xf2
function get_points_multiplier(player) {
    multiplier = isdefined(player zombie_utility::get_zombie_var_player(#"zombie_point_scalar")) ? player zombie_utility::get_zombie_var_player(#"zombie_point_scalar") : zombie_utility::get_zombie_var_team(#"zombie_point_scalar", player.team);
    if (isdefined(level.current_game_module) && level.current_game_module == 2) {
        if (isdefined(level._race_team_double_points) && level._race_team_double_points == player._race_team) {
            return multiplier;
        } else {
            return 1;
        }
    }
    return multiplier;
}

// Namespace zm_score/zm_score
// Params 4, eflags: 0x0
// Checksum 0xe062b8a1, Offset: 0x1008
// Size: 0x246
function player_add_points_kill_bonus(mod, hit_location, weapon, player_points = undefined) {
    if (mod != "MOD_MELEE") {
        if ("head" == hit_location || "helmet" == hit_location || "neck" == hit_location) {
            scoreevents::processscoreevent("headshot", self, undefined, weapon);
        } else {
            scoreevents::processscoreevent("kill", self, undefined, weapon);
        }
    }
    if (isdefined(level.player_score_override)) {
        new_points = self [[ level.player_score_override ]](weapon, player_points);
        if (new_points > 0 && new_points != player_points) {
            return new_points;
        }
    }
    if (mod == "MOD_MELEE") {
        self score_cf_increment_info("death_melee");
        scoreevents::processscoreevent("melee_kill", self, undefined, weapon);
        return zombie_utility::get_zombie_var(#"zombie_score_bonus_melee");
    }
    if (isdefined(player_points)) {
        score = player_points;
    } else {
        score = 0;
    }
    if (isdefined(hit_location)) {
        switch (hit_location) {
        case #"head":
        case #"helmet":
        case #"neck":
            self score_cf_increment_info("death_head");
            score = zombie_utility::get_zombie_var(#"zombie_score_bonus_head");
            break;
        default:
            break;
        }
    }
    return score;
}

// Namespace zm_score/zm_score
// Params 2, eflags: 0x0
// Checksum 0x25802102, Offset: 0x1258
// Size: 0x41e
function player_reduce_points(event, n_amount) {
    if (level.intermission || zm_utility::is_standard()) {
        return;
    }
    points = 0;
    switch (event) {
    case #"take_all":
        points = self.score;
        break;
    case #"take_half":
        points = int(self.score / 2);
        break;
    case #"take_specified":
        points = n_amount;
        break;
    case #"no_revive_penalty":
        if (zm_custom::function_5638f689(#"zmpointlossonteammatedeath")) {
            percent = zm_custom::function_5638f689(#"zmpointlossonteammatedeath") / 100;
        } else {
            percent = zombie_utility::get_zombie_var(#"penalty_no_revive");
        }
        points = self.score * percent;
        break;
    case #"died":
        if (zm_custom::function_5638f689(#"zmpointlossondeath")) {
            percent = zm_custom::function_5638f689(#"zmpointlossondeath") / 100;
        } else {
            percent = zombie_utility::get_zombie_var(#"penalty_died");
        }
        points = self.score * percent;
        break;
    case #"downed":
        if (zm_custom::function_5638f689(#"zmpointlossondown")) {
            percent = zm_custom::function_5638f689(#"zmpointlossondown") / 100;
        } else {
            percent = zombie_utility::get_zombie_var(#"penalty_downed");
            step = zombie_utility::get_zombie_var(#"hash_3037a1f286b662e6");
            if (step > 0) {
                percent *= int(self.score / step);
            }
            if (percent > 0.5) {
                percent = 0.5;
            }
        }
        self notify(#"i_am_down");
        points = self.score * percent;
        self.score_lost_when_downed = zm_utility::round_up_to_ten(int(points));
        break;
    case #"points_lost_on_hit_percent":
        points = self.score * n_amount;
        break;
    case #"points_lost_on_hit_value":
        points = n_amount;
        break;
    default:
        assert(0, "<dev string:x30>");
        break;
    }
    points = self.score - zm_utility::round_up_to_ten(int(points));
    if (points < 0) {
        points = 0;
    }
    self.score = points;
}

// Namespace zm_score/zm_score
// Params 4, eflags: 0x0
// Checksum 0x2b672b08, Offset: 0x1680
// Size: 0x246
function add_to_player_score(points, b_add_to_total = 1, str_awarded_by = "", var_ee8f9d0 = 0) {
    if (!isdefined(points) || level.intermission || isdefined(level.var_430873e5) && level.var_430873e5) {
        return;
    }
    assert(isplayer(self), "<dev string:x44>");
    points = zm_utility::round_up_score(points, 10);
    n_points_to_add_to_currency = bgb::add_to_player_score_override(points, str_awarded_by);
    if (var_ee8f9d0) {
        level thread zm_hero_weapon::function_67f820d2(self, points, str_awarded_by);
        return;
    }
    self.score += n_points_to_add_to_currency;
    self.pers[#"score"] = self.score;
    self incrementplayerstat("scoreEarned", n_points_to_add_to_currency);
    level notify(#"earned_points", {#player:self, #points:points});
    level thread zm_hero_weapon::function_67f820d2(self, points, str_awarded_by);
    if (b_add_to_total) {
        self.score_total += points;
        level.score_total += points;
    }
    self notify(#"earned_points", {#n_points:points, #str_awarded_by:str_awarded_by});
}

// Namespace zm_score/zm_score
// Params 2, eflags: 0x0
// Checksum 0x61c837a2, Offset: 0x18d0
// Size: 0x194
function minus_to_player_score(points, b_forced = 0) {
    if (!isdefined(points) || level.intermission) {
        return;
    }
    if (self bgb::is_enabled(#"zm_bgb_shopping_free")) {
        self bgb::do_one_shot_use();
        self playsoundtoplayer(#"zmb_bgb_shoppingfree_coinreturn", self);
        return;
    }
    if (zm_utility::is_standard() && !b_forced) {
        return;
    }
    self.score -= points;
    self.pers[#"score"] = self.score;
    self incrementplayerstat("scoreSpent", points);
    level notify(#"spent_points", {#player:self, #points:points});
    if (isdefined(level.bgb_in_use) && level.bgb_in_use && level.onlinegame) {
        self namespace_ade8e118::function_51cf4361(points);
    }
}

// Namespace zm_score/zm_score
// Params 1, eflags: 0x0
// Checksum 0xa362e9eb, Offset: 0x1a70
// Size: 0xc
function add_to_team_score(points) {
    
}

// Namespace zm_score/zm_score
// Params 1, eflags: 0x0
// Checksum 0x9b4ffad2, Offset: 0x1a88
// Size: 0xc
function minus_to_team_score(points) {
    
}

// Namespace zm_score/zm_score
// Params 0, eflags: 0x0
// Checksum 0x4bdb7ba2, Offset: 0x1aa0
// Size: 0x9e
function player_died_penalty() {
    players = getplayers(self.team);
    for (i = 0; i < players.size; i++) {
        if (players[i] != self && !players[i].is_zombie) {
            players[i] player_reduce_points("no_revive_penalty");
        }
    }
}

// Namespace zm_score/zm_score
// Params 0, eflags: 0x0
// Checksum 0xf9e59248, Offset: 0x1b48
// Size: 0x44
function player_downed_penalty() {
    println("<dev string:x9a>");
    self player_reduce_points("downed");
}

// Namespace zm_score/zm_score
// Params 2, eflags: 0x0
// Checksum 0xcc8d7d26, Offset: 0x1b98
// Size: 0x8a
function can_player_purchase(n_cost, var_7fc5fadc = 0) {
    if (self.score >= n_cost) {
        return true;
    }
    if (self bgb::is_enabled(#"zm_bgb_shopping_free")) {
        return true;
    }
    if (zm_utility::is_standard() && !var_7fc5fadc) {
        return true;
    }
    return false;
}

// Namespace zm_score/zm_score
// Params 0, eflags: 0x0
// Checksum 0x89935834, Offset: 0x1c30
// Size: 0xde
function function_c4374c52() {
    if (isdefined(self.var_5f02c51)) {
        var_7112f711 = self.var_5f02c51;
    } else {
        var_7112f711 = function_7636d211(self.archetype);
        assert(var_7112f711, "<dev string:xc4>" + function_15979fa9(self.archetype) + "<dev string:xde>");
    }
    self.var_b7fcaf8e = var_7112f711;
    self.var_f7d44b6c = max(1, int(self.maxhealth / var_7112f711 * 0.1));
    self.var_8c3be92d = [];
}

// Namespace zm_score/zm_score
// Params 2, eflags: 0x0
// Checksum 0xd86a4b1e, Offset: 0x1d18
// Size: 0x1b6
function function_496b6fa3(e_attacker, n_damage) {
    if (!isplayer(e_attacker) || !isdefined(self.var_8c3be92d) || isdefined(self.marked_for_death) && self.marked_for_death) {
        return;
    }
    n_index = e_attacker.entity_num;
    if (!isdefined(self.var_8c3be92d[n_index])) {
        self.var_8c3be92d[n_index] = 0;
    }
    var_c4fb569a = self.var_8c3be92d[n_index];
    var_57523f2b = var_c4fb569a + n_damage;
    var_e6dc8f06 = int(var_c4fb569a / self.var_f7d44b6c);
    var_4aefcad7 = int(var_57523f2b / self.var_f7d44b6c);
    n_points = (var_4aefcad7 - var_e6dc8f06) * 10;
    if (n_points > self.var_b7fcaf8e) {
        n_points = self.var_b7fcaf8e;
    }
    if (n_points) {
        e_attacker player_add_points("damage_points", n_points, undefined, undefined, undefined, undefined, undefined, self.var_f7038080);
        self.var_b7fcaf8e -= n_points;
    }
    self.var_8c3be92d[n_index] = var_57523f2b;
}

// Namespace zm_score/zm_score
// Params 1, eflags: 0x0
// Checksum 0xb95e7d9b, Offset: 0x1ed8
// Size: 0x32
function function_96865aad(b_disabled = 1) {
    if (isdefined(self)) {
        self.var_f7038080 = b_disabled;
    }
}

// Namespace zm_score/zm_score
// Params 0, eflags: 0x0
// Checksum 0x635a4a8b, Offset: 0x1f18
// Size: 0x1c
function function_a8fa79c2() {
    return self.pers[#"score"];
}

// Namespace zm_score/zm_score
// Params 1, eflags: 0x0
// Checksum 0x4930ce71, Offset: 0x1f40
// Size: 0x32
function function_fb877e6e(score) {
    self.pers[#"score"] = score;
    self.score = score;
}

