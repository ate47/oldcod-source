#using scripts\core_common\callbacks_shared;
#using scripts\core_common\map;
#using scripts\core_common\util_shared;

#namespace namespace_1a4edaec;

// Namespace namespace_1a4edaec/level_init
// Params 1, eflags: 0x40
// Checksum 0x80cb0f22, Offset: 0x78
// Size: 0x4c
function event_handler[level_init] main(*eventstruct) {
    bundle = function_9ea44286();
    if (isdefined(bundle)) {
        callback::on_localplayer_spawned(&on_localplayer_spawned);
    }
}

// Namespace namespace_1a4edaec/namespace_1a4edaec
// Params 1, eflags: 0x0
// Checksum 0xf6f9149a, Offset: 0xd0
// Size: 0x24
function on_localplayer_spawned(localclientnum) {
    self thread function_fe8cf253(localclientnum);
}

// Namespace namespace_1a4edaec/namespace_1a4edaec
// Params 0, eflags: 0x0
// Checksum 0x9cf30d4c, Offset: 0x100
// Size: 0x52
function function_9ea44286() {
    mapbundle = map::get_script_bundle();
    if (!isdefined(mapbundle)) {
        return undefined;
    }
    if (!isdefined(mapbundle.var_e13ec3f3)) {
        return undefined;
    }
    return getscriptbundle(mapbundle.var_e13ec3f3);
}

// Namespace namespace_1a4edaec/namespace_1a4edaec
// Params 1, eflags: 0x4
// Checksum 0xc9c135f5, Offset: 0x160
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

