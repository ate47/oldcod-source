#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/music_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/trigger_shared;
#using scripts/core_common/util_shared;

#namespace audio;

// Namespace audio/audio_shared
// Params 0, eflags: 0x2
// Checksum 0x91c0b824, Offset: 0x858
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("audio", &__init__, undefined, undefined);
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xc48ba5f2, Offset: 0x898
// Size: 0xfc
function __init__() {
    snd_snapshot_init();
    callback::on_localclient_connect(&player_init);
    callback::on_localplayer_spawned(&local_player_spawn);
    callback::on_localplayer_spawned(&sndsprintbreath);
    level thread register_clientfields();
    level thread sndkillcam();
    level thread function_b8573880();
    setsoundcontext("foley", "normal");
    setsoundcontext("plr_impact", "");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xf87d3197, Offset: 0x9a0
// Size: 0x31c
function register_clientfields() {
    clientfield::register("world", "sndMatchSnapshot", 1, 2, "int", &sndmatchsnapshot, 1, 0);
    clientfield::register("world", "sndFoleyContext", 1, 1, "int", &sndfoleycontext, 0, 0);
    clientfield::register("scriptmover", "sndRattle", 1, 1, "int", &sndrattle_server, 1, 0);
    clientfield::register("toplayer", "sndMelee", 1, 1, "int", &weapon_butt_sounds, 1, 1);
    clientfield::register("vehicle", "sndSwitchVehicleContext", 1, 3, "int", &sndswitchvehiclecontext, 0, 0);
    clientfield::register("toplayer", "sndCCHacking", 1, 2, "int", &sndcchacking, 1, 1);
    clientfield::register("toplayer", "sndTacRig", 1, 1, "int", &sndtacrig, 0, 1);
    clientfield::register("toplayer", "sndLevelStartSnapOff", 1, 1, "int", &sndlevelstartsnapoff, 0, 1);
    clientfield::register("world", "sndIGCsnapshot", 1, 4, "int", &sndigcsnapshot, 1, 0);
    clientfield::register("world", "sndChyronLoop", 1, 1, "int", &sndchyronloop, 0, 0);
    clientfield::register("world", "sndZMBFadeIn", 1, 1, "int", &sndzmbfadein, 1, 0);
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x41e6daae, Offset: 0xcc8
// Size: 0xec
function local_player_spawn(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    setsoundcontext("foley", "normal");
    if (!sessionmodeismultiplayergame()) {
        if (isdefined(level._lastmusicstate)) {
            soundsetmusicstate(level._lastmusicstate);
        }
        self thread sndmusicdeathwatcher();
    }
    self thread isplayerinfected();
    self thread snd_underwater(localclientnum);
    self thread clientvoicesetup(localclientnum);
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x905dfb98, Offset: 0xdc0
// Size: 0xbc
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
// Checksum 0x33163a39, Offset: 0xe88
// Size: 0xf8
function snddoublejump_watcher() {
    self endon(#"death");
    while (true) {
        self waittill("doublejump_start");
        trace = tracepoint(self.origin, self.origin - (0, 0, 100000));
        trace_surface_type = trace["surfacetype"];
        trace_origin = trace["position"];
        if (!isdefined(trace) || !isdefined(trace_origin)) {
            continue;
        }
        if (!isdefined(trace_surface_type)) {
            trace_surface_type = "default";
        }
        playsound(0, "veh_jetpack_surface_" + trace_surface_type, trace_origin);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xaf9a84c9, Offset: 0xf88
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
// Checksum 0x906b9230, Offset: 0x1060
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
// Checksum 0x3425f37a, Offset: 0x10d8
// Size: 0x10c
function snd_snapshot_init() {
    level._sndactivesnapshot = "default";
    level._sndnextsnapshot = "default";
    mapname = getdvarstring("mapname");
    if (mapname !== "core_frontend") {
        if (sessionmodeiscampaigngame()) {
            level._sndactivesnapshot = "cmn_level_start";
            level._sndnextsnapshot = "cmn_level_start";
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
// Checksum 0x8296c07e, Offset: 0x11f0
// Size: 0x28
function function_23cf79ea() {
    level endon(#"hash_76eb38a5");
    level waittilltimeout(20, "sndOn");
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xa4b1c8f3, Offset: 0x1220
// Size: 0x5c
function snd_set_snapshot(state) {
    level._sndnextsnapshot = state;
    /#
        println("<dev string:x28>" + state + "<dev string:x44>");
    #/
    level notify(#"new_bus");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xe945957b, Offset: 0x1288
// Size: 0xd8
function snd_snapshot_think() {
    for (;;) {
        if (level._sndactivesnapshot == level._sndnextsnapshot) {
            level waittill("new_bus");
        }
        if (level._sndactivesnapshot == level._sndnextsnapshot) {
            continue;
        }
        /#
            assert(isdefined(level._sndnextsnapshot));
        #/
        /#
            assert(isdefined(level._sndactivesnapshot));
        #/
        setgroupsnapshot(level._sndnextsnapshot);
        level._sndactivesnapshot = level._sndnextsnapshot;
    }
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x0
// Checksum 0x2641457e, Offset: 0x1368
// Size: 0x230
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
        if (isdefined(randsound.playing) && isdefined(randsound.script_sound) && randsound.playing) {
            playsound(localclientnum, randsound.script_sound, randsound.origin);
        }
        /#
            if (getdvarint("<dev string:x46>") > 0) {
                print3d(randsound.origin, randsound.script_sound, (0, 0.8, 0), 1, 3, 45);
            }
        #/
    }
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x0
// Checksum 0xd10f6f3, Offset: 0x15a0
// Size: 0x7c
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
// Checksum 0xef554861, Offset: 0x1628
// Size: 0x106
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
// Checksum 0xc577ee3d, Offset: 0x1738
// Size: 0x194
function soundloopthink() {
    if (!isdefined(self.script_sound)) {
        return;
    }
    if (!isdefined(self.origin)) {
        return;
    }
    notifyname = "";
    /#
        assert(isdefined(notifyname));
    #/
    if (isdefined(self.script_string)) {
        notifyname = self.script_string;
    }
    /#
        assert(isdefined(notifyname));
    #/
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
// Checksum 0x4a3906eb, Offset: 0x18d8
// Size: 0x34
function soundloopcheckpointrestore() {
    level waittill("save_restore");
    soundloopemitter(self.script_sound, self.origin);
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x14af762f, Offset: 0x1918
// Size: 0x19c
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
// Checksum 0x6cfc56ff, Offset: 0x1ac0
// Size: 0x4c
function soundlinecheckpointrestore(target) {
    level waittill("save_restore");
    soundlineemitter(self.script_sound, self.origin, target.origin);
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xdfaa5bd6, Offset: 0x1b18
// Size: 0x154
function startsoundloops() {
    loopers = struct::get_array("looper", "script_label");
    if (isdefined(loopers) && loopers.size > 0) {
        delay = 0;
        /#
            if (getdvarint("<dev string:x46>") > 0) {
                println("<dev string:x52>" + loopers.size + "<dev string:x7d>");
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
        if (getdvarint("<dev string:x46>") > 0) {
            println("<dev string:x88>");
        }
    #/
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xf128b465, Offset: 0x1c78
// Size: 0x154
function startlineemitters() {
    lineemitters = struct::get_array("line_emitter", "script_label");
    if (isdefined(lineemitters) && lineemitters.size > 0) {
        delay = 0;
        /#
            if (getdvarint("<dev string:x46>") > 0) {
                println("<dev string:xa7>" + lineemitters.size + "<dev string:x7d>");
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
        if (getdvarint("<dev string:x46>") > 0) {
            println("<dev string:xd8>");
        }
    #/
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x4fcbfeba, Offset: 0x1dd8
// Size: 0x106
function startrattles() {
    rattles = struct::get_array("sound_rattle", "script_label");
    if (isdefined(rattles)) {
        /#
            println("<dev string:xfd>" + rattles.size + "<dev string:x104>");
        #/
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
// Checksum 0xe11abf2, Offset: 0x1ee8
// Size: 0x154
function init_audio_triggers(localclientnum) {
    util::waitforclient(localclientnum);
    steptrigs = getentarray(localclientnum, "audio_step_trigger", "targetname");
    materialtrigs = getentarray(localclientnum, "audio_material_trigger", "targetname");
    /#
        if (getdvarint("<dev string:x46>") > 0) {
            println("<dev string:x10d>" + steptrigs.size + "<dev string:x117>");
            println("<dev string:x10d>" + materialtrigs.size + "<dev string:x12d>");
        }
    #/
    array::thread_all(steptrigs, &audio_step_trigger, localclientnum);
    array::thread_all(materialtrigs, &audio_material_trigger, localclientnum);
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x1123be1f, Offset: 0x2048
// Size: 0x78
function audio_step_trigger(localclientnum) {
    self._localclientnum = localclientnum;
    for (;;) {
        waitresult = self waittill("trigger");
        self thread trigger::function_thread(waitresult.activator, &trig_enter_audio_step_trigger, &trig_leave_audio_step_trigger);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x9617cc87, Offset: 0x20c8
// Size: 0x68
function audio_material_trigger(trig) {
    for (;;) {
        waitresult = self waittill("trigger");
        self thread trigger::function_thread(waitresult.activator, &trig_enter_audio_material_trigger, &trig_leave_audio_material_trigger);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x9e7c5214, Offset: 0x2138
// Size: 0x84
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
// Checksum 0x92d597ad, Offset: 0x21c8
// Size: 0x9c
function trig_leave_audio_material_trigger(player) {
    if (isdefined(self.script_label)) {
        player.inmaterialoverridetrigger--;
        /#
            /#
                assert(player.inmaterialoverridetrigger >= 0);
            #/
        #/
        if (player.inmaterialoverridetrigger <= 0) {
            player.audiomaterialoverride = undefined;
            player.inmaterialoverridetrigger = 0;
            player clearmaterialoverride();
        }
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xaea53899, Offset: 0x2270
// Size: 0x17c
function trig_enter_audio_step_trigger(trigplayer) {
    localclientnum = self._localclientnum;
    if (!isdefined(trigplayer.insteptrigger)) {
        trigplayer.insteptrigger = 0;
    }
    suffix = "_npc";
    if (trigplayer islocalplayer()) {
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
// Checksum 0xfa0baf6e, Offset: 0x23f8
// Size: 0x19c
function trig_leave_audio_step_trigger(trigplayer) {
    localclientnum = self._localclientnum;
    suffix = "_npc";
    if (trigplayer islocalplayer()) {
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
        /#
            println("<dev string:x147>");
        #/
        trigplayer.insteptrigger = 0;
    }
    if (trigplayer.insteptrigger == 0) {
        trigplayer.step_sound = "none";
        trigplayer clearsteptriggersound();
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xb79a160, Offset: 0x25a0
// Size: 0x8e
function bump_trigger_start(localclientnum) {
    bump_trigs = getentarray(localclientnum, "audio_bump_trigger", "targetname");
    for (i = 0; i < bump_trigs.size; i++) {
        bump_trigs[i] thread thread_bump_trigger(localclientnum);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x4684d02a, Offset: 0x2638
// Size: 0xb0
function thread_bump_trigger(localclientnum) {
    self thread bump_trigger_listener();
    if (!isdefined(self.script_activated)) {
        self.script_activated = 1;
    }
    self._localclientnum = localclientnum;
    for (;;) {
        waitresult = self waittill("trigger");
        self thread trigger::function_thread(waitresult.activator, &trig_enter_bump, &trig_leave_bump);
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x4433f9e7, Offset: 0x26f0
// Size: 0x21c
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
        ent playsound(localclientnum, self.script_bump_alias, self.origin, volume);
    }
    if (isdefined(self.script_bump_alias_soft) && self.script_bump_volume_threshold > volume && self.script_activated) {
        ent playsound(localclientnum, self.script_bump_alias_soft, self.origin, volume);
    }
    if (isdefined(self.script_bump_alias_hard) && self.script_bump_volume_threshold <= volume && self.script_activated) {
        ent playsound(localclientnum, self.script_bump_alias_hard, self.origin, volume);
    }
    if (isdefined(self.script_mantle_alias) && self.script_activated) {
        ent thread mantle_wait(self.script_mantle_alias, localclientnum);
    }
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x0
// Checksum 0xed2bbc2f, Offset: 0x2918
// Size: 0x64
function mantle_wait(alias, localclientnum) {
    self endon(#"death");
    self endon(#"left_mantle");
    self waittill("traversesound");
    self playsound(localclientnum, alias, self.origin, 1);
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xc66d470c, Offset: 0x2988
// Size: 0x20
function trig_leave_bump(ent) {
    wait 1;
    ent notify(#"left_mantle");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x176ef262, Offset: 0x29b0
// Size: 0x34
function bump_trigger_listener() {
    if (isdefined(self.script_label)) {
        level waittill(self.script_label);
        self.script_activated = 0;
    }
}

// Namespace audio/audio_shared
// Params 5, eflags: 0x0
// Checksum 0x3d43d1e6, Offset: 0x29f0
// Size: 0xcc
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
// Checksum 0x699f3e6a, Offset: 0x2ac8
// Size: 0xe4
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
// Checksum 0xbd5c9623, Offset: 0x2bb8
// Size: 0x2e
function absolute_value(fowd) {
    if (fowd < 0) {
        return (fowd * -1);
    }
    return fowd;
}

// Namespace audio/audio_shared
// Params 3, eflags: 0x0
// Checksum 0xf8d7f76d, Offset: 0x2bf0
// Size: 0x1e8
function closest_point_on_line_to_point(point, linestart, lineend) {
    self endon(#"hash_18e2bbbb");
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
// Checksum 0xdd9a9066, Offset: 0x2de0
// Size: 0x84
function snd_play_auto_fx(fxid, alias, offsetx, offsety, offsetz, onground, area, threshold, alias_override) {
    soundplayautofx(fxid, alias, offsetx, offsety, offsetz, onground, area, threshold, alias_override);
}

/#

    // Namespace audio/audio_shared
    // Params 3, eflags: 0x0
    // Checksum 0xcd99bb8d, Offset: 0x2e70
    // Size: 0x6c
    function snd_print_fx_id(fxid, type, ent) {
        if (getdvarint("<dev string:x46>") > 0) {
            println("<dev string:x18e>" + fxid + "<dev string:x1a0>" + type);
        }
    }

#/

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x467c994, Offset: 0x2ee8
// Size: 0x116
function debug_line_emitter() {
    while (true) {
        /#
            if (getdvarint("<dev string:x46>") > 0) {
                line(self.start, self.end, (0, 1, 0));
                print3d(self.start, "<dev string:x1aa>", (0, 0.8, 0), 1, 3, 1);
                print3d(self.end, "<dev string:x1b0>", (0, 0.8, 0), 1, 3, 1);
                print3d(self.origin, self.script_sound, (0, 0.8, 0), 1, 3, 1);
            }
            waitframe(1);
        #/
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x9f9168aa, Offset: 0x3008
// Size: 0x10c
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
// Checksum 0xe7ce7724, Offset: 0x3120
// Size: 0x2c
function playloopat(aliasname, origin) {
    soundloopemitter(aliasname, origin);
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x0
// Checksum 0x17083310, Offset: 0x3158
// Size: 0x2c
function stoploopat(aliasname, origin) {
    soundstoploopemitter(aliasname, origin);
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x8000288, Offset: 0x3190
// Size: 0x34
function soundwait(id) {
    while (soundplaying(id)) {
        wait 0.1;
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x1a27d0cc, Offset: 0x31d0
// Size: 0x338
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
        underwaternotify = self waittill("underwater_begin", "underwater_end", "swimming_begin", "swimming_end", "death", "sndEndUWWatcher");
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
// Checksum 0xddc684a4, Offset: 0x3510
// Size: 0x14
function underwaterbegin() {
    level.audiosharedunderwater = 1;
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x3942c33d, Offset: 0x3530
// Size: 0x14
function underwaterend() {
    level.audiosharedunderwater = 0;
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xc4a7aedd, Offset: 0x3550
// Size: 0x68
function function_b8573880() {
    level waittill("pfx_igc_on");
    setsoundcontext("igc", "on");
    level waittill("pfx_igc_off");
    setsoundcontext("igc", "");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xd513fce5, Offset: 0x35c0
// Size: 0x14
function swimbegin() {
    self.audiosharedswimming = 1;
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xc9b9b0e6, Offset: 0x35e0
// Size: 0x18
function swimend(localclientnum) {
    self.audiosharedswimming = 0;
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0x1ef0add3, Offset: 0x3600
// Size: 0x18
function swimcancel(localclientnum) {
    self.audiosharedswimming = 0;
}

// Namespace audio/audio_shared
// Params 2, eflags: 0x0
// Checksum 0xd7219e4f, Offset: 0x3620
// Size: 0xce
function soundplayuidecodeloop(decodestring, playtimems) {
    if (!isdefined(level.playinguidecodeloop) || !level.playinguidecodeloop) {
        level.playinguidecodeloop = 1;
        fake_ent = spawn(0, (0, 0, 0), "script_origin");
        if (isdefined(fake_ent)) {
            fake_ent playloopsound("uin_notify_data_loop");
            wait playtimems / 1000;
            fake_ent stopallloopsounds(0);
        }
        level.playinguidecodeloop = undefined;
    }
}

// Namespace audio/audio_shared
// Params 5, eflags: 0x0
// Checksum 0xadafd59, Offset: 0x36f8
// Size: 0x2c
function setcurrentambientstate(ambientroom, ambientpackage, roomcollidercent, packagecollidercent, defaultroom) {
    
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xe56893db, Offset: 0x3730
// Size: 0x3c
function isplayerinfected() {
    self endon(#"death");
    self.isinfected = 0;
    setsoundcontext("healthstate", "human");
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0xe59226b3, Offset: 0x3778
// Size: 0x35e
function function_e1ab476f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_9953d541 = "chr_health_lowhealth_enter";
    var_9446a781 = "chr_health_lowhealth_exit";
    var_177599f1 = "chr_health_laststand_exit";
    var_dc3140c4 = "chr_health_dni_repair";
    if (newval) {
        switch (newval) {
        case 1:
            self.lowhealth = 1;
            playsound(localclientnum, var_9953d541, (0, 0, 0));
            forceambientroom("sndHealth_LowHealth");
            self thread function_451c4dae(localclientnum, var_dc3140c4, 0.4, 0.8);
            break;
        case 2:
            playsound(localclientnum, "chr_health_laststand_enter", (0, 0, 0));
            forceambientroom("sndHealth_LastStand");
            self notify(#"hash_2b4649a6");
            setsoundcontext("laststand", "active");
            break;
        }
        return;
    }
    self.lowhealth = 0;
    setsoundcontext("laststand", "");
    if (isdefined(level.audiosharedunderwater) && sessionmodeiscampaigngame() && level.audiosharedunderwater) {
        mapname = getdvarstring("mapname");
        if (mapname == "cp_mi_sing_sgen") {
            forceambientroom("");
        } else {
            forceambientroom("");
        }
    } else {
        forceambientroom("");
    }
    if (oldval == 1) {
        playsound(localclientnum, var_9446a781, (0, 0, 0));
        self notify(#"hash_2b4649a6");
    } else {
        if (isalive(self)) {
            playsound(localclientnum, var_177599f1, (0, 0, 0));
            if (isdefined(self.sndtacrigemergencyreserve) && self.sndtacrigemergencyreserve) {
                playsound(localclientnum, "gdt_cybercore_regen_complete", (0, 0, 0));
            }
        }
        self notify(#"hash_2b4649a6");
    }
}

// Namespace audio/audio_shared
// Params 4, eflags: 0x0
// Checksum 0x5547ab09, Offset: 0x3ae0
// Size: 0xc0
function function_451c4dae(localclientnum, var_7f2a8cb, min, max) {
    self endon(#"hash_2b4649a6");
    wait 0.5;
    if (isdefined(self) && isdefined(self.isinfected)) {
        if (self.isinfected) {
            playsound(localclientnum, "vox_dying_infected_after", (0, 0, 0));
        }
        while (isdefined(self)) {
            playsound(localclientnum, var_7f2a8cb, (0, 0, 0));
            wait randomfloatrange(min, max);
        }
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0xe2ca3a39, Offset: 0x3ba8
// Size: 0x64
function sndtacrig(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.sndtacrigemergencyreserve = 1;
        return;
    }
    self.sndtacrigemergencyreserve = 0;
}

// Namespace audio/audio_shared
// Params 3, eflags: 0x0
// Checksum 0xde05f0d4, Offset: 0x3c18
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
// Checksum 0x444fee20, Offset: 0x3c90
// Size: 0xdc
function sndrattle_server(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (self.model == "wpn_t7_bouncing_betty_world") {
            betty = getweapon("bouncingbetty");
            level thread dorattle(self.origin, betty.soundrattlerangemin, betty.soundrattlerangemax);
            return;
        }
        level thread dorattle(self.origin, 25, 600);
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x9fbb1b99, Offset: 0x3d78
// Size: 0x78
function sndrattle_grenade_client() {
    while (true) {
        waitresult = level waittill("explode");
        level thread dorattle(waitresult.position, waitresult.weapon.soundrattlerangemin, waitresult.weapon.soundrattlerangemax);
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0x158320bf, Offset: 0x3df8
// Size: 0xf4
function weapon_butt_sounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.meleed = 1;
        level.mysnd = playsound(localclientnum, "chr_melee_tinitus", (0, 0, 0));
        forceambientroom("sndHealth_Melee");
        return;
    }
    self.meleed = 0;
    forceambientroom("");
    if (isdefined(level.mysnd)) {
        stopsound(level.mysnd);
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xf65b20f0, Offset: 0x3ef8
// Size: 0x2c
function set_sound_context_defaults() {
    wait 2;
    setsoundcontext("foley", "normal");
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0xe936ad04, Offset: 0x3f30
// Size: 0xe4
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
// Checksum 0x400a2928, Offset: 0x4020
// Size: 0x5c
function sndfoleycontext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setsoundcontext("foley", "normal");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xcc93d2b2, Offset: 0x4088
// Size: 0x34
function sndkillcam() {
    level thread sndfinalkillcam_slowdown();
    level thread sndfinalkillcam_deactivate();
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0xb8916051, Offset: 0x40c8
// Size: 0x38
function snddeath_activate() {
    while (true) {
        level waittill("sndDED");
        snd_set_snapshot("mpl_death");
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x6f19d904, Offset: 0x4108
// Size: 0x38
function snddeath_deactivate() {
    while (true) {
        level waittill("sndDEDe");
        snd_set_snapshot("default");
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x5c5a73eb, Offset: 0x4148
// Size: 0x58
function sndfinalkillcam_activate() {
    while (true) {
        level waittill("sndFKs");
        playsound(0, "mpl_final_killcam_enter", (0, 0, 0));
        snd_set_snapshot("mpl_final_killcam");
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x18a974f6, Offset: 0x41a8
// Size: 0x78
function sndfinalkillcam_slowdown() {
    while (true) {
        level waittill("sndFKsl");
        playsound(0, "mpl_final_killcam_enter", (0, 0, 0));
        playsound(0, "mpl_final_killcam_slowdown", (0, 0, 0));
        snd_set_snapshot("mpl_final_killcam_slowdown");
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x81756e8a, Offset: 0x4228
// Size: 0x38
function sndfinalkillcam_deactivate() {
    while (true) {
        level waittill("sndFKe");
        snd_set_snapshot("default");
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0x29a3b238, Offset: 0x4268
// Size: 0x9c
function sndswitchvehiclecontext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self islocalclientdriver(localclientnum)) {
        setsoundcontext("plr_impact", "veh");
        return;
    }
    setsoundcontext("plr_impact", "");
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x77cb69c9, Offset: 0x4310
// Size: 0x2c
function sndmusicdeathwatcher() {
    self waittill("death");
    soundsetmusicstate("death");
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0xb1243aef, Offset: 0x4348
// Size: 0x1a4
function sndcchacking(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        switch (newval) {
        case 1:
            playsound(0, "gdt_cybercore_hack_start_plr", (0, 0, 0));
            self.hsnd = self playloopsound("gdt_cybercore_hack_lp_plr", 0.5);
            break;
        case 2:
            playsound(0, "gdt_cybercore_prime_upg_plr", (0, 0, 0));
            self.hsnd = self playloopsound("gdt_cybercore_prime_loop_plr", 0.5);
            break;
        }
        return;
    }
    if (isdefined(self.hsnd)) {
        self stoploopsound(self.hsnd, 0.5);
    }
    if (oldval == 1) {
        playsound(0, "gdt_cybercore_hack_success_plr", (0, 0, 0));
        return;
    }
    if (oldval == 2) {
        playsound(0, "gdt_cybercore_activate_fail_plr", (0, 0, 0));
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0xb54afa4f, Offset: 0x44f8
// Size: 0x194
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
    snd_set_snapshot("default");
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0x59970524, Offset: 0x4698
// Size: 0x7c
function sndlevelstartsnapoff(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (!(isdefined(level.sndigcsnapshotoverride) && level.sndigcsnapshotoverride)) {
            snd_set_snapshot("default");
        }
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0xe36b0be6, Offset: 0x4720
// Size: 0x5c
function sndzmbfadein(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        snd_set_snapshot("default");
    }
}

// Namespace audio/audio_shared
// Params 7, eflags: 0x0
// Checksum 0x1227e8c4, Offset: 0x4788
// Size: 0xd4
function sndchyronloop(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (!isdefined(level.chyronloop)) {
            level.chyronloop = spawn(0, (0, 0, 0), "script_origin");
            level.chyronloop playloopsound("uin_chyron_loop");
        }
        return;
    }
    if (isdefined(level.chyronloop)) {
        level.chyronloop delete();
    }
}

// Namespace audio/audio_shared
// Params 1, eflags: 0x0
// Checksum 0xbce8161, Offset: 0x4868
// Size: 0xc0
function sndsprintbreath(localclientnum) {
    self endon(#"entityshutdown");
    self endon(#"death");
    if (sessionmodeiscampaigngame()) {
        if (!isdefined(self.var_accf7d19)) {
            self.var_accf7d19 = 0;
        }
        while (true) {
            if (isdefined(self)) {
                if (self isplayersprinting()) {
                    self thread sndbreathstart();
                } else {
                    self notify(#"hash_9b673c1d");
                    self thread function_e34e6327();
                }
            }
            wait 0.1;
        }
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x759cbaf6, Offset: 0x4930
// Size: 0x74
function sndbreathstart() {
    self endon(#"hash_9b673c1d");
    self endon(#"death");
    wait 7;
    if (isdefined(self)) {
        if (self.var_accf7d19 == 0) {
            self.sndlooper = self playloopsound("chr_sprint_breath_lp", 0.1);
            self.var_accf7d19 = 1;
        }
    }
}

// Namespace audio/audio_shared
// Params 0, eflags: 0x0
// Checksum 0x30a45533, Offset: 0x49b0
// Size: 0x7c
function function_e34e6327() {
    self endon(#"death");
    wait 1.5;
    if (isdefined(self)) {
        if (self.var_accf7d19 == 1) {
            self stoploopsound(self.sndlooper);
            self.var_accf7d19 = 0;
            self playsound(0, "chr_sprint_breath_end");
        }
    }
}

