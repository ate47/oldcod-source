#using script_72d4466ce2e2cc7b;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace util;

// Namespace util/util_shared
// Params 0, eflags: 0x6
// Checksum 0x69181e15, Offset: 0x158
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"util_shared", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace util/util_shared
// Params 0, eflags: 0x5 linked
// Checksum 0xe1d9175e, Offset: 0x1a0
// Size: 0x34
function private function_70a657d8() {
    function_73fab74d();
    register_clientfields();
    namespace_1e38a8f6::init();
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xc3f60b00, Offset: 0x1e0
// Size: 0x94
function register_clientfields() {
    clientfield::register("world", "cf_team_mapping", 1, 1, "int", &cf_team_mapping, 0, 0);
    clientfield::register("world", "preload_frontend", 1, 1, "int", &preload_frontend, 0, 0);
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0xcc65ac7, Offset: 0x280
// Size: 0x2c
function empty(*a, *b, *c, *d, *e) {
    
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xdd76a844, Offset: 0x2b8
// Size: 0x84
function waitforallclients() {
    localclient = 0;
    if (!isdefined(level.localplayers)) {
        while (!isdefined(level.localplayers)) {
            waitframe(1);
        }
    }
    while (level.localplayers.size <= 0) {
        waitframe(1);
    }
    while (localclient < level.localplayers.size) {
        waitforclient(localclient);
        localclient++;
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xab5a69e4, Offset: 0x348
// Size: 0x7c
function function_89a98f85() {
    num = getdvarint(#"splitscreen_playercount", 0);
    if (num < 1) {
        num = 1;
    }
    num = 1;
    for (localclient = 0; localclient < num; localclient++) {
        waitforclient(localclient);
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xb5324026, Offset: 0x3d0
// Size: 0x30
function waitforclient(client) {
    while (!clienthassnapshot(client)) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x1e244016, Offset: 0x408
// Size: 0x4c
function function_35840de8(seconds) {
    if (isdefined(seconds) && float(seconds) > 0) {
        wait float(seconds);
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xad3c85e5, Offset: 0x460
// Size: 0x62
function get_dvar_float_default(str_dvar, default_val) {
    value = getdvarstring(str_dvar);
    return value != "" ? float(value) : default_val;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x84de1747, Offset: 0x4d0
// Size: 0x62
function get_dvar_int_default(str_dvar, default_val) {
    value = getdvarstring(str_dvar);
    return value != "" ? int(value) : default_val;
}

// Namespace util/util_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x302c7b48, Offset: 0x540
// Size: 0x9e
function spawn_model(n_client, str_model, origin = (0, 0, 0), angles = (0, 0, 0)) {
    model = spawn(n_client, origin, "script_model");
    if (isdefined(model)) {
        model setmodel(str_model);
        model.angles = angles;
    }
    return model;
}

// Namespace util/util_shared
// Params 4, eflags: 0x1 linked
// Checksum 0xe4cc68a3, Offset: 0x5e8
// Size: 0x86
function spawn_anim_model(n_client, model_name, origin, angles) {
    model = spawn_model(n_client, model_name, origin, angles);
    if (isdefined(model)) {
        model useanimtree("generic");
        model.animtree = "generic";
    }
    return model;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x5918b4e7, Offset: 0x678
// Size: 0x80
function waittill_string(msg, ent) {
    if (msg != "death") {
        self endon(#"death");
    }
    ent endon(#"die");
    self waittill(msg);
    ent notify(#"returned", {#msg:msg});
}

// Namespace util/util_shared
// Params 1, eflags: 0x20 variadic
// Checksum 0x617b1c71, Offset: 0x700
// Size: 0x9c
function waittill_multiple(...) {
    s_tracker = spawnstruct();
    s_tracker._wait_count = 0;
    for (i = 0; i < vararg.size; i++) {
        self thread _waitlogic(s_tracker, vararg[i]);
    }
    if (s_tracker._wait_count > 0) {
        s_tracker waittill(#"waitlogic_finished");
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x20 variadic
// Checksum 0x929a372a, Offset: 0x7a8
// Size: 0x1a4
function waittill_multiple_ents(...) {
    a_ents = [];
    a_notifies = [];
    for (i = 0; i < vararg.size; i++) {
        if (i % 2) {
            if (!isdefined(a_notifies)) {
                a_notifies = [];
            } else if (!isarray(a_notifies)) {
                a_notifies = array(a_notifies);
            }
            a_notifies[a_notifies.size] = vararg[i];
            continue;
        }
        if (!isdefined(a_ents)) {
            a_ents = [];
        } else if (!isarray(a_ents)) {
            a_ents = array(a_ents);
        }
        a_ents[a_ents.size] = vararg[i];
    }
    s_tracker = spawnstruct();
    s_tracker._wait_count = 0;
    for (i = 0; i < a_ents.size; i++) {
        ent = a_ents[i];
        if (isdefined(ent)) {
            ent thread _waitlogic(s_tracker, a_notifies[i]);
        }
    }
    if (s_tracker._wait_count > 0) {
        s_tracker waittill(#"waitlogic_finished");
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x6d7ebd0a, Offset: 0x958
// Size: 0xb0
function _waitlogic(s_tracker, notifies) {
    s_tracker._wait_count++;
    if (!isdefined(notifies)) {
        notifies = [];
    } else if (!isarray(notifies)) {
        notifies = array(notifies);
    }
    notifies[notifies.size] = "death";
    self waittill(notifies);
    s_tracker._wait_count--;
    if (s_tracker._wait_count == 0) {
        s_tracker notify(#"waitlogic_finished");
    }
}

// Namespace util/util_shared
// Params 14, eflags: 0x1 linked
// Checksum 0xc76bf878, Offset: 0xa10
// Size: 0x14a
function waittill_any_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
    assert(isdefined(ent1));
    assert(isdefined(string1));
    if (isdefined(ent2) && isdefined(string2)) {
        ent2 endon(string2);
    }
    if (isdefined(ent3) && isdefined(string3)) {
        ent3 endon(string3);
    }
    if (isdefined(ent4) && isdefined(string4)) {
        ent4 endon(string4);
    }
    if (isdefined(ent5) && isdefined(string5)) {
        ent5 endon(string5);
    }
    if (isdefined(ent6) && isdefined(string6)) {
        ent6 endon(string6);
    }
    if (isdefined(ent7) && isdefined(string7)) {
        ent7 endon(string7);
    }
    ent1 waittill(string1);
}

// Namespace util/util_shared
// Params 11, eflags: 0x0
// Checksum 0x6374b836, Offset: 0xb68
// Size: 0x11a
function function_e532f5da(n_timeout, ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5) {
    assert(isdefined(n_timeout));
    assert(isdefined(ent1));
    assert(isdefined(string1));
    if (isdefined(ent2) && isdefined(string2)) {
        ent2 endon(string2);
    }
    if (isdefined(ent3) && isdefined(string3)) {
        ent3 endon(string3);
    }
    if (isdefined(ent4) && isdefined(string4)) {
        ent4 endon(string4);
    }
    if (isdefined(ent5) && isdefined(string5)) {
        ent5 endon(string5);
    }
    ent1 waittilltimeout(n_timeout, string1);
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0xbb124fe5, Offset: 0xc90
// Size: 0x78
function waittill_any_ents_two(ent1, string1, ent2, string2) {
    assert(isdefined(ent1));
    assert(isdefined(string1));
    if (isdefined(ent2) && isdefined(string2)) {
        ent2 endon(string2);
    }
    ent1 waittill(string1);
}

// Namespace util/util_shared
// Params 3, eflags: 0x21 linked variadic
// Checksum 0xd58fca0d, Offset: 0xd10
// Size: 0x32
function single_func(entity, func, ...) {
    return _single_func(entity, func, vararg);
}

// Namespace util/util_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x10b8c538, Offset: 0xd50
// Size: 0x32
function single_func_argarray(entity, func, a_vars) {
    return _single_func(entity, func, a_vars);
}

// Namespace util/util_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x86ad3c42, Offset: 0xd90
// Size: 0x48a
function _single_func(entity, func, a_vars) {
    _clean_up_arg_array(a_vars);
    switch (a_vars.size) {
    case 8:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
        }
        break;
    case 7:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
        }
        break;
    case 6:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
        }
        break;
    case 5:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
        }
        break;
    case 4:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
        }
        break;
    case 3:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1], a_vars[2]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1], a_vars[2]);
        }
        break;
    case 2:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1]);
        }
        break;
    case 1:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0]);
        } else {
            return [[ func ]](a_vars[0]);
        }
        break;
    case 0:
        if (isdefined(entity)) {
            return entity [[ func ]]();
        } else {
            return [[ func ]]();
        }
        break;
    default:
        assertmsg("<dev string:x38>");
        break;
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xed4e699e, Offset: 0x1228
// Size: 0x64
function _clean_up_arg_array(&a_vars) {
    for (i = a_vars.size - 1; i >= 0; i--) {
        if (a_vars[i] === undefined) {
            arrayremoveindex(a_vars, i, 0);
            continue;
        }
        break;
    }
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x98e9966, Offset: 0x1298
// Size: 0xae
function new_func(func, arg1, arg2, arg3, arg4, arg5, arg6) {
    s_func = spawnstruct();
    s_func.func = func;
    s_func.arg1 = arg1;
    s_func.arg2 = arg2;
    s_func.arg3 = arg3;
    s_func.arg4 = arg4;
    s_func.arg5 = arg5;
    s_func.arg6 = arg6;
    return s_func;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x7a393b6e, Offset: 0x1350
// Size: 0x5a
function call_func(s_func) {
    return single_func(self, s_func.func, s_func.arg1, s_func.arg2, s_func.arg3, s_func.arg4, s_func.arg5, s_func.arg6);
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x3a2b670c, Offset: 0x13b8
// Size: 0x154
function array_ent_thread(entities, func, arg1, arg2, arg3, arg4, arg5) {
    assert(isdefined(entities), "<dev string:x4a>");
    assert(isdefined(func), "<dev string:x85>");
    if (isarray(entities)) {
        if (entities.size) {
            foreach (entity in entities) {
                single_thread(self, func, entity, arg1, arg2, arg3, arg4, arg5);
            }
        }
        return;
    }
    single_thread(self, func, entities, arg1, arg2, arg3, arg4, arg5);
}

// Namespace util/util_shared
// Params 3, eflags: 0x21 linked variadic
// Checksum 0x786a3f2e, Offset: 0x1518
// Size: 0x3c
function single_thread(entity, func, ...) {
    _single_thread(entity, func, undefined, undefined, vararg);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x6f998f74, Offset: 0x1560
// Size: 0x3c
function single_thread_argarray(entity, func, &a_vars) {
    _single_thread(entity, func, undefined, undefined, a_vars);
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x7705e012, Offset: 0x15a8
// Size: 0x44
function function_50f54b6f(entity, func, arg1, &a_vars) {
    _single_thread(entity, func, arg1, undefined, a_vars);
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x29401695, Offset: 0x15f8
// Size: 0x4c
function function_cf55c866(entity, func, arg1, arg2, &a_vars) {
    _single_thread(entity, func, arg1, arg2, a_vars);
}

// Namespace util/util_shared
// Params 5, eflags: 0x1 linked
// Checksum 0x5685db8c, Offset: 0x1650
// Size: 0x85a
function _single_thread(entity, func, arg1, arg2, &a_vars) {
    _clean_up_arg_array(a_vars);
    assert(isfunctionptr(func), "<dev string:xbc>" + "<dev string:xd4>");
    if (!isfunctionptr(func)) {
        return;
    }
    if (isdefined(arg2)) {
        switch (a_vars.size) {
        case 8:
            entity thread [[ func ]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
            break;
        case 7:
            entity thread [[ func ]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
            break;
        case 6:
            entity thread [[ func ]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
            break;
        case 5:
            entity thread [[ func ]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
            break;
        case 4:
            entity thread [[ func ]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
            break;
        case 3:
            entity thread [[ func ]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2]);
            break;
        case 2:
            entity thread [[ func ]](arg1, arg2, a_vars[0], a_vars[1]);
            break;
        case 1:
            entity thread [[ func ]](arg1, arg2, a_vars[0]);
            break;
        case 0:
            entity thread [[ func ]](arg1, arg2);
            break;
        default:
            assertmsg("<dev string:x38>");
            break;
        }
        return;
    }
    if (isdefined(arg1)) {
        switch (a_vars.size) {
        case 8:
            entity thread [[ func ]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
            break;
        case 7:
            entity thread [[ func ]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
            break;
        case 6:
            entity thread [[ func ]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
            break;
        case 5:
            entity thread [[ func ]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
            break;
        case 4:
            entity thread [[ func ]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
            break;
        case 3:
            entity thread [[ func ]](arg1, a_vars[0], a_vars[1], a_vars[2]);
            break;
        case 2:
            entity thread [[ func ]](arg1, a_vars[0], a_vars[1]);
            break;
        case 1:
            entity thread [[ func ]](arg1, a_vars[0]);
            break;
        case 0:
            entity thread [[ func ]](arg1);
            break;
        default:
            assertmsg("<dev string:x38>");
            break;
        }
        return;
    }
    switch (a_vars.size) {
    case 8:
        entity thread [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
        break;
    case 7:
        entity thread [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
        break;
    case 6:
        entity thread [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
        break;
    case 5:
        entity thread [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
        break;
    case 4:
        entity thread [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
        break;
    case 3:
        entity thread [[ func ]](a_vars[0], a_vars[1], a_vars[2]);
        break;
    case 2:
        entity thread [[ func ]](a_vars[0], a_vars[1]);
        break;
    case 1:
        entity thread [[ func ]](a_vars[0]);
        break;
    case 0:
        entity thread [[ func ]]();
        break;
    default:
        assertmsg("<dev string:x38>");
        break;
    }
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x1351d126, Offset: 0x1eb8
// Size: 0x64
function add_listen_thread(wait_till, func, param1, param2, param3, param4, param5) {
    level thread add_listen_thread_internal(wait_till, func, param1, param2, param3, param4, param5);
}

// Namespace util/util_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xd8b97f0c, Offset: 0x1f28
// Size: 0x70
function add_listen_thread_internal(wait_till, func, param1, param2, param3, param4, param5) {
    for (;;) {
        level waittill(wait_till);
        single_thread(level, func, param1, param2, param3, param4, param5);
    }
}

// Namespace util/util_shared
// Params 8, eflags: 0x1 linked
// Checksum 0x8cd3cf31, Offset: 0x1fa0
// Size: 0xcc
function timeout(n_time, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self endon(#"death");
    if (isdefined(n_time)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s delay_notify(n_time, "timeout");
    }
    single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x1b7d8617, Offset: 0x2078
// Size: 0x2a
function create_flags_and_return_tokens(flags) {
    return strtok(flags, " ");
}

// Namespace util/util_shared
// Params 9, eflags: 0x1 linked
// Checksum 0xb66a2d76, Offset: 0x20b0
// Size: 0x74
function delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self thread _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 9, eflags: 0x1 linked
// Checksum 0x7d996f5d, Offset: 0x2130
// Size: 0xdc
function _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self endon(#"death");
    if (isdefined(str_endon)) {
        self endon(str_endon);
    }
    if (ishash(time_or_notify) || isstring(time_or_notify)) {
        self waittill(time_or_notify);
    } else {
        wait time_or_notify;
    }
    single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xe812912f, Offset: 0x2218
// Size: 0x34
function delay_notify(time_or_notify, str_notify, str_endon) {
    self thread _delay_notify(time_or_notify, str_notify, str_endon);
}

// Namespace util/util_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x7f713ff, Offset: 0x2258
// Size: 0x8e
function _delay_notify(time_or_notify, str_notify, str_endon) {
    self endon(#"death");
    if (isdefined(str_endon)) {
        self endon(str_endon);
    }
    if (ishash(time_or_notify) || isstring(time_or_notify)) {
        self waittill(time_or_notify);
    } else {
        wait time_or_notify;
    }
    self notify(str_notify);
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x34f00f84, Offset: 0x22f0
// Size: 0x42
function new_timer(n_timer_length) {
    s_timer = spawnstruct();
    s_timer.n_time_created = gettime();
    s_timer.n_length = n_timer_length;
    return s_timer;
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x3967d1db, Offset: 0x2340
// Size: 0x20
function get_time() {
    t_now = gettime();
    return t_now - self.n_time_created;
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x53b97af0, Offset: 0x2368
// Size: 0x34
function get_time_in_seconds() {
    return float(get_time()) / 1000;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x15e6cf23, Offset: 0x23a8
// Size: 0x4a
function get_time_frac(n_end_time = self.n_length) {
    return lerpfloat(0, 1, get_time_in_seconds() / n_end_time);
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xa5ca75e4, Offset: 0x2400
// Size: 0x58
function get_time_left() {
    if (isdefined(self.n_length)) {
        n_current_time = get_time_in_seconds();
        return max(self.n_length - n_current_time, 0);
    }
    return -1;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xc6c1a426, Offset: 0x2460
// Size: 0x16
function is_time_left() {
    return get_time_left() != 0;
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xe31b170b, Offset: 0x2480
// Size: 0x62
function timer_wait(n_wait) {
    if (isdefined(self.n_length)) {
        n_wait = min(n_wait, get_time_left());
    }
    wait n_wait;
    n_current_time = get_time_in_seconds();
    return n_current_time;
}

// Namespace util/util_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xd23e0990, Offset: 0x24f0
// Size: 0x84
function add_remove_list(&a = [], on_off) {
    if (on_off) {
        if (!isinarray(a, self)) {
            arrayinsert(a, self, a.size);
        }
        return;
    }
    arrayremovevalue(a, self, 0);
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x887ad5d8, Offset: 0x2580
// Size: 0x24
function clean_deleted(&array) {
    arrayremovevalue(array, undefined);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x558223bd, Offset: 0x25b0
// Size: 0xe2
function get_eye() {
    if (sessionmodeiscampaigngame()) {
        if (isplayer(self)) {
            linked_ent = self getlinkedent();
            if (isdefined(linked_ent) && getdvarint(#"cg_camerausetagcamera", 0) > 0) {
                camera = linked_ent gettagorigin("tag_camera");
                if (isdefined(camera)) {
                    return camera;
                }
            }
        }
    }
    pos = self geteye();
    return pos;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6181a17a, Offset: 0x26a0
// Size: 0xb0
function spawn_player_arms() {
    arms = spawn(self getlocalclientnumber(), self.origin + (0, 0, -1000), "script_model");
    if (isdefined(level.player_viewmodel)) {
        arms setmodel(level.player_viewmodel);
    } else {
        arms setmodel(#"c_usa_cia_masonjr_viewhands");
    }
    return arms;
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0xe8f07a2b, Offset: 0x2758
// Size: 0x126
function lerp_dvar(str_dvar, n_start_val, n_end_val, n_lerp_time = getdvarfloat(n_end_val, 0), b_saved_dvar, *b_client_dvar, *n_client) {
    s_timer = new_timer();
    do {
        n_time_delta = s_timer timer_wait(0.01666);
        n_curr_val = lerpfloat(n_lerp_time, b_saved_dvar, n_time_delta / b_client_dvar);
        if (is_true(n_client)) {
            setsaveddvar(n_end_val, n_curr_val);
            continue;
        }
        setdvar(n_end_val, n_curr_val);
    } while (n_time_delta < b_client_dvar);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x179aa662, Offset: 0x2888
// Size: 0xea
function is_valid_type_for_callback(type) {
    switch (type) {
    case #"scriptmover":
    case #"na":
    case #"missile":
    case #"general":
    case #"player":
    case #"turret":
    case #"actor":
    case #"helicopter":
    case #"trigger":
    case #"vehicle":
    case #"plane":
        return 1;
    default:
        return 0;
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xbfc54910, Offset: 0x2980
// Size: 0xa8
function wait_till_not_touching(e_to_check, e_to_touch) {
    assert(isdefined(e_to_check), "<dev string:xf1>");
    assert(isdefined(e_to_touch), "<dev string:x132>");
    e_to_check endon(#"death");
    e_to_touch endon(#"death");
    while (e_to_check istouching(e_to_touch)) {
        waitframe(1);
    }
}

/#

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0xb69e1153, Offset: 0x2a30
    // Size: 0x32
    function error(message) {
        println("<dev string:x173>", message);
        waitframe(1);
    }

#/

// Namespace util/util_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xa3677acb, Offset: 0x2a70
// Size: 0xda
function register_system(ssysname, cbfunc) {
    if (!isdefined(level._systemstates)) {
        level._systemstates = [];
    }
    if (level._systemstates.size >= 32) {
        /#
            error("<dev string:x184>");
        #/
        return;
    }
    if (isdefined(level._systemstates[ssysname])) {
        /#
            error("<dev string:x1a8>" + ssysname);
        #/
        return;
    }
    level._systemstates[ssysname] = spawnstruct();
    level._systemstates[ssysname].callback = cbfunc;
}

// Namespace util/util_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x86edea, Offset: 0x2b58
// Size: 0x48
function field_set_lighting_ent(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    level.light_entity = self;
}

// Namespace util/util_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x1de51162, Offset: 0x2ba8
// Size: 0x3c
function field_use_lighting_ent(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x1a2b10d, Offset: 0x2bf0
// Size: 0x3c
function waittill_dobj(localclientnum) {
    while (isdefined(self) && !self hasdobj(localclientnum)) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x5dc041e0, Offset: 0x2c38
// Size: 0x6e
function playfxontag(localclientnum, effect, entity, tagname) {
    if (isdefined(entity) && entity hasdobj(localclientnum) && isdefined(effect)) {
        return function_239993de(localclientnum, effect, entity, tagname);
    }
    return undefined;
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x736cb55c, Offset: 0x2cb0
// Size: 0x34
function function_6d0694af() {
    while (isdefined(self) && !self function_700ca4f5()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x38652c83, Offset: 0x2cf0
// Size: 0x174
function server_wait(*localclientnum, seconds, waitbetweenchecks, level_endon) {
    if (isdefined(level_endon)) {
        level endon(level_endon);
    }
    if (seconds != 0 && isdemoplaying()) {
        if (!isdefined(waitbetweenchecks)) {
            waitbetweenchecks = 0.2;
        }
        waitcompletedsuccessfully = 0;
        starttime = getservertime(0);
        lasttime = starttime;
        endtime = starttime + int(seconds * 1000);
        while (getservertime(0) < endtime && getservertime(0) >= lasttime) {
            lasttime = getservertime(0);
            wait waitbetweenchecks;
        }
        if (lasttime < getservertime(0)) {
            waitcompletedsuccessfully = 1;
        }
    } else {
        wait seconds;
        waitcompletedsuccessfully = 1;
    }
    return waitcompletedsuccessfully;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x9d25e174, Offset: 0x2e70
// Size: 0x8c
function get_other_team(str_team) {
    if (str_team == #"allies") {
        return #"axis";
    } else if (str_team == #"axis") {
        return #"allies";
    } else {
        return #"allies";
    }
    assertmsg("<dev string:x1d3>" + str_team);
}

// Namespace util/util_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x348574e1, Offset: 0x2f08
// Size: 0x42
function function_fbce7263(team_a, team_b) {
    if (team_a === team_b) {
        return false;
    }
    if (!isdefined(team_a) || !isdefined(team_b)) {
        return true;
    }
    return true;
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x129e10d6, Offset: 0x2f58
// Size: 0x2a
function isenemyteam(team) {
    return function_fbce7263(team, self.team);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x94209718, Offset: 0x2f90
// Size: 0x94
function isenemyplayer(player) {
    assert(isdefined(player));
    if (!isplayer(player)) {
        return false;
    }
    if (player.team != #"none") {
        if (player.team === self.team) {
            return false;
        }
    } else if (player == self) {
        return false;
    }
    return true;
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xe93b4fd7, Offset: 0x3030
// Size: 0xd2
function function_50ed1561(localclientnum) {
    function_89a98f85();
    if (!isdefined(self)) {
        return false;
    }
    if (!self function_21c0fa55()) {
        return false;
    }
    if (function_65b9eb0f(localclientnum)) {
        return false;
    }
    if (localclientnum !== self getlocalclientnumber()) {
        return false;
    }
    if (isdefined(level.localplayers[localclientnum]) && self getentitynumber() != level.localplayers[localclientnum] getentitynumber()) {
        return false;
    }
    return true;
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xbdc26ffc, Offset: 0x3110
// Size: 0x4e
function is_player_view_linked_to_entity(localclientnum) {
    if (function_fd3d58c7(localclientnum)) {
        return true;
    }
    if (function_e75c64a4(localclientnum)) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xc0069fd8, Offset: 0x3168
// Size: 0x12
function get_start_time() {
    return getmicrosecondsraw();
}

/#

    // Namespace util/util_shared
    // Params 2, eflags: 0x0
    // Checksum 0xcca195a, Offset: 0x3188
    // Size: 0x134
    function note_elapsed_time(start_time, label = "unspecified") {
        elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());
        if (!isdefined(start_time)) {
            return;
        }
        elapsed_time *= 0.001;
        if (!isdefined(level.orbis)) {
            level.orbis = getdvarstring(#"orbisgame") == "<dev string:x1f2>";
        }
        if (!level.orbis) {
            elapsed_time = int(elapsed_time);
        }
        msg = label + "<dev string:x1fa>" + elapsed_time + "<dev string:x20d>";
        profileprintln(msg);
        iprintlnbold(msg);
    }

#/

// Namespace util/util_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xcce80682, Offset: 0x32c8
// Size: 0x92
function record_elapsed_time(start_time, &elapsed_time_array) {
    elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());
    if (!isdefined(elapsed_time_array)) {
        elapsed_time_array = [];
    } else if (!isarray(elapsed_time_array)) {
        elapsed_time_array = array(elapsed_time_array);
    }
    elapsed_time_array[elapsed_time_array.size] = elapsed_time;
}

/#

    // Namespace util/util_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x34f215bb, Offset: 0x3368
    // Size: 0x2cc
    function note_elapsed_times(&elapsed_time_array, label = "unspecified") {
        if (!isarray(elapsed_time_array)) {
            return;
        }
        msg = label + "<dev string:x214>" + elapsed_time_array.size;
        profileprintln(msg);
        if (elapsed_time_array.size == 0) {
            return;
        }
        if (!isdefined(level.orbis)) {
            level.orbis = getdvarstring(#"orbisgame") == "<dev string:x1f2>";
        }
        total_elapsed_time = 0;
        smallest_elapsed_time = 2147483647;
        largest_elapsed_time = 0;
        foreach (elapsed_time in elapsed_time_array) {
            elapsed_time *= 0.001;
            total_elapsed_time += elapsed_time;
            if (elapsed_time < smallest_elapsed_time) {
                smallest_elapsed_time = elapsed_time;
            }
            if (elapsed_time > largest_elapsed_time) {
                largest_elapsed_time = elapsed_time;
            }
            if (!level.orbis) {
                elapsed_time = int(elapsed_time);
            }
            msg = label + "<dev string:x1fa>" + elapsed_time + "<dev string:x20d>";
            profileprintln(msg);
        }
        average_elapsed_time = total_elapsed_time / elapsed_time_array.size;
        msg = label + "<dev string:x222>" + average_elapsed_time + "<dev string:x20d>";
        profileprintln(msg);
        iprintlnbold(msg);
        msg = label + "<dev string:x23d>" + largest_elapsed_time + "<dev string:x20d>";
        profileprintln(msg);
        msg = label + "<dev string:x258>" + smallest_elapsed_time + "<dev string:x20d>";
        profileprintln(msg);
    }

#/

// Namespace util/util_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x683fbf9b, Offset: 0x3640
// Size: 0x6c
function get_elapsed_time(start_time, end_time = getmicrosecondsraw()) {
    if (!isdefined(start_time)) {
        return undefined;
    }
    elapsed_time = end_time - start_time;
    if (elapsed_time < 0) {
        elapsed_time += -2147483648;
    }
    return elapsed_time;
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x3a121298, Offset: 0x36b8
// Size: 0xcc
function init_utility() {
    level.isdemoplaying = isdemoplaying();
    level.localplayers = [];
    level.numgametypereservedobjectives = [];
    level.releasedobjectives = [];
    maxlocalclients = getmaxlocalclients();
    for (localclientnum = 0; localclientnum < maxlocalclients; localclientnum++) {
        level.releasedobjectives[localclientnum] = [];
        level.numgametypereservedobjectives[localclientnum] = 0;
    }
    waitforclient(0);
    level.localplayers = getlocalplayers();
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x798356d8, Offset: 0x3790
// Size: 0x8c
function within_fov(start_origin, start_angles, end_origin, fov) {
    normal = vectornormalize(end_origin - start_origin);
    forward = anglestoforward(start_angles);
    dot = vectordot(forward, normal);
    return dot >= fov;
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x6bb86c80, Offset: 0x3828
// Size: 0x12
function is_mature() {
    return ismaturecontentenabled();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x3d5cb370, Offset: 0x3848
// Size: 0x12
function function_fa1da5cb() {
    return isshowbloodenabled();
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x1643f996, Offset: 0x3868
// Size: 0x12
function function_2c435484() {
    return function_4e803413();
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x232f17bb, Offset: 0x3888
// Size: 0x38
function is_gib_restricted_build() {
    if (!(ismaturecontentenabled() && isshowgibsenabled())) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xdd2cb390, Offset: 0x38c8
// Size: 0x22
function function_cd6c95db(localclientnum) {
    return function_d6e37bb1(localclientnum);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x2e0d7a12, Offset: 0x38f8
// Size: 0x22
function function_a0819fe3(localclientnum) {
    return colorblindmode(localclientnum);
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x11be82c8, Offset: 0x3928
// Size: 0xda
function registersystem(ssysname, cbfunc) {
    if (!isdefined(level._systemstates)) {
        level._systemstates = [];
    }
    if (level._systemstates.size >= 32) {
        /#
            error("<dev string:x184>");
        #/
        return;
    }
    if (isdefined(level._systemstates[ssysname])) {
        /#
            error("<dev string:x1a8>" + ssysname);
        #/
        return;
    }
    level._systemstates[ssysname] = spawnstruct();
    level._systemstates[ssysname].callback = cbfunc;
}

// Namespace util/util_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xa9b2910e, Offset: 0x3a10
// Size: 0x4c
function add_trigger_to_ent(ent, trig) {
    if (!isdefined(ent._triggers)) {
        ent._triggers = [];
    }
    ent._triggers[trig getentitynumber()] = 1;
}

// Namespace util/util_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xb0b7331d, Offset: 0x3a68
// Size: 0x6c
function remove_trigger_from_ent(ent, trig) {
    if (!isdefined(ent._triggers)) {
        return;
    }
    if (!isdefined(ent._triggers[trig getentitynumber()])) {
        return;
    }
    ent._triggers[trig getentitynumber()] = 0;
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x442463b9, Offset: 0x3ae0
// Size: 0x70
function ent_already_in_trigger(trig) {
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

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x1c5b537d, Offset: 0x3b58
// Size: 0xf4
function trigger_thread(ent, on_enter_payload, on_exit_payload) {
    ent endon(#"death");
    if (ent ent_already_in_trigger(self)) {
        return;
    }
    add_trigger_to_ent(ent, self);
    if (isdefined(on_enter_payload)) {
        [[ on_enter_payload ]](ent);
    }
    while (isdefined(ent) && ent istouching(self)) {
        waitframe(1);
    }
    if (isdefined(ent) && isdefined(on_exit_payload)) {
        [[ on_exit_payload ]](ent);
    }
    if (isdefined(ent)) {
        remove_trigger_from_ent(ent, self);
    }
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x6394c09a, Offset: 0x3c58
// Size: 0xec
function local_player_trigger_thread_always_exit(ent, on_enter_payload, on_exit_payload) {
    if (ent ent_already_in_trigger(self)) {
        return;
    }
    add_trigger_to_ent(ent, self);
    if (isdefined(on_enter_payload)) {
        [[ on_enter_payload ]](ent);
    }
    while (isdefined(ent) && ent istouching(self) && ent issplitscreenhost()) {
        waitframe(1);
    }
    if (isdefined(on_exit_payload)) {
        [[ on_exit_payload ]](ent);
    }
    if (isdefined(ent)) {
        remove_trigger_from_ent(ent, self);
    }
}

// Namespace util/util_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x1fe868ec, Offset: 0x3d50
// Size: 0x8c
function local_player_entity_thread(localclientnum, entity, func, arg1, arg2, arg3, arg4) {
    entity endon(#"death");
    entity waittill_dobj(localclientnum);
    single_thread(entity, func, localclientnum, arg1, arg2, arg3, arg4);
}

// Namespace util/util_shared
// Params 6, eflags: 0x0
// Checksum 0x7a00feb1, Offset: 0x3de8
// Size: 0x94
function local_players_entity_thread(entity, func, arg1, arg2, arg3, arg4) {
    players = level.localplayers;
    for (i = 0; i < players.size; i++) {
        players[i] thread local_player_entity_thread(i, entity, func, arg1, arg2, arg3, arg4);
    }
}

/#

    // Namespace util/util_shared
    // Params 4, eflags: 0x0
    // Checksum 0x7860c1b8, Offset: 0x3e88
    // Size: 0xb4
    function debug_line(from, to, color, time) {
        level.debug_line = getdvarint(#"scr_debug_line", 0);
        if (isdefined(level.debug_line) && level.debug_line == 1) {
            if (!isdefined(time)) {
                time = 1000;
            }
            line(from, to, color, 1, 1, time);
        }
    }

    // Namespace util/util_shared
    // Params 3, eflags: 0x0
    // Checksum 0xbb3c2edb, Offset: 0x3f48
    // Size: 0xac
    function debug_star(origin, color, time) {
        level.debug_star = getdvarint(#"scr_debug_star", 0);
        if (isdefined(level.debug_star) && level.debug_star == 1) {
            if (!isdefined(time)) {
                time = 1000;
            }
            if (!isdefined(color)) {
                color = (1, 1, 1);
            }
            debugstar(origin, time, color);
        }
    }

#/

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x981c1067, Offset: 0x4000
// Size: 0x13c
function getnextobjid(localclientnum) {
    nextid = 0;
    if (!isdefined(level.releasedobjectives) || !isdefined(level.releasedobjectives[localclientnum])) {
        return nextid;
    }
    if (level.releasedobjectives[localclientnum].size > 0) {
        nextid = level.releasedobjectives[localclientnum][level.releasedobjectives[localclientnum].size - 1];
        level.releasedobjectives[localclientnum][level.releasedobjectives[localclientnum].size - 1] = undefined;
    } else {
        nextid = level.numgametypereservedobjectives[localclientnum];
        level.numgametypereservedobjectives[localclientnum]++;
    }
    /#
        if (nextid > 31) {
            println("<dev string:x274>");
        }
        assert(nextid < 32);
    #/
    if (nextid > 31) {
        nextid = 31;
    }
    return nextid;
}

// Namespace util/util_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x87a5f7, Offset: 0x4148
// Size: 0xa2
function releaseobjid(localclientnum, objid) {
    assert(objid < level.numgametypereservedobjectives[localclientnum]);
    for (i = 0; i < level.releasedobjectives[localclientnum].size; i++) {
        if (objid == level.releasedobjectives[localclientnum][i]) {
            return;
        }
    }
    level.releasedobjectives[localclientnum][level.releasedobjectives[localclientnum].size] = objid;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x3fdb5222, Offset: 0x41f8
// Size: 0x28
function is_safehouse(str_next_map = get_map_name()) {
    return false;
}

/#

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0x94d4cd97, Offset: 0x4228
    // Size: 0x118
    function button_held_think(which_button) {
        self endon(#"death");
        if (!isdefined(self._holding_button)) {
            self._holding_button = [];
        }
        self._holding_button[which_button] = 0;
        time_started = 0;
        while (true) {
            if (self._holding_button[which_button]) {
                if (!self [[ level._button_funcs[which_button] ]]()) {
                    self._holding_button[which_button] = 0;
                }
            } else if (self [[ level._button_funcs[which_button] ]]()) {
                if (time_started == 0) {
                    time_started = gettime();
                }
                if (gettime() - time_started > 250) {
                    self._holding_button[which_button] = 1;
                }
            } else if (time_started != 0) {
                time_started = 0;
            }
            waitframe(1);
        }
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x447a884d, Offset: 0x4348
    // Size: 0x48
    function init_button_wrappers() {
        if (!isdefined(level._button_funcs)) {
            level._button_funcs[4] = &up_button_pressed;
            level._button_funcs[5] = &down_button_pressed;
        }
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf796ce34, Offset: 0x4398
    // Size: 0x62
    function up_button_held() {
        init_button_wrappers();
        if (!isdefined(self._up_button_think_threaded)) {
            self thread button_held_think(4);
            self._up_button_think_threaded = 1;
        }
        return self._holding_button[4];
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xcd424dc9, Offset: 0x4408
    // Size: 0x62
    function down_button_held() {
        init_button_wrappers();
        if (!isdefined(self._down_button_think_threaded)) {
            self thread button_held_think(5);
            self._down_button_think_threaded = 1;
        }
        return self._holding_button[5];
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2ab7acbe, Offset: 0x4478
    // Size: 0x46
    function up_button_pressed() {
        return self buttonpressed("<dev string:x2a2>") || self buttonpressed("<dev string:x2ad>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xb561af58, Offset: 0x44c8
    // Size: 0x28
    function waittill_up_button_pressed() {
        while (!self up_button_pressed()) {
            waitframe(1);
        }
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xfb3afeda, Offset: 0x44f8
    // Size: 0x46
    function down_button_pressed() {
        return self buttonpressed("<dev string:x2b8>") || self buttonpressed("<dev string:x2c5>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x9354fd5d, Offset: 0x4548
    // Size: 0x28
    function waittill_down_button_pressed() {
        while (!self down_button_pressed()) {
            waitframe(1);
        }
    }

#/

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x39020a1a, Offset: 0x4578
// Size: 0x6c
function function_4c1656d5() {
    if (sessionmodeiswarzonegame()) {
        return getdvarfloat(#"hash_4e7a02edee964bf9", 250);
    }
    return getdvarfloat(#"hash_4ec50cedeed64871", 250);
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x3daa47e1, Offset: 0x45f0
// Size: 0x124
function function_16fb0a3b() {
    if (sessionmodeiswarzonegame()) {
        if (getdvarint(#"hash_23a1d3a9139af42b", 0) > 0) {
            return getdvarfloat(#"hash_608e7bb0e9517884", 250);
        } else {
            return getdvarfloat(#"hash_4e7a02edee964bf9", 250);
        }
        return;
    }
    if (getdvarint(#"hash_23fac9a913e70c03", 0) > 0) {
        return getdvarfloat(#"hash_606c79b0e9348eb8", 250);
    }
    return getdvarfloat(#"hash_4ec50cedeed64871", 250);
}

// Namespace util/util_shared
// Params 4, eflags: 0x21 linked variadic
// Checksum 0x9ca612f5, Offset: 0x4720
// Size: 0x1f4
function lerp_generic(localclientnum, duration, callback, ...) {
    localplayer = function_5c10bd79(localclientnum);
    if (!isdefined(localplayer)) {
        return;
    }
    starttime = localplayer getclienttime();
    var_d183f050 = getservertime(localclientnum);
    currenttime = starttime;
    elapsedtime = 0;
    defaultargs = array(currenttime, elapsedtime, localclientnum, duration);
    args = arraycombine(defaultargs, vararg, 1, 0);
    while (elapsedtime < duration) {
        if (isdefined(callback)) {
            args[0] = currenttime;
            args[1] = elapsedtime;
            _single_func(undefined, callback, args);
        }
        waitframe(1);
        localplayer = function_5c10bd79(localclientnum);
        if (!isdefined(localplayer)) {
            return;
        }
        currenttime = localplayer getclienttime();
        var_5710f35c = getservertime(localclientnum);
        if (var_5710f35c < var_d183f050) {
            return;
        }
        elapsedtime = currenttime - starttime;
    }
    if (isdefined(callback)) {
        args[0] = currenttime;
        args[1] = duration;
        _single_func(undefined, callback, args);
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x5d315e67, Offset: 0x4920
// Size: 0x5c
function function_c16f65a3(enemy_a, enemy_b) {
    assert(enemy_a != enemy_b, "<dev string:x2d2>");
    level.team_enemy_mapping[enemy_a] = enemy_b;
    level.team_enemy_mapping[enemy_b] = enemy_a;
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xc84fd832, Offset: 0x4988
// Size: 0xb4
function function_73fab74d() {
    if (isdefined(level.var_1bbf77be)) {
        return;
    }
    level.var_1bbf77be = 1;
    function_c16f65a3(#"allies", #"axis");
    function_c16f65a3(#"team3", #"any");
    set_team_mapping(#"allies", #"axis");
}

// Namespace util/util_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xc365b661, Offset: 0x4a48
// Size: 0x122
function cf_team_mapping(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    switch (bwastimejump) {
    case 0:
        set_team_mapping(#"axis", #"allies");
        break;
    case 1:
        set_team_mapping(#"allies", #"axis");
        break;
    default:
        set_team_mapping(#"allies", #"axis");
        break;
    }
}

// Namespace util/util_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x4b980823, Offset: 0x4b78
// Size: 0x5c
function preload_frontend(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        preloadfrontend();
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xa7fecf19, Offset: 0x4be0
// Size: 0x1a4
function set_team_mapping(str_team_for_sidea, str_team_for_sideb) {
    assert(str_team_for_sidea != str_team_for_sideb, "<dev string:x31a>");
    level.team_mapping[#"sidea"] = str_team_for_sidea;
    level.team_mapping[#"sideb"] = str_team_for_sideb;
    level.team_mapping[#"attacker"] = str_team_for_sidea;
    level.team_mapping[#"defender"] = str_team_for_sideb;
    level.team_mapping[#"attackers"] = str_team_for_sidea;
    level.team_mapping[#"defenders"] = str_team_for_sideb;
    level.team_mapping[#"hash_75fde2190cfb2c00"] = #"allies";
    level.team_mapping[#"kgb"] = #"axis";
    level.team_mapping[#"teama"] = level.team_mapping[#"sidea"];
    level.team_mapping[#"teamb"] = level.team_mapping[#"sideb"];
    level.team_mapping[#"side3"] = #"team3";
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x66a0e866, Offset: 0x4d90
// Size: 0x62
function get_team_mapping(str_team) {
    assert(isdefined(str_team));
    if (isdefined(level.team_mapping)) {
        result = level.team_mapping[str_team];
        if (isdefined(result)) {
            return result;
        }
    }
    return str_team;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x15448e7f, Offset: 0x4e00
// Size: 0x7a
function get_enemy_team(team) {
    team = get_team_mapping(team);
    if (!isdefined(team)) {
        return undefined;
    }
    if (isdefined(level.team_enemy_mapping) && isdefined(level.team_enemy_mapping[team])) {
        return level.team_enemy_mapping[team];
    }
    return #"none";
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x9daedc3f, Offset: 0x4e88
// Size: 0x132
function function_35aed314(teama, teamb) {
    teama = get_team_mapping(teama);
    teamb = get_team_mapping(teamb);
    if (!isdefined(teama) || !isdefined(teamb)) {
        return false;
    }
    if (teama == teamb) {
        return false;
    }
    if (isdefined(level.team_enemy_mapping)) {
        if (isdefined(level.team_enemy_mapping[teama])) {
            if (#"any" == level.team_enemy_mapping[teama]) {
                return true;
            }
            if (teamb == level.team_enemy_mapping[teama]) {
                return true;
            }
        }
        if (isdefined(level.team_enemy_mapping[teamb])) {
            if (#"any" == level.team_enemy_mapping[teamb]) {
                return true;
            }
            if (teama == level.team_enemy_mapping[teamb]) {
                return true;
            }
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x4b9696d, Offset: 0x4fc8
// Size: 0x24
function is_on_side(str_team) {
    return self.team === get_team_mapping(str_team);
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x2d974c1d, Offset: 0x4ff8
// Size: 0x32
function get_game_type() {
    return tolower(getdvarstring(#"g_gametype"));
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x10c86e39, Offset: 0x5038
// Size: 0x32
function get_map_name() {
    return tolower(getdvarstring(#"sv_mapname"));
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x47450aae, Offset: 0x5078
// Size: 0x1c
function is_frontend_map() {
    return get_map_name() === "core_frontend";
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xcf4aa303, Offset: 0x50a0
// Size: 0x76
function function_26489405() {
    isnightmap = 0;
    mapname = get_map_name();
    switch (mapname) {
    case #"mp_casino":
        isnightmap = 1;
        break;
    default:
        break;
    }
    return isnightmap;
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x31124842, Offset: 0x5120
// Size: 0x34
function is_arena_lobby() {
    mode = function_bea73b01();
    if (mode == 3) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x293e3158, Offset: 0x5160
// Size: 0x60
function function_e387bcd() {
    if (!isdefined(self)) {
        return false;
    }
    if (isdefined(self.script_wait)) {
        return true;
    }
    if (isdefined(self.script_wait_add)) {
        return true;
    }
    if (isdefined(self.script_wait_min)) {
        return true;
    }
    if (isdefined(self.script_wait_max)) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x728cf297, Offset: 0x51c8
// Size: 0xbc
function function_4b93f9c2() {
    result = 0;
    if (isdefined(self.script_wait)) {
        result += self.script_wait;
    }
    n_min = isdefined(self.script_wait_min) ? self.script_wait_min : 0;
    n_max = isdefined(self.script_wait_max) ? self.script_wait_max : 0;
    if (n_max > n_min) {
        result += randomfloatrange(n_min, n_max);
    } else if (n_min > 0) {
        result += n_min;
    }
    return result;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x480dd433, Offset: 0x5290
// Size: 0x15a
function script_wait() {
    n_time = gettime();
    if (isdefined(self.script_wait)) {
        wait self.script_wait;
        if (isdefined(self.script_wait_add)) {
            self.script_wait += self.script_wait_add;
        }
    }
    n_min = isdefined(self.script_wait_min) ? self.script_wait_min : 0;
    n_max = isdefined(self.script_wait_max) ? self.script_wait_max : 0;
    if (n_max > n_min) {
        wait randomfloatrange(n_min, n_max);
        self.script_wait_min += isdefined(self.script_wait_add) ? self.script_wait_add : 0;
        self.script_wait_max += isdefined(self.script_wait_add) ? self.script_wait_add : 0;
    } else if (n_min > 0) {
        wait n_min;
        self.script_wait_min += isdefined(self.script_wait_add) ? self.script_wait_add : 0;
    }
    return gettime() - n_time;
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x37727887, Offset: 0x53f8
// Size: 0x96
function lock_model(model) {
    if (isdefined(model)) {
        if (!isdefined(level.model_locks)) {
            level.model_locks = [];
        }
        if (!isdefined(level.model_locks[model])) {
            level.model_locks[model] = 0;
        }
        if (level.model_locks[model] < 1) {
            forcestreamxmodel(model);
        }
        level.model_locks[model]++;
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xf6bffce0, Offset: 0x5498
// Size: 0x9c
function unlock_model(model) {
    if (!isdefined(level.model_locks)) {
        level.model_locks = [];
    }
    if (isdefined(model) && isdefined(level.model_locks[model])) {
        if (level.model_locks[model] > 0) {
            level.model_locks[model]--;
            if (level.model_locks[model] < 1) {
                stopforcestreamingxmodel(model);
            }
        }
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xefc7160, Offset: 0x5540
// Size: 0x1c6
function function_48e57e36(var_1f1d12d8) {
    base = 1;
    decimal = 0;
    for (i = var_1f1d12d8.size - 1; i >= 0; i--) {
        if (var_1f1d12d8[i] >= "0" && var_1f1d12d8[i] <= "9") {
            decimal += int(var_1f1d12d8[i]) * base;
            base *= 16;
            continue;
        }
        if (var_1f1d12d8[i] >= "a" && var_1f1d12d8[i] <= "f") {
            if (var_1f1d12d8[i] == "a") {
                number = 10;
            } else if (var_1f1d12d8[i] == "b") {
                number = 11;
            } else if (var_1f1d12d8[i] == "c") {
                number = 12;
            } else if (var_1f1d12d8[i] == "d") {
                number = 13;
            } else if (var_1f1d12d8[i] == "e") {
                number = 14;
            } else if (var_1f1d12d8[i] == "f") {
                number = 15;
            }
            decimal += number * base;
            base *= 16;
        }
    }
    return decimal;
}

/#

    // Namespace util/util_shared
    // Params 3, eflags: 0x0
    // Checksum 0xefdd7fda, Offset: 0x5710
    // Size: 0x5c
    function add_devgui(localclientnum, menu_path, commands) {
        adddebugcommand(localclientnum, "<dev string:x368>" + menu_path + "<dev string:x378>" + commands + "<dev string:x37f>");
    }

    // Namespace util/util_shared
    // Params 2, eflags: 0x0
    // Checksum 0xb4b77644, Offset: 0x5778
    // Size: 0x44
    function remove_devgui(localclientnum, menu_path) {
        adddebugcommand(localclientnum, "<dev string:x385>" + menu_path + "<dev string:x37f>");
    }

#/

// Namespace util/util_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xb7819c59, Offset: 0x57c8
// Size: 0x9e
function function_b5338ccb(value, deadzone = 0.2) {
    assert(deadzone < 1);
    if (abs(value) < deadzone) {
        return 0;
    }
    return (value - deadzone * math::sign(value)) / (1 - deadzone);
}

// Namespace util/util_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xd8b17dbe, Offset: 0x5870
// Size: 0xac
function function_63320ea1(vector, deadzone, var_edfc4672 = 0) {
    if (var_edfc4672) {
        return (function_b5338ccb(vector[0], deadzone), function_b5338ccb(vector[1], deadzone), 0);
    }
    return vectornormalize(vector) * function_b5338ccb(length(vector), deadzone);
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x8da2b1d6, Offset: 0x5928
// Size: 0x24
function function_5ff170ee() {
    setdvar(#"hash_19b5d46719678445", 0);
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x656713c4, Offset: 0x5958
// Size: 0x7c
function function_8d617b62(color, stops) {
    setdvar(#"hash_19b5d46719678445", 1);
    setdvar(#"r_suncolor", color);
    setdvar(#"r_sunstops", stops);
}

// Namespace util/util_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x61a73569, Offset: 0x59e0
// Size: 0x54
function function_21aef83c() {
    setdvar(#"hash_51a850dd61ea465b", 500);
    setdvar(#"hash_6f9f3341a7820247", 0);
}

// Namespace util/util_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xa37bcf3, Offset: 0x5a40
// Size: 0x54
function function_8eb5d4b0(var_b5b0042e, var_aba8f86c) {
    setdvar(#"hash_51a850dd61ea465b", var_b5b0042e);
    setdvar(#"hash_6f9f3341a7820247", var_aba8f86c);
}

// Namespace util/util_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x9197ec98, Offset: 0x5aa0
// Size: 0x84
function function_3ec868ea(localclientnum, var_7bb490d6 = 1) {
    var_ac505d0d = function_6593be12(localclientnum) / 100;
    if (var_7bb490d6) {
        var_ac505d0d *= getdvarfloat(#"m_mousesensitivity");
    }
    return var_ac505d0d;
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x32779202, Offset: 0x5b30
// Size: 0x1ec
function function_ca4b4e19(localclientnum, var_b5338ccb = 1, var_7bb490d6 = 1) {
    input = [];
    if (!gamepadusedlast(localclientnum)) {
        input[#"look"] = function_3ec868ea(localclientnum, var_7bb490d6);
        input[#"move"] = (isbuttonpressed(localclientnum, 75) ? -1 : isbuttonpressed(localclientnum, 76) ? 1 : 0, isbuttonpressed(localclientnum, 74) ? -1 : isbuttonpressed(localclientnum, 73) ? 1 : 0, 0);
    } else {
        input = self getcontrollerposition();
        if (var_b5338ccb) {
            input[#"look"] = function_63320ea1(input[#"look"]);
            input[#"move"] = function_63320ea1(input[#"move"]);
        }
    }
    return input;
}

// Namespace util/util_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x4da8d79c, Offset: 0x5d28
// Size: 0x9a
function init_dvar(str_dvar, default_val, func_callback) {
    function_5ac4dc99(str_dvar, default_val);
    if (isdefined(func_callback)) {
        function_cd140ee9(str_dvar, func_callback);
        level thread [[ func_callback ]]({#name:str_dvar, #value:getdvar(str_dvar)});
    }
}

// Namespace util/util_shared
// Params 6, eflags: 0x1 linked
// Checksum 0x65a71259, Offset: 0x5dd0
// Size: 0x39e
function function_6f326f49(hour, minute, second, day, month, var_7323307b) {
    for (;;) {
        setdvar(#"hash_dfcfdb3bf28da5e", string(hour, 2) + ":" + string(minute, 2) + ":" + string(second, 2) + " " + string(month, 2) + "/" + string(day, 2) + "/" + string(var_7323307b % 100, 2));
        wait 1;
        second += 1;
        if (second > 59) {
            second = 0;
            minute += 1;
        }
        if (minute > 59) {
            minute = 0;
            hour += 1;
        }
        if (hour > 23) {
            hour = 0;
            day += 1;
        }
        switch (month) {
        case 1:
            var_8bf17cd8 = 31;
            break;
        case 2:
            if (var_7323307b % 4 == 0 || var_7323307b % 100 == 0 && !(var_7323307b % 4 == 0 && var_7323307b % 100 == 0)) {
                var_8bf17cd8 = 29;
            } else {
                var_8bf17cd8 = 28;
            }
            break;
        case 3:
            var_8bf17cd8 = 31;
            break;
        case 4:
            var_8bf17cd8 = 30;
            break;
        case 5:
            var_8bf17cd8 = 31;
            break;
        case 6:
            var_8bf17cd8 = 30;
            break;
        case 7:
            var_8bf17cd8 = 31;
            break;
        case 8:
            var_8bf17cd8 = 31;
            break;
        case 9:
            var_8bf17cd8 = 30;
            break;
        case 10:
            var_8bf17cd8 = 31;
            break;
        case 11:
            var_8bf17cd8 = 30;
            break;
        case 12:
            var_8bf17cd8 = 31;
            break;
        }
        if (day > var_8bf17cd8) {
            day = 1;
            month += 1;
        }
        if (month > 12) {
            month = 1;
            var_7323307b += 1;
        }
    }
}

// Namespace util/util_shared
// Params 6, eflags: 0x0
// Checksum 0xa41d7d6c, Offset: 0x6178
// Size: 0x31c
function function_a9ea7ad4(hour, minute, second, day, month, var_7323307b) {
    if (hour < 0) {
        hour = 0;
    } else if (hour > 23) {
        hour = 23;
    }
    if (minute < 0) {
        minute = 0;
    } else if (minute > 59) {
        minute = 59;
    }
    if (second < 0) {
        second = 0;
    } else if (second > 59) {
        second = 59;
    }
    if (month < 1) {
        month = 1;
    } else if (month > 12) {
        month = 12;
    }
    if (var_7323307b < 0) {
        var_7323307b = 0;
    } else if (var_7323307b > 1000000) {
        var_7323307b = 1000000;
    }
    switch (month) {
    case 1:
        var_8bf17cd8 = 31;
        break;
    case 2:
        if (var_7323307b % 4 == 0 || var_7323307b % 100 == 0 && !(var_7323307b % 4 == 0 && var_7323307b % 100 == 0)) {
            var_8bf17cd8 = 29;
        } else {
            var_8bf17cd8 = 28;
        }
        break;
    case 3:
        var_8bf17cd8 = 31;
        break;
    case 4:
        var_8bf17cd8 = 30;
        break;
    case 5:
        var_8bf17cd8 = 31;
        break;
    case 6:
        var_8bf17cd8 = 30;
        break;
    case 7:
        var_8bf17cd8 = 31;
        break;
    case 8:
        var_8bf17cd8 = 31;
        break;
    case 9:
        var_8bf17cd8 = 30;
        break;
    case 10:
        var_8bf17cd8 = 31;
        break;
    case 11:
        var_8bf17cd8 = 30;
        break;
    case 12:
        var_8bf17cd8 = 31;
        break;
    }
    if (day < 1) {
        day = 1;
    } else if (day > var_8bf17cd8) {
        day = var_8bf17cd8;
    }
    thread function_6f326f49(hour, minute, second, day, month, var_7323307b);
}

