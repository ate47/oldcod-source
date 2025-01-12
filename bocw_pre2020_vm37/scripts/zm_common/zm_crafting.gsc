#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_challenges;
#using scripts\zm_common\zm_contracts;
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
// Params 0, eflags: 0x6
// Checksum 0x6d904077, Offset: 0x280
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"zm_crafting", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x5 linked
// Checksum 0xa70168b0, Offset: 0x2d8
// Size: 0x2c
function private function_70a657d8() {
    level.var_5df2581a = [];
    level.crafting_components = [];
    function_475a63eb();
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x5 linked
// Checksum 0xffa28eb6, Offset: 0x310
// Size: 0xa4
function private postinit() {
    function_7a8f3cbd();
    function_60a6c623();
    setup_tables();
    if (zombie_utility::function_d2dfacfd(#"highlight_craftables") || zm_custom::function_901b751c(#"zmcraftingkeyline")) {
        level thread function_40f32480();
    }
    /#
        thread devgui_think();
    #/
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x1 linked
// Checksum 0xa971501d, Offset: 0x3c0
// Size: 0xa8
function function_60a6c623() {
    foundries = getscriptbundles("craftfoundry");
    foreach (foundry in foundries) {
        setup_craftfoundry(foundry);
    }
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x1 linked
// Checksum 0x58c53c81, Offset: 0x470
// Size: 0x23c
function setup_craftfoundry(craftfoundry) {
    if (isdefined(craftfoundry)) {
        if (!is_true(craftfoundry.loaded)) {
            craftfoundry.loaded = 1;
            craftfoundry.blueprints = [];
            switch (craftfoundry.var_2a2adea3) {
            case 8:
                craftfoundry.blueprints[7] = function_b18074d0(craftfoundry.var_b81b4995);
            case 7:
                craftfoundry.blueprints[6] = function_b18074d0(craftfoundry.var_5e039567);
            case 6:
                craftfoundry.blueprints[5] = function_b18074d0(craftfoundry.var_b84049db);
            case 5:
                craftfoundry.blueprints[4] = function_b18074d0(craftfoundry.var_5dee9539);
            case 4:
                craftfoundry.blueprints[3] = function_b18074d0(craftfoundry.var_93b280c0);
            case 3:
                craftfoundry.blueprints[2] = function_b18074d0(craftfoundry.var_a980ac5c);
            case 2:
                craftfoundry.blueprints[1] = function_b18074d0(craftfoundry.var_339dfcd);
            case 1:
                craftfoundry.blueprints[0] = function_b18074d0(craftfoundry.var_110b7b70);
                break;
            }
            /#
                function_e197bb07(craftfoundry);
            #/
        }
    }
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x1 linked
// Checksum 0xbb787496, Offset: 0x6b8
// Size: 0x228
function setup_tables() {
    level.var_4fe2f84d = [];
    var_c443493d = getentarray("crafting_trigger", "targetname");
    foreach (trigger in var_c443493d) {
        var_6886faaa = trigger.var_6886faaa;
        if (isdefined(var_6886faaa)) {
            trigger.craftfoundry = function_c1552513(var_6886faaa);
        } else {
            assertmsg("<dev string:x38>");
        }
        unitrigger = function_f665fde0(trigger);
        if (!isdefined(level.var_4fe2f84d[var_6886faaa])) {
            level.var_4fe2f84d[var_6886faaa] = [];
        }
        if (!isdefined(level.var_4fe2f84d[var_6886faaa])) {
            level.var_4fe2f84d[var_6886faaa] = [];
        } else if (!isarray(level.var_4fe2f84d[var_6886faaa])) {
            level.var_4fe2f84d[var_6886faaa] = array(level.var_4fe2f84d[var_6886faaa]);
        }
        if (!isinarray(level.var_4fe2f84d[var_6886faaa], unitrigger)) {
            level.var_4fe2f84d[var_6886faaa][level.var_4fe2f84d[var_6886faaa].size] = unitrigger;
        }
        /#
            level thread function_3012605d(unitrigger);
        #/
    }
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x0
// Checksum 0xc3f0037f, Offset: 0x8e8
// Size: 0x96
function reset_table() {
    assert(!is_true(self.registered), "<dev string:x5e>");
    zm_unitrigger::register_static_unitrigger(self, &crafting_think);
    self function_35f5c90b(#"craft");
    self.crafted = 0;
    self.blueprint.completed = 0;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x1 linked
// Checksum 0xe1dfc62e, Offset: 0x988
// Size: 0x80
function function_c1552513(name) {
    craftfoundry = getscriptbundle(name);
    if (isdefined(craftfoundry)) {
        craftfoundry.name = name;
        setup_craftfoundry(craftfoundry);
    } else {
        assertmsg("<dev string:x92>" + name);
    }
    return craftfoundry;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x1 linked
// Checksum 0x4acba9e3, Offset: 0xa10
// Size: 0x478
function function_b18074d0(name) {
    blueprint = getscriptbundle(name);
    if (isdefined(blueprint)) {
        if (!is_true(blueprint.loaded)) {
            blueprint.loaded = 1;
            blueprint.name = name;
            blueprint.components = [];
            switch (blueprint.componentcount) {
            case 8:
                blueprint.components[7] = get_component(blueprint.var_f4d434cb, blueprint);
            case 7:
                blueprint.components[6] = get_component(blueprint.var_e71f1961, blueprint);
            case 6:
                blueprint.components[5] = get_component(blueprint.registerperk_packa_seepainterminate, blueprint);
            case 5:
                blueprint.components[4] = get_component(blueprint.var_4282502a, blueprint);
            case 4:
                blueprint.components[3] = get_component(blueprint.var_7b8e4241, blueprint);
            case 3:
                blueprint.components[2] = get_component(blueprint.var_2e0a273a, blueprint);
            case 2:
                blueprint.components[1] = get_component(blueprint.var_670f9944, blueprint);
            case 1:
                blueprint.components[0] = get_component(blueprint.var_99577dd3, blueprint);
                break;
            }
            blueprint.var_54a97edd = get_component(blueprint.result, blueprint);
            x = isdefined(blueprint.var_2206e7ed) ? float(blueprint.var_2206e7ed) : 0;
            y = isdefined(blueprint.var_e414062) ? float(blueprint.var_e414062) : 0;
            z = isdefined(blueprint.var_3c809ce0) ? float(blueprint.var_3c809ce0) : 0;
            blueprint.v_offset = (x, y, z);
            x = isdefined(blueprint.prj_scr_round_pause) ? float(blueprint.prj_scr_round_pause) : 0;
            y = isdefined(blueprint.var_11928e3b) ? float(blueprint.var_11928e3b) : 0;
            z = isdefined(blueprint.var_71c8b937) ? float(blueprint.var_71c8b937) : 0;
            blueprint.v_angles = (x, y, z);
            if (!isdefined(blueprint.var_4dbc4aee)) {
                blueprint.var_4dbc4aee = "ERROR: Missing Prompt String";
            }
            function_728a82e0(blueprint);
            /#
                level thread function_e5af6b6e(blueprint);
            #/
        }
    } else {
        assertmsg("<dev string:xad>" + name);
    }
    return blueprint;
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x1 linked
// Checksum 0xd99330dc, Offset: 0xe90
// Size: 0x240
function get_component(component, blueprint) {
    if (isstring(component) || ishash(component)) {
        component = getweapon(component);
    }
    if (!isdefined(level.crafting_components[component.name])) {
        if (component == level.weaponnone) {
            assertmsg("<dev string:xc3>");
        }
        /#
            function_4765f5b3(component);
        #/
        level.crafting_components[component.name] = component;
    }
    if (isdefined(blueprint) && isdefined(blueprint.result)) {
        if (is_true(blueprint.result.isriotshield)) {
            if (!zm_custom::function_901b751c(#"zmshieldisenabled")) {
                a_items = getitemarray();
                foreach (e_item in a_items) {
                    if (e_item.item == component) {
                        e_item delete();
                    }
                }
            } else {
                zm_items::function_4d230236(component, &function_86531922);
            }
        } else {
            zm_items::function_4d230236(component, &function_d56724a6);
        }
    }
    return level.crafting_components[component.name];
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x5 linked
// Checksum 0xd7cb4608, Offset: 0x10d8
// Size: 0xf8
function private function_40f32480() {
    level waittill(#"all_players_spawned");
    a_items = getitemarray();
    foreach (e_item in a_items) {
        if (isdefined(e_item.item) && isinarray(level.crafting_components, e_item.item)) {
            e_item clientfield::set("highlight_item", 1);
        }
    }
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x1 linked
// Checksum 0x30a51bce, Offset: 0x11d8
// Size: 0x54
function function_728a82e0(blueprint) {
    if (!isdefined(level.var_5df2581a[blueprint.name])) {
        blueprint.completed = 0;
        blueprint.builder = undefined;
        level.var_5df2581a[blueprint.name] = blueprint;
    }
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x0
// Checksum 0x63bad261, Offset: 0x1238
// Size: 0xe2
function function_31d883d7() {
    results = [];
    foreach (blueprint in level.var_5df2581a) {
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
// Params 1, eflags: 0x1 linked
// Checksum 0x31e88b3, Offset: 0x1328
// Size: 0x1a6
function function_4165306b(player) {
    results = [];
    if (isdefined(self.craftfoundry.blueprints)) {
        foreach (blueprint in self.craftfoundry.blueprints) {
            if (!blueprint.completed && function_6d1e4410(player, blueprint)) {
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
        if (!blueprint.completed && function_6d1e4410(player, blueprint)) {
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
// Params 2, eflags: 0x1 linked
// Checksum 0xf85b7a5, Offset: 0x14d8
// Size: 0xaa
function function_6d1e4410(player, blueprint) {
    foreach (component in blueprint.components) {
        if (!zm_items::player_has(player, component)) {
            return false;
        }
    }
    return true;
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x1 linked
// Checksum 0xf963cdc4, Offset: 0x1590
// Size: 0xb8
function function_6f635422(player, blueprint) {
    foreach (component in blueprint.components) {
        if (zm_items::player_has(player, component)) {
            zm_items::player_take(player, component);
        }
    }
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x1 linked
// Checksum 0x527c67b5, Offset: 0x1650
// Size: 0x114
function function_7a8f3cbd() {
    level.var_90237ebd = zm_progress::function_53a680b8(&function_7362ecc8, &function_8962a3bb, &function_735c3a67, &function_f7dbfdf9, &function_d95a600f, &function_73f3bb03);
    level.var_98dad84e = zm_progress::function_53a680b8(&function_7362ecc8, &function_8962a3bb, &function_735c3a67, &function_f7dbfdf9, &function_d95a600f, &function_73f3bb03);
    zm_progress::function_163442cb(level.var_98dad84e, level.weaponnone);
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x1 linked
// Checksum 0xe5a6fcaf, Offset: 0x1770
// Size: 0x96
function function_7362ecc8(player, unitrigger) {
    if (is_true(unitrigger.locked)) {
        return false;
    }
    blueprints = unitrigger function_4165306b(player);
    if (blueprints.size < 1) {
        return false;
    }
    if (is_true(unitrigger.blueprint.locked)) {
        return false;
    }
    return true;
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x1 linked
// Checksum 0x253b1093, Offset: 0x1810
// Size: 0x18
function function_8962a3bb(*player, *unitrigger) {
    return true;
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x1 linked
// Checksum 0x9d4033e9, Offset: 0x1830
// Size: 0x5c
function function_735c3a67(player, unitrigger) {
    if (isdefined(player)) {
        unitrigger.locked = 1;
        unitrigger.blueprint.locked = 1;
        player playsound(#"hash_1fff2aa71bff91fa");
    }
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x1 linked
// Checksum 0xbe21c33, Offset: 0x1898
// Size: 0x54
function function_f7dbfdf9(player, *unitrigger) {
    if (isdefined(unitrigger)) {
        unitrigger notify(#"crafting_fail");
        unitrigger playsound(#"hash_15b7f680d9f65b62");
    }
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x1 linked
// Checksum 0xa5564cd4, Offset: 0x18f8
// Size: 0x54
function function_d95a600f(player, *unitrigger) {
    if (isdefined(unitrigger)) {
        unitrigger notify(#"crafting_success");
        unitrigger playsound(#"hash_421a00cb329b2a45");
    }
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x1 linked
// Checksum 0x5643ed9f, Offset: 0x1958
// Size: 0x32
function function_73f3bb03(*player, unitrigger) {
    unitrigger.locked = 0;
    unitrigger.blueprint.locked = 0;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x1 linked
// Checksum 0x4f7fac22, Offset: 0x1998
// Size: 0x7c
function function_7bffa1ac(weapon) {
    if (zm_equipment::is_equipment(weapon)) {
        if (zm_equipment::is_limited(weapon) && zm_equipment::limited_in_use(weapon)) {
            return true;
        }
        return false;
    }
    return !zm_weapons::limited_weapon_below_quota(weapon, undefined);
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x1 linked
// Checksum 0xbe06f193, Offset: 0x1a20
// Size: 0x52
function function_2d53738e(weapon) {
    if (zm_equipment::is_equipment(weapon)) {
        return zm_equipment::is_player_equipment(weapon);
    }
    return self hasweapon(weapon);
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x1 linked
// Checksum 0xde8db508, Offset: 0x1a80
// Size: 0x36
function function_48ce9379(weapon) {
    if (isdefined(self.var_4e90ce0c)) {
        return array::contains(self.var_4e90ce0c, weapon);
    }
    return 0;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x1 linked
// Checksum 0x49b72c92, Offset: 0x1ac0
// Size: 0x1b8
function function_126fc77c(player) {
    if (!isdefined(self.stub)) {
        /#
            iprintlnbold("<dev string:xe2>");
        #/
        return 0;
    }
    can_use = self.stub function_18f2be60(player);
    if (!isdefined(self.stub.hint_string)) {
        /#
            iprintlnbold("<dev string:x11e>");
        #/
        return can_use;
    }
    if (isdefined(level.var_a6f62e91) && isdefined(self.stub.cost) && self.stub [[ level.var_a6f62e91 ]](player, #"crafting_table")) {
        self sethintstringforplayer(player, self.stub.hint_string, self.stub.cost);
    } else if (isdefined(self.stub.cost) && self.stub.cost != 0) {
        self sethintstring(self.stub.hint_string, self.stub.cost);
    } else {
        self sethintstring(self.stub.hint_string);
    }
    return can_use;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x1 linked
// Checksum 0x87855efd, Offset: 0x1c80
// Size: 0x748
function function_f665fde0(trig) {
    if (!isdefined(trig)) {
        return;
    }
    unitrigger_stub = spawnstruct();
    unitrigger_stub.craftfoundry = trig.craftfoundry;
    if (zm_utility::get_story() == 1 && isdefined(trig.target2)) {
        unitrigger_stub.var_c2f40a58 = getent(trig.target2, "targetname");
        unitrigger_stub.var_c2f40a58 ghost();
    }
    if (zm_utility::get_story() == 1 && isdefined(trig.target3)) {
        unitrigger_stub.var_4f749ffe = getent(trig.target3, "targetname");
        unitrigger_stub.var_4f749ffe ghost();
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
    unitrigger_stub.script_string = trig.script_string;
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.hint_string = #"hash_a502ccb8fec4c7a";
    unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    unitrigger_stub.require_look_at = 1;
    unitrigger_stub.require_look_toward = 0;
    unitrigger_stub.var_c060d2c8 = 1;
    zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
    unitrigger_stub.prompt_and_visibility_func = &function_126fc77c;
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
    unitrigger_stub function_35f5c90b(#"craft");
    return unitrigger_stub;
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x1 linked
// Checksum 0xa89b66af, Offset: 0x23d0
// Size: 0x1fc
function function_987a472(modelname, blueprint) {
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
            assertmsg("<dev string:x14a>");
        }
        return;
    }
    s_crafting.model notsolid();
    s_crafting.model show();
}

// Namespace zm_crafting/button_bit_melee_pressed
// Params 0, eflags: 0x40
// Checksum 0xb34b92de, Offset: 0x25d8
// Size: 0xb0
function event_handler[button_bit_melee_pressed] player_melee() {
    player = self;
    if (!isdefined(player.useholdent) || !isdefined(player.useholdent.stub)) {
        return;
    }
    stub = player.useholdent.stub;
    if (isdefined(stub.var_90dfb0bf) && isdefined(level.var_b87dee47[stub.var_90dfb0bf].var_cb2020d8)) {
        stub [[ level.var_b87dee47[stub.var_90dfb0bf].var_cb2020d8 ]](player);
    }
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x1 linked
// Checksum 0x9fc0f135, Offset: 0x2690
// Size: 0xc0
function function_ca244624(var_55426150) {
    if (!isdefined(level.var_4fe2f84d[var_55426150])) {
        return;
    }
    foreach (trigger in level.var_4fe2f84d[var_55426150]) {
        trigger.locked = 1;
        level thread zm_unitrigger::unregister_unitrigger(trigger);
    }
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x0
// Checksum 0xbd726d06, Offset: 0x2758
// Size: 0x1a4
function function_d1f16587(var_55426150, func) {
    if (!isdefined(level.var_4fe2f84d[var_55426150])) {
        return;
    }
    foreach (trigger in level.var_4fe2f84d[var_55426150]) {
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
// Params 2, eflags: 0x1 linked
// Checksum 0xb78aebd0, Offset: 0x2908
// Size: 0xec
function function_86531922(*e_holder, w_item) {
    if (isdefined(w_item.gadgetreadysoundplayer)) {
        self thread zm_audio::create_and_play_dialog(#"shield_pickup", w_item.gadgetreadysoundplayer);
    } else {
        self thread zm_audio::create_and_play_dialog(#"shield_piece", #"pickup");
    }
    self playsound(#"hash_230737b2535a3374");
    if (w_item.var_f56ac2bd !== "") {
        level zm_ui_inventory::function_7df6bb60(hash(w_item.var_f56ac2bd), 1);
    }
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x1 linked
// Checksum 0x41c5affe, Offset: 0x2a00
// Size: 0x164
function function_d56724a6(*e_holder, w_item) {
    if (w_item.var_f56ac2bd !== "") {
        level zm_ui_inventory::function_7df6bb60(hash(w_item.var_f56ac2bd), 1);
    }
    if (isdefined(w_item.var_25bb96cc)) {
        self playsound(w_item.var_25bb96cc);
    } else {
        self playsound(#"hash_230737b2535a3374");
    }
    if (isdefined(w_item.gadgetreadysoundplayer)) {
        self thread zm_audio::create_and_play_dialog(#"component_pickup", w_item.gadgetreadysoundplayer);
        return;
    }
    if (isdefined(w_item.var_62a98b13)) {
        self thread zm_audio::create_and_play_dialog(#"component_pickup", w_item.var_62a98b13);
        return;
    }
    self thread zm_audio::create_and_play_dialog(#"component_pickup", #"generic");
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x5 linked
// Checksum 0x4c239205, Offset: 0x2b70
// Size: 0x214
function private function_475a63eb() {
    if (!isdefined(level.var_b87dee47)) {
        level.var_b87dee47 = [];
    }
    function_e1eeba22(#"craft", &function_8109ae21, &function_f37c4bb5, &function_b03ccfce, &function_d564a5c0);
    function_e1eeba22(#"persistent_buy", &function_9693e041, &function_df8ce6e2, &function_b03ccfce);
    function_e1eeba22(#"buy_once_then_box", &function_15d10d06, &function_42673a26, &function_6e16f902);
    function_e1eeba22(#"one_time_craft", &function_f189f7f, &function_5a4c40a2, &function_578c67bf);
    function_e1eeba22(#"spawn_as_ingredient", &function_f189f7f, &function_5a4c40a2, &function_3c45b116);
    function_e1eeba22(#"spawn_as_item", &function_f189f7f, &function_5a4c40a2, &function_230f6303);
}

// Namespace zm_crafting/zm_crafting
// Params 5, eflags: 0x5 linked
// Checksum 0x344aa4c6, Offset: 0x2d90
// Size: 0x90
function private function_e1eeba22(state, var_a3d8c117, var_ea7ebe1f, var_aee03b4c, var_cb2020d8) {
    var_90dfb0bf = spawnstruct();
    var_90dfb0bf.name = state;
    var_90dfb0bf.var_a3d8c117 = var_a3d8c117;
    var_90dfb0bf.var_ea7ebe1f = var_ea7ebe1f;
    var_90dfb0bf.var_cb2020d8 = var_cb2020d8;
    var_90dfb0bf.var_aee03b4c = var_aee03b4c;
    level.var_b87dee47[state] = var_90dfb0bf;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x5 linked
// Checksum 0xf5ccce27, Offset: 0x2e28
// Size: 0xdc
function private function_35f5c90b(state) {
    if (!isdefined(state)) {
        return;
    }
    self.var_90dfb0bf = state;
    if (!isdefined(level.var_b87dee47[self.var_90dfb0bf])) {
        /#
            if (ishash(state)) {
                state = "<dev string:x182>" + function_9e72a96(state);
            }
            assertmsg("<dev string:x187>" + state);
        #/
        return;
    }
    if (isdefined(level.var_b87dee47[self.var_90dfb0bf].var_aee03b4c)) {
        self [[ level.var_b87dee47[self.var_90dfb0bf].var_aee03b4c ]]();
    }
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x1 linked
// Checksum 0x917c576a, Offset: 0x2f10
// Size: 0x174
function function_18f2be60(player) {
    if (is_true(self.locked)) {
        self.hint_string = "";
        return 0;
    }
    if (player laststand::player_is_in_laststand() || player zm_utility::in_revive_trigger()) {
        self.hint_string = "";
        return 0;
    }
    if (player zm_utility::is_drinking() && !is_true(player.var_1f8802c9)) {
        self.hint_string = "";
        return 0;
    }
    initial_current_weapon = player getcurrentweapon();
    current_weapon = zm_weapons::get_nonalternate_weapon(initial_current_weapon);
    if (zm_equipment::is_equipment(current_weapon)) {
        self.hint_string = "";
        return 0;
    }
    if (isdefined(self.var_90dfb0bf)) {
        return self [[ level.var_b87dee47[self.var_90dfb0bf].var_a3d8c117 ]](player);
    }
    self.hint_string = "";
    return 0;
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x1 linked
// Checksum 0x8d161534, Offset: 0x3090
// Size: 0x10c
function crafting_think() {
    self notify(#"crafting_think");
    self endon(#"crafting_think", #"kill_trigger", #"death");
    while (isdefined(self)) {
        waitresult = self waittill(#"trigger");
        player = waitresult.activator;
        level notify(#"crafting_started", {#unitrigger:self, #activator:player});
        if (isdefined(self.stub.var_90dfb0bf)) {
            self [[ level.var_b87dee47[self.stub.var_90dfb0bf].var_ea7ebe1f ]](player);
        }
    }
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x31a8
// Size: 0x4
function private function_b03ccfce() {
    
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x5 linked
// Checksum 0xcfaa2f1f, Offset: 0x31b8
// Size: 0x1c
function private function_f189f7f(*player) {
    self.hint_string = "";
    return false;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x5 linked
// Checksum 0x9349d665, Offset: 0x31e0
// Size: 0xc
function private function_5a4c40a2(*player) {
    
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x5 linked
// Checksum 0x9d3d30f0, Offset: 0x31f8
// Size: 0x3a6
function private function_8109ae21(player) {
    blueprints = function_4165306b(player);
    var_9c8338de = blueprints.size;
    if (!isdefined(self.blueprint) || self.var_9c8338de !== var_9c8338de || is_true(self.blueprint.completed)) {
        self.blueprint = self.craftfoundry;
        if (blueprints.size) {
            if (!isdefined(self.var_c0df4857)) {
                self.var_c0df4857 = 0;
            }
            if (self.var_c0df4857 >= blueprints.size) {
                self.var_c0df4857 = 0;
            }
            self.blueprint = blueprints[self.var_c0df4857];
        }
        self.var_9c8338de = var_9c8338de;
    }
    if (blueprints.size < 1 || !array::contains(blueprints, self.blueprint)) {
        self.hint_string = #"hash_64cb545dd18c607";
        if (zm_utility::get_story() == 1 && isdefined(self.var_c2f40a58) && is_true(self.var_c2f40a58.is_visible)) {
            self.var_c2f40a58 ghost();
            self.var_c2f40a58.is_visible = undefined;
        }
        return true;
    }
    if (is_true(self.blueprint.locked)) {
        self.hint_string = "";
        return false;
    }
    if (blueprints.size > 1 && isdefined(self.blueprint.var_4050486a)) {
        self.hint_string = self.blueprint.var_4050486a;
    } else {
        self.hint_string = self.blueprint.var_4dbc4aee;
    }
    if (zm_utility::get_story() == 1 && isdefined(self.var_c2f40a58)) {
        if (isdefined(self.blueprint.var_db27a7f7)) {
            if (self.blueprint.var_db27a7f7 !== self.var_c2f40a58) {
                self.var_c2f40a58 setmodel(self.blueprint.var_db27a7f7);
                self.var_c2f40a58 show();
                self.var_c2f40a58.is_visible = 1;
            } else if (!is_true(self.var_c2f40a58.is_visible)) {
                self.var_c2f40a58 show();
                self.var_c2f40a58.is_visible = 1;
            }
        } else if (is_true(self.var_c2f40a58.is_visible)) {
            self.var_c2f40a58 ghost();
            self.var_c2f40a58.is_visible = undefined;
        }
    }
    return true;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x5 linked
// Checksum 0x25c1dd81, Offset: 0x35a8
// Size: 0xf6
function private function_d564a5c0(player) {
    if (self.crafted) {
        return;
    }
    if (!isdefined(self.blueprint)) {
        return;
    }
    if (is_true(self.blueprint.locked)) {
        return;
    }
    blueprints = function_4165306b(player);
    var_9c8338de = blueprints.size;
    if (self.var_9c8338de != var_9c8338de) {
        return;
    }
    self.blueprint = self.craftfoundry;
    if (blueprints.size) {
        if (!isdefined(self.var_c0df4857)) {
            self.var_c0df4857 = 0;
        }
        self.var_c0df4857++;
        if (self.var_c0df4857 >= blueprints.size) {
            self.var_c0df4857 = 0;
        }
        self.blueprint = blueprints[self.var_c0df4857];
    }
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x5 linked
// Checksum 0x7a273781, Offset: 0x36a8
// Size: 0x5fc
function private function_f37c4bb5(player) {
    if (self.stub.crafted) {
        return;
    }
    if (!isdefined(self.stub.blueprint)) {
        return;
    }
    var_c060d2c8 = self.stub.var_c060d2c8;
    silent = 0;
    initial_current_weapon = player getcurrentweapon();
    current_weapon = zm_weapons::get_nonalternate_weapon(initial_current_weapon);
    if (current_weapon.isheroweapon || current_weapon.isgadget || current_weapon.isriotshield) {
        silent = 1;
    }
    if (silent) {
        progress_result = zm_progress::progress_think(player, level.var_98dad84e, var_c060d2c8);
    } else {
        progress_result = zm_progress::progress_think(player, level.var_90237ebd, var_c060d2c8);
    }
    self notify(#"hash_6db03c91467a21f5", {#b_completed:progress_result});
    if (progress_result) {
        self.stub.crafted = 1;
        player_crafted = player;
        self.stub.blueprint.completed = 1;
        if (is_true(self.stub.blueprint.var_d8967a0c)) {
            function_6f635422(player, self.stub.blueprint);
        }
        level notify(#"blueprint_completed", {#blueprint:self.stub.blueprint, #produced:self.stub.blueprint.var_54a97edd, #player:player});
        player notify(#"blueprint_completed", {#blueprint:self.stub.blueprint, #produced:self.stub.blueprint.var_54a97edd});
        if (self.stub.blueprint.var_46309255 === "persistent_buy" || self.stub.blueprint.var_46309255 === "buy_once_then_box" || self.stub.blueprint.var_46309255 === "spawn_as_ingredient") {
            function_987a472(self.stub.blueprint.var_54a97edd.worldmodel, self.stub.blueprint);
        }
        if (isdefined(player_crafted)) {
            player_crafted playsound(#"zmb_craftable_complete");
            if (isdefined(self.stub.blueprint.name)) {
                player_crafted thread zm_audio::create_and_play_dialog(#"build_complete", self.stub.blueprint.name);
            }
        }
        if (isdefined(self.stub.craftfoundry.callback_funcs)) {
            foreach (func in self.stub.craftfoundry.callback_funcs) {
                self thread [[ func ]](player);
            }
        }
        if (isdefined(self.stub.blueprint.var_54a97edd) && is_true(self.stub.blueprint.var_54a97edd.isriotshield)) {
            foreach (e_player in getplayers()) {
                /#
                    e_player zm_challenges::debug_print("<dev string:x1a2>");
                #/
                e_player zm_stats::increment_challenge_stat(#"shields_built", undefined, 1);
            }
        }
        if (isdefined(self.stub.blueprint.var_46309255)) {
            self.stub function_35f5c90b(self.stub.blueprint.var_46309255);
        }
    }
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x0
// Checksum 0x615d64d8, Offset: 0x3cb0
// Size: 0x20c
function function_a187b293(player) {
    if (self.crafted) {
        return;
    }
    if (!isdefined(player)) {
        player = array::random(level.players);
    }
    if (!isdefined(self.blueprint)) {
        self.blueprint = self.craftfoundry;
    }
    a_s_blueprints = function_4165306b(player);
    self.var_9c8338de = a_s_blueprints.size;
    self.crafted = 1;
    self.blueprint.completed = 1;
    if (self.blueprint.var_46309255 === "persistent_buy" || self.blueprint.var_46309255 === "buy_once_then_box" || self.blueprint.var_46309255 === "spawn_as_ingredient") {
        function_987a472(self.blueprint.var_54a97edd.worldmodel, self.blueprint);
    }
    if (isdefined(self.craftfoundry.callback_funcs)) {
        foreach (func in self.craftfoundry.callback_funcs) {
            self thread [[ func ]](player);
        }
    }
    if (isdefined(self.blueprint.var_46309255)) {
        self function_35f5c90b(self.blueprint.var_46309255);
    }
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x5 linked
// Checksum 0x839c237, Offset: 0x3ec8
// Size: 0x1c
function private function_578c67bf() {
    thread zm_unitrigger::unregister_unitrigger(self);
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x5 linked
// Checksum 0x22567500, Offset: 0x3ef0
// Size: 0x12c
function private function_3c45b116() {
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
    zm_items::spawn_item(self.blueprint.var_54a97edd, v_origin, v_angles);
    thread zm_unitrigger::unregister_unitrigger(self);
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x5 linked
// Checksum 0x1e7b58f1, Offset: 0x4028
// Size: 0x114
function private function_230f6303() {
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
// Params 1, eflags: 0x5 linked
// Checksum 0x57a2de59, Offset: 0x4148
// Size: 0x454
function private function_9693e041(player) {
    if (player function_7bffa1ac(self.blueprint.var_54a97edd)) {
        self.hint_string = #"hash_718d32f9e8cea17";
        self.cost = undefined;
        return true;
    }
    if (player function_2d53738e(self.blueprint.var_54a97edd)) {
        if (is_true(self.var_ad7ae074)) {
            return true;
        }
        if (is_true(self.blueprint.var_54a97edd.isriotshield) && isdefined(player.player_shield_reset_health) && is_true(player.var_d3345483)) {
            self.cost = function_ceac3bf9(player, 1);
            str = self.blueprint.var_1238231a;
            var_e7ed2264 = function_c9163c5d(str);
            hint_str = player zm_utility::function_d6046228(str, var_e7ed2264);
            backup_str = player zm_utility::function_d6046228(#"zombie/repair_shield", #"hash_197687e8f04962c9");
            self.hint_string = isdefined(hint_str) ? hint_str : backup_str;
            _shad_turret_debug_server = 1;
        } else {
            self.hint_string = #"hash_53fd856df9288be7";
            self.cost = undefined;
            return true;
        }
    } else if (!player function_2d53738e(self.blueprint.var_54a97edd) && (is_true(self.blueprint.var_c028dcfe) && !player function_48ce9379(self.blueprint.var_54a97edd) || is_true(level.var_905507c3))) {
        str = self.blueprint.var_abd9b2d0;
        var_e7ed2264 = function_c9163c5d(str);
        hint_str = player zm_utility::function_d6046228(str, var_e7ed2264);
        self.hint_string = isdefined(hint_str) ? hint_str : "";
        self.cost = undefined;
    } else if (zm_trial_disable_buys::is_active()) {
        self.hint_string = #"hash_55d25caf8f7bbb2f";
    } else {
        if (!is_true(_shad_turret_debug_server)) {
            str = self.blueprint.var_391591d0;
            var_e7ed2264 = function_c9163c5d(str);
            self.hint_string = player zm_utility::function_d6046228(str, var_e7ed2264);
        }
        self.cost = function_ceac3bf9(player);
        if (self.cost == 0) {
            str = self.blueprint.var_abd9b2d0;
            var_e7ed2264 = function_c9163c5d(str);
            hint_str = player zm_utility::function_d6046228(str, var_e7ed2264);
            self.hint_string = isdefined(hint_str) ? hint_str : "";
            self.cost = undefined;
        }
    }
    if (isdefined(level.var_932a1afb)) {
        self [[ level.var_932a1afb ]](player);
    }
    return true;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x1 linked
// Checksum 0x1f2e8e6f, Offset: 0x45a8
// Size: 0x3c
function function_c9163c5d(str) {
    if (isdefined(str) && str != "") {
        str += "_KEYBOARD";
    }
    return str;
}

// Namespace zm_crafting/zm_crafting
// Params 2, eflags: 0x1 linked
// Checksum 0x85462979, Offset: 0x45f0
// Size: 0x1fa
function function_ceac3bf9(player, b_repaired = 0) {
    if (!isdefined(player.var_36ea3103)) {
        player.var_36ea3103 = 0;
    }
    if (isdefined(player.talisman_shield_price) && self.blueprint.var_54a97edd.isriotshield) {
        var_a185bd91 = player.talisman_shield_price;
    } else {
        var_a185bd91 = 0;
    }
    switch (player.var_36ea3103) {
    case 0:
        n_cost = 0;
        break;
    case 1:
        n_cost = 250;
        break;
    case 2:
        n_cost = 500;
        break;
    case 3:
        n_cost = 750;
        break;
    case 4:
        n_cost = 1000;
        break;
    case 5:
        n_cost = 1250;
        break;
    case 6:
        n_cost = 1500;
        break;
    case 7:
        n_cost = 2000;
        break;
    default:
        n_cost = player function_86cab486();
        break;
    }
    n_cost -= var_a185bd91;
    if (n_cost < 100) {
        n_cost = 100;
    }
    if (b_repaired) {
        n_cost = math::clamp(n_cost, 250, 2500);
    }
    return n_cost;
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x5 linked
// Checksum 0xadd2e35, Offset: 0x47f8
// Size: 0xce
function private function_86cab486() {
    if (!isdefined(self.var_76a15cfd)) {
        self.var_76a15cfd = 0;
    }
    if (self.var_3b6a5556 !== level.round_number) {
        n_cost = 2500;
    } else {
        switch (self.var_76a15cfd) {
        case 0:
            n_cost = 2500;
            break;
        case 1:
            n_cost = 3000;
            break;
        case 2:
            n_cost = 4000;
            break;
        default:
            n_cost = 5000;
            break;
        }
    }
    return n_cost;
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x1 linked
// Checksum 0x42d89cba, Offset: 0x48d0
// Size: 0x68
function function_fccf9f0d() {
    if (self.var_36ea3103 >= 8) {
        if (self.var_3b6a5556 !== level.round_number) {
            self.var_76a15cfd = 1;
            self.var_3b6a5556 = level.round_number;
        } else {
            self.var_76a15cfd++;
        }
    }
    self.var_36ea3103++;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x5 linked
// Checksum 0x18ba6c95, Offset: 0x4940
// Size: 0x7b0
function private function_df8ce6e2(player) {
    if (isdefined(level.var_f7d93c4e)) {
        if (!is_true(self [[ level.var_f7d93c4e ]](player))) {
            return;
        }
    }
    if (!is_true(self.stub.crafted)) {
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
    if (isdefined(level.var_a6f62e91)) {
        if (self [[ level.var_a6f62e91 ]](player, #"crafting_table")) {
            return;
        }
    }
    if (player function_2d53738e(self.stub.blueprint.var_54a97edd)) {
        if (is_true(self.stub.blueprint.var_54a97edd.isriotshield) && isdefined(player.player_shield_reset_health) && is_true(player.var_d3345483)) {
            var_d97673ff = 1;
        } else {
            return;
        }
    }
    if (player function_7bffa1ac(self.stub.blueprint.var_54a97edd)) {
        self.stub.hint_string = "";
        self sethintstring(self.stub.hint_string);
        return;
    }
    if (is_true(var_d97673ff)) {
        var_f66d1847 = self.stub function_ceac3bf9(player, 1);
    } else {
        var_f66d1847 = self.stub function_ceac3bf9(player);
    }
    if (isdefined(var_f66d1847) && var_f66d1847 > 0) {
        if (is_true(self.stub.blueprint.var_c028dcfe) && !player function_48ce9379(self.stub.blueprint.var_54a97edd)) {
            if (!isdefined(player.var_4e90ce0c)) {
                player.var_4e90ce0c = [];
            }
            array::add(player.var_4e90ce0c, self.stub.blueprint.var_54a97edd, 0);
            player thread function_fccf9f0d();
        } else if (zm_trial_disable_buys::is_active()) {
            return;
        } else if (player zm_score::can_player_purchase(var_f66d1847)) {
            player thread function_fccf9f0d();
            player zm_score::minus_to_player_score(var_f66d1847);
            player zm_utility::play_sound_on_ent("purchase");
        } else {
            zm_utility::play_sound_on_ent("no_purchase");
            player zm_audio::create_and_play_dialog(#"general", #"outofmoney");
            return;
        }
    }
    if (isdefined(self.stub.blueprint.var_fe8a5e39)) {
        if (!isdefined(player.var_2f3339f0)) {
            player.var_2f3339f0 = [];
        }
        if (!is_true(player.var_2f3339f0[self.stub.blueprint.var_54a97edd])) {
            player thread zm_equipment::show_hint_text(self.stub.blueprint.var_fe8a5e39);
            player.var_2f3339f0[self.stub.blueprint.var_54a97edd] = 1;
        }
    }
    if (is_true(self.stub.blueprint.var_54a97edd.isriotshield)) {
        if (is_true(var_d97673ff)) {
            player [[ player.player_shield_reset_health ]](undefined, 1);
        } else if (is_true(player.hasriotshield) && isdefined(player.weaponriotshield)) {
            player zm_weapons::weapon_take(player.weaponriotshield);
        }
    }
    if (!is_true(var_d97673ff)) {
        player zm_weapons::weapon_give(self.stub.blueprint.var_54a97edd);
    } else {
        player playsound(#"hash_230737b2535a3374");
    }
    player notify(#"hash_77d44943fb143b18", {#weapon:self.stub.blueprint.var_54a97edd});
    player zm_stats::function_c0c6ab19(#"weapons_bought", 1, 1);
    player contracts::increment_zm_contract(#"contract_zm_weapons_bought", 1, #"zstandard");
    self.stub.bought = 1;
    self.stub.hint_string = "";
    self.stub.cost = undefined;
    self sethintstring(self.stub.hint_string);
    self.stub.var_ad7ae074 = 1;
    self.stub thread function_d94efa98();
    player zm_stats::track_craftables_pickedup(self.stub.blueprint.var_54a97edd);
    if (isdefined(level.var_8c978b55)) {
        self [[ level.var_8c978b55 ]](player);
    }
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x5 linked
// Checksum 0x3c4c7184, Offset: 0x50f8
// Size: 0x46
function private function_d94efa98() {
    self endon(#"death");
    self notify("3e96e4291194b559");
    self endon("3e96e4291194b559");
    wait 5;
    self.var_ad7ae074 = undefined;
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x5 linked
// Checksum 0xc7cadf73, Offset: 0x5148
// Size: 0x44
function private function_6e16f902() {
    if (isdefined(self.model)) {
        self.model notsolid();
        self.model show();
    }
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x5 linked
// Checksum 0x3be36e2b, Offset: 0x5198
// Size: 0xde
function private function_15d10d06(player) {
    if (player function_7bffa1ac(self.blueprint.var_54a97edd)) {
        self.hint_string = #"hash_7b4e31b02c13ed59";
        return true;
    } else if (is_true(self.bought)) {
        self.hint_string = #"hash_48157c44f8771b6c";
        return true;
    }
    str = self.blueprint.var_391591d0;
    var_e7ed2264 = function_c9163c5d(str);
    self.hint_string = player zm_utility::function_d6046228(str, var_e7ed2264);
    return true;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x5 linked
// Checksum 0xe1747c17, Offset: 0x5280
// Size: 0x26c
function private function_42673a26(player) {
    if (is_true(self.stub.bought)) {
        return;
    }
    current_weapon = player getcurrentweapon();
    if (zm_loadout::is_placeable_mine(current_weapon) || zm_equipment::is_equipment_that_blocks_purchase(current_weapon)) {
        return;
    }
    if (!is_true(self.stub.crafted)) {
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
    if (!player function_7bffa1ac(self.stub.blueprint.var_54a97edd)) {
        player zm_weapons::weapon_give(self.stub.blueprint.var_54a97edd);
        zm_weapons::function_603af7a8(self.stub.blueprint.var_54a97edd);
        self.stub.bought = 1;
    }
    if (player function_7bffa1ac(self.stub.blueprint.var_54a97edd)) {
        self.stub.hint_string = #"hash_7b4e31b02c13ed59";
    } else {
        self.stub.hint_string = #"hash_48157c44f8771b6c";
    }
    self sethintstring(self.stub.hint_string);
}

/#

    // Namespace zm_crafting/zm_crafting
    // Params 1, eflags: 0x0
    // Checksum 0x7406ba97, Offset: 0x54f8
    // Size: 0x134
    function function_3012605d(unitrigger) {
        if (!isdefined(level.var_644b04e2)) {
            level.var_644b04e2 = [];
        }
        if (!isdefined(level.var_a9839862)) {
            level.var_a9839862 = 0;
        }
        table_id = level.var_a9839862;
        level.var_a9839862++;
        level.var_644b04e2[table_id] = unitrigger;
        name = unitrigger.craftfoundry.name;
        if (unitrigger.craftfoundry.displayname != "<dev string:x1c9>") {
            name = unitrigger.craftfoundry.displayname;
        }
        util::waittill_can_add_debug_command();
        str_cmd = "<dev string:x1cd>" + table_id + "<dev string:x200>" + name + "<dev string:x206>" + table_id + "<dev string:x230>";
        adddebugcommand(str_cmd);
    }

    // Namespace zm_crafting/zm_crafting
    // Params 1, eflags: 0x0
    // Checksum 0x5f51b29d, Offset: 0x5638
    // Size: 0x10
    function function_e197bb07(*foundry) {
        
    }

    // Namespace zm_crafting/zm_crafting
    // Params 1, eflags: 0x0
    // Checksum 0x8132d2bc, Offset: 0x5650
    // Size: 0xd0
    function function_e5af6b6e(blueprint) {
        name = blueprint.name;
        if (blueprint.displayname != "<dev string:x1c9>") {
            name = blueprint.displayname;
        }
        foreach (component in blueprint.components) {
            function_e9e4a1d0(name, component);
        }
    }

    // Namespace zm_crafting/zm_crafting
    // Params 2, eflags: 0x0
    // Checksum 0x99e768da, Offset: 0x5728
    // Size: 0xa4
    function function_e9e4a1d0(var_a13e8cac, component) {
        util::waittill_can_add_debug_command();
        name = getweaponname(component);
        str_cmd = "<dev string:x236>" + var_a13e8cac + "<dev string:x25f>" + name + "<dev string:x269>" + name + "<dev string:x230>";
        adddebugcommand(str_cmd);
    }

    // Namespace zm_crafting/zm_crafting
    // Params 1, eflags: 0x0
    // Checksum 0xb1b4a8b1, Offset: 0x57d8
    // Size: 0x10
    function function_4765f5b3(*component) {
        
    }

    // Namespace zm_crafting/zm_crafting
    // Params 0, eflags: 0x0
    // Checksum 0x4a1227a7, Offset: 0x57f0
    // Size: 0xf4
    function devgui_get_players() {
        var_4ab6b47 = getdvarstring(#"hash_7c8c0c3f35357a53");
        if (var_4ab6b47 != "<dev string:x1c9>") {
            player_id = int(var_4ab6b47);
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
    // Checksum 0x97b50843, Offset: 0x58f0
    // Size: 0x276
    function devgui_think() {
        setdvar(#"hash_7c8c0c3f35357a53", "<dev string:x1c9>");
        util::waittill_can_add_debug_command();
        str_cmd = "<dev string:x28e>";
        adddebugcommand(str_cmd);
        for (i = 1; i <= 4; i++) {
            util::waittill_can_add_debug_command();
            str_cmd = "<dev string:x2dc>" + i + "<dev string:x30a>" + i + "<dev string:x30f>" + i + "<dev string:x230>";
            adddebugcommand(str_cmd);
        }
        while (true) {
            var_cf5ebef8 = getdvarstring(#"hash_43086839e587cc6c");
            if (var_cf5ebef8 != "<dev string:x1c9>") {
                table_id = int(var_cf5ebef8);
                array::thread_all(devgui_get_players(), &function_fe738a08, table_id);
                setdvar(#"hash_43086839e587cc6c", "<dev string:x1c9>");
            }
            component = getdvarstring(#"hash_3a357be22156749e");
            if (component != "<dev string:x1c9>") {
                w_comp = get_component(component);
                array::thread_all(devgui_get_players(), &function_3e29352d, w_comp);
                setdvar(#"hash_3a357be22156749e", "<dev string:x1c9>");
            }
            wait 1;
        }
    }

    // Namespace zm_crafting/zm_crafting
    // Params 1, eflags: 0x0
    // Checksum 0x6b753526, Offset: 0x5b70
    // Size: 0x24
    function function_3e29352d(w_comp) {
        self giveweapon(w_comp);
    }

    // Namespace zm_crafting/zm_crafting
    // Params 1, eflags: 0x0
    // Checksum 0x3ccc4150, Offset: 0x5ba0
    // Size: 0x1dc
    function function_fe738a08(table_id) {
        unitrigger = level.var_644b04e2[table_id];
        entnum = self getentitynumber();
        origin = unitrigger.origin;
        forward = anglestoforward(unitrigger.angles);
        right = anglestoright(unitrigger.angles);
        var_21f5823e = vectortoangles(forward * -1);
        var_916d3dfe = origin + 48 * forward;
        switch (entnum) {
        case 0:
            var_916d3dfe += 16 * right;
            break;
        case 1:
            var_916d3dfe += 16 * forward;
            break;
        case 2:
            var_916d3dfe -= 16 * right;
            break;
        case 3:
            var_916d3dfe -= 16 * forward;
            break;
        }
        self setorigin(var_916d3dfe);
        self setplayerangles(var_21f5823e);
    }

#/
