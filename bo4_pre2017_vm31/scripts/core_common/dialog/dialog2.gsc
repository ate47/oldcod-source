#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/dialog/dialog_table;
#using scripts/core_common/dialog/voice;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace dialog2;

// Namespace dialog2/dialog2
// Params 0, eflags: 0x2
// Checksum 0x5486dc82, Offset: 0x238
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("dialog2", &__init__, undefined, undefined);
}

// Namespace dialog2/dialog2
// Params 0, eflags: 0x0
// Checksum 0xfec0e4ec, Offset: 0x278
// Size: 0x34
function __init__() {
    callback::on_connect(&on_player_connect);
    level.var_7d2735c3 = [];
}

// Namespace dialog2/dialog2
// Params 0, eflags: 0x0
// Checksum 0x365af6d2, Offset: 0x2b8
// Size: 0x24
function on_player_connect() {
    self init_character(undefined, "J_Head");
}

// Namespace dialog2/dialog2
// Params 1, eflags: 0x0
// Checksum 0x359d15ea, Offset: 0x2e8
// Size: 0x24
function function_1d11865d(table) {
    dialog_table::load(table);
}

// Namespace dialog2/dialog2
// Params 2, eflags: 0x0
// Checksum 0xec85c06, Offset: 0x318
// Size: 0xb4
function init_character(chrname, var_29eab8b) {
    assert(isentity(self), "<dev string:x28>");
    assert(isplayer(self) || isdefined(chrname), "<dev string:x4b>");
    self.var_1da5cc6f = chrname;
    self.var_29eab8b = var_29eab8b;
    self.dialogqueue = [];
    self.var_46600405 = 0;
}

// Namespace dialog2/dialog2
// Params 1, eflags: 0x0
// Checksum 0xb3452688, Offset: 0x3d8
// Size: 0x1c
function set_portrait(portraitid) {
    self.var_cbf05d24 = portraitid;
}

// Namespace dialog2/dialog2
// Params 0, eflags: 0x0
// Checksum 0xe407fc01, Offset: 0x400
// Size: 0x38
function playing() {
    if (!isdefined(self.dialogqueue)) {
        return false;
    }
    return self pending() || isdefined(self.dialog);
}

// Namespace dialog2/dialog2
// Params 0, eflags: 0x0
// Checksum 0x965a82c1, Offset: 0x440
// Size: 0x28
function pending() {
    if (!isdefined(self.dialogqueue)) {
        return false;
    }
    return self.dialogqueue.size > 0;
}

