#using script_72d4466ce2e2cc7b;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace util;

// Namespace util/util_shared
// Params 0, eflags: 0x2
// Checksum 0x15524142, Offset: 0x108
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"util_shared", &__init__, undefined, undefined);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xe566f801, Offset: 0x150
// Size: 0x34
function __init__() {
    function_2b9d78e6();
    register_clientfields();
    namespace_fe84c968::init();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf53cfa0, Offset: 0x190
// Size: 0x94
function register_clientfields() {
    clientfield::register("world", "cf_team_mapping", 1, 1, "int", &cf_team_mapping, 0, 0);
    clientfield::register("world", "preload_frontend", 1, 1, "int", &preload_frontend, 0, 0);
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x8cf5780f, Offset: 0x230
// Size: 0x2c
function empty(a, b, c, d, e) {
    
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x333a5056, Offset: 0x268
// Size: 0x86
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
// Params 0, eflags: 0x0
// Checksum 0x27ef1c32, Offset: 0x2f8
// Size: 0x86
function function_2170ff73() {
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
// Params 1, eflags: 0x0
// Checksum 0xebff7c6a, Offset: 0x388
// Size: 0x30
function waitforclient(client) {
    while (!clienthassnapshot(client)) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x2cf8fc99, Offset: 0x3c0
// Size: 0x62
function get_dvar_float_default(str_dvar, default_val) {
    value = getdvarstring(str_dvar);
    return value != "" ? float(value) : default_val;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xa1e0e4b8, Offset: 0x430
// Size: 0x62
function get_dvar_int_default(str_dvar, default_val) {
    value = getdvarstring(str_dvar);
    return value != "" ? int(value) : default_val;
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x57dfef34, Offset: 0x4a0
// Size: 0x96
function spawn_model(n_client, str_model, origin = (0, 0, 0), angles = (0, 0, 0)) {
    model = spawn(n_client, origin, "script_model");
    model setmodel(str_model);
    model.angles = angles;
    return model;
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x972f3d56, Offset: 0x540
// Size: 0x82
function spawn_anim_model(n_client, model_name, origin, angles) {
    model = spawn_model(n_client, model_name, origin, angles);
    model useanimtree("generic");
    model.animtree = "generic";
    return model;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xd5348ff5, Offset: 0x5d0
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
// Checksum 0xc30edb18, Offset: 0x658
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
// Params 2, eflags: 0x0
// Checksum 0xb3ef7520, Offset: 0x700
// Size: 0x2a
function waittill_either(msg1, msg2) {
    self endon(msg1);
    self waittill(msg2);
}

// Namespace util/util_shared
// Params 1, eflags: 0x20 variadic
// Checksum 0x5d479bd0, Offset: 0x738
// Size: 0x1c4
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
// Params 2, eflags: 0x0
// Checksum 0x19c8f110, Offset: 0x908
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
// Params 14, eflags: 0x0
// Checksum 0x31e7c88c, Offset: 0x9c0
// Size: 0x166
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
// Params 4, eflags: 0x0
// Checksum 0xdf4dcb02, Offset: 0xb30
// Size: 0x80
function waittill_any_ents_two(ent1, string1, ent2, string2) {
    assert(isdefined(ent1));
    assert(isdefined(string1));
    if (isdefined(ent2) && isdefined(string2)) {
        ent2 endon(string2);
    }
    ent1 waittill(string1);
}

// Namespace util/util_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0xcaf961cc, Offset: 0xbb8
// Size: 0x3a
function single_func(entity, func, ...) {
    return _single_func(entity, func, vararg);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x5aa4fb47, Offset: 0xc00
// Size: 0x3a
function single_func_argarray(entity, func, a_vars) {
    return _single_func(entity, func, a_vars);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0xe15bed7d, Offset: 0xc48
// Size: 0x53a
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
        assertmsg("<dev string:x30>");
        break;
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x3ccadae6, Offset: 0x1190
// Size: 0x6e
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
// Checksum 0x539fb9a8, Offset: 0x1208
// Size: 0xca
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
// Checksum 0x38c42722, Offset: 0x12e0
// Size: 0x72
function call_func(s_func) {
    return single_func(self, s_func.func, s_func.arg1, s_func.arg2, s_func.arg3, s_func.arg4, s_func.arg5, s_func.arg6);
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0xfa3f015b, Offset: 0x1360
// Size: 0x164
function array_ent_thread(entities, func, arg1, arg2, arg3, arg4, arg5) {
    assert(isdefined(entities), "<dev string:x3f>");
    assert(isdefined(func), "<dev string:x77>");
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
// Params 8, eflags: 0x0
// Checksum 0xf5979524, Offset: 0x14d0
// Size: 0x162
function single_thread(entity, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    assert(isdefined(entity), "<dev string:xab>");
    if (isdefined(arg6)) {
        entity thread [[ func ]](arg1, arg2, arg3, arg4, arg5, arg6);
        return;
    }
    if (isdefined(arg5)) {
        entity thread [[ func ]](arg1, arg2, arg3, arg4, arg5);
        return;
    }
    if (isdefined(arg4)) {
        entity thread [[ func ]](arg1, arg2, arg3, arg4);
        return;
    }
    if (isdefined(arg3)) {
        entity thread [[ func ]](arg1, arg2, arg3);
        return;
    }
    if (isdefined(arg2)) {
        entity thread [[ func ]](arg1, arg2);
        return;
    }
    if (isdefined(arg1)) {
        entity thread [[ func ]](arg1);
        return;
    }
    entity thread [[ func ]]();
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x79474c21, Offset: 0x1640
// Size: 0x6c
function add_listen_thread(wait_till, func, param1, param2, param3, param4, param5) {
    level thread add_listen_thread_internal(wait_till, func, param1, param2, param3, param4, param5);
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x4a579418, Offset: 0x16b8
// Size: 0x78
function add_listen_thread_internal(wait_till, func, param1, param2, param3, param4, param5) {
    for (;;) {
        level waittill(wait_till);
        single_thread(level, func, param1, param2, param3, param4, param5);
    }
}

// Namespace util/util_shared
// Params 8, eflags: 0x0
// Checksum 0x90081bff, Offset: 0x1738
// Size: 0xe4
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
// Params 9, eflags: 0x0
// Checksum 0x404edefb, Offset: 0x1828
// Size: 0x84
function delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self thread _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 9, eflags: 0x0
// Checksum 0xb17ae884, Offset: 0x18b8
// Size: 0xe4
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
// Params 3, eflags: 0x0
// Checksum 0x22d1b426, Offset: 0x19a8
// Size: 0x3c
function delay_notify(time_or_notify, str_notify, str_endon) {
    self thread _delay_notify(time_or_notify, str_notify, str_endon);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x90d62611, Offset: 0x19f0
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
// Params 1, eflags: 0x0
// Checksum 0xc0574668, Offset: 0x1a88
// Size: 0x46
function new_timer(n_timer_length) {
    s_timer = spawnstruct();
    s_timer.n_time_created = gettime();
    s_timer.n_length = n_timer_length;
    return s_timer;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xca3f6916, Offset: 0x1ad8
// Size: 0x20
function get_time() {
    t_now = gettime();
    return t_now - self.n_time_created;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x7bdea9a6, Offset: 0x1b00
// Size: 0x34
function get_time_in_seconds() {
    return float(get_time()) / 1000;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xcf7eeb73, Offset: 0x1b40
// Size: 0x4a
function get_time_frac(n_end_time = self.n_length) {
    return lerpfloat(0, 1, get_time_in_seconds() / n_end_time);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xe04ff86a, Offset: 0x1b98
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
// Checksum 0x2fd9c8e4, Offset: 0x1bf8
// Size: 0x16
function is_time_left() {
    return get_time_left() != 0;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x71f322d9, Offset: 0x1c18
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
// Params 2, eflags: 0x0
// Checksum 0xba759fbe, Offset: 0x1c88
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
// Params 1, eflags: 0x0
// Checksum 0x10fa00f7, Offset: 0x1d18
// Size: 0xce
function clean_deleted(&array) {
    done = 0;
    while (!done && array.size > 0) {
        done = 1;
        foreach (key, val in array) {
            if (!isdefined(val)) {
                arrayremoveindex(array, key, 0);
                done = 0;
                break;
            }
        }
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x8295a8c3, Offset: 0x1df0
// Size: 0xe2
function get_eye() {
    if (sessionmodeiscampaigngame()) {
        if (self isplayer()) {
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
// Checksum 0x404b9d4f, Offset: 0x1ee0
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
// Checksum 0x5134b779, Offset: 0x1f98
// Size: 0x142
function lerp_dvar(str_dvar, n_start_val = getdvarfloat(str_dvar, 0), n_end_val, n_lerp_time, b_saved_dvar, b_client_dvar, n_client = 0) {
    s_timer = new_timer();
    do {
        n_time_delta = s_timer timer_wait(0.01666);
        n_curr_val = lerpfloat(n_start_val, n_end_val, n_time_delta / n_lerp_time);
        if (isdefined(b_saved_dvar) && b_saved_dvar) {
            setsaveddvar(str_dvar, n_curr_val);
            continue;
        }
        setdvar(str_dvar, n_curr_val);
    } while (n_time_delta < n_lerp_time);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xa2fdf7e7, Offset: 0x20e8
// Size: 0x1e
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
        return true;
    default:
        return false;
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x55ab591e, Offset: 0x21e0
// Size: 0xa8
function wait_till_not_touching(e_to_check, e_to_touch) {
    assert(isdefined(e_to_check), "<dev string:xdc>");
    assert(isdefined(e_to_touch), "<dev string:x11a>");
    e_to_check endon(#"death");
    e_to_touch endon(#"death");
    while (e_to_check istouching(e_to_touch)) {
        waitframe(1);
    }
}

/#

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0x6fe72045, Offset: 0x2290
    // Size: 0x32
    function error(message) {
        println("<dev string:x158>", message);
        waitframe(1);
    }

#/

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x924d4d89, Offset: 0x22d0
// Size: 0xe2
function register_system(ssysname, cbfunc) {
    if (!isdefined(level._systemstates)) {
        level._systemstates = [];
    }
    if (level._systemstates.size >= 32) {
        /#
            error("<dev string:x166>");
        #/
        return;
    }
    if (isdefined(level._systemstates[ssysname])) {
        /#
            error("<dev string:x187>" + ssysname);
        #/
        return;
    }
    level._systemstates[ssysname] = spawnstruct();
    level._systemstates[ssysname].callback = cbfunc;
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x6afd6edd, Offset: 0x23c0
// Size: 0x4a
function field_set_lighting_ent(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.light_entity = self;
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x20b330f8, Offset: 0x2418
// Size: 0x3c
function field_use_lighting_ent(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xcb13de11, Offset: 0x2460
// Size: 0x3c
function waittill_dobj(localclientnum) {
    while (isdefined(self) && !self hasdobj(localclientnum)) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x24660b06, Offset: 0x24a8
// Size: 0x6e
function playfxontag(localclientnum, effect, entity, tagname) {
    if (isdefined(entity) && entity hasdobj(localclientnum)) {
        return function_fb03c761(localclientnum, effect, entity, tagname);
    }
    return undefined;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x49d8f8bc, Offset: 0x2520
// Size: 0x34
function function_cee87e61() {
    while (isdefined(self) && !self function_cd182a88()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x5957b725, Offset: 0x2560
// Size: 0x140
function server_wait(localclientnum, seconds, waitbetweenchecks, level_endon) {
    if (isdefined(level_endon)) {
        level endon(level_endon);
    }
    if (seconds != 0 && isdemoplaying()) {
        if (!isdefined(waitbetweenchecks)) {
            waitbetweenchecks = 0.2;
        }
        waitcompletedsuccessfully = 0;
        starttime = level.servertime;
        lasttime = starttime;
        endtime = starttime + int(seconds * 1000);
        while (level.servertime < endtime && level.servertime >= lasttime) {
            lasttime = level.servertime;
            wait waitbetweenchecks;
        }
        if (lasttime < level.servertime) {
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
// Checksum 0x5acf53ae, Offset: 0x26a8
// Size: 0x8c
function get_other_team(str_team) {
    if (str_team == #"allies") {
        return #"axis";
    } else if (str_team == #"axis") {
        return #"allies";
    } else {
        return #"allies";
    }
    assertmsg("<dev string:x1af>" + str_team);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x29310d58, Offset: 0x2740
// Size: 0x90
function isenemyplayer(player) {
    assert(isdefined(player));
    if (!player isplayer()) {
        return false;
    }
    if (player.team != "free") {
        if (player.team == self.team) {
            return false;
        }
    } else if (player == self) {
        return false;
    }
    return true;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x82a65834, Offset: 0x27d8
// Size: 0xd2
function function_162f7df2(localclientnum) {
    function_2170ff73();
    if (!isdefined(self)) {
        return false;
    }
    if (!self function_60dbc438()) {
        return false;
    }
    if (function_9a47ed7f(localclientnum)) {
        return false;
    }
    if (localclientnum != self getlocalclientnumber()) {
        return false;
    }
    if (isdefined(level.localplayers[localclientnum]) && self getentitynumber() != level.localplayers[localclientnum] getentitynumber()) {
        return false;
    }
    return true;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x60c50ed3, Offset: 0x28b8
// Size: 0x4e
function is_player_view_linked_to_entity(localclientnum) {
    if (function_3de16bf8(localclientnum)) {
        return true;
    }
    if (function_8e3213c5(localclientnum)) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xc2cf108b, Offset: 0x2910
// Size: 0x12
function get_start_time() {
    return getmicrosecondsraw();
}

/#

    // Namespace util/util_shared
    // Params 2, eflags: 0x0
    // Checksum 0x4852d9c8, Offset: 0x2930
    // Size: 0x12c
    function note_elapsed_time(start_time, label = "unspecified") {
        elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());
        if (!isdefined(start_time)) {
            return;
        }
        elapsed_time *= 0.001;
        if (!isdefined(level.orbis)) {
            level.orbis = getdvarstring(#"orbisgame") == "<dev string:x1cb>";
        }
        if (!level.orbis) {
            elapsed_time = int(elapsed_time);
        }
        msg = label + "<dev string:x1d0>" + elapsed_time + "<dev string:x1e0>";
        profileprintln(msg);
        iprintlnbold(msg);
    }

#/

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x8a5b4d68, Offset: 0x2a68
// Size: 0x98
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
    // Params 2, eflags: 0x0
    // Checksum 0xec4a6f5b, Offset: 0x2b08
    // Size: 0x2c4
    function note_elapsed_times(&elapsed_time_array, label = "unspecified") {
        if (!isarray(elapsed_time_array)) {
            return;
        }
        msg = label + "<dev string:x1e4>" + elapsed_time_array.size;
        profileprintln(msg);
        if (elapsed_time_array.size == 0) {
            return;
        }
        if (!isdefined(level.orbis)) {
            level.orbis = getdvarstring(#"orbisgame") == "<dev string:x1cb>";
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
            msg = label + "<dev string:x1d0>" + elapsed_time + "<dev string:x1e0>";
            profileprintln(msg);
        }
        average_elapsed_time = total_elapsed_time / elapsed_time_array.size;
        msg = label + "<dev string:x1ef>" + average_elapsed_time + "<dev string:x1e0>";
        profileprintln(msg);
        iprintlnbold(msg);
        msg = label + "<dev string:x207>" + largest_elapsed_time + "<dev string:x1e0>";
        profileprintln(msg);
        msg = label + "<dev string:x21f>" + smallest_elapsed_time + "<dev string:x1e0>";
        profileprintln(msg);
    }

#/

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x7d8b47e0, Offset: 0x2dd8
// Size: 0x70
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
// Params 0, eflags: 0x0
// Checksum 0xd1f17e98, Offset: 0x2e50
// Size: 0xde
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
// Checksum 0x731de6be, Offset: 0x2f38
// Size: 0x90
function within_fov(start_origin, start_angles, end_origin, fov) {
    normal = vectornormalize(end_origin - start_origin);
    forward = anglestoforward(start_angles);
    dot = vectordot(forward, normal);
    return dot >= fov;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf4365be3, Offset: 0x2fd0
// Size: 0x12
function is_mature() {
    return ismaturecontentenabled();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x28094a49, Offset: 0x2ff0
// Size: 0x38
function is_gib_restricted_build() {
    if (!(ismaturecontentenabled() && isshowgibsenabled())) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x6bdbfcb8, Offset: 0x3030
// Size: 0xe2
function registersystem(ssysname, cbfunc) {
    if (!isdefined(level._systemstates)) {
        level._systemstates = [];
    }
    if (level._systemstates.size >= 32) {
        /#
            error("<dev string:x166>");
        #/
        return;
    }
    if (isdefined(level._systemstates[ssysname])) {
        /#
            error("<dev string:x187>" + ssysname);
        #/
        return;
    }
    level._systemstates[ssysname] = spawnstruct();
    level._systemstates[ssysname].callback = cbfunc;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xf54b7ed1, Offset: 0x3120
// Size: 0x5a
function add_trigger_to_ent(ent, trig) {
    if (!isdefined(ent._triggers)) {
        ent._triggers = [];
    }
    ent._triggers[trig getentitynumber()] = 1;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x222a4726, Offset: 0x3188
// Size: 0x72
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
// Params 1, eflags: 0x0
// Checksum 0x78a7e573, Offset: 0x3208
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
// Checksum 0xf94f69cd, Offset: 0x3280
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
// Checksum 0xddfcc0e, Offset: 0x3380
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
// Params 7, eflags: 0x0
// Checksum 0x743c0608, Offset: 0x3478
// Size: 0x9c
function local_player_entity_thread(localclientnum, entity, func, arg1, arg2, arg3, arg4) {
    entity endon(#"death");
    entity waittill_dobj(localclientnum);
    single_thread(entity, func, localclientnum, arg1, arg2, arg3, arg4);
}

// Namespace util/util_shared
// Params 6, eflags: 0x0
// Checksum 0x306fdeb8, Offset: 0x3520
// Size: 0xa6
function local_players_entity_thread(entity, func, arg1, arg2, arg3, arg4) {
    players = level.localplayers;
    for (i = 0; i < players.size; i++) {
        players[i] thread local_player_entity_thread(i, entity, func, arg1, arg2, arg3, arg4);
    }
}

/#

    // Namespace util/util_shared
    // Params 4, eflags: 0x0
    // Checksum 0x9c39dd49, Offset: 0x35d0
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
    // Checksum 0xf15bae2a, Offset: 0x3690
    // Size: 0xb4
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
// Params 0, eflags: 0x0
// Checksum 0x8c74d64b, Offset: 0x3750
// Size: 0x30
function servertime() {
    for (;;) {
        level.servertime = getservertime(0);
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x9f911d2e, Offset: 0x3788
// Size: 0x10c
function getnextobjid(localclientnum) {
    nextid = 0;
    if (level.releasedobjectives[localclientnum].size > 0) {
        nextid = level.releasedobjectives[localclientnum][level.releasedobjectives[localclientnum].size - 1];
        level.releasedobjectives[localclientnum][level.releasedobjectives[localclientnum].size - 1] = undefined;
    } else {
        nextid = level.numgametypereservedobjectives[localclientnum];
        level.numgametypereservedobjectives[localclientnum]++;
    }
    /#
        if (nextid > 31) {
            println("<dev string:x238>");
        }
        assert(nextid < 32);
    #/
    if (nextid > 31) {
        nextid = 31;
    }
    return nextid;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x76670b5, Offset: 0x38a0
// Size: 0xb8
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
// Checksum 0xbd77c26e, Offset: 0x3960
// Size: 0x28
function is_safehouse(str_next_map = get_map_name()) {
    return false;
}

/#

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0xf5e1f515, Offset: 0x3990
    // Size: 0x11a
    function button_held_think(which_button) {
        self endon(#"disconnect");
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
    // Checksum 0x2323e278, Offset: 0x3ab8
    // Size: 0x56
    function init_button_wrappers() {
        if (!isdefined(level._button_funcs)) {
            level._button_funcs[4] = &up_button_pressed;
            level._button_funcs[5] = &down_button_pressed;
        }
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x98b866cb, Offset: 0x3b18
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
    // Checksum 0x2fe37471, Offset: 0x3b88
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
    // Checksum 0x50a7962, Offset: 0x3bf8
    // Size: 0x46
    function up_button_pressed() {
        return self buttonpressed("<dev string:x263>") || self buttonpressed("<dev string:x26b>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x992feab3, Offset: 0x3c48
    // Size: 0x28
    function waittill_up_button_pressed() {
        while (!self up_button_pressed()) {
            waitframe(1);
        }
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x8b5b7f0d, Offset: 0x3c78
    // Size: 0x46
    function down_button_pressed() {
        return self buttonpressed("<dev string:x273>") || self buttonpressed("<dev string:x27d>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x82ed109, Offset: 0x3cc8
    // Size: 0x28
    function waittill_down_button_pressed() {
        while (!self down_button_pressed()) {
            waitframe(1);
        }
    }

#/

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xcd929bec, Offset: 0x3cf8
// Size: 0x6c
function function_d27ced7f() {
    if (sessionmodeiswarzonegame()) {
        return getdvarfloat(#"hash_4e7a02edee964bf9", 250);
    }
    return getdvarfloat(#"hash_4ec50cedeed64871", 250);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x17f8acaf, Offset: 0x3d70
// Size: 0x124
function function_1a1c8e97() {
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
// Params 4, eflags: 0x20 variadic
// Checksum 0xf9f47907, Offset: 0x3ea0
// Size: 0x17c
function lerp_generic(localclientnum, duration, callback, ...) {
    starttime = getservertime(localclientnum);
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
        currenttime = getservertime(localclientnum);
        if (currenttime < starttime) {
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
// Params 2, eflags: 0x0
// Checksum 0x762bc7ee, Offset: 0x4028
// Size: 0x6a
function function_6fa1120c(enemy_a, enemy_b) {
    assert(enemy_a != enemy_b, "<dev string:x287>");
    level.team_enemy_mapping[enemy_a] = enemy_b;
    level.team_enemy_mapping[enemy_b] = enemy_a;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xb2a07afc, Offset: 0x40a0
// Size: 0xb4
function function_2b9d78e6() {
    if (isdefined(level.var_c5eb0f1)) {
        return;
    }
    level.var_c5eb0f1 = 1;
    function_6fa1120c(#"allies", #"axis");
    function_6fa1120c(#"team3", #"any");
    set_team_mapping(#"allies", #"axis");
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0xdaf7df4a, Offset: 0x4160
// Size: 0x122
function cf_team_mapping(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
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
// Params 7, eflags: 0x0
// Checksum 0x93883bf3, Offset: 0x4290
// Size: 0x5c
function preload_frontend(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        preloadfrontend();
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xcbca173e, Offset: 0x42f8
// Size: 0x292
function set_team_mapping(str_team_for_sidea, str_team_for_sideb) {
    if (str_team_for_sidea == #"allies") {
        str_team_for_sidea = #"allies";
    } else if (str_team_for_sidea == #"axis") {
        str_team_for_sidea = #"axis";
    }
    if (str_team_for_sideb == #"axis") {
        str_team_for_sideb = #"axis";
    } else if (str_team_for_sideb == #"allies") {
        str_team_for_sideb = #"allies";
    }
    assert(str_team_for_sidea != str_team_for_sideb, "<dev string:x2cc>");
    level.team_mapping[#"sidea"] = str_team_for_sidea;
    level.team_mapping[#"sideb"] = str_team_for_sideb;
    level.team_mapping[#"attacker"] = str_team_for_sidea;
    level.team_mapping[#"defender"] = str_team_for_sideb;
    level.team_mapping[#"attackers"] = str_team_for_sidea;
    level.team_mapping[#"defenders"] = str_team_for_sideb;
    level.team_mapping[#"wun"] = #"allies";
    level.team_mapping[#"fpa"] = #"axis";
    level.team_mapping[#"teama"] = level.team_mapping[#"sidea"];
    level.team_mapping[#"teamb"] = level.team_mapping[#"sideb"];
    level.team_mapping[#"side3"] = #"team3";
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xf27fd796, Offset: 0x4598
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
// Checksum 0x9095dc19, Offset: 0x4608
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
// Checksum 0xd7f5a335, Offset: 0x4690
// Size: 0x13e
function function_66fe7264(teama, teamb) {
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
// Params 1, eflags: 0x0
// Checksum 0xe2c26aca, Offset: 0x47d8
// Size: 0x24
function is_on_side(str_team) {
    return self.team === get_team_mapping(str_team);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6d760eba, Offset: 0x4808
// Size: 0x32
function get_game_type() {
    return tolower(getdvarstring(#"g_gametype"));
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x5ec21b03, Offset: 0x4848
// Size: 0x32
function get_map_name() {
    return tolower(getdvarstring(#"sv_mapname"));
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x3c8de54c, Offset: 0x4888
// Size: 0x1c
function is_frontend_map() {
    return get_map_name() === "core_frontend";
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x52946e95, Offset: 0x48b0
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
// Params 1, eflags: 0x0
// Checksum 0x4701958f, Offset: 0x4a18
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
// Params 1, eflags: 0x0
// Checksum 0x53374879, Offset: 0x4ab8
// Size: 0x9c
function unlock_model(model) {
    if (isdefined(model)) {
        if (!isdefined(level.model_locks)) {
            level.model_locks = [];
        }
        if (!isdefined(level.model_locks[model])) {
            level.model_locks[model] = 0;
        }
        level.model_locks[model]--;
        if (level.model_locks[model] < 1) {
            stopforcestreamingxmodel(model);
        }
    }
}

