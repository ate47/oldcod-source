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
// Params 3, eflags: 0x0
// Checksum 0xb9177500, Offset: 0x108
// Size: 0x144
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
// Params 3, eflags: 0x0
// Checksum 0x931679a7, Offset: 0x258
// Size: 0x134
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
// Params 3, eflags: 0x0
// Checksum 0x2d32f136, Offset: 0x398
// Size: 0x17c
function add_callback(event, func, obj) {
    assert(isdefined(event), "<dev string:x30>");
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
// Params 3, eflags: 0x0
// Checksum 0x4f94e42d, Offset: 0x520
// Size: 0x14c
function add_entity_callback(event, func, obj) {
    assert(isdefined(event), "<dev string:x30>");
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
// Params 2, eflags: 0x0
// Checksum 0xd49a26a8, Offset: 0x678
// Size: 0x44
function remove_callback_on_death(event, func) {
    self waittill(#"death");
    remove_callback(event, func, self);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x0
// Checksum 0x48872ed6, Offset: 0x6c8
// Size: 0x104
function function_1f42556c(event, func, obj) {
    assert(isdefined(event), "<dev string:x60>");
    if (!isdefined(self._callbacks)) {
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
// Params 3, eflags: 0x0
// Checksum 0x7b02baa5, Offset: 0x7d8
// Size: 0x12c
function remove_callback(event, func, obj) {
    assert(isdefined(event), "<dev string:x60>");
    assert(isdefined(level._callbacks[event]), "<dev string:x93>");
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
// Params 2, eflags: 0x0
// Checksum 0x3706b73c, Offset: 0x910
// Size: 0x3c
function on_localclient_connect(func, obj) {
    add_callback(#"on_localclient_connect", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb425cf92, Offset: 0x958
// Size: 0x3c
function on_localclient_shutdown(func, obj) {
    add_callback(#"on_localclient_shutdown", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x1c6edd01, Offset: 0x9a0
// Size: 0x3c
function on_finalize_initialization(func, obj) {
    add_callback(#"on_finalize_initialization", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xde40c1b2, Offset: 0x9e8
// Size: 0x3c
function on_gameplay_started(func, obj) {
    add_callback(#"on_gameplay_started", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xf80f9cbe, Offset: 0xa30
// Size: 0x3c
function on_localplayer_spawned(func, obj) {
    add_callback(#"on_localplayer_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x77dfa107, Offset: 0xa78
// Size: 0x3c
function remove_on_localplayer_spawned(func, obj) {
    remove_callback(#"on_localplayer_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x703750e5, Offset: 0xac0
// Size: 0x3c
function on_spawned(func, obj) {
    add_callback(#"on_player_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7512d6ad, Offset: 0xb08
// Size: 0x3c
function remove_on_spawned(func, obj) {
    remove_callback(#"on_player_spawned", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa4ffeca8, Offset: 0xb50
// Size: 0x3c
function on_laststand(func, obj) {
    add_callback(#"on_player_laststand", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xe721fc4f, Offset: 0xb98
// Size: 0x3c
function remove_on_laststand(func, obj) {
    remove_callback(#"on_player_laststand", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x81b3d9f7, Offset: 0xbe0
// Size: 0x3c
function on_player_corpse(func, obj) {
    add_callback(#"on_player_corpse", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x153d443b, Offset: 0xc28
// Size: 0x3c
function function_948e38c4(func, obj) {
    add_callback(#"hash_781399e15b138a4e", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xe887fb47, Offset: 0xc70
// Size: 0x3c
function on_weapon_change(func, obj) {
    self add_entity_callback(#"weapon_change", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x78453d52, Offset: 0xcb8
// Size: 0x3c
function function_c2d859ed(func, obj) {
    add_callback(#"weapon_change", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xa56fa38e, Offset: 0xd00
// Size: 0x3c
function on_deleted(func, obj) {
    add_callback(#"on_entity_deleted", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xb327935f, Offset: 0xd48
// Size: 0x3c
function remove_on_deleted(func, obj) {
    remove_callback(#"on_entity_deleted", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x182f0cc6, Offset: 0xd90
// Size: 0x3c
function on_shutdown(func, obj) {
    add_entity_callback(#"on_entity_shutdown", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x6e035b29, Offset: 0xdd8
// Size: 0x3c
function on_start_gametype(func, obj) {
    add_callback(#"on_start_gametype", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xd326d718, Offset: 0xe20
// Size: 0x3c
function on_end_game(func, obj) {
    add_callback(#"on_end_game", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x98527d23, Offset: 0xe68
// Size: 0x3c
function remove_on_end_game(func, obj) {
    remove_callback(#"on_end_game", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x75fcecee, Offset: 0xeb0
// Size: 0x3c
function on_trigger(func, obj) {
    add_entity_callback(#"on_trigger", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x474f9adf, Offset: 0xef8
// Size: 0x3c
function remove_on_trigger(func, obj) {
    function_1f42556c(#"on_trigger", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xf2aaaa29, Offset: 0xf40
// Size: 0x3c
function on_trigger_once(func, obj) {
    add_entity_callback(#"on_trigger_once", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x160ac6d5, Offset: 0xf88
// Size: 0x3c
function remove_on_trigger_once(func, obj) {
    function_1f42556c(#"on_trigger_once", func, obj);
}

// Namespace callback/level_preinit
// Params 1, eflags: 0x40
// Checksum 0x6945c968, Offset: 0xfd0
// Size: 0x3c
function event_handler[level_preinit] codecallback_preinitialization(eventstruct) {
    callback(#"on_pre_initialization");
    system::run_pre_systems();
}

// Namespace callback/level_finalizeinit
// Params 1, eflags: 0x40
// Checksum 0x48669b4, Offset: 0x1018
// Size: 0x3c
function event_handler[level_finalizeinit] codecallback_finalizeinitialization(eventstruct) {
    system::run_post_systems();
    callback(#"on_finalize_initialization");
}

// Namespace callback/systemstatechange
// Params 1, eflags: 0x40
// Checksum 0x9dbaae7e, Offset: 0x1060
// Size: 0x134
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
    println("<dev string:xc0>" + eventstruct.system + "<dev string:xec>");
}

// Namespace callback/maprestart
// Params 1, eflags: 0x40
// Checksum 0x9a7d7ac, Offset: 0x11a0
// Size: 0x5c
function event_handler[maprestart] codecallback_maprestart(eventstruct) {
    println("<dev string:x114>");
    util::waitforclient(0);
    level thread util::init_utility();
}

// Namespace callback/localclient_connect
// Params 1, eflags: 0x40
// Checksum 0x970b6fba, Offset: 0x1208
// Size: 0x54
function event_handler[localclient_connect] codecallback_localclientconnect(eventstruct) {
    println("<dev string:x136>" + eventstruct.localclientnum);
    [[ level.callbacklocalclientconnect ]](eventstruct.localclientnum);
}

// Namespace callback/glass_smash
// Params 1, eflags: 0x40
// Checksum 0xd3dda027, Offset: 0x1268
// Size: 0x58
function event_handler[glass_smash] codecallback_glasssmash(eventstruct) {
    level notify(#"glass_smash", {#position:eventstruct.location, #direction:eventstruct.direction});
}

// Namespace callback/sound_setambientstate
// Params 1, eflags: 0x40
// Checksum 0xb238f282, Offset: 0x12c8
// Size: 0x54
function event_handler[sound_setambientstate] codecallback_soundsetambientstate(eventstruct) {
    audio::setcurrentambientstate(eventstruct.ambientroom, eventstruct.ambientpackage, eventstruct.roomcollider, eventstruct.packagecollider, eventstruct.is_defaultroom);
}

// Namespace callback/sound_setaiambientstate
// Params 1, eflags: 0x40
// Checksum 0x3e36839f, Offset: 0x1328
// Size: 0xc
function event_handler[sound_setaiambientstate] codecallback_soundsetaiambientstate(eventstruct) {
    
}

// Namespace callback/event_6684c621
// Params 1, eflags: 0x40
// Checksum 0x3454e65d, Offset: 0x1340
// Size: 0x6c
function event_handler[event_6684c621] function_968670cc(eventstruct) {
    if (!isdefined(level.var_ee00187e)) {
        return;
    }
    println("<dev string:x163>");
    thread [[ level.var_ee00187e ]](eventstruct.var_61ee2903, eventstruct.var_c7800596, eventstruct.var_7866a58);
}

// Namespace callback/sound_playuidecodeloop
// Params 1, eflags: 0x40
// Checksum 0x45a955fd, Offset: 0x13b8
// Size: 0x34
function event_handler[sound_playuidecodeloop] codecallback_soundplayuidecodeloop(eventstruct) {
    self thread audio::soundplayuidecodeloop(eventstruct.decode_string, eventstruct.play_time_ms);
}

// Namespace callback/player_spawned
// Params 1, eflags: 0x40
// Checksum 0x9b8d2c15, Offset: 0x13f8
// Size: 0x44
function event_handler[player_spawned] codecallback_playerspawned(eventstruct) {
    println("<dev string:x190>");
    [[ level.callbackplayerspawned ]](eventstruct.localclientnum);
}

// Namespace callback/player_laststand
// Params 1, eflags: 0x40
// Checksum 0x903530da, Offset: 0x1448
// Size: 0x24
function event_handler[player_laststand] codecallback_playerlaststand(eventstruct) {
    [[ level.callbackplayerlaststand ]](eventstruct.localclientnum);
}

// Namespace callback/event_d10f98aa
// Params 1, eflags: 0x40
// Checksum 0x587612e0, Offset: 0x1478
// Size: 0x54
function event_handler[event_d10f98aa] function_e09fb91a(eventstruct) {
    if (!isdefined(level.var_cceb290b)) {
        return;
    }
    println("<dev string:x1b3>");
    thread [[ level.var_cceb290b ]](eventstruct.var_db93c8d6);
}

// Namespace callback/event_b1ecae84
// Params 1, eflags: 0x40
// Checksum 0xce1ed808, Offset: 0x14d8
// Size: 0x54
function event_handler[event_b1ecae84] function_709e5314(eventstruct) {
    println("<dev string:x1da>");
    if (isdefined(level.var_9db431b2)) {
        [[ level.var_9db431b2 ]](eventstruct.localclientnum);
    }
}

// Namespace callback/event_59f30256
// Params 1, eflags: 0x40
// Checksum 0x4d9c3c2a, Offset: 0x1538
// Size: 0x44
function event_handler[event_59f30256] function_64a22ce6(eventstruct) {
    if (isdefined(level.var_dc95ab2d)) {
        [[ level.var_dc95ab2d ]](self, eventstruct.localclientnum, eventstruct.weapon);
    }
}

// Namespace callback/entity_gibevent
// Params 1, eflags: 0x40
// Checksum 0xe910b334, Offset: 0x1588
// Size: 0x50
function event_handler[entity_gibevent] codecallback_gibevent(eventstruct) {
    if (isdefined(level._gibeventcbfunc)) {
        self thread [[ level._gibeventcbfunc ]](eventstruct.localclientnum, eventstruct.type, eventstruct.locations);
    }
}

// Namespace callback/gametype_precache
// Params 1, eflags: 0x40
// Checksum 0xc5f09549, Offset: 0x15e0
// Size: 0x2c
function event_handler[gametype_precache] codecallback_precachegametype(eventstruct) {
    if (isdefined(level.callbackprecachegametype)) {
        [[ level.callbackprecachegametype ]]();
    }
}

// Namespace callback/gametype_start
// Params 1, eflags: 0x40
// Checksum 0x1678d963, Offset: 0x1618
// Size: 0x5e
function event_handler[gametype_start] codecallback_startgametype(eventstruct) {
    if (isdefined(level.callbackstartgametype) && (!isdefined(level.gametypestarted) || !level.gametypestarted)) {
        [[ level.callbackstartgametype ]]();
        level.gametypestarted = 1;
    }
}

// Namespace callback/entity_spawned
// Params 1, eflags: 0x40
// Checksum 0xa38d01b6, Offset: 0x1680
// Size: 0x24
function event_handler[entity_spawned] codecallback_entityspawned(eventstruct) {
    [[ level.callbackentityspawned ]](eventstruct.localclientnum);
}

// Namespace callback/sound_notify
// Params 1, eflags: 0x40
// Checksum 0x73628817, Offset: 0x16b0
// Size: 0x92
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
// Checksum 0xba4779ac, Offset: 0x1750
// Size: 0x74
function event_handler[entity_shutdown] codecallback_entityshutdown(eventstruct) {
    if (isdefined(level.callbackentityshutdown)) {
        [[ level.callbackentityshutdown ]](eventstruct.localclientnum, eventstruct.entity);
    }
    eventstruct.entity entity_callback(#"on_entity_shutdown", eventstruct.localclientnum);
}

// Namespace callback/localclient_shutdown
// Params 1, eflags: 0x40
// Checksum 0xb72c91c5, Offset: 0x17d0
// Size: 0x5c
function event_handler[localclient_shutdown] codecallback_localclientshutdown(eventstruct) {
    level.localplayers = getlocalplayers();
    eventstruct.entity callback(#"on_localclient_shutdown", eventstruct.localclientnum);
}

// Namespace callback/localclient_changed
// Params 1, eflags: 0x40
// Checksum 0xcca8888, Offset: 0x1838
// Size: 0x26
function event_handler[localclient_changed] codecallback_localclientchanged(eventstruct) {
    level.localplayers = getlocalplayers();
}

// Namespace callback/player_airsupport
// Params 1, eflags: 0x40
// Checksum 0xdb24a83d, Offset: 0x1868
// Size: 0xc4
function event_handler[player_airsupport] codecallback_airsupport(eventstruct) {
    if (isdefined(level.callbackairsupport)) {
        [[ level.callbackairsupport ]](eventstruct.localclientnum, eventstruct.location[0], eventstruct.location[1], eventstruct.location[2], eventstruct.type, eventstruct.yaw, eventstruct.team, eventstruct.team_faction, eventstruct.owner, eventstruct.exit_type, eventstruct.server_time, eventstruct.height);
    }
}

// Namespace callback/demosystem_jump
// Params 1, eflags: 0x40
// Checksum 0x9270e793, Offset: 0x1938
// Size: 0x76
function event_handler[demosystem_jump] codecallback_demojump(eventstruct) {
    level notify(#"demo_jump", {#time:eventstruct.time});
    level notify("demo_jump" + eventstruct.localclientnum, {#time:eventstruct.time});
}

// Namespace callback/callbacks_shared
// Params 1, eflags: 0x0
// Checksum 0xa4c90523, Offset: 0x19b8
// Size: 0x36
function codecallback_demoplayerswitch(localclientnum) {
    level notify(#"demo_player_switch");
    level notify("demo_player_switch" + localclientnum);
}

// Namespace callback/player_switch
// Params 1, eflags: 0x40
// Checksum 0x43c0cea1, Offset: 0x19f8
// Size: 0x3e
function event_handler[player_switch] codecallback_playerswitch(eventstruct) {
    level notify(#"player_switch");
    level notify("player_switch" + eventstruct.localclientnum);
}

// Namespace callback/killcam_begin
// Params 1, eflags: 0x40
// Checksum 0x6d109e35, Offset: 0x1a40
// Size: 0x76
function event_handler[killcam_begin] codecallback_killcambegin(eventstruct) {
    level notify(#"killcam_begin", {#time:eventstruct.time});
    level notify("killcam_begin" + eventstruct.localclientnum, {#time:eventstruct.time});
}

// Namespace callback/killcam_end
// Params 1, eflags: 0x40
// Checksum 0xc16111dd, Offset: 0x1ac0
// Size: 0x76
function event_handler[killcam_end] codecallback_killcamend(eventstruct) {
    level notify(#"killcam_end", {#time:eventstruct.time});
    level notify("killcam_end" + eventstruct.localclientnum, {#time:eventstruct.time});
}

// Namespace callback/player_corpse
// Params 1, eflags: 0x40
// Checksum 0x2690fc5f, Offset: 0x1b40
// Size: 0x40
function event_handler[player_corpse] codecallback_creatingcorpse(eventstruct) {
    if (isdefined(level.callbackcreatingcorpse)) {
        [[ level.callbackcreatingcorpse ]](eventstruct.localclientnum, eventstruct.player);
    }
}

// Namespace callback/exploder_activate
// Params 1, eflags: 0x40
// Checksum 0x95ecbe9d, Offset: 0x1b88
// Size: 0xcc
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
// Checksum 0x1c7ed930, Offset: 0x1c60
// Size: 0xcc
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
// Checksum 0x2e14e3b5, Offset: 0x1d38
// Size: 0x50
function event_handler[sound_chargeshotweaponnotify] codecallback_chargeshotweaponsoundnotify(eventstruct) {
    if (isdefined(level.sndchargeshot_func)) {
        self [[ level.sndchargeshot_func ]](eventstruct.localclientnum, eventstruct.weapon, eventstruct.chargeshotlevel);
    }
}

// Namespace callback/hostmigration
// Params 1, eflags: 0x40
// Checksum 0xbf4c4364, Offset: 0x1d90
// Size: 0x54
function event_handler[hostmigration] codecallback_hostmigration(eventstruct) {
    println("<dev string:x202>");
    if (isdefined(level.callbackhostmigration)) {
        [[ level.callbackhostmigration ]](eventstruct.localclientnum);
    }
}

// Namespace callback/entity_footstep
// Params 1, eflags: 0x40
// Checksum 0x4116344c, Offset: 0x1df0
// Size: 0x54
function event_handler[entity_footstep] codecallback_playaifootstep(eventstruct) {
    [[ level.callbackplayaifootstep ]](eventstruct.localclientnum, eventstruct.location, eventstruct.surface, eventstruct.notetrack, eventstruct.bone);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x0
// Checksum 0x96d27a5d, Offset: 0x1e50
// Size: 0x48
function codecallback_clientflag(localclientnum, flag, set) {
    if (isdefined(level.callbackclientflag)) {
        [[ level.callbackclientflag ]](localclientnum, flag, set);
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x758f4e03, Offset: 0x1ea0
// Size: 0x5e
function codecallback_clientflagasval(localclientnum, val) {
    if (isdefined(level._client_flagasval_callbacks) && isdefined(level._client_flagasval_callbacks[self.type])) {
        self thread [[ level._client_flagasval_callbacks[self.type] ]](localclientnum, val);
    }
}

// Namespace callback/extracam_currentheroheadshot
// Params 1, eflags: 0x40
// Checksum 0xc08e0c0f, Offset: 0x1f08
// Size: 0x70
function event_handler[extracam_currentheroheadshot] codecallback_extracamrendercurrentheroheadshot(eventstruct) {
    if (isdefined(level.extra_cam_render_current_hero_headshot_func_callback)) {
        [[ level.extra_cam_render_current_hero_headshot_func_callback ]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.character_index, eventstruct.is_defaulthero);
    }
}

// Namespace callback/event_b8117406
// Params 1, eflags: 0x40
// Checksum 0xe4c316eb, Offset: 0x1f80
// Size: 0x94
function event_handler[event_b8117406] function_3be92122(eventstruct) {
    if (isdefined(level.var_75d55119)) {
        [[ level.var_75d55119 ]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.character_index, eventstruct.outfit_index, eventstruct.item_type, eventstruct.item_index, eventstruct.is_defaultrender);
    }
}

// Namespace callback/extracam_characterheaditem
// Params 1, eflags: 0x40
// Checksum 0x59a43f16, Offset: 0x2020
// Size: 0x70
function event_handler[extracam_characterheaditem] codecallback_extracamrendercharacterheaditem(eventstruct) {
    if (isdefined(level.extra_cam_render_character_head_item_func_callback)) {
        [[ level.extra_cam_render_character_head_item_func_callback ]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.head_index, eventstruct.is_default_render);
    }
}

// Namespace callback/extracam_genderrender
// Params 1, eflags: 0x40
// Checksum 0xf41e2acf, Offset: 0x2098
// Size: 0x64
function event_handler[extracam_genderrender] codecallback_extracamrendergender(eventstruct) {
    if (isdefined(level.extra_cam_render_gender_func_callback)) {
        [[ level.extra_cam_render_gender_func_callback ]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.gender);
    }
}

// Namespace callback/extracam_wcpaintjobicon
// Params 1, eflags: 0x40
// Checksum 0x5b7c540a, Offset: 0x2108
// Size: 0x88
function event_handler[extracam_wcpaintjobicon] codecallback_extracamrenderwcpaintjobicon(eventstruct) {
    if (isdefined(level.extra_cam_render_wc_paintjobicon_func_callback)) {
        [[ level.extra_cam_render_wc_paintjobicon_func_callback ]](eventstruct.localclientnum, eventstruct.extracam_index, eventstruct.job_index, eventstruct.weapon_options, eventstruct.weapon, eventstruct.loadout_slot, eventstruct.paintjob_slot, eventstruct.is_fileshare_preview);
    }
}

// Namespace callback/extracam_wcvarianticon
// Params 1, eflags: 0x40
// Checksum 0xf59b6ed7, Offset: 0x2198
// Size: 0x88
function event_handler[extracam_wcvarianticon] codecallback_extracamrenderwcvarianticon(eventstruct) {
    if (isdefined(level.extra_cam_render_wc_varianticon_func_callback)) {
        [[ level.extra_cam_render_wc_varianticon_func_callback ]](eventstruct.localclientnum, eventstruct.extracam_index, eventstruct.job_index, eventstruct.weapon_options, eventstruct.weapon, eventstruct.loadout_slot, eventstruct.paintjob_slot, eventstruct.is_fileshare_preview);
    }
}

// Namespace callback/collectibles_changed
// Params 1, eflags: 0x40
// Checksum 0xa1ecd797, Offset: 0x2228
// Size: 0x4c
function event_handler[collectibles_changed] codecallback_collectibleschanged(eventstruct) {
    if (isdefined(level.on_collectibles_change)) {
        [[ level.on_collectibles_change ]](eventstruct.clientnum, eventstruct.collectibles, eventstruct.localclientnum);
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x746c2c2e, Offset: 0x2280
// Size: 0x5e
function add_weapon_type(weapontype, callback) {
    if (!isdefined(level.weapon_type_callback_array)) {
        level.weapon_type_callback_array = [];
    }
    weapontype = getweapon(weapontype);
    level.weapon_type_callback_array[weapontype] = callback;
}

// Namespace callback/callbacks_shared
// Params 1, eflags: 0x0
// Checksum 0x18045bc2, Offset: 0x22e8
// Size: 0x66
function spawned_weapon_type(localclientnum) {
    weapontype = self.weapon.rootweapon;
    if (isdefined(level.weapon_type_callback_array) && isdefined(level.weapon_type_callback_array[weapontype])) {
        self thread [[ level.weapon_type_callback_array[weapontype] ]](localclientnum);
    }
}

// Namespace callback/notetrack_callclientscript
// Params 1, eflags: 0x40
// Checksum 0x56cd2f5e, Offset: 0x2358
// Size: 0xc6
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
// Checksum 0x32ee37f4, Offset: 0x2428
// Size: 0xce
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

// Namespace callback/event_b7d4b6fe
// Params 1, eflags: 0x40
// Checksum 0x6da12267, Offset: 0x2500
// Size: 0x174
function event_handler[event_b7d4b6fe] function_123a8181(eventstruct) {
    origin = self.origin;
    magnitude = float(eventstruct.magnitude);
    innerradius = float(eventstruct.innerradius);
    outerradius = float(eventstruct.outerradius);
    innerdamage = isdefined(self.var_19a0c648) ? self.var_19a0c648 : 50;
    outerdamage = isdefined(self.var_83d92359) ? self.var_83d92359 : 25;
    var_ef6a2419 = isdefined(self.var_b9925bd5) ? self.var_b9925bd5 : 1;
    var_f6a9ce34 = isdefined(self.var_e9d7ca68) ? self.var_e9d7ca68 : 1;
    physicsexplosionsphere(eventstruct.localclientnum, origin, outerradius, innerradius, magnitude, innerdamage, outerdamage, var_ef6a2419, var_f6a9ce34);
}

// Namespace callback/scene_init
// Params 1, eflags: 0x40
// Checksum 0x78d2e805, Offset: 0x2680
// Size: 0x44
function event_handler[scene_init] codecallback_serversceneinit(eventstruct) {
    if (isdefined(level.server_scenes[eventstruct.scene_name])) {
        level thread scene::init(eventstruct.scene_name);
    }
}

// Namespace callback/scene_play
// Params 1, eflags: 0x40
// Checksum 0x18206cb4, Offset: 0x26d0
// Size: 0x5c
function event_handler[scene_play] codecallback_serversceneplay(eventstruct) {
    level thread scene_black_screen();
    if (isdefined(level.server_scenes[eventstruct.scene_name])) {
        level thread scene::play(eventstruct.scene_name);
    }
}

// Namespace callback/scene_stop
// Params 1, eflags: 0x40
// Checksum 0xa46c246f, Offset: 0x2738
// Size: 0x6c
function event_handler[scene_stop] codecallback_serverscenestop(eventstruct) {
    level thread scene_black_screen();
    if (isdefined(level.server_scenes[eventstruct.scene_name])) {
        level thread scene::stop(eventstruct.scene_name, undefined, undefined, undefined, 1);
    }
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x0
// Checksum 0xf9c394e9, Offset: 0x27b0
// Size: 0x14a
function scene_black_screen() {
    foreach (i, player in level.localplayers) {
        if (!isdefined(player.lui_black)) {
            player.lui_black = createluimenu(i, "FullScreenBlack");
            openluimenu(i, player.lui_black);
        }
    }
    waitframe(1);
    foreach (i, player in level.localplayers) {
        if (isdefined(player.lui_black)) {
            closeluimenu(i, player.lui_black);
            player.lui_black = undefined;
        }
    }
}

// Namespace callback/gadget_visionpulsereveal
// Params 1, eflags: 0x40
// Checksum 0x8e31a20a, Offset: 0x2908
// Size: 0x4c
function event_handler[gadget_visionpulsereveal] codecallback_gadgetvisionpulse_reveal(eventstruct) {
    if (isdefined(level.gadgetvisionpulse_reveal_func)) {
        eventstruct.entity [[ level.gadgetvisionpulse_reveal_func ]](eventstruct.localclientnum, eventstruct.enable);
    }
}

// Namespace callback/callbacks_shared
// Params 5, eflags: 0x4
// Checksum 0x9a9e5eb3, Offset: 0x2960
// Size: 0x8c
function private fade_to_black_for_x_sec(startwait, blackscreenwait, fadeintime, fadeouttime, shadername) {
    self endon(#"disconnect");
    wait startwait;
    self lui::screen_fade_out(fadeintime, shadername);
    wait blackscreenwait;
    if (isdefined(self)) {
        self lui::screen_fade_in(fadeouttime, shadername);
    }
}

// Namespace callback/ui_fadeblackscreen
// Params 1, eflags: 0x40
// Checksum 0x505f0714, Offset: 0x29f8
// Size: 0x94
function event_handler[ui_fadeblackscreen] codecallback_fadeblackscreen(eventstruct) {
    if (isdefined(self) && self isplayer() && !isbot(self) && self function_60dbc438()) {
        self thread fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend, eventstruct.blend);
    }
}

// Namespace callback/event_da91a4ae
// Params 1, eflags: 0x40
// Checksum 0x247ccb77, Offset: 0x2a98
// Size: 0x94
function event_handler[event_da91a4ae] function_9705378a(eventstruct) {
    if (isdefined(self) && self isplayer() && !isbot(self) && self function_60dbc438()) {
        self thread fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend_out, eventstruct.blend_in);
    }
}

// Namespace callback/event_633e7680
// Params 1, eflags: 0x40
// Checksum 0x3ac24984, Offset: 0x2b38
// Size: 0x4c
function event_handler[event_633e7680] function_b7b0bc67(eventstruct) {
    self animation::play_siege(eventstruct.anim_name, eventstruct.shot_name, eventstruct.rate, eventstruct.loop);
}

// Namespace callback/forcestreambundle
// Params 1, eflags: 0x40
// Checksum 0x38703556, Offset: 0x2b90
// Size: 0x3c
function event_handler[forcestreambundle] codecallback_forcestreambundle(eventstruct) {
    forcestreambundle(eventstruct.name, eventstruct.var_d3e848c2, eventstruct.var_ddb931ae);
}

// Namespace callback/event_52153ba9
// Params 1, eflags: 0x40
// Checksum 0x361e2e87, Offset: 0x2bd8
// Size: 0x64
function event_handler[event_52153ba9] function_51fef3f0(eventstruct) {
    if (isdefined(level.var_d7458be9)) {
        [[ level.var_d7458be9 ]](eventstruct.localclientnum, eventstruct.eventtype, eventstruct.itemid, eventstruct.value, eventstruct.value2);
    }
}

// Namespace callback/event_ee03d8c2
// Params 1, eflags: 0x40
// Checksum 0x82fdb0a3, Offset: 0x2c48
// Size: 0x34
function event_handler[event_ee03d8c2] function_1aff304d(eventstruct) {
    if (isdefined(level.var_7419c002)) {
        [[ level.var_7419c002 ]](eventstruct.var_320c7c6a);
    }
}

// Namespace callback/trigger
// Params 1, eflags: 0x40
// Checksum 0x7975c83d, Offset: 0x2c88
// Size: 0x7c
function event_handler[trigger] codecallback_trigger(eventstruct) {
    if (isdefined(level.var_7419c002)) {
        self callback(#"on_trigger", eventstruct);
        self callback(#"on_trigger_once", eventstruct);
        self remove_on_trigger_once("all");
    }
}

// Namespace callback/freefall
// Params 1, eflags: 0x40
// Checksum 0x45b7a186, Offset: 0x2d10
// Size: 0x2c
function event_handler[freefall] function_25fa193b(eventstruct) {
    self callback(#"freefall", eventstruct);
}

// Namespace callback/parachute
// Params 1, eflags: 0x40
// Checksum 0x7f202a8d, Offset: 0x2d48
// Size: 0x2c
function event_handler[parachute] function_ad5a594b(eventstruct) {
    self callback(#"parachute", eventstruct);
}

// Namespace callback/death
// Params 1, eflags: 0x40
// Checksum 0x2992c232, Offset: 0x2d80
// Size: 0x2c
function event_handler[death] codecallback_death(eventstruct) {
    self callback(#"death", eventstruct);
}

// Namespace callback/weapon_change
// Params 1, eflags: 0x40
// Checksum 0xde019332, Offset: 0x2db8
// Size: 0x6c
function event_handler[weapon_change] function_1230dc4a(eventstruct) {
    if (self function_60dbc438()) {
        level callback(#"weapon_change", eventstruct);
    }
    self callback(#"weapon_change", eventstruct);
}

