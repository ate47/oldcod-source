#using scripts\core_common\activecamo_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace callback;

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x84caff24, Offset: 0x108
// Size: 0x12e
function callback(event, localclientnum, params) {
    if (isdefined(level._callbacks) && isdefined(level._callbacks[event])) {
        for (i = 0; i < level._callbacks[event].size; i++) {
            callback = level._callbacks[event][i][0];
            obj = level._callbacks[event][i][1];
            if (!isdefined(callback)) {
                continue;
            }
            if (isdefined(obj)) {
                if (isdefined(params)) {
                    obj thread [[ callback ]](localclientnum, self, params);
                } else {
                    obj thread [[ callback ]](localclientnum, self);
                }
                continue;
            }
            if (isdefined(params)) {
                self thread [[ callback ]](localclientnum, params);
                continue;
            }
            self thread [[ callback ]](localclientnum);
        }
    }
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x50ff8e52, Offset: 0x240
// Size: 0x11e
function entity_callback(event, localclientnum, params) {
    if (isdefined(self._callbacks) && isdefined(self._callbacks[event])) {
        for (i = 0; i < self._callbacks[event].size; i++) {
            callback = self._callbacks[event][i][0];
            obj = self._callbacks[event][i][1];
            if (!isdefined(callback)) {
                continue;
            }
            if (isdefined(obj)) {
                if (isdefined(params)) {
                    obj thread [[ callback ]](localclientnum, self, params);
                } else {
                    obj thread [[ callback ]](localclientnum, self);
                }
                continue;
            }
            if (isdefined(params)) {
                self thread [[ callback ]](localclientnum, params);
                continue;
            }
            self thread [[ callback ]](localclientnum);
        }
    }
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xfd2f5397, Offset: 0x368
// Size: 0x17c
function add_callback(event, func, obj) {
    assert(isdefined(event), "<dev string:x38>");
    if (!isdefined(level._callbacks) || !isdefined(level._callbacks[event])) {
        level._callbacks[event] = [];
    }
    foreach (callback in level._callbacks[event]) {
        if (callback[0] == func) {
            if (!isdefined(obj) || callback[1] == obj) {
                return;
            }
        }
    }
    array::add(level._callbacks[event], array(func, obj), 0);
    if (isdefined(obj)) {
        obj thread remove_callback_on_death(event, func);
    }
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x49da22a7, Offset: 0x4f0
// Size: 0x154
function add_entity_callback(event, func, obj) {
    assert(isdefined(event), "<dev string:x38>");
    if (!isdefined(self._callbacks) || !isdefined(self._callbacks[event])) {
        self._callbacks[event] = [];
    }
    foreach (callback in self._callbacks[event]) {
        if (callback[0] == func) {
            if (!isdefined(obj) || callback[1] == obj) {
                return;
            }
        }
    }
    array::add(self._callbacks[event], array(func, obj), 0);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x4aabfa5e, Offset: 0x650
// Size: 0x44
function remove_callback_on_death(event, func) {
    self waittill(#"death");
    remove_callback(event, func, self);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x7240c266, Offset: 0x6a0
// Size: 0x124
function function_52ac9652(event, func, obj) {
    assert(isdefined(event), "<dev string:x6b>");
    if (!isdefined(self._callbacks) || !isdefined(self._callbacks[event])) {
        return;
    }
    foreach (index, func_group in self._callbacks[event]) {
        if (func_group[0] == func) {
            if (func_group[1] === obj) {
                arrayremoveindex(self._callbacks[event], index, 0);
                break;
            }
        }
    }
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xb92965c9, Offset: 0x7d0
// Size: 0x12c
function remove_callback(event, func, obj) {
    assert(isdefined(event), "<dev string:x6b>");
    assert(isdefined(level._callbacks[event]), "<dev string:xa1>");
    foreach (index, func_group in level._callbacks[event]) {
        if (func_group[0] == func) {
            if (func_group[1] === obj) {
                arrayremoveindex(level._callbacks[event], index, 0);
                break;
            }
        }
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xbc90aa6c, Offset: 0x908
// Size: 0x3c
function on_localclient_connect(func, obj) {
    add_callback(#"on_localclient_connect", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x2c13cd7, Offset: 0x950
// Size: 0x3c
function on_localclient_shutdown(func, obj) {
    add_callback(#"on_localclient_shutdown", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xf3128592, Offset: 0x998
// Size: 0x3c
function on_finalize_initialization(func, obj) {
    add_callback(#"on_finalize_initialization", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xb26ac51a, Offset: 0x9e0
// Size: 0x3c
function on_gameplay_started(func, obj) {
    add_callback(#"on_gameplay_started", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x77b53010, Offset: 0xa28
// Size: 0x3c
function on_localplayer_spawned(func, obj) {
    add_callback(#"on_localplayer_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x97736c64, Offset: 0xa70
// Size: 0x3c
function remove_on_localplayer_spawned(func, obj) {
    remove_callback(#"on_localplayer_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xe0853001, Offset: 0xab8
// Size: 0x3c
function on_spawned(func, obj) {
    add_callback(#"on_player_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x393ea582, Offset: 0xb00
// Size: 0x3c
function remove_on_spawned(func, obj) {
    remove_callback(#"on_player_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xebd86c78, Offset: 0xb48
// Size: 0x3c
function function_675f0963(func, obj) {
    add_callback(#"hash_1fc6e31d0d02aa3", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x561a362b, Offset: 0xb90
// Size: 0x3c
function function_ce9bb4ec(func, obj) {
    remove_callback(#"hash_1fc6e31d0d02aa3", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x9fa980ab, Offset: 0xbd8
// Size: 0x3c
function on_vehicle_spawned(func, obj) {
    add_callback(#"on_vehicle_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x9b4526ff, Offset: 0xc20
// Size: 0x3c
function remove_on_vehicle_spawned(func, obj) {
    remove_callback(#"on_vehicle_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x1212091e, Offset: 0xc68
// Size: 0x3c
function on_laststand(func, obj) {
    add_callback(#"on_player_laststand", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x42ecb31c, Offset: 0xcb0
// Size: 0x3c
function remove_on_laststand(func, obj) {
    remove_callback(#"on_player_laststand", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x6852a043, Offset: 0xcf8
// Size: 0x3c
function on_player_corpse(func, obj) {
    add_callback(#"on_player_corpse", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x87c6dd2b, Offset: 0xd40
// Size: 0x3c
function function_930e5d42(func, obj) {
    add_callback(#"hash_781399e15b138a4e", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x67d665bb, Offset: 0xd88
// Size: 0x3c
function on_weapon_change(func, obj) {
    self add_entity_callback(#"weapon_change", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x2955f14d, Offset: 0xdd0
// Size: 0x3c
function on_ping(func, obj) {
    self add_entity_callback(#"on_ping", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x83903a0, Offset: 0xe18
// Size: 0x3c
function function_78827e7f(func, obj) {
    self add_entity_callback(#"hash_5768f5220f99ebd1", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x1b54d2e1, Offset: 0xe60
// Size: 0x3c
function function_6231c19(func, obj) {
    add_callback(#"weapon_change", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xd359eba5, Offset: 0xea8
// Size: 0x3c
function function_a880899e(func, obj) {
    self add_entity_callback(#"hash_42d524149523a1eb", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x3b77d7d2, Offset: 0xef0
// Size: 0x3c
function function_23694c6c(func, obj) {
    self add_entity_callback(#"hash_42d524149523a1eb", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xd4ee920, Offset: 0xf38
// Size: 0x3c
function on_deleted(func, obj) {
    add_callback(#"on_entity_deleted", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x2cc8fc13, Offset: 0xf80
// Size: 0x3c
function remove_on_deleted(func, obj) {
    remove_callback(#"on_entity_deleted", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x455d69eb, Offset: 0xfc8
// Size: 0x3c
function on_shutdown(func, obj) {
    add_entity_callback(#"on_entity_shutdown", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x789e1e57, Offset: 0x1010
// Size: 0x3c
function on_start_gametype(func, obj) {
    add_callback(#"on_start_gametype", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x28029b29, Offset: 0x1058
// Size: 0x3c
function on_end_game(func, obj) {
    add_callback(#"on_end_game", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x78c59ba9, Offset: 0x10a0
// Size: 0x3c
function remove_on_end_game(func, obj) {
    remove_callback(#"on_end_game", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x7f74d997, Offset: 0x10e8
// Size: 0x3c
function on_killcam_begin(func, obj) {
    add_callback(#"killcam_begin", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x16b9420a, Offset: 0x1130
// Size: 0x3c
function on_killcam_end(func, obj) {
    add_callback(#"killcam_end", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x9a38c9ff, Offset: 0x1178
// Size: 0x3c
function function_9fcd5f60(func, obj) {
    add_callback(#"hash_7a8be4f48b2d1cf6", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x557dbaec, Offset: 0x11c0
// Size: 0x3c
function on_melee(func, obj) {
    add_callback(#"melee", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa8dc9fd0, Offset: 0x1208
// Size: 0x3c
function on_trigger(func, obj) {
    add_entity_callback(#"on_trigger", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xaa622361, Offset: 0x1250
// Size: 0x3c
function remove_on_trigger(func, obj) {
    function_52ac9652(#"on_trigger", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xdd4a42dd, Offset: 0x1298
// Size: 0x3c
function on_trigger_once(func, obj) {
    add_entity_callback(#"on_trigger_once", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x6ea4c9e9, Offset: 0x12e0
// Size: 0x3c
function remove_on_trigger_once(func, obj) {
    function_52ac9652(#"on_trigger_once", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x9399b4d5, Offset: 0x1328
// Size: 0x3c
function function_2870abef(func, obj) {
    add_callback(#"hash_23660169f647c82b", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x4b2ad470, Offset: 0x1370
// Size: 0x3c
function function_b27200db(func, obj) {
    add_callback(#"hash_4bc6f7eaa57c10a7", func, obj);
}

// Namespace callback/level_preinit
// Params 1, eflags: 0x40
// Checksum 0xcbc064ea, Offset: 0x13b8
// Size: 0x1c
function event_handler[level_preinit] codecallback_preinitialization(*eventstruct) {
    system::run_pre_systems();
}

// Namespace callback/event_cc819519
// Params 1, eflags: 0x40
// Checksum 0x64107de, Offset: 0x13e0
// Size: 0x1c
function event_handler[event_cc819519] function_12c01a61(*eventstruct) {
    system::run_post_systems();
}

// Namespace callback/level_finalizeinit
// Params 1, eflags: 0x40
// Checksum 0xf6306483, Offset: 0x1408
// Size: 0x3c
function event_handler[level_finalizeinit] codecallback_finalizeinitialization(*eventstruct) {
    system::function_b1553822();
    callback(#"on_finalize_initialization");
}

// Namespace callback/systemstatechange
// Params 1, eflags: 0x40
// Checksum 0xe0d09437, Offset: 0x1450
// Size: 0x10c
function event_handler[systemstatechange] codecallback_statechange(eventstruct) {
    if (!isdefined(level._systemstates)) {
        level._systemstates = [];
    }
    if (!isdefined(level._systemstates[eventstruct.system])) {
        level._systemstates[eventstruct.system] = spawnstruct();
    }
    level._systemstates[eventstruct.system].state = eventstruct.state;
    if (isdefined(level._systemstates[eventstruct.system].callback)) {
        [[ level._systemstates[eventstruct.system].callback ]](eventstruct.localclientnum, eventstruct.state);
        return;
    }
    println("<dev string:xd1>" + eventstruct.system + "<dev string:x100>");
}

// Namespace callback/maprestart
// Params 1, eflags: 0x40
// Checksum 0x8d7d7aa8, Offset: 0x1568
// Size: 0x5c
function event_handler[maprestart] codecallback_maprestart(*eventstruct) {
    println("<dev string:x12b>");
    util::waitforclient(0);
    level thread util::init_utility();
}

// Namespace callback/localclient_connect
// Params 1, eflags: 0x40
// Checksum 0xa47da413, Offset: 0x15d0
// Size: 0x4c
function event_handler[localclient_connect] codecallback_localclientconnect(eventstruct) {
    println("<dev string:x150>" + eventstruct.localclientnum);
    [[ level.callbacklocalclientconnect ]](eventstruct.localclientnum);
}

/#

    // Namespace callback/glass_smash
    // Params 1, eflags: 0x40
    // Checksum 0xc0c00e8c, Offset: 0x1628
    // Size: 0x2c
    function event_handler[glass_smash] codecallback_glasssmash(*eventstruct) {
        println("<dev string:x180>");
    }

#/

// Namespace callback/sound_setambientstate
// Params 1, eflags: 0x40
// Checksum 0x689acd52, Offset: 0x1660
// Size: 0x44
function event_handler[sound_setambientstate] codecallback_soundsetambientstate(eventstruct) {
    audio::setcurrentambientstate(eventstruct.ambientroom, eventstruct.ambientpackage, eventstruct.roomcollider, eventstruct.packagecollider, eventstruct.is_defaultroom);
}

// Namespace callback/sound_setaiambientstate
// Params 1, eflags: 0x40
// Checksum 0x5aba6e2a, Offset: 0x16b0
// Size: 0xc
function event_handler[sound_setaiambientstate] codecallback_soundsetaiambientstate(*eventstruct) {
    
}

// Namespace callback/event_10eed35b
// Params 1, eflags: 0x40
// Checksum 0x96fc1707, Offset: 0x16c8
// Size: 0x50
function event_handler[event_10eed35b] function_d3771684(eventstruct) {
    if (!isdefined(level.var_44e74ef4)) {
        return;
    }
    println("<dev string:x1cb>");
    thread [[ level.var_44e74ef4 ]](eventstruct);
}

// Namespace callback/sound_playuidecodeloop
// Params 1, eflags: 0x40
// Checksum 0x7f02b62a, Offset: 0x1720
// Size: 0x34
function event_handler[sound_playuidecodeloop] codecallback_soundplayuidecodeloop(eventstruct) {
    self thread audio::soundplayuidecodeloop(eventstruct.decode_string, eventstruct.play_time_ms);
}

// Namespace callback/player_spawned
// Params 1, eflags: 0x40
// Checksum 0xbbbf5059, Offset: 0x1760
// Size: 0x24
function event_handler[player_spawned] codecallback_playerspawned(eventstruct) {
    [[ level.callbackplayerspawned ]](eventstruct.localclientnum);
}

// Namespace callback/player_laststand
// Params 1, eflags: 0x40
// Checksum 0x2ac16663, Offset: 0x1790
// Size: 0x24
function event_handler[player_laststand] codecallback_playerlaststand(eventstruct) {
    [[ level.callbackplayerlaststand ]](eventstruct.localclientnum);
}

// Namespace callback/event_d6f9e6ad
// Params 1, eflags: 0x40
// Checksum 0xa7cf27c4, Offset: 0x17c0
// Size: 0x54
function event_handler[event_d6f9e6ad] function_c1d1f779(eventstruct) {
    if (!isdefined(level.var_c3e66138)) {
        return;
    }
    println("<dev string:x1fb>");
    thread [[ level.var_c3e66138 ]](eventstruct.var_428d0be2);
}

// Namespace callback/event_e469e10d
// Params 1, eflags: 0x40
// Checksum 0xe5f7a3fa, Offset: 0x1820
// Size: 0x34
function event_handler[event_e469e10d] function_cfcbacb1(eventstruct) {
    if (isdefined(level.var_beec2b1)) {
        [[ level.var_beec2b1 ]](eventstruct.localclientnum);
    }
}

// Namespace callback/event_dd67c1a8
// Params 1, eflags: 0x40
// Checksum 0xf447daf6, Offset: 0x1860
// Size: 0x40
function event_handler[event_dd67c1a8] function_46c0443b(eventstruct) {
    if (isdefined(level.var_c442de72)) {
        [[ level.var_c442de72 ]](self, eventstruct.localclientnum, eventstruct.weapon);
    }
}

// Namespace callback/entity_gibevent
// Params 1, eflags: 0x40
// Checksum 0xc9f3009e, Offset: 0x18a8
// Size: 0x48
function event_handler[entity_gibevent] codecallback_gibevent(eventstruct) {
    if (isdefined(level._gibeventcbfunc)) {
        self thread [[ level._gibeventcbfunc ]](eventstruct.localclientnum, eventstruct.type, eventstruct.locations);
    }
}

// Namespace callback/gametype_precache
// Params 1, eflags: 0x40
// Checksum 0xd7fdf4b1, Offset: 0x18f8
// Size: 0x2c
function event_handler[gametype_precache] codecallback_precachegametype(*eventstruct) {
    if (isdefined(level.callbackprecachegametype)) {
        [[ level.callbackprecachegametype ]]();
    }
}

// Namespace callback/gametype_start
// Params 1, eflags: 0x40
// Checksum 0x9a63359c, Offset: 0x1930
// Size: 0x60
function event_handler[gametype_start] codecallback_startgametype(*eventstruct) {
    if (isdefined(level.callbackstartgametype) && (!isdefined(level.gametypestarted) || !level.gametypestarted)) {
        [[ level.callbackstartgametype ]]();
        level.gametypestarted = 1;
    }
}

// Namespace callback/entity_spawned
// Params 1, eflags: 0x40
// Checksum 0x3fa66fda, Offset: 0x1998
// Size: 0x24
function event_handler[entity_spawned] codecallback_entityspawned(eventstruct) {
    [[ level.callbackentityspawned ]](eventstruct.localclientnum);
}

// Namespace callback/enter_vehicle
// Params 1, eflags: 0x40
// Checksum 0xb142305c, Offset: 0x19c8
// Size: 0xa8
function event_handler[enter_vehicle] codecallback_entervehicle(eventstruct) {
    if (isplayer(self)) {
        if (isdefined(level.var_69b47c50)) {
            self [[ level.var_69b47c50 ]](eventstruct.localclientnum, eventstruct.vehicle);
        }
        return;
    }
    if (self isvehicle()) {
        if (isdefined(level.var_93b40f07)) {
            self [[ level.var_93b40f07 ]](eventstruct.localclientnum, eventstruct.player);
        }
    }
}

// Namespace callback/exit_vehicle
// Params 1, eflags: 0x40
// Checksum 0x74e3f36f, Offset: 0x1a78
// Size: 0xa8
function event_handler[exit_vehicle] codecallback_exitvehicle(eventstruct) {
    if (isplayer(self)) {
        if (isdefined(level.var_db2ec524)) {
            self [[ level.var_db2ec524 ]](eventstruct.localclientnum, eventstruct.vehicle);
        }
        return;
    }
    if (self isvehicle()) {
        if (isdefined(level.var_d4d60480)) {
            self [[ level.var_d4d60480 ]](eventstruct.localclientnum, eventstruct.player);
        }
    }
}

// Namespace callback/sound_notify
// Params 1, eflags: 0x40
// Checksum 0x8e3ab2e7, Offset: 0x1b28
// Size: 0x8a
function event_handler[sound_notify] codecallback_soundnotify(eventstruct) {
    switch (eventstruct.notetrack) {
    case #"scr_bomb_beep":
        if (getgametypesetting(#"silentplant") == 0) {
            self playsound(eventstruct.localclientnum, #"fly_bomb_buttons_npc");
        }
        break;
    }
}

// Namespace callback/entity_shutdown
// Params 1, eflags: 0x40
// Checksum 0xbb03c848, Offset: 0x1bc0
// Size: 0x6c
function event_handler[entity_shutdown] codecallback_entityshutdown(eventstruct) {
    if (isdefined(level.callbackentityshutdown)) {
        [[ level.callbackentityshutdown ]](eventstruct.localclientnum, eventstruct.entity);
    }
    eventstruct.entity entity_callback(#"on_entity_shutdown", eventstruct.localclientnum);
}

// Namespace callback/localclient_shutdown
// Params 1, eflags: 0x40
// Checksum 0xf7c1b925, Offset: 0x1c38
// Size: 0x54
function event_handler[localclient_shutdown] codecallback_localclientshutdown(eventstruct) {
    level.localplayers = getlocalplayers();
    eventstruct.entity callback(#"on_localclient_shutdown", eventstruct.localclientnum);
}

// Namespace callback/localclient_changed
// Params 1, eflags: 0x40
// Checksum 0xfd39cf50, Offset: 0x1c98
// Size: 0x24
function event_handler[localclient_changed] codecallback_localclientchanged(*eventstruct) {
    level.localplayers = getlocalplayers();
}

// Namespace callback/player_airsupport
// Params 1, eflags: 0x40
// Checksum 0x9ccc251d, Offset: 0x1cc8
// Size: 0xa0
function event_handler[player_airsupport] codecallback_airsupport(eventstruct) {
    if (isdefined(level.callbackairsupport)) {
        [[ level.callbackairsupport ]](eventstruct.localclientnum, eventstruct.location[0], eventstruct.location[1], eventstruct.location[2], eventstruct.type, eventstruct.yaw, eventstruct.team, eventstruct.team_faction, eventstruct.owner, eventstruct.exit_type, eventstruct.server_time, eventstruct.height);
    }
}

// Namespace callback/demosystem_jump
// Params 1, eflags: 0x40
// Checksum 0x9eb00caa, Offset: 0x1d70
// Size: 0x72
function event_handler[demosystem_jump] codecallback_demojump(eventstruct) {
    level notify(#"demo_jump", {#time:eventstruct.time});
    level notify("demo_jump" + eventstruct.localclientnum, {#time:eventstruct.time});
}

// Namespace callback/callbacks_shared
// Params 1, eflags: 0x0
// Checksum 0x4fde537e, Offset: 0x1df0
// Size: 0x36
function codecallback_demoplayerswitch(localclientnum) {
    level notify(#"demo_player_switch");
    level notify("demo_player_switch" + localclientnum);
}

// Namespace callback/player_switch
// Params 1, eflags: 0x40
// Checksum 0x1e9e5568, Offset: 0x1e30
// Size: 0x3a
function event_handler[player_switch] codecallback_playerswitch(eventstruct) {
    level notify(#"player_switch");
    level notify("player_switch" + eventstruct.localclientnum);
}

// Namespace callback/killcam_begin
// Params 1, eflags: 0x40
// Checksum 0x3b4e5e19, Offset: 0x1e78
// Size: 0x94
function event_handler[killcam_begin] codecallback_killcambegin(eventstruct) {
    level notify(#"killcam_begin", {#time:eventstruct.time});
    level notify("killcam_begin" + eventstruct.localclientnum, {#time:eventstruct.time});
    level callback(#"killcam_begin", eventstruct);
}

// Namespace callback/killcam_end
// Params 1, eflags: 0x40
// Checksum 0x4e5f590c, Offset: 0x1f18
// Size: 0x94
function event_handler[killcam_end] codecallback_killcamend(eventstruct) {
    level notify(#"killcam_end", {#time:eventstruct.time});
    level notify("killcam_end" + eventstruct.localclientnum, {#time:eventstruct.time});
    level callback(#"killcam_end", eventstruct);
}

// Namespace callback/event_b1c5e32
// Params 1, eflags: 0x40
// Checksum 0xbd639510, Offset: 0x1fb8
// Size: 0x2c
function event_handler[event_b1c5e32] function_d6a509f1(eventstruct) {
    level callback(#"hash_7a8be4f48b2d1cf6", eventstruct);
}

// Namespace callback/player_corpse
// Params 1, eflags: 0x40
// Checksum 0x47178e17, Offset: 0x1ff0
// Size: 0x3c
function event_handler[player_corpse] codecallback_creatingcorpse(eventstruct) {
    if (isdefined(level.callbackcreatingcorpse)) {
        [[ level.callbackcreatingcorpse ]](eventstruct.localclientnum, eventstruct.player);
    }
}

// Namespace callback/exploder_activate
// Params 1, eflags: 0x40
// Checksum 0x855ed3dc, Offset: 0x2038
// Size: 0xdc
function event_handler[exploder_activate] codecallback_activateexploder(eventstruct) {
    if (!isdefined(level._exploder_ids)) {
        return;
    }
    exploder = undefined;
    foreach (k, v in level._exploder_ids) {
        if (v == eventstruct.exploder_id) {
            exploder = k;
            break;
        }
    }
    if (!isdefined(exploder)) {
        return;
    }
    exploder::activate_exploder(exploder);
}

// Namespace callback/exploder_deactivate
// Params 1, eflags: 0x40
// Checksum 0x60dba96, Offset: 0x2120
// Size: 0xdc
function event_handler[exploder_deactivate] codecallback_deactivateexploder(eventstruct) {
    if (!isdefined(level._exploder_ids)) {
        return;
    }
    exploder = undefined;
    foreach (k, v in level._exploder_ids) {
        if (v == eventstruct.exploder_id) {
            exploder = k;
            break;
        }
    }
    if (!isdefined(exploder)) {
        return;
    }
    exploder::stop_exploder(exploder);
}

// Namespace callback/sound_chargeshotweaponnotify
// Params 1, eflags: 0x40
// Checksum 0xe6c20bfc, Offset: 0x2208
// Size: 0x48
function event_handler[sound_chargeshotweaponnotify] codecallback_chargeshotweaponsoundnotify(eventstruct) {
    if (isdefined(level.sndchargeshot_func)) {
        self [[ level.sndchargeshot_func ]](eventstruct.localclientnum, eventstruct.weapon, eventstruct.chargeshotlevel);
    }
}

// Namespace callback/hostmigration
// Params 1, eflags: 0x40
// Checksum 0xe49512c3, Offset: 0x2258
// Size: 0x54
function event_handler[hostmigration] codecallback_hostmigration(eventstruct) {
    println("<dev string:x225>");
    if (isdefined(level.callbackhostmigration)) {
        [[ level.callbackhostmigration ]](eventstruct.localclientnum);
    }
}

// Namespace callback/entity_footstep
// Params 1, eflags: 0x40
// Checksum 0xd01faa5c, Offset: 0x22b8
// Size: 0x44
function event_handler[entity_footstep] codecallback_playaifootstep(eventstruct) {
    [[ level.callbackplayaifootstep ]](eventstruct.localclientnum, eventstruct.location, eventstruct.surface, eventstruct.notetrack, eventstruct.bone);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x0
// Checksum 0x48f809dd, Offset: 0x2308
// Size: 0x44
function codecallback_clientflag(localclientnum, flag, set) {
    if (isdefined(level.callbackclientflag)) {
        [[ level.callbackclientflag ]](localclientnum, flag, set);
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x8978cf85, Offset: 0x2358
// Size: 0x5e
function codecallback_clientflagasval(localclientnum, val) {
    if (isdefined(level._client_flagasval_callbacks) && isdefined(level._client_flagasval_callbacks[self.type])) {
        self thread [[ level._client_flagasval_callbacks[self.type] ]](localclientnum, val);
    }
}

// Namespace callback/event_3cbeb
// Params 1, eflags: 0x40
// Checksum 0xd084264c, Offset: 0x23c0
// Size: 0x74
function event_handler[event_3cbeb] function_327732bf(eventstruct) {
    if (isdefined(level.var_dda8e1d8)) {
        [[ level.var_dda8e1d8 ]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.character_index, eventstruct.outfit_index, eventstruct.item_type, eventstruct.item_index, eventstruct.is_defaultrender);
    }
}

// Namespace callback/extracam_wcpaintjobicon
// Params 1, eflags: 0x40
// Checksum 0x2e3de04c, Offset: 0x2440
// Size: 0x6c
function event_handler[extracam_wcpaintjobicon] codecallback_extracamrenderwcpaintjobicon(eventstruct) {
    if (isdefined(level.extra_cam_render_wc_paintjobicon_func_callback)) {
        [[ level.extra_cam_render_wc_paintjobicon_func_callback ]](eventstruct.localclientnum, eventstruct.extracam_index, eventstruct.job_index, eventstruct.weapon_options, eventstruct.weapon, eventstruct.loadout_slot, eventstruct.paintjob_slot, eventstruct.is_fileshare_preview);
    }
}

// Namespace callback/extracam_wcvarianticon
// Params 1, eflags: 0x40
// Checksum 0xd1e8f36, Offset: 0x24b8
// Size: 0x6c
function event_handler[extracam_wcvarianticon] codecallback_extracamrenderwcvarianticon(eventstruct) {
    if (isdefined(level.extra_cam_render_wc_varianticon_func_callback)) {
        [[ level.extra_cam_render_wc_varianticon_func_callback ]](eventstruct.localclientnum, eventstruct.extracam_index, eventstruct.job_index, eventstruct.weapon_options, eventstruct.weapon, eventstruct.loadout_slot, eventstruct.paintjob_slot, eventstruct.is_fileshare_preview);
    }
}

// Namespace callback/collectibles_changed
// Params 1, eflags: 0x40
// Checksum 0xefa2397f, Offset: 0x2530
// Size: 0x44
function event_handler[collectibles_changed] codecallback_collectibleschanged(eventstruct) {
    if (isdefined(level.on_collectibles_change)) {
        [[ level.on_collectibles_change ]](eventstruct.clientnum, eventstruct.collectibles, eventstruct.localclientnum);
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xceb71741, Offset: 0x2580
// Size: 0x54
function add_weapon_type(weapontype, callback) {
    if (!isdefined(level.weapon_type_callback_array)) {
        level.weapon_type_callback_array = [];
    }
    weapontype = getweapon(weapontype);
    level.weapon_type_callback_array[weapontype] = callback;
}

// Namespace callback/callbacks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xd659eabb, Offset: 0x25e0
// Size: 0x66
function spawned_weapon_type(localclientnum) {
    weapontype = self.weapon.rootweapon;
    if (isdefined(level.weapon_type_callback_array) && isdefined(level.weapon_type_callback_array[weapontype])) {
        self thread [[ level.weapon_type_callback_array[weapontype] ]](localclientnum);
    }
}

// Namespace callback/callbacks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xa73ddf8d, Offset: 0x2650
// Size: 0x24
function function_cbfd8fd6(localclientnum) {
    activecamo::function_cbfd8fd6(localclientnum);
}

// Namespace callback/notetrack_callclientscript
// Params 1, eflags: 0x40
// Checksum 0x43489d53, Offset: 0x2680
// Size: 0xba
function event_handler[notetrack_callclientscript] codecallback_callclientscript(eventstruct) {
    if (!isdefined(level._animnotifyfuncs)) {
        return;
    }
    if (isdefined(level._animnotifyfuncs[eventstruct.label])) {
        if (isdefined(eventstruct.param3) && eventstruct.param3 != "") {
            self [[ level._animnotifyfuncs[eventstruct.label] ]](eventstruct.param, eventstruct.param3);
            return;
        }
        self [[ level._animnotifyfuncs[eventstruct.label] ]](eventstruct.param);
    }
}

// Namespace callback/notetrack_callclientscriptonlevel
// Params 1, eflags: 0x40
// Checksum 0x545e0a78, Offset: 0x2748
// Size: 0xba
function event_handler[notetrack_callclientscriptonlevel] codecallback_callclientscriptonlevel(eventstruct) {
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
// Checksum 0x61e43da9, Offset: 0x2810
// Size: 0x164
function event_handler[event_69572c01] function_2073f6dc(eventstruct) {
    origin = self.origin;
    magnitude = float(eventstruct.magnitude);
    innerradius = float(eventstruct.innerradius);
    outerradius = float(eventstruct.outerradius);
    innerdamage = isdefined(self.var_f501d778) ? self.var_f501d778 : 50;
    outerdamage = isdefined(self.var_e14c1b5c) ? self.var_e14c1b5c : 25;
    var_a62fd3ab = isdefined(self.var_abe3f153) ? self.var_abe3f153 : 1;
    var_c1cde02b = isdefined(self.var_bd0f9401) ? self.var_bd0f9401 : 1;
    physicsexplosionsphere(eventstruct.localclientnum, origin, outerradius, innerradius, magnitude, innerdamage, outerdamage, var_a62fd3ab, var_c1cde02b);
}

// Namespace callback/scene_init
// Params 1, eflags: 0x40
// Checksum 0xa3040e87, Offset: 0x2980
// Size: 0x44
function event_handler[scene_init] codecallback_serversceneinit(eventstruct) {
    if (isdefined(level.server_scenes[eventstruct.scene_name])) {
        level thread scene::init(eventstruct.scene_name);
    }
}

// Namespace callback/scene_play
// Params 1, eflags: 0x40
// Checksum 0x99fd3aec, Offset: 0x29d0
// Size: 0x5c
function event_handler[scene_play] codecallback_serversceneplay(eventstruct) {
    level thread scene_black_screen();
    if (isdefined(level.server_scenes[eventstruct.scene_name])) {
        level thread scene::play(eventstruct.scene_name);
    }
}

// Namespace callback/scene_stop
// Params 1, eflags: 0x40
// Checksum 0x31a5f423, Offset: 0x2a38
// Size: 0x64
function event_handler[scene_stop] codecallback_serverscenestop(eventstruct) {
    level thread scene_black_screen();
    if (isdefined(level.server_scenes[eventstruct.scene_name])) {
        level thread scene::stop(eventstruct.scene_name, undefined, undefined, undefined, 1);
    }
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xff3aa127, Offset: 0x2aa8
// Size: 0x100
function scene_black_screen() {
    foreach (i, player in level.localplayers) {
        player lui::screen_fade_out(0);
    }
    waitframe(1);
    foreach (player in level.localplayers) {
        player lui::screen_fade_in(0);
    }
}

// Namespace callback/gadget_visionpulsereveal
// Params 1, eflags: 0x40
// Checksum 0x9cd267dd, Offset: 0x2bb0
// Size: 0x44
function event_handler[gadget_visionpulsereveal] codecallback_gadgetvisionpulse_reveal(eventstruct) {
    if (isdefined(level.gadgetvisionpulse_reveal_func)) {
        eventstruct.entity [[ level.gadgetvisionpulse_reveal_func ]](eventstruct.localclientnum, eventstruct.enable);
    }
}

// Namespace callback/callbacks_shared
// Params 5, eflags: 0x5 linked
// Checksum 0xc24db4d0, Offset: 0x2c00
// Size: 0x8c
function private fade_to_black_for_x_sec(startwait, blackscreenwait, fadeintime, fadeouttime, var_79f400ae) {
    self endon(#"disconnect");
    wait startwait;
    self lui::screen_fade_out(fadeintime, var_79f400ae);
    wait blackscreenwait;
    if (isdefined(self)) {
        self lui::screen_fade_in(fadeouttime, var_79f400ae);
    }
}

// Namespace callback/ui_fadeblackscreen
// Params 1, eflags: 0x40
// Checksum 0x5506d62a, Offset: 0x2c98
// Size: 0x8c
function event_handler[ui_fadeblackscreen] codecallback_fadeblackscreen(eventstruct) {
    if (isdefined(self) && isplayer(self) && !isbot(self) && self function_21c0fa55()) {
        self thread fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend, eventstruct.blend);
    }
}

// Namespace callback/event_40f83b44
// Params 1, eflags: 0x40
// Checksum 0x5cce1635, Offset: 0x2d30
// Size: 0x8c
function event_handler[event_40f83b44] function_4b5ab05f(eventstruct) {
    if (isdefined(self) && isplayer(self) && !isbot(self) && self function_21c0fa55()) {
        self thread fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend_out, eventstruct.blend_in);
    }
}

// Namespace callback/event_1f757215
// Params 1, eflags: 0x40
// Checksum 0x143bdc8, Offset: 0x2dc8
// Size: 0x44
function event_handler[event_1f757215] function_5067ee2f(eventstruct) {
    self animation::play_siege(eventstruct.anim_name, eventstruct.shot_name, eventstruct.rate, eventstruct.loop);
}

// Namespace callback/forcestreambundle
// Params 1, eflags: 0x40
// Checksum 0x271d2fa2, Offset: 0x2e18
// Size: 0x34
function event_handler[forcestreambundle] codecallback_forcestreambundle(eventstruct) {
    forcestreambundle(eventstruct.name, eventstruct.var_3c542760, eventstruct.var_a0e51075);
}

// Namespace callback/event_bfc28859
// Params 1, eflags: 0x40
// Checksum 0xc3079975, Offset: 0x2e58
// Size: 0x54
function event_handler[event_bfc28859] function_582e112f(eventstruct) {
    if (isdefined(level.var_45ca79e5)) {
        [[ level.var_45ca79e5 ]](eventstruct.localclientnum, eventstruct.eventtype, eventstruct.itemid, eventstruct.value, eventstruct.value2);
    }
}

// Namespace callback/event_a5e70678
// Params 1, eflags: 0x40
// Checksum 0x33840c59, Offset: 0x2eb8
// Size: 0x34
function event_handler[event_a5e70678] function_11988454(eventstruct) {
    if (isdefined(level.var_a6c75fcb)) {
        [[ level.var_a6c75fcb ]](eventstruct.var_85604f16);
    }
}

// Namespace callback/trigger
// Params 1, eflags: 0x40
// Checksum 0xeb45e2e4, Offset: 0x2ef8
// Size: 0x7c
function event_handler[trigger] codecallback_trigger(eventstruct) {
    if (isdefined(level.var_a6c75fcb)) {
        self callback(#"on_trigger", eventstruct);
        self callback(#"on_trigger_once", eventstruct);
        self remove_on_trigger_once("all");
    }
}

// Namespace callback/entity_deleted
// Params 1, eflags: 0x40
// Checksum 0xe9814722, Offset: 0x2f80
// Size: 0x2c
function event_handler[entity_deleted] codecallback_entitydeleted(*eventstruct) {
    self callback(#"on_entity_deleted");
}

// Namespace callback/freefall
// Params 1, eflags: 0x40
// Checksum 0xb458200d, Offset: 0x2fb8
// Size: 0x5c
function event_handler[freefall] function_5019e563(eventstruct) {
    self callback(#"freefall", eventstruct);
    self entity_callback(#"freefall", eventstruct.localclientnum, eventstruct);
}

// Namespace callback/parachute
// Params 1, eflags: 0x40
// Checksum 0xffd1fcdb, Offset: 0x3020
// Size: 0x5c
function event_handler[parachute] function_87b05fa3(eventstruct) {
    self callback(#"parachute", eventstruct);
    self entity_callback(#"parachute", eventstruct.localclientnum, eventstruct);
}

// Namespace callback/death
// Params 1, eflags: 0x40
// Checksum 0x47606442, Offset: 0x3088
// Size: 0x44
function event_handler[death] codecallback_death(eventstruct) {
    self notify(#"death", eventstruct);
    self entity_callback(#"death", eventstruct);
}

// Namespace callback/melee
// Params 1, eflags: 0x40
// Checksum 0x8a924ffb, Offset: 0x30d8
// Size: 0x2c
function event_handler[melee] codecallback_melee(eventstruct) {
    self callback(#"melee", eventstruct);
}

// Namespace callback/culled
// Params 1, eflags: 0x40
// Checksum 0x54473df0, Offset: 0x3110
// Size: 0x2c
function event_handler[culled] function_667f84de(eventstruct) {
    self entity_callback(#"culled", eventstruct);
}

// Namespace callback/weapon_change
// Params 1, eflags: 0x40
// Checksum 0x2fb364bc, Offset: 0x3148
// Size: 0x6c
function event_handler[weapon_change] function_6846a2b7(eventstruct) {
    if (self function_21c0fa55()) {
        level callback(#"weapon_change", eventstruct);
    }
    self callback(#"weapon_change", eventstruct);
}

// Namespace callback/event_41480c76
// Params 1, eflags: 0x40
// Checksum 0x83c5dacf, Offset: 0x31c0
// Size: 0x6c
function event_handler[event_41480c76] function_c33f3471(eventstruct) {
    if (self function_21c0fa55()) {
        level callback(#"hash_4152cf6a61494581", eventstruct);
    }
    self callback(#"hash_4152cf6a61494581", eventstruct);
}

// Namespace callback/event_6e84b1b1
// Params 1, eflags: 0x40
// Checksum 0x1a4c88f8, Offset: 0x3238
// Size: 0x2c
function event_handler[event_6e84b1b1] function_ff9acfac(eventstruct) {
    level callback(#"hash_2fc4cfecaed47583", eventstruct);
}

// Namespace callback/event_2a48d8d7
// Params 1, eflags: 0x40
// Checksum 0x720fd09e, Offset: 0x3270
// Size: 0x2c
function event_handler[event_2a48d8d7] function_c0a2fad1(eventstruct) {
    self callback(#"hash_42d524149523a1eb", eventstruct);
}

// Namespace callback/event_4e1fa07c
// Params 1, eflags: 0x40
// Checksum 0xd56c821f, Offset: 0x32a8
// Size: 0x6c
function event_handler[event_4e1fa07c] function_5ea431f0(eventstruct) {
    if (self function_21c0fa55()) {
        level callback(#"hash_42d524149523a1eb", eventstruct);
    }
    self callback(#"hash_42d524149523a1eb", eventstruct);
}

// Namespace callback/updateactivecamo
// Params 1, eflags: 0x40
// Checksum 0xec42b159, Offset: 0x3320
// Size: 0x3c
function event_handler[updateactivecamo] codecallback_updateactivecamo(eventstruct) {
    self callback(#"updateactivecamo", eventstruct.localclientnum, eventstruct);
}

// Namespace callback/event_ab7a7fd3
// Params 1, eflags: 0x40
// Checksum 0x32b92286, Offset: 0x3368
// Size: 0x2c
function event_handler[event_ab7a7fd3] function_bc70e1e4(eventstruct) {
    self callback(#"hash_6900f4ea0ff32c3e", eventstruct);
}

// Namespace callback/ping
// Params 1, eflags: 0x40
// Checksum 0x85892882, Offset: 0x33a0
// Size: 0x2c
function event_handler[ping] function_87cf247e(eventstruct) {
    self callback(#"on_ping", eventstruct);
}

// Namespace callback/event_7fdec554
// Params 1, eflags: 0x40
// Checksum 0x7df4b0fe, Offset: 0x33d8
// Size: 0x2c
function event_handler[event_7fdec554] function_45d8e443(eventstruct) {
    self callback(#"hash_5768f5220f99ebd1", eventstruct);
}

// Namespace callback/event_e9d1ea42
// Params 1, eflags: 0x40
// Checksum 0x282f9832, Offset: 0x3410
// Size: 0x2c
function event_handler[event_e9d1ea42] function_84c7f7d4(eventstruct) {
    self callback(#"hash_23660169f647c82b", eventstruct);
}

// Namespace callback/event_43452705
// Params 1, eflags: 0x40
// Checksum 0xf36e8b5b, Offset: 0x3448
// Size: 0x2c
function event_handler[event_43452705] function_fcc3f82c(eventstruct) {
    self callback(#"hash_4bc6f7eaa57c10a7", eventstruct);
}

// Namespace callback/callbacks_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x16a59898, Offset: 0x3480
// Size: 0xbc
function callback_stunned(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self.stunned = bwastimejump;
    println("<dev string:x252>");
    if (bwastimejump) {
        self notify(#"stunned");
    } else {
        self notify(#"not_stunned");
    }
    if (isdefined(self.stunnedcallback)) {
        self [[ self.stunnedcallback ]](fieldname, bwastimejump);
    }
}

