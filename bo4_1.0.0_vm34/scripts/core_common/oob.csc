#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\filter_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace oob;

// Namespace oob/oob
// Params 0, eflags: 0x2
// Checksum 0xd9020a9, Offset: 0xd8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"out_of_bounds", &__init__, undefined, undefined);
}

// Namespace oob/oob
// Params 0, eflags: 0x0
// Checksum 0x3b2d9397, Offset: 0x120
// Size: 0x1c4
function __init__() {
    if (sessionmodeismultiplayergame()) {
        level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 3000);
        level.oob_timekeep_ms = getdvarint(#"oob_timekeep_ms", 3000);
    } else if (sessionmodeiswarzonegame()) {
        level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 10000);
        level.oob_timekeep_ms = getdvarint(#"oob_timekeep_ms", 3000);
    } else {
        level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 6000);
    }
    clientfield::register("toplayer", "out_of_bounds", 1, 5, "int", &onoutofboundschange, 0, 1);
    callback::on_localclient_connect(&on_localplayer_connect);
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    callback::on_localclient_shutdown(&on_localplayer_shutdown);
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x2db97894, Offset: 0x2f0
// Size: 0x44
function on_localplayer_connect(localclientnum) {
    oobmodel = getoobuimodel(localclientnum);
    setuimodelvalue(oobmodel, 0);
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x9803f340, Offset: 0x340
// Size: 0x3c
function on_localplayer_spawned(localclientnum) {
    filter::disable_filter_oob(self, 0);
    self randomfade(0);
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x36b9e087, Offset: 0x388
// Size: 0x3c
function on_localplayer_shutdown(localclientnum) {
    localplayer = self;
    if (isdefined(localplayer)) {
        stopoutofboundseffects(localclientnum, localplayer);
    }
}

// Namespace oob/oob
// Params 7, eflags: 0x0
// Checksum 0xec3ff468, Offset: 0x3d0
// Size: 0x3d4
function onoutofboundschange(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.oob_sound_ent)) {
        level.oob_sound_ent = [];
    }
    if (!isdefined(level.oob_sound_ent[localclientnum])) {
        level.oob_sound_ent[localclientnum] = spawn(localclientnum, (0, 0, 0), "script_origin");
    }
    localplayer = function_f97e7787(localclientnum);
    if (function_f68f5e32(localplayer)) {
        return;
    }
    if (newval > 0) {
        if (!isdefined(localplayer.oob_effect_enabled)) {
            filter::init_filter_oob(localplayer);
            filter::enable_filter_oob(localplayer, 0);
            localplayer.oob_effect_enabled = 1;
            if (util::get_game_type() === #"zstandard") {
                level.oob_sound_ent[localclientnum] playloopsound(#"hash_6da7ae12f538ef5e", 0.5);
            } else {
                level.oob_sound_ent[localclientnum] playloopsound(#"uin_out_of_bounds_loop", 0.5);
            }
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
        if (newvalf > 0.5) {
            newvalf = 0.5;
        }
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
// Checksum 0xfc1bcf97, Offset: 0x7b0
// Size: 0x10e
function stopoutofboundseffects(localclientnum, localplayer) {
    if (!isdefined(localplayer)) {
        return;
    }
    filter::disable_filter_oob(localplayer, 0);
    if (isdefined(localplayer)) {
        localplayer randomfade(0);
    }
    if (isdefined(level.oob_sound_ent) && isdefined(level.oob_sound_ent[localclientnum])) {
        level.oob_sound_ent[localclientnum] stopallloopsounds(0.5);
    }
    oobmodel = getoobuimodel(localclientnum);
    setuimodelvalue(oobmodel, 0);
    if (isdefined(localplayer) && isdefined(localplayer.oob_effect_enabled)) {
        localplayer.oob_effect_enabled = 0;
        localplayer.oob_effect_enabled = undefined;
    }
}

// Namespace oob/oob
// Params 1, eflags: 0x0
// Checksum 0x21888549, Offset: 0x8c8
// Size: 0x4a
function getoobuimodel(localclientnum) {
    controllermodel = getuimodelforcontroller(localclientnum);
    return createuimodel(controllermodel, "hudItems.outOfBoundsEndTime");
}

