#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\zm_common\callings\zm_callings;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_items;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_progress;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_crafting;

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x2
// Checksum 0x7e3d3eca, Offset: 0x288
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_crafting", &__init__, &__main__, undefined);
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x0
// Checksum 0xa31288d3, Offset: 0x2d8
// Size: 0x34
function __init__() {
    level.var_f25c1c2a = [];
    level.crafting_components = [];
    function_76694477();
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x0
// Checksum 0x5af1e557, Offset: 0x318
// Size: 0xa4
function __main__() {
    function_48193e45();
    function_b028db56();
    setup_tables();
    if (zombie_utility::get_zombie_var(#"highlight_craftables") || zm_custom::function_5638f689(#"zmcraftingkeyline")) {
        level thread function_b3398e97();
    }
    /#
        thread devgui_think();
    #/
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x0
// Checksum 0xf422081e, Offset: 0x3c8
// Size: 0x98
function function_b028db56() {
    foundries = getscriptbundles("craftfoundry");
    foreach (foundry in foundries) {
        setup_craftfoundry(foundry);
    }
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x0
// Checksum 0xf7af2506, Offset: 0x468
// Size: 0x27c
function setup_craftfoundry(craftfoundry) {
    if (isdefined(craftfoundry)) {
        if (!(isdefined(craftfoundry.loaded) && craftfoundry.loaded)) {
            craftfoundry.loaded = 1;
            craftfoundry.blueprints = [];
            switch (craftfoundry.var_689a6873) {
            case 8:
                craftfoundry.blueprints[7] = function_ad17f25(craftfoundry.blueprint08);
            case 7:
                craftfoundry.blueprints[6] = function_ad17f25(craftfoundry.blueprint07);
            case 6:
                craftfoundry.blueprints[5] = function_ad17f25(craftfoundry.blueprint06);
            case 5:
                craftfoundry.blueprints[4] = function_ad17f25(craftfoundry.blueprint05);
            case 4:
                craftfoundry.blueprints[3] = function_ad17f25(craftfoundry.blueprint04);
            case 3:
                craftfoundry.blueprints[2] = function_ad17f25(craftfoundry.blueprint03);
            case 2:
                craftfoundry.blueprints[1] = function_ad17f25(craftfoundry.blueprint02);
            case 1:
                craftfoundry.blueprints[0] = function_ad17f25(craftfoundry.blueprint01);
                break;
            }
            /#
                function_99112475(craftfoundry);
            #/
        }
    }
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x0
// Checksum 0x6441a775, Offset: 0x6f0
// Size: 0x240
function setup_tables() {
    level.var_1c7ed52c = [];
    var_31a2ca07 = getentarray("crafting_trigger", "targetname");
    foreach (trigger in var_31a2ca07) {
        var_5a729415 = trigger.var_5a729415;
        if (isdefined(var_5a729415)) {
            trigger.craftfoundry = function_2a8b8a87(var_5a729415);
        } else {
            assertmsg("<dev string:x30>");
        }
        unitrigger = function_c67c58e(trigger);
        if (!isdefined(level.var_1c7ed52c[var_5a729415])) {
            level.var_1c7ed52c[var_5a729415] = [];
        }
        if (!isdefined(level.var_1c7ed52c[var_5a729415])) {
            level.var_1c7ed52c[var_5a729415] = [];
        } else if (!isarray(level.var_1c7ed52c[var_5a729415])) {
            level.var_1c7ed52c[var_5a729415] = array(level.var_1c7ed52c[var_5a729415]);
        }
        if (!isinarray(level.var_1c7ed52c[var_5a729415], unitrigger)) {
            level.var_1c7ed52c[var_5a729415][level.var_1c7ed52c[var_5a729415].size] = unitrigger;
        }
        unitrigger thread function_e1ebd88();
        /#
            function_755680e2(unitrigger);
        #/
    }
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x0
// Checksum 0x45210135, Offset: 0x938
// Size: 0x96
function reset_table() {
    assert(!(isdefined(self.registered) && self.registered), "<dev string:x53>");
    zm_unitrigger::register_static_unitrigger(self, &crafting_think);
    self function_95a899c8(#"craft");
    self.crafted = 0;
    self.blueprint.completed = 0;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x0
// Checksum 0xfb90bbd9, Offset: 0x9d8
// Size: 0x88
function function_2a8b8a87(name) {
    craftfoundry = struct::get_script_bundle("craftfoundry", name);
    if (isdefined(craftfoundry)) {
        craftfoundry.name = name;
        setup_craftfoundry(craftfoundry);
    } else {
        assertmsg("<dev string:x84>" + name);
    }
    return craftfoundry;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x0
// Checksum 0xda88e488, Offset: 0xa68
// Size: 0x4e0
function function_ad17f25(name) {
    blueprint = struct::get_script_bundle("craftblueprint", name);
    if (isdefined(blueprint)) {
        if (!(isdefined(blueprint.loaded) && blueprint.loaded)) {
            blueprint.loaded = 1;
            blueprint.name = name;
            blueprint.components = [];
            switch (blueprint.componentcount) {
            case 8:
                blueprint.components[7] = get_component(blueprint.var_361b57c6, blueprint);
            case 7:
                blueprint.components[6] = get_component(blueprint.var_a822c701, blueprint);
            case 6:
                blueprint.components[5] = get_component(blueprint.var_82204c98, blueprint);
            case 5:
                blueprint.components[4] = get_component(blueprint.var_f427bbd3, blueprint);
            case 4:
                blueprint.components[3] = get_component(blueprint.var_ce25416a, blueprint);
            case 3:
                blueprint.components[2] = get_component(blueprint.var_402cb0a5, blueprint);
            case 2:
                blueprint.components[1] = get_component(blueprint.var_1a2a363c, blueprint);
            case 1:
                blueprint.components[0] = get_component(blueprint.var_8c31a577, blueprint);
                break;
            }
            blueprint.var_29ca87bc = get_component(blueprint.result, blueprint);
            x = isdefined(blueprint.var_3581ee11) ? float(blueprint.var_3581ee11) : 0;
            y = isdefined(blueprint.var_f7f73a8) ? float(blueprint.var_f7f73a8) : 0;
            z = isdefined(blueprint.var_8186e2e3) ? float(blueprint.var_8186e2e3) : 0;
            blueprint.v_offset = (x, y, z);
            x = isdefined(blueprint.var_18f865cb) ? float(blueprint.var_18f865cb) : 0;
            y = isdefined(blueprint.var_376781d0) ? float(blueprint.var_376781d0) : 0;
            z = isdefined(blueprint.var_50dc8782) ? float(blueprint.var_50dc8782) : 0;
            blueprint.v_angles = (x, y, z);
            if (!isdefined(blueprint.var_a05722e9)) {
                blueprint.var_a05722e9 = "ERROR: Missing Prompt String";
            }
            function_8817c5c8(blueprint);
            /#
                function_fd3c53ff(blueprint);
            #/
        }
    } else {
        assertmsg("<dev string:x9c>" + name);
    }
    return blueprint;
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x0
// Checksum 0xb7973576, Offset: 0xf50
// Size: 0x260
function get_component(component, blueprint) {
    if (isstring(component) || ishash(component)) {
        component = getweapon(component);
    }
    if (!isdefined(level.crafting_components[component.name])) {
        if (component == level.weaponnone) {
            assertmsg("<dev string:xaf>");
        }
        /#
            function_7eea2573(component);
        #/
        level.crafting_components[component.name] = component;
    }
    if (isdefined(blueprint) && isdefined(blueprint.result)) {
        if (isdefined(blueprint.result.isriotshield) && blueprint.result.isriotshield) {
            if (!zm_custom::function_5638f689(#"zmshieldisenabled")) {
                a_items = getitemarray();
                foreach (e_item in a_items) {
                    if (e_item.item == component) {
                        e_item delete();
                    }
                }
            } else {
                zm_items::function_187a472b(component, &function_28b148c5);
            }
        } else {
            zm_items::function_187a472b(component, &function_21808c1);
        }
    }
    return level.crafting_components[component.name];
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x4
// Checksum 0x56907287, Offset: 0x11b8
// Size: 0xf0
function private function_b3398e97() {
    level waittill(#"all_players_spawned");
    a_items = getitemarray();
    foreach (e_item in a_items) {
        if (isdefined(e_item.item) && isinarray(level.crafting_components, e_item.item)) {
            e_item clientfield::set("highlight_item", 1);
        }
    }
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x0
// Checksum 0x6703485, Offset: 0x12b0
// Size: 0x5e
function function_8817c5c8(blueprint) {
    if (!isdefined(level.var_f25c1c2a[blueprint.name])) {
        blueprint.completed = 0;
        blueprint.builder = undefined;
        level.var_f25c1c2a[blueprint.name] = blueprint;
    }
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x0
// Checksum 0x14353859, Offset: 0x1318
// Size: 0xd8
function function_f941c8e0() {
    results = [];
    foreach (blueprint in level.var_f25c1c2a) {
        if (blueprint.completed) {
            if (!isdefined(results)) {
                results = [];
            } else if (!isarray(results)) {
                results = array(results);
            }
            results[results.size] = blueprint;
        }
    }
    return results;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x0
// Checksum 0x2c42743c, Offset: 0x13f8
// Size: 0x1a4
function function_514b5791(player) {
    results = [];
    if (isdefined(self.craftfoundry.blueprints)) {
        foreach (blueprint in self.craftfoundry.blueprints) {
            if (!blueprint.completed && function_15ce5b7d(player, blueprint)) {
                if (!isdefined(results)) {
                    results = [];
                } else if (!isarray(results)) {
                    results = array(results);
                }
                results[results.size] = blueprint;
            }
        }
    } else {
        blueprint = self.craftfoundry;
        if (!blueprint.completed && function_15ce5b7d(player, blueprint)) {
            if (!isdefined(results)) {
                results = [];
            } else if (!isarray(results)) {
                results = array(results);
            }
            results[results.size] = blueprint;
        }
    }
    return results;
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x0
// Checksum 0xa7917817, Offset: 0x15a8
// Size: 0x9a
function function_15ce5b7d(player, blueprint) {
    foreach (component in blueprint.components) {
        if (!zm_items::player_has(player, component)) {
            return false;
        }
    }
    return true;
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x0
// Checksum 0x308d2303, Offset: 0x1650
// Size: 0xa8
function function_358a5543(player, blueprint) {
    foreach (component in blueprint.components) {
        if (zm_items::player_has(player, component)) {
            zm_items::player_take(player, component);
        }
    }
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x0
// Checksum 0x6d2d2cb7, Offset: 0x1700
// Size: 0x11c
function function_48193e45() {
    level.var_131cc740 = zm_progress::function_77f3eafe(&function_c86f70dc, &function_98f07e7b, &function_cb510f0e, &function_f6c8ed66, &function_3442d29f, &function_e2981d9d);
    level.var_d10f3114 = zm_progress::function_77f3eafe(&function_c86f70dc, &function_98f07e7b, &function_cb510f0e, &function_f6c8ed66, &function_3442d29f, &function_e2981d9d);
    zm_progress::function_6d677d88(level.var_d10f3114, level.weaponnone);
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x0
// Checksum 0x7f28ab84, Offset: 0x1828
// Size: 0xa8
function function_c86f70dc(player, unitrigger) {
    if (isdefined(unitrigger.locked) && unitrigger.locked) {
        return false;
    }
    blueprints = unitrigger function_514b5791(player);
    if (blueprints.size < 1) {
        return false;
    }
    if (isdefined(unitrigger.blueprint.locked) && unitrigger.blueprint.locked) {
        return false;
    }
    return true;
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x0
// Checksum 0xd8d005ce, Offset: 0x18d8
// Size: 0x18
function function_98f07e7b(player, unitrigger) {
    return true;
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x0
// Checksum 0x79a8ba10, Offset: 0x18f8
// Size: 0x5c
function function_cb510f0e(player, unitrigger) {
    unitrigger.locked = 1;
    unitrigger.blueprint.locked = 1;
    player playsound(#"hash_1fff2aa71bff91fa");
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x0
// Checksum 0x5e82de69, Offset: 0x1960
// Size: 0x4c
function function_f6c8ed66(player, unitrigger) {
    player notify(#"crafting_fail");
    player playsound(#"hash_15b7f680d9f65b62");
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x0
// Checksum 0xe503d4b0, Offset: 0x19b8
// Size: 0x4c
function function_3442d29f(player, unitrigger) {
    player notify(#"crafting_success");
    player playsound(#"hash_421a00cb329b2a45");
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x0
// Checksum 0x5a99f0fc, Offset: 0x1a10
// Size: 0x36
function function_e2981d9d(player, unitrigger) {
    unitrigger.locked = 0;
    unitrigger.blueprint.locked = 0;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x0
// Checksum 0xb02c8db, Offset: 0x1a50
// Size: 0x7c
function function_1308deb1(weapon) {
    if (zm_equipment::is_equipment(weapon)) {
        if (zm_equipment::is_limited(weapon) && zm_equipment::limited_in_use(weapon)) {
            return true;
        }
        return false;
    }
    return !zm_weapons::limited_weapon_below_quota(weapon, undefined);
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x0
// Checksum 0x87f2aecc, Offset: 0x1ad8
// Size: 0x52
function function_3130e451(weapon) {
    if (zm_equipment::is_equipment(weapon)) {
        return zm_equipment::is_player_equipment(weapon);
    }
    return self hasweapon(weapon);
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x0
// Checksum 0x3439e4db, Offset: 0x1b38
// Size: 0x36
function function_fed11d50(weapon) {
    if (isdefined(self.var_d7be0f57)) {
        return array::contains(self.var_d7be0f57, weapon);
    }
    return 0;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x0
// Checksum 0xdd6b966b, Offset: 0x1b78
// Size: 0xc0
function function_1659474(player) {
    can_use = self.stub function_a6df8122(player);
    if (isdefined(self.stub.cost) && self.stub.cost != 0) {
        self sethintstring(self.stub.hint_string, self.stub.cost);
    } else {
        self sethintstring(self.stub.hint_string);
    }
    return can_use;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x0
// Checksum 0x7fb491f1, Offset: 0x1c40
// Size: 0x808
function function_c67c58e(trig) {
    if (!isdefined(trig)) {
        return;
    }
    unitrigger_stub = spawnstruct();
    unitrigger_stub.craftfoundry = trig.craftfoundry;
    if (zm_utility::get_story() == 1 && isdefined(trig.target2)) {
        unitrigger_stub.var_45887d3 = getent(trig.target2, "targetname");
        unitrigger_stub.var_45887d3 ghost();
    }
    if (zm_utility::get_story() == 1 && isdefined(trig.target3)) {
        unitrigger_stub.var_ff209ee5 = getent(trig.target3, "targetname");
        unitrigger_stub.var_ff209ee5 ghost();
    }
    angles = trig.script_angles;
    if (!isdefined(angles)) {
        angles = (0, 0, 0);
    }
    unitrigger_stub.origin = trig.origin + anglestoright(angles) * -6;
    unitrigger_stub.angles = trig.angles;
    if (isdefined(trig.script_angles)) {
        unitrigger_stub.angles = trig.script_angles;
    }
    unitrigger_stub.delete_trigger = 1;
    unitrigger_stub.crafted = 0;
    unitrigger_stub.usetime = int(3000);
    if (isdefined(self.usetime)) {
        unitrigger_stub.usetime = self.usetime;
    } else if (isdefined(trig.usetime)) {
        unitrigger_stub.usetime = trig.usetime;
    }
    tmins = trig getmins();
    tmaxs = trig getmaxs();
    tsize = tmaxs - tmins;
    if (isdefined(trig.script_depth)) {
        unitrigger_stub.script_length = trig.script_depth;
    } else {
        unitrigger_stub.script_length = tsize[1];
    }
    if (isdefined(trig.script_width)) {
        unitrigger_stub.script_width = trig.script_width;
    } else {
        unitrigger_stub.script_width = tsize[0];
    }
    if (isdefined(trig.script_height)) {
        unitrigger_stub.script_height = trig.script_height;
    } else {
        unitrigger_stub.script_height = tsize[2];
    }
    unitrigger_stub.target = trig.target;
    unitrigger_stub.targetname = trig.targetname;
    unitrigger_stub.script_noteworthy = trig.script_noteworthy;
    unitrigger_stub.script_parameters = trig.script_parameters;
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.hint_string = #"hash_a502ccb8fec4c7a";
    unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    unitrigger_stub.require_look_at = 1;
    unitrigger_stub.require_look_toward = 0;
    zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
    unitrigger_stub.prompt_and_visibility_func = &function_1659474;
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &crafting_think);
    unitrigger_stub.piece_trigger = trig;
    trig.trigger_stub = unitrigger_stub;
    if (isdefined(trig.zombie_weapon_upgrade)) {
        unitrigger_stub.zombie_weapon_upgrade = getweapon(trig.zombie_weapon_upgrade);
    }
    if (isdefined(unitrigger_stub.target)) {
        m_target = getent(unitrigger_stub.target, "targetname");
        if (isdefined(m_target)) {
            unitrigger_stub.model = m_target;
            if (isdefined(unitrigger_stub.zombie_weapon_upgrade)) {
                unitrigger_stub.model useweaponhidetags(unitrigger_stub.zombie_weapon_upgrade);
            }
            if (isdefined(unitrigger_stub.model.script_parameters)) {
                a_utm_params = strtok(unitrigger_stub.model.script_parameters, " ");
                foreach (param in a_utm_params) {
                    if (param == "starts_visible") {
                        b_start_visible = 1;
                        continue;
                    }
                    if (param == "starts_empty") {
                        b_start_empty = 1;
                    }
                }
            }
            if (b_start_visible !== 1) {
                unitrigger_stub.model ghost();
                unitrigger_stub.model notsolid();
            }
        }
    }
    if (isdefined(unitrigger_stub.model) && b_start_empty === 1) {
        for (i = 0; i < unitrigger_stub.craftablespawn.a_piecespawns.size; i++) {
            if (isdefined(unitrigger_stub.craftablespawn.a_piecespawns[i].tag_name)) {
                if (unitrigger_stub.craftablespawn.a_piecespawns[i].crafted !== 1) {
                    unitrigger_stub.model hidepart(unitrigger_stub.craftablespawn.a_piecespawns[i].tag_name);
                    continue;
                }
                unitrigger_stub.model showpart(unitrigger_stub.craftablespawn.a_piecespawns[i].tag_name);
            }
        }
    }
    if (unitrigger_stub.delete_trigger) {
        trig delete();
    }
    unitrigger_stub function_95a899c8(#"craft");
    return unitrigger_stub;
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x0
// Checksum 0x56f29eab, Offset: 0x2450
// Size: 0x22c
function function_eb54488b(modelname, blueprint) {
    if (isdefined(self.stub)) {
        s_crafting = self.stub;
    } else {
        s_crafting = self;
    }
    if (!isdefined(s_crafting.model)) {
        s_model = struct::get(s_crafting.target, "targetname");
        if (isdefined(s_model)) {
            m_spawn = spawn("script_model", s_model.origin);
            m_spawn.origin += blueprint.v_offset;
            if (isdefined(s_crafting.v_origin_offset)) {
                m_spawn.origin += s_crafting.v_origin_offset;
            }
            m_spawn.angles = s_model.angles;
            m_spawn.angles += blueprint.v_angles;
            if (isdefined(s_crafting.v_angle_offset)) {
                m_spawn.angles += s_crafting.v_angle_offset;
            }
            m_spawn setmodel(modelname);
            s_crafting.model = m_spawn;
            s_crafting.model notsolid();
            s_crafting.model show();
        } else {
            assertmsg("<dev string:xcb>");
        }
        return;
    }
    s_crafting.model notsolid();
    s_crafting.model show();
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x4
// Checksum 0x5e44f75c, Offset: 0x2688
// Size: 0x70
function private function_e1ebd88() {
    self endon(#"death");
    while (isdefined(self)) {
        event = self waittill(#"unitrigger_activated");
        player = event.player;
        self thread function_d6e92409(player);
    }
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x4
// Checksum 0x83be6a4, Offset: 0x2700
// Size: 0x108
function private function_d6e92409(player) {
    self notify(#"hash_295a022a1c72a359");
    self endon(#"hash_295a022a1c72a359");
    self endon(#"unitrigger_deactivated");
    player endon(#"death");
    player.crafting_melee = 0;
    while (isdefined(player)) {
        melee_now = player meleebuttonpressed();
        if (melee_now && !player.crafting_melee) {
            if (isdefined(self.var_c5c70403) && isdefined(level.var_10947565[self.var_c5c70403].var_c334d7f7)) {
                self [[ level.var_10947565[self.var_c5c70403].var_c334d7f7 ]](player);
            }
        }
        player.crafting_melee = melee_now;
        waitframe(1);
    }
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x0
// Checksum 0x534b5059, Offset: 0x2810
// Size: 0xb8
function function_4b55c808(var_778cfb02) {
    if (!isdefined(level.var_1c7ed52c[var_778cfb02])) {
        return;
    }
    foreach (trigger in level.var_1c7ed52c[var_778cfb02]) {
        trigger.locked = 1;
        level thread zm_unitrigger::unregister_unitrigger(trigger);
    }
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x0
// Checksum 0x22daecf6, Offset: 0x28d0
// Size: 0x1b2
function function_80bf4df3(var_778cfb02, func) {
    if (!isdefined(level.var_1c7ed52c[var_778cfb02])) {
        return;
    }
    foreach (trigger in level.var_1c7ed52c[var_778cfb02]) {
        if (!isdefined(trigger.craftfoundry.callback_funcs)) {
            trigger.craftfoundry.callback_funcs = [];
        }
        if (!isdefined(trigger.craftfoundry.callback_funcs)) {
            trigger.craftfoundry.callback_funcs = [];
        } else if (!isarray(trigger.craftfoundry.callback_funcs)) {
            trigger.craftfoundry.callback_funcs = array(trigger.craftfoundry.callback_funcs);
        }
        if (!isinarray(trigger.craftfoundry.callback_funcs, func)) {
            trigger.craftfoundry.callback_funcs[trigger.craftfoundry.callback_funcs.size] = func;
        }
    }
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x0
// Checksum 0x1c2c07e5, Offset: 0x2a90
// Size: 0xdc
function function_28b148c5(e_holder, w_item) {
    if (isdefined(w_item.gadgetreadysoundplayer)) {
        self thread zm_audio::create_and_play_dialog("shield_pickup", w_item.gadgetreadysoundplayer);
    } else {
        self thread zm_audio::create_and_play_dialog("shield_piece", "pickup");
    }
    self playsound(#"hash_230737b2535a3374");
    if (w_item.var_86344180 !== "") {
        level zm_ui_inventory::function_31a39683(hash(w_item.var_86344180), 1);
    }
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x0
// Checksum 0xd81c9272, Offset: 0x2b78
// Size: 0xf4
function function_21808c1(e_holder, w_item) {
    if (w_item.var_86344180 !== "") {
        level zm_ui_inventory::function_31a39683(hash(w_item.var_86344180), 1);
    }
    if (isdefined(w_item.gadgetreadysoundplayer)) {
        self thread zm_audio::create_and_play_dialog("component_pickup", w_item.gadgetreadysoundplayer);
        return;
    }
    if (isdefined(w_item.var_cbf7a606)) {
        self thread zm_audio::create_and_play_dialog("component_pickup", w_item.var_cbf7a606);
        return;
    }
    self thread zm_audio::create_and_play_dialog("component_pickup", "generic");
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x4
// Checksum 0xd8b48268, Offset: 0x2c78
// Size: 0x214
function private function_76694477() {
    if (!isdefined(level.var_10947565)) {
        level.var_10947565 = [];
    }
    function_4dcd6b5d(#"craft", &function_c559314f, &function_b901c58e, &function_44eca91, &function_c72f8096);
    function_4dcd6b5d(#"persistent_buy", &function_1fbd29bb, &function_d688e612, &function_44eca91);
    function_4dcd6b5d(#"buy_once_then_box", &function_e08d24c9, &function_9f6fb0c8, &function_86d005a);
    function_4dcd6b5d(#"one_time_craft", &function_b1f31b9c, &function_405b03ed, &function_ba705bfd);
    function_4dcd6b5d(#"spawn_as_ingredient", &function_b1f31b9c, &function_405b03ed, &function_4242de6a);
    function_4dcd6b5d(#"spawn_as_item", &function_b1f31b9c, &function_405b03ed, &function_75563084);
}

// Namespace zm_crafting/zm_crafting
// Params 5, eflags: 0x4
// Checksum 0x7c58e8b, Offset: 0x2e98
// Size: 0xae
function private function_4dcd6b5d(state, var_d94e2d42, var_b60a4813, var_fb187067, var_c334d7f7) {
    var_c5c70403 = spawnstruct();
    var_c5c70403.name = state;
    var_c5c70403.var_d94e2d42 = var_d94e2d42;
    var_c5c70403.var_b60a4813 = var_b60a4813;
    var_c5c70403.var_c334d7f7 = var_c334d7f7;
    var_c5c70403.var_fb187067 = var_fb187067;
    level.var_10947565[state] = var_c5c70403;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x4
// Checksum 0xd70711ec, Offset: 0x2f50
// Size: 0xd4
function private function_95a899c8(state) {
    self.var_c5c70403 = state;
    if (!isdefined(level.var_10947565[self.var_c5c70403])) {
        /#
            if (ishash(state)) {
                state = "<dev string:x100>" + function_15979fa9(state);
            }
            assertmsg("<dev string:x102>" + state);
        #/
        return;
    }
    if (isdefined(level.var_10947565[self.var_c5c70403].var_fb187067)) {
        self [[ level.var_10947565[self.var_c5c70403].var_fb187067 ]]();
    }
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x0
// Checksum 0xde7f26a9, Offset: 0x3030
// Size: 0x174
function function_a6df8122(player) {
    if (isdefined(self.locked) && self.locked) {
        self.hint_string = "";
        return 0;
    }
    if (player laststand::player_is_in_laststand() || player zm_utility::in_revive_trigger()) {
        self.hint_string = "";
        return 0;
    }
    if (player zm_utility::is_drinking() && !(isdefined(player.var_885c20e3) && player.var_885c20e3)) {
        self.hint_string = "";
        return 0;
    }
    initial_current_weapon = player getcurrentweapon();
    current_weapon = zm_weapons::get_nonalternate_weapon(initial_current_weapon);
    if (zm_equipment::is_equipment(current_weapon)) {
        self.hint_string = "";
        return 0;
    }
    if (isdefined(self.var_c5c70403)) {
        return self [[ level.var_10947565[self.var_c5c70403].var_d94e2d42 ]](player);
    }
    self.hint_string = "";
    return 0;
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x0
// Checksum 0x6b6a7bb4, Offset: 0x31b0
// Size: 0x104
function crafting_think() {
    self notify(#"crafting_think");
    self endon(#"crafting_think", #"kill_trigger", #"death");
    while (isdefined(self)) {
        waitresult = self waittill(#"trigger");
        player = waitresult.activator;
        level notify(#"crafting_started", {#unitrigger:self, #activator:player});
        if (isdefined(self.stub.var_c5c70403)) {
            self [[ level.var_10947565[self.stub.var_c5c70403].var_b60a4813 ]](player);
        }
    }
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x32c0
// Size: 0x4
function private function_44eca91() {
    
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x4
// Checksum 0xdac9b4b4, Offset: 0x32d0
// Size: 0x1c
function private function_b1f31b9c(player) {
    self.hint_string = "";
    return false;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x4
// Checksum 0xb7a6f2bc, Offset: 0x32f8
// Size: 0xc
function private function_405b03ed(player) {
    
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x4
// Checksum 0x830bbd4, Offset: 0x3310
// Size: 0x396
function private function_c559314f(player) {
    blueprints = function_514b5791(player);
    var_f79e087f = blueprints.size;
    if (!isdefined(self.blueprint) || self.var_f79e087f !== var_f79e087f) {
        self.blueprint = self.craftfoundry;
        if (blueprints.size) {
            if (!isdefined(self.var_319cb9f8)) {
                self.var_319cb9f8 = 0;
            }
            if (self.var_319cb9f8 >= blueprints.size) {
                self.var_319cb9f8 = 0;
            }
            self.blueprint = blueprints[self.var_319cb9f8];
        }
        self.var_f79e087f = var_f79e087f;
    }
    if (blueprints.size < 1 || !array::contains(blueprints, self.blueprint)) {
        self.hint_string = #"hash_64cb545dd18c607";
        if (zm_utility::get_story() == 1 && isdefined(self.var_45887d3) && isdefined(self.var_45887d3.is_visible) && self.var_45887d3.is_visible) {
            self.var_45887d3 ghost();
            self.var_45887d3.is_visible = undefined;
        }
        return true;
    }
    if (isdefined(self.blueprint.locked) && self.blueprint.locked) {
        self.hint_string = "";
        return false;
    }
    if (blueprints.size > 1 && isdefined(self.blueprint.var_e8670b5c)) {
        self.hint_string = self.blueprint.var_e8670b5c;
    } else {
        self.hint_string = self.blueprint.var_a05722e9;
    }
    if (zm_utility::get_story() == 1 && isdefined(self.var_45887d3)) {
        if (isdefined(self.blueprint.mdlblueprint)) {
            if (self.blueprint.mdlblueprint !== self.var_45887d3) {
                self.var_45887d3 setmodel(self.blueprint.mdlblueprint);
                self.var_45887d3 show();
                self.var_45887d3.is_visible = 1;
            } else if (!(isdefined(self.var_45887d3.is_visible) && self.var_45887d3.is_visible)) {
                self.var_45887d3 show();
                self.var_45887d3.is_visible = 1;
            }
        } else if (isdefined(self.var_45887d3.is_visible) && self.var_45887d3.is_visible) {
            self.var_45887d3 ghost();
            self.var_45887d3.is_visible = undefined;
        }
    }
    return true;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x4
// Checksum 0xbda6ec45, Offset: 0x36b0
// Size: 0x102
function private function_c72f8096(player) {
    if (self.crafted) {
        return;
    }
    if (!isdefined(self.blueprint)) {
        return;
    }
    if (isdefined(self.blueprint.locked) && self.blueprint.locked) {
        return;
    }
    blueprints = function_514b5791(player);
    var_f79e087f = blueprints.size;
    if (self.var_f79e087f != var_f79e087f) {
        return;
    }
    self.blueprint = self.craftfoundry;
    if (blueprints.size) {
        if (!isdefined(self.var_319cb9f8)) {
            self.var_319cb9f8 = 0;
        }
        self.var_319cb9f8++;
        if (self.var_319cb9f8 >= blueprints.size) {
            self.var_319cb9f8 = 0;
        }
        self.blueprint = blueprints[self.var_319cb9f8];
    }
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x4
// Checksum 0x14451700, Offset: 0x37c0
// Size: 0x4b4
function private function_b901c58e(player) {
    if (self.stub.crafted) {
        return;
    }
    if (!isdefined(self.stub.blueprint)) {
        return;
    }
    silent = 0;
    initial_current_weapon = player getcurrentweapon();
    current_weapon = zm_weapons::get_nonalternate_weapon(initial_current_weapon);
    if (current_weapon.isheroweapon || current_weapon.isgadget || current_weapon.isriotshield) {
        silent = 1;
    }
    if (silent) {
        progress_result = zm_progress::progress_think(player, level.var_d10f3114);
    } else {
        progress_result = zm_progress::progress_think(player, level.var_131cc740);
    }
    self notify(#"hash_6db03c91467a21f5", {#b_completed:progress_result});
    if (progress_result) {
        self.stub.crafted = 1;
        player_crafted = player;
        self.stub.blueprint.completed = 1;
        if (isdefined(self.stub.blueprint.var_d8ba2e08) && self.stub.blueprint.var_d8ba2e08) {
            function_358a5543(player, self.stub.blueprint);
        }
        level notify(#"blueprint_completed", {#blueprint:self.stub.blueprint, #produced:self.stub.blueprint.var_29ca87bc, #player:player});
        player notify(#"blueprint_completed", {#blueprint:self.stub.blueprint, #produced:self.stub.blueprint.var_29ca87bc});
        if (self.stub.blueprint.var_898b0f1f === "persistent_buy" || self.stub.blueprint.var_898b0f1f === "buy_once_then_box" || self.stub.blueprint.var_898b0f1f === "spawn_as_ingredient") {
            function_eb54488b(self.stub.blueprint.var_29ca87bc.worldmodel, self.stub.blueprint);
        }
        if (isdefined(player_crafted)) {
            player_crafted playsound(#"zmb_craftable_complete");
            if (isdefined(self.stub.blueprint.name)) {
                player_crafted thread zm_audio::create_and_play_dialog("build_complete", self.stub.blueprint.name);
            }
        }
        if (isdefined(self.stub.craftfoundry.callback_funcs)) {
            foreach (func in self.stub.craftfoundry.callback_funcs) {
                self thread [[ func ]](player);
            }
        }
        self.stub function_95a899c8(self.stub.blueprint.var_898b0f1f);
    }
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x0
// Checksum 0x33c351af, Offset: 0x3c80
// Size: 0x1fc
function function_c9b27eac(player) {
    if (self.crafted) {
        return;
    }
    if (!isdefined(player)) {
        player = array::random(level.players);
    }
    if (!isdefined(self.blueprint)) {
        self.blueprint = self.craftfoundry;
    }
    a_s_blueprints = function_514b5791(player);
    self.var_f79e087f = a_s_blueprints.size;
    self.crafted = 1;
    self.blueprint.completed = 1;
    if (self.blueprint.var_898b0f1f === "persistent_buy" || self.blueprint.var_898b0f1f === "buy_once_then_box" || self.blueprint.var_898b0f1f === "spawn_as_ingredient") {
        function_eb54488b(self.blueprint.var_29ca87bc.worldmodel, self.blueprint);
    }
    if (isdefined(self.craftfoundry.callback_funcs)) {
        foreach (func in self.craftfoundry.callback_funcs) {
            self thread [[ func ]](player);
        }
    }
    if (isdefined(self.blueprint.var_898b0f1f)) {
        self function_95a899c8(self.blueprint.var_898b0f1f);
    }
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x4
// Checksum 0xa2a18324, Offset: 0x3e88
// Size: 0x1c
function private function_ba705bfd() {
    thread zm_unitrigger::unregister_unitrigger(self);
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x4
// Checksum 0x9415d50e, Offset: 0x3eb0
// Size: 0x134
function private function_4242de6a() {
    v_origin = self.origin;
    v_angles = self.angles;
    if (!isdefined(self.model)) {
        s_model = struct::get(self.target, "targetname");
        if (isdefined(s_model)) {
            v_origin = s_model.origin;
            if (isdefined(self.v_origin_offset)) {
                v_origin += self.v_origin_offset;
            }
            v_angles = s_model.angles;
            if (isdefined(self.v_angle_offset)) {
                v_angles += self.v_angle_offset;
            }
        }
    } else {
        v_origin = self.model.origin;
        v_angles = self.model.angles;
    }
    zm_items::spawn_item(self.blueprint.var_29ca87bc, v_origin, v_angles);
    thread zm_unitrigger::unregister_unitrigger(self);
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x4
// Checksum 0x77308475, Offset: 0x3ff0
// Size: 0x114
function private function_75563084() {
    v_origin = self.origin;
    v_angles = self.angles;
    if (!isdefined(self.model)) {
        s_model = struct::get(self.target, "targetname");
        if (isdefined(s_model)) {
            v_origin = s_model.origin;
            if (isdefined(self.v_origin_offset)) {
                v_origin += self.v_origin_offset;
            }
            v_angles = s_model.angles;
            if (isdefined(self.v_angle_offset)) {
                v_angles += self.v_angle_offset;
            }
        }
    } else {
        self.model notsolid();
        self.model show();
    }
    thread zm_unitrigger::unregister_unitrigger(self);
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x4
// Checksum 0xfe64ea91, Offset: 0x4110
// Size: 0x2e8
function private function_1fbd29bb(player) {
    if (player function_1308deb1(self.blueprint.var_29ca87bc)) {
        self.hint_string = #"hash_718d32f9e8cea17";
        self.cost = undefined;
        return true;
    }
    if (player function_3130e451(self.blueprint.var_29ca87bc)) {
        if (isdefined(self.blueprint.var_29ca87bc.isriotshield) && self.blueprint.var_29ca87bc.isriotshield && isdefined(player.player_shield_reset_health) && isdefined(player.var_dc5406eb) && player.var_dc5406eb) {
            self.hint_string = #"zombie/repair_shield";
            var_53b23667 = 1;
        } else {
            self.hint_string = #"hash_53fd856df9288be7";
            self.cost = undefined;
            return true;
        }
    }
    if (isdefined(self.blueprint.var_59f45085) && self.blueprint.var_59f45085 && !player function_fed11d50(self.blueprint.var_29ca87bc) || isdefined(level.var_69baaca7) && level.var_69baaca7) {
        self.hint_string = isdefined(self.blueprint.var_e80643cc) ? self.blueprint.var_e80643cc : "";
        self.cost = undefined;
    } else if (zm_trial_disable_buys::is_active()) {
        self.hint_string = #"hash_55d25caf8f7bbb2f";
    } else {
        if (isdefined(player.talisman_shield_price) && self.blueprint.var_29ca87bc.isriotshield) {
            var_1f098a3d = player.talisman_shield_price;
        } else {
            var_1f098a3d = 0;
        }
        if (!(isdefined(var_53b23667) && var_53b23667)) {
            self.hint_string = self.blueprint.var_822291f2;
        }
        self.cost = zm_weapons::get_weapon_cost(self.blueprint.var_29ca87bc) - var_1f098a3d;
    }
    if (isdefined(level.var_7d1641bd)) {
        self [[ level.var_7d1641bd ]](player);
    }
    return true;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x4
// Checksum 0xa1dbd136, Offset: 0x4400
// Size: 0x71c
function private function_d688e612(player) {
    if (isdefined(level.var_80774e14)) {
        if (!(isdefined(self [[ level.var_80774e14 ]](player)) && self [[ level.var_80774e14 ]](player))) {
            return;
        }
    }
    if (!(isdefined(self.stub.crafted) && self.stub.crafted)) {
        self.stub.hint_string = "";
        self sethintstring(self.stub.hint_string);
        return;
    }
    if (player != self.parent_player) {
        return;
    }
    if (!zm_utility::is_player_valid(player)) {
        player thread zm_utility::ignore_triggers(0.5);
        return;
    }
    if (player function_3130e451(self.stub.blueprint.var_29ca87bc)) {
        if (isdefined(self.stub.blueprint.var_29ca87bc.isriotshield) && self.stub.blueprint.var_29ca87bc.isriotshield && isdefined(player.player_shield_reset_health) && isdefined(player.var_dc5406eb) && player.var_dc5406eb) {
            var_4c05b350 = 1;
        } else {
            return;
        }
    }
    if (player function_1308deb1(self.stub.blueprint.var_29ca87bc)) {
        self.stub.hint_string = "";
        self sethintstring(self.stub.hint_string);
        return;
    }
    if (isdefined(player.talisman_shield_price) && self.stub.blueprint.var_29ca87bc.isriotshield) {
        var_1f098a3d = player.talisman_shield_price;
    } else {
        var_1f098a3d = 0;
    }
    var_80437059 = zm_weapons::get_weapon_cost(self.stub.blueprint.var_29ca87bc) - var_1f098a3d;
    if (isdefined(var_80437059) && var_80437059 > 0) {
        if (isdefined(self.stub.blueprint.var_59f45085) && self.stub.blueprint.var_59f45085 && !player function_fed11d50(self.stub.blueprint.var_29ca87bc)) {
            if (!isdefined(player.var_d7be0f57)) {
                player.var_d7be0f57 = [];
            }
            array::add(player.var_d7be0f57, self.stub.blueprint.var_29ca87bc, 0);
        } else if (zm_trial_disable_buys::is_active()) {
            return;
        } else if (player zm_score::can_player_purchase(var_80437059)) {
            player zm_score::minus_to_player_score(var_80437059);
        } else {
            zm_utility::play_sound_on_ent("no_purchase");
            player zm_audio::create_and_play_dialog("general", "outofmoney");
            return;
        }
    }
    if (isdefined(self.stub.blueprint.var_cb060aab)) {
        if (!isdefined(player.var_61a067a2)) {
            player.var_61a067a2 = [];
        }
        if (!(isdefined(player.var_61a067a2[self.stub.blueprint.var_29ca87bc]) && player.var_61a067a2[self.stub.blueprint.var_29ca87bc])) {
            player thread zm_equipment::show_hint_text(self.stub.blueprint.var_cb060aab);
            player.var_61a067a2[self.stub.blueprint.var_29ca87bc] = 1;
        }
    }
    if (isdefined(self.stub.blueprint.var_29ca87bc.isriotshield) && self.stub.blueprint.var_29ca87bc.isriotshield) {
        if (isdefined(var_4c05b350) && var_4c05b350) {
            player [[ player.player_shield_reset_health ]](undefined, 1);
        } else if (isdefined(player.hasriotshield) && player.hasriotshield && isdefined(player.weaponriotshield)) {
            player zm_weapons::weapon_take(player.weaponriotshield);
        }
    }
    if (!(isdefined(var_4c05b350) && var_4c05b350)) {
        player zm_weapons::weapon_give(self.stub.blueprint.var_29ca87bc);
    }
    player notify(#"hash_77d44943fb143b18", {#weapon:self.stub.blueprint.var_29ca87bc});
    player zm_callings::function_7cafbdd3(18);
    self.stub.bought = 1;
    self.stub.hint_string = "";
    self.stub.cost = undefined;
    self sethintstring(self.stub.hint_string);
    player zm_stats::track_craftables_pickedup(self.stub.blueprint.var_29ca87bc);
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x4
// Checksum 0xb17bfb61, Offset: 0x4b28
// Size: 0x44
function private function_86d005a() {
    if (isdefined(self.model)) {
        self.model notsolid();
        self.model show();
    }
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x4
// Checksum 0xd4d2f80, Offset: 0x4b78
// Size: 0xa2
function private function_e08d24c9(player) {
    if (player function_1308deb1(self.blueprint.var_29ca87bc)) {
        self.hint_string = #"hash_7b4e31b02c13ed59";
        return true;
    } else if (isdefined(self.bought) && self.bought) {
        self.hint_string = #"hash_48157c44f8771b6c";
        return true;
    }
    self.hint_string = self.blueprint.var_822291f2;
    return true;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x4
// Checksum 0xdd3d78f9, Offset: 0x4c28
// Size: 0x274
function private function_9f6fb0c8(player) {
    if (isdefined(self.stub.bought) && self.stub.bought) {
        return;
    }
    current_weapon = player getcurrentweapon();
    if (zm_loadout::is_placeable_mine(current_weapon) || zm_equipment::is_equipment_that_blocks_purchase(current_weapon)) {
        return;
    }
    if (!(isdefined(self.stub.crafted) && self.stub.crafted)) {
        self.stub.hint_string = "";
        self sethintstring(self.stub.hint_string);
        return;
    }
    if (!zm_utility::is_player_valid(player)) {
        player thread zm_utility::ignore_triggers(0.5);
        return;
    }
    if (player != self.parent_player) {
        return;
    }
    if (isdefined(self.stub.model)) {
    }
    if (!player function_1308deb1(self.stub.blueprint.var_29ca87bc)) {
        player zm_weapons::weapon_give(self.stub.blueprint.var_29ca87bc);
        zm_weapons::function_55d25350(self.stub.blueprint.var_29ca87bc);
        self.stub.bought = 1;
    }
    if (player function_1308deb1(self.stub.blueprint.var_29ca87bc)) {
        self.stub.hint_string = #"hash_7b4e31b02c13ed59";
    } else {
        self.stub.hint_string = #"hash_48157c44f8771b6c";
    }
    self sethintstring(self.stub.hint_string);
}

/#

    // Namespace zm_crafting/zm_crafting
    // Params 1, eflags: 0x0
    // Checksum 0x7c16fe1e, Offset: 0x4ea8
    // Size: 0x134
    function function_755680e2(unitrigger) {
        if (!isdefined(level.var_b837b47d)) {
            level.var_b837b47d = [];
        }
        if (!isdefined(level.var_6ca0ca9e)) {
            level.var_6ca0ca9e = 0;
        }
        table_id = level.var_6ca0ca9e;
        level.var_6ca0ca9e++;
        level.var_b837b47d[table_id] = unitrigger;
        name = unitrigger.craftfoundry.name;
        if (unitrigger.craftfoundry.displayname != "<dev string:x11a>") {
            name = unitrigger.craftfoundry.displayname;
        }
        str_cmd = "<dev string:x11b>" + table_id + "<dev string:x14b>" + name + "<dev string:x14e>" + table_id + "<dev string:x175>";
        adddebugcommand(str_cmd);
    }

    // Namespace zm_crafting/zm_crafting
    // Params 1, eflags: 0x0
    // Checksum 0x8adc1962, Offset: 0x4fe8
    // Size: 0x10
    function function_99112475(foundry) {
        
    }

    // Namespace zm_crafting/zm_crafting
    // Params 1, eflags: 0x0
    // Checksum 0x75f3c583, Offset: 0x5000
    // Size: 0xd0
    function function_fd3c53ff(blueprint) {
        name = blueprint.name;
        if (blueprint.displayname != "<dev string:x11a>") {
            name = blueprint.displayname;
        }
        foreach (component in blueprint.components) {
            function_9b000b47(name, component);
        }
    }

    // Namespace zm_crafting/zm_crafting
    // Params 2, eflags: 0x0
    // Checksum 0x5a590ad5, Offset: 0x50d8
    // Size: 0x8c
    function function_9b000b47(var_d1b19212, component) {
        name = getweaponname(component);
        str_cmd = "<dev string:x178>" + var_d1b19212 + "<dev string:x19e>" + name + "<dev string:x1a5>" + name + "<dev string:x175>";
        adddebugcommand(str_cmd);
    }

    // Namespace zm_crafting/zm_crafting
    // Params 1, eflags: 0x0
    // Checksum 0x3bfac7a9, Offset: 0x5170
    // Size: 0x10
    function function_7eea2573(component) {
        
    }

    // Namespace zm_crafting/zm_crafting
    // Params 0, eflags: 0x0
    // Checksum 0xa791ac9d, Offset: 0x5188
    // Size: 0xf4
    function devgui_get_players() {
        var_aa0b46fd = getdvarstring(#"hash_7c8c0c3f35357a53");
        if (var_aa0b46fd != "<dev string:x11a>") {
            player_id = int(var_aa0b46fd);
            if (player_id > 0 && player_id <= 4 && isdefined(getplayers()[player_id - 1])) {
                result = [];
                result[player_id - 1] = getplayers()[player_id - 1];
                return result;
            }
        }
        return getplayers();
    }

    // Namespace zm_crafting/zm_crafting
    // Params 0, eflags: 0x0
    // Checksum 0x8abf733c, Offset: 0x5288
    // Size: 0x256
    function devgui_think() {
        setdvar(#"hash_7c8c0c3f35357a53", "<dev string:x11a>");
        str_cmd = "<dev string:x1c7>";
        adddebugcommand(str_cmd);
        for (i = 1; i <= 4; i++) {
            str_cmd = "<dev string:x212>" + i + "<dev string:x23d>" + i + "<dev string:x23f>" + i + "<dev string:x175>";
            adddebugcommand(str_cmd);
        }
        while (true) {
            var_ad3f5d0 = getdvarstring(#"hash_43086839e587cc6c");
            if (var_ad3f5d0 != "<dev string:x11a>") {
                table_id = int(var_ad3f5d0);
                array::thread_all(devgui_get_players(), &function_8512d4df, table_id);
                setdvar(#"hash_43086839e587cc6c", "<dev string:x11a>");
            }
            component = getdvarstring(#"hash_3a357be22156749e");
            if (component != "<dev string:x11a>") {
                w_comp = get_component(component);
                array::thread_all(devgui_get_players(), &function_38b14e61, w_comp);
                setdvar(#"hash_3a357be22156749e", "<dev string:x11a>");
            }
            wait 1;
        }
    }

    // Namespace zm_crafting/zm_crafting
    // Params 1, eflags: 0x0
    // Checksum 0xe21c7a54, Offset: 0x54e8
    // Size: 0x24
    function function_38b14e61(w_comp) {
        self giveweapon(w_comp);
    }

    // Namespace zm_crafting/zm_crafting
    // Params 1, eflags: 0x0
    // Checksum 0x8ac02ecf, Offset: 0x5518
    // Size: 0x1e4
    function function_8512d4df(table_id) {
        unitrigger = level.var_b837b47d[table_id];
        entnum = self getentitynumber();
        origin = unitrigger.origin;
        forward = anglestoforward(unitrigger.angles);
        right = anglestoright(unitrigger.angles);
        var_d9191ee9 = vectortoangles(forward * -1);
        plorigin = origin + 48 * forward;
        switch (entnum) {
        case 0:
            plorigin += 16 * right;
            break;
        case 1:
            plorigin += 16 * forward;
            break;
        case 2:
            plorigin -= 16 * right;
            break;
        case 3:
            plorigin -= 16 * forward;
            break;
        }
        self setorigin(plorigin);
        self setplayerangles(var_d9191ee9);
    }

#/
