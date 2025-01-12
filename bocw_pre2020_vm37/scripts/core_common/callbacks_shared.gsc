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
// Params 2, eflags: 0x1 linked
// Checksum 0x69fbf0f8, Offset: 0x108
// Size: 0x5c
function callback(event, params) {
    mpl_heatwave_fx(level, event, params);
    if (self != level) {
        mpl_heatwave_fx(self, event, params);
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xe92aed86, Offset: 0x170
// Size: 0xb8
function function_bea20a96(event, params) {
    ais = getaiarray();
    foreach (ai in ais) {
        ai mpl_heatwave_fx(ai, event, params);
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x51fda650, Offset: 0x230
// Size: 0xd8
function function_daed27e8(event, params) {
    players = getplayers();
    foreach (player in players) {
        player mpl_heatwave_fx(level, event, params);
        player mpl_heatwave_fx(player, event, params);
    }
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x5 linked
// Checksum 0xdb60cf4f, Offset: 0x310
// Size: 0x244
function private mpl_heatwave_fx(ent, event, params) {
    if (isdefined(ent._callbacks) && isdefined(ent) && isdefined(ent._callbacks[event])) {
        for (i = 0; i < ent._callbacks[event].size; i++) {
            if (!isarray(ent._callbacks[event][i])) {
                continue;
            }
            callback = ent._callbacks[event][i][0];
            assert(isfunctionptr(callback), "<dev string:x38>" + "<dev string:x53>");
            if (!isfunctionptr(callback)) {
                return;
            }
            obj = ent._callbacks[event][i][1];
            var_47e0b77b = isdefined(ent._callbacks[event][i][2]) ? ent._callbacks[event][i][2] : [];
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
        arrayremovevalue(ent._callbacks[event], 0, 0);
    }
}

// Namespace callback/callbacks_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x906485bc, Offset: 0x560
// Size: 0x44
function add_callback(event, func, obj, a_params) {
    function_2b653c00(level, event, func, obj, a_params);
}

// Namespace callback/callbacks_shared
// Params 4, eflags: 0x1 linked
// Checksum 0xc9b5f69d, Offset: 0x5b0
// Size: 0x44
function function_d8abfc3d(event, func, obj, a_params) {
    function_2b653c00(self, event, func, obj, a_params);
}

// Namespace callback/callbacks_shared
// Params 5, eflags: 0x5 linked
// Checksum 0x646fe6f5, Offset: 0x600
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
// Params 2, eflags: 0x5 linked
// Checksum 0x4c35f1b7, Offset: 0x810
// Size: 0x3c
function private function_862146b3(event, func) {
    return string(event) + string(func);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xbb75e5d5, Offset: 0x858
// Size: 0x84
function remove_callback_on_death(event, func) {
    self notify(function_862146b3(event, func));
    self endon(function_862146b3(event, func));
    self waittill(#"death", #"remove_callbacks");
    remove_callback(event, func, self);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x208884, Offset: 0x8e8
// Size: 0x3c
function remove_callback(event, func, obj) {
    function_3f5f097e(level, event, func, obj);
}

// Namespace callback/callbacks_shared
// Params 4, eflags: 0x1 linked
// Checksum 0xa614257f, Offset: 0x930
// Size: 0x44
function function_52ac9652(event, func, obj, instant) {
    function_3f5f097e(self, event, func, obj, instant);
}

// Namespace callback/callbacks_shared
// Params 5, eflags: 0x5 linked
// Checksum 0x229e990, Offset: 0x980
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
// Params 2, eflags: 0x1 linked
// Checksum 0x8cc7cc5c, Offset: 0xb50
// Size: 0x3c
function on_finalize_initialization(func, obj) {
    add_callback(#"on_finalize_initialization", func, obj);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x21 linked variadic
// Checksum 0xafc7bda, Offset: 0xb98
// Size: 0x44
function on_connect(func, obj, ...) {
    add_callback(#"on_player_connect", func, obj, vararg);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x9fdc8680, Offset: 0xbe8
// Size: 0x3c
function remove_on_connect(func, obj) {
    remove_callback(#"on_player_connect", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xb4a5d4c3, Offset: 0xc30
// Size: 0x3c
function on_connecting(func, obj) {
    add_callback(#"on_player_connecting", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7e430e40, Offset: 0xc78
// Size: 0x3c
function remove_on_connecting(func, obj) {
    remove_callback(#"on_player_connecting", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x3c1d4266, Offset: 0xcc0
// Size: 0x3c
function on_disconnect(func, obj) {
    add_callback(#"on_player_disconnect", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xecffd2e8, Offset: 0xd08
// Size: 0x3c
function remove_on_disconnect(func, obj) {
    remove_callback(#"on_player_disconnect", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xf1cd9cb0, Offset: 0xd50
// Size: 0x3c
function on_spawned(func, obj) {
    add_callback(#"on_player_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xf3abd62f, Offset: 0xd98
// Size: 0x3c
function remove_on_spawned(func, obj) {
    remove_callback(#"on_player_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xf1b1dca8, Offset: 0xde0
// Size: 0x3c
function remove_on_revived(func, obj) {
    remove_callback(#"on_player_revived", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x5367c843, Offset: 0xe28
// Size: 0x3c
function on_deleted(func, obj) {
    add_callback(#"on_entity_deleted", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xe510e324, Offset: 0xe70
// Size: 0x3c
function remove_on_deleted(func, obj) {
    remove_callback(#"on_entity_deleted", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x17ae466a, Offset: 0xeb8
// Size: 0x3c
function on_loadout(func, obj) {
    add_callback(#"on_loadout", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xfa0c2d4, Offset: 0xf00
// Size: 0x3c
function remove_on_loadout(func, obj) {
    remove_callback(#"on_loadout", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x51d2dc93, Offset: 0xf48
// Size: 0x3c
function on_player_damage(func, obj) {
    add_callback(#"on_player_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xac1a92d5, Offset: 0xf90
// Size: 0x3c
function remove_on_player_damage(func, obj) {
    remove_callback(#"on_player_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xf8643762, Offset: 0xfd8
// Size: 0x3c
function on_start_gametype(func, obj) {
    add_callback(#"on_start_gametype", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xb2c9e8fa, Offset: 0x1020
// Size: 0x3c
function on_end_game(func, obj) {
    add_callback(#"on_end_game", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xfa8cd500, Offset: 0x1068
// Size: 0x3c
function function_14dae612(func, obj) {
    add_callback(#"hash_1b5be9017cd4b5fa", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x4d087635, Offset: 0x10b0
// Size: 0x3c
function on_game_playing(func, obj) {
    add_callback(#"on_game_playing", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x5a157f16, Offset: 0x10f8
// Size: 0x3c
function function_359493ba(func, obj) {
    add_callback(#"hash_7177603f5415549b", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x4d2af4fc, Offset: 0x1140
// Size: 0x3c
function on_joined_team(func, obj) {
    add_callback(#"joined_team", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x4445b20e, Offset: 0x1188
// Size: 0x3c
function on_joined_spectate(func, obj) {
    add_callback(#"on_joined_spectate", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xe430352d, Offset: 0x11d0
// Size: 0x3c
function on_player_killed(func, obj) {
    add_callback(#"on_player_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xe4c510e5, Offset: 0x1218
// Size: 0x3c
function on_player_corpse(func, obj) {
    add_callback(#"on_player_corpse", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb6dd44b0, Offset: 0x1260
// Size: 0x3c
function remove_on_player_killed(func, obj) {
    remove_callback(#"on_player_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa587c377, Offset: 0x12a8
// Size: 0x3c
function function_80270643(func, obj) {
    add_callback(#"on_team_eliminated", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xe89cce77, Offset: 0x12f0
// Size: 0x3c
function function_c53a8ab8(func, obj) {
    remove_callback(#"on_team_eliminated", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x104313b0, Offset: 0x1338
// Size: 0x3c
function on_ai_killed(func, obj) {
    add_callback(#"on_ai_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x27b5f0a9, Offset: 0x1380
// Size: 0x3c
function remove_on_ai_killed(func, obj) {
    remove_callback(#"on_ai_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x33035f58, Offset: 0x13c8
// Size: 0x3c
function on_actor_killed(func, obj) {
    add_callback(#"on_actor_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x2f1432d4, Offset: 0x1410
// Size: 0x3c
function remove_on_actor_killed(func, obj) {
    remove_callback(#"on_actor_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xd58c6e3a, Offset: 0x1458
// Size: 0x3c
function function_30c3f95d(func, obj) {
    function_d8abfc3d(#"hash_3d6ccbbe0e628b2d", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xf828014d, Offset: 0x14a0
// Size: 0x3c
function function_95ba5345(func, obj) {
    function_52ac9652(#"hash_3d6ccbbe0e628b2d", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x47de8106, Offset: 0x14e8
// Size: 0x3c
function on_vehicle_spawned(func, obj) {
    add_callback(#"on_vehicle_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x8ea69bb, Offset: 0x1530
// Size: 0x3c
function remove_on_vehicle_spawned(func, obj) {
    remove_callback(#"on_vehicle_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x6e80d5f8, Offset: 0x1578
// Size: 0x3c
function on_vehicle_killed(func, obj) {
    add_callback(#"on_vehicle_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x68c6b4ce, Offset: 0x15c0
// Size: 0x3c
function on_vehicle_collision(func, obj) {
    function_d8abfc3d(#"veh_collision", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xf5b54b1a, Offset: 0x1608
// Size: 0x3c
function remove_on_vehicle_killed(func, obj) {
    remove_callback(#"on_vehicle_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x279bae1a, Offset: 0x1650
// Size: 0x3c
function on_ai_damage(func, obj) {
    add_callback(#"on_ai_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xaa0d2601, Offset: 0x1698
// Size: 0x3c
function remove_on_ai_damage(func, obj) {
    remove_callback(#"on_ai_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x966297af, Offset: 0x16e0
// Size: 0x3c
function on_ai_spawned(func, obj) {
    add_callback(#"on_ai_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x3b1532c4, Offset: 0x1728
// Size: 0x3c
function remove_on_ai_spawned(func, obj) {
    remove_callback(#"on_ai_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7def7f79, Offset: 0x1770
// Size: 0x3c
function function_f642faf2(func, obj) {
    add_callback(#"hash_7d2e38b28c894e5a", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x1f3389a9, Offset: 0x17b8
// Size: 0x3c
function function_c1017156(func, obj) {
    remove_callback(#"hash_7d2e38b28c894e5a", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x4409bdf0, Offset: 0x1800
// Size: 0x3c
function on_actor_damage(func, obj) {
    add_callback(#"on_actor_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xad687c42, Offset: 0x1848
// Size: 0x3c
function remove_on_actor_damage(func, obj) {
    remove_callback(#"on_actor_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x719cdb8b, Offset: 0x1890
// Size: 0x3c
function function_9d78f548(func, obj) {
    add_callback(#"hash_2e68909d4e4ed889", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x19732e20, Offset: 0x18d8
// Size: 0x3c
function function_f125b93a(func, obj) {
    remove_callback(#"hash_2e68909d4e4ed889", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x1724d410, Offset: 0x1920
// Size: 0x3c
function on_vehicle_damage(func, obj) {
    add_callback(#"on_vehicle_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xd83ff5b3, Offset: 0x1968
// Size: 0x3c
function remove_on_vehicle_damage(func, obj) {
    remove_callback(#"on_vehicle_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x98dba4d8, Offset: 0x19b0
// Size: 0x3c
function on_downed(func, obj) {
    add_callback(#"on_player_downed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa7040899, Offset: 0x19f8
// Size: 0x3c
function remove_on_downed(func, obj) {
    remove_callback(#"on_player_downed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x32bb3f7d, Offset: 0x1a40
// Size: 0x3c
function on_laststand(func, obj) {
    add_callback(#"on_player_laststand", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x1ae3b78d, Offset: 0x1a88
// Size: 0x3c
function remove_on_laststand(func, obj) {
    remove_callback(#"on_player_laststand", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x14f6389d, Offset: 0x1ad0
// Size: 0x3c
function on_bleedout(func, obj) {
    add_callback(#"on_player_bleedout", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x90fc85a7, Offset: 0x1b18
// Size: 0x3c
function on_revived(func, obj) {
    add_callback(#"on_player_revived", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xd9ee986e, Offset: 0x1b60
// Size: 0x3c
function on_mission_failed(func, obj) {
    add_callback(#"on_mission_failed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xb884d9e2, Offset: 0x1ba8
// Size: 0x3c
function on_challenge_complete(func, obj) {
    add_callback(#"on_challenge_complete", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x4a1b4b8a, Offset: 0x1bf0
// Size: 0x3c
function on_weapon_change(func, obj) {
    add_callback(#"weapon_change", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x589a5cda, Offset: 0x1c38
// Size: 0x3c
function remove_on_weapon_change(func, obj) {
    remove_callback(#"weapon_change", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x5c56956e, Offset: 0x1c80
// Size: 0x3c
function on_weapon_fired(func, obj) {
    add_callback(#"weapon_fired", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x5ae02386, Offset: 0x1cc8
// Size: 0x3c
function remove_on_weapon_fired(func, obj) {
    remove_callback(#"weapon_fired", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xf65ca3cc, Offset: 0x1d10
// Size: 0x3c
function on_grenade_fired(func, obj) {
    add_callback(#"grenade_fired", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb5956c4f, Offset: 0x1d58
// Size: 0x3c
function remove_on_grenade_fired(func, obj) {
    remove_callback(#"grenade_fired", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x529d4a61, Offset: 0x1da0
// Size: 0x3c
function on_offhand_fire(func, obj) {
    add_callback(#"offhand_fire", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb563d46f, Offset: 0x1de8
// Size: 0x3c
function remove_on_offhand_fire(func, obj) {
    remove_callback(#"offhand_fire", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x9efbf44, Offset: 0x1e30
// Size: 0x3c
function function_4b7977fe(func, obj) {
    add_callback(#"hash_198a389d6b65f68d", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x2f5e1, Offset: 0x1e78
// Size: 0x3c
function function_61583a71(func, obj) {
    remove_callback(#"hash_198a389d6b65f68d", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x77ade057, Offset: 0x1ec0
// Size: 0x3c
function on_detonate(func, obj) {
    function_d8abfc3d(#"detonate", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7b6dc086, Offset: 0x1f08
// Size: 0x3c
function remove_on_detonate(func, obj) {
    function_52ac9652(#"detonate", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x304abb26, Offset: 0x1f50
// Size: 0x3c
function on_double_tap_detonate(func, obj) {
    function_d8abfc3d(#"doubletap_detonate", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7412ad8b, Offset: 0x1f98
// Size: 0x3c
function remove_on_double_tap_detonate(func, obj) {
    function_52ac9652(#"doubletap_detonate", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x3e6e5b4e, Offset: 0x1fe0
// Size: 0x3c
function on_death(func, obj) {
    function_d8abfc3d(#"death", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x2e5d6add, Offset: 0x2028
// Size: 0x3c
function remove_on_death(func, obj) {
    function_52ac9652(#"death", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xa287272e, Offset: 0x2070
// Size: 0x3c
function function_27d9ab8(func, obj) {
    add_callback(#"hash_1e4a4ca774f4ce22", func, obj);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x21 linked variadic
// Checksum 0x18f3f662, Offset: 0x20b8
// Size: 0x44
function on_trigger(func, obj, ...) {
    function_d8abfc3d(#"on_trigger", func, obj, vararg);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x3b44bf23, Offset: 0x2108
// Size: 0x3c
function remove_on_trigger(func, obj) {
    function_52ac9652(#"on_trigger", func, obj);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x21 linked variadic
// Checksum 0xcf17cc25, Offset: 0x2150
// Size: 0x44
function on_trigger_once(func, obj, ...) {
    function_d8abfc3d(#"on_trigger_once", func, obj, vararg);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xfa0b6dfa, Offset: 0x21a0
// Size: 0x3c
function remove_on_trigger_once(func, obj) {
    function_52ac9652(#"on_trigger_once", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xd72f90c4, Offset: 0x21e8
// Size: 0x3c
function function_33f0ddd3(func, obj) {
    add_callback(#"hash_39bf72fd97e248a0", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x3e54648a, Offset: 0x2230
// Size: 0x3c
function function_824d206(func, obj) {
    remove_callback(#"hash_39bf72fd97e248a0", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x1b6d653f, Offset: 0x2278
// Size: 0x3c
function on_boast(func, obj) {
    add_callback(#"on_boast", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xc420679e, Offset: 0x22c0
// Size: 0x3c
function remove_on_boast(func, obj) {
    remove_callback(#"on_boast", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7dbe64ae, Offset: 0x2308
// Size: 0x3c
function function_5753ac6e(func, obj) {
    add_callback(#"hash_4a9c56bba76da754", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb54f975e, Offset: 0x2350
// Size: 0x3c
function function_16046baa(func, obj) {
    remove_callback(#"hash_4a9c56bba76da754", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xfe970841, Offset: 0x2398
// Size: 0x3c
function on_ping(func, obj) {
    add_callback(#"on_ping", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xd0862169, Offset: 0x23e0
// Size: 0x3c
function on_menu_response(func, obj) {
    add_callback(#"menu_response", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xbf6898b8, Offset: 0x2428
// Size: 0x3c
function function_96bbd5dc(func, obj) {
    remove_callback(#"menu_response", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x4b26c4d5, Offset: 0x2470
// Size: 0x3c
function on_item_pickup(func, obj) {
    add_callback(#"on_item_pickup", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x45d92ae5, Offset: 0x24b8
// Size: 0x3c
function on_item_drop(func, obj) {
    add_callback(#"on_drop_item", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xba3ad0f8, Offset: 0x2500
// Size: 0x3c
function on_drop_inventory(func, obj) {
    add_callback(#"on_drop_inventory", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xc09fe6ba, Offset: 0x2548
// Size: 0x3c
function on_item_use(func, obj) {
    add_callback(#"on_item_use", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x97fa77d8, Offset: 0x2590
// Size: 0x3c
function on_stash_open(func, obj) {
    add_callback(#"on_stash_open", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xbe88a26, Offset: 0x25d8
// Size: 0x3c
function on_character_unlock(func, obj) {
    add_callback(#"on_character_unlock", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x72aa1af, Offset: 0x2620
// Size: 0x3c
function on_contract_complete(func, obj) {
    add_callback(#"contract_complete", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x27eb8ff, Offset: 0x2668
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
// Checksum 0xe5e8c5b4, Offset: 0x26e0
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
// Checksum 0x69218777, Offset: 0x2758
// Size: 0x6c
function function_be4cb7fe(func, obj) {
    if (self == level) {
        add_callback(#"hash_255b4626805810f5", func, obj);
        return;
    }
    function_d8abfc3d(#"hash_255b4626805810f5", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x6bc1579d, Offset: 0x27d0
// Size: 0x3c
function function_532a4f74(func, obj) {
    add_callback(#"hash_78ee75fdad31407d", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xdce2d791, Offset: 0x2818
// Size: 0x3c
function function_c16ce2bc(func, obj) {
    add_callback(#"hash_52c6deac4a362083", func, obj);
}

// Namespace callback/level_preinit
// Params 1, eflags: 0x40
// Checksum 0x62bc7998, Offset: 0x2860
// Size: 0x3c
function event_handler[level_preinit] codecallback_preinitialization(*eventstruct) {
    system::run_pre_systems();
    flag::set(#"hash_2e89d1cf2db1b05c");
}

// Namespace callback/level_init
// Params 1, eflags: 0x40
// Checksum 0xff9e600, Offset: 0x28a8
// Size: 0x2c
function event_handler[level_init] function_4123368a(*eventstruct) {
    flag::set(#"levelinit");
}

// Namespace callback/event_cc819519
// Params 1, eflags: 0x40
// Checksum 0x1ff3c33c, Offset: 0x28e0
// Size: 0x3c
function event_handler[event_cc819519] function_12c01a61(*eventstruct) {
    system::run_post_systems();
    flag::set(#"postinit");
}

// Namespace callback/level_finalizeinit
// Params 1, eflags: 0x40
// Checksum 0x3f4b1abd, Offset: 0x2928
// Size: 0x5c
function event_handler[level_finalizeinit] codecallback_finalizeinitialization(*eventstruct) {
    system::function_b1553822();
    flag::set(#"hash_4f4b65226250fc99");
    callback(#"on_finalize_initialization");
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7a0d93f7, Offset: 0x2990
// Size: 0x40
function add_weapon_damage(weapontype, callback) {
    if (!isdefined(level.weapon_damage_callback_array)) {
        level.weapon_damage_callback_array = [];
    }
    level.weapon_damage_callback_array[weapontype] = callback;
}

// Namespace callback/callbacks_shared
// Params 5, eflags: 0x0
// Checksum 0xc623b3aa, Offset: 0x29d8
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
// Params 2, eflags: 0x1 linked
// Checksum 0x8f29f8ae, Offset: 0x2ab0
// Size: 0x40
function add_weapon_fired(weapon, callback) {
    if (!isdefined(level.var_129c2069)) {
        level.var_129c2069 = [];
    }
    level.var_129c2069[weapon] = callback;
}

// Namespace callback/callbacks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x5d77f599, Offset: 0x2af8
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
// Checksum 0xcb1a51c4, Offset: 0x2ba8
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
// Checksum 0xf696f670, Offset: 0x2c10
// Size: 0x30
function event_handler[player_connect] codecallback_playerconnect(*eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayerconnect ]]();
}

// Namespace callback/player_disconnect
// Params 1, eflags: 0x40
// Checksum 0xcf0911aa, Offset: 0x2c48
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
// Checksum 0xd0751ba4, Offset: 0x2ce8
// Size: 0x34
function event_handler[hostmigration_setupgametype] codecallback_migration_setupgametype() {
    println("<dev string:xfd>");
    simple_hostmigration::migration_setupgametype();
}

// Namespace callback/hostmigration
// Params 1, eflags: 0x40
// Checksum 0xf6183ce, Offset: 0x2d28
// Size: 0x3c
function event_handler[hostmigration] codecallback_hostmigration(*eventstruct) {
    println("<dev string:x12d>");
    [[ level.callbackhostmigration ]]();
}

// Namespace callback/hostmigration_save
// Params 1, eflags: 0x40
// Checksum 0x3d89cd9b, Offset: 0x2d70
// Size: 0x3c
function event_handler[hostmigration_save] codecallback_hostmigrationsave(*eventstruct) {
    println("<dev string:x153>");
    [[ level.callbackhostmigrationsave ]]();
}

// Namespace callback/hostmigration_premigrationsave
// Params 1, eflags: 0x40
// Checksum 0x205ec562, Offset: 0x2db8
// Size: 0x3c
function event_handler[hostmigration_premigrationsave] codecallback_prehostmigrationsave(*eventstruct) {
    println("<dev string:x17d>");
    [[ level.callbackprehostmigrationsave ]]();
}

// Namespace callback/hostmigration_playermigrated
// Params 1, eflags: 0x40
// Checksum 0x3971b1b5, Offset: 0x2e00
// Size: 0x3c
function event_handler[hostmigration_playermigrated] codecallback_playermigrated(*eventstruct) {
    println("<dev string:x1aa>");
    [[ level.callbackplayermigrated ]]();
}

// Namespace callback/player_damage
// Params 1, eflags: 0x40
// Checksum 0x68e7a761, Offset: 0x2e48
// Size: 0x98
function event_handler[player_damage] codecallback_playerdamage(eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayerdamage ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.normal);
}

// Namespace callback/player_killed
// Params 1, eflags: 0x40
// Checksum 0x706e00e, Offset: 0x2ee8
// Size: 0x78
function event_handler[player_killed] codecallback_playerkilled(eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayerkilled ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset, eventstruct.death_anim_duration);
}

// Namespace callback/event_2958ea55
// Params 1, eflags: 0x40
// Checksum 0x67fb85df, Offset: 0x2f68
// Size: 0x68
function event_handler[event_2958ea55] function_73e8e3f9(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_3a9881cb)) {
        [[ level.var_3a9881cb ]](eventstruct.attacker, eventstruct.effect_name, eventstruct.var_894859a2, eventstruct.var_ab5b905e, eventstruct.weapon);
    }
}

// Namespace callback/event_a98a54a7
// Params 1, eflags: 0x40
// Checksum 0xf9ad7f84, Offset: 0x2fd8
// Size: 0x38
function event_handler[event_a98a54a7] function_323548ba(eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayershielddamageblocked ]](eventstruct.damage);
}

// Namespace callback/player_laststand
// Params 1, eflags: 0x40
// Checksum 0x1785f306, Offset: 0x3018
// Size: 0x8c
function event_handler[player_laststand] codecallback_playerlaststand(eventstruct) {
    self endon(#"disconnect");
    self stopanimscripted();
    [[ level.callbackplayerlaststand ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset, eventstruct.delay);
}

// Namespace callback/event_dd67c1a8
// Params 1, eflags: 0x40
// Checksum 0xfeeabaf8, Offset: 0x30b0
// Size: 0x38
function event_handler[event_dd67c1a8] function_46c0443b(eventstruct) {
    self endon(#"disconnect");
    [[ level.var_69959686 ]](eventstruct.weapon);
}

// Namespace callback/event_1294e3a7
// Params 1, eflags: 0x40
// Checksum 0x2269fce4, Offset: 0x30f0
// Size: 0x48
function event_handler[event_1294e3a7] function_9e4c68e2(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_bb1ea3f1)) {
        [[ level.var_bb1ea3f1 ]](eventstruct.weapon);
    }
}

// Namespace callback/event_eb7e11e4
// Params 1, eflags: 0x40
// Checksum 0x803c8656, Offset: 0x3140
// Size: 0x48
function event_handler[event_eb7e11e4] function_2f677e9d(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_2f64d35)) {
        [[ level.var_2f64d35 ]](eventstruct.weapon);
    }
}

// Namespace callback/event_3dd1ca18
// Params 1, eflags: 0x40
// Checksum 0x86f7165, Offset: 0x3190
// Size: 0x48
function event_handler[event_3dd1ca18] function_cf68d893(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_523faa05)) {
        [[ level.var_523faa05 ]](eventstruct.weapon);
    }
}

// Namespace callback/event_bf57d5bb
// Params 1, eflags: 0x40
// Checksum 0x144bb18f, Offset: 0x31e0
// Size: 0x48
function event_handler[event_bf57d5bb] function_d7eb3672(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_a28be0a5)) {
        [[ level.var_a28be0a5 ]](eventstruct.weapon);
    }
}

// Namespace callback/event_e9b4bb47
// Params 1, eflags: 0x40
// Checksum 0x1e0a1340, Offset: 0x3230
// Size: 0x48
function event_handler[event_e9b4bb47] function_7dba9a1(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_bd0b5fc1)) {
        [[ level.var_bd0b5fc1 ]](eventstruct.weapon);
    }
}

// Namespace callback/player_boast
// Params 1, eflags: 0x40
// Checksum 0xe93d3097, Offset: 0x3280
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
// Checksum 0xec50964c, Offset: 0x3300
// Size: 0x44
function event_handler[event_8451509a] function_e35aeddd(*eventstruct) {
    self endon(#"disconnect");
    callback(#"hash_4a9c56bba76da754");
}

// Namespace callback/sprint_begin
// Params 1, eflags: 0x40
// Checksum 0x74182fed, Offset: 0x3350
// Size: 0x44
function event_handler[sprint_begin] function_336afb8e(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_7bd720f6)) {
        [[ level.var_7bd720f6 ]](eventstruct);
    }
}

// Namespace callback/sprint_end
// Params 1, eflags: 0x40
// Checksum 0xeda126f6, Offset: 0x33a0
// Size: 0x44
function event_handler[sprint_end] function_6806b4f(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_42b43ce2)) {
        [[ level.var_42b43ce2 ]](eventstruct);
    }
}

// Namespace callback/event_9e865a6e
// Params 1, eflags: 0x40
// Checksum 0x9add3522, Offset: 0x33f0
// Size: 0x44
function event_handler[event_9e865a6e] function_1855d09f(*eventstruct) {
    self endon(#"disconnect");
    callback(#"hash_78ee75fdad31407d");
}

// Namespace callback/event_50ce9aa8
// Params 1, eflags: 0x40
// Checksum 0x5019a92a, Offset: 0x3440
// Size: 0x44
function event_handler[event_50ce9aa8] function_e51b8b9d(*eventstruct) {
    self endon(#"disconnect");
    callback(#"hash_52c6deac4a362083");
}

// Namespace callback/slide_begin
// Params 1, eflags: 0x40
// Checksum 0xe35437b5, Offset: 0x3490
// Size: 0x44
function event_handler[slide_begin] function_2e3100e0(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_e74639aa)) {
        [[ level.var_e74639aa ]](eventstruct);
    }
}

// Namespace callback/slide_end
// Params 1, eflags: 0x40
// Checksum 0x9d280e48, Offset: 0x34e0
// Size: 0x44
function event_handler[slide_end] function_e1b7e658(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_7f80c5a6)) {
        [[ level.var_7f80c5a6 ]](eventstruct);
    }
}

// Namespace callback/jump_begin
// Params 1, eflags: 0x40
// Checksum 0x2c92b6c4, Offset: 0x3530
// Size: 0x44
function event_handler[jump_begin] function_b0353bef(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_6c3038dc)) {
        [[ level.var_6c3038dc ]](eventstruct);
    }
}

// Namespace callback/jump_end
// Params 1, eflags: 0x40
// Checksum 0xf51e5d0, Offset: 0x3580
// Size: 0x44
function event_handler[jump_end] function_40b29944(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_4c9e52d1)) {
        [[ level.var_4c9e52d1 ]](eventstruct);
    }
}

// Namespace callback/player_melee
// Params 1, eflags: 0x40
// Checksum 0x512f179b, Offset: 0x35d0
// Size: 0x70
function event_handler[player_melee] codecallback_playermelee(eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayermelee ]](eventstruct.attacker, eventstruct.amount, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.bone_index, eventstruct.is_shieldhit, eventstruct.is_frombehind);
}

// Namespace callback/actor_spawned
// Params 1, eflags: 0x40
// Checksum 0x6cb390e2, Offset: 0x3648
// Size: 0x28
function event_handler[actor_spawned] codecallback_actorspawned(eventstruct) {
    self [[ level.callbackactorspawned ]](eventstruct.entity);
}

// Namespace callback/event_7d801d3e
// Params 1, eflags: 0x40
// Checksum 0x4addce2, Offset: 0x3678
// Size: 0x38
function event_handler[event_7d801d3e] function_2f02dc73(eventstruct) {
    if (isdefined(level.var_a79419ed)) {
        self [[ level.var_a79419ed ]](eventstruct.entity);
    }
}

// Namespace callback/event_52071346
// Params 1, eflags: 0x40
// Checksum 0x8a62e62e, Offset: 0x36b8
// Size: 0x2c
function event_handler[event_52071346] function_40ef094(*eventstruct) {
    self callback(#"hash_7d2e38b28c894e5a");
}

// Namespace callback/actor_damage
// Params 1, eflags: 0x40
// Checksum 0x9436e931, Offset: 0x36f0
// Size: 0x94
function event_handler[actor_damage] codecallback_actordamage(eventstruct) {
    [[ level.callbackactordamage ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.model_index, eventstruct.surface_type, eventstruct.normal);
}

// Namespace callback/actor_killed
// Params 1, eflags: 0x40
// Checksum 0x3b0877e8, Offset: 0x3790
// Size: 0x5c
function event_handler[actor_killed] codecallback_actorkilled(eventstruct) {
    [[ level.callbackactorkilled ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset);
}

// Namespace callback/actor_cloned
// Params 1, eflags: 0x40
// Checksum 0x23fb11fb, Offset: 0x37f8
// Size: 0x24
function event_handler[actor_cloned] codecallback_actorcloned(eventstruct) {
    [[ level.callbackactorcloned ]](eventstruct.clone);
}

// Namespace callback/event_bc72e1ee
// Params 1, eflags: 0x40
// Checksum 0x6cff0ed9, Offset: 0x3828
// Size: 0x2c
function event_handler[event_bc72e1ee] function_df3c93ef(eventstruct) {
    self callback(#"hash_3d6ccbbe0e628b2d", eventstruct);
}

// Namespace callback/event_1524de24
// Params 1, eflags: 0x40
// Checksum 0x1bded590, Offset: 0x3860
// Size: 0x9c
function event_handler[event_1524de24] function_5b0a9275(eventstruct) {
    [[ level.var_6788bf11 ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.model_index, eventstruct.part_name, eventstruct.surface_type, eventstruct.normal);
}

// Namespace callback/vehicle_spawned
// Params 1, eflags: 0x40
// Checksum 0x69efc496, Offset: 0x3908
// Size: 0x34
function event_handler[vehicle_spawned] codecallback_vehiclespawned(eventstruct) {
    if (isdefined(level.callbackvehiclespawned)) {
        [[ level.callbackvehiclespawned ]](eventstruct.spawner);
    }
}

// Namespace callback/vehicle_killed
// Params 1, eflags: 0x40
// Checksum 0xc9d8f6f6, Offset: 0x3948
// Size: 0x5c
function event_handler[vehicle_killed] codecallback_vehiclekilled(eventstruct) {
    [[ level.callbackvehiclekilled ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset);
}

// Namespace callback/vehicle_damage
// Params 1, eflags: 0x40
// Checksum 0x5effaa54, Offset: 0x39b0
// Size: 0x94
function event_handler[vehicle_damage] codecallback_vehicledamage(eventstruct) {
    [[ level.callbackvehicledamage ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.damage_from_underneath, eventstruct.model_index, eventstruct.part_name, eventstruct.normal);
}

// Namespace callback/vehicle_radiusdamage
// Params 1, eflags: 0x40
// Checksum 0x72620167, Offset: 0x3a50
// Size: 0x94
function event_handler[vehicle_radiusdamage] codecallback_vehicleradiusdamage(eventstruct) {
    if (isdefined(level.callbackvehicleradiusdamage)) {
        [[ level.callbackvehicleradiusdamage ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.inner_damage, eventstruct.outer_damage, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.outer_radius, eventstruct.cone_angle, eventstruct.cone_direction, eventstruct.time_offset);
    }
}

// Namespace callback/ping
// Params 1, eflags: 0x40
// Checksum 0x7bafe436, Offset: 0x3af0
// Size: 0x2c
function event_handler[ping] function_87cf247e(eventstruct) {
    self callback(#"on_ping", eventstruct);
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x3d667980, Offset: 0x3b28
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
// Params 0, eflags: 0x1 linked
// Checksum 0x445e95d3, Offset: 0x3be0
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
// Checksum 0xe1e52a57, Offset: 0x3c60
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
// Checksum 0xd6be680e, Offset: 0x3df0
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
// Checksum 0x9d24023b, Offset: 0x3e98
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
// Params 0, eflags: 0x1 linked
// Checksum 0x9255897e, Offset: 0x3f40
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
// Checksum 0x9892e9f0, Offset: 0x4040
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
// Checksum 0xc11506ae, Offset: 0x4110
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
// Checksum 0x51f8e147, Offset: 0x41d8
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
// Checksum 0x8f399ef5, Offset: 0x42e8
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
        case #"hash_23fc6c9a6565775f":
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
        case #"hash_3da13f2589a059c6":
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
// Checksum 0xdc0ce807, Offset: 0x4540
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
// Checksum 0x70c94530, Offset: 0x45e0
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
// Checksum 0xc401a15a, Offset: 0x4680
// Size: 0x74
function event_handler[ui_fadeblackscreen] codecallback_fadeblackscreen(eventstruct) {
    if (isplayer(self) && !isbot(self)) {
        self thread hud::fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend, eventstruct.blend);
    }
}

// Namespace callback/event_40f83b44
// Params 1, eflags: 0x40
// Checksum 0x1fd3e11d, Offset: 0x4700
// Size: 0x74
function event_handler[event_40f83b44] function_4b5ab05f(eventstruct) {
    if (isplayer(self) && !isbot(self)) {
        self thread hud::fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend_out, eventstruct.blend_in);
    }
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xc1873519, Offset: 0x4780
// Size: 0x1f4
function abort_level() {
    println("<dev string:x1d1>");
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
// Checksum 0xeabc23d1, Offset: 0x4980
// Size: 0x58
function event_handler[glass_smash] codecallback_glasssmash(eventstruct) {
    level notify(#"glass_smash", {#position:eventstruct.position, #direction:eventstruct.direction});
}

// Namespace callback/freefall
// Params 1, eflags: 0x40
// Checksum 0x16552c53, Offset: 0x49e0
// Size: 0x2c
function event_handler[freefall] function_5019e563(eventstruct) {
    self callback(#"freefall", eventstruct);
}

// Namespace callback/parachute
// Params 1, eflags: 0x40
// Checksum 0xbb4e74ae, Offset: 0x4a18
// Size: 0x2c
function event_handler[parachute] function_87b05fa3(eventstruct) {
    self callback(#"parachute", eventstruct);
}

// Namespace callback/event_43f9bc02
// Params 1, eflags: 0x40
// Checksum 0x4e11bcdd, Offset: 0x4a50
// Size: 0x2c
function event_handler[event_43f9bc02] function_5bc68fd9(eventstruct) {
    self callback(#"hash_5d462019157fdedc", eventstruct);
}

// Namespace callback/skydive_end
// Params 1, eflags: 0x40
// Checksum 0xf0fc5884, Offset: 0x4a88
// Size: 0x2c
function event_handler[skydive_end] function_250a9740(eventstruct) {
    self callback(#"skydive_end", eventstruct);
}

// Namespace callback/swimming_begin
// Params 1, eflags: 0x40
// Checksum 0x3057be3a, Offset: 0x4ac0
// Size: 0x44
function event_handler[swimming_begin] function_e337eb32(*eventstruct) {
    self callback(#"swimming", {#swimming:1});
}

// Namespace callback/swimming_end
// Params 1, eflags: 0x40
// Checksum 0x25721a57, Offset: 0x4b10
// Size: 0x44
function event_handler[swimming_end] function_e142d2b2(*eventstruct) {
    self callback(#"swimming", {#swimming:0});
}

// Namespace callback/underwater
// Params 1, eflags: 0x40
// Checksum 0x29078112, Offset: 0x4b60
// Size: 0x2c
function event_handler[underwater] codecallback_underwater(eventstruct) {
    self callback(#"underwater", eventstruct);
}

// Namespace callback/event_d6f9e6ad
// Params 1, eflags: 0x40
// Checksum 0xd9a7a258, Offset: 0x4b98
// Size: 0x2c
function event_handler[event_d6f9e6ad] function_8877d89(eventstruct) {
    self callback(#"hash_42aa89b2a0951308", eventstruct);
}

/#

    // Namespace callback/debug_movement
    // Params 1, eflags: 0x40
    // Checksum 0x7ce8a2d0, Offset: 0x4bd0
    // Size: 0x34
    function event_handler[debug_movement] function_930ce3c3(eventstruct) {
        self callback(#"debug_movement", eventstruct);
    }

#/

// Namespace callback/event_31e1c5e9
// Params 1, eflags: 0x40
// Checksum 0x4939fe72, Offset: 0x4c10
// Size: 0x5c
function event_handler[event_31e1c5e9] function_7d45bff(*eventstruct) {
    self endon(#"death");
    level flag::wait_till("system_postinit_complete");
    self callback(#"hash_1e4a4ca774f4ce22");
}

// Namespace callback/trigger
// Params 2, eflags: 0x41 linked
// Checksum 0x64491e93, Offset: 0x4c78
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
// Checksum 0x1ed8319d, Offset: 0x4d50
// Size: 0x2c
function event_handler[entity_deleted] codecallback_entitydeleted(*eventstruct) {
    self callback(#"on_entity_deleted");
}

// Namespace callback/bot_enteruseredge
// Params 1, eflags: 0x40
// Checksum 0xd2e39979, Offset: 0x4d88
// Size: 0x2c
function event_handler[bot_enteruseredge] codecallback_botentereduseredge(eventstruct) {
    self callback(#"hash_767bb029d2dcda7c", eventstruct);
}

// Namespace callback/event_e054b61b
// Params 1, eflags: 0x40
// Checksum 0xa4813068, Offset: 0x4dc0
// Size: 0x2c
function event_handler[event_e054b61b] function_d658381b(*eventstruct) {
    self callback(#"hash_6efb8cec1ca372dc");
}

// Namespace callback/event_46837d44
// Params 1, eflags: 0x40
// Checksum 0x6fc92fc2, Offset: 0x4df8
// Size: 0x2c
function event_handler[event_46837d44] function_2ff20679(*eventstruct) {
    self callback(#"hash_6280ac8ed281ce3c");
}

// Namespace callback/event_596b7bdc
// Params 1, eflags: 0x40
// Checksum 0x464a7cb1, Offset: 0x4e30
// Size: 0x88
function event_handler[event_596b7bdc] function_f5026566(eventstruct) {
    if (!isdefined(level.var_abb3fd2)) {
        return;
    }
    /#
    #/
    eventdata = {};
    eventdata.tableindex = eventstruct.tableindex;
    eventdata.var_96db1aff = eventstruct.var_96db1aff;
    self [[ level.var_abb3fd2 ]](eventstruct.event_name, eventstruct.time, eventstruct.client, eventstruct.priority, eventdata);
}

// Namespace callback/player_decoration
// Params 1, eflags: 0x40
// Checksum 0x47060048, Offset: 0x4ec0
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
// Checksum 0xb1bd70f5, Offset: 0x4f38
// Size: 0x30
function event_handler[event_4620dccd] function_a4a77d57(eventstruct) {
    if (isdefined(level.var_b24258)) {
        self [[ level.var_b24258 ]](eventstruct);
    }
}

// Namespace callback/event_4e560379
// Params 1, eflags: 0x40
// Checksum 0xbb1e66d9, Offset: 0x4f70
// Size: 0x30
function event_handler[event_4e560379] function_d5edcd9a(eventstruct) {
    if (isdefined(level.var_ee39a80e)) {
        self [[ level.var_ee39a80e ]](eventstruct);
    }
}

// Namespace callback/event_ba6fea54
// Params 1, eflags: 0x40
// Checksum 0x8f8dd214, Offset: 0x4fa8
// Size: 0x4c
function event_handler[event_ba6fea54] function_f4449e63(eventstruct) {
    if (isdefined(level.var_17c7288a)) {
        [[ level.var_17c7288a ]](eventstruct.player, eventstruct.eventtype, eventstruct.eventdata, eventstruct.var_c5a66313);
    }
}

// Namespace callback/detonate
// Params 1, eflags: 0x40
// Checksum 0x4e207f8b, Offset: 0x5000
// Size: 0x2c
function event_handler[detonate] codecallback_detonate(eventstruct) {
    self callback(#"detonate", eventstruct);
}

// Namespace callback/doubletap_detonate
// Params 1, eflags: 0x40
// Checksum 0xc64cc74c, Offset: 0x5038
// Size: 0x2c
function event_handler[doubletap_detonate] function_92aba4c4(eventstruct) {
    self callback(#"doubletap_detonate", eventstruct);
}

// Namespace callback/death
// Params 1, eflags: 0x40
// Checksum 0x445a1469, Offset: 0x5070
// Size: 0x44
function event_handler[death] codecallback_death(eventstruct) {
    self notify(#"death", eventstruct);
    self callback(#"death", eventstruct);
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x50c0
// Size: 0x4
function callback_void() {
    
}

