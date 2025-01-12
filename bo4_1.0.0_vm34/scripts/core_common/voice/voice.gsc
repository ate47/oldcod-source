#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace voice;

// Namespace voice/voice
// Params 0, eflags: 0x2
// Checksum 0xd1904c44, Offset: 0x100
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"voice", &__init__, undefined, undefined);
}

// Namespace voice/voice
// Params 0, eflags: 0x0
// Checksum 0x23671e33, Offset: 0x148
// Size: 0x8c
function __init__() {
    callback::on_connect(&on_player_connect);
    level.var_5b1c49b = [];
    if (!isdefined(level.scr_sound)) {
        level.scr_sound = [];
    }
    /#
        if (!isprofilebuild()) {
            setdvar(#"hash_5a4f3b089c68658f", 1);
        }
    #/
}

// Namespace voice/voice
// Params 0, eflags: 0x0
// Checksum 0xe9e6e818, Offset: 0x1e0
// Size: 0x48
function on_player_connect() {
    self init_character(undefined, "J_Head");
    if (isdefined(level.var_505c52c1)) {
        self thread [[ level.var_505c52c1 ]]();
    }
}

// Namespace voice/voice
// Params 1, eflags: 0x0
// Checksum 0x8e34a3d1, Offset: 0x230
// Size: 0xc
function function_a48e516b(table) {
    
}

// Namespace voice/voice
// Params 3, eflags: 0x0
// Checksum 0x69cd0a4e, Offset: 0x248
// Size: 0x1c
function add(chrname, scriptkey, alias) {
    
}

// Namespace voice/voice
// Params 2, eflags: 0x0
// Checksum 0x2f4feefc, Offset: 0x270
// Size: 0x14
function add_igc(scriptid, alias) {
    
}

// Namespace voice/voice
// Params 3, eflags: 0x0
// Checksum 0x80bf5be5, Offset: 0x290
// Size: 0xda
function init_character(chrname, var_1c9daea3, var_212ce07f = 0) {
    assert(isentity(self), "<dev string:x30>");
    assert(isplayer(self) || isdefined(chrname), "<dev string:x52>");
    if (isdefined(self)) {
        self.var_bf8e2237 = chrname;
        self.var_1c9daea3 = var_1c9daea3;
        self.var_ae3e9976 = [];
        self.var_f60b70fd = 0;
        self.var_a1b1910a = var_212ce07f;
    }
}

// Namespace voice/voice
// Params 1, eflags: 0x0
// Checksum 0x8d353950, Offset: 0x378
// Size: 0x1a
function set_portrait(portraitid) {
    self.allies_to_cqb = portraitid;
}

// Namespace voice/voice
// Params 0, eflags: 0x0
// Checksum 0xa12283f1, Offset: 0x3a0
// Size: 0x1c
function playing() {
    if (!isdefined(self.var_ae3e9976)) {
        return false;
    }
    return isdefined(self.var_48673935);
}

// Namespace voice/voice
// Params 0, eflags: 0x0
// Checksum 0xfe4fc0a2, Offset: 0x3c8
// Size: 0x20
function pending() {
    if (!isdefined(self.var_ae3e9976)) {
        return false;
    }
    return self.var_ae3e9976.size > 0;
}

// Namespace voice/voice
// Params 0, eflags: 0x0
// Checksum 0x6ad4c2fc, Offset: 0x3f0
// Size: 0x2e
function stop() {
    if (self playing()) {
        self notify(#"voice_stop");
    }
}

// Namespace voice/voice
// Params 1, eflags: 0x0
// Checksum 0x12eeebb8, Offset: 0x428
// Size: 0x138
function stop_all(team) {
    stop = [];
    foreach (speaker in level.var_5b1c49b) {
        if (isdefined(team) && team != #"any" && team != speaker.team) {
            continue;
        }
        stop[stop.size] = speaker;
    }
    foreach (speaker in stop) {
        speaker stop();
    }
}

// Namespace voice/voice
// Params 3, eflags: 0x0
// Checksum 0xb0b902cb, Offset: 0x568
// Size: 0x308
function play(scriptkey, var_d2ce6882 = undefined, var_822cf89d = 0) {
    if (!isdefined(self) || issentient(self) && !isalive(self)) {
        return false;
    }
    assert(isdefined(self.var_ae3e9976), "<dev string:x82>");
    if (isstring(scriptkey)) {
        scriptkey = tolower(scriptkey);
    }
    alias = undefined;
    if (var_822cf89d) {
        assert(isdefined(self.var_a1b1910a) && self.var_a1b1910a, "<dev string:xb0>");
        a_aliases = self function_3910de2(scriptkey);
        if (isdefined(self.var_7f703f75)) {
            var_7e7168da = a_aliases.size == 1 && a_aliases[0] == self.var_7f703f75;
            if (var_7e7168da) {
                alias = self.var_7f703f75;
            } else {
                a_aliases = array::exclude(a_aliases, self.var_7f703f75);
                alias = array::random(a_aliases);
            }
        } else {
            alias = array::random(a_aliases);
        }
    } else {
        alias = self get_chr_alias(scriptkey);
    }
    voice = spawnstruct();
    voice.scriptkey = scriptkey;
    voice.params = function_b67f42f1(scriptkey);
    voice.alias = alias;
    voice.var_d2ce6882 = var_d2ce6882;
    if (isdefined(self.var_a1b1910a) && self.var_a1b1910a && isdefined(alias)) {
        self.var_7f703f75 = alias;
    }
    if (!playing() && !pending()) {
        self thread start_pending();
    }
    function_9d14df1f(voice);
    return isdefined(alias);
}

// Namespace voice/voice
// Params 0, eflags: 0x4
// Checksum 0x287615f4, Offset: 0x878
// Size: 0xcc
function private start_pending() {
    self endoncallback(&function_3ccd4170, #"death", #"entering_last_stand", #"disconnect", #"voice_stop");
    level endon(#"game_ended");
    level.var_5b1c49b[level.var_5b1c49b.size] = self;
    while (isdefined(self.var_f60b70fd) && self.var_f60b70fd) {
        waitframe(1);
    }
    waittillframeend();
    if (isdefined(self)) {
        self thread play_next();
    }
}

// Namespace voice/voice
// Params 0, eflags: 0x4
// Checksum 0x736dd7ed, Offset: 0x950
// Size: 0x504
function private play_next() {
    self endoncallback(&end_play_next, #"death", #"entering_last_stand", #"disconnect", #"voice_stop");
    level endon(#"game_ended");
    voice = function_d650eb83();
    if (!isdefined(voice)) {
        self end_play_next();
        return;
    }
    self function_819f0264();
    self.var_48673935 = voice;
    if (isdefined(self.archetype) && (self.archetype == "human" || self.archetype == "human_riotshield" || self.archetype == "human_rpg" || self.archetype == "civilian")) {
        self clientfield::set("facial_dial", 1);
    }
    if (isdefined(voice.alias) && getdvarint(#"hash_49f50ad33517adfd", 1) == 1) {
        soundent = self playsoundwithnotify(voice.alias, "voice_done", self.var_1c9daea3);
        self mask_sound(soundent, voice.params, voice.var_d2ce6882);
        self waittill(#"voice_done");
        self notify(voice.scriptkey);
    } else if (isdefined(voice.alias)) {
        self notify(#"voice_done");
        self notify(voice.scriptkey);
    }
    if (!isdefined(voice.alias) && getdvarint(#"hash_5a4f3b089c68658f", 0) == 1 || getdvarint(#"hash_71fefd466102ebff", 0) == 1) {
        tempname = self.var_bf8e2237;
        if (!isdefined(tempname) && isplayer(self)) {
            tempname = self getchrname();
        }
        if (!isdefined(tempname)) {
            tempname = "Unknown";
        }
        str_line = tempname + ": " + voice.scriptkey;
        n_wait_time = (strtok(voice.scriptkey, " ").size - 1) / 2;
        n_wait_time = math::clamp(n_wait_time, 2, 5);
        if (isdefined(voice.var_d2ce6882) && isentity(voice.var_d2ce6882)) {
            voice.var_d2ce6882 thread function_12463a90(str_line, n_wait_time);
        } else {
            a_e_teammates = getplayers(self.team);
            foreach (e_player in a_e_teammates) {
                if (isbot(e_player)) {
                    continue;
                }
                e_player thread function_12463a90(str_line, n_wait_time);
            }
        }
        self notify(#"voice_done");
        self notify(voice.scriptkey);
    }
    self end_play_next();
}

// Namespace voice/voice
// Params 2, eflags: 0x4
// Checksum 0x9d89cb21, Offset: 0xe60
// Size: 0xf4
function private function_12463a90(str_line, n_wait_time) {
    self endon(#"disconnect");
    self notify(#"hash_3a2cea55af16657f");
    self endon(#"hash_3a2cea55af16657f");
    if (!isdefined(self getluimenu("TempDialog"))) {
        self openluimenu("TempDialog");
    }
    self waittilltimeout(n_wait_time, #"death");
    if (isdefined(self getluimenu("TempDialog"))) {
        self closeluimenu(self getluimenu("TempDialog"));
    }
}

// Namespace voice/voice
// Params 1, eflags: 0x4
// Checksum 0x5c9abf6, Offset: 0xf60
// Size: 0x5c
function private function_3ccd4170(notifyhash) {
    if (isdefined(notifyhash)) {
        self function_819f0264();
        self notify(#"voice_done");
    }
    arrayremovevalue(level.var_5b1c49b, self);
}

// Namespace voice/voice
// Params 1, eflags: 0x4
// Checksum 0xe2470911, Offset: 0xfc8
// Size: 0x196
function private end_play_next(notifyhash) {
    self function_3ccd4170();
    if (isdefined(notifyhash)) {
        self thread stop_playing();
        self notify(#"voice_done");
        if (isdefined(self.var_48673935) && isstring(self.var_48673935.scriptkey)) {
            self notify(self.var_48673935.scriptkey);
        }
    }
    self.var_48673935 = undefined;
    if (isactor(self) && isdefined(self.archetype) && (self.archetype == "human" || self.archetype == "human_riotshield" || self.archetype == "human_rpg" || self.archetype == "civilian")) {
        self clientfield::set("facial_dial", 0);
    }
    if (isdefined(self.var_ae3e9976) && self.var_ae3e9976.size > 0) {
        play_next();
        return;
    }
    self notify(#"hash_296a16c4cf068a53");
}

// Namespace voice/voice
// Params 0, eflags: 0x4
// Checksum 0xc08bc232, Offset: 0x1168
// Size: 0x66
function private stop_playing() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self.var_f60b70fd = 1;
    self stopsounds();
    waitframe(1);
    if (isdefined(self)) {
        self.var_f60b70fd = 0;
    }
}

// Namespace voice/voice
// Params 0, eflags: 0x4
// Checksum 0xa032a971, Offset: 0x11d8
// Size: 0x26
function private clear_queue() {
    array::delete_all(self.var_ae3e9976);
    self.var_ae3e9976 = [];
}

// Namespace voice/voice
// Params 0, eflags: 0x4
// Checksum 0x15e034b5, Offset: 0x1208
// Size: 0xfa
function private function_819f0264() {
    self endon(#"death");
    self endon(#"disconnect");
    if (isdefined(self.var_ae3e9976)) {
        for (i = 0; i < self.var_ae3e9976.size; i++) {
            if (isdefined(self.var_ae3e9976[i]) && isdefined(self.var_ae3e9976[i].scriptkey)) {
                b_queue = isdefined(self.var_ae3e9976[i].params) ? self.var_ae3e9976[i].params.queue : 0;
                if (!b_queue) {
                    arrayremoveindex(self.var_ae3e9976, i);
                    continue;
                }
            }
        }
    }
}

// Namespace voice/voice
// Params 3, eflags: 0x4
// Checksum 0x10b3463, Offset: 0x1310
// Size: 0x2ec
function private mask_sound(soundent, params, var_d2ce6882) {
    mask = isdefined(params) ? params.mask : #"all";
    if (mask == #"all") {
        if (isdefined(self.allies_to_cqb)) {
            foreach (player in getplayers()) {
                self show_portrait_to(player);
            }
        }
        return;
    }
    soundent hide();
    if (mask == #"friendly") {
        foreach (player in getplayers()) {
            if (player.team == self.team) {
                self play_to(soundent, player);
            }
        }
    } else if (mask == #"enemy") {
        foreach (player in getplayers()) {
            if (player.team != self.team) {
                self play_to(soundent, player);
            }
        }
    } else if (mask == #"self") {
        if (isplayer(self)) {
            self play_to(soundent, player);
        }
    }
    if (isdefined(var_d2ce6882) && isplayer(var_d2ce6882)) {
        self play_to(soundent, var_d2ce6882);
    }
}

// Namespace voice/voice
// Params 2, eflags: 0x4
// Checksum 0x56399bc0, Offset: 0x1608
// Size: 0x54
function private play_to(soundent, player) {
    if (isdefined(soundent)) {
        soundent showtoplayer(player);
    }
    if (isdefined(self.allies_to_cqb)) {
        self show_portrait_to(player);
    }
}

// Namespace voice/voice
// Params 1, eflags: 0x4
// Checksum 0x23965e9f, Offset: 0x1668
// Size: 0x54
function private show_portrait_to(player) {
    player luinotifyevent(#"offsite_comms_message", 1, self.allies_to_cqb);
    player thread close_portrait(self);
}

// Namespace voice/voice
// Params 1, eflags: 0x4
// Checksum 0x3f0c7457, Offset: 0x16c8
// Size: 0xac
function private close_portrait(speaker) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    speaker waittill(#"death", #"entering_last_stand", #"disconnect", #"voice_stop", #"voice_done");
    self luinotifyevent(#"offsite_comms_complete");
}

// Namespace voice/voice
// Params 1, eflags: 0x0
// Checksum 0xfc1499eb, Offset: 0x1780
// Size: 0x3b8
function play_notetrack(scriptid) {
    alias = function_56ff667f(scriptid);
    if (!isdefined(alias)) {
        return;
    }
    if (isdefined(self gettagorigin("J_Head"))) {
        soundent = self playsoundwithnotify(alias, "voice_done", "J_Head");
    } else {
        soundent = self playsoundwithnotify(alias, "voice_done");
    }
    if (!self flagsys::get(#"scene")) {
        return;
    }
    if (isdefined(self._scene_object) && isdefined(self._scene_object._o_scene) && isdefined(self._scene_object._o_scene._str_team)) {
        str_team = self._scene_object._o_scene._str_team;
    } else {
        str_team = self._scene_object._str_team;
    }
    if (isdefined(str_team) && str_team != #"any") {
        soundent hide();
        foreach (player in getplayers()) {
            if (isdefined(player._scene_object) && isdefined(player._scene_object._o_scene) && isdefined(self._scene_object._o_scene) && player._scene_object._o_scene == self._scene_object._o_scene) {
                self play_to(soundent, player);
                continue;
            }
            if (!isdefined(player._scene_object) && isdefined(player.var_2d7eda15) && isdefined(self._scene_object._o_scene) && player.var_2d7eda15 == self._scene_object._o_scene._str_name) {
                self play_to(soundent, player);
                continue;
            }
            if (self flagsys::get(#"hash_e2ce599b208682a") && self util::is_on_side(player.team) || self flagsys::get(#"hash_f21f320f68c0457") && !self util::is_on_side(player.team)) {
                self play_to(soundent, player);
            }
        }
    }
}

// Namespace voice/voice
// Params 0, eflags: 0x0
// Checksum 0x331fc71e, Offset: 0x1b40
// Size: 0x52
function function_a3c60b2b() {
    chrname = self.var_bf8e2237;
    if (!isdefined(chrname) && isplayer(self)) {
        chrname = self getchrname();
    }
    return chrname;
}

// Namespace voice/voice
// Params 1, eflags: 0x0
// Checksum 0xa230d7b2, Offset: 0x1ba0
// Size: 0x82
function get_chr_alias(scriptkey) {
    chrname = self function_a3c60b2b();
    if (!isdefined(chrname)) {
        return undefined;
    }
    aliases = function_cd08845a(chrname, scriptkey);
    if (aliases.size == 0) {
        return undefined;
    }
    return array::random(aliases);
}

// Namespace voice/voice
// Params 1, eflags: 0x0
// Checksum 0x97d0ad9f, Offset: 0x1c30
// Size: 0x52
function function_3910de2(scriptkey) {
    chrname = self function_a3c60b2b();
    if (!isdefined(chrname)) {
        return undefined;
    }
    return function_cd08845a(chrname, scriptkey);
}

// Namespace voice/voice
// Params 0, eflags: 0x0
// Checksum 0x62340e5f, Offset: 0x1c90
// Size: 0x50
function function_f2a4d933() {
    return isdefined(level.handlers) && isdefined(level.handlers[#"allies"]) && isdefined(level.handlers[#"axis"]);
}

// Namespace voice/voice
// Params 0, eflags: 0x0
// Checksum 0xadc70e65, Offset: 0x1ce8
// Size: 0x50
function function_7adcfbd() {
    return isdefined(level.commanders) && isdefined(level.commanders[#"allies"]) && isdefined(level.commanders[#"axis"]);
}

// Namespace voice/voice
// Params 0, eflags: 0x0
// Checksum 0x32cb6dec, Offset: 0x1d40
// Size: 0x30
function function_a944b12() {
    if (isdefined(self.var_ae3e9976) && self.var_ae3e9976.size > 0) {
        return self.var_ae3e9976[0];
    }
    return undefined;
}

// Namespace voice/voice
// Params 0, eflags: 0x0
// Checksum 0x309b3d61, Offset: 0x1d78
// Size: 0x40
function function_418cb06f() {
    if (isdefined(self.var_ae3e9976) && self.var_ae3e9976.size > 0) {
        return self.var_ae3e9976[self.var_ae3e9976.size - 1];
    }
    return undefined;
}

// Namespace voice/voice
// Params 1, eflags: 0x0
// Checksum 0x197a50b0, Offset: 0x1dc0
// Size: 0x252
function function_9d14df1f(s_voice) {
    if (isdefined(self.var_ae3e9976)) {
        interrupt = isdefined(s_voice.params) ? s_voice.params.interrupt : 0;
        priority = function_3aa72ba0(s_voice);
        if (isdefined(interrupt) && interrupt && isdefined(self.var_48673935)) {
            if (priority > function_3aa72ba0(self.var_48673935)) {
                self stop();
                arrayinsert(self.var_ae3e9976, s_voice, 0);
                return;
            }
        }
        if (self.var_ae3e9976.size == 0) {
            arrayinsert(self.var_ae3e9976, s_voice, 0);
            return;
        }
        if (priority > function_3aa72ba0(function_a944b12())) {
            arrayinsert(self.var_ae3e9976, s_voice, 0);
            return;
        }
        if (priority <= function_3aa72ba0(function_418cb06f())) {
            arrayinsert(self.var_ae3e9976, s_voice, self.var_ae3e9976.size);
            return;
        }
        for (i = 0; i < self.var_ae3e9976.size; i++) {
            if (priority <= function_3aa72ba0(self.var_ae3e9976[i]) && priority > function_3aa72ba0(self.var_ae3e9976[i + 1])) {
                arrayinsert(self.var_ae3e9976, s_voice, i + 1);
                break;
            }
        }
    }
}

// Namespace voice/voice
// Params 0, eflags: 0x0
// Checksum 0x505d9e1a, Offset: 0x2020
// Size: 0x68
function function_d650eb83() {
    voice = undefined;
    if (isdefined(self.var_ae3e9976) && self.var_ae3e9976.size > 0) {
        voice = function_a944b12();
        arrayremoveindex(self.var_ae3e9976, 0);
    }
    return voice;
}

// Namespace voice/voice
// Params 1, eflags: 0x0
// Checksum 0x24a08c3, Offset: 0x2090
// Size: 0x52
function function_3aa72ba0(s_voice) {
    if (!isdefined(s_voice.params) || !isdefined(s_voice.params.priority)) {
        return 0;
    }
    return s_voice.params.priority;
}

