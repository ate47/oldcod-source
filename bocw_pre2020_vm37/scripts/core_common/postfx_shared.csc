#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace postfx;

// Namespace postfx/postfx_shared
// Params 0, eflags: 0x6
// Checksum 0xfcc4b714, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"postfx_bundle", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace postfx/postfx_shared
// Params 0, eflags: 0x5 linked
// Checksum 0xac3b2b5e, Offset: 0xd8
// Size: 0x24
function private function_70a657d8() {
    callback::on_localplayer_spawned(&localplayer_postfx_bundle_init);
}

// Namespace postfx/postfx_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x347bb25, Offset: 0x108
// Size: 0x7c
function localplayer_postfx_bundle_init(*localclientnum) {
    if (isdefined(self.postfxbundelsinited)) {
        return;
    }
    self.postfxbundelsinited = 1;
    self.playingpostfxbundle = "";
    self.forcestoppostfxbundle = 0;
    self.exitpostfxbundle = 0;
    /#
        self thread postfxbundledebuglisten();
        self thread function_764eb053();
    #/
}

/#

    // Namespace postfx/postfx_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc9ae824b, Offset: 0x190
    // Size: 0x210
    function postfxbundledebuglisten() {
        self endon(#"death");
        setdvar(#"scr_play_postfx_bundle", "<dev string:x38>");
        setdvar(#"scr_stop_postfx_bundle", "<dev string:x38>");
        setdvar(#"scr_exit_postfx_bundle", "<dev string:x38>");
        while (true) {
            playbundlename = getdvarstring(#"scr_play_postfx_bundle");
            if (playbundlename != "<dev string:x38>") {
                self thread playpostfxbundle(playbundlename);
                setdvar(#"scr_play_postfx_bundle", "<dev string:x38>");
            }
            stopbundlename = getdvarstring(#"scr_stop_postfx_bundle");
            if (stopbundlename != "<dev string:x38>") {
                self thread stoppostfxbundle(stopbundlename);
                setdvar(#"scr_stop_postfx_bundle", "<dev string:x38>");
            }
            var_38ce085 = getdvarstring(#"scr_exit_postfx_bundle");
            if (var_38ce085 != "<dev string:x38>") {
                self thread exitpostfxbundle(var_38ce085);
                setdvar(#"scr_exit_postfx_bundle", "<dev string:x38>");
            }
            wait 0.5;
        }
    }

    // Namespace postfx/postfx_shared
    // Params 0, eflags: 0x0
    // Checksum 0xeeb4aed, Offset: 0x3a8
    // Size: 0x2ae
    function function_764eb053() {
        self endon(#"death");
        var_986c8888 = 0;
        var_4828f60f = 0;
        var_e0f0fb1d = "<dev string:x38>";
        ent = undefined;
        while (true) {
            showmodel = getdvarint(#"hash_56d8c90edb7a97b6", 0);
            showviewmodel = getdvarint(#"hash_65c459b02d95c9c9", 0);
            newspawn = 0;
            if (showmodel != var_986c8888) {
                if (showmodel > 0) {
                    if (!isdefined(ent)) {
                        newspawn = 1;
                        ent = util::spawn_model(self.localclientnum, "<dev string:x3c>");
                    }
                } else if (var_986c8888 > 0) {
                    if (isdefined(ent)) {
                        ent delete();
                        ent = undefined;
                    }
                }
                var_986c8888 = showmodel;
            }
            if ((newspawn || showmodel == 1) && isdefined(ent)) {
                ent.origin = self.origin + (0, 0, 70) + anglestoforward(self.angles) * 250;
            }
            bundlename = getdvarstring(#"cg_playrenderoverridebundle", "<dev string:x38>");
            if (bundlename != var_e0f0fb1d && isdefined(ent)) {
                ent stoprenderoverridebundle(var_e0f0fb1d);
                if (bundlename != "<dev string:x38>") {
                    ent playrenderoverridebundle(bundlename);
                }
            }
            if (showviewmodel && (showviewmodel != var_4828f60f || bundlename != var_e0f0fb1d)) {
                self stoprenderoverridebundle(var_e0f0fb1d);
                if (bundlename != "<dev string:x38>") {
                    self playrenderoverridebundle(bundlename);
                }
            }
            var_e0f0fb1d = bundlename;
            var_4828f60f = showviewmodel;
            waitframe(1);
        }
    }

#/

// Namespace postfx/postfx_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x96216b3e, Offset: 0x660
// Size: 0x3c
function playpostfxbundle(playbundlename) {
    self thread watchentityshutdown(playbundlename);
    self codeplaypostfxbundle(playbundlename);
}

// Namespace postfx/postfx_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x49c5e385, Offset: 0x6a8
// Size: 0x8c
function watchentityshutdown(playbundlename) {
    var_17b7891d = "6433c543b3eba711" + playbundlename;
    self notify(var_17b7891d);
    self endon(var_17b7891d);
    localclientnum = self.localclientnum;
    self waittill(#"death", #"finished_playing_postfx_bundle");
    codestoppostfxbundlelocal(localclientnum, playbundlename);
}

// Namespace postfx/postfx_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x9556b014, Offset: 0x740
// Size: 0x24
function stoppostfxbundle(bundlename) {
    self codestoppostfxbundle(bundlename);
}

// Namespace postfx/postfx_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xafe57ceb, Offset: 0x770
// Size: 0x34
function function_c8b5f318(bundlename, constname, constvalue) {
    self function_116b95e5(bundlename, constname, constvalue);
}

// Namespace postfx/postfx_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xf433a366, Offset: 0x7b0
// Size: 0x22
function function_556665f2(bundlename) {
    return self function_d2cb869e(bundlename);
}

// Namespace postfx/postfx_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x6cc385b9, Offset: 0x7e0
// Size: 0x24
function exitpostfxbundle(bundlename) {
    self function_3f145588(bundlename);
}

// Namespace postfx/postfx_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x93a919aa, Offset: 0x810
// Size: 0x124
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

// Namespace postfx/postfx_shared
// Params 3, eflags: 0x0
// Checksum 0x88e7d368, Offset: 0x940
// Size: 0x9c
function toggle_postfx(*localclientnum, enabled, var_c8b06dda) {
    assert(isdefined(var_c8b06dda));
    if (!enabled) {
        if (self function_556665f2(var_c8b06dda)) {
            self stoppostfxbundle(var_c8b06dda);
        }
        return;
    }
    if (!self function_556665f2(var_c8b06dda)) {
        self playpostfxbundle(var_c8b06dda);
    }
}

