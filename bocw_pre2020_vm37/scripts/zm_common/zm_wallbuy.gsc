#using script_340a2e805e35f7a2;
#using script_471b31bd963b388e;
#using script_7fc996fe8678852;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_contracts;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_wallbuy;

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x6
// Checksum 0x650c9af7, Offset: 0x410
// Size: 0xa4
function private autoexec __init__system__() {
    system::register(#"zm_wallbuy", &function_70a657d8, &postinit, undefined, array(#"zm", #"zm_zonemgr", #"zm_unitrigger", #"zm_weapons", #"hash_5bcba15330839867"));
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x5 linked
// Checksum 0x149961dc, Offset: 0x4c0
// Size: 0x15c
function private function_70a657d8() {
    if (!zm_custom::function_901b751c(#"zmwallbuysenabled")) {
        a_outlines = getentarray("wallbuy_outline", "targetname");
        foreach (e_outline in a_outlines) {
            e_outline delete();
        }
        return;
    }
    clientfield::register("scriptmover", "wallbuy_ambient_fx", 1, 3, "int");
    clientfield::register("scriptmover", "wallbuy_reveal_fx", 1, 1, "int");
    namespace_8b6a9d79::function_b3464a7c("wallbuy", &function_d77fb9ee);
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x5 linked
// Checksum 0x2611f85a, Offset: 0x628
// Size: 0xdc
function private postinit() {
    if (!getgametypesetting(#"zmwallbuysenabled")) {
        return;
    }
    var_f5ae494f = struct::get_array(#"content_destination", "variantname");
    if (!isdefined(var_f5ae494f) || var_f5ae494f.size <= 0) {
        thread init_spawnable_weapon_upgrade();
        return;
    }
    if (!zm_utility::is_survival() && isdefined(var_f5ae494f) && var_f5ae494f.size > 0) {
        level thread function_669a830(var_f5ae494f[0]);
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x1 linked
// Checksum 0x386ba5ea, Offset: 0x710
// Size: 0x1f4
function function_8183be86() {
    var_b48509f9 = zm_utility::function_e3025ca5();
    n_roll = randomint(100);
    var_df3ef88a = 2 * var_b48509f9;
    var_ce91127 = 4 * var_b48509f9;
    var_2081b742 = 8 * var_b48509f9;
    var_990f9df7 = 16 * var_b48509f9;
    var_df3ef88a = math::clamp(var_df3ef88a, 0, 100);
    var_ce91127 = math::clamp(var_ce91127, 0, 100);
    var_2081b742 = math::clamp(var_2081b742, 0, 100);
    var_990f9df7 = math::clamp(var_990f9df7, 0, 100);
    var_8ec9324e = 100 - var_df3ef88a;
    var_7d403093 = 100 - var_ce91127;
    var_83ed455f = 100 - var_2081b742;
    var_31890740 = 100 - var_990f9df7;
    if (n_roll >= var_8ec9324e) {
        return #"orange";
    }
    if (n_roll >= var_7d403093) {
        return #"purple";
    }
    if (n_roll >= var_83ed455f) {
        return #"blue";
    }
    if (n_roll >= var_31890740) {
        return #"green";
    }
    return #"white";
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 8, eflags: 0x1 linked
// Checksum 0x6d86adc9, Offset: 0x910
// Size: 0x24c
function function_a1a1d2(weapon_name, var_e9040287, item_name, chalk_model, index, var_492e21a0, var_58bd64f1, var_13f9dee7) {
    weapon = getweapon(weapon_name);
    hint = #"hash_6ee6f17a7c9eb226";
    cost = zm_weapons::get_weapon_cost(weapon);
    cost += zm_weapons::function_5d47055e(var_13f9dee7);
    chalk_model = self namespace_8b6a9d79::spawn_script_model(self, chalk_model);
    trigger = self namespace_8b6a9d79::function_214737c7(self, &function_ab0340bb, hint, weapon.displayname, undefined, undefined, undefined, undefined, cost);
    trigger.weapon = weapon;
    trigger.cost = cost;
    trigger.var_9f32a5f4 = 1;
    trigger.item_name = item_name;
    tempmodel = var_e9040287 namespace_8b6a9d79::spawn_script_model(var_e9040287, weapon.worldmodel);
    tempmodel useweaponmodel(weapon);
    if (isdefined(var_e9040287.var_3474efbf)) {
        var_e27c9160 = tempmodel worldtolocalcoords(tempmodel.origin);
        var_e27c9160 = (var_e27c9160[0] + var_492e21a0, var_e27c9160[1], var_e27c9160[2] + var_58bd64f1);
        tempmodel.origin = tempmodel localtoworldcoords(var_e27c9160);
    }
    tempmodel hide();
    tempmodel.targetname = "wallbuy_weapon" + index;
    trigger.target = tempmodel.targetname;
    trigger thread weapon_spawn_think();
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x1 linked
// Checksum 0x22ff917e, Offset: 0xb68
// Size: 0xc
function function_ab0340bb(*var_71f7928d) {
    
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x1 linked
// Checksum 0xd40782e1, Offset: 0xb80
// Size: 0x334
function function_d77fb9ee(s_instance) {
    if (!getgametypesetting(#"zmwallbuysenabled")) {
        return;
    }
    wallbuys = s_instance.var_fe2612fe[#"wallbuy_chalk"];
    count = 0;
    foreach (wallbuy in wallbuys) {
        weapon_name = wallbuy.script_noteworthy;
        var_e9040287 = wallbuy.var_fe2612fe[#"hash_79425207763b7a66"][0];
        if (zm_utility::is_survival()) {
            rarity = function_8183be86();
        } else {
            rarity = isdefined(wallbuy.script_string) ? wallbuy.script_string : "white";
        }
        item_name = level.var_29d88fe5[weapon_name][rarity];
        var_2c9ef3be = function_d26435e4(wallbuy, rarity);
        var_492e21a0 = 0;
        var_de5dab41 = 0;
        switch (weapon_name) {
        case #"knife_loadout":
            break;
        case #"ar_accurate_t9":
            break;
        case #"ar_standard_t9":
            break;
        case #"launcher_standard_t9":
            break;
        case #"pistol_burst_t9":
            break;
        case #"pistol_semiauto_t9":
            break;
        case #"shotgun_pump_t9":
            break;
        case #"shotgun_semiauto_t9":
            break;
        case #"smg_standard_t9":
            var_492e21a0 = -0.1;
            break;
        case #"smg_heavy_t9":
            break;
        case #"tr_damagesemi_t9":
            var_492e21a0 = -0.2;
            break;
        case #"tr_longburst_t9":
            var_492e21a0 = -0.13;
            break;
        case #"sniper_standard_t9":
            break;
        case #"sniper_quickscope_t9":
            break;
        }
        wallbuy function_a1a1d2(weapon_name, var_e9040287, item_name, var_2c9ef3be, count, var_492e21a0, var_de5dab41, rarity);
        count++;
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x1 linked
// Checksum 0xdf416907, Offset: 0xec0
// Size: 0x64
function function_669a830(s_destination) {
    if (!getgametypesetting(#"zmwallbuysenabled")) {
        return;
    }
    level flag::wait_till("start_zombie_round_logic");
    waittillframeend();
    init_spawnable_weapon_upgrade(s_destination);
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x0
// Checksum 0xf23ccf5a, Offset: 0xf30
// Size: 0x1bc
function init_weapon_upgrade() {
    weapon_spawns = [];
    weapon_spawns = getentarray("weapon_upgrade", "targetname");
    for (i = 0; i < weapon_spawns.size; i++) {
        weapon_spawns[i].weapon = getweapon(weapon_spawns[i].zombie_weapon_upgrade);
        hint_string = zm_weapons::get_weapon_hint(weapon_spawns[i].weapon);
        cost = zm_weapons::get_weapon_cost(weapon_spawns[i].weapon);
        weapon_spawns[i] sethintstring(hint_string);
        weapon_spawns[i] setcursorhint("HINT_NOICON");
        weapon_spawns[i] usetriggerrequirelookat();
        weapon_spawns[i] thread weapon_spawn_think();
        model = getent(weapon_spawns[i].target, "targetname");
        if (isdefined(model)) {
            model useweaponhidetags(weapon_spawns[i].weapon);
            model hide();
        }
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x1 linked
// Checksum 0x9a8a5fab, Offset: 0x10f8
// Size: 0xdb4
function init_spawnable_weapon_upgrade(s_destination) {
    if (isdefined(s_destination)) {
        foreach (s_location in s_destination.locations) {
            if (namespace_8b6a9d79::function_fe9fb6fd(s_location)) {
                continue;
            }
            wallbuy = s_location.instances[#"wallbuy"];
            if (isdefined(wallbuy)) {
                namespace_8b6a9d79::function_20d7e9c7(wallbuy);
            }
        }
        return;
    }
    spawn_list = [];
    spawnable_weapon_spawns = struct::get_array("weapon_upgrade", "targetname");
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("bowie_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("sickle_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("tazer_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("buildable_wallbuy", "targetname"), 1, 0);
    if (is_true(level.use_autofill_wallbuy)) {
        spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, level.active_autofill_wallbuys, 1, 0);
    }
    if (!is_true(level.headshots_only)) {
        spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("claymore_purchase", "targetname"), 1, 0);
    }
    location = level.scr_zm_map_start_location;
    if ((location == "default" || location == "") && isdefined(level.default_start_location)) {
        location = level.default_start_location;
    }
    match_string = level.scr_zm_ui_gametype;
    if ("" != location) {
        match_string = match_string + "_" + location;
    }
    match_string_plus_space = " " + match_string;
    for (i = 0; i < spawnable_weapon_spawns.size; i++) {
        spawnable_weapon = spawnable_weapon_spawns[i];
        spawnable_weapon.weapon = getweapon(spawnable_weapon.zombie_weapon_upgrade);
        weapon_group = zm_utility::getweaponclasszm(spawnable_weapon.weapon);
        if (weapon_group == #"weapon_pistol" && !zm_custom::function_901b751c(#"zmweaponspistol") || weapon_group == #"weapon_cqb" && !zm_custom::function_901b751c(#"zmweaponsshotgun") || weapon_group == #"weapon_smg" && !zm_custom::function_901b751c(#"zmweaponssmg") || weapon_group == #"weapon_assault" && !zm_custom::function_901b751c(#"zmweaponsar") || weapon_group == #"weapon_tactical" && !zm_custom::function_901b751c(#"zmweaponstr") || weapon_group == #"weapon_lmg" && !zm_custom::function_901b751c(#"zmweaponslmg") || weapon_group == #"weapon_sniper" && !zm_custom::function_901b751c(#"zmweaponssniper") || weapon_group == #"weapon_knife" && !zm_custom::function_901b751c(#"zmweaponsknife")) {
            continue;
        }
        if (isdefined(spawnable_weapon.zombie_weapon_upgrade) && spawnable_weapon.weapon.isgrenadeweapon && is_true(level.headshots_only)) {
            continue;
        }
        if (!isdefined(spawnable_weapon.script_noteworthy) || spawnable_weapon.script_noteworthy == "") {
            spawn_list[spawn_list.size] = spawnable_weapon;
            continue;
        }
        matches = strtok(spawnable_weapon.script_noteworthy, ",");
        for (j = 0; j < matches.size; j++) {
            if (matches[j] == match_string || matches[j] == match_string_plus_space) {
                spawn_list[spawn_list.size] = spawnable_weapon;
            }
        }
    }
    tempmodel = spawn("script_model", (0, 0, 0));
    for (i = 0; i < spawn_list.size; i++) {
        clientfieldname = spawn_list[i].zombie_weapon_upgrade + "_" + spawn_list[i].origin;
        numbits = 2;
        if (isdefined(level._wallbuy_override_num_bits)) {
            numbits = level._wallbuy_override_num_bits;
        }
        clientfield::register("world", clientfieldname, 1, numbits, "int");
        target_struct = struct::get(spawn_list[i].target, "targetname");
        if (spawn_list[i].targetname == "buildable_wallbuy") {
            bits = 4;
            if (isdefined(level.buildable_wallbuy_weapons)) {
                bits = getminbitcountfornum(level.buildable_wallbuy_weapons.size + 1);
            }
            clientfield::register("world", clientfieldname + "_idx", 1, bits, "int");
            spawn_list[i].clientfieldname = clientfieldname;
            continue;
        }
        var_f8d30499 = 50;
        var_887e6ebe = 32;
        var_b0e9dcba = 120;
        if (is_true(level.var_a8f3193b)) {
            tempmodel.origin = spawn_list[i].origin;
            tempmodel.angles = spawn_list[i].angles;
            mins = undefined;
            maxs = undefined;
            absmins = undefined;
            absmaxs = undefined;
            tempmodel setmodel(target_struct.model);
            tempmodel useweaponhidetags(spawn_list[i].weapon);
            mins = tempmodel getmins();
            maxs = tempmodel getmaxs();
            absmins = tempmodel getabsmins();
            absmaxs = tempmodel getabsmaxs();
            bounds = absmaxs - absmins;
            var_887e6ebe = bounds[0] * 0.25;
            var_f8d30499 = bounds[1];
            var_b0e9dcba = bounds[2];
        }
        unitrigger_stub = zm_unitrigger::function_9267812e(var_f8d30499, var_887e6ebe, var_b0e9dcba);
        zm_unitrigger::function_47625e58(unitrigger_stub, spawn_list[i].origin - anglestoright(spawn_list[i].angles) * var_887e6ebe * 0.2, spawn_list[i].angles);
        zm_unitrigger::function_c4a5fdf5(unitrigger_stub, 1);
        if (is_true(spawn_list[i].require_look_from)) {
            unitrigger_stub.require_look_from = 1;
        }
        unitrigger_stub.target = spawn_list[i].target;
        unitrigger_stub.targetname = spawn_list[i].targetname;
        zm_unitrigger::function_c9e3607c(unitrigger_stub, "HINT_WEAPON", spawn_list[i].weapon);
        zm_unitrigger::unitrigger_set_hint_string(unitrigger_stub, zm_weapons::get_weapon_hint(spawn_list[i].weapon), zm_weapons::get_weapon_cost(spawn_list[i].weapon));
        if (is_true(spawn_list[i].require_look_from)) {
            unitrigger_stub.require_look_from = 1;
        }
        if (isdefined(spawn_list[i].script_string) && is_true(int(spawn_list[i].script_string))) {
            zm_unitrigger::function_89380dda(unitrigger_stub, 0);
        } else {
            zm_unitrigger::function_89380dda(unitrigger_stub, 1);
        }
        unitrigger_stub.target = spawn_list[i].target;
        unitrigger_stub.targetname = spawn_list[i].targetname;
        unitrigger_stub.weapon = spawn_list[i].weapon;
        unitrigger_stub.var_9d17fab9 = spawn_list[i].zombie_weapon_upgrade + "_item_sr";
        unitrigger_stub.clientfieldname = clientfieldname;
        if (unitrigger_stub.weapon.weapclass != "melee" && unitrigger_stub.weapon.weapclass != "grenade") {
            zm_unitrigger::function_2547d31f(unitrigger_stub, &wall_weapon_update_prompt);
        }
        zm_unitrigger::register_static_unitrigger(unitrigger_stub, &weapon_spawn_think);
        spawn_list[i].trigger_stub = unitrigger_stub;
        if (isdefined(target_struct.target) && !is_true(level.var_c1013f84)) {
            if (is_true(level.var_2e5167c9)) {
                spawn_list[i] thread function_44840c02(target_struct.target);
            }
        }
    }
    level._spawned_wallbuys = spawn_list;
    if (isdefined(tempmodel)) {
        tempmodel delete();
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x1 linked
// Checksum 0x3e4f0605, Offset: 0x1eb8
// Size: 0x94
function function_44840c02(str_targetname) {
    level flag::wait_till_all(array(#"zones_initialized", #"hash_4f4b65226250fc99"));
    var_8d0ce13b = getent(str_targetname, "targetname");
    var_8d0ce13b clientfield::set("wallbuy_ambient_fx", 1);
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 2, eflags: 0x0
// Checksum 0x33d516e4, Offset: 0x1f58
// Size: 0x224
function function_c970de50(trigger, parent) {
    if (isdefined(parent)) {
        trigger enablelinkto();
        trigger linkto(parent, "", self worldtolocalcoords(trigger.origin), (0, 0, 0));
    }
    trigger.weapon = getweapon(trigger.zombie_weapon_upgrade);
    trigger setcursorhint("HINT_WEAPON", trigger.weapon);
    trigger.cost = zm_weapons::get_weapon_cost(trigger.weapon);
    trigger.hint_string = zm_weapons::get_weapon_hint(trigger.weapon);
    trigger.hint_parm1 = trigger.cost;
    trigger sethintstring(trigger.hint_string);
    self.buyable_weapon = trigger;
    level._spawned_wallbuys[level._spawned_wallbuys.size] = trigger;
    weapon_model = getent(trigger.target, "targetname");
    if (isdefined(parent)) {
        weapon_model linkto(parent, "", self worldtolocalcoords(weapon_model.origin), weapon_model.angles + self.angles);
        weapon_model setmovingplatformenabled(1);
        weapon_model._linked_ent = trigger;
    }
    weapon_model show();
    weapon_model thread function_753c491c(trigger);
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x1 linked
// Checksum 0x88549409, Offset: 0x2188
// Size: 0x74
function function_753c491c(trigger) {
    self.orgmodel = self.model;
    self setmodel(#"wpn_t7_none_world");
    trigger waittill(#"trigger");
    self setmodel(self.orgmodel);
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 3, eflags: 0x0
// Checksum 0xa23d1118, Offset: 0x2208
// Size: 0x614
function add_dynamic_wallbuy(weapon, wallbuy, pristine) {
    spawned_wallbuy = undefined;
    for (i = 0; i < level._spawned_wallbuys.size; i++) {
        if (level._spawned_wallbuys[i].target == wallbuy) {
            spawned_wallbuy = level._spawned_wallbuys[i];
            break;
        }
    }
    if (!isdefined(spawned_wallbuy)) {
        assertmsg("<dev string:x38>");
        return;
    }
    if (isdefined(spawned_wallbuy.trigger_stub)) {
        assertmsg("<dev string:x57>");
        return;
    }
    target_struct = struct::get(wallbuy, "targetname");
    wallmodel = zm_utility::spawn_weapon_model(weapon, undefined, target_struct.origin, target_struct.angles, undefined);
    clientfieldname = spawned_wallbuy.clientfieldname;
    model = weapon.worldmodel;
    unitrigger_stub = spawnstruct();
    unitrigger_stub.origin = target_struct.origin;
    unitrigger_stub.angles = target_struct.angles;
    wallmodel.origin = target_struct.origin;
    wallmodel.angles = target_struct.angles;
    mins = undefined;
    maxs = undefined;
    absmins = undefined;
    absmaxs = undefined;
    wallmodel setmodel(model);
    wallmodel useweaponhidetags(weapon);
    mins = wallmodel getmins();
    maxs = wallmodel getmaxs();
    absmins = wallmodel getabsmins();
    absmaxs = wallmodel getabsmaxs();
    bounds = absmaxs - absmins;
    unitrigger_stub.script_length = bounds[0] * 0.25;
    unitrigger_stub.script_width = bounds[1];
    unitrigger_stub.script_height = bounds[2];
    unitrigger_stub.origin -= anglestoright(unitrigger_stub.angles) * unitrigger_stub.script_length * 0.4;
    unitrigger_stub.target = spawned_wallbuy.target;
    unitrigger_stub.targetname = "weapon_upgrade";
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.first_time_triggered = !pristine;
    if (!weapon.ismeleeweapon) {
        if (pristine || zm_loadout::is_placeable_mine(weapon)) {
            unitrigger_stub.hint_string = zm_weapons::get_weapon_hint(weapon);
        } else {
            unitrigger_stub.hint_string = get_weapon_hint_ammo();
        }
        unitrigger_stub.cost = zm_weapons::get_weapon_cost(weapon);
    }
    unitrigger_stub.weapon = weapon;
    unitrigger_stub.weapon_upgrade = weapon;
    unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    unitrigger_stub.require_look_at = 1;
    unitrigger_stub.clientfieldname = clientfieldname;
    zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
    if (weapon.ismeleeweapon) {
        if (weapon == "tazer_knuckles" && isdefined(level.taser_trig_adjustment)) {
            unitrigger_stub.origin += level.taser_trig_adjustment;
        }
        zm_melee_weapon::add_stub(unitrigger_stub, weapon);
        zm_unitrigger::register_static_unitrigger(unitrigger_stub, &zm_melee_weapon::melee_weapon_think);
    } else {
        unitrigger_stub.prompt_and_visibility_func = &wall_weapon_update_prompt;
        zm_unitrigger::register_static_unitrigger(unitrigger_stub, &weapon_spawn_think);
    }
    spawned_wallbuy.trigger_stub = unitrigger_stub;
    weaponidx = undefined;
    if (isdefined(level.buildable_wallbuy_weapons)) {
        for (i = 0; i < level.buildable_wallbuy_weapons.size; i++) {
            if (weapon == level.buildable_wallbuy_weapons[i]) {
                weaponidx = i;
                break;
            }
        }
    }
    if (isdefined(weaponidx)) {
        level clientfield::set(clientfieldname + "_idx", weaponidx + 1);
        wallmodel delete();
        if (!pristine) {
            level clientfield::set(clientfieldname, 1);
        }
        return;
    }
    level clientfield::set(clientfieldname, 1);
    wallmodel show();
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x1 linked
// Checksum 0x1af9d514, Offset: 0x2828
// Size: 0x470
function wall_weapon_update_prompt(player) {
    if (!isdefined(player.currentweapon)) {
        return false;
    }
    weapon = self.stub.weapon;
    player_has_weapon = player zm_weapons::has_weapon_or_upgrade(weapon);
    if (!player_has_weapon && is_true(level.weapons_using_ammo_sharing)) {
        shared_ammo_weapon = player zm_weapons::get_shared_ammo_weapon(self.zombie_weapon_upgrade);
        if (isdefined(shared_ammo_weapon)) {
            weapon = shared_ammo_weapon;
            player_has_weapon = 1;
        }
    }
    if (isdefined(level.func_override_wallbuy_prompt)) {
        if (!self [[ level.func_override_wallbuy_prompt ]](player, player_has_weapon)) {
            return false;
        }
    } else if (zm_trial_disable_buys::is_active()) {
        return false;
    } else if (!player_has_weapon) {
        self.stub.cursor_hint = "HINT_WEAPON";
        cost = zm_weapons::get_weapon_cost(weapon);
        if (player bgb::is_enabled(#"zm_bgb_secret_shopper") && !zm_weapons::is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee") {
            if (player function_8b1a219a()) {
                self.stub.hint_string = #"hash_7778a99e3a7d47";
            } else {
                self.stub.hint_string = #"hash_18379e4e114fabf9";
            }
            if (self.stub.var_8d306e51) {
                self sethintstringforplayer(player, self.stub.hint_string);
            } else {
                self sethintstring(self.stub.hint_string);
            }
        } else if (player bgb::is_enabled(#"zm_bgb_wall_to_wall_clearance")) {
            if (player function_8b1a219a()) {
                self.stub.hint_string = #"hash_7a24a147b8f09767";
            } else {
                self.stub.hint_string = #"hash_791fe9da17cf7059";
            }
            if (self.stub.var_8d306e51) {
                self sethintstringforplayer(player, self.stub.hint_string);
            } else {
                self sethintstring(self.stub.hint_string);
            }
        } else {
            if (player function_8b1a219a()) {
                self.stub.hint_string = #"hash_2791ecebb85142c4";
            } else {
                self.stub.hint_string = #"hash_60606b68e93a29c8";
            }
            if (self.stub.var_8d306e51) {
                self sethintstringforplayer(player, self.stub.hint_string);
            } else {
                self sethintstring(self.stub.hint_string);
            }
        }
    } else {
        return false;
    }
    self.stub.cursor_hint = "HINT_WEAPON";
    self.stub.cursor_hint_weapon = weapon;
    self setcursorhint(self.stub.cursor_hint, self.stub.cursor_hint_weapon);
    return true;
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x1 linked
// Checksum 0xd4635348, Offset: 0x2ca0
// Size: 0xbc
function reset_wallbuy_internal(set_hint_string) {
    if (is_true(self.first_time_triggered)) {
        self.first_time_triggered = 0;
        if (isdefined(self.clientfieldname)) {
            level clientfield::set(self.clientfieldname, 0);
        }
        if (set_hint_string) {
            hint_string = zm_weapons::get_weapon_hint(self.weapon);
            cost = zm_weapons::get_weapon_cost(self.weapon);
            self sethintstring(hint_string);
        }
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x0
// Checksum 0x50715eb2, Offset: 0x2d68
// Size: 0x362
function reset_wallbuys() {
    weapon_spawns = [];
    weapon_spawns = getentarray("weapon_upgrade", "targetname");
    melee_and_grenade_spawns = [];
    melee_and_grenade_spawns = getentarray("bowie_upgrade", "targetname");
    melee_and_grenade_spawns = arraycombine(melee_and_grenade_spawns, getentarray("sickle_upgrade", "targetname"), 1, 0);
    melee_and_grenade_spawns = arraycombine(melee_and_grenade_spawns, getentarray("tazer_upgrade", "targetname"), 1, 0);
    if (!is_true(level.headshots_only)) {
        melee_and_grenade_spawns = arraycombine(melee_and_grenade_spawns, getentarray("claymore_purchase", "targetname"), 1, 0);
    }
    for (i = 0; i < weapon_spawns.size; i++) {
        weapon_spawns[i].weapon = getweapon(weapon_spawns[i].zombie_weapon_upgrade);
        weapon_spawns[i] reset_wallbuy_internal(1);
    }
    for (i = 0; i < melee_and_grenade_spawns.size; i++) {
        melee_and_grenade_spawns[i].weapon = getweapon(melee_and_grenade_spawns[i].zombie_weapon_upgrade);
        melee_and_grenade_spawns[i] reset_wallbuy_internal(0);
    }
    if (isdefined(level._unitriggers)) {
        candidates = [];
        for (i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
            stub = level._unitriggers.trigger_stubs[i];
            tn = stub.targetname;
            if (tn == "weapon_upgrade" || tn == "bowie_upgrade" || tn == "sickle_upgrade" || tn == "tazer_upgrade" || tn == "claymore_purchase") {
                stub.first_time_triggered = 0;
                if (isdefined(stub.clientfieldname)) {
                    level clientfield::set(stub.clientfieldname, 0);
                }
                if (tn == "weapon_upgrade") {
                    stub.hint_string = zm_weapons::get_weapon_hint(stub.weapon);
                    stub.cost = zm_weapons::get_weapon_cost(stub.weapon);
                }
            }
        }
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x1 linked
// Checksum 0x3194a431, Offset: 0x30d8
// Size: 0x12
function get_weapon_hint_ammo() {
    return #"hash_60606b68e93a29c8";
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 2, eflags: 0x0
// Checksum 0x2e204266, Offset: 0x30f8
// Size: 0x3c
function weapon_set_first_time_hint(*cost, *ammo_cost) {
    self sethintstring(get_weapon_hint_ammo());
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x1 linked
// Checksum 0x7c21bc1a, Offset: 0x3140
// Size: 0x3a
function placeable_mine_can_buy_weapon_extra_check_func(w_weapon) {
    if (isdefined(w_weapon) && w_weapon == self zm_loadout::get_player_placeable_mine()) {
        return false;
    }
    return true;
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x1 linked
// Checksum 0x688306f7, Offset: 0x3188
// Size: 0xc10
function weapon_spawn_think() {
    self endon(#"death");
    var_4ee4441d = is_true(self.var_9f32a5f4);
    rarity = #"none";
    if (isdefined(self.rarity)) {
        rarity = self.rarity;
    }
    cost = zm_weapons::get_weapon_cost(self.weapon);
    ammo_cost = zm_weapons::get_ammo_cost(self.weapon);
    is_grenade = self.weapon.isgrenadeweapon;
    shared_ammo_weapon = undefined;
    if (isdefined(self.parent_player) && !is_grenade) {
        self.parent_player notify(#"zm_bgb_secret_shopper", {#trigger:self});
    }
    second_endon = undefined;
    if (isdefined(self.stub)) {
        second_endon = "kill_trigger";
        self.first_time_triggered = self.stub.first_time_triggered;
    }
    onlyplayer = undefined;
    can_buy_weapon_extra_check_func = undefined;
    if (isdefined(self.stub) && is_true(self.stub.trigger_per_player)) {
        onlyplayer = self.parent_player;
        if (zm_loadout::is_placeable_mine(self.weapon)) {
            can_buy_weapon_extra_check_func = &placeable_mine_can_buy_weapon_extra_check_func;
        }
    }
    self thread zm_magicbox::decide_hide_show_hint("stop_hint_logic", second_endon, onlyplayer, can_buy_weapon_extra_check_func, 0);
    if (is_grenade || zm_loadout::is_melee_weapon(self.weapon)) {
        self.first_time_triggered = 0;
        if (var_4ee4441d) {
            hint = #"hash_6ee6f17a7c9eb226";
        } else {
            hint = zm_weapons::get_weapon_hint(self.weapon);
        }
        self sethintstring(hint);
        cursor_hint = "HINT_WEAPON";
        cursor_hint_weapon = self.weapon;
        self setcursorhint(cursor_hint, cursor_hint_weapon);
    } else if (!isdefined(self.first_time_triggered)) {
        self.first_time_triggered = 0;
        if (isdefined(self.stub)) {
            self.stub.first_time_triggered = 0;
        }
    }
    for (;;) {
        waitresult = self waittill(#"trigger");
        player = waitresult.activator;
        currentweapon = player getcurrentweapon();
        if (!zm_utility::is_player_valid(player)) {
            player thread zm_utility::ignore_triggers(0.5);
            continue;
        }
        if (!player zm_magicbox::can_buy_weapon(0)) {
            wait 0.1;
            continue;
        }
        if (isdefined(self.stub) && is_true(self.stub.require_look_from)) {
            toplayer = player util::get_eye() - self.origin;
            forward = -1 * anglestoright(self.angles);
            dot = vectordot(toplayer, forward);
            if (dot < 0) {
                continue;
            }
        }
        if (player zm_loadout::has_powerup_weapon() || currentweapon.isheroweapon) {
            wait 0.1;
            continue;
        }
        if (zm_trial_disable_buys::is_active()) {
            wait 0.1;
            continue;
        }
        player_has_weapon = player zm_weapons::function_40d216ce(currentweapon, self.weapon);
        if (isdefined(player.var_44b2ea64)) {
            foreach (func_override in player.var_44b2ea64) {
                n_cost = player [[ func_override ]](self.weapon, self);
                if (isdefined(n_cost)) {
                    if (n_cost < cost) {
                        cost = n_cost;
                    }
                }
            }
        }
        if (isdefined(player.check_override_wallbuy_purchase)) {
            if (player [[ player.check_override_wallbuy_purchase ]](self.weapon, self)) {
                continue;
            }
        }
        if (!player_has_weapon) {
            if (zm_utility::function_e05ac4ad(player, cost)) {
                if (self.first_time_triggered == 0) {
                    self show_all_weapon_buys(player, cost, ammo_cost, is_grenade, var_4ee4441d);
                }
                player zm_score::minus_to_player_score(cost);
                if (isdefined(level.var_db463b5)) {
                    self [[ level.var_db463b5 ]](player);
                }
                level notify(#"weapon_bought", {#player:player, #weapon:self.weapon});
                player zm_stats::increment_challenge_stat(#"survivalist_buy_wallbuy", undefined, 1);
                player zm_stats::increment_challenge_stat(#"hash_385398b8acbf8b4a", undefined, 1);
                player zm_stats::increment_challenge_stat(#"hash_702d98df99af63d5", undefined, 1);
                player zm_stats::function_c0c6ab19(#"weapons_bought", 1, 1);
                player zm_stats::function_c0c6ab19(#"wallbuys", 1, 1);
                player contracts::increment_zm_contract(#"contract_zm_weapons_bought", 1, #"zstandard");
                player contracts::increment_zm_contract(#"contract_zm_wallbuys", 1, #"zstandard");
                if (self.weapon.isriotshield) {
                    player zm_equipment::give(self.weapon);
                    if (isdefined(player.player_shield_reset_health)) {
                        player [[ player.player_shield_reset_health ]](self.weapon);
                    }
                } else {
                    if (zm_loadout::is_lethal_grenade(self.weapon)) {
                        player zm_weapons::weapon_take(player zm_loadout::get_player_lethal_grenade());
                        player zm_loadout::set_player_lethal_grenade(self.weapon);
                    }
                    weapon = self.weapon;
                    if (should_upgrade_weapon(player)) {
                        if (player zm_weapons::can_upgrade_weapon(weapon)) {
                            weapon = zm_weapons::get_upgrade_weapon(weapon);
                            player notify(#"zm_bgb_wall_power_used");
                        }
                    }
                    if (isdefined(self.item_name)) {
                        point = function_4ba8fde(self.item_name);
                        if (isdefined(point.var_a6762160.var_a53e9db0)) {
                            weapon = namespace_65181344::function_67456242(point.var_a6762160);
                            dropitem = item_drop::drop_item(0, weapon, 1, weapon.maxammo, point.id, self.origin, self.angles, 1);
                            dropitem.hidetime = 1;
                            dropitem hide();
                            player zm_weapons::function_98776900(dropitem, 0, 0);
                        } else {
                            player zm_weapons::function_98776900(point, 0, 0);
                        }
                    } else {
                        player zm_weapons::weapon_give(weapon, 0, 1, undefined, undefined, rarity);
                    }
                }
                if (isdefined(weapon)) {
                    player notify(#"weapon_purchased", {#weapon:weapon});
                    player zm_stats::increment_client_stat("wallbuy_weapons_purchased");
                    player zm_stats::increment_player_stat("wallbuy_weapons_purchased");
                    player zm_stats::function_8f10788e("boas_wallbuy_weapons_purchased");
                    bb::logpurchaseevent(player, self, cost, weapon.name, player zm_weapons::has_upgrade(weapon), "_weapon", "_purchase");
                    weaponindex = undefined;
                    if (isdefined(weaponindex)) {
                        weaponindex = matchrecordgetweaponindex(weapon);
                    }
                    if (isdefined(weaponindex)) {
                        player recordmapevent(6, gettime(), player.origin, level.round_number, weaponindex, cost);
                    }
                }
            } else {
                zm_utility::play_sound_on_ent("no_purchase");
                player zm_audio::create_and_play_dialog(#"general", #"outofmoney");
            }
        }
        if (isdefined(player)) {
            player notify(#"wallbuy_done");
            if (isdefined(self.stub) && isdefined(self.stub.prompt_and_visibility_func)) {
                self [[ self.stub.prompt_and_visibility_func ]](player);
            }
        }
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x1 linked
// Checksum 0xc01871d3, Offset: 0x3da0
// Size: 0x56
function should_upgrade_weapon(player) {
    if (isdefined(level.var_f270168a)) {
        return [[ level.var_f270168a ]]();
    }
    if (player bgb::is_enabled(#"zm_bgb_wall_power")) {
        return 1;
    }
    return 0;
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 5, eflags: 0x1 linked
// Checksum 0x6d93fb92, Offset: 0x3e00
// Size: 0x42a
function show_all_weapon_buys(player, *cost, *ammo_cost, *is_grenade, var_4ee4441d = 0) {
    model = getent(self.target, "targetname");
    is_melee = zm_loadout::is_melee_weapon(self.weapon);
    if (isdefined(model)) {
        model thread weapon_show(is_grenade, var_4ee4441d);
    } else if (isdefined(self.clientfieldname)) {
        level clientfield::set(self.clientfieldname, 1);
    }
    if (zm_utility::get_story() != 1 && !isdefined(model)) {
        var_6ff4b667 = struct::get(self.target, "targetname");
        if (isdefined(var_6ff4b667) && isdefined(var_6ff4b667.target)) {
            var_8d0ce13b = getent(var_6ff4b667.target, "targetname");
            var_8d0ce13b clientfield::set("wallbuy_reveal_fx", 1);
            var_8d0ce13b clientfield::set("wallbuy_ambient_fx", 0);
        }
    }
    self.first_time_triggered = 1;
    if (isdefined(self.stub)) {
        self.stub.first_time_triggered = 1;
    }
    if (!is_true(level.dont_link_common_wallbuys) && isdefined(level._spawned_wallbuys)) {
        for (i = 0; i < level._spawned_wallbuys.size; i++) {
            wallbuy = level._spawned_wallbuys[i];
            if (isdefined(self.stub) && isdefined(wallbuy.trigger_stub) && self.stub.clientfieldname == wallbuy.trigger_stub.clientfieldname) {
                continue;
            }
            if (self.weapon == wallbuy.weapon) {
                if (isdefined(wallbuy.trigger_stub) && isdefined(wallbuy.trigger_stub.clientfieldname)) {
                    level clientfield::set(wallbuy.trigger_stub.clientfieldname, 1);
                    var_6ff4b667 = struct::get(wallbuy.target, "targetname");
                    if (isdefined(var_6ff4b667) && isdefined(var_6ff4b667.target)) {
                        var_8d0ce13b = getent(var_6ff4b667.target, "targetname");
                        var_8d0ce13b clientfield::set("wallbuy_ambient_fx", 0);
                    }
                } else if (isdefined(wallbuy.target)) {
                    model = getent(wallbuy.target, "targetname");
                    if (isdefined(model)) {
                        model thread weapon_show(is_grenade);
                    }
                }
                if (isdefined(wallbuy.trigger_stub)) {
                    wallbuy.trigger_stub.first_time_triggered = 1;
                    if (isdefined(wallbuy.trigger_stub.trigger)) {
                        wallbuy.trigger_stub.trigger.first_time_triggered = 1;
                    }
                }
            }
        }
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 2, eflags: 0x1 linked
// Checksum 0x997afe62, Offset: 0x4238
// Size: 0x294
function weapon_show(player, var_4ee4441d = 0) {
    if (var_4ee4441d) {
        var_4487b2bf = self.origin;
        var_e27c9160 = self worldtolocalcoords(var_4487b2bf);
        var_e27c9160 = (var_e27c9160[0], var_e27c9160[1] - 3, var_e27c9160[2]);
        self.origin = self localtoworldcoords(var_e27c9160);
        waitframe(1);
        self show();
        zm_utility::play_sound_at_pos("weapon_show", self.origin, self);
        time = 1;
        if (!isdefined(self._linked_ent)) {
            self moveto(var_4487b2bf, time);
        }
        return;
    }
    player_angles = vectortoangles(player.origin - self.origin);
    player_yaw = player_angles[1];
    weapon_yaw = self.angles[1];
    if (isdefined(self.script_int)) {
        weapon_yaw -= self.script_int;
    }
    yaw_diff = angleclamp180(player_yaw - weapon_yaw);
    if (yaw_diff > 0) {
        yaw = weapon_yaw - 90;
    } else {
        yaw = weapon_yaw + 90;
    }
    self.og_origin = self.origin;
    self.origin += anglestoforward((0, yaw, 0)) * 8;
    waitframe(1);
    self show();
    zm_utility::play_sound_at_pos("weapon_show", self.origin, self);
    time = 1;
    if (!isdefined(self._linked_ent)) {
        self moveto(self.og_origin, time);
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x1 linked
// Checksum 0xdcf0331a, Offset: 0x44d8
// Size: 0xb8
function is_wallbuy(w_to_check) {
    w_base = zm_weapons::get_base_weapon(w_to_check);
    foreach (s_wallbuy in level._spawned_wallbuys) {
        if (s_wallbuy.weapon == w_base) {
            return true;
        }
    }
    return false;
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0x29568a3a, Offset: 0x4598
// Size: 0x17a
function function_b5992fb1(var_13f9dee7 = #"none") {
    switch (var_13f9dee7) {
    case #"green":
        self clientfield::set("wallbuy_ambient_fx", 3);
        break;
    case #"blue":
        self clientfield::set("wallbuy_ambient_fx", 4);
        break;
    case #"purple":
        self clientfield::set("wallbuy_ambient_fx", 5);
        break;
    case #"orange":
        self clientfield::set("wallbuy_ambient_fx", 6);
        break;
    case #"gold":
        self clientfield::set("wallbuy_ambient_fx", 7);
        break;
    default:
        self clientfield::set("wallbuy_ambient_fx", 0);
        break;
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0x57eeaf3d, Offset: 0x4720
// Size: 0x17a
function function_36eb0acc(var_13f9dee7 = #"none") {
    switch (var_13f9dee7) {
    case #"green":
        self clientfield::set("model_rarity_rob", 3);
        break;
    case #"blue":
        self clientfield::set("model_rarity_rob", 4);
        break;
    case #"purple":
        self clientfield::set("model_rarity_rob", 5);
        break;
    case #"orange":
        self clientfield::set("model_rarity_rob", 6);
        break;
    case #"gold":
        self clientfield::set("model_rarity_rob", 7);
        break;
    default:
        self clientfield::set("model_rarity_rob", 0);
        break;
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0xac3607e0, Offset: 0x48a8
// Size: 0xa8
function function_c047c228(func_override) {
    if (!isdefined(self.var_44b2ea64)) {
        self.var_44b2ea64 = [];
    }
    if (!isdefined(self.var_44b2ea64)) {
        self.var_44b2ea64 = [];
    } else if (!isarray(self.var_44b2ea64)) {
        self.var_44b2ea64 = array(self.var_44b2ea64);
    }
    if (!isinarray(self.var_44b2ea64, func_override)) {
        self.var_44b2ea64[self.var_44b2ea64.size] = func_override;
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0xb5d4f0cd, Offset: 0x4958
// Size: 0x24
function function_a6889c(func_override) {
    arrayremovevalue(self.var_44b2ea64, func_override);
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0xc162d4b9, Offset: 0x4988
// Size: 0xa8
function function_48f914bd(func_override) {
    if (!isdefined(self.var_6d2d0163)) {
        self.var_6d2d0163 = [];
    }
    if (!isdefined(self.var_6d2d0163)) {
        self.var_6d2d0163 = [];
    } else if (!isarray(self.var_6d2d0163)) {
        self.var_6d2d0163 = array(self.var_6d2d0163);
    }
    if (!isinarray(self.var_6d2d0163, func_override)) {
        self.var_6d2d0163[self.var_6d2d0163.size] = func_override;
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0xf1a3441e, Offset: 0x4a38
// Size: 0x24
function function_99911dae(func_override) {
    arrayremovevalue(self.var_6d2d0163, func_override);
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0xff0169f9, Offset: 0x4a68
// Size: 0xa8
function function_33023da5(func_override) {
    if (!isdefined(self.var_dc25727a)) {
        self.var_dc25727a = [];
    }
    if (!isdefined(self.var_dc25727a)) {
        self.var_dc25727a = [];
    } else if (!isarray(self.var_dc25727a)) {
        self.var_dc25727a = array(self.var_dc25727a);
    }
    if (!isinarray(self.var_dc25727a, func_override)) {
        self.var_dc25727a[self.var_dc25727a.size] = func_override;
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0xae7a1d8, Offset: 0x4b18
// Size: 0x24
function function_782e8955(func_override) {
    arrayremovevalue(self.var_dc25727a, func_override);
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 2, eflags: 0x1 linked
// Checksum 0xbad5f55c, Offset: 0x4b48
// Size: 0x14e
function function_d26435e4(wallbuy, rarity = undefined) {
    if (!isdefined(rarity)) {
        rarity = wallbuy.script_string;
    }
    switch (wallbuy.script_noteworthy) {
    case #"pistol_burst_t9":
    case #"tr_damagesemi_t9":
    case #"shotgun_pump_t9":
    case #"tr_longburst_t9":
    case #"smg_standard_t9":
    case #"smg_heavy_t9":
    case #"sniper_standard_t9":
    case #"ar_standard_t9":
        str_model = "p9_zm_chalk_buy_" + wallbuy.script_noteworthy + function_db435e40(rarity);
        break;
    default:
        str_model = "p9_zm_chalk_buy_" + "tr_longburst_t9" + function_db435e40(rarity);
        break;
    }
    return str_model;
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x5 linked
// Checksum 0x9521ec2, Offset: 0x4ca0
// Size: 0xda
function private function_db435e40(var_13f9dee7 = "white") {
    switch (var_13f9dee7) {
    case #"green":
        return "_uncommon";
    case #"purple":
        return "_epic";
    case #"orange":
        return "_legendary";
    case #"blue":
        return "_rare";
    case #"gold":
        return "_ultra";
    default:
        return "";
    }
}

