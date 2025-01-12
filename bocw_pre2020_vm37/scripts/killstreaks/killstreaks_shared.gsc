#using script_396f7d71538c9677;
#using script_4721de209091b1a6;
#using scripts\abilities\ability_util;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\damage;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\placeables;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\weaponobjects;

#namespace killstreaks;

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x7b480ecb, Offset: 0x470
// Size: 0x384
function init_shared() {
    level.killstreaks = [];
    level.killstreakweapons = [];
    level.var_b1dfdc3b = [];
    level.var_8997324c = [];
    level.droplocations = [];
    level.zoffsetcounter = 0;
    level.var_46c23c0f = 0;
    clientfield::register_clientuimodel("locSel.commandMode", 1, 1, "int");
    clientfield::register_clientuimodel("locSel.snapTo", 1, 1, "int");
    clientfield::register("vehicle", "timeout_beep", 1, 2, "int");
    clientfield::register("toplayer", "thermal_glow", 1, 1, "int");
    clientfield::register("toplayer", "thermal_glow_enemies_only", 12000, 1, "int");
    clientfield::register("vehicle", "standardTagFxSet", 1, 1, "int");
    clientfield::register("scriptmover", "standardTagFxSet", 1, 1, "int");
    clientfield::register("scriptmover", "lowHealthTagFxSet", 1, 1, "int");
    clientfield::register("scriptmover", "deathTagFxSet", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_524d30f5676b2070", 1, 1, "int");
    clientfield::register("vehicle", "scorestreakActive", 1, 1, "int");
    clientfield::register("scriptmover", "scorestreakActive", 1, 1, "int");
    namespace_f9b02f80::function_196f2c38();
    level.var_19a15e42 = undefined;
    level.killstreakmaxhealthfunction = &killstreak_bundles::get_max_health;
    level.var_239dc073 = getweapon(#"killstreak_remote");
    if (!isdefined(level.var_6cfbe5a)) {
        level.var_6cfbe5a = new throttle();
        [[ level.var_6cfbe5a ]]->initialize(1, 0.1);
    }
    level.var_98769415 = &get_from_weapon;
    level.iskillstreakweapon = &is_killstreak_weapon;
    level.get_killstreak_for_weapon_for_stats = &get_killstreak_for_weapon_for_stats;
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x2c018b0c, Offset: 0x800
// Size: 0x9c
function function_447e6858() {
    level.killstreakcorebundle = getscriptbundle("killstreak_core");
    if (!isdefined(level.roundstartkillstreakdelay)) {
        level.roundstartkillstreakdelay = 0;
    }
    level.numkillstreakreservedobjectives = 0;
    level.killstreakcounter = 0;
    callback::on_spawned(&on_player_spawned);
    callback::on_joined_team(&on_joined_team);
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x97881e78, Offset: 0x8a8
// Size: 0x3c
function function_b5b6ef3e(func, obj) {
    callback::add_callback(#"hash_45f35669076bc317", func, obj);
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x5 linked
// Checksum 0xdc707f3d, Offset: 0x8f0
// Size: 0x17a
function private register_ui(killstreak_type, killstreak_menu) {
    assert(isdefined(level.killstreaks[killstreak_type]), "<dev string:x38>");
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
        if (level.killstreaks[killstreak_type].uiname == "<dev string:x75>") {
            level.killstreaks[killstreak_type].uiname = killstreak_menu;
        }
    #/
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x77bfbcd4, Offset: 0xa78
// Size: 0x116
function private killstreak_init(killstreak_type) {
    assert(isdefined(killstreak_type), "<dev string:x79>");
    assert(!isdefined(level.killstreaks[killstreak_type]), "<dev string:xb5>" + killstreak_type + "<dev string:xc4>");
    level.killstreaks[killstreak_type] = spawnstruct();
    level.killstreaks[killstreak_type].killstreaklevel = 0;
    level.killstreaks[killstreak_type].quantity = 0;
    level.killstreaks[killstreak_type].overrideentitycameraindemo = 0;
    level.killstreaks[killstreak_type].teamkillpenaltyscale = 1;
    level.killstreaks[killstreak_type].var_b6c17aab = 0;
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x5 linked
// Checksum 0xac7e7264, Offset: 0xb98
// Size: 0x10c
function private register_weapon(killstreak_type, bundle, weapon) {
    if (weapon.name == #"none") {
        return;
    }
    assert(isdefined(killstreak_type), "<dev string:x79>");
    assert(weapon.name != #"none");
    assert(!isdefined(level.killstreakweapons[weapon]), "<dev string:xdb>");
    level.killstreaks[killstreak_type].weapon = weapon;
    level.killstreakweapons[weapon] = killstreak_type;
    if (is_true(bundle.var_7f7b9887)) {
        level.var_b1dfdc3b[weapon] = killstreak_type;
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x5 linked
// Checksum 0x403b511b, Offset: 0xcb0
// Size: 0x8c
function private register_vehicle(killstreak_type, vehicle) {
    assert(isdefined(killstreak_type), "<dev string:x79>");
    assert(!isdefined(level.var_8997324c[vehicle]), "<dev string:xdb>");
    level.killstreaks[killstreak_type].vehicle = vehicle;
    level.var_8997324c[vehicle] = killstreak_type;
}

// Namespace killstreaks/killstreaks_shared
// Params 6, eflags: 0x5 linked
// Checksum 0xcee686f, Offset: 0xd48
// Size: 0x35a
function private function_e48aca4d(type, bundle, weapon, vehicle, killstreak_use_function, isinventoryweapon) {
    killstreak_init(type);
    menukey = bundle.var_a99ef6da;
    if (!isdefined(menukey)) {
        menukey = type;
    } else if (is_true(isinventoryweapon)) {
        menukey = "inventory_" + menukey;
    }
    register_ui(type, menukey);
    level.killstreaks[type].usagekey = type;
    level.killstreaks[type].delaystreak = bundle.var_daf6b7af;
    level.killstreaks[type].usefunction = killstreak_use_function;
    register_weapon(type, bundle, weapon);
    level.menureferenceforkillstreak[menukey] = type;
    if (isdefined(bundle.altweapons)) {
        foreach (alt_weapon in bundle.altweapons) {
            function_181f96a6(type, bundle, alt_weapon.var_359445cd);
        }
    }
    if (isdefined(vehicle)) {
        register_vehicle(type, vehicle);
    }
    level.killstreaks[type].notavailabletext = bundle.var_502a0e23;
    level.killstreaks[type].script_bundle = bundle;
    namespace_f9b02f80::function_1110a5de(type);
    if (is_true(bundle.var_1bc9830d) && is_true(isinventoryweapon)) {
        register_dev_dvars(type);
    }
    switch (bundle.var_c36eb69b) {
    case #"none":
        level.killstreaks[type].teamkillpenaltyscale = 0;
        break;
    case #"hash_5a6d83d54a8fb299":
        level.killstreaks[type].teamkillpenaltyscale = level.teamkillreducedpenalty;
        break;
    case #"default":
    default:
        level.killstreaks[type].teamkillpenaltyscale = 1;
        break;
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x53c61dff, Offset: 0x10b0
// Size: 0x118
function register_bundle(bundle, killstreak_use_function) {
    function_e48aca4d(bundle.var_d3413870, bundle, bundle.ksweapon, bundle.ksvehicle, killstreak_use_function, 0);
    if (isdefined(bundle.var_fc0c8eae) && bundle.var_fc0c8eae.name != #"none") {
        function_e48aca4d("inventory_" + bundle.var_d3413870, bundle, bundle.var_fc0c8eae, undefined, killstreak_use_function, 1);
        if (bundle.var_fc0c8eae.iscarriedkillstreak && bundle.ksweapon.iscarriedkillstreak) {
            if (!isdefined(level.var_6110cb51)) {
                level.var_6110cb51 = [];
            }
            level.var_6110cb51[bundle.ksweapon] = bundle.var_fc0c8eae;
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x10c51346, Offset: 0x11d0
// Size: 0x4c
function register_killstreak(bundlename, use_function) {
    bundle = getscriptbundle(bundlename);
    register_bundle(bundle, use_function);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x17bddef3, Offset: 0x1228
// Size: 0x5c
function function_94c74046(killstreaktype) {
    assert(isdefined(killstreaktype), "<dev string:x11a>");
    if (!isdefined(level.var_33c629ad)) {
        level.var_33c629ad = [];
    }
    level.var_33c629ad[killstreaktype] = 1;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x41336172, Offset: 0x1290
// Size: 0x1e
function function_6bde02cc(killstreaktype) {
    return isdefined(level.var_33c629ad[killstreaktype]);
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x5 linked
// Checksum 0x28e7aa5b, Offset: 0x12b8
// Size: 0x100
function private function_181f96a6(killstreaktype, bundle, weapon) {
    assert(isdefined(killstreaktype), "<dev string:x79>");
    assert(isdefined(level.killstreaks[killstreaktype]), "<dev string:x16a>");
    if (weapon == level.weaponnone) {
        return;
    }
    if (level.killstreaks[killstreaktype].weapon === weapon) {
        return;
    }
    if (!isdefined(level.killstreakweapons[weapon])) {
        level.killstreakweapons[weapon] = killstreaktype;
    }
    if (is_true(bundle.var_7f7b9887)) {
        if (!isdefined(level.var_b1dfdc3b[weapon])) {
            level.var_b1dfdc3b[weapon] = killstreaktype;
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x4
// Checksum 0xb08c8133, Offset: 0x13c0
// Size: 0x4c
function private register_alt_weapon(killstreaktype, weapon) {
    function_181f96a6(killstreaktype, weapon);
    function_181f96a6("inventory_" + killstreaktype, weapon);
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x61b88a1a, Offset: 0x1418
// Size: 0x40
function function_b013c2d3(killstreaktype, weapon) {
    if (!isdefined(level.var_3ff1b984)) {
        level.var_3ff1b984 = [];
    }
    level.var_3ff1b984[weapon] = killstreaktype;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xf743f8d8, Offset: 0x1460
// Size: 0x40
function function_d8c32ca4(killstreaktype, var_ae755d2f) {
    if (!isdefined(level.var_a385666)) {
        level.var_a385666 = [];
    }
    level.var_a385666[killstreaktype] = var_ae755d2f;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xef53cb00, Offset: 0x14a8
// Size: 0x134
function register_dev_dvars(killstreaktype) {
    /#
        assert(isdefined(killstreaktype), "<dev string:x79>");
        assert(isdefined(level.killstreaks[killstreaktype]), "<dev string:x1b3>");
        level.killstreaks[killstreaktype].devdvar = "<dev string:x1fa>" + killstreaktype + "<dev string:x202>";
        level.killstreaks[killstreaktype].devenemydvar = "<dev string:x1fa>" + killstreaktype + "<dev string:x20b>";
        level.killstreaks[killstreaktype].devtimeoutdvar = "<dev string:x1fa>" + killstreaktype + "<dev string:x219>";
        setdvar(level.killstreaks[killstreaktype].devtimeoutdvar, 0);
        level thread register_devgui(killstreaktype);
    #/
}

/#

    // Namespace killstreaks/killstreaks_shared
    // Params 1, eflags: 0x0
    // Checksum 0x17581882, Offset: 0x15e8
    // Size: 0xbc
    function register_dev_debug_dvar(killstreaktype) {
        assert(isdefined(killstreaktype), "<dev string:x79>");
        assert(isdefined(level.killstreaks[killstreaktype]), "<dev string:x1b3>");
        level.killstreaks[killstreaktype].devdebugdvar = "<dev string:x1fa>" + killstreaktype + "<dev string:x227>";
        devgui_scorestreak_command_debugdvar(killstreaktype, level.killstreaks[killstreaktype].devdebugdvar);
    }

    // Namespace killstreaks/killstreaks_shared
    // Params 1, eflags: 0x0
    // Checksum 0x98713457, Offset: 0x16b0
    // Size: 0x138
    function register_devgui(killstreaktype) {
        level endon(#"game_ended");
        wait randomintrange(2, 20) * float(function_60d95f53()) / 1000;
        give_type_all = "<dev string:x231>";
        give_type_enemy = "<dev string:x239>";
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
    // Checksum 0xc26f3754, Offset: 0x17f0
    // Size: 0x4c
    function devgui_scorestreak_command_givedvar(killstreaktype, give_type, dvar) {
        devgui_scorestreak_command(killstreaktype, give_type, "<dev string:x247>" + dvar + "<dev string:x24f>");
    }

    // Namespace killstreaks/killstreaks_shared
    // Params 2, eflags: 0x0
    // Checksum 0x12343528, Offset: 0x1848
    // Size: 0x34
    function devgui_scorestreak_command_timeoutdvar(killstreaktype, dvar) {
        devgui_scorestreak_dvar_toggle(killstreaktype, "<dev string:x255>", dvar);
    }

    // Namespace killstreaks/killstreaks_shared
    // Params 2, eflags: 0x0
    // Checksum 0xb5ade604, Offset: 0x1888
    // Size: 0x34
    function devgui_scorestreak_command_debugdvar(killstreaktype, dvar) {
        devgui_scorestreak_dvar_toggle(killstreaktype, "<dev string:x261>", dvar);
    }

#/

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xdf5d1e94, Offset: 0x18c8
// Size: 0x6c
function devgui_scorestreak_dvar_toggle(killstreaktype, title, dvar) {
    setdvar(dvar, 0);
    devgui_scorestreak_command(killstreaktype, "Toggle " + title, "toggle " + dvar + " 1 0");
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xd03142e9, Offset: 0x1940
// Size: 0x244
function devgui_scorestreak_command(killstreaktype, title, command) {
    /#
        assert(isdefined(killstreaktype), "<dev string:x79>");
        assert(isdefined(level.killstreaks[killstreaktype]), "<dev string:x1b3>");
        root = "<dev string:x26a>";
        display_name = level.killstreaks[killstreaktype].menuname;
        killstreak_weapon = get_killstreak_weapon(killstreaktype);
        if (isdefined(killstreak_weapon) && killstreak_weapon != level.weaponnone) {
            if (killstreak_weapon.displayname == #"") {
                display_name += "<dev string:x28a>";
            } else {
                display_name = makelocalizedstring(killstreak_weapon.displayname);
            }
            if (strstartswith(display_name, "<dev string:x29e>")) {
                display_name = getsubstr(display_name, 10);
            }
        } else if (strstartswith(display_name, "<dev string:x29e>")) {
            display_name = getsubstr(display_name, 10);
        }
        if (strstartswith(killstreaktype, "<dev string:x29e>")) {
            killstreaktype = getsubstr(killstreaktype, 10);
        }
        util::add_queued_debug_command(root + display_name + "<dev string:x2ac>" + killstreaktype + "<dev string:x2b2>" + title + "<dev string:x2b8>" + command + "<dev string:x2bf>");
    #/
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xe02b971d, Offset: 0x1b90
// Size: 0x9e
function should_draw_debug(killstreak) {
    /#
        assert(isdefined(killstreak), "<dev string:x79>");
        function_2459bd2f();
        if (isdefined(level.killstreaks[killstreak]) && isdefined(level.killstreaks[killstreak].devdebugdvar)) {
            return getdvarint(level.killstreaks[killstreak].devdebugdvar, 0);
        }
    #/
    return 0;
}

/#

    // Namespace killstreaks/killstreaks_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3e80dd61, Offset: 0x1c38
    // Size: 0x34
    function function_2459bd2f() {
        assert(isdefined(level.killstreaks), "<dev string:x2c6>");
    }

#/

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x53015285, Offset: 0x1c78
// Size: 0x30
function is_available(killstreak) {
    if (isdefined(level.menureferenceforkillstreak[killstreak])) {
        return 1;
    }
    return 0;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x870d78c1, Offset: 0x1cb0
// Size: 0x1c
function get_by_menu_name(killstreak) {
    return level.menureferenceforkillstreak[killstreak];
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xaef728c2, Offset: 0x1cd8
// Size: 0x4a
function get_menu_name(killstreaktype) {
    assert(isdefined(level.killstreaks[killstreaktype]));
    return level.killstreaks[killstreaktype].menuname;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x1dc7ea71, Offset: 0x1d30
// Size: 0x11a
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
// Params 3, eflags: 0x1 linked
// Checksum 0x99541729, Offset: 0x1e58
// Size: 0x24e
function give_if_streak_count_matches(index, killstreak, streakcount) {
    pixbeginevent(#"givekillstreakifstreakcountmatches");
    /#
        if (!isdefined(killstreak)) {
            println("<dev string:x336>");
        }
        if (isdefined(killstreak)) {
            println("<dev string:x350>" + killstreak + "<dev string:x369>");
        }
        if (!is_available(killstreak)) {
            println("<dev string:x36e>");
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
// Checksum 0xdb569ac9, Offset: 0x20b0
// Size: 0xc0
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
// Params 5, eflags: 0x1 linked
// Checksum 0xfd4a7209, Offset: 0x2178
// Size: 0x178
function give(killstreaktype, streak, *suppressnotification, noxp, tobottom) {
    pixbeginevent(#"givekillstreak");
    self endon(#"disconnect");
    level endon(#"game_ended");
    killstreakgiven = 0;
    if (isdefined(noxp)) {
        if (self give_internal(streak, undefined, noxp, tobottom)) {
            killstreakgiven = 1;
            if (self.just_given_new_inventory_killstreak === 1) {
                self add_to_notification_queue(level.killstreaks[streak].menuname, suppressnotification, streak, noxp, 1);
            }
        }
    } else if (self give_internal(streak)) {
        killstreakgiven = 1;
        if (self.just_given_new_inventory_killstreak === 1) {
            self add_to_notification_queue(level.killstreaks[streak].menuname, suppressnotification, streak, noxp, 1);
        }
    }
    pixendevent();
    return killstreakgiven;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x8346e165, Offset: 0x22f8
// Size: 0xf4
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
// Params 0, eflags: 0x1 linked
// Checksum 0xedfc020f, Offset: 0x23f8
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
// Params 4, eflags: 0x1 linked
// Checksum 0x7ba316e6, Offset: 0x2578
// Size: 0x8f0
function give_internal(killstreaktype, *do_not_update_death_count, noxp, tobottom) {
    self.just_given_new_inventory_killstreak = undefined;
    if (level.gameended) {
        return false;
    }
    if (!util::is_killstreaks_enabled()) {
        return false;
    }
    if (!isdefined(level.killstreaks[do_not_update_death_count])) {
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
        self.pers[#"killstreaks"][0] = do_not_update_death_count;
        self.pers[#"killstreak_unique_id"][0] = level.killstreakcounter;
        level.killstreakcounter++;
        if (isdefined(noxp)) {
            self.pers[#"killstreak_has_been_used"][0] = noxp;
        } else {
            self.pers[#"killstreak_has_been_used"][0] = 0;
        }
        if (size == 0) {
            ammocount = give_weapon(do_not_update_death_count);
        }
        self.pers[#"killstreak_ammo_count"][0] = 0;
    } else {
        var_7b935486 = 0;
        if (self.pers[#"killstreaks"].size && self.currentweapon === get_killstreak_weapon(self.pers[#"killstreaks"][self.pers[#"killstreaks"].size - 1])) {
            var_7b935486 = 1;
        }
        self.pers[#"killstreaks"][self.pers[#"killstreaks"].size] = do_not_update_death_count;
        self.pers[#"killstreak_unique_id"][self.pers[#"killstreak_unique_id"].size] = level.killstreakcounter;
        level.killstreakcounter++;
        if (self.pers[#"killstreaks"].size > level.maxinventoryscorestreaks) {
            self remove_oldest();
            just_max_stack_removed_inventory_killstreak = self.just_removed_used_killstreak;
        }
        if (!isdefined(noxp)) {
            noxp = 0;
        }
        self.pers[#"killstreak_has_been_used"][self.pers[#"killstreak_has_been_used"].size] = noxp;
        ammocount = give_weapon(do_not_update_death_count);
        self.pers[#"killstreak_ammo_count"][self.pers[#"killstreak_ammo_count"].size] = ammocount;
        if (var_7b935486) {
            var_3522232f = self.pers[#"killstreaks"].size - 2;
            var_a1312679 = self.pers[#"killstreaks"].size - 1;
            var_3197d2aa = self.pers[#"killstreaks"][var_3522232f];
            var_c72e250a = self.pers[#"killstreak_unique_id"][var_3522232f];
            var_948e9ad0 = self.pers[#"killstreak_has_been_used"][var_3522232f];
            var_80931fe9 = self.pers[#"killstreak_ammo_count"][var_3522232f];
            self.pers[#"killstreaks"][var_3522232f] = self.pers[#"killstreaks"][var_a1312679];
            self.pers[#"killstreak_unique_id"][var_3522232f] = self.pers[#"killstreak_unique_id"][var_a1312679];
            self.pers[#"killstreak_has_been_used"][var_3522232f] = self.pers[#"killstreak_has_been_used"][var_a1312679];
            self.pers[#"killstreak_ammo_count"][var_3522232f] = self.pers[#"killstreak_ammo_count"][var_a1312679];
            self.pers[#"killstreaks"][var_a1312679] = var_3197d2aa;
            self.pers[#"killstreak_unique_id"][var_a1312679] = var_c72e250a;
            self.pers[#"killstreak_has_been_used"][var_a1312679] = var_948e9ad0;
            self.pers[#"killstreak_ammo_count"][var_a1312679] = var_80931fe9;
            self setinventoryweapon(get_killstreak_weapon(var_3197d2aa));
        }
    }
    self.just_given_new_inventory_killstreak = do_not_update_death_count !== just_max_stack_removed_inventory_killstreak && !is_true(var_7b935486);
    if (!isdefined(self.var_58d669ff)) {
        self.var_58d669ff = [];
    }
    if (!isdefined(self.var_58d669ff[do_not_update_death_count])) {
        self.var_58d669ff[do_not_update_death_count] = [];
    }
    array::push(self.var_58d669ff[do_not_update_death_count], gettime(), self.var_58d669ff[do_not_update_death_count].size);
    return true;
}

// Namespace killstreaks/killstreaks_shared
// Params 5, eflags: 0x1 linked
// Checksum 0x4f86c713, Offset: 0x2e70
// Size: 0x15c
function add_to_notification_queue(menuname, *streakcount, hardpointtype, nonotify, var_af825242) {
    killstreaktablenumber = level.killstreakindices[streakcount];
    if (!isdefined(killstreaktablenumber)) {
        return;
    }
    if (is_true(nonotify)) {
        return;
    }
    informdialog = namespace_f9b02f80::get_killstreak_inform_dialog(hardpointtype);
    var_5b220756 = function_a2c375bb(hardpointtype);
    self thread namespace_f9b02f80::play_killstreak_ready_dialog(hardpointtype, 2.4);
    self thread play_killstreak_ready_sfx(hardpointtype);
    self luinotifyevent(#"killstreak_received", 3, killstreaktablenumber, informdialog, var_af825242);
    self function_8ba40d2f(#"killstreak_received", 3, killstreaktablenumber, informdialog, var_af825242);
    self function_8ba40d2f(#"hash_6a9cb800ad0ef395", 2, self.clientid, var_5b220756);
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x8eea6a0a, Offset: 0x2fd8
// Size: 0xb0
function has_equipped() {
    currentweapon = self getcurrentweapon();
    foreach (killstreak in level.killstreaks) {
        if (killstreak.weapon == currentweapon) {
            return true;
        }
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xc8ced616, Offset: 0x3090
// Size: 0x22
function _get_from_weapon(weapon) {
    return get_killstreak_for_weapon(weapon);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x88ddaa12, Offset: 0x30c0
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
// Params 1, eflags: 0x5 linked
// Checksum 0x93266670, Offset: 0x3140
// Size: 0x150
function private function_ed34685(currentweapon) {
    if (currentweapon != level.weaponnone && !is_true(level.usingmomentum)) {
        weaponslist = self getweaponslist();
        foreach (carriedweapon in weaponslist) {
            if (currentweapon == carriedweapon) {
                continue;
            }
            var_6ddecf7f = get_killstreak_for_weapon(carriedweapon);
            if (isdefined(var_6ddecf7f)) {
                if (level.killstreaks[var_6ddecf7f].script_bundle.var_301403ee) {
                    continue;
                }
            }
            if (is_killstreak_weapon(carriedweapon)) {
                self takeweapon(carriedweapon);
            }
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xc2a70c2b, Offset: 0x3298
// Size: 0x4aa
function give_weapon(killstreaktype, usestoredammo) {
    currentweapon = self getcurrentweapon();
    function_ed34685(currentweapon);
    weapon = get_killstreak_weapon(killstreaktype);
    if (currentweapon != weapon && self hasweapon(weapon) == 0) {
        self takeweapon(weapon);
        self giveweapon(weapon);
    }
    if (is_true(level.usingmomentum)) {
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
            var_e93a65da = self.pers[#"killstreak_ammo_count"][self.pers[#"killstreak_ammo_count"].size - 1];
            if (currentweapon == weapon && !isheldinventorykillstreakweapon(weapon)) {
                return weapon.maxammo;
            } else if (is_true(usestoredammo) && (isdefined(var_e93a65da) ? var_e93a65da : 0) > 0) {
                if ((isdefined(self.pers[#"held_killstreak_ammo_count"][weapon]) ? self.pers[#"held_killstreak_ammo_count"][weapon] : 0) > 0) {
                    return self.pers[#"held_killstreak_ammo_count"][weapon];
                }
                self.pers[#"held_killstreak_ammo_count"][weapon] = var_e93a65da;
                self loadout::function_3ba6ee5d(weapon, var_e93a65da);
            } else {
                self.pers[#"held_killstreak_ammo_count"][weapon] = weapon.maxammo;
                self.pers[#"held_killstreak_clip_count"][weapon] = weapon.clipsize;
                self loadout::function_3ba6ee5d(weapon, self.pers[#"held_killstreak_ammo_count"][weapon]);
            }
            return self.pers[#"held_killstreak_ammo_count"][weapon];
        } else {
            switch (level.killstreaks[killstreaktype].script_bundle.var_514a90ee) {
            case #"clip":
                delta = weapon.clipsize;
                break;
            case #"one":
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
// Params 1, eflags: 0x1 linked
// Checksum 0x364d98f0, Offset: 0x3750
// Size: 0x228
function activate_next(do_not_update_death_count) {
    if (level.gameended) {
        return false;
    }
    if (is_true(level.usingmomentum)) {
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
    if (self isremotecontrolling() && self.usingremote === weapon.statname) {
        while (self isremotecontrolling()) {
            waitframe(1);
        }
    }
    ammocount = give_weapon(killstreaktype, 1);
    if (weapon.iscarriedkillstreak) {
        self function_fa6e0467(weapon);
    }
    if (!isdefined(do_not_update_death_count) || do_not_update_death_count != 0) {
        self.pers["killstreakItemDeathCount" + killstreaktype] = self.deathcount;
    }
    return true;
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x3b3d545f, Offset: 0x3980
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
        self thread namespace_f9b02f80::play_killstreak_ready_dialog(self.pers[#"killstreaks"][size - 1]);
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
// Params 1, eflags: 0x1 linked
// Checksum 0x67f6abdf, Offset: 0x3b98
// Size: 0x74
function get_killstreak_quantity(killstreakweapon) {
    if (!isdefined(self.pers[#"killstreak_quantity"])) {
        return 0;
    }
    return isdefined(self.pers[#"killstreak_quantity"][killstreakweapon]) ? self.pers[#"killstreak_quantity"][killstreakweapon] : 0;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xbfbc069c, Offset: 0x3c18
// Size: 0x238
function change_killstreak_quantity(killstreakweapon, delta) {
    if (delta === 1 && killstreakweapon.statname == "remote_missile") {
        streamermodelhint(killstreakweapon.var_22082a57, 7);
    }
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
    self notify("killstreak_quantity_" + killstreakweapon.name);
    killstreaktype = get_killstreak_for_weapon(killstreakweapon);
    if (!isdefined(self.var_58d669ff)) {
        self.var_58d669ff = [];
    }
    if (!isdefined(self.var_58d669ff[killstreaktype])) {
        self.var_58d669ff[killstreaktype] = [];
    }
    for (index = 0; delta - index > 0; index++) {
        array::push(self.var_58d669ff[killstreaktype], function_f8d53445(), self.var_58d669ff[killstreaktype].size);
    }
    return quantity;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x90811647, Offset: 0x3e58
// Size: 0xd0
function function_1f96e8f8(killstreakweapon) {
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
// Params 1, eflags: 0x1 linked
// Checksum 0xd94ac0d2, Offset: 0x3f30
// Size: 0x8c
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
// Checksum 0xad0a88b5, Offset: 0x3fc8
// Size: 0xb0
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
// Params 2, eflags: 0x1 linked
// Checksum 0xb30b5803, Offset: 0x4080
// Size: 0x184
function recordkillstreakbegindirect(killstreak, recordstreakindex) {
    player = self;
    if (!isplayer(player) || !isdefined(recordstreakindex)) {
        return;
    }
    if (!isdefined(player.killstreakevents)) {
        player.killstreakevents = associativearray();
    }
    var_b16cd32d = 0;
    if (isdefined(self.var_58d669ff) && isdefined(self.var_58d669ff[killstreak]) && self.var_58d669ff[killstreak].size > 0) {
        var_b16cd32d = array::pop_front(self.var_58d669ff[killstreak], 0);
    }
    if (isdefined(self.killstreakevents[recordstreakindex])) {
        kills = player.killstreakevents[recordstreakindex];
        eventindex = player recordkillstreakevent(recordstreakindex, var_b16cd32d);
        player killstreakrules::recordkillstreakenddirect(eventindex, recordstreakindex, kills);
        player.killstreakevents[recordstreakindex] = undefined;
        return;
    }
    eventindex = player recordkillstreakevent(recordstreakindex, var_b16cd32d);
    player.killstreakevents[recordstreakindex] = eventindex;
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x79f95d0, Offset: 0x4210
// Size: 0x354
function remove_when_done(killstreaktype, *haskillstreakbeenused, isfrominventory) {
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill(#"killstreak_done");
        if (waitresult.var_d3413870 == haskillstreakbeenused) {
            break;
        }
    }
    if (waitresult.is_successful) {
        self function_aa56f6a0(haskillstreakbeenused, isfrominventory);
        success = 1;
    } else {
        killstreak_weapon = get_killstreak_weapon(haskillstreakbeenused);
        if (!killstreak_weapon.iscarriedkillstreak) {
            self function_1f96e8f8(killstreak_weapon);
        }
    }
    waittillframeend();
    killstreak_weapon = get_killstreak_weapon(haskillstreakbeenused);
    if (killstreak_weapon.var_7d24272c) {
        if ((!is_true(level.usingmomentum) || is_true(isfrominventory)) && waitresult.is_successful) {
            activate_next();
        }
        return;
    }
    currentweapon = self getcurrentweapon();
    if (currentweapon == killstreak_weapon && killstreak_weapon.iscarriedkillstreak) {
        return;
    }
    if (waitresult.is_successful && (!self has_killstreak_in_class(get_menu_name(haskillstreakbeenused)) || is_true(isfrominventory))) {
        switch_to_last_non_killstreak_weapon();
    } else {
        killstreakforcurrentweapon = get_from_weapon(currentweapon);
        if (currentweapon.isgameplayweapon) {
            if (is_true(self.isplanting) || is_true(self.isdefusing)) {
                return;
            }
        }
        if (!isdefined(killstreakforcurrentweapon) && isdefined(currentweapon)) {
            return;
        }
        if (waitresult.is_successful || !isdefined(killstreakforcurrentweapon) || (killstreakforcurrentweapon == haskillstreakbeenused || killstreakforcurrentweapon == "inventory_" + haskillstreakbeenused) && !currentweapon.iscarriedkillstreak) {
            switch_to_last_non_killstreak_weapon();
        }
    }
    if ((!is_true(level.usingmomentum) || is_true(isfrominventory)) && waitresult.is_successful) {
        activate_next();
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xe7dc551, Offset: 0x4570
// Size: 0x3cc
function function_aa56f6a0(killstreaktype, isfrominventory) {
    /#
        print("<dev string:x38c>" + get_menu_name(killstreaktype));
    #/
    if (!isdefined(self.pers[level.killstreaks[killstreaktype].usagekey])) {
        self.pers[level.killstreaks[killstreaktype].usagekey] = 0;
    }
    self.pers[level.killstreaks[killstreaktype].usagekey]++;
    killstreak_weapon = get_killstreak_weapon(killstreaktype);
    var_d86010cb = get_killstreak_for_weapon_for_stats(killstreak_weapon);
    if (isdefined(level.killstreaks[var_d86010cb].menuname)) {
        recordstreakindex = level.killstreakindices[level.killstreaks[var_d86010cb].menuname];
        self recordkillstreakbegindirect(killstreaktype, recordstreakindex);
    }
    if (is_true(level.usingscorestreaks)) {
        var_ad8ae78f = {#gametime:function_f8d53445(), #killstreak:killstreaktype, #activatedby:getplayerspawnid(self)};
        function_92d1707f(#"hash_1aa07f199266e0c7", var_ad8ae78f);
        if (is_true(isfrominventory)) {
            remove_used_killstreak(killstreaktype);
            if (self getinventoryweapon() == killstreak_weapon) {
                self setinventoryweapon(level.weaponnone);
            }
        } else {
            self change_killstreak_quantity(killstreak_weapon, -1);
        }
    } else if (is_true(level.usingmomentum)) {
        if (is_true(isfrominventory) && self getinventoryweapon() == killstreak_weapon) {
            remove_used_killstreak(killstreaktype);
            self setinventoryweapon(level.weaponnone);
        } else if (isdefined(level.var_b0dc03c7)) {
            self [[ level.var_b0dc03c7 ]](killstreaktype);
        }
    } else {
        remove_used_killstreak(killstreaktype);
    }
    if (!is_true(level.usingmomentum)) {
        self setactionslot(4, "");
    }
    callback::callback(#"hash_4a1cdf56005f9fb3", {#player:self, #killstreaktype:killstreaktype});
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xe2709d1d, Offset: 0x4948
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
// Checksum 0x932aae29, Offset: 0x49f8
// Size: 0x64
function function_2ea0382e() {
    self.pers[#"killstreaks"] = [];
    self.pers[#"killstreak_has_been_used"] = [];
    self.pers[#"killstreak_unique_id"] = [];
    self.pers[#"killstreak_ammo_count"] = [];
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x7c680404, Offset: 0x4a68
// Size: 0x3c2
function remove_used_killstreak(killstreak, killstreakid, take_weapon_after_use = 1) {
    self.just_removed_used_killstreak = undefined;
    if (!isdefined(self.pers[#"killstreaks"])) {
        return;
    }
    killstreak_weapon = get_killstreak_weapon(killstreak);
    if (killstreak_weapon.iscarriedkillstreak) {
        if (isdefined(self.pers[#"held_killstreak_ammo_count"][killstreak_weapon])) {
            if (self.pers[#"held_killstreak_ammo_count"][killstreak_weapon] > 0) {
                return;
            }
        }
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
// Params 1, eflags: 0x1 linked
// Checksum 0x55950cfd, Offset: 0x4e38
// Size: 0xa2
function take_weapon_after_use(killstreakweapon) {
    self endon(#"disconnect", #"death", #"joined_team", #"joined_spectators");
    self waittill(#"weapon_change");
    if (self getinventoryweapon() != killstreakweapon) {
        self takeweapon(killstreakweapon);
    }
    self.killstreakactivated = 1;
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x7ca41916, Offset: 0x4ee8
// Size: 0x66
function get_top_killstreak() {
    if (self.pers[#"killstreaks"].size == 0) {
        return undefined;
    }
    return self.pers[#"killstreaks"][self.pers[#"killstreaks"].size - 1];
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xac65ff3e, Offset: 0x4f58
// Size: 0x80
function get_if_top_killstreak_has_been_used() {
    if (!is_true(level.usingmomentum)) {
        if (self.pers[#"killstreak_has_been_used"].size == 0) {
            return undefined;
        }
        return self.pers[#"killstreak_has_been_used"][self.pers[#"killstreak_has_been_used"].size - 1];
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0xad5ecab5, Offset: 0x4fe0
// Size: 0x66
function get_top_killstreak_unique_id() {
    if (self.pers[#"killstreak_unique_id"].size == 0) {
        return undefined;
    }
    return self.pers[#"killstreak_unique_id"][self.pers[#"killstreak_unique_id"].size - 1];
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x1da0b1ea, Offset: 0x5050
// Size: 0x78
function get_killstreak_index_by_id(killstreakid) {
    for (index = self.pers[#"killstreak_unique_id"].size - 1; index >= 0; index--) {
        if (self.pers[#"killstreak_unique_id"][index] == killstreakid) {
            return index;
        }
    }
    return undefined;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xffab2a54, Offset: 0x50d0
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
// Params 1, eflags: 0x1 linked
// Checksum 0x53b09bc3, Offset: 0x5170
// Size: 0x222
function function_4f415d8e(params) {
    if (game.state == "postgame" || !isdefined(self)) {
        return;
    }
    assert(self.lastnonkillstreakweapon != level.weaponnone);
    lastvalidpimary = self.lastnonkillstreakweapon;
    weapon = params.weapon;
    if (weapons::is_primary_weapon(weapon)) {
        lastvalidpimary = weapon;
    }
    if (weapon === self.lastnonkillstreakweapon || weapon === level.weaponnone || weapon === level.weaponbasemelee) {
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
    if (isdefined(name) && weapon.iscarriedkillstreak) {
        return;
    }
    self.lastnonkillstreakweapon = weapon;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x8079f452, Offset: 0x53a0
// Size: 0x334
function function_4167ea4e(params) {
    weapon = params.weapon;
    if (self isonladder() || self isinvehicle()) {
        if (is_killstreak_weapon(weapon) || weapon === level.weaponnone) {
            self switch_to_last_non_killstreak_weapon();
        }
        return;
    }
    if (!is_killstreak_weapon(weapon)) {
        return;
    }
    if (function_f479a2ff(weapon)) {
        return;
    }
    killstreak = get_killstreak_for_weapon(weapon);
    if (is_true(level.forceusekillstreak)) {
        thread usekillstreak(killstreak, undefined);
        return;
    }
    if (!is_true(level.usingmomentum)) {
        killstreak = get_top_killstreak();
        if (weapon != get_killstreak_weapon(killstreak)) {
            return;
        }
    }
    if (level.killstreaks[killstreak].script_bundle.var_9e2fccd4 === weapon) {
        return;
    }
    waittillframeend();
    if (is_true(self.usingkillstreakheldweapon) && weapon.iscarriedkillstreak) {
        return;
    }
    isfrominventory = undefined;
    if (is_true(level.usingscorestreaks)) {
        if (weapon == self getinventoryweapon()) {
            isfrominventory = 1;
        } else if (self getammocount(weapon) <= 0 && weapon.name != "killstreak_ai_tank") {
            self switch_to_last_non_killstreak_weapon();
            return;
        }
    } else if (is_true(level.usingmomentum)) {
        if (weapon == self getinventoryweapon()) {
            isfrominventory = 1;
        } else if (self.momentum < self function_dceb5542(level.killstreaks[killstreak].itemindex)) {
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
// Params 1, eflags: 0x1 linked
// Checksum 0x79fd52cb, Offset: 0x56e0
// Size: 0xd4
function on_grenade_fired(params) {
    grenade = params.projectile;
    grenadeweaponid = params.weapon;
    if (grenadeweaponid == level.var_239dc073) {
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
// Params 1, eflags: 0x1 linked
// Checksum 0xb224d44f, Offset: 0x57c0
// Size: 0xac
function on_offhand_fire(params) {
    grenadeweaponid = params.weapon;
    if (grenadeweaponid == level.var_239dc073) {
        return;
    }
    if (is_killstreak_weapon(grenadeweaponid)) {
        killstreak = get_killstreak_for_weapon(grenadeweaponid);
        isfrominventory = grenadeweaponid == self getinventoryweapon();
        thread usekillstreak(killstreak, isfrominventory);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xe95e2d1b, Offset: 0x5878
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
// Params 1, eflags: 0x1 linked
// Checksum 0x23ced43a, Offset: 0x5968
// Size: 0x50
function is_delayable_killstreak(killstreaktype) {
    if (isdefined(level.killstreaks[killstreaktype]) && is_true(level.killstreaks[killstreaktype].delaystreak)) {
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xe9ff9960, Offset: 0x59c0
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
// Params 2, eflags: 0x1 linked
// Checksum 0xe3c937a3, Offset: 0x5a88
// Size: 0x1ee
function trigger_killstreak(killstreaktype, isfrominventory) {
    assert(isdefined(level.killstreaks[killstreaktype].usefunction), "<dev string:x39c>" + killstreaktype);
    self.usingkillstreakfrominventory = isfrominventory;
    if (is_true(level.infinalkillcam)) {
        return;
    }
    if (should_delay_killstreak(killstreaktype)) {
        display_unavailable_time();
    } else {
        killstreak_weapon = get_killstreak_weapon(killstreaktype);
        if (!killstreak_weapon.iscarriedkillstreak) {
            self setweaponammoclip(killstreak_weapon, killstreak_weapon.startammo);
        }
        success = [[ level.killstreaks[killstreaktype].usefunction ]](killstreaktype);
        if (is_true(success)) {
            if (isdefined(self)) {
                self notify(#"killstreak_used", killstreaktype);
                self notify(#"killstreak_done", {#is_successful:1, #var_d3413870:killstreaktype});
                self.usingkillstreakfrominventory = undefined;
            }
            return;
        }
    }
    if (isdefined(self)) {
        self.usingkillstreakfrominventory = undefined;
        self notify(#"killstreak_done", {#is_successful:0, #var_d3413870:killstreaktype});
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x907b13f2, Offset: 0x5c80
// Size: 0x5e
function add_to_killstreak_count(*weapon) {
    if (!isdefined(self.pers[#"totalkillstreakcount"])) {
        self.pers[#"totalkillstreakcount"] = 0;
    }
    self.pers[#"totalkillstreakcount"]++;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x25a1181b, Offset: 0x5ce8
// Size: 0xa6
function should_give_killstreak(weapon) {
    rootweapon = isdefined(weapon) && isdefined(weapon.rootweapon) ? weapon.rootweapon : weapon;
    if (getdvarint(#"scr_allow_killstreak_building", 0) == 0) {
        if (function_c5927b3f(rootweapon)) {
            return true;
        }
        if (is_weapon_associated_with_killstreak(rootweapon)) {
            return false;
        }
    }
    return true;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x751d1764, Offset: 0x5d98
// Size: 0x9c
function play_killstreak_ready_sfx(killstreaktype) {
    if (game.state != "playing") {
        return;
    }
    if (isdefined(level.killstreaks[killstreaktype].script_bundle.var_c08f7089)) {
        self playsoundtoplayer(level.killstreaks[killstreaktype].script_bundle.var_c08f7089, self);
        return;
    }
    self playsoundtoplayer("uin_kls_generic", self);
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xa2fdb8fa, Offset: 0x5e40
// Size: 0x36e
function player_killstreak_threat_tracking(killstreaktype, var_bdb26ff0) {
    assert(isdefined(killstreaktype));
    self endon(#"death", #"delete", #"leaving");
    level endon(#"game_ended");
    while (true) {
        if (!isdefined(self.owner)) {
            return;
        }
        players = function_f6f34851(self.owner.team);
        players = array::randomize(players);
        var_c3c784a5 = 5;
        var_9217cadc = 0;
        foreach (player in players) {
            if (!player battlechatter::can_play_dialog(1)) {
                continue;
            }
            lookangles = player getplayerangles();
            if (lookangles[0] < -90 || lookangles[0] > -20) {
                continue;
            }
            lookdir = anglestoforward(lookangles);
            eyepoint = player geteye();
            streakdir = vectornormalize(self.origin - eyepoint);
            dot = vectordot(streakdir, lookdir);
            if (dot < var_bdb26ff0) {
                continue;
            }
            if (var_c3c784a5 == 0) {
                break;
            }
            traceresult = bullettrace(eyepoint, self.origin, 1, player);
            if (traceresult[#"fraction"] >= 1 || traceresult[#"entity"] === self) {
                if (battlechatter::dialog_chance("killstreakSpotChance")) {
                    player battlechatter::playkillstreakthreat(killstreaktype);
                }
                var_9217cadc = battlechatter::mpdialog_value("killstreakSpotDelay", 0);
                break;
            }
            var_c3c784a5--;
        }
        wait battlechatter::mpdialog_value("killstreakSpotInterval", float(function_60d95f53()) / 1000) + var_9217cadc;
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xeaf9d563, Offset: 0x61b8
// Size: 0x20c
function function_ece736e7(player, killstreak) {
    if (!battlechatter::function_e1983f22() || function_c0c60634(killstreak)) {
        return;
    }
    if (is_true(level.teambased)) {
        enemies = function_f6f34851(player.team, player.origin, 1200);
    } else {
        enemies = function_f6f34851();
    }
    closestenemies = arraysort(enemies, player.origin);
    playereye = player geteye();
    foreach (enemy in closestenemies) {
        enemyeye = enemy geteye();
        enemyangles = enemy getplayerangles();
        if (util::within_fov(enemyeye, enemyangles, playereye, 0.5)) {
            if (sighttracepassed(enemyeye, playereye, 0, enemy)) {
                enemy battlechatter::playkillstreakthreat(get_from_weapon(killstreak));
                killstreak.var_95b0150d = gettime();
                return;
            }
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x78270243, Offset: 0x63d0
// Size: 0x54
function function_c0c60634(weapon) {
    if (isdefined(weapon.var_95b0150d)) {
        if (weapon.var_95b0150d + int(10 * 1000) >= gettime()) {
            return true;
        }
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x48e748a0, Offset: 0x6430
// Size: 0x30
function get_killstreak_usage(usagekey) {
    if (!isdefined(self.pers[usagekey])) {
        return 0;
    }
    return self.pers[usagekey];
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x4d707b5d, Offset: 0x6468
// Size: 0x106
function on_player_spawned() {
    profilestart();
    pixbeginevent(#"hash_1d81325f0403ec55");
    self thread give_owned();
    self.killcamkilledbyent = undefined;
    self callback::on_weapon_change(&function_4f415d8e);
    self callback::on_weapon_change(&function_4167ea4e);
    self callback::on_grenade_fired(&on_grenade_fired);
    self callback::on_offhand_fire(&on_offhand_fire);
    self thread initialspawnprotection();
    self function_f964dc1c();
    pixendevent();
    profilestop();
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xc61b0298, Offset: 0x6578
// Size: 0x15c
function on_joined_team(*params) {
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
    if (is_true(level.usingscorestreaks)) {
        self.pers[#"killstreak_quantity"] = [];
        self.pers[#"held_killstreak_ammo_count"] = [];
        self.pers[#"held_killstreak_clip_count"] = [];
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x5 linked
// Checksum 0xb0437e40, Offset: 0x66e0
// Size: 0x154
function private initialspawnprotection() {
    self endon(#"death", #"disconnect");
    if (isdefined(level.var_f81eb032) && isdefined(level.var_f81eb032.var_176dc082)) {
        self thread [[ level.var_f81eb032.var_176dc082 ]](level.spawnprotectiontime);
    }
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
    // Checksum 0xa6ad25e2, Offset: 0x6840
    // Size: 0xe0
    function killstreak_debug_think() {
        setdvar(#"debug_killstreak", "<dev string:x75>");
        for (;;) {
            cmd = getdvarstring(#"debug_killstreak");
            switch (cmd) {
            case #"data_dump":
                killstreak_data_dump();
                break;
            }
            if (cmd != "<dev string:x75>") {
                setdvar(#"debug_killstreak", "<dev string:x75>");
            }
            wait 0.5;
        }
    }

    // Namespace killstreaks/killstreaks_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3749b53f, Offset: 0x6928
    // Size: 0x32c
    function killstreak_data_dump() {
        iprintln("<dev string:x3c7>");
        println("<dev string:x3ea>");
        println("<dev string:x409>");
        keys = getarraykeys(level.killstreaks);
        for (i = 0; i < keys.size; i++) {
            data = level.killstreaks[keys[i]];
            type_data = level.killstreaktype[keys[i]];
            print(keys[i] + "<dev string:x472>");
            print(data.killstreaklevel + "<dev string:x472>");
            print(data.weapon.name + "<dev string:x472>");
            alt = 0;
            if (isdefined(data.script_bundle.altweapons)) {
                assert(data.script_bundle.altweapons.size <= 4);
                for (alt = 0; alt < data.script_bundle.altweapons.size; alt++) {
                    print(data.script_bundle.altweapons[alt].name + "<dev string:x472>");
                }
            }
            while (alt < 4) {
                print("<dev string:x472>");
                alt++;
            }
            type = 0;
            if (isdefined(type_data)) {
                assert(type_data.size < 4);
                type_keys = getarraykeys(type_data);
                while (type < type_keys.size) {
                    if (type_data[type_keys[type]] == 1) {
                        print(type_keys[type] + "<dev string:x472>");
                    }
                    type++;
                }
            }
            while (type < 4) {
                print("<dev string:x472>");
                type++;
            }
            println("<dev string:x75>");
        }
        println("<dev string:x477>");
    }

#/

// Namespace killstreaks/killstreaks_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x5bccbe3, Offset: 0x6c60
// Size: 0x94
function function_2b6aa9e8(killstreak_ref, destroyed_callback, low_health_callback, emp_callback) {
    self setcandamage(1);
    self thread monitordamage(killstreak_ref, killstreak_bundles::get_max_health(killstreak_ref), destroyed_callback, killstreak_bundles::get_low_health(killstreak_ref), low_health_callback, 0, emp_callback, 1);
}

// Namespace killstreaks/killstreaks_shared
// Params 8, eflags: 0x1 linked
// Checksum 0x874d3f37, Offset: 0x6d00
// Size: 0x912
function monitordamage(killstreak_ref, max_health, destroyed_callback, low_health, low_health_callback, emp_damage, emp_callback, allow_bullet_damage) {
    self endon(#"death", #"delete");
    self setcandamage(1);
    self setup_health(killstreak_ref, max_health, low_health);
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
        if (is_true(self.invulnerable)) {
            continue;
        }
        if (!isdefined(attacker)) {
            continue;
        }
        if (!isplayer(attacker)) {
            if (isdefined(level.figure_out_attacker)) {
                attacker = self [[ level.figure_out_attacker ]](attacker);
                if (!isplayer(attacker)) {
                    continue;
                }
            } else {
                continue;
            }
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
            isvalidattacker = isdefined(attacker.team) && util::function_fbce7263(attacker.team, self.team);
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
        if (is_true(self.selfdestruct)) {
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
        if (self.damagetaken >= self.maxhealth) {
            level.globalkillstreaksdestroyed++;
            attacker stats::function_e24eec31(getweapon(killstreak_ref), #"destroyed", 1);
            if (isdefined(inflictor) && inflictor getentitytype() == 4) {
                bundle = get_script_bundle(killstreak_ref);
                if (isdefined(bundle.var_888a5ff7) && isdefined(waitresult.position)) {
                    var_74d40edb = inflictor getvelocity();
                    if (lengthsquared(var_74d40edb) > function_a3f6cdac(50)) {
                        var_29edfc10 = vectornormalize(var_74d40edb);
                        playfx(bundle.var_888a5ff7, waitresult.position, var_29edfc10);
                    }
                }
            }
            self function_73566ec7(attacker, weapon, self.owner);
            if (isdefined(destroyed_callback)) {
                self thread [[ destroyed_callback ]](attacker, weapon);
            }
            return;
        }
        if (isdefined(inflictor) && inflictor getentitytype() == 4) {
            bundle = get_script_bundle(killstreak_ref);
            if (isdefined(bundle.var_accc3277) && isdefined(bundle.var_7b7cd9b8)) {
                var_43dd078e = bundle.var_7b7cd9b8.size;
                if (var_43dd078e > 0) {
                    var_98f207d4 = randomint(var_43dd078e);
                    var_f7901b1a = bundle.var_7b7cd9b8[var_98f207d4].var_53ba63fe;
                    /#
                        var_1a2e7367 = getdvarstring(#"hash_68da706138cf16e2", "<dev string:x75>");
                        if (var_1a2e7367 != "<dev string:x75>") {
                            var_f7901b1a = var_1a2e7367;
                        }
                    #/
                    if (isdefined(var_f7901b1a)) {
                        var_e2465f33 = self gettagorigin(var_f7901b1a);
                        if (isdefined(var_e2465f33)) {
                            playfxontag(bundle.var_accc3277, self, var_f7901b1a);
                        }
                    }
                }
            }
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
// Params 3, eflags: 0x1 linked
// Checksum 0x78d4deea, Offset: 0x7620
// Size: 0x3a0
function function_73566ec7(attacker, weapon, owner) {
    if (!isdefined(self) || is_true(self.var_c5bb583d) || !isdefined(attacker) || !isplayer(attacker) || !isdefined(self.killstreaktype) || self.team === attacker.team) {
        return;
    }
    bundle = get_script_bundle(self.killstreaktype);
    if (isdefined(bundle) && isdefined(bundle.var_ebd92bbc)) {
        scoreevents::processscoreevent(bundle.var_ebd92bbc, attacker, owner, weapon);
        attacker stats::function_dad108fa(#"stats_destructions", 1);
        attacker contracts::increment_contract(#"hash_317a8b8df3aa8838");
        self.var_c5bb583d = 1;
        if (isdefined(self.attackers) && self.attackers.size > 0) {
            maxhealth = 1 / self.maxhealth;
            if (!isdefined(bundle.var_74711af9)) {
                return;
            }
            foreach (assister in self.attackers) {
                if (assister == attacker || !isplayer(assister) || !util::function_fbce7263(self.team, assister.team)) {
                    continue;
                }
                if (isdefined(bundle.var_93f7b1ae) && isdefined(self.attackerdamage)) {
                    timepassed = float(gettime() - self.attackerdamage[assister.clientid].lastdamagetime) / 1000;
                    if (timepassed > bundle.var_93f7b1ae) {
                        continue;
                    }
                }
                if (isdefined(bundle.var_ebcd245a) && isdefined(self.attackerdamage)) {
                    damagepercent = self.attackerdamage[assister.clientid].damage * maxhealth;
                    if (damagepercent < bundle.var_ebcd245a) {
                        continue;
                    }
                }
                scoreevents::processscoreevent(bundle.var_74711af9, assister, owner, self.attackerdamage[assister.clientid].weapon);
                assister stats::function_dad108fa(#"stats_destructions", 1);
                assister contracts::increment_contract(#"hash_317a8b8df3aa8838");
            }
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 15, eflags: 0x1 linked
// Checksum 0x2cbb6d0e, Offset: 0x79c8
// Size: 0x3c4
function ondamageperweapon(killstreak_ref, attacker, damage, flags, type, weapon, max_health, destroyed_callback, low_health, *low_health_callback, emp_damage, emp_callback, allow_bullet_damage, chargelevel, var_488beb6d) {
    self.maxhealth = destroyed_callback;
    self.lowhealth = low_health_callback;
    tablehealth = killstreak_bundles::get_max_health(attacker);
    if (isdefined(tablehealth)) {
        self.maxhealth = tablehealth;
    }
    tablehealth = killstreak_bundles::get_low_health(attacker);
    if (isdefined(tablehealth)) {
        self.lowhealth = tablehealth;
    }
    if (is_true(self.invulnerable)) {
        return 0;
    }
    if (!isplayer(damage)) {
        if (isdefined(level.figure_out_attacker)) {
            damage = self [[ level.figure_out_attacker ]](damage);
            if (!isplayer(damage)) {
                return get_old_damage(damage, max_health, weapon, flags, allow_bullet_damage);
            }
        } else {
            return get_old_damage(damage, max_health, weapon, flags, allow_bullet_damage);
        }
    }
    friendlyfire = damage::friendlyfirecheck(self.owner, damage);
    if (!friendlyfire) {
        return 0;
    }
    if (!is_true(var_488beb6d)) {
        isvalidattacker = 1;
        if (level.teambased) {
            isvalidattacker = isdefined(damage.team) && util::function_fbce7263(damage.team, self.team);
        }
        if (!isvalidattacker) {
            return 0;
        }
    }
    if (max_health.isemp && weapon == "MOD_GRENADE_SPLASH") {
        emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage(attacker, self.maxhealth);
        if (!isdefined(emp_damage_to_apply)) {
            emp_damage_to_apply = isdefined(emp_damage) ? emp_damage : 1;
        }
        if (isdefined(emp_callback) && emp_damage_to_apply > 0) {
            self [[ emp_callback ]](damage, max_health);
        }
        return emp_damage_to_apply;
    }
    weapon_damage = killstreak_bundles::get_weapon_damage(attacker, self.maxhealth, damage, max_health, weapon, flags, type, chargelevel);
    if (!isdefined(weapon_damage)) {
        weapon_damage = get_old_damage(damage, max_health, weapon, flags, allow_bullet_damage);
    }
    if (!isdefined(weapon_damage) || weapon_damage <= 0) {
        return 0;
    }
    idamage = int(weapon_damage);
    if (idamage >= self.health) {
        self function_73566ec7(damage, max_health, self.owner);
        if (isdefined(low_health)) {
            self thread [[ low_health ]](damage, max_health);
        }
    }
    return idamage;
}

// Namespace killstreaks/killstreaks_shared
// Params 6, eflags: 0x1 linked
// Checksum 0x5d723d43, Offset: 0x7d98
// Size: 0x236
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
        if (is_true(hasfmj)) {
            damage = int(damage * level.cac_armorpiercing_data);
        }
        if (isdefined(bullet_damage_scalar)) {
            damage = int(damage * bullet_damage_scalar);
        }
        break;
    case #"mod_explosive":
    case #"mod_projectile":
    case #"mod_projectile_splash":
        if (weapon.statindex === level.weaponpistolenergy.statindex || weapon.statindex !== level.weaponshotgunenergy.statindex || weapon.statindex === level.weaponspecialcrossbow.statindex) {
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
// Params 1, eflags: 0x1 linked
// Checksum 0x567e903f, Offset: 0x7fd8
// Size: 0x24
function isheldinventorykillstreakweapon(killstreakweapon) {
    return killstreakweapon.iscarriedkillstreak && killstreakweapon.var_6f41c2a9;
}

// Namespace killstreaks/killstreaks_shared
// Params 5, eflags: 0x0
// Checksum 0xf5c79d20, Offset: 0x8008
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
// Params 2, eflags: 0x0
// Checksum 0xda4d6078, Offset: 0x80c0
// Size: 0x7c
function waittillemp(onempdcallback, arg) {
    self endon(#"death", #"delete");
    waitresult = self waittill(#"emp_deployed");
    if (isdefined(onempdcallback)) {
        [[ onempdcallback ]](waitresult.attacker, arg);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x7a8e80bf, Offset: 0x8148
// Size: 0x6e
function is_killstreak_weapon_assist_allowed(weapon) {
    killstreak = get_killstreak_for_weapon(weapon);
    if (!isdefined(killstreak)) {
        return false;
    }
    if (is_true(level.killstreaks[killstreak].script_bundle.var_c4d802f4)) {
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x8d5d379f, Offset: 0x81c0
// Size: 0xc0
function should_override_entity_camera_in_demo(player, weapon) {
    killstreak = get_killstreak_for_weapon(weapon);
    if (!isdefined(killstreak)) {
        return false;
    }
    bundle = get_script_bundle(killstreak);
    if (is_true(bundle.var_6648cf11)) {
        return true;
    }
    if (isdefined(player.remoteweapon) && is_true(player.remoteweapon.controlled)) {
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xbd7e271, Offset: 0x8288
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
// Params 3, eflags: 0x1 linked
// Checksum 0x21f4b7b5, Offset: 0x82e8
// Size: 0x13e
function clear_using_remote(immediate, skipnotify, gameended) {
    if (!isdefined(self)) {
        return;
    }
    self.dofutz = 0;
    self.no_fade2black = 0;
    self clientfield::set_to_player("static_postfx", 0);
    self function_50b430e0();
    if (isdefined(self.carryicon)) {
        self.carryicon.alpha = 1;
    }
    self.usingremote = undefined;
    self reset_killstreak_delay_killcam();
    self enableoffhandweapons();
    self enableweaponcycling();
    if (isalive(self)) {
        self switch_to_last_non_killstreak_weapon(immediate, undefined, gameended);
    }
    if (!is_true(skipnotify)) {
        self notify(#"stopped_using_remote");
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x9e77b474, Offset: 0x8430
// Size: 0xe
function reset_killstreak_delay_killcam() {
    self.killstreak_delay_killcam = undefined;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xa270b17c, Offset: 0x8448
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
// Params 2, eflags: 0x5 linked
// Checksum 0x704c94f, Offset: 0x84c8
// Size: 0x44c
function private init_ride_killstreak_internal(streak, always_allow) {
    if (isdefined(streak)) {
        laptopwait = "timeout";
        bundle = get_script_bundle(streak);
        start_delay = bundle.var_15b39264;
        var_58330f68 = bundle.var_daafb2f7;
        postfxbundle = bundle.var_bda68f72;
    } else {
        laptopwait = self waittilltimeout(0.2, #"disconnect", #"death", #"weapon_switch_started");
        laptopwait = laptopwait._notify;
    }
    if (!isdefined(start_delay)) {
        start_delay = 0.2;
    }
    if (!isdefined(var_58330f68)) {
        var_58330f68 = 0.2;
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
        if (!isdefined(self.team) || self.team == #"spectator") {
            return "fail";
        }
        return "success";
    }
    if (self is_interacting_with_object()) {
        return "fail";
    }
    if (isdefined(postfxbundle)) {
        self thread function_cfa9cec5(start_delay);
    } else {
        self thread hud::fade_to_black_for_x_sec(start_delay, var_58330f68, 0.1, 0.1);
    }
    self thread watch_for_remove_remote_weapon();
    var_c3d5a8a9 = self waittilltimeout(start_delay + var_58330f68, #"disconnect", #"death");
    self notify(#"endwatchforremoveremoteweapon");
    hostmigration::waittillhostmigrationdone();
    if (self isinvehicle() === 1) {
        return "fail";
    }
    if (var_c3d5a8a9._notify != "disconnect") {
        self thread clear_ride_intro(1);
        if (!isdefined(self.team) || self.team == #"spectator") {
            return "fail";
        }
    }
    if (always_allow) {
        if (var_c3d5a8a9._notify == "disconnect") {
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
    if (is_true(self.laststand)) {
        return "fail";
    }
    if (self is_interacting_with_object()) {
        return "fail";
    }
    if (var_c3d5a8a9._notify == "disconnect") {
        return "disconnect";
    }
    return "success";
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x2282aeb9, Offset: 0x8920
// Size: 0x44
function private clear_ride_intro(delay) {
    self endon(#"disconnect");
    if (isdefined(delay)) {
        wait delay;
    }
    self thread hud::screen_fade_in(0);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x58376b31, Offset: 0x8970
// Size: 0x5c
function function_cfa9cec5(startwait) {
    self endon(#"disconnect");
    wait startwait;
    if (!isdefined(self)) {
        return;
    }
    self clientfield::set_to_player("" + #"hash_524d30f5676b2070", 1);
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xd0c6914f, Offset: 0x89d8
// Size: 0x2c
function function_50b430e0() {
    self clientfield::set_to_player("" + #"hash_524d30f5676b2070", 0);
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xf3ad590e, Offset: 0x8a10
// Size: 0x66
function is_interacting_with_object() {
    if (self iscarryingturret()) {
        return true;
    }
    if (is_true(self.isplanting)) {
        return true;
    }
    if (is_true(self.isdefusing)) {
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x6d976af9, Offset: 0x8a80
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
// Params 1, eflags: 0x1 linked
// Checksum 0xecab736, Offset: 0x8b78
// Size: 0xb2
function defaulthackedhealthupdatecallback(*hacker) {
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
// Params 19, eflags: 0x1 linked
// Checksum 0xddef4cc7, Offset: 0x8c38
// Size: 0x180
function function_8cd96439(killstreakref, killstreakid, onplacecallback, oncancelcallback, onmovecallback, onshutdowncallback, ondeathcallback, onempcallback, model, validmodel, invalidmodel, spawnsvehicle, pickupstring, timeout, health, empdamage, placehintstring, invalidlocationhintstring, placeimmediately = 0) {
    player = self;
    placeable = placeables::spawnplaceable(onplacecallback, oncancelcallback, onmovecallback, onshutdowncallback, ondeathcallback, onempcallback, undefined, undefined, model, validmodel, invalidmodel, spawnsvehicle, pickupstring, timeout, health, empdamage, placehintstring, invalidlocationhintstring, placeimmediately, &function_84da1341);
    if (isdefined(placeable.othermodel)) {
        placeable.othermodel clientfield::set("enemyvehicle", 1);
    }
    placeable.killstreakref = killstreakref;
    placeable.killstreakid = killstreakid;
    placeable configure_team(killstreakref, killstreakid, player);
    return placeable;
}

// Namespace killstreaks/killstreaks_shared
// Params 4, eflags: 0x1 linked
// Checksum 0xf0a783f0, Offset: 0x8dc0
// Size: 0x7c
function function_84da1341(*damagecallback, destroyedcallback, var_1891d3cd, var_2053fdc6) {
    waitframe(1);
    placeable = self;
    if (isdefined(level.var_8ddb1b0e)) {
        placeable thread [[ level.var_8ddb1b0e ]](placeable.killstreakref, placeable.health, destroyedcallback, 0, undefined, var_1891d3cd, var_2053fdc6, 1);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x55b70103, Offset: 0x8e48
// Size: 0xbc
function configure_team(killstreaktype, killstreakid, owner, influencertype, configureteamprefunction, configureteampostfunction, ishacked = 0) {
    killstreak = self;
    killstreak.killstreaktype = killstreaktype;
    killstreak.killstreakid = killstreakid;
    killstreak _setup_configure_team_callbacks(influencertype, configureteamprefunction, configureteampostfunction);
    killstreak configure_team_internal(owner, ishacked);
    owner thread trackactivekillstreak(killstreak);
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x1d85b079, Offset: 0x8f10
// Size: 0x1e4
function configure_team_internal(owner, ishacked) {
    killstreak = self;
    if (ishacked == 0) {
        killstreak.originalowner = owner;
        killstreak.originalteam = owner.team;
    } else {
        assert(killstreak.killstreakteamconfigured, "<dev string:x49a>");
    }
    if (isdefined(killstreak.killstreakconfigureteamprefunction)) {
        killstreak thread [[ killstreak.killstreakconfigureteamprefunction ]](owner, ishacked);
    }
    if (isdefined(killstreak.killstreakinfluencertype)) {
        killstreak influencers::remove_influencers();
    }
    if (!isdefined(owner) || !isdefined(owner.team)) {
        return;
    }
    killstreak setteam(owner.team);
    killstreak.team = owner.team;
    if (!isai(killstreak)) {
        killstreak setowner(owner);
    }
    killstreak.owner = owner;
    killstreak.ownerentnum = owner.entnum;
    killstreak.pilotindex = killstreak.owner namespace_f9b02f80::get_random_pilot_index(killstreak.killstreaktype);
    if (isdefined(killstreak.killstreakinfluencertype)) {
        killstreak influencers::create_entity_enemy_influencer(killstreak.killstreakinfluencertype, owner.team);
    }
    if (isdefined(killstreak.killstreakconfigureteampostfunction)) {
        killstreak thread [[ killstreak.killstreakconfigureteampostfunction ]](owner, ishacked);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x5 linked
// Checksum 0xac792283, Offset: 0x9100
// Size: 0x5a
function private _setup_configure_team_callbacks(influencertype, configureteamprefunction, configureteampostfunction) {
    killstreak = self;
    killstreak.killstreakteamconfigured = 1;
    killstreak.killstreakinfluencertype = influencertype;
    killstreak.killstreakconfigureteamprefunction = configureteamprefunction;
    killstreak.killstreakconfigureteampostfunction = configureteampostfunction;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xc697d613, Offset: 0x9168
// Size: 0x1b6
function trackactivekillstreak(killstreak) {
    killstreakindex = killstreak.killstreakid;
    if (isdefined(self) && isdefined(self.pers) && isdefined(killstreakindex)) {
        self endon(#"disconnect");
        self.pers[#"activekillstreaks"][killstreakindex] = killstreak;
        var_5b220756 = function_a2c375bb(killstreak.killstreaktype);
        if (isdefined(var_5b220756)) {
            killstreak.var_5b220756 = var_5b220756;
            self clientfield::set_player_uimodel(level.var_4b42d599[var_5b220756], 1);
            self function_8ba40d2f(#"hash_1d8e470838fb6dd3", 2, self.clientid, var_5b220756);
        }
        killstreak waittill(#"killstreak_hacked", #"death");
        if (isdefined(self)) {
            if (isdefined(var_5b220756)) {
                self clientfield::set_player_uimodel(level.var_4b42d599[var_5b220756], 0);
                self function_8ba40d2f(#"hash_2e64558432f8b5b2", 2, self.clientid, var_5b220756);
            }
            self.pers[#"activekillstreaks"][killstreakindex] = undefined;
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 4, eflags: 0x0
// Checksum 0x2a506c63, Offset: 0x9328
// Size: 0x50
function processscoreevent(event, player, victim, weapon) {
    if (isdefined(level.var_19a15e42)) {
        [[ level.var_19a15e42 ]](event, player, victim, weapon);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xf5e5c4ef, Offset: 0x9380
// Size: 0x256
function update_player_threat(player) {
    if (!isplayer(player)) {
        return;
    }
    heli = self;
    player.threatlevel = 0;
    dist = distance(player.origin, heli.origin);
    var_b90cd297 = isdefined(self.var_fc0dee44) ? self.var_fc0dee44 : level.heli_visual_range;
    player.threatlevel += (var_b90cd297 - dist) / var_b90cd297 * 100;
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
// Params 1, eflags: 0x1 linked
// Checksum 0xbd45d6ee, Offset: 0x95e0
// Size: 0xc2
function update_non_player_threat(non_player) {
    heli = self;
    non_player.threatlevel = 0;
    dist = distance(non_player.origin, heli.origin);
    var_b90cd297 = isdefined(self.var_fc0dee44) ? self.var_fc0dee44 : level.heli_visual_range;
    non_player.threatlevel += (var_b90cd297 - dist) / var_b90cd297 * 100;
    if (non_player.threatlevel <= 0) {
        non_player.threatlevel = 1;
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xf20af000, Offset: 0x96b0
// Size: 0x1be
function update_actor_threat(actor) {
    heli = self;
    actor.threatlevel = 0;
    dist = distance(actor.origin, heli.origin);
    var_b90cd297 = isdefined(self.var_fc0dee44) ? self.var_fc0dee44 : level.heli_visual_range;
    actor.threatlevel += (var_b90cd297 - dist) / var_b90cd297 * 100;
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
// Params 1, eflags: 0x1 linked
// Checksum 0x8cfb9c6e, Offset: 0x9878
// Size: 0xa6
function update_dog_threat(dog) {
    heli = self;
    dog.threatlevel = 0;
    dist = distance(dog.origin, heli.origin);
    var_b90cd297 = isdefined(self.var_fc0dee44) ? self.var_fc0dee44 : level.heli_visual_range;
    dog.threatlevel += (var_b90cd297 - dist) / var_b90cd297 * 100;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x9d655403, Offset: 0x9928
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
// Params 1, eflags: 0x1 linked
// Checksum 0xeb566edf, Offset: 0x99e8
// Size: 0x14e
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
    if (isdefined(player.score)) {
        player.missilethreatlevel += player.score * 4;
    }
    if (isdefined(player.antithreat)) {
        player.missilethreatlevel -= player.antithreat;
    }
    if (player.missilethreatlevel <= 0) {
        player.missilethreatlevel = 1;
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x2bdfef49, Offset: 0x9b40
// Size: 0x1a
function update_missile_dog_threat(dog) {
    dog.missilethreatlevel = 1;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x9495ed9a, Offset: 0x9b68
// Size: 0x1a
function function_6d23c51c(dog) {
    dog.missilethreatlevel = 2;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x76af728a, Offset: 0x9b90
// Size: 0xa8
function function_fff56140(owner, var_4a025683) {
    self notify(#"hash_4363bc1bae999ad3");
    self endon(#"hash_4363bc1bae999ad3", #"death");
    res = owner waittill(#"joined_team", #"disconnect", #"joined_spectators", #"changed_specialist");
    [[ var_4a025683 ]]();
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x4cfc38ed, Offset: 0x9c40
// Size: 0xd6
function should_not_timeout(killstreak) {
    /#
        assert(isdefined(killstreak), "<dev string:x79>");
        assert(isdefined(level.killstreaks[killstreak]), "<dev string:x1b3>");
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
// Params 6, eflags: 0x1 linked
// Checksum 0x3a70307, Offset: 0x9d20
// Size: 0x54
function waitfortimeout(killstreak, duration, callback, endcondition1, endcondition2, endcondition3) {
    function_b86397ae(killstreak, duration, undefined, callback, endcondition1, endcondition2, endcondition3);
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xfa51cdb6, Offset: 0x9d80
// Size: 0x31c
function function_b86397ae(killstreak, duration, var_c94af1de, callback, endcondition1, endcondition2, endcondition3) {
    /#
        if (should_not_timeout(killstreak)) {
            return;
        }
    #/
    self endon(#"killstreak_hacked", #"cancel_timeout");
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
    killstreakbundle = get_script_bundle(killstreak);
    if (isdefined(var_c94af1de)) {
        self.killstreakendtime = var_c94af1de + duration;
        waittime = self.killstreakendtime - gettime();
    } else {
        self.killstreakendtime = gettime() + duration;
        waittime = duration;
    }
    if (isdefined(self.owner) && isplayer(self.owner) && isdefined(self.var_5b220756) && self.var_ec8ef668 !== 1) {
        self.owner function_a831f92c(self.var_5b220756, int(ceil(float(duration) / 1000)), 0);
        self.owner function_b3185041(self.var_5b220756, self.killstreakendtime);
    }
    if (isdefined(killstreakbundle) && isdefined(killstreakbundle.kstimeoutbeepduration)) {
        self function_b00e94e0(killstreakbundle, waittime);
    } else {
        hostmigration::migrationawarewait(waittime);
    }
    self notify(#"kill_waitfortimeouthacked_thread");
    if (isdefined(self)) {
        self.killstreaktimedout = 1;
        self.killstreakendtime = 0;
    }
    if (isdefined(self.owner) && isplayer(self.owner) && isdefined(self.var_5b220756)) {
        self.owner function_b3185041(self.var_5b220756, 0);
    }
    self notify(#"timed_out");
    if (isdefined(self)) {
        self [[ callback ]]();
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xa4b06d51, Offset: 0xa0a8
// Size: 0x3c
function function_b00e94e0(killstreakbundle, duration) {
    self waitfortimeoutbeep(killstreakbundle.kstimeoutbeepduration, killstreakbundle.kstimeoutfastbeepduration, duration);
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x513abffe, Offset: 0xa0f0
// Size: 0x184
function waitfortimeoutbeep(kstimeoutbeepduration, kstimeoutfastbeepduration, duration) {
    self endon(#"death");
    beepduration = int(kstimeoutbeepduration * 1000);
    hostmigration::migrationawarewait(max(duration - beepduration, 0));
    if (isvehicle(self)) {
        self clientfield::set("timeout_beep", 1);
    }
    if (isdefined(kstimeoutfastbeepduration)) {
        fastbeepduration = int(kstimeoutfastbeepduration * 1000);
        hostmigration::migrationawarewait(max(beepduration - fastbeepduration, 0));
        if (isvehicle(self)) {
            self clientfield::set("timeout_beep", 2);
        }
        hostmigration::migrationawarewait(fastbeepduration);
    }
    self function_67bc25ec();
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x5c3fe9fb, Offset: 0xa280
// Size: 0x44
function function_67bc25ec() {
    if (isdefined(self) && isvehicle(self)) {
        self clientfield::set("timeout_beep", 0);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 5, eflags: 0x1 linked
// Checksum 0x2d88e25a, Offset: 0xa2d0
// Size: 0xf4
function waitfortimeouthacked(*killstreak, callback, endcondition1, endcondition2, endcondition3) {
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
// Checksum 0xdc7b1a3f, Offset: 0xa3d0
// Size: 0x76
function function_975d45c3() {
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
// Params 1, eflags: 0x1 linked
// Checksum 0xa354c89, Offset: 0xa450
// Size: 0x1a
function set_killstreak_delay_killcam(killstreak_name) {
    self.killstreak_delay_killcam = killstreak_name;
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x3a129116, Offset: 0xa478
// Size: 0x1c
function getactivekillstreaks() {
    return self.pers[#"activekillstreaks"];
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x36691484, Offset: 0xa4a0
// Size: 0x42
function function_55e3fed6(killstreaktype) {
    var_98037a32 = self.var_8b9b1bba[killstreaktype];
    if (!isdefined(var_98037a32)) {
        return false;
    }
    if (var_98037a32 > gettime()) {
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x44d6055, Offset: 0xa4f0
// Size: 0xaa
function watchteamchange(teamchangenotify) {
    self notify("5d151652fc812705");
    self endon("5d151652fc812705");
    killstreak = self;
    killstreak endon(#"death", teamchangenotify);
    killstreak.owner waittill(#"joined_team", #"disconnect", #"joined_spectators", #"emp_jammed");
    killstreak notify(teamchangenotify);
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xa4d9b771, Offset: 0xa5a8
// Size: 0x3c
function killstreak_assist(victim, assister, killstreak) {
    victim recordkillstreakassist(victim, assister, killstreak);
}

// Namespace killstreaks/killstreaks_shared
// Params 4, eflags: 0x0
// Checksum 0xe46e8e60, Offset: 0xa5f0
// Size: 0x11a
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
    owner.ricochet_protection[killstreak_id].distancesq = function_a3f6cdac(ricochet_distance);
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x81de114a, Offset: 0xa718
// Size: 0x76
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
// Checksum 0x5d96525b, Offset: 0xa798
// Size: 0x4c
function remove_ricochet_protection(killstreak_id, owner) {
    if (!isdefined(owner) || !isdefined(owner.ricochet_protection) || !isdefined(killstreak_id)) {
        return;
    }
    owner.ricochet_protection[killstreak_id] = undefined;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x439a7f6e, Offset: 0xa7f0
// Size: 0x24
function thermal_glow(enable) {
    clientfield::set_to_player("thermal_glow", enable);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x7bcb80f7, Offset: 0xa820
// Size: 0x24
function thermal_glow_enemies_only(enable) {
    clientfield::set_to_player("thermal_glow_enemies_only", enable);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x3b5e0960, Offset: 0xa850
// Size: 0x102
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

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x68270102, Offset: 0xa960
// Size: 0x3a
function get_script_bundle(type) {
    if (!isdefined(level.killstreaks[type])) {
        return undefined;
    }
    return level.killstreaks[type].script_bundle;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x81648004, Offset: 0xa9a8
// Size: 0x44
function function_e2c3bda3(killstreaktype, var_dee4d012) {
    var_fc96f513 = level.var_8c83a621[killstreaktype];
    if (!isdefined(var_fc96f513)) {
        var_fc96f513 = var_dee4d012;
    }
    return var_fc96f513;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xe49b0889, Offset: 0xa9f8
// Size: 0x40
function function_8c83a621(killstreaktype, var_fc96f513) {
    if (!isdefined(level.var_8c83a621)) {
        level.var_8c83a621 = [];
    }
    level.var_8c83a621[killstreaktype] = var_fc96f513;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xc1dac09c, Offset: 0xaa40
// Size: 0x40
function function_257a5f13(killstreaktype, var_ba5a6782) {
    if (!isdefined(level.var_257a5f13)) {
        level.var_257a5f13 = [];
    }
    level.var_257a5f13[killstreaktype] = var_ba5a6782;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xd4f1ddc8, Offset: 0xaa88
// Size: 0x184
function function_b182645e(player, hardpointtype) {
    if (isdefined(level.var_257a5f13[hardpointtype])) {
        var_5b220756 = 3;
        var_1abcfdda = getarraykeys(player.killstreak);
        foreach (key in var_1abcfdda) {
            if (!isdefined(player.killstreak[key])) {
                continue;
            }
            if (player.killstreak[key] == hardpointtype) {
                var_5b220756 = key;
                break;
            }
        }
        duration = level.var_257a5f13[hardpointtype];
        player function_a831f92c(var_5b220756, duration, 0);
        self.killstreakendtime = gettime() + int(duration * 1000);
        player function_b3185041(var_5b220756, self.killstreakendtime);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x6107b773, Offset: 0xac18
// Size: 0x164
function function_f964dc1c() {
    for (slot = 0; slot < 4; slot++) {
        duration = isdefined(self.pers[#"hash_6ae564fce4d70aff"][slot]) ? self.pers[#"hash_6ae564fce4d70aff"][slot] : 0;
        var_f63114ce = isdefined(self.pers[#"hash_7b0ebc5ef8a8b896"][slot]) ? self.pers[#"hash_7b0ebc5ef8a8b896"][slot] : 0;
        self function_5249e8b8(slot, duration);
        self function_d5d8e662(slot, var_f63114ce);
        endtime = isdefined(self.pers[#"hash_754e08b82fb3a121"][slot]) ? self.pers[#"hash_754e08b82fb3a121"][slot] : 0;
        self function_4051d1c6(slot, endtime);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x24417eaa, Offset: 0xad88
// Size: 0xfc
function function_a831f92c(var_5b220756, duration, var_f63114ce) {
    if (!isdefined(self.pers[#"hash_6ae564fce4d70aff"])) {
        self.pers[#"hash_6ae564fce4d70aff"] = [];
    }
    if (!isdefined(self.pers[#"hash_7b0ebc5ef8a8b896"])) {
        self.pers[#"hash_7b0ebc5ef8a8b896"] = [];
    }
    self.pers[#"hash_6ae564fce4d70aff"][var_5b220756] = duration;
    self function_5249e8b8(var_5b220756, duration);
    self.pers[#"hash_7b0ebc5ef8a8b896"][var_5b220756] = var_f63114ce;
    self function_d5d8e662(var_5b220756, var_f63114ce);
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xd201ae0b, Offset: 0xae90
// Size: 0x84
function function_b3185041(var_5b220756, endtime) {
    if (!isdefined(self.pers[#"hash_754e08b82fb3a121"])) {
        self.pers[#"hash_754e08b82fb3a121"] = [];
    }
    self.pers[#"hash_754e08b82fb3a121"][var_5b220756] = endtime;
    self function_4051d1c6(var_5b220756, endtime);
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x7c75b79d, Offset: 0xaf20
// Size: 0x24
function function_a781e8d2() {
    self clientfield::set("standardTagFxSet", 1);
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x44eb7ad2, Offset: 0xaf50
// Size: 0x24
function function_90e951f2() {
    self clientfield::set("standardTagFxSet", 0);
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0xfc8f8fa8, Offset: 0xaf80
// Size: 0x24
function function_8b4513ca() {
    self clientfield::set("lowHealthTagFxSet", 1);
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0xd496eab, Offset: 0xafb0
// Size: 0x24
function function_7d265bd3() {
    self clientfield::set("deathTagFxSet", 1);
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xdb0d3172, Offset: 0xafe0
// Size: 0x164
function function_ea21be29(killstreaktype, killstreak_weapon, player_died) {
    player = self;
    assert(isdefined(player));
    if (player_died) {
        var_38665394 = player getteam();
        var_27dca80 = player waittill(#"loadout_given", #"disconnect");
        if (var_27dca80._notify !== "loadout_given") {
            return false;
        }
        if (isdefined(player) && var_38665394 !== player getteam()) {
            return false;
        }
    }
    if (isdefined(player)) {
        if (!isdefined(killstreak_weapon)) {
            return false;
        }
        if (player getammocount(killstreak_weapon) > 0) {
            return false;
        }
        var_f66fab06 = player killstreakrules::function_d9f8f32b(killstreaktype);
        player thread killstreakrules::function_9f635a5(var_f66fab06, killstreaktype);
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xe246e046, Offset: 0xb150
// Size: 0x2be
function function_fc82c544(killstreaktype) {
    player = self;
    assert(isplayer(player));
    level thread popups::displaykillstreakteammessagetoall(killstreaktype, self);
    self battlechatter::function_576ff6fe(killstreaktype);
    player disableoffhandweapons();
    result = player waittill(#"weapon_change_complete", #"death", #"disconnect", #"joined_team", #"emp_jammed", #"emp_grenaded");
    if (isdefined(player)) {
        player enableoffhandweapons();
    }
    var_36f4a15 = 0;
    if (result._notify == "weapon_change_complete") {
        if (isdefined(result.weapon)) {
            function_ece736e7(player, result.weapon);
        }
        var_36f4a15 = 1;
        var_66970d93 = 1;
        killstreak_weapon = result.weapon;
        while (var_66970d93) {
            result = player waittill(#"weapon_change", #"death", #"disconnect", #"joined_team", #"emp_jammed", #"emp_grenaded");
            var_66970d93 = isdefined(result.weapon) && result.weapon == killstreak_weapon;
        }
    }
    if ((isdefined(result.last_weapon) || result._notify === "death") && isdefined(player)) {
        var_37b0037 = player function_ea21be29(killstreaktype, killstreak_weapon, result._notify === "death");
        if (!var_37b0037) {
            return 0;
        }
    }
    return var_36f4a15;
}

/#

    // Namespace killstreaks/killstreaks_shared
    // Params 0, eflags: 0x0
    // Checksum 0x4689af9e, Offset: 0xb418
    // Size: 0x2a8
    function debug_ricochet_protection() {
        debug_wait = 0.5;
        debug_frames = int(debug_wait / float(function_60d95f53()) / 1000) + 1;
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
