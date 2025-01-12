#using scripts\core_common\array_shared;
#using scripts\core_common\beam_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_grappler;

// Namespace zm_grappler/zm_grappler
// Params 0, eflags: 0x6
// Checksum 0x21955955, Offset: 0x118
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_grappler", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_grappler/zm_grappler
// Params 0, eflags: 0x4
// Checksum 0x8ddcf574, Offset: 0x160
// Size: 0xd4
function private function_70a657d8() {
    clientfield::register("scriptmover", "grappler_beam_source", 1, getminbitcountfornum(5), "int", &grappler_source, 1, 0);
    clientfield::register("scriptmover", "grappler_beam_target", 1, getminbitcountfornum(5), "int", &grappler_beam, 1, 0);
    if (!isdefined(level.grappler_beam)) {
        level.grappler_beam = "zod_beast_grapple_beam";
    }
}

// Namespace zm_grappler/zm_grappler
// Params 7, eflags: 0x0
// Checksum 0xe18ec90a, Offset: 0x240
// Size: 0xaa
function grappler_source(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(level.grappler_sources)) {
        level.grappler_sources = [];
    }
    assert(!isdefined(level.grappler_sources[bwastimejump]));
    level.grappler_sources[bwastimejump] = self;
    level notify("grapple_id_" + bwastimejump);
}

// Namespace zm_grappler/zm_grappler
// Params 7, eflags: 0x0
// Checksum 0x6c2375e2, Offset: 0x2f8
// Size: 0x136
function grappler_beam(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    if (!isdefined(level.grappler_sources)) {
        level.grappler_sources = [];
    }
    if (!isdefined(level.grappler_sources[bwastimejump])) {
        level waittilltimeout(1, "grapple_id_" + bwastimejump);
    }
    assert(isdefined(level.grappler_sources[bwastimejump]));
    pivot = level.grappler_sources[bwastimejump];
    if (!isdefined(pivot)) {
        return;
    }
    if (bwastimejump) {
        thread function_34e3f163(self, "tag_origin", pivot, 0.05);
        return;
    }
    self notify(#"grappler_done");
}

// Namespace zm_grappler/zm_grappler
// Params 4, eflags: 0x0
// Checksum 0x67c59417, Offset: 0x438
// Size: 0x84
function function_34e3f163(player, tag, pivot, delay) {
    player endon(#"grappler_done", #"death");
    pivot endon(#"death");
    wait delay;
    thread grapple_beam(player, tag, pivot);
}

// Namespace zm_grappler/zm_grappler
// Params 1, eflags: 0x0
// Checksum 0x4e4ea6db, Offset: 0x4c8
// Size: 0x4c
function function_f4b9c325(*notifyhash) {
    level beam::kill(self.player, self.tag, self.pivot, "tag_origin", level.grappler_beam);
}

// Namespace zm_grappler/zm_grappler
// Params 3, eflags: 0x0
// Checksum 0xbe681448, Offset: 0x520
// Size: 0xe4
function grapple_beam(player, tag, pivot) {
    self endoncallback(&function_f4b9c325, #"death");
    self.player = player;
    self.tag = tag;
    self.pivot = pivot;
    level beam::launch(player, tag, pivot, "tag_origin", level.grappler_beam, 1);
    player waittill(#"grappler_done");
    level beam::kill(player, tag, pivot, "tag_origin", level.grappler_beam);
}

