#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\remotemissile_shared;

#namespace remotemissile;

// Namespace remotemissile/remotemissile
// Params 0, eflags: 0x6
// Checksum 0xd6a96ced, Offset: 0xa0
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"remotemissile", &preinit, undefined, undefined, #"killstreaks" );
}

// Namespace remotemissile/remotemissile
// Params 0, eflags: 0x4
// Checksum 0x752bf1df, Offset: 0xf0
// Size: 0x2c
function private preinit()
{
    init_shared( "killstreak_remote_missile" + "_cp" );
}

// Namespace remotemissile/remotemissile
// Params 1
// Checksum 0xc79f5637, Offset: 0x128
// Size: 0x2c
function function_faf099cc( var_8c3b1df8 )
{
    callback::add_callback( #"hash_7e19bff37ddc39e3", var_8c3b1df8 );
}

// Namespace remotemissile/remotemissile
// Params 1
// Checksum 0x59b3ea2e, Offset: 0x160
// Size: 0x2c
function function_39398439( var_8c3b1df8 )
{
    callback::remove_callback( #"hash_7e19bff37ddc39e3", var_8c3b1df8 );
}

