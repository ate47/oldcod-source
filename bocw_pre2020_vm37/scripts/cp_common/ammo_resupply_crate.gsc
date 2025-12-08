#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\cp_common\util;

#namespace ammo_resupply_crate;

// Namespace ammo_resupply_crate/ammo_resupply_crate
// Params 0, eflags: 0x6
// Checksum 0xe16e0100, Offset: 0xe0
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"ammo_resupply_crate", undefined, &init_postload, undefined, undefined );
}

// Namespace ammo_resupply_crate/ammo_resupply_crate
// Params 0, eflags: 0x4
// Checksum 0xc49af1a8, Offset: 0x128
// Size: 0x64
function private init_postload()
{
    var_59dc62dc = struct::get_array( "ammo_resupply_crate" );
    level flag::wait_till( "all_players_connected" );
    array::thread_all( var_59dc62dc, &ammo_crate_init );
}

// Namespace ammo_resupply_crate/ammo_resupply_crate
// Params 0
// Checksum 0xa7b65225, Offset: 0x198
// Size: 0x54
function ammo_crate_init()
{
    self util::create_cursor_hint( undefined, undefined, #"hash_59581ed64841a461", undefined, undefined, &resupply_ammo, undefined, undefined, undefined, undefined, 1, 0, &function_6014ca4c );
}

// Namespace ammo_resupply_crate/ammo_resupply_crate
// Params 1, eflags: 0x4
// Checksum 0x7d41021e, Offset: 0x1f8
// Size: 0x144
function private resupply_ammo( s_info )
{
    player = s_info.player;
    player playgestureviewmodel( #"ges_drophand" );
    a_w_weapons = player getweaponslist( 0 );
    
    foreach ( w_weapon in a_w_weapons )
    {
        if ( isdefined( w_weapon.var_4d97c40b ) && w_weapon.var_4d97c40b )
        {
            continue;
        }
        
        player givemaxammo( w_weapon );
    }
    
    snd::play( "fly_ammo_crate_pickup", self );
    player thread function_cc6f66e5();
}

// Namespace ammo_resupply_crate/ammo_resupply_crate
// Params 0, eflags: 0x4
// Checksum 0x1a981af0, Offset: 0x348
// Size: 0x36
function private function_cc6f66e5()
{
    self endon( #"death" );
    self.var_626ab4f2 = 1;
    wait 5;
    self.var_626ab4f2 = undefined;
}

// Namespace ammo_resupply_crate/ammo_resupply_crate
// Params 1
// Checksum 0x433adb6f, Offset: 0x388
// Size: 0x22, Type: bool
function function_6014ca4c( s_info )
{
    return !isdefined( s_info.player.var_626ab4f2 );
}

