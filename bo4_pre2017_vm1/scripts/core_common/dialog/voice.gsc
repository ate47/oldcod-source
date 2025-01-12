#using scripts/core_common/animation_shared;
#using scripts/core_common/dialog/dialog2;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace voice;

// Namespace voice/voice
// Params 0, eflags: 0x2
// Checksum 0x6c1b8061, Offset: 0x130
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("voice", &__init__, undefined, undefined);
}

// Namespace voice/voice
// Params 0, eflags: 0x0
// Checksum 0x78add520, Offset: 0x170
// Size: 0x24
function __init__() {
    if (!isdefined(level.scr_sound)) {
        level.scr_sound = [];
    }
}

// Namespace voice/voice
// Params 3, eflags: 0x0
// Checksum 0x79cb549a, Offset: 0x1a0
// Size: 0x64
function add(chrname, scriptkey, alias) {
    if (!isdefined(level.scr_sound[chrname])) {
        level.scr_sound[chrname] = [];
    }
    level.scr_sound[chrname][scriptkey] = alias;
}

// Namespace voice/voice
// Params 2, eflags: 0x0
// Checksum 0x305bf581, Offset: 0x210
// Size: 0x9c
function add_igc(scriptid, alias) {
    if (!isdefined(level.scr_sound["generic"])) {
        level.scr_sound["generic"] = [];
    }
    level.scr_sound["generic"][scriptid] = alias;
    animation::add_global_notetrack_handler("vox#" + scriptid, &namespace_3a85d5f1::play_notetrack, 0, scriptid);
}

// Namespace voice/voice
// Params 1, eflags: 0x0
// Checksum 0x21aa4159, Offset: 0x2b8
// Size: 0xb2
function get_chr_alias(scriptkey) {
    chrname = self.var_1da5cc6f;
    if (!isdefined(chrname) && isplayer(self)) {
        chrname = self getchrname();
    }
    if (!isdefined(chrname) || !isdefined(level.scr_sound) || !isdefined(level.scr_sound[chrname])) {
        return undefined;
    }
    return level.scr_sound[chrname][scriptkey];
}

// Namespace voice/voice
// Params 1, eflags: 0x0
// Checksum 0xd6a6cf55, Offset: 0x378
// Size: 0x5a
function function_dc3ae640(scriptid) {
    if (!isdefined(level.scr_sound) || !isdefined(level.scr_sound["generic"])) {
        return undefined;
    }
    return level.scr_sound["generic"][scriptid];
}

