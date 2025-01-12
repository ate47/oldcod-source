#using scripts/core_common/array_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/trigger_shared;
#using scripts/core_common/util_shared;

#namespace util;

// Namespace util/util_shared
// Params 0, eflags: 0x2
// Checksum 0xec48af81, Offset: 0x3c0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("util_shared", &__init__, undefined, undefined);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x7ac09255, Offset: 0x400
// Size: 0x14
function __init__() {
    register_clientfields();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xb60001d2, Offset: 0x420
// Size: 0x4c
function register_clientfields() {
    clientfield::register("world", "cf_team_mapping", 1, 1, "int", &cf_team_mapping, 0, 0);
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x60f995e8, Offset: 0x478
// Size: 0x2c
function empty(a, b, c, d, e) {
    
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xcadf71bf, Offset: 0x4b0
// Size: 0x96
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
// Params 1, eflags: 0x0
// Checksum 0x1ce409d1, Offset: 0x550
// Size: 0x30
function waitforclient(client) {
    while (!clienthassnapshot(client)) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x58fe4e9c, Offset: 0x588
// Size: 0x62
function get_dvar_float_default(str_dvar, default_val) {
    value = getdvarstring(str_dvar);
    return value != "" ? float(value) : default_val;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xba0588ce, Offset: 0x5f8
// Size: 0x62
function get_dvar_int_default(str_dvar, default_val) {
    value = getdvarstring(str_dvar);
    return value != "" ? int(value) : default_val;
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x483f41d6, Offset: 0x668
// Size: 0xac
function spawn_model(n_client, str_model, origin, angles) {
    if (!isdefined(origin)) {
        origin = (0, 0, 0);
    }
    if (!isdefined(angles)) {
        angles = (0, 0, 0);
    }
    model = spawn(n_client, origin, "script_model");
    model setmodel(str_model);
    model.angles = angles;
    return model;
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0xffe91435, Offset: 0x720
// Size: 0x84
function spawn_anim_model(n_client, model_name, origin, angles) {
    model = spawn_model(n_client, model_name, origin, angles);
    model useanimtree(#generic);
    model.animtree = "generic";
    return model;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x4392d45b, Offset: 0x7b0
// Size: 0x68
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
// Checksum 0xf6e394e0, Offset: 0x820
// Size: 0xac
function waittill_multiple(...) {
    s_tracker = spawnstruct();
    s_tracker._wait_count = 0;
    for (i = 0; i < vararg.size; i++) {
        self thread _waitlogic(s_tracker, vararg[i]);
    }
    if (s_tracker._wait_count > 0) {
        s_tracker waittill("waitlogic_finished");
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x20 variadic
// Checksum 0x809158c6, Offset: 0x8d8
// Size: 0x1e4
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
        s_tracker waittill("waitlogic_finished");
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xd7b7407d, Offset: 0xac8
// Size: 0xc4
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
// Checksum 0x1e7c6f47, Offset: 0xb98
// Size: 0x182
function waittill_any_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
    /#
        assert(isdefined(ent1));
    #/
    /#
        assert(isdefined(string1));
    #/
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
// Checksum 0x7cd8aef6, Offset: 0xd28
// Size: 0x92
function waittill_any_ents_two(ent1, string1, ent2, string2) {
    /#
        assert(isdefined(ent1));
    #/
    /#
        assert(isdefined(string1));
    #/
    if (isdefined(ent2) && isdefined(string2)) {
        ent2 endon(string2);
    }
    ent1 waittill(string1);
}

// Namespace util/util_shared
// Params 8, eflags: 0x0
// Checksum 0xbbc9c257, Offset: 0xdc8
// Size: 0x170
function single_func(entity, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    if (!isdefined(entity)) {
        entity = level;
    }
    if (isdefined(arg6)) {
        return entity [[ func ]](arg1, arg2, arg3, arg4, arg5, arg6);
    }
    if (isdefined(arg5)) {
        return entity [[ func ]](arg1, arg2, arg3, arg4, arg5);
    }
    if (isdefined(arg4)) {
        return entity [[ func ]](arg1, arg2, arg3, arg4);
    }
    if (isdefined(arg3)) {
        return entity [[ func ]](arg1, arg2, arg3);
    }
    if (isdefined(arg2)) {
        return entity [[ func ]](arg1, arg2);
    }
    if (isdefined(arg1)) {
        return entity [[ func ]](arg1);
    }
    return entity [[ func ]]();
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x10d4a95d, Offset: 0xf40
// Size: 0xe8
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
// Checksum 0xd8144c29, Offset: 0x1030
// Size: 0x72
function call_func(s_func) {
    return single_func(self, s_func.func, s_func.arg1, s_func.arg2, s_func.arg3, s_func.arg4, s_func.arg5, s_func.arg6);
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x7d7a878d, Offset: 0x10b0
// Size: 0x16c
function array_ent_thread(entities, func, arg1, arg2, arg3, arg4, arg5) {
    /#
        assert(isdefined(entities), "<dev string:x28>");
    #/
    /#
        assert(isdefined(func), "<dev string:x60>");
    #/
    if (isarray(entities)) {
        if (entities.size) {
            keys = getarraykeys(entities);
            for (i = 0; i < keys.size; i++) {
                single_thread(self, func, entities[keys[i]], arg1, arg2, arg3, arg4, arg5);
            }
        }
        return;
    }
    single_thread(self, func, entities, arg1, arg2, arg3, arg4, arg5);
}

// Namespace util/util_shared
// Params 8, eflags: 0x0
// Checksum 0x82a7bd21, Offset: 0x1228
// Size: 0x184
function single_thread(entity, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    /#
        assert(isdefined(entity), "<dev string:x94>");
    #/
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
// Checksum 0xaa42c26f, Offset: 0x13b8
// Size: 0x6c
function add_listen_thread(wait_till, func, param1, param2, param3, param4, param5) {
    level thread add_listen_thread_internal(wait_till, func, param1, param2, param3, param4, param5);
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x87572e23, Offset: 0x1430
// Size: 0x80
function add_listen_thread_internal(wait_till, func, param1, param2, param3, param4, param5) {
    for (;;) {
        level waittill(wait_till);
        single_thread(level, func, param1, param2, param3, param4, param5);
    }
}

// Namespace util/util_shared
// Params 8, eflags: 0x0
// Checksum 0xd32ee174, Offset: 0x14b8
// Size: 0xd4
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
// Checksum 0xe916f0d4, Offset: 0x1598
// Size: 0x84
function delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self thread _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 9, eflags: 0x0
// Checksum 0xead8f137, Offset: 0x1628
// Size: 0xcc
function _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self endon(#"death");
    if (isdefined(str_endon)) {
        self endon(str_endon);
    }
    if (isstring(time_or_notify)) {
        self waittill(time_or_notify);
    } else {
        wait time_or_notify;
    }
    single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x22867af6, Offset: 0x1700
// Size: 0x3c
function delay_notify(time_or_notify, str_notify, str_endon) {
    self thread _delay_notify(time_or_notify, str_notify, str_endon);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x9bf2889, Offset: 0x1748
// Size: 0x76
function _delay_notify(time_or_notify, str_notify, str_endon) {
    self endon(#"death");
    if (isdefined(str_endon)) {
        self endon(str_endon);
    }
    if (isstring(time_or_notify)) {
        self waittill(time_or_notify);
    } else {
        wait time_or_notify;
    }
    self notify(str_notify);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x8c94c80f, Offset: 0x17c8
// Size: 0x50
function new_timer(n_timer_length) {
    s_timer = spawnstruct();
    s_timer.n_time_created = gettime();
    s_timer.n_length = n_timer_length;
    return s_timer;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x3f3b5d4b, Offset: 0x1820
// Size: 0x24
function get_time() {
    t_now = gettime();
    return t_now - self.n_time_created;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xd13b9b86, Offset: 0x1850
// Size: 0x18
function get_time_in_seconds() {
    return get_time() / 1000;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xb193d658, Offset: 0x1870
// Size: 0x52
function get_time_frac(n_end_time) {
    if (!isdefined(n_end_time)) {
        n_end_time = self.n_length;
    }
    return lerpfloat(0, 1, get_time_in_seconds() / n_end_time);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x7a2b9720, Offset: 0x18d0
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
// Checksum 0xd8b2862e, Offset: 0x1930
// Size: 0x16
function is_time_left() {
    return get_time_left() != 0;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x6d639473, Offset: 0x1950
// Size: 0x74
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
// Checksum 0x51b364ea, Offset: 0x19d0
// Size: 0x84
function add_remove_list(&a, on_off) {
    if (!isdefined(a)) {
        a = [];
    }
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
// Checksum 0xeec9b0f0, Offset: 0x1a60
// Size: 0xe2
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
// Checksum 0xc4897db2, Offset: 0x1b50
// Size: 0xd4
function get_eye() {
    if (sessionmodeiscampaigngame()) {
        if (self isplayer()) {
            linked_ent = self getlinkedent();
            if (isdefined(linked_ent) && getdvarint("cg_cameraUseTagCamera") > 0) {
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
// Checksum 0x7a7a2137, Offset: 0x1c30
// Size: 0xb0
function spawn_player_arms() {
    arms = spawn(self getlocalclientnumber(), self.origin + (0, 0, -1000), "script_model");
    if (isdefined(level.player_viewmodel)) {
        arms setmodel(level.player_viewmodel);
    } else {
        arms setmodel("c_usa_cia_masonjr_viewhands");
    }
    return arms;
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x59539ebb, Offset: 0x1ce8
// Size: 0x142
function lerp_dvar(str_dvar, n_start_val, n_end_val, n_lerp_time, b_saved_dvar, b_client_dvar, n_client) {
    if (!isdefined(n_client)) {
        n_client = 0;
    }
    if (!isdefined(n_start_val)) {
        n_start_val = getdvarfloat(str_dvar);
    }
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
// Checksum 0x87e06ccc, Offset: 0x1e38
// Size: 0x1e
function is_valid_type_for_callback(type) {
    switch (type) {
    case #"na":
    case #"actor":
    case #"general":
    case #"helicopter":
    case #"missile":
    case #"plane":
    case #"player":
    case #"scriptmover":
    case #"trigger":
    case #"turret":
    case #"vehicle":
        return true;
    default:
        return false;
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xde67f048, Offset: 0x1ec8
// Size: 0xa8
function wait_till_not_touching(e_to_check, e_to_touch) {
    /#
        assert(isdefined(e_to_check), "<dev string:xc5>");
    #/
    /#
        assert(isdefined(e_to_touch), "<dev string:x103>");
    #/
    e_to_check endon(#"death");
    e_to_touch endon(#"death");
    while (e_to_check istouching(e_to_touch)) {
        waitframe(1);
    }
}

/#

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0x8f349c44, Offset: 0x1f78
    // Size: 0x32
    function error(message) {
        println("<dev string:x141>", message);
        waitframe(1);
    }

#/

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x5bd919cf, Offset: 0x1fb8
// Size: 0xf0
function register_system(ssysname, cbfunc) {
    if (!isdefined(level._systemstates)) {
        level._systemstates = [];
    }
    if (level._systemstates.size >= 32) {
        /#
            error("<dev string:x14f>");
        #/
        return;
    }
    if (isdefined(level._systemstates[ssysname])) {
        /#
            error("<dev string:x170>" + ssysname);
        #/
        return;
    }
    level._systemstates[ssysname] = spawnstruct();
    level._systemstates[ssysname].callback = cbfunc;
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x9401e8ae, Offset: 0x20b0
// Size: 0x4c
function field_set_lighting_ent(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.light_entity = self;
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x260cdb0a, Offset: 0x2108
// Size: 0x3c
function field_use_lighting_ent(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x7c4be3f, Offset: 0x2150
// Size: 0x3a
function waittill_dobj(localclientnum) {
    while (isdefined(self) && !self hasdobj(localclientnum)) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x7fbf9ee3, Offset: 0x2198
// Size: 0x13e
function server_wait(localclientnum, seconds, waitbetweenchecks, level_endon) {
    if (isdefined(level_endon)) {
        level endon(level_endon);
    }
    if (level.isdemoplaying && seconds != 0) {
        if (!isdefined(waitbetweenchecks)) {
            waitbetweenchecks = 0.2;
        }
        waitcompletedsuccessfully = 0;
        starttime = level.servertime;
        lasttime = starttime;
        endtime = starttime + seconds * 1000;
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
// Params 2, eflags: 0x0
// Checksum 0x95bd653, Offset: 0x22e0
// Size: 0x14c
function friend_not_foe(var_1d8cde9, var_56abff8b) {
    player = getnonpredictedlocalplayer(var_1d8cde9);
    if (isdefined(player) && isdefined(player.team) && (isdefined(var_56abff8b) && var_56abff8b || player.team == "spectator")) {
        player = getlocalplayer(var_1d8cde9);
    }
    if (isdefined(player) && isdefined(player.team)) {
        team = player.team;
        if (team == "free") {
            owner = self getowner(var_1d8cde9);
            if (isdefined(owner) && owner == player) {
                return true;
            }
        } else if (self.team == team) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x6b3a3a53, Offset: 0x2438
// Size: 0xe4
function friend_not_foe_team(var_1d8cde9, team, var_56abff8b) {
    player = getnonpredictedlocalplayer(var_1d8cde9);
    if (isdefined(player) && isdefined(player.team) && (isdefined(var_56abff8b) && var_56abff8b || player.team == "spectator")) {
        player = getlocalplayer(var_1d8cde9);
    }
    if (isdefined(player) && isdefined(player.team)) {
        if (player.team == team) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x1e3d1a17, Offset: 0x2528
// Size: 0x74
function get_other_team(str_team) {
    if (str_team == "allies") {
        return "axis";
    } else if (str_team == "axis") {
        return "allies";
    } else {
        return "allies";
    }
    /#
        assertmsg("<dev string:x198>" + str_team);
    #/
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x11fbbbb5, Offset: 0x25a8
// Size: 0x9c
function isenemyplayer(player) {
    /#
        assert(isdefined(player));
    #/
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
// Checksum 0xc1ab05f6, Offset: 0x2650
// Size: 0x4e
function is_player_view_linked_to_entity(localclientnum) {
    if (self isdriving(localclientnum)) {
        return true;
    }
    if (self islocalplayerweaponviewonlylinked()) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x17cbf389, Offset: 0x26a8
// Size: 0x12
function get_start_time() {
    return getmicrosecondsraw();
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x658852b3, Offset: 0x26c8
// Size: 0xec
function note_elapsed_time(start_time, label) {
    if (!isdefined(label)) {
        label = "unspecified";
    }
    /#
        elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());
        if (!isdefined(start_time)) {
            return;
        }
        elapsed_time *= 0.001;
        if (!level.orbis) {
            elapsed_time = int(elapsed_time);
        }
        msg = label + "<dev string:x1b4>" + elapsed_time + "<dev string:x1c4>";
        iprintlnbold(msg);
    #/
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x4d188d36, Offset: 0x27c0
// Size: 0xa2
function record_elapsed_time(start_time, &elapsed_time_array) {
    elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());
    if (!isdefined(elapsed_time_array)) {
        elapsed_time_array = [];
    } else if (!isarray(elapsed_time_array)) {
        elapsed_time_array = array(elapsed_time_array);
    }
    elapsed_time_array[elapsed_time_array.size] = elapsed_time;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x456fc13, Offset: 0x2870
// Size: 0x304
function note_elapsed_times(&elapsed_time_array, label) {
    if (!isdefined(label)) {
        label = "unspecified";
    }
    /#
        if (!isarray(elapsed_time_array)) {
            return;
        }
        msg = label + "<dev string:x1c8>" + elapsed_time_array.size;
        profileprintln(msg);
        if (elapsed_time_array.size == 0) {
            return;
        }
        if (!isdefined(level.orbis)) {
            level.orbis = getdvarstring("<dev string:x1d3>") == "<dev string:x1dd>";
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
            msg = label + "<dev string:x1b4>" + elapsed_time + "<dev string:x1c4>";
            profileprintln(msg);
        }
        average_elapsed_time = total_elapsed_time / elapsed_time_array.size;
        msg = label + "<dev string:x1e2>" + average_elapsed_time + "<dev string:x1c4>";
        profileprintln(msg);
        iprintlnbold(msg);
        msg = label + "<dev string:x1fa>" + largest_elapsed_time + "<dev string:x1c4>";
        profileprintln(msg);
        msg = label + "<dev string:x212>" + smallest_elapsed_time + "<dev string:x1c4>";
        profileprintln(msg);
    #/
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x7fb2c239, Offset: 0x2b80
// Size: 0x82
function get_elapsed_time(start_time, end_time) {
    if (!isdefined(end_time)) {
        end_time = getmicrosecondsraw();
    }
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
// Checksum 0xd4184d10, Offset: 0x2c10
// Size: 0xf0
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
// Checksum 0x749de770, Offset: 0x2d08
// Size: 0xa2
function within_fov(start_origin, start_angles, end_origin, fov) {
    normal = vectornormalize(end_origin - start_origin);
    forward = anglestoforward(start_angles);
    dot = vectordot(forward, normal);
    return dot >= fov;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x89ecfa32, Offset: 0x2db8
// Size: 0x12
function is_mature() {
    return ismaturecontentenabled();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa55421d8, Offset: 0x2dd8
// Size: 0x36
function is_gib_restricted_build() {
    if (!(ismaturecontentenabled() && isshowgibsenabled())) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x17c4e0d4, Offset: 0x2e18
// Size: 0xf0
function registersystem(ssysname, cbfunc) {
    if (!isdefined(level._systemstates)) {
        level._systemstates = [];
    }
    if (level._systemstates.size >= 32) {
        /#
            error("<dev string:x14f>");
        #/
        return;
    }
    if (isdefined(level._systemstates[ssysname])) {
        /#
            error("<dev string:x170>" + ssysname);
        #/
        return;
    }
    level._systemstates[ssysname] = spawnstruct();
    level._systemstates[ssysname].callback = cbfunc;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6b7f86df, Offset: 0x2f10
// Size: 0x4c
function function_bc37a245() {
    if (sessionmodeiscampaigngame()) {
        return "gamedata/stats/cp/cp_statstable.csv";
    }
    if (sessionmodeiszombiesgame()) {
        return "gamedata/stats/zm/zm_statstable.csv";
    }
    return "gamedata/stats/mp/mp_statstable.csv";
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x5e26ce65, Offset: 0x2f68
// Size: 0x62
function add_trigger_to_ent(ent, trig) {
    if (!isdefined(ent._triggers)) {
        ent._triggers = [];
    }
    ent._triggers[trig getentitynumber()] = 1;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x173bab81, Offset: 0x2fd8
// Size: 0x82
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
// Checksum 0x916f6b67, Offset: 0x3068
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
// Checksum 0x160c1a45, Offset: 0x30e0
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
// Checksum 0xc2a08f83, Offset: 0x31e0
// Size: 0xf4
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
// Checksum 0x5cc93ed6, Offset: 0x32e0
// Size: 0x94
function local_player_entity_thread(localclientnum, entity, func, arg1, arg2, arg3, arg4) {
    entity endon(#"death");
    entity waittill_dobj(localclientnum);
    single_thread(entity, func, localclientnum, arg1, arg2, arg3, arg4);
}

// Namespace util/util_shared
// Params 6, eflags: 0x0
// Checksum 0x5e956057, Offset: 0x3380
// Size: 0xae
function local_players_entity_thread(entity, func, arg1, arg2, arg3, arg4) {
    players = level.localplayers;
    for (i = 0; i < players.size; i++) {
        players[i] thread local_player_entity_thread(i, entity, func, arg1, arg2, arg3, arg4);
    }
}

/#

    // Namespace util/util_shared
    // Params 4, eflags: 0x0
    // Checksum 0xa6809aa8, Offset: 0x3438
    // Size: 0xb4
    function debug_line(from, to, color, time) {
        level.debug_line = getdvarint("<dev string:x22b>", 0);
        if (isdefined(level.debug_line) && level.debug_line == 1) {
            if (!isdefined(time)) {
                time = 1000;
            }
            line(from, to, color, 1, 1, time);
        }
    }

    // Namespace util/util_shared
    // Params 3, eflags: 0x0
    // Checksum 0x1b24d6f3, Offset: 0x34f8
    // Size: 0xb4
    function debug_star(origin, color, time) {
        level.debug_star = getdvarint("<dev string:x23a>", 0);
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
// Checksum 0x69c7f59b, Offset: 0x35b8
// Size: 0x32
function servertime() {
    for (;;) {
        level.servertime = getservertime(0);
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x55068cff, Offset: 0x35f8
// Size: 0x128
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
            println("<dev string:x249>");
        }
        /#
            assert(nextid < 32);
        #/
    #/
    if (nextid > 31) {
        nextid = 31;
    }
    return nextid;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x6e47ad88, Offset: 0x3728
// Size: 0xc8
function releaseobjid(localclientnum, objid) {
    /#
        assert(objid < level.numgametypereservedobjectives[localclientnum]);
    #/
    for (i = 0; i < level.releasedobjectives[localclientnum].size; i++) {
        if (objid == level.releasedobjectives[localclientnum][i]) {
            return;
        }
    }
    level.releasedobjectives[localclientnum][level.releasedobjectives[localclientnum].size] = objid;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xd970f73, Offset: 0x37f8
// Size: 0x2e
function function_3eb32a89(str_next_map) {
    switch (str_next_map) {
    case #"cp_mi_sing_biodomes":
    case #"cp_mi_sing_blackstation":
    case #"cp_mi_sing_sgen":
        return "cp_sh_singapore";
    case #"cp_mi_cairo_aquifer":
    case #"cp_mi_cairo_infection":
    case #"cp_mi_cairo_lotus":
        return "cp_sh_cairo";
    default:
        return "cp_sh_mobile";
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x9e6528e8, Offset: 0x3870
// Size: 0x5a
function is_safehouse(str_next_map) {
    if (!isdefined(str_next_map)) {
        str_next_map = tolower(getdvarstring("mapname"));
    }
    switch (str_next_map) {
    case #"hash_c0022b6f":
    case #"cp_sh_mobile":
    case #"hash_709124d9":
        return true;
    default:
        return false;
    }
}

/#

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0x32949cdf, Offset: 0x3900
    // Size: 0x128
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
    // Checksum 0x19dbd41c, Offset: 0x3a30
    // Size: 0x56
    function init_button_wrappers() {
        if (!isdefined(level._button_funcs)) {
            level._button_funcs[4] = &up_button_pressed;
            level._button_funcs[5] = &down_button_pressed;
        }
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xdca02063, Offset: 0x3a90
    // Size: 0x66
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
    // Checksum 0xeabd04a7, Offset: 0x3b00
    // Size: 0x66
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
    // Checksum 0x48b85535, Offset: 0x3b70
    // Size: 0x44
    function up_button_pressed() {
        return self buttonpressed("<dev string:x274>") || self buttonpressed("<dev string:x27c>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x34edd7c5, Offset: 0x3bc0
    // Size: 0x28
    function waittill_up_button_pressed() {
        while (!self up_button_pressed()) {
            waitframe(1);
        }
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc071628d, Offset: 0x3bf0
    // Size: 0x44
    function down_button_pressed() {
        return self buttonpressed("<dev string:x284>") || self buttonpressed("<dev string:x28e>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x92bd1b0f, Offset: 0x3c40
    // Size: 0x28
    function waittill_down_button_pressed() {
        while (!self down_button_pressed()) {
            waitframe(1);
        }
    }

#/

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0xf01cb485, Offset: 0x3c70
// Size: 0x4ea
function _single_func(entity, func, a_vars) {
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
        /#
            assertmsg("<dev string:x298>");
        #/
        break;
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x29190014, Offset: 0x4168
// Size: 0x76
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
// Params 4, eflags: 0x20 variadic
// Checksum 0x13640ce3, Offset: 0x41e8
// Size: 0x154
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
        elapsedtime = currenttime - starttime;
    }
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x3c04e936, Offset: 0x4348
// Size: 0xd6
function cf_team_mapping(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 0:
        set_team_mapping("axis", "allies");
        break;
    case 1:
        set_team_mapping("allies", "axis");
        break;
    default:
        set_team_mapping("allies", "axis");
        break;
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xfd811a2d, Offset: 0x4428
// Size: 0x1ea
function set_team_mapping(str_team_for_sidea, str_team_for_sideb) {
    if (tolower(str_team_for_sidea) == "wun") {
        str_team_for_sidea = "allies";
    } else if (tolower(str_team_for_sidea) == "fpa") {
        str_team_for_sidea = "axis";
    }
    if (tolower(str_team_for_sideb) == "fpa") {
        str_team_for_sideb = "axis";
    } else if (tolower(str_team_for_sideb) == "wun") {
        str_team_for_sideb = "allies";
    }
    /#
        assert(str_team_for_sidea != str_team_for_sideb, "<dev string:x2a7>");
    #/
    level.team_mapping["sidea"] = str_team_for_sidea;
    level.team_mapping["sideb"] = str_team_for_sideb;
    level.team_mapping["wun"] = "allies";
    level.team_mapping["fpa"] = "axis";
    level.team_mapping["teama"] = level.team_mapping["sidea"];
    level.team_mapping["teamb"] = level.team_mapping["sideb"];
    level.team_mapping["side3"] = "team3";
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x3a2af0d2, Offset: 0x4620
// Size: 0x9e
function get_team_mapping(str_team) {
    if (isdefined(level.team_mapping) && isdefined(str_team)) {
        str_team = tolower(str_team);
        a_keys = getarraykeys(level.team_mapping);
        if (isinarray(a_keys, str_team)) {
            return level.team_mapping[str_team];
        }
    }
    return str_team;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x261d81fa, Offset: 0x46c8
// Size: 0x2c
function is_on_side(str_team) {
    return self.team === get_team_mapping(str_team);
}

