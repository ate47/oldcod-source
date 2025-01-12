#using scripts\core_common\callbacks_shared;
#using scripts\core_common\dialog_shared;
#using scripts\core_common\system_shared;

#namespace grapple;

// Namespace grapple/grapple
// Params 0, eflags: 0x2
// Checksum 0x7cf8a94, Offset: 0x108
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"grapple", &__init__, undefined, undefined);
}

// Namespace grapple/grapple
// Params 0, eflags: 0x0
// Checksum 0xddbf508, Offset: 0x150
// Size: 0x5e
function __init__() {
    callback::on_spawned(&player_on_spawned);
    level.var_cceb290b = &function_dc30df1b;
    level.var_8ff7a9f6 = getscriptbundle("grapple_custom_settings");
}

// Namespace grapple/grapple
// Params 1, eflags: 0x0
// Checksum 0xa0290018, Offset: 0x1b8
// Size: 0x7c
function player_on_spawned(localclientnum) {
    if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
        if (!self function_60dbc438()) {
            return;
        }
        self thread function_537328d6(localclientnum);
        self thread function_a3adf418(localclientnum);
    }
}

// Namespace grapple/grapple
// Params 1, eflags: 0x0
// Checksum 0x6039bc8c, Offset: 0x240
// Size: 0x20c
function function_537328d6(localclientnum) {
    self endon(#"death");
    var_69bf58b7 = undefined;
    invalidhandle = undefined;
    while (isdefined(self)) {
        var_b9a6ebb3 = function_b03a55ee(localclientnum);
        if (isdefined(var_b9a6ebb3)) {
            if (var_b9a6ebb3 && !isdefined(var_69bf58b7)) {
                if (isdefined(invalidhandle)) {
                    killfx(localclientnum, invalidhandle);
                    self notify("grapple_light_done_watch" + "invalid");
                    invalidhandle = undefined;
                }
                var_69bf58b7 = playviewmodelfx(localclientnum, #"hash_2a3978ae302f2faf", "tag_fx1");
                thread grapple_light_watch_end(localclientnum, var_69bf58b7, "valid");
            } else if (!var_b9a6ebb3 && !isdefined(invalidhandle)) {
                if (isdefined(var_69bf58b7)) {
                    killfx(localclientnum, var_69bf58b7);
                    self notify("grapple_light_done_watch" + "valid");
                    var_69bf58b7 = undefined;
                }
                invalidhandle = playviewmodelfx(localclientnum, #"hash_39ed4a0ecba806a2", "tag_fx1");
                thread grapple_light_watch_end(localclientnum, invalidhandle, "invalid");
            }
        } else {
            if (isdefined(invalidhandle)) {
                killfx(localclientnum, invalidhandle);
                invalidhandle = undefined;
            }
            if (isdefined(var_69bf58b7)) {
                killfx(localclientnum, var_69bf58b7);
                var_69bf58b7 = undefined;
            }
        }
        waitframe(1);
    }
}

// Namespace grapple/grapple
// Params 3, eflags: 0x0
// Checksum 0x48abfba, Offset: 0x458
// Size: 0x8c
function grapple_light_watch_end(localclientnum, handle, name) {
    self endon("grapple_light_done_watch" + name);
    self notify("grapple_light_watch_end" + name);
    self endon("grapple_light_watch_end" + name);
    self waittill(#"death");
    if (isdefined(handle)) {
        killfx(localclientnum, handle);
    }
}

// Namespace grapple/grapple
// Params 1, eflags: 0x0
// Checksum 0xe876a310, Offset: 0x4f0
// Size: 0x1b8
function function_a3adf418(localclientnum) {
    self endon(#"death");
    doearthquake = 1;
    var_38db7bf6 = 0;
    while (isdefined(self)) {
        if (function_f207ef37(localclientnum) == 3) {
            if (doearthquake) {
                self.grappleeq = earthquake(localclientnum, level.var_8ff7a9f6.var_e3022a40, 10000, self.origin, 0, 0);
                doearthquake = 0;
            }
            self mapshaderconstant(localclientnum, 0, "scriptVector1", var_38db7bf6, 0, 0, 0);
            var_38db7bf6 += 0.05;
        } else if (function_f207ef37(localclientnum) == 0) {
            self mapshaderconstant(localclientnum, 0, "scriptVector1", var_38db7bf6, 0, 0, 0);
            var_38db7bf6 -= 0.05;
        } else {
            self mapshaderconstant(localclientnum, 0, "scriptVector1", 0, 0, 0, 0);
            if (isdefined(self.grappleeq)) {
                function_71255a66(localclientnum, self.grappleeq);
                self.grappleeq = undefined;
                doearthquake = 1;
            }
        }
        waitframe(1);
    }
}

// Namespace grapple/grapple
// Params 1, eflags: 0x0
// Checksum 0x5ae91083, Offset: 0x6b0
// Size: 0x84
function function_dc30df1b(var_db93c8d6) {
    if (!isdefined(var_db93c8d6) || isdefined(level.allowspecialistdialog) && !level.allowspecialistdialog) {
        return;
    }
    dialogalias = var_db93c8d6 dialog_shared::get_player_dialog_alias("grappleGunWeaponUseFail");
    if (!isdefined(dialogalias)) {
        return;
    }
    var_db93c8d6 playsound(0, dialogalias);
}

