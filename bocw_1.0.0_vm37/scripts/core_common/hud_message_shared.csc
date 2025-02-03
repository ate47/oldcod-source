#using scripts\core_common\system_shared;

#namespace hud_message;

// Namespace hud_message/hud_message_shared
// Params 0, eflags: 0x6
// Checksum 0xb7a8f093, Offset: 0x68
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hud_message", &preinit, undefined, undefined, undefined);
}

// Namespace hud_message/hud_message_shared
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0xb0
// Size: 0x4
function private preinit() {
    
}

// Namespace hud_message/hud_message_shared
// Params 3, eflags: 0x0
// Checksum 0x4f9f1c1e, Offset: 0xc0
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
// Checksum 0xc34f1b06, Offset: 0x1e0
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
// Checksum 0xf17939e5, Offset: 0x298
// Size: 0x2c
function clearlowermessage(localclientnum) {
    function_65299180(localclientnum, #"hash_6b9a1c6794314120", []);
}

