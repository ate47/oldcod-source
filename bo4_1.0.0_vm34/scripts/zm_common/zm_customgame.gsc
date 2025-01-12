#using script_1de6f3c239229d19;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_power;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;

#namespace zm_custom;

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x2
// Checksum 0x9f20c4e, Offset: 0x4d8
// Size: 0x282
function autoexec function_107d2a00() {
    /#
        level thread function_5793a336();
    #/
    level thread function_fe7bca06();
    level thread function_1309bfff();
    level thread function_7128f2cd();
    level thread function_fb65052a();
    callback::on_spawned(&function_143f7288);
    callback::on_spawned(&function_2680579f);
    callback::on_spawned(&function_8a7511a1);
    callback::on_spawned(&function_f2c9f706);
    clientfield::register("clientuimodel", "zmhud.damage_point_shake", 1, 1, "counter");
    level.zmGameTimer = zm_game_timer::register("zmGameTimer");
    /#
        level thread function_5cbcc9f9();
    #/
    var_7be7f7ca = function_8407b264();
    foreach (s_setting in var_7be7f7ca) {
        test = function_5638f689(s_setting.name);
        if (isdefined(function_5638f689(s_setting.name)) && function_5638f689(s_setting.name) != s_setting.default_val) {
            level.var_d845a657 = 1;
            level.var_b5bdb0b1 = &function_a5ce341b;
        }
    }
}

// Namespace zm_custom/zm_customgame
// Params 1, eflags: 0x0
// Checksum 0x2d231d38, Offset: 0x768
// Size: 0x70
function function_5638f689(var_414f8ef3) {
    if (var_414f8ef3 === "") {
        return undefined;
    }
    setting = getgametypesetting(var_414f8ef3);
    assert(isdefined(setting), "<dev string:x30>" + var_414f8ef3 + "<dev string:x46>");
    return setting;
}

// Namespace zm_custom/zm_customgame
// Params 1, eflags: 0x0
// Checksum 0xa9e5123f, Offset: 0x7e0
// Size: 0xa6
function function_50bc59c7(var_414f8ef3) {
    a_s_defaults = function_8407b264();
    foreach (s_setting in a_s_defaults) {
        if (var_414f8ef3 == s_setting.name) {
            return s_setting.default_val;
        }
    }
    return undefined;
}

