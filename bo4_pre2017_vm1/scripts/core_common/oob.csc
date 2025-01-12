#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/system_shared;

#namespace oob;

// Namespace oob/oob
// Params 0, eflags: 0x2
// Checksum 0x3f753d95, Offset: 0x198
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("out_of_bounds", &__init__, undefined, undefined);
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0x79c23242, Offset: 0x1d8
// Size: 0x13c
function __init__() {
    if (sessionmodeismultiplayergame()) {
        level.oob_timelimit_ms = getdvarint("oob_timelimit_ms", 3000);
        level.oob_timekeep_ms = getdvarint("oob_timekeep_ms", 3000);
    } else {
        level.oob_timelimit_ms = getdvarint("oob_timelimit_ms", 6000);
    }
    clientfield::register("toplayer", "out_of_bounds", 1, 5, "int", &onoutofboundschange, 0, 1);
    callback::on_localclient_connect(&on_localplayer_connect);
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    callback::on_localclient_shutdown(&on_localplayer_shutdown);
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x4ed866d0, Offset: 0x320
// Size: 0x6c
function on_localplayer_connect(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    oobmodel = getoobuimodel(localclientnum);
    setuimodelvalue(oobmodel, 0);
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x7a11d13e, Offset: 0x398
// Size: 0x3c
function on_localplayer_spawned(localclientnum) {
    filter::disable_filter_oob(self, 0);
    self randomfade(0);
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0xa2ae97a2, Offset: 0x3e0
// Size: 0x44
function on_localplayer_shutdown(localclientnum) {
    localplayer = self;
    if (isdefined(localplayer)) {
        stopoutofboundseffects(localclientnum, localplayer);
    }
}

// Namespace oob/oob
// Params 7, eflags: 0x0
// Checksum 0xb1b69672, Offset: 0x430
// Size: 0x364
function onoutofboundschange(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    localplayer = getlocalplayer(localclientnum);
    if (!isdefined(level.oob_sound_ent)) {
        level.oob_sound_ent = [];
    }
    if (!isdefined(level.oob_sound_ent[localclientnum])) {
        level.oob_sound_ent[localclientnum] = spawn(localclientnum, (0, 0, 0), "script_origin");
    }
    if (newval > 0) {
        if (!isdefined(localplayer.oob_effect_enabled)) {
            filter::init_filter_oob(localplayer);
            filter::enable_filter_oob(localplayer, 0);
            localplayer.oob_effect_enabled = 1;
            level.oob_sound_ent[localclientnum] playloopsound("uin_out_of_bounds_loop", 0.5);
            oobmodel = getoobuimodel(localclientnum);
            if (isdefined(level.oob_timekeep_ms) && isdefined(self.oob_start_time) && isdefined(self.oob_active_duration) && getservertime(0) - self.oob_end_time < level.oob_timekeep_ms) {
                setuimodelvalue(oobmodel, getservertime(0, 1) + level.oob_timelimit_ms - self.oob_active_duration);
            } else {
                self.oob_active_duration = undefined;
                setuimodelvalue(oobmodel, getservertime(0, 1) + level.oob_timelimit_ms);
            }
            self.oob_start_time = getservertime(0, 1);
        }
        newvalf = newval / 31;
        localplayer randomfade(newvalf);
        return;
    }
    if (isdefined(level.oob_timekeep_ms) && isdefined(self.oob_start_time)) {
        self.oob_end_time = getservertime(0, 1);
        if (!isdefined(self.oob_active_duration)) {
            self.oob_active_duration = 0;
        }
        self.oob_active_duration += self.oob_end_time - self.oob_start_time;
    }
    stopoutofboundseffects(localclientnum, localplayer);
}

// Namespace oob/oob
// Params 2, eflags: 0x0
// Checksum 0xaec79c48, Offset: 0x7a0
// Size: 0x106
function stopoutofboundseffects(localclientnum, localplayer) {
    filter::disable_filter_oob(localplayer, 0);
    localplayer randomfade(0);
    if (isdefined(level.oob_sound_ent) && isdefined(level.oob_sound_ent[localclientnum])) {
        level.oob_sound_ent[localclientnum] stopallloopsounds(0.5);
    }
    oobmodel = getoobuimodel(localclientnum);
    setuimodelvalue(oobmodel, 0);
    if (isdefined(localplayer.oob_effect_enabled)) {
        localplayer.oob_effect_enabled = 0;
        localplayer.oob_effect_enabled = undefined;
    }
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x712ca5e4, Offset: 0x8b0
// Size: 0x4a
function getoobuimodel(localclientnum) {
    controllermodel = getuimodelforcontroller(localclientnum);
    return createuimodel(controllermodel, "hudItems.outOfBoundsEndTime");
}

