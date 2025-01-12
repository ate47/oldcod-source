#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace renderoverridebundle;

// Namespace renderoverridebundle/renderoverridebundle
// Params 0, eflags: 0x2
// Checksum 0x4d8363d, Offset: 0xd8
// Size: 0x34
function autoexec __init__system__() {
    system::register("renderoverridebundle", &__init__, undefined, undefined);
}

// Namespace renderoverridebundle/renderoverridebundle
// Params 0, eflags: 0x0
// Checksum 0xee80f2f1, Offset: 0x118
// Size: 0xac
function __init__() {
    level.renderoverridebundle = {#local_clients:[], #var_9b5a544f:[]};
    callback::on_localclient_connect(&function_7e71b8dd);
    function_9f4eff5e(#"hash_ebb37dab2ee0ae3", sessionmodeiscampaigngame() ? #"rob_sonar_set_friendlyequip_cp" : #"rob_sonar_set_friendlyequip_mp", &function_c84d46f);
}

// Namespace renderoverridebundle/renderoverridebundle
// Params 1, eflags: 0x0
// Checksum 0x652a0955, Offset: 0x1d0
// Size: 0x6c
function function_7e71b8dd(clientnum) {
    if (!isdefined(level.renderoverridebundle.local_clients[clientnum])) {
        level.renderoverridebundle.local_clients[clientnum] = {#var_e9b96670:[]};
    }
    thread function_e9b96670(clientnum);
}

// Namespace renderoverridebundle/renderoverridebundle
// Params 4, eflags: 0x4
// Checksum 0x432957bd, Offset: 0x248
// Size: 0xae
function private function_4bbf2756(var_a375db18, bundle, validity_func, var_92e316b5) {
    /#
        var_563952cc = level.renderoverridebundle.var_9b5a544f[var_a375db18];
        if (!isdefined(var_563952cc)) {
            return 0;
        }
        if (var_563952cc.bundle != bundle) {
            return 1;
        }
        if (var_563952cc.validity_func != validity_func) {
            return 1;
        }
        if (var_563952cc.var_92e316b5 != var_92e316b5) {
            return 1;
        }
        return 0;
    #/
}

// Namespace renderoverridebundle/renderoverridebundle
// Params 4, eflags: 0x0
// Checksum 0xd786faa4, Offset: 0x300
// Size: 0xfe
function function_9f4eff5e(var_a375db18, bundle, validity_func, var_92e316b5) {
    assert(isdefined(level.renderoverridebundle));
    if (!isdefined(level.renderoverridebundle.var_9b5a544f)) {
        level.renderoverridebundle.var_9b5a544f = [];
    }
    assert(!function_4bbf2756(var_a375db18, bundle, validity_func, var_92e316b5));
    level.renderoverridebundle.var_9b5a544f[var_a375db18] = {#bundle:bundle, #validity_func:validity_func, #var_92e316b5:var_92e316b5};
}

// Namespace renderoverridebundle/renderoverridebundle
// Params 2, eflags: 0x0
// Checksum 0xa6b52593, Offset: 0x408
// Size: 0x5c
function function_33af47c1(local_client_num, var_a375db18) {
    assert(isdefined(level.renderoverridebundle.var_9b5a544f[var_a375db18]));
    return level.renderoverridebundle.var_9b5a544f[var_a375db18];
}

// Namespace renderoverridebundle/renderoverridebundle
// Params 1, eflags: 0x0
// Checksum 0xd1cdbc81, Offset: 0x470
// Size: 0x236
function function_e9b96670(local_client_num) {
    while (true) {
        result = level waittill(#"demo_jump", #"killcam_begin", #"killcam_end", #"player_switch", #"joined_team", #"localplayer_spawned", #"hash_7f642789ed08aae0");
        if (result._notify == "killcam_end") {
            function_9084ad97(local_client_num);
        }
        foreach (entity_num, entity_array in level.renderoverridebundle.local_clients[local_client_num].var_e9b96670) {
            entity = getentbynum(local_client_num, entity_num);
            if (isalive(entity)) {
                foreach (flag, var_a375db18 in entity_array) {
                    if (function_d224c0e6(local_client_num) && var_a375db18 != #"hash_71fbf1094f57b910") {
                        continue;
                    }
                    entity thread function_15e70783(local_client_num, flag, var_a375db18);
                }
            }
        }
        waitframe(1);
    }
}

// Namespace renderoverridebundle/renderoverridebundle
// Params 1, eflags: 0x0
// Checksum 0x9e8c2859, Offset: 0x6b0
// Size: 0x144
function function_9084ad97(local_client_num) {
    foreach (entity_num, entity_array in level.renderoverridebundle.local_clients[local_client_num].var_e9b96670) {
        entity = getentbynum(local_client_num, entity_num);
        if (!isdefined(entity)) {
            continue;
        }
        foreach (flag, var_563952cc in entity_array) {
            if (entity flag::exists(flag)) {
                entity flag::clear(flag);
            }
        }
    }
}

// Namespace renderoverridebundle/renderoverridebundle
// Params 2, eflags: 0x0
// Checksum 0x9c7c5f9, Offset: 0x800
// Size: 0x96
function start_bundle(flag, bundle) {
    is_set = flag::get(flag);
    if (!flag::get(flag)) {
        self flag::toggle(flag);
        self playrenderoverridebundle(bundle);
        self notify("kill" + flag + bundle);
    }
}

// Namespace renderoverridebundle/renderoverridebundle
// Params 2, eflags: 0x0
// Checksum 0x56b8d54e, Offset: 0x8a0
// Size: 0x74
function stop_bundle(flag, bundle) {
    self notify("kill" + flag + bundle);
    if (flag::get(flag)) {
        self flag::toggle(flag);
        self stoprenderoverridebundle(bundle);
    }
}

// Namespace renderoverridebundle/renderoverridebundle
// Params 4, eflags: 0x0
// Checksum 0xfbe8135c, Offset: 0x920
// Size: 0xb4
function fade_bundle(localclientnum, flag, bundle, fadeduration) {
    self endon(#"death");
    if (flag::get(flag)) {
        util::lerp_generic(localclientnum, fadeduration, &function_1feccf19, 1, 0, bundle);
    }
    wait float(fadeduration) / 1000;
    stop_bundle(flag, bundle);
}

// Namespace renderoverridebundle/renderoverridebundle
// Params 7, eflags: 0x0
// Checksum 0x55d10d23, Offset: 0x9e0
// Size: 0xa4
function function_1feccf19(currenttime, elapsedtime, localclientnum, fadeduration, from, to, bundle) {
    percent = elapsedtime / fadeduration;
    amount = to * percent + from * (1 - percent);
    self function_98a01e4c(bundle, #"alpha", amount);
}

// Namespace renderoverridebundle/renderoverridebundle
// Params 2, eflags: 0x0
// Checksum 0x670f627e, Offset: 0xa90
// Size: 0xb6
function function_27735faa(local_client_num, var_38e5c836) {
    if (!isdefined(var_38e5c836.validity_func) && isdefined(var_38e5c836.var_92e316b5)) {
        return 1;
    }
    if (isdefined(var_38e5c836.var_92e316b5)) {
        if (!isdefined(var_38e5c836.validity_func)) {
            return var_38e5c836.var_92e316b5;
        }
        return [[ var_38e5c836.validity_func ]](local_client_num, var_38e5c836.bundle, var_38e5c836.var_92e316b5);
    }
    return [[ var_38e5c836.validity_func ]](local_client_num, var_38e5c836.bundle);
}

// Namespace renderoverridebundle/renderoverridebundle
// Params 3, eflags: 0x0
// Checksum 0x8dfebe59, Offset: 0xb50
// Size: 0x1f4
function function_15e70783(local_client_num, flag, var_a375db18) {
    if (!self flag::exists(flag)) {
        self flag::init(flag);
    }
    if (self.type === "actor_corpse" || self.type === "vehicle_corpse") {
        return;
    }
    var_38e5c836 = function_33af47c1(local_client_num, var_a375db18);
    if (function_27735faa(local_client_num, var_38e5c836)) {
        self start_bundle(flag, var_38e5c836.bundle);
    } else {
        self stop_bundle(flag, var_38e5c836.bundle);
    }
    entity_num = self getentitynumber();
    if (!isdefined(level.renderoverridebundle.local_clients[local_client_num])) {
        level.renderoverridebundle.local_clients[local_client_num] = {#var_e9b96670:[]};
    }
    if (!isdefined(level.renderoverridebundle.local_clients[local_client_num].var_e9b96670[entity_num])) {
        level.renderoverridebundle.local_clients[local_client_num].var_e9b96670[entity_num] = [];
    }
    level.renderoverridebundle.local_clients[local_client_num].var_e9b96670[entity_num][flag] = var_a375db18;
}

// Namespace renderoverridebundle/renderoverridebundle
// Params 2, eflags: 0x0
// Checksum 0x32a985ee, Offset: 0xd50
// Size: 0x74
function function_c84d46f(local_client_num, bundle) {
    if (!self function_31d3dfec()) {
        return false;
    }
    if (isdefined(level.vision_pulse) && isdefined(level.vision_pulse[local_client_num]) && level.vision_pulse[local_client_num]) {
        return false;
    }
    return true;
}

// Namespace renderoverridebundle/renderoverridebundle
// Params 2, eflags: 0x0
// Checksum 0x65ee8d42, Offset: 0xdd0
// Size: 0x4e
function function_fa682688(local_client_num, bundle) {
    if (self function_60dbc438()) {
        return false;
    }
    if (self function_31d3dfec()) {
        return false;
    }
    return true;
}

// Namespace renderoverridebundle/renderoverridebundle
// Params 4, eflags: 0x0
// Checksum 0xa82d1496, Offset: 0xe28
// Size: 0x94
function function_78b7aef9(local_client_num, field_name, bundle, var_cbf7a46e) {
    local_player = function_f97e7787(local_client_num);
    should_play = isdefined(local_player) ? local_player clientfield::get_to_player(field_name) : 0;
    self function_a95eb710(local_client_num, should_play, bundle, var_cbf7a46e);
}

// Namespace renderoverridebundle/renderoverridebundle
// Params 4, eflags: 0x0
// Checksum 0x54f644e9, Offset: 0xec8
// Size: 0xac
function function_a95eb710(local_client_num, should_play, bundle, var_cbf7a46e) {
    if (isdefined(var_cbf7a46e)) {
        should_play = self [[ var_cbf7a46e ]](local_client_num, should_play);
    }
    is_playing = self function_40a6c199(bundle);
    if (should_play) {
        if (!is_playing) {
            self playrenderoverridebundle(bundle);
        }
        return;
    }
    if (is_playing) {
        self stoprenderoverridebundle(bundle);
    }
}

