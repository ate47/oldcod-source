#using script_642f4870fb9fcc8a;
#using scripts\core_common\ai\region_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\rank_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\emp_shared;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\mp_common\ai\planner_mp_control_commander;
#using scripts\mp_common\ai\planner_mp_control_squad;
#using scripts\mp_common\ai\planner_mp_dom_commander;
#using scripts\mp_common\ai\planner_mp_dom_squad;
#using scripts\mp_common\ai\planner_mp_koth_commander;
#using scripts\mp_common\ai\planner_mp_koth_squad;
#using scripts\mp_common\ai\planner_mp_sd_commander;
#using scripts\mp_common\ai\planner_mp_sd_squad;
#using scripts\mp_common\bots\mp_bot_action;
#using scripts\mp_common\draft;

#namespace bot;

// Namespace bot/mp_bot
// Params 0, eflags: 0x2
// Checksum 0xabec43b3, Offset: 0x558
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"bot_mp", &__init__, undefined, undefined);
}

// Namespace bot/mp_bot
// Params 0, eflags: 0x0
// Checksum 0x8d43caa9, Offset: 0x5a0
// Size: 0x3da
function __init__() {
    callback::on_start_gametype(&init);
    level.onbotconnect = &on_bot_connect;
    level.onbotspawned = &on_bot_spawned;
    level.onbotkilled = &on_bot_killed;
    if (!isdefined(level.var_9baecddf)) {
        level.var_9baecddf = "bot_tacstate_mp_default";
    }
    level.var_4ddc87c6 = [];
    level.var_4ddc87c6[#"primaryweapon"] = array("ar_accurate_t8", "ar_fastfire_t8", "ar_damage_t8", "ar_stealth_t8", "ar_modular_t8", "smg_standard_t8", "smg_handling_t8", "smg_fastfire_t8", "smg_capacity_t8", "smg_accurate_t8", "tr_powersemi_t8", "tr_longburst_t8", "tr_midburst_t8", "lmg_standard_t8", "sniper_powerbolt_t8", "sniper_quickscope_t8");
    level.var_4ddc87c6[#"secondaryweapon"] = array("pistol_revolver_t8", "pistol_standard_t8", "shotgun_pump_t8", "shotgun_semiauto_t8", "launcher_standard_t8");
    level.var_4ddc87c6[#"perk1"] = array("talent_engineer", "talent_coldblooded", "talent_resistance", "talent_flakjacket");
    level.var_4ddc87c6[#"perk2"] = array("talent_scavenger", "talent_lightweight", "talent_gungho", "talent_dexterity");
    level.var_4ddc87c6[#"perk3"] = array("talent_teamlink", "talent_ghost", "talent_tracker", "talent_deadsilence");
    level.var_4ddc87c6[#"gear"] = array("gear_equipmentcharge", "gear_medicalinjectiongun", "gear_scorestreakcharge", "gear_armor", "gear_awareness");
    level.var_4ddc87c6[#"equipment"] = array("trophy_system", "hatchet", "frag_grenade", "eq_molotov", "eq_slow_grenade");
    level.var_4ddc87c6[#"scorestreak"] = array("ac130", "ai_tank_marker", "counteruav", "drone_squadron", "helicopter_comlink", "planemortar", "recon_car", "remote_missile", "straferun", "supplydrop_marker", "swat_team", "uav", "ultimate_turret");
}

// Namespace bot/mp_bot
// Params 0, eflags: 0x0
// Checksum 0xc3b6d168, Offset: 0x988
// Size: 0xdc
function init() {
    level endon(#"game_ended");
    level thread init_strategic_command();
    botsoak = getdvarint(#"sv_botsoak", 0);
    if (!isdedicated()) {
        if (level.rankedmatch) {
            return;
        }
    }
    if (!botsoak) {
        level flag::wait_till("all_players_connected");
    }
    level thread populate_bots();
    level thread region_utility::function_a20797f5();
}

// Namespace bot/mp_bot
// Params 0, eflags: 0x0
// Checksum 0xcc5b1eac, Offset: 0xa70
// Size: 0x2fa
function init_strategic_command() {
    if (level.var_18197185) {
        return;
    }
    if (!isdefined(level.gametype) || !isdefined(level.teams)) {
        return;
    }
    switch (level.gametype) {
    case #"control":
        foreach (team in level.teams) {
            plannermpcontrolcommander::createcommander(team);
        }
        break;
    case #"dom":
        foreach (team in level.teams) {
            plannermpdomcommander::createcommander(team);
        }
        break;
    case #"koth":
        foreach (team in level.teams) {
            plannermpkothcommander::createcommander(team);
        }
        break;
    case #"sd":
        foreach (team in level.teams) {
            plannermpsdcommander::createcommander(team);
        }
        break;
    default:
        foreach (team in level.teams) {
            namespace_ceda4ee8::createcommander(team);
        }
        break;
    }
}

// Namespace bot/mp_bot
// Params 0, eflags: 0x0
// Checksum 0xe0b85887, Offset: 0xd78
// Size: 0x16a
function on_bot_connect() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    if (!self islobbybot()) {
        if (!isdefined(level.givecustomloadout)) {
            self function_fcdf099c();
        }
    }
    if (!isdefined(self.var_f1a6dad4) || !player_role::is_valid(self.var_f1a6dad4)) {
        self player_role::clear();
        draft::assign_remaining_players(self);
    }
    self set_rank();
    switch (getdvarint(#"bot_difficulty", 1)) {
    case 0:
        break;
    case 1:
    default:
        break;
    case 2:
        break;
    case 3:
        break;
    }
}

// Namespace bot/mp_bot
// Params 0, eflags: 0x0
// Checksum 0x6bd1a8b4, Offset: 0xef0
// Size: 0x77c
function function_fcdf099c() {
    var_f22c24fe = 0;
    var_be3c1f5d = [];
    var_be3c1f5d[#"primaryweapon"] = array::random(level.var_4ddc87c6[#"primaryweapon"]);
    /#
        function_c8b8691("<dev string:x30>", var_be3c1f5d[#"primaryweapon"]);
    #/
    self botclassadditem(0, var_be3c1f5d[#"primaryweapon"]);
    var_f22c24fe++;
    attachments = getrandomcompatibleattachmentsforweapon(getweapon(var_be3c1f5d[#"primaryweapon"]), 3);
    var_be3c1f5d[#"primaryattachment1"] = attachments[0];
    self botclassaddattachment(0, var_be3c1f5d[#"primaryweapon"], var_be3c1f5d[#"primaryattachment1"], "primaryAttachment1");
    var_f22c24fe++;
    var_be3c1f5d[#"primaryattachment2"] = attachments[1];
    self botclassaddattachment(0, var_be3c1f5d[#"primaryweapon"], var_be3c1f5d[#"primaryattachment2"], "primaryAttachment2");
    var_f22c24fe++;
    var_be3c1f5d[#"primaryattachment3"] = attachments[2];
    self botclassaddattachment(0, var_be3c1f5d[#"primaryweapon"], var_be3c1f5d[#"primaryattachment3"], "primaryAttachment3");
    var_f22c24fe++;
    var_be3c1f5d[#"perk1"] = array::random(level.var_4ddc87c6[#"perk1"]);
    self botclassadditem(0, var_be3c1f5d[#"perk1"]);
    var_f22c24fe++;
    var_be3c1f5d[#"perk2"] = array::random(level.var_4ddc87c6[#"perk2"]);
    self botclassadditem(0, var_be3c1f5d[#"perk2"]);
    var_f22c24fe++;
    var_be3c1f5d[#"perk3"] = array::random(level.var_4ddc87c6[#"perk3"]);
    self botclassadditem(0, var_be3c1f5d[#"perk3"]);
    var_f22c24fe++;
    var_be3c1f5d[#"gear"] = array::random(level.var_4ddc87c6[#"gear"]);
    self botclassadditem(0, var_be3c1f5d[#"gear"]);
    var_f22c24fe++;
    var_5c09c136 = randomfloat(1) < 0.25;
    if (var_5c09c136) {
        var_be3c1f5d[#"equipment"] = array::random(level.var_4ddc87c6[#"equipment"]);
        self botclassadditem(0, var_be3c1f5d[#"equipment"]);
        var_f22c24fe++;
    } else {
        var_be3c1f5d[#"equipment"] = "default_specialist_equipment";
        self botclassadditem(0, var_be3c1f5d[#"equipment"]);
    }
    var_be3c1f5d[#"secondaryweapon"] = array::random(level.var_4ddc87c6[#"secondaryweapon"]);
    /#
        function_c8b8691("<dev string:x3e>", var_be3c1f5d[#"secondaryweapon"]);
    #/
    self botclassadditem(0, var_be3c1f5d[#"secondaryweapon"]);
    var_f22c24fe++;
    var_685b8b86 = 10 - var_f22c24fe;
    if (var_685b8b86 > 0) {
        attachments = getrandomcompatibleattachmentsforweapon(getweapon(var_be3c1f5d[#"secondaryweapon"]), var_685b8b86);
        for (i = 0; i < var_685b8b86; i++) {
            attachtag = "secondaryAttachment" + i + 1;
            var_be3c1f5d[attachtag] = attachments[i];
            self botclassaddattachment(0, var_be3c1f5d[#"secondaryweapon"], var_be3c1f5d[attachtag], attachtag);
            var_f22c24fe++;
        }
    }
    var_c20e92bc = array::randomize(level.var_4ddc87c6[#"scorestreak"]);
    var_be3c1f5d[#"scorestreak1"] = var_c20e92bc[0];
    self botclassadditem(0, var_be3c1f5d[#"scorestreak1"]);
    var_be3c1f5d[#"scorestreak2"] = var_c20e92bc[1];
    self botclassadditem(0, var_be3c1f5d[#"scorestreak2"]);
    var_be3c1f5d[#"scorestreak3"] = var_c20e92bc[2];
    self botclassadditem(0, var_be3c1f5d[#"scorestreak3"]);
}

/#

    // Namespace bot/mp_bot
    // Params 2, eflags: 0x0
    // Checksum 0x5cc341b, Offset: 0x1678
    // Size: 0x4c
    function function_c8b8691(var_c8ed2b6f, loadoutitem) {
        if (var_c8ed2b6f == "<dev string:x30>" || var_c8ed2b6f == "<dev string:x3e>") {
            bot_action::function_585771f0(loadoutitem);
        }
    }

#/

// Namespace bot/mp_bot
// Params 0, eflags: 0x0
// Checksum 0xa00ba654, Offset: 0x16d0
// Size: 0x64
function on_bot_spawned() {
    if (isdefined(level.var_ba69f006) && level.var_ba69f006) {
        self ai::set_behavior_attribute("allowprimaryoffhand", 0);
        self ai::set_behavior_attribute("allowspecialoffhand", 0);
    }
}

// Namespace bot/mp_bot
// Params 0, eflags: 0x0
// Checksum 0x8725cb78, Offset: 0x1740
// Size: 0x84
function on_bot_killed() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self endon(#"spawned");
    self waittill(#"death_delay_finished");
    wait 0.1;
    if (level.playerforcerespawn) {
        return;
    }
    self thread respawn();
}

// Namespace bot/mp_bot
// Params 0, eflags: 0x0
// Checksum 0x9847f9b2, Offset: 0x17d0
// Size: 0x68
function respawn() {
    self endon(#"spawned");
    self endon(#"disconnect");
    level endon(#"game_ended");
    while (true) {
        self bottapbutton(3);
        wait 0.1;
    }
}

// Namespace bot/mp_bot
// Params 0, eflags: 0x0
// Checksum 0x6e3a1056, Offset: 0x1840
// Size: 0x212
function use_killstreak() {
    if (!level.loadoutkillstreaksenabled || self emp::enemyempactive()) {
        return;
    }
    weapons = self getweaponslist();
    inventoryweapon = self getinventoryweapon();
    foreach (weapon in weapons) {
        killstreak = killstreaks::get_killstreak_for_weapon(weapon);
        if (!isdefined(killstreak)) {
            continue;
        }
        if (weapon != inventoryweapon && !self getweaponammoclip(weapon)) {
            continue;
        }
        if (self killstreakrules::iskillstreakallowed(killstreak, self.team)) {
            useweapon = weapon;
            break;
        }
    }
    if (!isdefined(useweapon)) {
        return;
    }
    killstreak_ref = killstreaks::get_menu_name(killstreak);
    switch (killstreak_ref) {
    case #"killstreak_helicopter_player_gunner":
    case #"killstreak_uav":
    case #"killstreak_satellite":
    case #"killstreak_sentinel":
    case #"killstreak_counteruav":
    case #"killstreak_raps":
        self switchtoweapon(useweapon);
        break;
    }
}

// Namespace bot/mp_bot
// Params 0, eflags: 0x0
// Checksum 0x27fbe974, Offset: 0x1a60
// Size: 0x30c
function set_rank() {
    players = getplayers();
    ranks = [];
    bot_ranks = [];
    human_ranks = [];
    for (i = 0; i < players.size; i++) {
        if (players[i] == self) {
            continue;
        }
        if (isdefined(players[i].pers[#"rank"])) {
            if (isbot(players[i])) {
                bot_ranks[bot_ranks.size] = players[i].pers[#"rank"];
                continue;
            }
            human_ranks[human_ranks.size] = players[i].pers[#"rank"];
        }
    }
    if (!human_ranks.size) {
        human_ranks[human_ranks.size] = 10;
    }
    human_avg = math::array_average(human_ranks);
    while (bot_ranks.size + human_ranks.size < 5) {
        r = human_avg + randomintrange(-5, 5);
        rank = math::clamp(r, 0, level.maxrank);
        human_ranks[human_ranks.size] = rank;
    }
    ranks = arraycombine(human_ranks, bot_ranks, 1, 0);
    avg = math::array_average(ranks);
    s = math::array_std_deviation(ranks, avg);
    rank = int(math::random_normal_distribution(avg, s, 0, level.maxrank));
    while (!isdefined(self.pers[#"rank"])) {
        wait 0.1;
    }
    self.pers[#"rank"] = rank;
    self.pers[#"rankxp"] = rank::getrankinfominxp(rank);
    self setrank(rank);
}

