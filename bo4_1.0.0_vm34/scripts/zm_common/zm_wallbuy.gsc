#using script_1b05b3ef7baa1c84;
#using scripts\core_common\aat_shared;
#using scripts\core_common\bb_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\callings\zm_callings;
#using scripts\zm_common\gametypes\globallogic_utils;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_placeable_mine;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_wallbuy;

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x2
// Checksum 0x71fee569, Offset: 0x378
// Size: 0x94
function autoexec __init__system__() {
    system::register(#"zm_wallbuy", &__init__, &__main__, array(#"zm", #"zm_zonemgr", #"zm_unitrigger", #"zm_weapons"));
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x0
// Checksum 0x4c76e743, Offset: 0x418
// Size: 0x124
function __init__() {
    if (!zm_custom::function_5638f689(#"zmwallbuysenabled")) {
        a_outlines = getentarray("wallbuy_outline", "targetname");
        foreach (e_outline in a_outlines) {
            e_outline delete();
        }
        return;
    }
    clientfield::register("scriptmover", "wallbuy_ambient_fx", 1, 1, "int");
    clientfield::register("scriptmover", "wallbuy_reveal_fx", 1, 1, "int");
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x0
// Checksum 0xb8482b33, Offset: 0x548
// Size: 0x7c
function __main__() {
    if (!getgametypesetting(#"zmwallbuysenabled")) {
        return;
    }
    thread init_spawnable_weapon_upgrade();
    thread init_weapon_upgrade();
    if (isdefined(level.var_4dd09857) && level.var_4dd09857) {
        function_9e8dccbe();
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x0
// Checksum 0x6457f61c, Offset: 0x5d0
// Size: 0x1ce
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
// Params 0, eflags: 0x0
// Checksum 0x5be9a9d6, Offset: 0x7a8
// Size: 0xd74
function init_spawnable_weapon_upgrade() {
    spawn_list = [];
    spawnable_weapon_spawns = struct::get_array("weapon_upgrade", "targetname");
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("bowie_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("sickle_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("tazer_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("buildable_wallbuy", "targetname"), 1, 0);
    if (isdefined(level.use_autofill_wallbuy) && level.use_autofill_wallbuy) {
        spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, level.active_autofill_wallbuys, 1, 0);
    }
    if (!(isdefined(level.headshots_only) && level.headshots_only)) {
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
        if (weapon_group == #"weapon_pistol" && !zm_custom::function_5638f689(#"zmweaponspistol") || weapon_group == #"weapon_cqb" && !zm_custom::function_5638f689(#"zmweaponsshotgun") || weapon_group == #"weapon_smg" && !zm_custom::function_5638f689(#"zmweaponssmg") || weapon_group == #"weapon_assault" && !zm_custom::function_5638f689(#"zmweaponsar") || weapon_group == #"weapon_tactical" && !zm_custom::function_5638f689(#"zmweaponstr") || weapon_group == #"weapon_lmg" && !zm_custom::function_5638f689(#"zmweaponslmg") || weapon_group == #"weapon_sniper" && !zm_custom::function_5638f689(#"zmweaponssniper") || weapon_group == #"weapon_knife" && !zm_custom::function_5638f689(#"zmweaponsknife")) {
            continue;
        }
        if (isdefined(spawnable_weapon.zombie_weapon_upgrade) && spawnable_weapon.weapon.isgrenadeweapon && isdefined(level.headshots_only) && level.headshots_only) {
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
        var_9cccae7c = 50;
        var_ae2de16c = 32;
        var_90aa16f9 = 120;
        if (isdefined(level.var_eec14791) && level.var_eec14791) {
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
            var_ae2de16c = bounds[0] * 0.25;
            var_9cccae7c = bounds[1];
            var_90aa16f9 = bounds[2];
        }
        unitrigger_stub = zm_unitrigger::function_9916df24(var_9cccae7c, var_ae2de16c, var_90aa16f9);
        zm_unitrigger::function_3fc5694(unitrigger_stub, spawn_list[i].origin - anglestoright(spawn_list[i].angles) * var_ae2de16c * 0.2, spawn_list[i].angles);
        zm_unitrigger::function_9946242d(unitrigger_stub, 1);
        if (isdefined(spawn_list[i].require_look_from) && spawn_list[i].require_look_from) {
            unitrigger_stub.require_look_from = 1;
        }
        unitrigger_stub.target = spawn_list[i].target;
        unitrigger_stub.targetname = spawn_list[i].targetname;
        zm_unitrigger::function_17b799aa(unitrigger_stub, "HINT_WEAPON", spawn_list[i].weapon);
        zm_unitrigger::unitrigger_set_hint_string(unitrigger_stub, zm_weapons::get_weapon_hint(spawn_list[i].weapon), zm_weapons::get_weapon_cost(spawn_list[i].weapon));
        if (isdefined(spawn_list[i].require_look_from) && spawn_list[i].require_look_from) {
            unitrigger_stub.require_look_from = 1;
        }
        if (isdefined(spawn_list[i].script_string) && isdefined(int(spawn_list[i].script_string)) && int(spawn_list[i].script_string)) {
            zm_unitrigger::function_7fcb11a8(unitrigger_stub, 0);
        } else {
            zm_unitrigger::function_7fcb11a8(unitrigger_stub, 1);
        }
        unitrigger_stub.target = spawn_list[i].target;
        unitrigger_stub.targetname = spawn_list[i].targetname;
        unitrigger_stub.weapon = spawn_list[i].weapon;
        unitrigger_stub.clientfieldname = clientfieldname;
        if (!unitrigger_stub.weapon.ismeleeweapon && !unitrigger_stub.weapon.isgrenadeweapon) {
            zm_unitrigger::function_2e5dcd8b(unitrigger_stub, &wall_weapon_update_prompt);
        }
        zm_unitrigger::register_static_unitrigger(unitrigger_stub, &weapon_spawn_think);
        spawn_list[i].trigger_stub = unitrigger_stub;
        if (isdefined(target_struct.target) && !(isdefined(level.var_97e174e9) && level.var_97e174e9)) {
            spawn_list[i] thread function_4a8f451a(target_struct.target);
        }
    }
    level._spawned_wallbuys = spawn_list;
    if (isdefined(tempmodel)) {
        tempmodel delete();
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0x9e23a605, Offset: 0x1528
// Size: 0x74
function function_4a8f451a(str_targetname) {
    level flag::wait_till("zones_initialized");
    var_67c8ead4 = getent(str_targetname, "targetname");
    var_67c8ead4 clientfield::set("wallbuy_ambient_fx", 1);
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 2, eflags: 0x0
// Checksum 0x486a8a5d, Offset: 0x15a8
// Size: 0x24c
function function_13c9f00f(trigger, parent) {
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
    weapon_model thread function_d7993b3d(trigger);
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0x778425be, Offset: 0x1800
// Size: 0x74
function function_d7993b3d(trigger) {
    self.orgmodel = self.model;
    self setmodel(#"wpn_t7_none_world");
    trigger waittill(#"trigger");
    self setmodel(self.orgmodel);
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 3, eflags: 0x0
// Checksum 0xf49c56e, Offset: 0x1880
// Size: 0x694
function add_dynamic_wallbuy(weapon, wallbuy, pristine) {
    spawned_wallbuy = undefined;
    for (i = 0; i < level._spawned_wallbuys.size; i++) {
        if (level._spawned_wallbuys[i].target == wallbuy) {
            spawned_wallbuy = level._spawned_wallbuys[i];
            break;
        }
    }
    if (!isdefined(spawned_wallbuy)) {
        assertmsg("<dev string:x30>");
        return;
    }
    if (isdefined(spawned_wallbuy.trigger_stub)) {
        assertmsg("<dev string:x4c>");
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
// Params 1, eflags: 0x0
// Checksum 0x53c9d62e, Offset: 0x1f20
// Size: 0x930
function wall_weapon_update_prompt(player) {
    if (!isdefined(player.currentweapon)) {
        return false;
    }
    weapon = self.stub.weapon;
    player_has_weapon = player zm_weapons::has_weapon_or_upgrade(weapon);
    if (!player_has_weapon && isdefined(level.weapons_using_ammo_sharing) && level.weapons_using_ammo_sharing) {
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
            self.stub.hint_string = #"hash_18379e4e114fabf9";
            if (self.stub.var_3cbfae8d) {
                self sethintstringforplayer(player, self.stub.hint_string);
            } else {
                self sethintstring(self.stub.hint_string);
            }
        } else if (player bgb::is_enabled(#"zm_bgb_wall_to_wall_clearance")) {
            self.stub.hint_string = #"hash_791fe9da17cf7059";
            if (self.stub.var_3cbfae8d) {
                self sethintstringforplayer(player, self.stub.hint_string);
            } else {
                self sethintstring(self.stub.hint_string);
            }
        } else {
            self.stub.hint_string = #"hash_60606b68e93a29c8";
            if (self.stub.var_3cbfae8d) {
                self sethintstringforplayer(player, self.stub.hint_string);
            } else {
                self sethintstring(self.stub.hint_string);
            }
        }
    } else {
        if (player bgb::is_enabled(#"zm_bgb_secret_shopper") && !zm_weapons::is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee") {
            ammo_cost = player zm_weapons::get_ammo_cost_for_weapon(weapon);
        } else if (player zm_weapons::has_upgrade(weapon) && self.stub.hacked !== 1) {
            ammo_cost = zm_weapons::get_upgraded_ammo_cost(weapon);
        } else {
            ammo_cost = zm_weapons::get_ammo_cost(weapon);
        }
        w_upgrade = player zm_weapons::get_upgrade_weapon(weapon, 1);
        if (player zm_weapons::has_upgrade(weapon) && player zm_utility::function_828cdc5(w_upgrade)) {
            self.stub.hint_string = #"hash_130babfa2f4b1e4c";
            if (self.stub.var_3cbfae8d) {
                self sethintstringforplayer(player, self.stub.hint_string);
            } else {
                self sethintstring(self.stub.hint_string);
            }
        } else if (player zm_weapons::has_weapon_or_upgrade(weapon) && player zm_utility::function_828cdc5(weapon)) {
            self.stub.hint_string = #"hash_130babfa2f4b1e4c";
            if (self.stub.var_3cbfae8d) {
                self sethintstringforplayer(player, self.stub.hint_string);
            } else {
                self sethintstring(self.stub.hint_string);
            }
        } else if (player bgb::is_enabled(#"zm_bgb_secret_shopper") && !zm_weapons::is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee") {
            if (isdefined(self.stub.hacked) && self.stub.hacked) {
                self.stub.hint_string = #"zombie_weaponammohacked_cfill_bgb_secret_shopper";
            } else {
                self.stub.hint_string = #"hash_4a6901dda0793d3c";
            }
            if (self.stub.var_3cbfae8d) {
                self sethintstringforplayer(player, self.stub.hint_string);
            } else {
                self sethintstring(self.stub.hint_string);
            }
        } else if (player bgb::is_enabled(#"zm_bgb_wall_to_wall_clearance")) {
            if (player zm_weapons::has_upgrade(weapon)) {
                self.stub.hint_string = #"hash_7d4f06d135499350";
            } else {
                self.stub.hint_string = #"hash_43ab0adee9d55608";
            }
            if (self.stub.var_3cbfae8d) {
                self sethintstringforplayer(player, self.stub.hint_string);
            } else {
                self sethintstring(self.stub.hint_string);
            }
        } else {
            if (isdefined(self.stub.hacked) && self.stub.hacked) {
                self.stub.hint_string = #"zombie_weaponammohacked_cfill";
            } else {
                self.stub.hint_string = #"hash_382490a598f64833";
            }
            if (self.stub.var_3cbfae8d) {
                self sethintstringforplayer(player, self.stub.hint_string);
            } else {
                self sethintstring(self.stub.hint_string);
            }
        }
    }
    self.stub.cursor_hint = "HINT_WEAPON";
    self.stub.cursor_hint_weapon = weapon;
    self setcursorhint(self.stub.cursor_hint, self.stub.cursor_hint_weapon);
    return true;
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0x2b6754f7, Offset: 0x2858
// Size: 0xbc
function reset_wallbuy_internal(set_hint_string) {
    if (isdefined(self.first_time_triggered) && self.first_time_triggered) {
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
// Checksum 0x5c954f76, Offset: 0x2920
// Size: 0x390
function reset_wallbuys() {
    weapon_spawns = [];
    weapon_spawns = getentarray("weapon_upgrade", "targetname");
    melee_and_grenade_spawns = [];
    melee_and_grenade_spawns = getentarray("bowie_upgrade", "targetname");
    melee_and_grenade_spawns = arraycombine(melee_and_grenade_spawns, getentarray("sickle_upgrade", "targetname"), 1, 0);
    melee_and_grenade_spawns = arraycombine(melee_and_grenade_spawns, getentarray("tazer_upgrade", "targetname"), 1, 0);
    if (!(isdefined(level.headshots_only) && level.headshots_only)) {
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
// Params 0, eflags: 0x0
// Checksum 0x969068d7, Offset: 0x2cb8
// Size: 0x12
function get_weapon_hint_ammo() {
    return #"hash_60606b68e93a29c8";
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 2, eflags: 0x0
// Checksum 0xd81d7ac6, Offset: 0x2cd8
// Size: 0x3c
function weapon_set_first_time_hint(cost, ammo_cost) {
    self sethintstring(get_weapon_hint_ammo());
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0x9b1f6c07, Offset: 0x2d20
// Size: 0x3a
function placeable_mine_can_buy_weapon_extra_check_func(w_weapon) {
    if (isdefined(w_weapon) && w_weapon == self zm_loadout::get_player_placeable_mine()) {
        return false;
    }
    return true;
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 0, eflags: 0x0
// Checksum 0xf338044c, Offset: 0x2d68
// Size: 0xf48
function weapon_spawn_think() {
    cost = zm_weapons::get_weapon_cost(self.weapon);
    ammo_cost = zm_weapons::get_ammo_cost(self.weapon);
    is_grenade = self.weapon.isgrenadeweapon;
    shared_ammo_weapon = undefined;
    if (isdefined(self.parent_player) && !is_grenade) {
        self.parent_player notify(#"zm_bgb_secret_shopper", self);
    }
    second_endon = undefined;
    if (isdefined(self.stub)) {
        second_endon = "kill_trigger";
        self.first_time_triggered = self.stub.first_time_triggered;
    }
    onlyplayer = undefined;
    can_buy_weapon_extra_check_func = undefined;
    if (isdefined(self.stub) && isdefined(self.stub.trigger_per_player) && self.stub.trigger_per_player) {
        onlyplayer = self.parent_player;
        if (zm_loadout::is_placeable_mine(self.weapon)) {
            can_buy_weapon_extra_check_func = &placeable_mine_can_buy_weapon_extra_check_func;
        }
    }
    self thread zm_magicbox::decide_hide_show_hint("stop_hint_logic", second_endon, onlyplayer, can_buy_weapon_extra_check_func);
    if (is_grenade || zm_loadout::is_melee_weapon(self.weapon)) {
        self.first_time_triggered = 0;
        hint = zm_weapons::get_weapon_hint(self.weapon);
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
        if (!zm_utility::is_player_valid(player)) {
            player thread zm_utility::ignore_triggers(0.5);
            continue;
        }
        if (!player zm_magicbox::can_buy_weapon()) {
            wait 0.1;
            continue;
        }
        if (isdefined(self.stub) && isdefined(self.stub.require_look_from) && self.stub.require_look_from) {
            toplayer = player util::get_eye() - self.origin;
            forward = -1 * anglestoright(self.angles);
            dot = vectordot(toplayer, forward);
            if (dot < 0) {
                continue;
            }
        }
        if (player zm_loadout::has_powerup_weapon()) {
            wait 0.1;
            continue;
        }
        if (zm_trial_disable_buys::is_active()) {
            wait 0.1;
            continue;
        }
        player_has_weapon = player zm_weapons::has_weapon_or_upgrade(self.weapon);
        if (!player_has_weapon && isdefined(level.weapons_using_ammo_sharing) && level.weapons_using_ammo_sharing) {
            shared_ammo_weapon = player zm_weapons::get_shared_ammo_weapon(self.weapon);
            if (isdefined(shared_ammo_weapon)) {
                player_has_weapon = 1;
            }
        }
        cost = zm_weapons::get_weapon_cost(self.weapon);
        if (isdefined(player.var_95341110)) {
            foreach (func_override in player.var_95341110) {
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
            if (zm_utility::function_4b3c286(player, cost)) {
                if (self.first_time_triggered == 0) {
                    self show_all_weapon_buys(player, cost, ammo_cost, is_grenade);
                }
                player zm_score::minus_to_player_score(cost);
                if (isdefined(level.var_11e6fc03)) {
                    self [[ level.var_11e6fc03 ]](player);
                }
                level notify(#"weapon_bought", {#player:player, #weapon:self.weapon.name});
                player zm_stats::increment_challenge_stat("SURVIVALIST_BUY_WALLBUY");
                player zm_callings::function_7cafbdd3(19);
                player zm_callings::function_7cafbdd3(18);
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
                    weapon = player zm_weapons::weapon_give(weapon);
                }
                if (isdefined(weapon)) {
                    player notify(#"weapon_purchased", {#weapon:weapon});
                    player zm_stats::increment_client_stat("wallbuy_weapons_purchased");
                    player zm_stats::increment_player_stat("wallbuy_weapons_purchased");
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
                player zm_audio::create_and_play_dialog("general", "outofmoney");
            }
        } else {
            weapon = self.weapon;
            if (isdefined(shared_ammo_weapon)) {
                weapon = shared_ammo_weapon;
            }
            if (isdefined(self.stub) && isdefined(self.stub.hacked) && self.stub.hacked) {
                if (!player zm_weapons::has_upgrade(weapon)) {
                    ammo_cost = 4500;
                } else {
                    ammo_cost = zm_weapons::get_ammo_cost(weapon);
                }
            } else if (player zm_weapons::has_upgrade(weapon)) {
                ammo_cost = 4500;
            } else {
                ammo_cost = zm_weapons::get_ammo_cost(weapon);
            }
            if (player bgb::is_enabled(#"zm_bgb_secret_shopper") && !zm_weapons::is_wonder_weapon(weapon)) {
                ammo_cost = player zm_weapons::get_ammo_cost_for_weapon(weapon);
            }
            if (isdefined(player.var_a74bf397)) {
                foreach (func_override in player.var_a74bf397) {
                    n_cost = player [[ func_override ]](weapon, self);
                    if (isdefined(n_cost)) {
                        if (n_cost < ammo_cost) {
                            ammo_cost = n_cost;
                        }
                    }
                }
            }
            if (weapon.isriotshield) {
                zm_utility::play_sound_on_ent("no_purchase");
            } else if (zm_utility::function_4b3c286(player, ammo_cost)) {
                if (player zm_weapons::has_upgrade(weapon)) {
                    ammo_given = player zm_weapons::ammo_give(level.zombie_weapons[weapon].upgrade);
                } else {
                    ammo_given = player zm_weapons::ammo_give(weapon);
                }
                if (ammo_given) {
                    if (self.first_time_triggered == 0) {
                        self show_all_weapon_buys(player, cost, ammo_cost, is_grenade);
                    }
                    if (player zm_weapons::has_upgrade(weapon)) {
                        player zm_stats::increment_client_stat("upgraded_ammo_purchased");
                        player zm_stats::increment_player_stat("upgraded_ammo_purchased");
                    } else {
                        player zm_stats::increment_client_stat("ammo_purchased");
                        player zm_stats::increment_player_stat("ammo_purchased");
                    }
                    player thread zm_audio::create_and_play_dialog("ammo", "buy");
                    player zm_score::minus_to_player_score(ammo_cost);
                    if (player zm_weapons::has_upgrade(weapon)) {
                        w_upgrade = player zm_weapons::get_upgrade_weapon(weapon, 1);
                        if (player zm_utility::function_828cdc5(w_upgrade)) {
                            player zm_utility::function_2a166315(w_upgrade);
                        }
                    } else if (player zm_utility::function_828cdc5(weapon)) {
                        player zm_utility::function_2a166315(weapon);
                    }
                    if (isdefined(level.var_11e6fc03)) {
                        self [[ level.var_11e6fc03 ]](player);
                    }
                    bb::logpurchaseevent(player, self, ammo_cost, weapon.name, player zm_weapons::has_upgrade(weapon), "_ammo", "_purchase");
                    weaponindex = undefined;
                    if (isdefined(weapon)) {
                        weaponindex = matchrecordgetweaponindex(weapon);
                    }
                    if (isdefined(weaponindex)) {
                        player recordmapevent(7, gettime(), player.origin, level.round_number, weaponindex, cost);
                    }
                    wait 1;
                }
            } else {
                zm_utility::play_sound_on_ent("no_purchase");
                if (isdefined(level.custom_generic_deny_vo_func)) {
                    player [[ level.custom_generic_deny_vo_func ]]();
                } else {
                    player zm_audio::create_and_play_dialog("general", "outofmoney");
                }
            }
        }
        player notify(#"wallbuy_done");
        if (isdefined(self.stub) && isdefined(self.stub.prompt_and_visibility_func)) {
            self [[ self.stub.prompt_and_visibility_func ]](player);
        }
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0x6713b08d, Offset: 0x3cb8
// Size: 0x56
function should_upgrade_weapon(player) {
    if (isdefined(level.var_5d888f14)) {
        return [[ level.var_5d888f14 ]]();
    }
    if (player bgb::is_enabled(#"zm_bgb_wall_power")) {
        return 1;
    }
    return 0;
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 4, eflags: 0x0
// Checksum 0x99f2eb0e, Offset: 0x3d18
// Size: 0x4c6
function show_all_weapon_buys(player, cost, ammo_cost, is_grenade) {
    model = getent(self.target, "targetname");
    is_melee = zm_loadout::is_melee_weapon(self.weapon);
    if (isdefined(model)) {
        model thread weapon_show(player);
    } else if (isdefined(self.clientfieldname)) {
        level clientfield::set(self.clientfieldname, 1);
    }
    if (!isdefined(model)) {
        var_6e18625a = struct::get(self.target, "targetname");
        if (isdefined(var_6e18625a) && isdefined(var_6e18625a.target)) {
            var_67c8ead4 = getent(var_6e18625a.target, "targetname");
            var_67c8ead4 clientfield::set("wallbuy_reveal_fx", 1);
            var_67c8ead4 clientfield::set("wallbuy_ambient_fx", 0);
        }
    }
    self.first_time_triggered = 1;
    if (isdefined(self.stub)) {
        self.stub.first_time_triggered = 1;
    }
    if (!is_grenade && !is_melee) {
        self weapon_set_first_time_hint(cost, ammo_cost);
    }
    if (!(isdefined(level.dont_link_common_wallbuys) && level.dont_link_common_wallbuys) && isdefined(level._spawned_wallbuys)) {
        for (i = 0; i < level._spawned_wallbuys.size; i++) {
            wallbuy = level._spawned_wallbuys[i];
            if (isdefined(self.stub) && isdefined(wallbuy.trigger_stub) && self.stub.clientfieldname == wallbuy.trigger_stub.clientfieldname) {
                continue;
            }
            if (self.weapon == wallbuy.weapon) {
                if (isdefined(wallbuy.trigger_stub) && isdefined(wallbuy.trigger_stub.clientfieldname)) {
                    level clientfield::set(wallbuy.trigger_stub.clientfieldname, 1);
                    var_6e18625a = struct::get(wallbuy.target, "targetname");
                    if (isdefined(var_6e18625a) && isdefined(var_6e18625a.target)) {
                        var_67c8ead4 = getent(var_6e18625a.target, "targetname");
                        var_67c8ead4 clientfield::set("wallbuy_ambient_fx", 0);
                    }
                } else if (isdefined(wallbuy.target)) {
                    model = getent(wallbuy.target, "targetname");
                    if (isdefined(model)) {
                        model thread weapon_show(player);
                    }
                }
                if (isdefined(wallbuy.trigger_stub)) {
                    wallbuy.trigger_stub.first_time_triggered = 1;
                    if (isdefined(wallbuy.trigger_stub.trigger)) {
                        wallbuy.trigger_stub.trigger.first_time_triggered = 1;
                        if (!is_grenade && !is_melee) {
                            wallbuy.trigger_stub.trigger weapon_set_first_time_hint(cost, ammo_cost);
                        }
                    }
                    continue;
                }
                if (!is_grenade && !is_melee) {
                    wallbuy weapon_set_first_time_hint(cost, ammo_cost);
                }
            }
        }
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0xa8baba17, Offset: 0x41e8
// Size: 0x194
function weapon_show(player) {
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
// Params 0, eflags: 0x0
// Checksum 0xe2c5d271, Offset: 0x4388
// Size: 0x684
function function_9e8dccbe() {
    level flag::wait_till("zm_weapons_table_loaded");
    wallbuys = struct::get_array("wallbuy_autofill", "targetname");
    if (!isdefined(wallbuys) || wallbuys.size == 0 || !isdefined(level.var_723d0afa) || level.var_723d0afa.size == 0) {
        return;
    }
    level.use_autofill_wallbuy = 1;
    level.active_autofill_wallbuys = [];
    var_69e24b8b[#"all"] = getarraykeys(level.var_723d0afa[#"all"]);
    var_7e5108a3 = [];
    index = 0;
    foreach (wallbuy in wallbuys) {
        weapon_class = wallbuy.script_string;
        weapon = undefined;
        if (isdefined(weapon_class) && weapon_class != "") {
            if (!isdefined(var_69e24b8b[weapon_class]) && isdefined(level.var_723d0afa[weapon_class])) {
                var_69e24b8b[weapon_class] = getarraykeys(level.var_723d0afa[weapon_class]);
            }
            if (isdefined(var_69e24b8b[weapon_class])) {
                for (i = 0; i < var_69e24b8b[weapon_class].size; i++) {
                    if (level.var_723d0afa[#"all"][var_69e24b8b[weapon_class][i]]) {
                        weapon = var_69e24b8b[weapon_class][i];
                        level.var_723d0afa[#"all"][weapon] = 0;
                        break;
                    }
                }
            } else {
                continue;
            }
        } else {
            var_7e5108a3[var_7e5108a3.size] = wallbuy;
            continue;
        }
        if (!isdefined(weapon)) {
            continue;
        }
        wallbuy.zombie_weapon_upgrade = weapon.name;
        wallbuy.weapon = weapon;
        right = anglestoright(wallbuy.angles);
        wallbuy.origin -= right * 2;
        wallbuy.target = "autofill_wallbuy_" + index;
        target_struct = spawnstruct();
        target_struct.targetname = wallbuy.target;
        target_struct.angles = wallbuy.angles;
        target_struct.origin = wallbuy.origin;
        model = wallbuy.weapon.worldmodel;
        target_struct.model = model;
        target_struct struct::init();
        level.active_autofill_wallbuys[level.active_autofill_wallbuys.size] = wallbuy;
        index++;
    }
    foreach (wallbuy in var_7e5108a3) {
        weapon = undefined;
        for (i = 0; i < var_69e24b8b[#"all"].size; i++) {
            if (level.var_723d0afa[#"all"][var_69e24b8b[#"all"][i]]) {
                weapon = var_69e24b8b[#"all"][i];
                level.var_723d0afa[#"all"][weapon] = 0;
                break;
            }
        }
        if (!isdefined(weapon)) {
            break;
        }
        wallbuy.zombie_weapon_upgrade = weapon.name;
        wallbuy.weapon = weapon;
        right = anglestoright(wallbuy.angles);
        wallbuy.origin -= right * 2;
        wallbuy.target = "autofill_wallbuy_" + index;
        target_struct = spawnstruct();
        target_struct.targetname = wallbuy.target;
        target_struct.angles = wallbuy.angles;
        target_struct.origin = wallbuy.origin;
        model = wallbuy.weapon.worldmodel;
        target_struct.model = model;
        target_struct struct::init();
        level.active_autofill_wallbuys[level.active_autofill_wallbuys.size] = wallbuy;
        index++;
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0x5d47f09f, Offset: 0x4a18
// Size: 0xac
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
// Checksum 0x25feb757, Offset: 0x4ad0
// Size: 0xaa
function function_324bd2b6(func_override) {
    if (!isdefined(self.var_95341110)) {
        self.var_95341110 = [];
    }
    if (!isdefined(self.var_95341110)) {
        self.var_95341110 = [];
    } else if (!isarray(self.var_95341110)) {
        self.var_95341110 = array(self.var_95341110);
    }
    if (!isinarray(self.var_95341110, func_override)) {
        self.var_95341110[self.var_95341110.size] = func_override;
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0x9b1adc0e, Offset: 0x4b88
// Size: 0x24
function function_7dbd127f(func_override) {
    arrayremovevalue(self.var_95341110, func_override);
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0xa727383b, Offset: 0x4bb8
// Size: 0xaa
function function_c25b6154(func_override) {
    if (!isdefined(self.var_a74bf397)) {
        self.var_a74bf397 = [];
    }
    if (!isdefined(self.var_a74bf397)) {
        self.var_a74bf397 = [];
    } else if (!isarray(self.var_a74bf397)) {
        self.var_a74bf397 = array(self.var_a74bf397);
    }
    if (!isinarray(self.var_a74bf397, func_override)) {
        self.var_a74bf397[self.var_a74bf397.size] = func_override;
    }
}

// Namespace zm_wallbuy/zm_wallbuy
// Params 1, eflags: 0x0
// Checksum 0x60dc63be, Offset: 0x4c70
// Size: 0x24
function function_f62cb5a1(func_override) {
    arrayremovevalue(self.var_a74bf397, func_override);
}

