#using scripts\abilities\ability_util;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damage;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\dialog_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\placeables;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\deployable;
#using scripts\weapons\tacticalinsertion;
#using scripts\weapons\weaponobjects;

#namespace killstreaks;

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x955a03f1, Offset: 0x578
// Size: 0x1b6
function init_shared() {
    level.killstreaks = [];
    level.killstreakweapons = [];
    level.var_59b5a4c5 = [];
    level.droplocations = [];
    level.zoffsetcounter = 0;
    level.var_2412e4d3 = 0;
    clientfield::register("clientuimodel", "locSel.commandMode", 1, 1, "int");
    clientfield::register("clientuimodel", "locSel.snapTo", 1, 1, "int");
    clientfield::register("vehicle", "timeout_beep", 1, 2, "int");
    clientfield::register("toplayer", "thermal_glow", 1, 1, "int");
    level.play_killstreak_firewall_being_hacked_dialog = undefined;
    level.play_killstreak_firewall_hacked_dialog = undefined;
    level.play_killstreak_being_hacked_dialog = undefined;
    level.play_killstreak_hacked_dialog = undefined;
    level.play_pilot_dialog_on_owner = undefined;
    level.play_pilot_dialog = undefined;
    level.play_taacom_dialog_response_on_owner = undefined;
    level.play_taacom_dialog = undefined;
    level.var_2e2a6dd4 = undefined;
    level.var_2f5ed0a0 = undefined;
    level.var_6f9f2a9f = undefined;
    level.var_35c93bc7 = getweapon(#"killstreak_remote");
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x659e15da, Offset: 0x738
// Size: 0xd6
function function_7ba8ee28() {
    level.numkillstreakreservedobjectives = 0;
    level.killstreakcounter = 0;
    if (!isdefined(level.roundstartkillstreakdelay)) {
        level.roundstartkillstreakdelay = 0;
    }
    level.iskillstreakweapon = &is_killstreak_weapon;
    level.killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");
    callback::on_spawned(&on_player_spawned);
    callback::on_joined_team(&on_joined_team);
    level.var_49a9ce47 = &function_85da67ce;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x5ad23d03, Offset: 0x818
// Size: 0xe0
function function_85da67ce(bot) {
    weapons = bot getweaponslist();
    foreach (weapon in weapons) {
        if (is_killstreak_weapon(weapon)) {
            killstreak = get_killstreak_for_weapon(weapon);
            bot thread usekillstreak(killstreak, 0);
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x8c2a2e7e, Offset: 0x900
// Size: 0x3c
function function_84669e37(func, obj) {
    callback::add_callback(#"hash_45f35669076bc317", func, obj);
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xaed8d184, Offset: 0x948
// Size: 0x18e
function register_ui(killstreak_type, killstreak_menu) {
    assert(isdefined(level.killstreaks[killstreak_type]), "<dev string:x30>");
    item_index = getitemindexfromref(killstreak_menu);
    killstreak_info = getunlockableiteminfofromindex(item_index, 0);
    killstreak_cost = 0;
    if (isdefined(killstreak_info)) {
        killstreak_cost = killstreak_info.momentum;
    }
    level.killstreaks[killstreak_type].itemindex = item_index;
    level.killstreaks[killstreak_type].momentumcost = killstreak_cost;
    level.killstreaks[killstreak_type].menuname = killstreak_menu;
    level.killstreaks[killstreak_type].uiname = "";
    /#
        if (isdefined(killstreak_info)) {
            level.killstreaks[killstreak_type].uiname = killstreak_info.displayname;
        }
        if (level.killstreaks[killstreak_type].uiname == "<dev string:x6a>") {
            level.killstreaks[killstreak_type].uiname = killstreak_menu;
        }
    #/
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xd3775c02, Offset: 0xae0
// Size: 0x13a
function killstreak_init(killstreak_type) {
    assert(isdefined(killstreak_type), "<dev string:x6b>");
    assert(!isdefined(level.killstreaks[killstreak_type]), "<dev string:xa4>" + killstreak_type + "<dev string:xb0>");
    level.killstreaks[killstreak_type] = spawnstruct();
    level.killstreaks[killstreak_type].killstreaklevel = 0;
    level.killstreaks[killstreak_type].quantity = 0;
    level.killstreaks[killstreak_type].allowassists = 0;
    level.killstreaks[killstreak_type].overrideentitycameraindemo = 0;
    level.killstreaks[killstreak_type].teamkillpenaltyscale = 1;
    level.killstreaks[killstreak_type].var_66b45a8f = 0;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xb209cf5f, Offset: 0xc28
// Size: 0xea
function register_weapon(killstreak_type, weapon) {
    if (weapon.name == #"none") {
        return;
    }
    assert(isdefined(killstreak_type), "<dev string:x6b>");
    assert(weapon.name != #"none");
    assert(!isdefined(level.killstreakweapons[weapon]), "<dev string:xc4>");
    level.killstreaks[killstreak_type].weapon = weapon;
    level.killstreakweapons[weapon] = killstreak_type;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xa9d5e697, Offset: 0xd20
// Size: 0x9a
function register_vehicle(killstreak_type, vehicle) {
    assert(isdefined(killstreak_type), "<dev string:x6b>");
    assert(!isdefined(level.var_59b5a4c5[vehicle]), "<dev string:xc4>");
    level.killstreaks[killstreak_type].vehicle = vehicle;
    level.var_59b5a4c5[vehicle] = killstreak_type;
}

// Namespace killstreaks/killstreaks_shared
// Params 10, eflags: 0x0
// Checksum 0xdb37b99c, Offset: 0xdc8
// Size: 0x284
function register(killstreaktype, killstreakweaponname, killstreakmenuname, killstreakusagekey, killstreakusefunction, killstreakdelaystreak, weaponholdallowed = 0, killstreakstatsname = undefined, registerdvars = 1, registerinventory = 1) {
    assert(isdefined(killstreakusefunction), "<dev string:x100>" + killstreaktype);
    killstreak_init(killstreaktype);
    register_ui(killstreaktype, killstreakmenuname);
    level.killstreaks[killstreaktype].usagekey = killstreakusagekey;
    level.killstreaks[killstreaktype].usefunction = killstreakusefunction;
    level.killstreaks[killstreaktype].delaystreak = killstreakdelaystreak;
    if (isdefined(killstreakweaponname)) {
        killstreakweapon = getweapon(killstreakweaponname);
        register_weapon(killstreaktype, killstreakweapon);
    }
    if (isdefined(killstreakstatsname)) {
        level.killstreaks[killstreaktype].killstreakstatsname = killstreakstatsname;
    }
    level.killstreaks[killstreaktype].weaponholdallowed = weaponholdallowed;
    if (isdefined(registerinventory) && registerinventory) {
        level.menureferenceforkillstreak[killstreakmenuname] = killstreaktype;
        bundlename = function_ad36ef5d(killstreaktype);
        killstreak_bundles::register_killstreak_bundle(bundlename);
        var_a06dd7c4 = undefined;
        if (isdefined(killstreakweaponname)) {
            var_a06dd7c4 = "inventory_" + killstreakweaponname;
        }
        register("inventory_" + killstreaktype, var_a06dd7c4, killstreakmenuname, killstreakusagekey, killstreakusefunction, killstreakdelaystreak, weaponholdallowed, killstreakstatsname, 0, 0);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x4
// Checksum 0xd1be6b5b, Offset: 0x1058
// Size: 0x46
function private function_ad36ef5d(killstreaktype) {
    if (killstreaktype === "drone_squadron") {
        if (sessionmodeiscampaigngame()) {
            return ("drone_squadron" + "_cp");
        }
    }
    return killstreaktype;
}

// Namespace killstreaks/killstreaks_shared
// Params 6, eflags: 0x4
// Checksum 0x2775ca68, Offset: 0x10a8
// Size: 0x624
function private function_33d5c163(type, bundle, weapon, vehicle, killstreak_use_function, isinventoryweapon) {
    killstreak_init(type);
    menukey = bundle.var_8b15fa4b;
    if (!isdefined(menukey)) {
        menukey = type;
    } else if (isdefined(isinventoryweapon) && isinventoryweapon) {
        menukey = "inventory_" + menukey;
    }
    register_ui(type, menukey);
    level.killstreaks[type].usagekey = type;
    level.killstreaks[type].delaystreak = bundle.var_a4b7f7bc;
    level.killstreaks[type].usefunction = killstreak_use_function;
    level.killstreaks[type].weaponholdallowed = 0;
    register_weapon(type, weapon);
    level.menureferenceforkillstreak[menukey] = type;
    if (isdefined(bundle.altweapons)) {
        foreach (alt_weapon in bundle.altweapons) {
            function_e421d243(type, alt_weapon.var_b5e3dd58);
        }
    }
    if (isdefined(vehicle)) {
        register_vehicle(type, vehicle);
    }
    function_7fc35457(type, bundle.var_6ccbbc89, bundle.var_97e60834, bundle.var_9da2ca97, bundle.var_df6fc7d1, bundle.var_16f19b06, bundle.var_1daca810, isdefined(bundle.var_55a6c74c) ? bundle.var_55a6c74c : 0, isdefined(bundle.var_5f18c0b3) ? bundle.var_5f18c0b3 : 0);
    level.killstreaks[type].var_24ad5764 = bundle.var_86cf2e58;
    if (isdefined(level.cratetypes)) {
        if (isdefined(isinventoryweapon) && isinventoryweapon) {
            if (isdefined(level.cratetypes[#"inventory_supplydrop"]) && isdefined(level.cratetypes[#"inventory_supplydrop"][type])) {
                level.cratetypes[#"inventory_supplydrop"][type].hint = bundle.var_aeedfc31;
                level.cratetypes[#"inventory_supplydrop"][type].hint_gambler = bundle.var_3d3d7227;
            }
        } else {
            if (isdefined(level.cratetypes[#"supplydrop"]) && isdefined(level.cratetypes[#"supplydrop"][type])) {
                level.cratetypes[#"supplydrop"][type].hint = bundle.var_aeedfc31;
                level.cratetypes[#"supplydrop"][type].hint_gambler = bundle.var_3d3d7227;
                game.strings[type + "_hint"] = bundle.var_aeedfc31;
            }
            if (isdefined(level.cratetypes[#"gambler"]) && isdefined(level.cratetypes[#"gambler"][type])) {
                level.cratetypes[#"gambler"][type].hint = bundle.var_aeedfc31;
                level.cratetypes[#"gambler"][type].hint_gambler = bundle.var_3d3d7227;
            }
        }
    }
    function_37b5ef47(type, bundle.var_7663ba4c, bundle.var_e647bc16, bundle.var_1ac019f7, bundle.var_214ac50e, bundle.var_f63aabdf, bundle.var_cd73a193, bundle.var_adb1465f, bundle.var_7822494d, bundle.var_4b4e7c32, bundle.var_476f423f, bundle.var_7576cbd3, bundle.var_ab535ed0);
    level.killstreaks[type].script_bundle = bundle;
    killstreak_bundles::register_bundle(type, bundle);
    if (isdefined(bundle.var_6c85a8d6) && bundle.var_6c85a8d6 && !(isdefined(isinventoryweapon) && isinventoryweapon)) {
        register_dev_dvars(type);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xd711c30d, Offset: 0x16d8
// Size: 0xcc
function register_bundle(bundle, killstreak_use_function) {
    function_33d5c163(bundle.var_e409027f, bundle, bundle.ksweapon, bundle.ksvehicle, killstreak_use_function, 0);
    if (isdefined(bundle.var_9009985) && bundle.var_9009985.name != #"none") {
        function_33d5c163("inventory_" + bundle.var_e409027f, bundle, bundle.var_9009985, undefined, killstreak_use_function, 1);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xb8cd8794, Offset: 0x17b0
// Size: 0x4c
function register_killstreak(bundlename, use_function) {
    bundle = struct::get_script_bundle("killstreak", bundlename);
    register_bundle(bundle, use_function);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xec172d47, Offset: 0x1808
// Size: 0x1e
function is_registered(killstreaktype) {
    return isdefined(level.killstreaks[killstreaktype]);
}

// Namespace killstreaks/killstreaks_shared
// Params 9, eflags: 0x0
// Checksum 0x776905a9, Offset: 0x1830
// Size: 0x17e
function function_7fc35457(killstreaktype, receivedtext, notusabletext, inboundtext, inboundnearplayertext, var_3e3825f6, hackedtext, utilizesairspace, var_fe140705) {
    assert(isdefined(killstreaktype), "<dev string:x128>");
    assert(isdefined(level.killstreaks[killstreaktype]), "<dev string:x15c>");
    level.killstreaks[killstreaktype].receivedtext = receivedtext;
    level.killstreaks[killstreaktype].notavailabletext = notusabletext;
    level.killstreaks[killstreaktype].inboundtext = inboundtext;
    level.killstreaks[killstreaktype].var_3e3825f6 = var_3e3825f6;
    level.killstreaks[killstreaktype].inboundnearplayertext = inboundnearplayertext;
    level.killstreaks[killstreaktype].hackedtext = hackedtext;
    level.killstreaks[killstreaktype].utilizesairspace = utilizesairspace;
    level.killstreaks[killstreaktype].var_fe140705 = var_fe140705;
}

// Namespace killstreaks/killstreaks_shared
// Params 13, eflags: 0x0
// Checksum 0xa2a06071, Offset: 0x19b8
// Size: 0x346
function function_37b5ef47(killstreaktype, informdialog, taacomdialogbundlekey, pilotdialogarraykey, startdialogkey, enemystartdialogkey, enemystartmultipledialogkey, hackeddialogkey, hackedstartdialogkey, requestdialogkey, threatdialogkey, var_8f7e621a, var_5b8c204f) {
    assert(isdefined(killstreaktype), "<dev string:x6b>");
    assert(isdefined(level.killstreaks[killstreaktype]), "<dev string:x19f>");
    level.killstreaks[killstreaktype].informdialog = informdialog;
    level.killstreaks[killstreaktype].taacomdialogbundlekey = taacomdialogbundlekey;
    level.killstreaks[killstreaktype].startdialogkey = startdialogkey;
    level.killstreaks[killstreaktype].enemystartdialogkey = enemystartdialogkey;
    level.killstreaks[killstreaktype].enemystartmultipledialogkey = enemystartmultipledialogkey;
    level.killstreaks[killstreaktype].hackeddialogkey = hackeddialogkey;
    level.killstreaks[killstreaktype].hackedstartdialogkey = hackedstartdialogkey;
    level.killstreaks[killstreaktype].var_5b8c204f = var_5b8c204f;
    level.killstreaks[killstreaktype].requestdialogkey = requestdialogkey;
    level.killstreaks[killstreaktype].var_8f7e621a = var_8f7e621a;
    level.killstreaks[killstreaktype].threatdialogkey = threatdialogkey;
    if (isdefined(pilotdialogarraykey)) {
        taacombundles = struct::get_script_bundles("mpdialog_taacom");
        foreach (bundle in taacombundles) {
            if (!isdefined(bundle.pilotbundles)) {
                bundle.pilotbundles = [];
            }
            bundle.pilotbundles[killstreaktype] = [];
            i = 0;
            field = pilotdialogarraykey + i;
            for (fieldvalue = bundle.(field); isdefined(fieldvalue); fieldvalue = bundle.(field)) {
                bundle.pilotbundles[killstreaktype][i] = fieldvalue;
                i++;
                field = pilotdialogarraykey + i;
            }
        }
        level.tacombundles = taacombundles;
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xa9b85274, Offset: 0x1d08
// Size: 0x13a
function function_e421d243(killstreaktype, weapon) {
    assert(isdefined(killstreaktype), "<dev string:x6b>");
    assert(isdefined(level.killstreaks[killstreaktype]), "<dev string:x1e1>");
    if (weapon.name == #"none") {
        return;
    }
    if (level.killstreaks[killstreaktype].weapon === weapon) {
        return;
    }
    if (!isdefined(level.killstreaks[killstreaktype].altweapons)) {
        level.killstreaks[killstreaktype].altweapons = [];
    }
    if (!isdefined(level.killstreakweapons[weapon])) {
        level.killstreakweapons[weapon] = killstreaktype;
    }
    level.killstreaks[killstreaktype].altweapons[level.killstreaks[killstreaktype].altweapons.size] = weapon;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x4c37f129, Offset: 0x1e50
// Size: 0x4c
function register_alt_weapon(killstreaktype, weapon) {
    function_e421d243(killstreaktype, weapon);
    function_e421d243("inventory_" + killstreaktype, weapon);
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x73300426, Offset: 0x1ea8
// Size: 0x2c
function function_71b27c39(killstreaktype, weapon) {
    function_e421d243(killstreaktype, weapon);
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x9218ac51, Offset: 0x1ee0
// Size: 0x4a
function function_96737296(killstreaktype, weapon) {
    if (!isdefined(level.var_d184eaf5)) {
        level.var_d184eaf5 = [];
    }
    level.var_d184eaf5[weapon] = killstreaktype;
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xb5b3f10e, Offset: 0x1f38
// Size: 0x146
function register_remote_override_weapon(killstreaktype, weaponname, isinventory) {
    assert(isdefined(killstreaktype), "<dev string:x6b>");
    assert(isdefined(level.killstreaks[killstreaktype]), "<dev string:x227>");
    weapon = getweapon(weaponname);
    if (level.killstreaks[killstreaktype].weapon === weapon) {
        return;
    }
    if (!isdefined(level.killstreaks[killstreaktype].remoteoverrideweapons)) {
        level.killstreaks[killstreaktype].remoteoverrideweapons = [];
    }
    if (!isdefined(level.killstreakweapons[weapon])) {
        level.killstreakweapons[weapon] = killstreaktype;
    }
    level.killstreaks[killstreaktype].remoteoverrideweapons[level.killstreaks[killstreaktype].remoteoverrideweapons.size] = weapon;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xd2cd02f9, Offset: 0x2088
// Size: 0x94
function is_remote_override_weapon(killstreaktype, weapon) {
    if (isdefined(level.killstreaks[killstreaktype].remoteoverrideweapons)) {
        for (i = 0; i < level.killstreaks[killstreaktype].remoteoverrideweapons.size; i++) {
            if (level.killstreaks[killstreaktype].remoteoverrideweapons[i] == weapon) {
                return true;
            }
        }
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xb3c09fd0, Offset: 0x2128
// Size: 0x134
function register_dev_dvars(killstreaktype) {
    /#
        assert(isdefined(killstreaktype), "<dev string:x6b>");
        assert(isdefined(level.killstreaks[killstreaktype]), "<dev string:x279>");
        level.killstreaks[killstreaktype].devdvar = "<dev string:x2bd>" + killstreaktype + "<dev string:x2c2>";
        level.killstreaks[killstreaktype].devenemydvar = "<dev string:x2bd>" + killstreaktype + "<dev string:x2c8>";
        level.killstreaks[killstreaktype].devtimeoutdvar = "<dev string:x2bd>" + killstreaktype + "<dev string:x2d3>";
        setdvar(level.killstreaks[killstreaktype].devtimeoutdvar, 0);
        level thread register_devgui(killstreaktype);
    #/
}

/#

    // Namespace killstreaks/killstreaks_shared
    // Params 1, eflags: 0x0
    // Checksum 0xad01b6e0, Offset: 0x2268
    // Size: 0xbc
    function register_dev_debug_dvar(killstreaktype) {
        assert(isdefined(killstreaktype), "<dev string:x6b>");
        assert(isdefined(level.killstreaks[killstreaktype]), "<dev string:x279>");
        level.killstreaks[killstreaktype].devdebugdvar = "<dev string:x2bd>" + killstreaktype + "<dev string:x2de>";
        devgui_scorestreak_command_debugdvar(killstreaktype, level.killstreaks[killstreaktype].devdebugdvar);
    }

    // Namespace killstreaks/killstreaks_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd407e705, Offset: 0x2330
    // Size: 0x138
    function register_devgui(killstreaktype) {
        level endon(#"game_ended");
        wait randomintrange(2, 20) * float(function_f9f48566()) / 1000;
        give_type_all = "<dev string:x2e5>";
        give_type_enemy = "<dev string:x2ea>";
        if (isdefined(level.killstreaks[killstreaktype].devdvar)) {
            devgui_scorestreak_command_givedvar(killstreaktype, give_type_all, level.killstreaks[killstreaktype].devdvar);
        }
        if (isdefined(level.killstreaks[killstreaktype].devenemydvar)) {
            devgui_scorestreak_command_givedvar(killstreaktype, give_type_enemy, level.killstreaks[killstreaktype].devenemydvar);
        }
        if (isdefined(level.killstreaks[killstreaktype].devtimeoutdvar)) {
        }
    }

    // Namespace killstreaks/killstreaks_shared
    // Params 3, eflags: 0x0
    // Checksum 0x7070c502, Offset: 0x2470
    // Size: 0x54
    function devgui_scorestreak_command_givedvar(killstreaktype, give_type, dvar) {
        devgui_scorestreak_command(killstreaktype, give_type, "<dev string:x2f5>" + dvar + "<dev string:x2fa>");
    }

    // Namespace killstreaks/killstreaks_shared
    // Params 2, eflags: 0x0
    // Checksum 0x8d681884, Offset: 0x24d0
    // Size: 0x34
    function devgui_scorestreak_command_timeoutdvar(killstreaktype, dvar) {
        devgui_scorestreak_dvar_toggle(killstreaktype, "<dev string:x2fd>", dvar);
    }

    // Namespace killstreaks/killstreaks_shared
    // Params 2, eflags: 0x0
    // Checksum 0xf418eff4, Offset: 0x2510
    // Size: 0x34
    function devgui_scorestreak_command_debugdvar(killstreaktype, dvar) {
        devgui_scorestreak_dvar_toggle(killstreaktype, "<dev string:x306>", dvar);
    }

#/

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xba9b7048, Offset: 0x2550
// Size: 0x6c
function devgui_scorestreak_dvar_toggle(killstreaktype, title, dvar) {
    setdvar(dvar, 0);
    devgui_scorestreak_command(killstreaktype, "Toggle " + title, "toggle " + dvar + " 1 0");
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xbfcf63f5, Offset: 0x25c8
// Size: 0xfc
function devgui_scorestreak_command(killstreaktype, title, command) {
    /#
        assert(isdefined(killstreaktype), "<dev string:x6b>");
        assert(isdefined(level.killstreaks[killstreaktype]), "<dev string:x279>");
        root = "<dev string:x30c>";
        user_name = level.killstreaks[killstreaktype].menuname;
        util::add_queued_debug_command(root + user_name + "<dev string:x329>" + killstreaktype + "<dev string:x32c>" + title + "<dev string:x32f>" + command + "<dev string:x333>");
    #/
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x52ba4a4d, Offset: 0x26d0
// Size: 0x9e
function should_draw_debug(killstreak) {
    /#
        assert(isdefined(killstreak), "<dev string:x6b>");
        function_b56d3a35();
        if (isdefined(level.killstreaks[killstreak]) && isdefined(level.killstreaks[killstreak].devdebugdvar)) {
            return getdvarint(level.killstreaks[killstreak].devdebugdvar, 0);
        }
    #/
    return 0;
}

/#

    // Namespace killstreaks/killstreaks_shared
    // Params 0, eflags: 0x0
    // Checksum 0x89d95c, Offset: 0x2778
    // Size: 0x34
    function function_b56d3a35() {
        assert(isdefined(level.killstreaks), "<dev string:x337>");
    }

#/

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x1672298a, Offset: 0x27b8
// Size: 0x30
function is_available(killstreak) {
    if (isdefined(level.menureferenceforkillstreak[killstreak])) {
        return 1;
    }
    return 0;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xca2d54b4, Offset: 0x27f0
// Size: 0x1c
function get_by_menu_name(killstreak) {
    return level.menureferenceforkillstreak[killstreak];
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x2a66d553, Offset: 0x2818
// Size: 0x4a
function get_menu_name(killstreaktype) {
    assert(isdefined(level.killstreaks[killstreaktype]));
    return level.killstreaks[killstreaktype].menuname;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x99c416e, Offset: 0x2870
// Size: 0x122
function get_level(index, killstreak) {
    killstreaklevel = level.killstreaks[get_by_menu_name(killstreak)].killstreaklevel;
    if (getdvarint(#"custom_killstreak_mode", 0) == 2) {
        if (isdefined(self.killstreak[index]) && killstreak == self.killstreak[index]) {
            killsrequired = getdvarint("custom_killstreak_" + index + 1 + "_kills", 0);
            if (killsrequired) {
                killstreaklevel = getdvarint("custom_killstreak_" + index + 1 + "_kills", 0);
            }
        }
    }
    return killstreaklevel;
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x5808615, Offset: 0x29a0
// Size: 0x25e
function give_if_streak_count_matches(index, killstreak, streakcount) {
    pixbeginevent(#"givekillstreakifstreakcountmatches");
    /#
        if (!isdefined(killstreak)) {
            println("<dev string:x3a4>");
        }
        if (isdefined(killstreak)) {
            println("<dev string:x3bb>" + killstreak + "<dev string:x3d1>");
        }
        if (!is_available(killstreak)) {
            println("<dev string:x3d3>");
        }
    #/
    if (self.pers[#"killstreaksearnedthiskillstreak"] > index && util::isroundbased()) {
        hasalreadyearnedkillstreak = 1;
    } else {
        hasalreadyearnedkillstreak = 0;
    }
    if (isdefined(killstreak) && is_available(killstreak) && !hasalreadyearnedkillstreak) {
        killstreaklevel = get_level(index, killstreak);
        if (self hasperk(#"specialty_killstreak")) {
            reduction = getdvarint(#"perk_killstreakreduction", 0);
            killstreaklevel -= reduction;
            if (killstreaklevel <= 0) {
                killstreaklevel = 1;
            }
        }
        if (killstreaklevel == streakcount) {
            self give(get_by_menu_name(killstreak), streakcount);
            self.pers[#"killstreaksearnedthiskillstreak"] = index + 1;
            pixendevent();
            return true;
        }
    }
    pixendevent();
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0xdccd1097, Offset: 0x2c08
// Size: 0xca
function give_for_streak() {
    if (!util::is_killstreaks_enabled()) {
        return;
    }
    if (!isdefined(self.pers[#"totalkillstreakcount"])) {
        self.pers[#"totalkillstreakcount"] = 0;
    }
    given = 0;
    for (i = 0; i < self.killstreak.size; i++) {
        given |= give_if_streak_count_matches(i, self.killstreak[i], self.pers[#"cur_kill_streak"]);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0xbfc8bf7c, Offset: 0x2ce0
// Size: 0xa2
function is_an_a_killstreak() {
    onkillstreak = 0;
    if (!isdefined(self.pers[#"kill_streak_before_death"])) {
        self.pers[#"kill_streak_before_death"] = 0;
    }
    streakplusone = self.pers[#"kill_streak_before_death"] + 1;
    if (self.pers[#"kill_streak_before_death"] >= 5) {
        onkillstreak = 1;
    }
    return onkillstreak;
}

// Namespace killstreaks/killstreaks_shared
// Params 5, eflags: 0x0
// Checksum 0x1aedd397, Offset: 0x2d90
// Size: 0x194
function give(killstreaktype, streak, suppressnotification, noxp, tobottom) {
    pixbeginevent(#"givekillstreak");
    self endon(#"disconnect");
    level endon(#"game_ended");
    had_to_delay = 0;
    killstreakgiven = 0;
    if (isdefined(noxp)) {
        if (self give_internal(killstreaktype, undefined, noxp, tobottom)) {
            killstreakgiven = 1;
            if (self.just_given_new_inventory_killstreak === 1) {
                self add_to_notification_queue(level.killstreaks[killstreaktype].menuname, streak, killstreaktype, noxp, 1);
            }
        }
    } else if (self give_internal(killstreaktype, noxp)) {
        killstreakgiven = 1;
        if (self.just_given_new_inventory_killstreak === 1) {
            self add_to_notification_queue(level.killstreaks[killstreaktype].menuname, streak, killstreaktype, noxp, 1);
        }
    }
    pixendevent();
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xccf223a2, Offset: 0x2f30
// Size: 0xfc
function take(killstreak) {
    self endon(#"disconnect");
    killstreak_weapon = get_killstreak_weapon(killstreak);
    remove_used_killstreak(killstreak);
    if (self getinventoryweapon() == killstreak_weapon) {
        self setinventoryweapon(level.weaponnone);
    }
    waittillframeend();
    currentweapon = self getcurrentweapon();
    if (currentweapon != killstreak_weapon || killstreak_weapon.iscarriedkillstreak) {
        return;
    }
    switch_to_last_non_killstreak_weapon();
    activate_next();
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x9b828b33, Offset: 0x3038
// Size: 0x174
function remove_oldest() {
    if (isdefined(self.pers[#"killstreaks"][0])) {
        currentweapon = self getcurrentweapon();
        if (currentweapon == get_killstreak_weapon(self.pers[#"killstreaks"][0])) {
            primaries = self getweaponslistprimaries();
            if (primaries.size > 0) {
                self switchtoweapon(primaries[0]);
            }
        }
        self notify(#"oldest_killstreak_removed", {#type:self.pers[#"killstreaks"][0], #id:self.pers[#"killstreak_unique_id"][0]});
        self remove_used_killstreak(self.pers[#"killstreaks"][0], self.pers[#"killstreak_unique_id"][0], 0);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 4, eflags: 0x0
// Checksum 0x1fece015, Offset: 0x31b8
// Size: 0x606
function give_internal(killstreaktype, do_not_update_death_count, noxp, tobottom) {
    self.just_given_new_inventory_killstreak = undefined;
    if (level.gameended) {
        return false;
    }
    if (!util::is_killstreaks_enabled()) {
        return false;
    }
    if (!isdefined(level.killstreaks[killstreaktype])) {
        return false;
    }
    if (!isdefined(self.pers[#"killstreaks"])) {
        self.pers[#"killstreaks"] = [];
    }
    if (!isdefined(self.pers[#"killstreak_has_been_used"])) {
        self.pers[#"killstreak_has_been_used"] = [];
    }
    if (!isdefined(self.pers[#"killstreak_unique_id"])) {
        self.pers[#"killstreak_unique_id"] = [];
    }
    if (!isdefined(self.pers[#"killstreak_ammo_count"])) {
        self.pers[#"killstreak_ammo_count"] = [];
    }
    just_max_stack_removed_inventory_killstreak = undefined;
    if (isdefined(tobottom) && tobottom) {
        size = self.pers[#"killstreaks"].size;
        if (self.pers[#"killstreaks"].size >= level.maxinventoryscorestreaks) {
            self remove_oldest();
            just_max_stack_removed_inventory_killstreak = self.just_removed_used_killstreak;
        }
        for (i = size; i > 0; i--) {
            self.pers[#"killstreaks"][i] = self.pers[#"killstreaks"][i - 1];
            self.pers[#"killstreak_has_been_used"][i] = self.pers[#"killstreak_has_been_used"][i - 1];
            self.pers[#"killstreak_unique_id"][i] = self.pers[#"killstreak_unique_id"][i - 1];
            self.pers[#"killstreak_ammo_count"][i] = self.pers[#"killstreak_ammo_count"][i - 1];
        }
        self.pers[#"killstreaks"][0] = killstreaktype;
        self.pers[#"killstreak_unique_id"][0] = level.killstreakcounter;
        level.killstreakcounter++;
        if (isdefined(noxp)) {
            self.pers[#"killstreak_has_been_used"][0] = noxp;
        } else {
            self.pers[#"killstreak_has_been_used"][0] = 0;
        }
        if (size == 0) {
            weapon = get_killstreak_weapon(killstreaktype);
            ammocount = give_weapon(weapon, 1);
        }
        self.pers[#"killstreak_ammo_count"][0] = 0;
    } else {
        self.pers[#"killstreaks"][self.pers[#"killstreaks"].size] = killstreaktype;
        self.pers[#"killstreak_unique_id"][self.pers[#"killstreak_unique_id"].size] = level.killstreakcounter;
        level.killstreakcounter++;
        if (self.pers[#"killstreaks"].size > level.maxinventoryscorestreaks) {
            self remove_oldest();
            just_max_stack_removed_inventory_killstreak = self.just_removed_used_killstreak;
        }
        if (isdefined(noxp)) {
            self.pers[#"killstreak_has_been_used"][self.pers[#"killstreak_has_been_used"].size] = noxp;
        } else {
            self.pers[#"killstreak_has_been_used"][self.pers[#"killstreak_has_been_used"].size] = 0;
        }
        weapon = get_killstreak_weapon(killstreaktype);
        ammocount = give_weapon(weapon, 1);
        self.pers[#"killstreak_ammo_count"][self.pers[#"killstreak_ammo_count"].size] = ammocount;
    }
    self.just_given_new_inventory_killstreak = killstreaktype !== just_max_stack_removed_inventory_killstreak;
    return true;
}

// Namespace killstreaks/killstreaks_shared
// Params 5, eflags: 0x0
// Checksum 0xdc9647bd, Offset: 0x37c8
// Size: 0x11c
function add_to_notification_queue(menuname, streakcount, hardpointtype, nonotify, var_e4ee1ae7) {
    killstreaktablenumber = level.killstreakindices[menuname];
    if (!isdefined(killstreaktablenumber)) {
        return;
    }
    if (isdefined(nonotify) && nonotify) {
        return;
    }
    informdialog = get_killstreak_inform_dialog(hardpointtype);
    self thread play_killstreak_ready_dialog(hardpointtype, 2.4);
    self thread play_killstreak_ready_sfx(hardpointtype);
    self luinotifyevent(#"killstreak_received", 3, killstreaktablenumber, informdialog, var_e4ee1ae7);
    self luinotifyeventtospectators(#"killstreak_received", 3, killstreaktablenumber, informdialog, var_e4ee1ae7);
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0xc379f6e6, Offset: 0x38f0
// Size: 0xa2
function has_equipped() {
    currentweapon = self getcurrentweapon();
    keys = getarraykeys(level.killstreaks);
    for (i = 0; i < keys.size; i++) {
        if (level.killstreaks[keys[i]].weapon == currentweapon) {
            return true;
        }
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xe3f36565, Offset: 0x39a0
// Size: 0x1d6
function _get_from_weapon(weapon) {
    keys = getarraykeys(level.killstreaks);
    foreach (key in keys) {
        killstreak = level.killstreaks[key];
        if (killstreak.weapon === weapon) {
            return key;
        }
        if (isdefined(killstreak.altweapons)) {
            foreach (altweapon in killstreak.altweapons) {
                if (altweapon == weapon) {
                    return key;
                }
            }
        }
        if (isdefined(killstreak.remoteoverrideweapons)) {
            foreach (var_aae41743 in killstreak.remoteoverrideweapons) {
                if (var_aae41743 == weapon) {
                    return key;
                }
            }
        }
    }
    return undefined;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xca78b499, Offset: 0x3b80
// Size: 0x76
function get_from_weapon(weapon) {
    if (weapon == level.weaponnone) {
        return undefined;
    }
    res = _get_from_weapon(weapon);
    if (!isdefined(res)) {
        return _get_from_weapon(weapon.rootweapon);
    }
    return res;
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x3082cf80, Offset: 0x3c00
// Size: 0x7da
function give_weapon(weapon, isinventory, usestoredammo) {
    currentweapon = self getcurrentweapon();
    if (currentweapon != level.weaponnone && !(isdefined(level.usingmomentum) && level.usingmomentum)) {
        weaponslist = self getweaponslist();
        for (idx = 0; idx < weaponslist.size; idx++) {
            carriedweapon = weaponslist[idx];
            if (currentweapon == carriedweapon) {
                continue;
            }
            switch (carriedweapon.name) {
            case #"m32":
            case #"minigun":
                continue;
            }
            if (is_killstreak_weapon(carriedweapon)) {
                self takeweapon(carriedweapon);
            }
        }
    }
    if (currentweapon != weapon && self hasweapon(weapon) == 0) {
        self takeweapon(weapon);
        self giveweapon(weapon);
    }
    if (isdefined(level.usingmomentum) && level.usingmomentum) {
        self setinventoryweapon(weapon);
        if (weapon.iscarriedkillstreak) {
            if (!isdefined(self.pers[#"held_killstreak_ammo_count"][weapon])) {
                self.pers[#"held_killstreak_ammo_count"][weapon] = 0;
            }
            if (!isdefined(self.pers[#"held_killstreak_clip_count"][weapon])) {
                self.pers[#"held_killstreak_clip_count"][weapon] = weapon.clipsize;
            }
            if (!isdefined(self.pers[#"killstreak_quantity"][weapon])) {
                self.pers[#"killstreak_quantity"][weapon] = 0;
            }
            if (currentweapon == weapon && !isheldinventorykillstreakweapon(weapon)) {
                return weapon.maxammo;
            } else if (isdefined(usestoredammo) && usestoredammo && self.pers[#"killstreak_ammo_count"][self.pers[#"killstreak_ammo_count"].size - 1] > 0) {
                switch (weapon.name) {
                case #"inventory_minigun":
                    if (isdefined(self.minigunactive) && self.minigunactive) {
                        return self.pers[#"held_killstreak_ammo_count"][weapon];
                    }
                    break;
                case #"inventory_m32":
                    if (isdefined(self.m32active) && self.m32active) {
                        return self.pers[#"held_killstreak_ammo_count"][weapon];
                    }
                    break;
                default:
                    break;
                }
                self.pers[#"held_killstreak_ammo_count"][weapon] = self.pers[#"killstreak_ammo_count"][self.pers[#"killstreak_ammo_count"].size - 1];
                self loadout::function_fae397a1(weapon, self.pers[#"killstreak_ammo_count"][self.pers[#"killstreak_ammo_count"].size - 1]);
            } else {
                self.pers[#"held_killstreak_ammo_count"][weapon] = weapon.maxammo;
                self.pers[#"held_killstreak_clip_count"][weapon] = weapon.clipsize;
                self loadout::function_fae397a1(weapon, self.pers[#"held_killstreak_ammo_count"][weapon]);
            }
            return self.pers[#"held_killstreak_ammo_count"][weapon];
        } else {
            switch (weapon.name) {
            case #"hash_465af87c47316d1":
            case #"inventory_minigun_drop":
            case #"dart":
            case #"ultimate_turret":
            case #"counteruav":
            case #"combat_robot_marker":
            case #"inventory_combat_robot_marker":
            case #"inventory_ultimate_turret":
            case #"hash_195173e5300c3eb9":
            case #"swat_team":
            case #"supplydrop_marker":
            case #"inventory_supplydrop_marker":
            case #"drone_squadron":
            case #"inventory_drone_squadron":
            case #"overwatch_helicopter":
            case #"inventory_dart":
            case #"inventory_straferun":
            case #"straferun":
            case #"uav":
            case #"helicopter_comlink":
            case #"inventory_ai_tank_marker":
            case #"swat_helicopter":
            case #"ai_tank_marker":
            case #"inventory_counteruav":
            case #"inventory_m32_drop":
            case #"inventory_swat_team":
            case #"inventory_uav":
            case #"inventory_overwatch_helicopter":
            case #"inventory_helicopter_comlink":
                delta = 1;
                break;
            default:
                delta = 0;
                break;
            }
            return change_killstreak_quantity(weapon, delta);
        }
        return;
    }
    self setactionslot(4, "weapon", weapon);
    return 1;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xe1f3450b, Offset: 0x43e8
// Size: 0x232
function activate_next(do_not_update_death_count) {
    if (level.gameended) {
        return false;
    }
    if (isdefined(level.usingmomentum) && level.usingmomentum) {
        self setinventoryweapon(level.weaponnone);
    } else {
        self setactionslot(4, "");
    }
    if (!isdefined(self.pers[#"killstreaks"]) || self.pers[#"killstreaks"].size == 0) {
        return false;
    }
    killstreaktype = self.pers[#"killstreaks"][self.pers[#"killstreaks"].size - 1];
    if (!isdefined(level.killstreaks[killstreaktype])) {
        return false;
    }
    weapon = level.killstreaks[killstreaktype].weapon;
    waitframe(1);
    ammocount = give_weapon(weapon, 0, 1);
    if (weapon.iscarriedkillstreak) {
        self setweaponammoclip(weapon, self.pers[#"held_killstreak_clip_count"][weapon]);
        self setweaponammostock(weapon, ammocount - self.pers[#"held_killstreak_clip_count"][weapon]);
    }
    if (!isdefined(do_not_update_death_count) || do_not_update_death_count != 0) {
        self.pers["killstreakItemDeathCount" + killstreaktype] = self.deathcount;
    }
    return true;
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0xac9ac2d9, Offset: 0x4628
// Size: 0x20e
function give_owned() {
    if (!isdefined(self.pers[#"killstreaks"])) {
        self.pers[#"killstreaks"] = [];
    }
    if (!isdefined(self.pers[#"killstreak_has_been_used"])) {
        self.pers[#"killstreak_has_been_used"] = [];
    }
    if (!isdefined(self.pers[#"killstreak_unique_id"])) {
        self.pers[#"killstreak_unique_id"] = [];
    }
    if (!isdefined(self.pers[#"killstreak_ammo_count"])) {
        self.pers[#"killstreak_ammo_count"] = [];
    }
    if (self.pers[#"killstreaks"].size > 0) {
        self activate_next(0);
    }
    size = self.pers[#"killstreaks"].size;
    if (size > 0) {
        self thread play_killstreak_ready_dialog(self.pers[#"killstreaks"][size - 1]);
    }
    self.lastnonkillstreakweapon = isdefined(self.currentweapon) ? self.currentweapon : level.weaponnone;
    if (self.lastnonkillstreakweapon == level.weaponnone) {
        weapons = self getweaponslistprimaries();
        if (weapons.size > 0) {
            self.lastnonkillstreakweapon = weapons[0];
            return;
        }
        self.lastnonkillstreakweapon = level.weaponbasemelee;
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xd6905452, Offset: 0x4840
// Size: 0x4c
function get_killstreak_quantity(killstreakweapon) {
    return isdefined(self.pers[#"killstreak_quantity"][killstreakweapon]) ? self.pers[#"killstreak_quantity"][killstreakweapon] : 0;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x3fc913a0, Offset: 0x4898
// Size: 0x120
function change_killstreak_quantity(killstreakweapon, delta) {
    quantity = get_killstreak_quantity(killstreakweapon);
    previousquantity = quantity;
    quantity += delta;
    if (quantity > level.scorestreaksmaxstacking) {
        quantity = level.scorestreaksmaxstacking;
    }
    if (self hasweapon(killstreakweapon) == 0) {
        self takeweapon(killstreakweapon);
        self giveweapon(killstreakweapon);
        self seteverhadweaponall(1);
    }
    self.pers[#"killstreak_quantity"][killstreakweapon] = quantity;
    self setweaponammoclip(killstreakweapon, quantity);
    return quantity;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x6576f43f, Offset: 0x49c0
// Size: 0xd0
function function_88a07108(killstreakweapon) {
    quantity = get_killstreak_quantity(killstreakweapon);
    if (quantity > level.scorestreaksmaxstacking) {
        quantity = level.scorestreaksmaxstacking;
    }
    if (self hasweapon(killstreakweapon) == 0) {
        self takeweapon(killstreakweapon);
        self giveweapon(killstreakweapon);
        self seteverhadweaponall(1);
    }
    self setweaponammoclip(killstreakweapon, quantity);
    return quantity;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xb5b273e1, Offset: 0x4a98
// Size: 0x82
function has_killstreak_in_class(killstreakmenuname) {
    foreach (equippedkillstreak in self.killstreak) {
        if (equippedkillstreak == killstreakmenuname) {
            return true;
        }
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xa3615633, Offset: 0x4b28
// Size: 0xb6
function has_killstreak(killstreak) {
    player = self;
    if (!isdefined(killstreak) || !isdefined(player.pers[#"killstreaks"])) {
        return false;
    }
    for (i = 0; i < self.pers[#"killstreaks"].size; i++) {
        if (player.pers[#"killstreaks"][i] == killstreak) {
            return true;
        }
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x82bcabb2, Offset: 0x4be8
// Size: 0x126
function recordkillstreakbegindirect(recordstreakindex) {
    player = self;
    if (!isplayer(player) || !isdefined(recordstreakindex)) {
        return;
    }
    if (!isdefined(self.killstreakevents)) {
        player.killstreakevents = associativearray();
    }
    if (isdefined(self.killstreakevents[recordstreakindex])) {
        kills = player.killstreakevents[recordstreakindex];
        eventindex = player recordkillstreakevent(recordstreakindex);
        player killstreakrules::recordkillstreakenddirect(eventindex, recordstreakindex, kills);
        player.killstreakevents[recordstreakindex] = undefined;
        return;
    }
    eventindex = player recordkillstreakevent(recordstreakindex);
    player.killstreakevents[recordstreakindex] = eventindex;
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xe0e8025d, Offset: 0x4d18
// Size: 0x5dc
function remove_when_done(killstreak, haskillstreakbeenused, isfrominventory) {
    self endon(#"disconnect");
    waitresult = self waittill(#"killstreak_done");
    killstreaktype = waitresult.var_e409027f;
    if (waitresult.is_successful) {
        /#
            print("<dev string:x3ee>" + get_menu_name(killstreak));
        #/
        killstreak_weapon = get_killstreak_weapon(killstreak);
        recordstreakindex = undefined;
        var_d09ffde5 = get_killstreak_for_weapon_for_stats(killstreak_weapon);
        if (isdefined(level.killstreaks[var_d09ffde5].menuname)) {
            recordstreakindex = level.killstreakindices[level.killstreaks[var_d09ffde5].menuname];
            self recordkillstreakbegindirect(recordstreakindex);
        }
        if (isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
            var_fc7663c7 = {#gametime:function_25e96038(), #killstreak:killstreak, #activatedby:getplayerspawnid(self)};
            function_b1f6086c(#"hash_1aa07f199266e0c7", var_fc7663c7);
            if (isdefined(isfrominventory) && isfrominventory) {
                remove_used_killstreak(killstreak);
                if (self getinventoryweapon() == killstreak_weapon) {
                    self setinventoryweapon(level.weaponnone);
                }
            } else {
                self change_killstreak_quantity(killstreak_weapon, -1);
            }
        } else if (isdefined(level.usingmomentum) && level.usingmomentum) {
            if (isdefined(isfrominventory) && isfrominventory && self getinventoryweapon() == killstreak_weapon) {
                remove_used_killstreak(killstreak);
                self setinventoryweapon(level.weaponnone);
            } else if (isdefined(level.var_a25d611f)) {
                self [[ level.var_a25d611f ]](killstreaktype);
            }
        } else {
            remove_used_killstreak(killstreak);
        }
        if (!(isdefined(level.usingmomentum) && level.usingmomentum)) {
            self setactionslot(4, "");
        }
        success = 1;
    } else {
        killstreak_weapon = get_killstreak_weapon(killstreak);
        self function_88a07108(killstreak_weapon);
    }
    waittillframeend();
    self unhide_compass();
    killstreak_weapon = get_killstreak_weapon(killstreaktype);
    if (killstreak_weapon.isgestureweapon) {
        return;
    }
    currentweapon = self getcurrentweapon();
    if (currentweapon == killstreak_weapon && killstreak_weapon.iscarriedkillstreak) {
        return;
    }
    if (waitresult.is_successful && (!self has_killstreak_in_class(get_menu_name(killstreak)) || isdefined(isfrominventory) && isfrominventory)) {
        switch_to_last_non_killstreak_weapon();
    } else {
        killstreakforcurrentweapon = get_from_weapon(currentweapon);
        if (currentweapon.isgameplayweapon) {
            if (isdefined(self.isplanting) && self.isplanting || isdefined(self.isdefusing) && self.isdefusing) {
                return;
            }
        }
        if (!isdefined(killstreakforcurrentweapon) && isdefined(currentweapon)) {
            return;
        }
        if (waitresult.is_successful || !isdefined(killstreakforcurrentweapon) || killstreakforcurrentweapon == killstreak || killstreakforcurrentweapon == "inventory_" + killstreak) {
            switch_to_last_non_killstreak_weapon();
        }
    }
    if (!(isdefined(level.usingmomentum) && level.usingmomentum) || isdefined(isfrominventory) && isfrominventory) {
        if (waitresult.is_successful) {
            activate_next();
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x5c3ae1fa, Offset: 0x5300
// Size: 0xa4
function usekillstreak(killstreak, isfrominventory) {
    haskillstreakbeenused = get_if_top_killstreak_has_been_used();
    if (isdefined(self.selectinglocation)) {
        return;
    }
    if (isdefined(self.drone)) {
        [[ level.killstreaks[killstreak].usefunction ]](killstreak);
        return;
    }
    self thread remove_when_done(killstreak, haskillstreakbeenused, isfrominventory);
    self thread trigger_killstreak(killstreak, isfrominventory);
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0xf65514d4, Offset: 0x53b0
// Size: 0x66
function function_e1bfee95() {
    self.pers[#"killstreaks"] = [];
    self.pers[#"killstreak_has_been_used"] = [];
    self.pers[#"killstreak_unique_id"] = [];
    self.pers[#"killstreak_ammo_count"] = [];
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xad735204, Offset: 0x5420
// Size: 0x372
function remove_used_killstreak(killstreak, killstreakid, take_weapon_after_use = 1) {
    self.just_removed_used_killstreak = undefined;
    if (!isdefined(self.pers[#"killstreaks"])) {
        return;
    }
    killstreakindex = undefined;
    for (i = self.pers[#"killstreaks"].size - 1; i >= 0; i--) {
        if (self.pers[#"killstreaks"][i] == killstreak) {
            if (isdefined(killstreakid) && self.pers[#"killstreak_unique_id"][i] != killstreakid) {
                continue;
            }
            killstreakindex = i;
            break;
        }
    }
    if (!isdefined(killstreakindex)) {
        return 0;
    }
    self.just_removed_used_killstreak = killstreak;
    if (take_weapon_after_use && !self has_killstreak_in_class(get_menu_name(killstreak))) {
        self thread take_weapon_after_use(get_killstreak_weapon(killstreak));
    }
    arraysize = self.pers[#"killstreaks"].size;
    for (i = killstreakindex; i < arraysize - 1; i++) {
        self.pers[#"killstreaks"][i] = self.pers[#"killstreaks"][i + 1];
        self.pers[#"killstreak_has_been_used"][i] = self.pers[#"killstreak_has_been_used"][i + 1];
        self.pers[#"killstreak_unique_id"][i] = self.pers[#"killstreak_unique_id"][i + 1];
        self.pers[#"killstreak_ammo_count"][i] = self.pers[#"killstreak_ammo_count"][i + 1];
    }
    self.pers[#"killstreaks"][arraysize - 1] = undefined;
    self.pers[#"killstreak_has_been_used"][arraysize - 1] = undefined;
    self.pers[#"killstreak_unique_id"][arraysize - 1] = undefined;
    self.pers[#"killstreak_ammo_count"][arraysize - 1] = undefined;
    return 1;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xaec354bd, Offset: 0x57a0
// Size: 0xb2
function take_weapon_after_use(killstreakweapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"joined_team");
    self endon(#"joined_spectators");
    self waittill(#"weapon_change");
    inventoryweapon = self getinventoryweapon();
    if (inventoryweapon != killstreakweapon) {
        self takeweapon(killstreakweapon);
    }
    self.killstreakactivated = 1;
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x37344fee, Offset: 0x5860
// Size: 0x66
function get_top_killstreak() {
    if (self.pers[#"killstreaks"].size == 0) {
        return undefined;
    }
    return self.pers[#"killstreaks"][self.pers[#"killstreaks"].size - 1];
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0xeaa15d85, Offset: 0x58d0
// Size: 0x88
function get_if_top_killstreak_has_been_used() {
    if (!(isdefined(level.usingmomentum) && level.usingmomentum)) {
        if (self.pers[#"killstreak_has_been_used"].size == 0) {
            return undefined;
        }
        return self.pers[#"killstreak_has_been_used"][self.pers[#"killstreak_has_been_used"].size - 1];
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x2f1b5874, Offset: 0x5960
// Size: 0x66
function get_top_killstreak_unique_id() {
    if (self.pers[#"killstreak_unique_id"].size == 0) {
        return undefined;
    }
    return self.pers[#"killstreak_unique_id"][self.pers[#"killstreak_unique_id"].size - 1];
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x9739823, Offset: 0x59d0
// Size: 0x7a
function get_killstreak_index_by_id(killstreakid) {
    for (index = self.pers[#"killstreak_unique_id"].size - 1; index >= 0; index--) {
        if (self.pers[#"killstreak_unique_id"][index] == killstreakid) {
            return index;
        }
    }
    return undefined;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xfa5c924d, Offset: 0x5a58
// Size: 0x92
function get_killstreak_momentum_cost(player, killstreak) {
    if (!(isdefined(level.usingmomentum) && level.usingmomentum)) {
        return 0;
    }
    if (!isdefined(killstreak)) {
        return 0;
    }
    assert(isdefined(level.killstreaks[killstreak]));
    return player function_ec6a435b(level.killstreaks[killstreak].itemindex);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xfe2bc56e, Offset: 0x5af8
// Size: 0x82
function get_killstreak_for_weapon_for_stats(weapon) {
    prefix = "inventory_";
    killstreak = get_killstreak_for_weapon(weapon);
    if (isdefined(killstreak)) {
        if (strstartswith(killstreak, prefix)) {
            killstreak = getsubstr(killstreak, prefix.size);
        }
    }
    return killstreak;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x83c27ba3, Offset: 0x5b88
// Size: 0x7e
function get_killstreak_team_kill_penalty_scale(weapon) {
    killstreak = get_killstreak_for_weapon(weapon);
    if (!isdefined(killstreak)) {
        return 1;
    }
    return isdefined(level.killstreaks[killstreak].teamkillpenaltyscale) ? level.killstreaks[killstreak].teamkillpenaltyscale : 1;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xe103015c, Offset: 0x5c10
// Size: 0x96
function wait_till_heavy_weapon_is_fully_on(weapon) {
    self endon(#"death", #"disconnect");
    slot = self gadgetgetslot(weapon);
    while (weapon == self getcurrentweapon()) {
        if (self util::gadget_is_in_use(slot)) {
            self.lastnonkillstreakweapon = weapon;
            return;
        }
        waitframe(1);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x62d30ac8, Offset: 0x5cb0
// Size: 0x212
function function_4ca0da85(params) {
    if (game.state == "postgame") {
        return;
    }
    assert(self.lastnonkillstreakweapon != level.weaponnone);
    lastvalidpimary = self.lastnonkillstreakweapon;
    weapon = params.weapon;
    if (weapons::is_primary_weapon(weapon)) {
        lastvalidpimary = weapon;
    }
    if (weapon == self.lastnonkillstreakweapon || weapon == level.weaponnone || weapon == level.weaponbasemelee) {
        return;
    }
    if (weapon.isgameplayweapon) {
        return;
    }
    if (isdefined(self.resurrect_weapon) && weapon == self.resurrect_weapon) {
        return;
    }
    name = get_killstreak_for_weapon(weapon);
    if (isdefined(name) && !weapon.iscarriedkillstreak) {
        killstreak = level.killstreaks[name];
        return;
    }
    if (params.last_weapon.isequipment) {
        if (self.lastnonkillstreakweapon.iscarriedkillstreak) {
            self.lastnonkillstreakweapon = lastvalidpimary;
        }
        return;
    }
    if (ability_util::is_hero_weapon(weapon)) {
        if (weapon.gadget_heroversion_2_0) {
            if (weapon.isgadget && self getammocount(weapon) > 0) {
                self thread wait_till_heavy_weapon_is_fully_on(weapon);
                return;
            }
        }
    }
    self.lastnonkillstreakweapon = weapon;
}

// Namespace killstreaks/killstreaks_shared
// Params 5, eflags: 0x0
// Checksum 0x49b92eb9, Offset: 0x5ed0
// Size: 0x6c
function function_1e9b6e10(timeout, timeoutcallback, endcondition1, endcondition2, endcondition3) {
    waitframe(1);
    placeable = self;
    placeable thread waitfortimeout(placeable.killstreakref, timeout, timeoutcallback, endcondition1, endcondition2);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x80d462cd, Offset: 0x5f48
// Size: 0x2cc
function function_ca64bffb(params) {
    weapon = params.weapon;
    if (!is_killstreak_weapon(weapon)) {
        return;
    }
    if (function_49792b6f(weapon)) {
        return;
    }
    killstreak = get_killstreak_for_weapon(weapon);
    if (isdefined(level.forceusekillstreak) && level.forceusekillstreak) {
        thread usekillstreak(killstreak, undefined);
        return;
    }
    if (!(isdefined(level.usingmomentum) && level.usingmomentum)) {
        killstreak = get_top_killstreak();
        if (weapon != get_killstreak_weapon(killstreak)) {
            return;
        }
    }
    if (is_remote_override_weapon(killstreak, weapon)) {
        return;
    }
    waittillframeend();
    if (isdefined(self.usingkillstreakheldweapon) && self.usingkillstreakheldweapon && weapon.iscarriedkillstreak) {
        return;
    }
    isfrominventory = undefined;
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
        if (weapon == self getinventoryweapon()) {
            isfrominventory = 1;
        } else if (self getammocount(weapon) <= 0 && weapon.name != "killstreak_ai_tank") {
            self switch_to_last_non_killstreak_weapon();
            return;
        }
    } else if (isdefined(level.usingmomentum) && level.usingmomentum) {
        if (weapon == self getinventoryweapon()) {
            isfrominventory = 1;
        } else if (self.momentum < self function_ec6a435b(level.killstreaks[killstreak].itemindex)) {
            self switch_to_last_non_killstreak_weapon();
            return;
        }
    }
    if (!isdefined(level.starttime) && level.roundstartkillstreakdelay > 0) {
        display_unavailable_time();
        return;
    }
    thread usekillstreak(killstreak, isfrominventory);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x7ad91d0f, Offset: 0x6220
// Size: 0xdc
function on_grenade_fired(params) {
    grenade = params.projectile;
    grenadeweaponid = params.weapon;
    if (grenadeweaponid == level.var_35c93bc7) {
        return;
    }
    if (grenadeweaponid.inventorytype === "offhand") {
        if (is_killstreak_weapon(grenadeweaponid)) {
            killstreak = get_killstreak_for_weapon(grenadeweaponid);
            isfrominventory = grenadeweaponid == self getinventoryweapon();
            thread usekillstreak(killstreak, isfrominventory);
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x47bfdfda, Offset: 0x6308
// Size: 0xac
function on_offhand_fire(params) {
    grenadeweaponid = params.weapon;
    if (grenadeweaponid == level.var_35c93bc7) {
        return;
    }
    if (is_killstreak_weapon(grenadeweaponid)) {
        killstreak = get_killstreak_for_weapon(grenadeweaponid);
        isfrominventory = grenadeweaponid == self getinventoryweapon();
        thread usekillstreak(killstreak, isfrominventory);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xc6cc368e, Offset: 0x63c0
// Size: 0xe8
function should_delay_killstreak(killstreaktype) {
    if (!isdefined(level.starttime)) {
        return false;
    }
    if (level.roundstartkillstreakdelay < float(gettime() - level.starttime - level.discardtime) / 1000) {
        return false;
    }
    if (!is_delayable_killstreak(killstreaktype)) {
        return false;
    }
    killstreakweapon = get_killstreak_weapon(killstreaktype);
    if (killstreakweapon.iscarriedkillstreak) {
        return false;
    }
    if (util::isfirstround() || util::isoneround()) {
        return false;
    }
    return true;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x5abf8071, Offset: 0x64b0
// Size: 0x62
function is_delayable_killstreak(killstreaktype) {
    if (isdefined(level.killstreaks[killstreaktype]) && isdefined(level.killstreaks[killstreaktype].delaystreak) && level.killstreaks[killstreaktype].delaystreak) {
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xa13ebf32, Offset: 0x6520
// Size: 0x186
function get_xp_amount_for_killstreak(killstreaktype) {
    xpamount = 0;
    switch (level.killstreaks[killstreaktype].killstreaklevel) {
    case 1:
    case 2:
    case 3:
    case 4:
        xpamount = 100;
        break;
    case 5:
        xpamount = 150;
        break;
    case 6:
    case 7:
        xpamount = 200;
        break;
    case 8:
        xpamount = 250;
        break;
    case 9:
        xpamount = 300;
        break;
    case 10:
    case 11:
        xpamount = 350;
        break;
    case 12:
    case 13:
    case 14:
    case 15:
        xpamount = 500;
        break;
    }
    return xpamount;
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x36ab669, Offset: 0x66b0
// Size: 0xbc
function display_unavailable_time() {
    timepassed = float([[ level.gettimepassed ]]()) / 1000;
    timeleft = int(level.roundstartkillstreakdelay - timepassed);
    if (timeleft <= 0) {
        timeleft = 1;
    }
    self iprintlnbold(#"hash_55a79f95e07a10bc", " " + timeleft + " ", #"hash_79a58948c3b976f5");
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x522e07c8, Offset: 0x6778
// Size: 0x2c0
function trigger_killstreak(killstreaktype, isfrominventory) {
    assert(isdefined(level.killstreaks[killstreaktype].usefunction), "<dev string:x100>" + killstreaktype);
    self.usingkillstreakfrominventory = isfrominventory;
    if (isdefined(level.infinalkillcam) && level.infinalkillcam) {
        return false;
    }
    if (should_delay_killstreak(killstreaktype)) {
        display_unavailable_time();
    } else {
        success = [[ level.killstreaks[killstreaktype].usefunction ]](killstreaktype);
        if (isdefined(success) && success) {
            if (isdefined(self)) {
                if (!isdefined(self.pers[level.killstreaks[killstreaktype].usagekey])) {
                    self.pers[level.killstreaks[killstreaktype].usagekey] = 0;
                }
                self.pers[level.killstreaks[killstreaktype].usagekey]++;
                self notify(#"killstreak_used", killstreaktype);
                self notify(#"killstreak_done", {#is_successful:1, #var_e409027f:killstreaktype});
            }
            self.usingkillstreakfrominventory = undefined;
            return true;
        } else if (isdefined(level.killstreaks[killstreaktype]) && isdefined(level.killstreaks[killstreaktype].weapon) && isdefined(level.killstreaks[killstreaktype].weapon.deployable) && level.killstreaks[killstreaktype].weapon.deployable && isdefined(self)) {
            self deployable::function_76d9b29b(level.killstreaks[killstreaktype].weapon);
        }
    }
    self.usingkillstreakfrominventory = undefined;
    if (isdefined(self)) {
        self notify(#"killstreak_done", {#is_successful:0, #var_e409027f:killstreaktype});
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x1eca72c9, Offset: 0x6a40
// Size: 0x5e
function add_to_killstreak_count(weapon) {
    if (!isdefined(self.pers[#"totalkillstreakcount"])) {
        self.pers[#"totalkillstreakcount"] = 0;
    }
    self.pers[#"totalkillstreakcount"]++;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x160338f8, Offset: 0x6aa8
// Size: 0xd6
function get_first_valid_killstreak_alt_weapon(killstreaktype) {
    assert(isdefined(level.killstreaks[killstreaktype]), "<dev string:x3fb>");
    if (isdefined(level.killstreaks[killstreaktype].altweapons)) {
        for (i = 0; i < level.killstreaks[killstreaktype].altweapons.size; i++) {
            if (isdefined(level.killstreaks[killstreaktype].altweapons[i])) {
                return level.killstreaks[killstreaktype].altweapons[i];
            }
        }
    }
    return level.weaponnone;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x4f61edd2, Offset: 0x6b88
// Size: 0x5e
function should_give_killstreak(weapon) {
    killstreakbuilding = getdvarint(#"scr_allow_killstreak_building", 0);
    if (killstreakbuilding == 0) {
        if (is_weapon_associated_with_killstreak(weapon)) {
            return false;
        }
    }
    return true;
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xb56ef53, Offset: 0x6bf0
// Size: 0x42
function point_is_in_danger_area(point, targetpos, radius) {
    return distance2d(point, targetpos) <= radius * 1.25;
}

// Namespace killstreaks/killstreaks_shared
// Params 5, eflags: 0x0
// Checksum 0x632cbea9, Offset: 0x6c40
// Size: 0x2bc
function print_killstreak_start_text(killstreaktype, owner, team, targetpos, dangerradius) {
    if (!isdefined(level.killstreaks[killstreaktype])) {
        return;
    }
    if (level.teambased) {
        players = level.players;
        if (!level.hardcoremode && isdefined(level.killstreaks[killstreaktype].inboundnearplayertext)) {
            for (i = 0; i < players.size; i++) {
                if (isalive(players[i]) && isdefined(players[i].pers[#"team"]) && players[i].pers[#"team"] == team) {
                    if (point_is_in_danger_area(players[i].origin, targetpos, dangerradius)) {
                        players[i] iprintlnbold(level.killstreaks[killstreaktype].inboundnearplayertext);
                    }
                }
            }
        }
        if (isdefined(level.killstreaks[killstreaktype])) {
            for (i = 0; i < level.players.size; i++) {
                player = level.players[i];
                playerteam = player.pers[#"team"];
                if (isdefined(playerteam)) {
                    if (playerteam == team) {
                        player iprintln(level.killstreaks[killstreaktype].inboundtext, owner);
                    }
                }
            }
        }
        return;
    }
    if (!level.hardcoremode && isdefined(level.killstreaks[killstreaktype].inboundnearplayertext)) {
        if (point_is_in_danger_area(owner.origin, targetpos, dangerradius)) {
            owner iprintlnbold(level.killstreaks[killstreaktype].inboundnearplayertext);
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x333311d4, Offset: 0x6f08
// Size: 0x20c
function play_killstreak_ready_sfx(killstreaktype) {
    if (!isdefined(level.gameended) || !level.gameended) {
        switch (killstreaktype) {
        case #"uav":
            var_a82fe87e = "uin_kls_uav";
            break;
        case #"counteruav":
            var_a82fe87e = "uin_kls_counteruav";
            break;
        case #"remote_missile":
            var_a82fe87e = "uin_kls_remote_missile";
            break;
        case #"ultimate_turret":
            var_a82fe87e = "uin_kls_ultimate_turret";
            break;
        case #"helicopter_comlink":
            var_a82fe87e = "uin_kls_helicopter_comlink";
            break;
        case #"tank_robot":
            var_a82fe87e = "uin_kls_tank_robot";
            break;
        case #"swat_team":
            var_a82fe87e = "uin_kls_swat_team";
            break;
        case #"ac130":
            var_a82fe87e = "uin_kls_ac130";
            break;
        case #"recon_car":
            var_a82fe87e = "uin_kls_rcbomb";
            break;
        case #"supply_drop":
            var_a82fe87e = "uin_kls_supply_drop";
            break;
        case #"planemortar":
            var_a82fe87e = "uin_kls_airstrike";
            break;
        case #"straferun":
            var_a82fe87e = "uin_kls_straferun";
            break;
        }
        if (isdefined(var_a82fe87e)) {
            self playsoundtoplayer(var_a82fe87e, self);
            return;
        }
        self playsoundtoplayer("uin_kls_generic", self);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x33edfe12, Offset: 0x7120
// Size: 0x120
function killstreak_dialog_queued(dialogkey, killstreaktype, killstreakid) {
    if (!isdefined(dialogkey) || !isdefined(killstreaktype)) {
        return;
    }
    if (isdefined(self.currentkillstreakdialog)) {
        if (dialogkey === self.currentkillstreakdialog.dialogkey && killstreaktype === self.currentkillstreakdialog.killstreaktype && killstreakid === self.currentkillstreakdialog.killstreakid) {
            return 1;
        }
    }
    for (i = 0; i < self.killstreakdialogqueue.size; i++) {
        if (dialogkey === self.killstreakdialogqueue[i].dialogkey && killstreaktype === self.killstreakdialogqueue[i].killstreaktype && killstreaktype === self.killstreakdialogqueue[i].killstreaktype) {
            return 1;
        }
    }
    return 0;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x4af03c7a, Offset: 0x7248
// Size: 0xdc
function play_killstreak_ready_dialog(killstreaktype, taacomwaittime) {
    self notify("killstreak_ready_" + killstreaktype);
    self endon(#"death");
    self endon("killstreak_start_" + killstreaktype);
    self endon("killstreak_ready_" + killstreaktype);
    level endon(#"game_ended");
    if (isdefined(level.gameended) && level.gameended) {
        return;
    }
    if (killstreak_dialog_queued("ready", killstreaktype)) {
        return;
    }
    if (isdefined(taacomwaittime)) {
        wait taacomwaittime;
    }
    self play_taacom_dialog("ready", killstreaktype);
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x6ef78bcf, Offset: 0x7330
// Size: 0x7c
function play_taacom_dialog_on_owner(dialogkey, killstreaktype, killstreakid) {
    if (!isdefined(self.owner) || !isdefined(self.team) || self.team != self.owner.team) {
        return;
    }
    self.owner play_taacom_dialog(dialogkey, killstreaktype, killstreakid);
}

// Namespace killstreaks/killstreaks_shared
// Params 4, eflags: 0x0
// Checksum 0x28367408, Offset: 0x73b8
// Size: 0x84
function play_taacom_dialog_response(dialogkey, killstreaktype, killstreakid, pilotindex) {
    assert(isdefined(dialogkey));
    assert(isdefined(killstreaktype));
    if (!isdefined(pilotindex)) {
        return;
    }
    self play_taacom_dialog(dialogkey + pilotindex, killstreaktype, killstreakid);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x4fcfa12, Offset: 0x7448
// Size: 0x320
function player_killstreak_threat_tracking(killstreaktype) {
    assert(isdefined(killstreaktype));
    self endon(#"death");
    self endon(#"delete");
    self endon(#"leaving");
    level endon(#"game_ended");
    while (true) {
        if (!isdefined(self.owner)) {
            return;
        }
        players = self.owner dialog_shared::get_enemy_players();
        players = array::randomize(players);
        foreach (player in players) {
            if (!player dialog_shared::can_play_dialog(1)) {
                continue;
            }
            lookangles = player getplayerangles();
            if (lookangles[0] < 270 || lookangles[0] > 330) {
                continue;
            }
            lookdir = anglestoforward(lookangles);
            eyepoint = player geteye();
            streakdir = vectornormalize(self.origin - eyepoint);
            dot = vectordot(streakdir, lookdir);
            if (dot < 0.94) {
                continue;
            }
            traceresult = bullettrace(eyepoint, self.origin, 1, player);
            if (traceresult[#"fraction"] >= 1 || traceresult[#"entity"] === self) {
                if (dialog_shared::dialog_chance("killstreakSpotChance")) {
                    player dialog_shared::play_killstreak_threat(killstreaktype);
                }
                wait dialog_shared::mpdialog_value("killstreakSpotDelay", 0);
                break;
            }
        }
        wait dialog_shared::mpdialog_value("killstreakSpotInterval", float(function_f9f48566()) / 1000);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xa0447db4, Offset: 0x7770
// Size: 0x46
function get_killstreak_inform_dialog(killstreaktype) {
    if (isdefined(level.killstreaks[killstreaktype].informdialog)) {
        return level.killstreaks[killstreaktype].informdialog;
    }
    return "";
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x9fc4e751, Offset: 0x77c0
// Size: 0x62
function get_killstreak_usage_by_killstreak(killstreaktype) {
    assert(isdefined(level.killstreaks[killstreaktype]), "<dev string:x416>");
    return get_killstreak_usage(level.killstreaks[killstreaktype].usagekey);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x66229e3b, Offset: 0x7830
// Size: 0x30
function get_killstreak_usage(usagekey) {
    if (!isdefined(self.pers[usagekey])) {
        return 0;
    }
    return self.pers[usagekey];
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x1b02913f, Offset: 0x7868
// Size: 0xee
function on_player_spawned() {
    profilestart();
    pixbeginevent(#"hash_1d81325f0403ec55");
    self thread give_owned();
    self.killcamkilledbyent = undefined;
    self callback::on_weapon_change(&function_4ca0da85);
    self callback::on_weapon_change(&function_ca64bffb);
    self callback::on_grenade_fired(&on_grenade_fired);
    self callback::on_offhand_fire(&on_offhand_fire);
    self thread initialspawnprotection();
    pixendevent();
    profilestop();
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x8cf28e9e, Offset: 0x7960
// Size: 0x166
function on_joined_team(params) {
    self endon(#"disconnect");
    self setinventoryweapon(level.weaponnone);
    self.pers[#"cur_kill_streak"] = 0;
    self.pers[#"cur_total_kill_streak"] = 0;
    self setplayercurrentstreak(0);
    self.pers[#"totalkillstreakcount"] = 0;
    self.pers[#"killstreaks"] = [];
    self.pers[#"killstreak_has_been_used"] = [];
    self.pers[#"killstreak_unique_id"] = [];
    self.pers[#"killstreak_ammo_count"] = [];
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
        self.pers[#"killstreak_quantity"] = [];
        self.pers[#"held_killstreak_ammo_count"] = [];
        self.pers[#"held_killstreak_clip_count"] = [];
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x4
// Checksum 0x6239b772, Offset: 0x7ad0
// Size: 0x11c
function private initialspawnprotection() {
    self endon(#"death");
    self endon(#"disconnect");
    self thread airsupport::monitorspeed(level.spawnprotectiontime);
    if (!isdefined(level.spawnprotectiontime) || level.spawnprotectiontime == 0) {
        return;
    }
    self.specialty_nottargetedbyairsupport = 1;
    self clientfield::set("killstreak_spawn_protection", 1);
    self val::set(#"killstreak_spawn_protection", "ignoreme", 1);
    wait level.spawnprotectiontime;
    self clientfield::set("killstreak_spawn_protection", 0);
    self.specialty_nottargetedbyairsupport = undefined;
    self val::reset(#"killstreak_spawn_protection", "ignoreme");
}

/#

    // Namespace killstreaks/killstreaks_shared
    // Params 0, eflags: 0x0
    // Checksum 0x104f79f6, Offset: 0x7bf8
    // Size: 0xe0
    function killstreak_debug_think() {
        setdvar(#"debug_killstreak", "<dev string:x6a>");
        for (;;) {
            cmd = getdvarstring(#"debug_killstreak");
            switch (cmd) {
            case #"data_dump":
                killstreak_data_dump();
                break;
            }
            if (cmd != "<dev string:x6a>") {
                setdvar(#"debug_killstreak", "<dev string:x6a>");
            }
            wait 0.5;
        }
    }

    // Namespace killstreaks/killstreaks_shared
    // Params 0, eflags: 0x0
    // Checksum 0x4415c5f6, Offset: 0x7ce0
    // Size: 0x33c
    function killstreak_data_dump() {
        iprintln("<dev string:x45d>");
        println("<dev string:x47d>");
        println("<dev string:x499>");
        keys = getarraykeys(level.killstreaks);
        for (i = 0; i < keys.size; i++) {
            data = level.killstreaks[keys[i]];
            type_data = level.killstreaktype[keys[i]];
            print(keys[i] + "<dev string:x4ff>");
            print(data.killstreaklevel + "<dev string:x4ff>");
            print(data.weapon.name + "<dev string:x4ff>");
            alt = 0;
            if (isdefined(data.altweapons)) {
                assert(data.altweapons.size <= 4);
                for (alt = 0; alt < data.altweapons.size; alt++) {
                    print(data.altweapons[alt].name + "<dev string:x4ff>");
                }
            }
            while (alt < 4) {
                print("<dev string:x4ff>");
                alt++;
            }
            type = 0;
            if (isdefined(type_data)) {
                assert(type_data.size < 4);
                type_keys = getarraykeys(type_data);
                while (type < type_keys.size) {
                    if (type_data[type_keys[type]] == 1) {
                        print(type_keys[type] + "<dev string:x4ff>");
                    }
                    type++;
                }
            }
            while (type < 4) {
                print("<dev string:x4ff>");
                type++;
            }
            println("<dev string:x6a>");
        }
        println("<dev string:x501>");
    }

#/

// Namespace killstreaks/killstreaks_shared
// Params 4, eflags: 0x0
// Checksum 0x79d9deef, Offset: 0x8028
// Size: 0x94
function function_1c47e9c9(killstreak_ref, destroyed_callback, low_health_callback, emp_callback) {
    self setcandamage(1);
    self thread monitordamage(killstreak_ref, killstreak_bundles::get_max_health(killstreak_ref), destroyed_callback, killstreak_bundles::get_low_health(killstreak_ref), low_health_callback, 0, emp_callback, 1);
}

// Namespace killstreaks/killstreaks_shared
// Params 8, eflags: 0x0
// Checksum 0x499d043c, Offset: 0x80c8
// Size: 0x6ee
function monitordamage(killstreak_ref, max_health, destroyed_callback, low_health, low_health_callback, emp_damage, emp_callback, allow_bullet_damage) {
    self endon(#"death");
    self endon(#"delete");
    self setcandamage(1);
    self setup_health(killstreak_ref, max_health, low_health);
    self.health = self.maxhealth;
    self.damagetaken = 0;
    while (true) {
        weapon_damage = undefined;
        waitresult = self waittill(#"damage");
        attacker = waitresult.attacker;
        damage = waitresult.amount;
        direction = waitresult.direction;
        point = waitresult.position;
        type = waitresult.mod;
        tagname = waitresult.tag_name;
        modelname = waitresult.model_name;
        partname = waitresult.part_name;
        weapon = waitresult.weapon;
        flags = waitresult.flags;
        inflictor = waitresult.inflictor;
        chargelevel = waitresult.charge_level;
        if (isdefined(self.invulnerable) && self.invulnerable) {
            continue;
        }
        if (!isdefined(attacker) || !isplayer(attacker)) {
            continue;
        }
        friendlyfire = damage::friendlyfirecheck(self.owner, attacker);
        if (!friendlyfire) {
            continue;
        }
        if (isdefined(self.owner) && attacker == self.owner) {
            continue;
        }
        isvalidattacker = 1;
        if (level.teambased) {
            isvalidattacker = isdefined(attacker.team) && attacker.team != self.team;
        }
        if (!isvalidattacker) {
            continue;
        }
        if (isdefined(self.killstreakdamagemodifier)) {
            damage = [[ self.killstreakdamagemodifier ]](damage, attacker, direction, point, type, tagname, modelname, partname, weapon, flags, inflictor, chargelevel);
            if (damage <= 0) {
                continue;
            }
        }
        if (weapon.isemp && type == "MOD_GRENADE_SPLASH") {
            emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage(killstreak_ref, self.maxhealth);
            if (!isdefined(emp_damage_to_apply)) {
                emp_damage_to_apply = isdefined(emp_damage) ? emp_damage : 1;
            }
            if (isdefined(emp_callback) && emp_damage_to_apply > 0) {
                self [[ emp_callback ]](attacker);
            }
            weapon_damage = emp_damage_to_apply;
        }
        if (isdefined(self.selfdestruct) && self.selfdestruct) {
            weapon_damage = self.maxhealth + 1;
        }
        if (!isdefined(weapon_damage)) {
            weapon_damage = killstreak_bundles::get_weapon_damage(killstreak_ref, self.maxhealth, attacker, weapon, type, damage, flags, chargelevel);
            if (!isdefined(weapon_damage)) {
                weapon_damage = get_old_damage(attacker, weapon, type, damage, allow_bullet_damage);
            }
        }
        if (weapon_damage > 0) {
            if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                if (!isvehicle(self)) {
                    attacker thread damagefeedback::update(type, undefined, undefined, weapon, self);
                }
            }
            self challenges::trackassists(attacker, weapon_damage, 0);
        }
        self.damagetaken += weapon_damage;
        if (!issentient(self) && weapon_damage > 0) {
            self.attacker = attacker;
        }
        if (self.damagetaken > self.maxhealth) {
            level.globalkillstreaksdestroyed++;
            attacker stats::function_4f10b697(getweapon(killstreak_ref), #"destroyed", 1);
            self function_8acf563(attacker, weapon, self.owner);
            if (isdefined(destroyed_callback)) {
                self thread [[ destroyed_callback ]](attacker, weapon);
            }
            return;
        }
        remaining_health = max_health - self.damagetaken;
        if (remaining_health < low_health && weapon_damage > 0) {
            if (isdefined(low_health_callback) && (!isdefined(self.currentstate) || self.currentstate != "damaged")) {
                self [[ low_health_callback ]](attacker, weapon);
            }
            self.currentstate = "damaged";
        }
        if (isdefined(self.extra_low_health) && remaining_health < self.extra_low_health && weapon_damage > 0) {
            if (isdefined(self.extra_low_health_callback) && !isdefined(self.extra_low_damage_notified)) {
                self [[ self.extra_low_health_callback ]](attacker, weapon);
                self.extra_low_damage_notified = 1;
            }
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xdd8eb955, Offset: 0x87c0
// Size: 0x338
function function_8acf563(attacker, weapon, owner) {
    if (!isdefined(self) || isdefined(self.var_d114dda4) && self.var_d114dda4 || !isdefined(attacker) || !isplayer(attacker) || !isdefined(self.killstreaktype)) {
        return;
    }
    bundle = level.killstreakbundle[self.killstreaktype];
    if (isdefined(bundle) && isdefined(bundle.var_2df60b42)) {
        scoreevents::processscoreevent(bundle.var_2df60b42, attacker, owner, weapon);
        attacker stats::function_b48aa4e(#"stats_destructions", 1);
        self.var_d114dda4 = 1;
        if (isdefined(self.attackers) && self.attackers.size > 0) {
            maxhealth = 1 / self.maxhealth;
            if (!isdefined(bundle.var_4f545fab)) {
                return;
            }
            foreach (assister in self.attackers) {
                if (assister == attacker || !isplayer(assister)) {
                    continue;
                }
                if (isdefined(bundle.var_4eac468) && isdefined(self.attackerdamage)) {
                    timepassed = float(gettime() - self.attackerdamage[assister.clientid].lastdamagetime) / 1000;
                    if (timepassed > bundle.var_4eac468) {
                        continue;
                    }
                }
                if (isdefined(bundle.var_d70c14b8) && isdefined(self.attackerdamage)) {
                    damagepercent = self.attackerdamage[assister.clientid].damage * maxhealth;
                    if (damagepercent < bundle.var_d70c14b8) {
                        continue;
                    }
                }
                scoreevents::processscoreevent(bundle.var_4f545fab, assister, owner, self.attackerdamage[assister.clientid].weapon);
                assister stats::function_b48aa4e(#"stats_destructions", 1);
            }
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 14, eflags: 0x0
// Checksum 0x1fd3285b, Offset: 0x8b00
// Size: 0x35c
function ondamageperweapon(killstreak_ref, attacker, damage, flags, type, weapon, max_health, destroyed_callback, low_health, low_health_callback, emp_damage, emp_callback, allow_bullet_damage, chargelevel) {
    self.maxhealth = max_health;
    self.lowhealth = low_health;
    tablehealth = killstreak_bundles::get_max_health(killstreak_ref);
    if (isdefined(tablehealth)) {
        self.maxhealth = tablehealth;
    }
    tablehealth = killstreak_bundles::get_low_health(killstreak_ref);
    if (isdefined(tablehealth)) {
        self.lowhealth = tablehealth;
    }
    if (isdefined(self.invulnerable) && self.invulnerable) {
        return 0;
    }
    if (!isdefined(attacker) || !isplayer(attacker)) {
        return get_old_damage(attacker, weapon, type, damage, allow_bullet_damage);
    }
    friendlyfire = damage::friendlyfirecheck(self.owner, attacker);
    if (!friendlyfire) {
        return 0;
    }
    isvalidattacker = 1;
    if (level.teambased) {
        isvalidattacker = isdefined(attacker.team) && attacker.team != self.team;
    }
    if (!isvalidattacker) {
        return 0;
    }
    if (weapon.isemp && type == "MOD_GRENADE_SPLASH") {
        emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage(killstreak_ref, self.maxhealth);
        if (!isdefined(emp_damage_to_apply)) {
            emp_damage_to_apply = isdefined(emp_damage) ? emp_damage : 1;
        }
        if (isdefined(emp_callback) && emp_damage_to_apply > 0) {
            self [[ emp_callback ]](attacker, weapon);
        }
        return emp_damage_to_apply;
    }
    weapon_damage = killstreak_bundles::get_weapon_damage(killstreak_ref, self.maxhealth, attacker, weapon, type, damage, flags, chargelevel);
    if (!isdefined(weapon_damage)) {
        weapon_damage = get_old_damage(attacker, weapon, type, damage, allow_bullet_damage);
    }
    if (weapon_damage <= 0) {
        return 0;
    }
    idamage = int(weapon_damage);
    if (idamage > self.health) {
        self function_8acf563(attacker, weapon, self.owner);
        if (isdefined(destroyed_callback)) {
            self thread [[ destroyed_callback ]](attacker, weapon);
        }
    }
    return idamage;
}

// Namespace killstreaks/killstreaks_shared
// Params 6, eflags: 0x0
// Checksum 0x26542665, Offset: 0x8e68
// Size: 0x246
function get_old_damage(attacker, weapon, type, damage, allow_bullet_damage, bullet_damage_scalar) {
    switch (type) {
    case #"mod_rifle_bullet":
    case #"mod_pistol_bullet":
        if (!allow_bullet_damage) {
            damage = 0;
            break;
        }
        if (isdefined(attacker) && isplayer(attacker)) {
            hasfmj = attacker hasperk(#"specialty_armorpiercing");
        }
        if (isdefined(hasfmj) && hasfmj) {
            damage = int(damage * level.cac_armorpiercing_data);
        }
        if (isdefined(bullet_damage_scalar)) {
            damage = int(damage * bullet_damage_scalar);
        }
        break;
    case #"mod_explosive":
    case #"mod_projectile":
    case #"mod_projectile_splash":
        if (weapon.statindex == level.weaponpistolenergy.statindex || weapon.statindex != level.weaponshotgunenergy.statindex || weapon.statindex == level.weaponspecialcrossbow.statindex) {
            break;
        }
        if (isdefined(self.remotemissiledamage) && isdefined(weapon) && weapon.name == #"remote_missile_missile") {
            damage = self.remotemissiledamage;
        } else if (isdefined(self.rocketdamage)) {
            damage = self.rocketdamage;
        }
        break;
    default:
        break;
    }
    return damage;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xe41f4d41, Offset: 0x90b8
// Size: 0x4c
function isheldinventorykillstreakweapon(killstreakweapon) {
    switch (killstreakweapon.name) {
    case #"inventory_m32":
    case #"inventory_minigun":
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 5, eflags: 0x0
// Checksum 0x7e8f071a, Offset: 0x9110
// Size: 0xac
function waitfortimecheck(duration, callback, endcondition1, endcondition2, endcondition3) {
    self endon(#"hacked");
    if (isdefined(endcondition1)) {
        self endon(endcondition1);
    }
    if (isdefined(endcondition2)) {
        self endon(endcondition2);
    }
    if (isdefined(endcondition3)) {
        self endon(endcondition3);
    }
    hostmigration::migrationawarewait(duration);
    self notify(#"time_check");
    self [[ callback ]]();
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0xb289051f, Offset: 0x91c8
// Size: 0x3a
function emp_isempd() {
    if (isdefined(level.emp_shared.enemyempactivefunc)) {
        return self [[ level.emp_shared.enemyempactivefunc ]]();
    }
    return 0;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xe45831f9, Offset: 0x9210
// Size: 0x74
function waittillemp(onempdcallback, arg) {
    self endon(#"death");
    self endon(#"delete");
    waitresult = self waittill(#"emp_deployed");
    if (isdefined(onempdcallback)) {
        [[ onempdcallback ]](waitresult.attacker, arg);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x98ba17cb, Offset: 0x9290
// Size: 0x11c
function destroyotherteamsequipment(attacker, weapon, radius) {
    foreach (team, _ in level.teams) {
        if (team == attacker.team) {
            continue;
        }
        destroyequipment(attacker, team, weapon, radius);
        destroytacticalinsertions(attacker, team, radius);
    }
    destroyequipment(attacker, "free", weapon, radius);
    destroytacticalinsertions(attacker, "free", radius);
}

// Namespace killstreaks/killstreaks_shared
// Params 4, eflags: 0x0
// Checksum 0x58c49fc, Offset: 0x93b8
// Size: 0x1d6
function destroyequipment(attacker, team, weapon, radius) {
    radiussq = radius * radius;
    for (i = 0; i < level.missileentities.size; i++) {
        item = level.missileentities[i];
        if (!isdefined(item)) {
            continue;
        }
        if (distancesquared(item.origin, attacker.origin) > radiussq) {
            continue;
        }
        if (!isdefined(item.weapon)) {
            continue;
        }
        if (!isdefined(item.owner)) {
            continue;
        }
        if (isdefined(team) && item.owner.team != team) {
            continue;
        } else if (item.owner == attacker) {
            continue;
        }
        if (!item.weapon.isequipment && !(isdefined(item.destroyedbyemp) && item.destroyedbyemp)) {
            continue;
        }
        watcher = item.owner weaponobjects::getwatcherforweapon(item.weapon);
        if (!isdefined(watcher)) {
            continue;
        }
        watcher thread weaponobjects::waitanddetonate(item, 0, attacker, weapon);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x1ad90393, Offset: 0x9598
// Size: 0x10e
function destroytacticalinsertions(attacker, victimteam, radius) {
    radiussq = radius * radius;
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (!isdefined(player.tacticalinsertion)) {
            continue;
        }
        if (level.teambased && player.team != victimteam) {
            continue;
        }
        if (attacker == player) {
            continue;
        }
        if (distancesquared(player.origin, attacker.origin) < radiussq) {
            player.tacticalinsertion thread tacticalinsertion::fizzle();
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xacb1ee91, Offset: 0x96b0
// Size: 0xb8
function destroyotherteamsactivevehicles(attacker, weapon, radius) {
    foreach (team, _ in level.teams) {
        if (team == attacker.team) {
            continue;
        }
        destroyactivevehicles(attacker, team, weapon, radius);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 4, eflags: 0x0
// Checksum 0xb0fb528, Offset: 0x9770
// Size: 0xb9c
function destroyactivevehicles(attacker, team, weapon, radius) {
    radiussq = radius * radius;
    targets = target_getarray();
    destroyentities(targets, attacker, team, weapon, radius);
    ai_tanks = getentarray("talon", "targetname");
    destroyentities(ai_tanks, attacker, team, weapon, radius);
    remotemissiles = getentarray("remote_missile", "targetname");
    destroyentities(remotemissiles, attacker, team, weapon, radius);
    remotedrone = getentarray("remote_drone", "targetname");
    destroyentities(remotedrone, attacker, team, weapon, radius);
    script_vehicles = getentarray("script_vehicle", "classname");
    foreach (vehicle in script_vehicles) {
        if (distancesquared(vehicle.origin, attacker.origin) > radiussq) {
            continue;
        }
        if (isdefined(team) && vehicle.team == team && isvehicle(vehicle)) {
            if (isdefined(vehicle.detonateviaemp) && isdefined(weapon.isempkillstreak) && weapon.isempkillstreak) {
                vehicle [[ vehicle.detonateviaemp ]](attacker, weapon);
            }
            if (isdefined(vehicle.archetype)) {
                if (vehicle.archetype == "turret" || vehicle.archetype == "rcbomb" || vehicle.archetype == "wasp") {
                    vehicle dodamage(vehicle.health + 1, vehicle.origin, attacker, attacker, "", "MOD_EXPLOSIVE", 0, weapon);
                }
            }
        }
    }
    planemortars = getentarray("plane_mortar", "targetname");
    foreach (planemortar in planemortars) {
        if (distance2d(planemortar.origin, attacker.origin) > radius) {
            continue;
        }
        if (isdefined(team) && isdefined(planemortar.team)) {
            if (planemortar.team != team) {
                continue;
            }
        } else if (planemortar.owner == attacker) {
            continue;
        }
        planemortar notify(#"emp_deployed", {#attacker:attacker});
    }
    dronestrikes = getentarray("drone_strike", "targetname");
    foreach (dronestrike in dronestrikes) {
        if (distance2d(dronestrike.origin, attacker.origin) > radius) {
            continue;
        }
        if (isdefined(team) && isdefined(dronestrike.team)) {
            if (dronestrike.team != team) {
                continue;
            }
        } else if (dronestrike.owner == attacker) {
            continue;
        }
        dronestrike notify(#"emp_deployed", {#attacker:attacker});
    }
    var_361f9014 = getentarray("guided_artillery_shell", "targetname");
    foreach (shell in var_361f9014) {
        if (distance2d(shell.origin, attacker.origin) > radius) {
            continue;
        }
        if (isdefined(team) && isdefined(shell.team)) {
            if (shell.team != team) {
                continue;
            }
        } else if (shell.owner == attacker) {
            continue;
        }
        shell notify(#"emp_deployed", {#attacker:attacker});
    }
    counteruavs = getentarray("counteruav", "targetname");
    foreach (counteruav in counteruavs) {
        if (distance2d(counteruav.origin, attacker.origin) > radius) {
            continue;
        }
        if (isdefined(team) && isdefined(counteruav.team)) {
            if (counteruav.team != team) {
                continue;
            }
        } else if (counteruav.owner == attacker) {
            continue;
        }
        counteruav notify(#"emp_deployed", {#attacker:attacker});
    }
    satellites = getentarray("satellite", "targetname");
    foreach (satellite in satellites) {
        if (distance2d(satellite.origin, attacker.origin) > radius) {
            continue;
        }
        if (isdefined(team) && isdefined(satellite.team)) {
            if (satellite.team != team) {
                continue;
            }
        } else if (satellite.owner == attacker) {
            continue;
        }
        satellite notify(#"emp_deployed", {#attacker:attacker});
    }
    robots = getaiarchetypearray("robot");
    foreach (robot in robots) {
        if (distancesquared(robot.origin, attacker.origin) > radiussq) {
            continue;
        }
        if (robot.allowdeath !== 0 && robot.magic_bullet_shield !== 1 && isdefined(team) && robot.team == team) {
            if (isdefined(attacker) && (!isdefined(robot.owner) || robot.owner util::isenemyplayer(attacker))) {
                scoreevents::processscoreevent(#"destroyed_combat_robot", attacker, robot.owner, weapon);
                luinotifyevent(#"player_callout", 2, #"hash_3b274c8c3c961f3", attacker.entnum);
            }
            robot kill();
        }
    }
    if (isdefined(level.missile_swarm_owner)) {
        if (level.missile_swarm_owner util::isenemyplayer(attacker)) {
            if (distancesquared(level.missile_swarm_owner.origin, attacker.origin) < radiussq) {
                level.missile_swarm_owner notify(#"emp_destroyed_missile_swarm", {#attacker:attacker});
            }
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 5, eflags: 0x0
// Checksum 0x841643c2, Offset: 0xa318
// Size: 0x25c
function destroyentities(entities, attacker, team, weapon, radius) {
    meansofdeath = "MOD_EXPLOSIVE";
    damage = 5000;
    direction_vec = (0, 0, 0);
    point = (0, 0, 0);
    modelname = "";
    tagname = "";
    partname = "";
    radiussq = radius * radius;
    foreach (entity in entities) {
        if (isdefined(team) && isdefined(entity.team)) {
            if (entity.team != team) {
                continue;
            }
        } else if (isdefined(entity.owner) && entity.owner == attacker) {
            continue;
        }
        if (distancesquared(entity.origin, attacker.origin) < radiussq) {
            entity notify(#"damage", {#amount:damage, #attacker:attacker, #direction:direction_vec, #position:point, #mod:meansofdeath, #tag_name:tagname, #model_name:modelname, #part_name:partname, #weapon:weapon});
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xeaa6b50, Offset: 0xa580
// Size: 0x62
function get_killstreak_for_weapon(weapon) {
    if (!isdefined(level.killstreakweapons)) {
        return undefined;
    }
    if (isdefined(level.killstreakweapons[weapon])) {
        return level.killstreakweapons[weapon];
    }
    return level.killstreakweapons[weapon.rootweapon];
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x875dac35, Offset: 0xa5f0
// Size: 0x5a
function is_killstreak_weapon_assist_allowed(weapon) {
    killstreak = get_killstreak_for_weapon(weapon);
    if (!isdefined(killstreak)) {
        return false;
    }
    if (level.killstreaks[killstreak].allowassists) {
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x3f4b3ec7, Offset: 0xa658
// Size: 0xaa
function should_override_entity_camera_in_demo(player, weapon) {
    killstreak = get_killstreak_for_weapon(weapon);
    if (!isdefined(killstreak)) {
        return false;
    }
    if (level.killstreaks[killstreak].overrideentitycameraindemo) {
        return true;
    }
    if (isdefined(player.remoteweapon) && isdefined(player.remoteweapon.controlled) && player.remoteweapon.controlled) {
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0xd2de4da3, Offset: 0xa710
// Size: 0x58
function watch_for_remove_remote_weapon() {
    self endon(#"endwatchforremoveremoteweapon");
    for (;;) {
        self waittill(#"remove_remote_weapon");
        self switch_to_last_non_killstreak_weapon();
        self enableusability();
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x90e3d877, Offset: 0xa770
// Size: 0x154
function clear_using_remote(immediate, skipnotify, gameended) {
    if (!isdefined(self)) {
        return;
    }
    self.dofutz = 0;
    self.no_fade2black = 0;
    self clientfield::set_to_player("static_postfx", 0);
    if (isdefined(self.carryicon)) {
        self.carryicon.alpha = 1;
    }
    self.usingremote = undefined;
    self reset_killstreak_delay_killcam();
    self enableoffhandweapons();
    self enableweaponcycling();
    curweapon = self getcurrentweapon();
    if (isalive(self)) {
        self switch_to_last_non_killstreak_weapon(immediate, undefined, gameended);
    }
    if (!(isdefined(skipnotify) && skipnotify)) {
        self notify(#"stopped_using_remote");
    }
    thread hide_tablet();
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x3aff52b6, Offset: 0xa8d0
// Size: 0x20
function hide_tablet() {
    self endon(#"disconnect");
    wait 0.2;
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x5cd70476, Offset: 0xa8f8
// Size: 0xe
function reset_killstreak_delay_killcam() {
    self.killstreak_delay_killcam = undefined;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x312214d2, Offset: 0xa910
// Size: 0x78
function init_ride_killstreak(streak, always_allow = 0) {
    self disableusability();
    result = self init_ride_killstreak_internal(streak, always_allow);
    if (isdefined(self)) {
        self enableusability();
    }
    return result;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x2f02c4ad, Offset: 0xa990
// Size: 0x4ac
function init_ride_killstreak_internal(streak, always_allow) {
    var_cd63fa97 = 0;
    if (isdefined(streak) && (streak == "dart" || streak == "killstreak_remote_turret" || streak == "killstreak_ai_tank" || streak == "qrdrone" || streak == "sentinel" || streak == "recon_car")) {
        laptopwait = "timeout";
    } else if (isdefined(streak) && streak == "remote_missile") {
        laptopwait = "timeout";
        var_cd63fa97 = getdvarfloat(#"hash_409036e81396b597", 0.075);
    } else {
        laptopwait = self waittilltimeout(0.2, #"disconnect", #"death", #"weapon_switch_started");
        laptopwait = laptopwait._notify;
    }
    hostmigration::waittillhostmigrationdone();
    if (laptopwait == "weapon_switch_started") {
        return "fail";
    }
    if (!isalive(self) && !always_allow) {
        return "fail";
    }
    if (laptopwait == "disconnect" || laptopwait == "death") {
        if (laptopwait == "disconnect") {
            return "disconnect";
        }
        if (self.team == #"spectator") {
            return "fail";
        }
        return "success";
    }
    if (self isempjammed() && !(isdefined(self.ignoreempjammed) && self.ignoreempjammed)) {
        return "fail";
    }
    if (self is_interacting_with_object()) {
        return "fail";
    }
    self thread hud::fade_to_black_for_x_sec(0, 0.2 + var_cd63fa97, 0.1, 0.1);
    self thread watch_for_remove_remote_weapon();
    blackoutwait = self waittilltimeout(0.2, #"disconnect", #"death");
    self notify(#"endwatchforremoveremoteweapon");
    hostmigration::waittillhostmigrationdone();
    if (blackoutwait._notify != "disconnect") {
        self thread clear_ride_intro(1);
        if (self.team == #"spectator") {
            return "fail";
        }
    }
    if (always_allow) {
        if (blackoutwait._notify == "disconnect") {
            return "disconnect";
        } else {
            return "success";
        }
    }
    if (self isonladder()) {
        return "fail";
    }
    if (!isalive(self)) {
        return "fail";
    }
    if (self isempjammed() && !(isdefined(self.ignoreempjammed) && self.ignoreempjammed)) {
        return "fail";
    }
    if (isdefined(self.laststand) && self.laststand) {
        return "fail";
    }
    if (self is_interacting_with_object()) {
        return "fail";
    }
    if (blackoutwait._notify == "disconnect") {
        return "disconnect";
    }
    return "success";
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x8430659b, Offset: 0xae48
// Size: 0x44
function clear_ride_intro(delay) {
    self endon(#"disconnect");
    if (isdefined(delay)) {
        wait delay;
    }
    self thread hud::screen_fade_in(0);
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x3352945f, Offset: 0xae98
// Size: 0x64
function is_interacting_with_object() {
    if (self iscarryingturret()) {
        return true;
    }
    if (isdefined(self.isplanting) && self.isplanting) {
        return true;
    }
    if (isdefined(self.isdefusing) && self.isdefusing) {
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x33aa1e7d, Offset: 0xaf08
// Size: 0xe2
function get_random_pilot_index(killstreaktype) {
    if (!isdefined(killstreaktype)) {
        return undefined;
    }
    if (!isdefined(self.pers[#"mptaacom"])) {
        return undefined;
    }
    taacombundle = get_mpdialog_tacom_bundle(self.pers[#"mptaacom"]);
    if (!isdefined(taacombundle) || !isdefined(taacombundle.pilotbundles)) {
        return undefined;
    }
    if (!isdefined(taacombundle.pilotbundles[killstreaktype])) {
        return undefined;
    }
    numpilots = taacombundle.pilotbundles[killstreaktype].size;
    if (numpilots <= 0) {
        return undefined;
    }
    return randomint(numpilots);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x6177e9f5, Offset: 0xaff8
// Size: 0x30
function get_mpdialog_tacom_bundle(name) {
    if (!isdefined(level.tacombundles)) {
        return undefined;
    }
    return level.tacombundles[name];
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x9ca7475d, Offset: 0xb030
// Size: 0x24
function hide_compass() {
    self clientfield::set("killstreak_hides_compass", 1);
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x7dfce444, Offset: 0xb060
// Size: 0x24
function unhide_compass() {
    self clientfield::set("killstreak_hides_compass", 0);
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xd04acab2, Offset: 0xb090
// Size: 0xee
function setup_health(killstreak_ref, max_health, low_health) {
    self.maxhealth = max_health;
    self.lowhealth = low_health;
    self.hackedhealthupdatecallback = &defaulthackedhealthupdatecallback;
    tablemaxhealth = killstreak_bundles::get_max_health(killstreak_ref);
    if (isdefined(tablemaxhealth)) {
        self.maxhealth = tablemaxhealth;
    }
    tablelowhealth = killstreak_bundles::get_low_health(killstreak_ref);
    if (isdefined(tablelowhealth)) {
        self.lowhealth = tablelowhealth;
    }
    tablehackedhealth = killstreak_bundles::get_hacked_health(killstreak_ref);
    if (isdefined(tablehackedhealth)) {
        self.hackedhealth = tablehackedhealth;
        return;
    }
    self.hackedhealth = self.maxhealth;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xb0857c3, Offset: 0xb188
// Size: 0xb2
function defaulthackedhealthupdatecallback(hacker) {
    killstreak = self;
    assert(isdefined(self.maxhealth));
    assert(isdefined(self.hackedhealth));
    assert(isdefined(self.damagetaken));
    damageafterhacking = self.maxhealth - self.hackedhealth;
    if (self.damagetaken < damageafterhacking) {
        self.damagetaken = damageafterhacking;
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 19, eflags: 0x0
// Checksum 0xb15b4ec7, Offset: 0xb248
// Size: 0x1b0
function function_ee1921e5(killstreakref, killstreakid, onplacecallback, oncancelcallback, onmovecallback, onshutdowncallback, ondeathcallback, onempcallback, model, validmodel, invalidmodel, spawnsvehicle, pickupstring, timeout, health, empdamage, placehintstring, invalidlocationhintstring, placeimmediately = 0) {
    player = self;
    placeable = placeables::spawnplaceable(onplacecallback, oncancelcallback, onmovecallback, onshutdowncallback, ondeathcallback, onempcallback, undefined, undefined, model, validmodel, invalidmodel, spawnsvehicle, pickupstring, timeout, health, empdamage, placehintstring, invalidlocationhintstring, placeimmediately, &function_3420f24);
    if (isdefined(placeable.othermodel)) {
        placeable.othermodel clientfield::set("enemyvehicle", 1);
    }
    placeable.killstreakref = killstreakref;
    placeable.killstreakid = killstreakid;
    placeable configure_team(killstreakref, killstreakid, player);
    return placeable;
}

// Namespace killstreaks/killstreaks_shared
// Params 4, eflags: 0x0
// Checksum 0x3e770c37, Offset: 0xb400
// Size: 0x88
function function_3420f24(damagecallback, destroyedcallback, var_f075ba56, var_ec678527) {
    waitframe(1);
    placeable = self;
    if (isdefined(level.var_243d1fc1)) {
        placeable thread [[ level.var_243d1fc1 ]](placeable.killstreakref, placeable.health, destroyedcallback, 0, undefined, var_f075ba56, var_ec678527, 1);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x0
// Checksum 0x5e8410c3, Offset: 0xb490
// Size: 0xcc
function configure_team(killstreaktype, killstreakid, owner, influencertype, configureteamprefunction, configureteampostfunction, ishacked = 0) {
    killstreak = self;
    killstreak.killstreaktype = killstreaktype;
    killstreak.killstreakid = killstreakid;
    killstreak _setup_configure_team_callbacks(influencertype, configureteamprefunction, configureteampostfunction);
    killstreak configure_team_internal(owner, ishacked);
    owner thread trackactivekillstreak(killstreak);
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x4f2ed997, Offset: 0xb568
// Size: 0x1f8
function configure_team_internal(owner, ishacked) {
    killstreak = self;
    if (ishacked == 0) {
        killstreak.originalowner = owner;
        killstreak.originalteam = owner.team;
        /#
        #/
    } else {
        assert(killstreak.killstreakteamconfigured, "<dev string:x521>");
    }
    if (isdefined(killstreak.killstreakconfigureteamprefunction)) {
        killstreak thread [[ killstreak.killstreakconfigureteamprefunction ]](owner, ishacked);
    }
    if (isdefined(killstreak.killstreakinfluencertype)) {
        killstreak influencers::remove_influencers();
    }
    killstreak setteam(owner.team);
    killstreak.team = owner.team;
    if (!isai(killstreak)) {
        killstreak setowner(owner);
    }
    killstreak.owner = owner;
    killstreak.ownerentnum = owner.entnum;
    killstreak.pilotindex = killstreak.owner get_random_pilot_index(killstreak.killstreaktype);
    if (isdefined(killstreak.killstreakinfluencertype)) {
        killstreak influencers::create_entity_enemy_influencer(killstreak.killstreakinfluencertype, owner.team);
    }
    if (isdefined(killstreak.killstreakconfigureteampostfunction)) {
        killstreak thread [[ killstreak.killstreakconfigureteampostfunction ]](owner, ishacked);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x4
// Checksum 0x4d556a06, Offset: 0xb768
// Size: 0x6a
function private _setup_configure_team_callbacks(influencertype, configureteamprefunction, configureteampostfunction) {
    killstreak = self;
    killstreak.killstreakteamconfigured = 1;
    killstreak.killstreakinfluencertype = influencertype;
    killstreak.killstreakconfigureteamprefunction = configureteamprefunction;
    killstreak.killstreakconfigureteampostfunction = configureteampostfunction;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x2fe7479c, Offset: 0xb7e0
// Size: 0x9e
function trackactivekillstreak(killstreak) {
    self endon(#"disconnect");
    killstreakindex = killstreak.killstreakid;
    if (isdefined(killstreakindex)) {
        self.pers[#"activekillstreaks"][killstreakindex] = killstreak;
        killstreak waittill(#"killstreak_hacked", #"death");
        self.pers[#"activekillstreaks"][killstreakindex] = undefined;
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xd82df534, Offset: 0xb888
// Size: 0x3c
function play_killstreak_firewall_being_hacked_dialog(killstreaktype, killstreakid) {
    if (isdefined(level.play_killstreak_firewall_being_hacked_dialog)) {
        self [[ level.play_killstreak_firewall_being_hacked_dialog ]](killstreaktype, killstreakid);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x6d25dc38, Offset: 0xb8d0
// Size: 0x3c
function play_killstreak_firewall_hacked_dialog(killstreaktype, killstreakid) {
    if (isdefined(level.play_killstreak_firewall_hacked_dialog)) {
        self [[ level.play_killstreak_firewall_hacked_dialog ]](killstreaktype, killstreakid);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xf6908b5f, Offset: 0xb918
// Size: 0x3c
function play_killstreak_being_hacked_dialog(killstreaktype, killstreakid) {
    if (isdefined(level.play_killstreak_being_hacked_dialog)) {
        self [[ level.play_killstreak_being_hacked_dialog ]](killstreaktype, killstreakid);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xd551075c, Offset: 0xb960
// Size: 0x48
function play_killstreak_hacked_dialog(killstreaktype, killstreakid, hacker) {
    if (isdefined(level.play_killstreak_hacked_dialog)) {
        self [[ level.play_killstreak_hacked_dialog ]](killstreaktype, killstreakid, hacker);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x942e56ad, Offset: 0xb9b0
// Size: 0x48
function play_killstreak_start_dialog(hardpointtype, team, killstreak_id) {
    if (isdefined(level.play_killstreak_start_dialog)) {
        self [[ level.play_killstreak_start_dialog ]](hardpointtype, team, killstreak_id);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 4, eflags: 0x0
// Checksum 0x385c89e6, Offset: 0xba00
// Size: 0x54
function play_pilot_dialog(dialogkey, killstreaktype, killstreakid, pilotindex) {
    if (isdefined(level.play_pilot_dialog)) {
        self [[ level.play_pilot_dialog ]](dialogkey, killstreaktype, killstreakid, pilotindex);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x3a0c89eb, Offset: 0xba60
// Size: 0x48
function play_pilot_dialog_on_owner(dialogkey, killstreaktype, killstreakid) {
    if (isdefined(level.play_pilot_dialog_on_owner)) {
        self [[ level.play_pilot_dialog_on_owner ]](dialogkey, killstreaktype, killstreakid);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xde9a896, Offset: 0xbab0
// Size: 0x3c
function play_destroyed_dialog_on_owner(killstreaktype, killstreakid) {
    if (isdefined(level.play_destroyed_dialog_on_owner)) {
        self [[ level.play_destroyed_dialog_on_owner ]](killstreaktype, killstreakid);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xc60d2968, Offset: 0xbaf8
// Size: 0x48
function play_taacom_dialog(dialogkey, killstreaktype, killstreakid) {
    if (isdefined(level.play_taacom_dialog)) {
        self [[ level.play_taacom_dialog ]](dialogkey, killstreaktype, killstreakid);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x1d2bf6c4, Offset: 0xbb48
// Size: 0x48
function play_taacom_dialog_response_on_owner(dialogkey, killstreaktype, killstreakid) {
    if (isdefined(level.play_taacom_dialog_response_on_owner)) {
        self [[ level.play_taacom_dialog_response_on_owner ]](dialogkey, killstreaktype, killstreakid);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 5, eflags: 0x0
// Checksum 0x90f4edc7, Offset: 0xbb98
// Size: 0x60
function leader_dialog_for_other_teams(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey) {
    if (isdefined(level.var_2f5ed0a0)) {
        [[ level.var_2f5ed0a0 ]](dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 6, eflags: 0x0
// Checksum 0x63555ec, Offset: 0xbc00
// Size: 0x6c
function leader_dialog(dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey) {
    if (isdefined(level.var_2e2a6dd4)) {
        [[ level.var_2e2a6dd4 ]](dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 4, eflags: 0x0
// Checksum 0xc182eb9e, Offset: 0xbc78
// Size: 0x54
function processscoreevent(event, player, victim, weapon) {
    if (isdefined(level.var_6f9f2a9f)) {
        [[ level.var_6f9f2a9f ]](event, player, victim, weapon);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xe24edbb1, Offset: 0xbcd8
// Size: 0x32
function allow_assists(killstreaktype, allow) {
    level.killstreaks[killstreaktype].allowassists = allow;
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x7d1597e8, Offset: 0xbd18
// Size: 0x3a
function set_team_kill_penalty_scale(killstreaktype, scale, isinventory) {
    level.killstreaks[killstreaktype].teamkillpenaltyscale = scale;
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xe67eabc8, Offset: 0xbd60
// Size: 0x3a
function override_entity_camera_in_demo(killstreaktype, value, isinventory) {
    level.killstreaks[killstreaktype].overrideentitycameraindemo = value;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xe8b8e796, Offset: 0xbda8
// Size: 0x27a
function update_player_threat(player) {
    if (!isplayer(player)) {
        return;
    }
    heli = self;
    player.threatlevel = 0;
    dist = distance(player.origin, heli.origin);
    player.threatlevel += (level.heli_visual_range - dist) / level.heli_visual_range * 100;
    if (isdefined(heli.attacker) && player == heli.attacker) {
        player.threatlevel += 100;
    }
    if (isdefined(player.carryobject)) {
        player.threatlevel += 200;
    }
    if (isdefined(player.score)) {
        player.threatlevel += player.score * 2;
    }
    if (player weapons::has_launcher()) {
        if (player weapons::has_lockon(heli)) {
            player.threatlevel += 1000;
        } else {
            player.threatlevel += 500;
        }
    }
    if (player weapons::has_heavy_weapon()) {
        player.threatlevel += 300;
    }
    if (player weapons::has_lmg()) {
        player.threatlevel += 200;
    }
    if (isdefined(player.antithreat)) {
        player.threatlevel -= player.antithreat;
    }
    if (player.threatlevel <= 0) {
        player.threatlevel = 1;
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xc6a107ff, Offset: 0xc030
// Size: 0xb2
function update_non_player_threat(non_player) {
    heli = self;
    non_player.threatlevel = 0;
    dist = distance(non_player.origin, heli.origin);
    non_player.threatlevel += (level.heli_visual_range - dist) / level.heli_visual_range * 100;
    if (non_player.threatlevel <= 0) {
        non_player.threatlevel = 1;
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x903448f, Offset: 0xc0f0
// Size: 0x1d2
function update_actor_threat(actor) {
    heli = self;
    actor.threatlevel = 0;
    dist = distance(actor.origin, heli.origin);
    actor.threatlevel += (level.heli_visual_range - dist) / level.heli_visual_range * 100;
    if (isdefined(actor.owner)) {
        if (isdefined(heli.attacker) && actor.owner == heli.attacker) {
            actor.threatlevel += 100;
        }
        if (isdefined(actor.owner.carryobject)) {
            actor.threatlevel += 200;
        }
        if (isdefined(actor.owner.score)) {
            actor.threatlevel += actor.owner.score * 4;
        }
        if (isdefined(actor.owner.antithreat)) {
            actor.threatlevel -= actor.owner.antithreat;
        }
    }
    if (actor.threatlevel <= 0) {
        actor.threatlevel = 1;
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xc23dfe7a, Offset: 0xc2d0
// Size: 0x8e
function update_dog_threat(dog) {
    heli = self;
    dog.threatlevel = 0;
    dist = distance(dog.origin, heli.origin);
    dog.threatlevel += (level.heli_visual_range - dist) / level.heli_visual_range * 100;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xf556d056, Offset: 0xc368
// Size: 0xb8
function missile_valid_target_check(missiletarget) {
    heli2target_normal = vectornormalize(missiletarget.origin - self.origin);
    heli2forward = anglestoforward(self.angles);
    heli2forward_normal = vectornormalize(heli2forward);
    heli_dot_target = vectordot(heli2target_normal, heli2forward_normal);
    if (heli_dot_target >= level.heli_valid_target_cone) {
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x8c96c064, Offset: 0xc428
// Size: 0x16a
function update_missile_player_threat(player) {
    player.missilethreatlevel = 0;
    dist = distance(player.origin, self.origin);
    player.missilethreatlevel += (level.heli_missile_range - dist) / level.heli_missile_range * 100;
    if (self missile_valid_target_check(player) == 0) {
        player.missilethreatlevel = 1;
        return;
    }
    if (isdefined(self.attacker) && player == self.attacker) {
        player.missilethreatlevel += 100;
    }
    player.missilethreatlevel += player.score * 4;
    if (isdefined(player.antithreat)) {
        player.missilethreatlevel -= player.antithreat;
    }
    if (player.missilethreatlevel <= 0) {
        player.missilethreatlevel = 1;
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x36a0b655, Offset: 0xc5a0
// Size: 0x1a
function update_missile_dog_threat(dog) {
    dog.missilethreatlevel = 1;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x2d9a05d6, Offset: 0xc5c8
// Size: 0xa0
function function_501f1a63(owner, var_94900029) {
    self notify(#"hash_4363bc1bae999ad3");
    self endon(#"hash_4363bc1bae999ad3");
    self endon(#"death");
    res = owner waittill(#"joined_team", #"disconnect", #"joined_spectators", #"changed_specialist");
    [[ var_94900029 ]]();
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x78a86c31, Offset: 0xc670
// Size: 0xd6
function should_not_timeout(killstreak) {
    /#
        assert(isdefined(killstreak), "<dev string:x6b>");
        assert(isdefined(level.killstreaks[killstreak]), "<dev string:x279>");
        if (getdvarint(#"hash_e8bb2ce168acce0", 0)) {
            return 1;
        }
        if (isdefined(level.killstreaks[killstreak].devtimeoutdvar)) {
            return getdvarint(level.killstreaks[killstreak].devtimeoutdvar, 0);
        }
    #/
    return 0;
}

// Namespace killstreaks/killstreaks_shared
// Params 6, eflags: 0x0
// Checksum 0xb7a664c1, Offset: 0xc750
// Size: 0x184
function waitfortimeout(killstreak, duration, callback, endcondition1, endcondition2, endcondition3) {
    /#
        if (should_not_timeout(killstreak)) {
            return;
        }
    #/
    self endon(#"killstreak_hacked");
    if (isdefined(endcondition1)) {
        self endon(endcondition1);
    }
    if (isdefined(endcondition2)) {
        self endon(endcondition2);
    }
    if (isdefined(endcondition3)) {
        self endon(endcondition3);
    }
    self thread waitfortimeouthacked(killstreak, callback, endcondition1, endcondition2, endcondition3);
    killstreakbundle = level.killstreakbundle[killstreak];
    self.killstreakendtime = gettime() + duration;
    if (isdefined(killstreakbundle) && isdefined(killstreakbundle.kstimeoutbeepduration)) {
        self waitfortimeoutbeep(killstreakbundle, duration);
    } else {
        hostmigration::migrationawarewait(duration);
    }
    self notify(#"kill_waitfortimeouthacked_thread");
    self.killstreaktimedout = 1;
    self.killstreakendtime = 0;
    self notify(#"timed_out");
    self [[ callback ]]();
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x631c6a5a, Offset: 0xc8e0
// Size: 0x194
function waitfortimeoutbeep(killstreakbundle, duration) {
    self endon(#"death");
    beepduration = int(killstreakbundle.kstimeoutbeepduration * 1000);
    hostmigration::migrationawarewait(max(duration - beepduration, 0));
    if (isvehicle(self)) {
        self clientfield::set("timeout_beep", 1);
    }
    if (isdefined(killstreakbundle.kstimeoutfastbeepduration)) {
        fastbeepduration = int(killstreakbundle.kstimeoutfastbeepduration * 1000);
        hostmigration::migrationawarewait(max(beepduration - fastbeepduration, 0));
        if (isvehicle(self)) {
            self clientfield::set("timeout_beep", 2);
        }
        hostmigration::migrationawarewait(fastbeepduration);
    }
    self function_c8c6c926();
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x7815d18, Offset: 0xca80
// Size: 0x44
function function_c8c6c926() {
    if (isdefined(self) && isvehicle(self)) {
        self clientfield::set("timeout_beep", 0);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 5, eflags: 0x0
// Checksum 0xc278c53c, Offset: 0xcad0
// Size: 0xf4
function waitfortimeouthacked(killstreak, callback, endcondition1, endcondition2, endcondition3) {
    self endon(#"kill_waitfortimeouthacked_thread");
    if (isdefined(endcondition1)) {
        self endon(endcondition1);
    }
    if (isdefined(endcondition2)) {
        self endon(endcondition2);
    }
    if (isdefined(endcondition3)) {
        self endon(endcondition3);
    }
    self waittill(#"killstreak_hacked");
    hackedduration = self killstreak_hacking::get_hacked_timeout_duration_ms();
    self.killstreakendtime = gettime() + hackedduration;
    hostmigration::migrationawarewait(hackedduration);
    self.killstreakendtime = 0;
    self notify(#"timed_out");
    self [[ callback ]]();
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x87961836, Offset: 0xcbd0
// Size: 0x76
function function_9a3c718e() {
    startheight = 200;
    switch (self getstance()) {
    case #"crouch":
        startheight = 30;
        break;
    case #"prone":
        startheight = 15;
        break;
    }
    return startheight;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x953e6755, Offset: 0xcc50
// Size: 0x1a
function set_killstreak_delay_killcam(killstreak_name) {
    self.killstreak_delay_killcam = killstreak_name;
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x2bfa9108, Offset: 0xcc78
// Size: 0x1c
function getactivekillstreaks() {
    return self.pers[#"activekillstreaks"];
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xca2f0504, Offset: 0xcca0
// Size: 0xb6
function watchteamchange(teamchangenotify) {
    self notify(teamchangenotify + "_Singleton");
    self endon(teamchangenotify + "_Singleton");
    killstreak = self;
    killstreak endon(#"death");
    killstreak endon(teamchangenotify);
    killstreak.owner waittill(#"joined_team", #"disconnect", #"joined_spectators", #"emp_jammed");
    killstreak notify(teamchangenotify);
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x67ca99c8, Offset: 0xcd60
// Size: 0x3c
function killstreak_assist(victim, assister, killstreak) {
    victim recordkillstreakassist(victim, assister, killstreak);
}

// Namespace killstreaks/killstreaks_shared
// Params 4, eflags: 0x0
// Checksum 0xabe85e4b, Offset: 0xcda8
// Size: 0x122
function add_ricochet_protection(killstreak_id, owner, origin, ricochet_distance) {
    testing = 0;
    /#
        testing = getdvarint(#"scr_ricochet_protection_debug", 0) == 2;
    #/
    if (!level.hardcoremode && !testing) {
        return;
    }
    if (!isdefined(ricochet_distance) || ricochet_distance == 0) {
        return;
    }
    if (!isdefined(owner.ricochet_protection)) {
        owner.ricochet_protection = [];
    }
    owner.ricochet_protection[killstreak_id] = spawnstruct();
    owner.ricochet_protection[killstreak_id].origin = origin;
    owner.ricochet_protection[killstreak_id].distancesq = ricochet_distance * ricochet_distance;
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x36017ea6, Offset: 0xced8
// Size: 0x82
function set_ricochet_protection_endtime(killstreak_id, owner, endtime) {
    if (!isdefined(owner) || !isdefined(owner.ricochet_protection) || !isdefined(killstreak_id)) {
        return;
    }
    if (!isdefined(owner.ricochet_protection[killstreak_id])) {
        return;
    }
    owner.ricochet_protection[killstreak_id].endtime = endtime;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x95285b52, Offset: 0xcf68
// Size: 0x54
function remove_ricochet_protection(killstreak_id, owner) {
    if (!isdefined(owner) || !isdefined(owner.ricochet_protection) || !isdefined(killstreak_id)) {
        return;
    }
    owner.ricochet_protection[killstreak_id] = undefined;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x360fc7f3, Offset: 0xcfc8
// Size: 0x24
function thermal_glow(enable) {
    clientfield::set_to_player("thermal_glow", enable);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xfdf2e561, Offset: 0xcff8
// Size: 0x106
function is_ricochet_protected(player) {
    if (!isdefined(player) || !isdefined(player.ricochet_protection)) {
        return false;
    }
    foreach (protection in player.ricochet_protection) {
        if (!isdefined(protection)) {
            continue;
        }
        if (isdefined(protection.endtime) && protection.endtime < gettime()) {
            continue;
        }
        if (distancesquared(protection.origin, player.origin) < protection.distancesq) {
            return true;
        }
    }
    return false;
}

/#

    // Namespace killstreaks/killstreaks_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2ae37d33, Offset: 0xd108
    // Size: 0x2a8
    function debug_ricochet_protection() {
        debug_wait = 0.5;
        debug_frames = int(debug_wait / float(function_f9f48566()) / 1000) + 1;
        while (true) {
            if (getdvarint(#"scr_ricochet_protection_debug", 0) == 0) {
                wait 2;
                continue;
            }
            wait debug_wait;
            foreach (player in level.players) {
                if (!isdefined(player)) {
                    continue;
                }
                if (!isdefined(player.ricochet_protection)) {
                    continue;
                }
                foreach (protection in player.ricochet_protection) {
                    if (!isdefined(protection)) {
                        continue;
                    }
                    if (isdefined(protection.endtime) && protection.endtime < gettime()) {
                        continue;
                    }
                    radius = sqrt(protection.distancesq);
                    sphere(protection.origin, radius, (1, 1, 0), 0.25, 0, 36, debug_frames);
                    circle(protection.origin, radius, (1, 0.5, 0), 0, 1, debug_frames);
                    circle(protection.origin + (0, 0, 2), radius, (1, 0.5, 0), 0, 1, debug_frames);
                }
            }
        }
    }

#/
