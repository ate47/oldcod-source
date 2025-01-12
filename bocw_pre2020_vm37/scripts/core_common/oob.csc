#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace oob;

// Namespace oob/oob
// Params 0, eflags: 0x6
// Checksum 0x856d76cf, Offset: 0xe8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"out_of_bounds", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace oob/oob
// Params 0, eflags: 0x5 linked
// Checksum 0xea58870c, Offset: 0x130
// Size: 0x2b4
function private function_70a657d8() {
    if (sessionmodeismultiplayergame()) {
        level.var_dcb68d74 = 1;
        level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 3000);
        level.oob_timekeep_ms = getdvarint(#"oob_timekeep_ms", 3000);
    } else if (sessionmodeiswarzonegame()) {
        level.var_dcb68d74 = 1;
        level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 10000);
        level.oob_timekeep_ms = getdvarint(#"oob_timekeep_ms", 3000);
    } else if (sessionmodeiscampaigngame()) {
        level.var_dcb68d74 = 0;
        level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 6000);
    } else {
        level.var_dcb68d74 = 1;
        level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 6000);
    }
    clientfield::register("toplayer", "out_of_bounds", 1, 5, "int", &onoutofboundschange, 0, 1);
    clientfield::register("toplayer", "nonplayer_oob_usage", 1, 1, "int", &function_95c61f07, 0, 1);
    callback::on_localclient_connect(&on_localplayer_connect);
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    callback::on_localclient_shutdown(&on_localplayer_shutdown);
    callback::function_a880899e(&function_a880899e);
}

// Namespace oob/oob
// Params 1, eflags: 0x1 linked
// Checksum 0xefb264d, Offset: 0x3f0
// Size: 0x140
function on_localplayer_connect(localclientnum) {
    setuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"hash_6f4b11a0bee9b73d"), "outOfBoundsEndTime"), 0);
    /#
        if (getdvarstring(#"hash_4e9b02559bacb944", "<dev string:x38>") == "<dev string:x3c>") {
            oobtriggers = function_29bda34d(localclientnum, "<dev string:x43>");
            foreach (var_7a0e76fe in oobtriggers) {
                var_7a0e76fe function_704c070e(localclientnum);
            }
        }
    #/
}

// Namespace oob/oob
// Params 1, eflags: 0x1 linked
// Checksum 0xde62b34e, Offset: 0x538
// Size: 0xc
function on_localplayer_spawned(*localclientnum) {
    
}

// Namespace oob/oob
// Params 1, eflags: 0x1 linked
// Checksum 0xe9deccd5, Offset: 0x550
// Size: 0x3c
function on_localplayer_shutdown(localclientnum) {
    localplayer = self;
    if (isdefined(localplayer)) {
        stopoutofboundseffects(localclientnum, localplayer);
    }
}

// Namespace oob/oob
// Params 1, eflags: 0x1 linked
// Checksum 0xe04ad12a, Offset: 0x598
// Size: 0x84
function function_a880899e(eventparams) {
    localplayer = function_5c10bd79(eventparams.localclientnum);
    if (!isdefined(localplayer.oob_effect_enabled)) {
        return;
    }
    if (eventparams.enabled) {
        function_d36db451(eventparams.localclientnum);
        return;
    }
    function_52b5ffe3(eventparams.localclientnum);
}

// Namespace oob/oob
// Params 7, eflags: 0x1 linked
// Checksum 0x5a0b7bc2, Offset: 0x628
// Size: 0x5e
function function_95c61f07(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump > 0) {
        self.nonplayeroobusage = 1;
        return;
    }
    self.nonplayeroobusage = undefined;
}

// Namespace oob/oob
// Params 2, eflags: 0x1 linked
// Checksum 0xe2de1694, Offset: 0x690
// Size: 0x36
function function_2fb8e4d4(*localclientnum, localplayer) {
    if (function_3132f113(localplayer)) {
        return false;
    }
    return true;
}

