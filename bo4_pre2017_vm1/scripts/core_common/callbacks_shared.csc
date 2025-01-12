#using scripts/core_common/array_shared;
#using scripts/core_common/audio_shared;
#using scripts/core_common/exploder_shared;
#using scripts/core_common/footsteps_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace callback;

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x0
// Checksum 0x2ebf0a7b, Offset: 0x218
// Size: 0x160
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
// Checksum 0xa8c1d188, Offset: 0x380
// Size: 0x154
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
// Checksum 0x3c5f4ec5, Offset: 0x4e0
// Size: 0x19c
function add_callback(event, func, obj) {
    /#
        assert(isdefined(event), "<dev string:x28>");
    #/
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
// Checksum 0x8daf433, Offset: 0x688
// Size: 0x16c
function add_entity_callback(event, func, obj) {
    /#
        assert(isdefined(event), "<dev string:x28>");
    #/
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
// Checksum 0xc3cd2c87, Offset: 0x800
// Size: 0x3c
function remove_callback_on_death(event, func) {
    self waittill("death");
    remove_callback(event, func, self);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x0
// Checksum 0xb2b41711, Offset: 0x848
// Size: 0x142
function remove_callback(event, func, obj) {
    /#
        assert(isdefined(event), "<dev string:x58>");
    #/
    /#
        assert(isdefined(level._callbacks[event]), "<dev string:x8b>");
    #/
    foreach (index, func_group in level._callbacks[event]) {
        if (func_group[0] == func) {
            if (func_group[1] === obj) {
                arrayremoveindex(level._callbacks[event], index, 0);
            }
        }
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x37d649b1, Offset: 0x998
// Size: 0x34
function on_localclient_connect(func, obj) {
    add_callback(#"hash_da8d7d74", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x94a2075b, Offset: 0x9d8
// Size: 0x34
function on_localclient_shutdown(func, obj) {
    add_callback(#"hash_e64327a6", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x8a974ac1, Offset: 0xa18
// Size: 0x34
function on_finalize_initialization(func, obj) {
    add_callback(#"hash_36fb1b1a", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x3d03d817, Offset: 0xa58
// Size: 0x34
function on_localplayer_spawned(func, obj) {
    add_callback(#"hash_842e788a", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xbe877a09, Offset: 0xa98
// Size: 0x34
function remove_on_localplayer_spawned(func, obj) {
    remove_callback(#"hash_842e788a", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x3c1f8f77, Offset: 0xad8
// Size: 0x34
function on_spawned(func, obj) {
    add_callback(#"hash_bc12b61f", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x92de1694, Offset: 0xb18
// Size: 0x34
function remove_on_spawned(func, obj) {
    remove_callback(#"hash_bc12b61f", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x75d38a63, Offset: 0xb58
// Size: 0x34
function function_301fb71c(func, obj) {
    add_callback(#"hash_5bd9c78a", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x7c4f0f0e, Offset: 0xb98
// Size: 0x34
function function_5930314d(func, obj) {
    remove_callback(#"hash_5bd9c78a", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xff12b12b, Offset: 0xbd8
// Size: 0x34
function on_deleted(func, obj) {
    add_callback(#"hash_ebc37b54", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x908c7bb7, Offset: 0xc18
// Size: 0x34
function remove_on_deleted(func, obj) {
    remove_callback(#"hash_ebc37b54", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x62abebe7, Offset: 0xc58
// Size: 0x34
function on_shutdown(func, obj) {
    add_entity_callback(#"hash_390259d9", func, obj);
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x6bf25d4a, Offset: 0xc98
// Size: 0x34
function on_start_gametype(func, obj) {
    add_callback(#"hash_cc62acca", func, obj);
}

// Namespace callback/level_preinit
// Params 1, eflags: 0x40
// Checksum 0xbb7014bc, Offset: 0xcd8
// Size: 0x34
function event_handler[level_preinit] codecallback_preinitialization(eventstruct) {
    callback(#"hash_ecc6aecf");
    system::run_pre_systems();
}

// Namespace callback/level_finalizeinit
// Params 1, eflags: 0x40
// Checksum 0x7720e77, Offset: 0xd18
// Size: 0x34
function event_handler[level_finalizeinit] codecallback_finalizeinitialization(eventstruct) {
    system::run_post_systems();
    callback(#"hash_36fb1b1a");
}

// Namespace callback/systemstatechange
// Params 1, eflags: 0x40
// Checksum 0xf7a0054b, Offset: 0xd58
// Size: 0x15c
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
    /#
        println("<dev string:xb8>" + eventstruct.system + "<dev string:xe4>");
    #/
}

// Namespace callback/maprestart
// Params 1, eflags: 0x40
// Checksum 0xc0c27e75, Offset: 0xec0
// Size: 0x5c
function event_handler[maprestart] codecallback_maprestart(eventstruct) {
    /#
        println("<dev string:x10c>");
    #/
    util::waitforclient(0);
    level thread util::init_utility();
}

// Namespace callback/localclient_connect
// Params 1, eflags: 0x40
// Checksum 0xcd8c780f, Offset: 0xf28
// Size: 0x5c
function event_handler[localclient_connect] codecallback_localclientconnect(eventstruct) {
    /#
        println("<dev string:x12e>" + eventstruct.localclientnum);
    #/
    [[ level.callbacklocalclientconnect ]](eventstruct.localclientnum);
}

// Namespace callback/glass_smash
// Params 1, eflags: 0x40
// Checksum 0x31073abe, Offset: 0xf90
// Size: 0x4c
function event_handler[glass_smash] codecallback_glasssmash(eventstruct) {
    level notify(#"glass_smash", {#position:eventstruct.location, #direction:eventstruct.direction});
}

// Namespace callback/sound_setambientstate
// Params 1, eflags: 0x40
// Checksum 0x9cd09495, Offset: 0xfe8
// Size: 0x5c
function event_handler[sound_setambientstate] codecallback_soundsetambientstate(eventstruct) {
    audio::setcurrentambientstate(eventstruct.ambientroom, eventstruct.ambientpackage, eventstruct.roomcollider, eventstruct.packagecollider, eventstruct.is_defaultroom);
}

// Namespace callback/sound_setaiambientstate
// Params 1, eflags: 0x40
// Checksum 0x2e313a94, Offset: 0x1050
// Size: 0xc
function event_handler[sound_setaiambientstate] codecallback_soundsetaiambientstate(eventstruct) {
    
}

// Namespace callback/sound_playuidecodeloop
// Params 1, eflags: 0x40
// Checksum 0x50fec843, Offset: 0x1068
// Size: 0x3c
function event_handler[sound_playuidecodeloop] codecallback_soundplayuidecodeloop(eventstruct) {
    self thread audio::soundplayuidecodeloop(eventstruct.decode_string, eventstruct.play_time_ms);
}

// Namespace callback/player_spawned
// Params 1, eflags: 0x40
// Checksum 0x20b9e44e, Offset: 0x10b0
// Size: 0x4c
function event_handler[player_spawned] codecallback_playerspawned(eventstruct) {
    /#
        println("<dev string:x15b>");
    #/
    [[ level.callbackplayerspawned ]](eventstruct.localclientnum);
}

// Namespace callback/entity_gibevent
// Params 1, eflags: 0x40
// Checksum 0x772976f, Offset: 0x1108
// Size: 0x54
function event_handler[entity_gibevent] codecallback_gibevent(eventstruct) {
    if (isdefined(level._gibeventcbfunc)) {
        self thread [[ level._gibeventcbfunc ]](eventstruct.localclientnum, eventstruct.type, eventstruct.locations);
    }
}

// Namespace callback/gametype_precache
// Params 1, eflags: 0x40
// Checksum 0x9a08ed72, Offset: 0x1168
// Size: 0x30
function event_handler[gametype_precache] codecallback_precachegametype(eventstruct) {
    if (isdefined(level.callbackprecachegametype)) {
        [[ level.callbackprecachegametype ]]();
    }
}

// Namespace callback/GameType_Start
// Params 1, eflags: 0x40
// Checksum 0xa1a83fc6, Offset: 0x11a0
// Size: 0x64
function event_handler[GameType_Start] codecallback_startgametype(eventstruct) {
    if (!isdefined(level.gametypestarted) || isdefined(level.callbackstartgametype) && !level.gametypestarted) {
        [[ level.callbackstartgametype ]]();
        level.gametypestarted = 1;
    }
}

// Namespace callback/entity_spawned
// Params 1, eflags: 0x40
// Checksum 0x7f5e64a9, Offset: 0x1210
// Size: 0x2c
function event_handler[entity_spawned] codecallback_entityspawned(eventstruct) {
    [[ level.callbackentityspawned ]](eventstruct.localclientnum);
}

// Namespace callback/sound_notify
// Params 1, eflags: 0x40
// Checksum 0xa23cd249, Offset: 0x1248
// Size: 0x7e
function event_handler[sound_notify] codecallback_soundnotify(eventstruct) {
    switch (eventstruct.notetrack) {
    case #"scr_bomb_beep":
        if (getgametypesetting("silentPlant") == 0) {
            self playsound(eventstruct.localclientnum, "fly_bomb_buttons_npc");
        }
        break;
    }
}

// Namespace callback/entity_shutdown
// Params 1, eflags: 0x40
// Checksum 0xa9629bdf, Offset: 0x12d0
// Size: 0x7c
function event_handler[entity_shutdown] codecallback_entityshutdown(eventstruct) {
    if (isdefined(level.callbackentityshutdown)) {
        [[ level.callbackentityshutdown ]](eventstruct.localclientnum, eventstruct.entity);
    }
    eventstruct.entity entity_callback(#"hash_390259d9", eventstruct.localclientnum);
}

// Namespace callback/localclient_shutdown
// Params 1, eflags: 0x40
// Checksum 0xfa7343bb, Offset: 0x1358
// Size: 0x5c
function event_handler[localclient_shutdown] codecallback_localclientshutdown(eventstruct) {
    level.localplayers = getlocalplayers();
    eventstruct.entity callback(#"hash_e64327a6", eventstruct.localclientnum);
}

// Namespace callback/localclient_changed
// Params 1, eflags: 0x40
// Checksum 0xcbebfd02, Offset: 0x13c0
// Size: 0x28
function event_handler[localclient_changed] codecallback_localclientchanged(eventstruct) {
    level.localplayers = getlocalplayers();
}

// Namespace callback/player_airsupport
// Params 1, eflags: 0x40
// Checksum 0xfe369f53, Offset: 0x13f0
// Size: 0xd4
function event_handler[player_airsupport] codecallback_airsupport(eventstruct) {
    if (isdefined(level.callbackairsupport)) {
        [[ level.callbackairsupport ]](eventstruct.localclientnum, eventstruct.location[0], eventstruct.location[1], eventstruct.location[2], eventstruct.type, eventstruct.yaw, eventstruct.team, eventstruct.team_faction, eventstruct.owner, eventstruct.exit_type, eventstruct.server_time, eventstruct.height);
    }
}

// Namespace callback/demosystem_jump
// Params 1, eflags: 0x40
// Checksum 0xc777076d, Offset: 0x14d0
// Size: 0x6a
function event_handler[demosystem_jump] codecallback_demojump(eventstruct) {
    level notify(#"demo_jump", {#time:eventstruct.time});
    level notify("demo_jump" + eventstruct.localclientnum, {#time:eventstruct.time});
}

// Namespace callback/callbacks_shared
// Params 1, eflags: 0x0
// Checksum 0xc3be249f, Offset: 0x1548
// Size: 0x32
function codecallback_demoplayerswitch(localclientnum) {
    level notify(#"demo_player_switch");
    level notify("demo_player_switch" + localclientnum);
}

// Namespace callback/player_switch
// Params 1, eflags: 0x40
// Checksum 0x9e53369f, Offset: 0x1588
// Size: 0x3a
function event_handler[player_switch] codecallback_playerswitch(eventstruct) {
    level notify(#"player_switch");
    level notify("player_switch" + eventstruct.localclientnum);
}

// Namespace callback/killcam_begin
// Params 1, eflags: 0x40
// Checksum 0xa9c99fdb, Offset: 0x15d0
// Size: 0x6a
function event_handler[killcam_begin] codecallback_killcambegin(eventstruct) {
    level notify(#"killcam_begin", {#time:eventstruct.time});
    level notify("killcam_begin" + eventstruct.localclientnum, {#time:eventstruct.time});
}

// Namespace callback/killcam_end
// Params 1, eflags: 0x40
// Checksum 0x7644b6b5, Offset: 0x1648
// Size: 0x6a
function event_handler[killcam_end] codecallback_killcamend(eventstruct) {
    level notify(#"killcam_end", {#time:eventstruct.time});
    level notify("killcam_end" + eventstruct.localclientnum, {#time:eventstruct.time});
}

// Namespace callback/player_corpse
// Params 1, eflags: 0x40
// Checksum 0x397895dd, Offset: 0x16c0
// Size: 0x48
function event_handler[player_corpse] codecallback_creatingcorpse(eventstruct) {
    if (isdefined(level.callbackcreatingcorpse)) {
        [[ level.callbackcreatingcorpse ]](eventstruct.localclientnum, eventstruct.player);
    }
}

// Namespace callback/player_foliage
// Params 1, eflags: 0x40
// Checksum 0xc179f7dd, Offset: 0x1710
// Size: 0x4c
function event_handler[player_foliage] function_6b2594ea(eventstruct) {
    footsteps::function_1e9a5eeb(eventstruct.localclientnum, eventstruct.player, eventstruct.is_firstperson, eventstruct.is_quiet);
}

// Namespace callback/exploder_activate
// Params 1, eflags: 0x40
// Checksum 0xb24c9a01, Offset: 0x1768
// Size: 0xe4
function event_handler[exploder_activate] codecallback_activateexploder(eventstruct) {
    if (!isdefined(level._exploder_ids)) {
        return;
    }
    keys = getarraykeys(level._exploder_ids);
    exploder = undefined;
    for (i = 0; i < keys.size; i++) {
        if (level._exploder_ids[keys[i]] == eventstruct.exploder_id) {
            exploder = keys[i];
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
// Checksum 0x3d533ce0, Offset: 0x1858
// Size: 0xe4
function event_handler[exploder_deactivate] codecallback_deactivateexploder(eventstruct) {
    if (!isdefined(level._exploder_ids)) {
        return;
    }
    keys = getarraykeys(level._exploder_ids);
    exploder = undefined;
    for (i = 0; i < keys.size; i++) {
        if (level._exploder_ids[keys[i]] == eventstruct.exploder_id) {
            exploder = keys[i];
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
// Checksum 0x8d3cdcee, Offset: 0x1948
// Size: 0x54
function event_handler[sound_chargeshotweaponnotify] codecallback_chargeshotweaponsoundnotify(eventstruct) {
    if (isdefined(level.sndchargeshot_func)) {
        self [[ level.sndchargeshot_func ]](eventstruct.localclientnum, eventstruct.weapon, eventstruct.chargeshotlevel);
    }
}

// Namespace callback/hostmigration
// Params 1, eflags: 0x40
// Checksum 0xc33a1f06, Offset: 0x19a8
// Size: 0x5c
function event_handler[hostmigration] codecallback_hostmigration(eventstruct) {
    /#
        println("<dev string:x17e>");
    #/
    if (isdefined(level.callbackhostmigration)) {
        [[ level.callbackhostmigration ]](eventstruct.localclientnum);
    }
}

// Namespace callback/entity_footstep
// Params 1, eflags: 0x40
// Checksum 0x11b3d650, Offset: 0x1a10
// Size: 0x5c
function event_handler[entity_footstep] codecallback_playaifootstep(eventstruct) {
    [[ level.callbackplayaifootstep ]](eventstruct.localclientnum, eventstruct.location, eventstruct.surface, eventstruct.notetrack, eventstruct.bone);
}

// Namespace callback/callbacks_shared
// Params 3, eflags: 0x0
// Checksum 0x100f59e5, Offset: 0x1a78
// Size: 0x4c
function codecallback_clientflag(localclientnum, flag, set) {
    if (isdefined(level.callbackclientflag)) {
        [[ level.callbackclientflag ]](localclientnum, flag, set);
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0x9712d7a3, Offset: 0x1ad0
// Size: 0x6a
function codecallback_clientflagasval(localclientnum, val) {
    if (isdefined(level._client_flagasval_callbacks) && isdefined(level._client_flagasval_callbacks[self.type])) {
        self thread [[ level._client_flagasval_callbacks[self.type] ]](localclientnum, val);
    }
}

// Namespace callback/extracam_hero
// Params 1, eflags: 0x40
// Checksum 0x4df6dd9c, Offset: 0x1b48
// Size: 0x6c
function event_handler[extracam_hero] function_648b2bd5(eventstruct) {
    if (isdefined(level.var_81c41302)) {
        [[ level.var_81c41302 ]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.character_index);
    }
}

// Namespace callback/extracam_lobbycilenthero
// Params 1, eflags: 0x40
// Checksum 0x3ee64a06, Offset: 0x1bc0
// Size: 0x60
function event_handler[extracam_lobbycilenthero] function_7e26b5e(eventstruct) {
    if (isdefined(level.var_c35758c9)) {
        [[ level.var_c35758c9 ]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode);
    }
}

// Namespace callback/extracam_currentheroheadshot
// Params 1, eflags: 0x40
// Checksum 0x1919feb4, Offset: 0x1c28
// Size: 0x78
function event_handler[extracam_currentheroheadshot] codecallback_extracamrendercurrentheroheadshot(eventstruct) {
    if (isdefined(level.extra_cam_render_current_hero_headshot_func_callback)) {
        [[ level.extra_cam_render_current_hero_headshot_func_callback ]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.character_index, eventstruct.is_defaulthero);
    }
}

// Namespace callback/extracam_characterbodyitem
// Params 1, eflags: 0x40
// Checksum 0x74283a42, Offset: 0x1ca8
// Size: 0x84
function event_handler[extracam_characterbodyitem] function_6913a8e7(eventstruct) {
    if (isdefined(level.var_63d084fe)) {
        [[ level.var_63d084fe ]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.character_index, eventstruct.item_index, eventstruct.is_defaultrender);
    }
}

// Namespace callback/extracam_characterhelmetitem
// Params 1, eflags: 0x40
// Checksum 0xf1498c2c, Offset: 0x1d38
// Size: 0x84
function event_handler[extracam_characterhelmetitem] function_d1674da0(eventstruct) {
    if (isdefined(level.var_a89ad62b)) {
        [[ level.var_a89ad62b ]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.character_index, eventstruct.item_index, eventstruct.is_default_render);
    }
}

// Namespace callback/extracam_characterheaditem
// Params 1, eflags: 0x40
// Checksum 0xd7e3604e, Offset: 0x1dc8
// Size: 0x78
function event_handler[extracam_characterheaditem] codecallback_extracamrendercharacterheaditem(eventstruct) {
    if (isdefined(level.extra_cam_render_character_head_item_func_callback)) {
        [[ level.extra_cam_render_character_head_item_func_callback ]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.head_index, eventstruct.is_default_render);
    }
}

// Namespace callback/extracam_genderrender
// Params 1, eflags: 0x40
// Checksum 0x8f4c9cfb, Offset: 0x1e48
// Size: 0x6c
function event_handler[extracam_genderrender] codecallback_extracamrendergender(eventstruct) {
    if (isdefined(level.extra_cam_render_gender_func_callback)) {
        [[ level.extra_cam_render_gender_func_callback ]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.gender);
    }
}

// Namespace callback/extracam_wcpaintjobicon
// Params 1, eflags: 0x40
// Checksum 0x6f1805c0, Offset: 0x1ec0
// Size: 0xa8
function event_handler[extracam_wcpaintjobicon] codecallback_extracamrenderwcpaintjobicon(eventstruct) {
    if (isdefined(level.extra_cam_render_wc_paintjobicon_func_callback)) {
        [[ level.extra_cam_render_wc_paintjobicon_func_callback ]](eventstruct.localclientnum, eventstruct.extracam_index, eventstruct.job_index, eventstruct.attachment_variant_string, eventstruct.weapon_options, eventstruct.weapon_plus_attachments, eventstruct.loadout_slot, eventstruct.paintjob_index, eventstruct.paintjob_slot, eventstruct.is_fileshare_preview);
    }
}

// Namespace callback/extracam_wcvarianticon
// Params 1, eflags: 0x40
// Checksum 0x371843b1, Offset: 0x1f70
// Size: 0xa8
function event_handler[extracam_wcvarianticon] codecallback_extracamrenderwcvarianticon(eventstruct) {
    if (isdefined(level.extra_cam_render_wc_varianticon_func_callback)) {
        [[ level.extra_cam_render_wc_varianticon_func_callback ]](eventstruct.localclientnum, eventstruct.extracam_index, eventstruct.job_index, eventstruct.attachment_variant_string, eventstruct.weapon_options, eventstruct.weapon_plus_attachments, eventstruct.loadout_slot, eventstruct.paintjob_index, eventstruct.paintjob_slot, eventstruct.is_fileshare_preview);
    }
}

// Namespace callback/collectibles_changed
// Params 1, eflags: 0x40
// Checksum 0x58bbe890, Offset: 0x2020
// Size: 0x54
function event_handler[collectibles_changed] codecallback_collectibleschanged(eventstruct) {
    if (isdefined(level.on_collectibles_change)) {
        [[ level.on_collectibles_change ]](eventstruct.clientnum, eventstruct.collectibles, eventstruct.localclientnum);
    }
}

// Namespace callback/callbacks_shared
// Params 2, eflags: 0x0
// Checksum 0xd161f328, Offset: 0x2080
// Size: 0x7e
function add_weapon_type(weapontype, callback) {
    if (!isdefined(level.weapon_type_callback_array)) {
        level.weapon_type_callback_array = [];
    }
    if (isstring(weapontype)) {
        weapontype = getweapon(weapontype);
    }
    level.weapon_type_callback_array[weapontype] = callback;
}

// Namespace callback/callbacks_shared
// Params 1, eflags: 0x0
// Checksum 0x6043fe74, Offset: 0x2108
// Size: 0x72
function spawned_weapon_type(localclientnum) {
    weapontype = self.weapon.rootweapon;
    if (isdefined(level.weapon_type_callback_array) && isdefined(level.weapon_type_callback_array[weapontype])) {
        self thread [[ level.weapon_type_callback_array[weapontype] ]](localclientnum);
    }
}

// Namespace callback/notetrack_callclientscript
// Params 1, eflags: 0x40
// Checksum 0x83b06548, Offset: 0x2188
// Size: 0x72
function event_handler[notetrack_callclientscript] codecallback_callclientscript(eventstruct) {
    if (!isdefined(level._animnotifyfuncs)) {
        return;
    }
    if (isdefined(level._animnotifyfuncs[eventstruct.label])) {
        self [[ level._animnotifyfuncs[eventstruct.label] ]](eventstruct.param);
    }
}

// Namespace callback/notetrack_callclientscriptonlevel
// Params 1, eflags: 0x40
// Checksum 0x72ecc2ec, Offset: 0x2208
// Size: 0x72
function event_handler[notetrack_callclientscriptonlevel] codecallback_callclientscriptonlevel(eventstruct) {
    if (!isdefined(level._animnotifyfuncs)) {
        return;
    }
    if (isdefined(level._animnotifyfuncs[eventstruct.label])) {
        level [[ level._animnotifyfuncs[eventstruct.label] ]](eventstruct.param);
    }
}

// Namespace callback/scene_init
// Params 1, eflags: 0x40
// Checksum 0x1547077, Offset: 0x2288
// Size: 0x54
function event_handler[scene_init] codecallback_serversceneinit(eventstruct) {
    if (isdefined(level.server_scenes[eventstruct.scene_name])) {
        level thread scene::init(eventstruct.scene_name);
    }
}

// Namespace callback/scene_play
// Params 1, eflags: 0x40
// Checksum 0x9d06fed8, Offset: 0x22e8
// Size: 0x6c
function event_handler[scene_play] codecallback_serversceneplay(eventstruct) {
    level thread scene_black_screen();
    if (isdefined(level.server_scenes[eventstruct.scene_name])) {
        level thread scene::play(eventstruct.scene_name);
    }
}

// Namespace callback/scene_stop
// Params 1, eflags: 0x40
// Checksum 0x7b80cdd4, Offset: 0x2360
// Size: 0x74
function event_handler[scene_stop] codecallback_serverscenestop(eventstruct) {
    level thread scene_black_screen();
    if (isdefined(level.server_scenes[eventstruct.scene_name])) {
        level thread scene::stop(eventstruct.scene_name, undefined, undefined, undefined, 1);
    }
}

// Namespace callback/callbacks_shared
// Params 0, eflags: 0x0
// Checksum 0x98d9fe3c, Offset: 0x23e0
// Size: 0x180
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
// Checksum 0x1882998f, Offset: 0x2568
// Size: 0x54
function event_handler[gadget_visionpulsereveal] codecallback_gadgetvisionpulse_reveal(eventstruct) {
    if (isdefined(level.gadgetvisionpulse_reveal_func)) {
        eventstruct.entity [[ level.gadgetvisionpulse_reveal_func ]](eventstruct.localclientnum, eventstruct.enable);
    }
}

