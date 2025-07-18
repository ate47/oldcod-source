#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;

#namespace streamer;

// Namespace streamer/namespace_51e8873d
// Params 4, eflags: 0x0
// Checksum 0xbeb61967, Offset: 0x70
// Size: 0xd0
function function_d46dcfc2(var_74f025c6, var_11a76757, var_352bdb5f, var_45269c45) {
    if (!isdefined(level.var_80747947)) {
        level.var_80747947 = [];
    }
    level.var_80747947[var_74f025c6] = {#var_11a76757:var_11a76757, #var_352bdb5f:var_352bdb5f, #var_45269c45:var_45269c45};
    assert(!level flag::get(var_74f025c6));
    [[ level.var_80747947[var_74f025c6].var_45269c45 ]]();
}

// Namespace streamer/namespace_51e8873d
// Params 1, eflags: 0x0
// Checksum 0x901ef429, Offset: 0x148
// Size: 0x6c
function force_stream(var_74f025c6) {
    level flag::increment(var_74f025c6);
    [[ level.var_80747947[var_74f025c6].var_352bdb5f ]]();
    self.var_74f025c6 = var_74f025c6;
    self callback::on_shutdown(&on_shutdown);
}

// Namespace streamer/namespace_51e8873d
// Params 1, eflags: 0x4
// Checksum 0x507f1ef4, Offset: 0x1c0
// Size: 0x9c
function private on_shutdown(*localclientnum) {
    if (!isdefined(self.var_74f025c6)) {
        return;
    }
    level flag::decrement(self.var_74f025c6);
    if (!level flag::get(self.var_74f025c6)) {
        [[ level.var_80747947[self.var_74f025c6].var_45269c45 ]]();
        function_121f6fcf(level.var_80747947[self.var_74f025c6].var_11a76757);
    }
}

// Namespace streamer/namespace_51e8873d
// Params 1, eflags: 0x4
// Checksum 0x30d362b4, Offset: 0x268
// Size: 0xd4
function private function_121f6fcf(var_11a76757) {
    if (!isdefined(level.var_80747947)) {
        return;
    }
    foreach (var_74f025c6, entry in level.var_80747947) {
        if (var_11a76757 & entry.var_11a76757 == 0) {
            continue;
        }
        if (level flag::get(var_74f025c6)) {
            [[ entry.var_352bdb5f ]]();
        }
    }
}

