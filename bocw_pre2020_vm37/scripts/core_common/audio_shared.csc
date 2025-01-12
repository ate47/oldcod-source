#using script_59f62971655f7103;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;

#namespace audio;

// Namespace audio/audio_shared
// Params 0, eflags: 0x6
// Checksum 0x213212e4, Offset: 0x5a8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"audio", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x32a69613, Offset: 0x5f0
// Size: 0x154
function private function_70a657d8() {
    snd_snapshot_init();
    callback::on_localclient_connect(&player_init);
    callback::on_localplayer_spawned(&local_player_spawn);
    callback::on_localplayer_spawned(&sndsprintbreath);
    callback::on_localplayer_spawned(&function_aa906715);
    callback::function_2870abef(&function_45e99595);
    callback::function_b27200db(&function_bc0a8bd8);
    level thread register_clientfields();
    level thread sndkillcam();
    setsoundcontext("plr_impact", "flesh");
    util::register_system(#"duckcmd", &function_c037c7cd);
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x40067f81, Offset: 0x750
// Size: 0x3f4
function register_clientfields() {
    clientfield::register("world", "sndMatchSnapshot", 1, 2, "int", &sndmatchsnapshot, 1, 0);
    clientfield::register("scriptmover", "sndRattle", 1, 1, "counter", &sndrattle_server, 1, 0);
    clientfield::register("allplayers", "sndRattle", 1, 1, "counter", &sndrattle_server, 1, 0);
    clientfield::register("toplayer", "sndMelee", 1, 1, "int", &weapon_butt_sounds, 1, 1);
    clientfield::register("vehicle", "sndSwitchVehicleContext", 1, 3, "int", &sndswitchvehiclecontext, 0, 0);
    clientfield::register("toplayer", "sndCCHacking", 1, 2, "int", &sndcchacking, 1, 1);
    clientfield::register("toplayer", "sndTacRig", 1, 1, "int", &sndtacrig, 0, 1);
    clientfield::register("toplayer", "sndLevelStartSnapOff", 1, 1, "int", &sndlevelstartsnapoff, 0, 1);
    clientfield::register("world", "sndIGCsnapshot", 1, 4, "int", &sndigcsnapshot, 1, 0);
    clientfield::register("world", "sndChyronLoop", 1, 1, "int", &sndchyronloop, 0, 0);
    clientfield::register("world", "sndZMBFadeIn", 1, 1, "int", &sndzmbfadein, 1, 0);
    clientfield::register("toplayer", "sndVehicleDamageAlarm", 1, 1, "counter", &sndvehicledamagealarm, 0, 0);
    clientfield::register("toplayer", "sndCriticalHealth", 1, 1, "int", &sndcriticalhealth, 0, 1);
    clientfield::register("toplayer", "sndLastStand", 1, 1, "int", &sndlaststand, 0, 0);
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xafff7365, Offset: 0xb50
// Size: 0x9c
function local_player_spawn(localclientnum) {
    if (!self function_21c0fa55()) {
        return;
    }
    if (!sessionmodeismultiplayergame() && !sessionmodeiswarzonegame()) {
        self thread sndmusicdeathwatcher();
    }
    self thread snd_underwater(localclientnum);
    self thread clientvoicesetup(localclientnum);
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xed0256ff, Offset: 0xbf8
// Size: 0x9c
function player_init(localclientnum) {
    if (issplitscreenhost(localclientnum)) {
        level thread bump_trigger_start(localclientnum);
        level thread init_audio_triggers(localclientnum);
        startsoundrandoms(localclientnum);
        startsoundloops();
        startlineemitters();
        startrattles();
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xba76e4a9, Offset: 0xca0
// Size: 0x84
function function_45e99595(*localclientnum) {
    if (!isdefined(self.var_ef6eb2d4)) {
        self.var_ef6eb2d4 = self battlechatter::get_player_dialog_alias("exertMantLight");
    }
    if (isdefined(self.var_ef6eb2d4) && soundexists(self.var_ef6eb2d4)) {
        self playsound(0, self.var_ef6eb2d4);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x3868fd27, Offset: 0xd30
// Size: 0x84
function function_bc0a8bd8(*localclientnum) {
    if (!isdefined(self.var_3991ee40)) {
        self.var_3991ee40 = self battlechatter::get_player_dialog_alias("exertMantHeavy");
    }
    if (isdefined(self.var_3991ee40) && soundexists(self.var_3991ee40)) {
        self playsound(0, self.var_3991ee40);
    }
}

// Namespace audio/audio_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x25a4429b, Offset: 0xdc0
// Size: 0x34
function function_c037c7cd(*clientnum, state, *oldstate) {
    snd_set_snapshot(oldstate);
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x712b1f78, Offset: 0xe00
// Size: 0x108
function snddoublejump_watcher() {
    self endon(#"death");
    while (true) {
        self waittill(#"doublejump_start");
        trace = tracepoint(self.origin, self.origin - (0, 0, 100000));
        trace_surface_type = trace[#"surfacetype"];
        trace_origin = trace[#"position"];
        if (!isdefined(trace) || !isdefined(trace_origin)) {
            continue;
        }
        if (!isdefined(trace_surface_type)) {
            trace_surface_type = "default";
        }
        playsound(0, #"veh_jetpack_surface_" + trace_surface_type, trace_origin);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xe5f2dce9, Offset: 0xf10
// Size: 0xbc
function clientvoicesetup(localclientnum) {
    self endon(#"death");
    if (isdefined(level.clientvoicesetup)) {
        [[ level.clientvoicesetup ]](localclientnum);
        return;
    }
    self thread sndvonotify("playerbreathinsound", "exert_sniper_hold");
    self thread sndvonotify("playerbreathoutsound", "exert_sniper_exhale");
    self thread sndvonotify("playerbreathgaspsound", "exert_sniper_gasp");
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xfa4cfd10, Offset: 0xfd8
// Size: 0xd8
function sndvonotify(notifystring, dialog) {
    self endon(#"death");
    for (;;) {
        self waittill(notifystring);
        if (!isdefined(self.voiceprefix)) {
            bundle = self getmpdialogname();
            playerbundle = getscriptbundle(bundle);
            if (!isdefined(playerbundle.voiceprefix)) {
                continue;
            }
            self.voiceprefix = playerbundle.voiceprefix;
        }
        soundalias = self.voiceprefix + dialog;
        self playsound(0, soundalias);
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x697fae59, Offset: 0x10b8
// Size: 0x11c
function snd_snapshot_init() {
    level._sndactivesnapshot = "default";
    level._sndnextsnapshot = "default";
    if (!util::is_frontend_map()) {
        if (sessionmodeiscampaigngame() && !function_22a92b8b() && !function_c9705ad4()) {
            level._sndactivesnapshot = "cmn_level_start";
            level._sndnextsnapshot = "cmn_level_start";
            level thread sndlevelstartduck_shutoff();
        }
        if (sessionmodeiszombiesgame()) {
            level._sndactivesnapshot = "zmb_game_start_nofade";
            level._sndnextsnapshot = "zmb_game_start_nofade";
        }
    }
    setgroupsnapshot(level._sndactivesnapshot);
    thread snd_snapshot_think();
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xbfe905ca, Offset: 0x11e0
// Size: 0x34
function sndlevelstartduck_shutoff() {
    level waittill(#"sndlevelstartduck_shutoff");
    snd_set_snapshot("default");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x245d944a, Offset: 0x1220
// Size: 0xfe
function function_22a92b8b() {
    ignore = 1;
    mapname = util::get_map_name();
    switch (mapname) {
    case #"hash_15642edd0e4376f1":
    case #"hash_5562580f1b903614":
    case #"hash_65a6e39408662d48":
    case #"hash_68bac554964f4148":
    case #"hash_7bdf016123a0147b":
        ignore = 0;
        break;
    }
    gametype = hash(util::get_game_type());
    switch (gametype) {
    case #"download":
        ignore = 1;
        break;
    }
    return ignore;
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x1ae69ff, Offset: 0x1328
// Size: 0x86
function function_c9705ad4() {
    ignore = 1;
    gametype = hash(util::get_game_type());
    switch (gametype) {
    case #"coop":
    case #"pvp":
        ignore = 0;
        break;
    }
    return ignore;
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xb4259b0b, Offset: 0x13b8
// Size: 0x60
function snd_set_snapshot(state) {
    level._sndnextsnapshot = state;
    println("<dev string:x38>" + state + "<dev string:x57>");
    level notify(#"new_bus");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xeffa5685, Offset: 0x1420
// Size: 0xc4
function snd_snapshot_think() {
    for (;;) {
        if (level._sndactivesnapshot == level._sndnextsnapshot) {
            level waittill(#"new_bus");
        }
        if (level._sndactivesnapshot == level._sndnextsnapshot) {
            continue;
        }
        assert(isdefined(level._sndnextsnapshot));
        assert(isdefined(level._sndactivesnapshot));
        setgroupsnapshot(level._sndnextsnapshot);
        level._sndactivesnapshot = level._sndnextsnapshot;
    }
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xfa84ecac, Offset: 0x14f0
// Size: 0x210
function soundrandom_thread(localclientnum, randsound) {
    if (!isdefined(randsound.script_wait_min)) {
        randsound.script_wait_min = 1;
    }
    if (!isdefined(randsound.script_wait_max)) {
        randsound.script_wait_max = 3;
    }
    notify_name = undefined;
    if (isdefined(randsound.script_string)) {
        notify_name = randsound.script_string;
    }
    if (!isdefined(notify_name) && isdefined(randsound.script_sound)) {
        createsoundrandom(randsound.origin, randsound.script_sound, randsound.script_wait_min, randsound.script_wait_max);
        return;
    }
    randsound.playing = 1;
    if (isdefined(randsound.script_int)) {
        randsound.playing = randsound.script_int != 0;
    }
    level thread soundrandom_notifywait(notify_name, randsound);
    while (true) {
        wait randomfloatrange(randsound.script_wait_min, randsound.script_wait_max);
        if (isdefined(randsound.script_sound) && is_true(randsound.playing)) {
            playsound(localclientnum, randsound.script_sound, randsound.origin);
        }
        /#
            if (getdvarint(#"debug_audio", 0) > 0) {
                print3d(randsound.origin, function_9e72a96(randsound.script_sound), (0, 0.8, 0), 1, 3, 45);
            }
        #/
    }
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x866e652c, Offset: 0x1708
// Size: 0x66
function soundrandom_notifywait(notify_name, randsound) {
    while (true) {
        level waittill(notify_name);
        if (is_true(randsound.playing)) {
            randsound.playing = 0;
            continue;
        }
        randsound.playing = 1;
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x7a455997, Offset: 0x1778
// Size: 0x134
function startsoundrandoms(localclientnum) {
    level.randoms = struct::get_array("random", "script_label");
    if (isdefined(level.randoms) && level.randoms.size > 0) {
        nscriptthreadedrandoms = 0;
        for (i = 0; i < level.randoms.size; i++) {
            if (isdefined(level.randoms[i].script_scripted)) {
                nscriptthreadedrandoms++;
            }
        }
        allocatesoundrandoms(level.randoms.size - nscriptthreadedrandoms);
        for (i = 0; i < level.randoms.size; i++) {
            level.randoms[i].angles = undefined;
            thread soundrandom_thread(localclientnum, level.randoms[i]);
        }
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x44840261, Offset: 0x18b8
// Size: 0x16a
function soundloopthink() {
    if (!isdefined(self.script_sound)) {
        return;
    }
    if (!isdefined(self.origin)) {
        return;
    }
    notifyname = "";
    assert(isdefined(notifyname));
    if (isdefined(self.script_string)) {
        notifyname = self.script_string;
    }
    assert(isdefined(notifyname));
    started = 1;
    if (isdefined(self.script_int)) {
        started = self.script_int != 0;
    }
    if (started) {
        soundloopemitter(self.script_sound, self.origin);
    }
    if (notifyname != "") {
        for (;;) {
            level waittill(notifyname);
            if (started) {
                soundstoploopemitter(self.script_sound, self.origin);
                self thread soundloopcheckpointrestore();
            } else {
                soundloopemitter(self.script_sound, self.origin);
            }
            started = !started;
        }
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x7c899da1, Offset: 0x1a30
// Size: 0x3c
function soundloopcheckpointrestore() {
    level waittill(#"save_restore");
    soundloopemitter(self.script_sound, self.origin);
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xa24bd570, Offset: 0x1a78
// Size: 0x17a
function soundlinethink() {
    if (!isdefined(self.target)) {
        return;
    }
    target = struct::get(self.target, "targetname");
    if (!isdefined(target)) {
        return;
    }
    notifyname = "";
    if (isdefined(self.script_string)) {
        notifyname = self.script_string;
    }
    started = 1;
    if (isdefined(self.script_int)) {
        started = self.script_int != 0;
    }
    if (started) {
        soundlineemitter(self.script_sound, self.origin, target.origin);
    }
    if (notifyname != "") {
        for (;;) {
            level waittill(notifyname);
            if (started) {
                soundstoplineemitter(self.script_sound, self.origin, target.origin);
                self thread soundlinecheckpointrestore(target);
            } else {
                soundlineemitter(self.script_sound, self.origin, target.origin);
            }
            started = !started;
        }
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xad2560a4, Offset: 0x1c00
// Size: 0x4c
function soundlinecheckpointrestore(target) {
    level waittill(#"save_restore");
    soundlineemitter(self.script_sound, self.origin, target.origin);
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x6845c04f, Offset: 0x1c58
// Size: 0x1a4
function startsoundloops() {
    level.loopers = struct::get_array("looper", "script_label");
    if (isdefined(level.loopers) && level.loopers.size > 0) {
        delay = 0;
        /#
            if (getdvarint(#"debug_audio", 0) > 0) {
                println("<dev string:x5c>" + level.loopers.size + "<dev string:x8a>");
            }
        #/
        for (i = 0; i < level.loopers.size; i++) {
            level.loopers[i].angles = undefined;
            level.loopers[i].script_label = undefined;
            level.loopers[i] thread soundloopthink();
            delay += 1;
            if (delay % 20 == 0) {
                waitframe(1);
            }
        }
        return;
    }
    /#
        if (getdvarint(#"debug_audio", 0) > 0) {
            println("<dev string:x98>");
        }
    #/
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xf58497b0, Offset: 0x1e08
// Size: 0x1a4
function startlineemitters() {
    level.lineemitters = struct::get_array("line_emitter", "script_label");
    if (isdefined(level.lineemitters) && level.lineemitters.size > 0) {
        delay = 0;
        /#
            if (getdvarint(#"debug_audio", 0) > 0) {
                println("<dev string:xba>" + level.lineemitters.size + "<dev string:x8a>");
            }
        #/
        for (i = 0; i < level.lineemitters.size; i++) {
            level.lineemitters[i].angles = undefined;
            level.lineemitters[i].script_label = undefined;
            level.lineemitters[i] thread soundlinethink();
            delay += 1;
            if (delay % 20 == 0) {
                waitframe(1);
            }
        }
        return;
    }
    /#
        if (getdvarint(#"debug_audio", 0) > 0) {
            println("<dev string:xee>");
        }
    #/
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xeb16cde9, Offset: 0x1fb8
// Size: 0x160
function startrattles() {
    rattles = struct::get_array("sound_rattle", "script_label");
    if (isdefined(rattles)) {
        println("<dev string:x116>" + rattles.size + "<dev string:x120>");
        delay = 0;
        for (i = 0; i < rattles.size; i++) {
            soundrattlesetup(rattles[i].script_sound, rattles[i].origin);
            delay += 1;
            if (delay % 20 == 0) {
                waitframe(1);
            }
        }
    }
    foreach (rattle in rattles) {
        rattle struct::delete();
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xad14ac29, Offset: 0x2120
// Size: 0x14c
function init_audio_triggers(localclientnum) {
    util::waitforclient(localclientnum);
    steptrigs = getentarray(localclientnum, "audio_step_trigger", "targetname");
    materialtrigs = getentarray(localclientnum, "audio_material_trigger", "targetname");
    /#
        if (getdvarint(#"debug_audio", 0) > 0) {
            println("<dev string:x12c>" + steptrigs.size + "<dev string:x139>");
            println("<dev string:x12c>" + materialtrigs.size + "<dev string:x152>");
        }
    #/
    array::thread_all(steptrigs, &audio_step_trigger, localclientnum);
    array::thread_all(materialtrigs, &audio_material_trigger, localclientnum);
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xf8951f5, Offset: 0x2278
// Size: 0xbe
function audio_step_trigger(*localclientnum) {
    var_887fc615 = self getentitynumber();
    while (true) {
        waitresult = self waittill(#"trigger");
        if (!waitresult.activator trigger::ent_already_in(var_887fc615)) {
            self thread trigger::function_thread(waitresult.activator, &trig_enter_audio_step_trigger, &trig_leave_audio_step_trigger);
        }
        waitframe(1);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x8407e147, Offset: 0x2340
// Size: 0x70
function audio_material_trigger(*trig) {
    for (;;) {
        waitresult = self waittill(#"trigger");
        self thread trigger::function_thread(waitresult.activator, &trig_enter_audio_material_trigger, &trig_leave_audio_material_trigger);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x7e5af002, Offset: 0x23b8
// Size: 0x6c
function trig_enter_audio_material_trigger(player) {
    if (!isdefined(player.inmaterialoverridetrigger)) {
        player.inmaterialoverridetrigger = 0;
    }
    if (isdefined(self.script_label)) {
        player.inmaterialoverridetrigger++;
        player.audiomaterialoverride = self.script_label;
        player setmaterialoverride(self.script_label);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xaf905daa, Offset: 0x2430
// Size: 0x8c
function trig_leave_audio_material_trigger(player) {
    if (isdefined(self.script_label)) {
        player.inmaterialoverridetrigger--;
        assert(player.inmaterialoverridetrigger >= 0);
        if (player.inmaterialoverridetrigger <= 0) {
            player.audiomaterialoverride = undefined;
            player.inmaterialoverridetrigger = 0;
            player clearmaterialoverride();
        }
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x2288fa6f, Offset: 0x24c8
// Size: 0x13c
function trig_enter_audio_step_trigger(trigplayer) {
    localclientnum = self._localclientnum;
    if (!isdefined(trigplayer.insteptrigger)) {
        trigplayer.insteptrigger = 0;
    }
    suffix = "_npc";
    if (trigplayer function_21c0fa55()) {
        suffix = "_plr";
    }
    if (isdefined(self.script_step_alias)) {
        trigplayer.step_sound = self.script_step_alias;
        trigplayer.insteptrigger += 1;
        trigplayer setsteptriggersound(self.script_step_alias + suffix);
    }
    if (isdefined(self.script_step_alias_enter) && trigplayer getmovementtype() == "sprint") {
        volume = get_vol_from_speed(trigplayer);
        trigplayer playsound(localclientnum, self.script_step_alias_enter + suffix, self.origin, volume);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x5ae05c0, Offset: 0x2610
// Size: 0x15c
function trig_leave_audio_step_trigger(trigplayer) {
    localclientnum = self._localclientnum;
    suffix = "_npc";
    if (trigplayer function_21c0fa55()) {
        suffix = "_plr";
    }
    if (isdefined(self.script_step_alias_exit) && trigplayer getmovementtype() == "sprint") {
        volume = get_vol_from_speed(trigplayer);
        trigplayer playsound(localclientnum, self.script_step_alias_exit + suffix, self.origin, volume);
    }
    if (isdefined(self.script_step_alias)) {
        trigplayer.insteptrigger -= 1;
    }
    if (trigplayer.insteptrigger < 0) {
        println("<dev string:x16f>");
        trigplayer.insteptrigger = 0;
    }
    if (trigplayer.insteptrigger == 0) {
        trigplayer.step_sound = "none";
        trigplayer clearsteptriggersound();
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xf1f01432, Offset: 0x2778
// Size: 0x7c
function bump_trigger_start(localclientnum) {
    bump_trigs = getentarray(localclientnum, "audio_bump_trigger", "targetname");
    for (i = 0; i < bump_trigs.size; i++) {
        bump_trigs[i] thread thread_bump_trigger(localclientnum);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x4a4adeb6, Offset: 0x2800
// Size: 0xa8
function thread_bump_trigger(localclientnum) {
    self thread bump_trigger_listener();
    if (!isdefined(self.script_activated)) {
        self.script_activated = 1;
    }
    self._localclientnum = localclientnum;
    for (;;) {
        waitresult = self waittill(#"trigger");
        self thread trigger::function_thread(waitresult.activator, &trig_enter_bump, &trig_leave_bump);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x8c5fb8a4, Offset: 0x28b0
// Size: 0x1f4
function trig_enter_bump(ent) {
    if (!isdefined(ent)) {
        return;
    }
    if (!isdefined(self.script_bump_volume_threshold)) {
        self.script_bump_volume_threshold = 0.75;
    }
    localclientnum = self._localclientnum;
    volume = get_vol_from_speed(ent);
    if (!sessionmodeiszombiesgame()) {
        if (isplayer(ent) && ent hasperk(localclientnum, "specialty_quieter")) {
            volume /= 2;
        }
    }
    if (isdefined(self.script_bump_alias) && self.script_activated) {
        self playsound(localclientnum, self.script_bump_alias, self.origin, volume);
    }
    if (isdefined(self.script_bump_alias_soft) && self.script_bump_volume_threshold > volume && self.script_activated) {
        self playsound(localclientnum, self.script_bump_alias_soft, self.origin, volume);
    }
    if (isdefined(self.script_bump_alias_hard) && self.script_bump_volume_threshold <= volume && self.script_activated) {
        self playsound(localclientnum, self.script_bump_alias_hard, self.origin, volume);
    }
    if (isdefined(self.script_mantle_alias) && self.script_activated) {
        ent thread mantle_wait(self.script_mantle_alias, localclientnum);
    }
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xe3b40aaa, Offset: 0x2ab0
// Size: 0x6c
function mantle_wait(alias, localclientnum) {
    self endon(#"death");
    self endon(#"left_mantle");
    self waittill(#"traversesound");
    self playsound(localclientnum, alias, self.origin, 1);
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x2a3bb395, Offset: 0x2b28
// Size: 0x28
function trig_leave_bump(ent) {
    wait 1;
    ent notify(#"left_mantle");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x2d854cb5, Offset: 0x2b58
// Size: 0x2a
function bump_trigger_listener() {
    if (isdefined(self.script_label)) {
        level waittill(self.script_label);
        self.script_activated = 0;
    }
}

// Namespace audio/audio_shared
// Params 5, eflags: 0x1 linked
// Checksum 0x1c90213, Offset: 0x2b90
// Size: 0xa4
function scale_speed(x1, x2, y1, y2, z) {
    if (z < x1) {
        z = x1;
    }
    if (z > x2) {
        z = x2;
    }
    dx = x2 - x1;
    n = (z - x1) / dx;
    dy = y2 - y1;
    w = n * dy + y1;
    return w;
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x994ddde4, Offset: 0x2c40
// Size: 0xca
function get_vol_from_speed(player) {
    min_speed = 20;
    max_speed = 200;
    max_vol = 1;
    min_vol = 0.1;
    speed = player getspeed();
    abs_speed = absolute_value(int(speed));
    volume = scale_speed(min_speed, max_speed, min_vol, max_vol, abs_speed);
    return volume;
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xe5aa1197, Offset: 0x2d18
// Size: 0x2c
function absolute_value(fowd) {
    if (fowd < 0) {
        return (fowd * -1);
    }
    return fowd;
}

// Namespace audio/audio_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xd72d7c29, Offset: 0x2d50
// Size: 0x1ae
function closest_point_on_line_to_point(point, linestart, lineend) {
    self endon(#"end line sound");
    linemagsqrd = lengthsquared(lineend - linestart);
    t = ((point[0] - linestart[0]) * (lineend[0] - linestart[0]) + (point[1] - linestart[1]) * (lineend[1] - linestart[1]) + (point[2] - linestart[2]) * (lineend[2] - linestart[2])) / linemagsqrd;
    if (t < 0) {
        self.origin = linestart;
        return;
    }
    if (t > 1) {
        self.origin = lineend;
        return;
    }
    start_x = linestart[0] + t * (lineend[0] - linestart[0]);
    start_y = linestart[1] + t * (lineend[1] - linestart[1]);
    start_z = linestart[2] + t * (lineend[2] - linestart[2]);
    self.origin = (start_x, start_y, start_z);
}

// Namespace audio/audio_shared
// Params 9, eflags: 0x0
// Checksum 0x938c5e3e, Offset: 0x2f08
// Size: 0x74
function snd_play_auto_fx(fxid, alias, offsetx, offsety, offsetz, onground, area, threshold, alias_override) {
    soundplayautofx(fxid, alias, offsetx, offsety, offsetz, onground, area, threshold, alias_override);
}

/#

    // Namespace audio/audio_shared
    // Params 3, eflags: 0x0
    // Checksum 0x8cf91911, Offset: 0x2f88
    // Size: 0x74
    function snd_print_fx_id(fxid, type, *ent) {
        if (getdvarint(#"debug_audio", 0) > 0) {
            println("<dev string:x1b9>" + type + "<dev string:x1ce>" + ent);
        }
    }

#/

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xcd164bed, Offset: 0x3008
// Size: 0x10e
function debug_line_emitter() {
    while (true) {
        /#
            if (getdvarint(#"debug_audio", 0) > 0) {
                line(self.start, self.end, (0, 1, 0));
                print3d(self.start, "<dev string:x1db>", (0, 0.8, 0), 1, 3, 1);
                print3d(self.end, "<dev string:x1e4>", (0, 0.8, 0), 1, 3, 1);
                print3d(self.origin, self.script_sound, (0, 0.8, 0), 1, 3, 1);
            }
            waitframe(1);
        #/
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x547e966f, Offset: 0x3120
// Size: 0x100
function move_sound_along_line() {
    closest_dist = undefined;
    /#
        self thread debug_line_emitter();
    #/
    while (true) {
        self closest_point_on_line_to_point(getlocalclientpos(0), self.start, self.end);
        if (isdefined(self.fake_ent)) {
            self.fake_ent.origin = self.origin;
        }
        closest_dist = distancesquared(getlocalclientpos(0), self.origin);
        if (closest_dist > 1048576) {
            wait 2;
            continue;
        }
        if (closest_dist > 262144) {
            wait 0.2;
            continue;
        }
        wait 0.05;
    }
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xc379dbeb, Offset: 0x3228
// Size: 0x2c
function playloopat(aliasname, origin) {
    soundloopemitter(aliasname, origin);
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xee46691, Offset: 0x3260
// Size: 0x2c
function stoploopat(aliasname, origin) {
    soundstoploopemitter(aliasname, origin);
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xaf493f, Offset: 0x3298
// Size: 0x34
function soundwait(id) {
    while (soundplaying(id)) {
        wait 0.1;
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xb63f28fa, Offset: 0x32d8
// Size: 0x378
function snd_underwater(localclientnum) {
    level endon(#"demo_jump");
    self endon(#"death");
    level endon("killcam_begin" + localclientnum);
    level endon("killcam_end" + localclientnum);
    self endon(#"sndenduwwatcher");
    if (!isdefined(level.audiosharedswimming)) {
        level.audiosharedswimming = 0;
    }
    if (!isdefined(level.audiosharedunderwater)) {
        level.audiosharedunderwater = 0;
    }
    setsoundcontext("water_global", "over");
    if (level.audiosharedswimming != isswimming(localclientnum)) {
        level.audiosharedswimming = isswimming(localclientnum);
        if (level.audiosharedswimming) {
            swimbegin();
        } else {
            swimcancel(localclientnum);
        }
    }
    if (level.audiosharedunderwater != isunderwater(localclientnum)) {
        level.audiosharedunderwater = isunderwater(localclientnum);
        if (level.audiosharedunderwater) {
            self underwaterbegin();
        } else {
            self underwaterend();
        }
    }
    while (true) {
        underwaternotify = self waittill(#"underwater_begin", #"underwater_end", #"swimming_begin", #"swimming_end", #"death", #"sndenduwwatcher");
        if (underwaternotify._notify == "death") {
            self underwaterend();
            self swimend(localclientnum);
        }
        if (underwaternotify._notify == "underwater_begin") {
            self underwaterbegin();
            continue;
        }
        if (underwaternotify._notify == "underwater_end") {
            self underwaterend();
            continue;
        }
        if (underwaternotify._notify == "swimming_begin") {
            self swimbegin();
            continue;
        }
        if (underwaternotify._notify == "swimming_end" && isplayer(self) && isalive(self)) {
            self swimend(localclientnum);
        }
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xe9d6acaf, Offset: 0x3658
// Size: 0x34
function underwaterbegin() {
    level.audiosharedunderwater = 1;
    setsoundcontext("water_global", "under");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x65a60178, Offset: 0x3698
// Size: 0x34
function underwaterend() {
    level.audiosharedunderwater = 0;
    setsoundcontext("water_global", "over");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xacef3641, Offset: 0x36d8
// Size: 0x12
function swimbegin() {
    self.audiosharedswimming = 1;
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xfacee47a, Offset: 0x36f8
// Size: 0x16
function swimend(*localclientnum) {
    self.audiosharedswimming = 0;
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x7e5b0d41, Offset: 0x3718
// Size: 0x16
function swimcancel(*localclientnum) {
    self.audiosharedswimming = 0;
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xb6d19bb4, Offset: 0x3738
// Size: 0xd6
function soundplayuidecodeloop(*decodestring, playtimems) {
    if (!isdefined(level.playinguidecodeloop) || !level.playinguidecodeloop) {
        level.playinguidecodeloop = 1;
        fake_ent = spawn(0, (0, 0, 0), "script_origin");
        if (isdefined(fake_ent)) {
            fake_ent playloopsound(#"uin_notify_data_loop");
            wait float(playtimems) / 1000;
            fake_ent stopallloopsounds(0);
        }
        level.playinguidecodeloop = undefined;
    }
}

// Namespace audio/audio_shared
// Params 5, eflags: 0x1 linked
// Checksum 0x1659513b, Offset: 0x3818
// Size: 0x2c
function setcurrentambientstate(*ambientroom, *ambientpackage, *roomcollidercent, *packagecollidercent, *defaultroom) {
    
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x3ec6fca6, Offset: 0x3850
// Size: 0x11e
function sndcriticalhealth(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    util::function_89a98f85();
    if (function_65b9eb0f(fieldname)) {
        return;
    }
    if (!isdefined(self)) {
        return;
    }
    if (!self function_21c0fa55()) {
        return;
    }
    if (!isdefined(self.var_2f6077ac)) {
        self.var_2f6077ac = self.origin;
    }
    if (bwastimejump) {
        playsound(fieldname, #"chr_health_lowhealth_enter", (0, 0, 0));
        playloopat("chr_health_lowhealth_loop", self.var_2f6077ac);
        return;
    }
    stoploopat("chr_health_lowhealth_loop", self.var_2f6077ac);
    self.var_2f6077ac = undefined;
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xa5af0c16, Offset: 0x3978
// Size: 0x11e
function sndlaststand(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    util::function_89a98f85();
    if (function_65b9eb0f(fieldname)) {
        return;
    }
    if (!isdefined(self)) {
        return;
    }
    if (!self function_21c0fa55()) {
        return;
    }
    if (!isdefined(self.sndlaststand)) {
        self.sndlaststand = self.origin;
    }
    if (bwastimejump) {
        playsound(fieldname, #"chr_health_laststand_enter", (0, 0, 0));
        playloopat("chr_health_laststand_loop", self.sndlaststand);
        return;
    }
    stoploopat("chr_health_laststand_loop", self.sndlaststand);
    self.sndlaststand = undefined;
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xa348da43, Offset: 0x3aa0
// Size: 0x62
function sndtacrig(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self.sndtacrigemergencyreserve = 1;
        return;
    }
    self.sndtacrigemergencyreserve = 0;
}

// Namespace audio/audio_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x61f1ded4, Offset: 0x3b10
// Size: 0x64
function dorattle(origin, min, max) {
    if (isdefined(min) && min > 0) {
        if (isdefined(max) && max <= 0) {
            max = undefined;
        }
        soundrattle(origin, min, max);
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xd46c867c, Offset: 0x3b80
// Size: 0xec
function sndrattle_server(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (isdefined(self.model) && self.model == #"wpn_t7_bouncing_betty_world") {
            betty = getweapon(#"bouncingbetty");
            level dorattle(self.origin, betty.soundrattlerangemin, betty.soundrattlerangemax);
            return;
        }
        level dorattle(self.origin, 25, 600);
    }
}

// Namespace audio/event_74314d75
// Params 1, eflags: 0x40
// Checksum 0xd18b22d3, Offset: 0x3c78
// Size: 0x4c
function event_handler[event_74314d75] function_b51c1cb9(eventstruct) {
    level dorattle(eventstruct.position, eventstruct.weapon.soundrattlerangemin, eventstruct.weapon.soundrattlerangemax);
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xc89a5704, Offset: 0x3cd0
// Size: 0xb4
function weapon_butt_sounds(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self.meleed = 1;
        level.mysnd = playsound(fieldname, #"chr_melee_tinitus", (0, 0, 0));
        return;
    }
    self.meleed = 0;
    if (isdefined(level.mysnd)) {
        stopsound(level.mysnd);
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x225934a6, Offset: 0x3d90
// Size: 0x114
function sndmatchsnapshot(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (sessionmodeiswarzonegame()) {
        return;
    }
    if (bwastimejump) {
        switch (bwastimejump) {
        case 1:
            snd_set_snapshot("mpl_prematch");
            break;
        case 2:
            snd_set_snapshot("mpl_postmatch");
            break;
        case 3:
            snd_set_snapshot("mpl_endmatch");
            break;
        }
        return;
    }
    snd_set_snapshot("default");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xadd1960f, Offset: 0x3eb0
// Size: 0x34
function sndkillcam() {
    level thread sndfinalkillcam_slowdown();
    level thread sndfinalkillcam_deactivate();
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xe75b5a3a, Offset: 0x3ef0
// Size: 0x40
function snddeath_activate() {
    while (true) {
        level waittill(#"sndded");
        snd_set_snapshot("mpl_death");
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xc9495349, Offset: 0x3f38
// Size: 0x40
function snddeath_deactivate() {
    while (true) {
        level waittill(#"snddede");
        snd_set_snapshot("default");
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x203086f, Offset: 0x3f80
// Size: 0x28
function sndfinalkillcam_activate() {
    while (true) {
        level waittill(#"sndfks");
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x20bd8874, Offset: 0x3fb0
// Size: 0x28
function sndfinalkillcam_slowdown() {
    while (true) {
        level waittill(#"sndfksl");
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x5370581e, Offset: 0x3fe0
// Size: 0x40
function sndfinalkillcam_deactivate() {
    while (true) {
        level waittill(#"sndfke");
        snd_set_snapshot("default");
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x80f7b103, Offset: 0x4028
// Size: 0xc4
function sndswitchvehiclecontext(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(self)) {
        return;
    }
    if (self isvehicle() && self function_4add50a7()) {
        setsoundcontext("plr_impact", "vehicle");
        return;
    }
    setsoundcontext("plr_impact", "flesh");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x66004e5e, Offset: 0x40f8
// Size: 0x1a
function sndmusicdeathwatcher() {
    self waittill(#"death");
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x7cefe426, Offset: 0x4120
// Size: 0x1cc
function sndcchacking(*localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        switch (bwastimejump) {
        case 1:
            playsound(0, #"gdt_cybercore_hack_start_plr", (0, 0, 0));
            self.hsnd = self playloopsound(#"gdt_cybercore_hack_lp_plr", 0.5);
            break;
        case 2:
            playsound(0, #"gdt_cybercore_prime_upg_plr", (0, 0, 0));
            self.hsnd = self playloopsound(#"gdt_cybercore_prime_loop_plr", 0.5);
            break;
        }
        return;
    }
    if (isdefined(self.hsnd)) {
        self stoploopsound(self.hsnd, 0.5);
    }
    if (fieldname == 1) {
        playsound(0, #"gdt_cybercore_hack_success_plr", (0, 0, 0));
        return;
    }
    if (fieldname == 2) {
        playsound(0, #"gdt_cybercore_activate_fail_plr", (0, 0, 0));
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xd76ff98d, Offset: 0x42f8
// Size: 0x184
function sndigcsnapshot(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        switch (bwastimejump) {
        case 1:
            snd_set_snapshot("cmn_igc_bg_lower");
            level.sndigcsnapshotoverride = 0;
            break;
        case 2:
            snd_set_snapshot("cmn_igc_amb_silent");
            level.sndigcsnapshotoverride = 1;
            break;
        case 3:
            snd_set_snapshot("cmn_igc_foley_lower");
            level.sndigcsnapshotoverride = 0;
            break;
        case 4:
            snd_set_snapshot("cmn_level_fadeout");
            level.sndigcsnapshotoverride = 0;
            break;
        case 5:
            snd_set_snapshot("cmn_level_fade_immediate");
            level.sndigcsnapshotoverride = 0;
            break;
        }
        return;
    }
    level.sndigcsnapshotoverride = 0;
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xf0cea420, Offset: 0x4488
// Size: 0x5e
function sndlevelstartsnapoff(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (is_true(level.sndigcsnapshotoverride)) {
        }
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x4d0893f1, Offset: 0x44f0
// Size: 0x5c
function sndzmbfadein(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        snd_set_snapshot("default");
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x5e447499, Offset: 0x4558
// Size: 0xd4
function sndchyronloop(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (!isdefined(level.chyronloop)) {
            level.chyronloop = spawn(0, (0, 0, 0), "script_origin");
            level.chyronloop playloopsound(#"uin_chyron_loop");
        }
        return;
    }
    if (isdefined(level.chyronloop)) {
        level.chyronloop delete();
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x24673770, Offset: 0x4638
// Size: 0x188
function function_aa906715() {
    self endon(#"death", #"disconnect", #"game_ended");
    if (self function_21c0fa55() && sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
        self.var_e4acdf73 = 0;
        var_1b0c36cc = self battlechatter::get_player_dialog_alias("exertGasCough");
        var_7f9cdb4f = self battlechatter::get_player_dialog_alias("exertGasGag");
        var_78ca4238 = self battlechatter::get_player_dialog_alias("exertGasGasp");
        if (!(isdefined(var_7f9cdb4f) && isdefined(var_1b0c36cc) && isdefined(var_78ca4238))) {
            return;
        }
        while (true) {
            self waittill(#"hash_59dc3b94303bbeac");
            self thread function_f041ffdb(var_1b0c36cc, var_7f9cdb4f);
            self waittill(#"hash_71bef43cb9e9e9f4");
            self thread function_deedd8d0(var_78ca4238);
            wait 0.1;
        }
    }
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xae8bafb7, Offset: 0x47c8
// Size: 0x64
function function_f041ffdb(var_1b0c36cc, var_7f9cdb4f) {
    self endon(#"death", #"hash_71bef43cb9e9e9f4");
    if (isdefined(self)) {
        self.var_7c77614c = gettime();
        self thread function_5e73e105(var_1b0c36cc, var_7f9cdb4f);
    }
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x934f7e1d, Offset: 0x4838
// Size: 0xf8
function function_5e73e105(var_1b0c36cc, var_7f9cdb4f) {
    self endon(#"death", #"disconnect", #"game_ended", #"hash_71bef43cb9e9e9f4");
    self.var_e4acdf73 = 1;
    while (true) {
        randomchance = randomfloatrange(0, 1);
        if (randomchance < 0.8) {
            self playsound(0, var_1b0c36cc);
        } else {
            self playsound(0, var_7f9cdb4f);
        }
        wait randomfloatrange(1.5, 3.5);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xee16bb88, Offset: 0x4938
// Size: 0x96
function function_deedd8d0(var_78ca4238) {
    self endon(#"death", #"hash_59dc3b94303bbeac");
    if (self.var_e4acdf73 && self.var_7c77614c + float(3) / 1000 > gettime()) {
        self playsound(0, var_78ca4238);
        self.var_e4acdf73 = 0;
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x7bb29da8, Offset: 0x49d8
// Size: 0x18c
function sndsprintbreath(*localclientnum) {
    self endon(#"death");
    if (self function_21c0fa55() && sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
        self.var_29054134 = 0;
        var_63112f76 = self battlechatter::get_player_dialog_alias("exertBreatheSprinting");
        var_dfb6f570 = self battlechatter::get_player_dialog_alias("exertBreatheSprintingEnd");
        if (!isdefined(var_63112f76) || !isdefined(var_dfb6f570)) {
            return;
        }
        while (true) {
            if (isdefined(self)) {
                if (self isplayersprinting()) {
                    self thread sndbreathstart(var_63112f76);
                    self thread function_ee6d1a7f(var_dfb6f570);
                    waitresult = self waittill(#"hash_4e899fa9b2775b4d", #"death");
                    if (waitresult._notify == "death") {
                        return;
                    }
                }
            }
            wait 0.1;
        }
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x44a0defc, Offset: 0x4b70
// Size: 0x64
function sndbreathstart(sound) {
    self endon(#"hash_4e899fa9b2775b4d");
    self endon(#"death");
    self waittill(#"hash_1d827c5a5cd4a607");
    if (isdefined(self)) {
        self thread function_d6bc7279(sound);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xb8ab727b, Offset: 0x4be0
// Size: 0x68
function function_d6bc7279(sound) {
    self endon(#"death");
    self endon(#"hash_4e899fa9b2775b4d");
    self.var_29054134 = 1;
    while (true) {
        self playsound(0, sound);
        wait 2.5;
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x82561736, Offset: 0x4c50
// Size: 0x5e
function function_ee6d1a7f(sound) {
    self endon(#"death");
    self waittill(#"hash_4e899fa9b2775b4d");
    if (self.var_29054134) {
        self playsound(0, sound);
        self.var_29054134 = 0;
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xcda46e28, Offset: 0x4cb8
// Size: 0x3c
function function_5da61577(*localclientnum) {
    self endon(#"death");
    if (isdefined(self)) {
        self thread function_bd07593a();
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x77143c5, Offset: 0x4d00
// Size: 0xb8
function function_bd07593a() {
    self endon(#"death");
    while (true) {
        if (self util::is_on_side(#"allies")) {
            if (self isplayersprinting()) {
                self playsound(0, #"hash_2dc9c76844261d06");
                wait 1;
            } else {
                self playsound(0, #"hash_70b507d0e243536d");
                wait 2.5;
            }
        }
        wait 0.1;
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x65e42cf, Offset: 0x4dc0
// Size: 0x64
function sndvehicledamagealarm(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self notify(#"sndvehicledamagealarm");
    self thread function_350920b9();
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xd751fd, Offset: 0x4e30
// Size: 0xc4
function function_350920b9() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"sndvehicledamagealarm");
    if (!isdefined(self.var_5730fa36)) {
        self.var_5730fa36 = self playloopsound(#"hash_7a6b427867364957");
    }
    wait 2;
    if (isdefined(self.var_5730fa36)) {
        self stoploopsound(self.var_5730fa36);
        self.var_5730fa36 = undefined;
    }
    self playsound(0, #"hash_26a4334032c725cb");
}

/#

    // Namespace audio/audio_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc07fa8ae, Offset: 0x4f00
    // Size: 0x164
    function function_31468a30(var_c75c63c) {
        soundloop = var_c75c63c.var_b6ce262a;
        if (isdefined(level.loopers)) {
            for (i = 0; i < level.loopers.size; i++) {
                if (!isdefined(level.loopers[i].script_sound)) {
                    level.loopers[i].origin = soundloop.origin;
                    level.loopers[i].script_sound = soundloop.script_sound;
                    level.loopers[i] thread soundloopthink();
                    return;
                }
            }
            index = level.loopers.size;
            arrayinsert(level.loopers, soundloop, index);
            level.loopers[index].angles = undefined;
            level.loopers[index].script_label = undefined;
            level.loopers[index] thread soundloopthink();
        }
    }

    // Namespace audio/event_2df6ae0f
    // Params 1, eflags: 0x40
    // Checksum 0xb2bf987f, Offset: 0x5070
    // Size: 0xc2
    function event_handler[event_2df6ae0f] function_5470fa95(var_c75c63c) {
        soundloop = var_c75c63c.var_b6ce262a;
        if (isdefined(level.loopers)) {
            index = var_c75c63c.index;
            if (index >= 0 && index < level.loopers.size) {
                soundstoploopemitter(soundloop.script_sound, soundloop.origin);
                level.loopers[index].origin = (0, 0, 0);
                level.loopers[index].script_sound = undefined;
            }
        }
    }

    // Namespace audio/event_7a92af95
    // Params 1, eflags: 0x40
    // Checksum 0x1b706f59, Offset: 0x5140
    // Size: 0x15c
    function event_handler[event_7a92af95] function_3fda4bf4(var_c75c63c) {
        soundloop = var_c75c63c.var_b6ce262a;
        if (isdefined(level.loopers) && isdefined(soundloop) && isdefined(soundloop.script_sound) && isdefined(soundloop.script_looping)) {
            index = var_c75c63c.index;
            if (index >= 0 && index < level.loopers.size) {
                level.loopers[index].origin = soundloop.origin;
                level.loopers[index].script_sound = soundloop.script_sound;
                level.loopers[index].script_looping = soundloop.script_looping;
                function_f03b7c11(index, level.loopers[index].script_sound, level.loopers[index].origin);
                return;
            }
            if (index == -2) {
                function_31468a30(var_c75c63c);
            }
        }
    }

    // Namespace audio/event_5295e5ef
    // Params 1, eflags: 0x40
    // Checksum 0x204e2b8e, Offset: 0x52a8
    // Size: 0xb2
    function event_handler[event_5295e5ef] function_882b5910(var_c75c63c) {
        soundloop = var_c75c63c.var_b6ce262a;
        level.var_7acea05a = -1;
        if (isdefined(level.loopers)) {
            for (i = 0; i < level.loopers.size; i++) {
                if (distancesquared(level.loopers[i].origin, soundloop.origin) < 1) {
                    level.var_7acea05a = i;
                    return;
                }
            }
        }
    }

    // Namespace audio/audio_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd4314109, Offset: 0x5368
    // Size: 0x184
    function function_4fb7ec9c(var_c75c63c) {
        var_2f7118b0 = var_c75c63c.var_b6ce262a;
        if (isdefined(level.lineemitters)) {
            for (i = 0; i < level.lineemitters.size; i++) {
                if (!isdefined(level.lineemitters[i].script_sound)) {
                    level.lineemitters[i].origin = var_2f7118b0.origin;
                    level.lineemitters[i].script_sound = var_2f7118b0.script_sound;
                    level.lineemitters[i].target = var_2f7118b0.target;
                    level.lineemitters[i] thread soundlinethink();
                    return;
                }
            }
            index = level.lineemitters.size;
            arrayinsert(level.lineemitters, var_2f7118b0, index);
            level.lineemitters[index].angles = undefined;
            level.lineemitters[index].script_label = undefined;
            level.lineemitters[index] thread soundlinethink();
        }
    }

    // Namespace audio/event_f61e7d0a
    // Params 1, eflags: 0x40
    // Checksum 0x2108307d, Offset: 0x54f8
    // Size: 0x122
    function event_handler[event_f61e7d0a] function_bbc6b84a(var_c75c63c) {
        var_2f7118b0 = var_c75c63c.var_b6ce262a;
        if (isdefined(level.lineemitters)) {
            index = var_c75c63c.index;
            if (index >= 0 && index < level.lineemitters.size) {
                target = struct::get(level.lineemitters[index].target, "<dev string:x1eb>");
                soundstoplineemitter(level.lineemitters[index].script_sound, level.lineemitters[index].origin, target.origin);
                level.lineemitters[index].origin = (0, 0, 0);
                level.lineemitters[index].script_sound = undefined;
            }
        }
    }

    // Namespace audio/event_70cd2720
    // Params 1, eflags: 0x40
    // Checksum 0xe66bceee, Offset: 0x5628
    // Size: 0x184
    function event_handler[event_70cd2720] function_4910c05b(var_c75c63c) {
        var_2f7118b0 = var_c75c63c.var_b6ce262a;
        if (isdefined(level.lineemitters) && isdefined(var_2f7118b0)) {
            index = var_c75c63c.index;
            if (index >= 0 && index < level.lineemitters.size) {
                level.lineemitters[index].origin = var_2f7118b0.origin;
                level.lineemitters[index].script_sound = var_2f7118b0.script_sound;
                level.lineemitters[index].target = var_2f7118b0.target;
                target = struct::get(level.lineemitters[index].target, "<dev string:x1eb>");
                if (isdefined(target)) {
                    function_15b81494(index, level.lineemitters[index].script_sound, level.lineemitters[index].origin, target.origin);
                }
                return;
            }
            if (index == -2) {
                function_4fb7ec9c(var_c75c63c);
            }
        }
    }

    // Namespace audio/event_edffbf97
    // Params 1, eflags: 0x40
    // Checksum 0x814751d, Offset: 0x57b8
    // Size: 0xb2
    function event_handler[event_edffbf97] function_ee6f0c88(var_c75c63c) {
        var_2f7118b0 = var_c75c63c.var_b6ce262a;
        level.var_7acea05a = -1;
        if (isdefined(level.lineemitters)) {
            for (i = 0; i < level.lineemitters.size; i++) {
                if (distancesquared(level.lineemitters[i].origin, var_2f7118b0.origin) < 1) {
                    level.var_7acea05a = i;
                    return;
                }
            }
        }
    }

    // Namespace audio/audio_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd4cf171, Offset: 0x5878
    // Size: 0x184
    function function_abd4ca1(var_c75c63c) {
        soundrandom = var_c75c63c.var_b6ce262a;
        if (isdefined(level.randoms)) {
            for (i = 0; i < level.randoms.size; i++) {
                if (!isdefined(level.randoms[i].script_sound)) {
                    level.randoms[i].origin = soundrandom.origin;
                    level.randoms[i].script_sound = soundrandom.script_sound;
                    level.randoms[i] thread soundrandom_thread(0, level.randoms[i]);
                    return;
                }
            }
            index = level.randoms.size;
            arrayinsert(level.randoms, soundrandom, index);
            level.randoms[index].angles = undefined;
            level.randoms[index].script_label = undefined;
            level.randoms[index] thread soundrandom_thread(0, level.randoms[index]);
        }
    }

    // Namespace audio/event_bfb86175
    // Params 1, eflags: 0x40
    // Checksum 0x353aa649, Offset: 0x5a08
    // Size: 0xce
    function event_handler[event_bfb86175] function_464598c8(var_c75c63c) {
        soundrandom = var_c75c63c.var_b6ce262a;
        if (isdefined(level.randoms)) {
            index = var_c75c63c.index;
            if (index >= 0 && index < level.randoms.size) {
                function_dac8758d(level.randoms[index].origin);
                level.randoms[index].origin = (0, 0, 0);
                level.randoms[index].script_sound = undefined;
            }
        }
    }

    // Namespace audio/event_43494658
    // Params 1, eflags: 0x40
    // Checksum 0x933ae82d, Offset: 0x5ae0
    // Size: 0x1b4
    function event_handler[event_43494658] function_12dface6(var_c75c63c) {
        soundrandom = var_c75c63c.var_b6ce262a;
        if (isdefined(level.randoms)) {
            index = var_c75c63c.index;
            neworigin = var_c75c63c.neworigin;
            if (index >= 0 && index < level.randoms.size) {
                if (isdefined(soundrandom.script_wait_min)) {
                    level.randoms[index].script_wait_min = soundrandom.script_wait_min;
                }
                if (isdefined(soundrandom.script_wait_max)) {
                    level.randoms[index].script_wait_max = soundrandom.script_wait_max;
                }
                level.randoms[index].script_sound = soundrandom.script_sound;
                function_12dface6(level.randoms[index].origin, neworigin, level.randoms[index].script_sound, level.randoms[index].script_wait_min, level.randoms[index].script_wait_max);
                level.randoms[index].origin = neworigin;
                return;
            }
            if (index == -2) {
                var_c75c63c.var_b6ce262a.origin = neworigin;
                function_abd4ca1(var_c75c63c);
            }
        }
    }

    // Namespace audio/event_8c00f89
    // Params 1, eflags: 0x40
    // Checksum 0x83749bc3, Offset: 0x5ca0
    // Size: 0xb2
    function event_handler[event_8c00f89] function_8673317e(var_c75c63c) {
        soundrandom = var_c75c63c.var_b6ce262a;
        level.var_7acea05a = -1;
        if (isdefined(level.randoms)) {
            for (i = 0; i < level.randoms.size; i++) {
                if (distancesquared(level.randoms[i].origin, soundrandom.origin) < 1) {
                    level.var_7acea05a = i;
                    return;
                }
            }
        }
    }

#/
