#using scripts\core_common\array_shared;
#using scripts\core_common\system_shared;

#namespace wz_jukebox;

// Namespace wz_jukebox/wz_jukebox
// Params 0, eflags: 0x2
// Checksum 0xebe55ffd, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"wz_jukebox", &__init__, undefined, undefined);
}

// Namespace wz_jukebox/wz_jukebox
// Params 0, eflags: 0x0
// Checksum 0x8e7ec6be, Offset: 0xd0
// Size: 0x92
function __init__() {
    dynents = getdynentarray("dynent_jukebox");
    foreach (jukebox in dynents) {
        jukebox.songs = [];
    }
}

// Namespace wz_jukebox/event_57a8880c
// Params 1, eflags: 0x40
// Checksum 0x8457ee6e, Offset: 0x170
// Size: 0xa4
function event_handler[event_57a8880c] function_565a245e(eventstruct) {
    if (eventstruct.ent.targetname === "dynent_jukebox") {
        if (eventstruct.state == 0 || eventstruct.state == 3) {
            eventstruct.ent thread jukebox_off();
            return;
        }
        if (eventstruct.state == 2) {
            eventstruct.ent thread jukebox_on();
        }
    }
}

// Namespace wz_jukebox/wz_jukebox
// Params 0, eflags: 0x0
// Checksum 0x6f5f9ee1, Offset: 0x220
// Size: 0x46
function jukebox_off() {
    self notify(#"jukebox_off");
    if (isdefined(self.var_33fb31a2)) {
        stopsound(self.var_33fb31a2);
        self.var_33fb31a2 = undefined;
    }
}

// Namespace wz_jukebox/wz_jukebox
// Params 0, eflags: 0x0
// Checksum 0x50dc90ff, Offset: 0x270
// Size: 0x202
function jukebox_on() {
    self endon(#"jukebox_off");
    var_1d078f78 = (self.origin[0] + 32, self.origin[1] - 16, self.origin[2] + 64);
    if (isdefined(self.var_33fb31a2)) {
        stopsound(self.var_33fb31a2);
        self.var_33fb31a2 = undefined;
        waitframe(1);
    }
    if (self.songs.size > 0) {
        random_num = randomint(self.songs.size);
        song = self.songs[random_num];
        arrayremoveindex(self.songs, random_num);
    } else {
        songs = array(#"hash_38b88ac8a1bb9bca", #"hash_38b88bc8a1bb9d7d", #"hash_38b888c8a1bb9864", #"hash_38b889c8a1bb9a17", #"hash_38b886c8a1bb94fe", #"hash_38b887c8a1bb96b1");
        self.songs = array::randomize(songs);
        random_num = randomint(self.songs.size);
        song = self.songs[random_num];
        arrayremoveindex(self.songs, random_num);
    }
    self.var_33fb31a2 = playsound(0, song, var_1d078f78);
}

