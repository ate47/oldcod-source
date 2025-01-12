#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_lockdown_util;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_unitrigger;

// Namespace zm_unitrigger/zm_unitrigger
// Params 0, eflags: 0x2
// Checksum 0x1f0c49bb, Offset: 0x1a8
// Size: 0x54
function autoexec __init__system__() {
    system::register(#"zm_unitrigger", &__init__, &__main__, #"zm_zonemgr");
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 5, eflags: 0x0
// Checksum 0x3f2abc25, Offset: 0x208
// Size: 0x258
function create(var_bb047212 = "", var_184c4c2c = 64, func_unitrigger_logic = &function_d59c1914, var_8ae30aad, var_54896f3c = 0) {
    if (isvec(var_184c4c2c) || isarray(var_184c4c2c)) {
        s_unitrigger = self function_9916df24(var_184c4c2c[0], var_184c4c2c[1], var_184c4c2c[2], var_8ae30aad);
    } else {
        s_unitrigger = self function_87d8e33b(var_184c4c2c, var_8ae30aad);
    }
    function_ef58ce37(s_unitrigger, &function_db2979f9);
    if (var_54896f3c) {
        if (isfunctionptr(var_bb047212)) {
            function_2e5dcd8b(s_unitrigger, var_bb047212);
        } else if (getdvarint(#"zm_debug_ee", 0)) {
            unitrigger_set_hint_string(s_unitrigger, var_bb047212);
        } else {
            unitrigger_set_hint_string(s_unitrigger, "");
        }
    } else if (isfunctionptr(var_bb047212)) {
        function_2e5dcd8b(s_unitrigger, var_bb047212);
    } else {
        unitrigger_set_hint_string(s_unitrigger, var_bb047212);
    }
    s_unitrigger.related_parent = self;
    self.s_unitrigger = s_unitrigger;
    s_unitrigger.in_zone = self.in_zone;
    register_static_unitrigger(s_unitrigger, func_unitrigger_logic);
    return s_unitrigger;
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 3, eflags: 0x0
// Checksum 0xf365b69a, Offset: 0x468
// Size: 0x9a
function function_b7e350e6(var_bb047212, var_184c4c2c, var_54896f3c = 0) {
    self create(var_bb047212, var_184c4c2c, undefined, undefined, var_54896f3c);
    s_notify = self waittill(#"trigger_activated");
    unregister_unitrigger(self.s_unitrigger);
    self.s_unitrigger = undefined;
    return s_notify.e_who;
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 0, eflags: 0x0
// Checksum 0x52e736c0, Offset: 0x510
// Size: 0xa8
function function_d59c1914() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"trigger");
        e_player = waitresult.activator;
        if (!zm_utility::can_use(e_player)) {
            continue;
        }
        self.stub.related_parent notify(#"trigger_activated", {#e_who:e_player});
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 0, eflags: 0x0
// Checksum 0x81ad51b9, Offset: 0x5c0
// Size: 0xb0
function function_87bc0962() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"trigger");
        e_player = waitresult.activator;
        if (!zm_utility::can_use(e_player, 1)) {
            continue;
        }
        self.stub.related_parent notify(#"trigger_activated", {#activator:e_player});
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 0, eflags: 0x0
// Checksum 0xe9d1edc, Offset: 0x678
// Size: 0x1a4
function __init__() {
    if (!isdefined(level.var_62637326)) {
        level.var_62637326 = 1;
    }
    level._unitriggers = spawnstruct();
    level._unitriggers._deferredinitlist = [];
    level._unitriggers.trigger_pool = [];
    level._unitriggers.trigger_stubs = [];
    level._unitriggers.dynamic_stubs = [];
    level._unitriggers.largest_radius = 64;
    stubs_keys = array("unitrigger_radius", "unitrigger_radius_use", "unitrigger_box", "unitrigger_box_use");
    stubs = [];
    for (i = 0; i < stubs_keys.size; i++) {
        stubs = arraycombine(stubs, struct::get_array(stubs_keys[i], "script_unitrigger_type"), 1, 0);
    }
    for (i = 0; i < stubs.size; i++) {
        register_unitrigger(stubs[i]);
    }
    callback::on_spawned(&function_b0d21997);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 0, eflags: 0x0
// Checksum 0x85d9b0d6, Offset: 0x828
// Size: 0x4c
function __main__() {
    level thread function_b0dda94();
    level thread debug_unitriggers();
    level thread function_47ba1000();
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 0, eflags: 0x0
// Checksum 0x8fead320, Offset: 0x880
// Size: 0x10a
function function_b0dda94() {
    level flag::wait_till("start_zombie_round_logic");
    if (level._unitriggers._deferredinitlist.size) {
        for (i = 0; i < level._unitriggers._deferredinitlist.size; i++) {
            register_static_unitrigger(level._unitriggers._deferredinitlist[i], level._unitriggers._deferredinitlist[i].trigger_func);
        }
        for (i = 0; i < level._unitriggers._deferredinitlist.size; i++) {
            level._unitriggers._deferredinitlist[i] = undefined;
        }
        level._unitriggers._deferredinitlist = undefined;
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x4
// Checksum 0x7ab652bf, Offset: 0x998
// Size: 0x442
function private register_unitrigger_internal(unitrigger_stub, trigger_func) {
    if (!isdefined(unitrigger_stub.script_unitrigger_type)) {
        println("<dev string:x30>");
        return;
    }
    if (isdefined(trigger_func)) {
        unitrigger_stub.trigger_func = trigger_func;
    }
    if (!isdefined(unitrigger_stub.trigger_per_player)) {
        unitrigger_stub.trigger_per_player = 0;
    }
    if (!isdefined(unitrigger_stub.var_3cbfae8d)) {
        unitrigger_stub.var_3cbfae8d = 0;
    }
    switch (unitrigger_stub.script_unitrigger_type) {
    case #"unitrigger_radius":
    case #"unitrigger_radius_use":
        if (!isdefined(unitrigger_stub.radius)) {
            unitrigger_stub.radius = 32;
        }
        if (!isdefined(unitrigger_stub.script_height)) {
            unitrigger_stub.script_height = 64;
        }
        unitrigger_stub.test_radius_sq = (unitrigger_stub.radius + 15) * (unitrigger_stub.radius + 15);
        break;
    case #"unitrigger_box_use":
    case #"unitrigger_box":
        if (!isdefined(unitrigger_stub.script_width)) {
            unitrigger_stub.script_width = 64;
        }
        if (!isdefined(unitrigger_stub.script_length)) {
            unitrigger_stub.script_length = 64;
        }
        if (!isdefined(unitrigger_stub.script_height)) {
            unitrigger_stub.script_height = 64;
        }
        box_radius = length((unitrigger_stub.script_width / 2, unitrigger_stub.script_length / 2, unitrigger_stub.script_height / 2));
        if (!isdefined(unitrigger_stub.radius) || unitrigger_stub.radius < box_radius) {
            unitrigger_stub.radius = box_radius;
        }
        unitrigger_stub.test_radius_sq = (box_radius + 15) * (box_radius + 15);
        break;
    default:
        println("<dev string:x78>" + unitrigger_stub.targetname + "<dev string:x9e>");
        return;
    }
    if (unitrigger_stub.radius > level._unitriggers.largest_radius) {
        level._unitriggers.largest_radius = min(113, unitrigger_stub.radius);
        if (isdefined(level.fixed_max_player_use_radius)) {
            if (level.fixed_max_player_use_radius > getdvarfloat(#"player_useradius_zm", 0)) {
                setdvar(#"player_useradius_zm", level.fixed_max_player_use_radius);
            }
        } else if (level._unitriggers.largest_radius > getdvarfloat(#"player_useradius_zm", 0)) {
            setdvar(#"player_useradius_zm", level._unitriggers.largest_radius);
        }
    }
    level._unitriggers.trigger_stubs[level._unitriggers.trigger_stubs.size] = unitrigger_stub;
    unitrigger_stub.registered = 1;
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x0
// Checksum 0x2a08d50c, Offset: 0xde8
// Size: 0x34
function register_unitrigger(unitrigger_stub, trigger_func) {
    register_static_unitrigger(unitrigger_stub, trigger_func, 1);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 1, eflags: 0x0
// Checksum 0xbd4b2cd6, Offset: 0xe28
// Size: 0x24
function unregister_unitrigger(unitrigger_stub) {
    thread unregister_unitrigger_internal(unitrigger_stub, 1);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x0
// Checksum 0x8c3be718, Offset: 0xe58
// Size: 0x28c
function unregister_unitrigger_internal(unitrigger_stub, var_f91c1621 = 0) {
    if (!isdefined(unitrigger_stub)) {
        return;
    }
    if (var_f91c1621) {
        zm_lockdown_util::function_30571aaf(unitrigger_stub);
    }
    unitrigger_stub.registered = 0;
    if (isdefined(unitrigger_stub.trigger_per_player) && unitrigger_stub.trigger_per_player) {
        if (isdefined(unitrigger_stub.playertrigger) && unitrigger_stub.playertrigger.size > 0) {
            keys = getarraykeys(unitrigger_stub.playertrigger);
            foreach (key in keys) {
                trigger = unitrigger_stub.playertrigger[key];
                trigger notify(#"kill_trigger");
                if (isdefined(trigger)) {
                    trigger delete();
                }
            }
            unitrigger_stub.playertrigger = [];
        }
    } else if (isdefined(unitrigger_stub.trigger)) {
        trigger = unitrigger_stub.trigger;
        trigger notify(#"kill_trigger");
        trigger.stub.trigger = undefined;
        trigger delete();
    }
    if (isdefined(unitrigger_stub.in_zone)) {
        arrayremovevalue(level.zones[unitrigger_stub.in_zone].unitrigger_stubs, unitrigger_stub);
        unitrigger_stub.in_zone = undefined;
    }
    arrayremovevalue(level._unitriggers.trigger_stubs, unitrigger_stub);
    arrayremovevalue(level._unitriggers.dynamic_stubs, unitrigger_stub);
    function_1b75c610(unitrigger_stub);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 3, eflags: 0x0
// Checksum 0x85f3104d, Offset: 0x10f0
// Size: 0x5ac
function register_static_unitrigger(unitrigger_stub, trigger_func, recalculate_zone) {
    if (level.zones.size == 0) {
        unitrigger_stub.trigger_func = trigger_func;
        level._unitriggers._deferredinitlist[level._unitriggers._deferredinitlist.size] = unitrigger_stub;
        return;
    }
    register_unitrigger_internal(unitrigger_stub, trigger_func);
    if (isdefined(unitrigger_stub.in_zone) && !isdefined(recalculate_zone)) {
        if (isdefined(level.zones[unitrigger_stub.in_zone].unitrigger_stubs)) {
            n_index = level.zones[unitrigger_stub.in_zone].unitrigger_stubs.size;
        } else {
            n_index = 0;
        }
        level.zones[unitrigger_stub.in_zone].unitrigger_stubs[n_index] = unitrigger_stub;
        thread function_a580fa9c(unitrigger_stub, unitrigger_stub.in_zone);
        return;
    }
    if (zm_utility::function_be4cf12d()) {
        heightoffset = (0, 0, -35);
        if (unitrigger_stub.script_unitrigger_type == "unitrigger_box_use" || unitrigger_stub.script_unitrigger_type == "unitrigger_box") {
            var_e69d54e8 = (15, 15, 35);
            maxs = (unitrigger_stub.script_width / 2, unitrigger_stub.script_height / 2, unitrigger_stub.script_length / 2);
            trigger = ai::function_63b748bd(unitrigger_stub.origin + heightoffset, maxs + var_e69d54e8, unitrigger_stub.angles);
        } else if (unitrigger_stub.script_unitrigger_type == "unitrigger_radius" || unitrigger_stub.script_unitrigger_type == "unitrigger_radius_use") {
            trigger = ai::t_cylinder(unitrigger_stub.origin + heightoffset, unitrigger_stub.radius + 15, unitrigger_stub.script_height + 35);
        }
        if (isdefined(trigger)) {
            var_7ee4a5fa = tacticalquery("unitrigger_zone_tacquery", trigger, unitrigger_stub.origin);
            if (var_7ee4a5fa.size > 0) {
                foreach (tpoint in var_7ee4a5fa) {
                    if (!isdefined(tpoint.node)) {
                        continue;
                    }
                    zone = zm_zonemgr::function_40267fe8(tpoint.node.origin, 1);
                    if (isdefined(zone)) {
                        break;
                    }
                }
            }
            if (isentity(trigger)) {
                trigger delete();
            }
            trigger = undefined;
        }
    } else {
        zone = zm_zonemgr::get_zone_from_position(unitrigger_stub.origin, 1);
    }
    if (isdefined(zone)) {
        if (!isdefined(level.zones[zone].unitrigger_stubs)) {
            level.zones[zone].unitrigger_stubs = [];
        }
        if (!isdefined(level.zones[zone].unitrigger_stubs)) {
            level.zones[zone].unitrigger_stubs = [];
        } else if (!isarray(level.zones[zone].unitrigger_stubs)) {
            level.zones[zone].unitrigger_stubs = array(level.zones[zone].unitrigger_stubs);
        }
        level.zones[zone].unitrigger_stubs[level.zones[zone].unitrigger_stubs.size] = unitrigger_stub;
        unitrigger_stub.in_zone = zone;
        thread function_a580fa9c(unitrigger_stub, zone);
        return;
    }
    level._unitriggers.dynamic_stubs[level._unitriggers.dynamic_stubs.size] = unitrigger_stub;
    unitrigger_stub.registered = 1;
    thread function_a580fa9c(unitrigger_stub, undefined);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 3, eflags: 0x0
// Checksum 0xdc54052e, Offset: 0x16a8
// Size: 0xdc
function register_dyn_unitrigger(unitrigger_stub, trigger_func, recalculate_zone) {
    if (level.zones.size == 0) {
        unitrigger_stub.trigger_func = trigger_func;
        level._unitriggers._deferredinitlist[level._unitriggers._deferredinitlist.size] = unitrigger_stub;
        return;
    }
    register_unitrigger_internal(unitrigger_stub, trigger_func);
    level._unitriggers.dynamic_stubs[level._unitriggers.dynamic_stubs.size] = unitrigger_stub;
    unitrigger_stub.registered = 1;
    thread function_a580fa9c(unitrigger_stub, undefined);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 1, eflags: 0x0
// Checksum 0x5303f301, Offset: 0x1790
// Size: 0xa4
function reregister_unitrigger(unitrigger_stub) {
    if (isdefined(unitrigger_stub.registered) && unitrigger_stub.registered) {
        zone = unitrigger_stub.in_zone;
        unregister_unitrigger_internal(unitrigger_stub);
        if (isdefined(zone)) {
            register_static_unitrigger(unitrigger_stub, unitrigger_stub.trigger_func, 1);
            return;
        }
        register_dyn_unitrigger(unitrigger_stub, unitrigger_stub.trigger_func);
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 1, eflags: 0x0
// Checksum 0xaf658b2b, Offset: 0x1840
// Size: 0x44
function reregister_unitrigger_as_dynamic(unitrigger_stub) {
    unregister_unitrigger_internal(unitrigger_stub);
    register_dyn_unitrigger(unitrigger_stub, unitrigger_stub.trigger_func);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x0
// Checksum 0x6aa4f434, Offset: 0x1890
// Size: 0xde
function function_87d8e33b(n_radius = 64, var_8ae30aad = 1) {
    if (var_8ae30aad) {
        s_trigger_type = "unitrigger_radius_use";
    } else {
        s_trigger_type = "unitrigger_radius";
    }
    s_unitrigger = spawnstruct();
    s_unitrigger.origin = self.origin;
    s_unitrigger.angles = self.angles;
    s_unitrigger.script_unitrigger_type = s_trigger_type;
    s_unitrigger.cursor_hint = "HINT_NOICON";
    s_unitrigger.radius = n_radius;
    return s_unitrigger;
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 4, eflags: 0x0
// Checksum 0x108008b4, Offset: 0x1978
// Size: 0x12e
function function_9916df24(n_width = 64, n_length = 64, n_height = 64, var_8ae30aad = 1) {
    if (var_8ae30aad) {
        s_trigger_type = "unitrigger_box_use";
    } else {
        s_trigger_type = "unitrigger_box";
    }
    s_unitrigger = spawnstruct();
    s_unitrigger.origin = self.origin;
    s_unitrigger.angles = self.angles;
    s_unitrigger.script_unitrigger_type = s_trigger_type;
    s_unitrigger.cursor_hint = "HINT_NOICON";
    s_unitrigger.script_height = n_height;
    s_unitrigger.script_width = n_width;
    s_unitrigger.script_length = n_length;
    return s_unitrigger;
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 1, eflags: 0x0
// Checksum 0xc7dc9e73, Offset: 0x1ab0
// Size: 0x52
function function_60eb8ed3(s_stub) {
    if (isdefined(s_stub.originfunc)) {
        origin = s_stub [[ s_stub.originfunc ]]();
    } else {
        origin = s_stub.origin;
    }
    return origin;
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 0, eflags: 0x0
// Checksum 0xe62280f9, Offset: 0x1b10
// Size: 0x3e
function unitrigger_origin() {
    if (isdefined(self.originfunc)) {
        origin = self [[ self.originfunc ]]();
    } else {
        origin = self.origin;
    }
    return origin;
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 3, eflags: 0x0
// Checksum 0xcee094d0, Offset: 0x1b58
// Size: 0x9c
function function_3fc5694(s_stub, origin, v_angles) {
    if (isfunctionptr(origin)) {
        s_stub.origin = undefined;
        s_stub.originfunc = origin;
    } else {
        s_stub.origin = origin;
        if (isdefined(v_angles)) {
            s_stub.angles = v_angles;
        }
    }
    function_ef58ce37(s_stub, &function_db2979f9);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 3, eflags: 0x0
// Checksum 0xbf6e5340, Offset: 0x1c00
// Size: 0x94
function function_17b799aa(s_stub, str_icon, w_weapon) {
    if (isdefined(str_icon)) {
        s_stub.cursor_hint = str_icon;
        s_stub.cursor_hint_weapon = undefined;
        if (function_dea37f1b(s_stub.cursor_hint) && isdefined(w_weapon)) {
            s_stub.cursor_hint_weapon = w_weapon;
        }
    }
    function_ef58ce37(s_stub, &function_c151d586);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 4, eflags: 0x0
// Checksum 0x6889df69, Offset: 0x1ca0
// Size: 0x7c
function unitrigger_set_hint_string(s_stub, str_hint, param1, param2) {
    s_stub.hint_string = str_hint;
    s_stub.var_64722a89 = param1;
    s_stub.var_8a74a4f2 = param2;
    s_stub.prompt_and_visibility_func = undefined;
    function_ef58ce37(s_stub, &function_c151d586);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 4, eflags: 0x0
// Checksum 0x5370ee6e, Offset: 0x1d28
// Size: 0x9c
function function_81f99740(s_stub, ent, default_ref, cost) {
    ref = default_ref;
    if (isdefined(ent.script_hint)) {
        ref = ent.script_hint;
    }
    s_stub.hint_string = zm_utility::get_zombie_hint(ref);
    s_stub.var_64722a89 = cost;
    function_ef58ce37(s_stub, &function_c151d586);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x0
// Checksum 0xe574bd54, Offset: 0x1dd0
// Size: 0x44
function function_2e5dcd8b(s_stub, var_30977e33) {
    s_stub.prompt_and_visibility_func = var_30977e33;
    function_ef58ce37(s_stub, &function_d3f08767);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x0
// Checksum 0x276ade9, Offset: 0x1e20
// Size: 0xb4
function function_7fcb11a8(s_stub, var_b176b8bc = 1) {
    if (var_b176b8bc == 2) {
        s_stub.require_look_toward = 1;
        s_stub.require_look_at = 0;
    } else if (var_b176b8bc == 0) {
        s_stub.require_look_toward = 0;
        s_stub.require_look_at = 0;
    } else {
        s_stub.require_look_toward = 0;
        s_stub.require_look_at = 1;
    }
    function_ef58ce37(s_stub, &function_2e429b8f);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x0
// Checksum 0x57ef8037, Offset: 0x1ee0
// Size: 0x54
function unitrigger_force_per_player_triggers(s_stub, opt_on_off = 1) {
    s_stub.trigger_per_player = opt_on_off;
    s_stub.var_3cbfae8d = 0;
    reregister_unitrigger(s_stub);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x0
// Checksum 0x6b8bdca, Offset: 0x1f40
// Size: 0x54
function function_9946242d(s_stub, opt_on_off = 1) {
    s_stub.trigger_per_player = opt_on_off;
    s_stub.var_3cbfae8d = 0;
    reregister_unitrigger(s_stub);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x0
// Checksum 0x5efff1b9, Offset: 0x1fa0
// Size: 0x54
function function_316f5c43(s_stub, player) {
    if (s_stub.trigger_per_player) {
        return s_stub.playertrigger[player getentitynumber()];
    }
    return s_stub.trigger;
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 1, eflags: 0x0
// Checksum 0x2e078afc, Offset: 0x2000
// Size: 0x44
function unitrigger_trigger(player) {
    if (self.trigger_per_player) {
        return self.playertrigger[player getentitynumber()];
    }
    return self.trigger;
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x0
// Checksum 0x49ad9484, Offset: 0x2050
// Size: 0xf0
function function_ef58ce37(s_stub, var_f4873a9c) {
    if (isdefined(s_stub.trigger_per_player) && s_stub.trigger_per_player) {
        if (isdefined(s_stub.playertrigger)) {
            foreach (trigger in s_stub.playertrigger) {
                trigger [[ var_f4873a9c ]](s_stub, trigger);
            }
        }
        return;
    }
    if (isdefined(s_stub.trigger)) {
        s_stub.trigger [[ var_f4873a9c ]](s_stub, trigger);
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x4
// Checksum 0x26102807, Offset: 0x2148
// Size: 0x5e
function private function_db2979f9(s_stub, trigger) {
    trigger.origin = s_stub unitrigger_origin();
    if (isdefined(s_stub.angles)) {
        trigger.angles = s_stub.angles;
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x4
// Checksum 0x52a1b337, Offset: 0x21b0
// Size: 0xdc
function private function_c151d586(s_stub, trigger) {
    if (isdefined(s_stub.var_3cbfae8d) && s_stub.var_3cbfae8d) {
        foreach (player in level.players) {
            function_f4c6e130(s_stub, trigger, player);
        }
        return;
    }
    function_f4c6e130(s_stub, trigger, trigger.player);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 3, eflags: 0x0
// Checksum 0xcfead27, Offset: 0x2298
// Size: 0x24c
function function_f4c6e130(s_stub, trigger, player) {
    if (isdefined(s_stub.cursor_hint)) {
        if (function_dea37f1b(s_stub.cursor_hint) && isdefined(s_stub.cursor_hint_weapon)) {
            trigger setcursorhint(s_stub.cursor_hint, s_stub.cursor_hint_weapon);
        } else {
            trigger setcursorhint(s_stub.cursor_hint);
        }
    }
    if (isdefined(s_stub.hint_string)) {
        if (isdefined(s_stub.hint_parm2)) {
            if (isdefined(s_stub.var_3cbfae8d) && s_stub.var_3cbfae8d) {
                trigger sethintstringforplayer(player, s_stub.hint_string, s_stub.hint_parm1, s_stub.hint_parm2);
            } else {
                trigger sethintstring(s_stub.hint_string, s_stub.hint_parm1, s_stub.hint_parm2);
            }
            return;
        }
        if (isdefined(s_stub.hint_parm1)) {
            if (isdefined(s_stub.var_3cbfae8d) && s_stub.var_3cbfae8d) {
                trigger sethintstringforplayer(player, s_stub.hint_string, s_stub.hint_parm1);
            } else {
                trigger sethintstring(s_stub.hint_string, s_stub.hint_parm1);
            }
            return;
        }
        if (isdefined(s_stub.var_3cbfae8d) && s_stub.var_3cbfae8d) {
            trigger sethintstringforplayer(player, s_stub.hint_string);
            return;
        }
        trigger sethintstring(s_stub.hint_string);
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x4
// Checksum 0x11eab2a2, Offset: 0x24f0
// Size: 0xdc
function private function_d3f08767(s_stub, trigger) {
    if (isdefined(s_stub.var_3cbfae8d) && s_stub.var_3cbfae8d) {
        foreach (player in level.players) {
            function_e4655b95(s_stub, trigger, player);
        }
        return;
    }
    function_e4655b95(s_stub, trigger, trigger.player);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 3, eflags: 0x4
// Checksum 0x39c19c56, Offset: 0x25d8
// Size: 0x84
function private function_e4655b95(s_stub, trigger, player) {
    if (isdefined(s_stub.prompt_and_visibility_func)) {
        usable = trigger [[ s_stub.prompt_and_visibility_func ]](player);
        trigger triggerenable(usable);
        return;
    }
    function_f4c6e130(s_stub, trigger, player);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x4
// Checksum 0xb8424cc7, Offset: 0x2668
// Size: 0x74
function private function_2e429b8f(s_stub, trigger) {
    trigger usetriggerrequirelookat(isdefined(s_stub.require_look_at) && s_stub.require_look_at);
    trigger usetriggerrequirelooktoward(isdefined(s_stub.require_look_toward) && s_stub.require_look_toward);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 0, eflags: 0x4
// Checksum 0x96c2b458, Offset: 0x26e8
// Size: 0x166
function private function_b0d21997() {
    if (!isdefined(self.var_241e617d)) {
        self.var_241e617d = [];
    }
    waitframe(1);
    if (isdefined(level.var_62637326) && level.var_62637326) {
        self thread function_58809b55();
    }
    while (isdefined(self)) {
        trigger = self.useholdent;
        if (isdefined(trigger)) {
            self function_1e358cb1(trigger);
        } else {
            self.var_241e617d = array::remove_undefined(self.var_241e617d, 0);
            if (!isdefined(self.var_8826706c)) {
                self.var_8826706c = 0;
            }
            if (self.var_8826706c >= self.var_241e617d.size) {
                self.var_8826706c = 0;
            }
            if (self.var_8826706c < self.var_241e617d.size) {
                if (isdefined(self.var_241e617d[self.var_8826706c])) {
                    self function_1e358cb1(self.var_241e617d[self.var_8826706c]);
                }
                self.var_8826706c++;
            }
        }
        function_889aef30(trigger);
        waitframe(1);
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 1, eflags: 0x4
// Checksum 0x61711c3a, Offset: 0x2858
// Size: 0xdc
function private function_889aef30(trigger) {
    if (self.current_trigger !== trigger) {
        if (isdefined(self.current_trigger)) {
            if (isdefined(self.current_trigger.stub)) {
                self.current_trigger.stub notify(#"unitrigger_deactivated", {#player:self});
            }
        }
        self.current_trigger = trigger;
        if (isdefined(self.current_trigger)) {
            if (isdefined(self.current_trigger.stub)) {
                self.current_trigger.stub notify(#"unitrigger_activated", {#player:self});
            }
        }
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 1, eflags: 0x4
// Checksum 0x9de68af5, Offset: 0x2940
// Size: 0x84
function private function_1e358cb1(trigger) {
    if (!isdefined(trigger.stub) || distancesquared(self.origin, trigger.stub unitrigger_origin()) > 65536) {
        return;
    }
    trigger function_8e490aae(trigger.stub, self);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 0, eflags: 0x4
// Checksum 0x32139bbc, Offset: 0x29d0
// Size: 0x140
function private function_58809b55() {
    self notify(#"hash_4a86a63120e0d3d9");
    self endon(#"hash_4a86a63120e0d3d9", #"disconnect");
    foreach (stub in level._unitriggers.dynamic_stubs) {
        self function_59e41a91(stub);
    }
    if (isdefined(self.cached_zone)) {
        self thread function_61a54713(self.cached_zone, self.cached_zone_name);
    }
    while (isdefined(self)) {
        waitresult = self waittill(#"zone_change");
        self thread function_61a54713(waitresult.zone, waitresult.zone_name);
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 0, eflags: 0x4
// Checksum 0x4443f0d1, Offset: 0x2b18
// Size: 0xf2
function private function_b45746af() {
    if (!isdefined(self.var_241e617d)) {
        self.var_241e617d = [];
    }
    foreach (trigger in self.var_241e617d) {
        if (isdefined(trigger) && isdefined(trigger.stub) && isdefined(trigger.stub.in_zone)) {
            cleanup_trigger(trigger, self);
        }
    }
    self.var_37315dda = undefined;
    self.var_241e617d = array::remove_undefined(self.var_241e617d, 0);
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x4
// Checksum 0x8637b1cf, Offset: 0x2c18
// Size: 0x10e
function private function_61a54713(zone, zone_name) {
    self endon(#"zone_change");
    function_b45746af();
    candidate_list = level.zones[zone_name].unitrigger_stubs;
    if (isarray(candidate_list)) {
        candidate_list = array::remove_undefined(candidate_list);
        foreach (stub in candidate_list) {
            self thread function_59e41a91(stub);
        }
    }
    self.var_37315dda = zone_name;
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x4
// Checksum 0x24a26e77, Offset: 0x2d30
// Size: 0xb8
function private function_a580fa9c(stub, zone_name) {
    waitframe(1);
    foreach (player in level.players) {
        if (!isdefined(zone_name) || player.var_37315dda === zone_name) {
            player function_59e41a91(stub);
        }
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 1, eflags: 0x4
// Checksum 0x2d7bbde4, Offset: 0x2df0
// Size: 0x9a
function private function_1b75c610(stub) {
    foreach (player in getplayers()) {
        player.var_241e617d = array::remove_undefined(player.var_241e617d, 0);
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 0, eflags: 0x4
// Checksum 0x1d9e4041, Offset: 0x2e98
// Size: 0xa4
function private function_2789a3fa() {
    if (!isdefined(level.var_ea926ff9)) {
        level.var_ea926ff9 = 0;
    }
    if (!isdefined(level.var_209f3a47)) {
        level.var_209f3a47 = 0;
    }
    while (level.var_209f3a47 == gettime() && level.var_ea926ff9 >= 2) {
        waitframe(1);
    }
    if (level.var_209f3a47 != gettime()) {
        level.var_ea926ff9 = 0;
        level.var_209f3a47 = gettime();
    }
    level.var_ea926ff9++;
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 1, eflags: 0x4
// Checksum 0xd002a0b9, Offset: 0x2f48
// Size: 0x174
function private function_59e41a91(stub) {
    function_2789a3fa();
    if (isdefined(level.var_62637326) && level.var_62637326) {
        trigger = check_and_build_trigger_from_unitrigger_stub(stub, self);
        trigger.parent_player = self;
        trigger.stub = stub;
        if (!isdefined(self.var_241e617d)) {
            self.var_241e617d = [];
        }
        if (!isinarray(self.var_241e617d, trigger)) {
            if (!isdefined(self.var_241e617d)) {
                self.var_241e617d = [];
            } else if (!isarray(self.var_241e617d)) {
                self.var_241e617d = array(self.var_241e617d);
            }
            self.var_241e617d[self.var_241e617d.size] = trigger;
        }
        usable = assess_and_apply_visibility(trigger, stub, self, 1);
        trigger triggerenable(usable);
        function_1e358cb1(trigger);
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x0
// Checksum 0x1aaac89d, Offset: 0x30c8
// Size: 0xd4
function cleanup_trigger(trigger, player) {
    trigger notify(#"kill_trigger");
    if (isdefined(trigger.stub.trigger_per_player) && trigger.stub.trigger_per_player) {
        trigger.stub.playertrigger[player getentitynumber()] = undefined;
    } else {
        trigger.stub.trigger = undefined;
    }
    trigger delete();
    level._unitriggers.trigger_pool[player getentitynumber()] = undefined;
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 4, eflags: 0x0
// Checksum 0x88ad982c, Offset: 0x31a8
// Size: 0x1b6
function assess_and_apply_visibility(trigger, stub, player, default_keep) {
    if (!isdefined(trigger) || !isdefined(stub)) {
        return 0;
    }
    keep_thread = default_keep;
    if (!isdefined(stub.prompt_and_visibility_func) || trigger [[ stub.prompt_and_visibility_func ]](player) || isdefined(level.var_62637326) && level.var_62637326) {
        keep_thread = 1;
        if (!(isdefined(trigger.thread_running) && trigger.thread_running)) {
            trigger thread trigger_thread(trigger.stub.trigger_func);
        }
        trigger.thread_running = 1;
        if (isdefined(trigger.reassess_time) && trigger.reassess_time <= 0) {
            trigger.reassess_time = undefined;
        }
    } else {
        if (isdefined(trigger.thread_running) && trigger.thread_running) {
            keep_thread = 0;
        }
        trigger.thread_running = 0;
        if (isdefined(stub.inactive_reassess_time)) {
            trigger.reassess_time = stub.inactive_reassess_time;
        } else {
            trigger.reassess_time = 1;
        }
    }
    return keep_thread;
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x4
// Checksum 0x56d93bb3, Offset: 0x3368
// Size: 0x46
function private is_same_trigger(old_trigger, trigger) {
    return isdefined(old_trigger) && old_trigger == trigger && trigger.parent_player == old_trigger.parent_player;
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x4
// Checksum 0x6c857257, Offset: 0x33b8
// Size: 0x1b8
function private check_and_build_trigger_from_unitrigger_stub(stub, player) {
    if (!isdefined(stub)) {
        return undefined;
    }
    if (isdefined(stub.trigger_per_player) && stub.trigger_per_player) {
        if (!isdefined(stub.playertrigger)) {
            stub.playertrigger = [];
        }
        if (!isdefined(stub.playertrigger[player getentitynumber()])) {
            trigger = build_trigger_from_unitrigger_stub(stub, player);
            level._unitriggers.trigger_pool[player getentitynumber()] = trigger;
        } else {
            trigger = stub.playertrigger[player getentitynumber()];
            trigger function_8e490aae(stub, player);
        }
        if (isdefined(trigger)) {
            trigger.player = player;
        }
    } else if (!isdefined(stub.trigger)) {
        trigger = build_trigger_from_unitrigger_stub(stub, player);
        level._unitriggers.trigger_pool[player getentitynumber()] = trigger;
    } else {
        trigger = stub.trigger;
        trigger function_8e490aae(stub, player);
    }
    return trigger;
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 1, eflags: 0x0
// Checksum 0xaca9fbca, Offset: 0x3578
// Size: 0x2a
function function_dea37f1b(var_3c6bc8d) {
    return var_3c6bc8d == "HINT_WEAPON" || var_3c6bc8d == "HINT_BGB";
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x4
// Checksum 0xf60bdb34, Offset: 0x35b0
// Size: 0x3d6
function private build_trigger_from_unitrigger_stub(s_stub, player) {
    radius = isdefined(s_stub.radius) ? s_stub.radius : 64;
    script_height = isdefined(s_stub.script_height) ? s_stub.script_height : 64;
    script_width = isdefined(s_stub.script_width) ? s_stub.script_width : 64;
    script_length = isdefined(s_stub.script_length) ? s_stub.script_length : 64;
    trigger = undefined;
    origin = s_stub unitrigger_origin();
    if (!isdefined(s_stub.script_unitrigger_type)) {
        s_stub.script_unitrigger_type = "unitrigger_radius_use";
    }
    switch (s_stub.script_unitrigger_type) {
    case #"unitrigger_radius":
        trigger = spawn("trigger_radius", origin, 0, radius, script_height);
        break;
    case #"unitrigger_radius_use":
        trigger = spawn("trigger_radius_use", origin, 0, radius, script_height);
        break;
    case #"unitrigger_box":
        trigger = spawn("trigger_box", origin, 0, script_width, script_length, script_height);
        break;
    case #"unitrigger_box_use":
        trigger = spawn("trigger_box_use", origin, 0, script_width, script_length, script_height);
        break;
    }
    if (isdefined(trigger)) {
        trigger.stub = s_stub;
        trigger.player = player;
        function_db2979f9(s_stub, trigger);
        if (isdefined(s_stub.onspawnfunc)) {
            s_stub [[ s_stub.onspawnfunc ]](trigger);
        }
        function_f4c6e130(s_stub, trigger, player);
        trigger triggerignoreteam();
        function_2e429b8f(s_stub, trigger);
        copy_zombie_keys_onto_trigger(trigger, s_stub);
        if (isdefined(s_stub.trigger_per_player) && s_stub.trigger_per_player) {
            trigger setinvisibletoall();
            trigger setvisibletoplayer(player);
            if (!isdefined(s_stub.playertrigger)) {
                s_stub.playertrigger = [];
            }
            s_stub.playertrigger[player getentitynumber()] = trigger;
        } else {
            s_stub.trigger = trigger;
        }
        trigger.player = player;
        trigger.thread_running = 0;
    }
    return trigger;
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x4
// Checksum 0x4d45746a, Offset: 0x3990
// Size: 0xa2
function private copy_zombie_keys_onto_trigger(trigger, s_stub) {
    trigger.script_noteworthy = s_stub.script_noteworthy;
    trigger.targetname = s_stub.targetname;
    trigger.target = s_stub.target;
    trigger.weapon = s_stub.weapon;
    trigger.clientfieldname = s_stub.clientfieldname;
    trigger.usetime = s_stub.usetime;
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 2, eflags: 0x4
// Checksum 0x6519ed1b, Offset: 0x3a40
// Size: 0x66
function private function_8e490aae(s_stub, player) {
    if (isdefined(self)) {
        function_db2979f9(s_stub, self);
        function_e4655b95(s_stub, self, player);
        if (!isdefined(self.stub)) {
            self.stub = s_stub;
        }
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 1, eflags: 0x4
// Checksum 0xc5c8ea01, Offset: 0x3ab0
// Size: 0x36
function private trigger_thread(trigger_func) {
    self endon(#"kill_trigger");
    if (isdefined(trigger_func)) {
        self [[ trigger_func ]]();
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 0, eflags: 0x0
// Checksum 0x20240eff, Offset: 0x3af0
// Size: 0x47e
function debug_unitriggers() {
    /#
        while (true) {
            if (getdvarint(#"debug_unitrigger", 0) > 0) {
                for (i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
                    triggerstub = level._unitriggers.trigger_stubs[i];
                    color = (0.75, 0, 0);
                    if (!isdefined(triggerstub.in_zone)) {
                        color = (0.65, 0.65, 0);
                    } else if (level.zones[triggerstub.in_zone].is_active) {
                        color = (1, 1, 0);
                    }
                    if (isdefined(triggerstub.trigger) || isdefined(triggerstub.playertrigger) && triggerstub.playertrigger.size > 0) {
                        color = (0, 1, 0);
                        if (isdefined(triggerstub.playertrigger) && triggerstub.playertrigger.size > 0) {
                            print3d(triggerstub.origin, triggerstub.playertrigger.size, color, 1, 1, 1);
                        }
                    }
                    origin = triggerstub unitrigger_origin();
                    if (isdefined(triggerstub.in_zone)) {
                        print3d(origin, level.zones[triggerstub.in_zone].name, color, 1, 0.25, 1);
                    }
                    if (getdvarint(#"debug_unitrigger", 0) > 1) {
                        if (isdefined(triggerstub.trigger_per_player) && triggerstub.trigger_per_player) {
                            if (isdefined(triggerstub.playertrigger)) {
                                foreach (var_dd2bc0e0 in triggerstub.playertrigger) {
                                    debug_trigger(var_dd2bc0e0, origin, color);
                                }
                            }
                        } else {
                            debug_trigger(triggerstub.trigger, origin, color);
                        }
                        continue;
                    }
                    switch (triggerstub.script_unitrigger_type) {
                    case #"unitrigger_radius":
                    case #"unitrigger_radius_use":
                        if (triggerstub.radius) {
                            circle(origin, triggerstub.radius, color, 0, 0, 1);
                        }
                        if (triggerstub.script_height) {
                            line(origin, origin + (0, 0, triggerstub.script_height), color, 0, 1);
                        }
                        break;
                    case #"unitrigger_box_use":
                    case #"unitrigger_box":
                        vec = (triggerstub.script_width / 2, triggerstub.script_length / 2, triggerstub.script_height / 2);
                        box(origin, vec * -1, vec, triggerstub.angles[1], color, 1, 0, 1);
                        break;
                    }
                }
            }
            waitframe(1);
        }
    #/
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 3, eflags: 0x0
// Checksum 0x1710438b, Offset: 0x3f78
// Size: 0x21a
function debug_trigger(trigger, var_c3105d8e, color) {
    if (isdefined(trigger)) {
        torigin = trigger getorigin();
        tangles = trigger getangles();
        tmins = trigger getmins();
        tmaxs = trigger getmaxs();
        if (distancesquared(var_c3105d8e, trigger.origin) > 16) {
            /#
                line(var_c3105d8e, torigin, color, 0, 1);
            #/
        } else {
            /#
                sphere(var_c3105d8e, 4, color, 1, 1, 10, 1);
            #/
        }
        /#
            forward = anglestoforward(tangles);
            line(torigin, torigin + 12 * forward, color, 0, 1);
            box(torigin, tmins, tmaxs, tangles[1], color, 1, 0, 1);
        #/
        switch (trigger.classname) {
        case #"trigger_radius":
        case #"trigger_radius_use":
            break;
        case #"trigger_box_use":
        case #"trigger_box":
            break;
        }
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 0, eflags: 0x4
// Checksum 0x22dce8db, Offset: 0x41a0
// Size: 0x858
function private function_47ba1000() {
    level flag::wait_till("start_zombie_round_logic");
    valid_range = level._unitriggers.largest_radius + 15;
    valid_range_sq = valid_range * valid_range;
    while (!isdefined(level.active_zone_names)) {
        wait 0.1;
    }
    while (true) {
        if (isdefined(level.var_62637326) && level.var_62637326) {
            wait 2;
            continue;
        }
        waited = 0;
        active_zone_names = level.active_zone_names;
        candidate_list = [];
        for (j = 0; j < active_zone_names.size; j++) {
            if (isdefined(level.zones[active_zone_names[j]].unitrigger_stubs)) {
                candidate_list = arraycombine(candidate_list, level.zones[active_zone_names[j]].unitrigger_stubs, 1, 0);
            }
        }
        candidate_list = arraycombine(candidate_list, level._unitriggers.dynamic_stubs, 1, 0);
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!isdefined(player)) {
                continue;
            }
            player_origin = player.origin + (0, 0, 35);
            trigger = level._unitriggers.trigger_pool[player getentitynumber()];
            old_trigger = undefined;
            closest = [];
            if (isdefined(trigger)) {
                dst = valid_range_sq;
                origin = trigger unitrigger_origin();
                dst = trigger.stub.test_radius_sq;
                time_to_ressess = 0;
                trigger_still_valid = 0;
                if (distance2dsquared(player_origin, origin) < dst) {
                    if (isdefined(trigger.reassess_time)) {
                        trigger.reassess_time -= 0.05;
                        if (trigger.reassess_time > 0) {
                            continue;
                        }
                        time_to_ressess = 1;
                    }
                    trigger_still_valid = 1;
                }
                closest = get_closest_unitriggers(player_origin, candidate_list, valid_range);
                if (isdefined(trigger) && time_to_ressess && (closest.size < 2 || isdefined(trigger.thread_running) && trigger.thread_running)) {
                    if (assess_and_apply_visibility(trigger, trigger.stub, player, 1)) {
                        continue;
                    }
                }
                if (trigger_still_valid && closest.size < 2) {
                    if (assess_and_apply_visibility(trigger, trigger.stub, player, 1)) {
                        continue;
                    }
                }
                if (trigger_still_valid) {
                    old_trigger = trigger;
                    trigger = undefined;
                    level._unitriggers.trigger_pool[player getentitynumber()] = undefined;
                } else if (isdefined(trigger)) {
                    cleanup_trigger(trigger, player);
                }
            } else {
                closest = get_closest_unitriggers(player_origin, candidate_list, valid_range);
            }
            index = 0;
            first_usable = undefined;
            first_visible = undefined;
            trigger_found = 0;
            while (index < closest.size) {
                if (!zm_utility::is_player_valid(player) && !(isdefined(closest[index].ignore_player_valid) && closest[index].ignore_player_valid)) {
                    index++;
                    continue;
                }
                if (!(isdefined(closest[index].registered) && closest[index].registered)) {
                    index++;
                    continue;
                }
                trigger = check_and_build_trigger_from_unitrigger_stub(closest[index], player);
                if (isdefined(trigger)) {
                    trigger.parent_player = player;
                    if (assess_and_apply_visibility(trigger, closest[index], player, 0)) {
                        if (player zm_utility::is_player_looking_at(closest[index].origin, 0.9, 0)) {
                            if (!is_same_trigger(old_trigger, trigger) && isdefined(old_trigger)) {
                                cleanup_trigger(old_trigger, player);
                            }
                            level._unitriggers.trigger_pool[player getentitynumber()] = trigger;
                            trigger_found = 1;
                            break;
                        }
                        if (!isdefined(first_usable)) {
                            first_usable = index;
                        }
                    }
                    if (!isdefined(first_visible)) {
                        first_visible = index;
                    }
                    if (isdefined(trigger)) {
                        if (is_same_trigger(old_trigger, trigger)) {
                            level._unitriggers.trigger_pool[player getentitynumber()] = undefined;
                        } else {
                            cleanup_trigger(trigger, player);
                        }
                    }
                    last_trigger = trigger;
                }
                index++;
                waited = 1;
                waitframe(1);
            }
            if (!isdefined(player)) {
                continue;
            }
            if (trigger_found) {
                continue;
            }
            if (isdefined(first_usable)) {
                index = first_usable;
            } else if (isdefined(first_visible)) {
                index = first_visible;
            }
            trigger = check_and_build_trigger_from_unitrigger_stub(closest[index], player);
            if (isdefined(trigger)) {
                trigger.parent_player = player;
                level._unitriggers.trigger_pool[player getentitynumber()] = trigger;
                if (is_same_trigger(old_trigger, trigger)) {
                    continue;
                }
                if (isdefined(old_trigger)) {
                    cleanup_trigger(old_trigger, player);
                }
                if (isdefined(trigger)) {
                    assess_and_apply_visibility(trigger, trigger.stub, player, 0);
                }
            }
        }
        if (!waited) {
            waitframe(1);
        }
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 0, eflags: 0x4
// Checksum 0x160f1294, Offset: 0x4a00
// Size: 0x118
function private run_visibility_function_for_all_triggers() {
    if (!isdefined(self.prompt_and_visibility_func)) {
        return;
    }
    if (isdefined(self.trigger_per_player) && self.trigger_per_player) {
        if (!isdefined(self.playertrigger)) {
            return;
        }
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (isdefined(self.playertrigger[players[i] getentitynumber()])) {
                self.playertrigger[players[i] getentitynumber()] [[ self.prompt_and_visibility_func ]](players[i]);
            }
        }
        return;
    }
    if (isdefined(self.trigger)) {
        self.trigger [[ self.prompt_and_visibility_func ]](getplayers()[0]);
    }
}

// Namespace zm_unitrigger/zm_unitrigger
// Params 3, eflags: 0x4
// Checksum 0xe8a0d16d, Offset: 0x4b20
// Size: 0x1d2
function private get_closest_unitriggers(org, array, dist = 9999999) {
    triggers = [];
    if (array.size < 1) {
        return triggers;
    }
    distsq = dist * dist;
    for (i = 0; i < array.size; i++) {
        if (!isdefined(array[i])) {
            continue;
        }
        origin = array[i] unitrigger_origin();
        radius_sq = array[i].test_radius_sq;
        newdistsq = distance2dsquared(origin, org);
        if (newdistsq >= radius_sq) {
            continue;
        }
        if (abs(origin[2] - org[2]) > 42) {
            continue;
        }
        array[i].dsquared = newdistsq;
        for (j = 0; j < triggers.size && newdistsq > triggers[j].dsquared; j++) {
        }
        arrayinsert(triggers, array[i], j);
    }
    return triggers;
}

