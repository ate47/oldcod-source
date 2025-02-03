#using script_2d142c6d365a90a3;
#using script_7183ecf0e4bbcdf8;
#using script_7ebad89114ecedb1;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace radiation;

// Namespace radiation/radiation
// Params 0, eflags: 0x6
// Checksum 0xe00287e3, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"radiation", &preinit, undefined, undefined, undefined);
}

// Namespace radiation/radiation
// Params 0, eflags: 0x4
// Checksum 0x81805f60, Offset: 0xd8
// Size: 0x44
function private preinit() {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    level.var_96929d7f = [];
    callback::on_localclient_connect(&function_f45ee99d);
}

// Namespace radiation/radiation
// Params 1, eflags: 0x0
// Checksum 0x292d21f6, Offset: 0x128
// Size: 0x5e
function function_f45ee99d(localclientnum) {
    level.var_96929d7f[localclientnum] = spawnstruct();
    level.var_96929d7f[localclientnum].var_32adf91d = 0;
    level.var_96929d7f[localclientnum].sickness = [];
}

