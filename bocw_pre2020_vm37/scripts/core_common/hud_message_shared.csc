#using scripts\core_common\system_shared;

#namespace hud_message;

// Namespace hud_message/hud_message_shared
// Params 0, eflags: 0x6
// Checksum 0x7e901a5d, Offset: 0x68
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hud_message", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace hud_message/hud_message_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0xb0
// Size: 0x4
function private function_70a657d8() {
    
}

// Namespace hud_message/hud_message_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x6c3381d, Offset: 0xc0
// Size: 0x114
function function_65299180(localclientnum, var_e69b15f0, arglist) {
    scriptnotifymodel = function_1df4c3b0(localclientnum, #"script_notify");
    for (i = 0; i < arglist.size; i++) {
        setuimodelvalue(getuimodel(scriptnotifymodel, #"arg" + i + 1), arglist[i]);
    }
    setuimodelvalue(getuimodel(scriptnotifymodel, #"numargs"), arglist.size);
    if (!setuimodelvalue(scriptnotifymodel, var_e69b15f0)) {
        forcenotifyuimodel(scriptnotifymodel);
    }
}

// Namespace hud_message/hud_message_shared
// Params 3, eflags: 0x0
// Checksum 0x6a44e55c, Offset: 0x1e0
// Size: 0xac
function setlowermessage(localclientnum, text, time) {
    if (isdefined(time) && time > 0) {
        function_65299180(localclientnum, #"hash_424b9c54c8bf7a82", [text, int(time)]);
        return;
    }
    function_65299180(localclientnum, #"hash_424b9c54c8bf7a82", [text]);
}

// Namespace hud_message/hud_message_shared
// Params 1, eflags: 0x0
// Checksum 0xcf1a3ee4, Offset: 0x298
// Size: 0x2c
function clearlowermessage(localclientnum) {
    function_65299180(localclientnum, #"hash_6b9a1c6794314120", []);
}

