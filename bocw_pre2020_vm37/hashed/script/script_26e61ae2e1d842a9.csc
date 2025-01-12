#using scripts\core_common\callbacks_shared;
#using scripts\core_common\map;
#using scripts\core_common\util_shared;

#namespace namespace_1a4edaec;

// Namespace namespace_1a4edaec/level_init
// Params 1, eflags: 0x40
// Checksum 0xc546358, Offset: 0x78
// Size: 0x4c
function event_handler[level_init] main(*eventstruct) {
    bundle = function_9ea44286();
    if (isdefined(bundle)) {
        callback::on_localplayer_spawned(&on_localplayer_spawned);
    }
}

// Namespace namespace_1a4edaec/namespace_1a4edaec
// Params 1, eflags: 0x1 linked
// Checksum 0x238b79c6, Offset: 0xd0
// Size: 0x24
function on_localplayer_spawned(localclientnum) {
    self thread function_fe8cf253(localclientnum);
}

// Namespace namespace_1a4edaec/namespace_1a4edaec
// Params 0, eflags: 0x1 linked
// Checksum 0x295b62e2, Offset: 0x100
// Size: 0x52
function function_9ea44286() {
    var_65792f8b = map::get_script_bundle();
    if (!isdefined(var_65792f8b)) {
        return undefined;
    }
    if (!isdefined(var_65792f8b.var_e13ec3f3)) {
        return undefined;
    }
    return getscriptbundle(var_65792f8b.var_e13ec3f3);
}

// Namespace namespace_1a4edaec/namespace_1a4edaec
// Params 1, eflags: 0x5 linked
// Checksum 0x173b2639, Offset: 0x160
// Size: 0x1e8
function private function_fe8cf253(localclientnum) {
    self endon(#"death");
    util::waittill_dobj(localclientnum);
    bundle = function_9ea44286();
    if (isdefined(self.var_87259100)) {
        stopfx(localclientnum, self.var_87259100);
    }
    if (isdefined(bundle.var_492662d7)) {
        self.var_87259100 = playfxoncamera(localclientnum, bundle.var_492662d7);
    }
    if (isdefined(bundle.var_39b6fcfb)) {
        minwait = isdefined(bundle.var_472be987) ? bundle.var_472be987 : 0.25;
        maxwait = isdefined(bundle.var_bce2eec7) ? bundle.var_bce2eec7 : 0.25;
        while (true) {
            playfxoncamera(localclientnum, bundle.var_39b6fcfb);
            /#
                minwait = isdefined(bundle.var_472be987) ? bundle.var_472be987 : 0.25;
                maxwait = isdefined(bundle.var_bce2eec7) ? bundle.var_bce2eec7 : 0.25;
            #/
            if (minwait <= maxwait) {
                wait randomfloatrange(minwait, maxwait);
                continue;
            }
            wait min(minwait, maxwait);
        }
    }
}

