#using scripts\core_common\array_shared;
#using scripts\core_common\beam_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\duplicaterender_mgr;
#using scripts\core_common\filter_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_grappler;

// Namespace zm_grappler/zm_grappler
// Params 0, eflags: 0x2
// Checksum 0x6dfe5d60, Offset: 0x118
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_grappler", &__init__, undefined, undefined);
}

// Namespace zm_grappler/zm_grappler
// Params 0, eflags: 0x0
// Checksum 0x448c7105, Offset: 0x160
// Size: 0xd6
function __init__() {
    clientfield::register("scriptmover", "grappler_beam_source", 1, getminbitcountfornum(5), "int", &grappler_source, 1, 0);
    clientfield::register("scriptmover", "grappler_beam_target", 1, getminbitcountfornum(5), "int", &grappler_beam, 1, 0);
    if (!isdefined(level.grappler_beam)) {
        level.grappler_beam = "zod_beast_grapple_beam";
    }
}

// Namespace zm_grappler/zm_grappler
// Params 7, eflags: 0x0
// Checksum 0x905846ec, Offset: 0x240
// Size: 0xae
function grappler_source(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.grappler_sources)) {
        level.grappler_sources = [];
    }
    assert(!isdefined(level.grappler_sources[newval]));
    level.grappler_sources[newval] = self;
    level notify("grapple_id_" + newval);
}

// Namespace zm_grappler/zm_grappler
// Params 7, eflags: 0x0
// Checksum 0xdc95ebf4, Offset: 0x2f8
// Size: 0x12e
function grappler_beam(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (!isdefined(level.grappler_sources)) {
        level.grappler_sources = [];
    }
    if (!isdefined(level.grappler_sources[newval])) {
        level waittilltimeout(0.5, "grapple_id_" + newval);
    }
    assert(isdefined(level.grappler_sources[newval]));
    pivot = level.grappler_sources[newval];
    if (newval) {
        thread function_55af4b5b(self, "tag_origin", pivot, 0.05);
        return;
    }
    self notify(#"grappler_done");
}

// Namespace zm_grappler/zm_grappler
// Params 4, eflags: 0x0
// Checksum 0x549fa9c8, Offset: 0x430
// Size: 0x84
function function_55af4b5b(player, tag, pivot, delay) {
    player endon(#"grappler_done", #"death");
    pivot endon(#"death");
    wait delay;
    thread grapple_beam(player, tag, pivot);
}

// Namespace zm_grappler/zm_grappler
// Params 1, eflags: 0x0
// Checksum 0xb01e4ef0, Offset: 0x4c0
// Size: 0x4c
function function_963a7a8e(notifyhash) {
    level beam::kill(self.player, self.tag, self.pivot, "tag_origin", level.grappler_beam);
}

// Namespace zm_grappler/zm_grappler
// Params 3, eflags: 0x0
// Checksum 0x7f9e669, Offset: 0x518
// Size: 0xe4
function grapple_beam(player, tag, pivot) {
    self endoncallback(&function_963a7a8e, #"death");
    self.player = player;
    self.tag = tag;
    self.pivot = pivot;
    level beam::launch(player, tag, pivot, "tag_origin", level.grappler_beam, 1);
    player waittill(#"grappler_done");
    level beam::kill(player, tag, pivot, "tag_origin", level.grappler_beam);
}

