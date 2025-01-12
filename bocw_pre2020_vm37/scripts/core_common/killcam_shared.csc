#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace killcam;

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x6
// Checksum 0x815125f7, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"killcam", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x5 linked
// Checksum 0xb13146ea, Offset: 0xd8
// Size: 0x84
function private function_70a657d8() {
    callback::on_localclient_connect(&on_localclient_connect);
    callback::on_killcam_begin(&on_killcam_begin);
    callback::on_killcam_end(&on_killcam_end);
    callback::function_9fcd5f60(&function_9fcd5f60);
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xc8aa9e0f, Offset: 0x168
// Size: 0x50
function on_localclient_connect(localclientnum) {
    if (!isdefined(level.killcam)) {
        level.killcam = [];
    }
    if (!isdefined(level.killcam[localclientnum])) {
        level.killcam[localclientnum] = {};
    }
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x3457ac03, Offset: 0x1c0
// Size: 0xdc
function function_549a01b9(localclientnum) {
    killcamentity = function_93e0f729(localclientnum);
    if (self == killcamentity) {
        level.killcam[localclientnum].var_57426003 = util::getnextobjid(localclientnum);
        objective_add(localclientnum, level.killcam[localclientnum].var_57426003, "active", #"hash_e8ccf98fcea7a36", self.origin);
        objective_onentity(localclientnum, level.killcam[localclientnum].var_57426003, self, 0, 0, 0);
    }
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x51f08860, Offset: 0x2a8
// Size: 0x6e
function function_bb763df8(localclientnum) {
    if (isdefined(level.killcam[localclientnum].var_57426003)) {
        objective_delete(localclientnum, level.killcam[localclientnum].var_57426003);
        level.killcam[localclientnum].var_57426003 = undefined;
    }
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x503dbe8c, Offset: 0x320
// Size: 0x8c
function on_killcam_begin(params) {
    player = function_27673a7(params.localclientnum);
    player function_2362a697(params.localclientnum, params.bundle);
    function_bb763df8(params.localclientnum);
    player function_549a01b9(params.localclientnum);
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x6b663dec, Offset: 0x3b8
// Size: 0x64
function on_killcam_end(params) {
    player = function_27673a7(params.localclientnum);
    player function_dc3fa738(params.localclientnum);
    function_bb763df8(params.localclientnum);
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x82949275, Offset: 0x428
// Size: 0xac
function function_9fcd5f60(params) {
    player = function_27673a7(params.localclientnum);
    player function_dc3fa738(params.localclientnum);
    player function_2362a697(params.localclientnum, params.bundle);
    function_bb763df8(params.localclientnum);
    player function_549a01b9(params.localclientnum);
}

// Namespace killcam/killcam_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xffcb809d, Offset: 0x4e0
// Size: 0x6e
function function_2362a697(localclientnum, script_bundle) {
    if (isdefined(script_bundle)) {
        var_c8b06dda = script_bundle.("posteffect");
        if (isdefined(var_c8b06dda)) {
            self codeplaypostfxbundle(var_c8b06dda);
            level.killcam[localclientnum].var_c6128b93 = var_c8b06dda;
        }
    }
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x9c849902, Offset: 0x558
// Size: 0x6e
function function_dc3fa738(localclientnum) {
    if (isdefined(level.killcam[localclientnum].var_c6128b93)) {
        self codestoppostfxbundle(level.killcam[localclientnum].var_c6128b93);
        level.killcam[localclientnum].var_c6128b93 = undefined;
    }
}

