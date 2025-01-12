#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\table_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\zm_common\gametypes\globallogic_score;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_daily_challenges;

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 0, eflags: 0x2
// Checksum 0xc0d95459, Offset: 0x4e8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_daily_challenges", &__init__, &__main__, undefined);
}

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 0, eflags: 0x0
// Checksum 0xd4923b39, Offset: 0x538
// Size: 0x84
function __init__() {
    callback::on_connect(&on_connect);
    callback::on_spawned(&on_spawned);
    callback::on_challenge_complete(&on_challenge_complete);
    zm_spawner::register_zombie_death_event_callback(&death_check_for_challenge_updates);
}

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 0, eflags: 0x0
// Checksum 0xdf59b975, Offset: 0x5c8
// Size: 0x34
function __main__() {
    level thread spent_points_tracking();
    level thread earned_points_tracking();
}

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 0, eflags: 0x0
// Checksum 0xd038f18d, Offset: 0x608
// Size: 0xa2
function on_connect() {
    self thread round_tracking();
    self thread perk_purchase_tracking();
    self thread perk_drink_tracking();
    self.a_daily_challenges = [];
    self.a_daily_challenges[0] = 0;
    self.a_daily_challenges[1] = 0;
    self.a_daily_challenges[2] = 0;
    self.a_daily_challenges[3] = 0;
}

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 0, eflags: 0x0
// Checksum 0xeb022f8e, Offset: 0x6b8
// Size: 0x1c
function on_spawned() {
    self thread challenge_ingame_time_tracking();
}

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 0, eflags: 0x0
// Checksum 0x88dbed32, Offset: 0x6e0
// Size: 0x1f6
function round_tracking() {
    self endon(#"disconnect");
    while (true) {
        level waittill(#"end_of_round");
        self.a_daily_challenges[3]++;
        switch (self.a_daily_challenges[3]) {
        case 10:
            self zm_stats::increment_challenge_stat("ZM_DAILY_ROUND_10");
            /#
                debug_print("<dev string:x30>");
            #/
            break;
        case 15:
            self zm_stats::increment_challenge_stat("ZM_DAILY_ROUND_15");
            /#
                debug_print("<dev string:x4d>");
            #/
            break;
        case 20:
            self zm_stats::increment_challenge_stat("ZM_DAILY_ROUND_20");
            /#
                debug_print("<dev string:x6a>");
            #/
            break;
        case 25:
            self zm_stats::increment_challenge_stat("ZM_DAILY_ROUND_25");
            /#
                debug_print("<dev string:x87>");
            #/
            break;
        case 30:
            self zm_stats::increment_challenge_stat("ZM_DAILY_ROUND_30");
            /#
                debug_print("<dev string:xa4>");
            #/
            break;
        }
    }
}

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 1, eflags: 0x0
// Checksum 0xe6aa5504, Offset: 0x8e0
// Size: 0x904
function death_check_for_challenge_updates(e_attacker) {
    if (!isdefined(e_attacker)) {
        return;
    }
    if (isdefined(e_attacker._trap_type)) {
        if (isdefined(e_attacker.activated_by_player)) {
            e_attacker.activated_by_player zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_TRAPS");
            /#
                debug_print("<dev string:xc1>");
            #/
        }
    }
    if (!isplayer(e_attacker)) {
        return;
    }
    if (isvehicle(self)) {
        str_damagemod = self.str_damagemod;
        w_damage = self.w_damage;
    } else {
        str_damagemod = self.damagemod;
        w_damage = self.damageweapon;
    }
    if (w_damage.isdualwield) {
        w_damage = w_damage.dualwieldweapon;
    }
    w_damage = zm_weapons::get_nonalternate_weapon(w_damage);
    if (zm_utility::is_headshot(w_damage, self.damagelocation, str_damagemod)) {
        e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_HEADSHOTS");
        /#
            debug_print("<dev string:xd4>");
        #/
        e_attacker.a_daily_challenges[0]++;
        if (e_attacker.a_daily_challenges[0] == 20) {
            e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_HEADSHOTS_IN_ROW");
            /#
                debug_print("<dev string:xeb>");
            #/
        }
    } else {
        e_attacker.a_daily_challenges[0] = 0;
    }
    if (str_damagemod == "MOD_MELEE") {
        e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_MELEE");
        /#
            debug_print("<dev string:x10c>");
        #/
    }
    if (isplayer(e_attacker) && e_attacker zm_powerups::is_insta_kill_active()) {
        e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_INSTAKILL");
        /#
            debug_print("<dev string:x127>");
        #/
        return;
    }
    if (zm_weapons::is_weapon_upgraded(w_damage)) {
        e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_PACKED");
        /#
            debug_print("<dev string:x140>");
        #/
        if (isdefined(level.zombie_weapons[level.start_weapon]) && level.zombie_weapons[level.start_weapon].upgrade === w_damage) {
            e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_PACKED_STARTING_PISTOL");
            /#
                debug_print("<dev string:x15c>");
            #/
        }
        switch (w_damage.weapclass) {
        case #"mg":
            e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_PACKED_MG");
            /#
                debug_print("<dev string:x181>");
            #/
            break;
        case #"pistol":
            e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_PACKED_PISTOL");
            /#
                debug_print("<dev string:x199>");
            #/
            break;
        case #"smg":
            e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_PACKED_SMG");
            /#
                debug_print("<dev string:x1b5>");
            #/
            break;
        case #"spread":
            e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_PACKED_SHOTGUN");
            /#
                debug_print("<dev string:x1ce>");
            #/
            break;
        case #"rifle":
            if (w_damage.issniperweapon) {
                e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_PACKED_SNIPER");
                /#
                    debug_print("<dev string:x1eb>");
                #/
            } else {
                e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_PACKED_RIFLE");
                /#
                    debug_print("<dev string:x207>");
                #/
            }
            break;
        }
    }
    switch (w_damage.weapclass) {
    case #"mg":
        e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_MG");
        /#
            debug_print("<dev string:x222>");
        #/
        break;
    case #"pistol":
        e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_PISTOL");
        /#
            debug_print("<dev string:x233>");
        #/
        break;
    case #"rifle":
        if (w_damage.issniperweapon) {
            e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_SNIPER");
            /#
                debug_print("<dev string:x248>");
            #/
        } else {
            e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_RIFLE");
            /#
                debug_print("<dev string:x25d>");
            #/
        }
        break;
    case #"smg":
        e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_SMG");
        /#
            debug_print("<dev string:x271>");
        #/
        break;
    case #"spread":
        e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_SHOTGUN");
        /#
            debug_print("<dev string:x283>");
        #/
        break;
    }
    switch (str_damagemod) {
    case #"mod_explosive":
    case #"mod_grenade":
    case #"mod_projectile":
    case #"mod_grenade_splash":
    case #"mod_projectile_splash":
        e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_EXPLOSIVE");
        /#
            debug_print("<dev string:x299>");
        #/
        break;
    }
    if (w_damage == getweapon(#"bowie_knife")) {
        e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_BOWIE");
        /#
            debug_print("<dev string:x2b1>");
        #/
    }
    if (w_damage == getweapon(#"bouncingbetty")) {
        e_attacker zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_BOUNCING_BETTY");
        /#
            debug_print("<dev string:x2cb>");
        #/
    }
}

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 0, eflags: 0x0
// Checksum 0xb7dfe637, Offset: 0x11f0
// Size: 0x108
function spent_points_tracking() {
    level endon(#"end_game");
    while (true) {
        result = level waittill(#"spent_points");
        player = result.player;
        n_points = result.points;
        player.a_daily_challenges[1] = player.a_daily_challenges[1] + n_points;
        player zm_stats::increment_challenge_stat("ZM_DAILY_SPEND_25K", n_points);
        player zm_stats::increment_challenge_stat("ZM_DAILY_SPEND_50K", n_points);
        /#
            debug_print("<dev string:x2e8>");
        #/
    }
}

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 0, eflags: 0x0
// Checksum 0xde93df3e, Offset: 0x1300
// Size: 0x110
function earned_points_tracking() {
    level endon(#"end_game");
    while (true) {
        result = level waittill(#"earned_points");
        player = result.player;
        n_points = result.points;
        n_multiplier = zm_score::get_points_multiplier(player);
        if (n_multiplier == 2) {
            player.a_daily_challenges[2] = player.a_daily_challenges[2] + n_points;
            player zm_stats::increment_challenge_stat("ZM_DAILY_EARN_5K_WITH_2X", n_points);
            /#
                debug_print("<dev string:x2fd>");
            #/
        }
    }
}

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 0, eflags: 0x0
// Checksum 0xcea05ada, Offset: 0x1418
// Size: 0x80
function challenge_ingame_time_tracking() {
    self endon(#"disconnect");
    self notify(#"stop_challenge_ingame_time_tracking");
    self endon(#"stop_challenge_ingame_time_tracking");
    level flag::wait_till("start_zombie_round_logic");
    for (;;) {
        wait 1;
        zm_stats::increment_client_stat("ZM_DAILY_CHALLENGE_INGAME_TIME");
    }
}

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 1, eflags: 0x0
// Checksum 0xcfe0af0d, Offset: 0x14a0
// Size: 0xf8
function increment_windows_repaired(s_barrier) {
    if (!isdefined(self.n_dc_barriers_rebuilt)) {
        self.n_dc_barriers_rebuilt = 0;
    }
    if (!(isdefined(self.b_dc_rebuild_timer_active) && self.b_dc_rebuild_timer_active)) {
        self thread rebuild_timer();
        self.a_s_barriers_rebuilt = [];
    }
    if (!isinarray(self.a_s_barriers_rebuilt, s_barrier)) {
        if (!isdefined(self.a_s_barriers_rebuilt)) {
            self.a_s_barriers_rebuilt = [];
        } else if (!isarray(self.a_s_barriers_rebuilt)) {
            self.a_s_barriers_rebuilt = array(self.a_s_barriers_rebuilt);
        }
        self.a_s_barriers_rebuilt[self.a_s_barriers_rebuilt.size] = s_barrier;
        self.n_dc_barriers_rebuilt++;
    }
}

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 0, eflags: 0x4
// Checksum 0x654389cd, Offset: 0x15a0
// Size: 0x9a
function private rebuild_timer() {
    self endon(#"disconnect");
    self.b_dc_rebuild_timer_active = 1;
    wait 45;
    if (self.n_dc_barriers_rebuilt >= 5) {
        self zm_stats::increment_challenge_stat("ZM_DAILY_REBUILD_WINDOWS");
        /#
            debug_print("<dev string:x32d>");
        #/
    }
    self.n_dc_barriers_rebuilt = 0;
    self.a_s_barriers_rebuilt = [];
    self.b_dc_rebuild_timer_active = undefined;
}

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 0, eflags: 0x0
// Checksum 0xcc19112e, Offset: 0x1648
// Size: 0xcc
function increment_magic_box() {
    if (isdefined(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) && zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) {
        self zm_stats::increment_challenge_stat("ZM_DAILY_PURCHASE_FIRE_SALE_MAGIC_BOX");
        /#
            debug_print("<dev string:x346>");
        #/
    }
    self zm_stats::increment_challenge_stat("ZM_DAILY_PURCHASE_MAGIC_BOX");
    /#
        debug_print("<dev string:x36f>");
    #/
}

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 0, eflags: 0x0
// Checksum 0x27b76992, Offset: 0x1720
// Size: 0xc0
function increment_nuked_zombie() {
    foreach (player in level.players) {
        if (player.sessionstate != "spectator") {
            player zm_stats::increment_challenge_stat("ZM_DAILY_KILLS_NUKED");
            /#
                debug_print("<dev string:x387>");
            #/
        }
    }
}

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 0, eflags: 0x0
// Checksum 0xd19bfcb5, Offset: 0x17e8
// Size: 0x88
function perk_purchase_tracking() {
    self endon(#"disconnect");
    while (true) {
        str_perk = undefined;
        self waittill(#"perk_purchased", str_perk);
        self zm_stats::increment_challenge_stat("ZM_DAILY_PURCHASE_PERKS");
        /#
            debug_print("<dev string:x39d>");
        #/
    }
}

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 0, eflags: 0x0
// Checksum 0xd1331b36, Offset: 0x1878
// Size: 0x70
function perk_drink_tracking() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"perk_bought");
        self zm_stats::increment_challenge_stat("ZM_DAILY_DRINK_PERKS");
        /#
            debug_print("<dev string:x3b5>");
        #/
    }
}

/#

    // Namespace zm_daily_challenges/zm_daily_challenges
    // Params 1, eflags: 0x0
    // Checksum 0x51bb378e, Offset: 0x18f0
    // Size: 0x24
    function debug_print(str_line) {
        println(str_line);
    }

#/

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 1, eflags: 0x0
// Checksum 0x851213c9, Offset: 0x1920
// Size: 0x17c
function on_challenge_complete(params) {
    n_challenge_index = params.challengeindex;
    if (is_daily_challenge(n_challenge_index)) {
        if (isdefined(self)) {
            uploadstats(self);
        }
        a_challenges = table::load(#"gamedata/stats/zm/statsmilestones4.csv", "a0");
        str_current_challenge = a_challenges[n_challenge_index][#"e4"];
        n_players = level.players.size;
        n_time_played = game.timepassed / 1000;
        n_challenge_start_time = self zm_stats::get_global_stat("zm_daily_challenge_start_time");
        n_challenge_time_ingame = self globallogic_score::getpersstat("ZM_DAILY_CHALLENGE_INGAME_TIME");
        n_challenge_games_played = self zm_stats::get_global_stat("zm_daily_challenge_games_played");
        /#
            debug_print("<dev string:x3c9>" + n_challenge_index);
        #/
    }
}

// Namespace zm_daily_challenges/zm_daily_challenges
// Params 1, eflags: 0x0
// Checksum 0xb03975ea, Offset: 0x1aa8
// Size: 0x52
function is_daily_challenge(n_challenge_index) {
    n_row = tablelookuprownum(#"gamedata/stats/zm/statsmilestones4.csv", 0, n_challenge_index);
    if (n_row > -1) {
        return true;
    }
    return false;
}

