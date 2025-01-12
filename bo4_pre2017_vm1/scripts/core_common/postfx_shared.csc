#using scripts/core_common/callbacks_shared;
#using scripts/core_common/duplicaterenderbundle;
#using scripts/core_common/filter_shared;
#using scripts/core_common/gfx_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace postfx;

// Namespace postfx/postfx_shared
// Params 0, eflags: 0x2
// Checksum 0xc6e47d1, Offset: 0x1e0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("postfx_bundle", &__init__, undefined, undefined);
}

// Namespace postfx/postfx_shared
// Params 0, eflags: 0x0
// Checksum 0x6abbff5, Offset: 0x220
// Size: 0x24
function __init__() {
    callback::on_localplayer_spawned(&localplayer_postfx_bundle_init);
}

// Namespace postfx/postfx_shared
// Params 1, eflags: 0x0
// Checksum 0x59a6176, Offset: 0x250
// Size: 0x1c
function localplayer_postfx_bundle_init(localclientnum) {
    function_7e41df4();
}

// Namespace postfx/postfx_shared
// Params 0, eflags: 0x0
// Checksum 0xdb4e5085, Offset: 0x278
// Size: 0x64
function function_7e41df4() {
    if (isdefined(self.postfxbundelsinited)) {
        return;
    }
    self.postfxbundelsinited = 1;
    self.playingpostfxbundle = "";
    self.forcestoppostfxbundle = 0;
    self.exitpostfxbundle = 0;
    /#
        self thread postfxbundledebuglisten();
    #/
}

/#

    // Namespace postfx/postfx_shared
    // Params 0, eflags: 0x0
    // Checksum 0xcbedb5de, Offset: 0x2e8
    // Size: 0x1c0
    function postfxbundledebuglisten() {
        self endon(#"death");
        setdvar("<dev string:x28>", "<dev string:x3f>");
        setdvar("<dev string:x40>", "<dev string:x3f>");
        setdvar("<dev string:x57>", "<dev string:x3f>");
        while (true) {
            playbundlename = getdvarstring("<dev string:x28>");
            if (playbundlename != "<dev string:x3f>") {
                self thread playpostfxbundle(playbundlename);
                setdvar("<dev string:x28>", "<dev string:x3f>");
            }
            stopbundlename = getdvarstring("<dev string:x40>");
            if (stopbundlename != "<dev string:x3f>") {
                self thread stoppostfxbundle();
                setdvar("<dev string:x40>", "<dev string:x3f>");
            }
            stopbundlename = getdvarstring("<dev string:x57>");
            if (stopbundlename != "<dev string:x3f>") {
                self thread exitpostfxbundle();
                setdvar("<dev string:x57>", "<dev string:x3f>");
            }
            wait 0.5;
        }
    }

#/

// Namespace postfx/postfx_shared
// Params 1, eflags: 0x0
// Checksum 0x26314859, Offset: 0x4b0
// Size: 0x54
function playpostfxbundle(playbundlename) {
    self codestoppostfxbundle(0);
    self thread watchentityshutdown(0);
    self codeplaypostfxbundle(playbundlename);
}

// Namespace postfx/postfx_shared
// Params 1, eflags: 0x0
// Checksum 0xe97c47b1, Offset: 0x510
// Size: 0x54
function watchentityshutdown(filterid) {
    localclientnum = self.localclientnum;
    self waittill("death", "finished_playing_postfx_bundle");
    codestoppostfxbundlelocal(localclientnum, filterid);
}

// Namespace postfx/postfx_shared
// Params 4, eflags: 0x0
// Checksum 0x59212fb1, Offset: 0x570
// Size: 0x104
function function_8d3c3170(localclientnum, var_402c9c53, filterid, values) {
    var_84704bee = gfx::getshaderconstantindex(var_402c9c53);
    setfilterpassconstant(localclientnum, filterid, 0, var_84704bee + 0, values[0]);
    setfilterpassconstant(localclientnum, filterid, 0, var_84704bee + 1, values[1]);
    setfilterpassconstant(localclientnum, filterid, 0, var_84704bee + 2, values[2]);
    setfilterpassconstant(localclientnum, filterid, 0, var_84704bee + 3, values[3]);
}

// Namespace postfx/postfx_shared
// Params 0, eflags: 0x0
// Checksum 0xaa744643, Offset: 0x680
// Size: 0x1c
function stoppostfxbundle() {
    self codestoppostfxbundle(0);
}

// Namespace postfx/postfx_shared
// Params 0, eflags: 0x0
// Checksum 0x36197e2b, Offset: 0x6a8
// Size: 0x1c
function exitpostfxbundle() {
    self stoppostfxbundle();
}

// Namespace postfx/postfx_shared
// Params 0, eflags: 0x0
// Checksum 0x9db16b4f, Offset: 0x6d0
// Size: 0x1c
function function_9493d991() {
    self stoppostfxbundle();
}

// Namespace postfx/postfx_shared
// Params 3, eflags: 0x0
// Checksum 0x86c448cc, Offset: 0x6f8
// Size: 0x134
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

