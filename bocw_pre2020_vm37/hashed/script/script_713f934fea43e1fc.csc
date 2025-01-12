#using script_2d142c6d365a90a3;
#using script_7183ecf0e4bbcdf8;
#using script_7ebad89114ecedb1;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace radiation;

// Namespace radiation/radiation
// Params 0, eflags: 0x6
// Checksum 0x293a6d2d, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"radiation", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace radiation/radiation
// Params 0, eflags: 0x5 linked
// Checksum 0xa632d422, Offset: 0xd8
// Size: 0x5c
function private function_70a657d8() {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    callback::on_localclient_connect(&function_f45ee99d);
    callback::on_localplayer_spawned(&function_f45ee99d);
}

// Namespace radiation/radiation
// Params 1, eflags: 0x1 linked
// Checksum 0xfce9f900, Offset: 0x140
// Size: 0x62
function function_f45ee99d(localclientnum) {
    localplayer = function_5c10bd79(localclientnum);
    localplayer.radiation = {};
    localplayer.radiation.var_32adf91d = 0;
    localplayer.radiation.sickness = [];
}