// Namespace oob/oob
// Params 7, eflags: 0x1 linked
// Checksum 0xf9368241, Offset: 0x6d0
// Size: 0x20c
function onoutofboundschange(localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(level.oob_sound_ent)) {
        level.oob_sound_ent = [];
    }
    if (!isdefined(level.oob_sound_ent[binitialsnap])) {
        level.oob_sound_ent[binitialsnap] = spawn(binitialsnap, (0, 0, 0), "script_origin");
    }
    localplayer = function_5c10bd79(binitialsnap);
    var_d66b86ee = function_2fb8e4d4(binitialsnap, localplayer);
    self callback::entity_callback(#"oob", binitialsnap, {#old_val:fieldname, #new_val:bwastimejump});
    if (var_d66b86ee && bwastimejump > 0) {
        if (!isdefined(localplayer.oob_effect_enabled)) {
            function_da2afac6(binitialsnap, localplayer);
        }
        return;
    }
    if (isdefined(level.oob_timekeep_ms) && isdefined(self.oob_start_time)) {
        self.oob_end_time = getservertime(0, 1);
        if (!isdefined(self.oob_active_duration)) {
            self.oob_active_duration = 0;
        }
        self.oob_active_duration += self.oob_end_time - self.oob_start_time;
    }
    if (is_true(self.nonplayeroobusage)) {
        self.oob_active_duration = undefined;
    }
    stopoutofboundseffects(binitialsnap, localplayer);
}

// Namespace oob/oob
// Params 1, eflags: 0x1 linked
// Checksum 0xe83e5023, Offset: 0x8e8
// Size: 0xe4
function function_52b5ffe3(localclientnum) {
    if (function_21dc7cf(localclientnum)) {
        return;
    }
    if (!isdefined(level.oob_sound_ent[localclientnum])) {
        return;
    }
    if (util::get_game_type() === #"zstandard") {
        level.oob_sound_ent[localclientnum] playloopsound(#"hash_6da7ae12f538ef5e", 0.5);
        return;
    }
    level.oob_sound_ent[localclientnum] playloopsound(#"uin_out_of_bounds_loop", 0.5);
}

// Namespace oob/oob
// Params 2, eflags: 0x1 linked
// Checksum 0xf7ce1804, Offset: 0x9d8
// Size: 0x16a
function function_da2afac6(localclientnum, localplayer) {
    localplayer.oob_effect_enabled = 1;
    function_52b5ffe3(localclientnum);
    oobmodel = getoobuimodel(localclientnum);
    if (level.var_dcb68d74) {
        if (isdefined(level.oob_timekeep_ms) && isdefined(self.oob_start_time) && isdefined(self.oob_active_duration) && getservertime(0) - self.oob_end_time < level.oob_timekeep_ms) {
            setuimodelvalue(oobmodel, getservertime(0, 1) + level.oob_timelimit_ms - self.oob_active_duration);
        } else {
            self.oob_active_duration = undefined;
            setuimodelvalue(oobmodel, getservertime(0, 1) + level.oob_timelimit_ms);
        }
    }
    self.oob_start_time = getservertime(0, 1);
}

// Namespace oob/oob
// Params 1, eflags: 0x1 linked
// Checksum 0xec5151a6, Offset: 0xb50
// Size: 0x5c
function function_d36db451(localclientnum) {
    if (isdefined(level.oob_sound_ent) && isdefined(level.oob_sound_ent[localclientnum])) {
        level.oob_sound_ent[localclientnum] stopallloopsounds(0.5);
    }
}

// Namespace oob/oob
// Params 2, eflags: 0x1 linked
// Checksum 0xee42df0e, Offset: 0xbb8
// Size: 0xa6
function stopoutofboundseffects(localclientnum, localplayer) {
    if (!isdefined(localplayer)) {
        return;
    }
    function_d36db451(localclientnum);
    if (level.var_dcb68d74) {
        oobmodel = getoobuimodel(localclientnum);
        setuimodelvalue(oobmodel, 0);
    }
    if (isdefined(localplayer) && isdefined(localplayer.oob_effect_enabled)) {
        localplayer.oob_effect_enabled = 0;
        localplayer.oob_effect_enabled = undefined;
    }
}

// Namespace oob/oob
// Params 1, eflags: 0x1 linked
// Checksum 0x9839c3bd, Offset: 0xc68
// Size: 0x42
function getoobuimodel(localclientnum) {
    return getuimodel(function_1df4c3b0(localclientnum, #"hash_6f4b11a0bee9b73d"), "outOfBoundsEndTime");
}

