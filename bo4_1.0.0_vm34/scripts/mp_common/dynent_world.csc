#using scripts\core_common\system_shared;

#namespace dynent_world;

// Namespace dynent_world/dynent_world
// Params 0, eflags: 0x2
// Checksum 0x48b8f153, Offset: 0x70
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"dynent_world", &__init__, undefined, undefined);
}

// Namespace dynent_world/dynent_world
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xb8
// Size: 0x4
function __init__() {
    
}

// Namespace dynent_world/event_57a8880c
// Params 1, eflags: 0x40
// Checksum 0x49152527, Offset: 0xc8
// Size: 0x664
function event_handler[event_57a8880c] function_565a245e(eventstruct) {
    dynent = eventstruct.ent;
    var_746034 = eventstruct.state;
    bundle = function_474cb3a(dynent);
    if (isdefined(bundle) && isdefined(bundle.dynentstates) && isdefined(bundle.dynentstates[var_746034])) {
        newstate = bundle.dynentstates[var_746034];
        teleport = eventstruct.teleport;
        var_4926c7e8 = eventstruct.rootorigin;
        var_ed8879d6 = eventstruct.var_9b9b74a9;
        if (!(isdefined(bundle.var_7d21adf7) && bundle.var_7d21adf7)) {
            pos = (isdefined(newstate.pos_x) ? newstate.pos_x : 0, isdefined(newstate.pos_y) ? newstate.pos_y : 0, isdefined(newstate.pos_z) ? newstate.pos_z : 0);
            pos = rotatepoint(pos, var_ed8879d6);
            neworigin = var_4926c7e8 + pos;
            pitch = var_ed8879d6[0] + (isdefined(newstate.var_70282927) ? newstate.var_70282927 : 0);
            yaw = var_ed8879d6[1] + (isdefined(newstate.var_1e927b7c) ? newstate.var_1e927b7c : 0);
            roll = var_ed8879d6[2] + (isdefined(newstate.var_17a28ce6) ? newstate.var_17a28ce6 : 0);
            newangles = (absangleclamp360(pitch), absangleclamp360(yaw), absangleclamp360(roll));
            var_eb59d318 = isdefined(bundle.var_eb59d318) ? bundle.var_eb59d318 : 0;
            if (!teleport && var_eb59d318 > 0) {
                dynent function_f4851ef1(neworigin, var_eb59d318);
                dynent function_f8af4dff(newangles, var_eb59d318);
            } else {
                dynent.origin = neworigin;
                dynent.angles = newangles;
            }
        }
        if (!teleport && isdefined(newstate.var_3c45fe7d)) {
            playsound(0, newstate.var_3c45fe7d, dynent.origin);
        }
        if (isdefined(newstate.overridemodel)) {
            function_83ebb7de(dynent, newstate.overridemodel);
        }
        if (isdefined(newstate.stateanim)) {
            starttime = 0;
            rate = isdefined(newstate.animrate) ? newstate.animrate : 0;
            if (isdefined(newstate.var_e5e83c61) && newstate.var_e5e83c61) {
                gametime = gettime();
                if (isdefined(newstate.var_ce82f01a) && newstate.var_ce82f01a) {
                    gametime += abs(dynent.origin[0] + dynent.origin[1] + dynent.origin[2]);
                }
                animlength = int(getanimlength(newstate.stateanim) * 1000);
                starttime = gametime / animlength / rate;
                starttime -= int(starttime);
            } else if (teleport && !isanimlooping(0, newstate.stateanim)) {
                starttime = 1;
            }
            function_39a8f05b(dynent, newstate.stateanim, starttime, rate);
        } else {
            function_652b0840(dynent);
        }
        if (isdefined(newstate.statefx) && isdefined(eventstruct.localclientnum)) {
            forward = anglestoforward(dynent.angles);
            up = anglestoup(dynent.angles);
            playfx(eventstruct.localclientnum, newstate.statefx, dynent.origin, forward, up);
        }
        setdynentenabled(dynent, isdefined(newstate.enable) && newstate.enable);
    }
}