// Namespace dialog2/dialog2
// Params 0, eflags: 0x0
// Checksum 0x93f1a2ce, Offset: 0x470
// Size: 0x2a
function stop() {
    if (self playing()) {
        self notify(#"dialog_stop");
    }
}

// Namespace dialog2/dialog2
// Params 1, eflags: 0x0
// Checksum 0x37c6a61e, Offset: 0x4a8
// Size: 0x142
function stop_all(team) {
    stop = [];
    foreach (speaker in level.var_7d2735c3) {
        if (isdefined(team) && team != speaker.team) {
            continue;
        }
        stop[stop.size] = speaker;
    }
    foreach (speaker in stop) {
        speaker stop();
    }
}

// Namespace dialog2/dialog2
// Params 2, eflags: 0x0
// Checksum 0x7d517e2b, Offset: 0x5f8
// Size: 0x1a4
function play(scriptkey, other) {
    assert(isdefined(self.dialogqueue), "<dev string:x7c>");
    if (issentient(self) && !isalive(self)) {
        return;
    }
    if (self playing()) {
        return;
    }
    alias = self voice::get_chr_alias(scriptkey);
    if (!isdefined(alias)) {
        return;
    }
    pending = self pending();
    dialog = spawnstruct();
    dialog.scriptkey = tolower(scriptkey);
    dialog.alias = alias;
    dialog.other = other;
    index = self.dialogqueue.size;
    arrayinsert(self.dialogqueue, dialog, index);
    if (!pending) {
        self thread start_pending();
    }
}

// Namespace dialog2/dialog2
// Params 0, eflags: 0x4
// Checksum 0xa7a0cb64, Offset: 0x7a8
// Size: 0x8c
function private start_pending() {
    self endoncallback(&function_3ccd4170, #"death", #"entering_last_stand", #"disconnect", #"dialog_stop");
    level endon(#"game_ended");
    level.var_7d2735c3[level.var_7d2735c3.size] = self;
    while (self.var_46600405) {
        waitframe(1);
    }
    waittillframeend();
    self thread play_next();
}

// Namespace dialog2/dialog2
// Params 0, eflags: 0x4
// Checksum 0x9cf2954, Offset: 0x840
// Size: 0x1c4
function private play_next() {
    self endoncallback(&end_play_next, #"death", #"entering_last_stand", #"disconnect", #"dialog_stop");
    level endon(#"game_ended");
    dialog = self.dialogqueue[0];
    arrayremoveindex(self.dialogqueue, 0);
    self clear_queue();
    self.dialog = dialog;
    if (self.archetype == "human" || self.archetype == "human_riotshield" || self.archetype == "human_rpg" || isdefined(self.archetype) && self.archetype == "civilian") {
        self clientfield::set("facial_dial", 1);
    }
    soundent = self playsoundwithnotify(dialog.alias, "dialog_done", self.var_29eab8b);
    self mask_sound(soundent, dialog.scriptkey, dialog.other);
    self waittill("dialog_done");
    self end_play_next();
}

// Namespace dialog2/dialog2
// Params 1, eflags: 0x4
// Checksum 0xf2c499ef, Offset: 0xa10
// Size: 0x5c
function private function_3ccd4170(notifyhash) {
    if (isdefined(notifyhash)) {
        self clear_queue();
        self notify(#"dialog_done");
    }
    arrayremovevalue(level.var_7d2735c3, self);
}

// Namespace dialog2/dialog2
// Params 1, eflags: 0x4
// Checksum 0x4a273c9, Offset: 0xa78
// Size: 0xdc
function private end_play_next(notifyhash) {
    self function_3ccd4170();
    if (isdefined(notifyhash)) {
        self thread stop_playing();
    }
    self.dialog = undefined;
    if (self.archetype == "human" || self.archetype == "human_riotshield" || self.archetype == "human_rpg" || isdefined(self.archetype) && self.archetype == "civilian") {
        self clientfield::set("facial_dial", 0);
    }
}

// Namespace dialog2/dialog2
// Params 0, eflags: 0x4
// Checksum 0xac8160b2, Offset: 0xb60
// Size: 0x58
function private stop_playing() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self.var_46600405 = 1;
    self stopsounds();
    waitframe(1);
    self.var_46600405 = 0;
}

// Namespace dialog2/dialog2
// Params 0, eflags: 0x4
// Checksum 0xa2f36470, Offset: 0xbc0
// Size: 0x10
function private clear_queue() {
    self.dialogqueue = [];
}

// Namespace dialog2/dialog2
// Params 3, eflags: 0x4
// Checksum 0x3c356e5e, Offset: 0xbd8
// Size: 0x30c
function private mask_sound(soundent, scriptkey, other) {
    mask = dialog_table::function_649707de(scriptkey);
    if (mask == "all") {
        if (isdefined(self.var_cbf05d24)) {
            foreach (player in getplayers()) {
                self show_portrait_to(player);
            }
        }
        return;
    }
    soundent hide();
    if (mask == "friendly") {
        foreach (player in getplayers()) {
            if (player.team == self.team) {
                self play_to(soundent, player);
            }
        }
    } else if (mask == "enemy") {
        foreach (player in getplayers()) {
            if (player.team != self.team) {
                self play_to(soundent, player);
            }
        }
    } else if (mask == "self") {
        if (isplayer(self)) {
            self play_to(soundent, player);
        }
    }
    if (isdefined(other) && isplayer(other)) {
        self play_to(soundent, other);
    }
}

// Namespace dialog2/dialog2
// Params 2, eflags: 0x4
// Checksum 0x994c7dbc, Offset: 0xef0
// Size: 0x64
function private play_to(soundent, player) {
    if (isdefined(soundent)) {
        soundent showtoplayer(player);
    }
    if (isdefined(self.var_cbf05d24)) {
        self show_portrait_to(player);
    }
}

// Namespace dialog2/dialog2
// Params 1, eflags: 0x4
// Checksum 0x558ecff6, Offset: 0xf60
// Size: 0x4c
function private show_portrait_to(player) {
    player luinotifyevent(%offsite_comms_message, 1, self.var_cbf05d24);
    player thread close_portrait(self);
}

// Namespace dialog2/dialog2
// Params 1, eflags: 0x4
// Checksum 0x9f7f43c6, Offset: 0xfb8
// Size: 0x74
function private close_portrait(speaker) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    speaker waittill("death", "entering_last_stand", "disconnect", "dialog_stop", "dialog_done");
    self luinotifyevent(%offsite_comms_complete);
}

// Namespace dialog2/dialog2
// Params 1, eflags: 0x0
// Checksum 0xfdc93ebe, Offset: 0x1038
// Size: 0x74
function play_notetrack(scriptid) {
    if (isdefined(level.var_3c0e32a)) {
        self thread [[ level.var_3c0e32a ]](scriptid);
        return;
    }
    alias = voice::function_dc3ae640(scriptid);
    self playsoundwithnotify(alias);
}

