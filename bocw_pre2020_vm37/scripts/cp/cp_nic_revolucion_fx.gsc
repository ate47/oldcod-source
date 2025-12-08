#using scripts\core_common\clientfield_shared;
#using scripts\cp_common\snd;

#namespace cp_nic_revolucion_fx;

// Namespace cp_nic_revolucion_fx/cp_nic_revolucion_fx
// Params 0
// Checksum 0x48a6f543, Offset: 0xd0
// Size: 0x64
function preload()
{
    clientfield::register( "toplayer", "cctv_cam_swap", 1, 1, "counter" );
    clientfield::register( "toplayer", "cctv_cam_static", 1, 2, "int" );
}

// Namespace cp_nic_revolucion_fx/cp_nic_revolucion_fx
// Params 0
// Checksum 0x87e1b8d4, Offset: 0x140
// Size: 0x3c
function function_383d3084()
{
    self clientfield::increment_to_player( "cctv_cam_swap", 1 );
    snd::client_msg( "flg_cctv_cam_swap_audio" );
}

// Namespace cp_nic_revolucion_fx/cp_nic_revolucion_fx
// Params 1
// Checksum 0x8b22cbe0, Offset: 0x188
// Size: 0x2c
function function_476c025a( var_5f6ea71e )
{
    self clientfield::set_to_player( "cctv_cam_static", var_5f6ea71e );
}

