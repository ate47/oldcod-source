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
// Params 0, eflags: 0x0
// Checksum 0x6a0dbce7, Offset: 0x4b8
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
// Params 0, eflags: 0x0
// Checksum 0x52a399e0, Offset: 0x848
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
// Checksum 0x151fd34d, Offset: 0x8f0
// Size: 0x3c
function function_b5b6ef3e(func, obj) {
    callback::add_callback(#"hash_45f35669076bc317", func, obj);
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x4
// Checksum 0xce284f77, Offset: 0x938
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
// Params 1, eflags: 0x4
// Checksum 0x432faebd, Offset: 0xac0
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
// Params 3, eflags: 0x4
// Checksum 0x9bd62852, Offset: 0xbe0
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
// Params 2, eflags: 0x4
// Checksum 0x54ca0933, Offset: 0xcf8
// Size: 0x8c
function private register_vehicle(killstreak_type, vehicle) {
    assert(isdefined(killstreak_type), "<dev string:x79>");
    assert(!isdefined(level.var_8997324c[vehicle]), "<dev string:xdb>");
    level.killstreaks[killstreak_type].vehicle = vehicle;
    level.var_8997324c[vehicle] = killstreak_type;
}

// Namespace killstreaks/killstreaks_shared
// Params 6, eflags: 0x4
// Checksum 0x482cd1db, Offset: 0xd90
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
    case #"reduced":
        level.killstreaks[type].teamkillpenaltyscale = level.teamkillreducedpenalty;
        break;
    case #"default":
    default:
        level.killstreaks[type].teamkillpenaltyscale = 1;
        break;
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x1d0864a5, Offset: 0x10f8
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
// Params 2, eflags: 0x0
// Checksum 0x2668589d, Offset: 0x1218
// Size: 0x4c
function register_killstreak(bundlename, use_function) {
    bundle = getscriptbundle(bundlename);
    register_bundle(bundle, use_function);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xc4f2be5c, Offset: 0x1270
// Size: 0x5c
function function_94c74046(killstreaktype) {
    assert(isdefined(killstreaktype), "<dev string:x11a>");
    if (!isdefined(level.var_33c629ad)) {
        level.var_33c629ad = [];
    }
    level.var_33c629ad[killstreaktype] = 1;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x7fc6d7cd, Offset: 0x12d8
// Size: 0x1e
function function_6bde02cc(killstreaktype) {
    return isdefined(level.var_33c629ad[killstreaktype]);
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x4
// Checksum 0xd2a62c68, Offset: 0x1300
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
// Checksum 0x8a5e499d, Offset: 0x1408
// Size: 0x4c
function private register_alt_weapon(killstreaktype, weapon) {
    function_181f96a6(killstreaktype, weapon);
    function_181f96a6("inventory_" + killstreaktype, weapon);
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x333cefc6, Offset: 0x1460
// Size: 0x40
function function_b013c2d3(killstreaktype, weapon) {
    if (!isdefined(level.var_3ff1b984)) {
        level.var_3ff1b984 = [];
    }
    level.var_3ff1b984[weapon] = killstreaktype;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xcb087614, Offset: 0x14a8
// Size: 0x40
function function_d8c32ca4(killstreaktype, var_ae755d2f) {
    if (!isdefined(level.var_a385666)) {
        level.var_a385666 = [];
    }
    level.var_a385666[killstreaktype] = var_ae755d2f;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x2863a086, Offset: 0x14f0
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
    // Checksum 0xf8f41e52, Offset: 0x1630
    // Size: 0xbc
    function register_dev_debug_dvar(killstreaktype) {
        assert(isdefined(killstreaktype), "<dev string:x79>");
        assert(isdefined(level.killstreaks[killstreaktype]), "<dev string:x1b3>");
        level.killstreaks[killstreaktype].devdebugdvar = "<dev string:x1fa>" + killstreaktype + "<dev string:x227>";
        devgui_scorestreak_command_debugdvar(killstreaktype, level.killstreaks[killstreaktype].devdebugdvar);
    }

    // Namespace killstreaks/killstreaks_shared
    // Params 1, eflags: 0x0
    // Checksum 0x41f16553, Offset: 0x16f8
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
    // Checksum 0xc516e2dc, Offset: 0x1838
    // Size: 0x4c
    function devgui_scorestreak_command_givedvar(killstreaktype, give_type, dvar) {
        devgui_scorestreak_command(killstreaktype, give_type, "<dev string:x247>" + dvar + "<dev string:x24f>");
    }

    // Namespace killstreaks/killstreaks_shared
    // Params 2, eflags: 0x0
    // Checksum 0x7dd4569a, Offset: 0x1890
    // Size: 0x34
    function devgui_scorestreak_command_timeoutdvar(killstreaktype, dvar) {
        devgui_scorestreak_dvar_toggle(killstreaktype, "<dev string:x255>", dvar);
    }

    // Namespace killstreaks/killstreaks_shared
    // Params 2, eflags: 0x0
    // Checksum 0x29bc851d, Offset: 0x18d0
    // Size: 0x34
    function devgui_scorestreak_command_debugdvar(killstreaktype, dvar) {
        devgui_scorestreak_dvar_toggle(killstreaktype, "<dev string:x261>", dvar);
    }

#/

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x86f0a08c, Offset: 0x1910
// Size: 0x6c
function devgui_scorestreak_dvar_toggle(killstreaktype, title, dvar) {
    setdvar(dvar, 0);
    devgui_scorestreak_command(killstreaktype, "Toggle " + title, "toggle " + dvar + " 1 0");
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x9e75c99c, Offset: 0x1988
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
// Checksum 0xc5908510, Offset: 0x1bd8
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
    // Checksum 0x914e722a, Offset: 0x1c80
    // Size: 0x34
    function function_2459bd2f() {
        assert(isdefined(level.killstreaks), "<dev string:x2c6>");
    }

#/

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x4a9feaeb, Offset: 0x1cc0
// Size: 0x30
function is_available(killstreak) {
    if (isdefined(level.menureferenceforkillstreak[killstreak])) {
        return 1;
    }
    return 0;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x4603b487, Offset: 0x1cf8
// Size: 0x1c
function get_by_menu_name(killstreak) {
    return level.menureferenceforkillstreak[killstreak];
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xc47a46b9, Offset: 0x1d20
// Size: 0x4a
function get_menu_name(killstreaktype) {
    assert(isdefined(level.killstreaks[killstreaktype]));
    return level.killstreaks[killstreaktype].menuname;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xd87a714, Offset: 0x1d78
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
// Params 3, eflags: 0x0
// Checksum 0x492699a6, Offset: 0x1ea0
// Size: 0x218
function give_if_streak_count_matches(index, killstreak, streakcount) {
    pixbeginevent(#"");
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
            profilestop();
            return true;
        }
    }
    profilestop();
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x40db24f, Offset: 0x20c8
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
// Params 5, eflags: 0x0
// Checksum 0x1490d070, Offset: 0x2190
// Size: 0x15a
function give(killstreaktype, streak, *suppressnotification, noxp, tobottom) {
    pixbeginevent(#"");
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
    profilestop();
    return killstreakgiven;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x9453706b, Offset: 0x22f8
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
// Params 0, eflags: 0x0
// Checksum 0x75754fec, Offset: 0x23f8
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
// Checksum 0x463053fd, Offset: 0x2578
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
// Params 5, eflags: 0x0
// Checksum 0x12f58d9b, Offset: 0x2e70
// Size: 0x164
function add_to_notification_queue(menuname, *streakcount, hardpointtype, nonotify, var_af825242) {
    killstreaktablenumber = level.killstreakindices[streakcount];
    if (!isdefined(killstreaktablenumber)) {
        return;
    }
    if (is_true(nonotify)) {
        return;
    }
    informdialog = namespace_f9b02f80::get_killstreak_inform_dialog(hardpointtype);
    killstreakslot = function_a2c375bb(hardpointtype);
    self thread namespace_f9b02f80::play_killstreak_ready_dialog(hardpointtype, 2.4);
    self thread play_killstreak_ready_sfx(hardpointtype);
    self luinotifyevent(#"killstreak_received", 3, killstreaktablenumber, informdialog, var_af825242);
    self function_8ba40d2f(#"killstreak_received", 3, killstreaktablenumber, informdialog, var_af825242);
    if (isdefined(killstreakslot)) {
        self function_6bf621ea(#"hash_6a9cb800ad0ef395", 2, self.clientid, killstreakslot);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0xe223a42a, Offset: 0x2fe0
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
// Params 1, eflags: 0x0
// Checksum 0x7a9e3bb4, Offset: 0x3098
// Size: 0x22
function _get_from_weapon(weapon) {
    return get_killstreak_for_weapon(weapon);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xf0b0a757, Offset: 0x30c8
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
// Params 1, eflags: 0x4
// Checksum 0x6f516d0f, Offset: 0x3148
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
// Params 2, eflags: 0x0
// Checksum 0xfbc75da7, Offset: 0x32a0
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
// Params 1, eflags: 0x0
// Checksum 0x6745db6, Offset: 0x3758
// Size: 0x248
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
    if (weapon.iscarriedkillstreak && !is_true(level.var_174c7c61)) {
        self function_fa6e0467(weapon);
    }
    if (!isdefined(do_not_update_death_count) || do_not_update_death_count != 0) {
        self.pers["killstreakItemDeathCount" + killstreaktype] = self.deathcount;
    }
    return true;
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x924aeb04, Offset: 0x39a8
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
// Params 1, eflags: 0x0
// Checksum 0x3ec5abda, Offset: 0x3bc0
// Size: 0x74
function get_killstreak_quantity(killstreakweapon) {
    if (!isdefined(self.pers[#"killstreak_quantity"])) {
        return 0;
    }
    return isdefined(self.pers[#"killstreak_quantity"][killstreakweapon]) ? self.pers[#"killstreak_quantity"][killstreakweapon] : 0;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x8c843169, Offset: 0x3c40
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
// Params 1, eflags: 0x0
// Checksum 0x25e0ae74, Offset: 0x3e80
// Size: 0x110
function function_1f96e8f8(killstreakweapon) {
    quantity = get_killstreak_quantity(killstreakweapon);
    if (quantity > level.scorestreaksmaxstacking) {
        quantity = level.scorestreaksmaxstacking;
    }
    if (self hasweapon(killstreakweapon) == 0 && !is_false(level.var_e2636f91)) {
        self takeweapon(killstreakweapon);
        self giveweapon(killstreakweapon);
        self seteverhadweaponall(1);
    }
    if (self hasweapon(killstreakweapon)) {
        self setweaponammoclip(killstreakweapon, quantity);
    }
    return quantity;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x94685b25, Offset: 0x3f98
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
// Checksum 0xf70a7fd7, Offset: 0x4030
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
// Params 2, eflags: 0x0
// Checksum 0xdc86c51e, Offset: 0x40e8
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
// Params 3, eflags: 0x0
// Checksum 0xc8332912, Offset: 0x4278
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
    if (killstreak_weapon.isgestureweapon) {
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
// Params 2, eflags: 0x0
// Checksum 0xacdfd46a, Offset: 0x45d8
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
// Params 2, eflags: 0x0
// Checksum 0xe2bf65c5, Offset: 0x49b0
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
// Checksum 0x8d2a2229, Offset: 0x4a60
// Size: 0x64
function function_2ea0382e() {
    self.pers[#"killstreaks"] = [];
    self.pers[#"killstreak_has_been_used"] = [];
    self.pers[#"killstreak_unique_id"] = [];
    self.pers[#"killstreak_ammo_count"] = [];
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x342991e4, Offset: 0x4ad0
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
// Params 1, eflags: 0x0
// Checksum 0xc4e1c1f8, Offset: 0x4ea0
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
// Params 0, eflags: 0x0
// Checksum 0x4b19b206, Offset: 0x4f50
// Size: 0x66
function get_top_killstreak() {
    if (self.pers[#"killstreaks"].size == 0) {
        return undefined;
    }
    return self.pers[#"killstreaks"][self.pers[#"killstreaks"].size - 1];
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x854a496c, Offset: 0x4fc0
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
// Checksum 0xb8c408cc, Offset: 0x5048
// Size: 0x66
function get_top_killstreak_unique_id() {
    if (self.pers[#"killstreak_unique_id"].size == 0) {
        return undefined;
    }
    return self.pers[#"killstreak_unique_id"][self.pers[#"killstreak_unique_id"].size - 1];
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x64b5e562, Offset: 0x50b8
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
// Params 1, eflags: 0x0
// Checksum 0x8585ed94, Offset: 0x5138
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
// Checksum 0x203fe519, Offset: 0x51d8
// Size: 0x222
function function_4f415d8e(params) {
    if (game.state == #"postgame" || !isdefined(self)) {
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
// Params 1, eflags: 0x0
// Checksum 0xd26c45d4, Offset: 0x5408
// Size: 0x3bc
function function_4167ea4e(params) {
    weapon = params.weapon;
    if (self isonladder()) {
        lastweapon = params.last_weapon;
        if (isdefined(lastweapon) && is_killstreak_weapon(lastweapon) && lastweapon.iscarriedkillstreak) {
        } else if (is_killstreak_weapon(weapon) || weapon === level.weaponnone) {
            self switch_to_last_non_killstreak_weapon();
            return;
        }
    }
    if (self isinvehicle()) {
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
// Params 1, eflags: 0x0
// Checksum 0x5792ca4e, Offset: 0x57d0
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
// Params 1, eflags: 0x0
// Checksum 0x647b471b, Offset: 0x58b0
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
// Params 1, eflags: 0x0
// Checksum 0x35120004, Offset: 0x5968
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
// Checksum 0xdfe3ade9, Offset: 0x5a58
// Size: 0x50
function is_delayable_killstreak(killstreaktype) {
    if (isdefined(level.killstreaks[killstreaktype]) && is_true(level.killstreaks[killstreaktype].delaystreak)) {
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x7ebf2217, Offset: 0x5ab0
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
// Checksum 0x1e95d9bd, Offset: 0x5b78
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
// Checksum 0xbc0a9249, Offset: 0x5d70
// Size: 0x5e
function add_to_killstreak_count(*weapon) {
    if (!isdefined(self.pers[#"totalkillstreakcount"])) {
        self.pers[#"totalkillstreakcount"] = 0;
    }
    self.pers[#"totalkillstreakcount"]++;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xc9a8f339, Offset: 0x5dd8
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
// Params 1, eflags: 0x0
// Checksum 0x25eb7d55, Offset: 0x5e88
// Size: 0xa4
function play_killstreak_ready_sfx(killstreaktype) {
    if (game.state != #"playing") {
        return;
    }
    if (isdefined(level.killstreaks[killstreaktype].script_bundle.var_c08f7089)) {
        self playsoundtoplayer(level.killstreaks[killstreaktype].script_bundle.var_c08f7089, self);
        return;
    }
    self playsoundtoplayer("uin_kls_generic", self);
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x24ac3392, Offset: 0x5f38
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
// Params 2, eflags: 0x0
// Checksum 0xc9c72649, Offset: 0x62b0
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
// Params 1, eflags: 0x0
// Checksum 0x8e893a6d, Offset: 0x64c8
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
// Checksum 0xc6025735, Offset: 0x6528
// Size: 0x30
function get_killstreak_usage(usagekey) {
    if (!isdefined(self.pers[usagekey])) {
        return 0;
    }
    return self.pers[usagekey];
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0xb1fb11e8, Offset: 0x6560
// Size: 0xde
function on_player_spawned() {
    pixbeginevent(#"");
    self thread give_owned();
    self.killcamkilledbyent = undefined;
    self callback::on_weapon_change(&function_4f415d8e);
    self callback::on_weapon_change(&function_4167ea4e);
    self callback::on_grenade_fired(&on_grenade_fired);
    self callback::on_offhand_fire(&on_offhand_fire);
    self thread initialspawnprotection();
    self function_f964dc1c();
    profilestop();
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x2d7e7624, Offset: 0x6648
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
// Params 0, eflags: 0x4
// Checksum 0x6f17bb3c, Offset: 0x67b0
// Size: 0x15c
function private initialspawnprotection() {
    self endon(#"death", #"disconnect");
    if (isdefined(level.var_f81eb032) && isdefined(level.var_f81eb032.var_176dc082)) {
        self thread [[ level.var_f81eb032.var_176dc082 ]](level.spawnsystem.var_d9984264);
    }
    if (level.spawnsystem.var_d9984264 == 0) {
        return;
    }
    self.specialty_nottargetedbyairsupport = 1;
    self clientfield::set("killstreak_spawn_protection", 1);
    self val::set(#"killstreak_spawn_protection", "ignoreme", 1);
    wait level.spawnsystem.var_d9984264;
    self clientfield::set("killstreak_spawn_protection", 0);
    self.specialty_nottargetedbyairsupport = undefined;
    self val::reset(#"killstreak_spawn_protection", "ignoreme");
}

/#

    // Namespace killstreaks/killstreaks_shared
    // Params 0, eflags: 0x0
    // Checksum 0x916e7579, Offset: 0x6918
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
    // Checksum 0xb92f3165, Offset: 0x6a00
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
// Params 4, eflags: 0x0
// Checksum 0xd4e13302, Offset: 0x6d38
// Size: 0x94
function function_2b6aa9e8(killstreak_ref, destroyed_callback, low_health_callback, emp_callback) {
    self setcandamage(1);
    self thread monitordamage(killstreak_ref, killstreak_bundles::get_max_health(killstreak_ref), destroyed_callback, killstreak_bundles::get_low_health(killstreak_ref), low_health_callback, 0, emp_callback, 1);
}

// Namespace killstreaks/killstreaks_shared
// Params 8, eflags: 0x0
// Checksum 0x999176a, Offset: 0x6dd8
// Size: 0x962
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
                var_e7344d41 = attacker;
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
            if (isdefined(var_e7344d41.var_307aef8d)) {
                var_e7344d41 [[ var_e7344d41.var_307aef8d ]](self);
            }
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
                    if (lengthsquared(var_74d40edb) > sqr(50)) {
                        var_29edfc10 = vectornormalize(var_74d40edb);
                        playfx(bundle.var_888a5ff7, waitresult.position, var_29edfc10, undefined, undefined, self.team);
                    }
                }
            }
            self function_73566ec7(attacker, weapon, self.owner);
            self.var_d02ddb8e = weapon;
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
// Params 3, eflags: 0x0
// Checksum 0xdf13e75d, Offset: 0x7748
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
// Params 15, eflags: 0x0
// Checksum 0xab47a482, Offset: 0x7af0
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
// Params 6, eflags: 0x0
// Checksum 0xe848c921, Offset: 0x7ec0
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
// Params 1, eflags: 0x0
// Checksum 0x1648fcc8, Offset: 0x8100
// Size: 0x24
function isheldinventorykillstreakweapon(killstreakweapon) {
    return killstreakweapon.iscarriedkillstreak && killstreakweapon.var_6f41c2a9;
}

// Namespace killstreaks/killstreaks_shared
// Params 5, eflags: 0x0
// Checksum 0x7cc99122, Offset: 0x8130
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
// Checksum 0x978e595a, Offset: 0x81e8
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
// Checksum 0xf03552d, Offset: 0x8270
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
// Checksum 0xd0650dd4, Offset: 0x82e8
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
// Params 0, eflags: 0x0
// Checksum 0xea467706, Offset: 0x83b0
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
// Checksum 0x84f7d5ef, Offset: 0x8410
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
// Params 0, eflags: 0x0
// Checksum 0x58ccf393, Offset: 0x8558
// Size: 0xe
function reset_killstreak_delay_killcam() {
    self.killstreak_delay_killcam = undefined;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xc2558def, Offset: 0x8570
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
// Params 2, eflags: 0x4
// Checksum 0xf79ddea2, Offset: 0x85f0
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
// Params 1, eflags: 0x4
// Checksum 0xcf2a8b92, Offset: 0x8a48
// Size: 0x44
function private clear_ride_intro(delay) {
    self endon(#"disconnect");
    if (isdefined(delay)) {
        wait delay;
    }
    self thread hud::screen_fade_in(0);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x48649129, Offset: 0x8a98
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
// Params 0, eflags: 0x0
// Checksum 0x27e3e6b8, Offset: 0x8b00
// Size: 0x2c
function function_50b430e0() {
    self clientfield::set_to_player("" + #"hash_524d30f5676b2070", 0);
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0xf62867f, Offset: 0x8b38
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
// Params 3, eflags: 0x0
// Checksum 0x1af53b90, Offset: 0x8ba8
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
// Checksum 0xedbb4f10, Offset: 0x8ca0
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
// Params 19, eflags: 0x0
// Checksum 0x66a1a0f, Offset: 0x8d60
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
// Params 4, eflags: 0x0
// Checksum 0xac2bf576, Offset: 0x8ee8
// Size: 0x7c
function function_84da1341(*damagecallback, destroyedcallback, var_1891d3cd, var_2053fdc6) {
    waitframe(1);
    placeable = self;
    if (isdefined(level.var_8ddb1b0e)) {
        placeable thread [[ level.var_8ddb1b0e ]](placeable.killstreakref, placeable.health, destroyedcallback, 0, undefined, var_1891d3cd, var_2053fdc6, 1);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x0
// Checksum 0xd3036344, Offset: 0x8f70
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
// Params 2, eflags: 0x0
// Checksum 0x76f535ee, Offset: 0x9038
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
// Params 3, eflags: 0x4
// Checksum 0x669036a9, Offset: 0x9228
// Size: 0x5a
function private _setup_configure_team_callbacks(influencertype, configureteamprefunction, configureteampostfunction) {
    killstreak = self;
    killstreak.killstreakteamconfigured = 1;
    killstreak.killstreakinfluencertype = influencertype;
    killstreak.killstreakconfigureteamprefunction = configureteamprefunction;
    killstreak.killstreakconfigureteampostfunction = configureteampostfunction;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x6b862cf1, Offset: 0x9290
// Size: 0x1b6
function trackactivekillstreak(killstreak) {
    killstreakindex = killstreak.killstreakid;
    if (isdefined(self) && isdefined(self.pers) && isdefined(killstreakindex)) {
        self endon(#"disconnect");
        self.pers[#"activekillstreaks"][killstreakindex] = killstreak;
        killstreakslot = function_a2c375bb(killstreak.killstreaktype);
        if (isdefined(killstreakslot)) {
            killstreak.killstreakslot = killstreakslot;
            self clientfield::set_player_uimodel(level.var_4b42d599[killstreakslot], 1);
            self function_6bf621ea(#"hash_1d8e470838fb6dd3", 2, self.clientid, killstreakslot);
        }
        killstreak waittill(#"killstreak_hacked", #"death");
        if (isdefined(self)) {
            if (isdefined(killstreakslot)) {
                self clientfield::set_player_uimodel(level.var_4b42d599[killstreakslot], 0);
                self function_6bf621ea(#"hash_2e64558432f8b5b2", 2, self.clientid, killstreakslot);
            }
            self.pers[#"activekillstreaks"][killstreakindex] = undefined;
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 4, eflags: 0x0
// Checksum 0x722e5973, Offset: 0x9450
// Size: 0x50
function processscoreevent(event, player, victim, weapon) {
    if (isdefined(level.var_19a15e42)) {
        [[ level.var_19a15e42 ]](event, player, victim, weapon);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xe1b2af75, Offset: 0x94a8
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
// Params 1, eflags: 0x0
// Checksum 0x2634c5e8, Offset: 0x9708
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
// Params 1, eflags: 0x0
// Checksum 0xb3d6af82, Offset: 0x97d8
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
// Params 1, eflags: 0x0
// Checksum 0xa1ddd998, Offset: 0x99a0
// Size: 0xa6
function update_dog_threat(dog) {
    heli = self;
    dog.threatlevel = 0;
    dist = distance(dog.origin, heli.origin);
    var_b90cd297 = isdefined(self.var_fc0dee44) ? self.var_fc0dee44 : level.heli_visual_range;
    dog.threatlevel += (var_b90cd297 - dist) / var_b90cd297 * 100;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x749f5d9a, Offset: 0x9a50
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
// Checksum 0xb9fb74bd, Offset: 0x9b10
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
// Params 1, eflags: 0x0
// Checksum 0x495d7b93, Offset: 0x9c68
// Size: 0x1a
function update_missile_dog_threat(dog) {
    dog.missilethreatlevel = 1;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x7338c894, Offset: 0x9c90
// Size: 0x1a
function function_6d23c51c(dog) {
    dog.missilethreatlevel = 2;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xf6ba1e3d, Offset: 0x9cb8
// Size: 0xa8
function function_fff56140(owner, var_4a025683) {
    self notify(#"hash_4363bc1bae999ad3");
    self endon(#"hash_4363bc1bae999ad3", #"death");
    res = owner waittill(#"joined_team", #"disconnect", #"joined_spectators", #"changed_specialist");
    [[ var_4a025683 ]]();
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x73c3af2d, Offset: 0x9d68
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
// Params 6, eflags: 0x0
// Checksum 0x4acde5a, Offset: 0x9e48
// Size: 0x54
function waitfortimeout(killstreak, duration, callback, endcondition1, endcondition2, endcondition3) {
    function_b86397ae(killstreak, duration, undefined, callback, endcondition1, endcondition2, endcondition3);
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x0
// Checksum 0x9c22a59a, Offset: 0x9ea8
// Size: 0x334
function function_b86397ae(killstreak, duration, starttimeoverride, callback, endcondition1, endcondition2, endcondition3) {
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
    if (isdefined(starttimeoverride)) {
        self.killstreakendtime = starttimeoverride + duration;
        waittime = self.killstreakendtime - gettime();
    } else {
        self.killstreakendtime = gettime() + duration;
        waittime = duration;
    }
    waittime = max(waittime, 0);
    if (isdefined(self.owner) && isplayer(self.owner) && isdefined(self.killstreakslot) && self.var_ec8ef668 !== 1) {
        self.owner function_a831f92c(self.killstreakslot, int(ceil(float(duration) / 1000)), 0);
        self.owner function_b3185041(self.killstreakslot, self.killstreakendtime);
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
    if (isdefined(self.owner) && isplayer(self.owner) && isdefined(self.killstreakslot)) {
        self.owner function_b3185041(self.killstreakslot, 0);
    }
    self notify(#"timed_out");
    if (isdefined(self)) {
        self [[ callback ]]();
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x95ceba23, Offset: 0xa1e8
// Size: 0x3c
function function_b00e94e0(killstreakbundle, duration) {
    self waitfortimeoutbeep(killstreakbundle.kstimeoutbeepduration, killstreakbundle.kstimeoutfastbeepduration, duration);
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xfebc5a84, Offset: 0xa230
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
// Params 0, eflags: 0x0
// Checksum 0xe0f8d594, Offset: 0xa3c0
// Size: 0x44
function function_67bc25ec() {
    if (isdefined(self) && isvehicle(self)) {
        self clientfield::set("timeout_beep", 0);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 5, eflags: 0x0
// Checksum 0x5fef0858, Offset: 0xa410
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
// Checksum 0x59dd38dd, Offset: 0xa510
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
// Params 1, eflags: 0x0
// Checksum 0xc95d4fee, Offset: 0xa590
// Size: 0x1a
function set_killstreak_delay_killcam(killstreak_name) {
    self.killstreak_delay_killcam = killstreak_name;
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x89f40b74, Offset: 0xa5b8
// Size: 0x1c
function getactivekillstreaks() {
    return self.pers[#"activekillstreaks"];
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x48b6646c, Offset: 0xa5e0
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
// Checksum 0x192cd677, Offset: 0xa630
// Size: 0xaa
function watchteamchange(teamchangenotify) {
    self notify("34546c545e72bda3");
    self endon("34546c545e72bda3");
    killstreak = self;
    killstreak endon(#"death", teamchangenotify);
    killstreak.owner waittill(#"joined_team", #"disconnect", #"joined_spectators", #"emp_jammed");
    killstreak notify(teamchangenotify);
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x80bb587b, Offset: 0xa6e8
// Size: 0x3c
function killstreak_assist(victim, assister, killstreak) {
    victim recordkillstreakassist(victim, assister, killstreak);
}

// Namespace killstreaks/killstreaks_shared
// Params 4, eflags: 0x0
// Checksum 0x38b50b2b, Offset: 0xa730
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
    owner.ricochet_protection[killstreak_id].distancesq = sqr(ricochet_distance);
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x986c7bc0, Offset: 0xa858
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
// Checksum 0x1e831ad5, Offset: 0xa8d8
// Size: 0x4c
function remove_ricochet_protection(killstreak_id, owner) {
    if (!isdefined(owner) || !isdefined(owner.ricochet_protection) || !isdefined(killstreak_id)) {
        return;
    }
    owner.ricochet_protection[killstreak_id] = undefined;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xda010a2d, Offset: 0xa930
// Size: 0x24
function thermal_glow(enable) {
    clientfield::set_to_player("thermal_glow", enable);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xf466b586, Offset: 0xa960
// Size: 0x24
function thermal_glow_enemies_only(enable) {
    clientfield::set_to_player("thermal_glow_enemies_only", enable);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x4dc797f2, Offset: 0xa990
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
// Params 1, eflags: 0x0
// Checksum 0x5ac57acc, Offset: 0xaaa0
// Size: 0x3a
function get_script_bundle(type) {
    if (!isdefined(level.killstreaks[type])) {
        return undefined;
    }
    return level.killstreaks[type].script_bundle;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xf556e768, Offset: 0xaae8
// Size: 0x44
function function_e2c3bda3(killstreaktype, var_dee4d012) {
    bundle_name = level.var_8c83a621[killstreaktype];
    if (!isdefined(bundle_name)) {
        bundle_name = var_dee4d012;
    }
    return bundle_name;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x28a3dc9a, Offset: 0xab38
// Size: 0x40
function function_8c83a621(killstreaktype, bundle_name) {
    if (!isdefined(level.var_8c83a621)) {
        level.var_8c83a621 = [];
    }
    level.var_8c83a621[killstreaktype] = bundle_name;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x5c75e77c, Offset: 0xab80
// Size: 0x40
function function_257a5f13(killstreaktype, var_ba5a6782) {
    if (!isdefined(level.var_257a5f13)) {
        level.var_257a5f13 = [];
    }
    level.var_257a5f13[killstreaktype] = var_ba5a6782;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x1a7f7413, Offset: 0xabc8
// Size: 0x184
function function_b182645e(player, hardpointtype) {
    if (isdefined(level.var_257a5f13[hardpointtype])) {
        killstreakslot = 3;
        var_1abcfdda = getarraykeys(player.killstreak);
        foreach (key in var_1abcfdda) {
            if (!isdefined(player.killstreak[key])) {
                continue;
            }
            if (player.killstreak[key] == hardpointtype) {
                killstreakslot = key;
                break;
            }
        }
        duration = level.var_257a5f13[hardpointtype];
        player function_a831f92c(killstreakslot, duration, 0);
        self.killstreakendtime = gettime() + int(duration * 1000);
        player function_b3185041(killstreakslot, self.killstreakendtime);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x1e3857b5, Offset: 0xad58
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
// Params 3, eflags: 0x0
// Checksum 0x213fb379, Offset: 0xaec8
// Size: 0xfc
function function_a831f92c(killstreakslot, duration, var_f63114ce) {
    if (!isdefined(self.pers[#"hash_6ae564fce4d70aff"])) {
        self.pers[#"hash_6ae564fce4d70aff"] = [];
    }
    if (!isdefined(self.pers[#"hash_7b0ebc5ef8a8b896"])) {
        self.pers[#"hash_7b0ebc5ef8a8b896"] = [];
    }
    self.pers[#"hash_6ae564fce4d70aff"][killstreakslot] = duration;
    self function_5249e8b8(killstreakslot, duration);
    self.pers[#"hash_7b0ebc5ef8a8b896"][killstreakslot] = var_f63114ce;
    self function_d5d8e662(killstreakslot, var_f63114ce);
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x21a4496f, Offset: 0xafd0
// Size: 0x84
function function_b3185041(killstreakslot, endtime) {
    if (!isdefined(self.pers[#"hash_754e08b82fb3a121"])) {
        self.pers[#"hash_754e08b82fb3a121"] = [];
    }
    self.pers[#"hash_754e08b82fb3a121"][killstreakslot] = endtime;
    self function_4051d1c6(killstreakslot, endtime);
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x3233af19, Offset: 0xb060
// Size: 0x24
function function_a781e8d2() {
    self clientfield::set("standardTagFxSet", 1);
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x2ddb1734, Offset: 0xb090
// Size: 0x24
function function_90e951f2() {
    self clientfield::set("standardTagFxSet", 0);
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0xacee00ea, Offset: 0xb0c0
// Size: 0x24
function function_8b4513ca() {
    self clientfield::set("lowHealthTagFxSet", 1);
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0xcd80e05, Offset: 0xb0f0
// Size: 0x24
function function_7d265bd3() {
    self clientfield::set("deathTagFxSet", 1);
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0x210663cc, Offset: 0xb120
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
// Params 1, eflags: 0x4
// Checksum 0x60a3d24e, Offset: 0xb290
// Size: 0x10c
function private function_119fdfcd(killstreaktype) {
    player = self;
    if (!isplayer(player)) {
        assert(isplayer(player));
        return;
    }
    if (!isdefined(player.var_d01e44d1)) {
        player.var_d01e44d1 = [];
    }
    var_4dd65320 = player.var_d01e44d1[killstreaktype];
    if (!isdefined(var_4dd65320) || var_4dd65320 + int(20 * 1000) < gettime()) {
        level thread popups::displaykillstreakteammessagetoall(killstreaktype, self);
        self battlechatter::function_576ff6fe(killstreaktype);
        player.var_d01e44d1[killstreaktype] = gettime();
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x7c7b0b3, Offset: 0xb3a8
// Size: 0x478
function function_fc82c544(killstreaktype) {
    player = self;
    assert(isplayer(player));
    function_119fdfcd(killstreaktype);
    player disableoffhandweapons();
    result = player waittill(#"weapon_change_complete", #"death", #"disconnect", #"joined_team", #"emp_jammed", #"emp_grenaded");
    if (isdefined(player)) {
        player enableoffhandweapons();
    }
    var_36f4a15 = 0;
    var_64df9ac6 = gettime();
    if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
        player function_eb52ba7(killstreaktype, player getteam(), -1);
    }
    if (result._notify == "weapon_change_complete") {
        if (isdefined(result.weapon)) {
            function_ece736e7(player, result.weapon);
        }
        var_36f4a15 = 1;
        var_66970d93 = 1;
        killstreak_weapon = result.weapon;
        while (var_66970d93) {
            result = player waittill(#"weapon_change", #"death", #"disconnect", #"joined_team", #"emp_jammed", #"emp_grenaded");
            var_66970d93 = result._notify != "death" && isdefined(result.weapon) && result.weapon == killstreak_weapon;
        }
    }
    if (result._notify === #"death" && isdefined(player) && isplayer(result.attacker)) {
        if (isdefined(level.var_1d971504)) {
            [[ level.var_1d971504 ]](result.attacker, player, killstreak_weapon);
        }
    }
    if ((isdefined(result.last_weapon) || result._notify === #"death") && isdefined(player)) {
        var_37b0037 = player function_ea21be29(killstreaktype, killstreak_weapon, result._notify === "death");
        if (!var_37b0037) {
            return 0;
        }
        if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
            mpkillstreakuses = {#starttime:var_64df9ac6, #endtime:gettime(), #spawnid:-1, #name:killstreaktype, #team:player getteam()};
            function_92d1707f(#"hash_710b205b26e46446", mpkillstreakuses);
            player function_fda235cf(killstreaktype, -1);
        }
    }
    return var_36f4a15;
}

/#

    // Namespace killstreaks/killstreaks_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc3fd17e5, Offset: 0xb828
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
