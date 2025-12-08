#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;

#namespace cp_nic_revolucion_fx;

// Namespace cp_nic_revolucion_fx/cp_nic_revolucion_fx
// Params 0
// Checksum 0xedac171a, Offset: 0xb8
// Size: 0x94
function preload()
{
    clientfield::register( "toplayer", "cctv_cam_swap", 1, 1, "counter", &function_80614586, 0, 0 );
    clientfield::register( "toplayer", "cctv_cam_static", 1, 2, "int", &function_653d42c1, 0, 0 );
}

// Namespace cp_nic_revolucion_fx/cp_nic_revolucion_fx
// Params 7
// Checksum 0xbc61e0bd, Offset: 0x158
// Size: 0x84
function function_80614586( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump > 0 )
    {
        self postfx::stoppostfxbundle( #"hash_73422bbb830f0e2d" );
        self postfx::playpostfxbundle( #"hash_73422bbb830f0e2d" );
    }
}

// Namespace cp_nic_revolucion_fx/cp_nic_revolucion_fx
// Params 7
// Checksum 0x69d3c2f5, Offset: 0x1e8
// Size: 0xec
function function_653d42c1( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 0 )
    {
        self postfx::stoppostfxbundle( #"hash_61c82b9155df8f6b" );
        self postfx::stoppostfxbundle( #"hash_4428330acc3d3af0" );
    }
    
    if ( bwastimejump == 1 )
    {
        self postfx::playpostfxbundle( #"hash_61c82b9155df8f6b" );
    }
    
    if ( bwastimejump == 2 )
    {
        self postfx::playpostfxbundle( #"hash_4428330acc3d3af0" );
    }
}

