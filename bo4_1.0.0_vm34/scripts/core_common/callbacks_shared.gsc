#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\simple_hostmigration;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\voice\voice_events;

#namespace callback;

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xd9798cd0, Offset: 0x118
// Size: 0x5c
function callback(event, params) {
    function_11e167d6(level, event, params);
    if (self != level) {
        function_11e167d6(self, event, params);
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x1e1b8a1c, Offset: 0x180
// Size: 0xb0
function function_569d2199(event, params) {
    ais = getaiarray();
    foreach (ai in ais) {
        ai function_11e167d6(ai, event, params);
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x985f5df9, Offset: 0x238
// Size: 0xd0
function function_a8a0e3ff(event, params) {
    function_11e167d6(level, event, params);
    players = getplayers();
    foreach (player in players) {
        player function_11e167d6(player, event, params);
    }
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x4
// Checksum 0xe4ac721c, Offset: 0x310
// Size: 0x1be
function private function_11e167d6(ent, event, params) {
    if (isdefined(ent._callbacks) && isdefined(ent._callbacks[event])) {
        for (i = 0; i < ent._callbacks[event].size; i++) {
            callback = ent._callbacks[event][i][0];
            obj = ent._callbacks[event][i][1];
            var_e01830cb = isdefined(ent._callbacks[event][i][2]) ? ent._callbacks[event][i][2] : [];
            if (!isdefined(callback)) {
                continue;
            }
            if (isdefined(obj)) {
                if (isdefined(params)) {
                    util::function_b51353f(obj, callback, self, params, var_e01830cb);
                } else {
                    util::function_e54ebad6(obj, callback, self, var_e01830cb);
                }
                continue;
            }
            if (isdefined(params)) {
                util::function_e54ebad6(self, callback, params, var_e01830cb);
                continue;
            }
            util::single_thread_argarray(self, callback, var_e01830cb);
        }
    }
}

// Namespace callback/callbacks_shared
// Params 4, eflags: 0x0
// Checksum 0xac34e242, Offset: 0x4d8
// Size: 0x4c
function add_callback(event, func, obj, a_params) {
    function_49c6043(level, event, func, obj, a_params);
}

// Namespace callback/callbacks_shared
// Params 4, eflags: 0x0
// Checksum 0x9e8b506f, Offset: 0x530
// Size: 0x44
function function_1dea870d(event, func, obj, a_params) {
    function_49c6043(self, event, func, obj, a_params);
}

// Namespace callback/callbacks_shared
// Params 5, eflags: 0x4
// Checksum 0x34489f64, Offset: 0x580
// Size: 0x194
function private function_49c6043(ent, event, func, obj, a_params) {
    assert(isdefined(event), "<dev string:x30>");
    if (!isdefined(ent._callbacks) || !isdefined(ent._callbacks[event])) {
        ent._callbacks[event] = [];
    }
    foreach (callback in ent._callbacks[event]) {
        if (callback[0] == func) {
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
// Checksum 0xab28fc86, Offset: 0x720
// Size: 0x3c
function private function_f969a6bd(event, func) {
    return string(event) + string(func);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x4d7062fe, Offset: 0x768
// Size: 0x8c
function remove_callback_on_death(event, func) {
    self notify(function_f969a6bd(event, func));
    self endon(function_f969a6bd(event, func));
    self util::waittill_either("death", "remove_callbacks");
    remove_callback(event, func, self);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x0
// Checksum 0x3bc26802, Offset: 0x800
// Size: 0x3c
function remove_callback(event, func, obj) {
    function_4e9b4ffe(level, event, func, obj);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x0
// Checksum 0x75daf137, Offset: 0x848
// Size: 0x3c
function function_1f42556c(event, func, obj) {
    function_4e9b4ffe(self, event, func, obj);
}

// Namespace callback/callbacks_shared
// Params 4, eflags: 0x4
// Checksum 0xb70e11db, Offset: 0x890
// Size: 0x184
function private function_4e9b4ffe(ent, event, func, obj) {
    assert(isdefined(event), "<dev string:x60>");
    if (func === "all") {
        ent._callbacks[event] = [];
        return;
    }
    assert(isdefined(ent._callbacks[event]), "<dev string:x93>");
    foreach (index, func_group in ent._callbacks[event]) {
        if (func_group[0] == func) {
            if (func_group[1] === obj) {
                if (isdefined(obj)) {
                    obj notify(function_f969a6bd(event, func));
                }
                arrayremoveindex(ent._callbacks[event], index, 0);
                break;
            }
        }
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xcf96059f, Offset: 0xa20
// Size: 0x3c
function on_finalize_initialization(func, obj) {
    add_callback(#"on_finalize_initialization", func, obj);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0xcc80894b, Offset: 0xa68
// Size: 0x44
function on_connect(func, obj, ...) {
    add_callback(#"on_player_connect", func, obj, vararg);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x9d6dd3f, Offset: 0xab8
// Size: 0x3c
function remove_on_connect(func, obj) {
    remove_callback(#"on_player_connect", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x63267af9, Offset: 0xb00
// Size: 0x3c
function on_connecting(func, obj) {
    add_callback(#"on_player_connecting", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xc014780, Offset: 0xb48
// Size: 0x3c
function remove_on_connecting(func, obj) {
    remove_callback(#"on_player_connecting", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x8b96e0b3, Offset: 0xb90
// Size: 0x3c
function on_disconnect(func, obj) {
    add_callback(#"on_player_disconnect", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xe68362ee, Offset: 0xbd8
// Size: 0x3c
function remove_on_disconnect(func, obj) {
    remove_callback(#"on_player_disconnect", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x8995b670, Offset: 0xc20
// Size: 0x3c
function on_spawned(func, obj) {
    add_callback(#"on_player_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xd78f31ce, Offset: 0xc68
// Size: 0x3c
function remove_on_spawned(func, obj) {
    remove_callback(#"on_player_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x713910ae, Offset: 0xcb0
// Size: 0x3c
function remove_on_revived(func, obj) {
    remove_callback(#"on_player_revived", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x146f3de9, Offset: 0xcf8
// Size: 0x3c
function on_deleted(func, obj) {
    add_callback(#"on_entity_deleted", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x57cf8ef1, Offset: 0xd40
// Size: 0x3c
function remove_on_deleted(func, obj) {
    remove_callback(#"on_entity_deleted", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x28b9e5a3, Offset: 0xd88
// Size: 0x3c
function on_loadout(func, obj) {
    add_callback(#"on_loadout", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x6233aefe, Offset: 0xdd0
// Size: 0x3c
function remove_on_loadout(func, obj) {
    remove_callback(#"on_loadout", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xf26a12a2, Offset: 0xe18
// Size: 0x3c
function on_player_damage(func, obj) {
    add_callback(#"on_player_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xe0460ce4, Offset: 0xe60
// Size: 0x3c
function remove_on_player_damage(func, obj) {
    remove_callback(#"on_player_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x51187be6, Offset: 0xea8
// Size: 0x3c
function on_start_gametype(func, obj) {
    add_callback(#"on_start_gametype", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xf8a4ae70, Offset: 0xef0
// Size: 0x3c
function on_end_game(func, obj) {
    add_callback(#"on_end_game", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xeaf35a24, Offset: 0xf38
// Size: 0x3c
function on_game_playing(func, obj) {
    add_callback(#"on_game_playing", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x128249ee, Offset: 0xf80
// Size: 0x3c
function on_joined_team(func, obj) {
    add_callback(#"joined_team", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x57b2e534, Offset: 0xfc8
// Size: 0x3c
function on_joined_spectate(func, obj) {
    add_callback(#"on_joined_spectate", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7327282f, Offset: 0x1010
// Size: 0x3c
function on_player_killed(func, obj) {
    add_callback(#"on_player_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xec4b1429, Offset: 0x1058
// Size: 0x3c
function on_player_killed_with_params(func, obj) {
    add_callback(#"on_player_killed_with_params", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x11fdd957, Offset: 0x10a0
// Size: 0x3c
function on_player_corpse(func, obj) {
    add_callback(#"on_player_corpse", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x1fc4ef1d, Offset: 0x10e8
// Size: 0x3c
function remove_on_player_killed(func, obj) {
    remove_callback(#"on_player_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xd258af66, Offset: 0x1130
// Size: 0x3c
function remove_on_player_killed_with_params(func, obj) {
    remove_callback(#"on_player_killed_with_params", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x241af10f, Offset: 0x1178
// Size: 0x3c
function on_dead_event(func, obj) {
    add_callback(#"on_dead_event", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xd64dba64, Offset: 0x11c0
// Size: 0x3c
function function_1886631(func, obj) {
    remove_callback(#"on_dead_event", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x63f4a12, Offset: 0x1208
// Size: 0x3c
function on_ai_killed(func, obj) {
    add_callback(#"on_ai_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7ebc82b0, Offset: 0x1250
// Size: 0x3c
function remove_on_ai_killed(func, obj) {
    remove_callback(#"on_ai_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xde47b3f6, Offset: 0x1298
// Size: 0x3c
function on_actor_killed(func, obj) {
    add_callback(#"on_actor_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x6e3da356, Offset: 0x12e0
// Size: 0x3c
function remove_on_actor_killed(func, obj) {
    remove_callback(#"on_actor_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xe8a77aa7, Offset: 0x1328
// Size: 0x3c
function on_vehicle_spawned(func, obj) {
    add_callback(#"on_vehicle_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x260db9b9, Offset: 0x1370
// Size: 0x3c
function remove_on_vehicle_spawned(func, obj) {
    remove_callback(#"on_vehicle_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x377f4ec9, Offset: 0x13b8
// Size: 0x3c
function on_vehicle_killed(func, obj) {
    add_callback(#"on_vehicle_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x3e84c568, Offset: 0x1400
// Size: 0x3c
function on_vehicle_collision(func, obj) {
    function_1dea870d(#"veh_collision", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xf779811a, Offset: 0x1448
// Size: 0x3c
function remove_on_vehicle_killed(func, obj) {
    remove_callback(#"on_vehicle_killed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb1f8cafa, Offset: 0x1490
// Size: 0x3c
function on_ai_damage(func, obj) {
    add_callback(#"on_ai_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xfb8dd286, Offset: 0x14d8
// Size: 0x3c
function remove_on_ai_damage(func, obj) {
    remove_callback(#"on_ai_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x9758cf8d, Offset: 0x1520
// Size: 0x3c
function on_ai_spawned(func, obj) {
    add_callback(#"on_ai_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xc4e7854a, Offset: 0x1568
// Size: 0x3c
function remove_on_ai_spawned(func, obj) {
    remove_callback(#"on_ai_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb4c8eb67, Offset: 0x15b0
// Size: 0x3c
function on_actor_damage(func, obj) {
    add_callback(#"on_actor_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7480db9c, Offset: 0x15f8
// Size: 0x3c
function remove_on_actor_damage(func, obj) {
    remove_callback(#"on_actor_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xd2b1966c, Offset: 0x1640
// Size: 0x3c
function function_789c6271(func, obj) {
    add_callback(#"hash_2e68909d4e4ed889", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xe9f5d922, Offset: 0x1688
// Size: 0x3c
function function_6e39ab52(func, obj) {
    remove_callback(#"hash_2e68909d4e4ed889", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x9ab1c84a, Offset: 0x16d0
// Size: 0x3c
function on_vehicle_damage(func, obj) {
    add_callback(#"on_vehicle_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x2161a537, Offset: 0x1718
// Size: 0x3c
function remove_on_vehicle_damage(func, obj) {
    remove_callback(#"on_vehicle_damage", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x309415ee, Offset: 0x1760
// Size: 0x3c
function on_laststand(func, obj) {
    add_callback(#"on_player_laststand", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x3d319f2b, Offset: 0x17a8
// Size: 0x3c
function remove_on_laststand(func, obj) {
    remove_callback(#"on_player_laststand", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x5d151395, Offset: 0x17f0
// Size: 0x3c
function on_bleedout(func, obj) {
    add_callback(#"on_player_bleedout", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x9a453639, Offset: 0x1838
// Size: 0x3c
function on_revived(func, obj) {
    add_callback(#"on_player_revived", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x290bbf74, Offset: 0x1880
// Size: 0x3c
function on_mission_failed(func, obj) {
    add_callback(#"on_mission_failed", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x6c49b980, Offset: 0x18c8
// Size: 0x3c
function on_challenge_complete(func, obj) {
    add_callback(#"on_challenge_complete", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xe2a11f46, Offset: 0x1910
// Size: 0x3c
function on_weapon_change(func, obj) {
    add_callback(#"weapon_change", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xbb150b85, Offset: 0x1958
// Size: 0x3c
function remove_on_weapon_change(func, obj) {
    remove_callback(#"weapon_change", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x87f9306c, Offset: 0x19a0
// Size: 0x3c
function on_weapon_fired(func, obj) {
    add_callback(#"weapon_fired", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xbf8ff903, Offset: 0x19e8
// Size: 0x3c
function remove_on_weapon_fired(func, obj) {
    remove_callback(#"weapon_fired", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xc6aff5a7, Offset: 0x1a30
// Size: 0x3c
function on_grenade_fired(func, obj) {
    add_callback(#"grenade_fired", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x9371b9e4, Offset: 0x1a78
// Size: 0x3c
function remove_on_grenade_fired(func, obj) {
    remove_callback(#"grenade_fired", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xca30c14c, Offset: 0x1ac0
// Size: 0x3c
function on_offhand_fire(func, obj) {
    add_callback(#"offhand_fire", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x9f1a53ee, Offset: 0x1b08
// Size: 0x3c
function remove_on_offhand_fire(func, obj) {
    remove_callback(#"offhand_fire", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x5a60533a, Offset: 0x1b50
// Size: 0x3c
function function_e108345d(func, obj) {
    add_callback(#"hash_198a389d6b65f68d", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xd9a2f6bf, Offset: 0x1b98
// Size: 0x3c
function function_947e4c26(func, obj) {
    remove_callback(#"hash_198a389d6b65f68d", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x3e3f91e1, Offset: 0x1be0
// Size: 0x3c
function on_detonate(func, obj) {
    function_1dea870d(#"detonate", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xf8d72839, Offset: 0x1c28
// Size: 0x3c
function remove_on_detonate(func, obj) {
    function_1f42556c(#"detonate", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x5ccc2501, Offset: 0x1c70
// Size: 0x3c
function on_double_tap_detonate(func, obj) {
    function_1dea870d(#"doubletap_detonate", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xe9491a87, Offset: 0x1cb8
// Size: 0x3c
function remove_on_double_tap_detonate(func, obj) {
    function_1f42556c(#"doubletap_detonate", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x4b030bd3, Offset: 0x1d00
// Size: 0x3c
function on_death(func, obj) {
    function_1dea870d(#"death", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x3521bd1c, Offset: 0x1d48
// Size: 0x3c
function remove_on_death(func, obj) {
    function_1f42556c(#"death", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xe2fa2f89, Offset: 0x1d90
// Size: 0x3c
function function_1a00d318(func, obj) {
    add_callback(#"hash_1e4a4ca774f4ce22", func, obj);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0x92bef1c5, Offset: 0x1dd8
// Size: 0x44
function on_trigger(func, obj, ...) {
    function_1dea870d(#"on_trigger", func, obj, vararg);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xaf083ee7, Offset: 0x1e28
// Size: 0x3c
function remove_on_trigger(func, obj) {
    function_1f42556c(#"on_trigger", func, obj);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0xac11dae9, Offset: 0x1e70
// Size: 0x44
function on_trigger_once(func, obj, ...) {
    function_1dea870d(#"on_trigger_once", func, obj, vararg);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa0f92c3e, Offset: 0x1ec0
// Size: 0x3c
function remove_on_trigger_once(func, obj) {
    function_1f42556c(#"on_trigger_once", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x9b629b69, Offset: 0x1f08
// Size: 0x3c
function function_c4f1b25e(func, obj) {
    add_callback(#"hash_39bf72fd97e248a0", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x5a11c186, Offset: 0x1f50
// Size: 0x3c
function function_4c693f09(func, obj) {
    remove_callback(#"hash_39bf72fd97e248a0", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x54d334e1, Offset: 0x1f98
// Size: 0x3c
function on_menu_response(func, obj) {
    add_callback(#"on_menu_response", func, obj);
}

// Namespace callback/level_preinit
// Params 1, eflags: 0x40
// Checksum 0xce43c12, Offset: 0x1fe0
// Size: 0x3c
function event_handler[level_preinit] codecallback_preinitialization(eventstruct) {
    callback(#"on_pre_initialization");
    system::run_pre_systems();
}

// Namespace callback/level_finalizeinit
// Params 1, eflags: 0x40
// Checksum 0xa54004de, Offset: 0x2028
// Size: 0x3c
function event_handler[level_finalizeinit] codecallback_finalizeinitialization(eventstruct) {
    system::run_post_systems();
    callback(#"on_finalize_initialization");
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x99b64fe4, Offset: 0x2070
// Size: 0x4a
function add_weapon_damage(weapontype, callback) {
    if (!isdefined(level.weapon_damage_callback_array)) {
        level.weapon_damage_callback_array = [];
    }
    level.weapon_damage_callback_array[weapontype] = callback;
}

// Namespace callback/callbacks_shared
// Params 5, eflags: 0x0
// Checksum 0x4c3c6571, Offset: 0x20c8
// Size: 0xda
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
// Checksum 0xcafe5d9, Offset: 0x21b0
// Size: 0x4a
function add_weapon_fired(weapon, callback) {
    if (!isdefined(level.var_1b244a28)) {
        level.var_1b244a28 = [];
    }
    level.var_1b244a28[weapon] = callback;
}

// Namespace callback/callbacks_shared
// Params 1, eflags: 0x0
// Checksum 0x7cfadc43, Offset: 0x2208
// Size: 0xa2
function callback_weapon_fired(weapon) {
    if (isdefined(weapon) && isdefined(level.var_1b244a28)) {
        if (isdefined(level.var_1b244a28[weapon])) {
            self thread [[ level.var_1b244a28[weapon] ]](weapon);
            return true;
        } else if (isdefined(level.var_1b244a28[weapon.rootweapon])) {
            self thread [[ level.var_1b244a28[weapon.rootweapon] ]](weapon);
            return true;
        }
    }
    return false;
}

// Namespace callback/gametype_start
// Params 1, eflags: 0x40
// Checksum 0xfc8351eb, Offset: 0x22b8
// Size: 0x4e
function event_handler[gametype_start] codecallback_startgametype(eventstruct) {
    if (!isdefined(level.gametypestarted) || !level.gametypestarted) {
        [[ level.callbackstartgametype ]]();
        level.gametypestarted = 1;
    }
}

// Namespace callback/player_connect
// Params 1, eflags: 0x40
// Checksum 0x5a09ed67, Offset: 0x2310
// Size: 0x30
function event_handler[player_connect] codecallback_playerconnect(eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayerconnect ]]();
}

// Namespace callback/player_disconnect
// Params 1, eflags: 0x40
// Checksum 0x89ebfa41, Offset: 0x2348
// Size: 0x8c
function event_handler[player_disconnect] codecallback_playerdisconnect(eventstruct) {
    self notify(#"death");
    self.player_disconnected = 1;
    self notify(#"disconnect");
    level notify(#"disconnect", self);
    [[ level.callbackplayerdisconnect ]]();
    callback(#"on_player_disconnect");
}

// Namespace callback/hostmigration_setupgametype
// Params 0, eflags: 0x40
// Checksum 0xa58e37c1, Offset: 0x23e0
// Size: 0x34
function event_handler[hostmigration_setupgametype] codecallback_migration_setupgametype() {
    println("<dev string:xc0>");
    simple_hostmigration::migration_setupgametype();
}

// Namespace callback/hostmigration
// Params 1, eflags: 0x40
// Checksum 0x5209e485, Offset: 0x2420
// Size: 0x3c
function event_handler[hostmigration] codecallback_hostmigration(eventstruct) {
    println("<dev string:xed>");
    [[ level.callbackhostmigration ]]();
}

// Namespace callback/hostmigration_save
// Params 1, eflags: 0x40
// Checksum 0x28d4dc, Offset: 0x2468
// Size: 0x3c
function event_handler[hostmigration_save] codecallback_hostmigrationsave(eventstruct) {
    println("<dev string:x110>");
    [[ level.callbackhostmigrationsave ]]();
}

// Namespace callback/hostmigration_premigrationsave
// Params 1, eflags: 0x40
// Checksum 0x9cfcde5c, Offset: 0x24b0
// Size: 0x3c
function event_handler[hostmigration_premigrationsave] codecallback_prehostmigrationsave(eventstruct) {
    println("<dev string:x137>");
    [[ level.callbackprehostmigrationsave ]]();
}

// Namespace callback/hostmigration_playermigrated
// Params 1, eflags: 0x40
// Checksum 0x2e3df023, Offset: 0x24f8
// Size: 0x3c
function event_handler[hostmigration_playermigrated] codecallback_playermigrated(eventstruct) {
    println("<dev string:x161>");
    [[ level.callbackplayermigrated ]]();
}

// Namespace callback/player_damage
// Params 1, eflags: 0x40
// Checksum 0x931f939b, Offset: 0x2540
// Size: 0xc8
function event_handler[player_damage] codecallback_playerdamage(eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayerdamage ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.normal);
}

// Namespace callback/player_killed
// Params 1, eflags: 0x40
// Checksum 0xd7b84e38, Offset: 0x2610
// Size: 0x98
function event_handler[player_killed] codecallback_playerkilled(eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayerkilled ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset, eventstruct.death_anim_duration);
}

// Namespace callback/event_e1fbe638
// Params 1, eflags: 0x40
// Checksum 0xca8f07b2, Offset: 0x26b0
// Size: 0x78
function event_handler[event_e1fbe638] function_562df5a8(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_dcb50c4e)) {
        [[ level.var_dcb50c4e ]](eventstruct.attacker, eventstruct.effect_name, eventstruct.var_c1550143, eventstruct.durationoverride, eventstruct.weapon);
    }
}

// Namespace callback/event_397cc267
// Params 1, eflags: 0x40
// Checksum 0xc92f1cf6, Offset: 0x2730
// Size: 0x38
function event_handler[event_397cc267] function_9cc0ff0b(eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayershielddamageblocked ]](eventstruct.damage);
}

// Namespace callback/player_laststand
// Params 1, eflags: 0x40
// Checksum 0xdf910922, Offset: 0x2770
// Size: 0xac
function event_handler[player_laststand] codecallback_playerlaststand(eventstruct) {
    self endon(#"disconnect");
    self stopanimscripted();
    [[ level.callbackplayerlaststand ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset, eventstruct.delay);
}

// Namespace callback/event_59f30256
// Params 1, eflags: 0x40
// Checksum 0x2e1292ea, Offset: 0x2828
// Size: 0x38
function event_handler[event_59f30256] function_64a22ce6(eventstruct) {
    self endon(#"disconnect");
    [[ level.var_d280b204 ]](eventstruct.weapon);
}

// Namespace callback/event_b2899454
// Params 1, eflags: 0x40
// Checksum 0xc0e435c4, Offset: 0x2868
// Size: 0x48
function event_handler[event_b2899454] function_47c92724(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_8a4a1aa6)) {
        [[ level.var_8a4a1aa6 ]](eventstruct.weapon);
    }
}

// Namespace callback/event_ad6ffd1f
// Params 1, eflags: 0x40
// Checksum 0xded495d7, Offset: 0x28b8
// Size: 0x48
function event_handler[event_ad6ffd1f] function_e59e98ef(eventstruct) {
    self endon(#"disconnect");
    if (isdefined(level.var_b6c73b45)) {
        [[ level.var_b6c73b45 ]](eventstruct.weapon);
    }
}

// Namespace callback/player_melee
// Params 1, eflags: 0x40
// Checksum 0x89c56e79, Offset: 0x2908
// Size: 0x8c
function event_handler[player_melee] codecallback_playermelee(eventstruct) {
    self endon(#"disconnect");
    [[ level.callbackplayermelee ]](eventstruct.attacker, eventstruct.amount, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.bone_index, eventstruct.is_shieldhit, eventstruct.is_frombehind);
}

// Namespace callback/actor_spawned
// Params 1, eflags: 0x40
// Checksum 0xeab0e57, Offset: 0x29a0
// Size: 0x28
function event_handler[actor_spawned] codecallback_actorspawned(eventstruct) {
    self [[ level.callbackactorspawned ]](eventstruct.entity);
}

// Namespace callback/actor_damage
// Params 1, eflags: 0x40
// Checksum 0xb60682de, Offset: 0x29d0
// Size: 0xcc
function event_handler[actor_damage] codecallback_actordamage(eventstruct) {
    [[ level.callbackactordamage ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.model_index, eventstruct.surface_type, eventstruct.normal);
}

// Namespace callback/actor_killed
// Params 1, eflags: 0x40
// Checksum 0x527ce41, Offset: 0x2aa8
// Size: 0x78
function event_handler[actor_killed] codecallback_actorkilled(eventstruct) {
    [[ level.callbackactorkilled ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset);
}

// Namespace callback/actor_cloned
// Params 1, eflags: 0x40
// Checksum 0x50001631, Offset: 0x2b28
// Size: 0x24
function event_handler[actor_cloned] codecallback_actorcloned(eventstruct) {
    [[ level.callbackactorcloned ]](eventstruct.clone);
}

// Namespace callback/event_524ce631
// Params 1, eflags: 0x40
// Checksum 0xa3015b3, Offset: 0x2b58
// Size: 0xd8
function event_handler[event_524ce631] function_e1b31f19(eventstruct) {
    [[ level.var_e66ba0a3 ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.model_index, eventstruct.part_name, eventstruct.surface_type, eventstruct.normal);
}

// Namespace callback/vehicle_spawned
// Params 1, eflags: 0x40
// Checksum 0x2c43e735, Offset: 0x2c38
// Size: 0x34
function event_handler[vehicle_spawned] codecallback_vehiclespawned(eventstruct) {
    if (isdefined(level.callbackvehiclespawned)) {
        [[ level.callbackvehiclespawned ]](eventstruct.spawner);
    }
}

// Namespace callback/vehicle_killed
// Params 1, eflags: 0x40
// Checksum 0x8f65bd32, Offset: 0x2c78
// Size: 0x78
function event_handler[vehicle_killed] codecallback_vehiclekilled(eventstruct) {
    [[ level.callbackvehiclekilled ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset);
}

// Namespace callback/vehicle_damage
// Params 1, eflags: 0x40
// Checksum 0xfe59b9af, Offset: 0x2cf8
// Size: 0xcc
function event_handler[vehicle_damage] codecallback_vehicledamage(eventstruct) {
    [[ level.callbackvehicledamage ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.damage_from_underneath, eventstruct.model_index, eventstruct.part_name, eventstruct.normal);
}

// Namespace callback/vehicle_radiusdamage
// Params 1, eflags: 0x40
// Checksum 0x51d766bf, Offset: 0x2dd0
// Size: 0xb4
function event_handler[vehicle_radiusdamage] codecallback_vehicleradiusdamage(eventstruct) {
    [[ level.callbackvehicleradiusdamage ]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.inner_damage, eventstruct.outer_damage, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.outer_radius, eventstruct.cone_angle, eventstruct.cone_direction, eventstruct.time_offset);
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x0
// Checksum 0xa45be9bd, Offset: 0x2e90
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
// Checksum 0x932b1f2e, Offset: 0x2f48
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
// Checksum 0xf801d66d, Offset: 0x2fc8
// Size: 0x1cc
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
// Checksum 0x62783c27, Offset: 0x31a0
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
// Checksum 0x1b76f23a, Offset: 0x3248
// Size: 0xa8
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
// Checksum 0x7a48718c, Offset: 0x32f8
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
// Checksum 0x8a639381, Offset: 0x33f8
// Size: 0xde
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
// Checksum 0x52f84f16, Offset: 0x34e0
// Size: 0xce
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

// Namespace callback/event_b7d4b6fe
// Params 1, eflags: 0x40
// Checksum 0x3175149d, Offset: 0x35b8
// Size: 0x10c
function event_handler[event_b7d4b6fe] function_123a8181(eventstruct) {
    origin = self.origin;
    magnitude = float(eventstruct.magnitude);
    innerradius = float(eventstruct.innerradius);
    outerradius = int(eventstruct.outerradius);
    innerdamage = isdefined(self.var_19a0c648) ? self.var_19a0c648 : 50;
    outerdamage = isdefined(self.var_83d92359) ? self.var_83d92359 : 25;
    physicsexplosionsphere(origin, outerradius, innerradius, magnitude, outerdamage, innerdamage);
}

// Namespace callback/sidemission_launch
// Params 1, eflags: 0x40
// Checksum 0xfb1ad2ae, Offset: 0x36d0
// Size: 0x9c
function event_handler[sidemission_launch] codecallback_launchsidemission(eventstruct) {
    switchmap_preload(eventstruct.name, eventstruct.game_type);
    luinotifyevent(#"open_side_mission_countdown", 1, eventstruct.list_index);
    wait 10;
    luinotifyevent(#"close_side_mission_countdown");
    switchmap_switch();
}

// Namespace callback/ui_fadeblackscreen
// Params 1, eflags: 0x40
// Checksum 0x37df21f0, Offset: 0x3778
// Size: 0x7c
function event_handler[ui_fadeblackscreen] codecallback_fadeblackscreen(eventstruct) {
    if (isplayer(self) && !isbot(self)) {
        self thread hud::fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend, eventstruct.blend);
    }
}

// Namespace callback/event_da91a4ae
// Params 1, eflags: 0x40
// Checksum 0xafbe3cf5, Offset: 0x3800
// Size: 0x7c
function event_handler[event_da91a4ae] function_9705378a(eventstruct) {
    if (isplayer(self) && !isbot(self)) {
        self thread hud::fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend_out, eventstruct.blend_in);
    }
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x0
// Checksum 0xc7c452d2, Offset: 0x3888
// Size: 0x224
function abort_level() {
    println("<dev string:x185>");
    level.callbackstartgametype = &callback_void;
    level.callbackplayerconnect = &callback_void;
    level.callbackplayerdisconnect = &callback_void;
    level.callbackplayerdamage = &callback_void;
    level.callbackplayerkilled = &callback_void;
    level.var_dcb50c4e = &callback_void;
    level.callbackplayerlaststand = &callback_void;
    level.var_d280b204 = &callback_void;
    level.callbackplayermelee = &callback_void;
    level.callbackactordamage = &callback_void;
    level.callbackactorkilled = &callback_void;
    level.var_e66ba0a3 = &callback_void;
    level.callbackvehicledamage = &callback_void;
    level.callbackvehiclekilled = &callback_void;
    level.callbackactorspawned = &callback_void;
    level.callbackbotentereduseredge = &callback_void;
    level.callbackbotcreateplayerbot = &callback_void;
    level.callbackbotshutdown = &callback_void;
    if (isdefined(level._gametype_default)) {
        setdvar(#"g_gametype", level._gametype_default);
    }
    exitlevel(0);
}

// Namespace callback/glass_smash
// Params 1, eflags: 0x40
// Checksum 0x3cc58cde, Offset: 0x3ab8
// Size: 0x58
function event_handler[glass_smash] codecallback_glasssmash(eventstruct) {
    level notify(#"glass_smash", {#position:eventstruct.position, #direction:eventstruct.direction});
}

// Namespace callback/freefall
// Params 1, eflags: 0x40
// Checksum 0x7c3c9459, Offset: 0x3b18
// Size: 0x2c
function event_handler[freefall] function_25fa193b(eventstruct) {
    self callback(#"freefall", eventstruct);
}

// Namespace callback/parachute
// Params 1, eflags: 0x40
// Checksum 0x32854b0, Offset: 0x3b50
// Size: 0x2c
function event_handler[parachute] function_ad5a594b(eventstruct) {
    self callback(#"parachute", eventstruct);
}

// Namespace callback/event_d10f98aa
// Params 1, eflags: 0x40
// Checksum 0xcfabfa28, Offset: 0x3b88
// Size: 0x2c
function event_handler[event_d10f98aa] function_5776d72d(eventstruct) {
    self callback(#"hash_42aa89b2a0951308", eventstruct);
}

// Namespace callback/event_844f91d8
// Params 1, eflags: 0x40
// Checksum 0x11815c4e, Offset: 0x3bc0
// Size: 0x5c
function event_handler[event_844f91d8] function_b0784568(eventstruct) {
    self endon(#"death");
    level flagsys::wait_till("system_init_complete");
    self callback(#"hash_1e4a4ca774f4ce22");
}

// Namespace callback/trigger
// Params 2, eflags: 0x40
// Checksum 0x728550a1, Offset: 0x3c28
// Size: 0xb4
function event_handler[trigger] codecallback_trigger(eventstruct, look_trigger = 0) {
    if (look_trigger || !trigger::is_look_trigger()) {
        self util::script_delay();
        self callback(#"on_trigger", eventstruct);
        self callback(#"on_trigger_once", eventstruct);
        self remove_on_trigger_once("all");
    }
}

// Namespace callback/entity_deleted
// Params 1, eflags: 0x40
// Checksum 0x2c1584f6, Offset: 0x3ce8
// Size: 0x2c
function event_handler[entity_deleted] codecallback_entitydeleted(eventstruct) {
    self callback(#"on_entity_deleted");
}

// Namespace callback/bot_enteruseredge
// Params 1, eflags: 0x40
// Checksum 0x983c8361, Offset: 0x3d20
// Size: 0x64
function event_handler[bot_enteruseredge] codecallback_botentereduseredge(eventstruct) {
    self [[ level.callbackbotentereduseredge ]](eventstruct.start_node, eventstruct.end_node, eventstruct.mantle_node, eventstruct.start_position, eventstruct.end_position, eventstruct.var_110d0d32);
}

// Namespace callback/bot_create_player_bot
// Params 1, eflags: 0x40
// Checksum 0xffb82b67, Offset: 0x3d90
// Size: 0x20
function event_handler[bot_create_player_bot] codecallback_botcreateplayerbot(eventstruct) {
    self [[ level.callbackbotcreateplayerbot ]]();
}

// Namespace callback/bot_stop_update
// Params 1, eflags: 0x40
// Checksum 0xd1a542fd, Offset: 0x3db8
// Size: 0x20
function event_handler[bot_stop_update] codecallback_botstopupdate(eventstruct) {
    self [[ level.callbackbotshutdown ]]();
}

// Namespace callback/voice_event
// Params 1, eflags: 0x40
// Checksum 0xd849e70f, Offset: 0x3de0
// Size: 0x34
function event_handler[voice_event] function_bbe7f8fc(eventstruct) {
    self voice_events::function_cd5f0529(eventstruct.event, eventstruct.params);
}

// Namespace callback/event_8e727982
// Params 1, eflags: 0x40
// Checksum 0x459585dc, Offset: 0x3e20
// Size: 0xa4
function event_handler[event_8e727982] function_bcf50330(eventstruct) {
    if (!isdefined(level.var_634a57d8)) {
        return;
    }
    /#
    #/
    eventdata = {};
    eventdata.tableindex = eventstruct.tableindex;
    eventdata.event_info = eventstruct.event_info;
    self [[ level.var_634a57d8 ]](eventstruct.event_name, eventstruct.time, eventstruct.client, eventstruct.priority, eventdata);
}

// Namespace callback/player_decoration
// Params 1, eflags: 0x40
// Checksum 0xa78bb0ef, Offset: 0x3ed0
// Size: 0x70
function event_handler[player_decoration] codecallback_decoration(eventstruct) {
    a_decorations = self getdecorations(1);
    if (!isdefined(a_decorations)) {
        return;
    }
    if (a_decorations.size == 12) {
    }
    level notify(#"decoration_awarded");
    [[ level.callbackdecorationawarded ]]();
}

// Namespace callback/event_ae2d59a
// Params 1, eflags: 0x40
// Checksum 0x48051bec, Offset: 0x3f48
// Size: 0x58
function event_handler[event_ae2d59a] function_667add1b(eventstruct) {
    if (isdefined(level.var_8ff021da)) {
        [[ level.var_8ff021da ]](eventstruct.player, eventstruct.eventtype, eventstruct.eventdata, eventstruct.var_d4bc02d7);
    }
}

// Namespace callback/detonate
// Params 1, eflags: 0x40
// Checksum 0x2ed7bb58, Offset: 0x3fa8
// Size: 0x2c
function event_handler[detonate] codecallback_detonate(eventstruct) {
    self callback(#"detonate", eventstruct);
}

// Namespace callback/doubletap_detonate
// Params 1, eflags: 0x40
// Checksum 0x307840b8, Offset: 0x3fe0
// Size: 0x2c
function event_handler[doubletap_detonate] function_e65e0c42(eventstruct) {
    self callback(#"doubletap_detonate", eventstruct);
}

// Namespace callback/death
// Params 1, eflags: 0x40
// Checksum 0x65992b31, Offset: 0x4018
// Size: 0x2c
function event_handler[death] codecallback_death(eventstruct) {
    self callback(#"death", eventstruct);
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x4050
// Size: 0x4
function callback_void() {
    
}

