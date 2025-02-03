#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace killcam;

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x6
// Checksum 0x4869cf39, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"killcam", &preinit, undefined, undefined, undefined);
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x4
// Checksum 0xd4a81eb7, Offset: 0xd8
// Size: 0x84
function private preinit() {
    callback::on_localclient_connect(&on_localclient_connect);
    callback::on_killcam_begin(&on_killcam_begin);
    callback::on_killcam_end(&on_killcam_end);
    callback::function_9fcd5f60(&function_9fcd5f60);
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0xa4a263, Offset: 0x168
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
// Params 1, eflags: 0x0
// Checksum 0x8f417c62, Offset: 0x1c0
// Size: 0xf4
function function_549a01b9(localclientnum) {
    killcamentity = function_93e0f729(localclientnum);
    if (self == killcamentity && isdefined(level.killcam[localclientnum])) {
        level.killcam[localclientnum].var_57426003 = util::getnextobjid(localclientnum);
        objective_add(localclientnum, level.killcam[localclientnum].var_57426003, "active", #"hash_e8ccf98fcea7a36", self.origin);
        objective_onentity(localclientnum, level.killcam[localclientnum].var_57426003, self, 0, 0, 0);
    }
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0x2de1f51b, Offset: 0x2c0
// Size: 0xa6
function function_bb763df8(localclientnum) {
    if (isdefined(level.killcam[localclientnum]) && isdefined(level.killcam[localclientnum].var_57426003)) {
        util::releaseobjid(localclientnum, level.killcam[localclientnum].var_57426003);
        objective_delete(localclientnum, level.killcam[localclientnum].var_57426003);
        level.killcam[localclientnum].var_57426003 = undefined;
    }
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0x2cbf207a, Offset: 0x370
// Size: 0x8c
function on_killcam_begin(params) {
    player = function_27673a7(params.localclientnum);
    player function_2362a697(params.localclientnum, params.bundle);
    function_bb763df8(params.localclientnum);
    player function_549a01b9(params.localclientnum);
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0x8c08858a, Offset: 0x408
// Size: 0x64
function on_killcam_end(params) {
    player = function_27673a7(params.localclientnum);
    player function_dc3fa738(params.localclientnum);
    function_bb763df8(params.localclientnum);
}

// Namespace killcam/killcam_shared
// Params 1, eflags: 0x0
// Checksum 0x9eb93f95, Offset: 0x478
// Size: 0xac
function function_9fcd5f60(params) {
    player = function_27673a7(params.localclientnum);
    player function_dc3fa738(params.localclientnum);
    player function_2362a697(params.localclientnum, params.bundle);
    function_bb763df8(params.localclientnum);
    player function_549a01b9(params.localclientnum);
}

// Namespace killcam/killcam_shared
// Params 2, eflags: 0x0
// Checksum 0x144a4992, Offset: 0x530
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
// Params 1, eflags: 0x0
// Checksum 0xfa4c9691, Offset: 0x5a8
// Size: 0x6e
function function_dc3fa738(localclientnum) {
    if (isdefined(level.killcam[localclientnum].var_c6128b93)) {
        self codestoppostfxbundle(level.killcam[localclientnum].var_c6128b93);
        level.killcam[localclientnum].var_c6128b93 = undefined;
    }
}

