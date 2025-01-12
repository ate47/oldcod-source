#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace trigger;

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x2
// Checksum 0x4fc00ac3, Offset: 0x208
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"trigger", &__init__, undefined, undefined);
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0xb92d561a, Offset: 0x250
// Size: 0x24
function __init__() {
    callback::function_1a00d318(&trigger_think);
}

// Namespace trigger/trigger_shared
// Params 4, eflags: 0x0
// Checksum 0xdc34c2ff, Offset: 0x280
// Size: 0xd4
function add_handler(var_a260e804, func_handler, func_init, var_336002d2 = 1) {
    if (isfunctionptr(var_a260e804) ? [[ var_a260e804 ]]() : isdefined(self.(var_a260e804))) {
        if (isdefined(func_handler)) {
            if (var_336002d2) {
                self callback::on_trigger_once(func_handler);
            } else {
                self callback::on_trigger(func_handler);
            }
        }
        if (isfunctionptr(func_init)) {
            [[ func_init ]](var_a260e804);
        }
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0xb40d3164, Offset: 0x360
// Size: 0x5c
function init_flags(str_kvp) {
    tokens = util::create_flags_and_return_tokens(self.(str_kvp));
    add_tokens_to_trigger_flags(tokens);
    update_based_on_flags();
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0x438b1648, Offset: 0x3c8
// Size: 0x2bc
function trigger_think() {
    self endon(#"death");
    add_handler("target", &trigger_spawner);
    add_handler("script_flag_true", undefined, &init_flags);
    add_handler("script_flag_true_any", undefined, &init_flags);
    add_handler("script_flag_false_any", undefined, &init_flags);
    add_handler("script_flag_false", undefined, &init_flags);
    add_handler("script_flag_set", &flag_set_trigger, &init_flags);
    add_handler("script_flag_clear", &flag_clear_trigger, &init_flags);
    add_handler("script_trigger_group", &trigger_group);
    add_handler("script_notify", &trigger_notify);
    add_handler("script_killspawner", &kill_spawner_trigger);
    add_handler("script_teleport_location", &teleport::team);
    add_handler(&is_trigger_once, &trigger_once);
    if (isdefined(self.script_flag_set_on_touching) || isdefined(self.script_flag_set_on_not_touching)) {
        level thread script_flag_set_touching(self);
    }
    if (is_look_trigger()) {
        level thread look_trigger(self);
        s_info = self waittill(#"trigger_look");
        self thread callback::codecallback_trigger(s_info, 1);
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x75f80752, Offset: 0x690
// Size: 0x4c
function function_5345af18(flags) {
    trigger_flags = function_dcb65892(self);
    function_377ee71e(self, trigger_flags | flags);
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0x3a84bcd9, Offset: 0x6e8
// Size: 0x1c2
function get_trigger_look_target() {
    if (isdefined(self.target)) {
        a_potential_targets = getentarray(self.target, "targetname");
        a_targets = [];
        foreach (target in a_potential_targets) {
            if (target.classname === "script_origin") {
                if (!isdefined(a_targets)) {
                    a_targets = [];
                } else if (!isarray(a_targets)) {
                    a_targets = array(a_targets);
                }
                a_targets[a_targets.size] = target;
            }
        }
        a_potential_target_structs = struct::get_array(self.target);
        a_targets = arraycombine(a_targets, a_potential_target_structs, 1, 0);
        if (a_targets.size > 0) {
            assert(a_targets.size == 1, "<dev string:x30>" + self.origin + "<dev string:x40>");
            e_target = a_targets[0];
        }
    }
    if (!isdefined(e_target)) {
        e_target = self;
    }
    return e_target;
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x2fd4b00b, Offset: 0x8b8
// Size: 0x220
function look_trigger(trigger) {
    trigger endon(#"death");
    e_target = trigger get_trigger_look_target();
    if (isdefined(trigger.script_flag) && !isdefined(level.flag[trigger.script_flag])) {
        level function_97c49a71(trigger.script_flag);
    }
    a_parameters = [];
    if (isdefined(trigger.script_parameters)) {
        a_parameters = strtok(trigger.script_parameters, ",; ");
    }
    b_ads_check = isinarray(a_parameters, "check_ads");
    while (true) {
        waitresult = trigger waittill(#"trigger");
        e_other = waitresult.activator;
        if (isplayer(e_other)) {
            while (isdefined(e_other) && e_other istouching(trigger)) {
                if (e_other util::is_looking_at(e_target, trigger.script_dot, isdefined(trigger.script_trace) && trigger.script_trace) && (!b_ads_check || !e_other util::is_ads())) {
                    trigger notify(#"trigger_look", waitresult);
                }
                waitframe(1);
            }
            continue;
        }
        assertmsg("<dev string:x63>");
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0xac42090d, Offset: 0xae0
// Size: 0x110
function trigger_spawner(s_info) {
    a_ai_spawners = getspawnerarray(self.target, "targetname");
    foreach (sp in a_ai_spawners) {
        if (isdefined(sp)) {
            if (isvehiclespawner(sp)) {
                level thread vehicle::_vehicle_spawn(sp);
                continue;
            }
            assert(isactorspawner(sp));
            sp thread trigger_spawner_spawn();
        }
    }
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0xcca906bf, Offset: 0xbf8
// Size: 0x5c
function trigger_spawner_spawn() {
    self endon(#"death");
    self flag::script_flag_wait();
    self util::script_delay();
    self spawner::spawn();
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0xd256bf0f, Offset: 0xc60
// Size: 0xc4
function trigger_notify(s_info) {
    if (isdefined(self.target)) {
        a_target_ents = getentarray(self.target, "targetname");
        foreach (notify_ent in a_target_ents) {
            notify_ent notify(self.script_notify, s_info);
        }
    }
    level notify(self.script_notify, s_info);
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0xe0533000, Offset: 0xd30
// Size: 0x82
function function_97c49a71(str_flag) {
    if (!level flag::exists(str_flag)) {
        level flag::init(str_flag);
    }
    if (!isdefined(level.trigger_flags)) {
        level.trigger_flags = [];
    }
    if (!isdefined(level.trigger_flags[str_flag])) {
        level.trigger_flags[str_flag] = [];
    }
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0xa1020cdf, Offset: 0xdc0
// Size: 0xa0
function flag_set_trigger() {
    a_str_flags = util::create_flags_and_return_tokens(self.script_flag_set);
    foreach (str_flag in a_str_flags) {
        level flag::set(str_flag);
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x3416b553, Offset: 0xe68
// Size: 0xa8
function flag_clear_trigger(s_info) {
    a_str_flags = util::create_flags_and_return_tokens(self.script_flag_clear);
    foreach (str_flag in a_str_flags) {
        level flag::clear(str_flag);
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0xcb2ecc73, Offset: 0xf18
// Size: 0x11a
function add_tokens_to_trigger_flags(tokens) {
    for (i = 0; i < tokens.size; i++) {
        flag = tokens[i];
        if (!isdefined(level.trigger_flags[flag])) {
            level.trigger_flags[flag] = [];
        } else if (!isarray(level.trigger_flags[flag])) {
            level.trigger_flags[flag] = array(level.trigger_flags[flag]);
        }
        if (!isinarray(level.trigger_flags[flag], self)) {
            level.trigger_flags[flag][level.trigger_flags[flag].size] = self;
        }
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x72b427fc, Offset: 0x1040
// Size: 0x190
function friendly_respawn_trigger(trigger) {
    trigger endon(#"death");
    spawners = getentarray(trigger.target, "targetname");
    assert(spawners.size == 1, "<dev string:x87>" + trigger.target + "<dev string:xca>");
    spawner = spawners[0];
    assert(!isdefined(spawner.script_forcecolor), "<dev string:xea>" + spawner.origin + "<dev string:xff>");
    spawners = undefined;
    spawner endon(#"death");
    while (true) {
        trigger waittill(#"trigger");
        if (isdefined(trigger.script_forcecolor)) {
            level.respawn_spawners_specific[trigger.script_forcecolor] = spawner;
        } else {
            level.respawn_spawner = spawner;
        }
        level flag::set("respawn_friendlies");
        wait 0.5;
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0xa40b2651, Offset: 0x11d8
// Size: 0x70
function friendly_respawn_clear(trigger) {
    trigger endon(#"death");
    while (true) {
        trigger waittill(#"trigger");
        level flag::clear("respawn_friendlies");
        wait 0.5;
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x8ef17654, Offset: 0x1250
// Size: 0x1a8
function script_flag_set_touching(trigger) {
    trigger endon(#"death");
    if (isdefined(trigger.script_flag_set_on_touching)) {
        level function_97c49a71(trigger.script_flag_set_on_touching);
    }
    if (isdefined(trigger.script_flag_set_on_not_touching)) {
        level function_97c49a71(trigger.script_flag_set_on_not_touching);
    }
    trigger thread _detect_touched();
    while (true) {
        trigger.script_touched = 0;
        waitframe(1);
        waittillframeend();
        if (!trigger.script_touched) {
            waitframe(1);
            waittillframeend();
        }
        if (trigger.script_touched) {
            if (isdefined(trigger.script_flag_set_on_touching)) {
                level flag::set(trigger.script_flag_set_on_touching);
            }
            if (isdefined(trigger.script_flag_set_on_not_touching)) {
                level flag::clear(trigger.script_flag_set_on_not_touching);
            }
            continue;
        }
        if (isdefined(trigger.script_flag_set_on_touching)) {
            level flag::clear(trigger.script_flag_set_on_touching);
        }
        if (isdefined(trigger.script_flag_set_on_not_touching)) {
            level flag::set(trigger.script_flag_set_on_not_touching);
        }
    }
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0xe713569c, Offset: 0x1400
// Size: 0x42
function _detect_touched() {
    self endon(#"death");
    while (true) {
        self waittill(#"trigger");
        self.script_touched = 1;
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x52aa01f3, Offset: 0x1450
// Size: 0x70
function trigger_delete_on_touch(trigger) {
    while (true) {
        waitresult = trigger waittill(#"trigger");
        other = waitresult.activator;
        if (isdefined(other)) {
            other delete();
        }
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x36d6efd, Offset: 0x14c8
// Size: 0xa4
function trigger_once(s_info) {
    waittillframeend();
    waittillframeend();
    if (isdefined(self)) {
        /#
            println("<dev string:x127>");
            println("<dev string:x128>" + self getentitynumber() + "<dev string:x158>" + self.origin);
            println("<dev string:x127>");
        #/
        self delete();
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x20 variadic
// Checksum 0xa4ea0ac8, Offset: 0x1578
// Size: 0xf2
function get_all(...) {
    if (vararg.size == 1 && isarray(vararg[0])) {
        a_vararg = vararg[0];
    } else {
        a_vararg = vararg;
    }
    a_all = getentarraybytype(20);
    if (a_vararg.size) {
        for (i = a_all.size - 1; i >= 0; i--) {
            if (!isinarray(a_vararg, a_all[i].classname)) {
                arrayremoveindex(a_all, i);
            }
        }
    }
    return a_all;
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x20 variadic
// Checksum 0x2a6cb26c, Offset: 0x1678
// Size: 0x72
function is_trigger_of_type(...) {
    if (vararg.size == 1 && isarray(vararg[0])) {
        a_vararg = vararg[0];
    } else {
        a_vararg = vararg;
    }
    return isinarray(a_vararg, self.classname);
}

// Namespace trigger/trigger_shared
// Params 4, eflags: 0x0
// Checksum 0x355ab36e, Offset: 0x16f8
// Size: 0x1b0
function wait_till(str_name, str_key = "targetname", e_entity, b_assert = 1) {
    if (isdefined(str_name)) {
        triggers = getentarray(str_name, str_key);
        assert(!b_assert || triggers.size > 0, "<dev string:x165>" + str_name + "<dev string:x179>" + str_key);
        if (triggers.size > 0) {
            if (triggers.size == 1) {
                trigger_hit = triggers[0];
                trigger_hit _trigger_wait(e_entity);
            } else {
                s_tracker = spawnstruct();
                array::thread_all(triggers, &_trigger_wait_think, s_tracker, e_entity);
                waitresult = s_tracker waittill(#"trigger");
                trigger_hit = waitresult.trigger;
                trigger_hit.who = waitresult.activator;
            }
            return trigger_hit;
        }
        return;
    }
    _trigger_wait(e_entity);
    return self;
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x75c248ff, Offset: 0x18b0
// Size: 0x266
function _trigger_wait(e_entity) {
    self endon(#"death");
    if (isdefined(e_entity)) {
        e_entity endon(#"death");
    }
    if (!isdefined(self.delaynotify)) {
        self.delaynotify = 0;
    }
    /#
        if (is_look_trigger()) {
            assert(!isarray(e_entity), "<dev string:x180>");
        } else if (self.classname === "<dev string:x1ab>") {
            assert(!isarray(e_entity), "<dev string:x1ba>");
        }
    #/
    while (true) {
        if (is_look_trigger()) {
            waitresult = self waittill(#"trigger_look");
            wait self.delaynotify;
            e_other = waitresult.activator;
            if (isdefined(e_entity)) {
                if (e_other !== e_entity) {
                    continue;
                }
            }
        } else if (self.classname === "trigger_damage") {
            waitresult = self waittill(#"trigger");
            wait self.delaynotify;
            e_other = waitresult.activator;
            if (isdefined(e_entity)) {
                if (e_other !== e_entity) {
                    continue;
                }
            }
        } else {
            waitresult = self waittill(#"trigger");
            wait self.delaynotify;
            e_other = waitresult.activator;
            if (isdefined(e_entity)) {
                if (isarray(e_entity)) {
                    if (!array::is_touching(e_entity, self)) {
                        continue;
                    }
                } else if (!e_entity istouching(self) && e_entity !== e_other) {
                    continue;
                }
            }
        }
        break;
    }
    self.who = e_other;
    return e_other;
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0xc77f1d, Offset: 0x1b20
// Size: 0x90
function _trigger_wait_think(s_tracker, e_entity) {
    self endon(#"death");
    s_tracker endon(#"trigger");
    e_other = _trigger_wait(e_entity);
    s_tracker notify(#"trigger", {#activator:e_other, #trigger:self});
}

// Namespace trigger/trigger_shared
// Params 4, eflags: 0x0
// Checksum 0x3738ff56, Offset: 0x1bb8
// Size: 0x17c
function use(str_name, str_key = "targetname", ent = getplayers()[0], b_assert = 1) {
    if (isdefined(str_name)) {
        e_trig = getent(str_name, str_key);
        if (!isdefined(e_trig)) {
            if (b_assert) {
                assertmsg("<dev string:x165>" + str_name + "<dev string:x179>" + str_key);
            }
            return;
        }
    } else {
        e_trig = self;
        str_name = self.targetname;
    }
    if (isdefined(ent)) {
        e_trig useby(ent);
    } else {
        e_trig useby(e_trig);
    }
    level notify(str_name, ent);
    if (e_trig is_look_trigger()) {
        e_trig notify(#"trigger_look", {#entity:ent});
    }
    return e_trig;
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0xbefa4e79, Offset: 0x1d40
// Size: 0x9c
function set_flag_permissions(msg) {
    if (!isdefined(level.trigger_flags) || !isdefined(level.trigger_flags[msg])) {
        return;
    }
    level.trigger_flags[msg] = array::remove_undefined(level.trigger_flags[msg]);
    array::thread_all(level.trigger_flags[msg], &update_based_on_flags);
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0x18721fd, Offset: 0x1de8
// Size: 0x26c
function update_based_on_flags() {
    true_on = 1;
    if (isdefined(self.script_flag_true)) {
        tokens = util::create_flags_and_return_tokens(self.script_flag_true);
        for (i = 0; i < tokens.size; i++) {
            if (!level flag::get(tokens[i])) {
                true_on = 0;
                break;
            }
        }
    }
    false_on = 1;
    if (isdefined(self.script_flag_false)) {
        tokens = util::create_flags_and_return_tokens(self.script_flag_false);
        for (i = 0; i < tokens.size; i++) {
            if (level flag::get(tokens[i])) {
                false_on = 0;
                break;
            }
        }
    }
    var_c2ff62a = 1;
    if (isdefined(self.script_flag_true_any)) {
        var_c2ff62a = 0;
        tokens = util::create_flags_and_return_tokens(self.script_flag_true_any);
        for (i = 0; i < tokens.size; i++) {
            if (level flag::get(tokens[i])) {
                var_c2ff62a = 1;
                break;
            }
        }
    }
    var_b152fd37 = 1;
    if (isdefined(self.script_flag_false_any)) {
        var_b152fd37 = 0;
        tokens = util::create_flags_and_return_tokens(self.script_flag_false_any);
        for (i = 0; i < tokens.size; i++) {
            if (!level flag::get(tokens[i])) {
                var_b152fd37 = 1;
                break;
            }
        }
    }
    self triggerenable(true_on && false_on && var_c2ff62a && var_b152fd37);
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0x9c458f05, Offset: 0x2060
// Size: 0x66
function is_look_trigger() {
    return isdefined(self.spawnflags) && (self.spawnflags & 256) == 256 && !is_trigger_of_type("trigger_damage") && !is_trigger_of_type("trigger_damage_new");
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0xa169bd5a, Offset: 0x20d0
// Size: 0x4c
function is_trigger_once() {
    return isdefined(self.spawnflags) && (self.spawnflags & 1024) == 1024 || is_trigger_of_type("trigger_once", "trigger_once_new");
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x20 variadic
// Checksum 0x2d12810d, Offset: 0x2128
// Size: 0x1aa
function wait_till_any(...) {
    ent = spawnstruct();
    if (isarray(vararg[0])) {
        a_str_targetnames = vararg[0];
    } else {
        a_str_targetnames = vararg;
    }
    assert(a_str_targetnames.size, "<dev string:x1e7>");
    a_triggers = [];
    a_triggers = arraycombine(a_triggers, getentarray(a_str_targetnames[0], "targetname"), 1, 0);
    for (i = 1; i < a_str_targetnames.size; i++) {
        a_triggers = arraycombine(a_triggers, getentarray(a_str_targetnames[i], "targetname"), 1, 0);
    }
    for (i = 0; i < a_triggers.size; i++) {
        ent thread _ent_waits_for_trigger(a_triggers[i]);
    }
    waitresult = ent waittill(#"done");
    return waitresult.trigger;
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0x5376da5e, Offset: 0x22e0
// Size: 0x3a
function wait_for_either(str_targetname1, str_targetname2) {
    trigger = wait_till_any(str_targetname1, str_targetname2);
    return trigger;
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x7efab711, Offset: 0x2328
// Size: 0x5e
function _ent_waits_for_trigger(trigger) {
    self endon(#"done");
    trigger wait_till();
    self notify(#"done", {#trigger:trigger});
}

// Namespace trigger/trigger_shared
// Params 3, eflags: 0x0
// Checksum 0xa00912f, Offset: 0x2390
// Size: 0x8c
function wait_or_timeout(n_time, str_name, str_key) {
    if (isdefined(n_time)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_time, "timeout");
    }
    wait_till(str_name, str_key);
}

// Namespace trigger/trigger_shared
// Params 4, eflags: 0x0
// Checksum 0x8c01cde3, Offset: 0x2428
// Size: 0xf4
function trigger_on_timeout(n_time, b_cancel_on_triggered = 1, str_name, str_key = "targetname") {
    trig = self;
    if (isdefined(str_name)) {
        trig = getent(str_name, str_key);
    }
    if (b_cancel_on_triggered) {
        if (trig is_look_trigger()) {
            trig endon(#"trigger_look");
        } else {
            trig endon(#"trigger");
        }
    }
    trig endon(#"death");
    wait n_time;
    trig use();
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0x80036ff0, Offset: 0x2528
// Size: 0xa8
function multiple_waits(str_trigger_name, str_trigger_notify) {
    foreach (trigger in getentarray(str_trigger_name, "targetname")) {
        trigger thread multiple_wait(str_trigger_notify);
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0xda8eec80, Offset: 0x25d8
// Size: 0x34
function multiple_wait(str_trigger_notify) {
    level endon(str_trigger_notify);
    self waittill(#"trigger");
    level notify(str_trigger_notify);
}

// Namespace trigger/trigger_shared
// Params 9, eflags: 0x0
// Checksum 0x39d94f8d, Offset: 0x2618
// Size: 0x84
function add_function(trigger, str_remove_on, func, param_1, param_2, param_3, param_4, param_5, param_6) {
    self thread _do_trigger_function(trigger, str_remove_on, func, param_1, param_2, param_3, param_4, param_5, param_6);
}

// Namespace trigger/trigger_shared
// Params 9, eflags: 0x0
// Checksum 0x5a22f88f, Offset: 0x26a8
// Size: 0x108
function _do_trigger_function(trigger, str_remove_on, func, param_1, param_2, param_3, param_4, param_5, param_6) {
    self endon(#"death");
    trigger endon(#"death");
    if (isdefined(str_remove_on)) {
        trigger endon(str_remove_on);
    }
    while (true) {
        if (isstring(trigger)) {
            wait_till(trigger);
        } else {
            trigger wait_till();
        }
        util::single_thread(self, func, param_1, param_2, param_3, param_4, param_5, param_6);
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0xbdf453b0, Offset: 0x27b8
// Size: 0x170
function kill_spawner_trigger(s_info) {
    a_spawners = getspawnerarray(self.script_killspawner, "script_killspawner");
    foreach (sp in a_spawners) {
        sp delete();
    }
    a_ents = getentarray(self.script_killspawner, "script_killspawner");
    foreach (ent in a_ents) {
        if (ent.classname === "spawn_manager" && ent != self) {
            ent delete();
        }
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x707fee09, Offset: 0x2930
// Size: 0xa8
function trigger_group(s_info) {
    foreach (trig in getentarray(self.script_trigger_group, "script_trigger_group")) {
        if (trig != self) {
            trig delete();
        }
    }
}

// Namespace trigger/trigger_shared
// Params 3, eflags: 0x0
// Checksum 0x12f87fb6, Offset: 0x29e0
// Size: 0xf4
function function_thread(ent, on_enter_payload, on_exit_payload) {
    ent endon(#"death");
    if (ent ent_already_in(self)) {
        return;
    }
    add_to_ent(ent, self);
    if (isdefined(on_enter_payload)) {
        [[ on_enter_payload ]](ent);
    }
    while (isdefined(ent) && ent istouching(self)) {
        wait 0.01;
    }
    if (isdefined(ent) && isdefined(on_exit_payload)) {
        [[ on_exit_payload ]](ent);
    }
    if (isdefined(ent)) {
        remove_from_ent(ent, self);
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x256f60e5, Offset: 0x2ae0
// Size: 0x70
function ent_already_in(trig) {
    if (!isdefined(self._triggers)) {
        return false;
    }
    if (!isdefined(self._triggers[trig getentitynumber()])) {
        return false;
    }
    if (!self._triggers[trig getentitynumber()]) {
        return false;
    }
    return true;
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0xcb8d8fa7, Offset: 0x2b58
// Size: 0x5a
function add_to_ent(ent, trig) {
    if (!isdefined(ent._triggers)) {
        ent._triggers = [];
    }
    ent._triggers[trig getentitynumber()] = 1;
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0xcf752fd2, Offset: 0x2bc0
// Size: 0x72
function remove_from_ent(ent, trig) {
    if (!isdefined(ent._triggers)) {
        return;
    }
    if (!isdefined(ent._triggers[trig getentitynumber()])) {
        return;
    }
    ent._triggers[trig getentitynumber()] = 0;
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0x97f6358d, Offset: 0x2c40
// Size: 0x6c
function trigger_wait() {
    self endon(#"trigger");
    if (isdefined(self.targetname)) {
        trig = getent(self.targetname, "target");
        if (isdefined(trig)) {
            trig wait_till();
        }
    }
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x20 variadic
// Checksum 0x9d76c9f9, Offset: 0x2cb8
// Size: 0x10c
function run(func, ...) {
    var_5eb0a1b = 0;
    if (isdefined(self.targetname)) {
        foreach (trig in getentarraybytype(20)) {
            if (trig.target === self.targetname) {
                trig callback::on_trigger(&function_7ba9f4bf, undefined, self, func, vararg);
                var_5eb0a1b = 1;
            }
        }
    }
    if (!var_5eb0a1b) {
        util::single_thread_argarray(self, func, vararg);
    }
}

// Namespace trigger/trigger_shared
// Params 4, eflags: 0x0
// Checksum 0x1cd4fb32, Offset: 0x2dd0
// Size: 0x44
function function_7ba9f4bf(s_info, ent, func, a_args) {
    util::single_func_argarray(ent, func, a_args);
}

