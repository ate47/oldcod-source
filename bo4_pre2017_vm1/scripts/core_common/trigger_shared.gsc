#using scripts/core_common/array_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;

#namespace trigger;

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x2
// Checksum 0x365dd484, Offset: 0x448
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("trigger", &__init__, undefined, undefined);
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0xb5c8506a, Offset: 0x488
// Size: 0x6d4
function __init__() {
    level.var_eb31f20 = undefined;
    level.trigger_hint_string = [];
    level.trigger_hint_func = [];
    if (!isdefined(level.trigger_flags)) {
        init_flags();
    }
    trigger_funcs = [];
    trigger_funcs["trigger_unlock"] = &trigger_unlock;
    trigger_funcs["flag_set"] = &flag_set_trigger;
    trigger_funcs["flag_clear"] = &flag_clear_trigger;
    trigger_funcs["flag_set_touching"] = &function_c6742dfe;
    trigger_funcs["friendly_respawn_trigger"] = &friendly_respawn_trigger;
    trigger_funcs["friendly_respawn_clear"] = &friendly_respawn_clear;
    trigger_funcs["trigger_delete"] = &trigger_turns_off;
    trigger_funcs["trigger_delete_on_touch"] = &trigger_delete_on_touch;
    trigger_funcs["trigger_off"] = &trigger_turns_off;
    trigger_funcs["delete_link_chain"] = &function_62964ea9;
    trigger_funcs["no_crouch_or_prone"] = &function_5c8525c5;
    trigger_funcs["no_prone"] = &function_555e49a2;
    trigger_funcs["flood_spawner"] = &spawner::flood_trigger_think;
    trigger_funcs["trigger_spawner"] = &trigger_spawner;
    trigger_funcs["trigger_hint"] = &trigger_hint;
    trigger_funcs["exploder"] = &function_c52b5655;
    foreach (trig in get_all("trigger_radius", "trigger_multiple", "trigger_once", "trigger_box")) {
        if (isdefined(trig.spawnflags) && (trig.spawnflags & 256) == 256) {
            level thread trigger_look(trig);
        }
    }
    foreach (trig in get_all()) {
        /#
            trig function_ad8ffc08();
        #/
        if (isdefined(trig.target)) {
            level thread trigger_spawner(trig);
        }
        if (trig.classname != "trigger_once" && is_trigger_once(trig)) {
            level thread trigger_once(trig);
        }
        if (isdefined(trig.script_flag_true)) {
            level thread function_f1980fe1(trig);
        }
        if (isdefined(trig.script_flag_set)) {
            level thread flag_set_trigger(trig, trig.script_flag_set);
        }
        if (isdefined(trig.script_flag_true_any)) {
            level thread function_565ad0f2(trig);
        }
        if (isdefined(trig.script_flag_false_any)) {
            level thread function_7ae906cf(trig);
        }
        if (isdefined(trig.script_flag_set_on_touching) || isdefined(trig.script_flag_set_on_not_touching)) {
            level thread script_flag_set_touching(trig);
        }
        if (isdefined(trig.script_flag_clear)) {
            level thread flag_clear_trigger(trig, trig.script_flag_clear);
        }
        if (isdefined(trig.script_flag_false)) {
            level thread function_83ff7020(trig);
        }
        if (isdefined(trig.script_trigger_group)) {
            trig thread trigger_group();
        }
        if (isdefined(trig.script_notify)) {
            level thread trigger_notify(trig, trig.script_notify);
        }
        if (isdefined(trig.var_31afeda1)) {
            level thread spawner::function_49ba1bae(trig);
        }
        if (isdefined(trig.script_killspawner)) {
            level thread kill_spawner_trigger(trig);
        }
        if (isdefined(trig.targetname)) {
            if (isdefined(trigger_funcs[trig.targetname])) {
                level thread [[ trigger_funcs[trig.targetname] ]](trig);
            }
        }
    }
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0x56586aa1, Offset: 0xb68
// Size: 0xea
function function_ad8ffc08() {
    if (isdefined(self.spawnflags) && (isdefined(self.spawnflags) && (isdefined(self.spawnflags) && (isdefined(self.spawnflags) && (isdefined(self.spawnflags) && (self.spawnflags & 1) == 1 || (self.spawnflags & 2) == 2) || (self.spawnflags & 4) == 4) || (self.spawnflags & 8) == 8) || isdefined(self.script_trigger_allplayers) && self.script_trigger_allplayers && (self.spawnflags & 16) == 16)) {
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0xb86f5fad, Offset: 0xc60
// Size: 0x138
function trigger_unlock(trigger) {
    noteworthy = "not_set";
    if (isdefined(trigger.script_noteworthy)) {
        noteworthy = trigger.script_noteworthy;
    }
    target_triggers = getentarray(trigger.target, "targetname");
    trigger thread trigger_unlock_death(trigger.target);
    while (true) {
        array::run_all(target_triggers, &triggerenable, 0);
        trigger waittill("trigger");
        array::run_all(target_triggers, &triggerenable, 1);
        wait_for_an_unlocked_trigger(target_triggers, noteworthy);
        array::notify_all(target_triggers, "relock");
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x3946538b, Offset: 0xda0
// Size: 0x64
function trigger_unlock_death(target) {
    self waittill("death");
    target_triggers = getentarray(target, "targetname");
    array::run_all(target_triggers, &triggerenable, 0);
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0xe8d36af8, Offset: 0xe10
// Size: 0xbe
function wait_for_an_unlocked_trigger(triggers, noteworthy) {
    level endon("unlocked_trigger_hit" + noteworthy);
    ent = spawnstruct();
    for (i = 0; i < triggers.size; i++) {
        triggers[i] thread report_trigger(ent, noteworthy);
    }
    ent waittill("trigger");
    level notify("unlocked_trigger_hit" + noteworthy);
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0x32c64cda, Offset: 0xed8
// Size: 0x50
function report_trigger(ent, noteworthy) {
    self endon(#"hash_323a0103");
    level endon("unlocked_trigger_hit" + noteworthy);
    self waittill("trigger");
    ent notify(#"trigger");
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0xe428a1fb, Offset: 0xf30
// Size: 0x200
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
            /#
                assert(a_targets.size == 1, "<dev string:x28>" + self.origin + "<dev string:x38>");
            #/
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
// Checksum 0xcb1511ca, Offset: 0x1138
// Size: 0x2f0
function trigger_look(trigger) {
    trigger endon(#"death");
    e_target = trigger get_trigger_look_target();
    if (isdefined(trigger.script_flag) && !isdefined(level.flag[trigger.script_flag])) {
        level flag::init(trigger.script_flag, undefined, 1);
    }
    a_parameters = [];
    if (isdefined(trigger.script_parameters)) {
        a_parameters = strtok(trigger.script_parameters, ",; ");
    }
    b_ads_check = isinarray(a_parameters, "check_ads");
    while (true) {
        waitresult = trigger waittill("trigger");
        e_other = waitresult.activator;
        if (isplayer(e_other)) {
            while (isdefined(e_other) && e_other istouching(trigger)) {
                if (!b_ads_check || e_other util::is_looking_at(e_target, trigger.script_dot, isdefined(trigger.script_trace) && trigger.script_trace) && !e_other util::is_ads()) {
                    trigger notify(#"trigger_look", {#entity:e_other});
                    if (isdefined(trigger.script_flag)) {
                        level flag::set(trigger.script_flag);
                    }
                } else if (isdefined(trigger.script_flag)) {
                    level flag::clear(trigger.script_flag);
                }
                waitframe(1);
            }
            if (isdefined(trigger.script_flag)) {
                level flag::clear(trigger.script_flag);
            }
            continue;
        }
        /#
            assertmsg("<dev string:x5b>");
        #/
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x8ca4b23c, Offset: 0x1430
// Size: 0x1a2
function trigger_spawner(trigger) {
    trigger endon(#"death");
    a_ai_spawners = getspawnerarray(trigger.target, "targetname");
    var_48d9ff9 = getvehiclespawnerarray(trigger.target, "targetname");
    trigger wait_till();
    foreach (sp in a_ai_spawners) {
        if (isdefined(sp)) {
            sp thread trigger_spawner_spawn();
        }
    }
    foreach (sp in var_48d9ff9) {
        if (isdefined(sp)) {
            vehicle::_vehicle_spawn(sp);
        }
    }
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0xa6301d4c, Offset: 0x15e0
// Size: 0x54
function trigger_spawner_spawn() {
    self endon(#"death");
    self flag::script_flag_wait();
    self util::script_delay();
    self spawner::spawn();
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0xc33f552c, Offset: 0x1640
// Size: 0x132
function trigger_notify(trigger, msg) {
    trigger endon(#"death");
    other = trigger wait_till();
    if (isdefined(trigger.target)) {
        a_target_ents = getentarray(trigger.target, "targetname");
        foreach (notify_ent in a_target_ents) {
            notify_ent notify(msg, {#activator:other});
        }
    }
    level notify(msg, {#activator:other});
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0xe121be2c, Offset: 0x1780
// Size: 0x100
function flag_set_trigger(trigger, str_flag) {
    trigger endon(#"death");
    if (!isdefined(str_flag)) {
        str_flag = trigger.script_flag;
    }
    if (!level flag::exists(str_flag)) {
        level flag::init(str_flag, undefined, 1);
    }
    while (true) {
        trigger wait_till();
        if (isdefined(trigger.targetname) && trigger.targetname == "flag_set") {
            trigger util::script_delay();
        }
        level flag::set(str_flag);
    }
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0x8b32ea1d, Offset: 0x1888
// Size: 0x100
function flag_clear_trigger(trigger, str_flag) {
    trigger endon(#"death");
    if (!isdefined(str_flag)) {
        str_flag = trigger.script_flag;
    }
    if (!level flag::exists(str_flag)) {
        level flag::init(str_flag, undefined, 1);
    }
    while (true) {
        trigger wait_till();
        if (isdefined(trigger.targetname) && trigger.targetname == "flag_clear") {
            trigger util::script_delay();
        }
        level flag::clear(str_flag);
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x580d771f, Offset: 0x1990
// Size: 0xa2
function add_tokens_to_trigger_flags(tokens) {
    for (i = 0; i < tokens.size; i++) {
        flag = tokens[i];
        if (!isdefined(level.trigger_flags[flag])) {
            level.trigger_flags[flag] = [];
        }
        level.trigger_flags[flag][level.trigger_flags[flag].size] = self;
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x30e3c78, Offset: 0x1a40
// Size: 0x6c
function function_83ff7020(trigger) {
    tokens = util::create_flags_and_return_tokens(trigger.script_flag_false);
    trigger add_tokens_to_trigger_flags(tokens);
    trigger update_based_on_flags();
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0xca7816cb, Offset: 0x1ab8
// Size: 0x6c
function function_f1980fe1(trigger) {
    tokens = util::create_flags_and_return_tokens(trigger.script_flag_true);
    trigger add_tokens_to_trigger_flags(tokens);
    trigger update_based_on_flags();
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x2d9ffc39, Offset: 0x1b30
// Size: 0x6c
function function_7ae906cf(trigger) {
    tokens = util::create_flags_and_return_tokens(trigger.script_flag_false_any);
    trigger add_tokens_to_trigger_flags(tokens);
    trigger function_f54d22dd();
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x2015cdfd, Offset: 0x1ba8
// Size: 0x6c
function function_565ad0f2(trigger) {
    tokens = util::create_flags_and_return_tokens(trigger.script_flag_true_any);
    trigger add_tokens_to_trigger_flags(tokens);
    trigger function_f54d22dd();
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x5c082854, Offset: 0x1c20
// Size: 0x188
function friendly_respawn_trigger(trigger) {
    trigger endon(#"death");
    spawners = getentarray(trigger.target, "targetname");
    /#
        assert(spawners.size == 1, "<dev string:x7f>" + trigger.target + "<dev string:xc2>");
    #/
    spawner = spawners[0];
    /#
        assert(!isdefined(spawner.script_forcecolor), "<dev string:xe2>" + spawner.origin + "<dev string:xf7>");
    #/
    spawners = undefined;
    spawner endon(#"death");
    while (true) {
        trigger waittill("trigger");
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
// Checksum 0xd3fb4c21, Offset: 0x1db0
// Size: 0x60
function friendly_respawn_clear(trigger) {
    trigger endon(#"death");
    while (true) {
        trigger waittill("trigger");
        level flag::clear("respawn_friendlies");
        wait 0.5;
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x70973f77, Offset: 0x1e18
// Size: 0xee
function trigger_turns_off(trigger) {
    trigger wait_till();
    trigger triggerenable(0);
    if (!isdefined(trigger.script_linkto)) {
        return;
    }
    tokens = strtok(trigger.script_linkto, " ");
    for (i = 0; i < tokens.size; i++) {
        array::run_all(getentarray(tokens[i], "script_linkname"), &triggerenable, 0);
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x98f360e3, Offset: 0x1f10
// Size: 0x1d8
function script_flag_set_touching(trigger) {
    trigger endon(#"death");
    if (isdefined(trigger.script_flag_set_on_touching)) {
        level flag::init(trigger.script_flag_set_on_touching, undefined, 1);
    }
    if (isdefined(trigger.script_flag_set_on_not_touching)) {
        level flag::init(trigger.script_flag_set_on_not_touching, undefined, 1);
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
// Checksum 0x849b3041, Offset: 0x20f0
// Size: 0x38
function _detect_touched() {
    self endon(#"death");
    while (true) {
        self waittill("trigger");
        self.script_touched = 1;
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0xe87fdda0, Offset: 0x2130
// Size: 0x70
function trigger_delete_on_touch(trigger) {
    while (true) {
        waitresult = trigger waittill("trigger");
        other = waitresult.activator;
        if (isdefined(other)) {
            other delete();
        }
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0xc8faed84, Offset: 0x21a8
// Size: 0x120
function function_c6742dfe(trigger) {
    str_flag = trigger.script_flag;
    if (!isdefined(level.flag[str_flag])) {
        level flag::init(str_flag, undefined, 1);
    }
    while (true) {
        waitresult = trigger waittill("trigger");
        other = waitresult.activator;
        level flag::set(str_flag);
        while (isalive(other) && other istouching(trigger) && isdefined(trigger)) {
            wait 0.25;
        }
        level flag::clear(str_flag);
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0xaa877bfc, Offset: 0x22d0
// Size: 0xfc
function trigger_once(trig) {
    trig endon(#"death");
    if (is_look_trigger(trig)) {
        trig waittill("trigger_look");
    } else {
        trig waittill("trigger");
    }
    waittillframeend();
    waittillframeend();
    if (isdefined(trig)) {
        /#
            println("<dev string:x11f>");
            println("<dev string:x120>" + trig getentitynumber() + "<dev string:x150>" + trig.origin);
            println("<dev string:x11f>");
        #/
        trig delete();
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x3621448e, Offset: 0x23d8
// Size: 0x1ac
function trigger_hint(trigger) {
    /#
        assert(isdefined(trigger.script_hint), "<dev string:x15d>" + trigger.origin + "<dev string:x16e>");
    #/
    trigger endon(#"death");
    if (!isdefined(level.displayed_hints)) {
        level.displayed_hints = [];
    }
    waittillframeend();
    /#
        assert(isdefined(level.trigger_hint_string[trigger.script_hint]), "<dev string:x183>" + trigger.script_hint + "<dev string:x19b>");
    #/
    waitresult = trigger waittill("trigger");
    other = waitresult.activator;
    /#
        assert(isplayer(other), "<dev string:x1f0>");
    #/
    if (isdefined(level.displayed_hints[trigger.script_hint])) {
        return;
    }
    level.displayed_hints[trigger.script_hint] = 1;
    display_hint(trigger.script_hint);
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x166df346, Offset: 0x2590
// Size: 0x68
function function_c52b5655(trigger) {
    trigger endon(#"death");
    while (true) {
        trigger waittill("trigger");
        if (isdefined(trigger.target)) {
            activateclientradiantexploder(trigger.target);
        }
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x67cdad76, Offset: 0x2600
// Size: 0xc4
function display_hint(hint) {
    if (getdvarstring("chaplincheat") == "1") {
        return;
    }
    if (isdefined(level.trigger_hint_func[hint])) {
        if ([[ level.trigger_hint_func[hint] ]]()) {
            return;
        }
        function_bd4fb8ef(level.trigger_hint_string[hint], level.trigger_hint_func[hint]);
        return;
    }
    function_bd4fb8ef(level.trigger_hint_string[hint]);
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0xb5b8eb62, Offset: 0x26d0
// Size: 0x394
function function_bd4fb8ef(string, var_6647cf0c) {
    level flag::wait_till_clear("global_hint_in_use");
    level flag::set("global_hint_in_use");
    hint = hud::createfontstring("objective", 2);
    hint.alpha = 0.9;
    hint.x = 0;
    hint.y = -68;
    hint.alignx = "center";
    hint.aligny = "middle";
    hint.horzalign = "center";
    hint.vertalign = "middle";
    hint.foreground = 0;
    hint.hidewhendead = 1;
    hint settext(string);
    hint.alpha = 0;
    hint fadeovertime(1);
    hint.alpha = 0.95;
    function_5f1a1049(1);
    if (isdefined(var_6647cf0c)) {
        for (;;) {
            hint fadeovertime(0.75);
            hint.alpha = 0.4;
            function_5f1a1049(0.75, var_6647cf0c);
            if ([[ var_6647cf0c ]]()) {
                break;
            }
            hint fadeovertime(0.75);
            hint.alpha = 0.95;
            function_5f1a1049(0.75);
            if ([[ var_6647cf0c ]]()) {
                break;
            }
        }
    } else {
        for (i = 0; i < 5; i++) {
            hint fadeovertime(0.75);
            hint.alpha = 0.4;
            function_5f1a1049(0.75);
            hint fadeovertime(0.75);
            hint.alpha = 0.95;
            function_5f1a1049(0.75);
        }
    }
    hint destroy();
    level flag::clear("global_hint_in_use");
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0xa2641724, Offset: 0x2a70
// Size: 0x7e
function function_5f1a1049(length, var_6647cf0c) {
    if (!isdefined(var_6647cf0c)) {
        wait length;
        return;
    }
    timer = length * 20;
    for (i = 0; i < timer; i++) {
        if ([[ var_6647cf0c ]]()) {
            break;
        }
        waitframe(1);
    }
}

// Namespace trigger/trigger_shared
// Params 10, eflags: 0x0
// Checksum 0x202d519a, Offset: 0x2af8
// Size: 0x524
function get_all(type1, var_70753f2d, var_4a72c4c4, var_24704a5b, var_fe6dcff2, var_d86b5589, var_b268db20, var_ec8e0747, var_c68b8cde, var_d4a0cdb2) {
    if (!isdefined(type1)) {
        type1 = "trigger_damage";
        var_70753f2d = "trigger_hurt";
        var_4a72c4c4 = "trigger_lookat";
        var_24704a5b = "trigger_once";
        var_fe6dcff2 = "trigger_radius";
        var_d86b5589 = "trigger_use";
        var_b268db20 = "trigger_use_touch";
        var_ec8e0747 = "trigger_box";
        var_c68b8cde = "trigger_multiple";
        var_d4a0cdb2 = "trigger_out_of_bounds";
    }
    /#
        assert(function_73e50955(type1));
    #/
    trigs = getentarray(type1, "classname");
    if (isdefined(var_70753f2d)) {
        /#
            assert(function_73e50955(var_70753f2d));
        #/
        trigs = arraycombine(trigs, getentarray(var_70753f2d, "classname"), 1, 0);
    }
    if (isdefined(var_4a72c4c4)) {
        /#
            assert(function_73e50955(var_4a72c4c4));
        #/
        trigs = arraycombine(trigs, getentarray(var_4a72c4c4, "classname"), 1, 0);
    }
    if (isdefined(var_24704a5b)) {
        /#
            assert(function_73e50955(var_24704a5b));
        #/
        trigs = arraycombine(trigs, getentarray(var_24704a5b, "classname"), 1, 0);
    }
    if (isdefined(var_fe6dcff2)) {
        /#
            assert(function_73e50955(var_fe6dcff2));
        #/
        trigs = arraycombine(trigs, getentarray(var_fe6dcff2, "classname"), 1, 0);
    }
    if (isdefined(var_d86b5589)) {
        /#
            assert(function_73e50955(var_d86b5589));
        #/
        trigs = arraycombine(trigs, getentarray(var_d86b5589, "classname"), 1, 0);
    }
    if (isdefined(var_b268db20)) {
        /#
            assert(function_73e50955(var_b268db20));
        #/
        trigs = arraycombine(trigs, getentarray(var_b268db20, "classname"), 1, 0);
    }
    if (isdefined(var_ec8e0747)) {
        /#
            assert(function_73e50955(var_ec8e0747));
        #/
        trigs = arraycombine(trigs, getentarray(var_ec8e0747, "classname"), 1, 0);
    }
    if (isdefined(var_c68b8cde)) {
        /#
            assert(function_73e50955(var_c68b8cde));
        #/
        trigs = arraycombine(trigs, getentarray(var_c68b8cde, "classname"), 1, 0);
    }
    if (isdefined(var_d4a0cdb2)) {
        /#
            assert(function_73e50955(var_d4a0cdb2));
        #/
        trigs = arraycombine(trigs, getentarray(var_d4a0cdb2, "classname"), 1, 0);
    }
    return trigs;
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x7c25ec4e, Offset: 0x3028
// Size: 0x82
function function_73e50955(type) {
    switch (type) {
    case #"trigger_box":
    case #"trigger_damage":
    case #"trigger_hurt":
    case #"trigger_lookat":
    case #"trigger_multiple":
    case #"trigger_once":
    case #"trigger_out_of_bounds":
    case #"trigger_radius":
    case #"trigger_use":
    case #"trigger_use_touch":
        return 1;
    default:
        return 0;
    }
}

// Namespace trigger/trigger_shared
// Params 10, eflags: 0x0
// Checksum 0x362c33b3, Offset: 0x30b8
// Size: 0xbe
function is_trigger_of_type(var_295339d2, var_350bf69, var_dd4e4500, var_e75f9ddf, var_c15d2376, var_9b5aa90d, var_75582ea4, var_7f698783, var_59670d1a, var_7fdc5f06) {
    a_triggers = get_all(var_295339d2, var_350bf69, var_dd4e4500, var_e75f9ddf, var_c15d2376, var_9b5aa90d, var_75582ea4, var_7f698783, var_59670d1a, var_7fdc5f06);
    if (isinarray(a_triggers, self)) {
        return true;
    }
    return false;
}

// Namespace trigger/trigger_shared
// Params 4, eflags: 0x0
// Checksum 0xb277b730, Offset: 0x3180
// Size: 0x1d8
function wait_till(str_name, str_key, e_entity, b_assert) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (!isdefined(b_assert)) {
        b_assert = 1;
    }
    if (isdefined(str_name)) {
        triggers = getentarray(str_name, str_key);
        /#
            assert(!b_assert || triggers.size > 0, "<dev string:x222>" + str_name + "<dev string:x236>" + str_key);
        #/
        if (triggers.size > 0) {
            if (triggers.size == 1) {
                trigger_hit = triggers[0];
                trigger_hit _trigger_wait(e_entity);
            } else {
                s_tracker = spawnstruct();
                array::thread_all(triggers, &_trigger_wait_think, s_tracker, e_entity);
                waitresult = s_tracker waittill("trigger");
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
// Checksum 0xa3efbfd9, Offset: 0x3360
// Size: 0x254
function _trigger_wait(e_entity) {
    self endon(#"death");
    if (isdefined(e_entity)) {
        e_entity endon(#"death");
    }
    /#
        if (is_look_trigger(self)) {
            /#
                assert(!isarray(e_entity), "<dev string:x23d>");
            #/
        } else if (self.classname === "<dev string:x268>") {
            /#
                assert(!isarray(e_entity), "<dev string:x277>");
            #/
        }
    #/
    while (true) {
        if (is_look_trigger(self)) {
            waitresult = self waittill("trigger_look");
            e_other = waitresult.entity;
            if (isdefined(e_entity)) {
                if (e_other !== e_entity) {
                    continue;
                }
            }
        } else if (self.classname === "trigger_damage") {
            waitresult = self waittill("trigger");
            e_other = waitresult.activator;
            if (isdefined(e_entity)) {
                if (e_other !== e_entity) {
                    continue;
                }
            }
        } else {
            waitresult = self waittill("trigger");
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
// Checksum 0x6fe6c70f, Offset: 0x35c0
// Size: 0x78
function _trigger_wait_think(s_tracker, e_entity) {
    self endon(#"death");
    s_tracker endon(#"trigger");
    e_other = _trigger_wait(e_entity);
    s_tracker notify(#"trigger", {#activator:e_other, #trigger:self});
}

// Namespace trigger/trigger_shared
// Params 4, eflags: 0x0
// Checksum 0xb49c85e, Offset: 0x3640
// Size: 0x190
function use(str_name, str_key, ent, b_assert) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (!isdefined(b_assert)) {
        b_assert = 1;
    }
    if (!isdefined(ent)) {
        ent = getplayers()[0];
    }
    if (isdefined(str_name)) {
        e_trig = getent(str_name, str_key);
        if (!isdefined(e_trig)) {
            if (b_assert) {
                /#
                    assertmsg("<dev string:x222>" + str_name + "<dev string:x236>" + str_key);
                #/
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
    if (is_look_trigger(e_trig)) {
        e_trig notify(#"trigger_look", {#entity:ent});
    }
    return e_trig;
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x5dcccd1f, Offset: 0x37d8
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
// Checksum 0x4a91099b, Offset: 0x3880
// Size: 0x164
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
    b_enable = true_on && false_on;
    self triggerenable(b_enable);
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0x29f2280a, Offset: 0x39f0
// Size: 0x184
function function_f54d22dd() {
    true_on = 1;
    if (isdefined(self.script_flag_true_any)) {
        true_on = 0;
        tokens = util::create_flags_and_return_tokens(self.script_flag_true_any);
        for (i = 0; i < tokens.size; i++) {
            if (level flag::get(tokens[i])) {
                true_on = 1;
                break;
            }
        }
    }
    false_on = 1;
    if (isdefined(self.script_flag_false_any)) {
        false_on = 0;
        tokens = util::create_flags_and_return_tokens(self.script_flag_false_any);
        for (i = 0; i < tokens.size; i++) {
            if (!level flag::get(tokens[i])) {
                false_on = 1;
                break;
            }
        }
    }
    b_enable = true_on && false_on;
    self triggerenable(b_enable);
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0xf74e4796, Offset: 0x3b80
// Size: 0x14
function init_flags() {
    level.trigger_flags = [];
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x4457de44, Offset: 0x3ba0
// Size: 0x64
function is_look_trigger(trig) {
    return isdefined(trig) ? isdefined(trig.spawnflags) && (trig.spawnflags & 256) == 256 && !(trig.classname === "trigger_damage") : 0;
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x69a246fe, Offset: 0x3c10
// Size: 0x5e
function is_trigger_once(trig) {
    return isdefined(trig) ? isdefined(trig.spawnflags) && (trig.spawnflags & 1024) == 1024 || self.classname === "trigger_once" : 0;
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0x198770c6, Offset: 0x3c78
// Size: 0x12a
function wait_for_either(str_targetname1, str_targetname2) {
    ent = spawnstruct();
    array = [];
    array = arraycombine(array, getentarray(str_targetname1, "targetname"), 1, 0);
    array = arraycombine(array, getentarray(str_targetname2, "targetname"), 1, 0);
    for (i = 0; i < array.size; i++) {
        ent thread _ent_waits_for_trigger(array[i]);
    }
    waitresult = ent waittill("done");
    return waitresult.trigger;
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x6929519e, Offset: 0x3db0
// Size: 0x3e
function _ent_waits_for_trigger(trigger) {
    trigger wait_till();
    self notify(#"done", {#trigger:trigger});
}

// Namespace trigger/trigger_shared
// Params 3, eflags: 0x0
// Checksum 0xc7d7beb, Offset: 0x3df8
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
// Checksum 0x96c9ce5d, Offset: 0x3e90
// Size: 0xf4
function trigger_on_timeout(n_time, b_cancel_on_triggered, str_name, str_key) {
    if (!isdefined(b_cancel_on_triggered)) {
        b_cancel_on_triggered = 1;
    }
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    trig = self;
    if (isdefined(str_name)) {
        trig = getent(str_name, str_key);
    }
    if (b_cancel_on_triggered) {
        if (is_look_trigger(trig)) {
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
// Checksum 0xf6685cb4, Offset: 0x3f90
// Size: 0xba
function multiple_waits(str_trigger_name, str_trigger_notify) {
    foreach (trigger in getentarray(str_trigger_name, "targetname")) {
        trigger thread multiple_wait(str_trigger_notify);
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x81aac279, Offset: 0x4058
// Size: 0x32
function multiple_wait(str_trigger_notify) {
    level endon(str_trigger_notify);
    self waittill("trigger");
    level notify(str_trigger_notify);
}

// Namespace trigger/trigger_shared
// Params 9, eflags: 0x0
// Checksum 0xf9852362, Offset: 0x4098
// Size: 0x84
function add_function(trigger, str_remove_on, func, param_1, param_2, param_3, param_4, param_5, param_6) {
    self thread _do_trigger_function(trigger, str_remove_on, func, param_1, param_2, param_3, param_4, param_5, param_6);
}

// Namespace trigger/trigger_shared
// Params 9, eflags: 0x0
// Checksum 0x9c82bcbf, Offset: 0x4128
// Size: 0x100
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
// Checksum 0xdfa22aae, Offset: 0x4230
// Size: 0x1ba
function kill_spawner_trigger(trigger) {
    trigger wait_till();
    a_spawners = getspawnerarray(trigger.script_killspawner, "script_killspawner");
    foreach (sp in a_spawners) {
        sp delete();
    }
    a_ents = getentarray(trigger.script_killspawner, "script_killspawner");
    foreach (ent in a_ents) {
        if (ent.classname === "spawn_manager" && ent != trigger) {
            ent delete();
        }
    }
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0xdc1e90e4, Offset: 0x43f8
// Size: 0xe2
function get_script_linkto_targets() {
    targets = [];
    if (!isdefined(self.script_linkto)) {
        return targets;
    }
    tokens = strtok(self.script_linkto, " ");
    for (i = 0; i < tokens.size; i++) {
        token = tokens[i];
        target = getent(token, "script_linkname");
        if (isdefined(target)) {
            targets[targets.size] = target;
        }
    }
    return targets;
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x83762c3b, Offset: 0x44e8
// Size: 0x64
function function_62964ea9(trigger) {
    trigger waittill("trigger");
    targets = trigger get_script_linkto_targets();
    array::thread_all(targets, &delete_links_then_self);
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0xc7ad887e, Offset: 0x4558
// Size: 0x5c
function delete_links_then_self() {
    targets = get_script_linkto_targets();
    array::thread_all(targets, &delete_links_then_self);
    self delete();
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x937d8155, Offset: 0x45c0
// Size: 0xf8
function function_5c8525c5(trigger) {
    while (true) {
        waitresult = trigger waittill("trigger");
        other = waitresult.activator;
        if (!isplayer(other)) {
            continue;
        }
        while (other istouching(trigger)) {
            other allowprone(0);
            other allowcrouch(0);
            waitframe(1);
        }
        other allowprone(1);
        other allowcrouch(1);
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0xff327162, Offset: 0x46c0
// Size: 0xc8
function function_555e49a2(trigger) {
    while (true) {
        waitresult = trigger waittill("trigger");
        other = waitresult.activator;
        if (!isplayer(other)) {
            continue;
        }
        while (other istouching(trigger)) {
            other allowprone(0);
            waitframe(1);
        }
        other allowprone(1);
    }
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0xe69666a, Offset: 0x4790
// Size: 0x66
function trigger_group() {
    self thread trigger_group_remove();
    level endon("trigger_group_" + self.script_trigger_group);
    self waittill("trigger");
    level notify("trigger_group_" + self.script_trigger_group, {#trigger:self});
}

// Namespace trigger/trigger_shared
// Params 0, eflags: 0x0
// Checksum 0x6eb53d80, Offset: 0x4800
// Size: 0x54
function trigger_group_remove() {
    waitresult = level waittill("trigger_group_" + self.script_trigger_group);
    if (self != waitresult.trigger) {
        self delete();
    }
}

// Namespace trigger/trigger_shared
// Params 3, eflags: 0x0
// Checksum 0x8d512f7b, Offset: 0x4860
// Size: 0xfc
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
// Checksum 0x84c7298d, Offset: 0x4968
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
// Checksum 0x8b653fdb, Offset: 0x49e0
// Size: 0x62
function add_to_ent(ent, trig) {
    if (!isdefined(ent._triggers)) {
        ent._triggers = [];
    }
    ent._triggers[trig getentitynumber()] = 1;
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0x70e41f28, Offset: 0x4a50
// Size: 0x82
function remove_from_ent(ent, trig) {
    if (!isdefined(ent._triggers)) {
        return;
    }
    if (!isdefined(ent._triggers[trig getentitynumber()])) {
        return;
    }
    ent._triggers[trig getentitynumber()] = 0;
}