// Namespace zm_custom/zm_customgame
// Params 1, eflags: 0x0
// Checksum 0xf3beb110, Offset: 0x890
// Size: 0xb8
function function_c4cdc40c(var_414f8ef3) {
    foreach (e_player in level.players) {
        e_player val::set(#"game_end", "freezecontrols", 1);
    }
    level notify(#"end_game");
}

// Namespace zm_custom/zm_customgame
// Params 1, eflags: 0x0
// Checksum 0xedb2f199, Offset: 0x950
// Size: 0x92
function function_f24cfbd2(e_player) {
    foreach (str_perk in level.var_3d574fc8) {
        if (!e_player hasperk(str_perk)) {
            return false;
        }
    }
    return true;
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x0
// Checksum 0xd7a4e1e6, Offset: 0x9f0
// Size: 0x222
function function_e57be1f0() {
    var_d4ef4b90 = function_5638f689(#"friendlyfiretype");
    switch (var_d4ef4b90) {
    case 0:
        zm_player::function_a4e9154d(&function_a9d4f59);
        zm_player::function_a4e9154d(&function_e69bfe91);
        zm_player::function_a4e9154d(&function_521772b1);
        break;
    case 1:
        zm_player::function_a4e9154d(&function_e69bfe91);
        zm_player::function_a4e9154d(&function_521772b1);
        zm_player::register_player_friendly_fire_callback(&function_a9d4f59);
        break;
    case 2:
        zm_player::function_a4e9154d(&function_a9d4f59);
        zm_player::function_a4e9154d(&function_521772b1);
        zm_player::register_player_friendly_fire_callback(&function_e69bfe91);
        break;
    case 3:
        zm_player::function_a4e9154d(&function_a9d4f59);
        zm_player::function_a4e9154d(&function_e69bfe91);
        zm_player::register_player_friendly_fire_callback(&function_521772b1);
        break;
    }
}

// Namespace zm_custom/zm_customgame
// Params 1, eflags: 0x0
// Checksum 0x7ad47a0b, Offset: 0xc20
// Size: 0x9d6
function function_4e389f8(s_talisman) {
    if (!function_5638f689(#"zmtalismansenabled")) {
        return false;
    }
    switch (s_talisman.name) {
    case #"talisman_box_guarantee_box_only":
        if (!function_5638f689(#"zmtalismanboxguaranteeboxonly") || function_5638f689(#"zmmysteryboxstate") == 0) {
            return false;
        }
        break;
    case #"talisman_box_guarantee_lmg":
        if (!function_5638f689(#"zmtalismanboxguaranteelmg") || !function_5638f689(#"zmweaponslmg") || function_5638f689(#"zmmysteryboxstate") == 0) {
            return false;
        }
        break;
    case #"talisman_box_guarantee_wonder_weapon":
        if (!function_5638f689(#"hash_61695e52556ff2d1") || !function_5638f689(#"zmwonderweaponisenabled") || function_5638f689(#"zmmysteryboxstate") == 0) {
            return false;
        }
        break;
    case #"talisman_coagulant":
        if (!function_5638f689(#"zmtalismancoagulant")) {
            return false;
        }
        break;
    case #"talisman_extra_claymore":
        if (!function_5638f689(#"zmtalismanextraclaymore")) {
            return false;
        }
        break;
    case #"talisman_extra_frag":
        if (!function_5638f689(#"zmtalismanextrafrag")) {
            return false;
        }
        break;
    case #"talisman_extra_miniturret":
        if (!function_5638f689(#"zmtalismanextraminiturret")) {
            return false;
        }
        break;
    case #"talisman_extra_molotov":
        if (!function_5638f689(#"zmtalismanextramolotov")) {
            return false;
        }
        break;
    case #"talisman_extra_semtex":
        if (!function_5638f689(#"zmtalismanextrasemtex")) {
            return false;
        }
        break;
    case #"talisman_impatient":
        if (!function_5638f689(#"zmtalismanimpatient")) {
            return false;
        }
        break;
    case #"talisman_perk_mod_single":
        if (!function_5638f689(#"zmtalismanperkmodsingle")) {
            return false;
        }
        break;
    case #"talisman_perk_permanent_1":
        if (!function_5638f689(#"zmtalismanperkpermanent1")) {
            return false;
        }
        break;
    case #"talisman_perk_permanent_2":
        if (!function_5638f689(#"zmtalismanperkpermanent2")) {
            return false;
        }
        break;
    case #"talisman_perk_permanent_3":
        if (!function_5638f689(#"zmtalismanperkpermanent3")) {
            return false;
        }
        break;
    case #"talisman_perk_permanent_4":
        if (!function_5638f689(#"zmtalismanperkpermanent4")) {
            return false;
        }
        break;
    case #"talisman_perk_reducecost_1":
        if (!function_5638f689(#"zmtalismanperkreducecost1")) {
            return false;
        }
        break;
    case #"talisman_perk_reducecost_2":
        if (!function_5638f689(#"zmtalismanperkreducecost2")) {
            return false;
        }
        break;
    case #"talisman_perk_reducecost_3":
        if (!function_5638f689(#"zmtalismanperkreducecost3")) {
            return false;
        }
        break;
    case #"talisman_perk_reducecost_4":
        if (!function_5638f689(#"zmtalismanperkreducecost4")) {
            return false;
        }
        break;
    case #"talisman_perk_start_1":
        if (!function_5638f689(#"zmtalismanperkstart1")) {
            return false;
        }
        break;
    case #"talisman_perk_start_2":
        if (!function_5638f689(#"zmtalismanperkstart2")) {
            return false;
        }
        break;
    case #"talisman_perk_start_3":
        if (!function_5638f689(#"zmtalismanperkstart3")) {
            return false;
        }
        break;
    case #"talisman_perk_start_4":
        if (!function_5638f689(#"zmtalismanperkstart4")) {
            return false;
        }
        break;
    case #"talisman_shield_durability_legendary":
        if (!function_5638f689(#"zmtalismanshielddurabilitylegendary")) {
            return false;
        }
        break;
    case #"talisman_shield_durability_rare":
        if (!function_5638f689(#"zmtalismanshielddurabilityrare")) {
            return false;
        }
        break;
    case #"talisman_shield_price":
        if (!function_5638f689(#"zmtalismanshieldprice")) {
            return false;
        }
        break;
    case #"talisman_special_startlv2":
        if (!function_5638f689(#"zmtalismanspecialstartlvl2")) {
            return false;
        }
        break;
    case #"talisman_special_startlv3":
        if (!function_5638f689(#"zmtalismanspecialstartlvl3")) {
            return false;
        }
        break;
    case #"talisman_special_xp_rate":
        if (!function_5638f689(#"zmtalismanspecialxprate")) {
            return false;
        }
        break;
    case #"talisman_start_weapon_ar":
        if (!function_5638f689(#"zmtalismanstartweaponar")) {
            return false;
        }
        break;
    case #"talisman_start_weapon_lmg":
        if (!function_5638f689(#"zmtalismanstartweaponlmg")) {
            return false;
        }
        break;
    case #"talisman_start_weapon_smg":
        if (!function_5638f689(#"zmtalismanstartweaponsmg")) {
            return false;
        }
        break;
    case #"talisman_weapon_reducepapcost":
        if (!function_5638f689(#"zmtalismanreducepapcost")) {
            return false;
        }
        break;
    default:
        break;
    }
    if (isdefined(s_talisman.rarity)) {
        switch (s_talisman.rarity) {
        case 0:
            if (!function_5638f689(#"zmtalismanscommon")) {
                return false;
            }
            break;
        case 1:
            if (!function_5638f689(#"zmtalismansrare")) {
                return false;
            }
            break;
        case 2:
            if (!function_5638f689(#"zmtalismanslegendary")) {
                return false;
            }
            break;
        case 3:
            if (!function_5638f689(#"zmtalismansepic")) {
                return false;
            }
            break;
        case 4:
            if (!function_5638f689(#"zmtalismansultra")) {
                return false;
            }
            break;
        default:
            break;
        }
    }
    return true;
}

// Namespace zm_custom/zm_customgame
// Params 1, eflags: 0x0
// Checksum 0xc4618d08, Offset: 0x1600
// Size: 0x1126
function function_25d3f3c8(str_elixir) {
    if (!isdefined(str_elixir) || str_elixir == "" || !function_5638f689(#"zmelixirsenabled")) {
        return false;
    }
    n_index = getitemindexfromref(str_elixir);
    s_fields = function_b679234(n_index, 2);
    if (isdefined(s_fields) && isdefined(s_fields.bgbrarity)) {
        n_rarity = s_fields.bgbrarity;
    }
    if (!isdefined(n_rarity)) {
        n_rarity = 0;
    }
    switch (str_elixir) {
    case #"zm_bgb_always_done_swiftly":
        if (!function_5638f689(#"zmelixiralwaysdoneswiftly")) {
            return false;
        }
        break;
    case #"zm_bgb_anywhere_but_here":
        if (!function_5638f689(#"zmelixiranywherebuthere")) {
            return false;
        }
        break;
    case #"zm_bgb_arsenal_accelerator":
        if (!function_5638f689(#"zmelixirarsenalaccelerator") || !function_5638f689(#"zmspecweaponisenabled")) {
            return false;
        }
        break;
    case #"zm_bgb_danger_closest":
        if (!function_5638f689(#"zmelixirdangerclosest")) {
            return false;
        }
        break;
    case #"zm_bgb_in_plain_sight":
        if (!function_5638f689(#"zmelixirinplainsight")) {
            return false;
        }
        break;
    case #"zm_bgb_newtonian_negation":
        if (!function_5638f689(#"zmelixirnewtoniannegation")) {
            return false;
        }
        break;
    case #"zm_bgb_now_you_see_me":
        if (!function_5638f689(#"zmelixirnowyouseeme")) {
            return false;
        }
        break;
    case #"zm_bgb_stock_option":
        if (!function_5638f689(#"zmelixirstockoption")) {
            return false;
        }
        break;
    case #"zm_bgb_board_games":
        if (!function_5638f689(#"zmelixirboardgames") || !function_5638f689(#"zmbarricadestate")) {
            return false;
        }
        break;
    case #"zm_bgb_burned_out":
        if (!function_5638f689(#"zmelixirburnedout")) {
            return false;
        }
        break;
    case #"zm_bgb_crawl_space":
        if (!function_5638f689(#"zmelixircrawlspace") || function_5638f689(#"zmcrawlerstate") == 0) {
            return false;
        }
        break;
    case #"zm_bgb_pop_shocks":
        if (!function_5638f689(#"zmelixirpopshocks")) {
            return false;
        }
        break;
    case #"zm_bgb_respin_cycle":
        if (!function_5638f689(#"hash_7c2b2a861115fd94") || function_5638f689(#"zmmysteryboxstate") == 0) {
            return false;
        }
        break;
    case #"zm_bgb_temporal_gift":
        if (!function_5638f689(#"zmelixirtemporalgift") || !function_5638f689(#"zmpowerupsactive")) {
            return false;
        }
        break;
    case #"zm_bgb_point_drops":
        if (!function_5638f689(#"zmelixirpointdrops") || !function_5638f689(#"zmpowerupchaospoints") || !function_5638f689(#"zmpowerupsactive")) {
            return false;
        }
        break;
    case #"zm_bgb_alchemical_antithesis":
        if (!function_5638f689(#"zmelixiralchemicalantithesis") || function_5638f689(#"zmpointsfixed")) {
            return false;
        }
        break;
    case #"zm_bgb_sword_flay":
        if (!function_5638f689(#"zmelixirswordflay") || !function_5638f689(#"zmweaponsmelee")) {
            return false;
        }
        break;
    case #"zm_bgb_dead_of_nuclear_winter":
        if (!function_5638f689(#"zmelixirdeadofnuclearwinter") || !function_5638f689(#"zmpowerupnuke") || !function_5638f689(#"zmpowerupsactive")) {
            return false;
        }
        break;
    case #"zm_bgb_licensed_contractor":
        if (!function_5638f689(#"zmelixirlicensedcontractor") || !function_5638f689(#"zmpowerupcarpenter") || !function_5638f689(#"zmpowerupsactive")) {
            return false;
        }
        break;
    case #"zm_bgb_undead_man_walking":
        if (!function_5638f689(#"zmelixirundeadmanwalking")) {
            return false;
        }
        break;
    case #"zm_bgb_whos_keeping_score":
        if (!function_5638f689(#"zmelixirwhoskeepingscore") || !function_5638f689(#"zmpowerupdouble") || !function_5638f689(#"zmpowerupsactive")) {
            return false;
        }
        break;
    case #"zm_bgb_aftertaste":
        if (!function_5638f689(#"zmelixiraftertaste")) {
            return false;
        }
        break;
    case #"zm_bgb_extra_credit":
        if (!function_5638f689(#"zmelixirextracredit") || !function_5638f689(#"zmpowerupchaospoints") || !function_5638f689(#"zmpowerupsactive")) {
            return false;
        }
        break;
    case #"zm_bgb_kill_joy":
        if (!function_5638f689(#"zmelixirkilljoy") || !function_5638f689(#"zmpowerupinstakill") || !function_5638f689(#"zmpowerupsactive")) {
            return false;
        }
        break;
    case #"zm_bgb_soda_fountain":
        if (!function_5638f689(#"zmelixirsodafountain") || !function_5638f689(#"zmperksactive")) {
            return false;
        }
        break;
    case #"zm_bgb_ctrl_z":
        if (!function_5638f689(#"zmelixirctrlz")) {
            return false;
        }
        break;
    case #"zm_bgb_free_fire":
        if (!function_5638f689(#"zmelixirfreefire")) {
            return false;
        }
        break;
    case #"zm_bgb_cache_back":
        if (!function_5638f689(#"zmelixircacheback") || !function_5638f689(#"zmpowerupmaxammo") || !function_5638f689(#"zmpowerupsactive")) {
            return false;
        }
        break;
    case #"zm_bgb_immolation_liquidation":
        if (!function_5638f689(#"zmelixirimmolationliquidation") || !function_5638f689(#"zmpowerupfiresale") || !function_5638f689(#"zmpowerupsactive") || function_5638f689(#"zmmysteryboxstate") == 0) {
            return false;
        }
        break;
    case #"zm_bgb_phoenix_up":
        if (!function_5638f689(#"zmelixirphoenixup")) {
            return false;
        }
        break;
    case #"zm_bgb_power_keg":
        if (!function_5638f689(#"zmelixirpowerkeg") || !function_5638f689(#"zmspecweaponisenabled") || !function_5638f689(#"zmpowerupspecialweapon") || !function_5638f689(#"zmpowerupsactive")) {
            return false;
        }
        break;
    case #"zm_bgb_blood_debt":
        if (!function_5638f689(#"zmelixirblooddebt")) {
            return false;
        }
        break;
    case #"zm_bgb_near_death_experience":
        if (!function_5638f689(#"zmelixirneardeathexperience")) {
            return false;
        }
        break;
    case #"zm_bgb_perkaholic":
        if (!function_5638f689(#"zmelixirperkaholic") || !function_5638f689(#"zmperksactive")) {
            return false;
        }
        break;
    case #"zm_bgb_wall_power":
        if (!function_5638f689(#"zmelixirwallpower") || function_5638f689(#"zmpapenabled") == 0) {
            return false;
        }
        break;
    case #"zm_bgb_anti_entrapment":
        if (!function_5638f689(#"zmelixirantientrapment")) {
            return false;
        }
        break;
    case #"zm_bgb_equip_mint":
        if (!function_5638f689(#"zmelixirequipmint")) {
            return false;
        }
        break;
    case #"zm_bgb_head_scan":
        if (!function_5638f689(#"zmelixirheadscan")) {
            return false;
        }
        break;
    case #"zm_bgb_join_the_party":
        if (!function_5638f689(#"zmelixirjointheparty")) {
            return false;
        }
        break;
    case #"zm_bgb_nowhere_but_there":
        if (!function_5638f689(#"zmelixirnowherebutthere")) {
            return false;
        }
        break;
    case #"zm_bgb_phantom_reload":
        if (!function_5638f689(#"zmelixirphantomreload")) {
            return false;
        }
        break;
    case #"zm_bgb_shields_up":
        if (!function_5638f689(#"zmelixirshieldsup") || !function_5638f689("zmShieldIsEnabled")) {
            return false;
        }
        break;
    case #"zm_bgb_wall_to_wall_clearance":
        if (!function_5638f689(#"zmelixirwalltowall")) {
            return false;
        }
        break;
    default:
        break;
    }
    switch (n_rarity) {
    case 0:
        if (!function_5638f689(#"zmelixirsdurables")) {
            return false;
        }
        break;
    case 2:
        if (!function_5638f689(#"zmelixirscommon")) {
            return false;
        }
        break;
    case 3:
        if (!function_5638f689(#"zmelixirsrare")) {
            return false;
        }
        break;
    case 4:
        if (!function_5638f689(#"zmelixirsepic")) {
            return false;
        }
        break;
    case 5:
        if (!function_5638f689(#"zmelixirslegendary")) {
            return false;
        }
        break;
    default:
        break;
    }
    return true;
}

// Namespace zm_custom/zm_customgame
// Params 1, eflags: 0x0
// Checksum 0x24afcd14, Offset: 0x2730
// Size: 0x194
function function_1bc3066a(s_weap) {
    if (s_weap.itemgroupname === "weapon_cqb" && !function_5638f689(#"zmweaponsshotgun") || s_weap.itemgroupname === "weapon_smg" && !function_5638f689(#"zmweaponssmg") || s_weap.itemgroupname === "weapon_assault" && !function_5638f689(#"zmweaponsar") || s_weap.itemgroupname === "weapon_tactical" && !function_5638f689(#"zmweaponstr") || s_weap.itemgroupname === "weapon_lmg" && !function_5638f689(#"zmweaponslmg") || s_weap.itemgroupname === "weapon_sniper" && !function_5638f689(#"zmweaponssniper")) {
        return false;
    }
    return true;
}

// Namespace zm_custom/zm_customgame
// Params 1, eflags: 0x0
// Checksum 0x39e33b50, Offset: 0x28d0
// Size: 0x29e
function function_3b3d4bf1(str_perk) {
    if (!isdefined(str_perk) || !function_5638f689(#"zmperksactive")) {
        return false;
    }
    switch (str_perk) {
    case #"specialty_armorvest":
        if (!function_5638f689(#"zmperksjuggernaut")) {
            return false;
        }
        break;
    case #"specialty_fastreload":
        if (!function_5638f689(#"zmperksspeed")) {
            return false;
        }
        break;
    case #"specialty_quickrevive":
        if (!function_5638f689(#"zmperksquickrevive")) {
            return false;
        }
        break;
    case #"specialty_widowswine":
        if (!function_5638f689(#"zmperkswidowswail")) {
            return false;
        }
        break;
    case #"specialty_staminup":
        if (!function_5638f689(#"zmperksstaminup")) {
            return false;
        }
        break;
    case #"specialty_additionalprimaryweapon":
        if (!function_5638f689(#"zmperksmulekick")) {
            return false;
        }
        break;
    case #"specialty_electriccherry":
        if (!function_5638f689(#"zmperkselectricburst")) {
            return false;
        }
        break;
    case #"specialty_deadshot":
        if (!function_5638f689(#"zmperksdeadshot")) {
            return false;
        }
        break;
    case #"specialty_cooldown":
        if (!function_5638f689(#"zmperkscooldown")) {
            return false;
        }
        break;
    case #"specialty_berserker":
        if (!function_5638f689(#"zmperksdyingwish")) {
            return false;
        }
        break;
    default:
        return false;
    }
    return true;
}

// Namespace zm_custom/zm_customgame
// Params 1, eflags: 0x0
// Checksum 0x5e1c434, Offset: 0x2b78
// Size: 0x2c0
function function_7b20008e(a_str_archetypes) {
    foreach (str_archetype in a_str_archetypes) {
        str_archetype = hash(str_archetype);
        if (isinarray(array(hash("blight_father")), str_archetype) && function_5638f689(#"zmminibossstate") == 0) {
            return true;
        }
        if (isinarray(array(hash("stoker"), hash("brutus"), hash("gladiator"), hash("gladiator_marauder"), hash("gladiator_destroyer")), str_archetype) && function_5638f689(#"zmheavystate") == 0) {
            return true;
        }
        if (str_archetype == "catalyst" && function_5638f689(#"hash_37698d5973834ce8") == 0) {
            return true;
        }
        if (isinarray(array(hash("bat"), hash("dog"), hash("nosferatu"), hash("tiger")), str_archetype) && function_5638f689(#"zmpopcornstate") == 0) {
            return true;
        }
    }
    return false;
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x0
// Checksum 0x3e9ed0b8, Offset: 0x2e40
// Size: 0x5a
function function_3f3efa0c() {
    if (function_5638f689(#"zmpowerupsislimitedround") && level.powerup_drop_count >= function_5638f689(#"zmpowerupslimitround")) {
        return true;
    }
    return false;
}

// Namespace zm_custom/zm_customgame
// Params 1, eflags: 0x0
// Checksum 0x6c13f5ec, Offset: 0x2ea8
// Size: 0x272
function function_163808e0(e_player) {
    self endon(#"death");
    e_player endon(#"disconnect");
    if (!zm_perks::vending_trigger_can_player_use(e_player, 1)) {
        waitframe(1);
        return;
    }
    n_slot = self.stub.script_int;
    n_cost = 2000;
    var_9ba9b184 = e_player.var_871d24d3[n_slot];
    if (!e_player zm_score::can_player_purchase(n_cost)) {
        self playsound(#"evt_perk_deny");
        e_player zm_audio::create_and_play_dialog("general", "outofmoney");
        waitframe(1);
        return;
    }
    e_player zm_score::minus_to_player_score(n_cost);
    e_player.var_ff07b668 = 1;
    sound = "evt_bottle_dispense";
    playsoundatposition(sound, self.origin);
    var_8183cdf2 = array::exclude(level.var_3d574fc8, e_player.perks_active);
    e_player.var_109ad3e3 = array::random(var_8183cdf2);
    if (!isdefined(e_player.var_109ad3e3)) {
        waitframe(1);
        return;
    }
    e_player.var_871d24d3[n_slot] = e_player.var_109ad3e3;
    e_player notify(#"perk_purchased", {#perk:e_player.var_109ad3e3});
    e_player thread zm_perks::function_25bb08(n_slot, e_player.var_109ad3e3);
    self thread zm_perks::function_dbd6062(e_player, e_player.var_109ad3e3, n_slot);
    e_player.var_ff07b668 = 0;
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x0
// Checksum 0xa0d1c35, Offset: 0x3128
// Size: 0x1e
function function_6642c67a() {
    if (function_c08fe6a2()) {
        return false;
    }
    return true;
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x0
// Checksum 0x1e044661, Offset: 0x3150
// Size: 0x40
function function_c08fe6a2() {
    if (util::get_game_type() != "zclassic") {
        return false;
    }
    return isdefined(level.var_d845a657) && level.var_d845a657;
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x0
// Checksum 0x7305fbf1, Offset: 0x3198
// Size: 0x24
function function_c5892a26() {
    self clientfield::increment_uimodel("zmhud.damage_point_shake");
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x4
// Checksum 0x1095b8f3, Offset: 0x31c8
// Size: 0xf3c
function private function_fe7bca06() {
    level thread function_51e951cf();
    function_414b38af();
    function_7e0bb202();
    function_e57be1f0();
    level waittill(#"all_players_spawned");
    function_35b464ae();
    wait 5;
    switch (function_5638f689(#"zmdoorstate")) {
    case 1:
    default:
        break;
    case 2:
        players = getplayers();
        a_zombie_doors = getentarray("zombie_door", "targetname");
        for (i = 0; i < a_zombie_doors.size; i++) {
            if (!(isdefined(a_zombie_doors[i].has_been_opened) && a_zombie_doors[i].has_been_opened)) {
                a_zombie_doors[i] notify(#"trigger", {#is_forced:1});
            }
            waitframe(1);
        }
        var_a44c3c69 = getentarray("zombie_airlock_buy", "targetname");
        for (i = 0; i < var_a44c3c69.size; i++) {
            var_a44c3c69[i] notify(#"trigger", {#is_forced:1});
            waitframe(1);
        }
        a_zombie_debris = getentarray("zombie_debris", "targetname");
        for (i = 0; i < a_zombie_debris.size; i++) {
            if (isdefined(a_zombie_debris[i])) {
                a_zombie_debris[i] notify(#"trigger", {#is_forced:1});
            }
            waitframe(1);
        }
        break;
    }
    switch (function_5638f689(#"zmpowerdoorstate")) {
    case 1:
    default:
        break;
    case 2:
        if (function_5638f689(#"zmpowerstate") != 2) {
            a_zombie_doors = getentarray("zombie_door", "targetname");
            foreach (door in a_zombie_doors) {
                if (!isdefined(door.script_noteworthy) || !isdefined(door.classname)) {
                    continue;
                }
                if (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door") {
                    door thread zm_blockers::door_opened();
                    if (isdefined(level.temporary_power_switch_logic)) {
                        door.power_on = 1;
                    }
                    continue;
                }
                if (door.script_noteworthy === "local_electric_door") {
                    door thread zm_blockers::door_opened();
                }
            }
        }
        break;
    }
    switch (function_5638f689(#"zmpowerstate")) {
    case 1:
        break;
    case 2:
        level flag::set("power_on");
        level flagsys::set(#"hash_3e80d503318a5674");
        if (function_5638f689(#"zmpowerdoorstate") == 1) {
            a_zombie_doors = getentarray("zombie_door", "targetname");
            foreach (door in a_zombie_doors) {
                if (!isdefined(door.script_noteworthy) || !isdefined(door.classname)) {
                    continue;
                }
                if (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door") {
                    door thread zm_blockers::door_opened();
                    if (isdefined(level.temporary_power_switch_logic)) {
                        door.power_on = 1;
                    }
                    continue;
                }
                if (door.script_noteworthy === "local_electric_door") {
                    door thread zm_blockers::door_opened();
                }
            }
        }
    case 0:
        a_trigs = getentarray("use_elec_switch", "targetname");
        foreach (trig in a_trigs) {
            trig notify(#"hash_21e36726a7f30458");
            trig delete();
        }
        break;
    default:
        break;
    }
    if (!function_5638f689(#"zmpowerupnuke")) {
        zm_powerups::powerup_remove_from_regular_drops("nuke");
    }
    if (!function_5638f689(#"zmpowerupdouble")) {
        zm_powerups::powerup_remove_from_regular_drops("double_points");
    }
    if (!function_5638f689(#"zmpowerupinstakill")) {
        zm_powerups::powerup_remove_from_regular_drops("insta_kill");
    }
    if (!function_5638f689(#"zmpowerupchaospoints")) {
        zm_powerups::powerup_remove_from_regular_drops("bonus_points_player");
        zm_powerups::powerup_remove_from_regular_drops("bonus_points_team");
    }
    if (!function_5638f689(#"zmpowerupfiresale")) {
        zm_powerups::powerup_remove_from_regular_drops("fire_sale");
    }
    if (!function_5638f689(#"zmpowerupspecialweapon") || !function_5638f689(#"zmspecweaponisenabled")) {
        zm_powerups::powerup_remove_from_regular_drops("hero_weapon_power");
    }
    if (!function_5638f689(#"zmpowerupfreeperk")) {
        zm_powerups::powerup_remove_from_regular_drops("free_perk");
    }
    if (!function_5638f689(#"zmpowerupmaxammo")) {
        zm_powerups::powerup_remove_from_regular_drops("full_ammo");
    }
    if (!function_5638f689(#"zmpowerupcarpenter")) {
        zm_powerups::powerup_remove_from_regular_drops("carpenter");
    }
    if (!isdefined(level.var_5a17cfc9)) {
        level.var_5a17cfc9 = [];
    }
    foreach (s_weap in level.zombie_weapons) {
        if (s_weap.weapon_classname == "pistol" && !function_5638f689(#"zmweaponspistol") || s_weap.weapon_classname == "shotgun" && !function_5638f689(#"zmweaponsshotgun") || s_weap.weapon_classname == "smg" && !function_5638f689(#"zmweaponssmg") || s_weap.weapon_classname == "ar" && !function_5638f689(#"zmweaponsar") || s_weap.weapon_classname == "tr" && !function_5638f689(#"zmweaponstr") || s_weap.weapon_classname == "lmg" && !function_5638f689(#"zmweaponslmg") || s_weap.weapon_classname == "sniper" && !function_5638f689(#"zmweaponssniper") || s_weap.weapon_classname == "melee" && !function_5638f689(#"zmweaponsknife") || s_weap.weapon_classname == "equipment" && !function_5638f689(#"zmequipmentisenabled")) {
            if (!isdefined(level.var_5a17cfc9)) {
                level.var_5a17cfc9 = [];
            } else if (!isarray(level.var_5a17cfc9)) {
                level.var_5a17cfc9 = array(level.var_5a17cfc9);
            }
            if (!isinarray(level.var_5a17cfc9, s_weap.weapon)) {
                level.var_5a17cfc9[level.var_5a17cfc9.size] = s_weap.weapon;
            }
        }
    }
    if (!function_5638f689(#"zmshieldisenabled")) {
        foreach (str_bp in array("zblueprint_shield", "zblueprint_shield_dual_wield", "zblueprint_zhield_zword", "zblueprint_shield_spectral_shield")) {
            zm_crafting::function_4b55c808(hash(str_bp));
        }
    }
    if (!function_5638f689(#"zmbarricadestate")) {
        level.no_board_repair = 1;
        level flag::wait_till("all_players_spawned");
        zm_blockers::function_e64ab78b();
        level.no_board_repair = 1;
    }
    switch (function_5638f689(#"zmequipmentchargerate")) {
    case 1:
        setgametypesetting("scoreEquipmentPowerTimeFactor", 1);
        break;
    case 2:
        setgametypesetting("scoreEquipmentPowerTimeFactor", 2);
        break;
    case 0:
        setgametypesetting("scoreEquipmentPowerTimeFactor", 0.5);
        break;
    }
    level flag::wait_till("all_players_spawned");
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x4
// Checksum 0x8584ebbe, Offset: 0x4110
// Size: 0xa4
function private function_51e951cf() {
    level waittill(#"start_of_round");
    if (function_5638f689(#"zmroundcap") && function_5638f689(#"startround") > function_5638f689(#"zmroundcap")) {
        wait 1;
        function_c4cdc40c("zmRoundCap");
    }
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x4
// Checksum 0xc01d4813, Offset: 0x41c0
// Size: 0x5e2
function private function_143f7288() {
    self endon(#"disconnect");
    player = self;
    level flag::wait_till("all_players_spawned");
    n_regen_delay = function_5638f689(#"zmhealthregendelay");
    n_regen_rate = function_5638f689(#"zmhealthregenrate");
    n_health_on_kill = function_5638f689(#"zmhealthonkill");
    n_health_drain = function_5638f689(#"zmhealthdrain");
    switch (function_5638f689(#"zmhealthstartingbars")) {
    case 3:
    default:
        var_5375bd93 = 0;
        break;
    case 4:
        var_5375bd93 = 1;
        break;
    case 5:
        var_5375bd93 = 2;
        break;
    case 6:
        var_5375bd93 = 3;
        break;
    case 2:
        var_5375bd93 = -1;
        break;
    case 1:
        var_5375bd93 = -2;
        break;
    case 0:
        var_5375bd93 = -3;
        break;
    }
    n_target = int(max(zombie_utility::get_zombie_var(#"player_base_health") + 50 * var_5375bd93, 1));
    n_mod = math::clamp(n_target - player.var_63f2cd6e, 0, n_target);
    player player::function_129882c1(#"custom_settings", n_mod);
    player.var_63f2cd6e = n_target;
    player setmaxhealth(player.var_63f2cd6e);
    player zm_utility::set_max_health();
    println("<dev string:x58>" + player.name + "<dev string:x61>" + player.var_63f2cd6e);
    switch (n_regen_delay) {
    case 0:
        player.n_regen_delay = 2;
        break;
    case 1:
        player.n_regen_delay = zombie_utility::get_zombie_var("player_health_regen_delay");
        break;
    case 2:
        player.n_regen_delay = 8;
        break;
    }
    switch (n_regen_rate) {
    case 0:
        player.var_36b14302 = 1;
        break;
    case 1:
        player.n_regen_rate = 50;
        break;
    case 2:
        player.n_regen_rate = zombie_utility::get_zombie_var("player_health_regen_rate");
        break;
    case 3:
        player.n_regen_rate = 12.5;
        break;
    case 4:
        player.n_regen_rate = 0;
        break;
    }
    switch (n_health_on_kill) {
    case 0:
        break;
    case 1:
        player.n_health_on_kill = 10;
        break;
    case 2:
        player.n_health_on_kill = 25;
        break;
    case 3:
        player.n_health_on_kill = 50;
        break;
    }
    switch (n_health_drain) {
    case 0:
        break;
    case 1:
        player thread drain_health(6);
        break;
    case 2:
        player thread drain_health(3);
        break;
    case 3:
        player thread drain_health(1);
        break;
    }
}

// Namespace zm_custom/zm_customgame
// Params 1, eflags: 0x4
// Checksum 0xd8dae454, Offset: 0x47b0
// Size: 0x100
function private drain_health(var_7e52931b) {
    self notify(#"hash_13fcb28a561bd5fe");
    self endon(#"disconnect", #"hash_13fcb28a561bd5fe");
    level endon(#"game_ended");
    self.heal.enabled = 0;
    while (zombie_utility::get_current_zombie_count() == 0) {
        waitframe(1);
    }
    while (true) {
        if (self.health <= 0 || self laststand::player_is_in_laststand() || isdefined(self.var_e99541c5) && self.var_e99541c5) {
            waitframe(1);
            continue;
        }
        wait var_7e52931b;
        self dodamage(5, self.origin);
    }
}

// Namespace zm_custom/zm_customgame
// Params 11, eflags: 0x4
// Checksum 0x162f6458, Offset: 0x48b8
// Size: 0x82
function private function_a9d4f59(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    idamage = int(idamage * 0.25);
    return idamage;
}

// Namespace zm_custom/zm_customgame
// Params 11, eflags: 0x4
// Checksum 0x4b93fc8f, Offset: 0x4948
// Size: 0x9e
function private function_e69bfe91(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    idamage = int(idamage * 0.25);
    eattacker dodamage(idamage, self.origin);
    return false;
}

// Namespace zm_custom/zm_customgame
// Params 11, eflags: 0x4
// Checksum 0x3bcc6def, Offset: 0x49f0
// Size: 0xa0
function private function_521772b1(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    idamage = int(idamage * 0.25 / 2);
    eattacker dodamage(idamage, self.origin);
    return idamage;
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x4
// Checksum 0x26a547c4, Offset: 0x4a98
// Size: 0x172
function private function_414b38af() {
    var_b788d676 = function_5638f689(#"zmpointsfixed");
    var_ef96e25a = function_5638f689(#"zmpointsstarting") * 100;
    var_3aef63a1 = function_5638f689(#"hash_5566698b97a6282e");
    var_6f6b9c5c = function_5638f689(#"zmpointslosstype");
    var_ed8e12ff = function_5638f689(#"zmpointslosspercent");
    var_98a8db8f = function_5638f689(#"zmpointslossvalue");
    if (var_ef96e25a != 500) {
        level.player_starting_points = var_ef96e25a;
    }
    if (var_b788d676) {
        level.var_430873e5 = 1;
    }
    if (var_6f6b9c5c) {
        if (var_6f6b9c5c == 1) {
            level.var_1c3ca9f2 = var_ed8e12ff / 100;
            return;
        }
        level.var_132a7f92 = var_98a8db8f;
    }
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x4
// Checksum 0x1a7d6fda, Offset: 0x4c18
// Size: 0x102
function private function_2680579f() {
    self endon(#"disconnect");
    level flag::wait_till("start_zombie_round_logic");
    waitframe(1);
    var_25eb7190 = function_5638f689(#"zmlaststandduration");
    switch (var_25eb7190) {
    case 0:
        self.var_b02abc40 = 1;
        self zm_laststand::function_7996dd34(0);
        return;
    case 1:
        self.var_5e981063 = 20;
        break;
    case 2:
        break;
    case 3:
        self.var_5e981063 = 60;
        break;
    }
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x4
// Checksum 0x73344691, Offset: 0x4d28
// Size: 0x6c
function private function_8a7511a1() {
    if (!function_5638f689(#"zmweaponsmelee")) {
        self allowmelee(0);
        self thread function_88141d5b();
        self thread function_eb018197();
    }
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x4
// Checksum 0x684bd0aa, Offset: 0x4da0
// Size: 0xc8
function private function_f2c9f706() {
    if (!function_5638f689(#"zmequipmentisenabled") && isdefined(self.slot_weapons[#"lethal_grenade"])) {
        self takeweapon(self.slot_weapons[#"lethal_grenade"]);
    }
    if (!function_5638f689(#"zmweaponspistol") && self hasweapon(getweapon(#"pistol_topbreak_t8"))) {
    }
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x4
// Checksum 0xa3d2bda9, Offset: 0x4e70
// Size: 0x80
function private function_88141d5b() {
    self endon(#"death");
    while (true) {
        self waittill(#"hero_weapon_power_on");
        self allowmelee(1);
        self waittill(#"hero_weapon_power_off");
        self allowmelee(0);
    }
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x4
// Checksum 0x99d84fc3, Offset: 0x4ef8
// Size: 0x70
function private function_eb018197() {
    self endon(#"death");
    while (true) {
        self waittill(#"crafting_fail", #"crafting_success", #"bgb_update");
        self allowmelee(0);
    }
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x4
// Checksum 0x4d1a8f1d, Offset: 0x4f70
// Size: 0x48a
function private function_35b464ae() {
    var_d0123576 = function_5638f689(#"zmcrawlerstate");
    var_6055b745 = function_5638f689(#"zmzombiespread");
    var_d95af459 = function_5638f689(#"zmzombieminspeed");
    var_89404ff7 = function_5638f689(#"zmzombiemaxspeed");
    var_b326c393 = function_5638f689(#"zmzombiehealthmult");
    var_29b03f64 = function_5638f689(#"zmzombiedamagemult");
    switch (var_d0123576) {
    case 1:
        break;
    case 0:
        level.var_387e0d0f = 1;
        break;
    case 2:
        level.var_a7873a6 = 1;
        break;
    }
    switch (var_6055b745) {
    case 0:
        level.zigzag_activation_distance = 256;
        level.inner_zigzag_radius = 0;
        level.outer_zigzag_radius = 16;
        level.zigzag_distance_min = 16;
        level.zigzag_distance_max = 512;
        break;
    case 1:
        break;
    case 2:
        level.zigzag_activation_distance = 16;
        level.inner_zigzag_radius = 256;
        level.outer_zigzag_radius = 2048;
        level.zigzag_distance_min = 128;
        level.zigzag_distance_max = 1024;
        break;
    }
    switch (var_d95af459) {
    case 0:
        break;
    case 1:
        level.var_b43e213c = "run";
        break;
    case 2:
        level.var_b43e213c = "sprint";
        break;
    case 3:
        level.var_b43e213c = "super_sprint";
        break;
    }
    switch (var_89404ff7) {
    case 0:
        level.var_b02d530a = "walk";
        break;
    case 1:
        level.var_b02d530a = "run";
        break;
    case 2:
        level.var_b02d530a = "sprint";
        break;
    case 3:
        break;
    }
    switch (var_29b03f64) {
    case 1:
        break;
    case 0:
        level.var_29b03f64 = 0.5;
        break;
    case 2:
        level.var_29b03f64 = 2;
        break;
    }
    switch (var_b326c393) {
    case 1:
        break;
    case 0:
        level.var_b326c393 = 0.5;
        break;
    case 2:
        level.var_b326c393 = 2;
        break;
    }
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x4
// Checksum 0xb6eabf14, Offset: 0x5408
// Size: 0xad2
function private function_7e0bb202() {
    var_fddd2648 = function_5638f689(#"zmheavystate");
    var_5952ea6b = function_5638f689(#"zmheavydamagemult");
    var_fff66c5c = function_5638f689(#"zmheavyhealthmult");
    var_448454f6 = function_5638f689(#"zmheavyspawnfreq");
    var_bbf62797 = function_5638f689(#"zmminibossstate");
    var_64928180 = function_5638f689(#"zmminibossdamagemult");
    var_a915bb7 = function_5638f689(#"zmminibosshealthmult");
    var_eda2a7ad = function_5638f689(#"zmminibossspawnfreq");
    var_d133b7b0 = function_5638f689(#"hash_37698d5973834ce8");
    var_2ca00c83 = function_5638f689(#"hash_23d7891cf2b9471c");
    var_8c9ffe54 = function_5638f689(#"hash_6d8c09b7927b8d9b");
    var_cb2b871e = function_5638f689(#"hash_f370576ccd22b54");
    var_a8ae2c42 = function_5638f689(#"zmpopcornstate");
    var_49ea6ed = function_5638f689(#"zmpopcorndamagemult");
    var_702ddaaa = function_5638f689(#"zmpopcornhealthmult");
    var_990e6314 = function_5638f689(#"zmpopcornspawnfreq");
    switch (var_fddd2648) {
    case 1:
        break;
    case 0:
        level.var_ae44635d = 1;
        break;
    case 2:
        level.var_2a40757c = 1;
        level.var_cc46bee = 1;
        break;
    }
    switch (var_5952ea6b) {
    case 1:
        break;
    case 0:
        level.var_5952ea6b = 0.5;
        break;
    case 2:
        level.var_5952ea6b = 2;
        break;
    }
    switch (var_fff66c5c) {
    case 1:
        break;
    case 0:
        level.var_fff66c5c = 0.5;
        break;
    case 2:
        level.var_fff66c5c = 2;
        break;
    }
    switch (var_448454f6) {
    case 1:
    default:
        break;
    case 0:
        level.var_2e9e915f = 0.5;
        break;
    case 2:
        level.var_2e9e915f = 2;
        break;
    case 3:
        level.var_2e9e915f = 4;
        break;
    }
    switch (var_bbf62797) {
    case 1:
        break;
    case 0:
        level.var_28d1499a = 1;
        break;
    case 2:
        level.var_595dcfa9 = 1;
        level.var_cc46bee = 1;
        break;
    }
    switch (var_64928180) {
    case 1:
        break;
    case 0:
        level.var_64928180 = 0.5;
        break;
    case 2:
        level.var_64928180 = 2;
        break;
    }
    switch (var_a915bb7) {
    case 1:
        break;
    case 0:
        level.var_a915bb7 = 0.5;
        break;
    case 2:
        level.var_a915bb7 = 2;
        break;
    }
    switch (var_eda2a7ad) {
    case 1:
    default:
        break;
    case 0:
        level.var_7a71e248 = 0.5;
        break;
    case 2:
        level.var_7a71e248 = 2;
        break;
    case 3:
        level.var_7a71e248 = 4;
        break;
    }
    switch (var_d133b7b0) {
    case 1:
        break;
    case 0:
        level.var_fe2329bd = 1;
        break;
    case 2:
        level.var_c7ce8d5c = 1;
        level.var_cc46bee = 1;
        break;
    }
    switch (var_2ca00c83) {
    case 1:
        break;
    case 0:
        level.var_2ca00c83 = 0.5;
        break;
    case 2:
        level.var_2ca00c83 = 2;
        break;
    }
    switch (var_8c9ffe54) {
    case 1:
        break;
    case 0:
        level.var_8c9ffe54 = 0.5;
        break;
    case 2:
        level.var_8c9ffe54 = 2;
        break;
    }
    switch (var_cb2b871e) {
    case 1:
    default:
        break;
    case 0:
        level.var_269a9bf7 = 0.5;
        break;
    case 2:
        level.var_269a9bf7 = 2;
        break;
    case 3:
        level.var_269a9bf7 = 4;
        break;
    }
    switch (var_a8ae2c42) {
    case 1:
        break;
    case 0:
        level.var_c643d497 = 1;
        break;
    case 2:
        level.var_1e301b4e = 1;
        break;
    }
    switch (var_49ea6ed) {
    case 1:
        break;
    case 0:
        level.var_49ea6ed = 0.5;
        break;
    case 2:
        level.var_49ea6ed = 2;
        break;
    }
    switch (var_702ddaaa) {
    case 1:
        break;
    case 0:
        level.var_702ddaaa = 0.5;
        break;
    case 2:
        level.var_702ddaaa = 2;
        break;
    }
    switch (var_990e6314) {
    case 1:
    default:
        break;
    case 0:
        level.var_92839a29 = 0.5;
        break;
    case 2:
        level.var_92839a29 = 2;
        break;
    case 3:
        level.var_92839a29 = 4;
        break;
    }
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x4
// Checksum 0x8ec30491, Offset: 0x5ee8
// Size: 0x31c
function private function_1309bfff() {
    timer = function_5638f689(#"zmtimecap") * 60;
    if (timer === 0) {
        return;
    }
    level endon(#"game_ended");
    level waittill(#"start_of_round");
    while (timer >= 0) {
        if (function_5638f689(#"zmshowtimer")) {
            n_minutes = int(floor(timer / 60));
            n_seconds = int(timer - n_minutes * 60);
            foreach (player in util::get_active_players()) {
                if (!level.zmGameTimer zm_game_timer::is_open(player)) {
                    level.zmGameTimer zm_game_timer::open(player);
                }
                level.zmGameTimer zm_game_timer::set_minutes(player, n_minutes);
                level.zmGameTimer zm_game_timer::set_seconds(player, n_seconds);
                if (n_seconds < 10) {
                    level.zmGameTimer zm_game_timer::set_showzero(player, 1);
                    continue;
                }
                level.zmGameTimer zm_game_timer::set_showzero(player, 0);
            }
        }
        wait 1;
        timer -= 1;
    }
    foreach (player in util::get_active_players()) {
        if (level.zmGameTimer zm_game_timer::is_open(player)) {
            level.zmGameTimer zm_game_timer::close(player);
        }
    }
    function_c4cdc40c("zmTimeCap");
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x4
// Checksum 0xa035d146, Offset: 0x6210
// Size: 0xfc
function private function_7128f2cd() {
    level flagsys::wait_till("all_players_spawned");
    if (function_5638f689(#"hash_404dff39285c417")) {
        str_team = level.players[0].team;
        n_players = level.players.size;
        var_fca7c46a = min(function_5638f689(#"hash_48e3333559fd6e2c"), 4 - n_players);
        bot::add_bots(var_fca7c46a, str_team);
        callback::on_connect(&function_653faad4);
    }
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x4
// Checksum 0x4299ba7f, Offset: 0x6318
// Size: 0x5c
function private function_653faad4() {
    self endon(#"disconnect");
    self waittill(#"spawned");
    if (level.players.size < 4) {
        bot::add_bots(1, self.team);
    }
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x4
// Checksum 0xeb00fe83, Offset: 0x6380
// Size: 0x164
function private function_fb65052a() {
    if (!function_5638f689(#"zmspecialroundsenabled")) {
        while (!flag::exists(#"disable_special_rounds")) {
            waitframe(1);
        }
        level flag::set(#"disable_special_rounds");
    }
    n_start = function_5638f689(#"startround");
    if (n_start > 1) {
        level waittill(#"start_of_round");
        for (i = 0; i < n_start; i++) {
            if (isdefined(level.var_73f9d658) && isdefined(level.var_73f9d658[i])) {
                for (var_f74e621 = i + n_start; isdefined(level.var_73f9d658[var_f74e621]); var_f74e621++) {
                }
                level.var_73f9d658[var_f74e621] = level.var_73f9d658[i];
            }
        }
    }
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x4
// Checksum 0x2ef71afe, Offset: 0x64f0
// Size: 0x2f7a
function private function_8407b264() {
    return array({#name:#"hash_404dff39285c417", #default_val:0}, {#name:#"hash_48e3333559fd6e2c", #default_val:1}, {#name:#"startround", #default_val:1}, {#name:#"magic", #default_val:1}, {#name:#"allowdogs", #default_val:0}, {#name:#"headshotsonly", #default_val:0}, {#name:#"hash_678c1d3307b1d73a", #default_val:0}, {#name:#"zmroundcap", #default_val:0}, {#name:#"zmtimecap", #default_val:0}, {#name:#"zmshowtimer", #default_val:0}, {#name:#"zmkillcap", #default_val:0}, {#name:#"zmdoorstate", #default_val:1}, {#name:#"zmspecialroundsenabled", #default_val:1}, {#name:#"zmendonquest", #default_val:0}, {#name:#"zmmysteryboxstate", #default_val:2}, {#name:#"hash_5d65c0983698a539", #default_val:0}, {#name:#"zmmysteryboxlimitmove", #default_val:0}, {#name:#"hash_23fe21eb92ffbc2c", #default_val:0}, {#name:#"zmmysteryboxlimit", #default_val:0}, {#name:#"hash_751384283abde22c", #default_val:0}, {#name:#"zmmysteryboxlimitround", #default_val:0}, {#name:#"zmpowerstate", #default_val:1}, {#name:#"zmpowerdoorstate", #default_val:1}, {#name:#"zmperksactive", #default_val:1}, {#name:#"zmperksjuggernaut", #default_val:1}, {#name:#"zmperksspeed", #default_val:1}, {#name:#"zmperksquickrevive", #default_val:1}, {#name:#"zmperkswidowswail", #default_val:1}, {#name:#"zmperksstaminup", #default_val:1}, {#name:#"zmperksmulekick", #default_val:1}, {#name:#"zmperkselectricburst", #default_val:1}, {#name:#"zmperksdeadshot", #default_val:1}, {#name:#"zmperkscooldown", #default_val:1}, {#name:#"zmperksdyingwish", #default_val:1}, {#name:#"zmpapenabled", #default_val:1}, {#name:#"zmsuperpapenabled", #default_val:1}, {#name:#"zmpowerupsactive", #default_val:1}, {#name:#"zmpowerupnuke", #default_val:1}, {#name:#"zmpowerupdouble", #default_val:1}, {#name:#"zmpowerupinstakill", #default_val:1}, {#name:#"zmpowerupchaospoints", #default_val:1}, {#name:#"zmpowerupfiresale", #default_val:1}, {#name:#"zmpowerupspecialweapon", #default_val:1}, {#name:#"zmpowerupfreeperk", #default_val:1}, {#name:#"zmpowerupmaxammo", #default_val:1}, {#name:#"zmpowerupcarpenter", #default_val:1}, {#name:#"zmpowerupsislimitedround", #default_val:0}, {#name:#"zmpowerupslimitround", #default_val:0}, {#name:#"zmpowerupsharing", #default_val:1}, {#name:#"zmwallbuysenabled", #default_val:1}, {#name:#"zmrandomwallbuys", #default_val:0}, {#name:#"zmelixirsenabled", #default_val:1}, {#name:#"zmelixirscooldown", #default_val:1}, {#name:#"zmelixirsindividual", #default_val:1}, {#name:#"zmelixirsdurables", #default_val:1}, {#name:#"zmelixirscommon", #default_val:1}, {#name:#"zmelixirsrare", #default_val:1}, {#name:#"zmelixirslegendary", #default_val:1}, {#name:#"zmelixirsepic", #default_val:1}, {#name:#"zmtalismansenabled", #default_val:1}, {#name:#"zmtalismansindividual", #default_val:1}, {#name:#"zmtalismanscommon", #default_val:1}, {#name:#"zmtalismansrare", #default_val:1}, {#name:#"zmtalismanslegendary", #default_val:1}, {#name:#"zmtalismansepic", #default_val:1}, {#name:#"zmweaponspistol", #default_val:1}, {#name:#"zmweaponsshotgun", #default_val:1}, {#name:#"zmweaponssmg", #default_val:1}, {#name:#"zmweaponsar", #default_val:1}, {#name:#"zmweaponstr", #default_val:1}, {#name:#"zmweaponslmg", #default_val:1}, {#name:#"zmweaponssniper", #default_val:1}, {#name:#"zmweaponsknife", #default_val:1}, {#name:#"zmweaponsmelee", #default_val:1}, {#name:#"zmspecweaponisenabled", #default_val:1}, {#name:#"zmspecweaponchargerate", #default_val:1}, {#name:#"zmwonderweaponisenabled", #default_val:1}, {#name:#"zmequipmentisenabled", #default_val:1}, {#name:#"zmequipmentchargerate", #default_val:1}, {#name:#"zmshieldisenabled", #default_val:1}, {#name:#"zmshielddurability", #default_val:1}, {#name:#"zmheadshotsonly", #default_val:0}, {#name:#"zmrunnerstate", #default_val:0}, {#name:#"zmwalkerstate", #default_val:0}, {#name:#"zmcrawlerstate", #default_val:1}, {#name:#"zmzombiespread", #default_val:1}, {#name:#"zmzombieminspeed", #default_val:0}, {#name:#"zmzombiemaxspeed", #default_val:3}, {#name:#"zmzombiedamagemult", #default_val:1}, {#name:#"zmzombiehealthmult", #default_val:1}, {#name:#"zmcrawlerdamagemult", #default_val:1}, {#name:#"zmcrawlerhealthmult", #default_val:1}, {#name:#"zmcrawleraggro", #default_val:1}, {#name:#"zmheavystate", #default_val:1}, {#name:#"zmheavydamagemult", #default_val:1}, {#name:#"zmheavyhealthmult", #default_val:1}, {#name:#"zmheavyaggro", #default_val:1}, {#name:#"zmminibossstate", #default_val:1}, {#name:#"zmminibossdamagemult", #default_val:1}, {#name:#"zmminibosshealthmult", #default_val:1}, {#name:#"zmminibossaggro", #default_val:1}, {#name:#"hash_37698d5973834ce8", #default_val:1}, {#name:#"hash_23d7891cf2b9471c", #default_val:1}, {#name:#"hash_6d8c09b7927b8d9b", #default_val:1}, {#name:#"hash_1e45aded9d98eb83", #default_val:1}, {#name:#"zmhealthstartingbars", #default_val:3}, {#name:#"zmhealthregendelay", #default_val:1}, {#name:#"zmhealthregenrate", #default_val:2}, {#name:#"zmhealthonkill", #default_val:0}, {#name:#"zmhealthdrain", #default_val:0}, {#name:#"zmpointsfixed", #default_val:0}, {#name:#"zmpointsstarting", #default_val:5}, {#name:#"hash_5566698b97a6282e", #default_val:0}, {#name:#"zmpointslosstype", #default_val:0}, {#name:#"zmpointslosspercent", #default_val:0}, {#name:#"zmpointslossvalue", #default_val:0}, {#name:#"zmlaststandduration", #default_val:2}, {#name:#"hash_12f776f6bc579bb4", #default_val:0}, {#name:#"zmlimiteddownsamount", #default_val:0}, {#name:#"zmbarricadestate", #default_val:1}, {#name:#"hash_3c5363541b97ca3e", #default_val:1}, {#name:#"zmpowerupfrequency", #default_val:1}, {#name:#"zmtalismanboxguaranteeboxonly", #default_val:1}, {#name:#"zmtalismanboxguaranteelmg", #default_val:1}, {#name:#"hash_61695e52556ff2d1", #default_val:1}, {#name:#"zmtalismancoagulant", #default_val:1}, {#name:#"zmtalismanextraclaymore", #default_val:1}, {#name:#"zmtalismanextrafrag", #default_val:1}, {#name:#"zmtalismanextraminiturret", #default_val:1}, {#name:#"zmtalismanextramolotov", #default_val:1}, {#name:#"zmtalismanextrasemtex", #default_val:1}, {#name:#"zmtalismanimpatient", #default_val:1}, {#name:#"zmtalismanperkmodsingle", #default_val:1}, {#name:#"zmtalismanperkpermanent1", #default_val:1}, {#name:#"zmtalismanperkpermanent2", #default_val:1}, {#name:#"zmtalismanperkpermanent3", #default_val:1}, {#name:#"zmtalismanperkpermanent4", #default_val:1}, {#name:#"zmtalismanperkreducecost1", #default_val:1}, {#name:#"zmtalismanperkreducecost2", #default_val:1}, {#name:#"zmtalismanperkreducecost3", #default_val:1}, {#name:#"zmtalismanperkreducecost4", #default_val:1}, {#name:#"zmtalismanperkstart1", #default_val:1}, {#name:#"zmtalismanperkstart2", #default_val:1}, {#name:#"zmtalismanperkstart3", #default_val:1}, {#name:#"zmtalismanperkstart4", #default_val:1}, {#name:#"zmtalismanshielddurabilitylegendary", #default_val:1}, {#name:#"zmtalismanshielddurabilityrare", #default_val:1}, {#name:#"zmtalismanshieldprice", #default_val:1}, {#name:#"zmtalismanspecialstartlvl2", #default_val:1}, {#name:#"zmtalismanspecialstartlvl3", #default_val:1}, {#name:#"zmtalismanspecialxprate", #default_val:1}, {#name:#"zmtalismanstartweaponar", #default_val:1}, {#name:#"zmtalismanstartweaponlmg", #default_val:1}, {#name:#"zmtalismanstartweaponsmg", #default_val:1}, {#name:#"zmtalismanreducepapcost", #default_val:1}, {#name:#"zmtalismansultra", #default_val:1}, {#name:#"zmelixiralwaysdoneswiftly", #default_val:1}, {#name:#"zmelixiranywherebuthere", #default_val:1}, {#name:#"zmelixirarsenalaccelerator", #default_val:1}, {#name:#"zmelixirdangerclosest", #default_val:1}, {#name:#"zmelixirinplainsight", #default_val:1}, {#name:#"zmelixirnewtoniannegation", #default_val:1}, {#name:#"zmelixirnowyouseeme", #default_val:1}, {#name:#"zmelixirstockoption", #default_val:1}, {#name:#"zmelixirboardgames", #default_val:1}, {#name:#"zmelixirburnedout", #default_val:1}, {#name:#"zmelixircrawlspace", #default_val:1}, {#name:#"zmelixirpopshocks", #default_val:1}, {#name:#"hash_7c2b2a861115fd94", #default_val:1}, {#name:#"zmelixirtemporalgift", #default_val:1}, {#name:#"zmelixirpointdrops", #default_val:1}, {#name:#"zmelixiralchemicalantithesis", #default_val:1}, {#name:#"zmelixirswordflay", #default_val:1}, {#name:#"zmelixirdeadofnuclearwinter", #default_val:1}, {#name:#"zmelixirlicensedcontractor", #default_val:1}, {#name:#"zmelixirundeadmanwalking", #default_val:1}, {#name:#"zmelixirwhoskeepingscore", #default_val:1}, {#name:#"zmelixiraftertaste", #default_val:1}, {#name:#"zmelixirextracredit", #default_val:1}, {#name:#"zmelixirkilljoy", #default_val:1}, {#name:#"zmelixirsodafountain", #default_val:1}, {#name:#"zmelixirctrlz", #default_val:1}, {#name:#"zmelixirfreefire", #default_val:1}, {#name:#"zmelixircacheback", #default_val:1}, {#name:#"zmelixirimmolationliquidation", #default_val:1}, {#name:#"zmelixirphoenixup", #default_val:1}, {#name:#"zmelixirpowerkeg", #default_val:1}, {#name:#"zmelixirblooddebt", #default_val:1}, {#name:#"zmelixirneardeathexperience", #default_val:1}, {#name:#"zmelixirperkaholic", #default_val:1}, {#name:#"zmelixirwallpower", #default_val:1}, {#name:#"hash_429b520a87274afb", #default_val:0}, {#name:#"zmtrapsenabled", #default_val:1}, {#name:#"zmstartingweaponenabled", #default_val:1}, {#name:#"hash_f370576ccd22b54", #default_val:1}, {#name:#"zmheavyspawnfreq", #default_val:1}, {#name:#"zmminibossspawnfreq", #default_val:1}, {#name:#"zmselfreviveamount", #default_val:0}, {#name:#"zmpopcornstate", #default_val:1}, {#name:#"zmpopcorndamagemult", #default_val:1}, {#name:#"zmpopcornhealthmult", #default_val:1}, {#name:#"zmpopcornspawnfreq", #default_val:1}, {#name:#"zmretainweapons", #default_val:1}, {#name:#"zmperkdecay", #default_val:1}, {#name:#"zmcraftingkeyline", #default_val:0}, {#name:#"zmpointlossondown", #default_val:0}, {#name:#"zmpointlossondeath", #default_val:0}, {#name:#"zmpointlossonteammatedeath", #default_val:0}, {#name:#"zmelixirantientrapment", #default_val:1}, {#name:#"zmelixirequipmint", #default_val:1}, {#name:#"zmelixirheadscan", #default_val:1}, {#name:#"zmelixirjointheparty", #default_val:1}, {#name:#"zmelixirnowherebutthere", #default_val:1}, {#name:#"zmelixirphantomreload", #default_val:1}, {#name:#"zmelixirshieldsup", #default_val:1}, {#name:#"zmelixirwalltowall", #default_val:1}, {#name:#"zmperksbandolier", #default_val:1}, {#name:#"zmperksdeathperception", #default_val:1}, {#name:#"zmperksphdslider", #default_val:1}, {#name:#"zmperkssecretsauce", #default_val:1}, {#name:#"zmperksstonecold", #default_val:1}, {#name:#"zmperksvictorious", #default_val:1});
}

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x0
// Checksum 0xc8458690, Offset: 0x9478
// Size: 0x6
function function_a5ce341b() {
    return false;
}

/#

    // Namespace zm_custom/zm_customgame
    // Params 0, eflags: 0x4
    // Checksum 0xb5cbeeb7, Offset: 0x9488
    // Size: 0x58c
    function private function_5793a336() {
        if (getdvarint(#"hash_459b2d01242f9fd4", 0)) {
            setgametypesetting("<dev string:x7e>", 9);
            setgametypesetting("<dev string:x89>", 2);
            setgametypesetting("<dev string:xa0>", 2);
            setgametypesetting("<dev string:xb1>", 2);
            setgametypesetting("<dev string:xc4>", 0);
            setgametypesetting("<dev string:xd7>", 1);
            setgametypesetting("<dev string:xe9>", 9);
            setgametypesetting("<dev string:xfe>", 2);
            setgametypesetting("<dev string:x111>", 1);
            setgametypesetting("<dev string:x122>", 9);
        }
        if (getdvarint(#"hash_18b717f0d84d2ee6", 0)) {
            setgametypesetting("<dev string:x136>", 4);
            setgametypesetting("<dev string:x7e>", 6);
            setgametypesetting("<dev string:x14b>", 1);
            setgametypesetting("<dev string:xa0>", 2);
            setgametypesetting("<dev string:x15c>", 2);
            setgametypesetting("<dev string:x16e>", 2);
            setgametypesetting("<dev string:x182>", 0);
            setgametypesetting("<dev string:x196>", 0);
        }
        if (getdvarint(#"hash_712656a2976e26c6", 0)) {
            setgametypesetting("<dev string:x1ab>", 40);
            setgametypesetting("<dev string:x1bc>", 1);
            setgametypesetting("<dev string:x1ca>", 0);
            setgametypesetting("<dev string:x1dc>", 3);
            setgametypesetting("<dev string:x1ee>", 0);
            setgametypesetting("<dev string:x1fe>", 0);
            setgametypesetting("<dev string:x211>", 0);
            setgametypesetting("<dev string:x226>", 0);
            setgametypesetting("<dev string:x238>", 0);
            setgametypesetting("<dev string:x24a>", 0);
            setgametypesetting("<dev string:x25d>", 1);
            setgametypesetting("<dev string:x272>", 3);
            setgametypesetting("<dev string:x286>", 0);
            setgametypesetting("<dev string:x296>", 0);
        }
        if (getdvarint(#"hash_6e1983b84de27c22", 0)) {
            setgametypesetting("<dev string:x136>", 6);
            setgametypesetting("<dev string:xd7>", 4);
            setgametypesetting("<dev string:x2a3>", 3);
            setgametypesetting("<dev string:x2b1>", 2);
            setgametypesetting("<dev string:xe9>", 10);
            setgametypesetting("<dev string:x7e>", 5);
            setgametypesetting("<dev string:x2c0>", 0);
            setgametypesetting("<dev string:xb1>", 2);
            setgametypesetting("<dev string:x2d3>", 0);
            setgametypesetting("<dev string:x2e4>", 0);
            setgametypesetting("<dev string:x2f7>", 0);
            setgametypesetting("<dev string:x307>", 2);
        }
    }

    // Namespace zm_custom/zm_customgame
    // Params 0, eflags: 0x4
    // Checksum 0xa8a03e75, Offset: 0x9a20
    // Size: 0x4b6
    function private function_5cbcc9f9() {
        level endon(#"game_ended");
        level waittill(#"all_players_spawned");
        var_dd75d3e1 = function_89d02538();
        var_17719d5e = array();
        var_cab39a16 = 0;
        var_2decd2ef = 0;
        foreach (s_var in var_dd75d3e1) {
            if (s_var.name.size > var_2decd2ef) {
                var_2decd2ef = s_var.name.size;
            }
        }
        for (i = 0; i < var_dd75d3e1.size; i++) {
            var_e1a598be = "<dev string:x325>";
            for (j = 0; j < var_2decd2ef - var_dd75d3e1[i].size; j++) {
                var_e1a598be += "<dev string:x326>";
            }
            var_e1a598be += var_dd75d3e1[i].name + "<dev string:x328>";
            if (var_dd75d3e1[i].state[0] != "<dev string:x325>" && isdefined(var_dd75d3e1[i].state[int(getgametypesetting(var_dd75d3e1[i].name))])) {
                var_e1a598be += var_dd75d3e1[i].state[int(getgametypesetting(var_dd75d3e1[i].name))];
                for (j = 0; j < 13 - var_dd75d3e1[i].state[int(getgametypesetting(var_dd75d3e1[i].name))].size; j++) {
                    var_e1a598be += "<dev string:x326>";
                }
            } else {
                var_e1a598be += getgametypesetting(var_dd75d3e1[i].name);
                for (j = 0; j < 13 - string(getgametypesetting(var_dd75d3e1[i].name)).size; j++) {
                    var_e1a598be += "<dev string:x326>";
                }
            }
            array::add(var_17719d5e, var_e1a598be);
        }
        var_257f7cd2 = 0;
        var_b90f70c8 = 0;
        if (function_c08fe6a2()) {
            for (i = 0; i < var_dd75d3e1.size; i++) {
                if (floor(getgametypesetting(var_dd75d3e1[i].name)) != var_dd75d3e1[i].default_val) {
                    var_257f7cd2++;
                    if (var_257f7cd2 > 29) {
                        var_257f7cd2 -= 29;
                        var_b90f70c8++;
                    }
                    v_pos = 300 + 18 * var_257f7cd2;
                    var_2c65341c = 200 + 400 * var_b90f70c8;
                    debug2dtext((var_2c65341c, v_pos, 0), var_17719d5e[i], (0, 1, 0), undefined, (0, 0, 0), 0.75, 0.85, 360);
                }
            }
        }
    }

    // Namespace zm_custom/zm_customgame
    // Params 0, eflags: 0x4
    // Checksum 0x4bd5024c, Offset: 0x9ee0
    // Size: 0x4d6c
    function private function_89d02538() {
        return array({#name:"<dev string:x32c>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x341>", #default_val:1, #state:array("<dev string:x325>")}, {#name:"<dev string:x7e>", #default_val:1, #state:array("<dev string:x325>")}, {#name:"<dev string:x34b>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x351>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x35b>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x369>", #default_val:0, #state:array("<dev string:x325>")}, {#name:"<dev string:x379>", #default_val:0, #state:array("<dev string:x325>")}, {#name:"<dev string:x384>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x38e>", #default_val:0, #state:array("<dev string:x325>")}, {#name:"<dev string:x39a>", #default_val:0, #state:array("<dev string:x325>")}, {#name:"<dev string:x3a4>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x3b0>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x3c7>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x1dc>", #default_val:2, #state:array("<dev string:x33a>", "<dev string:x3d4>", "<dev string:x3e2>", "<dev string:x3ea>")}, {#name:"<dev string:x3f1>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x40b>", #default_val:0, #state:array("<dev string:x325>")}, {#name:"<dev string:x421>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x437>", #default_val:0, #state:array("<dev string:x325>")}, {#name:"<dev string:x449>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x464>", #default_val:0, #state:array("<dev string:x325>")}, {#name:"<dev string:x47b>", #default_val:1, #state:array("<dev string:x488>", "<dev string:x3e2>", "<dev string:x48f>")}, {#name:"<dev string:x494>", #default_val:1, #state:array("<dev string:x488>", "<dev string:x3e2>", "<dev string:x48f>")}, {#name:"<dev string:x4a5>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x4b3>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x4c5>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x2e4>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x4d2>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x4e4>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x4f4>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x504>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x519>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x2f7>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x2d3>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x529>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x3e2>", "<dev string:x536>")}, {#name:"<dev string:x540>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x552>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x563>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x1ee>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x1fe>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x211>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x226>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x571>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x238>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x588>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x24a>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x599>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x25d>", #default_val:0, #state:array("<dev string:x325>")}, {#name:"<dev string:x5b2>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x1ca>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x5c3>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x5d4>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x5e5>", #default_val:1, #state:array("<dev string:x325>")}, {#name:"<dev string:x5f7>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x60b>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x61d>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x62d>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x63b>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x64e>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x65c>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x66f>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x685>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x697>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x6a7>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x6bc>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x6cc>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x6dc>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x296>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x6ed>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x6f9>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x705>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x286>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x712>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x721>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x730>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x89>", #default_val:1, #state:array("<dev string:x746>", "<dev string:x3e2>", "<dev string:x74b>")}, {#name:"<dev string:x750>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x768>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x77d>", #default_val:1, #state:array("<dev string:x746>", "<dev string:x3e2>", "<dev string:x74b>")}, {#name:"<dev string:x793>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xfe>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>")}, {#name:"<dev string:x7b1>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x7c1>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>", "<dev string:x7cf>")}, {#name:"<dev string:x7d4>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>", "<dev string:x7cf>")}, {#name:"<dev string:x7e2>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>", "<dev string:x7cf>")}, {#name:"<dev string:x7f1>", #default_val:1, #state:array("<dev string:x800>", "<dev string:x806>", "<dev string:x80d>")}, {#name:"<dev string:x14b>", #default_val:0, #state:array("<dev string:x813>", "<dev string:x818>", "<dev string:x81c>", "<dev string:x823>")}, {#name:"<dev string:x830>", #default_val:3, #state:array("<dev string:x813>", "<dev string:x818>", "<dev string:x81c>", "<dev string:x823>")}, {#name:"<dev string:x841>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>")}, {#name:"<dev string:x2c0>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>")}, {#name:"<dev string:x854>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>")}, {#name:"<dev string:x868>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>")}, {#name:"<dev string:x87c>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x88b>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>", "<dev string:x7cf>")}, {#name:"<dev string:x898>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>")}, {#name:"<dev string:x15c>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>")}, {#name:"<dev string:x8aa>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x8b7>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>", "<dev string:x7cf>")}, {#name:"<dev string:x8c7>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>")}, {#name:"<dev string:x8dc>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>")}, {#name:"<dev string:x8f1>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x901>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>", "<dev string:x7cf>")}, {#name:"<dev string:x911>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>")}, {#name:"<dev string:x926>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>")}, {#name:"<dev string:x93b>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x136>", #default_val:3, #state:array("<dev string:x325>")}, {#name:"<dev string:xc4>", #default_val:1, #state:array("<dev string:x94b>", "<dev string:x806>", "<dev string:x951>")}, {#name:"<dev string:xd7>", #default_val:2, #state:array("<dev string:x956>", "<dev string:x94b>", "<dev string:x806>", "<dev string:x951>", "<dev string:x95e>")}, {#name:"<dev string:x2b1>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x963>", "<dev string:x806>", "<dev string:x969>")}, {#name:"<dev string:x2a3>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x963>", "<dev string:x806>", "<dev string:x969>")}, {#name:"<dev string:x1bc>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x1ab>", #default_val:5, #state:array("<dev string:x325>")}, {#name:"<dev string:x96f>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x111>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x981>", "<dev string:x98c>")}, {#name:"<dev string:x122>", #default_val:0, #state:array("<dev string:x325>")}, {#name:"<dev string:x992>", #default_val:0, #state:array("<dev string:x325>")}, {#name:"<dev string:x272>", #default_val:2, #state:array("<dev string:x33a>", "<dev string:x94b>", "<dev string:x806>", "<dev string:x951>")}, {#name:"<dev string:x9a4>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xe9>", #default_val:0, #state:array("<dev string:x325>")}, {#name:"<dev string:x9bc>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x9cd>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x9e2>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>")}, {#name:"<dev string:x9f5>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xa13>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xa2d>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xa4a>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xa5e>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xa76>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xa8a>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xaa4>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xabb>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xad1>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xae5>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xafd>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xb16>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xb2f>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xb48>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xb61>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xb7b>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xb95>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xbaf>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xbc9>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xbde>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xbf3>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xc08>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xc1d>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xc41>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xc60>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xc76>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xc91>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xcac>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xcc4>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xcdc>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xcf5>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xd0e>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xd26>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xd37>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xd51>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xd69>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xd84>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xd9a>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xdaf>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xdc9>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xddd>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xdf1>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xe04>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xe16>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xe29>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xe3b>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xe4f>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xe64>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xe77>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xe94>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xea6>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xec2>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xedd>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xef6>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xf0f>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xf22>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xf36>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xf46>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xf5b>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xf69>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xf7a>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xf8c>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xfaa>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xfbc>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xfcd>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xfdf>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:xffb>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x100e>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x1020>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x1031>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x1040>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x16e>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>", "<dev string:x1058>")}, {#name:"<dev string:xa0>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>", "<dev string:x1058>")}, {#name:"<dev string:x182>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>", "<dev string:x1058>")}, {#name:"<dev string:x1062>", #default_val:0, #state:array("<dev string:x325>")}, {#name:"<dev string:x1075>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>", "<dev string:x7cf>")}, {#name:"<dev string:x1084>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>")}, {#name:"<dev string:x1098>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>")}, {#name:"<dev string:xb1>", #default_val:1, #state:array("<dev string:x7a5>", "<dev string:x3e2>", "<dev string:x7aa>", "<dev string:x1058>")}, {#name:"<dev string:x10ac>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x10bc>", #default_val:1, #state:array("<dev string:x3e2>", "<dev string:x956>")}, {#name:"<dev string:x10c8>", #default_val:0, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x10da>", #default_val:0, #state:array("<dev string:x325>")}, {#name:"<dev string:x10ec>", #default_val:0, #state:array("<dev string:x325>")}, {#name:"<dev string:x10ff>", #default_val:0, #state:array("<dev string:x325>")}, {#name:"<dev string:x111a>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x1131>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x1143>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x1154>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x1169>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x1181>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x1197>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x11a9>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x11bc>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x11cd>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x11e4>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x11f5>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x1208>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")}, {#name:"<dev string:x1219>", #default_val:1, #state:array("<dev string:x33a>", "<dev string:x33e>")});
    }

#/
