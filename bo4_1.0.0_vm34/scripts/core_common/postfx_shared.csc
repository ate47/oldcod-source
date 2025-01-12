#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace postfx;

// Namespace postfx/postfx_shared
// Params 0, eflags: 0x2
// Checksum 0x3141e72e, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"postfx_bundle", &__init__, undefined, undefined);
}

// Namespace postfx/postfx_shared
// Params 0, eflags: 0x0
// Checksum 0xdcb7eb15, Offset: 0xe0
// Size: 0x24
function __init__() {
    callback::on_localplayer_spawned(&localplayer_postfx_bundle_init);
}

// Namespace postfx/postfx_shared
// Params 1, eflags: 0x0
// Checksum 0x33b08563, Offset: 0x110
// Size: 0x7c
function localplayer_postfx_bundle_init(localclientnum) {
    if (isdefined(self.postfxbundelsinited)) {
        return;
    }
    self.postfxbundelsinited = 1;
    self.playingpostfxbundle = "";
    self.forcestoppostfxbundle = 0;
    self.exitpostfxbundle = 0;
    /#
        self thread postfxbundledebuglisten();
        self thread function_5f02937b();
    #/
}

/#

    // Namespace postfx/postfx_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe8c247b8, Offset: 0x198
    // Size: 0x210
    function postfxbundledebuglisten() {
        self endon(#"death");
        setdvar(#"scr_play_postfx_bundle", "<dev string:x30>");
        setdvar(#"scr_stop_postfx_bundle", "<dev string:x30>");
        setdvar(#"scr_exit_postfx_bundle", "<dev string:x30>");
        while (true) {
            playbundlename = getdvarstring(#"scr_play_postfx_bundle");
            if (playbundlename != "<dev string:x30>") {
                self thread playpostfxbundle(playbundlename);
                setdvar(#"scr_play_postfx_bundle", "<dev string:x30>");
            }
            stopbundlename = getdvarstring(#"scr_stop_postfx_bundle");
            if (stopbundlename != "<dev string:x30>") {
                self thread stoppostfxbundle(stopbundlename);
                setdvar(#"scr_stop_postfx_bundle", "<dev string:x30>");
            }
            var_768d4b3c = getdvarstring(#"scr_exit_postfx_bundle");
            if (var_768d4b3c != "<dev string:x30>") {
                self thread exitpostfxbundle(var_768d4b3c);
                setdvar(#"scr_exit_postfx_bundle", "<dev string:x30>");
            }
            wait 0.5;
        }
    }

    // Namespace postfx/postfx_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1e32d097, Offset: 0x3b0
    // Size: 0x2b6
    function function_5f02937b() {
        self endon(#"death");
        var_95b63974 = 0;
        var_b8e49545 = 0;
        var_5c4a890b = "<dev string:x30>";
        ent = undefined;
        while (true) {
            showmodel = getdvarint(#"hash_56d8c90edb7a97b6", 0);
            showviewmodel = getdvarint(#"hash_65c459b02d95c9c9", 0);
            newspawn = 0;
            if (showmodel != var_95b63974) {
                if (showmodel > 0) {
                    if (!isdefined(ent)) {
                        newspawn = 1;
                        ent = util::spawn_model(self.localclientnum, "<dev string:x31>");
                    }
                } else if (var_95b63974 > 0) {
                    if (isdefined(ent)) {
                        ent delete();
                        ent = undefined;
                    }
                }
                var_95b63974 = showmodel;
            }
            if ((newspawn || showmodel == 1) && isdefined(ent)) {
                ent.origin = self.origin + (0, 0, 70) + anglestoforward(self.angles) * 250;
            }
            bundlename = getdvarstring(#"cg_playrenderoverridebundle", "<dev string:x30>");
            if (bundlename != var_5c4a890b && isdefined(ent)) {
                ent stoprenderoverridebundle(var_5c4a890b);
                if (bundlename != "<dev string:x30>") {
                    ent playrenderoverridebundle(bundlename);
                }
            }
            if (showviewmodel && (showviewmodel != var_b8e49545 || bundlename != var_5c4a890b)) {
                self stoprenderoverridebundle(var_5c4a890b);
                if (bundlename != "<dev string:x30>") {
                    self playrenderoverridebundle(bundlename);
                }
            }
            var_5c4a890b = bundlename;
            var_b8e49545 = showviewmodel;
            waitframe(1);
        }
    }

#/

// Namespace postfx/postfx_shared
// Params 1, eflags: 0x0
// Checksum 0x350ce5bf, Offset: 0x670
// Size: 0x3c
function playpostfxbundle(playbundlename) {
    self thread watchentityshutdown(playbundlename);
    self codeplaypostfxbundle(playbundlename);
}

// Namespace postfx/postfx_shared
// Params 1, eflags: 0x0
// Checksum 0x2827e3f, Offset: 0x6b8
// Size: 0xac
function watchentityshutdown(playbundlename) {
    self notify("6433c543b3eba711" + playbundlename);
    self endon("6433c543b3eba711" + playbundlename);
    localclientnum = self.localclientnum;
    self waittill(#"death", #"finished_playing_postfx_bundle");
    if (isdefined(self) && !self isremotecontrolling(localclientnum)) {
        codestoppostfxbundlelocal(localclientnum, playbundlename);
    }
}

// Namespace postfx/postfx_shared
// Params 1, eflags: 0x0
// Checksum 0x168de871, Offset: 0x770
// Size: 0x24
function stoppostfxbundle(bundlename) {
    self codestoppostfxbundle(bundlename);
}

// Namespace postfx/postfx_shared
// Params 3, eflags: 0x0
// Checksum 0x367bfb01, Offset: 0x7a0
// Size: 0x3c
function function_babe55b3(bundlename, constname, constvalue) {
    self function_202a8b08(bundlename, constname, constvalue);
}

// Namespace postfx/postfx_shared
// Params 1, eflags: 0x0
// Checksum 0x4e1122ef, Offset: 0x7e8
// Size: 0x22
function function_7348f3a5(bundlename) {
    return self function_6bf2b84(bundlename);
}

// Namespace postfx/postfx_shared
// Params 1, eflags: 0x0
// Checksum 0x60676f75, Offset: 0x818
// Size: 0x24
function exitpostfxbundle(bundlename) {
    self function_32d9902(bundlename);
}

// Namespace postfx/postfx_shared
// Params 3, eflags: 0x0
// Checksum 0x13a0fee0, Offset: 0x848
// Size: 0x11c
function setfrontendstreamingoverlay(localclientnum, system, enabled) {
    if (!isdefined(self.overlayclients)) {
        self.overlayclients = [];
    }
    if (!isdefined(self.overlayclients[localclientnum])) {
        self.overlayclients[localclientnum] = [];
    }
    self.overlayclients[localclientnum][system] = enabled;
    foreach (en in self.overlayclients[localclientnum]) {
        if (en) {
            enablefrontendstreamingoverlay(localclientnum, 1);
            return;
        }
    }
    enablefrontendstreamingoverlay(localclientnum, 0);
}

