#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace cctv;

// Namespace cctv/cctv
// Params 0, eflags: 0x6
// Checksum 0x95574927, Offset: 0x188
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"cctv", &_preload, undefined, undefined, undefined );
}

// Namespace cctv/cctv
// Params 0, eflags: 0x4
// Checksum 0xade42044, Offset: 0x1d0
// Size: 0x14
function private _preload()
{
    function_bc948200();
}

// Namespace cctv/cctv
// Params 0
// Checksum 0x56923af0, Offset: 0x1f0
// Size: 0xdc
function function_bc948200()
{
    clientfield::register( "toplayer", "cctv_postfx", 1, 1, "int", &function_f343c90c, 0, 0 );
    clientfield::register( "toplayer", "cull_outside_nuke_room", 1, 1, "int", &function_e9459dfe, 0, 0 );
    clientfield::register( "toplayer", "preload_nukeroom_tarp_material", 1, 1, "int", &function_bc3489ab, 0, 0 );
}

// Namespace cctv/cctv
// Params 7, eflags: 0x4
// Checksum 0x112717e9, Offset: 0x2d8
// Size: 0x17c
function private function_f343c90c( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    self endon( #"death" );
    
    if ( bwastimejump == 1 )
    {
        if ( self function_d2cb869e( "pstfx_t9_cp_crt_camera_fx" ) )
        {
            codestoppostfxbundlelocal( fieldname, "pstfx_t9_cp_crt_camera_fx" );
        }
        
        function_a837926b( fieldname, "pstfx_t9_cp_crt_camera_fx" );
        
        if ( self function_d2cb869e( "pstfx_t9_cp_crt_camera_fx" ) )
        {
            function_4238734d( fieldname, "pstfx_t9_cp_crt_camera_fx", "Cubic Distortion", 0.5 );
            function_4238734d( fieldname, "pstfx_t9_cp_crt_camera_fx", "Lens Scale", 0.95 );
        }
        
        return;
    }
    
    if ( self function_d2cb869e( "pstfx_t9_cp_crt_camera_fx" ) )
    {
        codestoppostfxbundlelocal( fieldname, "pstfx_t9_cp_crt_camera_fx" );
    }
}

// Namespace cctv/cctv
// Params 7, eflags: 0x4
// Checksum 0xc1a41cc7, Offset: 0x460
// Size: 0x84
function private function_e9459dfe( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 1 )
    {
        function_93620041( fieldname, "cull_outside_nuke_room" );
        return;
    }
    
    function_9362afb8( fieldname, "cull_outside_nuke_room" );
}

// Namespace cctv/cctv
// Params 7, eflags: 0x4
// Checksum 0x65a289f9, Offset: 0x4f0
// Size: 0xe4
function private function_bc3489ab( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 1 )
    {
        forcestreammaterial( "mc/p9_nic_nukeroom_tarps" );
        forcestreammaterial( "mc/t8_mad_plastic_tarp_white_quarantine_tent" );
        forcestreammaterial( "mc/mtl_p9_usa_luggage_01_decal_zipper" );
        return;
    }
    
    stopforcestreamingmaterial( "mc/p9_nic_nukeroom_tarps" );
    stopforcestreamingmaterial( "mc/t8_mad_plastic_tarp_white_quarantine_tent" );
    stopforcestreamingmaterial( "mc/mtl_p9_usa_luggage_01_decal_zipper" );
}

