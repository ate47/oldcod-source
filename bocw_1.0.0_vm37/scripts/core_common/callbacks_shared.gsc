#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\simple_hostmigration;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;

#namespace callback;

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7b54b73d, Offset: 0x108
// Size: 0x5c
function callback(event, params) {
    mpl_heatwave_fx(level, event, params);
    if (self != level) {
        mpl_heatwave_fx(self, event, params);
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa3623824, Offset: 0x170
// Size: 0xb8
function function_bea20a96(event, params) {
    ais = getaiarray();
    foreach (ai in ais) {
        ai mpl_heatwave_fx(ai, event, params);
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xf3a460f6, Offset: 0x230
// Size: 0xd8
function function_daed27e8(event, params) {
    players = getplayers();
    foreach (player in players) {
        player mpl_heatwave_fx(level, event, params);
        player mpl_heatwave_fx(player, event, params);
    }
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x4
// Checksum 0x8fd89eca, Offset: 0x310
// Size: 0x1dc
function private mpl_heatwave_fx(ent, event, params) {
    callbacks = ent._callbacks[event];
    if (isdefined(callbacks)) {
        for (i = 0; i < callbacks.size; i++) {
            callback_fields = callbacks[i];
            if (!isarray(callback_fields)) {
                continue;
            }
            callback = callback_fields[0];
            assert(isfunctionptr(callback), "<dev string:x38>" + "<dev string:x53>");
            if (!isfunctionptr(callback)) {
                return;
            }
            obj = callback_fields[1];
            var_47e0b77b = callback_fields[2];
            if (!isdefined(var_47e0b77b)) {
                var_47e0b77b = [];
            }
            if (isdefined(obj)) {
                if (isdefined(params)) {
                    util::function_cf55c866(obj, callback, self, params, var_47e0b77b);
                } else {
                    util::function_50f54b6f(obj, callback, self, var_47e0b77b);
                }
                continue;
            }
            if (isdefined(params)) {
                util::function_50f54b6f(self, callback, params, var_47e0b77b);
                continue;
            }
            util::single_thread_argarray(self, callback, var_47e0b77b);
        }
        arrayremovevalue(callbacks, 0, 0);
    }
}

// Namespace callback/callbacks_shared
// Params 4, eflags: 0x0
// Checksum 0x1994e34e, Offset: 0x4f8
// Size: 0x44
function add_callback(event, func, obj, a_params) {
    function_2b653c00(level, event, func, obj, a_params);
}

// Namespace callback/callbacks_shared
// Params 4, eflags: 0x0
// Checksum 0x64a4f64c, Offset: 0x548
// Size: 0x44
function function_d8abfc3d(event, func, obj, a_params) {
    function_2b653c00(self, event, func, obj, a_params);
}

// Namespace callback/callbacks_shared
// Params 5, eflags: 0x4
// Checksum 0xeb55da11, Offset: 0x598
// Size: 0x204
function private function_2b653c00(ent, event, func, obj, a_params) {
    if (!isdefined(ent)) {
        return;
    }
    assert(isfunctionptr(func), "<dev string:x70>" + "<dev string:x53>");
    if (!isfunctionptr(func)) {
        return;
    }
    assert(isdefined(event), "<dev string:x94>");
    if (!(isdefined(ent._callbacks) && isdefined(ent._callbacks[event]))) {
        ent._callbacks[event] = [];
    }
    foreach (callback in ent._callbacks[event]) {
        if (isarray(callback) && callback[0] == func) {
            if (!isdefined(obj) || callback[1] == obj) {
                return;
            }
        }
    }
    array::add(ent._callbacks[event], array(func, obj, a_params), 0);
    if (isdefined(obj)) {
        obj thread remove_callback_on_death(event, func);
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x4
// Checksum 0xbba7445, Offset: 0x7a8
// Size: 0x3c
function private function_862146b3(event, func) {
    return string(event) + string(func);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x510af9d, Offset: 0x7f0
// Size: 0x84
function remove_callback_on_death(event, func) {
    self notify(function_862146b3(event, func));
    self endon(function_862146b3(event, func));
    self waittill(#"death", #"remove_callbacks");
    remove_callback(event, func, self);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x0
// Checksum 0x619dcd4e, Offset: 0x880
// Size: 0x3c
function remove_callback(event, func, obj) {
    function_3f5f097e(level, event, func, obj);
}

// Namespace callback/callbacks_shared
// Params 4, eflags: 0x0
// Checksum 0xd8b9c4fc, Offset: 0x8c8
// Size: 0x44
function function_52ac9652(event, func, obj, instant) {
    function_3f5f097e(self, event, func, obj, instant);
}

// Namespace callback/callbacks_shared
// Params 5, eflags: 0x4
// Checksum 0xdbae72d3, Offset: 0x918
// Size: 0x1c2
function private function_3f5f097e(ent, event, func, obj, instant) {
    if (!isdefined(ent._callbacks)) {
        return;
    }
    assert(isdefined(event), "<dev string:xc7>");
    if (func === "all") {
        ent._callbacks[event] = [];
        return;
    }
    if (!isdefined(ent._callbacks[event])) {
        return;
    }
    if (is_true(instant)) {
        arrayremovevalue(ent._callbacks[event], 0, 0);
        return;
    }
    foreach (index, func_group in ent._callbacks[event]) {
        if (isarray(func_group) && func_group[0] == func) {
            if (func_group[1] === obj) {
                if (isdefined(obj)) {
                    obj notify(function_862146b3(event, func));
                }
                ent._callbacks[event][index] = 0;
                break;
            }
        }
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x52a02539, Offset: 0xae8
// Size: 0x3c
function on_finalize_initialization(func, obj) {
    add_callback(#"on_finalize_initialization", func, obj);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0xc7d5599d, Offset: 0xb30
// Size: 0x44
function on_connect(func, obj, ...) {
    add_callback(#"on_player_connect", func, obj, vararg);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x2d4c1194, Offset: 0xb80
// Size: 0x3c
function remove_on_connect(func, obj) {
    remove_callback(#"on_player_connect", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x1a60bf2b, Offset: 0xbc8
// Size: 0x3c
function on_connecting(func, obj) {
    add_callback(#"on_player_connecting", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xe3362890, Offset: 0xc10
// Size: 0x3c
function remove_on_connecting(func, obj) {
    remove_callback(#"on_player_connecting", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7de68b57, Offset: 0xc58
// Size: 0x3c
function on_disconnect(func, obj) {
    add_callback(#"on_player_disconnect", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xf79f9cfa, Offset: 0xca0
// Size: 0x3c
function remove_on_disconnect(func, obj) {
    remove_callback(#"on_player_disconnect", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xff85339a, Offset: 0xce8
// Size: 0x3c
function on_spawned(func, obj) {
    add_callback(#"on_player_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x21c3cc00, Offset: 0xd30
// Size: 0x3c
function remove_on_spawned(func, obj) {
    remove_callback(#"on_player_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x86634de9, Offset: 0xd78
// Size: 0x3c
function remove_on_revived(func, obj) {
    remove_callback(#"on_player_revived", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x185f848d, Offset: 0xdc0
// Size: 0x3c
function on_deleted(func, obj) {
    add_callback(#"on_entity_deleted", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x4a9572fa, Offset: 0xe08
// Size: 0x3c
function remove_on_deleted(func, obj) {
    remove_callback(#"on_entity_deleted", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x509b5edc, Offset: 0xe50
// Size: 0x3c
function on_loadout(func, obj) {
    add_callback(#"on_loadout", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x109f1a36, Offset: 0xe98
// Size: 0x3c
function remove_on_loadout(func, obj) {
    remove_callback(#"on_loadout", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xe832ea43, Offset: 0xee0
// Size: 0x3c
function on_player_damage(func, obj) {
    add_callback(#"on_player_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x4a7ee4d8, Offset: 0xf28
// Size: 0x3c
function remove_on_player_damage(func, obj) {
    remove_callback(#"on_player_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x812ff0d2, Offset: 0xf70
// Size: 0x3c
function on_start_gametype(func, obj) {
    add_callback(#"on_start_gametype", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7ffcaec7, Offset: 0xfb8
// Size: 0x3c
function on_end_game(func, obj) {
    add_callback(#"on_end_game", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x29d87032, Offset: 0x1000
// Size: 0x3c
function function_14dae612(func, obj) {
    add_callback(#"hash_1b5be9017cd4b5fa", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x973f5e22, Offset: 0x1048
// Size: 0x3c
function on_game_playing(func, obj) {
    add_callback(#"on_game_playing", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb0f2cdc5, Offset: 0x1090
// Size: 0x3c
function function_359493ba(func, obj) {
    add_callback(#"hash_7177603f5415549b", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x72063ccd, Offset: 0x10d8
// Size: 0x3c
function on_joined_team(func, obj) {
    add_callback(#"joined_team", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa741d6c3, Offset: 0x1120
// Size: 0x3c
function on_joined_spectate(func, obj) {
    add_callback(#"on_joined_spectate", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xeb96710, Offset: 0x1168
// Size: 0x3c
function on_player_killed(func, obj) {
    add_callback(#"on_player_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xbcf33763, Offset: 0x11b0
// Size: 0x3c
function function_c046382d(func, obj) {
    add_callback(#"hash_2fea1d218f4c6a1f", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa9a53e1f, Offset: 0x11f8
// Size: 0x3c
function on_player_corpse(func, obj) {
    add_callback(#"on_player_corpse", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x8f4e19c2, Offset: 0x1240
// Size: 0x3c
function remove_on_player_killed(func, obj) {
    remove_callback(#"on_player_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x2c6b1984, Offset: 0x1288
// Size: 0x3c
function function_489cbdb4(func, obj) {
    remove_callback(#"hash_2fea1d218f4c6a1f", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xbb385c22, Offset: 0x12d0
// Size: 0x3c
function function_80270643(func, obj) {
    add_callback(#"on_team_eliminated", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x26ab77d4, Offset: 0x1318
// Size: 0x3c
function function_c53a8ab8(func, obj) {
    remove_callback(#"on_team_eliminated", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa9f3fc23, Offset: 0x1360
// Size: 0x3c
function on_ai_killed(func, obj) {
    add_callback(#"on_ai_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xbe09b1d, Offset: 0x13a8
// Size: 0x3c
function remove_on_ai_killed(func, obj) {
    remove_callback(#"on_ai_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xf54a2fbf, Offset: 0x13f0
// Size: 0x3c
function on_actor_killed(func, obj) {
    add_callback(#"on_actor_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x330c1548, Offset: 0x1438
// Size: 0x3c
function remove_on_actor_killed(func, obj) {
    remove_callback(#"on_actor_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x53879d53, Offset: 0x1480
// Size: 0x3c
function function_30c3f95d(func, obj) {
    function_d8abfc3d(#"hash_3d6ccbbe0e628b2d", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xd5ca814d, Offset: 0x14c8
// Size: 0x3c
function function_95ba5345(func, obj) {
    function_52ac9652(#"hash_3d6ccbbe0e628b2d", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa4ceef7e, Offset: 0x1510
// Size: 0x3c
function on_vehicle_spawned(func, obj) {
    add_callback(#"on_vehicle_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x69d6aece, Offset: 0x1558
// Size: 0x3c
function remove_on_vehicle_spawned(func, obj) {
    remove_callback(#"on_vehicle_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb500d93d, Offset: 0x15a0
// Size: 0x3c
function on_vehicle_killed(func, obj) {
    add_callback(#"on_vehicle_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x6902b70d, Offset: 0x15e8
// Size: 0x3c
function on_vehicle_collision(func, obj) {
    function_d8abfc3d(#"veh_collision", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x4d743773, Offset: 0x1630
// Size: 0x3c
function remove_on_vehicle_killed(func, obj) {
    remove_callback(#"on_vehicle_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x495becf7, Offset: 0x1678
// Size: 0x3c
function on_ai_damage(func, obj) {
    add_callback(#"on_ai_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x44c88ae3, Offset: 0x16c0
// Size: 0x3c
function remove_on_ai_damage(func, obj) {
    remove_callback(#"on_ai_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x267af4eb, Offset: 0x1708
// Size: 0x3c
function on_ai_spawned(func, obj) {
    add_callback(#"on_ai_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xbb79926f, Offset: 0x1750
// Size: 0x3c
function remove_on_ai_spawned(func, obj) {
    remove_callback(#"on_ai_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x6f3b4a76, Offset: 0x1798
// Size: 0x3c
function function_f642faf2(func, obj) {
    add_callback(#"hash_7d2e38b28c894e5a", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb3792b22, Offset: 0x17e0
// Size: 0x3c
function function_c1017156(func, obj) {
    remove_callback(#"hash_7d2e38b28c894e5a", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x58ab813d, Offset: 0x1828
// Size: 0x3c
function on_actor_damage(func, obj) {
    add_callback(#"on_actor_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x906a92b2, Offset: 0x1870
// Size: 0x3c
function remove_on_actor_damage(func, obj) {
    remove_callback(#"on_actor_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x56f5cca6, Offset: 0x18b8
// Size: 0x3c
function function_9d78f548(func, obj) {
    add_callback(#"hash_2e68909d4e4ed889", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xe7825dee, Offset: 0x1900
// Size: 0x3c
function function_f125b93a(func, obj) {
    remove_callback(#"hash_2e68909d4e4ed889", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7477691d, Offset: 0x1948
// Size: 0x3c
function on_vehicle_damage(func, obj) {
    add_callback(#"on_vehicle_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x148bc44d, Offset: 0x1990
// Size: 0x3c
function remove_on_vehicle_damage(func, obj) {
    remove_callback(#"on_vehicle_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa31239d4, Offset: 0x19d8
// Size: 0x3c
function on_downed(func, obj) {
    add_callback(#"on_player_downed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x555749f1, Offset: 0x1a20
// Size: 0x3c
function remove_on_downed(func, obj) {
    remove_callback(#"on_player_downed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xbf404502, Offset: 0x1a68
// Size: 0x3c
function on_laststand(func, obj) {
    add_callback(#"on_player_laststand", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x62605d12, Offset: 0x1ab0
// Size: 0x3c
function remove_on_laststand(func, obj) {
    remove_callback(#"on_player_laststand", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7a859817, Offset: 0x1af8
// Size: 0x3c
function on_bleedout(func, obj) {
    add_callback(#"on_player_bleedout", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xe844c7a8, Offset: 0x1b40
// Size: 0x3c
function on_revived(func, obj) {
    add_callback(#"on_player_revived", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x5f1c1bdd, Offset: 0x1b88
// Size: 0x3c
function on_mission_failed(func, obj) {
    add_callback(#"on_mission_failed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x5c742b9b, Offset: 0x1bd0
// Size: 0x3c
function on_challenge_complete(func, obj) {
    add_callback(#"on_challenge_complete", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x26b11a6, Offset: 0x1c18
// Size: 0x3c
function on_weapon_change(func, obj) {
    add_callback(#"weapon_change", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa7d9d58b, Offset: 0x1c60
// Size: 0x3c
function remove_on_weapon_change(func, obj) {
    remove_callback(#"weapon_change", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x46caf48a, Offset: 0x1ca8
// Size: 0x3c
function on_weapon_fired(func, obj) {
    add_callback(#"weapon_fired", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x673cdd4, Offset: 0x1cf0
// Size: 0x3c
function remove_on_weapon_fired(func, obj) {
    remove_callback(#"weapon_fired", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa49565a2, Offset: 0x1d38
// Size: 0x3c
function on_grenade_fired(func, obj) {
    add_callback(#"grenade_fired", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x72dfa87b, Offset: 0x1d80
// Size: 0x3c
function remove_on_grenade_fired(func, obj) {
    remove_callback(#"grenade_fired", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xc4c363fe, Offset: 0x1dc8
// Size: 0x3c
function on_offhand_fire(func, obj) {
    add_callback(#"offhand_fire", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x6b3c8a83, Offset: 0x1e10
// Size: 0x3c
function remove_on_offhand_fire(func, obj) {
    remove_callback(#"offhand_fire", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x2d60f116, Offset: 0x1e58
// Size: 0x3c
function function_4b7977fe(func, obj) {
    add_callback(#"hash_198a389d6b65f68d", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x8779340, Offset: 0x1ea0
// Size: 0x3c
function function_61583a71(func, obj) {
    remove_callback(#"hash_198a389d6b65f68d", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xaa4b2b0, Offset: 0x1ee8
// Size: 0x3c
function on_detonate(func, obj) {
    function_d8abfc3d(#"detonate", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x806625e6, Offset: 0x1f30
// Size: 0x3c
function remove_on_detonate(func, obj) {
    function_52ac9652(#"detonate", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x99d8f9d4, Offset: 0x1f78
// Size: 0x3c
function on_double_tap_detonate(func, obj) {
    function_d8abfc3d(#"doubletap_detonate", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x70008865, Offset: 0x1fc0
// Size: 0x3c
function remove_on_double_tap_detonate(func, obj) {
    function_52ac9652(#"doubletap_detonate", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x219abe4a, Offset: 0x2008
// Size: 0x3c
function on_death(func, obj) {
    function_d8abfc3d(#"death", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x1aa67deb, Offset: 0x2050
// Size: 0x3c
function remove_on_death(func, obj) {
    function_52ac9652(#"death", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x9f3d6cf4, Offset: 0x2098
// Size: 0x3c
function function_27d9ab8(func, obj) {
    add_callback(#"hash_1e4a4ca774f4ce22", func, obj);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0x823e023f, Offset: 0x20e0
// Size: 0x44
function on_trigger(func, obj, ...) {
    function_d8abfc3d(#"on_trigger", func, obj, vararg);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xfed359e0, Offset: 0x2130
// Size: 0x3c
function remove_on_trigger(func, obj) {
    function_52ac9652(#"on_trigger", func, obj);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0x14dd9b8, Offset: 0x2178
// Size: 0x44
function on_trigger_once(func, obj, ...) {
    function_d8abfc3d(#"on_trigger_once", func, obj, vararg);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb104044, Offset: 0x21c8
// Size: 0x3c
function remove_on_trigger_once(func, obj) {
    function_52ac9652(#"on_trigger_once", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x797ba618, Offset: 0x2210
// Size: 0x3c
function function_33f0ddd3(func, obj) {
    add_callback(#"hash_39bf72fd97e248a0", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x4aa89b82, Offset: 0x2258
// Size: 0x3c
function function_824d206(func, obj) {
    remove_callback(#"hash_39bf72fd97e248a0", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x90861e9c, Offset: 0x22a0
// Size: 0x3c
function on_boast(func, obj) {
    add_callback(#"on_boast", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xbe884109, Offset: 0x22e8
// Size: 0x3c
function remove_on_boast(func, obj) {
    remove_callback(#"on_boast", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7d1e3551, Offset: 0x2330
// Size: 0x3c
function function_5753ac6e(func, obj) {
    add_callback(#"hash_4a9c56bba76da754", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x8ad8ed3e, Offset: 0x2378
// Size: 0x3c
function function_16046baa(func, obj) {
    remove_callback(#"hash_4a9c56bba76da754", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xc897a256, Offset: 0x23c0
// Size: 0x3c
function on_ping(func, obj) {
    add_callback(#"on_ping", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x599bf07b, Offset: 0x2408
// Size: 0x3c
function on_menu_response(func, obj) {
    add_callback(#"menu_response", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x6e8ef727, Offset: 0x2450
// Size: 0x3c
function function_96bbd5dc(func, obj) {
    remove_callback(#"menu_response", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x2049e50f, Offset: 0x2498
// Size: 0x3c
function on_item_pickup(func, obj) {
    add_callback(#"on_item_pickup", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x53d5dd74, Offset: 0x24e0
// Size: 0x3c
function on_item_drop(func, obj) {
    add_callback(#"on_drop_item", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x636d3110, Offset: 0x2528
// Size: 0x3c
function on_drop_inventory(func, obj) {
    add_callback(#"on_drop_inventory", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x37253efd, Offset: 0x2570
// Size: 0x3c
function on_item_use(func, obj) {
    add_callback(#"on_item_use", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb7f0d532, Offset: 0x25b8
// Size: 0x3c
function on_stash_open(func, obj) {
    add_callback(#"on_stash_open", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xca06eda9, Offset: 0x2600
// Size: 0x3c
function on_character_unlock(func, obj) {
    add_callback(#"on_character_unlock", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x8f171fb9, Offset: 0x2648
// Size: 0x3c
function on_contract_complete(func, obj) {
    add_callback(#"contract_complete", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x9503bd3f, Offset: 0x2690
// Size: 0x6c
function function_6700e8b5(func, obj) {
    if (self == level) {
        add_callback(#"hash_4428d68b23082312", func, obj);
        return;
    }
    function_d8abfc3d(#"hash_4428d68b23082312", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa91b894f, Offset: 0x2708
// Size: 0x6c
function function_900862de(func, obj) {
    if (self == level) {
        add_callback(#"hash_4b4c187e584b34ac", func, obj);
        return;
    }
    function_d8abfc3d(#"hash_4b4c187e584b34ac", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xc2bea328, Offset: 0x2780
// Size: 0x6c
function function_be4cb7fe(func, obj) {
    if (self == level) {
        add_callback(#"hash_255b4626805810f5", func, obj);
        return;
    }
    function_d8abfc3d(#"hash_255b4626805810f5", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xf985f5d1, Offset: 0x27f8
// Size: 0x3c
function on_rappel(func, obj) {
    add_callback(#"on_rappel", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xbd97e114, Offset: 0x2840
// Size: 0x3c
function function_c16ce2bc(func, obj) {
    add_callback(#"hash_52c6deac4a362083", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x38a2d5a2, Offset: 0x2888
// Size: 0x3c
function function_e5340d32(func, obj) {
    add_callback(#"hash_3b6ebf3a7ab5c795", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x3bb1cfdc, Offset: 0x28d0
// Size: 0x3c
function function_d4f0a93d(func, obj) {
    remove_callback(#"hash_3b6ebf3a7ab5c795", func, obj);
}

// Namespace callback/level_preinit
// Params 1, eflags: 0x40
// Checksum 0x4da1fefd, Offset: 0x2918
// Size: 0x3c
function event_handler[level_preinit] codecallback_preinitialization(*eventstruct) {
    system::run_pre_systems();
    flag::set(#"preinit");
}

// Namespace callback/level_init
// Params 1, eflags: 0x40
// Checksum 0xe2ab7d69, Offset: 0x2960
// Size: 0x2c
function event_handler[level_init] function_4123368a(*eventstruct) {
    flag::set(#"levelinit");
}

// Namespace callback/event_cc819519
// Params 1, eflags: 0x40
// Checksum 0x95dad4e4, Offset: 0x2998
// Size: 0x3c
function event_handler[event_cc819519] function_12c01a61(*eventstruct) {
    system::run_post_systems();
    flag::set(#"postinit");
}

// Namespace callback/level_finalizeinit
// Params 1, eflags: 0x40
// Checksum 0x9ab33f7, Offset: 0x29e0
// Size: 0x5c
function event_handler[level_finalizeinit] codecallback_finalizeinitialization(*eventstruct) {
    system::function_b1553822();
    flag::set(#"hash_4f4b65226250fc99");
    callback(#"on_finalize_initialization");
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xbf9e598f, Offset: 0x2a48
// Size: 0x40
function add_weapon_damage(weapontype, callback) {
    if (!isdefined(level.weapon_damage_callback_array)) {
        level.weapon_damage_callback_array = [];
    }
    level.weapon_damage_callback_array[weapontype] = callback;
}

// Namespace callback/callbacks_shared
// Params 5, eflags: 0x0
// Checksum 0x9c36be15, Offset: 0x2a90
// Size: 0xca
function callback_weapon_damage(eattacker, einflictor, weapon, meansofdeath, damage) {
    if (isdefined(level.weapon_damage_callback_array)) {
        if (isdefined(level.weapon_damage_callback_array[weapon])) {
            self thread [[ level.weapon_damage_callback_array[weapon] ]](eattacker, einflictor, weapon, meansofdeath, damage);
            return true;
        } else if (isdefined(level.weapon_damage_callback_array[weapon.rootweapon])) {
            self thread [[ level.weapon_damage_callback_array[weapon.rootweapon] ]](eattacker, einflictor, weapon, meansofdeath, damage);
            return true;
        }
    }
    return false;
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x8d2496d6, Offset: 0x2b68
// Size: 0x40
function add_weapon_fired(weapon, callback) {
    if (!isdefined(level.var_129c2069)) {
        level.var_129c2069 = [];
    }
    level.var_129c2069[weapon] = callback;
}

// Namespace callback/callbacks_shared
// Params 1, eflags: 0x0
// Checksum 0x20c2c20a, Offset: 0x2bb0
// Size: 0xa2
function callback_weapon_fired(weapon) {
    if (isdefined(weapon) && isdefined(level.var_129c2069)) {
        if (isdefined(level.var_129c2069[weapon])) {
            self thread [[ level.var_129c2069[weapon] ]](weapon);
            return true;
        } else if (isdefined(level.var_129c2069[weapon.rootweapon])) {
            self thread [[ level.var_129c2069[weapon.rootweapon] ]](weapon);
            return true;
        }
    }
    return false;
}

// Namespace callback/gametype_start
// Params 1, eflags: 0x40
// Checksum 0xa02ad18e, Offset: 0x2c60
// Size: 0x5c
function event_handler[gametype_start] codecallback_startgametype(*eventstruct) {
    if (!isdefined(level.gametypestarted) || !level.gametypestarted) {
        if (isdefined(level.callbackstartgametype)) {
            [[ level.callbackstartgametype ]]();
        }
        level.gametypestarted = 1;
    }
}

// Namespace callback/player_connect
// Params 1, eflags: 0x40
// Checksum 0xa23058de, Offset: 0x2cc8
// Size: 0x30
function event_handler[player_connect] codecallback_playerconnect(*eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayerconnect ]]();
}

// Namespace callback/player_disconnect
// Params 1, eflags: 0x40
// Checksum 0x7ba622dd, Offset: 0x2d00
// Size: 0x94
function event_handler[player_disconnect] codecallback_playerdisconnect(*eventstruct) {
    self.player_disconnected = 1;
    self notify(#"disconnect");
    level notify(#"disconnect", self);
    self notify(#"death");
    [[ level.callbackplayerdisconnect ]]();
    callback(#"on_player_disconnect");
}

// Namespace callback/hostmigration_setupgametype
// Params 0, eflags: 0x40
// Checksum 0xc3298c98, Offset: 0x2da0
// Size: 0x34
function event_handler[hostmigration_setupgametype] codecallback_migration_setupgametype() {
    println("<dev string:xfd>");
    simple_hostmigration::migration_setupgametype();
}

// Namespace callback/hostmigration
// Params 1, eflags: 0x40
// Checksum 0x99b5aec8, Offset: 0x2de0
// Size: 0x3c
function event_handler[hostmigration] codecallback_hostmigration(*eventstruct) {
    println("<dev string:x12d>");
    [[ level.callbackhostmigration ]]();
}

// Namespace callback/hostmigration_save
// Params 1, eflags: 0x40
// Checksum 0xd36b64c, Offset: 0x2e28
// Size: 0x3c
function event_handler[hostmigration_save] codecallback_hostmigrationsave(*eventstruct) {
    println("<dev string:x153>");
    [[ level.callbackhostmigrationsave ]]();
}

// Namespace callback/hostmigration_premigrationsave
// Params 1, eflags: 0x40
// Checksum 0x907cc424, Offset: 0x2e70
// Size: 0x3c
function event_handler[hostmigration_premigrationsave] codecallback_prehostmigrationsave(*eventstruct) {
    println("<dev string:x17d>");
    [[ level.callbackprehostmigrationsave ]]();
}

// Namespace callback/hostmigration_playermigrated
// Params 1, eflags: 0x40
// Checksum 0x281f3caf, Offset: 0x2eb8
// Size: 0x3c
function event_handler[hostmigration_playermigrated] codecallback_playermigrated(*eventstruct) {
    println("<dev string:x1aa>");
    [[ level.callbackplayermigrated ]]();
}

// Namespace callback/player_damage
// Params 1, eflags: 0x40
// Checksum 0x3fc99efb, Offset: 0x2f00
// Size: 0x98
function event_handler[player_damage] codecallback_playerdamage(eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayerdamage ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.normal);
}

// Namespace callback/player_killed
// Params 1, eflags: 0x40
// Checksum 0x78090204, Offset: 0x2fa0
// Size: 0x78
function event_handler[player_killed] codecallback_playerkilled(eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayerkilled ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset, eventstruct.death_anim_duration);
}

// Namespace callback/event_2958ea55
// Params 1, eflags: 0x40
// Checksum 0x57193ad4, Offset: 0x3020
// Size: 0x68
function event_handler[event_2958ea55] function_73e8e3f9(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_3a9881cb)) {
        [[ level.var_3a9881cb ]](eventstruct.attacker, eventstruct.effect_name, eventstruct.var_894859a2, eventstruct.durationoverride, eventstruct.weapon);
    }
}

// Namespace callback/event_a98a54a7
// Params 1, eflags: 0x40
// Checksum 0x8b2507f2, Offset: 0x3090
// Size: 0x38
function event_handler[event_a98a54a7] function_323548ba(eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayershielddamageblocked ]](eventstruct.damage);
}

// Namespace callback/player_laststand
// Params 1, eflags: 0x40
// Checksum 0x7424fe08, Offset: 0x30d0
// Size: 0x8c
function event_handler[player_laststand] codecallback_playerlaststand(eventstruct) {
    self endon(#"disconnect");
    self stopanimscripted();
    [[ level.callbackplayerlaststand ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset, eventstruct.delay);
}

// Namespace callback/event_dd67c1a8
// Params 1, eflags: 0x40
// Checksum 0xf93f7e46, Offset: 0x3168
// Size: 0x38
function event_handler[event_dd67c1a8] function_46c0443b(eventstruct) {
    self endon(#"disconnect");
    [[ level.var_69959686 ]](eventstruct.weapon);
}

// Namespace callback/event_1294e3a7
// Params 1, eflags: 0x40
// Checksum 0x372e9f6d, Offset: 0x31a8
// Size: 0x48
function event_handler[event_1294e3a7] function_9e4c68e2(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_bb1ea3f1)) {
        [[ level.var_bb1ea3f1 ]](eventstruct.weapon);
    }
}

// Namespace callback/event_eb7e11e4
// Params 1, eflags: 0x40
// Checksum 0x8d68a244, Offset: 0x31f8
// Size: 0x48
function event_handler[event_eb7e11e4] function_2f677e9d(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_2f64d35)) {
        [[ level.var_2f64d35 ]](eventstruct.weapon);
    }
}

// Namespace callback/event_3dd1ca18
// Params 1, eflags: 0x40
// Checksum 0x555327f1, Offset: 0x3248
// Size: 0x48
function event_handler[event_3dd1ca18] function_cf68d893(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_523faa05)) {
        [[ level.var_523faa05 ]](eventstruct.weapon);
    }
}

// Namespace callback/event_bf57d5bb
// Params 1, eflags: 0x40
// Checksum 0x418aa769, Offset: 0x3298
// Size: 0x48
function event_handler[event_bf57d5bb] function_d7eb3672(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_a28be0a5)) {
        [[ level.var_a28be0a5 ]](eventstruct.weapon);
    }
}

// Namespace callback/event_e9b4bb47
// Params 1, eflags: 0x40
// Checksum 0x588caa8, Offset: 0x32e8
// Size: 0x48
function event_handler[event_e9b4bb47] function_7dba9a1(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_bd0b5fc1)) {
        [[ level.var_bd0b5fc1 ]](eventstruct.weapon);
    }
}

// Namespace callback/player_boast
// Params 1, eflags: 0x40
// Checksum 0x4dd7c975, Offset: 0x3338
// Size: 0x74
function event_handler[player_boast] function_3b159f77(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_4268159)) {
        [[ level.var_4268159 ]](eventstruct.gestureindex, eventstruct.animlength);
    }
    callback(#"on_boast", eventstruct);
}

// Namespace callback/event_8451509a
// Params 1, eflags: 0x40
// Checksum 0x397757f4, Offset: 0x33b8
// Size: 0x44
function event_handler[event_8451509a] function_e35aeddd(*eventstruct) {
    self endon(#"disconnect");
    callback(#"hash_4a9c56bba76da754");
}

// Namespace callback/sprint_begin
// Params 1, eflags: 0x40
// Checksum 0x77189053, Offset: 0x3408
// Size: 0x44
function event_handler[sprint_begin] function_336afb8e(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_7bd720f6)) {
        [[ level.var_7bd720f6 ]](eventstruct);
    }
}

// Namespace callback/sprint_end
// Params 1, eflags: 0x40
// Checksum 0x30b83fcf, Offset: 0x3458
// Size: 0x44
function event_handler[sprint_end] function_6806b4f(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_42b43ce2)) {
        [[ level.var_42b43ce2 ]](eventstruct);
    }
}

// Namespace callback/event_9e865a6e
// Params 1, eflags: 0x40
// Checksum 0x8441729e, Offset: 0x34a8
// Size: 0x44
function event_handler[event_9e865a6e] function_1855d09f(*eventstruct) {
    self endon(#"disconnect");
    callback(#"on_rappel");
}

// Namespace callback/rappel_end
// Params 1, eflags: 0x40
// Checksum 0x554f2b6f, Offset: 0x34f8
// Size: 0x44
function event_handler[rappel_end] function_e51b8b9d(*eventstruct) {
    self endon(#"disconnect");
    callback(#"hash_52c6deac4a362083");
}

// Namespace callback/slide_begin
// Params 1, eflags: 0x40
// Checksum 0x1d3f7c3, Offset: 0x3548
// Size: 0x44
function event_handler[slide_begin] function_2e3100e0(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_e74639aa)) {
        [[ level.var_e74639aa ]](eventstruct);
    }
}

// Namespace callback/slide_end
// Params 1, eflags: 0x40
// Checksum 0xcd9dc568, Offset: 0x3598
// Size: 0x44
function event_handler[slide_end] function_e1b7e658(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_7f80c5a6)) {
        [[ level.var_7f80c5a6 ]](eventstruct);
    }
}

// Namespace callback/jump_begin
// Params 1, eflags: 0x40
// Checksum 0x1923cc63, Offset: 0x35e8
// Size: 0x44
function event_handler[jump_begin] function_b0353bef(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_6c3038dc)) {
        [[ level.var_6c3038dc ]](eventstruct);
    }
}

// Namespace callback/jump_end
// Params 1, eflags: 0x40
// Checksum 0x886dc726, Offset: 0x3638
// Size: 0x44
function event_handler[jump_end] function_40b29944(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_4c9e52d1)) {
        [[ level.var_4c9e52d1 ]](eventstruct);
    }
}

// Namespace callback/player_melee
// Params 1, eflags: 0x40
// Checksum 0x7fcd1141, Offset: 0x3688
// Size: 0x70
function event_handler[player_melee] codecallback_playermelee(eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayermelee ]](eventstruct.attacker, eventstruct.amount, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.bone_index, eventstruct.is_shieldhit, eventstruct.is_frombehind);
}

// Namespace callback/actor_spawned
// Params 1, eflags: 0x40
// Checksum 0x4113d733, Offset: 0x3700
// Size: 0x28
function event_handler[actor_spawned] codecallback_actorspawned(eventstruct) {
    self [[ level.callbackactorspawned ]](eventstruct.entity);
}

// Namespace callback/event_7d801d3e
// Params 1, eflags: 0x40
// Checksum 0x9020c156, Offset: 0x3730
// Size: 0x38
function event_handler[event_7d801d3e] function_2f02dc73(eventstruct) {
    if (isdefined(level.var_a79419ed)) {
        self [[ level.var_a79419ed ]](eventstruct.entity);
    }
}

// Namespace callback/event_52071346
// Params 1, eflags: 0x40
// Checksum 0xfa810f43, Offset: 0x3770
// Size: 0x2c
function event_handler[event_52071346] function_40ef094(*eventstruct) {
    self callback(#"hash_7d2e38b28c894e5a");
}

// Namespace callback/actor_damage
// Params 1, eflags: 0x40
// Checksum 0xdc124cdf, Offset: 0x37a8
// Size: 0x94
function event_handler[actor_damage] codecallback_actordamage(eventstruct) {
    [[ level.callbackactordamage ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.model_index, eventstruct.surface_type, eventstruct.normal);
}

// Namespace callback/actor_killed
// Params 1, eflags: 0x40
// Checksum 0x7673e042, Offset: 0x3848
// Size: 0x5c
function event_handler[actor_killed] codecallback_actorkilled(eventstruct) {
    [[ level.callbackactorkilled ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset);
}

// Namespace callback/actor_cloned
// Params 1, eflags: 0x40
// Checksum 0xa913e270, Offset: 0x38b0
// Size: 0x24
function event_handler[actor_cloned] codecallback_actorcloned(eventstruct) {
    [[ level.callbackactorcloned ]](eventstruct.clone);
}

// Namespace callback/event_bc72e1ee
// Params 1, eflags: 0x40
// Checksum 0x66093231, Offset: 0x38e0
// Size: 0x2c
function event_handler[event_bc72e1ee] function_df3c93ef(eventstruct) {
    self callback(#"hash_3d6ccbbe0e628b2d", eventstruct);
}

// Namespace callback/event_1524de24
// Params 1, eflags: 0x40
// Checksum 0x8f6ffbd8, Offset: 0x3918
// Size: 0x9c
function event_handler[event_1524de24] function_5b0a9275(eventstruct) {
    [[ level.var_6788bf11 ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.model_index, eventstruct.part_name, eventstruct.surface_type, eventstruct.normal);
}

// Namespace callback/vehicle_spawned
// Params 1, eflags: 0x40
// Checksum 0xd7c1db6c, Offset: 0x39c0
// Size: 0x34
function event_handler[vehicle_spawned] codecallback_vehiclespawned(eventstruct) {
    if (isdefined(level.callbackvehiclespawned)) {
        [[ level.callbackvehiclespawned ]](eventstruct.spawner);
    }
}

// Namespace callback/vehicle_killed
// Params 1, eflags: 0x40
// Checksum 0xfdd1fc1d, Offset: 0x3a00
// Size: 0x5c
function event_handler[vehicle_killed] codecallback_vehiclekilled(eventstruct) {
    [[ level.callbackvehiclekilled ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset);
}

// Namespace callback/vehicle_damage
// Params 1, eflags: 0x40
// Checksum 0x26c9a6f6, Offset: 0x3a68
// Size: 0x94
function event_handler[vehicle_damage] codecallback_vehicledamage(eventstruct) {
    [[ level.callbackvehicledamage ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.damage_from_underneath, eventstruct.model_index, eventstruct.part_name, eventstruct.normal);
}

// Namespace callback/vehicle_radiusdamage
// Params 1, eflags: 0x40
// Checksum 0x21e11af3, Offset: 0x3b08
// Size: 0x94
function event_handler[vehicle_radiusdamage] codecallback_vehicleradiusdamage(eventstruct) {
    if (isdefined(level.callbackvehicleradiusdamage)) {
        [[ level.callbackvehicleradiusdamage ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.inner_damage, eventstruct.outer_damage, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.outer_radius, eventstruct.cone_angle, eventstruct.cone_direction, eventstruct.time_offset);
    }
}

// Namespace callback/ping
// Params 1, eflags: 0x40
// Checksum 0xc6118b8e, Offset: 0x3ba8
// Size: 0x2c
function event_handler[ping] function_87cf247e(eventstruct) {
    self callback(#"on_ping", eventstruct);
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x0
// Checksum 0x1ad85cf6, Offset: 0x3be0
// Size: 0xae
function finishcustomtraversallistener() {
    self endon(#"death");
    self waittillmatch({#notetrack:"end"}, #"custom_traversal_anim_finished");
    self finishtraversal();
    self unlink();
    self.usegoalanimweight = 0;
    self.blockingpain = 0;
    self.customtraverseendnode = undefined;
    self.customtraversestartnode = undefined;
    self notify(#"custom_traversal_cleanup");
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x0
// Checksum 0x551764e1, Offset: 0x3c98
// Size: 0x74
function killedcustomtraversallistener() {
    self endon(#"custom_traversal_cleanup");
    self waittill(#"death");
    if (isdefined(self)) {
        self finishtraversal();
        self stopanimscripted();
        self unlink();
    }
}

// Namespace callback/entity_playcustomtraversal
// Params 1, eflags: 0x40
// Checksum 0xd5288651, Offset: 0x3d18
// Size: 0x184
function event_handler[entity_playcustomtraversal] codecallback_playcustomtraversal(eventstruct) {
    entity = eventstruct.entity;
    endparent = eventstruct.end_entity;
    entity.blockingpain = 1;
    entity.usegoalanimweight = 1;
    entity.customtraverseendnode = entity.traverseendnode;
    entity.customtraversestartnode = entity.traversestartnode;
    entity animmode("noclip", 0);
    entity orientmode("face angle", eventstruct.direction[1]);
    if (isdefined(endparent)) {
        offset = entity.origin - endparent.origin;
        entity linkto(endparent, "", offset);
    }
    entity animscripted("custom_traversal_anim_finished", eventstruct.location, eventstruct.direction, eventstruct.animation, eventstruct.anim_mode, undefined, eventstruct.playback_speed, eventstruct.goal_time, eventstruct.lerp_time);
    entity thread finishcustomtraversallistener();
    entity thread killedcustomtraversallistener();
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xf5e1cfe2, Offset: 0x3ea8
// Size: 0x9c
function codecallback_faceeventnotify(notify_msg, ent) {
    if (isdefined(ent) && isdefined(ent.do_face_anims) && ent.do_face_anims) {
        if (isdefined(level.face_event_handler) && isdefined(level.face_event_handler.events[notify_msg])) {
            ent sendfaceevent(level.face_event_handler.events[notify_msg]);
        }
    }
}

// Namespace callback/ui_menuresponse
// Params 1, eflags: 0x40
// Checksum 0x7e77d06c, Offset: 0x3f50
// Size: 0xa0
function event_handler[ui_menuresponse] codecallback_menuresponse(eventstruct) {
    if (!isdefined(level.menuresponsequeue)) {
        level.menuresponsequeue = [];
        level thread menu_response_queue_pump();
    }
    index = level.menuresponsequeue.size;
    level.menuresponsequeue[index] = {#ent:self, #eventstruct:eventstruct};
    level notify(#"menuresponse_queue");
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x0
// Checksum 0x5ff9362c, Offset: 0x3ff8
// Size: 0xf8
function menu_response_queue_pump() {
    while (true) {
        level waittill(#"menuresponse_queue");
        do {
            if (isdefined(level.menuresponsequeue[0].ent)) {
                level.menuresponsequeue[0].ent notify(#"menuresponse", level.menuresponsequeue[0].eventstruct);
                level.menuresponsequeue[0].ent callback(#"menu_response", level.menuresponsequeue[0].eventstruct);
            }
            arrayremoveindex(level.menuresponsequeue, 0, 0);
            waitframe(1);
        } while (level.menuresponsequeue.size > 0);
    }
}

// Namespace callback/notetrack_callserverscript
// Params 1, eflags: 0x40
// Checksum 0xb01e6dde, Offset: 0x40f8
// Size: 0xc2
function event_handler[notetrack_callserverscript] codecallback_callserverscript(eventstruct) {
    if (!isdefined(level._animnotifyfuncs)) {
        return;
    }
    if (isdefined(level._animnotifyfuncs[eventstruct.label])) {
        if (isdefined(eventstruct.param3) && eventstruct.param3 != "") {
            eventstruct.entity [[ level._animnotifyfuncs[eventstruct.label] ]](eventstruct.param, eventstruct.param3);
            return;
        }
        eventstruct.entity [[ level._animnotifyfuncs[eventstruct.label] ]](eventstruct.param);
    }
}

// Namespace callback/notetrack_callserverscriptonlevel
// Params 1, eflags: 0x40
// Checksum 0xfe1f1991, Offset: 0x41c8
// Size: 0xba
function event_handler[notetrack_callserverscriptonlevel] codecallback_callserverscriptonlevel(eventstruct) {
    if (!isdefined(level._animnotifyfuncs)) {
        return;
    }
    if (isdefined(level._animnotifyfuncs[eventstruct.label])) {
        if (isdefined(eventstruct.param3) && eventstruct.param3 != "") {
            level [[ level._animnotifyfuncs[eventstruct.label] ]](eventstruct.param, eventstruct.param3);
            return;
        }
        level [[ level._animnotifyfuncs[eventstruct.label] ]](eventstruct.param);
    }
}

// Namespace callback/event_69572c01
// Params 1, eflags: 0x40
// Checksum 0x85126bfc, Offset: 0x4290
// Size: 0x104
function event_handler[event_69572c01] function_2073f6dc(eventstruct) {
    origin = self.origin;
    magnitude = float(eventstruct.magnitude);
    innerradius = float(eventstruct.innerradius);
    outerradius = int(eventstruct.outerradius);
    innerdamage = isdefined(self.var_f501d778) ? self.var_f501d778 : 50;
    outerdamage = isdefined(self.var_e14c1b5c) ? self.var_e14c1b5c : 25;
    physicsexplosionsphere(origin, outerradius, innerradius, magnitude, outerdamage, innerdamage);
}

// Namespace callback/event_195cc461
// Params 1, eflags: 0x40
// Checksum 0xfade709b, Offset: 0x43a0
// Size: 0x24c
function event_handler[event_195cc461] function_52d32e5b(eventstruct) {
    actor = self;
    player = getplayers()[0];
    if (!isactor(actor)) {
        return;
    }
    if (is_true(eventstruct.enable) && isdefined(player)) {
        switch (eventstruct.type) {
        case #"hash_d85822f3fe3ff26":
            actor lookatentity(player, 0, 0, 0, eventstruct.blend, eventstruct.weight);
            break;
        case #"head_torso":
            actor lookatentity(player, 0, 0, 1, eventstruct.blend, eventstruct.weight);
            break;
        case #"head":
            actor lookatentity(player, 1, 0, 1, eventstruct.blend, eventstruct.weight);
            break;
        case #"eyes":
            actor lookatentity(player, 1, 1, 0, eventstruct.blend, eventstruct.weight);
            break;
        case #"aim":
            actor aimatentityik(player, eventstruct.blend, eventstruct.weight);
            break;
        case #"head_eyes":
        default:
            actor lookatentity(player, 1, 0, 0, eventstruct.blend, eventstruct.weight);
            break;
        }
        return;
    }
    actor lookatentity();
}

// Namespace callback/event_5d98e413
// Params 1, eflags: 0x40
// Checksum 0xe0b83fff, Offset: 0x45f8
// Size: 0x94
function event_handler[event_5d98e413] function_81d4b0fe(eventstruct) {
    player = self;
    if (!isplayer(player)) {
        player = getplayers()[0];
    }
    if (isdefined(player)) {
        player setviewclamp(eventstruct.minyaw, eventstruct.maxyaw, eventstruct.minpitch, eventstruct.maxpitch, 0, 0, eventstruct.blend);
    }
}

// Namespace callback/sidemission_launch
// Params 1, eflags: 0x40
// Checksum 0xdc2dcc5d, Offset: 0x4698
// Size: 0x94
function event_handler[sidemission_launch] codecallback_launchsidemission(eventstruct) {
    switchmap_preload(eventstruct.name, eventstruct.game_type);
    luinotifyevent(#"open_side_mission_countdown", 1, eventstruct.list_index);
    wait 10;
    luinotifyevent(#"close_side_mission_countdown");
    switchmap_switch();
}

// Namespace callback/ui_fadeblackscreen
// Params 1, eflags: 0x40
// Checksum 0x15fd7df1, Offset: 0x4738
// Size: 0x74
function event_handler[ui_fadeblackscreen] codecallback_fadeblackscreen(eventstruct) {
    if (isplayer(self) && !isbot(self)) {
        self thread hud::fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend, eventstruct.blend);
    }
}

// Namespace callback/event_40f83b44
// Params 1, eflags: 0x40
// Checksum 0xe7393742, Offset: 0x47b8
// Size: 0x74
function event_handler[event_40f83b44] function_4b5ab05f(eventstruct) {
    if (isplayer(self) && !isbot(self)) {
        self thread hud::fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend_out, eventstruct.blend_in);
    }
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x0
// Checksum 0x621d3962, Offset: 0x4838
// Size: 0x224
function abort_level() {
    /#
        println("<dev string:x1d1>");
        println("<dev string:x231>");
        println("<dev string:x1d1>");
    #/
    level.callbackstartgametype = &callback_void;
    level.callbackplayerconnect = &callback_void;
    level.callbackplayerdisconnect = &callback_void;
    level.callbackplayerdamage = &callback_void;
    level.callbackplayerkilled = &callback_void;
    level.var_3a9881cb = &callback_void;
    level.callbackplayerlaststand = &callback_void;
    level.var_4268159 = &callback_void;
    level.var_69959686 = &callback_void;
    level.callbackplayermelee = &callback_void;
    level.callbackactordamage = &callback_void;
    level.callbackactorkilled = &callback_void;
    level.var_6788bf11 = &callback_void;
    level.callbackvehicledamage = &callback_void;
    level.callbackvehiclekilled = &callback_void;
    level.callbackactorspawned = &callback_void;
    if (isdefined(level._gametype_default)) {
        setdvar(#"g_gametype", level._gametype_default);
    }
    exitlevel(0);
}

// Namespace callback/glass_smash
// Params 1, eflags: 0x40
// Checksum 0x3690fede, Offset: 0x4a68
// Size: 0x58
function event_handler[glass_smash] codecallback_glasssmash(eventstruct) {
    level notify(#"glass_smash", {#position:eventstruct.position, #direction:eventstruct.direction});
}

// Namespace callback/freefall
// Params 1, eflags: 0x40
// Checksum 0x67384da9, Offset: 0x4ac8
// Size: 0x2c
function event_handler[freefall] function_5019e563(eventstruct) {
    self callback(#"freefall", eventstruct);
}

// Namespace callback/parachute
// Params 1, eflags: 0x40
// Checksum 0x5ba9361d, Offset: 0x4b00
// Size: 0x2c
function event_handler[parachute] function_87b05fa3(eventstruct) {
    self callback(#"parachute", eventstruct);
}

// Namespace callback/skydive_touch
// Params 1, eflags: 0x40
// Checksum 0x73423bea, Offset: 0x4b38
// Size: 0x2c
function event_handler[skydive_touch] function_5bc68fd9(eventstruct) {
    self callback(#"skydive_touch", eventstruct);
}

// Namespace callback/skydive_end
// Params 1, eflags: 0x40
// Checksum 0xe4da7369, Offset: 0x4b70
// Size: 0x2c
function event_handler[skydive_end] function_250a9740(eventstruct) {
    self callback(#"skydive_end", eventstruct);
}

// Namespace callback/swimming_begin
// Params 1, eflags: 0x40
// Checksum 0xdf71e150, Offset: 0x4ba8
// Size: 0x44
function event_handler[swimming_begin] function_e337eb32(*eventstruct) {
    self callback(#"swimming", {#swimming:1});
}

// Namespace callback/swimming_end
// Params 1, eflags: 0x40
// Checksum 0x8921364f, Offset: 0x4bf8
// Size: 0x44
function event_handler[swimming_end] function_e142d2b2(*eventstruct) {
    self callback(#"swimming", {#swimming:0});
}

// Namespace callback/underwater
// Params 1, eflags: 0x40
// Checksum 0xd9472330, Offset: 0x4c48
// Size: 0x2c
function event_handler[underwater] codecallback_underwater(eventstruct) {
    self callback(#"underwater", eventstruct);
}

// Namespace callback/event_d6f9e6ad
// Params 1, eflags: 0x40
// Checksum 0x1bc532d1, Offset: 0x4c80
// Size: 0x2c
function event_handler[event_d6f9e6ad] function_8877d89(eventstruct) {
    self callback(#"hash_42aa89b2a0951308", eventstruct);
}

/#

    // Namespace callback/debug_movement
    // Params 1, eflags: 0x40
    // Checksum 0xff575617, Offset: 0x4cb8
    // Size: 0x34
    function event_handler[debug_movement] function_930ce3c3(eventstruct) {
        self callback(#"debug_movement", eventstruct);
    }

#/

// Namespace callback/event_6ba27c50
// Params 1, eflags: 0x40
// Checksum 0x4452dc31, Offset: 0x4cf8
// Size: 0x2c
function event_handler[event_6ba27c50] function_d736b8a9(eventstruct) {
    self callback(#"hash_3b6ebf3a7ab5c795", eventstruct);
}

// Namespace callback/event_31e1c5e9
// Params 1, eflags: 0x40
// Checksum 0x282134d1, Offset: 0x4d30
// Size: 0x5c
function event_handler[event_31e1c5e9] function_7d45bff(*eventstruct) {
    self endon(#"death");
    level flag::wait_till("system_postinit_complete");
    self callback(#"hash_1e4a4ca774f4ce22");
}

// Namespace callback/trigger
// Params 2, eflags: 0x40
// Checksum 0x374f7aee, Offset: 0x4d98
// Size: 0xcc
function event_handler[trigger] codecallback_trigger(eventstruct, look_trigger = 0) {
    self endon(#"death");
    if (look_trigger || !self trigger::is_look_trigger()) {
        self util::script_delay();
        self callback(#"on_trigger", eventstruct);
        self callback(#"on_trigger_once", eventstruct);
        self remove_on_trigger_once("all");
    }
}

// Namespace callback/entity_deleted
// Params 1, eflags: 0x40
// Checksum 0x56ee7aea, Offset: 0x4e70
// Size: 0x2c
function event_handler[entity_deleted] codecallback_entitydeleted(*eventstruct) {
    self callback(#"on_entity_deleted");
}

// Namespace callback/bot_enteruseredge
// Params 1, eflags: 0x40
// Checksum 0x91c0e4be, Offset: 0x4ea8
// Size: 0x2c
function event_handler[bot_enteruseredge] codecallback_botentereduseredge(eventstruct) {
    self callback(#"hash_767bb029d2dcda7c", eventstruct);
}

// Namespace callback/event_e054b61b
// Params 1, eflags: 0x40
// Checksum 0x41c996ab, Offset: 0x4ee0
// Size: 0x2c
function event_handler[event_e054b61b] function_d658381b(*eventstruct) {
    self callback(#"hash_6efb8cec1ca372dc");
}

// Namespace callback/event_46837d44
// Params 1, eflags: 0x40
// Checksum 0x3991c93d, Offset: 0x4f18
// Size: 0x2c
function event_handler[event_46837d44] function_2ff20679(*eventstruct) {
    self callback(#"hash_6280ac8ed281ce3c");
}

// Namespace callback/event_596b7bdc
// Params 1, eflags: 0x40
// Checksum 0x5bb167b7, Offset: 0x4f50
// Size: 0x88
function event_handler[event_596b7bdc] function_f5026566(eventstruct) {
    if (!isdefined(level.var_abb3fd2)) {
        return;
    }
    /#
    #/
    eventdata = {};
    eventdata.tableindex = eventstruct.tableindex;
    eventdata.event_info = eventstruct.event_info;
    self [[ level.var_abb3fd2 ]](eventstruct.event_name, eventstruct.time, eventstruct.client, eventstruct.priority, eventdata);
}

// Namespace callback/player_decoration
// Params 1, eflags: 0x40
// Checksum 0xf0683e1, Offset: 0x4fe0
// Size: 0x70
function event_handler[player_decoration] codecallback_decoration(*eventstruct) {
    a_decorations = self getdecorations(1);
    if (!isdefined(a_decorations)) {
        return;
    }
    if (a_decorations.size == 12) {
    }
    level notify(#"decoration_awarded");
    [[ level.callbackdecorationawarded ]]();
}

// Namespace callback/event_4620dccd
// Params 1, eflags: 0x40
// Checksum 0x3a1deb14, Offset: 0x5058
// Size: 0x30
function event_handler[event_4620dccd] function_a4a77d57(eventstruct) {
    if (isdefined(level.var_b24258)) {
        self [[ level.var_b24258 ]](eventstruct);
    }
}

// Namespace callback/event_4e560379
// Params 1, eflags: 0x40
// Checksum 0xf47c200b, Offset: 0x5090
// Size: 0x30
function event_handler[event_4e560379] function_d5edcd9a(eventstruct) {
    if (isdefined(level.var_ee39a80e)) {
        self [[ level.var_ee39a80e ]](eventstruct);
    }
}

// Namespace callback/event_ba6fea54
// Params 1, eflags: 0x40
// Checksum 0xdea7c74a, Offset: 0x50c8
// Size: 0x4c
function event_handler[event_ba6fea54] function_f4449e63(eventstruct) {
    if (isdefined(level.var_17c7288a)) {
        [[ level.var_17c7288a ]](eventstruct.player, eventstruct.eventtype, eventstruct.eventdata, eventstruct.var_c5a66313);
    }
}

// Namespace callback/detonate
// Params 1, eflags: 0x40
// Checksum 0xe5709b14, Offset: 0x5120
// Size: 0x2c
function event_handler[detonate] codecallback_detonate(eventstruct) {
    self callback(#"detonate", eventstruct);
}

// Namespace callback/doubletap_detonate
// Params 1, eflags: 0x40
// Checksum 0xd7e4c8f0, Offset: 0x5158
// Size: 0x2c
function event_handler[doubletap_detonate] function_92aba4c4(eventstruct) {
    self callback(#"doubletap_detonate", eventstruct);
}

// Namespace callback/death
// Params 1, eflags: 0x40
// Checksum 0x2a5b4805, Offset: 0x5190
// Size: 0x44
function event_handler[death] codecallback_death(eventstruct) {
    self notify(#"death", eventstruct);
    self callback(#"death", eventstruct);
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x51e0
// Size: 0x4
function callback_void() {
    
}

