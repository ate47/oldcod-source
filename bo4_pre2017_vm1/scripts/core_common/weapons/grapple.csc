#using scripts/core_common/array_shared;
#using scripts/core_common/beam_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace grapple;

// Namespace grapple/grapple
// Params 0, eflags: 0x2
// Checksum 0x347e7355, Offset: 0x200
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("grapple", &__init__, undefined, undefined);
}

// Namespace grapple/grapple
// Params 0, eflags: 0x0
// Checksum 0x5cee6a30, Offset: 0x240
// Size: 0x24
function __init__() {
    callback::on_spawned(&player_on_spawned);
}

// Namespace grapple/grapple
// Params 1, eflags: 0x0
// Checksum 0x663a6970, Offset: 0x270
// Size: 0x34
function player_on_spawned(localclientnum) {
    if (sessionmodeismultiplayergame()) {
        self thread function_b25c9962(1);
    }
}

// Namespace grapple/grapple
// Params 4, eflags: 0x0
// Checksum 0x53bde688, Offset: 0x2b0
// Size: 0x54
function function_55af4b5b(player, tag, pivot, delay) {
    player endon(#"hash_2f0976f1");
    wait delay;
    thread grapple_beam(player, tag, pivot);
}

// Namespace grapple/grapple
// Params 3, eflags: 0x0
// Checksum 0xb1ef95c6, Offset: 0x310
// Size: 0x8c
function grapple_beam(player, tag, pivot) {
    level beam::launch(player, tag, pivot, "tag_origin", "zod_beast_grapple_beam");
    player waittill("grapple_done");
    level beam::kill(player, tag, pivot, "tag_origin", "zod_beast_grapple_beam");
}

// Namespace grapple/grapple
// Params 3, eflags: 0x0
// Checksum 0xe1e8d412, Offset: 0x3a8
// Size: 0x1a6
function function_b25c9962(onoff, tag, delay) {
    if (!isdefined(tag)) {
        tag = "tag_weapon_left";
    }
    if (!isdefined(delay)) {
        delay = 0.15;
    }
    self notify(#"hash_2f0976f1");
    self notify(#"hash_b25c9962");
    self endon(#"hash_b25c9962");
    self endon(#"death");
    if (onoff) {
        while (isdefined(self)) {
            waitresult = self waittill("grapple_beam_on");
            var_1e66ebb1 = tag;
            /#
                if (getdvarint("<dev string:x28>") > 0) {
                    var_1e66ebb1 = "<dev string:x37>";
                }
            #/
            if (isdefined(waitresult.pivot) && !waitresult.pivot isplayer()) {
                thread function_55af4b5b(self, var_1e66ebb1, waitresult.pivot, delay);
            }
            evt = self waittilltimeout(7.5, "grapple_pulled", "grapple_landed", "grapple_cancel", "grapple_beam_off", "disconnect");
            self notify(#"hash_2f0976f1");
        }
    }
}

