#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\dialog_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;

#namespace audio;

// Namespace audio/audio_shared
// Params 0, eflags: 0x2
// Checksum 0x3cf4febd, Offset: 0x4a8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"audio", &__init__, undefined, undefined);
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x2174cbd5, Offset: 0x4f0
// Size: 0xe4
function __init__() {
    snd_snapshot_init();
    callback::on_localclient_connect(&player_init);
    callback::on_localplayer_spawned(&local_player_spawn);
    callback::on_localplayer_spawned(&sndsprintbreath);
    level thread register_clientfields();
    level thread sndkillcam();
    setsoundcontext("foley", "normal");
    setsoundcontext("plr_impact", "");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x70b09649, Offset: 0x5e0
// Size: 0x43c
function register_clientfields() {
    clientfield::register("world", "sndMatchSnapshot", 1, 2, "int", &sndmatchsnapshot, 1, 0);
    clientfield::register("world", "sndFoleyContext", 1, 1, "int", &sndfoleycontext, 0, 0);
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
// Params 1, eflags: 0x0
// Checksum 0x57546fc5, Offset: 0xa28
// Size: 0xd4
function local_player_spawn(localclientnum) {
    if (!self function_60dbc438()) {
        return;
    }
    setsoundcontext("foley", "normal");
    if (!sessionmodeismultiplayergame() && !sessionmodeiswarzonegame()) {
        self thread sndmusicdeathwatcher();
    }
    self thread isplayerinfected();
    self thread snd_underwater(localclientnum);
    self thread clientvoicesetup(localclientnum);
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x6aa73845, Offset: 0xb08
// Size: 0xb4
function player_init(localclientnum) {
    if (issplitscreenhost(localclientnum)) {
        level thread bump_trigger_start(localclientnum);
        level thread init_audio_triggers(localclientnum);
        level thread sndrattle_grenade_client();
        startsoundrandoms(localclientnum);
        startsoundloops();
        startlineemitters();
        startrattles();
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xb4fdf055, Offset: 0xbc8
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
// Params 1, eflags: 0x0
// Checksum 0x9c860a58, Offset: 0xcd8
// Size: 0xcc
function clientvoicesetup(localclientnum) {
    self endon(#"death");
    if (isdefined(level.clientvoicesetup)) {
        [[ level.clientvoicesetup ]](localclientnum);
        return;
    }
    self.teamclientprefix = "vox_gen";
    self thread sndvonotify("playerbreathinsound", "sinper_hold");
    self thread sndvonotify("playerbreathoutsound", "sinper_exhale");
    self thread sndvonotify("playerbreathgaspsound", "sinper_gasp");
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x0
// Checksum 0xd9d70594, Offset: 0xdb0
// Size: 0x70
function sndvonotify(notifystring, dialog) {
    self endon(#"death");
    for (;;) {
        self waittill(notifystring);
        soundalias = self.teamclientprefix + "_" + dialog;
        self playsound(0, soundalias);
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x60e4767, Offset: 0xe28
// Size: 0x134
function snd_snapshot_init() {
    level._sndactivesnapshot = "default";
    level._sndnextsnapshot = "default";
    if (!util::is_frontend_map()) {
        if (sessionmodeiscampaigngame() && !function_a871673b() && !function_8f142bd9()) {
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
// Params 0, eflags: 0x0
// Checksum 0x29ffc573, Offset: 0xf68
// Size: 0x34
function sndlevelstartduck_shutoff() {
    level waittill(#"sndlevelstartduck_shutoff");
    snd_set_snapshot("default");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x31e67a9d, Offset: 0xfa8
// Size: 0xfe
function function_a871673b() {
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
// Params 0, eflags: 0x0
// Checksum 0x8e78b178, Offset: 0x10b0
// Size: 0x86
function function_8f142bd9() {
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
// Params 1, eflags: 0x0
// Checksum 0x18a7c9c5, Offset: 0x1140
// Size: 0x58
function snd_set_snapshot(state) {
    level._sndnextsnapshot = state;
    println("<dev string:x30>" + state + "<dev string:x4c>");
    level notify(#"new_bus");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xf98f2bc5, Offset: 0x11a0
// Size: 0xc6
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
// Params 2, eflags: 0x0
// Checksum 0xd278cd0f, Offset: 0x1270
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
    level thread soundrandom_notifywait(notify_name, randsound);
    while (true) {
        wait randomfloatrange(randsound.script_wait_min, randsound.script_wait_max);
        if (isdefined(randsound.script_sound) && isdefined(randsound.playing) && randsound.playing) {
            playsound(localclientnum, randsound.script_sound, randsound.origin);
        }
        /#
            if (getdvarint(#"debug_audio", 0) > 0) {
                print3d(randsound.origin, randsound.script_sound, (0, 0.8, 0), 1, 3, 45);
            }
        #/
    }
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x0
// Checksum 0xaf8ed08e, Offset: 0x1488
// Size: 0x72
function soundrandom_notifywait(notify_name, randsound) {
    while (true) {
        level waittill(notify_name);
        if (isdefined(randsound.playing) && randsound.playing) {
            randsound.playing = 0;
            continue;
        }
        randsound.playing = 1;
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x68b41175, Offset: 0x1508
// Size: 0xf6
function startsoundrandoms(localclientnum) {
    randoms = struct::get_array("random", "script_label");
    if (isdefined(randoms) && randoms.size > 0) {
        nscriptthreadedrandoms = 0;
        for (i = 0; i < randoms.size; i++) {
            if (isdefined(randoms[i].script_scripted)) {
                nscriptthreadedrandoms++;
            }
        }
        allocatesoundrandoms(randoms.size - nscriptthreadedrandoms);
        for (i = 0; i < randoms.size; i++) {
            thread soundrandom_thread(localclientnum, randoms[i]);
        }
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xa00b8efe, Offset: 0x1608
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
// Params 0, eflags: 0x0
// Checksum 0x2d2337d0, Offset: 0x1780
// Size: 0x3c
function soundloopcheckpointrestore() {
    level waittill(#"save_restore");
    soundloopemitter(self.script_sound, self.origin);
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x6dd28369, Offset: 0x17c8
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
// Params 1, eflags: 0x0
// Checksum 0xcd18ad23, Offset: 0x1950
// Size: 0x4c
function soundlinecheckpointrestore(target) {
    level waittill(#"save_restore");
    soundlineemitter(self.script_sound, self.origin, target.origin);
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x5fe189f5, Offset: 0x19a8
// Size: 0x15c
function startsoundloops() {
    loopers = struct::get_array("looper", "script_label");
    if (isdefined(loopers) && loopers.size > 0) {
        delay = 0;
        /#
            if (getdvarint(#"debug_audio", 0) > 0) {
                println("<dev string:x4e>" + loopers.size + "<dev string:x79>");
            }
        #/
        for (i = 0; i < loopers.size; i++) {
            loopers[i] thread soundloopthink();
            delay += 1;
            if (delay % 20 == 0) {
                waitframe(1);
            }
        }
        return;
    }
    /#
        if (getdvarint(#"debug_audio", 0) > 0) {
            println("<dev string:x84>");
        }
    #/
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x56a59981, Offset: 0x1b10
// Size: 0x15c
function startlineemitters() {
    lineemitters = struct::get_array("line_emitter", "script_label");
    if (isdefined(lineemitters) && lineemitters.size > 0) {
        delay = 0;
        /#
            if (getdvarint(#"debug_audio", 0) > 0) {
                println("<dev string:xa3>" + lineemitters.size + "<dev string:x79>");
            }
        #/
        for (i = 0; i < lineemitters.size; i++) {
            lineemitters[i] thread soundlinethink();
            delay += 1;
            if (delay % 20 == 0) {
                waitframe(1);
            }
        }
        return;
    }
    /#
        if (getdvarint(#"debug_audio", 0) > 0) {
            println("<dev string:xd4>");
        }
    #/
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x85058941, Offset: 0x1c78
// Size: 0xec
function startrattles() {
    rattles = struct::get_array("sound_rattle", "script_label");
    if (isdefined(rattles)) {
        println("<dev string:xf9>" + rattles.size + "<dev string:x100>");
        delay = 0;
        for (i = 0; i < rattles.size; i++) {
            soundrattlesetup(rattles[i].script_sound, rattles[i].origin);
            delay += 1;
            if (delay % 20 == 0) {
                waitframe(1);
            }
        }
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x74fd51fe, Offset: 0x1d70
// Size: 0x14c
function init_audio_triggers(localclientnum) {
    util::waitforclient(localclientnum);
    steptrigs = getentarray(localclientnum, "audio_step_trigger", "targetname");
    materialtrigs = getentarray(localclientnum, "audio_material_trigger", "targetname");
    /#
        if (getdvarint(#"debug_audio", 0) > 0) {
            println("<dev string:x109>" + steptrigs.size + "<dev string:x113>");
            println("<dev string:x109>" + materialtrigs.size + "<dev string:x129>");
        }
    #/
    array::thread_all(steptrigs, &audio_step_trigger, localclientnum);
    array::thread_all(materialtrigs, &audio_material_trigger, localclientnum);
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x2c21a8d3, Offset: 0x1ec8
// Size: 0x80
function audio_step_trigger(localclientnum) {
    self._localclientnum = localclientnum;
    for (;;) {
        waitresult = self waittill(#"trigger");
        self thread trigger::function_thread(waitresult.activator, &trig_enter_audio_step_trigger, &trig_leave_audio_step_trigger);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xaec95650, Offset: 0x1f50
// Size: 0x70
function audio_material_trigger(trig) {
    for (;;) {
        waitresult = self waittill(#"trigger");
        self thread trigger::function_thread(waitresult.activator, &trig_enter_audio_material_trigger, &trig_leave_audio_material_trigger);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xb2c7df14, Offset: 0x1fc8
// Size: 0x74
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
// Params 1, eflags: 0x0
// Checksum 0xf240ff58, Offset: 0x2048
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
// Params 1, eflags: 0x0
// Checksum 0x877889ad, Offset: 0x20e0
// Size: 0x154
function trig_enter_audio_step_trigger(trigplayer) {
    localclientnum = self._localclientnum;
    if (!isdefined(trigplayer.insteptrigger)) {
        trigplayer.insteptrigger = 0;
    }
    suffix = "_npc";
    if (trigplayer function_60dbc438()) {
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
// Params 1, eflags: 0x0
// Checksum 0x216f7841, Offset: 0x2240
// Size: 0x174
function trig_leave_audio_step_trigger(trigplayer) {
    localclientnum = self._localclientnum;
    suffix = "_npc";
    if (trigplayer function_60dbc438()) {
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
        println("<dev string:x143>");
        trigplayer.insteptrigger = 0;
    }
    if (trigplayer.insteptrigger == 0) {
        trigplayer.step_sound = "none";
        trigplayer clearsteptriggersound();
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x9988cbb5, Offset: 0x23c0
// Size: 0x86
function bump_trigger_start(localclientnum) {
    bump_trigs = getentarray(localclientnum, "audio_bump_trigger", "targetname");
    for (i = 0; i < bump_trigs.size; i++) {
        bump_trigs[i] thread thread_bump_trigger(localclientnum);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x78a51ee, Offset: 0x2450
// Size: 0xb0
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
// Params 1, eflags: 0x0
// Checksum 0x2491178a, Offset: 0x2508
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
        if (ent isplayer() && ent hasperk(localclientnum, "specialty_quieter")) {
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
// Params 2, eflags: 0x0
// Checksum 0x3646fbb6, Offset: 0x2708
// Size: 0x74
function mantle_wait(alias, localclientnum) {
    self endon(#"death");
    self endon(#"left_mantle");
    self waittill(#"traversesound");
    self playsound(localclientnum, alias, self.origin, 1);
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x371092b2, Offset: 0x2788
// Size: 0x28
function trig_leave_bump(ent) {
    wait 1;
    ent notify(#"left_mantle");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x47b0972a, Offset: 0x27b8
// Size: 0x2a
function bump_trigger_listener() {
    if (isdefined(self.script_label)) {
        level waittill(self.script_label);
        self.script_activated = 0;
    }
}

// Namespace audio/audio_shared
// Params 5, eflags: 0x0
// Checksum 0x6ea7e10f, Offset: 0x27f0
// Size: 0xbc
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
// Params 1, eflags: 0x0
// Checksum 0x44e04b62, Offset: 0x28b8
// Size: 0xd2
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
// Params 1, eflags: 0x0
// Checksum 0x43f742d6, Offset: 0x2998
// Size: 0x2c
function absolute_value(fowd) {
    if (fowd < 0) {
        return (fowd * -1);
    }
    return fowd;
}

// Namespace audio/audio_shared
// Params 3, eflags: 0x0
// Checksum 0xb8da7c26, Offset: 0x29d0
// Size: 0x1da
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
// Checksum 0x319cab20, Offset: 0x2bb8
// Size: 0x84
function snd_play_auto_fx(fxid, alias, offsetx, offsety, offsetz, onground, area, threshold, alias_override) {
    soundplayautofx(fxid, alias, offsetx, offsety, offsetz, onground, area, threshold, alias_override);
}

/#

    // Namespace audio/audio_shared
    // Params 3, eflags: 0x0
    // Checksum 0xc96f01ef, Offset: 0x2c48
    // Size: 0x74
    function snd_print_fx_id(fxid, type, ent) {
        if (getdvarint(#"debug_audio", 0) > 0) {
            println("<dev string:x18a>" + fxid + "<dev string:x19c>" + type);
        }
    }

#/

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x299670ac, Offset: 0x2cc8
// Size: 0x10e
function debug_line_emitter() {
    while (true) {
        /#
            if (getdvarint(#"debug_audio", 0) > 0) {
                line(self.start, self.end, (0, 1, 0));
                print3d(self.start, "<dev string:x1a6>", (0, 0.8, 0), 1, 3, 1);
                print3d(self.end, "<dev string:x1ac>", (0, 0.8, 0), 1, 3, 1);
                print3d(self.origin, self.script_sound, (0, 0.8, 0), 1, 3, 1);
            }
            waitframe(1);
        #/
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xa5188303, Offset: 0x2de0
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
// Params 2, eflags: 0x0
// Checksum 0x256f1503, Offset: 0x2ee8
// Size: 0x2c
function playloopat(aliasname, origin) {
    soundloopemitter(aliasname, origin);
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x0
// Checksum 0x3c9abeb, Offset: 0x2f20
// Size: 0x2c
function stoploopat(aliasname, origin) {
    soundstoploopemitter(aliasname, origin);
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xd04622d, Offset: 0x2f58
// Size: 0x34
function soundwait(id) {
    while (soundplaying(id)) {
        wait 0.1;
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x8028e6f4, Offset: 0x2f98
// Size: 0x370
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
        if (underwaternotify._notify == "swimming_end" && self isplayer() && isalive(self)) {
            self swimend(localclientnum);
        }
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xa56b5cd4, Offset: 0x3310
// Size: 0x34
function underwaterbegin() {
    level.audiosharedunderwater = 1;
    setsoundcontext("water_global", "under");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x6ebeece4, Offset: 0x3350
// Size: 0x34
function underwaterend() {
    level.audiosharedunderwater = 0;
    setsoundcontext("water_global", "over");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xd4d6dbbe, Offset: 0x3390
// Size: 0x12
function swimbegin() {
    self.audiosharedswimming = 1;
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xc3c5ca44, Offset: 0x33b0
// Size: 0x16
function swimend(localclientnum) {
    self.audiosharedswimming = 0;
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xb3583c9a, Offset: 0x33d0
// Size: 0x16
function swimcancel(localclientnum) {
    self.audiosharedswimming = 0;
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x0
// Checksum 0x39f9a37a, Offset: 0x33f0
// Size: 0xd6
function soundplayuidecodeloop(decodestring, playtimems) {
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
// Params 5, eflags: 0x0
// Checksum 0xde3a6e25, Offset: 0x34d0
// Size: 0x2c
function setcurrentambientstate(ambientroom, ambientpackage, roomcollidercent, packagecollidercent, defaultroom) {
    
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xbcb7aef5, Offset: 0x3508
// Size: 0x44
function isplayerinfected() {
    self endon(#"death");
    self.isinfected = 0;
    setsoundcontext("healthstate", "human");
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0x661e2b69, Offset: 0x3558
// Size: 0x11e
function sndcriticalhealth(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::function_2170ff73();
    if (function_9a47ed7f(localclientnum)) {
        return;
    }
    if (!isdefined(self)) {
        return;
    }
    if (!self function_60dbc438()) {
        return;
    }
    if (!isdefined(self.var_18ba4a3a)) {
        self.var_18ba4a3a = self.origin;
    }
    if (newval) {
        playsound(localclientnum, #"chr_health_lowhealth_enter", (0, 0, 0));
        playloopat("chr_health_lowhealth_loop", self.var_18ba4a3a);
        return;
    }
    stoploopat("chr_health_lowhealth_loop", self.var_18ba4a3a);
    self.var_18ba4a3a = undefined;
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0x23acec94, Offset: 0x3680
// Size: 0x11e
function sndlaststand(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::function_2170ff73();
    if (function_9a47ed7f(localclientnum)) {
        return;
    }
    if (!isdefined(self)) {
        return;
    }
    if (!self function_60dbc438()) {
        return;
    }
    if (!isdefined(self.sndlaststand)) {
        self.sndlaststand = self.origin;
    }
    if (newval) {
        playsound(localclientnum, #"chr_health_laststand_enter", (0, 0, 0));
        playloopat("chr_health_laststand_loop", self.sndlaststand);
        return;
    }
    stoploopat("chr_health_laststand_loop", self.sndlaststand);
    self.sndlaststand = undefined;
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0x75b8e796, Offset: 0x37a8
// Size: 0x62
function sndtacrig(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.sndtacrigemergencyreserve = 1;
        return;
    }
    self.sndtacrigemergencyreserve = 0;
}

// Namespace audio/audio_shared
// Params 3, eflags: 0x0
// Checksum 0x13cab200, Offset: 0x3818
// Size: 0x6c
function dorattle(origin, min, max) {
    if (isdefined(min) && min > 0) {
        if (isdefined(max) && max <= 0) {
            max = undefined;
        }
        soundrattle(origin, min, max);
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0xf8be3850, Offset: 0x3890
// Size: 0xf4
function sndrattle_server(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isdefined(self.model) && self.model == #"wpn_t7_bouncing_betty_world") {
            betty = getweapon(#"bouncingbetty");
            level thread dorattle(self.origin, betty.soundrattlerangemin, betty.soundrattlerangemax);
            return;
        }
        level thread dorattle(self.origin, 25, 600);
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x8ba13b80, Offset: 0x3990
// Size: 0x78
function sndrattle_grenade_client() {
    while (true) {
        waitresult = level waittill(#"explode");
        level thread dorattle(waitresult.position, waitresult.weapon.soundrattlerangemin, waitresult.weapon.soundrattlerangemax);
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0x95aa3a8f, Offset: 0x3a10
// Size: 0xb4
function weapon_butt_sounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.meleed = 1;
        level.mysnd = playsound(localclientnum, #"chr_melee_tinitus", (0, 0, 0));
        return;
    }
    self.meleed = 0;
    if (isdefined(level.mysnd)) {
        stopsound(level.mysnd);
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xb90220e3, Offset: 0x3ad0
// Size: 0x2c
function set_sound_context_defaults() {
    wait 2;
    setsoundcontext("foley", "normal");
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0x485dc89f, Offset: 0x3b08
// Size: 0xfc
function sndmatchsnapshot(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        switch (newval) {
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
// Params 7, eflags: 0x0
// Checksum 0x3a5e6c5e, Offset: 0x3c10
// Size: 0x5c
function sndfoleycontext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setsoundcontext("foley", "normal");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xbe013fe2, Offset: 0x3c78
// Size: 0x34
function sndkillcam() {
    level thread sndfinalkillcam_slowdown();
    level thread sndfinalkillcam_deactivate();
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xf882eae6, Offset: 0x3cb8
// Size: 0x40
function snddeath_activate() {
    while (true) {
        level waittill(#"sndded");
        snd_set_snapshot("mpl_death");
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xbf9de779, Offset: 0x3d00
// Size: 0x40
function snddeath_deactivate() {
    while (true) {
        level waittill(#"snddede");
        snd_set_snapshot("default");
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x77627e3c, Offset: 0x3d48
// Size: 0x28
function sndfinalkillcam_activate() {
    while (true) {
        level waittill(#"sndfks");
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xc6da7c63, Offset: 0x3d78
// Size: 0x28
function sndfinalkillcam_slowdown() {
    while (true) {
        level waittill(#"sndfksl");
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x7b673b1e, Offset: 0x3da8
// Size: 0x40
function sndfinalkillcam_deactivate() {
    while (true) {
        level waittill(#"sndfke");
        snd_set_snapshot("default");
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0xa06c1cfe, Offset: 0x3df0
// Size: 0x9c
function sndswitchvehiclecontext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self function_2a8c9709()) {
        setsoundcontext("plr_impact", "veh");
        return;
    }
    setsoundcontext("plr_impact", "");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x4ce9ef32, Offset: 0x3e98
// Size: 0x1a
function sndmusicdeathwatcher() {
    self waittill(#"death");
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0x4ccc81d, Offset: 0x3ec0
// Size: 0x1cc
function sndcchacking(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        switch (newval) {
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
    if (oldval == 1) {
        playsound(0, #"gdt_cybercore_hack_success_plr", (0, 0, 0));
        return;
    }
    if (oldval == 2) {
        playsound(0, #"gdt_cybercore_activate_fail_plr", (0, 0, 0));
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0x652e10b, Offset: 0x4098
// Size: 0x182
function sndigcsnapshot(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        switch (newval) {
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
// Params 7, eflags: 0x0
// Checksum 0xa79caee6, Offset: 0x4228
// Size: 0x64
function sndlevelstartsnapoff(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isdefined(level.sndigcsnapshotoverride) && level.sndigcsnapshotoverride) {
        }
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0xef49c961, Offset: 0x4298
// Size: 0x5c
function sndzmbfadein(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        snd_set_snapshot("default");
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0xc6ee8fe6, Offset: 0x4300
// Size: 0xd4
function sndchyronloop(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
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
// Params 1, eflags: 0x0
// Checksum 0xf5d08834, Offset: 0x43e0
// Size: 0x16c
function sndsprintbreath(localclientnum) {
    self endon(#"death");
    if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
        self.var_82a581ea = 0;
        var_fd4bcee7 = self dialog_shared::get_player_dialog_alias("exertBreatheSprinting");
        var_2f70a669 = self dialog_shared::get_player_dialog_alias("exertBreatheSprintingEnd");
        if (!isdefined(var_fd4bcee7) || !isdefined(var_2f70a669)) {
            return;
        }
        while (true) {
            if (isdefined(self)) {
                if (self isplayersprinting()) {
                    self thread sndbreathstart(var_fd4bcee7);
                    self thread function_70230b58(var_2f70a669);
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
// Params 1, eflags: 0x0
// Checksum 0x9ef32d7a, Offset: 0x4558
// Size: 0x64
function sndbreathstart(sound) {
    self endon(#"hash_4e899fa9b2775b4d");
    self endon(#"death");
    self waittill(#"hash_1d827c5a5cd4a607");
    if (isdefined(self)) {
        self thread function_1ca00aea(sound);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x78dc977a, Offset: 0x45c8
// Size: 0x68
function function_1ca00aea(sound) {
    self endon(#"death");
    self endon(#"hash_4e899fa9b2775b4d");
    self.var_82a581ea = 1;
    while (true) {
        self playsound(0, sound);
        wait 2.5;
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x4f677c2, Offset: 0x4638
// Size: 0x5e
function function_70230b58(sound) {
    self endon(#"death");
    self waittill(#"hash_4e899fa9b2775b4d");
    if (self.var_82a581ea) {
        self playsound(0, sound);
        self.var_82a581ea = 0;
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x5fa3ec1f, Offset: 0x46a0
// Size: 0x3c
function function_f24a9177(localclientnum) {
    self endon(#"death");
    if (isdefined(self)) {
        self thread function_62eacb23();
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x318560be, Offset: 0x46e8
// Size: 0xb8
function function_62eacb23() {
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
// Params 7, eflags: 0x0
// Checksum 0x672c39b5, Offset: 0x47a8
// Size: 0x64
function sndvehicledamagealarm(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"sndvehicledamagealarm");
    self thread function_c48632ec();
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x2a5434e6, Offset: 0x4818
// Size: 0xc4
function function_c48632ec() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"sndvehicledamagealarm");
    if (!isdefined(self.var_9226bdee)) {
        self.var_9226bdee = self playloopsound(#"hash_7a6b427867364957");
    }
    wait 2;
    if (isdefined(self.var_9226bdee)) {
        self stoploopsound(self.var_9226bdee);
        self.var_9226bdee = undefined;
    }
    self playsound(0, #"hash_26a4334032c725cb");
}

